<%
Response.Expires=-1000
Response.Buffer= False

usuario = Trim(Request.QueryString("usuario"))
atendente = Trim(Request.QueryString("atendente"))
id_conversa = Trim(Request.QueryString("id_conversa"))
email = Trim(Request.QueryString("email"))
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
</head>
<body class="texto" bgcolor="white" leftmargin="0" topmargin="0" bottommargin="0" rightmargin="0">

<%
If Request.Form() <> "" Then

  Set Conexao = Server.CreateObject("ADODB.Connection")
  Conexao.Open Application("SOS_conexao")
  ComandoSQL = "Select * From historico WHERE id=" & id_conversa
  Set objRS_historico = Server.CreateObject("ADODB.Recordset")
  objRS_historico.CursorLocation = 3
  objRS_historico.CursorType = 1
  objRS_historico.LockType = 2
  objRS_historico.Open ComandoSQL, Conexao,,, &H0001
  objRS_historico("nota") = Request.Form("nota")
  objRS_historico("obs_nota") = Request.Form("obs_nota")
  conversa = objRS_historico("conversa")
  assunto = objRS_historico("assunto")
  entrada = objRS_historico("entrada")
  saida = objRS_historico("saida")
  objRS_historico.Update
  objRS_historico.Close

  ComandoSQL = "SELECT atendente FROM atendentes WHERE id=" & atendente
  Set objRS = Conexao.Execute(ComandoSQL)
  atendente = objRS("atendente")
  Set objRS = Nothing
  Set ComandoSQL = Nothing

  Conexao.Close
  Set Conexao = Nothing

  If Trim(Request.Form("receber")) <> "" And Trim(Request.Form("email") <> "") Then
    If Instr(Request.Form("email"),"@") Then
      strMsg = "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>"
      strMsg = strMsg & "<HTML><HEAD>"
      strMsg = strMsg & "<META content='text/html; charset=iso-8859-1' http-equiv=Content-Type>"
      strMsg = strMsg & "<META content='MSHTML 5.00.2614.3500' name=GENERATOR></HEAD>"
      strMsg = strMsg & "<BODY><font face=Arial size=2><FONT color='crimson'><B>" & Application("SOS_titulo") & "</B></font><BR><BR>"
      strMsg = strMsg & "<B>Usuário:</B> "  & usuario
      strMsg = strMsg & "<br><B>Assunto:</B> "  & assunto
      strMsg = strMsg & "<br><B>Entrada:</B> "  & entrada
      strMsg = strMsg & "<br><B>Saida:</B> " & saida
      strMsg = strMsg & "<br><B>Atendente:</B> " & atendente & "<HR size=1 color=gainsboro>"
      strMsg = strMsg & conversa & "<HR size=1 color=gainsboro>"
      strMsg = strMsg & "</FONT></font></BOBY>"
      strMsg = strMsg & "</HTML>"
      EnviaEmail Application("SOS_servidor"), Application("SOS_componente"), email, email, email, Application("SOS_titulo_email"), strMsg
    End If
  End If
  Set conversa = Nothing
  Response.Write "<script language='JavaScript'>window.close()</script>"
Else
%>

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="texto" bgcolor="#F9F9F9">
  <tr> 
    <td colspan="2" valign="middle" height="30" bgcolor="#EEEEEE">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="gray"><b><%=Application("SOS_titulo")%></b></font></td>
  </tr>
  <tr> 
    <td width="120" valign="top" align="center"><br><img src="imagens/atendente.gif" width="92" height="128"></td>
    <td valign="top"><br><form name="form_entrar" method="post" action="dar_nota.asp?usuario=<%=usuario%>&atendente=<%=atendente%>&id_conversa=<%=id_conversa%>&email=<%=email%>">
        <font color="#CC0000"><b>ATENDIMENTO FINALIZADO</b></font><br>
        <br>
        Caro(a) <strong><%=usuario%></strong>,<br>
        Ajude-nos a avaliar nosso atendimento.<br>
        <br>
        <B>Sua nota</B><br>
        <select name="nota" class="formulario">
        <option value=0 selected></option>
        <option value=1>Péssimo atendimento</option>
        <option value=2>Atendimento Regular</option>
        <option value=3>Bom atendimento</option>
        <option value=4>Ótimo atendimento</option>
		</select>
        <br>
        <B>Observa&ccedil;&otilde;es de avalia&ccedil;&atilde;o</B><br>
        <textarea name="obs_nota" class="formulario" style="height:60px"></textarea>
        <br><input type="checkbox" name="receber" value="ok">
        Desejo receber uma c&oacute;pia da conversa<br>
        Email: 
        <input name="email" value="<%=email%>" class="formulario">
        <br><br>
        <input type="image" src="imagens/botao_enviar.gif"> 
      </form></td>
  </tr>
  <tr>
    <td colspan="2" height="20" valign="middle" align="center"><font color="gray">SOS - Suporte Online SuperAsp<br>Copyright© 2003 - Todos os direitos reservados</font><br><br></td>
  </tr>
</table>

<%
End If
%>

</BODY>
</HTML>


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
%>