<%
If Session("SOS_admin") = "" And Session("SOS_ipadmin") <> Request.ServerVariables("REMOTE_ADDR") Then
  Response.Write "<script language='javascript'>window.open('admin_login.asp','_top')</script>"
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
<body class="texto" bgcolor="#ffffff" topmargin="5" leftmargin="5" rightmargin="5" bottommargin="5">
&nbsp;<font color='gray'><b>CHAMADA PARA O SUPORTE</b></font>
<table class=texto cellpadding=5 cessspacing=0 width='100%'>
  <tr>
    <td bgcolor='whitesmoke' style='border-top:2px solid gainsboro'>
<br>Copie o código abaixo e cole nas páginas do seu site onde deseja fazer a chamada para o suporte<br><br>

<textarea name="codigo" style="width:100%;height:75;background-color:white; border: 1px solid silver" readonly class="texto">
<iframe name="SOS_status" src="<%=endereco_virtual%>/status.asp" style="width:104;height:81" scrolling="no" frameborder="0"></iframe>
</textarea>
    </td>
  </tr>
</table>
<center>
<br><br>Status exibido pelo código acima<br>
<iframe name="SOS_status" src="<%=endereco_virtual%>/status.asp" style="width:145;height:81" scrolling="no" frameborder="0"></iframe>
</center>
<br><br>

</body>
</html>

<%
End If
%>