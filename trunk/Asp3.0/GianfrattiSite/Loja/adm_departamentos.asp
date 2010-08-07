<!--#include file="adm_restrito.asp"-->
<%

'##### DEPARTAMENTOS

'Sub DepartamentosASP()
If Request("acaba") = "sim" Then
Session("adm_descprod") = ""
Session("adm_email") = ""
End If

Select Case strAcao
Case "inserir"
	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Incluir novo departamento na loja</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<form method=post action=""administrador.asp?link=dep&acao=gravanovo"">"
	strTextoHtml = strTextoHtml & "<table align=center width=""90%"">"

	varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"

	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dia & "/" & mez & "/" & Year(Date) & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Departamento:</b></td><td><input name=""nomedep"" type=""text"" value="""

	If Request.QueryString("erro1") <> "sim" Then
	strTextoHtml = strTextoHtml & Request.QueryString("erro1")
	End If

	strTextoHtml = strTextoHtml & """ size=50  style=font-size:11px;font-family:tahoma>"

	If Request.QueryString("erro1") = "sim" Then
	strTextoHtml = strTextoHtml & varimg
	End If

	strTextoHtml = strTextoHtml & "</td></tr><tr><td colspan=2><FONT face=tahoma  style=font-size:10px color=""#003366"">Dica: Para criar apenas um Departamento e inserir Produtos nele (sem ter Sub-Departamentos), crie um Sub-Departamento chamado ""Todos"" e cadastre os produtos neste Sub-Departamento</font></td></tr>"
	
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Descrição (opcional):</b></td><td><textarea name=""descri"" rows=5 cols=55 style=font-size:11px;font-family:tahoma>" & Request.QueryString("erro3") & "</textarea></td></tr>"


	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Visível:</b></td><td><select name=""ver"" style=font-size:11px;font-family:tahoma><option value=""s"" "

	If CStr(Request.QueryString("erro2")) = "s" Then
	strTextoHtml = strTextoHtml & "selected"
	End If

	strTextoHtml = strTextoHtml & ">Sim<option value=""n"" "

	If CStr(Request.QueryString("erro2")) = "n" Then
	strTextoHtml = strTextoHtml & "selected"
	End If

	strTextoHtml = strTextoHtml & ">Não</select></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td align=center></td><td align=center>&nbsp;&nbsp;&nbsp;&nbsp;<input type=""submit"" NAME=""Enter"" style=font-size:11px;font-family:tahoma value=""Gravar departamento""> <input type=""reset"" value=""Limpar formulario"" style=font-size:11px;font-family:tahoma></td></table><br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"

Case "gravanovo"
	nome = Trim(Request("nomedep"))
	descri = Trim(Request("descri"))
	ver = Trim(Request("ver"))
	If nome = "" Then
	If nome = "" Then erro1 = "sim" Else erro1 = nome
	erro3 = descri
	If ver = "" Then erro2 = "sim" Else erro2 = ver
	Response.Redirect "?link=dep&acao=inserir&erro1=" & erro1 & "&erro2=" & erro2 & "&erro3=" & erro3
	End If

	If descri = "" Then
	descri = "-"
	End If

	If CStr(Len(Day(Now))) = CStr("1") Then
	diazz = "0" & Day(Now)
	Else
	diazz = Day(Now)
	End If
	If CStr(Len(Month(Now))) = CStr("1") Then
	meszz = "0" & Month(Now)
	Else
	meszz = Month(Now)
	End If
	dataz = diazz & "/" & meszz & "/" & Year(Now)

	textosql = "INSERT INTO sessoes (data, nome, descr,ver) VALUES ('" & dataz & "', '" & nome & "', '" & descri & "','" & ver & "');"
	Set gravadep = conexao.Execute(textosql)

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Novo departamento incluído na loja com sucesso</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
	strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=dep&acao=inserir&acaba=sim"">Inserir um novo departamento na loja</a></b></center>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc><br>"
	strTextoHtml = strTextoHtml & "<table align=center width=""90%"">"

	varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"

	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dataz & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Departamento:</b></td><td><FONT face=tahoma  style=font-size:11px>" & nome & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Descrição (opcional):</b></td><td><FONT face=tahoma  style=font-size:11px>"

	If descri = "" Then
	strTextoHtml = strTextoHtml & "-"
	Else
	strTextoHtml = strTextoHtml & descri
	End If

	strTextoHtml = strTextoHtml & "</td></tr><tr><td><FONT face=tahoma  style=font-size:11px><b>Visível:</b></td><td><FONT face=tahoma  style=font-size:11px>"

	If CStr(ver) = "s" Then
	strTextoHtml = strTextoHtml & "Sim"
	Else
	strTextoHtml = strTextoHtml & "Não"
	End If

	strTextoHtml = strTextoHtml & "</td></tr><tr><td colspan=2 align=center height=15></td></tr></table><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"

