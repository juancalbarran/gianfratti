Public Class TableSelector

    Dim TheTables As System.Data.DataTable
    Dim ResultTables As System.Data.DataTable
    Dim SQLObject As SQLImplementation
    Dim IsCancelled As Boolean
    Dim m_Counter As Integer

    Public ReadOnly Property Counter() As Integer
        Get
            Return m_Counter
        End Get
    End Property

    Public ReadOnly Property WasCancelled() As Boolean
        Get
            Return IsCancelled
        End Get
    End Property

    Public Property TheSQLObject() As SQLImplementation
        Get
            Return SQLObject
        End Get
        Set(ByVal value As SQLImplementation)
            SQLObject = value
        End Set
    End Property

    Public Property TheTableCollection() As System.Data.DataTable
        Get
            Return TheTables
        End Get
        Set(ByVal value As System.Data.DataTable)
            TheTables = value
            ResultTables = value
        End Set
    End Property

    Public ReadOnly Property ResultCollection() As System.Data.DataTable
        Get
            Return ResultTables
        End Get
    End Property

    Private Sub TableSelector_FormClosed(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles Me.FormClosed
        IsCancelled = True
    End Sub

    Private Sub TableSelector_Shown(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Shown
        Dim chkbox As String
        Dim ndx As Integer

        ndx = 0
        For Each r As Data.DataRow In TheTables.Rows
            If SQLObject.IsSystemTable(r("TABLE_NAME")) Then
                Continue For
            End If
            chkbox = r("TABLE_NAME")
            Me.clbTables.Items.Add(chkbox)
            Me.clbTables.SetItemCheckState(ndx, CheckState.Checked)
            ndx = ndx + 1
        Next
        IsCancelled = False
    End Sub

    Private Sub btnSelectAll_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSelectAll.Click
        Dim ndx As Integer

        For ndx = 1 To clbTables.Items.Count
            clbTables.SetItemCheckState(ndx - 1, CheckState.Checked)
        Next
    End Sub

    Private Sub btnUnselectAll_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnUnselectAll.Click
        Dim ndx As Integer

        For ndx = 1 To clbTables.Items.Count
            clbTables.SetItemCheckState(ndx - 1, CheckState.Unchecked)
        Next
    End Sub

    Private Sub btnOk_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnOk.Click
        Dim counter As Integer
        Dim str As String
        Dim j As Integer = 0

        For counter = 1 To clbTables.Items.Count
            str = CStr(clbTables.Items.Item(counter - 1))
            If SQLObject.IsSystemTable(str) Then Continue For
            If clbTables.GetItemChecked(counter - 1) Then j = j + 1 : Continue For
            For Each r As Data.DataRow In ResultTables.Rows
                If r("TABLE_NAME") = str Then ResultTables.Rows.Remove(r) : Exit For
            Next
        Next
        m_Counter = j
        Me.Hide()
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Me.IsCancelled = True
        Me.Hide()
    End Sub

    Private Sub btnDependencies_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDependencies.Click
        Dim Dep As New DependencyForm
        Dim counter As Integer
        Dim str As String

        For counter = 1 To clbTables.Items.Count
            str = CStr(clbTables.Items.Item(counter - 1))
            If SQLObject.IsSystemTable(str) Then Continue For
            If clbTables.GetItemChecked(counter - 1) Then Dep.AddTableName(str)
        Next

        Dep.TheSQLObject = Me.SQLObject
        Dep.TheCheckListBox = Me.clbTables
        Dep.ShowDialog()

    End Sub

    Private Sub btnSelectDependents_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSelectDependents.Click
        Dim DepTables As New LinkedList(Of DepTable)
        Dim dt As DepTable
        Dim ndx As Integer
        Dim TableToAdd As String = ""

        dt = New DepTable(Me.SQLObject)
        For ndx = 0 To clbTables.Items.Count - 1
            If Not clbTables.GetItemChecked(ndx) Then
                Continue For
            End If
            dt = New DepTable(Me.SQLObject)
            dt.TableName = CStr(clbTables.Items(ndx))
            dt.Scan()
            DepTables.AddLast(dt)
        Next

        Do
            TableToAdd = ""
            For Each dep As DepTable In DepTables
                If Not dep.Scanned Then
                    dep.Scan()
                End If

                For Each str As String In dep.Dependants
                    If Not LocateString(DepTables, str) Then
                        TableToAdd = str
                        Exit For
                    End If
                Next
                If TableToAdd <> "" Then Exit For
            Next

            If TableToAdd <> "" Then
                Dim dd As New DepTable(Me.SQLObject)

                dd.TableName = TableToAdd
                dd.Scan()
                DepTables.AddLast(dd)
            End If
        Loop While TableToAdd <> ""

        For ndx = 1 To clbTables.Items.Count
            clbTables.SetItemCheckState(ndx - 1, CheckState.Unchecked)
        Next

        For Each dep As DepTable In DepTables
            For ndx = 0 To clbTables.Items.Count - 1
                If CStr(clbTables.Items(ndx)) = dep.TableName Then
                    Me.clbTables.SetItemCheckState(ndx, CheckState.Checked)
                End If
            Next
        Next

        MessageBox.Show("Dependant tables have been selected for you", "Dependencies", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
    End Sub

    Private Function LocateString(ByVal deptables As LinkedList(Of DepTable), ByVal str As String) As Boolean
        Dim found As Boolean = False

        For Each dep As DepTable In deptables
            If dep.TableName = str Then
                found = True
                Exit For
            End If
        Next

        Return found
    End Function

    Private Class DepTable
        Private m_tablename As String
        Private m_scanned As Boolean
        Private m_dependants As New LinkedList(Of String)
        Private SQLObject As SQLImplementation

        Sub New(ByVal sql As SQLImplementation)
            m_scanned = False
            m_tablename = ""
            SQLObject = sql
        End Sub

        Public Property TheSQLObject() As SQLImplementation
            Get
                Return SQLObject
            End Get
            Set(ByVal value As SQLImplementation)
                SQLObject = value
            End Set
        End Property

        Public Property TableName() As String
            Get
                Return m_tablename
            End Get
            Set(ByVal value As String)
                m_tablename = value
            End Set
        End Property

        Public ReadOnly Property Scanned() As Boolean
            Get
                Return m_scanned
            End Get
        End Property

        Public ReadOnly Property Dependants() As LinkedList(Of String)
            Get
                Return m_dependants
            End Get
        End Property

        Public Sub Scan()
            Dim tb As New System.Data.DataTable

            tb = SQLObject.GetForeignKeys(m_tablename)
            For Each dr As DataRow In tb.Rows
                m_dependants.AddLast(CStr(dr("PKTABLE_NAME")))
            Next

            m_scanned = True
        End Sub
    End Class
End Class

