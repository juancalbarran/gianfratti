<title>Cotação do Dolar</title>
<% 
Set XMLHttp = Server.CreateObject("Microsoft.XMLHTTP") 
XMLHttp.open "GET", "http://www.bcb.gov.br/htms/infecon/taxas/taxas.htm", false 
XMLHttp.send() 
pega = XMLHttp.ResponseText 
cotacao = LCase(pega) 
Set cod = Nothing 

i = 1 
teste = cotacao 
i = inStr(i,cotacao,"taxa de venda") 
i = inStr(i,cotacao,"<tr>") 
i = inStr(i,cotacao,"<td") 
i = inStr(i,cotacao,">") 
f = inStr(i,cotacao,"</td>") 
cotacao_data = Mid(cotacao,i,(f-i)) 
cotacao_data = Replace(cotacao_Data,">"," ") 
i = inStr(f,cotacao,"<td ") 
i = inStr(i,cotacao,">") 
f = inStr(i,cotacao,"</td>") 
cotacao_venda = Mid(cotacao,i,(f-i)) 
cotacao_venda = Replace(cotacao_venda,">"," ") 
i = inStr(f,cotacao,"<td ") 
i = inStr(i,cotacao,">") 
f = inStr(i,cotacao,"</td>") 
cotacao_compra = Mid(cotacao,i,(f-i)) 
cotacao_compra = Replace(cotacao_compra,">"," ") 

response.write "Data: "&cotacao_data&"<br>" 
response.write "Dolar Venda: "&cotacao_venda&"<br>" 
response.write "Dolar Compra : "&cotacao_compra&"<br>" 
%> 
