<!--#include file="adm_restrito.asp"-->
<%

'##### EMAIL

'Sub EmailASP()
If Request("acaba") = "sim" Then
Session("adm_descprod") = ""
Session("adm_email") = ""
End If
Select Case strAcao
Case "escrever"
varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"
strTextoHtml = strTextoHtml & "<form name=""frmemail"" method=""post"" action=""administrador.asp?link=news&acao=grava""><FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/news_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Escrever nova Newsletter</B></FONT><hr size=1 color=#cccccc>"
If Request("sucesso") = "sim" Then
strTextoHtml = strTextoHtml & "<center><b><font style=font-size:11px;font-family:tahoma;color:#003366><br>E-MAIL(S) ENVIADO(S) COM SUCESSO!<br><br></font></b></center>"
Else
strTextoHtml = strTextoHtml & "<br>"
End If
strTextoHtml = strTextoHtml & "<table width=""90%"" align=center border=0>"
strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Enviar para:</b></td><td>"
strTextoHtml = strTextoHtml & "<select name=""para"" style=font-size:11px;font-family:tahoma><option value=""todos"">Para Todos (Clientes e Assinantes)</option><option value=""clientes"">Somente Clientes da Loja</option><option value=""news"">Somente Assinantes da Newsletter da Loja</option>"

'*** Clientes Cadastrados

If VersaoDb = 1 then
   Set rs = conexao.Execute("SELECT nome, email FROM clientes ORDER by nome;")
else
   Set rs = conexao.Execute("SELECT nome, email FROM clientes ORDER by nome;")
end if

strTextoHtml = strTextoHtml & "<OPTGROUP LABEL=""""></OPTGROUP><OPTGROUP LABEL=""Clientes Cadastrados"">"
While Not rs.EOF
strTextoHtml = strTextoHtml & "<option value='" & Cripto(rs("email"),False) & "'>" & Cripto(rs("nome"),False) & " (" & Cripto(rs("email"), False) & ")</option>"
rs.movenext
Wend
strTextoHtml = strTextoHtml & "</OPTGROUP>"


'*** Assinantes Cadastrados
If VersaoDb = 1 then
   Set rs2 = conexao.Execute("SELECT email FROM newsletter ORDER by email;")
else
   Set rs2 = conexao.Execute("SELECT email FROM newsletter ORDER by email;")
end if
strTextoHtml = strTextoHtml & "<OPTGROUP LABEL=""""></OPTGROUP><OPTGROUP LABEL=""Assinantes Cadastrados"">"
While Not rs2.EOF
strTextoHtml = strTextoHtml & "<option value='" & rs2("email") & "'>" & rs2("email") & "</option>"
rs2.movenext
Wend
strTextoHtml = strTextoHtml & "</OPTGROUP></select></td></tr>"

strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Assunto:</b></td><td><input type=text name=""assunto"" size=""45"" value=""" & Request("msg") & """ style=font-size:11px;font-family:tahoma>"
If Request("erro2") = "sim" Then
strTextoHtml = strTextoHtml & varimg
End If
strTextoHtml = strTextoHtml & "</td></tr>"

