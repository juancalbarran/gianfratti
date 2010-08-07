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

'INÍCIO DO CÓDIGO

'Este código está otimizado e roda tanto em Windows 2000/NT/XP/ME/98 quanto em servidores UNIX-LINUX com chilli!ASP


'*** ATENCAO: Antes de usar este codigo , compare com o arquivo original atualizapedido.asp para ver se existe atualizacoes a serem feitas neste codigo abaixo


%>
<!-- #include file="topo.asp" -->
<%
session("PesoTotalCep") = Replace(Replace(Replace(Replace(Request("vvcep"), "-", ""), "/", ""), "\", ""), "'", "")

'Remove os itens do carrinho do compras
if request.querystring("acao") = "remover" then
	produtoz = request.querystring("produto")
	intOrderID = cstr(Session("orderID"))
	abredb.Execute("DELETE FROM pedidos WHERE idcompra='"&intOrderID&"' AND idprod='"&produtoz&"';")

'#########################################################################################
'#----------------------------------------------------------------------------------------
'# CONTROLE DE ESTOQUE POR ROGERIO SILVA
'#  O controle que estava originalmente nos arquivos comprar.asp e atualizapedido.asp foi removido destes 
'#  e readaptado para o arquivo pagamento.asp aqui para que a "baixa" do estoque seja realizado
'#  somente na Finalizacao da Compra qdo houve a real saída do produto do estoque 
'#########################################################################################

		if Cstr(Request("vvcep")) = Cstr("") then
		response.redirect "carrinhodecompras.asp?Tarifa=0"
		end if
else
	'cria o valor do frete
	session("estado2") = request("frete")%>
	<div id="layer1" style="position:absolute; left:-2px; top:5px; z-index:4"><div id="layer1" style="position:absolute; left:181px; top:126px; z-index:4"><font face="<%=fonte%>" style=font-size:11px;color:000000> <a href=default.asp style=text-decoration:none; onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg4%>';return true;"><b><%=strLg4%></b></a> » <%=strLg1%><br><br><div align=left> <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table></div>
	<%
	'Retorna se a compra estiver vazia
	if cstr(Session("orderID")) = "" then%>
		<br><br><div align=center><p><font face=<%=fonte%> style=font-size:17px><b><%=strLg49%><br> <%=strLg50%><br><br></b><a href=default.asp><img src="<%=dirlingua%>/imagens/continuar.gif" onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg68%>';return true;" border=0></a><b></font></p></div><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table>
		<%
		response.end
	else
		'Calcula os itens no carrinho de compra
		intOrderID = cstr(Session("orderID"))
		set rsProd = abredb.Execute("SELECT * FROM pedidos WHERE idcompra='"&intOrderID&"';")
			if rsProd.EOF and rsProd.BOF then
				rsProd.close
				set rsProd = Nothing
				Session("orderID") = ""
			else
				do while not rsProd.EOF
				element = "quant" & rsProd("idprod")
				intQuant = Request.form(element)
				intQuantz = rsProd("idprod")
					if intQuant <> "" and isNumeric(intQuant) then
						if intQuant = 0 then 
						end if
					set rsProd1 = abredb.Execute("update pedidos set quantidade='"&intQuant&"' WHERE idcompra='"&intOrderID&"' AND idprod='"&intQuantz&"';")
					end if
				rsProd.MoveNext
				loop
				rsprod.close
				set rsProd = Nothing
			end if
	end if
end if

if Cstr(Request("vvcep")) = Cstr("") then
	response.redirect "carrinhodecompras.asp?Tarifa=0"
end if

'##########################################################
'##########################################################
'##########################################################
'CALCULO DE FRETE USANDO A ROTINA DOS CORREIOS
'Chama os produtos comprados
intOrderID = Session("orderID")
set pedidos = abredb.Execute("SELECT idprod, quantidade FROM pedidos WHERE idcompra='" & intOrderID & "'")
	if pedidos.eof then

	else
		while not pedidos.EOF
		idprod = pedidos("idprod")
		quantidade = pedidos("quantidade")
		set produtos = abredb.Execute("SELECT preco, nome, peso FROM produtos WHERE idprod="&idprod&";")
		preco = produtos("preco")
		peso = produtos("peso")
		nome = produtos("nome")
		intProdID = idprod
		strProdNome = nome
		pesoz = peso
		intProdPrice = preco
		intQuant = quantidade
			if session("estado") = "" then
				intFrete = 0
			else
				intFrete = valorfrete
			end if
		'Calcula o total do frete
		intTotalFrete = intTotalFrete + (intQuant * intProdPrice)	
		intTotal = intTotalFrete + intFrete	
		subpreco = formatNumber(intProdPrice,2)
		totpreco = formatNumber((intQuant * intProdPrice),2)
		pesototal = 1 + FormatNumber(pesototal, 3) + FormatNumber((produtos("peso") * intQuant), 3) - 1
		produtos.Close
		set produtos = Nothing
		pedidos.MoveNext
		wend
	end if
	pedidos.Close
	set pedidos = Nothing
Session("PesoTotalFrete") = FormatNumber(pesototal, 3)
suacompra = formatNumber(intTotal,2)

'--> Session("PesoTotalFrete") 'Peso Total
'--> application("CORREIOSseucep11") 'CEP da Loja
'--> application("CORREIOSmaop11") 'Mao Propria
'--> application("CORREIOSaviso11") 'Aviso de Recebimento
'--> session("PesoTotalCep") 'CEP do cliente
'--> suacompra 'Valor Declarado

'*** Para verificacoes em caso de erro
'response.write "<br>PesoTotalCep :"&session("PesoTotalCep")
'response.write "<br>CORREIOSseucep11 :"&application("CORREIOSseucep11")
'response.write "<br>PesoTotalFrete :"&Session("PesoTotalFrete")
'response.write "<br>CORREIOSaviso11 :"&application("CORREIOSaviso11")
'response.write "<br>CORREIOSmaop11 :"&application("CORREIOSmaop11")
'response.write "<br>suacompra :"&suacompra
'response.end

UrlRetorno = "http://" & request.servervariables("Server_Name") & request.servervariables("Url")
UrlRetorno = Replace(UrlRetorno, "atualizapedido.asp", "carrinhodecompras.asp")

'*** Inicio do Codigo especial para uso do componente sedex da Locaweb
Set Sedex_obj = CreateObject("Correios.Sedex")
cod_sedex = "40010"
ValorBox = Sedex_obj.Tarifacao(CStr(cod_sedex), CStr(application("CORREIOSseucep11")),CStr(session("PesoTotalCep")), CDbl(peso_total), CDbl(suacompra))
If Sedex_obj.Erro <> 0 Then
Response.Write Sedex_obj.DescricaoErro
ValorBox = 0
Else
' o Sedex inclui uma taxa de 1% de seguro. Se quiser incluir 
' esse custo, eh so colocar
ValorBox = ValorBox + 0.01*total
End If
response.write "<script>parent.location= '"&UrlRetorno&"?parametro=tarifa&parametro=resultado&Servico=40010&Tarifa="&ValorBox&"'</script>"
Set Sedex_obj = Nothing
response.write Replace(Replace(mid(ValorBox, instr(ValorBox, "<Script"), 999), "</body>", ""), "</html>", "")
'*** Fim do Codigo especial para uso do componente sedex da Locaweb

session("PesoTotalValor")=ValorBox

%>
<table width=590 align=center><tr><td><font face=<%=fonte%> style=font-size:11px><b><br>Atualizando... por favor aguarde.</b></td></tr></table>
   </td></tr>
  </table></td></tr>
 </table>
 <!-- #include file="baixo.asp" -->