Case "editar"
	Set rs = conexao.Execute("SELECT * FROM sessoes ORDER by nome")
	If rs.EOF Or rs.bof Then

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Editar departamentos na loja</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=100><tr><td>"
	strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Departamentos(s) encontrado(s): <b>0</b> <hr size=1 color=#dddddd width=""100%"">"
	strTextoHtml = strTextoHtml & "<br><br><table width=568 align=center>"
	strTextoHtml = strTextoHtml & "<tr><td align=center><br><br><b><font style=font-size:11px>Nenhum departamento foi encontrado na base de dados da loja.<br><br></b><br><br></td></tr></table>"
	strTextoHtml = strTextoHtml & "<br></table>"
	strTextoHtml = strTextoHtml & "<table width=""100%"" cellspacing=""0"" cellpadding=""0""><tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
	strTextoHtml = strTextoHtml & "</tr></table><td></tr></table>"

	Else

	Set rs2 = conexao.Execute("SELECT count(nome) AS total FROM sessoes;")
	totalreg = rs2("total")
	rs2.Close
	Set rs2 = Nothing
	numiz = Request("pagina") & "0"
	numiz = CInt(numiz)
	iz = iz + numiz

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Editar departamentos na loja</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=100><tr><td>"
	strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Departamentos(s) encontrado(s): <b>" & totalreg & "</b> <hr size=1 color=#dddddd width=""100%"">"
	strTextoHtml = strTextoHtml & "<table><tr><td height=3></td></tr></table><table width=568 align=center>"

	While Not rs.EOF
	iz = iz + 1
	If rs("ver") = "s" Then
	varestoq = "<font color=#000000>Sim</font>"
	Else
	varestoq = "<font color=#b23c04>Não</font>"
	End If

	strTextoHtml = strTextoHtml & "<tr><td align=left valign=center>"
	strTextoHtml = strTextoHtml & "<table width=""100%"" bgcolor=#eeeeee style='border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;'><tr><td valign=center><font face=""tahoma"" style=font-size:11px;color:000000>" & iz & ") <b>" & UCase(rs("nome")) & "</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Data: <b>" & rs("data") & "</b> &nbsp;&nbsp;&nbsp;Visível: <b>" & varestoq & "</b></td><td align=right valign=center><font face=""tahoma"" style=font-size:11px;color:000000>Ação: <b><a href=?link=dep&acao=ver&dep=" & rs("id") & ">Ver</a></b> | <b><a href=?link=dep&acao=edita&dep=" & rs("id") & ">Editar</a></b>&nbsp;</td></tr></table> <table><tr><td height=4></td></tr></table>"

	rs.movenext
	Wend

	strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
	strTextoHtml = strTextoHtml & "</tr></table></td></tr></table> </td></tr></table>"

	rs.Close
	Set rs = Nothing
	End If

