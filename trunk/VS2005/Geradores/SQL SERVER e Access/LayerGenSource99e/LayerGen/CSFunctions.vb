Public Class CSFunctions
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

    Public Property AuthenticationType() As LangImplementation.AuthenticationTypes Implements LangImplementation.AuthenticationType
        Get
            Return m_AuthenticationType
        End Get
        Set(ByVal value As LangImplementation.AuthenticationTypes)
            m_AuthenticationType = value
        End Set
    End Property

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
#End Region

    Public Sub CreateBusinessGetAll(ByVal TableName As String) Implements LangImplementation.CreateBusinessGetAll
        OutputFile.WriteLine("         public void GetAll()")
        OutputFile.WriteLine("         {")
        OutputFile.WriteLine("             DataTable dt = " + Me.DataNameSpace + "." + TableName + ".GetAll();")
        OutputFile.WriteLine("             if ((dt != null)) {")
        OutputFile.WriteLine("                 this.Load(dt.Rows);")
        OutputFile.WriteLine("             }")
        OutputFile.WriteLine("         }")
        OutputFile.WriteLine("        ")
    End Sub

    Public Sub CreateDataGetByFKs(ByVal TableName As String) Implements LangImplementation.CreateDataGetByFKs
        Dim dt As DataTable = SQLObject.GetForeignKeys(TableName)
        Dim ndx As Integer = 0
        Dim dr As DataRow

        If dt.Rows.Count = 0 Then Exit Sub

        If Me.IsDatabaseMSSQL Then
            While (ndx < dt.Rows.Count)
                dr = dt.Rows(ndx)
                OutputFile.WriteLine("")
                OutputFile.WriteLine("// Get all records which match the passed value of " + dr("PKCOLUMN_NAME"))
                OutputFile.WriteLine("        public static DataTable GetBy" + dr("PKCOLUMN_NAME") + "(int " + dr("PKCOLUMN_NAME") + " ) {")
                OutputFile.WriteLine("            string storedProcedure = " + Chr(34) + "sp_" + TableName + "_GetBy" + dr("PKCOLUMN_NAME") + Chr(34) + ";")
                OutputFile.WriteLine("            System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();")
                OutputFile.WriteLine("            string ConnectionString = GetConnectionString();")
                OutputFile.WriteLine("            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection();")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("            conn.ConnectionString = ConnectionString;")
                OutputFile.WriteLine("            cmd.CommandType = CommandType.StoredProcedure;")
                OutputFile.WriteLine("            cmd.Connection = conn;")
                OutputFile.WriteLine("            cmd.CommandText = storedProcedure;")
                OutputFile.WriteLine("            cmd.Parameters.Add(" + Chr(34) + "@" + dr("PKCOLUMN_NAME") + Chr(34) + ", SqlDbType.Int);")
                OutputFile.WriteLine("            cmd.Parameters[" + Chr(34) + "@" + dr("PKCOLUMN_NAME") + Chr(34) + "].Value = " + dr("PKCOLUMN_Name") + ";")

                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("            try {")
                OutputFile.WriteLine("                DataSet ds;")
                OutputFile.WriteLine("                System.Data.SqlClient.SqlDataAdapter da;")
                OutputFile.WriteLine("                DataTable Table = null;")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("                conn.Open();")
                OutputFile.WriteLine("                da = new System.Data.SqlClient.SqlDataAdapter();")
                OutputFile.WriteLine("                da.SelectCommand = cmd;")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("                ds = new DataSet();")
                OutputFile.WriteLine("                da.Fill(ds);")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("                if (ds.Tables.Count > 0) {")
                OutputFile.WriteLine("                   if (ds.Tables[0].Rows.Count > 0) {")
                OutputFile.WriteLine("                        Table = ds.Tables[0];")
                OutputFile.WriteLine("                   }")
                OutputFile.WriteLine("                }")
                OutputFile.WriteLine("                conn.Close();")
                OutputFile.WriteLine("                return Table;")
                OutputFile.WriteLine("             }")
                OutputFile.WriteLine("             catch (Exception ) {")
                OutputFile.WriteLine("                conn.Close();")
                OutputFile.WriteLine("                throw;")
                OutputFile.WriteLine("            }")
                OutputFile.WriteLine("            conn.Close();")
                OutputFile.WriteLine("        }")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("")
                ndx = ndx + 1
            End While
        Else
            While (ndx < dt.Rows.Count)
                dr = dt.Rows(ndx)
                OutputFile.WriteLine("")
                OutputFile.WriteLine("// Get all records which match the passed value of " + dr("PKCOLUMN_NAME"))
                OutputFile.WriteLine("        public static DataTable GetBy" + dr("PKCOLUMN_NAME") + "(int " + dr("PKCOLUMN_NAME") + " ) {")
                OutputFile.WriteLine("            string storedProcedure = " + Chr(34) + "sp_" + TableName + "_GetBy" + dr("PKCOLUMN_NAME") + Chr(34) + ";")
                OutputFile.WriteLine("            System.Data.OleDb.OleDbCommand cmd = new System.Data.OleDb.OleDbCommand();")
                OutputFile.WriteLine("            string ConnectionString = GetConnectionString();")
                OutputFile.WriteLine("            System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection();")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("            conn.ConnectionString = ConnectionString;")
                OutputFile.WriteLine("            cmd.CommandType = CommandType.StoredProcedure;")
                OutputFile.WriteLine("            cmd.Connection = conn;")
                OutputFile.WriteLine("            cmd.CommandText = storedProcedure;")
                OutputFile.WriteLine("            cmd.Parameters.Add(" + Chr(34) + dr("PKCOLUMN_NAME") + Chr(34) + ", System.Data.OleDb.OleDbType.Integer);")
                OutputFile.WriteLine("            cmd.Parameters[" + Chr(34) + dr("PKCOLUMN_NAME") + Chr(34) + "].Value = " + dr("PKCOLUMN_Name") + ";")

                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("            try {")
                OutputFile.WriteLine("                DataSet ds;")
                OutputFile.WriteLine("                System.Data.OleDb.OleDbDataAdapter da;")
                OutputFile.WriteLine("                DataTable Table = null;")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("                conn.Open();")
                OutputFile.WriteLine("                da = new System.Data.OleDb.OleDbDataAdapter();")
                OutputFile.WriteLine("                da.SelectCommand = cmd;")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("                ds = new DataSet();")
                OutputFile.WriteLine("                da.Fill(ds);")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("                if (ds.Tables.Count > 0) {")
                OutputFile.WriteLine("                   if (ds.Tables[0].Rows.Count > 0) {")
                OutputFile.WriteLine("                        Table = ds.Tables[0];")
                OutputFile.WriteLine("                   }")
                OutputFile.WriteLine("                }")
                OutputFile.WriteLine("                conn.Close();")
                OutputFile.WriteLine("                return Table;")
                OutputFile.WriteLine("             }")
                OutputFile.WriteLine("             catch (Exception ) {")
                OutputFile.WriteLine("                conn.Close();")
                OutputFile.WriteLine("                throw;")
                OutputFile.WriteLine("            }")
                OutputFile.WriteLine("            conn.Close();")
                OutputFile.WriteLine("        }")
                OutputFile.WriteLine("        ")
                OutputFile.WriteLine("")
                ndx = ndx + 1
            End While
        End If
    End Sub

    Public Sub CreateBusinessFKs(ByVal TableName As String) Implements LangImplementation.CreateBusinessFKs
        Dim dt As DataTable = SQLObject.GetForeignKeys(TableName)
        Dim ndx As Integer = 0
        Dim dr As DataRow

        If dt.Rows.Count = 0 Then Exit Sub

        While (ndx < dt.Rows.Count)
            dr = dt.Rows(ndx)
            OutputFile.WriteLine("         public void GetBy" + dr("PKCOLUMN_NAME") + "(int " + dr("PKCOLUMN_NAME") + ")")
            OutputFile.WriteLine("         {")
            OutputFile.WriteLine("             DataTable dt = " + Me.DataNameSpace + "." + TableName + ".GetBy" + dr("PKCOLUMN_NAME") + "(" + dr("PKCOLUMN_NAME") + ");")
            OutputFile.WriteLine("             if ((dt != null)) {")
            OutputFile.WriteLine("                 this.Load(dt.Rows);")
            OutputFile.WriteLine("             }")
            OutputFile.WriteLine("         }")
            OutputFile.WriteLine("        ")
            ndx = ndx + 1
        End While
    End Sub

    Public Sub CreateSortingFunctions(ByVal TableName As String) Implements LangImplementation.CreateSortingFunctions
        Dim Fields As DataTable = SQLObject.GetFields(TableName)
        Dim Rows As DataRow
        Dim StringFile As New System.IO.StringWriter()

        OutputFile.WriteLine("#region "" Enumerated Sort Fields """)
        OutputFile.WriteLine("    public enum SortFields")
        OutputFile.WriteLine("    {")

        For Each Rows In Fields.Rows
            Dim FieldName As String = Rows("Column_Name")

            FieldName = VBFunctions.VBName(FieldName)
            If IsFieldSortable(Rows("Type_Name")) Then
                StringFile.WriteLine("        Sort_" + FieldName + ",")
            End If
        Next
        OutputFile.WriteLine(StringFile.ToString.TrimEnd().TrimEnd(","))
        OutputFile.WriteLine("    }")

        OutputFile.WriteLine("")
        OutputFile.WriteLine("    public enum SortType")
        OutputFile.WriteLine("    {")
        OutputFile.WriteLine("        Ascending = 1,")
        OutputFile.WriteLine("        Descending = 2")
        OutputFile.WriteLine("    }")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("#endregion")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("#region "" Sort Comparers """)
        For Each Rows In Fields.Rows
            Dim FieldName As String = Rows("Column_Name")

            'FieldName = VBFunctions.VBName(FieldName)
            FieldName = VBFunctions.GetProperName(FieldName)

            If IsFieldSortable(Rows("Type_Name")) Then
                OutputFile.WriteLine("    private class Comp_" + FieldName + " : IComparer")
                OutputFile.WriteLine("    {")
                OutputFile.WriteLine("")
                OutputFile.WriteLine("        public int Compare(Object x, Object y)")
                OutputFile.WriteLine("        {")
                OutputFile.WriteLine("            " + Me.BusinessNameSpace + "." + TableName + " " + TableName + "1 = (" + Me.BusinessNameSpace + "." + TableName + ")x;")
                OutputFile.WriteLine("            " + Me.BusinessNameSpace + "." + TableName + " " + TableName + "2 = (" + Me.BusinessNameSpace + "." + TableName + ")y;")
                OutputFile.WriteLine("")
                OutputFile.WriteLine("            try {")
                OutputFile.WriteLine("                return " + TableName + "1." + FieldName + ".CompareTo(" + TableName + "2." + FieldName + ");")
                OutputFile.WriteLine("            } catch (Exception) {")
                OutputFile.WriteLine("                return 0;")
                OutputFile.WriteLine("            }")
                OutputFile.WriteLine("        }")
                OutputFile.WriteLine("    }")
                OutputFile.WriteLine("")
                OutputFile.WriteLine("    private class Comp_" + FieldName + "_D : IComparer")
                OutputFile.WriteLine("    {")
                OutputFile.WriteLine("")
                OutputFile.WriteLine("        public int Compare(Object x, Object y)")
                OutputFile.WriteLine("        {")
                OutputFile.WriteLine("            " + Me.BusinessNameSpace + "." + TableName + " " + TableName + "1 = (" + Me.BusinessNameSpace + "." + TableName + ")x;")
                OutputFile.WriteLine("            " + Me.BusinessNameSpace + "." + TableName + " " + TableName + "2 = (" + Me.BusinessNameSpace + "." + TableName + ")y;")
                OutputFile.WriteLine("            int j;")
                OutputFile.WriteLine("")
                OutputFile.WriteLine("            try {")
                OutputFile.WriteLine("                j = " + TableName + "1." + FieldName + ".CompareTo(" + TableName + "2." + FieldName + ");")
                OutputFile.WriteLine("                if (j==1) return -1;")
                OutputFile.WriteLine("                if (j==-1) return 1;")
                OutputFile.WriteLine("            } catch (Exception) {")
                OutputFile.WriteLine("                j=0;")
                OutputFile.WriteLine("            }")
                OutputFile.WriteLine("")
                OutputFile.WriteLine("            return j;")
                OutputFile.WriteLine("        }")
                OutputFile.WriteLine("    }")
                OutputFile.WriteLine("")
            End If
        Next
        OutputFile.WriteLine("#endregion")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("#region "" Sort Functions """)
        OutputFile.WriteLine("    public void Sort(SortFields SortField, SortType SortMethod)")
        OutputFile.WriteLine("    {")
        For Each Rows In Fields.Rows
            Dim FieldName As String = Rows("Column_Name")
            Dim origName = VBFunctions.VBName(FieldName)

            'FieldName = VBFunctions.VBName(FieldName)
            FieldName = VBFunctions.GetProperName(FieldName)
            'FieldName = FixCSName(FieldName)
            'TableName = VBFunctions.GetProperName(TableName)
            If IsFieldSortable(Rows("Type_Name")) Then
                OutputFile.WriteLine("        if (SortField == SortFields.Sort_" + origName + ") {")
                OutputFile.WriteLine("            if (SortMethod == SortType.Ascending) {")
                OutputFile.WriteLine("                this.InnerList.Sort(new Comp_" + FieldName + "());")
                OutputFile.WriteLine("            } else {")
                OutputFile.WriteLine("                this.InnerList.Sort(new Comp_" + FieldName + "_D());")
                OutputFile.WriteLine("            }")
                OutputFile.WriteLine("        }")
                OutputFile.WriteLine("")
            End If
        Next
        OutputFile.WriteLine("    }")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("    public void Sort(SortFields SortField)")
        OutputFile.WriteLine("    {")
        OutputFile.WriteLine("        Sort(SortField, SortType.Ascending);")
        OutputFile.WriteLine("    }")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("#endregion")
        OutputFile.WriteLine("")
    End Sub

    Public Sub CreateDataGetAll(ByVal TableName As String) Implements LangImplementation.CreateDataGetAll
        If Me.IsDatabaseMSSQL Then
            OutputFile.WriteLine("")
            OutputFile.WriteLine("        public static DataTable GetAll()")
            OutputFile.WriteLine("        {")
            OutputFile.WriteLine("            string storedProcedure = " + Chr(34) + "sp_" + TableName + "_GetAll" + Chr(34) + ";")
            OutputFile.WriteLine("            System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();")
            OutputFile.WriteLine("            string ConnectionString = GetConnectionString();")
            OutputFile.WriteLine("            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection();")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("            conn.ConnectionString = ConnectionString;")
            OutputFile.WriteLine("            cmd.CommandType = CommandType.StoredProcedure;")
            OutputFile.WriteLine("            cmd.Connection = conn;")
            OutputFile.WriteLine("            cmd.CommandText = storedProcedure;")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("            try {")
            OutputFile.WriteLine("                DataSet ds;")
            OutputFile.WriteLine("                System.Data.SqlClient.SqlDataAdapter da;")
            OutputFile.WriteLine("                DataTable Table = null;")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("                conn.Open();")
            OutputFile.WriteLine("                da = new System.Data.SqlClient.SqlDataAdapter();")
            OutputFile.WriteLine("                da.SelectCommand = cmd;")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("                ds = new DataSet();")
            OutputFile.WriteLine("                da.Fill(ds);")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("                if (ds.Tables.Count > 0) {")
            OutputFile.WriteLine("                   if (ds.Tables[0].Rows.Count > 0) {")
            OutputFile.WriteLine("                        Table = ds.Tables[0]; ")
            OutputFile.WriteLine("                   }")
            OutputFile.WriteLine("                }")
            OutputFile.WriteLine("                conn.Close();")
            OutputFile.WriteLine("                return Table;")
            OutputFile.WriteLine("             }")
            OutputFile.WriteLine("             catch (Exception ) {")
            OutputFile.WriteLine("                conn.Close();")
            OutputFile.WriteLine("                throw;")
            OutputFile.WriteLine("            }")
            OutputFile.WriteLine("        }")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("")
        Else
            OutputFile.WriteLine("")
            OutputFile.WriteLine("        public static DataTable GetAll()")
            OutputFile.WriteLine("        {")
            OutputFile.WriteLine("            string storedProcedure = " + Chr(34) + "sp_" + TableName + "_GetAll" + Chr(34) + ";")
            OutputFile.WriteLine("            System.Data.OleDb.OleDbCommand cmd = new System.Data.OleDb.OleDbCommand();")
            OutputFile.WriteLine("            string ConnectionString = GetConnectionString();")
            OutputFile.WriteLine("            System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection();")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("            conn.ConnectionString = ConnectionString;")
            OutputFile.WriteLine("            cmd.CommandType = CommandType.StoredProcedure;")
            OutputFile.WriteLine("            cmd.Connection = conn;")
            OutputFile.WriteLine("            cmd.CommandText = storedProcedure;")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("            try {")
            OutputFile.WriteLine("                DataSet ds;")
            OutputFile.WriteLine("                System.Data.OleDb.OleDbDataAdapter da;")
            OutputFile.WriteLine("                DataTable Table = null;")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("                conn.Open();")
            OutputFile.WriteLine("                da = new System.Data.OleDb.OleDbDataAdapter();")
            OutputFile.WriteLine("                da.SelectCommand = cmd;")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("                ds = new DataSet();")
            OutputFile.WriteLine("                da.Fill(ds);")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("                if (ds.Tables.Count > 0) {")
            OutputFile.WriteLine("                   if (ds.Tables[0].Rows.Count > 0) {")
            OutputFile.WriteLine("                        Table = ds.Tables[0]; ")
            OutputFile.WriteLine("                   }")
            OutputFile.WriteLine("                }")
            OutputFile.WriteLine("                conn.Close();")
            OutputFile.WriteLine("                return Table;")
            OutputFile.WriteLine("             }")
            OutputFile.WriteLine("             catch (Exception ) {")
            OutputFile.WriteLine("                conn.Close();")
            OutputFile.WriteLine("                throw;")
            OutputFile.WriteLine("            }")
            OutputFile.WriteLine("        }")
            OutputFile.WriteLine("        ")
            OutputFile.WriteLine("")
        End If
    End Sub

    Public Sub CreateBusinessConstructors(ByVal dt As DataTable, ByVal TableName As String, ByVal PrimaryKey As String) Implements LangImplementation.CreateBusinessConstructors
        Dim count As Integer = dt.Rows.Count
        Dim ndx As Integer
        Dim dr As DataRow

        OutputFile.WriteLine("#region " + Chr(34) + "Constructors" + Chr(34))
        OutputFile.WriteLine()
        OutputFile.WriteLine(Chr(9) + "public " + TableName + "() : base()")
        OutputFile.WriteLine(Chr(9) + "{")
        OutputFile.WriteLine(Chr(9) + "}")
        OutputFile.WriteLine()
        OutputFile.Write(Chr(9) + "public " + TableName + "(")
        If SQLObject.IsView(TableName) Then
            OutputFile.WriteLine("Int32 intPrimaryKey)")
        Else
            For ndx = 1 To count
                dr = dt.Rows(ndx - 1)
                If CStr(dr("COLUMN_NAME")).ToLower = PrimaryKey.ToLower Then
                    OutputFile.WriteLine(GetSQLType(dr("TYPE_NAME")) + " intPrimaryKey) : base(intPrimaryKey)")
                    Exit For
                End If
            Next
        End If
        OutputFile.WriteLine(Chr(9) + "{")
        OutputFile.WriteLine(Chr(9) + "}")
        OutputFile.WriteLine()
        OutputFile.WriteLine(Chr(9) + "public " + TableName + "(DataRow dtrRow) : base(dtrRow)")
        OutputFile.WriteLine(Chr(9) + "{")
        OutputFile.WriteLine(Chr(9) + "}")
        OutputFile.WriteLine()
        OutputFile.WriteLine("#endregion")
        OutputFile.WriteLine()
    End Sub

    Public Shared Function VBName(ByVal str As String) As String
        str = str.Replace("#", "num")
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

    Public Sub CreateBusinessHeader(ByVal TableName As String) Implements LangImplementation.CreateBusinessHeader
        If Not Me.m_SupressComments Then
            OutputFile.WriteLine("// This file was automatically created by LayerGen " + Version())
            OutputFile.WriteLine("// Created: " + Now().ToShortDateString() + " " + Now().ToShortTimeString())
            OutputFile.WriteLine("")
        End If
        'OutputFile.WriteLine("using Microsoft.VisualBasic;")
        OutputFile.WriteLine("using System;")
        OutputFile.WriteLine("using System.Data;")
        OutputFile.WriteLine("using System.Collections;")
        OutputFile.WriteLine()
        OutputFile.WriteLine("namespace " + Me.BusinessNameSpace)
        OutputFile.WriteLine("{")
        OutputFile.WriteLine("#region " + Chr(34) + TableName + " Class" + Chr(34))
        OutputFile.WriteLine(Chr(9) + "[Serializable()]")
        OutputFile.WriteLine(Chr(9) + "public class " + TableName + " : " + Me.DataNameSpace + "." + TableName + ", " + Me.BusinessNameSpace + ".IBusiness")
        OutputFile.WriteLine("{")
        OutputFile.WriteLine()
    End Sub

    Public Sub CreateInterfaceImplementation(ByVal TableName As String, ByVal PrimaryKey As String) Implements LangImplementation.CreateInterfaceImplementation
        OutputFile.WriteLine("#region " + Chr(34) + "Interface Implementation" + Chr(34))
        OutputFile.WriteLine(Chr(9) + "public void Rollback()")
        OutputFile.WriteLine(Chr(9) + "{")
        If PrimaryKey <> "" Then
            'OutputFile.WriteLine(Chr(9) + Chr(9) + "base." + VBFunctions.GetProperName(PrimaryKey) + " = 0;")
        End If
        OutputFile.WriteLine(Chr(9) + "}")
        OutputFile.WriteLine("")
        OutputFile.WriteLine(Chr(9) + "public void Validate()")
        OutputFile.WriteLine(Chr(9) + "{")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "// TODO: Write your own validation code")
        OutputFile.WriteLine(Chr(9) + "}")
        OutputFile.WriteLine("#endregion")
        OutputFile.WriteLine(Chr(9) + "}")
        OutputFile.WriteLine("#endregion")
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

    Public Sub CreateCollectionClass(ByVal TableName As String, ByVal PrimaryKey As String, ByVal EnableSorting As Boolean) Implements LangImplementation.CreateCollectionClass
        OutputFile.WriteLine("#region " + Chr(34) + TableName + "s Class" + Chr(34))
        OutputFile.WriteLine(Chr(9) + "[Serializable()] ")
        OutputFile.WriteLine(Chr(9) + "public class " + TableName + "s : CollectionBase")
        OutputFile.WriteLine(Chr(9) + "{")
        OutputFile.WriteLine("")
        If EnableSorting = True Then
            CreateSortingFunctions(TableName)
        End If
        OutputFile.WriteLine(Chr(9) + "#region " + Chr(34) + "Constructors" + Chr(34))
        OutputFile.WriteLine(Chr(9) + Chr(9) + "public " + TableName + "s()")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "{")
        OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9))
        OutputFile.WriteLine(Chr(9) + Chr(9) + "}")
        OutputFile.WriteLine("")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "public " + TableName + "s(DataRowCollection datarows) : this()")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "{")
        OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "this.Load(datarows);")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "}")
        OutputFile.WriteLine(Chr(9) + "#endregion")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("#region " + Chr(34) + "Member Functions" + Chr(34))
        OutputFile.WriteLine(Chr(9) + "protected void Load(DataRowCollection dataRows)")
        OutputFile.WriteLine(Chr(9) + "{")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "foreach (DataRow dr in dataRows) {")
        OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "this.Add(new " + TableName + "(dr));")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "}   ")
        OutputFile.WriteLine(Chr(9) + "}")
        OutputFile.WriteLine("")
        OutputFile.WriteLine(Chr(9) + "public " + TableName + " this[int index]  {")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "get { return (" + TableName + ")base.InnerList[index]; }")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "set { base.InnerList[index] = value; }")
        OutputFile.WriteLine(Chr(9) + "}")
        OutputFile.WriteLine("")
        OutputFile.WriteLine(Chr(9) + "public int Add(" + TableName + " val)")
        OutputFile.WriteLine(Chr(9) + "{")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "return base.InnerList.Add(val);")
        OutputFile.WriteLine(Chr(9) + "}")
        OutputFile.WriteLine("#endregion")
        OutputFile.WriteLine("")
        If SQLObject.IsView(TableName) = False Then
            OutputFile.WriteLine("#region " + Chr(34) + "Save Function" + Chr(34))
            OutputFile.WriteLine(Chr(9) + "public void Save()")
            OutputFile.WriteLine(Chr(9) + "{")
            OutputFile.WriteLine(Chr(9) + Chr(9) + "foreach (" + TableName + " a in this.InnerList) {")
            OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "a.Save();")
            OutputFile.WriteLine(Chr(9) + Chr(9) + "}")
            OutputFile.WriteLine(Chr(9) + "}")
            OutputFile.WriteLine("#endregion")
            OutputFile.WriteLine("")
        End If
        OutputFile.WriteLine("#region " + Chr(34) + "Rollback Function" + Chr(34))
        OutputFile.WriteLine(Chr(9) + "public void Rollback()")
        OutputFile.WriteLine(Chr(9) + "{")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "foreach (" + TableName + " a in this.InnerList) {")
        OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "a.Rollback();")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "}")
        OutputFile.WriteLine(Chr(9) + "}")
        OutputFile.WriteLine("#endregion")
        OutputFile.WriteLine("")
        Me.CreateBusinessGetAll(TableName)
        OutputFile.WriteLine("#region " + Chr(34) + "Custom Query Methods" + Chr(34))
        OutputFile.WriteLine("        // TODO: Add your own custom Query Methods")
        OutputFile.WriteLine("        // I have provided an example to show you how easy")
        OutputFile.WriteLine("        // it is to add your own custom query. Don't forget")
        OutputFile.WriteLine("        // to add your query method to the Data layer too")
        OutputFile.WriteLine("        //")
        OutputFile.WriteLine("        // public void GetByFirstName(string FirstName)")
        OutputFile.WriteLine("        // {")
        OutputFile.WriteLine("        //     DataTable dt = " + Me.DataNameSpace + "." + TableName + ".GetByFirstName(FirstName);")
        OutputFile.WriteLine("        //     if ((dt != null)) {")
        OutputFile.WriteLine("        //         this.Load(dt.Rows);")
        OutputFile.WriteLine("        //     }")
        OutputFile.WriteLine("        // }")
        OutputFile.WriteLine("        //")
        OutputFile.WriteLine("#endregion")
        OutputFile.WriteLine("")
        OutputFile.WriteLine(Chr(9) + "}")
        OutputFile.WriteLine("#endregion")
        OutputFile.WriteLine("}")
    End Sub

    Public Sub CreateDataHeader(ByVal TableName As String) Implements LangImplementation.CreateDataHeader
        If Not Me.m_SupressComments Then
            OutputFile.WriteLine("// This file was automatically created by LayerGen " + Version())
            OutputFile.WriteLine("// Created: " + Now().ToShortDateString() + " " + Now().ToShortTimeString())
            OutputFile.WriteLine("")
        End If
        'OutputFile.WriteLine("using Microsoft.VisualBasic;")
        OutputFile.WriteLine("using System;")
        OutputFile.WriteLine("using System.Data;")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("#pragma warning disable 162")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("namespace " + Me.DataNameSpace)
        OutputFile.WriteLine("{")
        OutputFile.WriteLine("#region " + Chr(34) + TableName + " Class" + Chr(34))
        OutputFile.WriteLine(Chr(9) + "[Serializable()]")
        OutputFile.WriteLine(Chr(9) + "public class " + TableName)
        OutputFile.WriteLine(Chr(9) + "{")
    End Sub

    Protected Sub CreateMemberVariables(ByVal dt As DataTable, ByVal FKeys As DataTable) Implements LangImplementation.CreateMemberVariables
        Dim dr As DataRow
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim type As String
        Dim varname As String

        OutputFile.WriteLine("#region " + Chr(34) + "Instance Variables" + Chr(34))

        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            type = dr("TYPE_NAME")
            varname = dr("COLUMN_NAME")
            OutputFile.WriteLine("        protected " + Me.GetSQLType(type) + " m_" + VBFunctions.VBName(varname.ToLower()) + ";")
        Next
        OutputFile.WriteLine("")
        OutputFile.WriteLine("        protected bool m_isDirty = false;")
        OutputFile.WriteLine("        protected string ConnectString;")
        OutputFile.WriteLine("        private bool m_isFresh = false;")
        If FKeys.Rows.Count > 0 Then
            OutputFile.WriteLine("")

            ndx = 0
            While (ndx < FKeys.Rows.Count)
                dr = FKeys.Rows(ndx)
                OutputFile.WriteLine("        protected " + Me.BusinessNameSpace + "." + dr("PKTABLE_NAME") + " my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + ";")
                ndx = ndx + 1
            End While
        End If
        OutputFile.WriteLine(Chr(13) + Chr(10) + "#endregion" + OutputFile.NewLine)
    End Sub

    Protected Sub CreateDataProperties(ByVal dt As DataTable, ByVal FKeys As DataTable) Implements LangImplementation.CreateDataProperties
        Dim dr As DataRow
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim type As String
        Dim varname As String
        Dim Isidentity As Boolean = False

        OutputFile.WriteLine("#region " + Chr(34) + "Properties" + Chr(34))

        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            type = dr("TYPE_NAME")
            varname = dr("COLUMN_NAME")
            If type.ToLower.EndsWith("identity") Then
                Isidentity = True
            End If
            OutputFile.WriteLine("        public " + Me.GetSQLType(type) + " " + VBFunctions.GetProperName(varname) + " {")
            OutputFile.WriteLine("            get { return this.m_" + VBFunctions.VBName(varname.ToLower()) + "; }")
            OutputFile.WriteLine("            set {")
            OutputFile.WriteLine("                this.m_isDirty=true;")
            OutputFile.WriteLine("                this.m_" + VBFunctions.VBName(varname.ToLower()) + " = value;")
            OutputFile.WriteLine("            }")
            OutputFile.WriteLine("        }" + OutputFile.NewLine)
        Next
        ndx = 0
        'OutputFile.WriteLine("        Public Readonly Property IsIdentityTable() As Boolean")
        'OutputFile.WriteLine("            Get")
        'OutputFile.WriteLine("                Return " + Isidentity.ToString())
        'OutputFile.WriteLine("            End Get")
        'OutputFile.WriteLine("        End Property")
        OutputFile.WriteLine("        public bool IsIdentityTable {")
        OutputFile.WriteLine("            get { return " + Isidentity.ToString.ToLower + "; }")
        OutputFile.WriteLine("        }")
        While (ndx < FKeys.Rows.Count)
            dr = FKeys.Rows(ndx)

            'OutputFile.WriteLine("        Public Property F" + MiscFunctions.StripID(dr("PKCOLUMN_NAME")) + " As " + Me.BusinessNameSpace + "." + dr("PKTABLE_NAME"))
            'OutputFile.WriteLine("            Get")
            'OutputFile.WriteLine("                If ((Me.my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + " Is Nothing) AndAlso (Me." + dr("PKCOLUMN_NAME") + " > 0)) Then")
            'OutputFile.WriteLine("                    Me.my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + " = New " + Me.BusinessNameSpace + "." + dr("PKTABLE_NAME") + "(Me." + dr("PKCOLUMN_NAME") + ")")
            'OutputFile.WriteLine("                Else")
            'OutputFile.WriteLine("                    Me.my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + " = New " + Me.BusinessNameSpace + "." + dr("PKTABLE_NAME") + "()")
            'OutputFile.WriteLine("                End If")
            'OutputFile.WriteLine("                Return Me.my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))))
            'OutputFile.WriteLine("            End Get")
            'OutputFile.WriteLine("            Set(ByVal Value As " + Me.BusinessNameSpace + "." + dr("PKTABLE_NAME") + ")")
            'OutputFile.WriteLine("                Me.my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + " = Value")
            'OutputFile.WriteLine("            End Set")
            'OutputFile.WriteLine("        End Property")

            OutputFile.WriteLine("        public " + Me.BusinessNameSpace + "." + dr("PKTABLE_NAME") + " F" + MiscFunctions.StripID(dr("PKCOLUMN_NAME")) + " {")
            OutputFile.WriteLine("            get {")
            OutputFile.WriteLine("                if (((this.my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + " == null) && (this." + VBFunctions.GetProperName(dr("PKCOLUMN_NAME")) + " > 0))) {")
            OutputFile.WriteLine("                    this.my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + " = new " + Me.BusinessNameSpace + "." + dr("PKTABLE_NAME") + "(this." + VBFunctions.GetProperName(dr("PKCOLUMN_NAME")) + ");")
            OutputFile.WriteLine("                }")
            OutputFile.WriteLine("                else {")
            OutputFile.WriteLine("                    this.my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + " = new " + Me.BusinessNameSpace + "." + dr("PKTABLE_NAME") + "();")
            OutputFile.WriteLine("                }")
            OutputFile.WriteLine("                return this.my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + ";")
            OutputFile.WriteLine("            }")
            OutputFile.WriteLine("            set {") '(ByVal Value As " + Me.BusinessNameSpace + "." + dr("PKTABLE_NAME") + ")")
            OutputFile.WriteLine("                this.my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + " = value;")
            OutputFile.WriteLine("            }")
            OutputFile.WriteLine("        }")
            OutputFile.WriteLine("")

            ndx = ndx + 1
        End While
        OutputFile.WriteLine("#endregion" + OutputFile.NewLine)

    End Sub

    Public Sub CreateDataConstructors(ByVal dt As DataTable, ByVal TableName As String, ByVal PrimaryKey As String) Implements LangImplementation.CreateDataConstructors
        Dim ndx As Integer
        Dim dr As DataRow
        Dim count As Integer = dt.Rows.Count

        OutputFile.WriteLine("")
        OutputFile.WriteLine("#region " + Chr(34) + "Constructors" + Chr(34))
        OutputFile.WriteLine("")
        OutputFile.WriteLine(Chr(9) + "public " + TableName + "()")
        OutputFile.WriteLine(Chr(9) + "{")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "SetConnectString();")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "this.m_isFresh = true;")
        OutputFile.WriteLine(Chr(9) + "}")
        OutputFile.WriteLine("")
        OutputFile.Write(Chr(9) + "public " + TableName + "(")
        If SQLObject.IsView(TableName) Then
            OutputFile.WriteLine("Int32 intPrimaryKey)")
        Else
            For ndx = 1 To count
                dr = dt.Rows(ndx - 1)
                If CStr(dr("COLUMN_NAME")).ToLower = PrimaryKey.ToLower Then
                    OutputFile.WriteLine(GetSQLType(dr("TYPE_NAME")) + " intPrimaryKey )")
                    Exit For
                End If
            Next
        End If
        OutputFile.WriteLine(Chr(9) + "{")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "SetConnectString();")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "this.Get(intPrimaryKey);")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "this.m_isFresh = false;")
        OutputFile.WriteLine(Chr(9) + "}")
        OutputFile.WriteLine("")
        OutputFile.WriteLine(Chr(9) + "public " + TableName + "(DataRow dtrRow)")
        OutputFile.WriteLine(Chr(9) + "{")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "SetConnectString();")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "this.Fill(dtrRow);")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "this.m_isFresh = false;")
        OutputFile.WriteLine(Chr(9) + "}")
        OutputFile.WriteLine("")
        OutputFile.WriteLine("#endregion")
        OutputFile.WriteLine("")
    End Sub

    Protected Sub CreateDataConnectionStringSubs() Implements LangImplementation.CreateDataConnectionStringSubs
        OutputFile.WriteLine("        protected void SetConnectString()")
        OutputFile.WriteLine("        {")
        OutputFile.WriteLine("             ConnectString = " + DataNameSpace + ".Universal.GetConnectionString();")
        OutputFile.WriteLine("        }" + OutputFile.NewLine)
        OutputFile.WriteLine("        protected string GetConnectString()")
        OutputFile.WriteLine("        {")
        OutputFile.WriteLine("            return ConnectString;")
        OutputFile.WriteLine("        }" + OutputFile.NewLine)
        OutputFile.WriteLine("        protected static string GetConnectionString()")
        OutputFile.WriteLine("        {")
        OutputFile.WriteLine("             return " + DataNameSpace + ".Universal.GetConnectionString();")
        OutputFile.WriteLine("        }" + OutputFile.NewLine)
    End Sub

    Protected Sub CreateDataCopySub(ByVal dt As DataTable) Implements LangImplementation.CreateDataCopySub
        Dim dr As DataRow
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim type As String
        Dim varname As String

        OutputFile.WriteLine("        public void Copy(DataRow dtrRow)")
        OutputFile.WriteLine("        {")
        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            type = dr("TYPE_NAME")
            varname = dr("COLUMN_NAME")
            OutputFile.WriteLine("            try {")
            OutputFile.WriteLine("                this.m_" + (VBFunctions.VBName(varname.ToLower)) + " = (" + Me.GetSQLType(type) + ")dtrRow[" + Chr(34) + varname + Chr(34) + "];")
            OutputFile.WriteLine("            }")
            OutputFile.WriteLine("            catch (Exception ) {")
            OutputFile.WriteLine("            }")
            OutputFile.WriteLine("")
        Next
        OutputFile.WriteLine("        }")
    End Sub

    Protected Sub CreateDataFillSub(ByVal dt As DataTable) Implements LangImplementation.CreateDataFillSub
        Dim dr As DataRow
        Dim ndx As Integer
        Dim count As Integer = dt.Rows.Count
        Dim type As String
        Dim varname As String

        OutputFile.WriteLine("        protected void Fill(DataRow dtrRow )")
        OutputFile.WriteLine("        {")

        For ndx = 1 To count
            dr = dt.Rows(ndx - 1)
            type = dr("TYPE_NAME")
            varname = dr("COLUMN_NAME")
            OutputFile.WriteLine("            try {")
            OutputFile.WriteLine("                if (((!object.ReferenceEquals(dtrRow[" + Chr(34) + varname + Chr(34) + "], DBNull.Value)))) {")
            OutputFile.WriteLine("                    this.m_" + VBFunctions.VBName(varname.ToLower()) + " = (" + Me.GetSQLType(type) + ")dtrRow[" + Chr(34) + varname + Chr(34) + "];")
            'If Me.GetSQLType(type) = "System.DateTime" Then
            'OutputFile.WriteLine("                } else {")
            'OutputFile.WriteLine("                        this.m_" + VBFunctions.VBName(varname.ToLower()) + " = null;")
            'End If
            OutputFile.WriteLine("                }")
            OutputFile.WriteLine("            }")
            OutputFile.WriteLine("            catch (Exception ) {")
            If Me.GetSQLType(type) = "System.DateTime" Then
                'OutputFile.WriteLine("                this.m_" + VBFunctions.VBName(varname.ToLower()) + " = null;")
            End If
            OutputFile.WriteLine("            }")
        Next
        OutputFile.WriteLine("        }")
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
            OutputFile.Write("        private void Get(")
            If SQLObject.IsView(TableName) Then
                OutputFile.WriteLine("Int32 intId)")
            Else
                For ndx = 1 To count
                    dr = dt.Rows(ndx - 1)
                    If CStr(dr("COLUMN_NAME")).ToLower = PrimaryKey.ToLower Then
                        OutputFile.WriteLine(GetSQLType(dr("TYPE_NAME")) + " intId)")
                        type = CStr(dr("TYPE_NAME"))
                        If type = "int identity" Then type = "Int"
                        If type = "decimal" Then type = "Decimal"
                        If type = "int" Then type = "Int"
                        If type = "bigint" Then type = "BigInt"
                        If type = "nvarchar" Then type = "NVarChar"
                        If type = "varchar" Then type = "VarChar"
                        If type = "datetime" Then type = "DateTime"
                        If type = "numeric" Then type = "Decimal"
                        If type = "bit" Then type = "Bit"
                        If type = "money" Then type = "Money"
                        If type = "text" Then type = "Text"
                        If type = "real" Then type = "Real"
                        If type = "float" Then type = "Float"
                        If type = "tinyint" Then type = "TinyInt"
                        If type = "smallint" Then type = "SmallInt"
                        If type = "smalldatetime" Then type = "SmallDateTime"
                        If type = "char" Then type = "Char"
                        If type = "uniqueidentifier" Then type = "UniqueIdentifier"
                        Exit For
                    End If
                Next
            End If
            OutputFile.WriteLine("        {")
            OutputFile.WriteLine("            string storedProcedure = " + Chr(34) + "sp_" + TableName + "_" + ViewCommand + Chr(34) + ";")
            OutputFile.WriteLine("            System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(); ")
            OutputFile.WriteLine("            DataSet ds;")
            OutputFile.WriteLine("            string ConnectionString = GetConnectString();")
            OutputFile.WriteLine("            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection();")
            OutputFile.WriteLine("            System.Data.SqlClient.SqlDataAdapter da;")
            OutputFile.WriteLine("")
            OutputFile.WriteLine("            conn.ConnectionString = ConnectionString;")
            OutputFile.WriteLine("            cmd.CommandType = CommandType.StoredProcedure;")
            OutputFile.WriteLine("            cmd.Connection = conn;")
            OutputFile.WriteLine("            cmd.CommandText = storedProcedure;")
            If SQLObject.IsView(TableName) = False Then
                OutputFile.Write("            cmd.Parameters.Add(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ", SqlDbType.")
                OutputFile.WriteLine((type) + ");")
                OutputFile.WriteLine("            cmd.Parameters[" + Chr(34) + "@" + PrimaryKey + Chr(34) + "].Value = intId;")
            End If
            OutputFile.WriteLine("")
            OutputFile.WriteLine("            try {")
            OutputFile.WriteLine("                conn.Open();")
            OutputFile.WriteLine("                da = new System.Data.SqlClient.SqlDataAdapter();")
            OutputFile.WriteLine("                da.SelectCommand = cmd;" + OutputFile.NewLine)
            OutputFile.WriteLine("                ds = new DataSet();")
            OutputFile.WriteLine("                da.Fill(ds);" + OutputFile.NewLine)
            OutputFile.WriteLine("                if (ds.Tables.Count > 0) {")
            OutputFile.WriteLine("                    if (ds.Tables[0].Rows.Count > 0) {")
            OutputFile.WriteLine("                        Fill(ds.Tables[0].Rows[0]);")
            OutputFile.WriteLine("                    }")
            OutputFile.WriteLine("                }")
            OutputFile.WriteLine("            }")
            OutputFile.WriteLine("            catch (Exception e) {")
            OutputFile.WriteLine("                throw e;")
            OutputFile.WriteLine("            }")
            OutputFile.WriteLine("            conn.Close();")
            OutputFile.WriteLine("        }" + OutputFile.NewLine)
        Else
            OutputFile.Write("        private void Get(")
            For ndx = 1 To count
                dr = dt.Rows(ndx - 1)
                If CStr(dr("COLUMN_NAME")).ToLower = PrimaryKey.ToLower Then
                    OutputFile.WriteLine(GetSQLType(dr("TYPE_NAME")) + " intId)")
                    type = CStr(dr("TYPE_NAME"))
                    Exit For
                End If
            Next
            OutputFile.WriteLine("        {")
            OutputFile.WriteLine("            string storedProcedure = " + Chr(34) + "sp_" + TableName + "_Select" + Chr(34) + ";")
            OutputFile.WriteLine("            System.Data.OleDb.OleDbCommand cmd = new System.Data.OleDb.OleDbCommand(); ")
            OutputFile.WriteLine("            DataSet ds;")
            OutputFile.WriteLine("            string ConnectionString = GetConnectString();")
            OutputFile.WriteLine("            System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection();")
            OutputFile.WriteLine("            System.Data.OleDb.OleDbDataAdapter da;")
            OutputFile.WriteLine("")
            OutputFile.WriteLine("            conn.ConnectionString = ConnectionString;")
            OutputFile.WriteLine("            cmd.CommandType = CommandType.StoredProcedure;")
            OutputFile.WriteLine("            cmd.Connection = conn;")
            OutputFile.WriteLine("            cmd.CommandText = storedProcedure;")
            OutputFile.WriteLine("            cmd.Parameters.Add(" + Chr(34) + PrimaryKey + Chr(34) + ", System.Data.OleDb.OleDbType.Integer);")
            OutputFile.WriteLine("            cmd.Parameters[" + Chr(34) + PrimaryKey + Chr(34) + "].Value = intId;")
            OutputFile.WriteLine("")
            OutputFile.WriteLine("            try {")
            OutputFile.WriteLine("                conn.Open();")
            OutputFile.WriteLine("                da = new System.Data.OleDb.OleDbDataAdapter();")
            OutputFile.WriteLine("                da.SelectCommand = cmd;" + OutputFile.NewLine)
            OutputFile.WriteLine("                ds = new DataSet();")
            OutputFile.WriteLine("                da.Fill(ds);" + OutputFile.NewLine)
            OutputFile.WriteLine("                if (ds.Tables.Count > 0) {")
            OutputFile.WriteLine("                    if (ds.Tables[0].Rows.Count > 0) {")
            OutputFile.WriteLine("                        Fill(ds.Tables[0].Rows[0]);")
            OutputFile.WriteLine("                    }")
            OutputFile.WriteLine("                }")
            OutputFile.WriteLine("            }")
            OutputFile.WriteLine("            catch (Exception e) {")
            OutputFile.WriteLine("                throw e;")
            OutputFile.WriteLine("            }")
            OutputFile.WriteLine("            conn.Close();")
            OutputFile.WriteLine("        }" + OutputFile.NewLine)
        End If
    End Sub

    Protected Sub CreateDataDeleteSub(ByVal dt As DataTable, ByVal TableName As String, ByVal PrimaryKey As String) Implements LangImplementation.CreateDataDeleteSub
        If Me.IsDatabaseMSSQL Then
            OutputFile.WriteLine("        public void Delete()")
            OutputFile.WriteLine("        {")
            OutputFile.WriteLine("            string storedProcedure = " + Chr(34) + "sp_" + TableName + "_Delete" + Chr(34) + ";")
            OutputFile.WriteLine("            System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();")
            OutputFile.WriteLine("            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection();")
            OutputFile.WriteLine("            string ConnectionString = GetConnectString();")
            OutputFile.WriteLine("")
            OutputFile.WriteLine("            conn.ConnectionString = ConnectionString;")
            OutputFile.WriteLine("            cmd.CommandType = CommandType.StoredProcedure;")
            OutputFile.WriteLine("            cmd.Connection = conn;")
            OutputFile.WriteLine("            cmd.CommandText = storedProcedure;")
            OutputFile.WriteLine("            cmd.Parameters.Add(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ", SqlDbType.Int);")
            OutputFile.WriteLine("            cmd.Parameters[" + Chr(34) + "@" + PrimaryKey + Chr(34) + "].Value = this.m_" + (VBFunctions.VBName(PrimaryKey.ToLower())) + ";")

            OutputFile.WriteLine("")
            OutputFile.WriteLine("            try {")
            OutputFile.WriteLine("                conn.Open();")
            OutputFile.WriteLine("                cmd.ExecuteNonQuery();")
            OutputFile.WriteLine("            }")
            OutputFile.WriteLine("            catch (Exception e) {")
            OutputFile.WriteLine("                throw e;")
            OutputFile.WriteLine("            }")
            OutputFile.WriteLine("            conn.Close();")
            OutputFile.WriteLine("        }" + OutputFile.NewLine)
        Else
            OutputFile.WriteLine("        public void Delete()")
            OutputFile.WriteLine("        {")
            OutputFile.WriteLine("            string storedProcedure = " + Chr(34) + "sp_" + TableName + "_Delete" + Chr(34) + ";")
            OutputFile.WriteLine("            System.Data.OleDb.OleDbCommand cmd = new System.Data.OleDb.OleDbCommand();")
            OutputFile.WriteLine("            System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection();")
            OutputFile.WriteLine("            string ConnectionString = GetConnectString();")
            OutputFile.WriteLine("")
            OutputFile.WriteLine("            conn.ConnectionString = ConnectionString;")
            OutputFile.WriteLine("            cmd.CommandType = CommandType.StoredProcedure;")
            OutputFile.WriteLine("            cmd.Connection = conn;")
            OutputFile.WriteLine("            cmd.CommandText = storedProcedure;")
            OutputFile.WriteLine("            cmd.Parameters.Add(" + Chr(34) + PrimaryKey + Chr(34) + ", System.Data.OleDb.OleDbType.Integer);")
            OutputFile.WriteLine("            cmd.Parameters[" + Chr(34) + PrimaryKey + Chr(34) + "].Value = this.m_" + (VBFunctions.VBName(PrimaryKey.ToLower())) + ";")

            OutputFile.WriteLine("")
            OutputFile.WriteLine("            try {")
            OutputFile.WriteLine("                conn.Open();")
            OutputFile.WriteLine("                cmd.ExecuteNonQuery();")
            OutputFile.WriteLine("            }")
            OutputFile.WriteLine("            catch (Exception e) {")
            OutputFile.WriteLine("                throw e;")
            OutputFile.WriteLine("            }")
            OutputFile.WriteLine("            conn.Close();")
            OutputFile.WriteLine("        }" + OutputFile.NewLine)
        End If
    End Sub

    Public Sub CreateInterfaces() Implements LangImplementation.CreateInterfaces
        OutputFile.WriteLine("namespace " + Me.BusinessNameSpace)
        OutputFile.WriteLine("{")
        OutputFile.WriteLine("")
        OutputFile.WriteLine(Chr(9) + "public interface ISequence")
        OutputFile.WriteLine(Chr(9) + "{")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "int Sequence {")
        OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "get;")
        OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "set;")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "}")
        OutputFile.WriteLine(Chr(9) + "}")
        OutputFile.WriteLine("")
        OutputFile.WriteLine(Chr(9) + "public interface IBusiness")
        OutputFile.WriteLine(Chr(9) + "{")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "void Validate();")
        OutputFile.WriteLine(Chr(9) + Chr(9) + "void Rollback();")
        OutputFile.WriteLine(Chr(9) + "}")
        OutputFile.WriteLine("}")
    End Sub

    Public Sub CreateUniversalConnection() Implements LangImplementation.CreateUniversalConnection
        If Me.IsDatabaseMSSQL Then
            If Me.m_AuthenticationType = LangImplementation.AuthenticationTypes.SQLServerAuthentication Then
                OutputFile.WriteLine("namespace " + Me.DataNameSpace + " {")
                OutputFile.WriteLine("")
                OutputFile.WriteLine(Chr(9) + "public class Universal")
                OutputFile.WriteLine(Chr(9) + "{")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "public static string GetConnectionString() ")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "{")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "// TODO: Need to decide on connection string requirements and pick a method below")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "return " + Chr(34) + "server=" + m_SQLServerName.Trim() + ";database=" + m_SQLDatabaseName.Trim() + ";UID=" + m_SQLUsername.Trim() + ";Password=\" + Chr(34) + m_sqlPassword.Trim() + "\" + Chr(34) + ";" + Chr(34) + ";")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "// return ConfigurationManager.ConnectionStrings(" + Chr(34) + "SQLServer" + Chr(34) + ").ConnectionString")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "}")
                OutputFile.WriteLine(Chr(9) + "}")
                OutputFile.WriteLine("}")
            ElseIf Me.m_AuthenticationType = LangImplementation.AuthenticationTypes.WindowsAuthentication Then
                OutputFile.WriteLine("namespace " + Me.DataNameSpace + " {")
                OutputFile.WriteLine("")
                OutputFile.WriteLine(Chr(9) + "public class Universal")
                OutputFile.WriteLine(Chr(9) + "{")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "public static string GetConnectionString() ")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "{")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "// TODO: Need to decide on connection string requirements and pick a method below")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "return " + Chr(34) + "server=" + m_SQLServerName.Trim() + ";database=" + m_SQLDatabaseName.Trim() + ";Trusted_Connection=Yes;")
                OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "// return ConfigurationManager.ConnectionStrings(" + Chr(34) + "SQLServer" + Chr(34) + ").ConnectionString")
                OutputFile.WriteLine(Chr(9) + Chr(9) + "}")
                OutputFile.WriteLine(Chr(9) + "}")
                OutputFile.WriteLine("}")
            End If
        Else
            OutputFile.WriteLine("namespace " + Me.DataNameSpace + " {")
            OutputFile.WriteLine("")
            OutputFile.WriteLine(Chr(9) + "public class Universal")
            OutputFile.WriteLine(Chr(9) + "{")
            OutputFile.WriteLine(Chr(9) + Chr(9) + "public static string GetConnectionString() ")
            OutputFile.WriteLine(Chr(9) + Chr(9) + "{")
            OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "// TODO: Need to decide on connection string requirements and pick a method below")
            OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "return " + Chr(34) + "Provider=Microsoft.Jet.OleDb.4.0;Data Source=\""" + TheSQLObject.AccessFileName.Replace("\", "\\") + "\"""";")
            OutputFile.WriteLine(Chr(9) + Chr(9) + Chr(9) + "// return ConfigurationManager.ConnectionStrings(" + Chr(34) + "SQLServer" + Chr(34) + ").ConnectionString")
            OutputFile.WriteLine(Chr(9) + Chr(9) + "}")
            OutputFile.WriteLine(Chr(9) + "}")
            OutputFile.WriteLine("}")
        End If
    End Sub

    Protected Sub CreateDataCustomQueryMethods(ByVal dt As DataTable, ByVal TableName As String) Implements LangImplementation.CreateDataCustomQueryMethods
        If Me.IsDatabaseMSSQL Then
            OutputFile.WriteLine("#region " + Chr(34) + "Custom Query Methods" + Chr(34))
            OutputFile.WriteLine("        // TODO: Add your own custom queries here. To do this, simply")
            OutputFile.WriteLine("        // create a stored procedure in your database. Then use the")
            OutputFile.WriteLine("        // sample code below as a guide to calling your stored")
            OutputFile.WriteLine("        // procedure. Also, make sure you make the appropriate changes")
            OutputFile.WriteLine("        // in the Business layer to call this function. See the region")
            OutputFile.WriteLine("        // called " + Chr(34) + "Custom Query Methods" + Chr(34) + " in the business")
            OutputFile.WriteLine("        // layer code. ")
            OutputFile.WriteLine("        //")
            OutputFile.WriteLine("        // public static DataTable GetByFirstName(string FirstName)")
            OutputFile.WriteLine("        // {")
            OutputFile.WriteLine("        //     string storedProcedure = " + Chr(34) + "sp_" + TableName + "_Custom" + Chr(34) + ";")
            OutputFile.WriteLine("        //     System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();")
            OutputFile.WriteLine("        //     string ConnectionString = GetConnectionString();")
            OutputFile.WriteLine("        //     System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(); ")
            OutputFile.WriteLine("        //")
            OutputFile.WriteLine("        //     conn.ConnectionString = ConnectionString;")
            OutputFile.WriteLine("        //     cmd.CommandType = CommandType.StoredProcedure;")
            OutputFile.WriteLine("        //     cmd.Connection = conn;")
            OutputFile.WriteLine("        //     cmd.CommandText = storedProcedure;")
            OutputFile.WriteLine("        //     cmd.Parameters.Add(" + Chr(34) + "@fname" + Chr(34) + ", SqlDbType.VarChar);")
            OutputFile.WriteLine("        //     cmd.Parameters[" + Chr(34) + "@fname" + Chr(34) + "].Value = FirstName;")
            OutputFile.WriteLine("        //")
            OutputFile.WriteLine("        //     try {")
            OutputFile.WriteLine("        //         DataSet ds; ")
            OutputFile.WriteLine("        //         System.Data.SqlClient.SqlDataAdapter da;")
            OutputFile.WriteLine("        //         DataTable Table = null;")
            OutputFile.WriteLine("        //")
            OutputFile.WriteLine("        //         conn.Open();")
            OutputFile.WriteLine("        //         da = new System.Data.SqlClient.SqlDataAdapter();")
            OutputFile.WriteLine("        //         da.SelectCommand = cmd;")
            OutputFile.WriteLine("        //")
            OutputFile.WriteLine("        //         ds = new DataSet();")
            OutputFile.WriteLine("        //         da.Fill(ds);")
            OutputFile.WriteLine("        //")
            OutputFile.WriteLine("        //         if (ds.Tables.Count > 0) {")
            OutputFile.WriteLine("        //            if (ds.Tables[0].Rows.Count > 0) {")
            OutputFile.WriteLine("        //                 Table = ds.Tables[0];")
            OutputFile.WriteLine("        //            }")
            OutputFile.WriteLine("        //         }")
            OutputFile.WriteLine("        //         conn.Close();")
            OutputFile.WriteLine("        //         return Table;")
            OutputFile.WriteLine("        //      }")
            OutputFile.WriteLine("        //      catch (Exception e) {")
            OutputFile.WriteLine("        //         throw;")
            OutputFile.WriteLine("        //      }")
            OutputFile.WriteLine("        //     conn.Close();")
            OutputFile.WriteLine("        // }")
            OutputFile.WriteLine("        //")
            OutputFile.WriteLine("")

            OutputFile.WriteLine("#endregion")
        Else
            OutputFile.WriteLine("#region " + Chr(34) + "Custom Query Methods" + Chr(34))
            OutputFile.WriteLine("        // TODO: Add your own custom queries here. To do this, simply")
            OutputFile.WriteLine("        // create a stored procedure in your database. Then use the")
            OutputFile.WriteLine("        // sample code below as a guide to calling your stored")
            OutputFile.WriteLine("        // procedure. Also, make sure you make the appropriate changes")
            OutputFile.WriteLine("        // in the Business layer to call this function. See the region")
            OutputFile.WriteLine("        // called " + Chr(34) + "Custom Query Methods" + Chr(34) + " in the business")
            OutputFile.WriteLine("        // layer code. ")
            OutputFile.WriteLine("        //")
            OutputFile.WriteLine("        // public static DataTable GetByFirstName(string FirstName)")
            OutputFile.WriteLine("        // {")
            OutputFile.WriteLine("        //     string storedProcedure = " + Chr(34) + "sp_" + TableName + "_Custom" + Chr(34) + ";")
            OutputFile.WriteLine("        //     System.Data.OleDb.OleDbCommand cmd = new System.Data.OleDb.OleDbCommand();")
            OutputFile.WriteLine("        //     string ConnectionString = GetConnectionString();")
            OutputFile.WriteLine("        //     System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection(); ")
            OutputFile.WriteLine("        //")
            OutputFile.WriteLine("        //     conn.ConnectionString = ConnectionString;")
            OutputFile.WriteLine("        //     cmd.CommandType = CommandType.StoredProcedure;")
            OutputFile.WriteLine("        //     cmd.Connection = conn;")
            OutputFile.WriteLine("        //     cmd.CommandText = storedProcedure;")
            OutputFile.WriteLine("        //     cmd.Parameters.Add(" + Chr(34) + "fname" + Chr(34) + ", System.Data.OleDb.OleDbType.VarWChar);")
            OutputFile.WriteLine("        //     cmd.Parameters[" + Chr(34) + "fname" + Chr(34) + "].Value = FirstName;")
            OutputFile.WriteLine("        //")
            OutputFile.WriteLine("        //     try {")
            OutputFile.WriteLine("        //         DataSet ds; ")
            OutputFile.WriteLine("        //         System.Data.OleDb.OleDbDataAdapter da;")
            OutputFile.WriteLine("        //         DataTable Table = null;")
            OutputFile.WriteLine("        //")
            OutputFile.WriteLine("        //         conn.Open();")
            OutputFile.WriteLine("        //         da = new System.Data.OleDb.OleDbDataAdapter();")
            OutputFile.WriteLine("        //         da.SelectCommand = cmd;")
            OutputFile.WriteLine("        //")
            OutputFile.WriteLine("        //         ds = new DataSet();")
            OutputFile.WriteLine("        //         da.Fill(ds);")
            OutputFile.WriteLine("        //")
            OutputFile.WriteLine("        //         if (ds.Tables.Count > 0) {")
            OutputFile.WriteLine("        //            if (ds.Tables[0].Rows.Count > 0) {")
            OutputFile.WriteLine("        //                 Table = ds.Tables[0];")
            OutputFile.WriteLine("        //            }")
            OutputFile.WriteLine("        //         }")
            OutputFile.WriteLine("        //         conn.Close();")
            OutputFile.WriteLine("        //         return Table;")
            OutputFile.WriteLine("        //      }")
            OutputFile.WriteLine("        //      catch (Exception e) {")
            OutputFile.WriteLine("        //         throw;")
            OutputFile.WriteLine("        //      }")
            OutputFile.WriteLine("        //     conn.Close();")
            OutputFile.WriteLine("        // }")
            OutputFile.WriteLine("        //")
            OutputFile.WriteLine("")

            OutputFile.WriteLine("#endregion")
        End If
    End Sub

    Public Sub CreateDataFooter() Implements LangImplementation.CreateDataFooter
        OutputFile.WriteLine("        }")
        OutputFile.WriteLine("#endregion")
        OutputFile.WriteLine("    }")
    End Sub

    Protected Sub CreateDataSaveSub(ByVal dt As DataTable, ByVal TableName As String, ByVal PrimaryKey As String) Implements LangImplementation.CreateDataSaveSub
        If Me.IsDatabaseMSSQL Then
            Dim dr As DataRow
            Dim ndx As Integer
            Dim count As Integer = dt.Rows.Count
            Dim type As String
            Dim varname As String
            Dim fkdt As DataTable

            fkdt = Me.SQLObject.GetForeignKeys(TableName)

            OutputFile.WriteLine("        public void Save()")
            OutputFile.WriteLine("        {")
            OutputFile.WriteLine("            string storedProcedure;")
            OutputFile.WriteLine("            System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();")
            OutputFile.WriteLine("            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(); ")
            OutputFile.WriteLine("            string ConnectionString = GetConnectString();")
            OutputFile.WriteLine("")
            If fkdt.Rows.Count > 0 Then
                ndx = 0
                While (ndx < fkdt.Rows.Count)
                    dr = fkdt.Rows(ndx)
                    OutputFile.WriteLine("            if ((this.my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + " != null)) {")
                    OutputFile.WriteLine("                my" + MiscFunctions.Proper(CStr(dr("PKTABLE_NAME"))) + ".Save();")
                    OutputFile.WriteLine("            }")
                    OutputFile.WriteLine("")
                    ndx = ndx + 1
                End While
            End If
            OutputFile.WriteLine("            if ((m_isDirty)) {")
            OutputFile.WriteLine("                conn.ConnectionString = ConnectionString;")
            OutputFile.WriteLine("                cmd.Connection = conn;")
            OutputFile.WriteLine("                cmd.CommandType = CommandType.StoredProcedure;")
            OutputFile.WriteLine("")

            For ndx = 1 To count
                dr = dt.Rows(ndx - 1)
                type = dr("TYPE_NAME")
                varname = dr("COLUMN_NAME")
                If type = "int identity" Then type = "Int"
                If type = "decimal" Then type = "Decimal"
                If type = "int" Then type = "Int"
                If type = "bigint" Then type = "BigInt"
                If type = "nvarchar" Then type = "NVarChar"
                If type = "varchar" Then type = "VarChar"
                If type = "datetime" Then type = "DateTime"
                If type = "numeric" Then type = "Decimal"
                If type = "bit" Then type = "Bit"
                If type = "money" Then type = "Money"
                If type = "text" Then type = "Text"
                If type = "real" Then type = "Real"
                If type = "float" Then type = "Float"
                If type = "tinyint" Then type = "TinyInt"
                If type = "smallint" Then type = "SmallInt"
                If type = "smalldatetime" Then type = "SmallDateTime"
                If type = "char" Then type = "Char"
                If type = "uniqueidentifier" Then type = "UniqueIdentifier"

                OutputFile.WriteLine("                cmd.Parameters.Add(" + Chr(34) + "@" + VBFunctions.VBName(varname) + Chr(34) + ", SqlDbType." + type + ");")
                If varname = PrimaryKey Then Continue For
                If type = "TinyInt" Or type = "SmallInt" Or type = "Int" Or type = "BigInt" Then
                    OutputFile.WriteLine("                if (this.m_" + VBFunctions.VBName(varname.ToLower()) + " !=0) {")
                ElseIf type = "Float" Or type = "Real" Then
                    OutputFile.WriteLine("                if (this.m_" + VBFunctions.VBName(varname.ToLower()) + " !=0.0) {")
                ElseIf type = "Decimal" Then
                    OutputFile.WriteLine("                if (this.m_" + VBFunctions.VBName(varname.ToLower()) + " !=0M) {")
                ElseIf type = "Bit" Then
                    OutputFile.WriteLine("                if (this.m_" + VBFunctions.VBName(varname.ToLower()) + " !=false) {")
                Else
                    'If type <> "image" Then
                    OutputFile.WriteLine("                if (this.m_" + VBFunctions.VBName(varname.ToLower()) + " !=null) {")
                    'Else
                    'OutputFile.WriteLine("                If (this.m_" + VBFunctions.VBName(varname.ToLower()) + " IsNot Nothing Then")
                    'End If
                End If
                OutputFile.WriteLine("                    cmd.Parameters[" + Chr(34) + "@" + VBFunctions.VBName(varname) + Chr(34) + "].Value = this.m_" + VBFunctions.VBName(varname.ToLower()) + ";")
                OutputFile.WriteLine("                } else {")
                OutputFile.Write("                    cmd.Parameters[" + Chr(34) + "@" + VBFunctions.VBName(varname) + Chr(34) + "].Value = ")
                If type = "NVarChar" Or type = "VarChar" Then
                    OutputFile.WriteLine(Chr(34) + Chr(34) + ";")
                End If
                If type = "Bit" Then
                    OutputFile.WriteLine("false;")
                End If
                If type = "DateTime" Then
                    OutputFile.WriteLine("System.DBNull.Value;")
                End If
                If type = "Money" Then
                    OutputFile.WriteLine("0.0;")
                End If
                If type <> "Bit" AndAlso type <> "Money" AndAlso type <> "DateTime" AndAlso type <> "VarChar" AndAlso type <> "NVarChar" Then
                    OutputFile.WriteLine("null;")
                End If
                OutputFile.WriteLine("                }")
                OutputFile.WriteLine("")
            Next

            'OutputFile.WriteLine("                if (this.m_" + VBFunctions.VBName(PrimaryKey.ToLower()) + " > 0) {")
            OutputFile.WriteLine("                if (!this.m_isFresh) {")
            OutputFile.WriteLine("                    storedProcedure = " + Chr(34) + "sp_" + TableName + "_Update" + Chr(34) + ";")
            OutputFile.WriteLine("                    cmd.CommandText=storedProcedure;")
            OutputFile.WriteLine("")
            OutputFile.WriteLine("                    cmd.Parameters[" + Chr(34) + "@" + PrimaryKey + Chr(34) + "].Value = this.m_" + VBFunctions.VBName(PrimaryKey.ToLower()) + ";")
            OutputFile.WriteLine("                    cmd.Parameters[" + Chr(34) + "@" + PrimaryKey + Chr(34) + "].Direction = ParameterDirection.Input;")
            OutputFile.WriteLine("                    try {")
            OutputFile.WriteLine("                        conn.Open();")
            OutputFile.WriteLine("                        cmd.ExecuteNonQuery();")
            OutputFile.WriteLine("                    }")
            OutputFile.WriteLine("                    catch (Exception e ) {")
            OutputFile.WriteLine("                        throw e;")
            OutputFile.WriteLine("                    }")
            OutputFile.WriteLine("                    conn.Close();")
            OutputFile.WriteLine("                }")
            OutputFile.WriteLine("                else {")
            OutputFile.WriteLine("                    storedProcedure = " + Chr(34) + "sp_" + TableName + "_Insert" + Chr(34) + ";")
            OutputFile.WriteLine("                    cmd.CommandText=storedProcedure;")
            OutputFile.WriteLine("")
            OutputFile.WriteLine("                    cmd.Parameters[" + Chr(34) + "@" + PrimaryKey + Chr(34) + "].Value = this.m_" + VBFunctions.VBName(PrimaryKey.ToLower()) + ";")
            'OutputFile.WriteLine("                    cmd.Parameters(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ").Value = Me.m_" + VBFunctions.VBName(PrimaryKey.ToLower()))
            'OutputFile.WriteLine("                    If IsIdentityTable() Then")
            'OutputFile.WriteLine("                        cmd.Parameters(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ").Direction = ParameterDirection.Output")
            'OutputFile.WriteLine("                    Else")
            'OutputFile.WriteLine("                        cmd.Parameters(" + Chr(34) + "@" + PrimaryKey + Chr(34) + ").Direction = ParameterDirection.Input")
            'OutputFile.WriteLine("                    End If")
            OutputFile.WriteLine("                    if (IsIdentityTable) {")
            OutputFile.WriteLine("                        cmd.Parameters[" + Chr(34) + "@" + PrimaryKey + Chr(34) + "].Direction = ParameterDirection.Output;")
            OutputFile.WriteLine("                    } else {")
            OutputFile.WriteLine("                        cmd.Parameters[" + Chr(34) + "@" + PrimaryKey + Chr(34) + "].Direction = ParameterDirection.Input;")
            OutputFile.WriteLine("                    }")
            OutputFile.WriteLine("                    try {")
            OutputFile.WriteLine("                        conn.Open();")
            OutputFile.WriteLine("                        cmd.ExecuteNonQuery();")
            OutputFile.WriteLine("                    }")
            OutputFile.WriteLine("                    catch (Exception e) {")
            OutputFile.WriteLine("                        throw e;")
            OutputFile.WriteLine("                    }")
            OutputFile.WriteLine("                    if (IsIdentityTable) {")
            OutputFile.Write("                        this.m_" + VBFunctions.VBName(PrimaryKey.ToLower()) + " = (")
            For ndx = 1 To count
                dr = dt.Rows(ndx - 1)
                If CStr(dr("COLUMN_NAME")).ToLower = PrimaryKey.ToLower Then
                    OutputFile.WriteLine(GetSQLType(dr("TYPE_NAME")) + ")cmd.Parameters[" + Chr(34) + "@" + PrimaryKey + Chr(34) + "].Value;")
                    Exit For
                End If
            Next
            'OutputFile.WriteLine("                        this.m_" + VBFunctions.VBName(PrimaryKey.ToLower()) + " = (Int32)cmd.Parameters[" + Chr(34) + "@" + PrimaryKey + Chr(34) + "].Value;")
            OutputFile.WriteLine("                    }")
            OutputFile.WriteLine("                    conn.Close();")
            OutputFile.WriteLine("                }")
            OutputFile.WriteLine("            }")
            OutputFile.WriteLine("        }")
            OutputFile.WriteLine("")
        Else
            Dim dr As DataRow
            Dim ndx As Integer
            Dim count As Integer = dt.Rows.Count
            Dim type As String
            Dim varname As String

            OutputFile.WriteLine("        public void Save()")
            OutputFile.WriteLine("        {")
            OutputFile.WriteLine("            string storedProcedure;")
            OutputFile.WriteLine("            System.Data.OleDb.OleDbCommand cmd = new System.Data.OleDb.OleDbCommand();")
            OutputFile.WriteLine("            System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection(); ")
            OutputFile.WriteLine("            string ConnectionString = GetConnectString();")
            OutputFile.WriteLine("")
            OutputFile.WriteLine("            if ((m_isDirty)) {")
            OutputFile.WriteLine("                conn.ConnectionString = ConnectionString;")
            OutputFile.WriteLine("                cmd.Connection = conn;")
            OutputFile.WriteLine("                cmd.CommandType = CommandType.StoredProcedure;")
            OutputFile.WriteLine("")

            For ndx = 1 To count
                dr = dt.Rows(ndx - 1)
                type = dr("TYPE_NAME")
                varname = dr("COLUMN_NAME")
                If type = "int identity" Then type = "Integer"
                If type = "int" Then type = "Integer"
                If type = "nchar" Then type = "VarWChar"
                If type = "nvarchar" Then type = "VarWChar"
                If type = "varchar" Then type = "VarWChar"
                If type = "datetime" Then type = "Date"
                If type = "numeric" Then type = "Numeric"
                If type = "bit" Then type = "Boolean"
                If type = "money" Then type = "Decimal"
                If type = "decimal" Then type = "Decimal"
                If type = "text" Then type = "Text"
                If type = "real" Then type = "Double"
                If type = "float" Then type = "Single"
                If type = "char" Then type = "Char"
                If type = "tinyint" Then type = "SmallInt"
                If type = "smallint" Then type = "SmallInt"
                If type = "smalldatetime" Then type = "Date"
                If varname = PrimaryKey Then Continue For

                OutputFile.WriteLine("                cmd.Parameters.Add(" + Chr(34) + varname + Chr(34) + ", System.Data.OleDb.OleDbType." + type + ");")
                If varname = PrimaryKey Then Continue For
                If type = "TinyInt" Or type = "SmallInt" Or type = "Int" Or type = "BigInt" Or type = "Integer" Then
                    OutputFile.WriteLine("                if (this.m_" + VBFunctions.VBName(varname.ToLower()) + " !=0) {")
                ElseIf type.ToUpper = "DECIMAL" Or type.ToUpper = "MONEY" Or type.ToUpper = "NUMERIC" Then
                    OutputFile.WriteLine("                if (this.m_" + VBFunctions.VBName(varname.ToLower()) + " !=0M) {")
                ElseIf type = "Float" Or type = "Real" Or type = "Double" Or type = "Single" Then
                    OutputFile.WriteLine("                if (this.m_" + VBFunctions.VBName(varname.ToLower()) + " !=0.0) {")
                ElseIf type = "Bit" Or type = "Boolean" Then
                    OutputFile.WriteLine("                if (this.m_" + VBFunctions.VBName(varname.ToLower()) + " !=false) {")
                Else
                    'If type <> "image" Then
                    OutputFile.WriteLine("                if (this.m_" + VBFunctions.VBName(varname.ToLower()) + " !=null) {")
                    'Else
                    'OutputFile.WriteLine("                If (this.m_" + VBFunctions.VBName(varname.ToLower()) + " IsNot Nothing Then")
                    'End If
                End If
                OutputFile.WriteLine("                    cmd.Parameters[" + Chr(34) + varname + Chr(34) + "].Value = this.m_" + VBFunctions.VBName(varname.ToLower()) + ";")
                OutputFile.WriteLine("                } else {")
                OutputFile.Write("                    cmd.Parameters[" + Chr(34) + varname + Chr(34) + "].Value = ")
                If type = "NVarChar" Or type = "VarChar" Or type = "VarWChar" Then
                    OutputFile.WriteLine(Chr(34) + Chr(34) + ";")
                End If
                If type = "Bit" Or type = "Boolean" Then
                    OutputFile.WriteLine("false;")
                End If
                If type = "DateTime" Or type = "Date" Then
                    OutputFile.WriteLine("System.DBNull.Value;")
                End If
                If type.ToUpper = "INTEGER" Or type = "SmallInt" Or type = "BigInt" Or type = "Int" Then
                    OutputFile.WriteLine("0;")
                End If
                If type.ToUpper = "DECIMAL" Or type = "Money" Or type = "Numeric" Then
                    OutputFile.WriteLine("0M;")
                End If
                If type = "Single" Or type = "Double" Then
                    OutputFile.WriteLine("0.0;")
                End If
                If type.ToUpper <> "NUMERIC" And type.ToUpper <> "DATE" And type.ToUpper <> "SINGLE" And type.ToUpper <> "DECIMAL" And type.ToUpper <> "INTEGER" And type.ToUpper <> "BOOLEAN" And type <> "VarWChar" And type <> "Char" AndAlso type <> "Decimal" AndAlso type <> "TinyInt" AndAlso type <> "SmallInt" AndAlso type <> "Int" AndAlso type <> "Bit" AndAlso type <> "Money" AndAlso type <> "DateTime" AndAlso type <> "VarChar" AndAlso type <> "NVarChar" AndAlso type <> "Float" Then
                    OutputFile.WriteLine("null;")
                End If
                OutputFile.WriteLine("                }")
                OutputFile.WriteLine("")
            Next

            OutputFile.WriteLine("                if (this.m_" + VBFunctions.VBName(PrimaryKey.ToLower()) + " > 0) {")
            OutputFile.WriteLine("                    storedProcedure = " + Chr(34) + "sp_" + TableName + "_Update" + Chr(34) + ";")
            OutputFile.WriteLine("                    cmd.CommandText=storedProcedure;")
            OutputFile.WriteLine("")
            OutputFile.WriteLine("                    cmd.Parameters[" + Chr(34) + PrimaryKey + Chr(34) + "].Value = this.m_" + VBFunctions.VBName(PrimaryKey.ToLower()) + ";")
            OutputFile.WriteLine("                    cmd.Parameters[" + Chr(34) + PrimaryKey + Chr(34) + "].Direction = ParameterDirection.Input;")
            OutputFile.WriteLine("                    try {")
            OutputFile.WriteLine("                        conn.Open();")
            OutputFile.WriteLine("                        cmd.ExecuteNonQuery();")
            OutputFile.WriteLine("                    }")
            OutputFile.WriteLine("                    catch (Exception e ) {")
            OutputFile.WriteLine("                        throw e;")
            OutputFile.WriteLine("                    }")
            OutputFile.WriteLine("                    conn.Close();")
            OutputFile.WriteLine("                }")
            OutputFile.WriteLine("                else {")
            OutputFile.WriteLine("                    storedProcedure = " + Chr(34) + "sp_" + TableName + "_Insert" + Chr(34) + ";")
            OutputFile.WriteLine("                    cmd.CommandText=storedProcedure;")
            OutputFile.WriteLine("")
            OutputFile.WriteLine("                    cmd.Parameters[" + Chr(34) + PrimaryKey + Chr(34) + "].Value = this.m_" + VBFunctions.VBName(PrimaryKey.ToLower()) + ";")
            OutputFile.WriteLine("                    cmd.Parameters[" + Chr(34) + PrimaryKey + Chr(34) + "].Direction = ParameterDirection.Output;")
            OutputFile.WriteLine("                    try {")
            OutputFile.WriteLine("                        conn.Open();")
            OutputFile.WriteLine("                        cmd.ExecuteNonQuery();")
            OutputFile.WriteLine("                    }")
            OutputFile.WriteLine("                    catch (Exception e) {")
            OutputFile.WriteLine("                        throw e;")
            OutputFile.WriteLine("                    }")
            OutputFile.WriteLine("                    this.m_" + VBFunctions.VBName(PrimaryKey.ToLower()) + " = (Int32)cmd.Parameters[" + Chr(34) + "@" + PrimaryKey + Chr(34) + "].Value;")
            OutputFile.WriteLine("                    conn.Close();")
            OutputFile.WriteLine("                }")
            OutputFile.WriteLine("            }")
            OutputFile.WriteLine("        }")
            OutputFile.WriteLine("")
        End If
    End Sub

    Public Function GetSQLType(ByVal Type As String) As String Implements LangImplementation.GetSQLType
        If Type = "binary" Or Type = "image" Or Type = "timestamp" Or Type = "varbinary" Then
            Return "byte []"
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
            Return "string"
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
            Return "bool"
        End If
        If Type = "money" Or Type = "smallmoney" Then
            Return "Decimal"
        End If
        If Type = "text" Then
            Return "string"
        End If
        If Type = "smalldatetime" Then
            Return "System.DateTime"
        End If
        If Type = "real" Then
            Return "float"
        End If
        If Type = "tinyint" Then
            Return "Byte"
        End If
        If Type = "float" Then
            Return "double"
        End If
        If Type = "uniqueidentifier" Then
            Return "Guid"
        End If
        Return Type
    End Function

    Private Function FixCSName(ByVal str As String) As String
        Dim str2 As String = ""

        str2 = str.ToLower()
        Mid(str2, 1, 1) = UCase(Mid(str2, 1, 1))

        Return str2
    End Function

End Class
