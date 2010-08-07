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
'###############################################################################################
'ARQUIVO EDITADO E POSTADO POR:
'ELIZEU ALCANTARA  E  HENRIQUE_METASUPRI E ANTONIO MOUALLEM
'###############################################################################################


'##### PRODUTOS

'Sub ProdutosASP()
If Request("acaba") = "sim" Then
Session("adm_email") = ""
Session("adm_descprod") = ""
End If

Select Case strAcao
Case "inserir"
			strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Incluir novo produto na loja</B></FONT><hr size=1 color=#cccccc>"
			strTextoHtml = strTextoHtml & "<form method=post ENCTYPE=""multipart/form-data"" action=""administrador.asp?link=produtos&acao=gravanovo"" name=frmprod>"
			strTextoHtml = strTextoHtml & "<table align=center width=""90%"">"
			varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dia & "/" & mez & "/" & Year(Date) & "</td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Nome do produto:</b></td><td><input name=""nomeprod"" type=""text"" value="""
			If Request.QueryString("erro1") <> "sim" Then
			strTextoHtml = strTextoHtml & Request.QueryString("erro1")
			End If
			strTextoHtml = strTextoHtml & """ size=75  style=font-size:11px;font-family:tahoma>"
			If Request.QueryString("erro1") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Categoria:</b></td><td><select name=""categ"" style=font-size:11px;font-family:tahoma>"
			'################################################################################
			'--------------------------------------------------------------------------------
			'################################################################################
			' Traz as categorias com as subcategorias
			'--------------------------------------------------------------------------------
			
			Set pesquisa = conexao.Execute("SELECT A.idcategoria, B.nome, A.data, A.nome as Nm, A.descr, A.ver FROM sessoes as B INNER JOIN CATEGORIA as A ON B.id = A.idsessao ORDER by B.nome ASC")
				While Not pesquisa.EOF
					strTextoHtml = strTextoHtml & "<option value=""" & pesquisa("idcategoria") & """"
						If CStr(pesquisa("idcategoria")) = CStr(Request.QueryString("erro10")) Then
							strTextoHtml = strTextoHtml & "selected"
						End If
				strTextoHtml = strTextoHtml & ">" & pesquisa("nome")&" > "&pesquisa("nm") & "</option>"
				pesquisa.movenext
				Wend
			pesquisa.Close
			Set pesquisa = Nothing
			
			
			strTextoHtml = strTextoHtml & "</select></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Peso:</b></td><td><FONT face=tahoma  style=font-size:11px><input name=""peso"" type=""text"" size=10 value="""
			If Request.QueryString("erro2") <> "sim" Then
			strTextoHtml = strTextoHtml & Request.QueryString("erro2")
			End If
			strTextoHtml = strTextoHtml & """ style=font-size:11px;font-family:tahoma>&nbsp;Kg &nbsp;&nbsp;&nbsp; <font color=""#003366"" style=font-size:10px>(Digite com virgula)</font> "
			If Request.QueryString("erro2") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"

			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Preço Normal:</b></td><td><FONT face=tahoma  style=font-size:11px>&nbsp;R$ <input name=""precv"" type=""text"" size=15 value="""
			If Request.QueryString("erro3") <> "sim" Then
			strTextoHtml = strTextoHtml & Request.QueryString("erro3")
			End If
			strTextoHtml = strTextoHtml & """ style=font-size:11px;font-family:tahoma>"
			If Request.QueryString("erro3") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Preço Promocional:</b></td><td><FONT face=tahoma  style=font-size:11px>&nbsp;R$ <input name=""precn"" type=""text"" size=15 value="""
			If Request.QueryString("erro4") <> "sim" Then
			strTextoHtml = strTextoHtml & Request.QueryString("erro4")
			End If
			strTextoHtml = strTextoHtml & """ style=font-size:11px;font-family:tahoma>"
			If Request.QueryString("erro4") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"
		
			strTextoHtml = strTextoHtml & "<input type=hidden name=""parc"" value=""v""><input type=hidden name=""juro"" value=""0""><input type=hidden name=""jurodia"" value=""mes"">"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Imagem grande:</b></td><td><FONT face=tahoma  style=font-size:11px><input name=""figurag"" type=""file"" size=15 style=font-size:11px;font-family:tahoma>"
			If Request.QueryString("erro8") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "<font color=""#003366"" style=font-size:10px>&nbsp;(tamanho ideal: lagura 185px, altura indiferente)</font></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Imagem pequena:</b></td><td><FONT face=tahoma  style=font-size:11px><input name=""figurap"" type=""file""  size=15 style=font-size:11px;font-family:tahoma>"
			If Request.QueryString("erro9") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "<font color=""#003366"" style=font-size:10px>&nbsp;(tamanho ideal: lagura 75px, altura indiferente)</font></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Fabricante:</b></td><td><input name=""fabri"" type=""text"" size=50 value="""
			If Request.QueryString("erro5") <> "sim" Then
			strTextoHtml = strTextoHtml & Request.QueryString("erro5")
			End If
			strTextoHtml = strTextoHtml & """ style=font-size:11px;font-family:tahoma>"
			If Request.QueryString("erro5") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"


'***  Adaptacao para usar o Htmlarea independente do servidor

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

			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Descrição:</b></td><td><textarea name=""descri"" rows=15 cols=75 style=font-size:11px;font-family:tahoma>" & Session("adm_descprod") & "</textarea>"
			strTextoHtml = strTextoHtml & "<br><FONT face=tahoma  style=font-size:10px color=""#003366"">Dica: Para fazer uma simples quebra de linha , digite Shift+Enter</font><br><br>"
			If Request.QueryString("erro6") = "sim" Then
			strTextoHtml = strTextoHtml & varimg & " &nbsp;&nbsp;&nbsp;<FONT face=tahoma  style=font-size:11px color=""#ff0000"">Digite uma descrição</font><br><br>"
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"

strTextoHtml = strTextoHtml & "<tr><td valign=""center"" colspan=2>"
strTextoHtml = strTextoHtml & "<script language=""javascript1.2"">"
strTextoHtml = strTextoHtml & "editor_generate('descri');"
strTextoHtml = strTextoHtml & "</script>"

			If Request.QueryString("erro6") = "sim" Then
			strTextoHtml = strTextoHtml & varimg & "&nbsp;&nbsp;&nbsp;<FONT face=tahoma  style=font-size:11px color=""#ff0000"">Digite uma descrição</font><br><br>"
			End If
strTextoHtml = strTextoHtml & "</td></tr>"

			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Mostrar na Loja? </b></td><td><select name=""estoq"" style=font-size:11px;font-family:tahoma><option value=""s"" "
			If CStr(Request.QueryString("erro11")) = "s" Then
			strTextoHtml = strTextoHtml & "selected"
			End If
			strTextoHtml = strTextoHtml & ">Visível<option value=""n"" "
			If CStr(Request.QueryString("erro11")) = "n" Then
			strTextoHtml = strTextoHtml & "selected"
			End If
			strTextoHtml = strTextoHtml & " style=color:#ff0000>Não Visível</select></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15></td></tr>"
			
			strTextoHtml = strTextoHtml & "<tr><td valign=""top""><FONT face=tahoma  style=font-size:11px><b>Destaque?</b></td><td><select name=""destaque"" style=font-size:11px;font-family:tahoma><option value=""s"" "
			If CStr(Request.QueryString("erro11")) = "s" Then
			strTextoHtml = strTextoHtml & "selected"
			End If
			strTextoHtml = strTextoHtml & " style=color:#0000ff>Sim<option value=""n"" "
			If CStr(Request.QueryString("erro11")) = "n" Then
			strTextoHtml = strTextoHtml & "selected"
			End If
			strTextoHtml = strTextoHtml & ">Não</select>"
			If mostrar_produto_destaque_fachada<>"Sim" Then
			strTextoHtml = strTextoHtml & "<br><FONT face=tahoma  style=font-size:10px color=""#003366"">(Para mostrar os destaques na Loja, também será preciso setar no Config.asp mostrar_produto_destaque_fachada=""Sim"")</font>"
			End If
			strTextoHtml = strTextoHtml & " </td></tr>"
						
'#########################################################################################
'#----------------------------------------------------------------------------------------
'# CONTROLE DE ESTOQUE POR ROGERIO SILVA
'#########################################################################################
			strTextoHtml = strTextoHtml & "<tr><td colspan=2><FONT face=tahoma  style=font-size:11px><br><br><b>Controle de estoque</b></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px>Qtd Máxima por cliente</td>"
	strTextoHtml = strTextoHtml & "<td><input type='text' name='maxProd' value='01' maxlength='4' size='2'></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px>Qtd disponível no estoque</td>"
			strTextoHtml = strTextoHtml & "<td><input type=text name='maxEstoque' value=01 maxlength=4 size=2></td></tr>"
'#########################################################################################
'#----------------------------------------------------------------------------------------
'# CONTROLE DE ESTOQUE POR ROGERIO SILVA
'#########################################################################################

			strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15></td></tr>"

			strTextoHtml = strTextoHtml & "<tr><td align=center></td><td align=center>&nbsp;&nbsp;&nbsp;&nbsp;<input type=""submit"" NAME=""Enter"" style=font-size:11px;font-family:tahoma value="" Gravar produto ""> <input type=""reset"" value=""Limpar formulario"" style=font-size:11px;font-family:tahoma></td></table><br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"

Case "gravanovo"
			Response.Expires = 0
			byteCount = Request.TotalBytes
			RequestBin = Request.BinaryRead(byteCount)
			Set UploadRequest = CreateObject("Scripting.Dictionary")
			BuildUploadRequest RequestBin
			'variaveis
			nome = Trim(UploadRequest.Item("nomeprod").Item("Value"))
			categ = Trim(UploadRequest.Item("categ").Item("Value"))
			peso = Trim(UploadRequest.Item("peso").Item("Value"))
			precov = Trim(UploadRequest.Item("precv").Item("Value"))
			precon = Trim(UploadRequest.Item("precn").Item("Value"))
			parcelamento = Trim(UploadRequest.Item("parc").Item("Value"))
			juros = Trim(UploadRequest.Item("juro").Item("Value"))
			juropor = Trim(UploadRequest.Item("jurodia").Item("Value"))
			fabricante = Trim(UploadRequest.Item("fabri").Item("Value"))
			descricao = Trim(UploadRequest.Item("descri").Item("Value"))
			estoq = Trim(UploadRequest.Item("estoq").Item("Value"))
			figurg = Trim(UploadRequest.Item("figurag").Item("Value"))
			figurp = Trim(UploadRequest.Item("figurap").Item("Value"))
			destaque = Trim(UploadRequest.Item("destaque").Item("Value"))
'#########################################################################################
'#----------------------------------------------------------------------------------------
'# CONTROLE DE ESTOQUE POR ROGERIO SILVA
'#########################################################################################
			QtdMax = Trim(UploadRequest.Item("maxProd").Item("Value"))
			Estoque = Trim(UploadRequest.Item("maxEstoque").Item("Value"))
'#########################################################################################
'#----------------------------------------------------------------------------------------
'# CONTROLE DE ESTOQUE POR ROGERIO SILVA
'#########################################################################################
			If parcelamento = "v" Then
			juros = "0"
			Else
			juros = juros
			End If

			If nome = "" Or peso = "" Or precov = "" Or precon = "" Or parcelamento = "" Or juros = "" Or juropor = "" Or fabricante = "" Or descricao = "" Or estoq = "" Or figurg = "" Or figurp = "" Then

			If parcelamento = "" Then
			erro14 = "sim"
			Else
			erro14 = parcelamento
			End If
			If juropor = "" Then
			erro13 = "sim"
			Else
			erro13 = juropor
			End If
			If categ = "" Then
			erro10 = "sim"
			Else
			erro10 = categ
			End If
			If estoq = "" Then
			erro11 = "sim"
			Else
			erro11 = estoq
			End If
			If figurg = "" Then
			erro8 = "sim"
			Else
			erro8 = figurg
			End If
			If figurp = "" Then
			erro9 = "sim"
			Else
			erro9 = figurp
			End If
			If nome = "" Then
			erro1 = "sim"
			Else
			erro1 = nome
			End If
			If peso = "" Then
			erro2 = "sim"
			Else
			erro2 = peso
			End If
			If precov = "" Then
			erro3 = "sim"
			Else
			erro3 = precov
			End If
			If precon = "" Then
			erro4 = "sim"
			Else
			erro4 = precon
			End If
			If fabricante = "" Then
			erro5 = "sim"
			Else
			erro5 = fabricante
			End If
			If descricao = "" Then
			erro6 = "sim"
			Session("adm_descprod") = ""
			Else
			Session("adm_descprod") = descricao
			End If
			If juros = "" Then
			erro12 = "sim"
			Else
			erro12 = juros
			End If

			Response.Redirect "?link=produtos&acao=inserir&erro14=" & erro14 & "&erro88=" & erro88 & "&erro99=" & erro99 & "&erro10=" & erro10 & "&erro11=" & erro11 & "&erro12=" & erro12 & "&erro13=" & erro13 & "&erro1=" & erro1 & "&erro2=" & erro2 & "&erro3=" & erro3 & "&erro4=" & erro4 & "&erro5=" & erro5 & "&erro6=" & erro6 & "&erro8=" & erro8 & "&erro9=" & erro9

			End If

			strString = descricao
			'strString = Codifica(strString) 'Usar somente qdo nao se usa a Ferramenta HTMLarea
			strString = Replace(strString,"<P>","<br>")
			strString = Replace(strString,"</P>","")
			if left(strString,4)="<br>" then strString=Mid(strString,5) end if
			descricao = ""
			descricao = strString

			Set selectfig = conexao.Execute("SELECT * FROM produtos WHERE imgra = '" & FileName & "';")

			ContentType = UploadRequest.Item("figurag").Item("ContentType")
			filepathname = UploadRequest.Item("figurag").Item("FileName")
			FileName = Right(filepathname, Len(filepathname) - InStrRev(filepathname, "\"))

			Set selectfig = conexao.Execute("SELECT * FROM produtos WHERE imgra = '" & FileName & "';")

			Value = UploadRequest.Item("figurag").Item("Value")
			Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")
			numero1 = instrrev(Request.servervariables("Path_Info"), "/")
			var3 = left(Request.servervariables("Path_Info"),numero1)
			Set MyFile = ScriptObject.CreateTextFile(Server.mappath(var3) & "\produtos\g_" & FileName)
			For i = 1 To LenB(Value)
			MyFile.Write Chr(AscB(MidB(Value, i, 1)))
			Next
			MyFile.Close

			contentType2 = UploadRequest.Item("figurap").Item("ContentType")
			filepathname2 = UploadRequest.Item("figurap").Item("FileName")
			filename2 = Right(filepathname2, Len(filepathname2) - InStrRev(filepathname2, "\"))
			value2 = UploadRequest.Item("figurap").Item("Value")
			Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")
			numero2 = instrrev(Request.servervariables("Path_Info"), "/")
			var32 = left(Request.servervariables("Path_Info"),numero2)
			Set MyFile2 = ScriptObject.CreateTextFile(Server.mappath(var32) & "\produtos\p_" & filename2)
			For i = 1 To LenB(value2)
			MyFile2.Write Chr(AscB(MidB(value2, i, 1)))
			Next
			MyFile2.Close


			'*** Substitui o ' por ´ (senao ocorre problemas) 
			descricao=replace(descricao,"'","´")
			fabricante=replace(fabricante,"'","´")
			nome=replace(nome,"'","´")


			textosql = "INSERT INTO produtos (nome, fabricante, detalhe, preco, precovelho, parcela" _
			& ", juro, aomes, estoque, idsessao, data, peso, imgra, impeq, status, destaque) VALUES ('" & nome & "', " _
			& "'" & fabricante & "', '" & descricao & "', '" & precon & "', '" & precov & "', '" & parcelamento & "'" _
			& ", '" & juros & "', '" & juropor & "', '" & estoq & "', '" & categ & "', '" & dia & "/" & mez & "/" & Year(Date) & "'," _
			& " '" & peso & "', 'g_" & FileName & "', 'p_" & filename2 & "', 'nao', '" & destaque & "')"

			'response.write "<br>textosql :"&textosql
			'response.end
			Set gravaprod = conexao.Execute(textosql)
'#########################################################################################
'#----------------------------------------------------------------------------------------
'# CONTROLE DE ESTOQUE POR ROGERIO SILVA
'#########################################################################################
			textoest = "SELECT idprod from produtos where nome='"&nome&"' and detalhe ='"&descricao&"'"

			Set buscaEst = conexao.Execute(textoest)
			if not buscaEst.eof then
				Saida = conexao.execute("INSERT INTO ESTOQUE (IDPRODUTO,QTDMAXIMA,ESTOQUE) values ("& buscaEst("idprod") &","& QTDMAX &","& Estoque &");")
			end if
			'response.write "<br>textoest :"&textoest
			'response.write "<br>buscaEst(idprod) :"&buscaEst("idprod")
			'response.write "<br>QTDMAX :"&QTDMAX
			'response.write "<br>Estoque :"&Estoque
			'response.end			
'#########################################################################################
'# CONTROLE DE ESTOQUE POR ROGERIO SILVA
'#----------------------------------------------------------------------------------------
'#########################################################################################
			strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Novo produto incluído com sucesso</B></FONT><hr size=1 color=#cccccc>"
			strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
			strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=produtos&acao=inserir&acaba=sim"">Inserir um novo produto na loja</a></b> | <b><A href=""produtos.asp?produto=" & buscaEst("idprod") & """ target=""_blank"">Ver este produto na loja</a></b></center>"
			strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
			strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc><br>"
			strTextoHtml = strTextoHtml & "<table align=center width=""88%"" cellspacing=""2"" cellpadding=""2"">"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dia & "/" & mez & "/" & Year(Date) & "</td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Nome do produto:</b></td><td><FONT face=tahoma  style=font-size:11px>" & nome & "</b></td></tr>"
			Set setcat = conexao.Execute("SELECT nome FROM categoria WHERE idcategoria = " & categ & ";")
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Categoria:</b></td><td><FONT face=tahoma  style=font-size:11px>" & setcat("nome") & "</b></td></tr>"
			setcat.Close
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Peso:</b></td><td><FONT face=tahoma  style=font-size:11px>" & peso & " Kg</b></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Preço Normal:</b></td><td><FONT face=tahoma  style=font-size:11px>R$ " & FormatNumber(precov, 2) & "</b></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Preço Promocional:</b></td><td><FONT face=tahoma  style=font-size:11px>R$ " & FormatNumber(precon, 2) & "</b></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Parcelamento:</b></td><td><FONT face=tahoma  style=font-size:11px>"
			If parcelamento = "v" Then
			strTextoHtml = strTextoHtml & "à Vista sem juros."
			Else
			strTextoHtml = strTextoHtml & parcelamento & "x  com juros de " & juros & "% ao "
			If juropor = "mes" Then
			strTextoHtml = strTextoHtml & "mês."
			Else
			strTextoHtml = strTextoHtml & "ano."
			End If
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Imagem pequena:</b></td><td><FONT face=tahoma  style=font-size:11px><b>Imagem grande:</b></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td valign=center width=""40%"" align=center style=""border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;""><img src=""produtos/p_" & filename2 & """ vsapce=5 hsapce=5  width=""75""></td><td valign=center width=""30%"" align=center style=""border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;""><img src=""produtos/g_" & FileName & """ width=185 vsapce=5 hsapce=5></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Fabricante:</b></td><td><FONT face=tahoma  style=font-size:11px>" & fabricante & "</b></td></tr>"
			strString = descricao
			'strString = Decodifica(strString) 'Usar somente qdo nao se usa a Ferramenta HTMLarea

			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Descrição:</b></font></td><td width=""100%"" style=""border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;""><table width=""100%"" height=""100%""><tr><td>" & strString & "</td></tr></table>"
			strTextoHtml = strTextoHtml & "</td></tr>"

			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Estoque:</b></td><td><FONT face=tahoma  style=font-size:11px>"
			If estoq = "s" Then
			strTextoHtml = strTextoHtml & "Visível"
			Else
			strTextoHtml = strTextoHtml & "Não Visível"
			End If
			strTextoHtml = strTextoHtml & "</b></td></tr>"

