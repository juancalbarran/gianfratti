<%
Dim strDBpathCorrection					'Variable to hold database path correction
strDBpathCorrection = "../"
%>
<!--#include file="../common.asp" -->
<!--#include file="check_admin.asp" -->
<% IF strAdminAutoRefresh = "Yes" THEN%>
<script language="JavaScript">
var countDownInterval=10;
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

<%ELSE%>
<%END IF%>

<html>
	<head>
<!--#include file="../style/style.asp" -->
	</head>
	
	<body style="margin: 0" topmargin="0" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0" background="<%=strDBpathCorrection%><%=img_bg%>">
		<Center>
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" height="8">
				<tr>
					<td >
					</td>
				</tr>
			</table>
			<table border="0" cellspacing="0" cellpadding="0" width="90%">
				<tr>
					<td>
						<table  border="0" cellspacing="0" cellpadding="0" height="15">
							<tr>
								<td bgcolor="#000000" width="15"><img src="<%=strDBpathCorrection%><%=img_top_left_curve%>"></td>
								<td bgcolor="#000000" width="100%" class="header">
									<B>
										&nbsp;&nbsp;&nbsp;Visitantes Online
									</B>
								</td>
								<td bgcolor="#000000" width="15"><img src="<%=strDBpathCorrection%><%=img_top_right_curve%>"></td>
							</tr>
						</table>
						<table  width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
							<tr>
								<td bgcolor="#ffffff">
									<table  width="100%" border="0" cellspacing="0" cellpadding="2">
										<tr>
												<td class="main" valign="top" align="center">
<%
Dim AdminstrIPAddress
AdminstrIPAddress = Request.ServerVariables("REMOTE_ADDR")  
%>
<table  width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td ><img src="images/ppl.gif" width="32" height="32"></td>
		<td class="main" valign="top" width="75%">
			A tabela a seguir mostra todos os seus Visitantes Online no seu site.<BR>Somente mostrará os Visitantes Online se na página .asp estiver o include CheckChat.asp<BR>Seu IP é : <B><%=AdminstrIPAddress%></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Esta página foi carregada em  : <B><% Response.write now()%></b>
		</td>
<form action="admin_change.asp?addpass=<% Response.write Request.querystring("addpass")%>&function=SHOWAD" method="post">
		<td align="right" class="main">
		Mostrar você na listagem? <select name="ShowAdmins" class="button">
<option value="Yes" <%IF strShowAdmins = "Yes" THEN RESPONSE.WRITE("Selected")%>>Sim
<option value="No" <%IF strShowAdmins <> "Yes" THEN RESPONSE.WRITE("Selected")%>>Não
</select> &nbsp; <input type="submit" value="Atualizar" class="button">
		</td></form>
	</tr>
</table>
<BR>
<table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000" height="14">
        <tr> 
         <td bgcolor="#c0c0c0" class="main" align="center" width="25"><b>&nbsp;ID&nbsp;</td>
         <td bgcolor="#c0c0c0" class="main" align="center"><b>&nbsp;IP&nbsp;</td>
         <td bgcolor="#c0c0c0" class="main" align="center"><b>&nbsp;Nome&nbsp;</td>
         <td bgcolor="#c0c0c0" class="main" align="center"><b>&nbsp;Browser&nbsp;</td>
         <td bgcolor="#c0c0c0" class="main" align="center"><b>&nbsp;Online desde&nbsp;</td>
         <td bgcolor="#c0c0c0" class="main" align="center"><b>&nbsp;Ativo Online&nbsp;</td>
         <td bgcolor="#c0c0c0" class="main" align="center"><b>&nbsp;Iniciar Chat&nbsp;</td>
         <td bgcolor="#c0c0c0" class="main" align="center"><b>&nbsp;Vis em Chat?&nbsp;</td>
         <td bgcolor="#c0c0c0" class="main" align="center"><b>&nbsp;Op em Chat?&nbsp;</td>
        </tr>

<%
Dim rsDetails		'Record sheet for user details
Dim usercount		'Holds number of users browsing

usercount = 0 	'Set to 0

'Open database
adoCon.Open cString

'Create new record sheet
Set rsDetails = Server.CreateObject("ADODB.Recordset")

'Create new SQL string
strSQL = "SELECT tblActiveUsers.IP, tblActiveUsers.RealName, tblActiveUsers.InChat, tblActiveUsers.CameOnline, tblActiveUsers.LastActive, tblActiveUsers.ChatRequest, tblActiveUsers.ID, tblActiveUsers.Browser, tblActiveUsers.AdminIn FROM tblActiveUsers;"

