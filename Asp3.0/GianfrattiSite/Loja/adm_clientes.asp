<!--#include file="adm_restrito.asp"-->
<%

'##### CLIENTES

'Sub ClientesASP()
If Request("acaba") = "sim" Then
Session("adm_descprod") = ""
Session("adm_email") = ""
End If

Select Case strAcao
Case "ver"

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/cli_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Administrar clientes cadastrados na loja</B></FONT><hr size=1 color=#cccccc>"

	finalera = Request.QueryString("final")
	pag = Request.QueryString("itens")
	pesss = Trim(Request.QueryString("pesq"))
	pagdxx = Request.QueryString("pagina")
	pesqsa = Request.QueryString("pesqsa")
	catege = Request("cat")

	if pesss = "" Then
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
	ElseIf catege = "todos" Or catege = "xxx" Or catege = "" Then
		resto = ""
	Else
		resto = "idsessao = '" & catege & "' and"
	End If

	palavraz = Split(Trim(pesqsa), " ")
	if VersaoDb = 1 then
		  restinho = "WHERE nome LIKE  '%" & Cripto(palavraz(0),true) & "%'"
	else
		  restinho = "WHERE nome LIKE  '%" & Cripto(palavraz(0),true) & "%'"
	end if


	Set rs = conexao.Execute("SELECT * FROM clientes " & restinho & " ORDER by nome asc")

	If rs.EOF Or rs.bof Then

		strTextoHtml = strTextoHtml & "<table><tr><td align=left valign=top><table border=0 cellspacing=4 cellpadding=4 width=100><tr><td>"
		strTextoHtml = strTextoHtml & "<font face=tahoma style=font-size:11px;color:000000>Cliente(s) encontrado(s): <b>0" & totalreg & "</b> <hr size=1 color=#dddddd width=""100%"">"
		strTextoHtml = strTextoHtml & "<table cellspacing=3 cellpadding=3 align=center width=""100%"">"
		strTextoHtml = strTextoHtml & "<tr><form action=? method=get><input name=link type=hidden value=clientes><input name=acao type=hidden value=ver>"
		strTextoHtml = strTextoHtml & "<td align=center><font face=""tahoma"" style=font-size:11px;color:000000><center>Para uma busca mais detalhada dos clientes cadastrados na loja realize uma pesquisa com o nome e/ou palavra-chave do cliente  que você procura.</td><tr><td align=center>"
		strTextoHtml = strTextoHtml & "<input name=""pesqsa"" type=""text"" size=30 value=""" & Request("pesqsa") & """ style=font-size:11px;color:000000;font-family:tahoma><font style=font-size:11px></font> <input type=submit class=""ok"" value=""Pesquisar"" style=font-size:11px;color:000000;font-family:tahoma>"
		strTextoHtml = strTextoHtml & "</td></form></tr><tr><td height=1 bgcolor=cccccc></td></tr></table><br><br>"
		strTextoHtml = strTextoHtml & "<table width=565 align=center>"
		strTextoHtml = strTextoHtml & "<tr><td align=center><br><br><b><font style=font-size:11px>Nenhum cliente foi encontrado na base de dados da loja.<br><br></b><br><br></td></tr></table>"
		strTextoHtml = strTextoHtml & "<br></table>"
		strTextoHtml = strTextoHtml & "<table width=100% cellspacing=""0"" cellpadding=""0""><tr><td colspan=2>"
		strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc width=""101%""></td></tr>"
		strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><font face=""tahoma"" style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
		strTextoHtml = strTextoHtml & "</tr></table><td></tr></table>"

	Else
		Set rs2 = conexao.Execute("SELECT count(nome) AS total FROM clientes " & restinho & ";")
		totalreg = rs2("total")
		rs2.Close
		Set rs2 = Nothing
		numiz = Request("pagina") & "0"
		numiz = CInt(numiz)
		iz = iz + numiz

		strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=100><tr><td>"
		strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Cliente(s) encontrado(s): <b>" & totalreg & "</b> <hr size=1 color=#dddddd width=""100%"">"
		strTextoHtml = strTextoHtml & "<table cellspacing=""3"" cellpadding=""3"" align=center width=""100%"">"
		strTextoHtml = strTextoHtml & "<tr><form action=""?"" method=get><input name=""link"" type=""hidden"" value=""clientes""><input name=""acao"" type=""hidden"" value=""ver"">"
		strTextoHtml = strTextoHtml & "<td align=center><font face=""tahoma"" style=font-size:11px;color:000000><center>Para uma busca mais detalhada dos clientes cadastrados na loja realize uma pesquisa com o nome e/ou palavra-chave do cliente  que você procura.</td><tr><td align=center>"
		strTextoHtml = strTextoHtml & "<input name=""pesqsa"" type=""text"" size=30 value=""" & Request("pesqsa") & """ style=font-size:11px;color:000000;font-family:tahoma><font style=font-size:11px></font> <input type=submit class=""ok"" value=""Pesquisar"" style=font-size:11px;color:000000;font-family:tahoma>"
		strTextoHtml = strTextoHtml & "<br><br></td></form></tr><tr><td height=1 bgcolor=cccccc></td></tr></table>"

		If Request("status") = "sucesso" Then
			strTextoHtml = strTextoHtml & "<br><center><b><font style=font-size:11px;font-family:tahoma;color:#003366>CLIENTE EXCLUÍDO COM SUCESSO!<br><br></font></b></center>"
		Else
			strTextoHtml = strTextoHtml & "<br>"
		End If

	strTextoHtml = strTextoHtml & "<table width=""565"" align=center>"

	While Not rs.EOF
		iz = iz + 1
		varestoq = "<font color=#b23c04>" & Cripto(rs("email"), False) & "</font>" & vbNewLine

		strTextoHtml = strTextoHtml & "<script language=""javascript"">" & vbNewLine
		strTextoHtml = strTextoHtml & "function cli" & rs("clienteid") & "(){" & vbNewLine
		strTextoHtml = strTextoHtml & "if (confirm('Você realmente deseja excluir este cliente?'))" & vbNewLine
		strTextoHtml = strTextoHtml & "{" & vbNewLine
		strTextoHtml = strTextoHtml & "window.location.href('?link=clientes&cli=" & rs("clienteid") & "&acao=exclui');" & vbNewLine
		strTextoHtml = strTextoHtml & "}" & vbNewLine
		strTextoHtml = strTextoHtml & "else" & vbNewLine
		strTextoHtml = strTextoHtml & "{" & vbNewLine
		strTextoHtml = strTextoHtml & "}}" & vbNewLine
		strTextoHtml = strTextoHtml & "</script>" & vbNewLine

		strTextoHtml = strTextoHtml & "<tr><td align=left valign=center>"
		strTextoHtml = strTextoHtml & "<table width=""100%"" bgcolor=#eeeeee style=""border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;""><tr><td valign=center><font face=""tahoma"" style=font-size:11px;color:000000>" & iz & ") <b>" & UCASE(Cripto(rs("nome"),False)) & "</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Data do cadastro: <b>" & rs("datacad") & "</b> &nbsp;&nbsp;&nbsp;E-mail: <b>" & varestoq & "</b></td><td align=right valign=center><font face=""tahoma"" style=font-size:11px;color:000000>Ação: <b><a href=?link=clientes&acao=olhar&cli=" & rs("clienteid") & ">Ver</a></b> | <b><a href=""javascript: cli" & rs("clienteid") & "();"">Excluir</a></b>&nbsp;</td></tr></table> <table><tr><td height=4></td></tr></table>"

		rs.movenext
		Wend

		strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=tahoma style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
		strTextoHtml = strTextoHtml & "</tr></table></td></tr></table></table>"

		rs.Close
		Set rs = Nothing
	End If

Case "exclui"
	notz = Request.QueryString("cli")
	Set dados = conexao.Execute("delete from clientes where clienteid = " & notz & ";")
	Response.Redirect "?link=clientes&acao=ver&status=sucesso"

Case "olhar"
	if VersaoDb = 1 then
	  Set dados = conexao.Execute("SELECT clienteid, datacad AS data, nome, email, senha, nascimento, cpf, rg, endereco, bairro, cidade, estado, cep, pais, tel , contato FROM clientes WHERE clienteid='" & Request("cli") & "';")
	else
	  Set dados = conexao.Execute("SELECT clientes.*, clientes.datacad AS data FROM clientes WHERE clienteid=" & Request("cli"))
	end if

	If dados.EOF Or dados.EOF Then
		Conn.Close
		Set Conn = Nothing
		Response.Redirect "administrador.asp"
	Else
		strNome = Cripto(dados("nome"), False)
		strEmail = Cripto(dados("email"),False)
		strNasc = Cripto(dados("nascimento"),False)
		strCpf = Cripto(dados("cpf"),False)
		strRg = Cripto(dados("rg"),False)
		strEndereco = Cripto(dados("endereco"),False)
		strBairro = Cripto(dados("bairro"),False)
		strCidade = Cripto(dados("cidade"),False)
		strEstado = Cripto(dados("estado"),False)
		strCep = Cripto(dados("cep"),False)
		strData = dados("data")
		strPais = Cripto(dados("pais"),False)
		strClienteid = dados("email")
		strFone = Cripto(dados("tel"),False)
		strContato = Cripto(dados("contato"), False)
		
		strSenha = Cripto(dados("senha"),False)
		
		numero = InStr(1, strNasc, "/")
		dia = Left(strNasc, numero)
		s = ""
		
	For x = 1 To Len(dia)
		ch = Mid(dia, x, 1)
		If Asc(ch) >= 48 And Asc(ch) <= 57 Then
			s = s & ch
		End If
	Next

	dia = s
	Mes = Mid(strNasc, 4, 2)
	
	SELECT CASE Mes
		   CASE "01"
			Mes = "janeiro"
		   CASE "02"
			Mes = "fevereiro"
		   CASE "03"
			Mes = "março"
		   CASE "04"
			Mes = "abril"
		   CASE "05"
			Mes = "maio"
		   CASE "06"
			Mes = "junho"
		   CASE "07"
			Mes = "julho"
		   CASE "08"
			Mes = "agosto"
		   CASE "09"
			Mes = "setembro"
		   CASE "10"
			Mes = "outubro"
		   CASE "11"
			Mes = "novembro"
		   CASE "12"
			Mes = "dezembro"
	End SELECT
	Ano = Right(strNasc, 4)

	Select Case strEstado
	Case "AC"
	estadoz = "Acre"
	Case "AL"
	estadoz = "Alagoas"
	Case "AP"
	estadoz = "Amapá"
	Case "AM"
	estadoz = "Amazonas"
	Case "BA"
	estadoz = "Bahia"
	Case "CE"
	estadoz = "Ceará"
	Case "DF"
	estadoz = "Distrito Federal"
	Case "ES"
	estadoz = "Espirito Santo"
	Case "GO"
	estadoz = "Goiás"
	Case "MA"
	estadoz = "Maranhão"
	Case "MT"
	estadoz = "Mato Grosso"
	Case "MS"
	estadoz = "Mato Grosso do Sul"
	Case "MG"
	estadoz = "Minas Gerais"
	Case "PA"
	estadoz = "Pará"
	Case "PB"
	estadoz = "Paraiba"
	Case "PR"
	estadoz = "Parana"
	Case "PE"
	estadoz = "Pernambuco"
	Case "PI"
	estadoz = "Piauí"
	Case "RJ"
	estadoz = "Rio de Janeiro"
	Case "RN"
	estadoz = "Rio Grande do Norte"
	Case "RS"
	estadoz = "Rio Grande do Sul"
	Case "RO"
	estadoz = "Rondônia"
	Case "RR"
	estadoz = "Roraima"
	Case "SC"
	estadoz = "Santa Catarina"
	Case "SP"
	estadoz = "São Paulo"
	Case "SE"
	estadoz = "Sergipe"
	Case "TO"
	estadoz = "Tocantins"
	End Select

	Set rs = conexao.Execute("select * from compras where clienteid='" & strClienteid & "';")

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/cli_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Ver cliente cadastrado na loja</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
	strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=clientes&acao=ver&acaba=sim"">Voltar e ver mais clientes</a></b></center>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc>"
	strTextoHtml = strTextoHtml & "<table width=""100%"">"
	strTextoHtml = strTextoHtml & "<tr><td colspan=2><font style=font-family:tahoma;font-size:11px;color:#000000;><br><b>Dados do Cliente</font><hr size=1 color=000000></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td><font style=font-family:tahoma;font-size:11px;color:#000000;>Data do cadastro:</font></td><td><font style=font-family:tahoma;font-size:11px;color:#000000><b>" & strData & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td bgcolor=#eeeeee><font style=font-family:tahoma;font-size:11px;color:#000000;>Nome / Razão Social:</font></td><td bgcolor=#eeeeee><font style=font-family:tahoma;font-size:11px;color:#000000><b>" & strNome & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td><font style=font-family:tahoma;font-size:11px;color:#000000;>E-mail:</td><td><font style=font-family:tahoma;font-size:11px;color:#000000;><b>" & strEmail & "</b></font></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td bgcolor=#eeeeee><font style=font-family:tahoma;font-size:11px;color:#000000;>Senha:</td><td bgcolor=#eeeeee><font style=font-family:tahoma;font-size:11px;color:#000000;><b>" & strSenha  & "</b></font></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td ><font style=font-family:tahoma;font-size:11px;color:#000000;>Nascimento:</font></td><td ><font style=""font-family:tahoma;font-size:11px;color:#000000;""><b>" & dia & " de " & Mes & " de " & Ano & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td bgcolor=#eeeeee><font style=font-family:tahoma;font-size:11px;color:#000000;>CPF / CNPJ:</font></td><td bgcolor=#eeeeee><font style=font-family:tahoma;font-size:11px;color:#000000;><b>" & strCpf & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td ><font style=font-family:tahoma;font-size:11px;color:#000000;>RG / IE:</font></td><td ><font style=font-family:tahoma;font-size:11px;color:#000000;><b>" & strRg & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td bgcolor=#eeeeee><font style=font-family:tahoma;font-size:11px;color:#000000;>Endereço:</font></td><td bgcolor=#eeeeee><font style=font-family:tahoma;font-size:11px;color:#000000;><b>" & strEndereco & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td ><font style=font-family:tahoma;font-size:11px;color:#000000;>Bairro:</font></td><td  ><font style=font-family:tahoma;font-size:11px;color:#000000;><b>" & strBairro & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td bgcolor=#eeeeee><font style=font-family:tahoma;font-size:11px;color:#000000;>Cidade:</font></td><td bgcolor=#eeeeee><font style=font-family:tahoma;font-size:11px;color:#000000;><b>" & strCidade & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td  ><font style=font-family:tahoma;font-size:11px;color:#000000;>Estado:</font></td><td  ><font style=font-family:tahoma;font-size:11px;color:#000000;><b>" & estadoz & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td bgcolor=#eeeeee><font style=font-family:tahoma;font-size:11px;color:#000000;>CEP:</font></td><td bgcolor=#eeeeee><font style=font-family:tahoma;font-size:11px;color:#000000;><b>" & strCep & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td><font style=font-family:tahoma;font-size:11px;color:#000000;>País:</td><td  ><font style=font-family:tahoma;font-size:11px;color:#000000;><b>" & strPais & "</td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td bgcolor=#eeeeee><font style=font-family:tahoma;font-size:11px;color:#000000;>Telefone:</font></td><td bgcolor=#eeeeee><font style=font-family:tahoma;font-size:11px;color:#000000;><b>" & strFone & "</font></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td><font style=font-family:tahoma;font-size:11px;color:#000000;>Nome do Contato:</font></td><td><font style=font-family:tahoma;font-size:11px;color:#000000;><b>" & strContato & "</font></td></tr>"

	strTextoHtml = strTextoHtml & "<tr><td colspan=2><font style=font-family:tahoma;font-size:11px;color:#000000;><br><b>Compras efetuadas</font><hr size=1 color=000000></td></tr>"

	Set rs2 = conexao.Execute("SELECT count(pedido) AS total FROM compras WHERE clienteid = '" & strClienteid & "';")

	totalreg = rs2("total")
	rs2.Close
	Set rs2 = Nothing
	numiz = Request("pagina") & "0"
	numiz = CInt(numiz) * 2
	iz = iz + numiz

	strTextoHtml = strTextoHtml & "<table border=""0"" cellspacing=""4"" cellpadding=""4"" width=""100%"">"
	strTextoHtml = strTextoHtml & "<tr><td><font face=""tahoma"" style=font-size:11px;color:000000>Compra(s) efetuada(s): <b>" & totalreg & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td>"

	If Request("status") = "sucesso" Then
	strTextoHtml = strTextoHtml & "<center><b><font style=font-size:11px;font-family:tahoma;color:#003366>COMPRA EXCLUÍDA COM SUCESSO!<br><br></font></b></center>"
	Else
	End If

	strTextoHtml = strTextoHtml & "<table width=""100%"" align=center>"
	While Not rs.EOF
	iz = iz + 1
	Select Case rs("estadoentrega")
	Case "AC"
	estadoz = "Acre"
	Case "AL"
	estadoz = "Alagoas"
	Case "AP"
	estadoz = "Amapá"
	Case "AM"
	estadoz = "Amazonas"
	Case "BA"
	estadoz = "Bahia"
	Case "CE"
	estadoz = "Ceará"
	Case "DF"
	estadoz = "Distrito Federal"
	Case "ES"
	estadoz = "Espirito Santo"
	Case "GO"
	estadoz = "Goiás"
	Case "MA"
	estadoz = "Maranhão"
	Case "MT"
	estadoz = "Mato Grosso"
	Case "MS"
	estadoz = "Mato Grosso do Sul"
	Case "MG"
	estadoz = "Minas Gerais"
	Case "PA"
	estadoz = "Pará"
	Case "PB"
	estadoz = "Paraiba"
	Case "PR"
	estadoz = "Parana"
	Case "PE"
	estadoz = "Pernambuco"
	Case "PI"
	estadoz = "Piauí"
	Case "RJ"
	estadoz = "Rio de Janeiro"
	Case "RN"
	estadoz = "Rio Grande do Norte"
	Case "RS"
	estadoz = "Rio Grande do Sul"
	Case "RO"
	estadoz = "Rondônia"
	Case "RR"
	estadoz = "Roraima"
	Case "SC"
	estadoz = "Santa Catarina"
	Case "SP"
	estadoz = "São Paulo"
	Case "SE"
	estadoz = "Sergipe"
	Case "TO"
	estadoz = "Tocantins"
	End Select

   Set rs3 = conexao.Execute("select nome, email from clientes where email='" & strClienteid & "'")
   on error resume next
	strTextoHtml = strTextoHtml & "<tr><td align=left valign=center>" & vbNewLine

	strTextoHtml = strTextoHtml & "<script language=""javascript"">" & vbNewLine
	strTextoHtml = strTextoHtml & "function compra" & rs("idcompra") & "(){" & vbNewLine
	strTextoHtml = strTextoHtml & "if (confirm('Você realmente deseja excluir esta compra?'))" & vbNewLine
	strTextoHtml = strTextoHtml & "{" & vbNewLine
	strTextoHtml = strTextoHtml & "window.location.href('?link=clientes&acao=excluirc&compra=" & rs("idcompra") & "&cli=" & dados("clienteid") & "');" & vbNewLine
	strTextoHtml = strTextoHtml & "}" & vbNewLine
	strTextoHtml = strTextoHtml & "else" & vbNewLine
	strTextoHtml = strTextoHtml & "{" & vbNewLine
	strTextoHtml = strTextoHtml & "}}" & vbNewLine
	strTextoHtml = strTextoHtml & "</script>" & vbNewLine

	strTextoHtml = strTextoHtml & "<table width=""100%"" bgcolor=#eeeeee style=""border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;""><tr><td valign=center><font face=""tahoma"" style=font-size:11px;color:000000>" & iz & ") Compra feita por: <b>" & UCase(Cripto(rs3("nome"),false)) & "</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Frete para: <b>" & estadoz & "</b> &nbsp;&nbsp;&nbsp;Total da compra: <font color=#b23c04><b>R$ " & FormatNumber(-1 + Cripto(rs("totalcompra"),false) + Cripto(rs("frete"),false) + 1, 2) & "</b></font></td><td align=right valign=center><font face=tahoma style=font-size:11px;color:000000>Ação: <b><a href=?link=clientes&acao=verc&compra=" & rs("idcompra") & ">Ver</a></b> | <b><a href=""javascript: compra" & rs("idcompra") & "();"">Excluir</a></b>&nbsp;</td></tr></table> <table><tr><td height=4></td></tr></table>"

	rs.movenext
	pagn = inicial + 20
	Wend
	paga = pagn - 40

	strTextoHtml = strTextoHtml & "</td></tr></table></table>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=#cccccc width=""100%""><font face=tahoma style=font-size:11px><b><center><br><a HREF=?>Voltar para Página Inicial</a></b></font></center>"
	End If

	Case "verc"

	Set rs = conexao.Execute("select * from compras where idcompra=" & Request("compra") & ";")
	Set rs3 = conexao.Execute("select * from clientes where email='" & rs("clienteid") & "'")

	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/cli_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Ver detalhes da compra</B></FONT><hr size=1 color=#cccccc>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
	strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=clientes&acao=olhar&acaba=sim&cli=" & rs3("clienteid") & """>Voltar e ver detalhes do cliente " & Cripto(rs3("nome"),false) & "</a></b></center>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
	strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc>"
	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#000000 style=font-size:11px>Compra efetuada pelo cliente: <b>" & UCase(Cripto(rs3("nome"),false)) & "</b><br>"
	strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#000000 style=font-size:11px>Pedido n<sup>o</sup> : <b>#" & rs("pedido") & "</b><br>"
	strTextoHtml = strTextoHtml & "<br>"

	Select Case rs("estadoentrega")
	Case "AC"
	estadoz = "Acre"
	Case "AL"
	estadoz = "Alagoas"
	Case "AP"
	estadoz = "Amapá"
	Case "AM"
	estadoz = "Amazonas"
	Case "BA"
	estadoz = "Bahia"
	Case "CE"
	estadoz = "Ceará"
	Case "DF"
	estadoz = "Distrito Federal"
	Case "ES"
	estadoz = "Espirito Santo"
	Case "GO"
	estadoz = "Goiás"
	Case "MA"
	estadoz = "Maranhão"
	Case "MT"
	estadoz = "Mato Grosso"
	Case "MS"
	estadoz = "Mato Grosso do Sul"
	Case "MG"
	estadoz = "Minas Gerais"
	Case "PA"
	estadoz = "Pará"
	Case "PB"
	estadoz = "Paraiba"
	Case "PR"
	estadoz = "Parana"
	Case "PE"
	estadoz = "Pernambuco"
	Case "PI"
	estadoz = "Piauí"
	Case "RJ"
	estadoz = "Rio de Janeiro"
	Case "RN"
	estadoz = "Rio Grande do Norte"
	Case "RS"
	estadoz = "Rio Grande do Sul"
	Case "RO"
	estadoz = "Rondônia"
	Case "RR"
	estadoz = "Roraima"
	Case "SC"
	estadoz = "Santa Catarina"
	Case "SP"
	estadoz = "São Paulo"
	Case "SE"
	estadoz = "Sergipe"
	Case "TO"
	estadoz = "Tocantins"
	End Select

	If rs("status") = "0" Then
	estatuzz = "Aguardando confirmação de pagamento"
	End If
	If rs("status") = "1" Then
	estatuzz = "Pagamento confirmado e Processar Compra"
	End If
	If rs("status") = "2" Then
	estatuzz = "Compra já enviada ao cliente"
	End If
	If rs("status") = "3" Then
	estatuzz = "Compra Já Entregue"
	End If
	If rs("status") = "4" Then
	estatuzz = "Compra Cancelada"
	End If
	If rs("status") = "5" Then
	estatuzz = "Compra Negada"
	End If
	If rs("status") = "6" Then
	estatuzz = "Outras - Contate o Atendimento"
	End If

	strTextoHtml = strTextoHtml & "<b>STAUS DA COMPRA EFETUADA:</b><hr size=1 color=000000>"
	strTextoHtml = strTextoHtml & "<table width=""100%""><tr><td valign=top><font face=tahoma style=font-size:11px;color:000000>Status da compra:</td><td align=right><font face=tahoma style=font-size:11px;color:000000><form action=""?"" method=get><input name=""link"" type=""hidden"" value=""compras""><input name=""acao"" type=""hidden"" value=""modificar""><input name=""compra"" type=""hidden"" value=""" & Request("compra") & """><input name=""dia"" type=""hidden"" value=""" & Request("dia") & """><input name=""data"" type=""hidden"" value=""" & Request("data") & """><input name=""mes"" type=""hidden"" value=""" & Request("mes") & """><input name=""ano"" type=""hidden"" value=""" & Request("ano") & """><font style=font-size:11px;color:b23c04;font-family:tahoma><strong>" & estatuzz & "</strong><br><br><a href=""?link=compras&acao=olhar&compra=" & Request("compra") & """><u>Clique aqui para mudar o Status acima</u></a></font></td></tr></table>"
	strTextoHtml = strTextoHtml & "<br><b>DADOS PARA ENTREGA DO PEDIDO:</b><hr size=1 color=000000>"
	strTextoHtml = strTextoHtml & "<table width=""100%"">"
	strTextoHtml = strTextoHtml & "<tr><td bgcolor=#eeeeee><FONT face=tahoma color=#000000 style=font-size:11px>Data da compra: </b></td><td  bgcolor=#eeeeee> <FONT face=tahoma color=#b23c04 style=font-size:11px><b>" & rs("datacompra") & "</b></td></tr>"

	estimativa = CDate(rs("datacompra")) + 10
	If Mid(estimativa, 2, 1) = "/" Then
	estimativa = "0" & estimativa
	Else
	estimativa = estimativa
	End If
	If Mid(estimativa, 5, 1) = "/" Then
	estimativa = Mid(estimativa, 1, 3) & "0" & Mid(estimativa, 4, 99)
	Else
	estimativa = estimativa
	End If

	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma color=#000000 style=font-size:11px>Estimativa para entrega: </b></td><td> <FONT face=tahoma color=#b23c04 style=font-size:11px><b>" & estimativa & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td bgcolor=#eeeeee><FONT face=tahoma color=#000000 style=font-size:11px>Endereço:</b></td><td bgcolor=#eeeeee> <FONT face=tahoma color=#b23c04 style=font-size:11px><b>" & Cripto(rs("endentrega"),false) & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma color=#000000 style=font-size:11px>Bairro:</b></td><td> <FONT face=tahoma color=#b23c04 style=font-size:11px><b>" & Cripto(rs("bairroentrega"),false) & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td bgcolor=#eeeeee><FONT face=tahoma color=#000000 style=font-size:11px>Cidade:</b></td><td bgcolor=#eeeeee> <FONT face=tahoma color=#b23c04 style=font-size:11px><b>" & Cripto(rs("cidadeentrega"),false) & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma color=#000000 style=font-size:11px>Estado: </b></td><td> <FONT face=tahoma color=#b23c04 style=font-size:11px><b>" & estadoz & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td bgcolor=#eeeeee><FONT face=tahoma color=#000000 style=font-size:11px>País: </b></td><td bgcolor=#eeeeee> <FONT face=tahoma color=#b23c04 style=font-size:11px><b>Brasil</b></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma color=#000000 style=font-size:11px>CEP: </b></td><td> <FONT face=tahoma color=#b23c04 style=font-size:11px><b>" & Cripto(rs("cepentrega"),false) & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td bgcolor=#eeeeee><FONT face=tahoma color=#000000 style=font-size:11px>Telefone: </b></td><td bgcolor=#eeeeee> <FONT face=tahoma color=#b23c04 style=font-size:11px><b>" & Cripto(rs("telentrega"),false) & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "</table><br>"
	strTextoHtml = strTextoHtml & "<b>DADOS DA COMPRA E PAGAMENTO:</b><hr size=1 color=000000>"
	strTextoHtml = strTextoHtml & "<table width=""100%"">"
	strTextoHtml = strTextoHtml & "</form><tr><td bgcolor=003366><font face=tahoma style=font-size:11px;color:ffffff>&nbsp;Cód.</b></td>"
	strTextoHtml = strTextoHtml & "<td bgcolor=003366><font face=tahoma style=font-size:11px;color:ffffff>&nbsp;Produto</b></td>"
	strTextoHtml = strTextoHtml & "<td bgcolor=003366><font face=tahoma style=font-size:11px;color:ffffff>&nbsp;Quant.</b></td>"
	strTextoHtml = strTextoHtml & "<td bgcolor=003366><font face=tahoma style=font-size:11px;color:ffffff>&nbsp;Valor Unit.</b></td>"
	strTextoHtml = strTextoHtml & "<td bgcolor=003366><font face=tahoma style=font-size:11px;color:ffffff>&nbsp;Valor Total</b></td>"
	strTextoHtml = strTextoHtml & "</tr>"

	Set rs10 = conexao.execute("SELECT * FROM pedidos WHERE idcompra = '" & Request("compra") & "';")
	If rs10.EOF Then
	Else
	While Not rs10.EOF

	Set prod = conexao.Execute("select * from produtos where idprod = " & rs10("idprod") & ";")
	If prod.bof Or prod.EOF Then
	strTextoHtml = strTextoHtml & "<tr><td align=center><font face=tahoma style=font-size:11px;color:000000>#</td><td colspan=4><font face=tahoma style=font-size:11px;color:000000>O produto comprado não estão mais presente na loja</b></center>"
	Else
	codigo = prod("idprod")
	prodnome = prod("nome")
	preconormal = prod("preco")
	quantidade = rs10("quantidade")
	subpreco = FormatNumber(preconormal, 2)
	totpreco = FormatNumber((quantidade * preconormal), 2)

	strTextoHtml = strTextoHtml & "<tr><td align=center><font face=tahoma style=font-size:11px;color:000000>" & codigo & "</td>"
	strTextoHtml = strTextoHtml & "<td><a href=""produtos.asp?produto="&codigo&""" target=""_blank""><font face=tahoma style=font-size:11px;color:000000><u>" & prodnome & "</u></a></td>"
	strTextoHtml = strTextoHtml & "<td align=center><font face=tahoma style=font-size:11px;color:000000>" & quantidade & "</td>"
	strTextoHtml = strTextoHtml & "<td align=right><font face=tahoma style=font-size:11px;color:000000>R$ " & subpreco & "</td>"
	strTextoHtml = strTextoHtml & "<td align=right><font face=tahoma style=font-size:11px;color:000000>R$ " & totpreco & "</td></tr>"
	End If
	rs10.movenext
	Wend
	rs10.Close
	End If

	totalcompra = Cripto(rs("totalcompra"),false)
	totalfrete = Cripto(rs("frete"),false)
	Status = rs("status")
	pagamento = rs("pagamentovia")
	intcomprasz = totalcompra + 1 + totalfrete - 1
	comprasz = intcomprasz
	comprasz = Replace(comprasz, "-", "")
	data = rs("datacompra")
	Select Case pagamento
	Case "0"
	ver = "Cartão de Crédito - Visa"
	Case "1"
	ver = "Cartão de Crédito - Mastercard"
	Case "2"
	ver = "Cartão de Crédito - Dinners"
	Case "3"
	ver = "Cartão de Crédito - American Express"
	Case "4"
	ver = "SEDEX à cobrar"
	Case "5"
	ver = "Depósito Bancário"
	Case "6"
    ver = "Transferência Eletrônica"
    Case "7"
    ver = "Boleto Bancário"
	
	End Select
	If Status = "0" Then
	estatus = "Aguardando confirmação de pagamento"
	If pagamento = "0" or pagamento = "1" or pagamento = "2" or pagamento = "3" or pagamento = "4" Then
	ver2 = "Aguardando confirmação com a operadora do cartão de credito"
	Else
	ver2 = "Aguardando confirmação de pagamento"
	End If
	End If
	If Status = "1" Then
	estatus = "Pagamento confirmado e Compra em processamento"
	If pagamento = "0" or pagamento = "1" or pagamento = "2" or pagamento = "3" or pagamento = "4" Then
	ver2 = "Pagamento confirmado com a operadora do cartão de credito, com envio de email informando ao cliente"
	Else
	ver2 = "Pagamento confirmado, com envio de email informando ao cliente"
	End If
	End If
	If Status = "2" Then
	estatus = "Compra já enviada ao cliente"
	ver2 = "Compra enviada, com envio de email informando ao cliente"
	End If
	If Status = "3" Then
	estatus = "Compra Já Entregue"
	ver2 = "Pagamento já efetuado"
	End If
	If Status = "4" Then
	estatus = "Compra Cancelada"
	ver2 = "Pagamento cancelado, com envio de email confirmando ao cliente"
	End If
	If Status = "5" Then
	estatus = "Compra Negada"
	ver2 = "Pagamento cancelado, com envio de email informando ao cliente"
	End If
	If Status = "6" Then
	estatus = "Outras - Contate o Atendimento"
	ver2 = "Pagamento ou Compra com problemas, com envio de email informando ao cliente para entrar em contato"
	End If
	comprazw = FormatNumber(comprasz, 2)
	totalfretezw = FormatNumber(totalfrete, 2)
	totalcomprazw = FormatNumber(totalcompra, 2)

	select case pagamento
	case 0,1,2,3
	   strInf = "<tr><td><font face=tahoma style=font-size:11px;color:000000>Número do Cartão</td><td align=right><font face=tahoma style=font-size:11px;color:000000><b>" & Cripto(rs("numero"),false) & "</b></td>"
	   strInf = strInf & "<tr><td><font face=tahoma style=font-size:11px;color:000000>Vencimento</td><td align=right><font face=tahoma style=font-size:11px;color:000000><b>" & Cripto(rs("codigo_seguranca"),false) & "</b></td>"
	   strInf = strInf & "<tr><td><font face=tahoma style=font-size:11px;color:000000>Vencimento</td><td align=right><font face=tahoma style=font-size:11px;color:000000><b>" & Cripto(rs("vencimento"),false) & "</b></td>"
	   strInf = strInf & "<tr><td><font face=tahoma style=font-size:11px;color:000000>Titular do Cartão</td><td align=right><font face=tahoma style=font-size:11px;color:000000><b>" & Cripto(rs("titular"),false) & "</b></td>"   
	case else
	   strInf = ""
	end select

	strTextoHtml = strTextoHtml & "</table><hr size=1 color=cccccc width=""100%""><table width=""100%""><tr><td><font face=tahoma style=font-size:11px;color:000000>Sub-total</td><td align=right><font face=tahoma style=font-size:11px;color:000000><b>R$ " & totalcomprazw & "</b></td>"
	strTextoHtml = strTextoHtml & "</tr></table><table width=""100%""><tr><td><font face=tahoma style=font-size:11px;color:000000>Frete</td>"
	strTextoHtml = strTextoHtml & "<td align=right><font face=tahoma style=font-size:11px;color:000000><b>R$ " & totalfretezw & "</b></td></tr>"
	strTextoHtml = strTextoHtml & "<tr><td><font face=tahoma style=font-size:11px;color:000000>Valor total da compra</td><td align=right><font face=tahoma style=font-size:11px;color:000000><b>R$ " & comprazw & "</b></td>"
	strTextoHtml = strTextoHtml & "</tr></table><hr size=1 color=cccccc width=""100%""><table width=""100%""><tr><td><font face=tahoma style=font-size:11px;color:000000>Forma de Pagamento</td><td align=right><font face=tahoma style=font-size:11px;color:b23c04><b>" & ver & "</b></td></tr>"
	select case pagamento
	case 0,1,2,3
	   strInf = "<tr><td><font face=tahoma style=font-size:11px;color:000000>Número do Cartão</td><td align=right><font face=tahoma style=font-size:11px;color:000000><b>" & Cripto(rs("numero"),false) & "</b></td>"
	   strInf = strInf & "<tr><td><font face=tahoma style=font-size:11px;color:000000>Código de Segurança</td><td align=right><font face=tahoma style=font-size:11px;color:000000><b>" & Cripto(rs("codigo_seguranca"),false) & "</b></td>"
	   strInf = strInf & "<tr><td><font face=tahoma style=font-size:11px;color:000000>Vencimento</td><td align=right><font face=tahoma style=font-size:11px;color:000000><b>" & Cripto(rs("vencimento"),false) & "</b></td>"
	   strInf = strInf & "<tr><td><font face=tahoma style=font-size:11px;color:000000>Titular do Cartão</td><td align=right><font face=tahoma style=font-size:11px;color:000000><b>" & Cripto(rs("titular"),false) & "</b></td>"   
	case else
	   strInf = ""
	end select
	strTextoHtml = strTextoHtml & strInf
	strTextoHtml = strTextoHtml & "<tr><td><font face=tahoma style=font-size:11px;color:000000>Status Visível p/ o Cliente</td><td align=right><font face=tahoma style=font-size:11px;color:b23c04><b>" & ver2 & "</b></td></tr></table>"
	strTextoHtml = strTextoHtml & "<center><br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br>"

	Case "excluirc"
	notz = Request.QueryString("compra")
	Set exc_compras = conexao.Execute("delete * from compras where idcompra=" & notz & ";")
	
	'Sem esta rotina, aparece "carrinhos-fantasmas" ...
	Set exc_pedidos = conexao.Execute("delete * from pedidos where idcompra='" & notz & "';")

	Response.Redirect "?link=clientes&acao=olhar&cli=" & Request("cli") & "&status=sucesso"
	End Select
'End Sub
%>