'#########################################################################################
'#----------------------------------------------------------------------------------------
'# CONTROLE DE ESTOQUE POR ROGERIO SILVA
'#########################################################################################
			strTextoHtml = strTextoHtml & "<tr><td colspan=2><FONT face=tahoma  style=font-size:11px><br><br><b>Controle de estoque</b></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px>Qtd Máxima por cliente</td>"
			strTextoHtml = strTextoHtml & "<td><input type=text name=maxProd value='"& QTDMAX &"' size=2 maxlength=4 readonly></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px>Qtd disponível no estoque</td>"
			strTextoHtml = strTextoHtml & "<td><input type=text name=maxEstoque value='"&Estoque&"' maxlength=4 readonly size=2></td></tr>"
'#########################################################################################
'# CONTROLE DE ESTOQUE POR ROGERIO SILVA
'#----------------------------------------------------------------------------------------
'#########################################################################################
			strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15></td></tr></table><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br><br>"

Case "editar"

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
				final = 20
				Else
				inicial = pag
				final = 20
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
				restinho = "WHERE " & resto & " nome LIKE '%" & palavraz(0) & "%'"
				End If
				'response.write "<br>restinho :"&restinho
				'response.end


				If VersaoDb = 1 then
				   Set rs = conexao.Execute("SELECT * FROM produtos " & restinho & " ORDER by nome asc LIMIT " & inicial & "," & final & ";")
				else
				   set rs = createobject("adodb.recordset")
				   set rs.activeconnection = conexao
				   rs.cursortype = 3
				   rs.pagesize = final
				   rs.open "SELECT * FROM produtos " & restinho & " ORDER by nome asc"
				end if

				If rs.EOF Or rs.bof Then

				strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Editar produtos na loja</B></FONT><hr size=1 color=#cccccc>"
				strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=100><tr><td>"
				strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Produtos(s) encontrado(s): <b>0" & totalreg & "</b> <hr size=1 color=#dddddd width=""100%"">"
				strTextoHtml = strTextoHtml & "<table cellspacing=""3"" cellpadding=""3"" align=center width=""100%"">"
				strTextoHtml = strTextoHtml & "<tr><form action=""?"" method=get><input name=""link"" type=""hidden"" value=""produtos""><input name=""acao"" type=""hidden"" value=""editar"">"
				strTextoHtml = strTextoHtml & "<td align=center><font face=""tahoma"" style=font-size:11px;color:000000><center>Para uma busca mais detalhada dos produtos na loja realize uma pesquisa com o nome e/ou palavra-chave do produto  que você procura.</td><tr><td align=center>"
				strTextoHtml = strTextoHtml & "<input name=""pesqsa"" type=""text"" value=""" & Request("pesqsa") & """ style=font-size:11px;color:000000;font-family:tahoma><font style=font-size:11px> em <select name=cat style=font-size:11px;font-family:tahoma>"
				strTextoHtml = strTextoHtml & "<option value=todos>toda loja</option>"
				strTextoHtml = strTextoHtml & "<option value=xxx>--------------------</option>"
				Set Menu = conexao.Execute("SELECT * FROM sessoes ORDER by nome;")
				If Err.Number <> 0 Then
				strTextoHtml = ""
				strTextoHtml = strTextoHtml & "<meta http-equiv=""refresh"" content=""0"">"
				Response.Write strTextoHtml
				Response.End
				End If
				While Not Menu.EOF
				strTextoHtml = strTextoHtml & "<option value=""" & Menu("id") & """ "
				If CStr(Request("cat")) = CStr(Menu("id")) Then
				strTextoHtml = strTextoHtml & "selected"
				End If
				strTextoHtml = strTextoHtml & ">" & L	(Menu("nome")) & "</option>"
				Menu.movenext
				Wend
				Menu.Close
				Set Menu = Nothing
				 
				strTextoHtml = strTextoHtml & "</select></font> <input type=submit class=""ok"" value=""Pesquisar"" style=font-size:11px;color:000000;font-family:tahoma>"
				strTextoHtml = strTextoHtml & "</td></form></tr><tr><td height=1 bgcolor=cccccc></td></tr></table><br><br>"
				strTextoHtml = strTextoHtml & "<table width=565 align=center>"
				strTextoHtml = strTextoHtml & "<tr><td align=center><br><br><b><font style=font-size:11px>Nenhum produto foi encontrado na base de dados da loja.<br><br></b><br><br></td></tr></table>"
				strTextoHtml = strTextoHtml & "<br></table>"
				strTextoHtml = strTextoHtml & "<table width=""100%"" cellspacing=""0"" cellpadding=""0""><tr><td colspan=2>"
				strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc width=""101%""></td></tr><tr><td></td><td align=right><font face=""tahoma"" style=font-size:11px;color:000000>"
				strTextoHtml = strTextoHtml & "&nbsp;<font face=""tahoma"" style=font-size:11px>Página(s): <b><u>1</u></b></a></font></td></tr>"
				strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
				strTextoHtml = strTextoHtml & "</tr></table><td></tr></table>"

				Else
				Set rs2 = conexao.Execute("SELECT count(nome) AS total FROM produtos " & restinho & ";")
				totalreg = rs2("total")
				rs2.Close
				Set rs2 = Nothing
				numiz = Request("pagina") & "0"
				numiz = CInt(numiz)
				iz = iz + numiz

				strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Editar produtos na loja</B></FONT><hr size=1 color=#cccccc>"
				strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=100><tr><td>"
				strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Produtos(s) encontrado(s): <b>" & totalreg & "</b> <hr size=1 color=#dddddd width=""100%"">"
				strTextoHtml = strTextoHtml & "<table cellspacing=""3"" cellpadding=""3"" align=center width=""100%"">"
				strTextoHtml = strTextoHtml & "<tr><form action=""?"" method=get><input name=""link"" type=""hidden"" value=""produtos""><input name=""acao"" type=""hidden"" value=""editar"">"
				strTextoHtml = strTextoHtml & "<td align=center><font face=""tahoma"" style=font-size:11px;color:000000><center>Para uma busca mais detalhada dos produtos na loja realize uma pesquisa com o nome e/ou palavra-chave do produto  que você procura.</td><tr><td align=center>"
				strTextoHtml = strTextoHtml & "<input name=""pesqsa"" type=""text"" value=""" & Request("pesqsa") & """ style=font-size:11px;color:000000;font-family:tahoma><font style=font-size:11px> em <select name=cat style=font-size:11px;font-family:tahoma>"
				strTextoHtml = strTextoHtml & "<option value=todos>toda loja</option>"
				strTextoHtml = strTextoHtml & "<option value=xxx>--------------------</option>"

				Set Menu = conexao.Execute("SELECT * FROM sessoes ORDER by nome;")
				If Err.Number <> 0 Then
				strTextoHtml = ""
				strTextoHtml = strTextoHtml & "<meta http-equiv=""refresh"" content=""0"">"
				Response.Write strTextoHtml
				Response.End
				End If
				While Not Menu.EOF
				strTextoHtml = strTextoHtml & "<option value=""" & Menu("id") & """ "
				If CStr(catege) = CStr(Menu("id")) Then
				strTextoHtml = strTextoHtml & "selected"
				End If
				strTextoHtml = strTextoHtml & ">" & LCase(Menu("nome")) & "</option>"
				Menu.movenext
				Wend
				Menu.Close
				Set Menu = Nothing
				 
				strTextoHtml = strTextoHtml & "</select></font> <input type=submit class=""ok"" value=""Pesquisar"" style=font-size:11px;color:000000;font-family:tahoma>"
				strTextoHtml = strTextoHtml & "</td></form></tr><tr><td height=1 bgcolor=cccccc></td></tr></table><br><br>"
				strTextoHtml = strTextoHtml & "<table width=""100%"" align=center>"

				'response.write "<br>sql :"& "SELECT nome FROM categoria WHERE id = " & rs("idsessao") & ""
				'response.end
				
				If VersaoDb = 1 then

				else

				pag = request.querystring("pagina")
				if pag = "" Then
				   pag = 1
				end if

				contador = 0
				rs.absolutepage = pag
				while not rs.eof and contador < rs.pagesize
				contador = contador +1

				iz = iz + 1
				If rs("estoque") = "s" Then
				varestoq = "<font color=#000000>Visível</font>"
				Else
				varestoq = "<font color=#b23c04>Não Visível </font>"
				End If


				if VersaoDb = 1 Then
				   'Set rs3 = conexao.Execute("SELECT nome FROM categoria WHERE idcategoria = '" & rs("idsessao") & "';")
				   Set rs3 = conexao.Execute("SELECT B.NOME AS SESSAO FROM CATEGORIA AS A, SESSOES AS B WHERE A.IDSESSAO = B.ID AND idcategoria='" & rs("idsessao")& "';")
				else
				   'Set rs3 = conexao.Execute("SELECT nome FROM categoria WHERE idcategoria =" & rs("idsessao"))
				   Set rs3 = conexao.Execute("SELECT B.NOME AS SESSAO FROM CATEGORIA AS A, SESSOES AS B WHERE A.IDSESSAO = B.ID AND idcategoria=" & rs("idsessao"))
				end if

				varsessao = rs3("Sessao")

						'***  Verifica se tem Estoque do Produto
						set rs_estoque = abredb.execute("SELECT estoque FROM estoque WHERE idproduto="&rs("idprod")&" ;")
						if not rs_estoque.eof then
						estoque_atual=rs_estoque("estoque")
						end if
						rs_estoque.close
						set rs_estoque = nothing

						if estoque_atual=0 then
						mostrar_estoque_atual=" <font color=red>Zero!</font> "
						else
						mostrar_estoque_atual=estoque_atual
						end if

						if rs("destaque")="s" then
						vardestaque=" <font color=blue>Sim</font> "
						else
						vardestaque=" Não "
						end if
				
				strTextoHtml = strTextoHtml & "<tr><td align=left valign=center>"
				strTextoHtml = strTextoHtml & "<table width=""100%"" bgcolor=#eeeeee style='border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;'><tr><td valign=center><font face=""tahoma"" style=font-size:11px;color:000000>" & iz & ") <b>" & UCase(rs("nome")) & "</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Depto: <b>" & varsessao & "</b> &nbsp;&nbsp;&nbsp;Estoque: <b>" & varestoq & "</b> &nbsp;&nbsp;&nbsp;Destaque: <b>" & vardestaque & "</b> &nbsp;&nbsp;&nbsp;Estoque: <b>" & mostrar_estoque_atual & "</b></td><td align=right valign=center><font face=""tahoma"" style=font-size:11px;color:000000>Ação: <b><a href=?link=produtos&acao=ver&prod=" & rs("idprod") & ">Ver</a></b> | <b><a href=?link=produtos&acao=edita&prod=" & rs("idprod") & ">Editar</a></b>&nbsp;</td></tr></table> <table><tr><td height=4></td></tr></table>"


				rs.movenext
				wend
				strTextoHtml = strTextoHtml & "<table width=565>"
				strTextoHtml = strTextoHtml & "<tr><td colspan=2>"
				strTextoHtml = strTextoHtml & "<center><br>"

				strTextoHtml = strTextoHtml & "<table width=100% cellspacing=""0"" cellpadding=""0""><tr><td colspan=2>"
				strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc width=""101%""></td></tr><tr><td colspan=2 align=right><font face=""tahoma"" style=font-size:11px;color:000000>"

				strTextoHtml = strTextoHtml & "Página(s):&nbsp;&nbsp;"

				for i = 1 to rs.pagecount

				if i = cint(pag) then
				   strTextoHtml = strTextoHtml & "<u><b>" & i & "</b></u> "
				else
				   strTextoHtml = strTextoHtml & "<a href='?link=produtos&acao=editar&acaba=sim&pagina=" & i & "&pesqsa=" & pesqsa & "&cat=" & catege & "'>" & i & "</a> "
				end if

				next

				strTextoHtml = strTextoHtml & "</td></tr>"
				end if


				strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
				strTextoHtml = strTextoHtml & " </tr></table></td></tr></table> </td></tr></table></td></tr></table></td></tr></table>"
				rs.Close
				Set rs = Nothing
				End If
		
Case "ver"
			Set setprod = conexao.Execute("SELECT * FROM produtos WHERE idprod = " & Request("prod") & ";")
			nome = setprod("nome")
			categ = setprod("idsessao")
			peso = setprod("peso")
			precov = setprod("precovelho")
			precon = setprod("preco")
			parcelamento = setprod("parcela")
			juros = setprod("juro")
			juropor = setprod("aomes")
			fabricante = setprod("fabricante")
			descricao = setprod("detalhe")
			estoq = setprod("estoque")
			figurg = setprod("imgra")
			figurp = setprod("impeq")
			destaque = setprod("destaque")
			
			if len(cstr(figurg))<3 then
			figurg="img_nao_disp.gif"
			end if
			
			if len(cstr(figurp))<3  then
			figurp="img_nao_disp.gif"
			end if
			

			If Request("status") = "sucesso" Then
			strTextoHtml = strTextoHtml & " <FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Produto editado com sucesso</B></FONT><hr size=1 color=#cccccc>"
			strTextoHtml = strTextoHtml & " <hr size=1 color=ffffff>"
			strTextoHtml = strTextoHtml & " <center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=produtos&acao=edita&prod=" & Request("prod") & "&acaba=sim"">Editar novamente este produto</a></b> | <b><A href=""?link=produtos&acao=editar&acaba=sim"">Ver novamente todos os produtos</a></b> | <b><A href=""produtos.asp?produto=" & Request("prod") & """ target=""_blank"">Ver este produto na loja</a></b></center>"
			Else
			strTextoHtml = strTextoHtml & " <FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Ver produto cadastrado na loja</B></FONT><hr size=1 color=#cccccc>"
			strTextoHtml = strTextoHtml & " <hr size=1 color=ffffff>"
			If Request("modo") = "exclui" Then

			strTextoHtml = strTextoHtml & "<script language=""javascript"">" & vbNewLine
			strTextoHtml = strTextoHtml & "function prod" & Request("prod") & "(){" & vbNewLine
			strTextoHtml = strTextoHtml & "if (confirm('Você realmente deseja excluir este produto?'))" & vbNewLine
			strTextoHtml = strTextoHtml & "{" & vbNewLine
			strTextoHtml = strTextoHtml & "window.location.href('?link=produtos&acao=exclui&prod=" & Request("prod") & "');" & vbNewLine
			strTextoHtml = strTextoHtml & "}" & vbNewLine
			strTextoHtml = strTextoHtml & "else" & vbNewLine
			strTextoHtml = strTextoHtml & "{" & vbNewLine
			strTextoHtml = strTextoHtml & "}}" & vbNewLine
			strTextoHtml = strTextoHtml & "</script>" & vbNewLine
			strTextoHtml = strTextoHtml & " <center><FONT face=tahoma  style=font-size:11px><b><a href=""javascript: prod" & Request("prod") & "();"">Excluir este produto</a></b> | <b><A href=""?link=produtos&acao=excluir&acaba=sim"">Ver todos os produtos</a></b> | <b><A href=""produtos.asp?produto=" & Request("prod") & """ target=""_blank"">Ver este produto na loja</a></b></center>"
			Else
			strTextoHtml = strTextoHtml & " <center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=produtos&acao=edita&prod=" & Request("prod") & "&acaba=sim"">Editar este produto</a></b> |<b><A href=""?link=produtos&acao=editar&acaba=sim""> Ver todos os produtos</a></b> | <b><A href=""produtos.asp?produto=" & Request("prod") & """ target=""_blank"">Ver este produto na loja</a></b> </center>"
			End If
			End If
			strTextoHtml = strTextoHtml & " <hr size=1 color=ffffff>"
			strTextoHtml = strTextoHtml & " <hr size=1 color=cccccc><br>"
			strTextoHtml = strTextoHtml & " <table align=center width=""88%"" cellspacing=""2"" cellpadding=""2"">"
			strTextoHtml = strTextoHtml & " <tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & setprod("data") & "</td></tr>"
			strTextoHtml = strTextoHtml & " <tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Nome do produto:</b></td><td><FONT face=tahoma  style=font-size:11px>" & nome & "</b></td></tr>"
			'Set setcat = conexao.Execute("SELECT nome FROM sessoes WHERE id = " & categ & ";")
			Set setcat = conexao.Execute("SELECT A.idcategoria, B.nome, A.data, A.nome as Nm, A.descr, A.ver FROM sessoes as B INNER JOIN CATEGORIA as A ON B.id = A.idsessao WHERE idcategoria= " & categ & ";")
			strTextoHtml = strTextoHtml & " <tr><td><FONT face=tahoma  style=font-size:11px><b>Categoria:</b></td><td><FONT face=tahoma  style=font-size:11px>" & setcat("nome") & "</b></td></tr>"
			setcat.Close
			strTextoHtml = strTextoHtml & " <tr><td><FONT face=tahoma  style=font-size:11px><b>Peso:</b></td><td><FONT face=tahoma  style=font-size:11px>" & peso & " Kg</b></td></tr>"
			strTextoHtml = strTextoHtml & " <tr><td><FONT face=tahoma  style=font-size:11px><b>Preço Normal:</b></td><td><FONT face=tahoma  style=font-size:11px>R$ " & FormatNumber(precov, 2) & "</b></td></tr>"
			strTextoHtml = strTextoHtml & " <tr><td><FONT face=tahoma  style=font-size:11px><b>Preço Promocional:</b></td><td><FONT face=tahoma  style=font-size:11px>R$ " & FormatNumber(precon, 2) & "</b></td></tr>"
			strTextoHtml = strTextoHtml & " <tr><td><FONT face=tahoma  style=font-size:11px><b>Parcelamento:</b></td><td><FONT face=tahoma  style=font-size:11px>"
			If parcelamento = "v" Then
			strTextoHtml = strTextoHtml & "à Vista."
			Else
			strTextoHtml = strTextoHtml & parcelamento & "x com juros de " & juros & "% ao "
			If juropor = "mes" Then
			strTextoHtml = strTextoHtml & "mês"
			Else
			strTextoHtml = strTextoHtml & "ano"
			End If
			strTextoHtml = strTextoHtml & ".</td></tr>"
			End If
			strTextoHtml = strTextoHtml & " <tr><td><FONT face=tahoma  style=font-size:11px><b>Imagem pequena:</b></td><td><FONT face=tahoma  style=font-size:11px><b>Imagem grande:</b></td></tr>"
			strTextoHtml = strTextoHtml & " <tr><td valign=center width=""40%"" align=center style=""border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;""><img src=""produtos/" & figurp & """ vsapce=5 hsapce=5  ></td><td valign=center width=""30%"" align=center style=""border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;""><img src=""produtos/" & figurg & """ vsapce=5 hsapce=5></td></tr>"
			strTextoHtml = strTextoHtml & " <tr><td><FONT face=tahoma  style=font-size:11px><b>Fabricante:</b></td><td><FONT face=tahoma  style=font-size:11px>" & fabricante & "</b></td></tr>"
			strString = descricao
			'strString = Decodifica(strString) 'Usar somente qdo nao se usa a Ferramenta HTMLarea
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Descrição:</b></font></td><td width=""100%"" style=""border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;""><table width=""100%"" height=""100%""><tr><td><FONT face=tahoma  style=font-size:11px>" & strString & "</font></td></tr></table>"

			strTextoHtml = strTextoHtml & "</td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Mostrar na Loja? </b></td><td><FONT face=tahoma  style=font-size:11px>"
			If estoq = "s" Then
			strTextoHtml = strTextoHtml & "Visível"
			Else
			strTextoHtml = strTextoHtml & "Não Visível"
			End If
			
			strTextoHtml = strTextoHtml & "<tr><td valign=""top""><FONT face=tahoma  style=font-size:11px><b>É destaque?</b></td><td><FONT face=tahoma  style=font-size:11px>"
			If destaque = "s" Then
			strTextoHtml = strTextoHtml & "<font color=#0000FF>SIM</font>"
			Else
			strTextoHtml = strTextoHtml & "NÃO"
			End If

			If mostrar_produto_destaque_fachada<>"Sim" Then
			strTextoHtml = strTextoHtml & "<br><FONT face=tahoma  style=font-size:10px color=""#003366"">(Para mostrar os destaques na Loja, também será preciso setar no Config.asp mostrar_produto_destaque_fachada=""Sim"")</font>"
			End If