'Open recordsheet and execute SQL
rsDetails.Open strSQL, adoCon

'Loop through the recordset 
Do While not rsDetails.EOF 

Response.Write "<Tr>" 
Response.Write "<TD bgcolor=#ffffff class=main align=center>"
Dim usrID2
usrID2 = rsDetails("ID")
Response.Write (rsDetails("ID")) 
Response.Write "</TD>" 
Response.Write "<TD bgcolor=#ffffff class=main align=center>" 
Response.Write (rsDetails("IP")) 
Response.Write "</TD>" 
Response.Write "<TD bgcolor=#ffffff class=main align=center>" 
IF rsDetails("RealName") <> "" THEN
Response.Write (rsDetails("RealName")) 
ELSE Response.write ("N/A")
End if
Response.Write "</TD>" 
Response.Write "<TD bgcolor=#ffffff class=main align=center>" 
Response.Write (rsDetails("Browser")) 
Response.Write "</TD>" 
Response.Write "<TD bgcolor=#ffffff class=main align=center>" 
Response.Write (rsDetails("CameOnline")) 
Response.Write "</TD>" 
Response.Write "<TD bgcolor=#ffffff class=main align=center>" 
Response.Write (rsDetails("LastActive")) 
Response.Write "</TD>" 
Response.Write "<TD bgcolor=#ffffff class=main align=center width=95>"
IF rsDetails("ChatRequest") = "0" THEN
Response.write("<font color=#ff0000><b>NO</b></font><BR><a class=bluelink href=admin_request.asp?addpass="&addpass&"&ID="&usrID2&">Iniciar Chat</a>")
ELSE
Response.write("<font color=#008000><b>YES</b></font><BR><a class=bluelink href=admin_request.asp?addpass="&addpass&"&ID="&usrID2&">Iniciar de novo</a>")
END IF
Response.Write "</TD>" 
Response.Write "<TD bgcolor=#ffffff class=main align=center>"
IF rsDetails("InChat") <> 0 THEN
Response.write("<font color=#008000><b>Sim</b></font>")
ELSE
Response.write("<font color=#ff0000><b>Nao</b></font>")
END IF
Response.Write "</TD>" 
Response.Write "<TD bgcolor=#ffffff class=main align=center>"
Dim strAdminIn
strAdminIn = rsDetails("AdminIn")
IF strAdminIn = "Yes" THEN
Response.write("<font color=#008000><b>YES</b></font><BR><a class=bluelink href=../chat.asp?addpass="&addpass&"&ID="&usrID2&" target=_blank>Abrir Chat</a>")
ELSE
Response.write("<font color=#ff0000><b>NO</b></font><BR><a class=bluelink href=../chat.asp?addpass="&addpass&"&ID="&usrID2&" target=_blank>Abrir Chat</a>")
END IF
Response.Write "</TD>"
Response.Write "</Tr>" 

usercount = usercount +1 'Add one to the usercount

'Move to the next record in the recordset 
rsDetails.MoveNext

Loop 

'Close and clean up
rsDetails.Close
Set rsDetails = Nothing
adoCon.close

%></table>


<BR>Cada visitante recebe um único ID (para identificação) que é mostrado na Coluna ID. Para entrar no chat com um visitante (abrirá uma janela nova para se iniciar a conversa com o visitante) clique no link <font color="#0000FF">Iniciar Chat</font> . Se o visitante está no chat, então aparecerá na Coluna Em Chat a palavra 'Sim' ou 'Yes'. Se um operador ou o administrador estiver no chat, aparecerá na Coluna Chat a palavra 'Sim' ou 'Yes'.<BR><BR>
												</center>
											</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>					
					<table  border="0" cellspacing="0" cellpadding="0" height="15">
						<tr>
							<td bgcolor="#000000" width="15"><img src="<%=strDBpathCorrection%><%=img_bottom_left_curve%>"></td>
							<td bgcolor="#000000" width="100%" >
							</td>
							<td bgcolor="#000000" width="15"><img src="<%=strDBpathCorrection%><%=img_bottom_right_curve%>"></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<table  width="100%" border="0" cellspacing="0" cellpadding="0" height="8">
			<tr>
				<td >
				</td>
			</tr>
		</table>
	</center>
</body>
</html>
