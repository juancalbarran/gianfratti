<%
If Session("SOS_admin") = "" And Session("SOS_ipadmin") <> Request.ServerVariables("REMOTE_ADDR") Then
  Response.Redirect "admin_login.asp"
Else
%>

<html>
<head>
<title><%=Application("SOS_titulo")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="copyright" content="SuperAsp">
<meta name="keywords" content="sos, suporte online, suporteonline, superasp, suporte, online">
<meta name="robots" content="ALL">
<style type="text/css">
<!--
.texto{
font-family: Tahoma, Arial;
font-size: 11px;
}
-->
</style>
</head>
<body class="texto" bgcolor="silver" topmargin="5" leftmargin="5" rightmargin="5" bottommargin="5" style="border-bottom: 1px solid gray">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
  <tr> 
    <td nowrap><img src="imagens/SOS_logo.gif" align="absmiddle">
	  <a href="admin_status.asp" target="SOS_principal"><img src="imagens/SOS_status.gif" width="75" height="60" border="0" align="absmiddle"></a>
	  <a href="admin_relatorio_atendimentos.asp" target="SOS_principal"><img src="imagens/SOS_atendimentos.gif" width="75" height="60" border="0" align="absmiddle"></a> 
      <a href="admin_departamento_consultar.asp" target="SOS_principal"><img src="imagens/SOS_departamentos.gif" width="75" height="60" border="0" align="absmiddle"></a> 
      <a href="admin_atendente_consultar.asp" target="SOS_principal"><img src="imagens/SOS_atendentes.gif" width="75" height="60" border="0" align="absmiddle"></a> 
      <a href="admin_comandos_consultar.asp" target="SOS_principal"><img src="imagens/SOS_comandos.gif" width="75" height="60" border="0" align="absmiddle"></a>
      <a href="admin_alterar_configuracoes.asp" target="SOS_principal"><img src="imagens/SOS_configuracoes.gif" width="75" height="60" border="0" align="absmiddle"></a>
	  <a href="admin_sair.asp" target="_top"><img src="imagens/SOS_sair.gif" width="75" height="60" align="absmiddle" border="0"></a></td>
  </tr>
</table>
</body>
</html>

<%
End If
%>