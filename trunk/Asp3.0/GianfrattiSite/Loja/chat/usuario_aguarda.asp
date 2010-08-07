<!--#include file="funcoes.asp"-->

<%
Response.Expires=-1000
usuario = Trim(Request.QueryString("usuario"))
atendente = Trim(Request.QueryString("atendente"))

If usuario <> "" And atendente <> "" Then

  SOS_usuario = Application("SOS_usuario")
  SOS_atendente = Application("SOS_atendente")
  SOS_email = Application("SOS_email")
  SOS_ip = Application("SOS_ip")
  SOS_entrada = Application("SOS_entrada")
  SOS_ativo = Application("SOS_ativo")
  SOS_id = Application("SOS_id")
  n = UBound(SOS_usuario)
  If n > 0 Then
    For i = 1 To n
      If Lcase(SOS_usuario(i)) = Lcase(usuario) And Int(SOS_atendente(i)) = Int(atendente) Then
        If SOS_ativo(i) = True Then
		  id_conversa = SOS_id(i)
		  email = SOS_email(i)
          Response.Write "<script language='JavaScript'>"
		  Response.Write "parent.document.all.id_conversa.value='" & id_conversa & "';"
		  Response.Write "parent.document.all.email.value='" & Server.URLEncode(email) & "';"
          Response.Write "document.location.href='usuario.asp?id_conversa=" & id_conversa & "&usuario=" & Server.URLEncode(usuario) & "&atendente=" & atendente & "';"
		  Response.Write "</script>"
        End If
      End If
    Next
  Else
    Response.Redirect "usuario_ocupado.asp?usuario=" & usuario
  End If
%>

<html>
<head>
<title><%=Application("SOS_titulo")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.texto{
font-family: Tahoma, Arial;
font-size: 11px;
color: gray;
}
a{
color: blue;
}
-->
</style>
</head>
<body class="texto" bgcolor="white" leftmargin="0" topmargin="0" bottommargin="0" rightmargin="0">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="texto" bgcolor="#F9F9F9">
  <tr> 
    <td colspan="2" valign="middle" height="30" bgcolor="#EEEEEE">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="gray"><b><%=Application("SOS_titulo")%></b></font></td>
  </tr>
  <tr>
    <td valign="top">

<blockquote>
<br><font color="#CC0000"><strong>Olá <%=usuario%></strong></font>
<br>
        Contatando atendente, aguarde... <br>
        <img src="imagens/aguarda.gif" width="79" height="27"></blockquote>
    </td>
  </tr>
</table>

<SCRIPT LANGUAGE="JavaScript">
<!--
function atualiza_pagina(){
  document.location.href=document.location.href
}
setTimeout("atualiza_pagina()",7000);
//-->
</SCRIPT>

</body>
</html>

<%
  'Elimina variaveis da memoria
  Set usuario = Nothing
  Set atendente = Nothing
  Set n = Nothing
  Set i = Nothing

End If
%>