<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class MainForm
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(MainForm))
        Me.lblSQLServerNameLabel = New System.Windows.Forms.Label
        Me.txtSQLServerName = New System.Windows.Forms.TextBox
        Me.lblSQLServerTypeLabel = New System.Windows.Forms.Label
        Me.cboSQLServerType = New System.Windows.Forms.ComboBox
        Me.lblSQLUserName = New System.Windows.Forms.Label
        Me.txtSQLUserName = New System.Windows.Forms.TextBox
        Me.lblSQLPasswordLabel = New System.Windows.Forms.Label
        Me.txtSQLPassword = New System.Windows.Forms.TextBox
        Me.lblLanguageLabel = New System.Windows.Forms.Label
        Me.cboLanguage = New System.Windows.Forms.ComboBox
        Me.fbdDestination = New System.Windows.Forms.FolderBrowserDialog
        Me.lblDestinationLabel = New System.Windows.Forms.Label
        Me.txtDestination = New System.Windows.Forms.TextBox
        Me.btnBrowse = New System.Windows.Forms.Button
        Me.btnCreateLayers = New System.Windows.Forms.Button
        Me.btnExit = New System.Windows.Forms.Button
        Me.lblSQLDatabaseNameLabel = New System.Windows.Forms.Label
        Me.txtSQLDatabaseName = New System.Windows.Forms.TextBox
        Me.ToolTipTimer = New System.Windows.Forms.Timer(Me.components)
        Me.btnAdvancedOptions = New System.Windows.Forms.Button
        Me.lblAppNameLabel = New System.Windows.Forms.Label
        Me.lblVersionLabel = New System.Windows.Forms.Label
        Me.lblCopyrightLabel = New System.Windows.Forms.Label
        Me.txtAccessFileName = New System.Windows.Forms.TextBox
        Me.lblAccessFileNameLabel = New System.Windows.Forms.Label
        Me.btnAccessBrowse = New System.Windows.Forms.Button
        Me.ofdAccessDatabase = New System.Windows.Forms.OpenFileDialog
        Me.gbAuthenticationType = New System.Windows.Forms.GroupBox
        Me.rbSQLServer = New System.Windows.Forms.RadioButton
        Me.rbWindowsAuthentication = New System.Windows.Forms.RadioButton
        Me.gbAuthenticationType.SuspendLayout()
        Me.SuspendLayout()
        '
        'lblSQLServerNameLabel
        '
        Me.lblSQLServerNameLabel.AutoSize = True
        Me.lblSQLServerNameLabel.Location = New System.Drawing.Point(75, 87)
        Me.lblSQLServerNameLabel.Name = "lblSQLServerNameLabel"
        Me.lblSQLServerNameLabel.Size = New System.Drawing.Size(96, 13)
        Me.lblSQLServerNameLabel.TabIndex = 0
        Me.lblSQLServerNameLabel.Text = "SQL Server &Name:"
        '
        'txtSQLServerName
        '
        Me.txtSQLServerName.Location = New System.Drawing.Point(177, 84)
        Me.txtSQLServerName.Name = "txtSQLServerName"
        Me.txtSQLServerName.Size = New System.Drawing.Size(130, 20)
        Me.txtSQLServerName.TabIndex = 1
        '
        'lblSQLServerTypeLabel
        '
        Me.lblSQLServerTypeLabel.AutoSize = True
        Me.lblSQLServerTypeLabel.Location = New System.Drawing.Point(79, 112)
        Me.lblSQLServerTypeLabel.Name = "lblSQLServerTypeLabel"
        Me.lblSQLServerTypeLabel.Size = New System.Drawing.Size(92, 13)
        Me.lblSQLServerTypeLabel.TabIndex = 2
        Me.lblSQLServerTypeLabel.Text = "SQL Server &Type:"
        '
        'cboSQLServerType
        '
        Me.cboSQLServerType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboSQLServerType.FormattingEnabled = True
        Me.cboSQLServerType.Location = New System.Drawing.Point(177, 109)
        Me.cboSQLServerType.Name = "cboSQLServerType"
        Me.cboSQLServerType.Size = New System.Drawing.Size(130, 21)
        Me.cboSQLServerType.TabIndex = 3
        '
        'lblSQLUserName
        '
        Me.lblSQLUserName.AutoSize = True
        Me.lblSQLUserName.Location = New System.Drawing.Point(84, 136)
        Me.lblSQLUserName.Name = "lblSQLUserName"
        Me.lblSQLUserName.Size = New System.Drawing.Size(87, 13)
        Me.lblSQLUserName.TabIndex = 4
        Me.lblSQLUserName.Text = "SQL &User Name:"
        '
        'txtSQLUserName
        '
        Me.txtSQLUserName.Location = New System.Drawing.Point(177, 136)
        Me.txtSQLUserName.Name = "txtSQLUserName"
        Me.txtSQLUserName.Size = New System.Drawing.Size(130, 20)
        Me.txtSQLUserName.TabIndex = 5
        '
        'lblSQLPasswordLabel
        '
        Me.lblSQLPasswordLabel.AutoSize = True
        Me.lblSQLPasswordLabel.Location = New System.Drawing.Point(91, 165)
        Me.lblSQLPasswordLabel.Name = "lblSQLPasswordLabel"
        Me.lblSQLPasswordLabel.Size = New System.Drawing.Size(80, 13)
        Me.lblSQLPasswordLabel.TabIndex = 6
        Me.lblSQLPasswordLabel.Text = "SQL &Password:"
        '
        'txtSQLPassword
        '
        Me.txtSQLPassword.Location = New System.Drawing.Point(177, 162)
        Me.txtSQLPassword.Name = "txtSQLPassword"
        Me.txtSQLPassword.PasswordChar = Global.Microsoft.VisualBasic.ChrW(42)
        Me.txtSQLPassword.Size = New System.Drawing.Size(130, 20)
        Me.txtSQLPassword.TabIndex = 7
        '
        'lblLanguageLabel
        '
        Me.lblLanguageLabel.AutoSize = True
        Me.lblLanguageLabel.Location = New System.Drawing.Point(113, 284)
        Me.lblLanguageLabel.Name = "lblLanguageLabel"
        Me.lblLanguageLabel.Size = New System.Drawing.Size(58, 13)
        Me.lblLanguageLabel.TabIndex = 10
        Me.lblLanguageLabel.Text = "&Language:"
        '
        'cboLanguage
        '
        Me.cboLanguage.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboLanguage.FormattingEnabled = True
        Me.cboLanguage.Location = New System.Drawing.Point(177, 281)
        Me.cboLanguage.Name = "cboLanguage"
        Me.cboLanguage.Size = New System.Drawing.Size(130, 21)
        Me.cboLanguage.TabIndex = 11
        '
        'fbdDestination
        '
        Me.fbdDestination.Description = "Choose a Destination Folder to place created files in"
        '
        'lblDestinationLabel
        '
        Me.lblDestinationLabel.AutoSize = True
        Me.lblDestinationLabel.Location = New System.Drawing.Point(63, 315)
        Me.lblDestinationLabel.Name = "lblDestinationLabel"
        Me.lblDestinationLabel.Size = New System.Drawing.Size(108, 13)
        Me.lblDestinationLabel.TabIndex = 12
        Me.lblDestinationLabel.Text = "Destination D&irectory:"
        '
        'txtDestination
        '
        Me.txtDestination.Location = New System.Drawing.Point(177, 312)
        Me.txtDestination.Name = "txtDestination"
        Me.txtDestination.Size = New System.Drawing.Size(130, 20)
        Me.txtDestination.TabIndex = 13
        '
        'btnBrowse
        '
        Me.btnBrowse.Location = New System.Drawing.Point(313, 312)
        Me.btnBrowse.Name = "btnBrowse"
        Me.btnBrowse.Size = New System.Drawing.Size(24, 21)
        Me.btnBrowse.TabIndex = 14
        Me.btnBrowse.Text = "..."
        Me.btnBrowse.UseVisualStyleBackColor = True
        '
        'btnCreateLayers
        '
        Me.btnCreateLayers.Location = New System.Drawing.Point(66, 371)
        Me.btnCreateLayers.Name = "btnCreateLayers"
        Me.btnCreateLayers.Size = New System.Drawing.Size(105, 23)
        Me.btnCreateLayers.TabIndex = 15
        Me.btnCreateLayers.Text = "&Create Layers"
        Me.btnCreateLayers.UseVisualStyleBackColor = True
        '
        'btnExit
        '
        Me.btnExit.Location = New System.Drawing.Point(232, 371)
        Me.btnExit.Name = "btnExit"
        Me.btnExit.Size = New System.Drawing.Size(105, 23)
        Me.btnExit.TabIndex = 16
        Me.btnExit.Text = "E&xit Program"
        Me.btnExit.UseVisualStyleBackColor = True
        '
        'lblSQLDatabaseNameLabel
        '
        Me.lblSQLDatabaseNameLabel.AutoSize = True
        Me.lblSQLDatabaseNameLabel.Location = New System.Drawing.Point(60, 191)
        Me.lblSQLDatabaseNameLabel.Name = "lblSQLDatabaseNameLabel"
        Me.lblSQLDatabaseNameLabel.Size = New System.Drawing.Size(111, 13)
        Me.lblSQLDatabaseNameLabel.TabIndex = 8
        Me.lblSQLDatabaseNameLabel.Text = "SQL &Database Name:"
        '
        'txtSQLDatabaseName
        '
        Me.txtSQLDatabaseName.Location = New System.Drawing.Point(177, 191)
        Me.txtSQLDatabaseName.Name = "txtSQLDatabaseName"
        Me.txtSQLDatabaseName.Size = New System.Drawing.Size(130, 20)
        Me.txtSQLDatabaseName.TabIndex = 9
        '
        'ToolTipTimer
        '
        Me.ToolTipTimer.Interval = 3000
        '
        'btnAdvancedOptions
        '
        Me.btnAdvancedOptions.Location = New System.Drawing.Point(66, 342)
        Me.btnAdvancedOptions.Name = "btnAdvancedOptions"
        Me.btnAdvancedOptions.Size = New System.Drawing.Size(271, 23)
        Me.btnAdvancedOptions.TabIndex = 17
        Me.btnAdvancedOptions.Text = "Advanced Options"
        Me.btnAdvancedOptions.UseVisualStyleBackColor = True
        '
        'lblAppNameLabel
        '
        Me.lblAppNameLabel.AutoSize = True
        Me.lblAppNameLabel.Font = New System.Drawing.Font("Arial Black", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblAppNameLabel.Location = New System.Drawing.Point(160, 0)
        Me.lblAppNameLabel.Name = "lblAppNameLabel"
        Me.lblAppNameLabel.Size = New System.Drawing.Size(95, 23)
        Me.lblAppNameLabel.TabIndex = 18
        Me.lblAppNameLabel.Text = "LayerGen"
        '
        'lblVersionLabel
        '
        Me.lblVersionLabel.AutoSize = True
        Me.lblVersionLabel.Font = New System.Drawing.Font("Arial Black", 10.0!)
        Me.lblVersionLabel.Location = New System.Drawing.Point(160, 23)
        Me.lblVersionLabel.Name = "lblVersionLabel"
        Me.lblVersionLabel.Size = New System.Drawing.Size(95, 19)
        Me.lblVersionLabel.TabIndex = 19
        Me.lblVersionLabel.Text = "Version 1.0"
        '
        'lblCopyrightLabel
        '
        Me.lblCopyrightLabel.AutoSize = True
        Me.lblCopyrightLabel.Font = New System.Drawing.Font("Arial Black", 10.0!)
        Me.lblCopyrightLabel.Location = New System.Drawing.Point(125, 42)
        Me.lblCopyrightLabel.Name = "lblCopyrightLabel"
        Me.lblCopyrightLabel.Size = New System.Drawing.Size(159, 19)
        Me.lblCopyrightLabel.TabIndex = 20
        Me.lblCopyrightLabel.Text = "(C) 2007 Alan Bryan"
        '
        'txtAccessFileName
        '
        Me.txtAccessFileName.Location = New System.Drawing.Point(177, 136)
        Me.txtAccessFileName.Name = "txtAccessFileName"
        Me.txtAccessFileName.Size = New System.Drawing.Size(130, 20)
        Me.txtAccessFileName.TabIndex = 21
        Me.txtAccessFileName.Visible = False
        '
        'lblAccessFileNameLabel
        '
        Me.lblAccessFileNameLabel.AutoSize = True
        Me.lblAccessFileNameLabel.Location = New System.Drawing.Point(76, 139)
        Me.lblAccessFileNameLabel.Name = "lblAccessFileNameLabel"
        Me.lblAccessFileNameLabel.Size = New System.Drawing.Size(95, 13)
        Me.lblAccessFileNameLabel.TabIndex = 22
        Me.lblAccessFileNameLabel.Text = "Access File Name:"
        Me.lblAccessFileNameLabel.Visible = False
        '
        'btnAccessBrowse
        '
        Me.btnAccessBrowse.Location = New System.Drawing.Point(313, 135)
        Me.btnAccessBrowse.Name = "btnAccessBrowse"
        Me.btnAccessBrowse.Size = New System.Drawing.Size(24, 21)
        Me.btnAccessBrowse.TabIndex = 23
        Me.btnAccessBrowse.Text = "..."
        Me.btnAccessBrowse.UseVisualStyleBackColor = True
        Me.btnAccessBrowse.Visible = False
        '
        'ofdAccessDatabase
        '
        Me.ofdAccessDatabase.DefaultExt = "mdb"
        Me.ofdAccessDatabase.Filter = "Microsoft Access Files|*.mdb|All Files|*.*"
        Me.ofdAccessDatabase.Title = "Select Access Database"
        '
        'gbAuthenticationType
        '
        Me.gbAuthenticationType.Controls.Add(Me.rbWindowsAuthentication)
        Me.gbAuthenticationType.Controls.Add(Me.rbSQLServer)
        Me.gbAuthenticationType.Location = New System.Drawing.Point(96, 223)
        Me.gbAuthenticationType.Name = "gbAuthenticationType"
        Me.gbAuthenticationType.Size = New System.Drawing.Size(241, 52)
        Me.gbAuthenticationType.TabIndex = 24
        Me.gbAuthenticationType.TabStop = False
        Me.gbAuthenticationType.Text = "Authentication Type"
        '
        'rbSQLServer
        '
        Me.rbSQLServer.AutoSize = True
        Me.rbSQLServer.Checked = True
        Me.rbSQLServer.Location = New System.Drawing.Point(7, 20)
        Me.rbSQLServer.Name = "rbSQLServer"
        Me.rbSQLServer.Size = New System.Drawing.Size(80, 17)
        Me.rbSQLServer.TabIndex = 0
        Me.rbSQLServer.TabStop = True
        Me.rbSQLServer.Text = "SQL Server"
        Me.rbSQLServer.UseVisualStyleBackColor = True
        '
        'rbWindowsAuthentication
        '
        Me.rbWindowsAuthentication.AutoSize = True
        Me.rbWindowsAuthentication.Location = New System.Drawing.Point(93, 20)
        Me.rbWindowsAuthentication.Name = "rbWindowsAuthentication"
        Me.rbWindowsAuthentication.Size = New System.Drawing.Size(140, 17)
        Me.rbWindowsAuthentication.TabIndex = 1
        Me.rbWindowsAuthentication.Text = "Windows Authentication"
        Me.rbWindowsAuthentication.UseVisualStyleBackColor = True
        '
        'MainForm
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(408, 406)
        Me.Controls.Add(Me.gbAuthenticationType)
        Me.Controls.Add(Me.btnAccessBrowse)
        Me.Controls.Add(Me.lblAccessFileNameLabel)
        Me.Controls.Add(Me.txtAccessFileName)
        Me.Controls.Add(Me.lblCopyrightLabel)
        Me.Controls.Add(Me.lblVersionLabel)
        Me.Controls.Add(Me.lblAppNameLabel)
        Me.Controls.Add(Me.btnAdvancedOptions)
        Me.Controls.Add(Me.txtSQLDatabaseName)
        Me.Controls.Add(Me.lblSQLDatabaseNameLabel)
        Me.Controls.Add(Me.btnExit)
        Me.Controls.Add(Me.btnCreateLayers)
        Me.Controls.Add(Me.btnBrowse)
        Me.Controls.Add(Me.txtDestination)
        Me.Controls.Add(Me.lblDestinationLabel)
        Me.Controls.Add(Me.cboLanguage)
        Me.Controls.Add(Me.lblLanguageLabel)
        Me.Controls.Add(Me.txtSQLPassword)
        Me.Controls.Add(Me.lblSQLPasswordLabel)
        Me.Controls.Add(Me.txtSQLUserName)
        Me.Controls.Add(Me.lblSQLUserName)
        Me.Controls.Add(Me.cboSQLServerType)
        Me.Controls.Add(Me.lblSQLServerTypeLabel)
        Me.Controls.Add(Me.txtSQLServerName)
        Me.Controls.Add(Me.lblSQLServerNameLabel)
        Me.DoubleBuffered = True
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Fixed3D
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MaximizeBox = False
        Me.Name = "MainForm"
        Me.Text = "Layer Generator"
        Me.gbAuthenticationType.ResumeLayout(False)
        Me.gbAuthenticationType.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents lblSQLServerNameLabel As System.Windows.Forms.Label
    Friend WithEvents txtSQLServerName As System.Windows.Forms.TextBox
    Friend WithEvents lblSQLServerTypeLabel As System.Windows.Forms.Label
    Friend WithEvents cboSQLServerType As System.Windows.Forms.ComboBox
    Friend WithEvents lblSQLUserName As System.Windows.Forms.Label
    Friend WithEvents txtSQLUserName As System.Windows.Forms.TextBox
    Friend WithEvents lblSQLPasswordLabel As System.Windows.Forms.Label
    Friend WithEvents txtSQLPassword As System.Windows.Forms.TextBox
    Friend WithEvents lblLanguageLabel As System.Windows.Forms.Label
    Friend WithEvents cboLanguage As System.Windows.Forms.ComboBox
    Friend WithEvents fbdDestination As System.Windows.Forms.FolderBrowserDialog
    Friend WithEvents lblDestinationLabel As System.Windows.Forms.Label
    Friend WithEvents txtDestination As System.Windows.Forms.TextBox
    Friend WithEvents btnBrowse As System.Windows.Forms.Button
    Friend WithEvents btnCreateLayers As System.Windows.Forms.Button
    Friend WithEvents btnExit As System.Windows.Forms.Button
    Friend WithEvents lblSQLDatabaseNameLabel As System.Windows.Forms.Label
    Friend WithEvents txtSQLDatabaseName As System.Windows.Forms.TextBox
    Friend WithEvents ToolTipTimer As System.Windows.Forms.Timer
    Friend WithEvents btnAdvancedOptions As System.Windows.Forms.Button
    Friend WithEvents lblAppNameLabel As System.Windows.Forms.Label
    Friend WithEvents lblVersionLabel As System.Windows.Forms.Label
    Friend WithEvents lblCopyrightLabel As System.Windows.Forms.Label
    Friend WithEvents txtAccessFileName As System.Windows.Forms.TextBox
    Friend WithEvents lblAccessFileNameLabel As System.Windows.Forms.Label
    Friend WithEvents btnAccessBrowse As System.Windows.Forms.Button
    Friend WithEvents ofdAccessDatabase As System.Windows.Forms.OpenFileDialog
    Friend WithEvents gbAuthenticationType As System.Windows.Forms.GroupBox
    Friend WithEvents rbWindowsAuthentication As System.Windows.Forms.RadioButton
    Friend WithEvents rbSQLServer As System.Windows.Forms.RadioButton

End Class