Case "excluir"
	Set rs = conexao.Execute("SELECT * FROM sessoes ORDER by nome")
	If rs.EOF Or rs.bof Then

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Excluir departamentos na loja</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=100><tr><td>"
	strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Departamentos(s) encontrado(s): <b>0</b> <hr size=1 color=#dddddd width=""100%"">"
	strTextoHtml = strTextoHtml & "<br><br><table width=568 align=center>"
	strTextoHtml = strTextoHtml & "<tr><td align=center><br><br><b><font style=font-size:11px>Nenhum departamento foi encontrado na base de dados da loja.<br><br></b><br><br></td></tr></table>"
	strTextoHtml = strTextoHtml & "<br></table>"
	strTextoHtml = strTextoHtml & "<table width=""100%"" cellspacing=""0"" cellpadding=""0""><tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
	strTextoHtml = strTextoHtml & "</tr></table><td></tr></table>"

	Else

	Set rs2 = conexao.Execute("SELECT count(nome) AS total FROM sessoes;")
	totalreg = rs2("total")
	rs2.Close
	Set rs2 = Nothing
	numiz = Request("pagina") & "0"
	numiz = CInt(numiz)
	iz = iz + numiz

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Excluir departamentos na loja</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=100><tr><td>"
	strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Departamentos(s) encontrado(s): <b>" & totalreg & "</b> <hr size=1 color=#dddddd width=""100%"">"
	strTextoHtml = strTextoHtml & "<table><tr><td height=3></td></tr></table><table width=568 align=center>"

	If Request("status") = "sucesso" Then

	strTextoHtml = strTextoHtml & "<div align=center><b><font style=font-size:11px;font-family:tahoma;color:#003366>DEPARTAMENTO EXCLIUDO COM SUCESSO!<br><br></font></b></center>"

	Else
	End If

	While Not rs.EOF
	iz = iz + 1
	If rs("ver") = "s" Then
	varestoq = "<font color=#000000>Sim</font>"
	Else
	varestoq = "<font color=#b23c04>Não</font>"
	End If

	strTextoHtml = strTextoHtml & "<script language=""javascript"">" & vbNewLine
	strTextoHtml = strTextoHtml & "function dep" & rs("id") & "(){" & vbNewLine
	strTextoHtml = strTextoHtml & "if (confirm('Você realmente deseja excluir este departamento e seus respectivos sub-departamentos e produtos?'))" & vbNewLine
	strTextoHtml = strTextoHtml & "{" & vbNewLine
	strTextoHtml = strTextoHtml & "window.location.href('?link=dep&acao=exclui&dep=" & rs("id") & "');" & vbNewLine
	strTextoHtml = strTextoHtml & "}" & vbNewLine
	strTextoHtml = strTextoHtml & "else" & vbNewLine
	strTextoHtml = strTextoHtml & "{" & vbNewLine
	strTextoHtml = strTextoHtml & "}}" & vbNewLine
	strTextoHtml = strTextoHtml & "</script>" & vbNewLine

	strTextoHtml = strTextoHtml & "<tr><td align=left valign=center>" & vbNewLine
	strTextoHtml = strTextoHtml & "<table width=""100%"" bgcolor=#eeeeee style='border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;'><tr><td valign=center><font face=""tahoma"" style=font-size:11px;color:000000>" & iz & ") <b>" & UCase(rs("nome")) & "</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Data: <b>" & rs("data") & "</b> &nbsp;&nbsp;&nbsp;Visível: <b>" & varestoq & "</b></td><td align=right valign=center><font face=""tahoma"" style=font-size:11px;color:000000>Ação: <b><a href=?link=dep&acao=ver&dep=" & rs("id") & "&modo=exclui>Ver</a></b> | <b><a href=""javascript: dep" & rs("id") & "();"">Excluir</a></b>&nbsp;</td></tr></table> <table><tr><td height=4></td></tr></table>"

	rs.movenext
	Wend

	strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
	strTextoHtml = strTextoHtml & "</tr></table></td></tr></table> </td></tr></table>"

	rs.Close
	Set rs = Nothing
	End If

Case "exclui"
	notz = Request.QueryString("dep")
	
	set rs_delete = abredb.execute("SELECT idcategoria from categoria where idsessao=" & notz & ";")
	if not rs_delete.eof then
	delete_idcategoria=rs_delete("idcategoria")
	end if
	rs_delete.close
	set rs_delete = nothing
		
	conexao.Execute("delete from categoria where idsessao=" & notz & ";")
	conexao.Execute("delete from sessoes where id=" & notz & ";")
	conexao.Execute("delete from produtos where idsessao='" & delete_idcategoria & "';")
	Response.Redirect "?link=dep&acao=excluir&status=sucesso"

