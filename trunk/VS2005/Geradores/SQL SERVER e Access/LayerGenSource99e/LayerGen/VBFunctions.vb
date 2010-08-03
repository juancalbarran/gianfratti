Public Class VBFunctions
    Implements LangImplementation

#Region " Member Variables "
    Protected OutputFile As IO.TextWriter
    Protected BusinessNameSpace As String
    Protected DataNameSpace As String
    Protected SQLObject As SQLImplementation
    Private m_SQLServerName As String
    Private m_SQLDatabaseName As String
    Private m_SQLUsername As String
    Private m_sqlPassword As String
    Private m_DoEncryption As Boolean
    Private m_EncryptionKey As String
    Protected m_Version As String
    Protected m_SupressComments As Boolean
    Protected m_IsDatabaseMSSQL As Boolean
    Protected m_AuthenticationType As LangImplementation.AuthenticationTypes
#End Region

#Region " Public Properties "

    Public Property IsDatabaseMSSQL() As Boolean Implements LangImplementation.IsDatabaseMSSQL
        Get
            Return m_IsDatabaseMSSQL
        End Get
        Set(ByVal value As Boolean)
            m_IsDatabaseMSSQL = value
        End Set
    End Property

    Public Property SupressComments() As Boolean Implements LangImplementation.SupressComments
        Get
            Return m_SupressComments
        End Get
        Set(ByVal value As Boolean)
            m_SupressComments = value
        End Set
    End Property

    Public Property Version() As String Implements LangImplementation.Version
        Get
            Return m_Version
        End Get
        Set(ByVal value As String)
            m_Version = value
        End Set
    End Property

    Public Property DoEncryption() As Boolean Implements LangImplementation.DoEncryption
        Get
            Return m_DoEncryption
        End Get
        Set(ByVal value As Boolean)
            m_DoEncryption = value
        End Set
    End Property

    Public Property EncryptionKey() As String Implements LangImplementation.EncryptionKey
        Get
            Return m_EncryptionKey
        End Get
        Set(ByVal value As String)
            m_EncryptionKey = value
        End Set
    End Property

    Public Property TheSQLServerName() As String Implements LangImplementation.TheSQLServerName
        Get
            Return m_SQLServerName
        End Get
        Set(ByVal value As String)
            m_SQLServerName = value
        End Set
    End Property

    Public Property TheSQLDatabaseName() As String Implements LangImplementation.TheSQLDatabaseName
        Get
            Return m_SQLDatabaseName
        End Get
        Set(ByVal value As String)
            m_SQLDatabaseName = value
        End Set
    End Property

    Public Property TheSQLUserName() As String Implements LangImplementation.TheSQLUserName
        Get
            Return m_SQLUsername
        End Get
        Set(ByVal value As String)
            m_SQLUsername = value
        End Set
    End Property

    Public Property TheSQLPassword() As String Implements LangImplementation.TheSQLPassword
        Get
            Return m_sqlPassword
        End Get
        Set(ByVal value As String)
            m_sqlPassword = value
        End Set
    End Property

    Public Property TheSQLObject() As SQLImplementation Implements LangImplementation.TheSQLObject
        Get
            Return SQLObject
        End Get
        Set(ByVal value As SQLImplementation)
            SQLObject = value
        End Set
    End Property

    Public Property TheDataNameSpace() As String Implements LangImplementation.TheDataNameSpace
        Get
            Return DataNameSpace
        End Get
        Set(ByVal value As String)
            DataNameSpace = value
        End Set
    End Property

    Public Property TheBusinessNameSpace() As String Implements LangImplementation.TheBusinessNameSpace
        Get
            Return BusinessNameSpace
        End Get
        Set(ByVal value As String)
            BusinessNameSpace = value
        End Set
    End Property

    Public Property TheOutputFile() As IO.TextWriter Implements LangImplementation.TheOutputFile
        Get
            Return OutputFile
        End Get
        Set(ByVal value As IO.TextWriter)
            OutputFile = value
        End Set
    End Property

    Public Property AuthenticationType() As LangImplementation.AuthenticationTypes Implements LangImplementation.AuthenticationType
        Get
            Return m_AuthenticationType
        End Get
        Set(ByVal value As LangImplementation.AuthenticationTypes)
            m_AuthenticationType = value
        End Set
    End Property
