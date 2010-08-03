Public Interface SQLImplementation
    Enum AuthenticationTypes
        SQLServerAuthentication
        WindowsAuthentication
    End Enum

    Sub SQLConnect(ByVal SQLServerName As String, ByVal SQLDatabaseName As String, ByVal SQLUserName As String, ByVal SQLPassword As String)
    ReadOnly Property IsConnected()
    Property TheOutputFile() As IO.TextWriter
    Sub SQLClose()
    Property DoEncryption() As Boolean
    Property EncryptionKey() As String
    Property Version() As String
    Property AuthenticationType() As AuthenticationTypes
    Function GetFields(ByVal TableName As String) As Data.DataTable
    Function GetPrimaryKey(ByVal TableName As String) As Data.DataTable
    Function GetTables() As Data.DataTable
    Function GetForeignKeys(ByVal TableName As String) As Data.DataTable
    Function IsSystemTable(ByVal TableName As String) As Boolean
    Function IsView(ByVal TableName As String) As Boolean
    Function IsIdentityTable(ByVal tablename As String) As Boolean
    Function IsIdentityField(ByVal tablename As String, ByVal fieldname As String) As Boolean
    Property SupressComments() As Boolean
    Property AccessFileName() As String

    Sub CreateStoredProcedureUpdate(ByVal dt As DataTable, ByVal tn As String, ByVal PrimaryKey As String)
    Sub CreateStoredProcedureDelete(ByVal dt As DataTable, ByVal tn As String, ByVal PrimaryKey As String)
    Sub CreateStoredProcedureInsert(ByVal dt As DataTable, ByVal tn As String, ByVal PrimaryKey As String)
    Sub CreateStoredProcedureSelect(ByVal dt As DataTable, ByVal tn As String, ByVal PrimaryKey As String)
    Sub CreateStoredProcedureGetAll(ByVal dt As DataTable, ByVal tn As String, ByVal PrimaryKey As String)
    Sub CreateStoredProcedureFKs(ByVal dt As DataTable, ByVal tn As String, ByVal PrimaryKey As String)
    Sub AutoInsertProcedures(ByVal proc As String)
End Interface
