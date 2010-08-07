<!--#include file="funcoes.asp"-->
<%
'******************************************************************
'  Suporte Online SuperAsp 1.0 - SuperASP.com.br - Ano 2003
'  Autor: Fabiano Dias - fdmail@ibest.com.br
'******************************************************************
'
'       DIREITOS AUTORIAIS DO SUPORTE ONLINE SUPERASP
'
'  Você não pode revender este script, alugar, disponibilizar  para
'  download ou fazer qualquer outro tipo  de  redistribuição  sem a
'  nossa autorização.
'
'  Este código de programação usa uma técnica de criptografia,  que
'  identifica sua autoria, ou seja, alterar este código ou revender
'  o mesmo sem contatar o autor significa estar infrigindo todas as
'  leis de direitos autorais e intelectuais,  e como tal passivo de
'  todas as aplicações na forma da lei.
'
'******************************************************************
Response.Expires=-1000
%>

<html>
<head>
<title><%=Application("SOS_titulo_janela")%></title>
<meta name="copyright" content="SuperAsp">
<meta name="keywords" content="sos, suporte online, suporteonline, superasp, suporte, online">
<meta name="robots" content="ALL">
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
a{
color:blue;
}
-->
</style>
<script language="JavaScript">
<!--
function envia_formulario(form){
if (document[form].SOS_usuario.value == ""){
  document[form].SOS_usuario.focus();
  alert('Informe seu nome');
}
else if (document[form].SOS_email.value == ""){
  document[form].SOS_email.focus();
  alert('Informe seu email');
}
else if (document[form].SOS_email.value.match(/(\w+)@(.+)\.(\w+)$/) == null){
  document[form].SOS_email.focus();
  document[form].SOS_email.select();
  alert('Endereço de email inválido');
}
else if (document[form].SOS_assunto.value == ""){
  document[form].SOS_assunto.focus();
  alert('Informe o assunto');
}
else if (document[form].SOS_departamento.value == ""){
  document[form].SOS_departamento.focus();
  alert('Informe o departamento');
}
else if (document[form].SOS_mensagem.value == ""){
  document[form].SOS_mensagem.focus();
  alert('Deixe sua mensagem');
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
If Request.Form("SOS_usuario") <> "" And Request.Form("SOS_email") <> "" And  Request.Form() <> "SOS_assunto" <> "" And Request.Form() <> "SOS_mensagem" Then

  Response.Cookies("SOS")("usuario") = Request.Form("SOS_usuario")
  Response.Cookies("SOS")("email") = Request.Form("SOS_email")
  Response.Cookies("SOS").expires=now+365

  strMsg = "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>"
  strMsg = strMsg & "<HTML><HEAD>"
  strMsg = strMsg & "<META content='text/html; charset=iso-8859-1' http-equiv=Content-Type>"
  strMsg = strMsg & "<META content='MSHTML 5.00.2614.3500' name=GENERATOR></HEAD>"
  strMsg = strMsg & "<BODY><FONT color='crimson'><B>" & Application("SOS_titulo") & "</B></font><BR><BR>"
  strMsg = strMsg & "<B>Usuário</B><BR><BR>"  & Trim(Request.Form("SOS_usuario")) & "<HR size=1 color=gainsboro>"
  strMsg = strMsg & "<B>Email</B><BR><BR>"  & Trim(Request.Form("SOS_email")) & "<HR size=1 color=gainsboro>"
  strMsg = strMsg & "<B>Assunto</B><BR><BR>"  & Trim(Request.Form("SOS_assunto")) & "<HR size=1 color=gainsboro>"
  strMsg = strMsg & "<B>Departamento</B><BR><BR>"  & Trim(Request.Form("SOS_departamento")) & "<HR size=1 color=gainsboro>"
  strMsg = strMsg & "<B>Mensagem</B><BR><BR>"  & Trim(Request.Form("SOS_mensagem")) & "<HR size=1 color=gainsboro>"
  strMsg = strMsg & "</FONT></BOBY>"
  strMsg = strMsg & "</HTML>"
  EnviaEmail Application("SOS_servidor"), Application("SOS_componente"), Application("SOS_email_atendimento"), Application("SOS_email_atendimento"), Application("SOS_email_atendimento"), Application("SOS_titulo_email") & " - " & Trim(Request.Form("SOS_departamento")), strMsg
%>

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="texto" bgcolor="#F7F7F7">
  <tr> 
    <td colspan="2" valign="middle" height="30" bgcolor="#EEEEEE">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="gray"><b><%=Application("SOS_titulo")%></b></font></td>
  </tr>
  <tr> 
    <td width="120" valign="top" align="center"><br><img src="imagens/atendente.gif" width="92" height="128"></td>
    <td valign="top"><br><br>
        <font color="#CC0000"><b>MENSAGEM ENVIADA</b></font><br>
        <br>Sua mensagem foi enviada para o nosso suporte<br><br>
		<a href="javascript: window.close()">Clique aqui para fechar esta janela</a>
	</td>
  </tr>
  <tr>
    <td colspan="2" height="20" valign="middle" align="center"><font color="gray">SOS - Suporte Online SuperAsp<br>Copyright© 2003 - Todos os direitos reservados</font><br><br></td>
  </tr>
</table>

<%

Function EnviaEmail(Host,Componente,Email,NomeEmail,ParaEmail,Assunto,Mensagem)
Select Case Componente
Case "AspMail"

on error resume next
Set eObjMail = Server.CreateObject("SMTPsvg.Mailer")
eObjMail.FromName = NomeEmail
eObjMail.FromAddress = Email
eObjMail.RemoteHost = Host
eObjMail.AddRecipient "", ParaEmail
eObjMail.Subject = Assunto
eObjMail.ContentType = "text/html"
eObjMail.BodyText = Mensagem	    
eObjMail.SendMail
Set eObjMail = nothing

Case "AspEmail"

on error resume next
Set eObjMail = Server.CreateObject("Persits.MailSender")
eObjMail.Host = Host
eObjMail.From = Email
eObjMail.FromName = NomeEmail
eObjMail.AddReplyTo Email
eObjMail.AddAddress ParaEmail
eObjMail.Subject = Assunto
eObjMail.isHTML = true
eObjMail.Body = Mensagem	 	
eObjMail.Send
Set eObjMail = nothing

Case "AspQmail"

on error resume next
Set eObjMail = Server.CreateObject("SMTPsvg.Mailer")
eObjMail.QMessage = 1
eObjMail.FromName = NomeEmail
eObjMail.FromAddress = Email
eObjMail.RemoteHost = Host
eObjMail.AddRecipient "", ParaEmail
eObjMail.Subject = Assunto
eObjMail.BodyText = Mensagem
objNewMail.SendMail
Set eObjMail = nothing
		
Case "CDONTS"

on error resume next
Set eObjMail = Server.CreateObject("CDONTS.NewMail")
eObjMail.to = ParaEmail
eObjMail.from = NomeEmail & "<" & Email & ">"
eObjMail.subject = Assunto
eObjMail.Importance = 1
eObjMail.BodyFormat = 0
eObjMail.MailFormat = 0
eObjMail.body = Mensagem		
eObjMail.send
Set eObjMail = nothing
		
End Select
End Function


Else
%>
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="texto" bgcolor="#F7F7F7">
  <tr> 
    <td colspan="2" valign="middle" height="30" bgcolor="#EEEEEE">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="gray"><b><%=Application("SOS_titulo")%></b></font></td>
  </tr>
  <tr> 
    <td width="120" valign="top" align="center"><br><img src="imagens/atendente.gif" width="92" height="128"></td>
    <td valign="top"><br><form name="form_entrar" method="post" action="enviar_mensagem.asp" style='margin-top: 0px;'>
        <font color="#CC0000"><b>EVIAR MENSAGEM PARA O SUPORTE</b></font><br>
        <table width="200" border="0" cellspacing="0" cellpadding="0" class="texto">
          <tr>
            <td><img src="imagens/topo.gif" width="250" height="15"></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;Seu nome<br> &nbsp;&nbsp; 
              <input type="text" name="SOS_usuario" class="formulario" value="<%=Request.Cookies("SOS")("usuario")%>"> 
              <br> &nbsp;&nbsp;&nbsp;Email para contato<br> &nbsp;&nbsp; <input type="text" name="SOS_email" class="formulario" value="<%=Request.Cookies("SOS")("email")%>">
              <br> &nbsp;&nbsp;&nbsp;Assunto<br> &nbsp;&nbsp; <input type="text" name="SOS_assunto" value="" class="formulario"> 
              <br>
              &nbsp;&nbsp;&nbsp;Departamento<br>
              &nbsp;&nbsp; 
              <select name="SOS_departamento" class="formulario" id="SOS_departamento">
			  <option value=""></option>
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
	  Response.Write "<option value='" & objRS("departamento") & "'>" & objRS("departamento") & "</option>"
	  objRS.MoveNext
	Wend
  End If
  objRS.Close
  objCon.Close
  Set objCon = Nothing
  Set objRS = Nothing
  Set strQ = Nothing
%>
              </select> <br>
              &nbsp;&nbsp;&nbsp;Mensagem<br> &nbsp;&nbsp; <textarea name="SOS_mensagem" class="formulario" id="SOS_mansagem" style="height: 70"></textarea> 
              <br>
              <br>
              &nbsp;&nbsp; &nbsp;&nbsp;<img src="imagens/botao_enviar.gif" style="cursor: hand" onClick="javascript: envia_formulario('form_entrar')"> 
            </td>
          </tr>
          <tr>
            <td><img src="imagens/rodape.gif" width="250" height="15"></td>
          </tr>
        </table>
        </form></td>
  </tr>
  <tr>
    <td colspan="2" height="20" valign="middle" align="center"><font color="gray">SOS - Suporte Online SuperAsp<br>Copyright© 2003 - Todos os direitos reservados</font><br><br></td>
  </tr>
</table>

<%
End If
%>

</body>
</html>