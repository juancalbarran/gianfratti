<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%hdnPost = Request.Form("hdnPost")%>
<html>
	<head>
		<title>Recognition Companhia Brasileira de Automa&ccedil;&atilde;o Banc&aacute;ria</title>
		<Meta http-equiv='Pragma' content='no-cache'>
		<Meta http-equiv=expires content='Thu, 01 Jan 1970 00:00:00 GMT'>
		<Meta http-equiv='Cache-Control' content='no-store'>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<!--meta http-equiv="refresh" content="0;URL=default.htm"-->
	</head>
	<script	language='javascript' for='window' event='onLoad'>
		window.name='index'
		viewinit()
	</script>
	<script src='Shared/js/funcoesCampos.js'></script>
	<script src='Shared/js/geral.js'></script>
	<script	defer>
		function viewinit() {
			if (!factory.object){
				document.getElementById('trScriptX').style.display='block'
				return (false)
			}
		}
	</script>
	<link type="text/css" rel="stylesheet" href="Shared/css/estilo.css">
<body topmargin="10" bottommargin="10" leftmargin="10" rightmargin="10">
<object id="factory" style="display:none" viewastext classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" <%If hdnPost = "ScriptX" Then%>codebase="http://www.meadroid.com/scriptx/ScriptX.cab#Version=6,2,433,14"<%End If%>></object>
<form method="post" name="frm" action="index.asp">
<input type="hidden" name="hdnPost" value="">
<table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%">
	<tr id="trScriptX" style="display:none; text-align:center">
		<td class="FonteVinho10Normal">Para você ter acesso ao sistema é necessário instalar o componente activeX ScriptX: <a name="" onClick="document.frm.hdnPost.value='ScriptX'; document.frm.submit(); " style="text-decoration:underline; cursor:pointer">Clique aqui</a> para instalar</td>
	</tr>
</table>
</form>
</body>
</html>
<%
	Dim md5

	Set md5 = Server.CreateObject("MD5DLL.Crypt")
	Response.Write "'Hello World' encrypted:<BR>"
	Response.Write md5.Encrypt(Cstr("Hello World"))
%>