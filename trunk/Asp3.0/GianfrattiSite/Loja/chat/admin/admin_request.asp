<%
Dim strDBpathCorrection					'Variable to hold database path correction
strDBpathCorrection = "../"
%>
<!--#include file="../common.asp" -->
<!--#include file="check_admin.asp" -->
<%
'Set some variables
Dim usrID			'Holds user ID to make request
Dim rsChatRequest 'Chat request record sheet

usrID=CLng(Request.querystring("ID"))

'Open a new connection to the database
adoCon.Open cString

'Create new SQL string
StrSQL="SELECT * FROM tblActiveUsers WHERE ID="&usrID

'Create new record sheet
set rsChatRequest	=Server.CreateObject("ADODB.Recordset")

'Set cursor and locktypes
rsChatRequest.CursorType = 2
rsChatRequest.LockType = 3

'Open row data where the logged in users IP equals the IP in the database
rsChatRequest.open StrSQL, CString

'Set
rsChatRequest.fields("ChatRequest")="5"

rsChatRequest.Update

'Close record sheet and clean up
rsChatRequest.Close
Set rsChatRequest = Nothing

'Redirect the customer to the chat room
Response.redirect("admin_visitors.asp?addpass="&addpass)
%>