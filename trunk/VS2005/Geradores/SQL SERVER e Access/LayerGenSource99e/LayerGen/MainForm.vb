Imports System.Drawing
Imports Microsoft.VisualBasic
Imports Microsoft.VisualBasic.ControlChars
Imports Microsoft.Win32

Public Class MainForm
    ' This is the default registry key where LayerGen stores
    ' user preferences
    Private Const STR_SoftwarerassTechnologiesayerGen As String = "Software\BrassTechnologies\LayerGen"
    ' This is the default SQL Server name, if none is found in the
    ' Registry
    Private Const STR_ServerName As String = "ServerName"
    ' This is the default User Name if none is found in the registry
    Private Const STR_UserName As String = "UserName"
    ' This is the default Password if none is found in the registry
    Private Const STR_Password As String = "Password"
    ' This is the default database name if none is found in the registry
    Private Const STR_DatabaseName As String = "DatabaseName"
    Private Const STR_Destination As String = "Destination"
    Private Const STR_LangSelect As String = "Language"
    ' This will be set to true or false, depending on weather we are
    ' connected to the SQL Server
    Private IsConnected As Boolean
    ' This is our output stream
    Private OutputFile As IO.TextWriter
    ' This will hold our extension. It varies depending on the language
    ' we chose to output to (either .VB or .CS)
    Private Extension As String
    ' This is a tool tip that we will assign to your browse button
    Private BrowseTip As ToolTip
    ' This holds the mouse X coordinate
    Private MouseX As Integer
    ' This holds the mouse Y coordinate
    Private MouseY As Integer
    ' This holds the name of our Data Namespace
    Private DataNameSpace As String
    ' This holds the name of our Business Namespace
    Private BusinessNameSpace As String
    ' This object will contain our SQL Server connection
    Private SQLObject As SQLImplementation
    ' This object will contain our Language generation object
    Private LangObject As LangImplementation
    ' This is set to true or false depending on weather we should automatically
    ' insert stored procedures into our SQL Server
    Private AutoInsert As Boolean
    ' This is set to true or false depending on weather we should generate
    ' a Procedures.SQL file (which will contain all the necessary stored procedures)
    Private GenerateSQL As Boolean
    ' This holds our encryption key
    Private EncryptionKey As String
    ' This determines if we should encrypt text data or not
    Private DoEncrypt As Boolean
    ' This is set to true or false depending on weather we should supress
    ' generating comments when we generate our stored procedures and our code.
    ' This is a "hidden" feature. It can be turned off by going into the registry
    ' STR_SoftwarerassTechnologiesayerGen and adding a value called SupressComments.
    ' Set this value to either 1 or 0 depending on weather you want to Supress
    ' them or not. 
    Private SupressComments As Boolean
    ' This is set to true or false depending on weather sorting is enabled or
    ' disabled. 
    Private EnableSorting As Boolean
    ' This is set to whatever language the user wants to use. 
    Private LanguageSelected As LanguageType

    ' Enumeration that holds the different SQL types suppored in Layergen.
    Private Enum LanguageType
        SqlServer = 1
        Access = 2
    End Enum

    ' This is the current version number of LayerGen
    Const VERSION As String = "0.99e"
    ' If this is BETA software, then this should be set to True
    Const BETA As Boolean = True

    ' This function is called whenever the main form is closing. 
    ' Our primary job here will be to save the user preferences to the
    ' registry so that next time Layergen runs, it can set the defaults
    ' to whatever was last used. 
    Private Sub MainForm_FormClosing(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        Dim regKey As RegistryKey ' Create a registry key object

        ' Point the registry key object to the registry path we want to save to.
        ' This is done just in case this is the 1st time the user has ran Layergen
        ' and so it will create the path for us if it doesn't exist
        regKey = Registry.CurrentUser.CreateSubKey(STR_SoftwarerassTechnologiesayerGen)
        ' Store the Server Name
        regKey.SetValue(STR_ServerName, Me.txtSQLServerName.Text.Trim())
        ' Store the User Name
        regKey.SetValue(STR_UserName, Me.txtSQLUserName.Text.Trim())
        ' Store the Password (warning! Password is not encrypted inside registry)
        regKey.SetValue(STR_Password, Me.txtSQLPassword.Text.Trim())
        ' Store the Database Name
        regKey.SetValue(STR_DatabaseName, Me.txtSQLDatabaseName.Text.Trim())
        ' Store the output destination path
        regKey.SetValue(STR_Destination, Me.txtDestination.Text.Trim())
        ' Store the language preference
        regKey.SetValue(STR_LangSelect, CStr(Me.cboLanguage.SelectedItem).Trim())
        ' Close the registry object and write changes to the registry
        regKey.Close()
    End Sub

    ' This function gets called everytime Layergen starts up
    Private Sub MainForm_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim regKey As RegistryKey ' Create a registry key object
        Dim regSubKey As RegistryKey ' Create a registry sub key object

        ' Set the main window's opacity so that it is just barely see through
        Me.Opacity = 0.95

        ' If this is BETA software then we are going to want to draw the
        ' title in red letters instead of black. In addition, we will add the
        ' word "BETA" after the version number
        If BETA Then
            ' Add the word "BETA" to the version number
            Me.lblVersionLabel.Text = "Version " + VERSION + " BETA"
            ' Change color of text to red
            Me.lblVersionLabel.ForeColor = Color.Red
        Else
            ' Set the title to the version number of the software
            Me.lblVersionLabel.Text = "Version " + VERSION
        End If

        ' This should center the title and version text in the middle
        Me.lblVersionLabel.Left = ((Me.Width - 100) / 2 - (Me.lblVersionLabel.Text.Length * 1.5))
        ' Disable our timer that will display our tooltip. This timer will
        ' not be enabled until the user hover's their mouse over the browse button
        ToolTipTimer.Enabled = False
        ' Create a new tool tip for the browse button
        BrowseTip = New ToolTip
        ' Set our SQLObject to Nothing
        SQLObject = Nothing
        ' Set our Language Object to nothing
        LangObject = Nothing

        ' Always show our tool tip
        BrowseTip.ShowAlways = True
        ' Set the output file to Nothing for now
        OutputFile = Nothing
        ' We aren't connected yet, so lets set this to false
        IsConnected = False

        ' The default Business Namespace name is "BusinessLayer"
        BusinessNameSpace = "BusinessLayer"
        ' The default Data Namespace name is "DataLayer"
        DataNameSpace = "DataLayer"

        ' Since Layergen supports Microsoft SQL Server, lets add it
        ' to the SQL Selection Combo Box
        cboSQLServerType.Items.Add("Microsoft SQL Server")
        ' MySQL is not yet supported. Coming soon!
        'cboSQLServerType.Items.Add("MySQL")
        ' PostgreSQL is not yet supported. Coming Soon!
        'cboSQLServerType.Items.Add("PostgreSQL")
        ' Oracle is not yet supported. Coming Soon!
        'cboSQLServerType.Items.Add("Oracle")
        ' Since layergen supports Microsoft Access Databases, lets add it
        ' to the SQL Seleection Combo Box
        cboSQLServerType.Items.Add("Microsoft Access")

        ' Make SQL Server the default selection
        cboSQLServerType.SelectedItem = "Microsoft SQL Server"

        ' Since Layergen supports VB.NET, lets add it to the
        ' Language selection Combo Box
        cboLanguage.Items.Add("VB.NET")
        ' Since Layergen supports C#.NET, lets add it to the
        ' Language selection Combo Box
        cboLanguage.Items.Add("C#")
        ' Layergen does not yet support VB 6.0. Maybe in the future, 
        ' depending on how many people really need this.
        'cboLanguage.Items.Add("VB 6.0") ' TODO: Add VB 6.0 support

        ' Make VB.NET the default selected Language
        cboLanguage.SelectedItem = "VB.NET"
        ' Enable the Language selection combo box
        cboLanguage.Enabled = True
        ' Since VB.NET is the default selected language, we will make the
        ' Default selected extension .VB
        Extension = ".VB"

        ' We want to point the CurrentUser Key in the registry since the
        ' settings get saved on a per user level (that way, if anyone else
        ' logs into this machine, they can have their own set of preferences)
        regKey = Registry.CurrentUser
        regSubKey = regKey.CreateSubKey(STR_SoftwarerassTechnologiesayerGen)

        ' Attempt to retrieve the saved SQL Server Name (if one exists)
        txtSQLServerName.Text = regSubKey.GetValue(STR_ServerName)
        ' Attempt to retrieve the saved SQL Server Password (if one exists)
        txtSQLPassword.Text = regSubKey.GetValue(STR_Password)
        ' Attempt to retrieve the saved SQL Server UserName (if one exists)
        txtSQLUserName.Text = regSubKey.GetValue(STR_UserName)
        ' Attempt to retrieve the saved SQL Server Database Name (if one exists)
        txtSQLDatabaseName.Text = regSubKey.GetValue(STR_DatabaseName)
        ' Attempt to retrieve the saved destination directory (if one exists)
        txtDestination.Text = regSubKey.GetValue(STR_Destination)
        ' Attempt to retreive the last language used (if one exists)
        cboLanguage.SelectedItem = regSubKey.GetValue(STR_LangSelect)
        ' Attempt to retrieve the business namespace name used
        BusinessNameSpace = regSubKey.GetValue("BusinessName")
        ' Attempt to retrieve the data namespace name used
        DataNameSpace = regSubKey.GetValue("DataName")
        ' If we do not find an AutoInsert registry key....
        If regSubKey.GetValue("AutoInsert") Is Nothing Then
            ' Then we will turn it off by default
            AutoInsert = False
            ' And now we will save this key for future use
            regKey.SetValue("AutoInsert", False)
        Else
            ' If we do find an AutoInsert Key, then retreive its value
            AutoInsert = regSubKey.GetValue("AutoInsert")
        End If
        ' If we do not find a GenerateSQL registry key...
        If regSubKey.GetValue("GenerateSQL") Is Nothing Then
            ' Then let's enable it by default
            GenerateSQL = True
            ' Then create the registry key for it
            regKey.SetValue("GenerateSQL", True)
        Else
            ' If we do find a GenerateSQL key, then retreive its value
            GenerateSQL = regSubKey.GetValue("GenerateSQL")
        End If

        ' If we do not find a Sort registry key...
        If regSubKey.GetValue("Sort") Is Nothing Then
            ' Then lets create the registry key
            regKey.SetValue("Sort", True)
            ' And enable sorting by default
            EnableSorting = True
        Else
            ' If we do find a Sort key, then retrieve its value
            EnableSorting = regSubKey.GetValue("Sort")
        End If

        ' If we do not find a SupressComments registry key...
        If regSubKey.GetValue("SupressComments") Is Nothing Then
            ' Then lets create the key now and default it to false
            regKey.SetValue("SupressComments", False)
            ' Let's set this option to false by default
            SupressComments = False
        Else
            ' If we do find it, lets retreive the value
            SupressComments = CBool(regSubKey.GetValue("SupressComments"))
        End If

        ' If no server name has never been given, then we will default to 127.0.0.1
        If txtSQLServerName.Text = "" Then txtSQLServerName.Text = "127.0.0.1"
        ' If no password has never been given, then we will default to "password"
        If txtSQLPassword.Text = "" Then txtSQLPassword.Text = "password"
        ' If no Username has never been given, then we will default to "username"
        If txtSQLUserName.Text = "" Then txtSQLUserName.Text = "Username"
        ' If no database name has never been given, then default to "dbname"
        If txtSQLDatabaseName.Text = "" Then txtSQLDatabaseName.Text = "dbname"
        ' If no output directory name has never been given, then default
        ' to "C:\LayerGenOutput"
        If txtDestination.Text = "" Then txtDestination.Text = "C:\LayerGenOutput"
        ' If no Business namespace has never been given, then default to "BusinessLayer"
        If BusinessNameSpace = "" Then Me.BusinessNameSpace = "BusinessLayer"
        ' If no Data namespace has never been given, then default to "DataNameSpace"
        If DataNameSpace = "" Then Me.DataNameSpace = "DataLayer"

        ' Leave the encryption key blank, since we don't want encryption by default
        Me.EncryptionKey = ""
        ' Disable encryption by default
        Me.DoEncrypt = False

        ' Close the registry since we are done
        regSubKey.Close()
        regKey.Close()
    End Sub

    ' This function gets called anytime the form needs to "refresh" or get
    ' repainted. In this function is where we add our gradients on the side of
    ' the form and draw "LayerGen" going up and down the sides
    Private Sub MainForm_Paint(ByVal sender As Object, ByVal e As System.Windows.Forms.PaintEventArgs) Handles Me.Paint
        ' If form is minimized, then exit this sub (no drawing necessary)
        If Me.ClientSize.Height = 0 Then Exit Sub
        ' Create a white pen
        Dim myPen As New System.Drawing.Pen(Color.White)
        ' Create a graphics object based on our form
        Dim formGraphics As Graphics
        ' Coordinates for a rectangle
        Dim x1, y1, x2, y2 As Single
        ' This is a back buffer, which is a temporary storage area in memory
        ' where we will do our drawing first, and then later copy this area to
        ' our form. We want the size to be the height of the form and 50 pixels
        ' wide.
        Dim BackBuffer As Bitmap = New Bitmap(50, Me.ClientSize.Height)
        ' Create a graphics object from our bitmap
        Dim DrawingArea As Graphics = Graphics.FromImage(BackBuffer)

        ' If we are currently minimized, then leave this subroutine
        ' or else an error will be raised
        If Me.WindowState = FormWindowState.Minimized Then
            Exit Sub
        End If
        ' Erase the drawing area by clearing it with the same color as our
        ' Main Form
        DrawingArea.Clear(Color.FromKnownColor(KnownColor.Control))

        ' Point the upper left corner of our rectangle to be 55 pixels.
        ' This is because we want a 5 pixel pad plus the width of our control (50 pixels)
        x1 = 5 + 50
        ' Set this to be 25 pixels below our SQLDatabasenameLabel
        y1 = Me.lblSQLDatabaseNameLabel.Top + 25
        ' Set this to be the width of our form - 65
        x2 = Me.Width - 15 - 50
        y2 = Me.lblSQLDatabaseNameLabel.Top + 25
        ' Create the graphics object
        formGraphics = Me.CreateGraphics()
        ' Draw the separator line that shows up below the SQL Database name
        formGraphics.DrawLine(myPen, x1, Me.lblCopyrightLabel.Bottom + 10 + 1, x2, Me.lblCopyrightLabel.Bottom + 10 + 1)
        formGraphics.DrawLine(myPen, x1, y1 + 1, x2, y2 + 1)
        ' Dispose of our pen
        myPen.Dispose()
        ' Create a new pen that is DarkGray in color
        myPen = New Pen(Color.DarkGray)
        ' Draw the separator line again below the original line. This make it look
        ' embossed.
        formGraphics.DrawLine(myPen, x1, y1, x2, y2)
        formGraphics.DrawLine(myPen, x1, Me.lblCopyrightLabel.Bottom + 10, x2, Me.lblCopyrightLabel.Bottom + 10)
        ' Dispose of the pen
        myPen.Dispose()

        ' Create a new gradient brush
        Dim a As New System.Drawing.Drawing2D.LinearGradientBrush(New RectangleF(0, 0, 50, Me.Height), Color.Blue, Color.LightSkyBlue, Drawing2D.LinearGradientMode.Horizontal)
        ' Paint the side of the form using the new brush
        DrawingArea.FillRectangle(a, New RectangleF(0, 0, 50, Me.ClientSize.Height))
        ' Dispose of the brush
        a.Dispose()

        ' Set our string on the side of the form to be "LayerGen"
        Dim str As String = "LayerGen"
        ' Create a new font for the text
        Dim ft As Font
        ft = New Font("Arial", 36, FontStyle.Italic Or FontStyle.Bold, GraphicsUnit.Point)

        'Rotate the text 90 degrees clockwise
        DrawingArea.TranslateTransform(-5, Me.ClientSize.Height - 55)
        DrawingArea.RotateTransform(180 + 90)
        ' Draw the text, first in black, then in white. This will give it
        ' a shadow
        DrawingArea.DrawString(str, ft, Brushes.Black, -3, -3)
        DrawingArea.DrawString(str, ft, Brushes.White, 0, 0)

        ' Rotate 90 degrees
        DrawingArea.RotateTransform(180 + 90)

        ' Copy the image (the rotated text) onto the form
        formGraphics.DrawImageUnscaled(BackBuffer, 0, 0)
        BackBuffer.RotateFlip(RotateFlipType.Rotate180FlipNone)
        formGraphics.DrawImageUnscaled(BackBuffer, Me.ClientSize.Width - 50, 0)
        ' Dispose of our graphics objects
        DrawingArea.Dispose()
        formGraphics.Dispose()
    End Sub

    ' This subroutine gets called whenever the browse button gets clicked.
    ' It opens up a dialog box that allows the user to select a directory
    Private Sub btnBrowse_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnBrowse.Click
        ' Show the dialog and store the result
        Dim result As DialogResult = fbdDestination.ShowDialog()

        ' If the user clicked OK...
        If (result = Windows.Forms.DialogResult.OK) Then
            ' Then we set the path to whatever the selected path was
            txtDestination.Text = fbdDestination.SelectedPath
        End If
    End Sub

    ' This subroutine is basically a mirror of the form_closing subroutine
    ' This gets called when the exit button is clicked
    Private Sub btnExit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExit.Click
        Dim regKey As RegistryKey

        regKey = Registry.CurrentUser.CreateSubKey(STR_SoftwarerassTechnologiesayerGen)
        regKey.SetValue(STR_ServerName, Me.txtSQLServerName.Text.Trim())
        regKey.SetValue(STR_UserName, Me.txtSQLUserName.Text.Trim())
        regKey.SetValue(STR_Password, Me.txtSQLPassword.Text.Trim())
        regKey.SetValue(STR_DatabaseName, Me.txtSQLDatabaseName.Text.Trim())
        regKey.SetValue(STR_Destination, Me.txtDestination.Text.Trim())
        regKey.SetValue(STR_LangSelect, CStr(Me.cboLanguage.SelectedItem).Trim())
        regKey.Close()
        ' This ends the program
        End
    End Sub

    ' This function gets called each time a key is pressed inside the
    ' SQL Server Name text box. If the user hits enter, then it creates the layers
    Private Sub txtSQLServerName_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtSQLServerName.KeyPress
        If e.KeyChar = Cr Then
            btnCreateLayers.PerformClick()
            Exit Sub
        End If
    End Sub

    ' This function gets called each time a key is pressed inside the
    ' SQL User Name text box. If the user hits enter, then it creates the layers
    Private Sub txtSQLUserName_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtSQLUserName.KeyPress
        If e.KeyChar = Cr Then
            btnCreateLayers.PerformClick()
            Exit Sub
        End If
    End Sub

    ' This function gets called each time a key is pressed inside the
    ' SQL password text box. If the user hits enter, then it creates the layers
    Private Sub txtSQLPassword_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtSQLPassword.KeyPress
        If e.KeyChar = Cr Then
            btnCreateLayers.PerformClick()
            Exit Sub
        End If
    End Sub

    ' This function gets called each time a key is pressed inside the
    ' destination text box. If the user hits enter, then it creates the layers
    Private Sub txtDestination_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtDestination.KeyPress
        If e.KeyChar = Cr Then
            btnCreateLayers.PerformClick()
            Exit Sub
        End If
    End Sub

    ' This subroutine gets called whenever the user clicks the
    ' "Create Layer's" button. It is also called whenever the user hits enter
    ' inside any of the text boxes on the screen
    Private Sub btnCreateLayers_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCreateLayers.Click
        ' This will hold a true/false value to deteremine if the layers were
        ' successfully created
        Dim Result As Boolean

        ' We want to check and make sure a value Server name was entered.
        ' We only want to check this if SQL Server is selected
        If txtSQLServerName.Text.Trim() = "" And Me.LanguageSelected = LanguageType.SqlServer Then
            ' Display an error message
            MiscFunctions.DisplayError("You must specify a SQL Server Name!")
            ' Give the SQL Server name control focus
            txtSQLServerName.Focus()
            ' Exit this subroutine
            Exit Sub
        End If
        ' Check to make sure a valid destination directory has been entered.
        If txtDestination.Text.Trim() = "" Then
            ' Display an error message stating a valid destination directory must be entered
            MiscFunctions.DisplayError("You must specify a valid destination directory for output files!")
            ' Set focus to the destination text box
            txtDestination.Focus()
            ' Exit this subroutine
            Exit Sub
        End If
        ' Check to see if the directory given exists
        If Not My.Computer.FileSystem.DirectoryExists(txtDestination.Text.Trim()) Then
            Dim dlgResult As DialogResult
            ' Let the user know the directory does not exist and ask if they want to create it
            dlgResult = MessageBox.Show("Directory " + Chr(34) + txtDestination.Text.Trim() + Chr(34) + " does not exist. Create it?", "Create Directory", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
            ' Check to see if the user clicked Yes or No
            If dlgResult <> Windows.Forms.DialogResult.Yes Then
                ' User clicked no, so lets set focus to the destination text box
                txtDestination.Focus()
                ' Exit this sub
                Exit Sub
            End If
            ' Try to create the directory, since we've established it don't exist
            Try
                My.Computer.FileSystem.CreateDirectory(txtDestination.Text.Trim())
                ' The path is too long
            Catch ex As IO.PathTooLongException
                MiscFunctions.DisplayError("Sorry, the path you specified is too long")
                txtDestination.Focus()
                Exit Sub
                ' The directory could not be found (possible network share)
            Catch ex As IO.DirectoryNotFoundException
                MiscFunctions.DisplayError("The directory could not be found (network down?)")
                txtDestination.Focus()
                Exit Sub
                ' Used tried to call the directory ':'
            Catch ex As NotSupportedException
                MiscFunctions.DisplayError("Cannot have directory called just ':'")
                txtDestination.Focus()
                Exit Sub
                ' Directory already exists
            Catch ex As System.IO.IOException
                MiscFunctions.DisplayError("Sorry, directory already exists")
                txtDestination.Focus()
                Exit Sub
                ' User does not have sufficient rights to create a directory here
            Catch ex As UnauthorizedAccessException
                MiscFunctions.DisplayError("You do not have sufficient rights to create this directory")
                txtDestination.Focus()
                Exit Sub
                ' Pathname contains illegal characters
            Catch ex As ArgumentException
                MiscFunctions.DisplayError("The path name you specified contains illegal characters")
                txtDestination.Focus()
                Exit Sub
            End Try
        End If
        ' Create the layers
        Result = CreateLayers()
        ' If we failed to create the layers, then exit this subroutine now
        If Result = False Then Exit Sub
        ' If the user wants encryption, then we need to create the Encrypt64 file
        If Me.DoEncrypt Then
            ' Check to see if pathname ends with a backslash character
            If txtDestination.Text.Trim().EndsWith("\") Then
                ' If it does, then append the filename "Encrypt64" plus the appropriate extension
                OutputFile = New IO.StreamWriter(txtDestination.Text.Trim() + "Encrypt64" + Extension)
            Else
                ' If it does not, then append a backslash along with the filename and appropriate extension
                OutputFile = New IO.StreamWriter(txtDestination.Text.Trim() + "\Encrypt64" + Extension)
            End If
            ' If the user chose to generate VB.NET code, then lets create
            ' the appropriate encrypt64 file.
            If CStr(Me.cboLanguage.SelectedItem).Trim = "VB.NET" Then
                ' All these lines do is output text to our file
                OutputFile.WriteLine("Imports System")
                OutputFile.WriteLine("Imports System.IO")
                OutputFile.WriteLine("Imports System.Xml")
                OutputFile.WriteLine("Imports System.Text")
                OutputFile.WriteLine("Imports System.Security.Cryptography")
                OutputFile.WriteLine("")
                OutputFile.WriteLine("Public Class Encryption64")
                OutputFile.WriteLine(Chr(9) + "Private key() As Byte = {}")
                OutputFile.WriteLine(Chr(9) + "Private IV() As Byte = {&H12, &H34, &H56, &H78, &H90, &HAB, &HCD, &HEF}")
                OutputFile.WriteLine(Chr(9) + "")
                OutputFile.WriteLine(Chr(9) + "Public Function Decrypt(ByVal stringToDecrypt As String, _")
                OutputFile.WriteLine(Chr(9) + "    ByVal sEncryptionKey As String) As String")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "Dim inputByteArray(stringToDecrypt.Length) As Byte")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "Try")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "key = System.Text.Encoding.UTF8.GetBytes(Left(sEncryptionKey, 8))")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Dim des As New DESCryptoServiceProvider")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "inputByteArray = Convert.FromBase64String(stringToDecrypt)")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Dim ms As New MemoryStream")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Dim cs As New CryptoStream(ms, des.CreateDecryptor(key, IV), _")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "   CryptoStreamMode.Write)")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "cs.Write(inputByteArray, 0, inputByteArray.Length)")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "cs.FlushFinalBlock()")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Dim encoding As System.Text.Encoding = System.Text.Encoding.UTF8")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Return encoding.GetString(ms.ToArray())")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "Catch e As Exception")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Return e.Message")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "End Try")
                OutputFile.WriteLine(Chr(9) + "End Function")
                OutputFile.WriteLine(Chr(9) + "")
                OutputFile.WriteLine(Chr(9) + "Public Function Encrypt(ByVal stringToEncrypt As String, _")
                OutputFile.WriteLine(Chr(9) + "    ByVal SEncryptionKey As String) As String")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "Try")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "key = System.Text.Encoding.UTF8.GetBytes(Left(SEncryptionKey, 8))")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Dim des As New DESCryptoServiceProvider")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Dim inputByteArray() As Byte = Encoding.UTF8.GetBytes( _")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "    stringToEncrypt)")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Dim ms As New MemoryStream")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Dim cs As New CryptoStream(ms, des.CreateEncryptor(key, IV), _")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "    CryptoStreamMode.Write)")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "cs.Write(inputByteArray, 0, inputByteArray.Length)")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "cs.FlushFinalBlock()")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Return Convert.ToBase64String(ms.ToArray())")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "Catch e As Exception")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Return e.Message")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "End Try")
                OutputFile.WriteLine(Chr(9) + "End Function")
                OutputFile.WriteLine("End Class")
                ' This closes the file
                OutputFile.Close()
            Else
                ' Lets create the file in C# instead of VB.NET
                ' Again, all this does is output lines to our file
                OutputFile.WriteLine("using System;")
                OutputFile.WriteLine("using System.IO;")
                OutputFile.WriteLine("using System.Xml;")
                OutputFile.WriteLine("using System.Text;")
                OutputFile.WriteLine("using System.Security.Cryptography;")
                OutputFile.WriteLine("")
                OutputFile.WriteLine("public class Encryption64")
                OutputFile.WriteLine("{")
                OutputFile.WriteLine(Chr(9) + "private byte[] key = {};")
                OutputFile.WriteLine(Chr(9) + "private byte[] IV = {18, 52, 86, 120, 144, 171, 205, 239};")
                OutputFile.WriteLine("")
                OutputFile.WriteLine(Chr(9) + "public string Decrypt(string stringToDecrypt, string sEncryptionKey)")
                OutputFile.WriteLine(Chr(9) + "{")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "byte[] inputByteArray = new byte[stringToDecrypt.Length + 1]; ")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "try {")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "key = System.Text.Encoding.UTF8.GetBytes(Strings.Left(sEncryptionKey, 8));")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "DESCryptoServiceProvider des = new DESCryptoServiceProvider();")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "inputByteArray = Convert.FromBase64String(stringToDecrypt);")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "MemoryStream ms = new MemoryStream();")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(key, IV), CryptoStreamMode.Write);")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "cs.Write(inputByteArray, 0, inputByteArray.Length);")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "cs.FlushFinalBlock();")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "System.Text.Encoding encoding = System.Text.Encoding.UTF8;")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "return encoding.GetString(ms.ToArray()); ")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "}")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "catch (Exception e) {")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "return e.Message;")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "}")
                OutputFile.WriteLine(Chr(9) + "}")
                OutputFile.WriteLine("")
                OutputFile.WriteLine(Chr(9) + "public string Encrypt(string stringToEncrypt, string SEncryptionKey)")
                OutputFile.WriteLine(Chr(9) + "{")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "try {")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "key = System.Text.Encoding.UTF8.GetBytes(Strings.Left(SEncryptionKey, 8));")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "DESCryptoServiceProvider des = new DESCryptoServiceProvider();")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "byte[] inputByteArray = Encoding.UTF8.GetBytes(stringToEncrypt);")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "MemoryStream ms = new MemoryStream();")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(key, IV), CryptoStreamMode.Write);")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "cs.Write(inputByteArray, 0, inputByteArray.Length);")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "cs.FlushFinalBlock();")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "return Convert.ToBase64String(ms.ToArray());")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "}")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "catch (Exception e) { ")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "return e.Message; ")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "}")
                OutputFile.WriteLine(Chr(9) + "}")
                OutputFile.WriteLine("}")
                ' Close the file
                OutputFile.Close()
            End If
        End If
        ' If the result is true then our layers were created successfully
        If Result = True Then
            MessageBox.Show("Layers Created Successfully!", "Layering done", MessageBoxButtons.OK, MessageBoxIcon.Information)
        End If
    End Sub

    ' This function returns the appropriate SQLImplementation pointer to the
    ' caller. Right now this function can only return a SQL Server pointer
    ' or an Access pointer
    Private Function CreateSQLObject() As SQLImplementation
        If Me.LanguageSelected = LanguageType.SqlServer Then
            Return New MSSQLFunctions
        End If
        If Me.LanguageSelected = LanguageType.Access Then
            Return New AccessFunctions
        End If

        Return Nothing
    End Function

    ' This function returns the appropriate LangImplementation pointer to the
    ' caller. Right now this function can only return VB.NET or C# pointers
    Private Function CreateLangObject() As LangImplementation
        If CStr(Me.cboLanguage.SelectedItem).Trim() = "VB.NET" Then
            Extension = ".VB"
            Return New VBFunctions
        End If
        If CStr(Me.cboLanguage.SelectedItem).Trim() = "C#" Then
            Extension = ".CS"
            Return New CSFunctions
        End If

        Return Nothing
    End Function

    ' This function creates our layers
    Private Function CreateLayers() As Boolean
        Dim Tables As Data.DataTable
        Dim PrimKeys As Data.DataTable
        Dim ForgKeys As Data.DataTable
        Dim PrimaryKey As String
        Dim ts As New TableSelector
        Dim sps As String = ""
        Dim ProgressWindow As New ProgressDialog()

        ' If our SQLObject's or our LangObject's have not been
        ' created yet, then create them now
        If SQLObject Is Nothing Then SQLObject = CreateSQLObject()
        If LangObject Is Nothing Then LangObject = CreateLangObject()

        ' These lines test to see if we are generating code based
        ' on SQL Server or some other database. It sets the appropriate
        ' flag in the LangObject
        If LanguageSelected = LanguageType.SqlServer Then
            LangObject.IsDatabaseMSSQL = True
        Else
            LangObject.IsDatabaseMSSQL = False
        End If

        ' Pass the option to supress comments onto our language object and
        ' our SQL Object
        SQLObject.SupressComments = Me.SupressComments
        LangObject.SupressComments = Me.SupressComments

        ' Set Layergen's version
        SQLObject.Version = VERSION
        LangObject.Version = VERSION

        ' Set the encryption key and a boolean determining if we want
        ' Encryption or not
        SQLObject.EncryptionKey = Me.EncryptionKey
        SQLObject.DoEncryption = Me.DoEncrypt
        LangObject.EncryptionKey = Me.EncryptionKey
        LangObject.DoEncryption = Me.DoEncrypt

        ' If we are using SQL Server, then set the username, password
        ' Database name and server address
        If LanguageSelected = LanguageType.SqlServer Then
            LangObject.TheSQLDatabaseName = Me.txtSQLDatabaseName.Text.Trim()
            LangObject.TheSQLServerName = Me.txtSQLServerName.Text.Trim()
            If Me.rbWindowsAuthentication.Checked = True Then
                SQLObject.AuthenticationType = SQLImplementation.AuthenticationTypes.WindowsAuthentication
                LangObject.AuthenticationType = LangImplementation.AuthenticationTypes.WindowsAuthentication
            ElseIf Me.rbSQLServer.Checked = True Then
                SQLObject.AuthenticationType = SQLImplementation.AuthenticationTypes.SQLServerAuthentication
                LangObject.AuthenticationType = LangImplementation.AuthenticationTypes.SQLServerAuthentication
            End If
            LangObject.TheSQLUserName = Me.txtSQLUserName.Text.Trim()
            LangObject.TheSQLPassword = Me.txtSQLPassword.Text.Trim()
        ElseIf LanguageSelected = LanguageType.Access Then
            ' If we are using Access, we just need the file name
            LangObject.TheSQLDatabaseName = Me.txtAccessFileName.Text.Trim()
        End If

        LangObject.TheSQLObject = SQLObject
        ts.TheSQLObject = SQLObject
        LangObject.TheOutputFile = OutputFile
        SQLObject.TheOutputFile = OutputFile

        LangObject.TheDataNameSpace = Me.DataNameSpace
        LangObject.TheBusinessNameSpace = Me.BusinessNameSpace

        If LanguageSelected = LanguageType.Access Then
            SQLObject.SQLConnect(Me.txtSQLServerName.Text, Me.txtAccessFileName.Text, Me.txtSQLUserName.Text, Me.txtSQLPassword.Text)
        ElseIf LanguageSelected = LanguageType.SqlServer Then
            SQLObject.SQLConnect(Me.txtSQLServerName.Text, Me.txtSQLDatabaseName.Text, Me.txtSQLUserName.Text, Me.txtSQLPassword.Text)
        End If
        If Not SQLObject.IsConnected Then
            ts = Nothing
            Return False
        End If

        Tables = SQLObject.GetTables()
        ts.TheTableCollection = Tables
        ts.ShowDialog()

        If ts.WasCancelled Then
            ts = Nothing
            Return False
        End If

        ProgressWindow.Show()
        ProgressWindow.Left = (My.Computer.Screen.Bounds.Width - ProgressWindow.Size.Width) / 2
        ProgressWindow.Top = (My.Computer.Screen.Bounds.Height - ProgressWindow.Size.Height - 50) / 2

        Dim ProgressOffset As Integer = ts.Counter * 3
        ProgressWindow.ProgressMax = ProgressOffset

        For Each r As Data.DataRow In Tables.Rows
            Dim PathName As String
            Dim dt As DataTable
            Dim FieldName As String = "TABLE_NAME"

            ProgressWindow.TableName = r(FieldName)
            If SQLObject.IsSystemTable(r(FieldName)) Then
                Continue For
            End If

            If txtDestination.Text.Trim().EndsWith("\") Then
                PathName = txtDestination.Text.Trim() + r(FieldName)
            Else
                PathName = txtDestination.Text.Trim() + "\" + r(FieldName)
            End If
            PrimKeys = SQLObject.GetPrimaryKey(r(FieldName))
            If PrimKeys.Rows.Count = 0 And SQLObject.IsView(r(FieldName)) = False Then
                MessageBox.Show("Table " + r(FieldName) + " has no primary key defined. Skipping", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                Continue For
            End If

            OutputFile = New IO.StreamWriter(PathName + "Business" + Extension)
            LangObject.TheOutputFile = OutputFile
            SQLObject.TheOutputFile = OutputFile
            ForgKeys = SQLObject.GetForeignKeys(r(FieldName))
            If SQLObject.IsView(r(FieldName)) = True Then
                PrimaryKey = ""
            Else
                PrimaryKey = PrimKeys.Rows(0)("COLUMN_NAME")
            End If

            ProgressWindow.FunctionName = "Business Layer"
            dt = SQLObject.GetFields(r(FieldName))
            CreateBusinessLayer(r(FieldName), PrimaryKey, dt)
            ProgressWindow.Progress = ProgressWindow.Progress + 1

            OutputFile.Close()
            OutputFile = Nothing
            OutputFile = New IO.StreamWriter(PathName + "Data" + Extension)
            LangObject.TheOutputFile = OutputFile
            SQLObject.TheOutputFile = OutputFile
            dt = SQLObject.GetFields(r(FieldName))
            ProgressWindow.FunctionName = "Data Layer"
            CreateDataLayer(r(FieldName), PrimaryKey, ForgKeys, dt)
            ProgressWindow.Progress = ProgressWindow.Progress + 1
            OutputFile.Close()
            OutputFile = Nothing

            OutputFile = New IO.StringWriter()
            LangObject.TheOutputFile = OutputFile
            SQLObject.TheOutputFile = OutputFile
            ProgressWindow.FunctionName = "Stored Procedure"
            CreateStoredProcedures(r(FieldName), PrimaryKey, dt)
            ProgressWindow.Progress = ProgressWindow.Progress + 1
            sps = sps + OutputFile.ToString()
            OutputFile.Close()
            OutputFile = Nothing

            If Me.GenerateSQL Then
                OutputFile = IO.File.AppendText(PathName.Replace(r(FieldName), "") + "Procedures.SQL")
                LangObject.TheOutputFile = OutputFile
                SQLObject.TheOutputFile = OutputFile
                CreateStoredProcedures(r(FieldName), PrimaryKey, dt)
                OutputFile.Close()
                OutputFile = Nothing
            End If
        Next
        If Me.AutoInsert Then
            SQLObject.AutoInsertProcedures(sps)
        End If
        If txtDestination.Text.Trim().EndsWith("\") Then
            OutputFile = New IO.StreamWriter(txtDestination.Text.Trim() + "Interfaces" + Extension)
        Else
            OutputFile = New IO.StreamWriter(txtDestination.Text.Trim() + "\Interfaces" + Extension)
        End If
        LangObject.TheOutputFile = OutputFile
        SQLObject.TheOutputFile = OutputFile
        LangObject.CreateInterfaces()
        OutputFile.Close()
        OutputFile = Nothing
        If txtDestination.Text.Trim().EndsWith("\") Then
            OutputFile = New IO.StreamWriter(txtDestination.Text.Trim() + "Universal" + Extension)
        Else
            OutputFile = New IO.StreamWriter(txtDestination.Text.Trim() + "\Universal" + Extension)
        End If
        LangObject.TheOutputFile = OutputFile
        SQLObject.TheOutputFile = OutputFile
        LangObject.CreateUniversalConnection()
        OutputFile.Close()
        OutputFile = Nothing
        SQLObject.SQLClose()
        IsConnected = False
        ProgressWindow.Close()
        Return True
    End Function

    Public Sub CreateDataLayer(ByVal TableName As String, ByVal PrimaryKey As String, ByVal FKeys As Data.DataTable, ByVal Fields As DataTable)
        LangObject.CreateDataHeader(TableName)
        LangObject.CreateMemberVariables(Fields, FKeys)
        LangObject.CreateDataConstructors(Fields, TableName, PrimaryKey)
        LangObject.CreateDataProperties(Fields, FKeys)
        LangObject.CreateDataConnectionStringSubs()
        LangObject.CreateDataCopySub(Fields)
        LangObject.CreateDataFillSub(Fields)
        LangObject.CreateDataGetSub(Fields, TableName, PrimaryKey)
        If SQLObject.IsView(TableName) = False Then
            LangObject.CreateDataDeleteSub(Fields, TableName, PrimaryKey)
            LangObject.CreateDataSaveSub(Fields, TableName, PrimaryKey)
        End If
        LangObject.CreateDataGetAll(TableName)
        LangObject.CreateDataGetByFKs(TableName)
        LangObject.CreateDataCustomQueryMethods(Fields, TableName)
        LangObject.CreateDataFooter()
    End Sub

    Public Sub CreateBusinessLayer(ByVal TableName As String, ByVal PrimaryKey As String, ByVal Fields As DataTable)
        LangObject.CreateBusinessHeader(TableName)
        LangObject.CreateBusinessConstructors(Fields, TableName, PrimaryKey)
        LangObject.CreateInterfaceImplementation(TableName, PrimaryKey)
        LangObject.CreateCollectionClass(TableName, PrimaryKey, EnableSorting)
    End Sub

    Public Sub CreateStoredProcedures(ByVal TableName As String, ByVal PrimaryKey As String, ByVal Fields As DataTable)
        If SQLObject.IsView(TableName) Then
            SQLObject.CreateStoredProcedureGetAll(Fields, TableName, PrimaryKey)
            Exit Sub
        End If

        SQLObject.CreateStoredProcedureUpdate(Fields, TableName, PrimaryKey)
        SQLObject.CreateStoredProcedureInsert(Fields, TableName, PrimaryKey)
        SQLObject.CreateStoredProcedureSelect(Fields, TableName, PrimaryKey)
        SQLObject.CreateStoredProcedureDelete(Fields, TableName, PrimaryKey)
        SQLObject.CreateStoredProcedureGetAll(Fields, TableName, PrimaryKey)
        SQLObject.CreateStoredProcedureFKs(Fields, TableName, PrimaryKey)
    End Sub

    Private Sub ToolTipTimer_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ToolTipTimer.Tick
        BrowseTip.Show("Browse for a destination folder", Me.btnBrowse, MouseX, MouseY)
        ToolTipTimer.Enabled = False
    End Sub

    Private Sub btnBrowse_MouseLeave(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBrowse.MouseLeave
        ToolTipTimer.Enabled = False
        BrowseTip.Hide(Me.btnBrowse)
    End Sub

    Private Sub btnBrowse_MouseMove(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles btnBrowse.MouseMove
        BrowseTip.Hide(Me.btnBrowse)
        MouseX = e.X + 15
        MouseY = e.Y + 15

        ToolTipTimer.Enabled = True
        ToolTipTimer.Interval = 1
        ToolTipTimer.Start()
    End Sub

    Private Sub btnAdvancedOptions_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAdvancedOptions.Click
        Dim ao As New AdvancedOptionsDialog

        ao.ShowDialog()
        If Not ao.WasCancelled Then
            BusinessNameSpace = ao.BusinessName
            DataNameSpace = ao.DataName
            Me.DoEncrypt = ao.DataEncryption
            Me.EncryptionKey = ao.EncryptionKey
            Me.GenerateSQL = ao.GenerateSQLFile
            Me.AutoInsert = ao.AutoInsert
            Me.EnableSorting = ao.Sorting
        End If
    End Sub

    Private Sub cboSQLServerType_SelectedValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboSQLServerType.SelectedValueChanged
        If Me.cboSQLServerType.SelectedItem = "Microsoft SQL Server" Then
            Me.LanguageSelected = LanguageType.SqlServer
        ElseIf Me.cboSQLServerType.SelectedItem = "Microsoft Access" Then
            Me.LanguageSelected = LanguageType.Access
        Else 'Just in case we missed one
            Me.LanguageSelected = LanguageType.SqlServer ' We'll default to SQL Server
        End If

        ReorganizeControls()
    End Sub

    Private Sub ReorganizeControls()
        If Me.LanguageSelected = LanguageType.SqlServer Then
            Me.lblSQLServerNameLabel.Visible = True
            Me.txtSQLServerName.Visible = True
            Me.lblSQLUserName.Visible = True
            Me.txtSQLUserName.Visible = True
            Me.lblSQLPasswordLabel.Visible = True
            Me.txtSQLPassword.Visible = True
            Me.lblSQLDatabaseNameLabel.Visible = True
            Me.txtSQLDatabaseName.Visible = True

            Me.btnAccessBrowse.Visible = False
            Me.lblAccessFileNameLabel.Visible = False
            Me.txtAccessFileName.Visible = False
        ElseIf Me.LanguageSelected = LanguageType.Access Then
            Me.lblSQLServerNameLabel.Visible = False
            Me.txtSQLServerName.Visible = False
            Me.lblSQLUserName.Visible = False
            Me.txtSQLUserName.Visible = False
            Me.lblSQLPasswordLabel.Visible = False
            Me.txtSQLPassword.Visible = False
            Me.lblSQLDatabaseNameLabel.Visible = False
            Me.txtSQLDatabaseName.Visible = False

            Me.btnAccessBrowse.Visible = True
            Me.lblAccessFileNameLabel.Visible = True
            Me.txtAccessFileName.Visible = True
        End If

        If Me.LanguageSelected = LanguageType.Access Then
            Me.gbAuthenticationType.Visible = False
            Me.rbSQLServer.Visible = False
            Me.rbWindowsAuthentication.Visible = False
        End If

        If Me.LanguageSelected = LanguageType.SqlServer Then
            Me.gbAuthenticationType.Visible = True
            Me.rbSQLServer.Visible = True
            Me.rbWindowsAuthentication.Visible = True
        End If
    End Sub

    Private Sub btnAccessBrowse_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAccessBrowse.Click
        Dim dr As DialogResult = ofdAccessDatabase.ShowDialog()

        If (dr = Windows.Forms.DialogResult.OK) Then
            txtAccessFileName.Text = ofdAccessDatabase.FileName
        End If
    End Sub

    Private Sub rbWindowsAuthentication_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rbWindowsAuthentication.CheckedChanged
        If rbWindowsAuthentication.Checked = True Then
            Me.txtSQLUserName.Visible = False
            Me.txtSQLPassword.Visible = False
            Me.lblSQLPasswordLabel.Visible = False
            Me.lblSQLUserName.Visible = False
        Else
            Me.txtSQLUserName.Visible = True
            Me.txtSQLPassword.Visible = True
            Me.lblSQLPasswordLabel.Visible = True
            Me.lblSQLUserName.Visible = True
        End If
    End Sub

    Private Sub rbSQLServer_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rbSQLServer.CheckedChanged
        If rbWindowsAuthentication.Checked = True Then
            Me.txtSQLUserName.Visible = False
            Me.txtSQLPassword.Visible = False
            Me.lblSQLPasswordLabel.Visible = False
            Me.lblSQLUserName.Visible = False
        Else
            Me.txtSQLUserName.Visible = True
            Me.txtSQLPassword.Visible = True
            Me.lblSQLPasswordLabel.Visible = True
            Me.lblSQLUserName.Visible = True
        End If
    End Sub
End Class
