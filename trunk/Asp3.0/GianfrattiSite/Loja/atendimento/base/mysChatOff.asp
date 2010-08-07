<%
'MYSUPPORT - ALGUNS DIREITOS RESERVADOS
'http://www.mysupport.com.br
'
'TERMOS DE LICENÇA DESTE SISTEMA
'
'Você pode:
'
'- Copiar, distribuir, exibir e executar a obra;
'- Criar obras derivadas.
'
'Sob as seguintes condições:
'
'- Atribuição. Você deve dar crédito ao autor original.
'- Uso Não-Comercial. Você não pode utilizar esta obra com finalidades comerciais.
'- Compartilhamento pela mesma Licença. Se você alterar, transformar, ou criar outra obra com base nesta, você somente poderá distribuir a obra resultante sob uma licença idêntica a esta.
'
'Para cada novo uso ou distribuição, você deve deixar claro para outros os termos da licença desta obra.
'Qualquer uma destas condições podem ser renunciadas, desde que você obtenha permissão do autor.
'Qualquer direito de uso legítimo (ou "fair use") concedido por lei, ou qualquer outro direito protegido pela legislação local, não são em hipótese alguma afetados pelo disposto acima.
'
'Este é um sumário para leigos da Licença Jurídica (na íntegra).
'
'LICENSE
'
'You are free:
'
'to copy, distribute, display, and perform the work;
'to make derivative works.
'
'Under the following conditions:
'
'- Attribution. You must give the original author credit.
'- Noncommercial. You may not use this work for commercial purposes.
'- Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under a license identical to this one. 
'
'For any reuse or distribution, you must make clear to others the license terms of this work.
'Any of these conditions can be waived if you get permission from the copyright holder.
'Your fair use and other rights are in no way affected by the above.
'
'This is a human-readable summary of the Legal Code (the full license).
%>
<!--#include file="db.asp"-->
<!--#include file="mysConfiguracoes.asp"-->
<%
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	Session.LCID = 1033
	
strStatus = OK(Request.QueryString("status"))
	
If strStatus = "TimeOut" AND Session("mysConversaID") <> "" Then
	Call AbreDB
	strSQL = "UPDATE conversas SET status = False WHERE id = " & Session("mysConversaID")
	Conexao.Execute(strSQL)
	Call FechaDB
End If
	
If Request.ServerVariables("HTTP_METHOD") = "POST" Then
	strNome		= Request.Form("nome")
	strEmail	= Request.Form("email")
	strAssunto	= Request.Form("assunto")
	strMensagem	= Request.Form("mensagem")

	    Set msg = Server.CreateObject("SMTPsvg.Mailer")
	    msg.FromName = NomeEmail
	    msg.FromAddress = strEmail
	    msg.RemoteHost = "localhost"
	    msg.AddRecipient "Contato Chat", strConfigEmail
	    msg.Subject = strAssunto
	    msg.ContentType = "text/html"
		strHTML			= "<html><body>"
	strHTML			= "<br>Nome:&nbsp;" & strNome
	strHTML			= "<br>Email:&nbsp;" & strEmail
	strHTML			= "<br>Assunto:&nbsp;" & strAssunto
	strHTML			= "<br>Mensagem:&nbsp;"
	strHTML			= strMensagem & "</body></html>"		
	    msg.BodyText = strHTML	    
	    msg.SendMail
	 	Set msg = nothing%>
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center"><font style="font-family:tahoma; font-size:11px">Sua mensagem foi enviada com sucesso. Em breve entraremos em contato</font></td>
  </tr>
</table>


<%
response.End
End If
%>
<html>
<head>
<title><%=strConfigNome%></title>
<style>
a:link	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:visited	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:hover	{font-size:8pt; font-family: Tahoma, Verdana; color:F4B511; TEXT-DECORATION: none;}
body	{ font-family: Tahoma, Verdana; font-size: 8pt; color: <%=strConfigFonte%>; }
td		{ font-family: Tahoma, Verdana; font-size: 8pt; color: <%=strConfigFonte%>; }
.campo{				
		font-family: Arial, Verdana; 
		font-size: 11px; 
		background-color: #FFFFFF;	
		border-left: 1 solid #68A4C8; 
		border-right: 1 solid #B8D0D8; 
		border-top: 1 solid #68A4C8; 
		border-bottom: 1 solid #B8D0D8;
		}
				
.botao 	{
			background-color: #E8E8E8; 
			color: black; 
			border-color: #FFFFFF; 
			border-width: 1px; 
			font-family: Tahoma, Verdana; 
			font-size: 8pt;
		}
</style>
</head>
<script language="JavaScript">
function validarForm(){
	if(form.nome.value == '') {
		alert('Você deve preencher o campo nome!');
		form.nome.focus();
		return false;
	}
	if(form.email.value == '') {
		alert('Você deve preencher o campo email!');
		form.email.focus();
		return false;
	}
	if(form.assunto.value == '') {
		alert('Você deve preencher o campo assunto!');
		form.assunto.focus();
		return false;
	}
	if(form.mensagem.value == '') {
		alert('Você deve preencher o campo mensagem!');
		form.mensagem.focus();
		return false;
	}
return true;
}
</script>
<body topmargin="0" leftmargin="0" bottommargin="0">
<table height="100%" width="100%" cellspacing="0">
	<tr bgcolor="<%=strConfigTopo%>">
		<td valign="top" width="50%" height="10%">
			<img src="<%=strConfigLogo%>" alt="" border="0">
		</td>
		<td valign="top">
		</td>
	</tr>
	<tr>
		<td colspan="2" height="75%" valign="top" style="border: 1 solid #DDDDDD" align="center"><br><br>
<font size="2"><b>No momento nosso suporte está indisponível...</b></font><br><br>Deixe uma mensagem, em breve um de nossos atendentes entrará em contato.<br>
Utilize o formulário abaixo para deixar sua mensagem.<br>
			<form name="form" action="mysChatOff.asp" method="post" onSubmit="return validarForm();">
			<table width="35%" align="center">
				<tr>
					<td colspan="2" align="center"></td>
				</tr>
				<tr>
					<td width="50%">Nome:</td>
					<td><input type="text" name="nome" size="30" class="campo" value="<%=Request.Cookies("MySupport")("Nome")%>"></td></tr>
				<tr>
					<td width="50%">Email:</td>
					<td><input type="text" name="email" size="30" class="campo" value="<%=Request.Cookies("MySupport")("Email")%>"></td></tr>
				<tr>
					<td width="50%">Assunto:</td>
					<td><input type="text" name="assunto" size="30" class="campo" value="<%=Request.Cookies("MySupport")("Assunto")%>"></td></tr>
				<tr>
					<td width="50%">Mensagem:</td>
					<td><textarea cols="32" rows="3" name="mensagem" class="campo"></textarea></td></tr>
				<tr>
					<td></td>
					<td>
			<input type="submit" value="    Enviar    " class="botao">
			</td></tr>
			</table>
			</form>
		</td>
	</tr>
	<tr bgcolor="<%=strConfigTopo%>">
		<td valign="middle" colspan="2" align="center">
			<font size="1">
			
			</font>
		</td>
	</tr>
</table>
</body>
</html>