#End Region

    Public Sub CreateBusinessConstructors(ByVal dt As DataTable, ByVal TableName As String, ByVal PrimaryKey As String) Implements LangImplementation.CreateBusinessConstructors
        Dim count As Integer = dt.Rows.Count
        Dim ndx As Integer
        Dim dr As DataRow

        OutputFile.WriteLine("#Region " + Chr(34) + "Constructors" + Chr(34))
        OutputFile.WriteLine()
        OutputFile.WriteLine("' Create a default constructor that simply called the base constructor")
        OutputFile.WriteLine(Chr(9) + "Public Sub New()")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "MyBase.New() ' Call the base constructor")
        OutputFile.WriteLine(Chr(9) + "End Sub")
        OutputFile.WriteLine()
        OutputFile.WriteLine("' This constructor will load a single record, defined by the primary key")
        OutputFile.Write(Chr(9) + "Public Sub New(ByVal intPrimaryKey As ")
        If SQLObject.IsView(TableName) Then
            OutputFile.WriteLine("Int32)")
        Else
            For ndx = 1 To count
                dr = dt.Rows(ndx - 1)
                If CStr(dr("COLUMN_NAME")).ToLower = PrimaryKey.ToLower Or CStr(dr("COLUMN_NAME")).ToLower = PrimaryKey.ToLower + " identity" Then
                    OutputFile.WriteLine(GetSQLType(dr("TYPE_NAME")) + ")")
                    Exit For
                End If
            Next
        End If
        OutputFile.WriteLine(Chr(9) + Chr(9) + "MyBase.New(intPrimaryKey)")
        OutputFile.WriteLine(Chr(9) + "End Sub")
        OutputFile.WriteLine()
        OutputFile.WriteLine("' This constructor will load a single record from a DataRow")
        OutputFile.WriteLine(Chr(9) + "Public Sub New(ByVal dtrRow As DataRow)")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "MyBase.New(dtrRow)")
        OutputFile.WriteLine(Chr(9) + "End Sub")
        OutputFile.WriteLine()
        OutputFile.WriteLine("#End Region")
        OutputFile.WriteLine()
    End Sub

    Public Shared Function VBName(ByVal str As String) As String
        str = str.Replace("#", "num")
        str = str.Replace(" ", "_")
        str = str.Replace("/", "_")
        str = str.Replace("-", "_")

        If str = "date" Then
            str = "date__"
        End If
        If str = "Date" Then
            str = "Date__"
        End If
        If str = "DATE" Then
            str = "DATE__"
        End If
        Return str
    End Function

    Public Shared Function GetProperName(ByVal varname As String) As String
        Dim s As String = ""
        Dim i As Integer
        Dim underscore As Boolean = False

        For i = 1 To Len(varname)
            If Mid(varname, i, 1) = "_" Then
                underscore = True
                Continue For
            End If
            If i = 1 Then s = s + UCase(Mid(varname, i, 1)) : Continue For
            If underscore = True Then
                s = s + "_" + UCase(Mid(varname, i, 1))
                underscore = False
            Else
                s = s + LCase(Mid(varname, i, 1))
            End If
        Next
        Return VBName(s)
    End Function

    Public Sub CreateBusinessGetAll(ByVal TableName As String) Implements LangImplementation.CreateBusinessGetAll
        OutputFile.WriteLine("' Loads all records from the table into the collection")
        OutputFile.WriteLine("         Public Sub GetAll()")
        OutputFile.WriteLine("             Dim dt as DataTable = " + Me.DataNameSpace + "." + TableName + ".GetAll()")
        OutputFile.WriteLine("             If Not (dt Is Nothing) Then")
        OutputFile.WriteLine("                 Me.Load(dt.Rows)")
        OutputFile.WriteLine("             End If")
        OutputFile.WriteLine("         End Sub")
        OutputFile.WriteLine("        ")
    End Sub

    Protected Sub CreateDataCustomQueryMethods(ByVal dt As DataTable, ByVal TableName As String) Implements LangImplementation.CreateDataCustomQueryMethods
        If Me.IsDatabaseMSSQL Then
            OutputFile.WriteLine("#Region " + Chr(34) + "Custom Query Methods" + Chr(34))
            OutputFile.WriteLine("        ' TODO: Add your own custom queries here. To do this, simply")
            OutputFile.WriteLine("        ' create a stored procedure in your database. Then use the")
            OutputFile.WriteLine("        ' sample code below as a guide to calling your stored")
            OutputFile.WriteLine("        ' procedure. Also, make sure you make the appropriate changes")
            OutputFile.WriteLine("        ' in the Business layer to call this function. See the region")
            OutputFile.WriteLine("        ' called " + Chr(34) + "Custom Query Methods" + Chr(34) + " in the business")
            OutputFile.WriteLine("        ' layer code. ")
            OutputFile.WriteLine("        '")
            OutputFile.WriteLine("        ' Public Shared Function GetByFirstName(ByVal FirstName As String) As DataTable")
            OutputFile.WriteLine("        '     Dim storedProcedure As String = " + Chr(34) + "sp_" + TableName + "_Custom" + Chr(34))
            OutputFile.WriteLine("        '     Dim cmd As New SqlClient.SqlCommand")
            OutputFile.WriteLine("        '     Dim ConnectionString As String = GetConnectionString()")
            OutputFile.WriteLine("        '     Dim conn as New SqlClient.SqlConnection")
            OutputFile.WriteLine("        '")
            OutputFile.WriteLine("        '     conn.ConnectionString = ConnectionString")
            OutputFile.WriteLine("        '     cmd.CommandType = CommandType.StoredProcedure")
            OutputFile.WriteLine("        '     cmd.Connection = conn")
            OutputFile.WriteLine("        '     cmd.CommandText = storedProcedure")
            OutputFile.WriteLine("        '     cmd.Parameters.Add(" + Chr(34) + "@fname" + Chr(34) + ", SqlDbType.VarChar)")
            OutputFile.WriteLine("        '     cmd.Parameters(" + Chr(34) + "@fname" + Chr(34) + ").Value = FirstName")
            OutputFile.WriteLine("        '")
            OutputFile.WriteLine("        '     Try")
            OutputFile.WriteLine("        '         Dim ds as DataSet")
            OutputFile.WriteLine("        '         Dim da as SqlClient.SqlDataAdapter")
            OutputFile.WriteLine("        '         Dim Table as DataTable = Nothing")
            OutputFile.WriteLine("        '")
            OutputFile.WriteLine("        '         conn.Open()")
            OutputFile.WriteLine("        '         da = new SqlClient.SqlDataAdapter()")
            OutputFile.WriteLine("        '         da.SelectCommand = cmd")
            OutputFile.WriteLine("        '")
            OutputFile.WriteLine("        '         ds = New DataSet()")
            OutputFile.WriteLine("        '         da.Fill(ds)")
            OutputFile.WriteLine("        '")
            OutputFile.WriteLine("        '         If ds.Tables.Count > 0 Then")
            OutputFile.WriteLine("        '            If ds.Tables(0).Rows.Count > 0 Then")
            OutputFile.WriteLine("        '                 Table = ds.Tables(0)")
            OutputFile.WriteLine("        '            End If")
            OutputFile.WriteLine("        '         End If")
            OutputFile.WriteLine("        '         conn.Close()")
            OutputFile.WriteLine("        '         Return Table")
            OutputFile.WriteLine("        '      Catch e As Exception")
            OutputFile.WriteLine("        '         Throw")
            OutputFile.WriteLine("        '     End Try")
            OutputFile.WriteLine("        '     conn.Close()")
            OutputFile.WriteLine("        ' End Function")
            OutputFile.WriteLine("        '")
            OutputFile.WriteLine("")

            OutputFile.WriteLine("#End Region")
        Else
            OutputFile.WriteLine("#Region " + Chr(34) + "Custom Query Methods" + Chr(34))
            OutputFile.WriteLine("        ' TODO: Add your own custom queries here. To do this, simply")
            OutputFile.WriteLine("        ' create a stored procedure in your database. Then use the")
            OutputFile.WriteLine("        ' sample code below as a guide to calling your stored")
            OutputFile.WriteLine("        ' procedure. Also, make sure you make the appropriate changes")
            OutputFile.WriteLine("        ' in the Business layer to call this function. See the region")
            OutputFile.WriteLine("        ' called " + Chr(34) + "Custom Query Methods" + Chr(34) + " in the business")
            OutputFile.WriteLine("        ' layer code. ")
            OutputFile.WriteLine("        '")
            OutputFile.WriteLine("        ' Public Shared Function GetByFirstName(ByVal FirstName As String) As DataTable")
            OutputFile.WriteLine("        '     Dim storedProcedure As String = " + Chr(34) + "sp_" + TableName + "_Custom" + Chr(34))
            OutputFile.WriteLine("        '     Dim cmd As New OleDb.OleDbCommand")
            OutputFile.WriteLine("        '     Dim ConnectionString As String = GetConnectionString()")
            OutputFile.WriteLine("        '     Dim conn as New OleDb.OleDbConnection")
            OutputFile.WriteLine("        '")
            OutputFile.WriteLine("        '     conn.ConnectionString = ConnectionString")
            OutputFile.WriteLine("        '     cmd.CommandType = CommandType.StoredProcedure")
            OutputFile.WriteLine("        '     cmd.Connection = conn")
            OutputFile.WriteLine("        '     cmd.CommandText = storedProcedure")
            OutputFile.WriteLine("        '     cmd.Parameters.Add(" + Chr(34) + "fname" + Chr(34) + ", OleDb.OleDbType.VarWChar)")
            OutputFile.WriteLine("        '     cmd.Parameters(" + Chr(34) + "fname" + Chr(34) + ").Value = FirstName")
            OutputFile.WriteLine("        '")
            OutputFile.WriteLine("        '     Try")
            OutputFile.WriteLine("        '         Dim ds as DataSet")
            OutputFile.WriteLine("        '         Dim da as OleDb.OleDbDataAdapter")
            OutputFile.WriteLine("        '         Dim Table as DataTable = Nothing")
            OutputFile.WriteLine("        '")
            OutputFile.WriteLine("        '         conn.Open()")
            OutputFile.WriteLine("        '         da = new SqlClient.SqlDataAdapter()")
            OutputFile.WriteLine("        '         da.SelectCommand = cmd")
            OutputFile.WriteLine("        '")
            OutputFile.WriteLine("        '         ds = New DataSet()")
            OutputFile.WriteLine("        '         da.Fill(ds)")
            OutputFile.WriteLine("        '")
            OutputFile.WriteLine("        '         If ds.Tables.Count > 0 Then")
            OutputFile.WriteLine("        '            If ds.Tables(0).Rows.Count > 0 Then")
            OutputFile.WriteLine("        '                 Table = ds.Tables(0)")
            OutputFile.WriteLine("        '            End If")
            OutputFile.WriteLine("        '         End If")
            OutputFile.WriteLine("        '         conn.Close()")
            OutputFile.WriteLine("        '         Return Table")
            OutputFile.WriteLine("        '      Catch e As Exception")
            OutputFile.WriteLine("        '         Throw")
            OutputFile.WriteLine("        '     End Try")
            OutputFile.WriteLine("        '     conn.Close()")
            OutputFile.WriteLine("        ' End Function")
            OutputFile.WriteLine("        '")
            OutputFile.WriteLine("")

            OutputFile.WriteLine("#End Region")
        End If

    End Sub

    Public Sub CreateBusinessFKs(ByVal TableName As String) Implements LangImplementation.CreateBusinessFKs
        Dim dt As DataTable = SQLObject.GetForeignKeys(TableName)
        Dim ndx As Integer = 0
        Dim dr As DataRow

        If dt.Rows.Count = 0 Then Exit Sub

        While (ndx < dt.Rows.Count)
            dr = dt.Rows(ndx)
            OutputFile.WriteLine("' Get all records which match the passed value of " + dr("PKCOLUMN_NAME"))
            OutputFile.WriteLine("        Public Sub GetBy" + dr("PKCOLUMN_NAME") + "(ByVal " + dr("PKCOLUMN_NAME") + " As Int32)")
            OutputFile.WriteLine("            Dim dt as DataTable = " + Me.DataNameSpace + "." + TableName + ".GetBy" + dr("PKCOLUMN_NAME") + "(" + dr("PKCOLUMN_NAME") + ")")
            OutputFile.WriteLine("            If Not (dt Is Nothing) Then")
            OutputFile.WriteLine("                Me.Load(dt.Rows)")
            OutputFile.WriteLine("            End If")
            OutputFile.WriteLine("        End Sub")
            OutputFile.WriteLine("")
            ndx = ndx + 1
        End While
    End Sub

    Sub CreateDataGetByFKs(ByVal TableName As String) Implements LangImplementation.CreateDataGetByFKs
        Dim dt As DataTable = SQLObject.GetForeignKeys(TableName)
        Dim ndx As Integer = 0
        Dim dr As DataRow

        If dt.Rows.Count = 0 Then Exit Sub

        If Me.IsDatabaseMSSQL Then
            While (ndx < dt.Rows.Count)
                dr = dt.Rows(ndx)
                OutputFile.WriteLine("")
                OutputFile.WriteLine("' Get all records which match the passed value of " + dr("PKCOLUMN_NAME"))
                OutputFile.WriteLine("        Public Shared Function GetBy" + dr("PKCOLUMN_NAME") + "(" + dr("PKCOLUMN_NAME") + " As Int32) As DataTable")
                OutputFile.WriteLine("            Dim storedProcedure As String = " + Chr(34) + "sp_" + TableName + "_GetBy" + dr("PKCOLUMN_NAME") + Chr(34))
                OutputFile.WriteLine("            Dim cmd As New SqlClient.SqlCommand")
                OutputFile.WriteLine("            Dim ConnectionString As String = GetConnectionString()")
                OutputFile.WriteLine("            Dim conn as New SqlClient.SqlConnection")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("            conn.ConnectionString = ConnectionString")
                OutputFile.WriteLine("            cmd.CommandType = CommandType.StoredProcedure")
                OutputFile.WriteLine("            cmd.Connection = conn")
                OutputFile.WriteLine("            cmd.CommandText = storedProcedure")
                OutputFile.WriteLine("            cmd.Parameters.Add(" + Chr(34) + "@" + dr("PKCOLUMN_NAME") + Chr(34) + ", SqlDbType.Int)")
                OutputFile.WriteLine("            cmd.Parameters(" + Chr(34) + "@" + dr("PKCOLUMN_NAME") + Chr(34) + ").Value = " + dr("PKCOLUMN_Name"))

                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("            Try")
                OutputFile.WriteLine("                Dim ds as DataSet")
                OutputFile.WriteLine("                Dim da as SqlClient.SqlDataAdapter")
                OutputFile.WriteLine("                Dim Table as DataTable = Nothing")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("                conn.Open()")
                OutputFile.WriteLine("                da = new SqlClient.SqlDataAdapter()")
                OutputFile.WriteLine("                da.SelectCommand = cmd")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("                ds = New DataSet()")
                OutputFile.WriteLine("                da.Fill(ds)")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("                If ds.Tables.Count > 0 Then")
                OutputFile.WriteLine("                   If ds.Tables(0).Rows.Count > 0 Then")
                OutputFile.WriteLine("                        Table = ds.Tables(0)")
                OutputFile.WriteLine("                   End If")
                OutputFile.WriteLine("                End If")
                OutputFile.WriteLine("                conn.Close()")
                OutputFile.WriteLine("                Return Table")
                OutputFile.WriteLine("             Catch e As Exception")
                OutputFile.WriteLine("                Throw")
                OutputFile.WriteLine("            End Try")
                OutputFile.WriteLine("            conn.Close()")
                OutputFile.WriteLine("        End Function")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("")
                ndx = ndx + 1
            End While
        Else
            While (ndx < dt.Rows.Count)
                dr = dt.Rows(ndx)
                OutputFile.WriteLine("")
                OutputFile.WriteLine("' Get all records which match the passed value of " + dr("PKCOLUMN_NAME"))
                OutputFile.WriteLine("        Public Shared Function GetBy" + dr("PKCOLUMN_NAME") + "(" + dr("PKCOLUMN_NAME") + " As Int32) As DataTable")
                OutputFile.WriteLine("            Dim storedProcedure As String = " + Chr(34) + "sp_" + TableName + "_GetBy" + dr("PKCOLUMN_NAME") + Chr(34))
                OutputFile.WriteLine("            Dim cmd As New OleDb.OleDbCommand")
                OutputFile.WriteLine("            Dim ConnectionString As String = GetConnectionString()")
                OutputFile.WriteLine("            Dim conn as New OleDb.OleDbConnection")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("            conn.ConnectionString = ConnectionString")
                OutputFile.WriteLine("            cmd.CommandType = CommandType.StoredProcedure")
                OutputFile.WriteLine("            cmd.Connection = conn")
                OutputFile.WriteLine("            cmd.CommandText = storedProcedure")
                OutputFile.WriteLine("            cmd.Parameters.Add(" + Chr(34) + dr("PKCOLUMN_NAME") + Chr(34) + ", Data.OleDb.OleDbType.Integer)")
                OutputFile.WriteLine("            cmd.Parameters(" + Chr(34) + dr("PKCOLUMN_NAME") + Chr(34) + ").Value = " + dr("PKCOLUMN_Name"))

                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("            Try")
                OutputFile.WriteLine("                Dim ds As DataSet")
                OutputFile.WriteLine("                Dim da As OleDb.OleDbDataAdapter")
                OutputFile.WriteLine("                Dim Table As DataTable = Nothing")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("                conn.Open()")
                OutputFile.WriteLine("                da = new OleDb.OleDbDataAdapter()")
                OutputFile.WriteLine("                da.SelectCommand = cmd")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("                ds = New DataSet()")
                OutputFile.WriteLine("                da.Fill(ds)")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("                If ds.Tables.Count > 0 Then")
                OutputFile.WriteLine("                   If ds.Tables(0).Rows.Count > 0 Then")
                OutputFile.WriteLine("                        Table = ds.Tables(0)")
                OutputFile.WriteLine("                   End If")
                OutputFile.WriteLine("                End If")
                OutputFile.WriteLine("                conn.Close()")
                OutputFile.WriteLine("                Return Table")
                OutputFile.WriteLine("             Catch e As Exception")
                OutputFile.WriteLine("                Throw")
                OutputFile.WriteLine("            End Try")
                OutputFile.WriteLine("            conn.Close()")
                OutputFile.WriteLine("        End Function")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("")
                ndx = ndx + 1
            End While
        End If

    End Sub

    Public Sub CreateDataGetAll(ByVal TableName As String) Implements LangImplementation.CreateDataGetAll
        If Me.IsDatabaseMSSQL Then
            OutputFile.WriteLine("")
            OutputFile.WriteLine("        Public Shared Function GetAll() As DataTable")
            OutputFile.WriteLine("            Dim storedProcedure As String = " + Chr(34) + "sp_" + TableName + "_GetAll" + Chr(34))
            OutputFile.WriteLine("            Dim cmd As New SqlClient.SqlCommand")
            OutputFile.WriteLine("            Dim ConnectionString As String = GetConnectionString()")
            OutputFile.WriteLine("            Dim conn as New SqlClient.SqlConnection")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("            conn.ConnectionString = ConnectionString")
            OutputFile.WriteLine("            cmd.CommandType = CommandType.StoredProcedure")
            OutputFile.WriteLine("            cmd.Connection = conn")
            OutputFile.WriteLine("            cmd.CommandText = storedProcedure")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("            Try")
            OutputFile.WriteLine("                Dim ds as DataSet")
            OutputFile.WriteLine("                Dim da as SqlClient.SqlDataAdapter")
            OutputFile.WriteLine("                Dim Table as DataTable = Nothing")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("                conn.Open()")
            OutputFile.WriteLine("                da = new SqlClient.SqlDataAdapter()")
            OutputFile.WriteLine("                da.SelectCommand = cmd")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("                ds = New DataSet()")
            OutputFile.WriteLine("                da.Fill(ds)")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("                If ds.Tables.Count > 0 Then")
            OutputFile.WriteLine("                   If ds.Tables(0).Rows.Count > 0 Then")
            OutputFile.WriteLine("                        Table = ds.Tables(0)")
            OutputFile.WriteLine("                   End If")
            OutputFile.WriteLine("                End If")
            OutputFile.WriteLine("                conn.Close()")
            OutputFile.WriteLine("                Return Table")
            OutputFile.WriteLine("             Catch e As Exception")
            OutputFile.WriteLine("                Throw")
            OutputFile.WriteLine("            End Try")
            OutputFile.WriteLine("            conn.Close()")
            OutputFile.WriteLine("        End Function")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("")
        Else
            OutputFile.WriteLine("")
            OutputFile.WriteLine("        Public Shared Function GetAll() As DataTable")
            OutputFile.WriteLine("            Dim storedProcedure As String = " + Chr(34) + "sp_" + TableName + "_GetAll" + Chr(34))
            OutputFile.WriteLine("            Dim cmd As New OleDb.OleDbCommand")
            OutputFile.WriteLine("            Dim ConnectionString As String = GetConnectionString()")
            OutputFile.WriteLine("            Dim conn as New OleDb.OleDbConnection")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("            conn.ConnectionString = ConnectionString")
            OutputFile.WriteLine("            cmd.CommandType = CommandType.StoredProcedure")
            OutputFile.WriteLine("            cmd.Connection = conn")
            OutputFile.WriteLine("            cmd.CommandText = storedProcedure")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("            Try")
            OutputFile.WriteLine("                Dim ds as DataSet")
            OutputFile.WriteLine("                Dim da as OleDb.OleDbDataAdapter")
            OutputFile.WriteLine("                Dim Table as DataTable = Nothing")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("                conn.Open()")
            OutputFile.WriteLine("                da = new OleDb.OleDbDataAdapter()")
            OutputFile.WriteLine("                da.SelectCommand = cmd")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("                ds = New DataSet()")
            OutputFile.WriteLine("                da.Fill(ds)")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("                If ds.Tables.Count > 0 Then")
            OutputFile.WriteLine("                   If ds.Tables(0).Rows.Count > 0 Then")
            OutputFile.WriteLine("                        Table = ds.Tables(0)")
            OutputFile.WriteLine("                   End If")
            OutputFile.WriteLine("                End If")
            OutputFile.WriteLine("                conn.Close()")
            OutputFile.WriteLine("                Return Table")
            OutputFile.WriteLine("             Catch e As Exception")
            OutputFile.WriteLine("                Throw")
            OutputFile.WriteLine("            End Try")
            OutputFile.WriteLine("            conn.Close()")
            OutputFile.WriteLine("        End Function")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("")
        End If
    End Sub

    Public Sub CreateBusinessHeader(ByVal TableName As String) Implements LangImplementation.CreateBusinessHeader
        If Not Me.m_SupressComments Then
            OutputFile.WriteLine("' This file was automatically created by LayerGen " + Version())
            OutputFile.WriteLine("' Created: " + Now().ToShortDateString() + " " + Now().ToShortTimeString())
            OutputFile.WriteLine("")
        End If
        OutputFile.WriteLine("Option Strict On")
        OutputFile.WriteLine("Option Explicit On")
        OutputFile.WriteLine()
        OutputFile.WriteLine("Imports Microsoft.VisualBasic")
        OutputFile.WriteLine("Imports System")
        OutputFile.WriteLine("Imports System.Data")
        OutputFile.WriteLine()
        OutputFile.WriteLine("NameSpace " + Me.BusinessNameSpace)
        OutputFile.WriteLine()
        OutputFile.WriteLine("#Region " + Chr(34) + TableName + " Class" + Chr(34))
        OutputFile.WriteLine(Chr(9) + "<Serializable()> Public Class " + TableName)
        OutputFile.WriteLine(Chr(9) + Chr(9) + "Inherits " + Me.DataNameSpace + "." + TableName)
        OutputFile.WriteLine(Chr(9) + Chr(9) + "Implements " + Me.BusinessNameSpace + ".IBusiness")
        OutputFile.WriteLine()
    End Sub

    Public Sub CreateInterfaceImplementation(ByVal TableName As String, ByVal PrimaryKey As String) Implements LangImplementation.CreateInterfaceImplementation
        OutputFile.WriteLine("#Region " + Chr(34) + "Interface Implementation" + Chr(34))
        OutputFile.WriteLine(Chr(9) + "Public Sub Rollback() Implements IBusiness.Rollback")
        If PrimaryKey <> "" Then
            'OutputFile.WriteLine(Chr(9) + Chr(9) + "MyBase." + PrimaryKey + " = System.DBNull.Value")
        End If
        OutputFile.WriteLine(Chr(9) + "End Sub")
        OutputFile.WriteLine("")
        OutputFile.WriteLine(Chr(9) + "Public Sub Validate() Implements IBusiness.Validate")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "' TODO: Write your own validation code")
        OutputFile.WriteLine(Chr(9) + "End Sub")
        OutputFile.WriteLine("")
        'OutputFile.WriteLine(Chr(9) + "Public Shadows Property Sequence() As Integer Implements ISequence.Sequence")
        'OutputFile.WriteLine(Chr(9) + Chr(9) + "Get")
        'OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Return MyBase.Sequence")
        'OutputFile.WriteLine(Chr(9) + Chr(9) + "End Get")
        'OutputFile.WriteLine(Chr(9) + Chr(9) + "Set(ByVal Value As Integer")
        'OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "MyBase.Sequence=Value")
        'OutputFile.WriteLine(Chr(9) + Chr(9) + "End Set")
        'OutputFile.WriteLine(Chr(9) + "End Property")
        OutputFile.WriteLine("#End Region")
        OutputFile.WriteLine(Chr(9) + "End Class")
        OutputFile.WriteLine("#End Region")
        OutputFile.WriteLine("")
    End Sub

    Public Sub CreateCollectionClass(ByVal TableName As String, ByVal PrimaryKey As String, ByVal EnableSorting As Boolean) Implements LangImplementation.CreateCollectionClass
        OutputFile.WriteLine("#Region " + Chr(34) + TableName + "s Class" + Chr(34))
        OutputFile.WriteLine(Chr(9) + "<Serializable()> Public Class " + TableName + "s : Inherits CollectionBase")
        OutputFile.WriteLine("")
        If EnableSorting = True Then
            CreateSortingFunctions(TableName)
        End If
        OutputFile.WriteLine(Chr(9) + "#Region " + Chr(34) + "Constructors" + Chr(34))
        OutputFile.WriteLine(Chr(9) + Chr(9) + "Public Sub New()")
        OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9))
        OutputFile.WriteLine(Chr(9) + Chr(9) + "End Sub")
        OutputFile.WriteLine("")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "Public Sub New(ByVal datarows As DataRowCollection)")
        OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Me.New()")
        OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Me.Load(datarows)")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "End Sub")
        OutputFile.WriteLine(Chr(9) + "#End Region")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("#Region " + Chr(34) + "Member Functions" + Chr(34))
        OutputFile.WriteLine(Chr(9) + "Protected Sub Load(ByVal dataRows As DataRowCollection)")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "For Each dr As DataRow In dataRows")
        OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Me.Add(New " + TableName + "(dr))")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "Next")
        OutputFile.WriteLine(Chr(9) + "End Sub")
        OutputFile.WriteLine("")
        OutputFile.WriteLine(Chr(9) + "Default Public Property " + TableName + "(ByVal index As Integer) As " + TableName)
        OutputFile.WriteLine(Chr(9) + Chr(9) + "Get")
        OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Return CType(MyBase.InnerList.Item(index), " + TableName + ")")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "End Get")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "Set(ByVal value As " + TableName + ")")
        OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "MyBase.InnerList.Item(index) = value")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "End Set")
        OutputFile.WriteLine(Chr(9) + "End Property")
        OutputFile.WriteLine("")
        OutputFile.WriteLine(Chr(9) + "Public Function Add(ByVal val As " + TableName + ") As Integer")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "Return MyBase.InnerList.Add(val)")
        OutputFile.WriteLine(Chr(9) + "End Function")
        OutputFile.WriteLine("#End Region")
        OutputFile.WriteLine("")
        If SQLObject.IsView(TableName) = False Then
            OutputFile.WriteLine("#Region " + Chr(34) + "Save Function" + Chr(34))
            OutputFile.WriteLine(Chr(9) + "Public Sub Save()")
            OutputFile.WriteLine(Chr(9) + Chr(9) + "For Each a As " + TableName + " In Me.InnerList")
            OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "a.Save()")
            OutputFile.WriteLine(Chr(9) + Chr(9) + "Next")
            OutputFile.WriteLine(Chr(9) + "End Sub")
            OutputFile.WriteLine("#End Region")
            OutputFile.WriteLine("")
        End If
        OutputFile.WriteLine("#Region " + Chr(34) + "Rollback Sub" + Chr(34))
        OutputFile.WriteLine(Chr(9) + "Public Sub Rollback")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "For Each a As " + TableName + " In Me.InnerList")
        OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "a.Rollback()")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "Next")
        OutputFile.WriteLine(Chr(9) + "End Sub")
        OutputFile.WriteLine("#End Region")
        OutputFile.WriteLine("")
        Me.CreateBusinessGetAll(TableName)
        CreateBusinessFKs(TableName)
        OutputFile.WriteLine("#Region " + Chr(34) + "Custom Query Methods" + Chr(34))
        OutputFile.WriteLine("        ' TODO: Add your own custom Query Methods")
        OutputFile.WriteLine("        ' I have provided an example to show you how easy")
        OutputFile.WriteLine("        ' it is to add your own custom query. Don't forget")
        OutputFile.WriteLine("        ' to add your query method to the Data layer too")
        OutputFile.WriteLine("        '")
        OutputFile.WriteLine("        ' Public Sub GetByFirstName(ByVal FirstName As String)")
        OutputFile.WriteLine("        '     Dim dt as DataTable = " + Me.DataNameSpace + "." + TableName + ".GetByFirstName(FirstName)")
        OutputFile.WriteLine("        '     If Not (dt Is Nothing) Then")
        OutputFile.WriteLine("        '         Me.Load(dt.Rows)")
        OutputFile.WriteLine("        '     End If")
        OutputFile.WriteLine("        ' End Sub")
        OutputFile.WriteLine("        '")
        OutputFile.WriteLine("#End Region")
        OutputFile.WriteLine("")
        OutputFile.WriteLine(Chr(9) + "End Class")
        OutputFile.WriteLine("#End Region")
        OutputFile.WriteLine("End Namespace")
    End Sub

    Public Sub CreateDataHeader(ByVal TableName As String) Implements LangImplementation.CreateDataHeader
        If Not Me.m_SupressComments Then
            OutputFile.WriteLine("' This file was automatically created by LayerGen " + Version())
            OutputFile.WriteLine("' Created: " + Now().ToShortDateString() + " " + Now().ToShortTimeString())
            OutputFile.WriteLine("")
        End If
        OutputFile.WriteLine("Option Strict On")
        OutputFile.WriteLine("Option Explicit On")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("Imports Microsoft.VisualBasic")
        OutputFile.WriteLine("Imports System")
        OutputFile.WriteLine("Imports System.Data")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("Namespace " + Me.DataNameSpace)
        OutputFile.WriteLine("")
        OutputFile.WriteLine("#Region " + Chr(34) + TableName + " Class" + Chr(34))
        OutputFile.WriteLine(Chr(9) + "<Serializable()> Public Class " + TableName)
    End Sub

    Protected Sub CreateMemberVariables(ByVal dt As DataTable, ByVal FKeys As DataTable) Implements LangImplementation.CreateMemberVariables
        Dim dr As DataRow
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim type As String
        Dim varname As String

        OutputFile.WriteLine("#Region " + Chr(34) + "Instance Variables" + Chr(34))

        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            type = dr("TYPE_NAME")
            varname = dr("COLUMN_NAME")
            OutputFile.WriteLine("        Protected m_" + VBFunctions.VBName(varname.ToLower()) + " As " + Me.GetSQLType(type))
        Next
        OutputFile.WriteLine("")
        OutputFile.WriteLine("        Protected m_isDirty As Boolean = False")
        OutputFile.WriteLine("        Private m_isFresh As Boolean = False")
        OutputFile.WriteLine("        Protected ConnectString As String")
        If Not Me.IsDatabaseMSSQL Then
            OutputFile.WriteLine("        Private cmdGetIdentity As OleDb.OleDbCommand")
        End If
        If FKeys.Rows.Count > 0 Then
            OutputFile.WriteLine("")

            ndx = 0
            While (ndx < FKeys.Rows.Count)
                dr = FKeys.Rows(ndx)
                OutputFile.Write("        Protected my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))))
                OutputFile.WriteLine(" As " + Me.BusinessNameSpace + "." + dr("PKTABLE_NAME"))
                ndx = ndx + 1
            End While
        End If
        OutputFile.WriteLine("#End Region" + OutputFile.NewLine)
    End Sub

    Protected Sub CreateDataProperties(ByVal dt As DataTable, ByVal FKeys As DataTable) Implements LangImplementation.CreateDataProperties
        Dim dr As DataRow
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim type As String
        Dim varname As String
        Dim Isidentity As Boolean = False

        OutputFile.WriteLine("#Region " + Chr(34) + "Properties" + Chr(34))

        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            type = dr("TYPE_NAME")
            varname = dr("COLUMN_NAME")
            If type.ToLower.EndsWith("identity") Then
                Isidentity = True
            End If
            OutputFile.WriteLine("        Public Property " + VBFunctions.GetProperName(varname) + "() As " + Me.GetSQLType(type))
            OutputFile.WriteLine("            Get")
            If Me.m_DoEncryption And Me.GetSQLType(type) = "String" Then
                OutputFile.WriteLine("             Dim oES As New Encryption64")
            End If
            If Me.m_DoEncryption And Me.GetSQLType(type) = "String" Then
                OutputFile.WriteLine("                Return oES.Decrypt(Me.m_" + VBFunctions.VBName(varname.ToLower()) + "," + Chr(34) + Me.m_EncryptionKey + Chr(34) + ")")
            Else
                OutputFile.WriteLine("                Return Me.m_" + VBFunctions.VBName(varname.ToLower()))
            End If

            OutputFile.WriteLine("            End Get")
            OutputFile.WriteLine("            Set(ByVal Value As " + Me.GetSQLType(type) + ")")
            If Me.m_DoEncryption And Me.GetSQLType(type) = "String" Then
                OutputFile.WriteLine("             Dim oES As New Encryption64")
            End If
            OutputFile.WriteLine("                Me.m_isDirty = True")
            If Me.m_DoEncryption And Me.GetSQLType(type) = "String" Then
                OutputFile.WriteLine("                Me.m_" + VBFunctions.VBName(varname.ToLower()) + " = oES.Encrypt(Value," + Chr(34) + Me.m_EncryptionKey + Chr(34) + ")")
            Else
                OutputFile.WriteLine("                Me.m_" + VBFunctions.VBName(varname.ToLower()) + " = Value")
            End If

            OutputFile.WriteLine("            End Set")
            OutputFile.WriteLine("        End Property" + OutputFile.NewLine)
        Next
        ndx = 0

        OutputFile.WriteLine("        Public Readonly Property IsIdentityTable() As Boolean")
        OutputFile.WriteLine("            Get")
        OutputFile.WriteLine("                Return " + Isidentity.ToString())
        OutputFile.WriteLine("            End Get")
        OutputFile.WriteLine("        End Property")

        While (ndx < FKeys.Rows.Count)
            dr = FKeys.Rows(ndx)
            OutputFile.WriteLine("        Public Property F" + MiscFunctions.StripID(dr("PKCOLUMN_NAME")) + " As " + Me.BusinessNameSpace + "." + dr("PKTABLE_NAME"))
            OutputFile.WriteLine("            Get")
            OutputFile.WriteLine("                If ((Me.my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + " Is Nothing) AndAlso (Me." + dr("PKCOLUMN_NAME") + " > 0)) Then")
            OutputFile.WriteLine("                    Me.my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + " = New " + Me.BusinessNameSpace + "." + dr("PKTABLE_NAME") + "(Me." + dr("PKCOLUMN_NAME") + ")")
            OutputFile.WriteLine("                End If")
            OutputFile.WriteLine("                Return Me.my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))))
            OutputFile.WriteLine("            End Get")
            OutputFile.WriteLine("            Set(ByVal Value As " + Me.BusinessNameSpace + "." + dr("PKTABLE_NAME") + ")")
            OutputFile.WriteLine("                Me.my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + " = Value")
            OutputFile.WriteLine("            End Set")
            OutputFile.WriteLine("        End Property")
            OutputFile.WriteLine("")
            ndx = ndx + 1
        End While
        OutputFile.WriteLine("#End Region" + OutputFile.NewLine)

    End Sub

    Public Sub CreateDataConstructors(ByVal dt As DataTable, ByVal TableName As String, ByVal PrimaryKey As String) Implements LangImplementation.CreateDataConstructors
        Dim ndx As Integer
        Dim dr As DataRow
        Dim count As Integer = dt.Rows.Count

        OutputFile.WriteLine("")
        OutputFile.WriteLine("#Region " + Chr(34) + "Constructors" + Chr(34))
        OutputFile.WriteLine("")
        OutputFile.WriteLine(Chr(9) + "Public Sub New()")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "SetConnectString()")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "m_IsFresh = True")
        OutputFile.WriteLine(Chr(9) + "End Sub")
        OutputFile.WriteLine("")
        OutputFile.Write(Chr(9) + "Public Sub New(ByVal intPrimaryKey As ")
        If SQLObject.IsView(TableName) Then
            OutputFile.WriteLine("Int32)")
        Else
            For ndx = 1 To count
                dr = dt.Rows(ndx - 1)
                If CStr(dr("COLUMN_NAME")).ToLower = PrimaryKey.ToLower Or CStr(dr("COLUMN_NAME")).ToLower = PrimaryKey.ToLower + " identity" Then
                    OutputFile.WriteLine(GetSQLType(dr("TYPE_NAME")) + ")")
                    Exit For
                End If
            Next
        End If
        OutputFile.WriteLine(Chr(9) + Chr(9) + "SetConnectString()")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "Me.Get(intPrimaryKey)")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "m_IsFresh = False")
        OutputFile.WriteLine(Chr(9) + "End Sub")
        OutputFile.WriteLine("")
        OutputFile.WriteLine(Chr(9) + "Public Sub New(ByVal dtrRow As DataRow)")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "SetConnectString()")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "Me.Fill(dtrRow)")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "m_IsFresh = False")
        OutputFile.WriteLine(Chr(9) + "End Sub")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("#End Region")
        OutputFile.WriteLine("")
    End Sub

    Protected Sub CreateDataConnectionStringSubs() Implements LangImplementation.CreateDataConnectionStringSubs
        OutputFile.WriteLine("        Protected Sub SetConnectString()")
        OutputFile.WriteLine("             ConnectString = " + DataNameSpace + ".Universal.GetConnectionString()")
        'OutputFile.WriteLine("            ConnectString = ConfigurationManager.ConnectionStrings(" + Chr(34) + "SQLServer" + Chr(34) + ").ConnectionString")
        OutputFile.WriteLine("        End Sub" + OutputFile.NewLine)
        OutputFile.WriteLine("        Protected Function GetConnectString() As String")
        OutputFile.WriteLine("            Return ConnectString")
        OutputFile.WriteLine("        End Function" + OutputFile.NewLine)
        OutputFile.WriteLine("        Protected Shared Function GetConnectionString() As String")
        OutputFile.WriteLine("             Return " + DataNameSpace + ".Universal.GetConnectionString()")
        'OutputFile.WriteLine("            Return ConfigurationManager.ConnectionStrings(" + Chr(34) + "SQLServer" + Chr(34) + ").ConnectionString")
        OutputFile.WriteLine("        End Function" + OutputFile.NewLine)
        
    End Sub

    Protected Sub CreateDataCopySub(ByVal dt As DataTable) Implements LangImplementation.CreateDataCopySub
        Dim dr As DataRow
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim type As String
        Dim varname As String

        OutputFile.WriteLine("        Public Sub Copy(dtrRow as DataRow)")
        'If Me.m_DoEncryption Then
        ' OutputFile.WriteLine("            Dim oES As New Encryption64")
        'End If
        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            type = dr("TYPE_NAME")
            varname = dr("COLUMN_NAME")
            OutputFile.WriteLine("            Try")
            'If Me.m_DoEncryption And Me.GetSQLType(type) = "String" Then
            'OutputFile.Write("                Me.m_" + (VBFunctions.VBName(varname.ToLower)) + " = oES.Decrypt(CType(dtrRow(" + Chr(34))
            'OutputFile.Write(varname + Chr(34) + "), ")
            'OutputFile.WriteLine(Me.GetSQLType(type) + ")," + Chr(34) + EncryptionKey + Chr(34) + ")")
            'Else
            OutputFile.Write("                Me.m_" + (VBFunctions.VBName(varname.ToLower)) + " = CType(dtrRow(" + Chr(34))
            OutputFile.Write(varname + Chr(34) + "), ")
            OutputFile.WriteLine(Me.GetSQLType(type) + ")")
            'End If

            OutputFile.WriteLine("            Catch ex as Exception")
            OutputFile.WriteLine("            End Try")
            OutputFile.WriteLine("")
            'If Me.m_DoEncryption Then
            'OutputFile.WriteLine("        oES = Nothing")
            'End If
        Next
        OutputFile.WriteLine("        End Sub")
    End Sub

    Protected Sub CreateDataFillSub(ByVal dt As DataTable) Implements LangImplementation.CreateDataFillSub
        Dim dr As DataRow
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim type As String
        Dim varname As String

        OutputFile.WriteLine("        Protected Sub Fill(ByVal dtrRow As DataRow)")
        'If Me.m_DoEncryption Then
        'OutputFile.WriteLine("            Dim oES As New Encryption64")
        'End If

        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            type = dr("TYPE_NAME")
            varname = dr("COLUMN_NAME")
            OutputFile.WriteLine("            Try")
            OutputFile.WriteLine("                If (Not dtrRow(" + Chr(34) + varname + Chr(34) + ") Is DBNull.Value) Then")
            'If Me.m_DoEncryption And Me.GetSQLType(type) = "String" Then
            'OutputFile.WriteLine("                    Me.m_" + VBFunctions.VBName(varname.ToLower()) + " = oES.Decrypt(CType(dtrRow(" + Chr(34) + varname + Chr(34) + "), " + Me.GetSQLType(type) + ")," + Chr(34) + Me.m_EncryptionKey + Chr(34) + ")")
            'Else
            OutputFile.WriteLine("                    Me.m_" + VBFunctions.VBName(varname.ToLower()) + " = CType(dtrRow(" + Chr(34) + varname + Chr(34) + "), " + Me.GetSQLType(type) + ")")
            'End If

            If Me.GetSQLType(type) = "System.DateTime" Then
                OutputFile.WriteLine("                Else")
                OutputFile.WriteLine("                        Me.m_" + VBFunctions.VBName(varname.ToLower()) + " = Nothing")
            End If
            OutputFile.WriteLine("                End If")
            OutputFile.WriteLine("            Catch ex as Exception")
            If Me.GetSQLType(type) = "System.DateTime" Then
                OutputFile.WriteLine("                me.m_" + VBFunctions.VBName(varname.ToLower()) + " = Nothing")
            End If
            OutputFile.WriteLine("            End Try")
        Next
        OutputFile.WriteLine("        End Sub")
        OutputFile.WriteLine("")
    End Sub

    Protected Sub CreateDataGetSub(ByVal dt As DataTable, ByVal TableName As String, ByVal PrimaryKey As String) Implements LangImplementation.CreateDataGetSub
        Dim ndx As Integer
        Dim dr As DataRow
        Dim count As Integer = dt.Rows.Count
        Dim type As String = ""
       
        Dim ViewCommand As String

        If SQLObject.IsView(TableName) Then
            ViewCommand = "GetAll"
        Else
            ViewCommand = "Select"
        End If
        If Me.IsDatabaseMSSQL Then
            OutputFile.Write("        Private Sub [Get](ByVal intId As ")
            If SQLObject.IsView(TableName) Then
                OutputFile.WriteLine("Int32)")
            Else
                For ndx = 1 To count
                    dr = dt.Rows(ndx - 1)
                    If CStr(dr("COLUMN_NAME")).ToLower = PrimaryKey.ToLower Or CStr(dr("COLUMN_NAME")).ToLower = PrimaryKey.ToLower + " identity" Then
                        OutputFile.WriteLine(GetSQLType(dr("TYPE_NAME")) + ")")
                        type = CStr(dr("TYPE_NAME"))
                        Exit For
                    End If
                Next
            End If
            OutputFile.WriteLine("            Dim storedProcedure As String = " + Chr(34) + "sp_" + TableName + "_" + ViewCommand + Chr(34))
            OutputFile.WriteLine("            Dim cmd As New SqlClient.SqlCommand")
            OutputFile.WriteLine("            Dim ds As DataSet")
            OutputFile.WriteLine("            Dim ConnectionString As String = GetConnectString()")
            OutputFile.WriteLine("            Dim conn As New SqlClient.SqlConnection")
            OutputFile.WriteLine("            Dim da As SqlClient.SqlDataAdapter")
            OutputFile.WriteLine("")
            OutputFile.WriteLine("            conn.ConnectionString = ConnectionString")
            OutputFile.WriteLine("            cmd.CommandType = CommandType.StoredProcedure")
            OutputFile.WriteLine("            cmd.Connection = conn")
            OutputFile.WriteLine("            cmd.CommandText = storedProcedure")
            If SQLObject.IsView(TableName) = False Then

                OutputFile.Write("            cmd.Parameters.Add(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ", SqlDbType.")
                OutputFile.WriteLine((type.Replace(" identity", "")) + ")")
                OutputFile.WriteLine("            cmd.Parameters(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ").Value = intId")
            End If
            OutputFile.WriteLine("")
            OutputFile.WriteLine("            Try")
            OutputFile.WriteLine("                conn.Open()")
            OutputFile.WriteLine("                da = New SqlClient.SqlDataAdapter()")
            OutputFile.WriteLine("                da.SelectCommand = cmd" + OutputFile.NewLine)
            OutputFile.WriteLine("                ds = New DataSet()")
            OutputFile.WriteLine("                da.Fill(ds)" + OutputFile.NewLine)
            OutputFile.WriteLine("                If ds.Tables.Count > 0 Then")
            OutputFile.WriteLine("                    If ds.Tables(0).Rows.Count > 0 Then")
            OutputFile.WriteLine("                        Fill(ds.Tables(0).Rows(0))")
            OutputFile.WriteLine("                    End If")
            OutputFile.WriteLine("                End If")
            OutputFile.WriteLine("            Catch e As Exception")
            OutputFile.WriteLine("                Throw e")
            OutputFile.WriteLine("            End Try")
            OutputFile.WriteLine("            conn.Close()")
            OutputFile.WriteLine("        End Sub" + OutputFile.NewLine)
        Else
            OutputFile.WriteLine("        Private Sub [Get](ByVal intId As ")
            For ndx = 1 To count
                dr = dt.Rows(ndx - 1)
                If CStr(dr("COLUMN_NAME")).ToLower = PrimaryKey.ToLower Then
                    OutputFile.WriteLine(GetSQLType(dr("TYPE_NAME")) + ")")
                    Exit For
                End If
            Next
            OutputFile.WriteLine("            Dim storedProcedure As String = " + Chr(34) + "sp_" + TableName + "_" + ViewCommand + Chr(34))
            OutputFile.WriteLine("            Dim cmd As New OleDb.OleDbCommand")
            OutputFile.WriteLine("            Dim ds As DataSet")
            OutputFile.WriteLine("            Dim ConnectionString As String = GetConnectString()")
            OutputFile.WriteLine("            Dim conn As New OleDb.OleDbConnection")
            OutputFile.WriteLine("            Dim da As OleDb.OleDbDataAdapter")
            OutputFile.WriteLine("")
            OutputFile.WriteLine("            conn.ConnectionString = ConnectionString")
            OutputFile.WriteLine("            cmd.CommandType = CommandType.StoredProcedure")
            OutputFile.WriteLine("            cmd.Connection = conn")
            OutputFile.WriteLine("            cmd.CommandText = storedProcedure")
            If SQLObject.IsView(TableName) = False Then
                OutputFile.WriteLine("            cmd.Parameters.Add(" + Chr(34) + PrimaryKey + Chr(34) + ", OleDb.OleDbType.Integer)")
                OutputFile.WriteLine("            cmd.Parameters(" + Chr(34) + PrimaryKey + Chr(34) + ").Value = intId")
            End If
            OutputFile.WriteLine("")
            OutputFile.WriteLine("            Try")
            OutputFile.WriteLine("                conn.Open()")
            OutputFile.WriteLine("                da = New OleDb.OleDbDataAdapter()")
            OutputFile.WriteLine("                da.SelectCommand = cmd" + OutputFile.NewLine)
            OutputFile.WriteLine("                ds = New DataSet()")
            OutputFile.WriteLine("                da.Fill(ds)" + OutputFile.NewLine)
            OutputFile.WriteLine("                If ds.Tables.Count > 0 Then")
            OutputFile.WriteLine("                    If ds.Tables(0).Rows.Count > 0 Then")
            OutputFile.WriteLine("                        Fill(ds.Tables(0).Rows(0))")
            OutputFile.WriteLine("                    End If")
            OutputFile.WriteLine("                End If")
            OutputFile.WriteLine("            Catch e As Exception")
            OutputFile.WriteLine("                Throw e")
            OutputFile.WriteLine("            End Try")
            OutputFile.WriteLine("            conn.Close()")
            OutputFile.WriteLine("        End Sub" + OutputFile.NewLine)
        End If
    End Sub

    Protected Sub CreateDataDeleteSub(ByVal dt As DataTable, ByVal TableName As String, ByVal PrimaryKey As String) Implements LangImplementation.CreateDataDeleteSub
        If Me.IsDatabaseMSSQL Then
            OutputFile.WriteLine("        Public Sub Delete()")
            OutputFile.WriteLine("            Dim storedProcedure As String = " + Chr(34) + "sp_" + TableName + "_Delete" + Chr(34))
            OutputFile.WriteLine("            Dim cmd As New SqlClient.SqlCommand")
            OutputFile.WriteLine("            Dim conn As New SqlClient.SqlConnection")
            OutputFile.WriteLine("            Dim ConnectionString As String = GetConnectString()")
            OutputFile.WriteLine("")
            OutputFile.WriteLine("            conn.ConnectionString = ConnectionString")
            OutputFile.WriteLine("            cmd.CommandType = CommandType.StoredProcedure")
            OutputFile.WriteLine("            cmd.Connection = conn")
            OutputFile.WriteLine("            cmd.CommandText = storedProcedure")
            OutputFile.WriteLine("            cmd.Parameters.Add(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ", SqlDbType.Int)")
            OutputFile.WriteLine("            cmd.Parameters(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ").Value = Me.m_" + (VBFunctions.VBName(PrimaryKey.ToLower())))

            OutputFile.WriteLine("")
            OutputFile.WriteLine("            Try")
            OutputFile.WriteLine("                conn.Open()")
            OutputFile.WriteLine("                cmd.ExecuteNonQuery()")
            OutputFile.WriteLine("            Catch e As Exception")
            OutputFile.WriteLine("                Throw e")
            OutputFile.WriteLine("            End Try")
            OutputFile.WriteLine("            conn.Close()")
            OutputFile.WriteLine("        End Sub" + OutputFile.NewLine)
        Else
            OutputFile.WriteLine("        Public Sub Delete()")
            OutputFile.WriteLine("            Dim storedProcedure As String = " + Chr(34) + "sp_" + TableName + "_Delete" + Chr(34))
            OutputFile.WriteLine("            Dim cmd As New OleDb.OleDbCommand")
            OutputFile.WriteLine("            Dim conn As New OleDb.OleDbConnection")
            OutputFile.WriteLine("            Dim ConnectionString As String = GetConnectString()")
            OutputFile.WriteLine("")
            OutputFile.WriteLine("            conn.ConnectionString = ConnectionString")
            OutputFile.WriteLine("            cmd.CommandType = CommandType.StoredProcedure")
            OutputFile.WriteLine("            cmd.Connection = conn")
            OutputFile.WriteLine("            cmd.CommandText = storedProcedure")
            OutputFile.WriteLine("            cmd.Parameters.Add(" + Chr(34) + PrimaryKey + Chr(34) + ", OleDb.OleDbType.Integer)")
            OutputFile.WriteLine("            cmd.Parameters(" + Chr(34) + PrimaryKey + Chr(34) + ").Value = Me.m_" + (VBFunctions.VBName(PrimaryKey.ToLower())))

            OutputFile.WriteLine("")
            OutputFile.WriteLine("            Try")
            OutputFile.WriteLine("                conn.Open()")
            OutputFile.WriteLine("                cmd.ExecuteNonQuery()")
            OutputFile.WriteLine("            Catch e As Exception")
            OutputFile.WriteLine("                Throw e")
            OutputFile.WriteLine("            End Try")
            OutputFile.WriteLine("            conn.Close()")
            OutputFile.WriteLine("        End Sub" + OutputFile.NewLine)
        End If
    End Sub

    Public Sub CreateInterfaces() Implements LangImplementation.CreateInterfaces
        OutputFile.WriteLine("Namespace " + Me.BusinessNameSpace)
        OutputFile.WriteLine("")
        OutputFile.WriteLine(Chr(9) + "Public Interface ISequence")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "Property Sequence() As Integer")
        OutputFile.WriteLine(Chr(9) + "End Interface")
        OutputFile.WriteLine("")
        OutputFile.WriteLine(Chr(9) + "Public Interface IBusiness")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "Sub Validate()")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "Sub Rollback()")
        OutputFile.WriteLine(Chr(9) + "End Interface")
        OutputFile.WriteLine("End Namespace")
    End Sub

    Public Sub CreateUniversalConnection() Implements LangImplementation.CreateUniversalConnection
        If Me.IsDatabaseMSSQL Then
            If Me.m_AuthenticationType = LangImplementation.AuthenticationTypes.SQLServerAuthentication Then
                OutputFile.WriteLine("Namespace " + Me.DataNameSpace)
                OutputFile.WriteLine("")
                OutputFile.WriteLine(Chr(9) + "Public Class Universal")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "Public Shared Function GetConnectionString() As String")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "' TODO: Need to decide on connection string requirements and pick a method below")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Return " + Chr(34) + "server=" + m_SQLServerName.Trim() + ";database=" + m_SQLDatabaseName.Trim() + ";UID=" + m_SQLUsername.Trim() + ";Password=" + Chr(34) + "+Chr(34)+" + Chr(34) + m_sqlPassword.Trim() + Chr(34) + "+Chr(34)+" + Chr(34) + ";" + Chr(34))
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "' Return ConfigurationManager.ConnectionStrings(" + Chr(34) + "SQLServer" + Chr(34) + ").ConnectionString")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "End Function")
                OutputFile.WriteLine(Chr(9) + "End Class")
                OutputFile.WriteLine("End Namespace")
            ElseIf Me.m_AuthenticationType = LangImplementation.AuthenticationTypes.WindowsAuthentication Then
                OutputFile.WriteLine("Namespace " + Me.DataNameSpace)
                OutputFile.WriteLine("")
                OutputFile.WriteLine(Chr(9) + "Public Class Universal")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "Public Shared Function GetConnectionString() As String")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "' TODO: Need to decide on connection string requirements and pick a method below")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Return " + Chr(34) + "server=" + m_SQLServerName.Trim() + ";database=" + m_SQLDatabaseName.Trim() + ";Trusted_Connection=Yes;")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "' Return ConfigurationManager.ConnectionStrings(" + Chr(34) + "SQLServer" + Chr(34) + ").ConnectionString")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "End Function")
                OutputFile.WriteLine(Chr(9) + "End Class")
                OutputFile.WriteLine("End Namespace")
            End If
        Else
            OutputFile.WriteLine("Namespace " + Me.DataNameSpace)
            OutputFile.WriteLine("")
            OutputFile.WriteLine(Chr(9) + "Public Class Universal")
            OutputFile.WriteLine(Chr(9) + Chr(9) + "Public Shared Function GetConnectionString() As String")
            OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "' TODO: Need to decide on connection string requirements and pick a method below")
            OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "Return " + Chr(34) + "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + TheSQLObject.AccessFileName + "" + Chr(34))
            OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "' Return ConfigurationManager.ConnectionStrings(" + Chr(34) + "DBServer" + Chr(34) + ").ConnectionString")
            OutputFile.WriteLine(Chr(9) + Chr(9) + "End Function")
            OutputFile.WriteLine(Chr(9) + "End Class")
            OutputFile.WriteLine("End Namespace")
        End If
    End Sub

    Public Sub CreateDataFooter() Implements LangImplementation.CreateDataFooter
        OutputFile.WriteLine("        End Class")
        OutputFile.WriteLine("#End Region")
        OutputFile.WriteLine("    End Namespace")
    End Sub

    Public Sub CreateSortingFunctions(ByVal TableName As String) Implements LangImplementation.CreateSortingFunctions
        Dim Fields As DataTable = SQLObject.GetFields(TableName)
        Dim Rows As DataRow

        OutputFile.WriteLine("#Region "" Enumerated Sort Fields """)
        OutputFile.WriteLine("    Public Enum SortFields")

        For Each Rows In Fields.Rows
            Dim FieldName As String = Rows("Column_Name")

            FieldName = VBName(FieldName)
            If IsFieldSortable(Rows("Type_Name")) Then
                OutputFile.WriteLine("        Sort_" + FieldName)
            End If
        Next

        OutputFile.WriteLine("    End Enum")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("    Public Enum SortType")
        OutputFile.WriteLine("        Ascending = 1")
        OutputFile.WriteLine("        Descending = 2")
        OutputFile.WriteLine("    End Enum")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("#End Region")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("#Region "" Sort Comparers """)
        For Each Rows In Fields.Rows
            Dim FieldName As String = Rows("Column_Name")

            FieldName = VBName(FieldName)
            If IsFieldSortable(Rows("Type_Name")) Then
                OutputFile.WriteLine("    Private Class Comp_" + FieldName)
                OutputFile.WriteLine("        Implements IComparer")
                OutputFile.WriteLine("")
                OutputFile.WriteLine("        Public Function Compare(ByVal x As Object, ByVal y As Object) As Integer Implements System.Collections.IComparer.Compare")
                OutputFile.WriteLine("            Dim " + TableName + "1 As " + Me.BusinessNameSpace + "." + TableName + " = CType(x, " + Me.BusinessNameSpace + "." + TableName + ")")
                OutputFile.WriteLine("            Dim " + TableName + "2 As " + Me.BusinessNameSpace + "." + TableName + " = CType(y, " + Me.BusinessNameSpace + "." + TableName + ")")
                OutputFile.WriteLine("")
                OutputFile.WriteLine("            Try")
                OutputFile.WriteLine("                Return " + TableName + "1." + FieldName + ".CompareTo(" + TableName + "2." + FieldName + ")")
                OutputFile.WriteLine("            Catch ex As Exception")
                OutputFile.WriteLine("                Return 0")
                OutputFile.WriteLine("            End Try")
                OutputFile.WriteLine("        End Function")
                OutputFile.WriteLine("    End Class")
                OutputFile.WriteLine("")
                OutputFile.WriteLine("    Private Class Comp_" + FieldName + "_D")
                OutputFile.WriteLine("        Implements IComparer")
                OutputFile.WriteLine("")
                OutputFile.WriteLine("        Public Function Compare(ByVal x As Object, ByVal y As Object) As Integer Implements System.Collections.IComparer.Compare")
                OutputFile.WriteLine("            Dim " + TableName + "1 As " + Me.BusinessNameSpace + "." + TableName + " = CType(x, " + Me.BusinessNameSpace + "." + TableName + ")")
                OutputFile.WriteLine("            Dim " + TableName + "2 As " + Me.BusinessNameSpace + "." + TableName + " = CType(y, " + Me.BusinessNameSpace + "." + TableName + ")")
                OutputFile.WriteLine("            Dim j As Integer")
                OutputFile.WriteLine("")
                OutputFile.WriteLine("            Try")
                OutputFile.WriteLine("                j = " + TableName + "1." + FieldName + ".CompareTo(" + TableName + "2." + FieldName + ")")
                OutputFile.WriteLine("                If j = 1 Then Return -1")
                OutputFile.WriteLine("                If j = -1 Then Return 1")
                OutputFile.WriteLine("            Catch ex As Exception")
                OutputFile.WriteLine("                j=0")
                OutputFile.WriteLine("            End Try")
                OutputFile.WriteLine("")
                OutputFile.WriteLine("            Return j")
                OutputFile.WriteLine("        End Function")
                OutputFile.WriteLine("    End Class")
                OutputFile.WriteLine("")
            End If
        Next
        OutputFile.WriteLine("#End Region")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("#Region "" Sort Functions """)
        OutputFile.WriteLine("    Public Sub Sort(ByVal SortField As SortFields, ByVal SortMethod As SortType)")
        For Each Rows In Fields.Rows
            Dim FieldName As String = Rows("Column_Name")

            FieldName = VBName(FieldName)
            If IsFieldSortable(Rows("Type_Name")) Then
                OutputFile.WriteLine("        If SortField = SortFields.Sort_" + FieldName + " Then")
                OutputFile.WriteLine("            If SortMethod = SortType.Ascending Then")
                OutputFile.WriteLine("                Me.InnerList.Sort(New Comp_" + FieldName + ")")
                OutputFile.WriteLine("            Else")
                OutputFile.WriteLine("                Me.InnerList.Sort(New Comp_" + FieldName + "_D)")
                OutputFile.WriteLine("            End If")
                OutputFile.WriteLine("        End If")
                OutputFile.WriteLine("")
            End If
        Next
        OutputFile.WriteLine("    End Sub")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("    Public Sub Sort(ByVal SortField As SortFields)")
        OutputFile.WriteLine("        Sort(SortField, SortType.Ascending)")
        OutputFile.WriteLine("    End Sub")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("#End Region")
        OutputFile.WriteLine("")
    End Sub

    Private Function IsFieldSortable(ByVal TypeName As String) As Boolean
        If TypeName.ToLower.EndsWith(" identity") Then
            TypeName = TypeName.Replace(" identity", "")
        End If

        If TypeName = "int" Then Return True
        If TypeName = "int indentity" Then Return True
        If TypeName = "nvarchar" Then Return True
        If TypeName = "varchar" Then Return True
        If TypeName = "char" Then Return True
        If TypeName = "nchar" Then Return True
        If TypeName = "numeric" Then Return True
        If TypeName = "datetime" Then Return True
        If TypeName = "smallint" Then Return True
        If TypeName = "smalldatetime" Then Return True
        If TypeName = "tinyint" Then Return True
        If TypeName = "real" Then Return True
        If TypeName = "float" Then Return True
        If TypeName = "bigint" Then Return True
        If TypeName = "decimal" Then Return True
        If TypeName = "money" Then Return True
        If TypeName = "smallmoney" Then Return True

        Return False
    End Function

    Protected Sub CreateDataSaveSub(ByVal dt As DataTable, ByVal TableName As String, ByVal PrimaryKey As String) Implements LangImplementation.CreateDataSaveSub
        Dim dr As DataRow
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim type As String
        Dim varname As String
        Dim fkdt As DataTable

        fkdt = Me.SQLObject.GetForeignKeys(TableName)

        If Me.IsDatabaseMSSQL Then
            OutputFile.WriteLine("        Public Sub Save()")
            OutputFile.WriteLine("            Dim storedProcedure As String")
            OutputFile.WriteLine("            Dim cmd As New SqlClient.SqlCommand")
            OutputFile.WriteLine("            Dim conn As New SqlClient.SqlConnection")
            OutputFile.WriteLine("            Dim ConnectionString As String = GetConnectString()")
            OutputFile.WriteLine("")
            If fkdt.Rows.Count > 0 Then
                ndx = 0
                While (ndx < fkdt.Rows.Count)
                    dr = fkdt.Rows(ndx)
                    OutputFile.WriteLine("            If Not (Me.my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + " Is Nothing) Then")
                    OutputFile.WriteLine("                my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + ".Save()")
                    OutputFile.WriteLine("            End If")
                    OutputFile.WriteLine("")
                    ndx = ndx + 1
                End While
            End If
            OutputFile.WriteLine("")
            OutputFile.WriteLine("            If (m_isdirty) Then")
            OutputFile.WriteLine("                conn.ConnectionString = ConnectionString")
            OutputFile.WriteLine("                cmd.Connection = conn")
            OutputFile.WriteLine("                cmd.CommandType = CommandType.StoredProcedure")
            OutputFile.WriteLine("")

            For ndx = 1 To count
                dr = dt.Rows(ndx - 1)
                type = dr("TYPE_NAME")
                If type.ToLower.EndsWith(" identity") Then
                    type = type.Replace(" identity", "")
                End If
                varname = dr("COLUMN_NAME")
                If type = "int identity" Then type = "Int"
                If type = "int" Then type = "Int"
                If type = "nvarchar" Then type = "NVarChar"
                If type = "varchar" Then type = "VarChar"
                If type = "datetime" Then type = "DateTime"
                If type = "numeric" Then type = "Decimal"
                If type = "bit" Then type = "Bit"
                If type = "money" Then type = "Money"
                If type = "text" Then type = "Text"
                If type = "real" Then type = "Real"
                If type = "float" Then type = "Float"
                If type = "char" Then type = "Char"
                If type = "tinyint" Then type = "TinyInt"
                If type = "smallint" Then type = "SmallInt"
                If type = "smalldatetime" Then type = "SmallDateTime"
                OutputFile.WriteLine("                cmd.Parameters.Add(" + Chr(34) + "@" + VBName(varname) + Chr(34) + ", SqlDbType." + type + ")")
                If varname = PrimaryKey Then Continue For
                If type <> "image" Then
                    OutputFile.WriteLine("                If Me.m_" + VBFunctions.VBName(varname.ToLower()) + " <> Nothing Then")
                Else
                    OutputFile.WriteLine("                If Me.m_" + VBFunctions.VBName(varname.ToLower()) + " IsNot Nothing Then")
                End If
                OutputFile.WriteLine("                    cmd.Parameters(" + Chr(34) + "@" + VBFunctions.VBName(varname) + Chr(34) + ").Value = Me.m_" + VBFunctions.VBName(varname.ToLower()))
                OutputFile.WriteLine("                Else")
                OutputFile.Write("                    cmd.Parameters(" + Chr(34) + "@" + VBFunctions.VBName(varname) + Chr(34) + ").Value = ")
                If type = "NVarChar" Or type = "VarChar" Or type = "Char" Then
                    OutputFile.WriteLine(Chr(34) + Chr(34))
                End If
                If type = "Bit" Then
                    OutputFile.WriteLine("False")
                End If
                If type = "DateTime" Then
                    OutputFile.WriteLine("System.DBNull.Value")
                End If
                If type = "Money" Or type = "Decimal" Or type = "Float" Then
                    OutputFile.WriteLine("0.0")
                End If
                If type = "TinyInt" Or type = "SmallInt" Or type = "Int" Then
                    OutputFile.WriteLine("0")
                End If

                If type <> "Char" AndAlso type <> "Decimal" AndAlso type <> "TinyInt" AndAlso type <> "SmallInt" AndAlso type <> "Int" AndAlso type <> "Bit" AndAlso type <> "Money" AndAlso type <> "DateTime" AndAlso type <> "VarChar" AndAlso type <> "NVarChar" AndAlso type <> "Float" Then
                    OutputFile.WriteLine("Nothing")
                End If
                OutputFile.WriteLine("                End If")
                OutputFile.WriteLine("")
            Next

            'OutputFile.WriteLine("                If Me.m_" + VBFunctions.VBName(PrimaryKey.ToLower()) + " > 0 Then")
            OutputFile.WriteLine("                If Not Me.m_isFresh Then")
            OutputFile.WriteLine("                    storedProcedure = " + Chr(34) + "sp_" + TableName + "_Update" + Chr(34))
            OutputFile.WriteLine("                    cmd.CommandText=storedProcedure")
            OutputFile.WriteLine("")
            OutputFile.WriteLine("                    cmd.Parameters(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ").Value = Me.m_" + VBFunctions.VBName(PrimaryKey.ToLower()))
            OutputFile.WriteLine("                    cmd.Parameters(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ").Direction = ParameterDirection.Input")
            OutputFile.WriteLine("                    Try")
            OutputFile.WriteLine("                        conn.Open()")
            OutputFile.WriteLine("                        cmd.ExecuteNonQuery()")
            OutputFile.WriteLine("                    Catch e As Exception")
            OutputFile.WriteLine("                        Throw e")
            OutputFile.WriteLine("                    End Try")
            OutputFile.WriteLine("                    conn.Close()")
            OutputFile.WriteLine("                Else")
            OutputFile.WriteLine("                    storedProcedure = " + Chr(34) + "sp_" + TableName + "_Insert" + Chr(34))
            OutputFile.WriteLine("                    cmd.CommandText=storedProcedure")
            OutputFile.WriteLine("")
            OutputFile.WriteLine("                    cmd.Parameters(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ").Value = Me.m_" + VBFunctions.VBName(PrimaryKey.ToLower()))
            OutputFile.WriteLine("                    If IsIdentityTable() Then")
            OutputFile.WriteLine("                        cmd.Parameters(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ").Direction = ParameterDirection.Output")
            OutputFile.WriteLine("                    Else")
            OutputFile.WriteLine("                        cmd.Parameters(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ").Direction = ParameterDirection.Input")
            OutputFile.WriteLine("                    End If")
            OutputFile.WriteLine("                    Try")
            OutputFile.WriteLine("                        conn.Open()")
            OutputFile.WriteLine("                        cmd.ExecuteNonQuery()")
            OutputFile.WriteLine("                    Catch e As Exception")
            OutputFile.WriteLine("                        Throw e")
            OutputFile.WriteLine("                    End Try")
            OutputFile.WriteLine("                    If IsIdentityTable() Then")
            'Dim dr As DataRow
            'Dim ndx As Integer
            'Dim count As Integer = dt.Rows.Count
            'Dim type As String
            'Dim varname As String
            'Dim Isidentity As Boolean = False

            'OutputFile.WriteLine("#Region " + Chr(34) + "Properties" + Chr(34))

            'For ndx = 1 To count
            '    dr = dt.Rows(ndx - 1)
            '    type = dr("TYPE_NAME")
            '    varname = dr("COLUMN_NAME")
            '    If type.ToLower.EndsWith("identity") Then
            '        Isidentity = True
            '    End If
            '    OutputFile.WriteLine("        Public Property " + VBFunctions.GetProperName(varname) + "() As " + Me.GetSQLType(type))
            '    OutputFile.WriteLine("            Get")
            '    If Me.m_DoEncryption And Me.GetSQLType(type) = "String" Then
            '        OutputFile.WriteLine("             Dim oES As New Encryption64")
            '    End If
            '    If Me.m_DoEncryption And Me.GetSQLType(type) = "String" Then
            '        OutputFile.WriteLine("                Return oES.Decrypt(Me.m_" + VBFunctions.VBName(varname.ToLower()) + "," + Chr(34) + Me.m_EncryptionKey + Chr(34) + ")")
            '    Else
            '        OutputFile.WriteLine("                Return Me.m_" + VBFunctions.VBName(varname.ToLower()))
            '    End If

            '    OutputFile.WriteLine("            End Get")
            '    OutputFile.WriteLine("            Set(ByVal Value As " + Me.GetSQLType(type) + ")")
            '    If Me.m_DoEncryption And Me.GetSQLType(type) = "String" Then
            '        OutputFile.WriteLine("             Dim oES As New Encryption64")
            '    End If
            '    OutputFile.WriteLine("                Me.m_isDirty = True")
            '    If Me.m_DoEncryption And Me.GetSQLType(type) = "String" Then
            '        OutputFile.WriteLine("                Me.m_" + VBFunctions.VBName(varname.ToLower()) + " = oES.Encrypt(Value," + Chr(34) + Me.m_EncryptionKey + Chr(34) + ")")
            '    Else
            '        OutputFile.WriteLine("                Me.m_" + VBFunctions.VBName(varname.ToLower()) + " = Value")
            '    End If

            '    OutputFile.WriteLine("            End Set")
            '    OutputFile.WriteLine("        End Property" + OutputFile.NewLine)
            'Next
            OutputFile.Write("                        Me.m_" + VBFunctions.VBName(PrimaryKey.ToLower()) + " = CType(cmd.Parameters(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ").Value, ")
            For ndx = 1 To count
                dr = dt.Rows(ndx - 1)
                If CStr(dr("COLUMN_NAME")).ToLower = PrimaryKey.ToLower Then
                    OutputFile.WriteLine(GetSQLType(dr("TYPE_NAME")) + ")")
                    Exit For
                End If
            Next
            OutputFile.WriteLine("                    End If")
            OutputFile.WriteLine("                    conn.Close()")
            OutputFile.WriteLine("                End If")
            OutputFile.WriteLine("            End If")
            OutputFile.WriteLine("        End Sub")
            OutputFile.WriteLine("")
        Else
            OutputFile.WriteLine("        Public Sub Save()")
            OutputFile.WriteLine("            Dim storedProcedure As String")
            OutputFile.WriteLine("            Dim cmd As New OleDb.OleDbCommand")
            OutputFile.WriteLine("            Dim conn As New OleDb.OleDbConnection")
            OutputFile.WriteLine("            Dim ConnectionString As String = GetConnectString()")
            OutputFile.WriteLine("")
            If fkdt.Rows.Count > 0 Then
                ndx = 0
                While (ndx < fkdt.Rows.Count)
                    dr = fkdt.Rows(ndx)
                    OutputFile.WriteLine("            If Not (Me.my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + " Is Nothing) Then")
                    OutputFile.WriteLine("                my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + ".Save()")
                    OutputFile.WriteLine("            End If")
                    OutputFile.WriteLine("")
                    ndx = ndx + 1
                End While
            End If
            OutputFile.WriteLine("")
            OutputFile.WriteLine("            If (m_isdirty) Then")
            OutputFile.WriteLine("                conn.ConnectionString = ConnectionString")
            OutputFile.WriteLine("                cmd.Connection = conn")
            OutputFile.WriteLine("                cmd.CommandType = CommandType.StoredProcedure")
            OutputFile.WriteLine("")

            For ndx = 1 To count
                dr = dt.Rows(ndx - 1)
                type = dr("TYPE_NAME")
                If type.ToLower.EndsWith(" identity") Then
                    type = type.Replace(" identity", "")
                End If
                varname = dr("COLUMN_NAME")
                If type = "int identity" Then type = "Integer"
                If type = "int" Then type = "Integer"
                If type = "nchar" Then type = "VarWChar"
                If type = "nvarchar" Then type = "VarWChar"
                If type = "varchar" Then type = "VarWChar"
                If type = "datetime" Then type = "Date"
                If type = "numeric" Then type = "Numeric"
                If type = "bit" Then type = "Boolean"
                If type = "money" Then type = "Numeric"
                If type = "text" Then type = "Text"
                If type = "real" Then type = "Double"
                If type = "float" Then type = "Single"
                If type = "char" Then type = "Char"
                If type = "tinyint" Then type = "SmallInt"
                If type = "smallint" Then type = "SmallInt"
                If type = "smalldatetime" Then type = "Date"
                If varname = PrimaryKey And SQLObject.IsIdentityField(TableName, varname) Then Continue For
                OutputFile.WriteLine("                cmd.Parameters.Add(" + Chr(34) + varname + Chr(34) + ", OleDb.OleDbType." + type + ")")

                If type <> "image" Then
                    OutputFile.WriteLine("                If Me.m_" + VBFunctions.VBName(varname.ToLower()) + " <> Nothing Then")
                Else
                    OutputFile.WriteLine("                If Me.m_" + VBFunctions.VBName(varname.ToLower()) + " IsNot Nothing Then")
                End If
                OutputFile.WriteLine("                    cmd.Parameters(" + Chr(34) + varname + Chr(34) + ").Value = Me.m_" + VBFunctions.VBName(varname.ToLower()))
                OutputFile.WriteLine("                Else")
                OutputFile.Write("                    cmd.Parameters(" + Chr(34) + varname + Chr(34) + ").Value = ")
                If type = "VarWChar" Or type = "NVarChar" Or type = "VarChar" Or type = "Char" Then
                    OutputFile.WriteLine(Chr(34) + Chr(34))
                End If
                If type = "Bit" Or type.ToUpper = "BOOLEAN" Then
                    OutputFile.WriteLine("False")
                End If
                If type = "DateTime" Or type.ToUpper = "DATE" Then
                    OutputFile.WriteLine("System.DBNull.Value")
                End If
                If type.ToUpper = "NUMERIC" Or type = "Money" Or type.ToUpper = "DECIMAL" Or type = "Float" Or type.ToUpper = "SINGLE" Then
                    OutputFile.WriteLine("0.0")
                End If
                If type = "TinyInt" Or type = "SmallInt" Or type = "Int" Or type.ToUpper = "INTEGER" Then
                    OutputFile.WriteLine("0")
                End If

                If type.ToUpper <> "NUMERIC" And type.ToUpper <> "DATE" And type.ToUpper <> "SINGLE" And type.ToUpper <> "DECIMAL" And type.ToUpper <> "INTEGER" And type.ToUpper <> "BOOLEAN" And type <> "VarWChar" And type <> "Char" AndAlso type <> "Decimal" AndAlso type <> "TinyInt" AndAlso type <> "SmallInt" AndAlso type <> "Int" AndAlso type <> "Bit" AndAlso type <> "Money" AndAlso type <> "DateTime" AndAlso type <> "VarChar" AndAlso type <> "NVarChar" AndAlso type <> "Float" Then
                    OutputFile.WriteLine("Nothing")
                End If
                OutputFile.WriteLine("                End If")
                OutputFile.WriteLine("")
            Next

            OutputFile.WriteLine("                If Not Me.m_isFresh Then")
            'OutputFile.WriteLine("                If Me.m_" + VBFunctions.VBName(PrimaryKey.ToLower()) + " > 0 Then")
            OutputFile.WriteLine("                    storedProcedure = " + Chr(34) + "sp_" + TableName + "_Update" + Chr(34))
            OutputFile.WriteLine("                    cmd.CommandText=storedProcedure")
            OutputFile.WriteLine("")
            OutputFile.WriteLine("                    cmd.Parameters.Add(" + Chr(34) + PrimaryKey + Chr(34) + ", OleDb.OleDbType.Integer)")
            OutputFile.WriteLine("                    cmd.Parameters(" + Chr(34) + PrimaryKey + Chr(34) + ").Value = Me.m_" + VBFunctions.VBName(PrimaryKey.ToLower()))
            'OutputFile.WriteLine("                    cmd.Parameters(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ").Direction = ParameterDirection.Input")
            OutputFile.WriteLine("                    Try")
            OutputFile.WriteLine("                        conn.Open()")
            OutputFile.WriteLine("                        cmd.ExecuteNonQuery()")
            OutputFile.WriteLine("                    Catch e As Exception")
            OutputFile.WriteLine("                        Throw e")
            OutputFile.WriteLine("                    End Try")
            OutputFile.WriteLine("                    conn.Close()")
            OutputFile.WriteLine("                Else")
            OutputFile.WriteLine("                    Dim dai As New OleDb.OleDbDataAdapter")
            OutputFile.WriteLine("                    Dim idset As New DataSet")
            OutputFile.WriteLine("                    storedProcedure = " + Chr(34) + "sp_" + TableName + "_Insert" + Chr(34))
            OutputFile.WriteLine("                    cmd.CommandText=storedProcedure")
            OutputFile.WriteLine("")
            'OutputFile.WriteLine("                    If IsIdentityTable() Then")
            'OutputFile.WriteLine("                        cmd.Parameters(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ").Direction = ParameterDirection.Output")
            'OutputFile.WriteLine("                    Else")
            'OutputFile.WriteLine("                        cmd.Parameters(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ").Direction = ParameterDirection.Input")
            'OutputFile.WriteLine("                    End If")

            'OutputFile.WriteLine("                    cmd.Parameters(" + Chr(34) + PrimaryKey + Chr(34) + ").Value = Me.m_" + VBFunctions.VBName(PrimaryKey.ToLower()))
            'OutputFile.WriteLine("                    cmd.Parameters(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ").Direction = ParameterDirection.Output")
            OutputFile.WriteLine("                    Try")
            OutputFile.WriteLine("                        conn.Open()")
            OutputFile.WriteLine("                        cmd.ExecuteNonQuery()")
            OutputFile.WriteLine("                    Catch e As Exception")
            OutputFile.WriteLine("                        Throw e")
            OutputFile.WriteLine("                    End Try")
            OutputFile.WriteLine("                   ")
            OutputFile.WriteLine("                    cmdGetIdentity = New OleDb.OleDbCommand")
            OutputFile.WriteLine("                    cmdGetIdentity.CommandText = ""SELECT @@IDENTITY""")
            OutputFile.WriteLine("                    cmdGetIdentity.Connection = conn")
            OutputFile.WriteLine("                    dai.SelectCommand = cmdGetIdentity")
            OutputFile.WriteLine("                    dai.Fill(idset)")
            OutputFile.Write("                        Me.m_" + VBFunctions.VBName(PrimaryKey.ToLower()) + " = CType(cmd.Parameters(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ").Value, ")
            For ndx = 1 To count
                dr = dt.Rows(ndx - 1)
                If CStr(dr("COLUMN_NAME")).ToLower = PrimaryKey.ToLower Then
                    OutputFile.WriteLine(GetSQLType(dr("TYPE_NAME")) + ")")
                    Exit For
                End If
            Next
            OutputFile.WriteLine("                    Me.m_" + VBFunctions.VBName(PrimaryKey.ToLower()) + " = CType(idset.Tables(0).Rows(0)(0), Integer)")
            OutputFile.WriteLine("                    conn.Close()")
            OutputFile.WriteLine("                End If")
            OutputFile.WriteLine("            End If")
            OutputFile.WriteLine("        End Sub")
            OutputFile.WriteLine("")
        End If
    End Sub

    Public Function GetSQLType(ByVal Type As String) As String Implements LangImplementation.GetSQLType
        If Type.EndsWith(" identity") Then Type = Type.Replace(" identity", "")
        If Type = "binary" Or Type = "image" Or Type = "timestamp" Or Type = "varbinary" Then
            Return "Byte ()"
        End If
        If Type = "int identity" Or Type = "int" Then
            Return "Int32"
        End If
        If Type = "smallint" Then
            Return "Int16"
        End If
        If Type = "bigint" Then
            Return "Int64"
        End If
        If Type = "nvarchar" Or Type = "varchar" Or Type = "char" Or _
                Type = "nchar" Or Type = "ntext" Or Type = "text" Then
            Return "String"
        End If
        If Type = "decimal" Then
            Return "Decimal"
        End If
        If Type = "datetime" Then
            Return "System.DateTime"
        End If
        If Type = "numeric" Then
            Return "Decimal"
        End If
        If Type = "bit" Then
            Return "Boolean"
        End If
        If Type = "money" Or Type = "smallmoney" Then
            Return "Decimal"
        End If
        If Type = "text" Then
            Return "String"
        End If
        If Type = "smalldatetime" Then
            Return "System.DateTime"
        End If
        If Type = "real" Then
            Return "Single"
        End If
        If Type = "tinyint" Then
            Return "Byte"
        End If
        If Type = "float" Then
            Return "Double"
        End If
        If Type = "uniqueidentifier" Then
            Return "GUID"
        End If
        Return Type
    End Function

End Class