'#########################################################################################
'#----------------------------------------------------------------------------------------
'# CONTROLE DE ESTOQUE POR ROGERIO SILVA
'#########################################################################################			
SQLEst = "SELECT * FROM ESTOQUE WHERE IDPRODUTO = " & Request("prod") & ";"
Set setEst = conexao.Execute(SQLEst)
IF NOT setEst.EOF THEN
			strTextoHtml = strTextoHtml & "<tr><td colspan=2><FONT face=tahoma  style=font-size:11px><br><br><b>Controle de estoque</b></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px>Qtd Máxima por cliente</td>"
			strTextoHtml = strTextoHtml & "<td><input type=text name=maxProd style=""font-size:11px;font-family:tahoma;border:1px #cccccc solid"" value='"& setEst("QTDMAXIMA") &"' maxlength=4 size=2 readonly></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px>Qtd disponível no estoque</td>"
			strTextoHtml = strTextoHtml & "<td><input type=text name=maxEstoque value='"& setEst("ESTOQUE") &"' maxlength=4 style=""font-size:11px;font-family:tahoma;border:1px #cccccc solid"" size=2 readonly></td></tr>"
END IF
setEst.close
Set setEst = nothing
'#########################################################################################
'# CONTROLE DE ESTOQUE POR ROGERIO SILVA
'#----------------------------------------------------------------------------------------
'#########################################################################################
			strTextoHtml = strTextoHtml & "</b></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15></td></tr></table><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br><br>"

