<!--#include file="db.asp"-->
<!--#include file="mysConfiguracoes.asp"-->
<%
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	Session.LCID = 1033
	
	If Session("mysConversaID") = "" Then
		Response.Write "<script>window.close();</script>"
		Response.End
	End If
%>
<html>
<head>
<title><%=strConfigNome%></title>
<style>
a:link	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:visited	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:hover	{font-size:8pt; font-family: Tahoma, Verdana; color:F4B511; TEXT-DECORATION: none;}
body	{ font-family: Tahoma, Verdana; font-size: 8pt; color: <%=strConfigFonte%>; }
td		{ font-family: Tahoma, Verdana; font-size: 8pt; color: <%=strConfigFonte%>; }
.campo{				
		font-family: Arial, Verdana; 
		font-size: 11px; 
		background-color: #FFFFFF;	
		border-left: 1 solid #68A4C8; 
		border-right: 1 solid #B8D0D8; 
		border-top: 1 solid #68A4C8; 
		border-bottom: 1 solid #B8D0D8;
		}
				
.botao 	{
			background-color: #E8E8E8; 
			color: black; 
			border-color: #FFFFFF; 
			border-width: 1px; 
			font-family: Tahoma, Verdana; 
			font-size: 8pt;
		}
</style>
</head>
<script language="JavaScript">
function getTime(){
  var date = new Date();
  return date.getTime();
}

var img_check = new Image ;
var refreshTime = 5 * 1000;

function checkImg(){
	imgStatus = 0 ;
	imgStatus = img_check.width;
	if ( imgStatus == 1 ){	}
	else {
		location.href = 'mysChat.asp';
	}
	
}
function checkNewMsg(){
	img_check.src = "mysImg.asp?opcao=PreChat&rand=" + getTime();
	img_check.onload = checkImg;
		window.setTimeout("checkNewMsg();",refreshTime);
}
checkNewMsg();

var TimeOut = setTimeout("location.href = 'mysChatOff.asp?status=TimeOut';",<%=strConfigTempo%> * 1000);
</script>
<body topmargin="0" leftmargin="0" bottommargin="0">
<table height="100%" width="100%" cellspacing="0">
	<tr bgcolor="<%=strConfigTopo%>">
		<td valign="top" width="50%" height="10%">
			<img src="<%=strConfigLogo%>" alt="" border="0">
		</td>
		<td align="right" valign="bottom">&nbsp;
		</td>
	</tr>
	<tr>
		<td colspan="2" height="75%" valign="top" style="border: 1 solid #DDDDDD">
			<br>
			<table width="70%" align="center">
				<tr>
					<td><img src="img/ampulheta.gif"></td>
					<td><font size="2">Por favor, aguarde até que um de nossos operadores possa lhe atender...</font></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr bgcolor="<%=strConfigTopo%>">
		<td valign="middle" colspan="2" align="center">
			<font size="1">

			</font>
		</td>
	</tr>
</table>
</body>
</html>
