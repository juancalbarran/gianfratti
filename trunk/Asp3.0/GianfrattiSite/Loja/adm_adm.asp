<!--#include file="adm_restrito.asp"-->
<%
'##### ADMINISTRADOR'

If Request("acaba") = "sim" Then
Session("adm_email") = ""
Session("adm_descprod") = ""
End If

Select Case strAcao
Case "inserir"
strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Incluir novo administrador na loja</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<form method=post action=""administrador.asp?link=adm&acao=gravanovo"" name=frmprod>"
strTextoHtml = strTextoHtml & "<table align=center width=""90%"" border=0>"
varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"
strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dia & "/" & mez & "/" & Year(Date) & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td width=""10%""><FONT face=tahoma  style=font-size:11px><b>Login:</b></td><td><input name=""login"" type=""text"" value="""
	If Request.QueryString("erro1") <> "sim" Then
	strTextoHtml = strTextoHtml & Request.QueryString("erro1")
	End If
strTextoHtml = strTextoHtml & """ size=50 maxlenght=50  style=font-size:11px;font-family:tahoma>"
	If Request.QueryString("erro1") = "sim" Then
	strTextoHtml = strTextoHtml & varimg
	End If
strTextoHtml = strTextoHtml & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Senha:</b></td><td><input name=""senha"" type=""password"" size=50 maxlenght=50 value="""
If Request.QueryString("erro2") <> "sim" Then
strTextoHtml = strTextoHtml & Request.QueryString("erro2")
End If
strTextoHtml = strTextoHtml & """ style=font-size:11px;font-family:tahoma>"
If Request.QueryString("erro2") = "sim" Then
strTextoHtml = strTextoHtml & varimg
End If
strTextoHtml = strTextoHtml & "</td></tr>"


strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Email:</b></td><td><input name=""email"" type=""text"" size=50 maxlenght=50 value="""
If Request.QueryString("erro3") <> "sim" Then
strTextoHtml = strTextoHtml & Request.QueryString("erro3")
End If
strTextoHtml = strTextoHtml & """ style=font-size:11px;font-family:tahoma>"
If Request.QueryString("erro3") = "sim" Then
strTextoHtml = strTextoHtml & varimg
End If
strTextoHtml = strTextoHtml & "</td></tr>"

strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15>&nbsp;</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td align=center colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;<input type=""submit"" NAME=""Enter"" style=font-size:11px;font-family:tahoma value="" Gravar Administrador ""> <input type=""reset"" value=""Limpar formulario"" style=font-size:11px;font-family:tahoma></td></table><br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"

Case "gravanovo"
login = Trim(Request.Form("login"))
senha = Trim(Request.Form("senha"))
email = Trim(Request.Form("email"))
textosql = "SELECT * FROM ACESSO WHERE LOGIN='"&Cripto(login,true)&"' AND SENHA= '"&Cripto(senha,true)&"' AND EMAIL=  '"&Cripto(email,true)&"'"

Set pesqadm = conexao.Execute(textosql)
IF NOT pesqadm.EOF THEN
	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Administrador já está cadastrado</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
	strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=admin&acao=inserir&acaba=sim"">Inserir um novo administrador na loja</a></b></center>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc><br>"
	strTextoHtml = strTextoHtml & "<table align=center width=""88%"" cellspacing=""2"" cellpadding=""2"">"
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dia & "/" & mez & "/" & Year(Date) & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Nome do administrador:</b></td><td><FONT face=tahoma  style=font-size:11px>" & login & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15></td></tr></table><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br><br>"
ELSE
	If login = "" Or senha = ""  OR email = "" Then
		If login = "" Then
		erro1 = "sim"
		Else
		erro1 = login
		End If
		If senha = "" Then
		erro2 = "sim"
		Else
		erro2 = senha
		End If
		If email = "" Then
		erro3 = "sim"
		Else
		erro3 = email
		End If
		Response.Redirect "?link=admin&acao=inserir&erro1=" & erro1 & "&erro2=" & erro2&"&erro3="&erro3
		End If
	textosql = "INSERT INTO ACESSO (LOGIN,SENHA,EMAIL) VALUES ('"& Cripto(login,true) &"','"& Cripto(senha,true) &"','"& Cripto(email,true) &"')"
	Set gravaadm = conexao.Execute(textosql)
	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Administrador cadastrado com sucesso</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
	strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=adm&acao=inserir&acaba=sim"">Inserir um novo administrador na loja</a></b></center>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc><br>"
	strTextoHtml = strTextoHtml & "<table align=center width=""88%"" cellspacing=""2"" cellpadding=""2"">"
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dia & "/" & mez & "/" & Year(Date) & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Nome do administrador:</b></td><td><FONT face=tahoma  style=font-size:11px>" & login & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15></td></tr></table><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br><br>"
END IF

