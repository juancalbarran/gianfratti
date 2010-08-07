<%
'If admin is logged in this function is called to redirect them if the password does not match
Dim addpass
addpass = Request.queryString("addpass")

IF addpass <> strAdminPass THEN Response.redirect("login.asp")
%>
<%IF strAdminAutoPopup = "Yes" THEN%>
<%
Dim usrPopID
Dim usrPopInChat
Dim usrPopAdminIn

Dim rsPop		'Record sheet for user details

'Open database
adoCon.Open cString

'Create new record sheet
Set rsPop = Server.CreateObject("ADODB.Recordset")

'Create new SQL string
strSQL = "SELECT tblActiveUsers.InChat, tblActiveUsers.ID, tblActiveUsers.AdminIn FROM tblActiveUsers;"

'Open recordsheet and execute SQL
rsPop.Open strSQL, adoCon

'Loop through the recordset 
Do While not rsPop.EOF 

usrPopID = (rsPop("ID")) 
usrPopInChat = (rsPop("InChat")) 
usrPopAdminIn = (rsPop("AdminIn")) 

IF usrPopInChat = 5 AND usrPopAdminIn = "No" THEN%>
<script language="Javascript">
popUSR<%=usrPopID%>=window.open("chat.asp?addpass=<%=addpass%>&ID=<%=usrPopID%>","popUSR<%=usrPopID%>","width=400, height=300, toolbar=yes, menubar=yes, scrollbars=yes, resizable=yes, location=yes, directories=yes, status=yes");
</script>
<%ELSE%>
<%END IF%>
<%
'Move to the next record in the recordset 
rsPop.MoveNext

Loop 

'Close and clean up
rsPop.Close
Set rsPop = Nothing
adoCon.close
%>
<%ELSE%>
<%END IF%>