<!-- #include virtual="/MailMarketing/Shared/inc/Conn.asp" -->
<%
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then

	'[RECUPERA LOGIN E SENHA DO FORM]
	LOGIN	= Replace(Request("Usuario_Login"), "'", "''")
	SENHA	= Replace(Request("Usuario_Senha"), "'", "''")
	
	If Login <> "" And Senha <> "" Then
		
		sSQL = "SELECT TOP 1 Usuario_CD, Usuario_NM FROM Usuarios WHERE UCASE$(Usuario_Login) ='" & UCASE(LOGIN) & "' AND UCASE$(Usuario_Senha) = '" & UCASE(SENHA) & "'"
		
		Set oRs = RetornaSQL(sSQL)
		
		If Not oRs.Eof Then
			Session("iUser")		= oRs.Fields("Usuario_CD")
			Session("Usuario_NM")	= oRs.Fields("Usuario_NM")
			response.redirect "/mailMarketing/principal/principal.htm"
		Else
			Erro="2"
		End If
		
		Set oRs = Nothing
		
	Else
		Erro="1"
	End If
Else
	Erro = Request("Erro")
End IF

Select case Erro
	Case 1
		mensagem = "Preencha corretamente os campos<br>login e ou Senha!"
	Case 2
		mensagem = "Login ou Senha inválidos!"
	Case 3
		mensagem = "Sua sessão expirou!<br>Informe novamente seu Login e Senha!"
	Case 4
		Session.Abandon()
End Select
%>

<html>
<head>
	<title>Mil Marketing</title>
	<Meta http-equiv='Pragma' content='no-cache'>
	<Meta http-equiv=expires content='Thu, 01 Jan 1970 00:00:00 GMT'>
	<Meta http-equiv='Cache-Control' content='no-store'>
	<Meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>

	<link type="text/css" rel="stylesheet" href="/mailMarketing/shared/css/style.css">
	<script language="Javascript" src="/mailMarketing/shared/js/geral.js" type="text/javascript"></script>
</head>
<body topmargin="0" leftmargin="0" onload="document.FrmLogin.Usuario_Login.focus();">
<table cellpadding="0" cellspacing="0" width="100%" height="100%" border="0" bgcolor="#EEEEEE">
	<tr>
		<td align="center">
			<form method="post" name="FrmLogin" action="p_login.asp" onsubmit="return ValidarLogin(this);">
			<table cellpadding="0" cellspacing="0" width="330" height="180" border="0" style="Border:1px solid #000000" bgcolor="#FFFFFF">
				<tr>
					<td valign="middle">
						<table align="center" cellpadding="0" cellspacing="0" width="90%" border="0">
							<tr>
								<td width="20%" align="center"><img src="/mailMarketing/shared/img/login.gif" align="absmiddle"></td>
								<td width="80%">
									<span class="Font10Preto">Área de acesso exclusivo aos usuários autorizados.</span><br>
									<span class="Font10Preto">Por favor, informe o usuário e a senha de acesso:</span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align="center" class="Font10Vermelho"><% =mensagem %></td>
				</tr>
				<tr>
					<td align="center">
						<table width="100%" cellpadding="2" cellspacing="2" border="0">
							<tr>
								<td align="right" class="Font10Preto">USUÁRIO:&nbsp;</td>
								<td><input type="text" name="Usuario_Login" size="30" maxlength="15" class="input" onfocus="this.style.backgroundColor='#E8E8E8'" onblur="this.style.backgroundColor='#FFFFFF'"></td>
							</tr>
							<tr>
								<td align="right" class="Font10Preto">SENHA:&nbsp;</td>
								<td><input type="password" name="Usuario_Senha" size="30" maxlength="15" class="input" onfocus="this.style.backgroundColor='#E8E8E8'" onblur="this.style.backgroundColor='#FFFFFF'"></td>
							</tr>
							<tr>
								<td colspan="2" align="center"><input type="submit" value="Acessar" class="buttom"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			</form>
		</td>
	</tr>
</table>
</body>
</html>
