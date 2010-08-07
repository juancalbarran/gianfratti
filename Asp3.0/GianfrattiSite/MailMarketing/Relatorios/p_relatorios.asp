<!-- #include virtual="/MailMarketing/Shared/inc/logado.asp" -->
<!-- #include virtual="/MailMarketing/Shared/inc/Conn.asp" -->
<!-- #include virtual="/MailMarketing/Shared/inc/Config.asp" -->
<!-- #include virtual="/MailMarketing/Shared/inc/functions.asp" -->

<%
	opcao		= request("opcao")
	acao		= request("acao")
	id			= REQUEST("id")
	
%>
<html>
<head>
	<Meta http-equiv='Pragma' content='no-cache'>
	<Meta http-equiv=expires content='Thu, 01 Jan 1970 00:00:00 GMT'>
	<Meta http-equiv='Cache-Control' content='no-store'>
	<Meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>
	<link type="text/css" rel="stylesheet" href="../shared/css/style.css">
	
	<script language="Javascript" type="text/javascript" src="../shared/js/efeitos.js"></script>
	<script language="Javascript" type="text/javascript" src="../shared/js/funcoesCampos.js"></script>
	<script language="Javascript" type="text/javascript" src="../shared/js/geral.js"></script>
	<script	language='javascript' for='window' event='onLoad'>
		window.name='Relatorios'
	</script>
</head>
<body topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0">
<table cellpadding="0" cellspacing="0" width="98%" height="100%" align="center" border="0">
	<tr>
		<td height="10">&nbsp;</td>
	</tr>
	<tr>
		<td class="Font10Vinho"><b>RELATÓRIOS</b></td>
	</tr>
	<tr>
		<td height="30" valign="bottom"><!--#include file="i_menu_titulo.asp"--></td>
	</tr>
	<tr>
		<td height="100%" class="BordaPretaTabela" valign="top" align="center"><br>
			<!--#include file="i_listar_dados.asp"-->
		</td>
	</tr>
	<tr>
		<td height="10">&nbsp;</td>
	</tr>
</table>
</body>
</html>
<%Response.Flush()%>