'***  Adaptacao para usar o Htmlarea
If Request.ServerVariables("SERVER_NAME")="localhost" then
caminho_pasta_htmlarea = Server.MapPath("htmlarea")
caminho_pasta_htmlarea = replace(caminho_pasta_htmlarea,"\","/")
caminho_pasta_htmlarea = caminho_pasta_htmlarea & "/"
Else
caminho_pasta_htmlarea = "htmlarea/"
End If

strTextoHtml = strTextoHtml & "<tr><td valign=""center"" colspan=2>"
strTextoHtml = strTextoHtml & "<SCRIPT LANGUAGE=""JavaScript1.2""><!-- // load htmlarea" & vbNewLine
strTextoHtml = strTextoHtml & "_editor_url="""&caminho_pasta_htmlarea&""";" & vbNewLine
strTextoHtml = strTextoHtml & "var win_ie_ver = parseFloat(navigator.appVersion.split(""MSIE"")[1]);" & vbNewLine
strTextoHtml = strTextoHtml & "if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }" & vbNewLine
strTextoHtml = strTextoHtml & "if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }" & vbNewLine
strTextoHtml = strTextoHtml & "if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }" & vbNewLine
strTextoHtml = strTextoHtml & "if (win_ie_ver >= 5.5) {" & vbNewLine
strTextoHtml = strTextoHtml & "	  document.write('<scr' + 'ipt src=""' +_editor_url+ 'editor.js""');" & vbNewLine
strTextoHtml = strTextoHtml & "	  document.write(' language=""Javascript1.2""></scr' + 'ipt>');  " & vbNewLine
strTextoHtml = strTextoHtml & "} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }" & vbNewLine
strTextoHtml = strTextoHtml & "// --></script>" & vbNewLine
strTextoHtml = strTextoHtml & "</td></tr>"

strTextoHtml = strTextoHtml & "<tr><td nowrap><FONT face=tahoma  style=font-size:11px><b>Texto do<br> e-mail:</b></td><td><textarea name=""email"" rows=20 cols=75 style=font-size:11px;font-family:tahoma>" & Session("adm_email") & "</textarea>"
strTextoHtml = strTextoHtml & "<br><FONT face=tahoma  style=font-size:10px color=""#003366"">Dica: Para fazer uma simples quebra de linha , digite Shift+Enter</font><br><br>"

If Request("erro") = "sim" Then
strTextoHtml = strTextoHtml & varimg
End If
strTextoHtml = strTextoHtml & "</td></tr>"

strTextoHtml = strTextoHtml & "<tr><td valign=""center"" colspan=2>"
strTextoHtml = strTextoHtml & "<script language=""javascript1.2"">"
strTextoHtml = strTextoHtml & "editor_generate('email');"
strTextoHtml = strTextoHtml & "</script>"
strTextoHtml = strTextoHtml & "</td></tr>"

strTextoHtml = strTextoHtml & "<tr><td></td><td align=center>&nbsp;&nbsp;&nbsp;&nbsp;<input type=""submit"" NAME=""Enter"" style=font-size:11px;font-family:tahoma value="" Enviar e-mail(s) ""> <input type=""reset"" value=""  Limpar e-mail  "" style=font-size:11px;font-family:tahoma></td></table><br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"

Case "grava"
email = Request("email")
para = Request("para")
assunto = Request("assunto")
Session("adm_email") = email
If email = "" Or assunto = "" Then
If email = "" Then
erro = "sim"
End If
If assunto = "" Then
erro2 = "sim"
End If
Response.Redirect "administrador.asp?link=news&acao=escrever&erro=" & erro & "&erro2=" & erro2 & "&msg=" & assunto
Else

strString = email
'strString = Codifica(strString) 'Usar somente qdo nao se usa a Ferramenta HTMLarea
email = ""
email = strString

strEmailHTML = "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">"
strEmailHTML = strEmailHTML & "<HTML><HEAD><TITLE>" & nomeloja & " - " & urlloja & "</TITLE>"
strEmailHTML = strEmailHTML & "<META http-equiv=Content-Type content='text/html; charset=iso-8859-1'>"
strEmailHTML = strEmailHTML & "<META content='MSHTML 6.00.2600.0' name=GENERATOR></HEAD>"
strEmailHTML = strEmailHTML & "<BODY>"
strEmailHTML = strEmailHTML & "<font face=""arial"" style='FONT-SIZE: 11px'>"&email&"</font>" 
strEmailHTML = strEmailHTML & "</BODY></HTML>"


Select Case para

'Envia para email para todos
Case "todos"
	Set rs = conexao.Execute("SELECT email FROM newsletter;")
	While Not rs.EOF
	EnviaEmail Application("HostLoja"), Application("ComponenteLoja"), emailloja, "", rs("email"), "Informativo " & nomeloja & " - " & assunto, strEmailHTML
	rs.movenext
	Wend
	
	Set rs2 = conexao.Execute("SELECT nome, email FROM clientes")
	While Not rs2.EOF
	EnviaEmail Application("HostLoja"), Application("ComponenteLoja"), emailloja, "", Cripto(rs2("email"), False), "Informativo " & nomeloja & " - " & assunto, strEmailHTML
	rs2.movenext
	Wend

'Envia para email para todos os assinantes da newsletter da loja
Case "news"
	Set rs = conexao.Execute("SELECT email FROM newsletter;")
	While Not rs.EOF
	EnviaEmail Application("HostLoja"), Application("ComponenteLoja"), emailloja, "", rs("email"), "Informativo " & nomeloja & " - " & assunto, strEmailHTML
	rs.movenext
	Wend

'Envia para email para todos os clientes da loja
Case "clientes"
	Set rs = conexao.Execute("SELECT nome, email FROM clientes;")
	While Not rs.EOF
	EnviaEmail Application("HostLoja"), Application("ComponenteLoja"), emailloja, "", Cripto(rs("email"), False), "Informativo " & nomeloja & " - " & assunto, strEmailHTML
	rs.movenext
	Wend

'Envia para email somente para o email selecionado (nao importa se é cliente ou assinante da newsletter
Case Else

	if instr(para, "@") <> 0 then
	EnviaEmail Application("HostLoja"), Application("ComponenteLoja"), emailloja, "", para, "Informativo " & nomeloja & " - " & assunto, strEmailHTML
	end if

End Select

Response.Redirect "administrador.asp?link=news&acao=escrever&sucesso=sim&acaba=sim"
End If

Case "excluir"
strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/news_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Excluir emails cadastrados na newsletter da loja</B></FONT><hr size=1 color=#cccccc>"

finalera = Request.QueryString("final")
pag = Request.QueryString("itens")
pesss = Trim(Request.QueryString("pesq"))
pagdxx = Request.QueryString("pagina")
pesqsa = Request.QueryString("pesqsa")
catege = Request("cat")
If pesss = "" Then
pesss = "-"
palavra = Split(Trim("asdfghjklçqwertyuiopzxcvbnm"), " ")
Else
pesss = pesss
palavra = Split(Trim(Request.QueryString("pesq")), " ")
End If
If pag = "" Then
inicial = 0
final = 10
Else
inicial = pag
final = 10
End If
If pesqsa = "" Then
restinho = ""
catege = "todos"
Else
If catege = "todos" Or catege = "xxx" Or catege = "" Then
resto = ""
Else
resto = "idsessao = '" & catege & "' and"
End If
palavraz = Split(Trim(pesqsa), " ")
restinho = "WHERE email LIKE  '%" & palavraz(0) & "%'"
End If

Set rs = conexao.Execute("SELECT email,datacad FROM newsletter " & restinho)


If rs.EOF Or rs.bof Then

strTextoHtml = strTextoHtml & "<table><tr><td align=left valign=top><table border=0 cellspacing=4 cellpadding=4 width=100><tr><td>"
strTextoHtml = strTextoHtml & "<font face=tahoma style=font-size:11px;color:000000>Cadastro(s) encontrado(s): <b>0" & totalreg & "</b> <hr size=1 color=#dddddd width=""100%"">"
strTextoHtml = strTextoHtml & "<table cellspacing=3 cellpadding=3 align=center width=""100%"">"
strTextoHtml = strTextoHtml & "<tr><form action=? method=get><input name=link type=hidden value=news><input name=acao type=hidden value=excluir>"
strTextoHtml = strTextoHtml & "<td align=center><font face=""tahoma"" style=font-size:11px;color:000000><center>Para uma busca mais detalhada dos e-mails cadastrados na loja realize uma pesquisa com o e-mail que você procura.</td><tr><td align=center>"
strTextoHtml = strTextoHtml & "<input name=""pesqsa"" type=""text"" size=30 value=""" & Request("pesqsa") & """ style=font-size:11px;color:000000;font-family:tahoma><font style=font-size:11px></font> <input type=submit class=""ok"" value=""Pesquisar"" style=font-size:11px;color:000000;font-family:tahoma>"
strTextoHtml = strTextoHtml & "</td></form></tr><tr><td height=1 bgcolor=cccccc></td></tr></table><br><br>"
strTextoHtml = strTextoHtml & "<table width=565 align=center>"
strTextoHtml = strTextoHtml & "<tr><td align=center><br><br><b><font style=font-size:11px>Nenhum cadastro foi encontrado na base de dados da loja.<br><br></b><br><br></td></tr></table>"
strTextoHtml = strTextoHtml & "<br></table>"
strTextoHtml = strTextoHtml & "<table width=100% cellspacing=""0"" cellpadding=""0""><tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
strTextoHtml = strTextoHtml & "</tr></table><td></tr></table>"

Else
Set rs2 = conexao.Execute("SELECT count(email) AS total FROM newsletter " & restinho & ";")
totalreg = rs2("total")
rs2.Close
Set rs2 = Nothing
numiz = Request("pagina") & "0"
numiz = CInt(numiz)
iz = iz + numiz

strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=100><tr><td>"
strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Assinantes(s) encontrado(s): <b>" & totalreg & "</b> <hr size=1 color=#dddddd width=""100%"">"
strTextoHtml = strTextoHtml & "<table cellspacing=""3"" cellpadding=""3"" align=center width=""100%"">"
strTextoHtml = strTextoHtml & "<tr><form action=""?"" method=get><input name=""link"" type=""hidden"" value=""news""><input name=""acao"" type=""hidden"" value=""excluir"">"
strTextoHtml = strTextoHtml & "<td align=center><font face=""tahoma"" style=font-size:11px;color:000000><center>Para uma busca mais detalhada dos e-mails cadastrados na loja realize uma pesquisa com o e-mail que você procura.</td><tr><td align=center>"
strTextoHtml = strTextoHtml & "<input name=""pesqsa"" type=""text"" size=30 value=""" & Request("pesqsa") & """ style=font-size:11px;color:000000;font-family:tahoma><font style=font-size:11px></font> <input type=submit class=""ok"" value=""Pesquisar"" style=font-size:11px;color:000000;font-family:tahoma>"
strTextoHtml = strTextoHtml & "<br><br></td></form></tr><tr><td height=1 bgcolor=cccccc></td></tr></table>"

If Request("status") = "sucesso" Then
strTextoHtml = strTextoHtml & "<br><center><b><font style=font-size:11px;font-family:tahoma;color:#003366>CADASTRO EXCLUÍDO COM SUCESSO!<br><br></font></b></center>"
Else
strTextoHtml = strTextoHtml & "<br>"
End If

strTextoHtml = strTextoHtml & "<table width=""565"" align=center>"

While Not rs.EOF
iz = iz + 1
emailx = rs("email")
emailx = Replace(emailx, "@", "")
emailx = Replace(emailx, ".", "")
varestoq = "<font color=#b23c04>" & rs("email") & "</font>" & vbNewLine

strTextoHtml = strTextoHtml & "<script language=""javascript"">" & vbNewLine
strTextoHtml = strTextoHtml & "function cli" & replace(emailx, "-", "") & "(){" & vbNewLine
strTextoHtml = strTextoHtml & "if (confirm('Você realmente deseja excluir este cadastro da newsletter?'))" & vbNewLine
strTextoHtml = strTextoHtml & "{" & vbNewLine
strTextoHtml = strTextoHtml & "window.location.href('?link=news&cli=" & rs("email") & "&acao=exclui');" & vbNewLine
strTextoHtml = strTextoHtml & "}" & vbNewLine
strTextoHtml = strTextoHtml & "else" & vbNewLine
strTextoHtml = strTextoHtml & "{" & vbNewLine
strTextoHtml = strTextoHtml & "}}" & vbNewLine
strTextoHtml = strTextoHtml & "</script>" & vbNewLine

strTextoHtml = strTextoHtml & "<tr><td align=left valign=center>"
strTextoHtml = strTextoHtml & "<table width=""100%"" bgcolor=#eeeeee style=""border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;""><tr><td valign=center><font face=""tahoma"" style=font-size:11px;color:000000>" & iz & ") <b>" & UCase(varestoq) & "</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Data do cadastro: <b>" & rs("datacad") & "</b></td><td align=right valign=center><font face=""tahoma"" style=font-size:11px;color:000000>Ação: <b><a href=""javascript: cli" & replace(emailx, "-", "") & "();"">Excluir</a></b>&nbsp;</td></tr></table> <table><tr><td height=4></td></tr></table>"

rs.movenext
Wend
pagn = inicial + 10
paga = pagn - 20


strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=tahoma style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
strTextoHtml = strTextoHtml & "</tr></table></table></table>"

rs.Close
Set rs = Nothing
End If

Case "exclui"
notz = Request.QueryString("cli")
Set dados = conexao.Execute("delete from newsletter where email = '" & notz & "';")
Response.Redirect "?link=news&acao=excluir&status=sucesso"

End Select
'End Sub
%>