Case "ver"

	Set setdep = conexao.Execute("SELECT * FROM sessoes WHERE id = " & Request("dep") & ";")

	nome = setdep("nome")
	data = setdep("data")
	descri = setdep("descr")
	ver = setdep("ver")

	If Request("status") = "sucesso" Then

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Departamento editado com sucesso</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
	strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=dep&acao=edita&dep=" & Request("dep") & "&acaba=sim"">Editar novamente este departamento</a></b> |<b><A href=""?link=dep&acao=editar&acaba=sim""> Ver novamente todos os departamentos</a></b></center>"

	Else

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Ver departamento cadastrado na loja</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"

	If Request("modo") = "exclui" Then

	strTextoHtml = strTextoHtml & "<script language=""javascript"">" & vbNewLine
	strTextoHtml = strTextoHtml & "function dep" & Request("dep") & "(){" & vbNewLine
	strTextoHtml = strTextoHtml & "if (confirm('Você realmente deseja excluir este departamento e seus respectivos produtos?'))" & vbNewLine
	strTextoHtml = strTextoHtml & "{" & vbNewLine
	strTextoHtml = strTextoHtml & "window.location.href('?link=dep&acao=exclui&dep=" & Request("dep") & "');" & vbNewLine
	strTextoHtml = strTextoHtml & "}" & vbNewLine
	strTextoHtml = strTextoHtml & "else" & vbNewLine
	strTextoHtml = strTextoHtml & "{" & vbNewLine
	strTextoHtml = strTextoHtml & "}}" & vbNewLine
	strTextoHtml = strTextoHtml & "</script>" & vbNewLine

	strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><a href=""vbscript: dep" & Request("dep") & "()"">Excluir este departamento</a></b> |<b><A href=""?link=dep&acao=excluir&acaba=sim""> Ver todos os departamentos</a></b></center>"

	Else

	strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=dep&acao=edita&dep=" & Request("dep") & "&acaba=sim"">Editar este departamento</a></b> |<b><A href=""?link=dep&acao=editar&acaba=sim""> Ver todos os departamentos</a></b></center>"

	End If
	End If

	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc><br>"
	strTextoHtml = strTextoHtml & "<table align=center width=""90%"">"
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dataz & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Departamento:</b></td><td><FONT face=tahoma  style=font-size:11px>" & nome & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Descrição (opcional):</b></td><td><FONT face=tahoma  style=font-size:11px>"

	If setdep("descr") = "" Then
	strTextoHtml = strTextoHtml & "-"
	Else
	strTextoHtml = strTextoHtml & descri
	End If

	strTextoHtml = strTextoHtml & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Visível:</b></td><td><FONT face=tahoma  style=font-size:11px>"

	If CStr(ver) = "s" Then
	strTextoHtml = strTextoHtml & "Sim"
	Else
	strTextoHtml = strTextoHtml & "Não"
	End If

	strTextoHtml = strTextoHtml & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15></td></tr></table><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"

