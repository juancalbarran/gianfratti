<!--#include file="common.asp" -->
<%
Dim usrID								'Holds logged in users ID
Dim Username		'Holds logged in username
Dim addpass				'Holds admin password
Dim login								'Holds the value of the event either login or empty
Dim rs											'New record sheet

usrID = CLng(Request.querystring("ID"))
username = Request.querystring("username")
addpass = Request.querystring ("addpass")
login = Request.querystring ("event")
%>

<%
	'If the query string login is login then user has just eneterd
 IF login = "login" AND addpass <> strAdminPass THEN
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
rs.fields("Speach")="<Center><font color=#008000><b>"&strTxtWelcome2&" "&Username&", "&strTxtPleaseWait&"</b></font></center>"
'Update
rs.Update

'Close and clean
rs.Close
adoCon.close

'Redirect back to ths page but witout the login event
Response.redirect("chat_main.asp?ID="&usrID&"&addpass="&addpass&"&username="&username)
%>
<% ELSE%>
<%END IF%>

<HTML>
	<head>


<!--#include file="style/style.asp" -->
<script language="JavaScript">
var countDownInterval=<%=intRefreshRate%>;
var c_reloadwidth=200
</script>
<ilayer id="c_reload" width=&{c_reloadwidth}; ><layer id="c_reload2" width=&{c_reloadwidth}; left=0 top=0></layer></ilayer>

<script>
var countDownTime=countDownInterval+1;
function countDown(){
countDownTime--;
if (countDownTime <=0){
countDownTime=countDownInterval;
clearTimeout(counter)
window.location.reload()
return
}
if (document.all)
document.all.countDownText.innerText = countDownTime+" ";
else if (document.getElementById)
document.getElementById("countDownText").innerHTML=countDownTime+" "
else if (document.layers){ 
document.c_reload.document.c_reload2.document.write('<table  width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td class="hidden"><b id="countDownText">'+countDownTime+'</b></td></tr></table>')
document.c_reload.document.c_reload2.document.close()
}
counter=setTimeout("countDown()", 1000);
}

function startit(){
if (document.all||document.getElementById)
document.write('<table  width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td class="hidden"><b id="countDownText">'+countDownTime+'</b></td></tr></table>')
countDown()
}

if (document.all||document.getElementById)
startit()
else
window.onload=startit

</script>
	</head>
	<body style="margin: 0" topmargin="0" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0" background="images/livesupport.jpg" STYLE="background-attachment: fixed;background-repeat: no-repeat;background-position: -20 144;">
		<table  width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="10">
				</td>
				<td class="main">
					
<%
'Open a new connection to the database
adoCon.Open cString

'Create a new SQL string
strSQL="SELECT * FROM tblChat WHERE RoomID="&usrID&" ORDER BY ID DESC"

'Create a new record sheet
set rs=server.CreateObject("ADODB.Recordset")

'Open the record sheet and SQL string
rs.open strSQL,adoCon,3,3

'Loop until the record sheet is empty only printing ones where room ID equals current ID
Do While not rs.EOF 
     Response.Write ("<b>")
     Response.Write (rs("Speaker")) 
     Response.Write ("</b> ")
     Response.Write (rs("Speach")) 
     Response.Write ("<BR>")
     'Move to the next record in the recordset
     rs.MoveNext
'Loop event
Loop 

'Close and clean
rs.Close
Set rs = Nothing
adoCon.close
%>
					
				</td>
			</tr>
		</table>
