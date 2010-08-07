<% 
'INÍCIO DO CÓDIGO

'Este código está otimizado e roda tanto em Windows 2000/NT/XP/ME/98 quanto em servidores UNIX-LINUX com chilli!ASP
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
		response.redirect "carrinhodecompras.asp?Tarifa=0&atualiza=ok"
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

if Cstr(Request("vvcep")) = Cstr("") and request("modo_entrega")="sedex" then
	response.redirect "carrinhodecompras.asp?Tarifa=0&atualiza=ok"
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
UrlRetorno = Replace(UrlRetorno, "atualizapedido.asp", "carrinhodecompras.asp?atualiza=ok")

if Session("PesoTotalFrete") < 1 then
   Session("PesoTotalFrete")=1
   else
   if instr(Session("PesoTotalFrete"),",")<>0 then
      Session("PesoTotalFrete")=replace(Session("PesoTotalFrete"),",",".")
	  else
	  if Session("PesoTotalFrete") > 30 then
	  Session("PesoTotalFrete")=30
      end if
   end if
end if

'response.write "<br>modo_entrega :"&request.querystring("modo_entrega")
'response.end

if request.querystring("modo_entrega")="motoboy" then
	session("modo_entrega")="motoboy"
	final=tarifa_entrega_motoboy
elseif request.querystring("modo_entrega")="download" then
	session("modo_entrega")="download"
	final=tarifa_entrega_download

elseif request.querystring("modo_entrega")="encomenda" then
	session("modo_entrega")="encomenda"
	estado = request("estado")
		pesoz = int(pesototal)
	estadozx = mid(estado,2,3)
	fretexz = right(estado,1)
numerox = left(estado,1)
if numerox = "" then
end if
if fretexz = "c" then
sqlq = "SELECT * FROM fretes WHERE localidade='pesocapital';"
else
sqlq = "SELECT * FROM fretes WHERE localidade='pesointerior';"
end if
Set dadosz = abredb.Execute(sqlq)
if dadosz.EOF or dadosz.BOF then
regi = "0,00"
else
regi = dadosz("re"&numerox&"")
end if
dadosz.close
Set dadosz = nothing
fretez = right(estado,1)
	numero = left(estado,1)
	if fretez = "c" then
	sql = "SELECT * FROM fretes WHERE localidade='capital';"
	else
	sql = "SELECT * FROM fretes WHERE localidade='interior';"
	end if
	Set dados = abredb.Execute(sql)
	if dados.EOF or dados.BOF then
	regiao = "0,00"
	else
	regiao = dados("re"&numero&"")
	end if

if pesoz <= 1 then
final = regiao

end if
if pesoz > 1 AND pesoz <= 2 then
final = regiao + (regi * 1)

end if
if pesoz > 2 AND pesoz <= 3 then
final = regiao + (regi * 2)

end if
if pesoz > 3 AND pesoz <= 4 then
final = regiao + (regi * 3)

end if
if pesoz > 4 AND pesoz <= 5 then
final = regiao + (regi * 4)

end if
if pesoz > 5 AND pesoz <= 6 then
final = regiao + (regi * 5)

end if
if pesoz > 6 AND pesoz <= 7 then
final = regiao + (regi * 6)

end if
if pesoz > 7 AND pesoz <= 8 then
final = regiao + (regi * 7)

end if
if pesoz > 8 AND pesoz <= 9 then
final = regiao + (regi * 8)

end if
if pesoz > 9 AND pesoz <= 10 then
final = regiao + (regi * 9)

end if
if pesoz > 10 AND pesoz <= 11 then
final = regiao + (regi * 10)

end if
if pesoz > 11 AND pesoz <= 12 then
final = regiao + (regi * 11)

end if
if pesoz > 12 AND pesoz <= 13 then
final = regiao + (regi * 12)

end if
if pesoz > 13 AND pesoz <= 14 then
final = regiao + (regi * 13)

end if
if pesoz > 14 AND pesoz => 15 then
final = regiao + (regi * int(pesoz))
end if

	'final = regi+intFrete
	session("PesoTotalValor") = left(final, 4)
response.redirect ("carrinhodecompras.asp?frete="&estadozx&"&atualiza=ok")

else
	
	session("modo_entrega")="sedex"
	'*** Rotina p/ permitir testar no modo Offline o valor do Sedex
	if sem_calculo_online_SiteCorreios="Sim" and Request.ServerVariables("SERVER_NAME") = "localhost" then
	final=10 
	else
	
		if cobrar_seguro_produto="N" then
		suacompra=0 'Para nao cobrar o valor de Seguro (1% do valor da compra)
		end if
	
		url_correios="http://www.correios.com.br/encomendas/precos/calculo.cfm?Servico=40010&CepDestino=" & session("PesoTotalCep") & "&CepOrigem=" & application("CORREIOSseucep11") & "&Peso=" & Session("PesoTotalFrete") & "&AvisoRecebimento=" & application("CORREIOSaviso11") & "&ValorDeclarado=" & Replace(suacompra, ".", "") & "&MaoPropria=" & application("CORREIOSmaop11")
		Set objXMLHTTP = CreateObject("Microsoft.XMLHTTP")
		objXMLHTTP.open "post", url_correios,false
		
		objXMLHTTP.send
		ValorBox = objXMLHTTP.responseText
		set objXMLHTTP = nothing
		primeira_tarifa = right(valorbox,len(valorbox)-instr(valorbox,"Tarifa"))
		segunda_tarifa = right(primeira_tarifa,len(primeira_tarifa)-instr(primeira_tarifa,"Tarifa"))
		final = replace(replace(left(right(segunda_tarifa,len(segunda_tarifa)-6),5),"&",""),".",",")
		final = left(final,instr(final,"e")-1)
		
	end if

end if
session("PesoTotalValor")=final

'*** Para verificar mensagens de erro

'response.write "<br>final :"&final

'response.write url_correios

'response.end

response.redirect UrlRetorno
%>
<table width=590 align=center><tr><td><font face=<%=fonte%> style=font-size:11px><b><br>Atualizando... por favor aguarde.</b></td></tr></table>
   </td></tr>
  </table></td></tr>
 </table>
 <!-- #include file="baixo.asp" -->