Case "edita"
	Set depz = conexao.Execute("SELECT * FROM sessoes WHERE id = " & Request("dep") & ";")

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Editar departamento na loja</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<form method=post action=""administrador.asp?link=dep&acao=gravavelho"">"
	strTextoHtml = strTextoHtml & "<input name=""dep"" type=""hidden"" value=""" & Request("dep") & """>"
	strTextoHtml = strTextoHtml & "<table align=center width=""90%"">"

	varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"

	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & depz("data") & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Departamento:</b></td><td><input name=""nomedep"" type=""text"" value=""" & depz("nome") & """ size=50  style=font-size:11px;font-family:tahoma>"

	If Request.QueryString("erro1") = "sim" Then
	strTextoHtml = strTextoHtml & varimg
	End If

	strTextoHtml = strTextoHtml & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Descrição (opcional):</b></td><td><textarea name=""descri"" rows=5 cols=55 style=font-size:11px;font-family:tahoma>"

	If depz("descr") = "-" Then
	strTextoHtml = strTextoHtml & ""
	Else
	strTextoHtml = strTextoHtml & depz("descr")
	End If

	strTextoHtml = strTextoHtml & "</textarea></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Visível:</b></td><td><select name=""ver"" style=font-size:11px;font-family:tahoma><option value=""s"" "

	If CStr(depz("ver")) = "s" Then
	strTextoHtml = strTextoHtml & "selected"
	End If

	strTextoHtml = strTextoHtml & ">Sim<option value=""n"" "

	If CStr(depz("ver")) = "n" Then
	strTextoHtml = strTextoHtml & "selected"
	End If

	strTextoHtml = strTextoHtml & ">Não</select></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td align=center></td><td align=center>&nbsp;&nbsp;&nbsp;&nbsp;<input type=""submit"" NAME=""Enter"" style=font-size:11px;font-family:tahoma value=""Editar departamento""> <input type=""reset"" value=""Limpar formulario"" style=font-size:11px;font-family:tahoma></td></table><br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"

Case "gravavelho"
	nome = Trim(Request("nomedep"))
	descri = Trim(Request("descri"))
	ver = Trim(Request("ver"))
	If nome = "" Then
	If nome = "" Then erro1 = "sim" Else erro1 = nome
	erro3 = descri
	If ver = "" Then erro2 = "sim" Else erro2 = ver
	Response.Redirect "?link=dep&acao=edita2&erro1=" & erro1 & "&erro2=" & erro2 & "&erro3=" & erro3 & "&dep=" & Request("dep")
	End If

	If descri = "" Then
	descri = "-"
	End If

	textosql = "UPDATE sessoes SET nome = '" & nome & "',  descr = '" & descri & "', ver = '" & ver & "' WHERE id = " & Request("dep") & ";"
	Set gravadep = conexao.Execute(textosql)

	Response.Redirect "?link=dep&acao=ver&status=sucesso&dep=" & Request("dep")

Case "edita2"

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Editar departamento na loja</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<form method=post action=""administrador.asp?link=dep&acao=gravavelho"">"
	strTextoHtml = strTextoHtml & "<input name=""dep"" type=""hidden"" value=""" & Request("dep") & """>"
	strTextoHtml = strTextoHtml & "<table align=center width=""90%"">"

	varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"

	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dia & "/" & mez & "/" & Year(Date) & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Departamento:</b></td><td><input name=""nomedep"" type=""text"" value="""

	If Request.QueryString("erro1") <> "sim" Then
	strTextoHtml = strTextoHtml & Request.QueryString("erro1")
	End If

	strTextoHtml = strTextoHtml & """ size=50  style=font-size:11px;font-family:tahoma>"

	If Request.QueryString("erro1") = "sim" Then
	strTextoHtml = strTextoHtml & varimg
	End If

	strTextoHtml = strTextoHtml & "</td></tr><tr><td><FONT face=tahoma  style=font-size:11px><b>Descrição (opcional):</b></td><td><textarea name=""descri"" rows=5 cols=55 style=font-size:11px;font-family:tahoma>" & Request.QueryString("erro3") & "</textarea></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Visível:</b></td><td><select name=""ver"" style=font-size:11px;font-family:tahoma><option value=""s"" "

	If CStr(Request.QueryString("erro2")) = "s" Then
	strTextoHtml = strTextoHtml & "selected"
	End If

	strTextoHtml = strTextoHtml & ">Sim<option value=""n"""

	If CStr(Request.QueryString("erro2")) = "n" Then
	strTextoHtml = strTextoHtml & "selected"
	End If

	strTextoHtml = strTextoHtml & ">Não</select></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td align=center></td><td align=center>&nbsp;&nbsp;&nbsp;&nbsp;<input type=""submit"" NAME=""Enter"" style=font-size:11px;font-family:tahoma value=""Editar departamento""> <input type=""reset"" value=""Limpar formulario"" style=font-size:11px;font-family:tahoma></td></table><br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"


End Select

'End Sub
%>