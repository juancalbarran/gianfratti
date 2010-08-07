<!--#include file="funcoes.asp"-->

<html>
<title>Conversa</title>
<head>

<%
usuario = Trim(Request.QueryString("usuario"))
atendente = Trim(Request.QueryString("atendente"))
id_conversa = Trim(Request.QueryString("id_conversa"))

Application.Lock()

usuario_saiu = True
atendente_saiu = True

SOS_usuario = Application("SOS_usuario")
SOS_atendente = Application("SOS_atendente")
SOS_ativo = Application("SOS_ativo")
n = UBound(SOS_usuario)
For i = 0 To n
  If Trim(SOS_atendente(i)) <> "" Then
    If Lcase(Trim(SOS_usuario(i))) = Lcase(usuario) And Int(SOS_atendente(i)) = Int(atendente) Then
      usuario_saiu = False
     If SOS_ativo(i) = True Then
        atendente_saiu = False
      End If
      Exit For
    End If
  End If
Next

Application.UnLock()

If usuario_saiu = True Or atendente_saiu = True Then
  If usuario_saiu = True Then
%>

<SCRIPT LANGUAGE="JavaScript">
<!--
function scrolling() {
  window.scroll(0,50000)
}
function Verificar() 
{
var ctrl=window.event.ctrlKey;
var tecla=window.event.keyCode; 
if (tecla==116) {event.keyCode=0; event.returnValue=false;}
if (tecla==122) {event.keyCode=0; event.returnValue=false;}
}
function alerta(){
if (confirm("O usuário saiu do atendimento. \nDeseja fechar esta janela?")) {
top.window.close();
}
}
setTimeout("alerta()",500);
//-->
</SCRIPT>

<%
  Else
%>

<SCRIPT LANGUAGE="JavaScript">
<!--
function scrolling() {
  window.scroll(0,50000)
}
function Verificar() 
{
var ctrl=window.event.ctrlKey;
var tecla=window.event.keyCode; 
if (tecla==116) {event.keyCode=0; event.returnValue=false;}
if (tecla==122) {event.keyCode=0; event.returnValue=false;}
}
function alerta(){
if (confirm("Não foi possível estabelecer contato com o atendente. \nDesta forma, o seu atendimento foi finalizado. \n\nDeseja fechar esta janela?")) {
top.window.close();
}
}
setTimeout("alerta()",500);
//-->
</SCRIPT>

<%
  End If
Else
%>

<SCRIPT LANGUAGE="JavaScript">
<!--
function atualiza(){
  document.location.href=document.location.href
}
setTimeout("atualiza()",5000);
function scrolling() {
  window.scroll(0,50000)
}
function Verificar() 
{
var ctrl=window.event.ctrlKey;
var tecla=window.event.keyCode; 
if (tecla==116) {event.keyCode=0; event.returnValue=false;}
if (tecla==122) {event.keyCode=0; event.returnValue=false;}
}
//-->
</SCRIPT>

<%
End If

Set usuario_saiu = Nothing
Set atendente_saiu = Nothing
Set n = Nothing
Set i = Nothing
%>

<link rel="STYLESHEET" type="text/css" href="estilos.css">
</head>
<body bgcolor="#ffffff" topMargin=10 leftMargin=10 rightMargin=0 bottomMargin=0 class="texto" onload="scrolling()" onKeyDown="Verificar()">

<%
Dim objRS_conversa, Conexao, ComandoSQL

Set Conexao = Server.CreateObject("ADODB.Connection")
Conexao.Open Application("SOS_conexao")
ComandoSQL = " SELECT conversa FROM historico Where id = " & id_conversa
Set objRS_conversa = Server.CreateObject("ADODB.Recordset")
objRS_conversa.CursorLocation = 2
objRS_conversa.CursorType = 0
objRS_conversa.LockType = 1
objRS_conversa.Open ComandoSQL, Conexao,,, &H0001
Response.Write objRS_conversa("conversa")

If InStr(objRS_conversa("conversa"),">window.open(") Then
  If usuario <> "" Then
    Dim objRS_atualiza, var_conversa
    ComandoSQL = " SELECT conversa FROM historico Where id = " & id_conversa
    Set objRS_atualiza = Server.CreateObject("ADODB.Recordset")
    objRS_atualiza.CursorLocation = 2
    objRS_atualiza.CursorType = 0
    objRS_atualiza.LockType = 3
    objRS_atualiza.Open ComandoSQL, Conexao,,, &H0001
    var_conversa = objRS_atualiza("conversa")
    var_conversa = Replace(var_conversa,">window.open(",">//window.open(")
    objRS_atualiza("conversa") = var_conversa
    objRS_atualiza.UpdateBatch
    objRS_atualiza.Requery
    objRS_atualiza.Close
    Set objRS_atualiza = Nothing
    Set var_conversa = Nothing
  End If
End If

objRS_conversa.Close
Conexao.Close

Set objRS_conversa = Nothing
Set Conexao = Nothing
Set ComandoSQL = Nothing
Set objRS_conversa = Nothing
%>

</body>
</html>