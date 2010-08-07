<%
usuario = Trim(Request.QueryString("usuario"))
atendente = Trim(Request.QueryString("atendente"))
id_conversa = Trim(Request.QueryString("id_conversa"))

If usuario <> "" Then
%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
function Verificar() {
var ctrl=window.event.ctrlKey;
var tecla=window.event.keyCode; 
if (tecla==116) {event.keyCode=0; event.returnValue=false;}
if (tecla==122) {event.keyCode=0; event.returnValue=false;}
}
function verifica_form(form) {
var passed = true;
  if (form["msg_texto"].value == ""){
  alert("Digite a mensagem para enviar")
  form["msg_texto"].focus();
  passed = false
  }
return passed;
}
//-->
</script>
<link rel="STYLESHEET" type="text/css" href="estilos.css">
</head>
<BODY bgcolor="#ffffff" topMargin=0 leftMargin=0 rightMargin=0 bottomMargin=0 class='msg' onKeyDown="Verificar()">

<%
Dim Conexao, var_conversa, objRS_conversa, ComandoSQL
If Request.Form() <> "" Then
  Set Conexao = Server.CreateObject("ADODB.Connection")
  Conexao.Open Application("SOS_conexao")
  ComandoSQL = " SELECT id, conversa FROM historico Where id = " & id_conversa
  Set objRS_conversa = Server.CreateObject("ADODB.Recordset")
  objRS_conversa.CursorLocation = 3
  objRS_conversa.CursorType = 0
  objRS_conversa.LockType = 3
  objRS_conversa.Open ComandoSQL, Conexao,,, &H0001
  var_conversa = "<b><font color=navy>&#8250; " & Request.QueryString("usuario") & "</b><br>"
  var_conversa = var_conversa & Replace(Request.Form("msg_texto"),chr(13),"<BR>") & "</font><br><br>"
  objRS_conversa("conversa") = objRS_conversa("conversa") & var_conversa
  objRS_conversa.UpdateBatch
  objRS_conversa.Requery
  objRS_conversa.Close
  Conexao.Close

%>
<script>parent.suporte.document.location.href=parent.suporte.document.location.href</script>
<%


End If

Response.Write "<table width='100%' border='0' cellpadding='2' cellspacing=0><tr>"
Response.Write "<form name='form_msg' method='post' action='usuario_msg.asp?id_conversa=" & id_conversa & " &usuario=" & Server.URLEncode(usuario) & " &atendente=" & Trim(atendente) & "' onsubmit='return verifica_form(this);'>"
Response.Write "<td width='100%' height='100%' class='texto'>"
Response.Write "<table width='100%' border='0' cellpadding='2' cellspacing=0 align='center'>"
Response.Write "<tr><td width='100%'class=texto>&nbsp;&nbsp;Mensagem:<br>&nbsp;&nbsp;"
Response.Write "<textarea name='msg_texto' class=form style='width: 99%; height: 45px'></textarea>"
Response.Write "</td><td width='30%'class=texto>&nbsp;&nbsp;"
Response.Write "<input type='submit' name='submit' value='Enviar' class='texto'>"
Response.Write "</td><tr>"
Response.Write "</table>"
Response.Write "</form>"
Response.Write "</table>"

Set ComandoSQL = Nothing
Set objRS_conversa = Nothing
Set var_conversa = Nothing
Set Conexao = Nothing
%>

<iframe src="status_usuario.asp?usuario=<%=usuario%>&atendente=<%=atendente%>" frameborder="0" style="width:1;height:100"></iframe>
<script language="JavaScript">document.form_msg.msg_texto.focus();</script>
</body>
</html>

<%
End If
Set usuario = Nothing
Set atendente = Nothing
Set id_conversa = Nothing
%>