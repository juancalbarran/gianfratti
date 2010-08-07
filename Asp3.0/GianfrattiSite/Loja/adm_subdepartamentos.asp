<%
'#########################################################################################
'#----------------------------------------------------------------------------------------
'#########################################################################################
'#
'#  CÓDIGO: VirtuaStore Versão OPEN - Copyright 2001-2004 VirtuaStore
'#  URL: http://comunidade.virtuastore.com.br
'#  E-MAIL: comunidade@virtuastore.com.br
'#  AUTORES: Otávio Dias(Desenvolvedor)
'# 
'#     Este programa é um software livre; você pode redistribuí-lo e/ou 
'#     modificá-lo sob os termos do GNU General Public License como 
'#     publicado pela Free Software Foundation.
'#     É importante lembrar que qualquer alteração feita no programa 
'#     deve ser informada e enviada para os criadores, através de e-mail 
'#     ou da página de onde foi baixado o código.
'#
'#  //-------------------------------------------------------------------------------------
'#  // LEIA COM ATENÇÃO: O software VirtuaStore OPEN deve conter as frases
'#  // "Powered by VirtuaStore OPEN" ou "Software derivado de VirtuaStore 1.2" e 
'#  // o link para o site http://comunidade.virtuastore.com.br no créditos da 
'#  // sua loja virtual para ser utilizado gratuitamente. Se o link e/ou uma das 
'#  // frases não estiver presentes ou visiveis este software deixará de ser
'#  // considerado Open-source(gratuito) e o uso sem autorização terá 
'#  // penalidades judiciais de acordo com as leis de pirataria de software.
'#  //--------------------------------------------------------------------------------------
'#      
'#     Este programa é distribuído com a esperança de que lhe seja útil,
'#     porém SEM NENHUMA GARANTIA. Veja a GNU General Public License
'#     abaixo (GNU Licença Pública Geral) para mais detalhes.
'# 
'#     Você deve receber a cópia da Licença GNU com este programa, 
'#     caso contrário escreva para
'#     Free Software Foundation, Inc., 59 Temple Place, Suite 330, 
'#     Boston, MA  02111-1307  USA
'# 
'#     Para enviar suas dúvidas, sugestões e/ou contratar a VirtuaWorks 
'#     Internet Design entre em contato através do e-mail 
'#     contato@virtuaworks.com.br ou pelo endereço abaixo: 
'#     Rua Venâncio Aires, 1001 - Niterói - Canoas - RS - Brasil. Cep 92110-000.
'#
'#     Para ajuda e suporte acesse um dos sites abaixo:
'#     http://comunidade.virtuastore.com.br
'#     http://br.groups.yahoo.com/group/virtuastore
'#
'#     BOM PROVEITO!          
'#     Equipe VirtuaStore
'#     []'s
'#
'#########################################################################################
'#----------------------------------------------------------------------------------------
'#########################################################################################

'INÍCIO DO CÓDIGO---------------------
'Este código está otimizado e roda tanto em Windows 2000/NT/XP/ME/98 quanto em servidores UNIX-LINUX com chilli!ASP
%>
<!--#include file="adm_restrito.asp"-->
<%

'##### Sub-departamentoS

'Sub Sub-departamentosASP()
If Request("acaba") = "sim" Then
Session("adm_descprod") = ""
Session("adm_email") = ""
End If

