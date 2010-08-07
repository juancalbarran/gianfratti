<%
If Request.QueryString("usuario") <> "" Then
  usuario = Trim(Request.QueryString("usuario"))
  Response.Expires=-1000
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
text-decoration : none;
}
a:hover{
text-decoration : underline;
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
<br><font color="#CC0000"><strong>Caro <%=usuario%></strong></font>
<br>O atendente está ocupado no momento
<br><br>&#8250;&nbsp;<a href="usuario_entrar.asp" target="_top">Solicitar novo atendimento</a>
<br>&#8250;&nbsp;<a href="enviar_mensagem.asp" target="_top">Enviar mensagem</a>
<br>&#8250;&nbsp;<a href="javascript: parent.window.close();">Sair</a>
</blockquote>


    </td>
  </tr>
</table>

</body>
</html>

<%
  'Elimina variaveis da memoria
  Set usuario =Nothing  
End If
%>