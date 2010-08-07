<!--#include file="funcoes.asp"-->

<%
usuario = Trim(Request.QueryString("usuario"))
atendente = Trim(Request.QueryString("atendente"))
id_conversa = Trim(Request.QueryString("id_conversa"))
email = Trim(Request.QueryString("email"))

'Chama rotina para remover o usuario na lista
remove_usuario usuario, atendente

If id_conversa <> "" Then
  Set Conexao = Server.CreateObject("ADODB.Connection")
  Conexao.Open Application("SOS_conexao")
  ComandoSQL = "UPDATE historico SET saida=Now() WHERE id=" & id_conversa
  Set objRS = Conexao.Execute(ComandoSQL)
  Set objRS = Nothing
  Conexao.Close
  Set Conexao = Nothing
%>

<script language="JavaScript">
<!--
function dar_nota(height,width) {
  var top; var left;
  top = ( (screen.height/2) - (height/2) )
  left = ( (screen.width/2) - (width/2) )
  window.open("dar_nota.asp?usuario=<%=Server.URLEncode(usuario)%>&atendente=<%=atendente%>&id_conversa=<%=id_conversa%>&email=<%=email%>","usuario_sair",'width='+width+',height='+height+',scrollbars=no,toolbar=no,location=no,status=no,menubar=no,resizable=no,left='+left+',top='+top);
}
dar_nota(400,400)
//-->
</script>

<%
End If

'Elimina variaveis da memoria
Set usuario = Nothing
Set atendente = Nothing
Set id_conversa = Nothing
%>
<script language="JavaScript">window.close()</script>