Select Case strAcao
Case "inserir"
	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Incluir novo Sub-departamento na loja</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<form method=post action=""administrador.asp?link=sdep&acao=gravanovo"">"
	strTextoHtml = strTextoHtml & "<table align=center width=""90%"">"
	varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"

	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dia & "/" & mez & "/" & Year(Date) & "</td></tr>"

	'--------------------------------------------------------------------------------------------
	'##### DEPARTAMENTOS (LISTAGEM)
	'--------------------------------------------------------------------------------------------

	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Departamento:</b></td><td>"
	SQL = "SELECT * FROM sessoes ORDER BY nome ASC"
	Set Rs = conexao.Execute(SQL)
	If not Rs.eof then
	strTextoHtml = strTextoHtml & "<select name='sessao' size='1'>"&VBcrlf
	Do while not Rs.eof
	strTextoHtml = strTextoHtml & "<option value="&Rs("id")&">"&Rs("nome")&"</option>"&VBcrlf
	Rs.MoveNext
	Loop
	strTextoHtml = strTextoHtml & "</select></td></tr>"&VBcrlf
	End if

	strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Sub-Departamento:</b></td><td><input name=""nomedep"" type=""text"" value="""


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
	strTextoHtml = strTextoHtml & "<tr><td align=center></td><td align=center>&nbsp;&nbsp;&nbsp;&nbsp;<input type=""submit"" NAME=""Enter"" style=font-size:11px;font-family:tahoma value=""Gravar Sub-departamento""> <input type=""reset"" value=""Limpar formulario"" style=font-size:11px;font-family:tahoma></td></table><br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"

Case "gravanovo"
	nome = Trim(Request("nomedep"))
	descri = Trim(Request("descri"))
	ver = Trim(Request("ver"))
	sessao = Request("sessao")
	If nome = "" Then
	If nome = "" Then erro1 = "sim" Else erro1 = nome
	erro3 = descri
	If ver = "" Then erro2 = "sim" Else erro2 = ver
	Response.Redirect "?link=sdep&acao=inserir&erro1=" & erro1 & "&erro2=" & erro2 & "&erro3=" & erro3
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

	textosql = "INSERT INTO categoria (data, nome, descr,ver,idsessao) VALUES ('" & dataz & "', '" & nome & "', '" & descri & "','" & ver & "',"&sessao&");"
	Set gravadep = conexao.Execute(textosql)

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Novo Sub-departamento incluído na loja com sucesso</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
	strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=sdep&acao=inserir&acaba=sim"">Inserir um novo Sub-departamento na loja</a></b></center>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc><br>"
	strTextoHtml = strTextoHtml & "<table align=center width=""90%"">"

	varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"

	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dataz & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Sub-departamento:</b></td><td><FONT face=tahoma  style=font-size:11px>" & nome & "</td></tr>"
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
	Set rs = conexao.Execute("SELECT * FROM SESSOES ORDER BY NOME")
	If rs.EOF Or rs.bof Then

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Editar Sub-departamentos na loja</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=100><tr><td>"
	strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Sub-departamentos(s) encontrado(s): <b>0</b> <hr size=1 color=#dddddd width=""100%"">"
	strTextoHtml = strTextoHtml & "<br><br><table width=568 align=center>"
	strTextoHtml = strTextoHtml & "<tr><td align=center><br><br><b><font style=font-size:11px>Nenhum Sub-departamento foi encontrado na base de dados da loja.<br><br></b><br><br></td></tr></table>"
	strTextoHtml = strTextoHtml & "<br></table>"
	strTextoHtml = strTextoHtml & "<table width=""100%"" cellspacing=""0"" cellpadding=""0""><tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
	strTextoHtml = strTextoHtml & "</tr></table><td></tr></table>"

	Else

	Set rs2 = conexao.Execute("select count(nome) as total from categoria")
	totalreg = rs2("total")
	rs2.Close
	Set rs2 = Nothing
	numiz = Request("pagina") & "0"
	numiz = CInt(numiz)
	iz = iz + numiz


	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Editar Sub-departamentos na loja</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=100><tr><td>"
	strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Sub-departamentos(s) encontrado(s): <b>" & totalreg & "</b> <hr size=1 color=#dddddd width=""100%"">"
	strTextoHtml = strTextoHtml & "<table><tr><td height=3></td></tr></table><table width=568 align=center border=0>"

	While Not rs.EOF
		iz = iz + 1
		If rs("ver") = "s" Then
			varestoq = "<font color=#000000>Sim</font>"
		Else
			varestoq = "<font color=#b23c04>Não</font>"
		End If
	
		strTextoHtml = strTextoHtml & "<tr><td align=left valign=center  style='border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;' >"&_
					"<font face=""tahoma"" style=font-size:11px;color:000000>" & iz & ") <b>"& UCase(rs("nome"))& "</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Data: <b>" & rs("data") & "</b> &nbsp;&nbsp;&nbsp;Visível: <b>" & varestoq & "</b>"&_
					"<table width=""100%"" bgcolor=#eeeeee  border=0 style='border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;' cellspacing=1>"
					
				Set Rs3 = conexao.Execute("SELECT A.idcategoria, B.nome, A.data, A.nome as Nm, A.descr, A.ver FROM CATEGORIA AS A, sessoes as B WHERE B.id = A.idsessao AND B.id="& Rs("id") &" ORDER by A.nome")

				IF NOT RS3.EOF THEN
				izz = 1
					While Not rs3.EOF
					
					If rs3("ver") = "s" Then
					varestoq = "<font color=#000000>Sim</font>"
					Else
					varestoq = "<font color=#b23c04>Não</font>"
					End If
		strTextoHtml = strTextoHtml & "<tr>"&_
									  "<td>"&_
										"<font face=""tahoma"" style=font-size:11px;color:000000>"& iz&"."&izz & ") <b>"& UCase(rs3("nm")) &"</font></td>"&_
										"<td><font face=""tahoma"" style=font-size:11px;color:000000>Data: <b>" & rs3("data") & "</b> &nbsp;&nbsp;&nbsp;Visível: <b>" & varestoq & "</b></font>"&_ 
										"</td>"&_
										"<td>"&_
										"<font face=""tahoma"" style=font-size:11px;color:000000>Ação: <b><a href=?link=sdep&acao=ver&dep=" & rs3("idcategoria") & ">Ver</a></b> | <b><a href=?link=sdep&acao=edita&dep=" & rs3("idcategoria") & ">Editar</a></b>&nbsp;</font>"&_
										"</td>"&_
										"</tr>"
							rs3.movenext
					izz = izz + 1
					Wend
				END IF

	strTextoHtml = strTextoHtml & "</table></td></tr><tr><td height=1>&nbsp;</td></tr>"

	rs.movenext
	Wend

	strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
	strTextoHtml = strTextoHtml & "</tr></table></td></tr></table> </td></tr></table>"

	rs.Close
	Set rs = Nothing
	End If

Case "excluir"
	Set rs = conexao.Execute("SELECT * FROM SESSOES ORDER BY NOME")
	If rs.EOF Or rs.bof Then

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Excluir Sub-departamentos na loja</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=100><tr><td>"
	strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Sub-departamentos(s) encontrado(s): <b>0</b> <hr size=1 color=#dddddd width=""100%"">"
	strTextoHtml = strTextoHtml & "<br><br><table width=568 align=center>"
	strTextoHtml = strTextoHtml & "<tr><td align=center><br><br><b><font style=font-size:11px>Nenhum Sub-departamento foi encontrado na base de dados da loja.<br><br></b><br><br></td></tr></table>"
	strTextoHtml = strTextoHtml & "<br></table>"
	strTextoHtml = strTextoHtml & "<table width=""100%"" cellspacing=""0"" cellpadding=""0""><tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
	strTextoHtml = strTextoHtml & "</tr></table><td></tr></table>"

	Else

	strTextoHtml = strTextoHtml & "<script language=""javascript"">" & vbNewLine
	strTextoHtml = strTextoHtml & "function dep(CAT){" & vbNewLine
	strTextoHtml = strTextoHtml & "if (confirm('Você realmente deseja excluir este Sub-departamento e seus respectivos produtos?'))" & vbNewLine
	strTextoHtml = strTextoHtml & "{" & vbNewLine
	strTextoHtml = strTextoHtml & "parent.location.href='?link=sdep&acao=exclui&dep='+CAT;" & vbNewLine
	strTextoHtml = strTextoHtml & "}" & vbNewLine
	strTextoHtml = strTextoHtml & "else" & vbNewLine
	strTextoHtml = strTextoHtml & "{" & vbNewLine
	strTextoHtml = strTextoHtml & "}}" & vbNewLine
	strTextoHtml = strTextoHtml & "</script>" & vbNewLine


	Set rs2 = conexao.Execute("SELECT count(nome) AS total FROM categoria;")
	totalreg = rs2("total")
	rs2.Close
	Set rs2 = Nothing
	numiz = Request("pagina") & "0"
	numiz = CInt(numiz)
	iz = iz + numiz

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Excluir Sub-departamentos na loja</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=100><tr><td>"
	strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Sub-departamentos(s) encontrado(s): <b>" & totalreg & "</b> <hr size=1 color=#dddddd width=""100%"">"
	strTextoHtml = strTextoHtml & "<table><tr><td height=3></td></tr></table><table width=568 align=center>"

	If Request("status") = "sucesso" Then

	strTextoHtml = strTextoHtml & "<div align=center><b><font style=font-size:11px;font-family:tahoma;color:#003366>DEPARTAMENTO EXCLUIDO COM SUCESSO!<br><br></font></b></center>"

	Else
	End If

	While Not rs.EOF
	iz = iz + 1
	If rs("ver") = "s" Then
	varestoq = "<font color=#000000>Sim</font>"
	Else
	varestoq = "<font color=#b23c04>Não</font>"
	End If

	strTextoHtml = strTextoHtml & "<tr><td align=left valign=center  style='border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;' >"&_
			"<font face=""tahoma"" style=font-size:11px;color:000000>" & iz & ") <b>"& UCase(rs("nome"))& "</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Data: <b>" & rs("data") & "</b> &nbsp;&nbsp;&nbsp;Visível: <b>" & varestoq & "</b>"&_
			"<table width=""100%"" bgcolor=#eeeeee  border=0 style='border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;' cellspacing=1>"
					
			Set Rs3 = conexao.Execute("SELECT A.idcategoria, B.nome, A.data, A.nome as Nm, A.descr, A.ver FROM CATEGORIA AS A, sessoes as B WHERE B.id = A.idsessao AND B.id="& Rs("id") &" ORDER by A.nome")
			IF NOT RS3.EOF THEN
			izz = 1
			While Not rs3.EOF
			
				If rs("ver") = "s" Then
					varestoq = "<font color=#000000>Sim</font>"
				Else
					varestoq = "<font color=#b23c04>Não</font>"
				End If
				
				
		strTextoHtml = strTextoHtml & "<tr>"&_
									  "<td>"&_
										"<font face=""tahoma"" style=font-size:11px;color:000000>"& iz&"."&izz & ") <b>"& UCase(rs3("nm")) &"</font></td>"&_
										"<td><font face=""tahoma"" style=font-size:11px;color:000000>Data: <b>" & rs3("data") & "</b> &nbsp;&nbsp;&nbsp;Visível: <b>" & varestoq & "</b></font>"&_ 
										"</td>"&_
										"<td>"&_
										"<font face=""tahoma"" style=font-size:11px;color:000000>Ação: <b><a href=?link=sdep&acao=ver&dep="&rs3("idcategoria")&"&modo=exclui>Ver</a></b> | <b><a href=""javascript: dep("&rs3("idcategoria")&");"">Excluir</a></b></font>"&_
										"</td>"&_
										"</tr>"&_
						rs3.movenext
					izz = izz + 1
					Wend
				END IF

	strTextoHtml = strTextoHtml & "</table></td></tr>"

	rs.movenext
	Wend

	strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
	strTextoHtml = strTextoHtml & "</tr></table></td></tr></table> </td></tr></table>"

	rs.Close
	Set rs = Nothing
	End If

Case "exclui"
	notz = Request.QueryString("dep")
	
response.buffer= true
'###############################################
'## CORRIGE BUG DE EXCLUIR
'###############################################
	IF request.querystring("Status") = "Redir" THEN
		Response.write "<meta http-equiv='refresh'content='0;URL=?link=sdep&acao=excluir&status=sucesso'>"
	END IF
	'###############################################
	'## CORRIGE BUG DE EXCLUIR
	'## EXCLUI DADOS DA TABELA ESTOQUE TB
	'###############################################
	conexao.Execute("delete from categoria where idcategoria=" & notz & ";")
	strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px><b>APAGANDO SUB-CATEGORIA E SEUS DEVIDOS PRODUTOS....<br>por favor aguarde!</b></font>"
	conexao.Execute("delete from produtos where idsessao='" & notz & "';")
	'###############################################
		Response.write "<meta http-equiv='refresh' content='3;URL=?link=sdep&acao=excluir&status=Redir'>"
	'###############################################
	conexao.Execute("delete from categoria where idcategoria=" & notz & ";")
	conexao.Execute("delete from produtos where idsessao='" & notz & "';")

	'###############################################
	'## CORRIGE BUG DE EXCLUIR
	'## EXCLUI DADOS DA TABELA ESTOQUE TB
	'###############################################
	response.flush
	response.clear
Case "ver"
	
	Set setdep = conexao.Execute("SELECT A.*, B.NOME AS SESSAO FROM CATEGORIA AS A, SESSOES AS B WHERE A.IDSESSAO = B.ID AND idcategoria="&Request("dep") & ";")

	nome = setdep("nome")
	data = setdep("data")
	descri = setdep("descr")
	ver = setdep("ver")

	If Request("status") = "sucesso" Then

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Sub-departamento editado com sucesso</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
	strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=sdep&acao=edita&dep=" & Request("dep") & "&acaba=sim"">Editar novamente este Sub-departamento</a></b> |<b><A href=""?link=sdep&acao=editar&acaba=sim""> Ver novamente todos os Sub-departamentos</a></b></center>"

	Else

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Ver Sub-departamento cadastrado na loja</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"

	If Request("modo") = "exclui" Then

	strTextoHtml = strTextoHtml & "<script language=""javascript"">" & vbNewLine
	strTextoHtml = strTextoHtml & "function dep" & Request("dep") & "(){" & vbNewLine
	strTextoHtml = strTextoHtml & "if (confirm('Você realmente deseja excluir este Sub-departamento e seus respectivos produtos?'))" & vbNewLine
	strTextoHtml = strTextoHtml & "{" & vbNewLine
	strTextoHtml = strTextoHtml & "window.location.href('?link=sdep&acao=exclui&dep=" & Request("dep") & "');" & vbNewLine
	strTextoHtml = strTextoHtml & "}" & vbNewLine
	strTextoHtml = strTextoHtml & "else" & vbNewLine
	strTextoHtml = strTextoHtml & "{" & vbNewLine
	strTextoHtml = strTextoHtml & "}}" & vbNewLine
	strTextoHtml = strTextoHtml & "</script>" & vbNewLine

	strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><a href=""vbscript: dep" & Request("dep") & "()"">Excluir este Sub-departamento</a></b> |<b><A href=""?link=sdep&acao=excluir&acaba=sim""> Ver todos os Sub-departamentos</a></b></center>"

	Else

	strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=sdep&acao=edita&dep=" & Request("dep") & "&acaba=sim"">Editar este Sub-departamento</a></b> |<b><A href=""?link=sdep&acao=editar&acaba=sim""> Ver todos os Sub-departamentos</a></b></center>"

	End If
	End If

	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc><br>"
	strTextoHtml = strTextoHtml & "<table align=center width=""90%"">"
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dataz & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Sub-departamento:</b></td><td><FONT face=tahoma  style=font-size:11px>" & nome & "</td></tr>"
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
	Set depz = conexao.Execute("SELECT * FROM categoria WHERE idcategoria = " & Request("dep") & ";")

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Editar Sub-departamento na loja</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<form method=post action=""administrador.asp?link=sdep&acao=gravavelho"">"
	strTextoHtml = strTextoHtml & "<input name=""dep"" type=""hidden"" value=""" & Request("dep") & """>"
	strTextoHtml = strTextoHtml & "<table align=center width=""90%"">"

	varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"

	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & depz("data") & "</td></tr>"
	
	'--------------------------------------------------------------------------------------------
	'##### DEPARTAMENTOS (LISTAGEM)
	'--------------------------------------------------------------------------------------------

	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Departamento:</b></td><td>"
	SQL = "SELECT * FROM sessoes ORDER BY nome ASC"
	Set Rs = conexao.Execute(SQL)
	If not Rs.eof then
	strTextoHtml = strTextoHtml & "<select name='sessao' size='1'>"&VBcrlf
	Do while not Rs.eof
	
		If CInt( depz("idsessao")) = Rs("id") then
		strTextoHtml = strTextoHtml & "<option value="&Rs("id")&" selected>"&Rs("nome")&"</option>"&VBcrlf
		Else
		strTextoHtml = strTextoHtml & "<option value="&Rs("id")&">"&Rs("nome")&"</option>"&VBcrlf
		End IF
	Rs.MoveNext
	Loop
	strTextoHtml = strTextoHtml & "</select></td></tr>"&VBcrlf
	End if	
	
	
	strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Sub-departamento:</b></td><td><input name=""nomedep"" type=""text"" value=""" & depz("nome") & """ size=50  style=font-size:11px;font-family:tahoma>"

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
	strTextoHtml = strTextoHtml & "<tr><td align=center></td><td align=center>&nbsp;&nbsp;&nbsp;&nbsp;<input type=""submit"" NAME=""Enter"" style=font-size:11px;font-family:tahoma value=""Editar Sub-departamento""> <input type=""reset"" value=""Limpar formulario"" style=font-size:11px;font-family:tahoma></td></table><br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"

Case "gravavelho"
	nome = Trim(Request("nomedep"))
	descri = Trim(Request("descri"))
	ver = Trim(Request("ver"))
	sessao = Request("sessao")
	If nome = "" Then
	If nome = "" Then erro1 = "sim" Else erro1 = nome
	erro3 = descri
	If ver = "" Then erro2 = "sim" Else erro2 = ver
	Response.Redirect "?link=sdep&acao=edita2&erro1=" & erro1 & "&erro2=" & erro2 & "&erro3=" & erro3 & "&dep=" & Request("dep")
	End If

	If descri = "" Then
	descri = "-"
	End If

	textosql = "UPDATE categoria SET nome = '" & nome & "',  descr = '" & descri & "', ver = '" & ver & "', idsessao="&sessao&" WHERE idcategoria = " & Request("dep") & ";"
	Set gravadep = conexao.Execute(textosql)

	Response.Redirect "?link=sdep&acao=ver&status=sucesso&dep=" & Request("dep")

Case "edita2"

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Editar Sub-departamento na loja</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<form method=post action=""administrador.asp?link=sdep&acao=gravavelho"">"
	strTextoHtml = strTextoHtml & "<input name=""dep"" type=""hidden"" value=""" & Request("dep") & """>"
	strTextoHtml = strTextoHtml & "<table align=center width=""90%"">"

	varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"

	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dia & "/" & mez & "/" & Year(Date) & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Sub-departamento:</b></td><td><input name=""nomedep"" type=""text"" value="""

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
	strTextoHtml = strTextoHtml & "<tr><td align=center></td><td align=center>&nbsp;&nbsp;&nbsp;&nbsp;<input type=""submit"" NAME=""Enter"" style=font-size:11px;font-family:tahoma value=""Editar Sub-departamento""> <input type=""reset"" value=""Limpar formulario"" style=font-size:11px;font-family:tahoma></td></table><br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"


End Select

'End Sub
%>