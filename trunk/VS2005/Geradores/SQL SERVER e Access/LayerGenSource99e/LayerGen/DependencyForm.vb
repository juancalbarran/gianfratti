Public Class DependencyForm

    Dim CheckListBox As CheckedListBox
    Dim SQLObject As SQLImplementation
    Dim TheTables As System.Data.DataTable
    Dim ResultTables As System.Data.DataTable
    Dim Tables As New Collections.ArrayList
    Dim DepString As String
    Dim TableString As String

    Public Sub AddTableName(ByVal str As String)
        Tables.Add(str)
    End Sub

    Public Sub New()

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        Me.Tables.Clear()
        TableString = ""
    End Sub

    Public Property TheSQLObject() As SQLImplementation
        Get
            Return SQLObject
        End Get
        Set(ByVal value As SQLImplementation)
            SQLObject = value
        End Set
    End Property

    Public Property TheCheckListBox() As CheckedListBox
        Get
            Return CheckListBox
        End Get
        Set(ByVal value As CheckedListBox)
            CheckListBox = value
        End Set
    End Property

    Private Function GetDepTable(ByVal TableName As String) As String
        Dim tb As New System.Data.DataTable
        Dim ndx As Integer
        Dim dr As DataRow
        Dim ds As String

        ds = ""

        tb = SQLObject.GetForeignKeys(TableName)
        If tb.Rows.Count > 0 Then
            ndx = 0
            While (ndx < tb.Rows.Count)
                dr = tb.Rows(ndx)
                ds = ds + dr("PKTABLE_NAME") + " "
                ndx = ndx + 1
            End While
        End If
        Return ds
    End Function

    Private Function IsDepTable(ByVal tablename As String) As Boolean
        Dim tb As New System.Data.DataTable
        Dim ndx As Integer
        Dim dr As DataRow
        Dim ds As String

        ds = ""

        tb = SQLObject.GetForeignKeys(tablename)
        If tb.Rows.Count > 0 Then
            ndx = 0
            While (ndx < tb.Rows.Count)
                dr = tb.Rows(ndx)
                ds = ds + dr("PKTABLE_NAME") + " "
                ndx = ndx + 1
            End While
        End If
        If ds.Trim = "" Then Return False
        Return True
    End Function

    Private Sub DependencyForm_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        DepString = ""
        TableString = ""
        Dim c As New ERDControl()

        For Each str As String In Me.Tables
            If IsDepTable(str) Then
                TableString = TableString + str.Trim() + ChrW(10) + GetDepTable(str).Trim() + ChrW(13)
                DepString = DepString + str + " --> " + GetDepTable(str) + ChrW(13)
                'c.InsertTable(str)
                'c.InsertTable(GetDepTab
            End If
        Next
        'strTables = TableString.Split(ChrW(13))
        'For Each s As String In strTables

        'Next
        'Dim c As New TableControl()
        'c.Top = 100
        'c.Left = 100
        'c.TableName = "str"
        'Me.Controls.Add(c)
        'Dim c As New ERDControl()
        c.Top = 100
        c.Left = 100
        c.Width = 500
        c.Height = 500
        c.InsertTable("Alan Bryan")
        c.InsertTable("Jim")
        c.InsertRelationship("Alan Bryan", "Jim")
        Me.Controls.Add(c)
        'MessageBox.Show(DepString)
    End Sub
End Class