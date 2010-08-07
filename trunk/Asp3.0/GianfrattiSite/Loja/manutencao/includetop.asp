<%@ Language=VBScript %>
<%
Option Explicit
Response.Buffer = True
Response.Expires = -10
Response.ExpiresAbsolute = DateAdd("d", -1, Now())
%>
<!-- #include file="adm_restrito.asp" -->
<!-- #include file="includes/pwdprotect.asp" -->
<!-- #include file="classes/database.asp" -->
<!-- #include file="includes/err.asp" -->
<!-- #include file="includes/functions.asp" -->
<!-- #include file="includes/adovbs.inc" -->
<!-- #include file="classes/columns.asp" -->
<%
If Right(Request.ServerVariables("SCRIPT_NAME"), Len("createdb.asp")) <> "createdb.asp" _
And Right(Request.ServerVariables("SCRIPT_NAME"), Len("loaddb.asp")) <> "loaddb.asp" _
And Right(Request.ServerVariables("SCRIPT_NAME"), Len("selectdb.asp")) <> "selectdb.asp" _
Then

	If IsBlank(Session("dbPath")) = True Then
		Response.Redirect "loaddb.asp"
		Response.End
	End If

	Dim db

	Set db = New DBConnect

	On Error Resume Next

	
	If db.Connect(Session("dbUser"), Session("dbPassword"), Session("dbPath")) = False Then
		'Display an error
		strError = "A connection to the database hasn't been established. " & _
		"Tente novamente: <a href=""loaddb.asp"">clic aqui</a> ou aguarde redirecionamento automomático."
		ErrorMessage "Connection Failure", strError
	
		
		IncludeBottom
	
		
		JSRedirect "loaddb.asp", 5
	
		Response.End
	End If
	
	On Error GoTo 0


	db.SetCursors adUseClient, adOpenStatic, 30
End If

Dim objFSO, action, i, strError
Dim database, table, field, record, records
Dim strQuery, tableloop, index, fieldloop, first, recordloop
Dim strQuery2, indexloop, subaction, redirect, valid
Dim intCurrentPage, intPageSize, intTotalPages, intRecordCount
Dim strPagingLink, whereclause, temp, objFile, temparray
Dim intI, view, objCommand, viewloop, column, forloop

Set column = New ColumnTypes

Const name = "EditaMDB"
Const version = "2.0"
'Const name = "aspAccessEditor"
'Const version = "2.0"
%>