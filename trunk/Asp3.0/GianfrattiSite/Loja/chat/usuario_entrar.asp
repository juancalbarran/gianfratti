<!--#include file="funcoes.asp"-->

<%
Response.Expires=-1000
%>

<html>
<head>
<title><%=Application("SOS_titulo_janela")%></title>
<style type="text/css">
<!--
.texto{
font-family: Tahoma, Arial;
font-size: 11px;
color: #3E6497;
}
.formulario{
font-family: Tahoma, Arial;
font-size: 11px;
width: 200px;
border: 1px solid silver;
background-color: white;
}
-->
</style>
<script language="JavaScript">
<!--
function envia_formulario(form){
if (document[form].usuario.value == ""){
  document[form].usuario.focus();
  alert('Informe seu nome');
}
else if (document[form].email.value == ""){
  document[form].email.focus();
  alert('Informe seu email');
}
else if (document[form].email.value.match(/(\w+)@(.+)\.(\w+)$/) == null){
  document[form].email.focus();
  document[form].email.select();
  alert('Endereço de email inválido');
}
else if (document[form].assunto.value == ""){
  document[form].assunto.focus();
  alert('Informe o assunto');
}
else if (document[form].departamento.value == ""){
  document[form].departamento.focus();
  alert('Informe o departamento');
}
else if (document[form].atendente.value == ""){
  alert('Informe o atendente');
}
else{
  document[form].submit();
}
}
//-->
</script>
</head>
<body class="texto" bgcolor="white" leftmargin="0" topmargin="0" bottommargin="0" rightmargin="0">

<%
If Request.Form("usuario") <> "" And Request.Form("assunto") <> "" And Request.Form("atendente") <> "" Then
  usuario = Trim(Request.Form("usuario"))
  atendente = Trim(Request.Form("atendente"))
  assunto = Trim(Request.Form("assunto"))
  email = Trim(Request.Form("email"))

  'Chama rotina para adicionar o usuario na lista
  adiciona_usuario usuario, atendente, email, assunto

  Response.Cookies("SOS")("usuario") = usuario
  Response.Cookies("SOS")("email") = email
  Response.Cookies("SOS").expires=now+365


%>
<script language="JavaScript">
<!--
window.onunload=exit
function exit(){
  window.open("usuario_sair.asp?usuario=<%=Server.URLEncode(usuario)%>&atendente=<%=atendente%>&id_conversa="+id_conversa.value+"&email="+email.value,"sair",'width=50,height=50,scrollbars=no,toolbar=no,location=no,status=no,menubar=no,resizable=no,left=10000,top=10000');
}
//-->
</script>

<input type="hidden" name="id_conversa" value="">
<input type="hidden" name="email" value="">
<iframe src="usuario_aguarda.asp?usuario=<%=Server.URLEncode(usuario)%>&atendente=<%=atendente%>" frameborder="0" style="width:100%;height:100%"></iframe>

<%
  'Elimina variaveis da memoria
  Set usuario = Nothing
  Set atendente = Nothing
  Set assunto = Nothing
  Set email = Nothing
Else
%>

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="texto" bgcolor="#F7F7F7">
  <tr> 
    <td colspan="2" valign="middle" height="30" bgcolor="#EEEEEE">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="gray"><b><%=Application("SOS_titulo")%></b></font></td>
  </tr>
  <tr> 
    <td width="120" valign="top" align="center"><br><img src="imagens/atendente.gif" width="92" height="128"></td>
    <td valign="top"><br><form name="form_entrar" method="post" action="usuario_entrar.asp" style='margin-top: 0px;'>
        <font color="#CC0000"><b>ATENDIMENTO ONLINE</b></font><br>
        Solicite atendimento a um de nossos atendentes<br>
        <br>
        <table width="200" border="0" cellspacing="0" cellpadding="0" class="texto">
          <tr> 
            <td><img src="imagens/topo.gif" width="250" height="15"></td>
          </tr>
          <tr> 
            <td bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;Seu nome<br> &nbsp;&nbsp; 
              <input name="usuario" type="text" class="formulario" id="usuario2" value="<%=Request.Cookies("SOS")("usuario")%>"> 
              <br>
              &nbsp;&nbsp;&nbsp;Email para contato<br> &nbsp;&nbsp; <input name="email" type="text" class="formulario" id="email" value="<%=Request.Cookies("SOS")("email")%>"> 
              <br> &nbsp;&nbsp;&nbsp;Assunto<br> &nbsp;&nbsp; <input name="assunto" type="text" class="formulario" id="assunto2" value=""> 
              <br> &nbsp;&nbsp;&nbsp;Departamento<br> <input type="hidden" name="atendente" value=""> 
              &nbsp;&nbsp; <select name="departamento" class="formulario" id="select" onChange="window.open('exibe_atendentes.asp?departamento='+this.value,'iframe_atendentes')">
                <option value="">Informe o departamento desejado</option>
                <%
  Dim objCon, objRS, strQ
  Set objCon = Server.CreateObject("ADODB.Connection")
  objCon.Open Application("SOS_conexao")
  Set objRS = Server.CreateObject("ADODB.Recordset")
  objRS.CursorLocation = 2
  objRS.CursorType = 0
  objRS.LockType = 1
  strQ = "SELECT * FROM departamentos ORDER BY departamento ASC"
  objRS.Open strQ, objCon, , , &H0001
  If Not objRS.EOF Then
    While Not objRS.EOF
	  Response.Write "<option value='" & objRS("id") & "'>" & objRS("departamento") & "</option>"
	  objRS.MoveNext
	Wend
  End If
  objRS.Close
  objCon.Close
  Set objCon = Nothing
  Set objRS = Nothing
  Set strQ = Nothing
%>
              </select> <br> <iframe name="iframe_atendentes" src="exibe_atendentes.asp" frameborder="0" style="width:100%;height:45"></iframe> 
              &nbsp;&nbsp;<img src="imagens/botao_enviar.gif" style="cursor: hand" onClick="javascript: envia_formulario('form_entrar')"> </td>
          </tr>
          <tr> 
            <td><img src="imagens/rodape.gif" width="250" height="15"></td>
          </tr>
        </table>
        <font color="#CC0000"><b><br>
        DEIXAR UMA MENSAGEM</b></font><br>
        <a href="enviar_mensagem.asp"><font color="#336699">Clique aqu</font>i</a> 
        para deixar uma mensagem<br>
      </form></td>
  </tr>
  <tr>
    <td colspan="2" height="20" valign="middle" align="center"><div align="center"><font color="#999999" size="1"> 
        © SOS - Suporte Online SuperAsp</font><br>
        <br>
      </div></td>
  </tr>
</table>

<%
End If

If Request("msg") <> "" Then
%>

<script language="javascript">
<!--
var msg_1; var msg_2; var msg_3
msg_1 = "Por favor, informe o seu nome e o assunto desejado"
msg_2 = "Outro usuário de sua rede já esta usando o mesmo nome em nosso suporte, \naguarde liberação ou informe seu nome completo"
msg_3 = "Você terá de entrar novamente no chat, não pressione novamente a tecla F5"
alert(msg_<%=Request("msg")%>)
//-->
</script>

<%
End IF
%>

</body>
</html>