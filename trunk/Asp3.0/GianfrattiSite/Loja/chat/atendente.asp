<%
Response.Expires=-1000

usuario = Trim(Request.QueryString("usuario"))
atendente = Trim(Request.QueryString("atendente"))
id_conversa = Trim(Request.QueryString("id_conversa"))

If usuario <> "" And atendente <> "" And id_conversa <> "" Then
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
  window.open("atendente_sair.asp?usuario=<%=Server.URLEncode(usuario)%>&atendente=<%=atendente%>","sair",'width=50,height=50,scrollbars=no,toolbar=no,location=no,status=no,menubar=no,resizable=no,left=10000,top=10000');
}
//-->
</script>
<frameset marginwidth="0" merginheight="0" framespacing="0" Border="0" frameborder="0" rows="80,*,100" cols="*">
  <frame name="topo" scrolling="no" marginwidth=8 marginheight=0 noresize src="atendente_topo.asp?id_conversa=<%=id_conversa%>&usuario=<%=Server.URLEncode(usuario)%>&atendente=<%=Trim(atendente)%>">
  <frame name="suporte" scrolling="yes" marginwidth=8 marginheight=0 src="exibe_conversa.asp?id_conversa=<%=id_conversa%>&usuario=<%=Server.URLEncode(usuario)%>&atendente=<%=Trim(atendente)%>" noresize>
  <frame name="msg" src="atendente_msg.asp?id_conversa=<%=id_conversa%>&usuario=<%=Server.URLEncode(usuario)%>&atendente=<%=Trim(atendente)%>" name="bottom"  Marginwidth="0" Marginheight="0" Framespacing="0" Border="0" Frameborder="no" scrolling=no>
<frame src="UntitledFrame-5"></frameset>
<noframes>Seu Browser n&atilde;o aceita frames</noframes>
</html>

<%
Else
  Response.Write "<strong>Erro:</strong> O usuario saiu"
End If

'Elimina variaveis da memoria
Set usuario = Nothing
Set atendente = Nothing
Set i = Nothing
Set n = Nothing
%>