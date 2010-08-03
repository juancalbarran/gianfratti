Public Interface LangImplementation
    Enum AuthenticationTypes
        SQLServerAuthentication
        WindowsAuthentication
    End Enum

    Property TheOutputFile() As IO.TextWriter
    Property TheDataNameSpace() As String
    Property TheBusinessNameSpace() As String
    Property TheSQLObject() As SQLImplementation
    Property TheSQLServerName() As String
    Property TheSQLDatabaseName() As String
    Property TheSQLUserName() As String
    Property TheSQLPassword() As String
    Property DoEncryption() As Boolean
    Property EncryptionKey() As String
    Property Version() As String
    Property SupressComments() As Boolean
    Property IsDatabaseMSSQL() As Boolean
    Property AuthenticationType() As AuthenticationTypes

    Sub CreateBusinessConstructors(ByVal dt As DataTable, ByVal TableName As String, ByVal PrimaryKey As String)
    Sub CreateBusinessGetAll(ByVal TableName As String)
    Sub CreateBusinessFKs(ByVal TableName As String)
    Sub CreateDataHeader(ByVal TableName As String)
    Sub CreateCollectionClass(ByVal TableName As String, ByVal PrimaryKey As String, ByVal EnableSorting As Boolean)
    Sub CreateInterfaceImplementation(ByVal TableName As String, ByVal PrimaryKey As String)
    Sub CreateBusinessHeader(ByVal TableName As String)
    Sub CreateDataCopySub(ByVal dt As DataTable)
    Sub CreateDataDeleteSub(ByVal dt As DataTable, ByVal TableName As String, ByVal PrimaryKey As String)
    Sub CreateDataGetSub(ByVal dt As DataTable, ByVal TableName As String, ByVal PrimaryKey As String)
    Sub CreateDataFillSub(ByVal dt As DataTable)
    Sub CreateDataConnectionStringSubs()
    Sub CreateDataConstructors(ByVal dt As DataTable, ByVal TableName As String, ByVal PrimaryKey As String)
    Sub CreateDataProperties(ByVal dt As DataTable, ByVal FKeys As DataTable)
    Sub CreateMemberVariables(ByVal dt As DataTable, ByVal FKeys As DataTable)
    Sub CreateInterfaces()
    Sub CreateUniversalConnection()
    Function GetSQLType(ByVal Type As String) As String
    Sub CreateDataGetAll(ByVal TableName As String)
    Sub CreateDataFooter()
    Sub CreateDataCustomQueryMethods(ByVal dt As DataTable, ByVal TableName As String)
    Sub CreateDataSaveSub(ByVal dt As DataTable, ByVal TableName As String, ByVal PrimaryKey As String)
    Sub CreateDataGetByFKs(ByVal TableName As String)
    Sub CreateSortingFunctions(ByVal TableName As String)
End Interface
