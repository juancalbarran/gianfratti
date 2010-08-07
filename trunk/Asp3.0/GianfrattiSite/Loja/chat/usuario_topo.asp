<%
usuario = Trim(Request.QueryString("usuario"))
atendente = Trim(Request.QueryString("atendente"))
id_conversa = Trim(Request.QueryString("id_conversa"))

If usuario <> "" Then
%>

<html>
<head>
<title><%=Application("titulo")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
function Verificar() 
{
var ctrl=window.event.ctrlKey;
var tecla=window.event.keyCode; 
if (tecla==116) {event.keyCode=0; event.returnValue=false;}
if (tecla==122) {event.keyCode=0; event.returnValue=false;}
}
//-->
</script>
<link rel="STYLESHEET" type="text/css" href="estilos.css">
</head>
<BODY bgcolor="#ffffff" topMargin=0 leftMargin=0 rightMargin=0 bottomMargin=0 class='msg_topo' onKeyDown="Verificar()">
<table borde=0 cellpadding=2 cellspacing=0 class=texto width="100%" height="100%">
  <tr>
    <td width="85"><img src="imagens/SOS_logo.gif" align="absmiddle"></td>

<%
Dim Conexao, ComandoSQL, departamento, atendente, var_id, var_atendente, var_departamento

Set Conexao = Server.CreateObject("ADODB.Connection")
Conexao.Open Application("SOS_conexao")
ComandoSQL = "SELECT Distinct id_departamento, atendente, foto FROM atendentes Where id = " & atendente
Set atendente = Conexao.Execute(ComandoSQL)
var_atendente = atendente("atendente")
var_id = atendente("id_departamento")

If Application("SOS_foto") = 1 Then
  Response.Write "<td width=50><img src='" & atendente("foto") & "' width=40 height=50 style='border: 1px inset'></td>"
End If
Response.Write "<td>"

ComandoSQL = "SELECT Distinct departamento FROM departamentos Where id = " & var_id
Set departamento = Conexao.Execute(ComandoSQL)
var_departamento = departamento("departamento")
Conexao.Close
Set Conexao = Nothing

Response.Write "<b><font color='#3E6497'>" & Application("SOS_titulo") & "</font></b>"
Response.Write "<br>Atendente: <b>" & var_atendente & "</b>"
Response.Write "<br>Departamento: " & var_departamento & ""

Set departamento = Nothing
Set atendente = Nothing
Set ComandoSQL = Nothing
Set atendente = Nothing
Set var_id = Nothing
Set var_departamento = Nothing
Set var_atendente = Nothing
%>

	</td>
  </tr>
</table>
<iframe name="iframe_avaliar" style="width: 1; height: 1;" frameborder="0"></iframe>
</body>
</html>

<%
End If
%>