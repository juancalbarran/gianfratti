 <%
'-----------------------------------------------------------------------------------
'#### ACESSO AO ADMINISTRADOR
'-----------------------------------------------------------------------------------
'Sub AcessoASP()
strTextoHtml = "<HTML>"
strTextoHtml = strTextoHtml & "<HEAD><TITLE>" & tituloloja & "</TITLE>"
strTextoHtml = strTextoHtml & "<style type=""text/css""><!--"
strTextoHtml = strTextoHtml & "a:link       { color: #000000; text-decoration:none }"
strTextoHtml = strTextoHtml & "a:visited    { color: #000000; text-decoration:none }"
strTextoHtml = strTextoHtml & "a:hover      { color: #365efc; text-decoration:underline }"
strTextoHtml = strTextoHtml & "#divDrag0{position:absolute; left:0; top:0; height:120; width:40; clip:rect(0,120,120,0); cursor:hand;}"
strTextoHtml = strTextoHtml & "-->"
strTextoHtml = strTextoHtml & "</style>"
strTextoHtml = strTextoHtml & "</HEAD>"
strTextoHtml = strTextoHtml & "<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>"

	strAcao = Request.Form("acao")
	Select Case strAcao
	Case "valida"
	'-----------------------------------------------------------------------------------
	'####### Realiza busca no banco de dados do usuário e senha digitados
	'####### Programador Responsável : Rogério Silva
	'####### Email: webmaster_wb@brfree.com.br
	'####### Site: http://worldbily.cjb.net
	'-----------------------------------------------------------------------------------
	'####### O LOGIN DEVE ESTAR NO BANCO DE DADOS - CRIPTOGRAFADO
	'-----------------------------------------------------------------------------------

	email = Trim(Request.Form("esqs"))

	if email <> "digite seu email" then


	textosql = "SELECT SENHA FROM ACESSO WHERE EMAIL='"&Cripto(email,true)&"'"	
	Set RS = conexao.Execute(textosql)
	IF NOT RS.EOF THEN

	Mensagem = "<FONT face=tahoma style=font-size:12px;font-family:tahoma color=red><b>ATENÇÃO:</b></font><FONT face=tahoma style=font-size:11px;font-family:tahoma> Foi solicitado o envio de senha por você ou alguém que tem conhecimento de seu email.<P><B>NUNCA FORNEÇA SUA SENHA OU DEIXE ALGUÉM VENDO DIGITAR A MESMA</B><hr size=1> <br>Solicitação de senha através da loja "& application("nomeloja") &"<Br>Sua senha é <b>"&DecodeBase64(RS("SENHA"))&"</b><br><br><B>Área administrativa da loja:</B> <A href='http://"&urlloja&"/admin'>http://"&urlloja&"/admin</A></font>"

	'-----------------------------------------------------------------------------------
	'####### Realiza busca no banco de dados o email e envia a senha para o administrador
	'####### Programador Responsável : Rogério Silva
	'####### Email: webmaster_wb@brfree.com.br
	'####### Site: http://worldbily.cjb.net
	'-----------------------------------------------------------------------------------
	'####### O EMAIL DEVE ESTAR NO BANCO DE DADOS - CRIPTOGRAFADO
	'-----------------------------------------------------------------------------------
	'####### ADVERTENCIA: NÃO RETIRE O LINK DO SITE!!! CASO CONTRÁRIO NÃO TERÁS AJUDA
	'-----------------------------------------------------------------------------------

	Host=application("HostLoja")
	Componente = application("ComponenteLoja")
	NomeEmail=DecodeBase64(Rs("LOGIN"))
	ParaEmail=email
	Assunto="Lembrete de senha :: "&NOW
	
	Call EnviaEmail(Host,Componente,Email_da_sua_loja,NomeEmail,ParaEmail,Assunto,Mensagem)

	response.redirect "?login=mail"
	else
	response.redirect "?login=email"
	end if
	else

	login = Trim(Request.Form("usr"))
	senha = Trim(Request.Form("sen"))
	textosql = "SELECT * FROM ACESSO WHERE LOGIN='"&Cripto(login,true)&"' AND SENHA= '"&Cripto(senha,true)&"'"	
	Set RS = conexao.Execute(textosql)
		IF NOT RS.EOF THEN
			'If Request.Form("usr") = LCase(Application("nomeadmin")) And Request.Form("sen") = Application("senhaadmin") Then
			Session("IdAdm") = Rs("IDACESSO")
			Session("NOME") = login
			Session("SENHA") = senha
			Session("Acesso") = (Rs("QTDACESSO")+1)
			Session("UltAcesso") = Rs("ULTACESSO")
			'---------------------------------------------------------------------------
			'#### ATUALIZA A ULTIMA VISITA E A QUANTIDADE DE VISITAS
			'---------------------------------------------------------------------------
			SQL = "UPDATE ACESSO SET QTDACESSO="& Session("Acesso") &", ULTACESSO='"& NOW() &"' WHERE IDACESSO="&RS("IDACESSO")
			Set RSU = conexao.Execute(SQL)
			'---------------------------------------------------------------------------
			textosql = "INSERT INTO admin (data, hora, ip, host) VALUES ('" & Day(Now) & "/" & Month(Now) & "/" & Year(Now) & "', '" & Time & "', '" & Request.ServerVariables("remote_addr") & "', '" & Request.ServerVariables("remote_host") & "');"
			Set gravaentra = conexao.Execute(textosql)	
			Session("admin") = "logado"
			Response.Redirect "?" & Request.Form("url")
			'-----------------------------------------------------------------------------------
			'####### NÃO UTILIZAREMOS MAIS AS LINHAS ABAIXO
			'-----------------------------------------------------------------------------------
			'ElseIf Request.Form("usr") = "789GHDWW45543f" And Request.Form("sen") = "SFGDTE45782FGD" Then
			'textosql = "INSERT INTO admin (data, hora, ip, host) VALUES ('" & Day(Now) & "/" & Month(Now) & "/" & Year(Now) & "', '" & Time & "', '" & Request.ServerVariables("remote_addr") & "', '" & Request.ServerVariables("remote_host") & "');"
			'Set gravaentra = conexao.Execute(textosql)
			'Session("admin") = "logado"
			'Response.Redirect "?" & Request.Form("url")
			'-----------------------------------------------------------------------------------
		Else
		Response.Redirect "?login=erro"
		End If
	end if
	Case Else

	strTextoHtml = strTextoHtml & "<table cellspacing=""0"" cellpadding=""0"" width=779 height=""100%"" align=center valign=center bgcolor=#ffffff style=""border-right: 1px solid #cccccc;border-left: 1px solid #cccccc;"">"
	strTextoHtml = strTextoHtml & "<tr><td valign=top><FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/acs.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Login na administração da loja</B></FONT><hr size=1 color=#cccccc width=""99%"" align=left><br>"
	strTextoHtml = strTextoHtml & "<table cellspacing=""0"" cellpadding=""2""><tr><td bgcolor=#eeeeee>"

		If Len(Day(Date)) = 1 Then
		dia = "0" & Day(Date)
		Else
		dia = Day(Date)
		End If
			If Len(Month(Date)) = 1 Then
			mez = "0" & Month(Date)
			Else
			mez = Month(Date)
			End If

	strTextoHtml = strTextoHtml & "<center><FONT face=tahoma style=font-size:11px><img src=adm_imagens/ssl.gif width=13 height=15 hspace=0 vspace=0 border=0 align=absbottom>&nbsp; Seu IP é <b>" & Request.ServerVariables("remote_addr") & "</b> e seu HOST é <b>" & Request.ServerVariables("remote_host") & "</b>, são <b>" & Time & "</b> em <b>" & dia & "/" & mez & "/" & Year(Date) & "</b> , por medidas de segurança estas informações serão gravadas em nossa base de dados.</center></td></tr></table><script language=javascript src='layer.js'></script>"
	strTextoHtml = strTextoHtml & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td valign=top>"

		If Request("login") = "erro" Then
		strTextoHtml = strTextoHtml & "<center><font style=font-size:11px;font-family:tahoma;color:red><b>Autorização para login no administrador negada!</b></font></center><br><br>"
		elseIf Request("login") = "mail" Then
		strTextoHtml = strTextoHtml & "<center><font style=font-size:11px;font-family:tahoma;color:blue><b>Email enviado com sucesso!</b></font></center><br><br>"
		elseIf Request("login") = "email" Then
		strTextoHtml = strTextoHtml & "<center><font style=font-size:11px;font-family:tahoma;color:red><b>Email inválido!</b></font></center><br><br>"
		End If

	strTextoHtml = strTextoHtml & "<div id='masterdiv'><table cellspacing=2 cellpadding=2 align=center style=""border-bottom: 1px solid #cccccc;border-left: 1px solid #cccccc;border-top: 1px solid #cccccc;border-right: 1px solid #cccccc""'>"
	strTextoHtml = strTextoHtml & "<tr><form action=administrador.asp method=post name=x><input name=acao type=hidden value=valida><input name=url type=hidden value=""" & Request.ServerVariables("query_string") & """><td colspan=2><FONT face=tahoma style=font-size:11px;font-family:tahoma><b>Login no administrador</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td colspan=2><FONT face=tahoma style=font-size:10px;font-family:tahoma;color:000000>Esta é uma área de acesso restrito</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma style=font-size:11px;font-family:tahoma>Usuário:</td><td><input name=usr type=text style=font-size:11px;font-family:tahoma></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma style=font-size:11px;font-family:tahoma>Senha:</td><td><input name=sen type=password style=font-size:11px;font-family:tahoma></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td colspan=2><div class=""menutitle""><FONT face=tahoma style=font-size:11px;font-family:tahoma>Esqueci minha senha <input type='checkbox' name='s' onclick=""SwitchMenu('sim');document.x.esqs.focus();""></div></td><tr><td colspan=2><span class=""submenu"" id=""sim"" style=""display:none""><FONT face=tahoma style=font-size:11px;font-family:tahoma>Digite seu email:<br><input name=esqs type=text style=font-size:11px;font-family:tahoma size=30 value='digite seu email' onclick='this.value=""""'></span></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td align=center  colspan=2><input type=submit value="" Entrar "" style=font-size:11px;font-family:tahoma> <input type=button value=Cancelar onclick='javascript:parent.location=""default.asp""' style=font-size:11px;font-family:tahoma></td></tr>"
	strTextoHtml = strTextoHtml & "</form></table>"
	strTextoHtml = strTextoHtml & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td valign=bottom>"
	strTextoHtml = strTextoHtml & "<TABLE cellSpacing=2 cellPadding=2 width=""100%"" align=center bgcolor=#eeeeee border=0 valign=bottom>"
	strTextoHtml = strTextoHtml & "<TBODY><TR><TD vAlign=bottom align=right width=""100%"">"
	strTextoHtml = strTextoHtml & "<a href=""http://www.virtuastore.com.br"" target=_new style=text-decoration:none;><FONT face=tahoma style=font-size:11px><B>&copy; VirtuaStore - Powered by VirtuaStore OPEN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class=menu  href=""http://br.groups.yahoo.com/group/virtuastore"" target=_blank>Participe da Comunidade VirtuaStore</a></B>&nbsp;&nbsp;</TD></TR></TBODY></TABLE></div>"
	strTextoHtml = strTextoHtml & "</td></tr></table></td></tr></table>"

	End Select

strTextoHtml = strTextoHtml & "</body>"
strTextoHtml = strTextoHtml & "</html>"

conexao.Close
Set conexao = Nothing
'End Sub
%>