Case "edita"
			Set setprod = conexao.Execute("SELECT * FROM produtos WHERE idprod = " & Request("prod") & ";")
			strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Editar produto na loja</B></FONT><hr size=1 color=#cccccc>"
			strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
			strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""produtos.asp?produto=" & Request("prod") & """ target=""_blank"">Ver este produto na loja</a></b></center>"
			strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
			strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc>"
			strTextoHtml = strTextoHtml & "<form method=post ENCTYPE=""multipart/form-data"" action=""?link=produtos&acao=gravavelho"" name=frmprod>"
			strTextoHtml = strTextoHtml & "<input name=""prod"" type=""hidden"" value=""" & Request("prod") & """>"
			strTextoHtml = strTextoHtml & "<table align=center width=""90%"">"
			varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & setprod("data") & "</td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Nome do produto:</b></td><td><input name=""nomeprod"" type=""text"" value=""" & setprod("nome") & """ size=75  style=font-size:11px;font-family:tahoma>"
			If Request.QueryString("erro1") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Categoria:</b></td><td><select name=""categ"" style=font-size:11px;font-family:tahoma>"
			Set pesquisa = conexao.Execute("SELECT A.idcategoria, B.nome, A.data, A.nome as Nm, A.descr, A.ver FROM sessoes as B INNER JOIN CATEGORIA as A ON B.id = A.idsessao ORDER by B.nome ASC")
			While Not pesquisa.EOF
			strTextoHtml = strTextoHtml & "<option value=""" & pesquisa("idcategoria") & """ "
			If CStr(pesquisa("idcategoria")) = CStr(setprod("idsessao")) Then
			strTextoHtml = strTextoHtml & "selected"
			End If
			strTextoHtml = strTextoHtml & ">" & pesquisa("nome") &" > "&pesquisa("nm") &"</option>"
			pesquisa.movenext
			Wend
			pesquisa.Close
			Set pesquisa = Nothing
			strTextoHtml = strTextoHtml & "</select></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Peso:</b></td><td><FONT face=tahoma  style=font-size:11px><input name=""peso"" type=""text"" size=10 value=""" & setprod("peso") & """ style=font-size:11px;font-family:tahoma>&nbsp;Kg &nbsp;&nbsp;&nbsp; <font color=""#003366"" style=font-size:10px>(Digite com virgula)</font>"
			If Request.QueryString("erro2") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"

			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Preço Normal:</b></td><td><FONT face=tahoma  style=font-size:11px>&nbsp;R$ <input name=""precv"" type=""text"" size=15 value=""" & setprod("precovelho") & """ style=font-size:11px;font-family:tahoma>"
			If Request.QueryString("erro3") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Preço Promocional:</b></td><td><FONT face=tahoma  style=font-size:11px>&nbsp;R$ <input name=""precn"" type=""text"" size=15 value=""" & setprod("preco") & """ style=font-size:11px;font-family:tahoma>"
			If Request.QueryString("erro4") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"

			strTextoHtml = strTextoHtml & "<input type=hidden name=""parc"" value=""v""><input type=hidden name=""juro"" value=""0""><input type=hidden name=""jurodia"" value=""mes"">"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Imagem grande:</b></td><td><FONT face=tahoma  style=font-size:11px><input name=""figurag"" type=""file"" size=15 style=font-size:11px;font-family:tahoma>"
			If Request.QueryString("erro8") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "<font color=""#003366"" style=font-size:10px> &nbsp;(caso não deseje editar a foto deixe em branco)</font></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Imagem pequena:</b></td><td><FONT face=tahoma  style=font-size:11px><input name=""figurap"" type=""file""  size=15 style=font-size:11px;font-family:tahoma>"
			If Request.QueryString("erro9") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "<font color=""#003366"" style=font-size:10px> &nbsp;(caso não deseje editar a foto deixe em branco)</font></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Fabricante:</b></td><td><input name=""fabri"" type=""text"" size=50 value=""" & setprod("fabricante") & """ style=font-size:11px;font-family:tahoma>"
			If Request.QueryString("erro5") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"
			strString = setprod("detalhe")
			'strString = Decodifica(strString)  'Usar somente qdo nao se usa a Ferramenta HTMLarea
			strTextoHtml = strTextoHtml & "</td></tr>"

'***  Adaptacao para usar o Htmlarea independente do servidor
If Request.ServerVariables("SERVER_NAME")="localhost" then
caminho_pasta_htmlarea = Server.MapPath("htmlarea")
caminho_pasta_htmlarea = replace(caminho_pasta_htmlarea,"\","/")
caminho_pasta_htmlarea = caminho_pasta_htmlarea & "/"
Else
caminho_pasta_htmlarea = "http://"&Endereco_do_site&"/htmlarea/"
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

			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Descrição:</b></td><td><textarea name=""descri"" rows=15 cols=75 style=font-size:11px;font-family:tahoma>" & strString & "</textarea>"
			strTextoHtml = strTextoHtml & "<br><FONT face=tahoma  style=font-size:10px  color=""#003366"">Dica: Para fazer uma simples quebra de linha , digite Shift+Enter</font><br><br>"
			If Request.QueryString("erro6") = "sim" Then
			strTextoHtml = strTextoHtml & varimg & "&nbsp;&nbsp;&nbsp;<FONT face=tahoma  style=font-size:11px color=""#ff0000"">Digite uma descrição</font><br><br>"
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"

strTextoHtml = strTextoHtml & "<tr><td valign=""center"" colspan=2>"
strTextoHtml = strTextoHtml & "<script language=""javascript1.2"">"
strTextoHtml = strTextoHtml & "editor_generate('descri');"
strTextoHtml = strTextoHtml & "</script>"
			If Request.QueryString("erro6") = "sim" Then
			strTextoHtml = strTextoHtml & varimg & "&nbsp;&nbsp;&nbsp;<FONT face=tahoma  style=font-size:11px color=""#ff0000"">Digite uma descrição</font><br><br>"
			End If
strTextoHtml = strTextoHtml & "</td></tr>"

			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Mostrar na Loja? </b></td><td><select name=""estoq"" style=font-size:11px;font-family:tahoma><option value=""s"" "
			If CStr(setprod("estoque")) = "s" Then
			strTextoHtml = strTextoHtml & "selected"
			End If
			strTextoHtml = strTextoHtml & ">Visível<option value=""n"" "
			If CStr(setprod("estoque")) = "n" Then
			strTextoHtml = strTextoHtml & "selected"
			End If
			
			strTextoHtml = strTextoHtml & " style=color:#ff0000>Não Visível</select></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15></td></tr>"
			
			strTextoHtml = strTextoHtml & "<tr><td valign=""top""><FONT face=tahoma  style=font-size:11px><b>Destaque?</b></td><td><select name=""destaque"" style=font-size:11px;font-family:tahoma><option value=""s"" "
			If CStr(setprod("destaque")) = "s" Then
			strTextoHtml = strTextoHtml & "selected"
			End If
			strTextoHtml = strTextoHtml & " style=color:#0000ff>Sim<option value=""n"" "
			If CStr(setprod("destaque")) = "n" Then
			strTextoHtml = strTextoHtml & "selected"
			End If
			strTextoHtml = strTextoHtml & ">Não</select>"
			If mostrar_produto_destaque_fachada<>"Sim" Then
			strTextoHtml = strTextoHtml & "<br><FONT face=tahoma  style=font-size:10px color=""#003366"">(Para mostrar os destaques na Loja, também será preciso setar no Config.asp mostrar_produto_destaque_fachada=""Sim"")</font>"
			End If
			strTextoHtml = strTextoHtml & " </td></tr>"
						
'#########################################################################################
'# CONTROLE DE ESTOQUE POR ROGERIO SILVA
'#----------------------------------------------------------------------------------------
'#########################################################################################
Set setEst = conexao.Execute("SELECT * FROM ESTOQUE WHERE idproduto = " & Request("prod") & ";")
			strTextoHtml = strTextoHtml & "<tr><td colspan=2><FONT face=tahoma  style=font-size:11px><br><br><b>Controle de estoque</b></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px>Qtd Máxima por cliente</td>"
			strTextoHtml = strTextoHtml & "<td><input type=text name=maxProd value="& setEst("QTDMAXIMA") &" maxlength=4 size=2></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px>Qtd disponível no estoque</td>"
			strTextoHtml = strTextoHtml & "<td><input type=text name=maxEstoque value="& setEst("ESTOQUE") &" maxlength=4 size=2></td></tr>"

'#########################################################################################
'#----------------------------------------------------------------------------------------
'# CONTROLE DE ESTOQUE POR ROGERIO SILVA
'#########################################################################################


			strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15></td></tr>"
			
			strTextoHtml = strTextoHtml & "<tr><td align=center></td><td align=center>&nbsp;&nbsp;&nbsp;&nbsp;<input type=""submit"" NAME=""Enter"" style=font-size:11px;font-family:tahoma value="" Editar produto ""> <input type=""reset"" value=""Limpar formulario"" style=font-size:11px;font-family:tahoma></td></table><br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"

Case "gravavelho"
			Response.Expires = 0
			byteCount = Request.TotalBytes
			RequestBin = Request.BinaryRead(byteCount)
			Set UploadRequest = CreateObject("Scripting.Dictionary")
			BuildUploadRequest RequestBin
			'variaveis
			nome = Trim(UploadRequest.Item("nomeprod").Item("Value"))
			categ = Trim(UploadRequest.Item("categ").Item("Value"))
			peso = Trim(UploadRequest.Item("peso").Item("Value"))
			precov = Trim(UploadRequest.Item("precv").Item("Value"))
			precon = Trim(UploadRequest.Item("precn").Item("Value"))
			parcelamento = Trim(UploadRequest.Item("parc").Item("Value"))
			juros = Trim(UploadRequest.Item("juro").Item("Value"))
			juropor = Trim(UploadRequest.Item("jurodia").Item("Value"))
			fabricante = Trim(UploadRequest.Item("fabri").Item("Value"))
			descricao = Trim(UploadRequest.Item("descri").Item("Value"))
			estoq = Trim(UploadRequest.Item("estoq").Item("Value"))
			figurg = Trim(UploadRequest.Item("figurag").Item("Value"))
			figurp = Trim(UploadRequest.Item("figurap").Item("Value"))
			destaque = Trim(UploadRequest.Item("destaque").Item("Value"))

'#########################################################################################
'# CONTROLE DE ESTOQUE POR ROGERIO SILVA
'#----------------------------------------------------------------------------------------
'#########################################################################################
			QtdMax = Trim(UploadRequest.Item("maxProd").Item("Value"))
			Estoque = Trim(UploadRequest.Item("maxEstoque").Item("Value"))
'#########################################################################################
'#----------------------------------------------------------------------------------------
'# CONTROLE DE ESTOQUE POR ROGERIO SILVA
'#########################################################################################

			If nome = "" Or peso = "" Or precov = "" Or precon = "" Or parcelamento = "" Or juros = "" Or juropor = "" Or fabricante = "" Or descricao = "" Or estoq = "" Then

			If parcelamento = "" Then
			erro14 = "sim"
			Else
			erro14 = parcelamento
			End If
			If juropor = "" Then
			erro13 = "sim"
			Else
			erro13 = juropor
			End If
			If categ = "" Then
			erro10 = "sim"
			Else
			erro10 = categ
			End If
			If estoq = "" Then
			erro11 = "sim"
			Else
			erro11 = estoq
			End If
			If figurg = "" Then
			erro8 = "sim"
			Else
			erro8 = figurg
			End If
			If figurp = "" Then
			erro9 = "sim"
			Else
			erro9 = figurp
			End If
			If nome = "" Then
			erro1 = "sim"
			Else
			erro1 = nome
			End If
			If peso = "" Then
			erro2 = "sim"
			Else
			erro2 = peso
			End If
			If precov = "" Then
			erro3 = "sim"
			Else
			erro3 = precov
			End If
			If precon = "" Then
			erro4 = "sim"
			Else
			erro4 = precon
			End If
			If fabricante = "" Then
			erro5 = "sim"
			Else
			erro5 = fabricante
			End If
			If descricao = "" Then
			erro6 = "sim"
			Session("adm_descprod") = ""
			Else
			Session("adm_descprod") = descricao
			End If
			If juros = "" Then
			erro12 = "sim"
			Else
			erro12 = juros
			End If

			Response.Redirect "?link=produtos&acao=edita2&erro14=" & erro14 & "&erro10=" & erro10 & "&erro99=" & erro99 & "&erro88=" & erro88 & "&erro11=" & erro11 & "&erro12=" & erro12 & "&erro13=" & erro13 & "&erro1=" & erro1 & "&erro2=" & erro2 & "&erro3=" & erro3 & "&erro4=" & erro4 & "&erro5=" & erro5 & "&erro6=" & erro6 & "&erro8=" & erro8 & "&erro9=" & erro9 & "&prod=" & UploadRequest.Item("prod").Item("Value")

			End If

			'*** Rotina da Figura Grande
			If figurg <> "" Then
			
			Set fig = conexao.Execute("SELECT imgra FROM produtos WHERE idprod = " & UploadRequest.Item("prod").Item("Value") & ";")

			ContentType = UploadRequest.Item("figurag").Item("ContentType")
			filepathname = UploadRequest.Item("figurag").Item("FileName")
			FileName = Right(filepathname, Len(filepathname) - InStrRev(filepathname, "\"))
			Value = UploadRequest.Item("figurag").Item("Value")
			Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")
			numero1 = instrrev(Request.servervariables("Path_Info"), "/")
			var3 = left(Request.servervariables("Path_Info"),numero1)

			'*** Gravava com o nome da img anterior
			'Set MyFile = ScriptObject.CreateTextFile(Server.mappath(var3) & "\produtos\" & fig("imgra"))

			Set MyFile = ScriptObject.CreateTextFile(Server.mappath(var3) & "\produtos\g_" & FileName)

			For i = 1 To LenB(Value)
			MyFile.Write Chr(AscB(MidB(Value, i, 1)))
			Next
			MyFile.Close
			
			textozql_fig=", imgra = 'g_" & FileName & "'"
			
			End If

			'*** Rotina da Figura Pequena
			If figurp <> "" Then

			
			Set fig = conexao.Execute("SELECT impeq FROM produtos WHERE idprod = " & UploadRequest.Item("prod").Item("Value") & ";")

			contentType2 = UploadRequest.Item("figurap").Item("ContentType")
			filepathname2 = UploadRequest.Item("figurap").Item("FileName")
			filename2 = Right(filepathname2, Len(filepathname2) - InStrRev(filepathname2, "\"))
			value2 = UploadRequest.Item("figurap").Item("Value")
			Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")
			numero2 = instrrev(Request.servervariables("Path_Info"), "/")
			var32 = left(Request.servervariables("Path_Info"),numero2)

			'*** Gravava com o nome da img anterior
			'Set MyFile2 = ScriptObject.CreateTextFile(Server.mappath(var32) & "\produtos\" & fig("impeq"))
			
			Set MyFile2 = ScriptObject.CreateTextFile(Server.mappath(var32) & "\produtos\p_" & filename2)
			For i = 1 To LenB(value2)
			MyFile2.Write Chr(AscB(MidB(value2, i, 1)))
			Next
			MyFile2.Close
			
			textozql_fig2=", impeq = 'p_" & filename2 & "'"
			
			End If

			strString = descricao
			'strString = Codifica(strString) 'Usar somente qdo nao se usa a Ferramenta HTMLarea
			strString = Replace(strString,"<P>","<br>")
			strString = Replace(strString,"</P>","")
			if left(strString,4)="<br>" then strString=Mid(strString,5) end if
			descricao = ""
			descricao = strString

			'*** Substitui o ' por ´ (senao ocorre problemas) 
			descricao=replace(descricao,"'","´")
			fabricante=replace(fabricante,"'","´")
			nome=replace(nome,"'","´") '*** Tirado o nome=replace(server.htmlencode(nome),"'","´") , pois gravava incorreto e prejudicava ao novo formato de pesquisa executado pelo pesquisa.asp


			textozql = "UPDATE produtos SET nome = '" & nome & "', fabricante = '" & fabricante & "', detalhe = '" & descricao & "', preco = '" & precon & "', precovelho =  '" & precov & "', parcela = '" & parcelamento & "', juro = '" & juros & "', aomes = '" & juropor & "' , estoque = '" & estoq & "', idsessao = '" & categ & "', peso = '" & peso & "', destaque = '" & destaque & "'" & textozql_fig & textozql_fig2 & " WHERE idprod=" & UploadRequest.Item("prod").Item("Value") & ";"

			Set atualizaprod = conexao.Execute(textozql)

'#########################################################################################
'#----------------------------------------------------------------------------------------
'# CONTROLE DE ESTOQUE POR ROGERIO SILVA
'#########################################################################################
Saida = conexao.execute("UPDATE ESTOQUE SET QTDMAXIMA= "& QTDMAX &", ESTOQUE="& Estoque &" WHERE IDPRODUTO=" & UploadRequest.Item("prod").Item("Value") & ";")
'#########################################################################################
'# CONTROLE DE ESTOQUE POR ROGERIO SILVA
'#----------------------------------------------------------------------------------------
'#########################################################################################
			Response.Redirect "?link=produtos&acao=ver&status=sucesso&prod=" & UploadRequest.Item("prod").Item("Value")


			Case "edita2"
			Set setprod = conexao.Execute("SELECT * FROM produtos WHERE idprod = " & Request("prod") & ";")
			strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Editar produto na loja</B></FONT><hr size=1 color=#cccccc>"
			strTextoHtml = strTextoHtml & "<form method=post ENCTYPE=""multipart/form-data"" action=""?link=produtos&acao=gravavelho"">"
			strTextoHtml = strTextoHtml & "<input name=""prod"" type=""hidden"" value=""" & Request("prod") & """>"
			strTextoHtml = strTextoHtml & "<table align=center width=""90%"">"
			varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & setprod("data") & "</td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Nome do produto:</b></td><td><input name=""nomeprod"" type=""text"" value="""
			If Request.QueryString("erro1") <> "sim" Then
			strTextoHtml = strTextoHtml & Request.QueryString("erro1")
			End If
			strTextoHtml = strTextoHtml & """ size=75  style=font-size:11px;font-family:tahoma>"
			If Request.QueryString("erro1") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Categoria:</b></td><td><select name=""categ"" style=font-size:11px;font-family:tahoma>"
			Set pesquisa = conexao.Execute("SELECT id, nome FROM sessoes ORDER by nome;")
			While Not pesquisa.EOF
			strTextoHtml = strTextoHtml & "<option value=""" & pesquisa("id") & """ "
			If CStr(pesquisa("id")) = CStr(Request.QueryString("erro10")) Then
			strTextoHtml = strTextoHtml & "selected"
			End If
			strTextoHtml = strTextoHtml & ">" & pesquisa("nome") & "</option>"
			pesquisa.movenext
			Wend
			pesquisa.Close
			Set pesquisa = Nothing
			strTextoHtml = strTextoHtml & "</select></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Peso:</b></td><td><FONT face=tahoma  style=font-size:11px><input name=""peso"" type=""text"" size=10 value="""
			If Request.QueryString("erro2") <> "sim" Then
			strTextoHtml = strTextoHtml & Request.QueryString("erro2")
			End If
			strTextoHtml = strTextoHtml & """ style=font-size:11px;font-family:tahoma>&nbsp;Kg  &nbsp;&nbsp;&nbsp; <font color=""#003366"" style=font-size:10px>(Digite com virgula)</font>"
			If Request.QueryString("erro2") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"

			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Preço Normal:</b></td><td><FONT face=tahoma  style=font-size:11px>&nbsp;R$ <input name=""precv"" type=""text"" size=15 value="""
			If Request.QueryString("erro3") <> "sim" Then
			strTextoHtml = strTextoHtml & Request.QueryString("erro3")
			End If
			strTextoHtml = strTextoHtml & """ style=font-size:11px;font-family:tahoma>"
			If Request.QueryString("erro3") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Preço Promocional:</b></td><td><FONT face=tahoma  style=font-size:11px>&nbsp;R$ <input name=""precn"" type=""text"" size=15 value="""
			If Request.QueryString("erro4") <> "sim" Then
			strTextoHtml = strTextoHtml & Request.QueryString("erro4")
			End If
			strTextoHtml = strTextoHtml & """ style=font-size:11px;font-family:tahoma>"
			If Request.QueryString("erro4") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"

			strTextoHtml = strTextoHtml & "<input type=hidden name=""parc"" value=""v""><input type=hidden name=""juro"" value=""0""><input type=hidden name=""jurodia"" value=""mes"">"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Imagem grande:</b></td><td><FONT face=tahoma  style=font-size:11px><input name=""figurag"" type=""file"" size=15 style=font-size:11px;font-family:tahoma> <font color=""#003366"" style=font-size:10px> &nbsp;(caso não deseje editar a foto deixe em branco)</font></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Imagem pequena:</b></td><td><FONT face=tahoma  style=font-size:11px><input name=""figurap"" type=""file""  size=15 style=font-size:11px;font-family:tahoma> <font color=""#003366"" style=font-size:10px> &nbsp;(caso não deseje editar a foto deixe em branco)</font></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Fabricante:</b></td><td><input name=""fabri"" type=""text"" size=50 value="""
			If Request.QueryString("erro5") <> "sim" Then
			strTextoHtml = strTextoHtml & Request.QueryString("erro5")
			End If
			strTextoHtml = strTextoHtml & """ style=font-size:11px;font-family:tahoma>"
			If Request.QueryString("erro5") = "sim" Then
			strTextoHtml = strTextoHtml & varimg
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Descrição:</b></td><td><textarea name=""descri"" rows=15 cols=75 style=font-size:11px;font-family:tahoma>" & Session("adm_descprod") & "</textarea>"
			strTextoHtml = strTextoHtml & "<br><FONT face=tahoma  style=font-size:10px  color=""#003366"">Dica: Para fazer uma simples quebra de linha , digite Shift+Enter</font><br><br>"
			If Request.QueryString("erro6") = "sim" Then
			strTextoHtml = strTextoHtml & varimg & "&nbsp;&nbsp;&nbsp;<FONT face=tahoma  style=font-size:11px color=""#ff0000"">Digite uma descrição</font><br><br>"
			End If
			strTextoHtml = strTextoHtml & "</td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Estoque:</b></td><td><select name=""estoq"" style=font-size:11px;font-family:tahoma><option value=""s"" "
			If CStr(Request.QueryString("erro11")) = "s" Then
			strTextoHtml = strTextoHtml & "selected"
			End If
			strTextoHtml = strTextoHtml & ">Visível<option value=""n"" "
			If CStr(Request.QueryString("erro11")) = "n" Then
			strTextoHtml = strTextoHtml & "selected"
			End If
			strTextoHtml = strTextoHtml & " style=color:#ff0000>Não Visível</select></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td align=center></td><td align=center>&nbsp;&nbsp;&nbsp;&nbsp;<input type=""submit"" NAME=""Enter"" style=font-size:11px;font-family:tahoma value="" Editar produto ""> <input type=""reset"" value=""Limpar formulario"" style=font-size:11px;font-family:tahoma></td></table><br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"

Case "excluir"

response.buffer= true

'###############################################
'## CORRIGE BUG DE EXCLUIR
'###############################################
IF request.querystring("Status") = "Redir" THEN
	Response.write "<meta http-equiv='refresh'content='0;URL=?link=produtos&acao=excluir&status=sucesso'>"
END IF
'###############################################
'## CORRIGE BUG DE EXCLUIR
'###############################################

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
			final = 20
			Else
			inicial = pag
			final = 20
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
			restinho = "WHERE " & resto & " nome LIKE '%" & palavraz(0) & "%'"
			End If


			If VersaoDb = 1 then
			   Set rs = conexao.Execute("SELECT * FROM produtos " & restinho & " ORDER by nome asc LIMIT " & inicial & "," & final & ";")
			else
			   set rs = createobject("adodb.recordset")
			   set rs.activeconnection = conexao
			   rs.cursortype = 3
			   rs.pagesize = final
			   rs.open "SELECT * FROM produtos " & restinho & " ORDER by nome asc"
			end if

			If rs.EOF Or rs.bof Then

			strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Excluir produtos na loja</B></FONT><hr size=1 color=#cccccc>"
			strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=100><tr><td>"
			strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Produtos(s) encontrado(s): <b>0" & totalreg & "</b> <hr size=1 color=#dddddd width=""100%"">"
			strTextoHtml = strTextoHtml & "<table cellspacing=""3"" cellpadding=""3"" align=center width=""100%"">"
			strTextoHtml = strTextoHtml & "<tr><form action=""?"" method=get><input name=""link"" type=""hidden"" value=""produtos""><input name=""acao"" type=""hidden"" value=""excluir"">"
			strTextoHtml = strTextoHtml & "<td align=center><font face=""tahoma"" style=font-size:11px;color:000000><center>Para uma busca mais detalhada dos produtos na loja realize uma pesquisa com o nome e/ou palavra-chave do produto  que você procura.</td><tr><td align=center>"
			strTextoHtml = strTextoHtml & "<input name=""pesqsa"" type=""text"" value=""" & Request("pesqsa") & """ style=font-size:11px;color:000000;font-family:tahoma><font style=font-size:11px> em <select name=cat style=font-size:11px;font-family:tahoma>"
			strTextoHtml = strTextoHtml & "<option value=todos>toda loja</option>"
			strTextoHtml = strTextoHtml & "<option value=xxx>--------------------</option>"
			Set Menu = conexao.Execute("SELECT * FROM sessoes ORDER by nome;")
			While Not Menu.EOF
			strTextoHtml = strTextoHtml & "<option value=""" & Menu("id") & """  "
			If CStr(catege) = CStr(Menu("id")) Then
			strTextoHtml = strTextoHtml & "selected"
			End If
			strTextoHtml = strTextoHtml & ">" & LCase(Menu("nome")) & "</option>"
			Menu.movenext
			Wend
			Menu.Close
			Set Menu = Nothing
			 
			strTextoHtml = strTextoHtml & "</select></font> <input type=submit class=""ok"" value=""Pesquisar"" style=font-size:11px;color:000000;font-family:tahoma>"
			strTextoHtml = strTextoHtml & "</td></form></tr><tr><td height=1 bgcolor=cccccc></td></tr></table><br><br>"
			strTextoHtml = strTextoHtml & "<table width=565 align=center>"
			strTextoHtml = strTextoHtml & "<tr><td align=center><br><br><b><font style=font-size:11px>Nenhum produto foi encontrado na base de dados da loja.<br><br></b><br><br></td></tr></table>"
			strTextoHtml = strTextoHtml & "<br></table>"
			strTextoHtml = strTextoHtml & "<table width=""100%"" cellspacing=""0"" cellpadding=""0""><tr><td colspan=2>"
			strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc width=""101%""></td></tr><tr><td></td><td align=right><font face=""tahoma"" style=font-size:11px;color:000000>"
			strTextoHtml = strTextoHtml & "&nbsp;<font face=""tahoma"" style=font-size:11px>Página(s): <b><u>1</u></b></font></td></tr>"
			strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
			strTextoHtml = strTextoHtml & "</tr></table><td></tr></table>"

			Else
			Set rs2 = conexao.Execute("SELECT count(nome) AS total FROM produtos " & restinho & ";")
			totalreg = rs2("total")
			rs2.Close
			Set rs2 = Nothing
			numiz = Request("pagina") & "0"
			numiz = CInt(numiz)
			iz = iz + numiz

			strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Excluir produtos na loja</B></FONT><hr size=1 color=#cccccc>"
			strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=100><tr><td>"
			strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Produtos(s) encontrado(s): <b>" & totalreg & "</b> <hr size=1 color=#dddddd width=""100%"">"
			strTextoHtml = strTextoHtml & "<table cellspacing=""3"" cellpadding=""3"" align=center width=""100%"">"
			strTextoHtml = strTextoHtml & "<tr><form action=""?"" method=get><input name=""link"" type=""hidden"" value=""produtos""><input name=""acao"" type=""hidden"" value=""excluir"">"
			strTextoHtml = strTextoHtml & "<td align=center><font face=""tahoma"" style=font-size:11px;color:000000><center>Para uma busca mais detalhada dos produtos na loja realize uma pesquisa com o nome e/ou palavra-chave do produto  que você procura.</td><tr><td align=center>"
			strTextoHtml = strTextoHtml & "<input name=""pesqsa"" type=""text"" value=""" & Request("pesqsa") & """ style=font-size:11px;color:000000;font-family:tahoma><font style=font-size:11px> em <select name=cat style=font-size:11px;font-family:tahoma>"
			strTextoHtml = strTextoHtml & "<option value=todos>toda loja</option>"
			strTextoHtml = strTextoHtml & "<option value=xxx>--------------------</option>"
			Set Menu = conexao.Execute("SELECT * FROM sessoes ORDER by nome;")
			While Not Menu.EOF
			strTextoHtml = strTextoHtml & "<option value=""" & Menu("id") & """  "
			If CStr(catege) = CStr(Menu("id")) Then
			strTextoHtml = strTextoHtml & "selected"
			End If
			strTextoHtml = strTextoHtml & ">" & LCase(Menu("nome")) & "</option>"
			Menu.movenext
			Wend
			Menu.Close
			Set Menu = Nothing
			 
			strTextoHtml = strTextoHtml & "</select></font> <input type=submit class=""ok"" value=""Pesquisar"" style=font-size:11px;color:000000;font-family:tahoma>"

			strTextoHtml = strTextoHtml & "</td></form></tr><tr><td height=1 bgcolor=cccccc></td></tr></table>"

			If Request("status") = "sucesso" Then
			strTextoHtml = strTextoHtml & "<br><center><b><font style=font-size:11px;font-family:tahoma;color:#003366>PRODUTO EXCLUÍDO COM SUCESSO!<br><br></font></b></center>"
			Else
			strTextoHtml = strTextoHtml & "<br><br>"
			End If

			strTextoHtml = strTextoHtml & "<table width=""100%"" align=center>"

			If VersaoDb = 1 then

			While Not rs.EOF
			iz = iz + 1
			If rs("estoque") = "s" Then
			varestoq = "<font color=#000000>Visível</font>"
			Else
			varestoq = "<font color=#b23c04>Não Visível </font>"
			End If

				if VersaoDb = 1 Then
				   'Set rs3 = conexao.Execute("SELECT nome FROM categoria WHERE idcategoria = '" & rs("idsessao") & "';")
				   Set rs3 = conexao.Execute("SELECT B.NOME AS SESSAO FROM CATEGORIA AS A, SESSOES AS B WHERE A.IDSESSAO = B.ID AND idcategoria='" & rs("idsessao")& "';")
				else
				   'Set rs3 = conexao.Execute("SELECT nome FROM categoria WHERE idcategoria =" & rs("idsessao"))
				   Set rs3 = conexao.Execute("SELECT B.NOME AS SESSAO FROM CATEGORIA AS A, SESSOES AS B WHERE A.IDSESSAO = B.ID AND idcategoria=" & rs("idsessao"))
				end if

			varsessao = rs3("Sessao")

			strTextoHtml = strTextoHtml & "<script language=""javascript"">" & vbNewLine
			strTextoHtml = strTextoHtml & "function prod" & rs("idprod") & "(){" & vbNewLine
			strTextoHtml = strTextoHtml & "if (confirm('Você realmente deseja excluir este produto?'))" & vbNewLine
			strTextoHtml = strTextoHtml & "{" & vbNewLine
			strTextoHtml = strTextoHtml & "window.location.href('?link=produtos&acao=exclui&prod=" & rs("idprod") & "');" & vbNewLine
			strTextoHtml = strTextoHtml & "}" & vbNewLine
			strTextoHtml = strTextoHtml & "else" & vbNewLine
			strTextoHtml = strTextoHtml & "{" & vbNewLine
			strTextoHtml = strTextoHtml & "}}" & vbNewLine
			strTextoHtml = strTextoHtml & "</script>" & vbNewLine


			strTextoHtml = strTextoHtml & "<tr><td align=left valign=center>"
			strTextoHtml = strTextoHtml & "<table width=""100%"" bgcolor=#eeeeee style='border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;'><tr><td valign=center><font face=""tahoma"" style=font-size:11px;color:000000>" & iz & ") <b>" & UCase(rs("nome")) & "</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Depto: <b>" & varsessao & "</b> &nbsp;&nbsp;&nbsp;Estoque: <b>" & varestoq & "</b></td><td align=right valign=middle><font face=""tahoma"" style=font-size:11px;color:000000>Ação: <b><a href=?link=produtos&acao=ver&prod=" & rs("idprod") & "&modo=exclui>Ver</a></b> | <b><a href=""javascript: prod" & rs("idprod") & "();"">Excluir</a></b>&nbsp;</td></tr></table> <table><tr><td height=4></td></tr></table>"
			rs.movenext
			pagn = inicial + 20
			Wend


			paga = pagn - 20

			If totalreg Mod 20 <> 0 Then
			valor = 1
			Else
			valor = 0
			End If
			pagina = Fix(totalreg / 20) + valor
			pagina = Replace(pagina, ",", "")
			pagdxx = pagdxx + 1
			pagdxx = Replace(pagdxx, ",", "")
			pagdxx2 = pagdxx - 2
			pagdxx2 = Replace(pagdxx2, ",", "")
			paga = Replace(paga, ",", "")
			pagn = Replace(pagn, ",", "")
			If pagdxx = "" Then pagdxx = 1
			If pagina = "0" Then pagina = "1"

			strTextoHtml = strTextoHtml & "<table width=565>"
			strTextoHtml = strTextoHtml & "<tr><td colspan=2>"
			strTextoHtml = strTextoHtml & "<center><br>"

			If paga < 0 Then
			paga = 0
			Else

			strTextoHtml = strTextoHtml & "<a HREF=""?link=produtos&acao=excluir&itens=" & paga & "&pagina=" & pagdxx2 & "&pesqsa=" & pesqsa & "&cat=" & catege & """ style=""color:000000""><font face=""tahoma"" style=font-size:11px><b>Página Anterior</b></a></font>&nbsp;&nbsp;"

			End If
			If totalreg < final Or totalreg = 20 Or pagdxx = pagina Then
			totalreg = ""
			npc = 1
			totalp = 1
			Else
			variavel1 = CStr(pagdxx + 1)
			variavel2 = CStr(pagina)
			variavel1 = Replace(variavel1, ",", "")
			variavel2 = Replace(variavel2, ",", "")
			strTextoHtml = strTextoHtml & "&nbsp;&nbsp;<a HREF=""?link=produtos&acao=excluir&itens=" & pagn & "&pagina=" & pagdxx & "&pesqsa=" & pesqsa & "&cat=" & catege
			If variavel1 = variavel2 Then
			strTextoHtml = strTextoHtml & "&final=sim"""
			End If
			strTextoHtml = strTextoHtml & " style=""color:000000""><font face=""tahoma"" style=font-size:11px><b>Próxima página</b></a></font>"
			End If
			strTextoHtml = strTextoHtml & "<table width=100% cellspacing=""0"" cellpadding=""0""><tr><td colspan=2>"
			strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc width=""101%""></td></tr><tr><td><font face=""tahoma"" style=font-size:11px;color:000000>Página <B>" & pagdxx & "</B> de <B>" & pagina & "</B></td><td align=right><font face=""tahoma"" style=font-size:11px;color:000000>"
			If pagina = 1 Then
			finalera = "sim"
			End If
			If pagina <> 1 Then
			For i = 1 To pagina - 1
			i = Replace(i, ",", "")
			i2 = i - 1
			i2 = Replace(i2, ",", "")
			fator = 20
			totalfator = fator * i - 20
			totalfator = Replace(totalfator, ",", "")
			paginadem = pagdxx
			paginadem = Replace(paginadem, ",", "")
			strTextoHtml = strTextoHtml & " &nbsp;<a HREF=""?link=produtos&acao=excluir&itens=" & totalfator & "&pagina=" & i2 & "&pesqsa=" & pesqsa & "&cat=" & catege & """ style=""color:000000""><font face=""tahoma"" style=font-size:11px>"
			If paginadem = i Then
			strTextoHtml = strTextoHtml & "<b><u>"
			End If
			strTextoHtml = strTextoHtml & Replace(i, ",", "") & "</u></b></a> &middot;</font>"
			Next
			End If
			pagina2 = pagina * 20 - 20
			pagina2 = Replace(pagina2, ",", "")
			pagina3 = pagina - 1
			pagina3 = Replace(pagina3, ",", "")
			strTextoHtml = strTextoHtml & " &nbsp;<a HREF=""?link=produtos&acao=excluir&itens=" & pagina2 & "&pagina=" & pagina3 & "&pesqsa=" & pesqsa & "&cat=" & catege & "&final=sim"" style=""color:000000""><font face=""tahoma"" style=font-size:11px>"
			If finalera = "sim" Then
			strTextoHtml = strTextoHtml & "<b><u>"
			End If
			strTextoHtml = strTextoHtml & pagina & "</u></b></a></td></tr>"
			else

			pag = request.querystring("pagina")
			if pag = "" Then
			   pag = 1
			end if

			contador = 0
			rs.absolutepage = pag
			while not rs.eof and contador < rs.pagesize
			contador = contador +1

			iz = iz + 1
			If rs("estoque") = "s" Then
			varestoq = "<font color=#000000>Visível</font>"
			Else
			varestoq = "<font color=#b23c04>Não Visível </font>"
			End If

				if VersaoDb = 1 Then
				   'Set rs3 = conexao.Execute("SELECT nome FROM categoria WHERE idcategoria = '" & rs("idsessao") & "';")
				   Set rs3 = conexao.Execute("SELECT B.NOME AS SESSAO FROM CATEGORIA AS A, SESSOES AS B WHERE A.IDSESSAO = B.ID AND idcategoria='" & rs("idsessao")& "';")
				else
				   'Set rs3 = conexao.Execute("SELECT nome FROM categoria WHERE idcategoria =" & rs("idsessao"))
				   Set rs3 = conexao.Execute("SELECT B.NOME AS SESSAO FROM CATEGORIA AS A, SESSOES AS B WHERE A.IDSESSAO = B.ID AND idcategoria=" & rs("idsessao"))
				end if

				varsessao = rs3("Sessao")

			strTextoHtml = strTextoHtml & "<script language=""javascript"">" & vbNewLine
			strTextoHtml = strTextoHtml & "function prod" & rs("idprod") & "(){" & vbNewLine
			strTextoHtml = strTextoHtml & "if (confirm('Você realmente deseja excluir este produto?'))" & vbNewLine
			strTextoHtml = strTextoHtml & "{" & vbNewLine
			strTextoHtml = strTextoHtml & "window.location.href('?link=produtos&acao=exclui&prod=" & rs("idprod") & "');" & vbNewLine
			strTextoHtml = strTextoHtml & "}" & vbNewLine
			strTextoHtml = strTextoHtml & "else" & vbNewLine
			strTextoHtml = strTextoHtml & "{" & vbNewLine
			strTextoHtml = strTextoHtml & "}}" & vbNewLine
			strTextoHtml = strTextoHtml & "</script>" & vbNewLine
			strTextoHtml = strTextoHtml & "<tr><td align=left valign=center>"
			strTextoHtml = strTextoHtml & "<table width=""100%"" bgcolor=#eeeeee style='border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;'><tr><td valign=center><font face=""tahoma"" style=font-size:11px;color:000000>" & iz & ") <b>" & UCase(rs("nome")) & "</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Depto: <b>" & varsessao & "</b> &nbsp;&nbsp;&nbsp;Estoque: <b>" & varestoq & "</b></td><td align=right valign=middle><font face=""tahoma"" style=font-size:11px;color:000000>Ação: <b><a href=?link=produtos&acao=ver&prod=" & rs("idprod") & "&modo=exclui>Ver</a></b> | <b><a href=""javascript: prod" & rs("idprod") & "();"">Excluir</a></b>&nbsp;</td></tr></table> <table><tr><td height=4></td></tr></table>"

			rs.movenext
			wend
			strTextoHtml = strTextoHtml & "<table width=565>"
			strTextoHtml = strTextoHtml & "<tr><td colspan=2>"
			strTextoHtml = strTextoHtml & "<center><br>"

			strTextoHtml = strTextoHtml & "<table width=100% cellspacing=""0"" cellpadding=""0""><tr><td colspan=2>"
			strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc width=""101%""></td></tr><tr><td colspan=2 align=right><font face=""tahoma"" style=font-size:11px;color:000000>"

			strTextoHtml = strTextoHtml & "Página(s):&nbsp;&nbsp;"

			for i = 1 to rs.pagecount

			if i = cint(pag) then
			   strTextoHtml = strTextoHtml & "<u><b>" & i & "</b></u> "
			else
			   strTextoHtml = strTextoHtml & "<a href='?link=produtos&acao=excluir&acaba=sim&pagina=" & i & "&pesqsa=" & pesqsa & "&cat=" & catege & "'>" & i & "</a> "
			end if

			next

			strTextoHtml = strTextoHtml & "</td></tr>"
			end if

			strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
			strTextoHtml = strTextoHtml & "</tr></table></td></tr></table> </td></tr></table></td></tr></table></td></tr></table>"
			rs.Close
			Set rs = Nothing
			End If
Case "exclui"
			notz = Request.QueryString("prod")
			on error resume next
			Set excluidados = conexao.Execute("SELECT imgra,impeq from produtos where idprod=" & notz & ";")
			Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
			objFSO.DeleteFile (Server.MapPath("produtos/" & excluidados("imgra") & ""))
			objFSO.DeleteFile (Server.MapPath("produtos/" & excluidados("impeq") & ""))
			Set objFSO = Nothing

'###############################################
'## CORRIGE BUG DE EXCLUIR
'## EXCLUI DADOS DA TABELA ESTOQUE TB
'###############################################
			SQLD = "delete from produtos where idprod=" & notz & ";"
			Set dados = conexao.Execute(SQLD)

			strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px><b>APAGANDO PRODUTO....<br>por favor aguarde!</b></font>"

			SQLE = "delete from estoque where idproduto=" & notz & ";"
			Set Estq = conexao.Execute(SQLE)


			Response.write "<meta http-equiv='refresh' content='3;URL=?link=produtos&acao=excluir&status=Redir'>"


			SQLD = "delete from produtos where idprod=" & notz & ";"
			Set dados = conexao.Execute(SQLD)

			SQLE = "delete from estoque where idproduto=" & notz & ";"
			Set Estq = conexao.Execute(SQLE)

'###############################################
'## CORRIGE BUG DE EXCLUIR
'## EXCLUI DADOS DA TABELA ESTOQUE TB
'###############################################
response.flush
response.clear
CASE "estoque"
%>
<!--#include file="adm_estoque.asp"--> <% 'Nome antigo era mostra_estoque.asp %>
<%
End Select
'End Sub

Set ScriptObject =nothing
%>