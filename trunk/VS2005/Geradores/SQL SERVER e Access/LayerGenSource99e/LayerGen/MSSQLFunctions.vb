Public Class MSSQLFunctions
    Implements SQLImplementation

    Private SqlConnection As Data.SqlClient.SqlConnection
    Private m_isConnected As Boolean
    Private m_SQLServerName As String
    Private m_SQLDatabaseName As String
    Private m_SQLUsername As String
    Private m_SQLPassword As String
    Private m_DoEncryption As Boolean
    Private m_EncryptionKey As String
    Private Outputfile As IO.TextWriter
    Private m_Version As String
    Private m_SupressComments As Boolean
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
            Return ""
        End Get
        Set(ByVal value As String)

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

    Public Sub SQLConnect(ByVal SQLServerName As String, ByVal SQLDatabaseName As String, ByVal SQLUserName As String, ByVal SQLPassword As String) Implements SQLImplementation.SQLConnect
        If m_AuthenticationType = SQLImplementation.AuthenticationTypes.SQLServerAuthentication Then
            Dim SqlConnectionString As String

            m_SQLServerName = SQLServerName
            m_SQLDatabaseName = SQLDatabaseName
            m_SQLUsername = SQLUserName
            m_SQLPassword = SQLPassword

            SqlConnectionString = "server=" + SQLServerName.Trim() + ";database=" + SQLDatabaseName.Trim() + ";UID=" + SQLUserName.Trim() + ";Password=" + Chr(34) + SQLPassword.Trim() + Chr(34) + ";"
            SqlConnection = New Data.SqlClient.SqlConnection(SqlConnectionString)
            Try
                SqlConnection.Open()
                m_isConnected = True
            Catch ex As Exception
                m_isConnected = False
                MiscFunctions.DisplayError("Could not connect to the SQL Server. Check your settings and try again")
                MiscFunctions.DisplayError(ex.Message)
                MiscFunctions.DisplayError(SqlConnectionString)
            End Try
        Else
            Dim SqlConnectionString As String

            SqlConnectionString = "server=" + SQLServerName.Trim() + ";database=" + SQLDatabaseName.Trim() + ";Trusted_Connection=Yes;"
            SqlConnection = New Data.SqlClient.SqlConnection(SqlConnectionString)
            Try
                SqlConnection.Open()
                m_isConnected = True
            Catch ex As Exception
                m_isConnected = False
                MiscFunctions.DisplayError("Could not connect to the SQL Server. Check your settings and try again")
                MiscFunctions.DisplayError(ex.Message)
                MiscFunctions.DisplayError(SqlConnectionString)
            End Try
        End If
    End Sub

    Public Sub SQLClose() Implements SQLImplementation.SQLClose
        If SqlConnection Is Nothing Then Return
        SqlConnection.Close()
    End Sub

    Public Function IsView(ByVal TableName As String) As Boolean Implements SQLImplementation.IsView
        Dim command As New SqlClient.SqlCommand
        Dim adapter As SqlClient.SqlDataAdapter
        Dim dt As DataTable = Nothing
        Dim ds As DataSet = New DataSet()

        command.CommandType = CommandType.StoredProcedure
        command.Connection = SqlConnection
        command.CommandText = "sp_tables"
        command.Parameters.Add("@table_qualifier", SqlDbType.NVarChar)
        command.Parameters.Add("@table_owner", SqlDbType.NVarChar)
        'command.Parameters.Add("@table_type", SqlDbType.NVarChar)
        command.Parameters.Add("@table_name", SqlDbType.NVarChar)

        command.Parameters("@table_qualifier").Value = m_SQLDatabaseName
        command.Parameters("@table_owner").Value = "dbo"
        command.Parameters("@table_name").Value = TableName
        'command.Parameters("@table_type").Value = "VIEW"

        adapter = New SqlClient.SqlDataAdapter()
        adapter.SelectCommand = command
        adapter.Fill(ds)

        dt = ds.Tables(0)

        Try
            Return CBool(CStr(dt.Rows(0)("TABLE_TYPE")) = "VIEW")
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Function GetFields(ByVal TableName As String) As Data.DataTable Implements SQLImplementation.GetFields
        Dim command As New SqlClient.SqlCommand
        Dim adapter As SqlClient.SqlDataAdapter
        Dim dt As DataTable = Nothing
        Dim ds As DataSet = New DataSet()

        command.CommandType = CommandType.StoredProcedure
        command.Connection = SqlConnection
        command.CommandText = "sp_columns"
        command.Parameters.Add("@table_name", SqlDbType.NVarChar)
        command.Parameters("@table_name").Value = TableName

        adapter = New SqlClient.SqlDataAdapter()
        adapter.SelectCommand = command
        adapter.Fill(ds)
        Return ds.Tables(0)
    End Function

    Public Function GetPrimaryKey(ByVal TableName As String) As Data.DataTable Implements SQLImplementation.GetPrimaryKey
        Dim command As New SqlClient.SqlCommand
        Dim adapter As SqlClient.SqlDataAdapter
        Dim dt As DataTable = Nothing
        Dim ds As DataSet = New DataSet()

        command.CommandType = CommandType.StoredProcedure
        command.Connection = SqlConnection
        command.CommandText = "sp_pkeys"
        command.Parameters.Add("@table_name", SqlDbType.NVarChar)
        command.Parameters("@table_name").Value = TableName

        adapter = New SqlClient.SqlDataAdapter()
        adapter.SelectCommand = command
        adapter.Fill(ds)
        Return ds.Tables(0)
    End Function

    Public Function GetForeignKeys(ByVal TableName As String) As Data.DataTable Implements SQLImplementation.GetForeignKeys
        Dim command As New SqlClient.SqlCommand
        Dim adapter As SqlClient.SqlDataAdapter
        Dim dt As DataTable = Nothing
        Dim ds As DataSet = New DataSet()

        command.CommandType = CommandType.StoredProcedure
        command.Connection = SqlConnection
        command.CommandText = "sp_fkeys"
        command.Parameters.Add("@fktable_name", SqlDbType.NVarChar)
        command.Parameters("@fktable_name").Value = TableName

        adapter = New SqlClient.SqlDataAdapter()
        adapter.SelectCommand = command
        adapter.Fill(ds)
        Return ds.Tables(0)
    End Function

    Public Function GetTables() As Data.DataTable Implements SQLImplementation.GetTables
        Dim command As New SqlClient.SqlCommand
        Dim adapter As SqlClient.SqlDataAdapter
        Dim dt As DataTable = Nothing
        Dim ds As DataSet = New DataSet()

        command.CommandType = CommandType.StoredProcedure
        command.Connection = SqlConnection
        command.CommandText = "sp_tables"
        command.Parameters.Add("@table_qualifier", SqlDbType.NVarChar)
        command.Parameters.Add("@table_owner", SqlDbType.NVarChar)

        command.Parameters("@table_qualifier").Value = m_SQLDatabaseName
        command.Parameters("@table_owner").Value = "dbo"

        adapter = New SqlClient.SqlDataAdapter()
        adapter.SelectCommand = command
        adapter.Fill(ds)

        Return ds.Tables(0)
    End Function

    Public Function IsIdentityField(ByVal tablename As String, ByVal fieldname As String) As Boolean Implements SQLImplementation.IsIdentityField
        Dim dt As DataTable
        Dim Identity As Boolean = False

        dt = Me.GetFields(tablename)
        For Each r As DataRow In dt.Rows
            If CStr(r("COLUMN_NAME")).ToLower = fieldname.ToLower Then
                If CStr(r("TYPE_NAME")).EndsWith(" identity") Then
                    Identity = True
                End If
            End If
        Next
        Return Identity
    End Function

    Public Function IsIdentityTable(ByVal tablename As String) As Boolean Implements SQLImplementation.IsIdentityTable
        Dim dt As DataTable
        Dim Identity As Boolean = False

        dt = Me.GetFields(tablename)
        For Each r As DataRow In dt.Rows
            If CStr(r("TYPE_NAME")).EndsWith(" identity") Then
                Identity = True
            End If
        Next
        Return Identity
    End Function

    Public Function IsSystemTable(ByVal TableName As String) As Boolean Implements SQLImplementation.IsSystemTable
        Dim tn As String

        tn = TableName.ToLower().Trim()
        If tn = "sysdiagrams" Or tn = "syscolumns" Or tn = "syscomments" Or tn = "sysdepends" Then
            Return True
        End If

        If tn = "sysfilegroups" Or tn = "sysfiles" Or tn = "sysfiles1" Or tn = "sysfiles2" Then
            Return True
        End If

        If tn = "sysforeignkeys" Or tn = "sysfulltextcatalogs" Or tn = "sysfulltextnotify" Then
            Return True
        End If

        If tn = "sysindexes" Or tn = "sysindexkeys" Or tn = "sysmembers" Or tn = "sysobjects" Then
            Return True
        End If

        If tn = "syspermissions" Or tn = "sysproperties" Or tn = "sysprotects" Or tn = "sysreferences" Then
            Return True
        End If

        If tn = "systypes" Or tn = "sysusers" Or tn = "syssegments" Or tn = "sysconstraints" Or tn = "dtproperties" Then
            Return True
        End If

        Return False
    End Function

    Protected Sub CreateStoredProcedureSelect(ByVal dt As DataTable, ByVal tn As String, ByVal PrimaryKey As String) Implements SQLImplementation.CreateStoredProcedureSelect
        Dim ct As Integer = 0
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim type As String = ""
        Dim varname As String
        Dim dr As DataRow
        Dim length As Integer

        'length = CInt(dr("PRECISION"))
        'If ndx = count Then
        '    Outputfile.Write("@" + varname + " " + type)
        '    If type = "nvarchar" Or type = "varchar" Or type = "nchar" Or type = "char" Then
        '        Outputfile.Write("(" + length.ToString + ")")
        '    Else
        '        Outputfile.Write(Outputfile.NewLine)
        '    End If

        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            If CStr(dr("COLUMN_NAME")).ToLower = PrimaryKey.ToLower Then
                type = dr("TYPE_NAME")
                length = CInt(dr("PRECISION"))
                Exit For
            End If
        Next

        If type = "nvarchar" Or type = "varchar" Or type = "nchar" Or type = "char" Then
            type = type.Replace(" identity", "")
            Outputfile.WriteLine("CREATE    PROCEDURE sp_" + tn + "_Select(@" + PrimaryKey + " " + type + "(" + length.ToString + ")=null) AS")
        Else
            type = type.Replace(" identity", "")
            Outputfile.WriteLine("CREATE    PROCEDURE sp_" + tn + "_Select(@" + PrimaryKey + " " + type + "=null) AS")
        End If
        Outputfile.WriteLine("")
        If Not Me.m_SupressComments Then
            Outputfile.WriteLine("-- This stored procedure was written by LayerGen " + Version())
            Outputfile.WriteLine("-- Created: " + Now().ToShortDateString() + " " + Now().ToShortTimeString())
            Outputfile.WriteLine("")
        End If
        Outputfile.Write("SELECT  ")

        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            type = dr("TYPE_NAME")
            varname = dr("COLUMN_NAME")
            If ndx = count Then Outputfile.Write("[" + varname + "]") Else Outputfile.Write("[" + varname + "], ")
            ct = ct + 1
            If ndx = count Then Exit For
            If ct > 5 Then
                Outputfile.WriteLine("")
                Outputfile.Write("        ")
                ct = 0
            End If
        Next
        Outputfile.WriteLine(" FROM " + tn + " WHERE " + PrimaryKey + "=@" + PrimaryKey)
        Outputfile.WriteLine("")
        Outputfile.WriteLine("SET QUOTED_IDENTIFIER ON")
        Outputfile.WriteLine(" GO ")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")

    End Sub

    Protected Sub CreateStoredProcedureFKs(ByVal dt As DataTable, ByVal tn As String, ByVal PrimaryKey As String) Implements SQLImplementation.CreateStoredProcedureFKs
        Dim FKdt As DataTable
        Dim ndx As Integer = 0
        Dim ndx2 As Integer
        Dim dr2 As DataRow
        Dim count As Integer = dt.Rows.Count
        Dim type As String
        Dim varname As String
        Dim ct As Integer

        FKdt = Me.GetForeignKeys(tn)
        If FKdt.Rows.Count = 0 Then Exit Sub
        While (ndx < FKdt.Rows.Count)
            Dim dr As DataRow
            dr = FKdt.Rows(ndx)
            ct = 0
            
            Outputfile.WriteLine("CREATE    PROCEDURE sp_" + tn + "_GetBy" + dr("PKCOLUMN_NAME") + "(@" + dr("PKCOLUMN_NAME") + " int) AS")
            Outputfile.WriteLine("")
            If Not Me.m_SupressComments Then
                Outputfile.WriteLine("-- This stored procedure was written by LayerGen " + Version())
                Outputfile.WriteLine("-- Created: " + Now().ToShortDateString() + " " + Now().ToShortTimeString())
                Outputfile.WriteLine("")
            End If
            Outputfile.Write("SELECT  ")
            For ndx2 = 1 To count
                dr2 = dt.Rows(ndx2 - 1)
                type = dr2("TYPE_NAME")
                varname = dr2("COLUMN_NAME")
                If ndx2 = count Then Outputfile.Write("[" + varname + "]") Else Outputfile.Write("[" + varname + "], ")
                ct = ct + 1
                If ndx2 = count Then Exit For
                If ct > 5 Then
                    Outputfile.WriteLine("")
                    Outputfile.Write("        ")
                    ct = 0
                End If
            Next
            Outputfile.WriteLine(" FROM " + tn + " WHERE [" + dr("PKCOLUMN_NAME") + "]=@" + dr("PKCOLUMN_NAME"))
            Outputfile.WriteLine("")
            Outputfile.WriteLine("SET QUOTED_IDENTIFIER ON")
            Outputfile.WriteLine(" GO ")
            Outputfile.WriteLine("")
            Outputfile.WriteLine("")
            Outputfile.WriteLine("")
            Outputfile.WriteLine("")
            Outputfile.WriteLine("")

            ndx = ndx + 1
        End While

    End Sub

    Protected Sub CreateStoredProcedureGetAll(ByVal dt As DataTable, ByVal tn As String, ByVal PrimaryKey As String) Implements SQLImplementation.CreateStoredProcedureGetAll
        Dim ct As Integer = 0
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim type As String
        Dim varname As String
        Dim dr As DataRow

       

        Outputfile.WriteLine("CREATE    PROCEDURE sp_" + tn + "_GetAll AS")
        Outputfile.WriteLine("")
        If Not Me.m_SupressComments Then
            Outputfile.WriteLine("-- This stored procedure was written by LayerGen " + Version())
            Outputfile.WriteLine("-- Created: " + Now().ToShortDateString() + " " + Now().ToShortTimeString())
            Outputfile.WriteLine("")
        End If
        Outputfile.Write("SELECT  ")

        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            type = dr("TYPE_NAME")
            varname = dr("COLUMN_NAME")
            If ndx = count Then Outputfile.Write("[" + varname + "]") Else Outputfile.Write("[" + varname + "], ")
            ct = ct + 1
            If ndx = count Then Exit For
            If ct > 5 Then
                Outputfile.WriteLine("")
                Outputfile.Write("        ")
                ct = 0
            End If
        Next
        Outputfile.WriteLine(" FROM " + tn)
        Outputfile.WriteLine("")
        Outputfile.WriteLine("SET QUOTED_IDENTIFIER ON")
        Outputfile.WriteLine(" GO ")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")

    End Sub

    Protected Sub CreateStoredProcedureDelete(ByVal dt As DataTable, ByVal tn As String, ByVal PrimaryKey As String) Implements SQLImplementation.CreateStoredProcedureDelete
        Dim type As String = ""
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim varname As String
        Dim dr As DataRow
        Dim length As Integer

        'length = CInt(dr("PRECISION"))
        'If ndx = count Then
        '    Outputfile.Write("@" + varname + " " + type)
        '    If type = "nvarchar" Or type = "varchar" Or type = "nchar" Or type = "char" Then
        '        Outputfile.Write("(" + length.ToString + ")")
        '    Else
        '        Outputfile.Write(Outputfile.NewLine)
        '    End If
      

        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            varname = dr("COLUMN_NAME")
            If varname.ToLower = PrimaryKey.ToLower Then
                type = dr("TYPE_NAME")
                length = CInt(dr("PRECISION"))
                Exit For
            End If
        Next
        If type = "nvarchar" Or type = "varchar" Or type = "nchar" Or type = "char" Then
            type = type.Replace(" identity", "")
            Outputfile.WriteLine("CREATE    PROCEDURE sp_" + tn + "_Delete(@" + PrimaryKey + " " + type + "(" + length.ToString + ")=null) AS")
        Else
            type = type.Replace(" identity", "")
            Outputfile.WriteLine("CREATE    PROCEDURE sp_" + tn + "_Delete(@" + PrimaryKey + " " + type + "=null) AS")
        End If

        Outputfile.WriteLine("")
        If Not Me.m_SupressComments Then
            Outputfile.WriteLine("-- This stored procedure was written by LayerGen " + Version())
            Outputfile.WriteLine("-- Created: " + Now().ToShortDateString() + " " + Now().ToShortTimeString())
            Outputfile.WriteLine("")
        End If
        Outputfile.WriteLine("SET NOCOUNT ON")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("DELETE FROM " + tn + " WHERE " + PrimaryKey + "=@" + PrimaryKey)
        Outputfile.WriteLine("")
        Outputfile.WriteLine("SET QUOTED_IDENTIFIER ON")
        Outputfile.WriteLine(" GO ")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")

    End Sub

    Protected Sub CreateStoredProcedureInsert(ByVal dt As DataTable, ByVal tn As String, ByVal PrimaryKey As String) Implements SQLImplementation.CreateStoredProcedureInsert
        Dim ct As Integer = 0
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim type As String
        Dim varname As String
        Dim dr As DataRow
        Dim length As Integer

        Outputfile.WriteLine("CREATE    PROCEDURE sp_" + tn + "_Insert")
        Outputfile.WriteLine("(")
        'Outputfile.Write("@" + PrimaryKey + " int OUTPUT, ")

        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            type = dr("TYPE_NAME")
            varname = dr("COLUMN_NAME")
            If dr("COLUMN_NAME") = PrimaryKey Then
                If type.ToLower.EndsWith("identity") Then
                    Outputfile.Write("@" + PrimaryKey + " int OUTPUT, ")
                    Continue For
                End If
            End If
            varname = VBFunctions.VBName(varname)
            ' TODO Change the next line to "length = CInt(dr("LENGTH"))" possibly for SQL Server 2000
            length = CInt(dr("PRECISION"))
            If ndx = count Then
                Outputfile.Write("@" + varname + " " + type)
                If type = "nvarchar" Or type = "varchar" Or type = "nchar" Or type = "char" Then
                    Outputfile.Write("(" + length.ToString + ")")
                Else
                    Outputfile.Write(Outputfile.NewLine)
                End If
            Else
                Outputfile.Write("@" + varname + " " + type)
                If type = "nvarchar" Or type = "varchar" Or type = "nchar" Or type = "char" Then
                    Outputfile.Write("(" + length.ToString + "), ")
                Else
                    Outputfile.Write(", ")
                End If
            End If
            ct = ct + 1
            If ct > 3 Then
                Outputfile.WriteLine("")
                Outputfile.Write("        ")
                ct = 0
            End If
        Next
        Outputfile.WriteLine(")")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("AS")
        Outputfile.WriteLine("")
        If Not Me.m_SupressComments Then
            Outputfile.WriteLine("-- This stored procedure was written by LayerGen " + Version())
            Outputfile.WriteLine("-- Created: " + Now().ToShortDateString() + " " + Now().ToShortTimeString())
            Outputfile.WriteLine("")
        End If
        Outputfile.WriteLine("SET NOCOUNT ON")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("INSERT INTO " + tn)
        Outputfile.Write("(")

        ct = 0
        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            type = dr("TYPE_NAME")
            If type.ToLower.EndsWith("identity") Then Continue For
            type = type.Replace("identity", "")
            varname = "[" + dr("COLUMN_NAME") + "]"
            If ndx = count Then
                Outputfile.Write(varname + ")")
            Else
                Outputfile.Write(varname + ", ")
            End If
            ct = ct + 1
            If ct > 5 Then
                Outputfile.WriteLine("")
                Outputfile.Write("  ")
                ct = 0
            End If
        Next

        Outputfile.WriteLine(" VALUES (")
        ct = 0
        Dim FoundIdentity As Boolean = False
        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            type = dr("TYPE_NAME")
            If type.ToLower.EndsWith("identity") Then FoundIdentity = True : Continue For
            varname = dr("COLUMN_NAME")
            If ndx = count Then
                Outputfile.Write("@" + VBFunctions.VBName((varname)) + ")")
            Else
                Outputfile.Write("@" + VBFunctions.VBName((varname)) + ", ")
            End If
            ct = ct + 1
            If ct > 5 Then
                Outputfile.WriteLine("")
                Outputfile.Write("  ")
                ct = 0
            End If
        Next

        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        If FoundIdentity Then
            Outputfile.WriteLine("SET @" + PrimaryKey + "=@@identity")
        End If
        Outputfile.WriteLine("")
        Outputfile.WriteLine("SET QUOTED_IDENTIFIER ON")
        Outputfile.WriteLine(" GO ")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")

    End Sub

    Protected Sub CreateStoredProcedureUpdate(ByVal dt As DataTable, ByVal tn As String, ByVal PrimaryKey As String) Implements SQLImplementation.CreateStoredProcedureUpdate
        Dim ct As Integer = 0
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim type As String
        Dim varname As String
        Dim dr As DataRow
        Dim length As Integer

        Outputfile.WriteLine("CREATE    PROCEDURE sp_" + tn + "_Update")
        Outputfile.WriteLine("(")

        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            type = dr("TYPE_NAME")
            type = type.Replace("identity", "")
            varname = dr("COLUMN_NAME")
            varname = VBFunctions.VBName(varname)
            ' TODO: Change the next line to "length = CInt(dr("LENGTH"))" for SQL Server 2000 possibly
            length = CInt(dr("PRECISION"))
            If ndx = count Then
                Outputfile.Write("@" + varname + " " + type)
                If type = "nvarchar" Or type = "varchar" Or type = "nchar" Or type = "char" Then
                    Outputfile.Write("(" + length.ToString + ")")
                Else
                    Outputfile.Write(Outputfile.NewLine)
                End If
            Else
                Outputfile.Write("@" + varname + " " + type)
                If type = "nvarchar" Or type = "varchar" Or type = "nchar" Or type = "char" Then
                    Outputfile.Write("(" + length.ToString + "), ")
                Else
                    Outputfile.Write(", ")
                End If
            End If
            ct = ct + 1
            If ct > 3 Then
                Outputfile.WriteLine("")
                Outputfile.Write("        ")
                ct = 0
            End If
        Next
        Outputfile.WriteLine(")")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("AS")
        Outputfile.WriteLine("")
        If Not Me.m_SupressComments Then
            Outputfile.WriteLine("-- This stored procedure was written by LayerGen " + Version())
            Outputfile.WriteLine("-- Created: " + Now().ToShortDateString() + " " + Now().ToShortTimeString())
            Outputfile.WriteLine("")
        End If
        Outputfile.WriteLine("SET NOCOUNT ON")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("UPDATE " + tn)
        Outputfile.Write("SET ")

        ct = 0
        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            type = dr("TYPE_NAME")
            varname = dr("COLUMN_NAME")
            If type.ToLower.EndsWith("identity") Then
                Continue For
            End If
            If ndx = count Then
                Outputfile.Write("[" + varname + "]=@" + VBFunctions.VBName(varname))
            Else
                Outputfile.Write("[" + varname + "]=@" + VBFunctions.VBName(varname) + ", ")
            End If
            ct = ct + 1
            If ct > 5 Then
                Outputfile.WriteLine("")
                Outputfile.Write("  ")
                ct = 0
            End If
        Next

        Outputfile.WriteLine("")
        Outputfile.WriteLine("WHERE " + PrimaryKey + "=@" + PrimaryKey)

        Outputfile.WriteLine("")
        Outputfile.WriteLine("SET QUOTED_IDENTIFIER ON")
        Outputfile.WriteLine(" GO ")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")
        Outputfile.WriteLine("")

    End Sub

    Public Sub New()
        m_isConnected = False
        SqlConnection = Nothing
    End Sub

    Public Sub AutoInsertProcedures(ByVal proc As String) Implements SQLImplementation.AutoInsertProcedures
        Dim command As New SqlClient.SqlCommand
        Dim oldindex As Integer
        Dim index As Integer = 0
        Dim substr As String
        Dim j As Integer = 1

        While True
            index = proc.IndexOf("PROCEDURE ", index)
            If index = -1 Then Exit While
            index = index + 10
            j = 1
            While True
                If Mid(proc, index + j, 1) = Chr(13) Or Mid(proc, index + j, 1) = Chr(10) Or _
                   Mid(proc, index + j, 1) = " " Or Mid(proc, index + j, 1) = "(" Then
                    Exit While
                End If
                j = j + 1
            End While
            Try
                command.CommandText = "DROP PROCEDURE [" + Mid(proc, index, j).Trim + "]" ' + vbCr + "GO"
                command.CommandType = CommandType.Text
                command.Connection = SqlConnection
                command.ExecuteNonQuery()
            Catch ex As Exception
            End Try
            index = index + j
        End While
        'RemoveOldProcedure(Mid(proc, index, j).Trim)
        oldindex = 0
        While True
            index = proc.IndexOf(" GO ", oldindex)
            If index = -1 Then Exit Sub
            substr = proc.Substring(oldindex, index - oldindex)
            If substr = String.Empty Then Exit While
            command.CommandType = CommandType.Text

            command.CommandText = substr
            command.Connection = SqlConnection
            command.ExecuteNonQuery()

            oldindex = index + 4
            If oldindex > proc.Length Then Exit While
        End While
    End Sub
End Class
