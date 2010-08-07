<!--#include file="common.asp" -->
<%
'Create some dimension variables
Dim addpass 									'Holds the value from the query string of the admin password
Dim strUsername					'Holds the value of the guests username
Dim usrID														'Holds the ID of the user
Dim rsActiveUser						'Record sheet for table active users
Dim sql																'Holds SQL string
%>

<%
'Give some variables some values
addpass = Request.queryString("addpass")				'Puts the admin password into variable
usrID = Request.querystring("ID")					'Puts users unique ID number into variable

'Request the username user inputted from form
strUsername = Request.form("login")
'If the username is empty then send them back to the login page
IF strUsername = "" THEN Response.redirect("default.asp")
%>

<%
'If the admin password in query string is correct the redirect to the chat page
IF addpass	= strAdminPass THEN
%>
<%
Response.redirect("chat.asp?ID="&usrID&"&addpass="&addpass&"&event=login")
%>
<%
'If admin password does not match then the user is a customer
ELSE
%>
<%
'Open the record sheet


set rsActiveUser	=Server.CreateObject("ADODB.Recordset")

sql="SELECT * FROM tblActiveUsers WHERE IP='" & strIPAddress & "';"

rsActiveUser.CursorType = 2
rsActiveUser.LockType = 3

'Open row data where the logged in users IP equals the IP in the database
rsActiveUser.open sql,CString

rsActiveUser.fields("RealName")=strUsername
rsActiveUser.fields("ChatRequest")=0  'Set the chat request field to 0 as admin is chatting/about to chat to customer
rsActiveUser.fields("Inchat")=5	'User is in chat so write this in database
usrID = rsActiveUser("ID")

rsActiveUser.Update

'Close record sheet and clean up
rsActiveUser.Close
Set rsActiveUser = Nothing

'Redirect the customer to the chat room
Response.redirect("chat.asp?ID="&usrID&"&event=login&username="&strUsername)
%>

<% 
End if
%>