Case "editar"
SQL = "SELECT * FROM ACESSO WHERE IDACESSO="&Session("IdAdm")
Set Rs = conexao.Execute(SQL)
IF NOT Rs.eof Then
	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Alteraração de senha</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<form method=post action=""administrador.asp?link=adm&acao=final"" name=frmprod>"
	strTextoHtml = strTextoHtml & "<table align=center width=""90%"" border=0>"
	varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dia & "/" & mez & "/" & Year(Date) & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td width=""10%""><FONT face=tahoma  style=font-size:11px><b>Login:</b></td><td><input name=""login"" type=""text"" value='"&Session("NOME")&"' size=50 maxlenght=50 readonly style=font-size:11px;font-family:tahoma>"
	strTextoHtml = strTextoHtml & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Senha:</b></td><td><input name=""senha"" type=""password"" size=50 maxlenght=50 value="""
	strTextoHtml = strTextoHtml & """ style=font-size:11px;font-family:tahoma>"
	If Request.QueryString("erro1") = "sim" Then
		strTextoHtml = strTextoHtml & varimg
		End If
	strTextoHtml = strTextoHtml & "</td></tr>"

	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Email:</b></td><td><input name=""email"" type=""text"" size=50  value='"&DecodeBase64(RS("EMAIL"))&"' "
	strTextoHtml = strTextoHtml & " style=font-size:11px;font-family:tahoma>"
		If Request.QueryString("erro2") = "sim" Then
		strTextoHtml = strTextoHtml & varimg
		End If
	strTextoHtml = strTextoHtml & "</td></tr>"

	strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15>&nbsp;</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td align=center colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;<input type=""submit"" NAME=""Enter"" style=font-size:11px;font-family:tahoma value="" Gravar Administrador ""> <input type=""reset"" value=""Limpar formulario"" style=font-size:11px;font-family:tahoma id=1 name=1></td></table><br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"
ELSE
	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Alteraração de senha</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=admin&acao=inserir&acaba=sim"">Inserir um novo administrador na loja</a></b></center><BR><BR>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "Não foi encontrado o seus dados na base.<br>Contate o WebMaster responsável."
	strTextoHtml = strTextoHtml & "<hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<table><tr><td colspan=2 align=center height=15 align=center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></td></tr></table>"
END IF

Case "final"
senha = Trim(Request.Form("senha"))
email = Trim(Request.Form("email"))
	If senha = "" or email = "" Then
		If senha = "" Then
		erro1 = "sim"
		Else
		erro1 = senha
		End If
		If email = "" Then
		erro2 = "sim"
		Else
		erro2 = email
		End If
		Response.Redirect "?link=adm&acao=editar&erro1=" & erro1 &"&erro2=" & erro2  
	End If

	textosql = "UPDATE  ACESSO SET SENHA='"& Cripto(senha,true) &"', EMAIL='"& Cripto(email,true) &"' WHERE IDACESSO="&Session("IdAdm")
	Set gravaadm = conexao.Execute(textosql)

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Senha alterada com sucesso</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
	strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=admin&acao=inserir&acaba=sim"">Inserir um novo administrador na loja</a></b></center>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc><br>"
	strTextoHtml = strTextoHtml & "<table align=center width=""88%"" cellspacing=""2"" cellpadding=""2"">"
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dia & "/" & mez & "/" & Year(Date) & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Nome do administrador:</b></td><td><FONT face=tahoma  style=font-size:11px>" & Ucase(Session("nome")) & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Email do administrador:</b></td><td><FONT face=tahoma  style=font-size:11px>" & email & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15></td></tr></table><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br><br>"

Case "excluir"

IF Request.QueryString("Adm") = "" THEN
	SQL = "SELECT * FROM ACESSO WHERE IDACESSO <> 1"
	SET RS = conexao.Execute(SQL)
		IF NOT Rs.EOF THEN
			strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Exclusão de administradores</B></FONT><hr size=1 color=#cccccc>"
			strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
			strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=admin&acao=inserir&acaba=sim"">Inserir um novo administrador na loja</a></b></center><BR><BR>"
			cont = 1
			do while not rs.eof
			strTextoHtml = strTextoHtml & "<table width=""100%"" bgcolor=#eeeeee style='border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;'><tr><td valign=center><font face=""tahoma"" style=font-size:11px;color:000000>"&Cont&") &nbsp;<b>"&DecodeBase64(Rs("LOGIN"))&"</b></font></td>"
			strTextoHtml = strTextoHtml & "<td align=right valign=middle><font face=""tahoma"" style=font-size:11px;color:000000>Ação: "
			strTextoHtml = strTextoHtml & "<b><a href=""#"" onclick=""javascript:if(confirm('Deseja excluir este adminitrador')==true){parent.location='?link=adm&acao=excluir&acaba=sim&Adm="&Rs("idacesso")&"';}else{return false};"">Excluir</a></b>&nbsp;</font></td>"
			strTextoHtml = strTextoHtml & "</tr></table> <table><tr><td height=4></td></tr></table>"
			strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
			Rs.MoveNext
			cont = cont + 1
			Loop
			strTextoHtml = strTextoHtml & "<table><tr><td colspan=2 align=center height=15 align=center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></td></tr></table>"
		ELSE
			strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Exclusão de administradores</B></FONT><hr size=1 color=#cccccc>"
			strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=admin&acao=inserir&acaba=sim"">Inserir um novo administrador na loja</a></b></center><BR><BR>"
			strTextoHtml = strTextoHtml & "<hr size=1 color=#cccccc>"
			strTextoHtml = strTextoHtml & "Não existem administradores cadastrados, além do default"
			strTextoHtml = strTextoHtml & "<hr size=1 color=#cccccc>"
			strTextoHtml = strTextoHtml & "<table><tr><td colspan=2 align=center height=15 align=center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></td></tr></table>"
		END IF
ELSE
	SQL = "DELETE FROM ACESSO WHERE IDACESSO = "&Request.QueryString("Adm")
	SET RS = conexao.Execute(SQL)
	Response.Redirect "?link=adm&acao=excluir&acaba=sim"
END IF
End Select
%>