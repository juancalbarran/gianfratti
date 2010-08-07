<!--#include file="db.asp"-->
<%
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	Session.lCid = 1033
	
	If NOT Session("mysOP") Then Response.Redirect "mysOpSair.asp"
%>
<html>
<head>
<title>MySupport - Atendimento Online</title>
<style>
a:link	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:visited	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:hover	{font-size:8pt; font-family: Tahoma, Verdana; color:F4B511; TEXT-DECORATION: none;}
body	{ font-family: Tahoma, Verdana; font-size: 8pt; }
td		{ font-family: Tahoma, Verdana; font-size: 8pt; }
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
 	
var stTime    = getTime();
var img_check = new Image ;
var refreshTime = 3 * 1000;
var isOk = true;

function checkImg(){
	imgStatus = 0 ;
	imgStatus = img_check.height;
	if ( imgStatus == 1 ){
		if(document.all("meio").src="mysOpChamados.asp"){
			document.all("meio").src="mysOpChamados.asp"
		}
		}
}
function checkNewMsg(){
	img_check.src = "mysOpImg.asp"
	img_check.onload = checkImg;
	if (isOk)
		window.setTimeout("checkNewMsg();",refreshTime);
}
checkNewMsg();
</script>
<body topmargin="0" leftmargin="0" bottommargin="0">
<table height="100%" width="100%" cellspacing="0">
	<tr bgcolor="F5F5F5">
		<td valign="middle" width="50%" height="60"><img src="img/mysupport.gif" alt="" border="0">
		</td>
		<td valign="middle" align="left">&nbsp;
		</td>
		<td>&nbsp;&nbsp;</td>
	</tr>
	<tr bgcolor="#07435E">
		<td colspan="3"><font color="#FFFFFF">
		<a href="mysOpChamados.asp" target="meio">
		<img title="Chamados em Espera" src="img/b_chamados.gif" alt="" border="0"></a>
		<img src="img/b_1px.gif" alt="" border="0">
		<a href="mysOpComandos.asp" target="meio">
		<img title="Mensagens programadas" src="img/b_comandos.gif" alt="" border="0"></a>
		<img src="img/b_1px.gif" alt="" border="0">
		<a href="mysOpHistorico.asp" target="meio">
		<img title="Historico de Atendimentos" src="img/b_historico.gif" alt="" border="0"></a>
		<img src="img/b_1px.gif" alt="" border="0">
		<a href="mysOpConfiguracoes.asp" target="meio">
		<img title="Configurações" src="img/b_configuracoes.gif" alt="" border="0"></a>
		<img src="img/b_1px.gif" alt="" border="0">
		<a href="mysOpSair.asp" target="meio">
		<img title="Sair do sistema" src="img/b_sair.gif" alt="" border="0"></a>
		</font></td>
	</tr>
	<tr>
		<td colspan="3" height="2"></td>
	</tr>
	<tr bgcolor="#F4B511">
		<td colspan="3" height="1"></td>
	</tr>
	<tr>
		<td colspan="3" height="2"></td>
	</tr>
	<tr>
		<td colspan="3" height="75%" valign="top">
			<iframe src="mysOpChamados.asp" name="meio" id="meio" width="100%" height="100%" frameborder="0"></iframe>
		</td>
	</tr>
	<tr bgcolor="#DDDDDD">
		<td colspan="3" height="1"></td>
	</tr>
	<tr>
		<td colspan="3" height="5" bgcolor="F5F5F5"></td>
	</tr>
	<tr bgcolor="F5F5F5">
		<td valign="top" colspan="3" height="38" align="center">
			<font size="1"></font></td>
	</tr>
		</td>
	</tr>
</table>
</body>
</html>
