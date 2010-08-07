<!--#include file="common.asp" -->


<% 
Dim usrID
Dim realname

usrID=CLng(Request.QueryString("ID"))

'Create some new vairbales
Dim rs 'New record sheet

'Open new connection to database
adoCon.Open cString

'Create new SQL string
strsql="SELECT * FROM tblActiveUsers WHERE ID="&usrID&" "
set rs=server.CreateObject("ADODB.Recordset")
rs.open strsql,adocon,3,3
realname = rs.fields("RealName")
rs.fields("InChat")=0
rs.fields("ChatRequest")=0
IF request.querystring("addpass") = strAdminPass THEN
rs.fields("AdminIn")="No"
Else
End if
rs.Update

rs.close
adoCon.close
set rs = nothing
%>
<%
'Open a new connection to the database
adoCon.Open cString

'Create new SQL string
strSQL= "SELECT tblChat.RoomID, tblChat.Speaker, tblChat.Speach FROM tblChat;"

'Create a new record sheet
set rs=server.CreateObject("ADODB.Recordset")

'Set cursor and locktypes
Rs.CursorType = 2
Rs.LockType = 3

'Open record sheet, execute SQL string
rs.open strSQL,adoCon,3,3

'Add a new record
rs.AddNew
'Set the roomID to the users ID
rs.fields("RoomID")=usrID
'Set the speakers field to blank
rs.fields("Speaker")=""
'Set the speach field to the welcome message
IF request.querystring("addpass") = strAdminPass THEN
rs.fields("Speach")="<Center><font color="&strExitColour&"><b>This Live Chat session has now ended.  "&strOperatorName&"  has left the chat room</b></font></center>"
ELSE
rs.fields("Speach")="<Center><font color="&strExitColour&"><b>"&realname&"  has left the chat room</b></font></center>"
ENd if
'Update
rs.Update

'Close and clean
rs.Close
adoCon.close
%>
<html>
<head>

</head>
<BODY onLoad="setTimeout(window.close, 1500)">
</body>
</html>

