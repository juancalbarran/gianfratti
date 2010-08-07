<%
'******************************************************************
'  Suporte Online SuperAsp 1.0 - SuperASP.com.br - Ano 2003
'  Autor: Fabiano Dias - fdmail@ibest.com.br
'******************************************************************
'
'       DIREITOS AUTORIAIS DO SUPORTE ONLINE SUPERASP
'
'  Você não pode revender este script, alugar, disponibilizar  para
'  download ou fazer qualquer outro tipo  de  redistribuição  sem a
'  nossa autorização.
'
'  Este código de programação usa uma técnica de criptografia,  que
'  identifica sua autoria, ou seja, alterar este código ou revender
'  o mesmo sem contatar o autor significa estar infrigindo todas as
'  leis de direitos autorais e intelectuais,  e como tal passivo de
'  todas as aplicações na forma da lei.
'
'******************************************************************
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
</head>
<script language="JavaScript">
<!--
window.onunload=exit
function exit(){
//  window.open("atendente_sair.asp?SOS_id=<%=Request("SOS_id")%>","topo_");
}
//-->
</script>
<frameset marginwidth="0" merginheight="0" framespacing="0" Border="0" frameborder="0" rows="72,*" cols="*">
  <frame name="SOS_menu" scrolling="no" marginwidth=8 marginheight=0 noresize src="admin_menu.asp">
  <frame name="SOS_principal" scrolling="yes" marginwidth=8 marginheight=0 src="admin_status.asp" noresize>
</frameset>
<noframes>Seu Browser n&atilde;o aceita frames</noframes>
</html>

<%
End If
%>