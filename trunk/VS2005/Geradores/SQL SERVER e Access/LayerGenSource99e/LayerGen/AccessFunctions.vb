Public Class AccessFunctions
    Implements SQLImplementation
    Private SqlConnection As Data.OleDb.OleDbConnection
    Private m_isConnected As Boolean
    Private m_SQLServerName As String
    Private m_SQLDatabaseName As String
    Private m_SQLUsername As String
    Private m_sqlPassword As String
    Private m_DoEncryption As Boolean
    Private m_EncryptionKey As String
    Private Outputfile As IO.TextWriter
    Private m_Version As String
    Private m_SupressComments As Boolean
    Private m_AccessFileName As String
    Private m_AuthenticationType As SQLImplementation.AuthenticationTypes

    Public Property AuthenticationType() As SQLImplementation.AuthenticationTypes Implements SQLImplementation.AuthenticationType
        Get
            Return m_AuthenticationType
        End Get
        Set(ByVal value As SQLImplementation.AuthenticationTypes)
            m_AuthenticationType = value
        End Set
    End Property

    Public Property AccessFileName() As String Implements SQLImplementation.AccessFileName
        Get
            Return m_AccessFileName
        End Get
        Set(ByVal value As String)
            m_AccessFileName = value
        End Set
    End Property

    Public Property SupressComments() As Boolean Implements SQLImplementation.SupressComments
        Get
            Return m_SupressComments
        End Get
        Set(ByVal value As Boolean)
            m_SupressComments = value
        End Set
    End Property

    Public Property Version() As String Implements SQLImplementation.Version
        Get
            Return m_Version
        End Get
        Set(ByVal value As String)
            m_Version = value
        End Set
    End Property

    Public Property DoEncryption() As Boolean Implements SQLImplementation.DoEncryption
        Get
            Return m_DoEncryption
        End Get
        Set(ByVal value As Boolean)
            m_DoEncryption = value
        End Set
    End Property

    Public Property EncryptionKey() As String Implements SQLImplementation.EncryptionKey
        Get
            Return m_EncryptionKey
        End Get
        Set(ByVal value As String)
            m_EncryptionKey = value
        End Set
    End Property

    Public Property TheOutputFile() As IO.TextWriter Implements SQLImplementation.TheOutputFile
        Get
            Return Outputfile
        End Get
        Set(ByVal value As IO.TextWriter)
            Outputfile = value
        End Set
    End Property

    Public ReadOnly Property IsConnected() Implements SQLImplementation.IsConnected
        Get
            Return m_isConnected
        End Get
    End Property

    Public Sub SQLConnect(ByVal SQLServerName As String, ByVal SQLAccessDatabaseName As String, ByVal SQLUserName As String, ByVal SQLPassword As String) Implements SQLImplementation.SQLConnect
        Dim SqlConnectionString As String

        m_SQLServerName = SQLServerName
        Me.AccessFileName = SQLAccessDatabaseName
        SqlConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + SQLAccessDatabaseName + ";User Id=admin;Password=;"
        SqlConnection = New Data.OleDb.OleDbConnection(SqlConnectionString)
        Try
            SqlConnection.Open()
            m_isConnected = True
        Catch ex As Exception
            m_isConnected = False
            MiscFunctions.DisplayError("Could not connect to the Access Database. Check your settings and try again")
            MiscFunctions.DisplayError(ex.Message)
            MiscFunctions.DisplayError(SqlConnectionString)
        End Try
    End Sub

    Public Sub SQLClose() Implements SQLImplementation.SQLClose
        If SqlConnection Is Nothing Then Return
        SqlConnection.Close()
    End Sub

    Public Function IsView(ByVal TableName As String) As Boolean Implements SQLImplementation.IsView
        Dim dt As DataTable = GetTables()

        For Each row As DataRow In dt.Rows
            If CStr(row("TABLE_NAME")).ToUpper.Trim = TableName.Trim.ToUpper Then
                If CStr(row("TABLE_TYPE")).ToUpper.Trim = "VIEW" Then
                    Return True
                Else
                    Return False
                End If
            End If
        Next

        Return False
    End Function

    Public Function GetAccessDataType(ByVal DataType As Integer) As String
        Select Case DataType
            Case 3
                Return "int"
            Case 20
                Return "bigint"
            Case 4, 5
                Return "float"
            Case 7, 133, 135
                Return "datetime"
            Case 11
                Return "bit"
            Case 2
                Return "smallint"
            Case 6
                Return "money"
            Case 8, 130, 202, 203
                Return "nchar"
            Case 14, 131, 139
                Return "decimal"
            Case 72
                Return "guid"
            Case 129, 200, 201
                Return "char"
            Case 205, 128, 204
                Return "binary"
        End Select

        Return "unknown"
    End Function

    Public Function GetFields(ByVal TableName As String) As Data.DataTable Implements SQLImplementation.GetFields
        Dim dt As New DataTable
        Dim dt2 As New DataTable
        Dim ndx As Integer
        Dim dt3 As New DataTable

        dt2.Columns.Add("TABLE_NAME")
        dt2.Columns.Add("COLUMN_NAME")
        dt2.Columns.Add("TYPE_NAME")
        dt2.Columns.Add("PRECISION")
        dt2.Columns.Add("LENGTH")
        dt2.Columns.Add("LOCATION")

        dt3.Columns.Add("TABLE_NAME")
        dt3.Columns.Add("COLUMN_NAME")
        dt3.Columns.Add("TYPE_NAME")
        dt3.Columns.Add("PRECISION")
        dt3.Columns.Add("LENGTH")
        dt3.Columns.Add("LOCATION")

        dt = SqlConnection.GetOleDbSchemaTable(OleDb.OleDbSchemaGuid.Columns, New Object() {Nothing, Nothing, TableName, Nothing})

        For Each row As DataRow In dt.Rows
            Dim r As DataRow = dt2.NewRow

            r("TABLE_NAME") = TableName
            r("COLUMN_NAME") = row("COLUMN_NAME")
            r("TYPE_NAME") = GetAccessDataType(row("DATA_TYPE"))
            r("PRECISION") = row("NUMERIC_PRECISION")
            r("LENGTH") = row("CHARACTER_MAXIMUM_LENGTH")
            r("LOCATION") = row("ORDINAL_POSITION")

            If GetAccessDataType(row("DATA_TYPE")) = "int" Then
                r("LENGTH") = 4
            End If
            If GetAccessDataType(row("DATA_TYPE")) = "bigint" Or _
               GetAccessDataType(row("DATA_TYPE")) = "float" Then
                r("LENGTH") = 8
            End If
            If GetAccessDataType(row("DATA_TYPE")) = "datetime" Then
                r("LENGTH") = 16
            End If
            If GetAccessDataType(row("DATA_TYPE")) = "bit" Then
                r("LENGTH") = 1
            End If
            If GetAccessDataType(row("DATA_TYPE")) = "smallint" Then
                r("LENGTH") = 2
            End If
            dt2.Rows.Add(r)
        Next

        For ndx = 0 To dt2.Rows.Count - 1
            For Each row As DataRow In dt2.Rows
                If CInt(row("LOCATION")) = ndx + 1 Then
                    Dim rr As DataRow

                    rr = dt3.NewRow()
                    rr("LENGTH") = row("LENGTH")
                    rr("LOCATION") = row("LOCATION")
                    rr("TABLE_NAME") = row("TABLE_NAME")
                    rr("COLUMN_NAME") = row("COLUMN_NAME")
                    rr("TYPE_NAME") = row("TYPE_NAME")
                    rr("PRECISION") = row("PRECISION")
                    dt3.Rows.Add(rr)
                End If
            Next
        Next
        Return dt3
    End Function

    Public Function GetPrimaryKey(ByVal TableName As String) As Data.DataTable Implements SQLImplementation.GetPrimaryKey
        Dim dt As New DataTable

        dt = SqlConnection.GetOleDbSchemaTable(OleDb.OleDbSchemaGuid.Primary_Keys, New Object() {Nothing, Nothing, TableName})

        Return dt

    End Function

    Public Function GetForeignKeys(ByVal TableName As String) As Data.DataTable Implements SQLImplementation.GetForeignKeys
        Dim dt As New DataTable
        Dim dt2 As New DataTable

        dt = SqlConnection.GetOleDbSchemaTable(OleDb.OleDbSchemaGuid.Foreign_Keys, New Object() {Nothing, Nothing, Nothing, Nothing})

        dt2.Columns.Add("PKTABLE_NAME")
        dt2.Columns.Add("PKCOLUMN_NAME")
        dt2.Columns.Add("FKTABLE_NAME")
        dt2.Columns.Add("FKCOLUMN_NAME")

        For Each r As DataRow In dt.Rows
            If CStr(r("FK_TABLE_NAME")).ToString = TableName.Trim Then
                Dim rr As DataRow

                rr = dt2.NewRow()
                rr("PKTABLE_NAME") = r("PK_TABLE_NAME")
                rr("PKCOLUMN_NAME") = r("PK_COLUMN_NAME")
                rr("FKTABLE_NAME") = r("FK_TABLE_NAME")
                rr("FKCOLUMN_NAME") = r("FK_COLUMN_NAME")
                dt2.Rows.Add(rr)
            End If
        Next

        Return dt2

    End Function

    Public Function GetTables() As Data.DataTable Implements SQLImplementation.GetTables
        Dim dt As New DataTable
        Dim Finished As Boolean = False

        dt = SqlConnection.GetOleDbSchemaTable(OleDb.OleDbSchemaGuid.Tables, New Object() {Nothing, Nothing, Nothing, "Table"})
        dt.Merge(SqlConnection.GetOleDbSchemaTable(OleDb.OleDbSchemaGuid.Tables, New Object() {Nothing, Nothing, Nothing, "View"}))

        While Finished = False
            Dim tblCount As Integer = dt.Rows.Count
            Dim found As Boolean = False

            For i As Integer = 0 To tblCount - 1
                If CStr(dt.Rows(i)("TABLE_NAME")).StartsWith("sp_", StringComparison.CurrentCultureIgnoreCase) Then
                    dt.Rows.RemoveAt(i)
                    found = True
                    Exit For
                End If
            Next
            If found = True Then
                found = False
            Else
                found = False
                Finished = True
            End If
        End While
        Return dt

    End Function

    Public Function IsIdentityField(ByVal tablename As String, ByVal fieldname As String) As Boolean Implements SQLImplementation.IsIdentityField
        Dim dt As DataTable
        Dim cmd As New OleDb.OleDbCommand
        Dim rdr As OleDb.OleDbDataReader

        cmd.CommandText = "SELECT TOP 1 * FROM " + tablename
        cmd.Connection = SqlConnection
        rdr = cmd.ExecuteReader(CommandBehavior.SchemaOnly Or CommandBehavior.KeyInfo)
        dt = rdr.GetSchemaTable

        For Each r As DataRow In dt.Rows
            If CStr(r("ColumnName")).ToLower() = fieldname.ToLower Then
                If CBool(r("IsAutoIncrement")) Then
                    Return True
                End If
            End If
        Next
        Return False
    End Function

    Public Function IsIdentityTable(ByVal tablename As String) As Boolean Implements SQLImplementation.IsIdentityTable
        Dim dt As DataTable
        Dim cmd As New OleDb.OleDbCommand
        Dim rdr As OleDb.OleDbDataReader

        cmd.CommandText = "SELECT TOP 1 * FROM " + tablename
        cmd.Connection = SqlConnection
        rdr = cmd.ExecuteReader(CommandBehavior.SchemaOnly Or CommandBehavior.KeyInfo)
        dt = rdr.GetSchemaTable

        For Each r As DataRow In dt.Rows
            If CBool(r("IsAutoIncrement")) Then
                Return True
            End If
        Next
        Return False
    End Function

    Public Function IsSystemTable(ByVal TableName As String) As Boolean Implements SQLImplementation.IsSystemTable
        Return False

    End Function

    Protected Sub CreateStoredProcedureSelect(ByVal dt As DataTable, ByVal tn As String, ByVal PrimaryKey As String) Implements SQLImplementation.CreateStoredProcedureSelect
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim dr As DataRow
        Dim varname As String
        Dim sqlText As String = ""

        sqlText = sqlText + "SELECT "
        Outputfile.WriteLine("")
        Outputfile.Write("SELECT ")
        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            varname = dr("COLUMN_NAME")
            If ndx = count Then
                Outputfile.Write(tn + "." + varname)
                sqlText = sqlText + tn + "." + varname
            Else
                Outputfile.Write(tn + "." + varname + ", ")
                sqlText = sqlText + tn + "." + varname + ", "
            End If
        Next
        Outputfile.Write(Outputfile.NewLine)
        sqlText = sqlText + vbCrLf + "FROM " + tn + " "
        Outputfile.WriteLine("FROM " + tn)
        Outputfile.WriteLine("WHERE (((" + tn + "." + PrimaryKey + ")=['" + PrimaryKey + "']));")
        sqlText = sqlText + "WHERE (((" + tn + "." + PrimaryKey + ")=['" + PrimaryKey + "']));"
        Outputfile.WriteLine("")
        CreateProcedure("sp_" + tn + "_Select", sqlText)

    End Sub

    Private Function DeleteProcedure(ByVal ProcName As String)
        Dim cmd As New OleDb.OleDbCommand

        cmd.CommandText = "DROP PROCEDURE " + ProcName
        cmd.Connection = SqlConnection

        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            Return False
        End Try
        Return True
    End Function

    Private Function CreateProcedure(ByVal ProcName As String, ByVal SQLText As String) As Boolean
        DeleteProcedure(ProcName)
        Dim cmd As New OleDb.OleDbCommand

        cmd.CommandText = "CREATE PROC " + ProcName + " AS " + SQLText
        cmd.Connection = SqlConnection

        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            Return False
        End Try
        Return True
    End Function

    Protected Sub CreateStoredProcedureFKs(ByVal dt As DataTable, ByVal tn As String, ByVal PrimaryKey As String) Implements SQLImplementation.CreateStoredProcedureFKs
        Dim FKdt As DataTable
        Dim ndx As Integer = 0
        Dim ndx2 As Integer = 0
        Dim count As Integer = dt.Rows.Count
        Dim dr As DataRow
        Dim SQLText As String = ""
        Dim varname As String

        FKdt = Me.GetForeignKeys(tn)
        If FKdt.Rows.Count = 0 Then Exit Sub
        Outputfile.WriteLine("")
        While (ndx2 < FKdt.Rows.Count)
            Outputfile.Write("SELECT ")
            SQLText = SQLText + "SELECT "
            For ndx = 1 To count
                dr = dt.Rows(ndx - 1)
                varname = dr("COLUMN_NAME")
                If ndx = count Then
                    Outputfile.Write(tn + "." + varname)
                    SQLText = SQLText + tn + "." + varname
                Else
                    Outputfile.Write(tn + "." + varname + ", ")
                    SQLText = SQLText + tn + "." + varname + ", "
                End If
            Next
            SQLText = SQLText + vbCrLf
            Outputfile.Write(Outputfile.NewLine)
            Outputfile.WriteLine("FROM " + tn)
            SQLText = SQLText + "FROM " + tn + " WHERE (((" + FKdt.Rows(ndx2)("PKCOLUMN_NAME") + ")=['" + FKdt.Rows(ndx2)("PKCOLUMN_NAME") + "']));"

            SQLText = SQLText + vbCrLf
            CreateProcedure("sp_" + tn + "_GetBy" + FKdt.Rows(ndx2)("PKCOLUMN_NAME"), SQLText)
            Outputfile.WriteLine("WHERE (((" + FKdt.Rows(ndx2)("PKCOLUMN_NAME") + ")=['" + FKdt.Rows(ndx2)("PKCOLUMN_NAME") + "']));")

            Outputfile.WriteLine("")
            ndx2 = ndx2 + 1
        End While

    End Sub

    Protected Sub CreateStoredProcedureGetAll(ByVal dt As DataTable, ByVal tn As String, ByVal PrimaryKey As String) Implements SQLImplementation.CreateStoredProcedureGetAll
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim dr As DataRow
        Dim varname As String
        Dim sqlText As String = ""

        Outputfile.WriteLine("")
        Outputfile.Write("SELECT ")
        sqlText = sqlText + "SELECT "
        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            varname = dr("COLUMN_NAME")
            If ndx = count Then
                Outputfile.Write(tn + "." + varname)
                sqlText = sqlText + tn + "." + varname
            Else
                Outputfile.Write(tn + "." + varname + ", ")
                sqlText = sqlText + tn + "." + varname + ", "
            End If
        Next
        sqlText = sqlText + vbCrLf + "FROM " + tn
        Outputfile.Write(Outputfile.NewLine)
        Outputfile.WriteLine("FROM " + tn)
        Outputfile.WriteLine("")
        CreateProcedure("sp_" + tn + "_GetAll", sqlText)
    End Sub

    Protected Sub CreateStoredProcedureDelete(ByVal dt As DataTable, ByVal tn As String, ByVal PrimaryKey As String) Implements SQLImplementation.CreateStoredProcedureDelete
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim dr As DataRow
        Dim varname As String
        Dim sqlText As String = ""

        sqlText = "DELETE "
        Outputfile.WriteLine("")
        Outputfile.Write("DELETE ")
        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            varname = dr("COLUMN_NAME")
            If ndx = count Then
                Outputfile.Write(tn + "." + varname)
                sqlText = sqlText + tn + "." + varname
            Else
                Outputfile.Write(tn + "." + varname + ", ")
                sqlText = sqlText + tn + "." + varname + ", "
            End If
        Next
        Outputfile.Write(Outputfile.NewLine)
        Outputfile.WriteLine("FROM " + tn)
        sqlText = sqlText + vbCrLf + "FROM " + tn + vbCrLf + "WHERE (((" + tn + "." + PrimaryKey + ")=['" + PrimaryKey + "']));"
        Outputfile.WriteLine("WHERE (((" + tn + "." + PrimaryKey + ")=['" + PrimaryKey + "']));")
        Outputfile.WriteLine("")
        CreateProcedure("sp_" + tn + "_Delete", sqlText)
    End Sub

    Protected Sub CreateStoredProcedureInsert(ByVal dt As DataTable, ByVal tn As String, ByVal PrimaryKey As String) Implements SQLImplementation.CreateStoredProcedureInsert
        Dim ct As Integer = 0
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim type As String
        Dim varname As String
        Dim dr As DataRow
        Dim sqlText As String = "INSERT INTO " + tn + " ("

        Outputfile.Write("INSERT INTO " + tn + " (")
        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            type = dr("TYPE_NAME")
            varname = dr("COLUMN_NAME")
            If IsIdentityTable(tn) And IsIdentityField(tn, varname) Then
                Continue For
            End If
            If ndx = count Then
                sqlText = sqlText + varname + " )" + vbCrLf
                Outputfile.WriteLine(varname + " )")
            Else
                Outputfile.Write(varname + ", ")
                sqlText = sqlText + varname + ", "
            End If
        Next
        Outputfile.Write("SELECT ")
        sqlText = sqlText + "SELECT "
        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            type = dr("TYPE_NAME")
            varname = dr("COLUMN_NAME")
            If IsIdentityTable(tn) And IsIdentityField(tn, varname) Then
                Continue For
            End If
            If ndx = count Then
                sqlText = sqlText + "['" + varname + "'] AS " + varname + ";"
                Outputfile.WriteLine("['" + varname + "'] AS " + varname + ";")
            Else
                Outputfile.Write("['" + varname + "'] AS " + varname + ", ")
                sqlText = sqlText + "['" + varname + "'] AS " + varname + ", "
            End If
        Next
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        CreateProcedure("sp_" + tn + "_Insert", sqlText)

    End Sub

    Protected Sub CreateStoredProcedureUpdate(ByVal dt As DataTable, ByVal tn As String, ByVal PrimaryKey As String) Implements SQLImplementation.CreateStoredProcedureUpdate
        Dim ct As Integer = 0
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim varname As String
        Dim dr As DataRow
        Dim sqlText As String = "UPDATE " + tn + " SET "

        Outputfile.Write("UPDATE " + tn + " SET ")

        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            varname = dr("COLUMN_NAME")
            If IsIdentityTable(tn) And IsIdentityField(tn, varname) Then
                Continue For
            End If
            If ndx = count Then
                Outputfile.Write(tn + "." + varname + " = ['" + varname + "']")
                Outputfile.Write(Outputfile.NewLine)
                sqlText = sqlText + tn + "." + varname + " = ['" + varname + "']" + vbCrLf
            Else
                Outputfile.Write(tn + "." + varname + " = ['" + varname + "'], ")
                sqlText = sqlText + tn + "." + varname + " = ['" + varname + "'], "
            End If
        Next
        Outputfile.WriteLine("WHERE (((" + tn + "." + PrimaryKey + ")=['" + PrimaryKey + "']));")
        sqlText = sqlText + "WHERE (((" + tn + "." + PrimaryKey + ")=['" + PrimaryKey + "']));"
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        CreateProcedure("sp_" + tn + "_Update", sqlText)
    End Sub

    Public Sub New()
        m_isConnected = False
        SqlConnection = Nothing
    End Sub

    Public Sub AutoInsertProcedures(ByVal proc As String) Implements SQLImplementation.AutoInsertProcedures
        ' This function really isn't necessary since we are automatically
        ' inserting the procedures into Access anyway. It is here just to
        ' make the VB.NET compiler happy and to complete our interface
        ' implementation
    End Sub
End Class
