<!--#include file="funcoes.asp"-->
<%
Response.Expires=-1000

usuario = Trim(Request.QueryString("usuario"))
atendente =  Trim(Request.QueryString("atendente"))
id_conversa = Trim(Request.QueryString("id_conversa"))

If id_conversa <> "" Then
%>

<HTML>
<HEAD>
<TITLE><%=Application("SOS_titulo_janela")%></TITLE>
</HEAD>
<frameset marginwidth="0" merginheight="0" framespacing="0" Border="0" frameborder="0" rows="75,*,75" cols="*">
  <frame name="topo" scrolling="no" marginwidth=8 marginheight=0 noresize src="usuario_topo.asp?id_conversa=<%=id_conversa%>&usuario=<%=Server.URLEncode(usuario)%>&atendente=<%=Trim(atendente)%>">
  <frame name="suporte" scrolling="yes" marginwidth=8 marginheight=0 src="exibe_conversa.asp?id_conversa=<%=id_conversa%>&usuario=<%=Server.URLEncode(usuario)%>&atendente=<%=Trim(atendente)%>" noresize>
  <frame name="msg" src="usuario_msg.asp?id_conversa=<%=id_conversa%>&usuario=<%=Server.URLEncode(usuario)%>&atendente=<%=Trim(atendente)%>" name="bottom"  Marginwidth="0" Marginheight="0" Framespacing="0" Border="0" Frameborder="no" scrolling=no>
<frame src="UntitledFrame-3"></frameset>
<noframes>Seu Browser n&atilde;o aceita frames</noframes>
</HTML>

<%
End If
%>