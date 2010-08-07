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
%>

<!--#include file="topo.asp"-->
<!--#include file="extenso.asp"-->
<!--#include file="checacartao.asp"-->
<!--#include file="email.asp"-->

<%
'Chama as variaveis para finalizar compra
strPedido = Request.Form("pedido1")
strNome = Request.Form("nome1")
strEndereco = request.form("ende1")
strBairro = request.form("bairro1")
strCidade = request.form("cidade1")
strEstado = request.form("est1")
strCep = request.form("cep1")
strPais = request.form("pais1")
strFone = request.form("fone1")
strCompq = request.form("compra1")
freteqwy = request.form("frete1")
strCartao = Request.Form("cartao")
strTitular = Request.Form("titularcartao")
strExpmes = Request.Form("cartaomes")
strExpano = Request.Form("cartaoano")
strTotalCompra = Request.form("totalcompra")
numero = Request.Form("numerocartao")
codigo_seguranca = Request.Form("codigo_seguranca")
vencimento = Request.form("cartaomes") & "/" & Request.form("cartaoano")

Dim brpay_imputs
Dim brpay_count

brpay_imputs = ""
brpay_count = 0

'Verifica o tipo de cartão de credito
if strCartao = "M" or strCartao = "V" or strCartao = "D" or strCartao = "A" then

'Tira letras do numero
s=""
for x=1 to len(numero)
ch=mid(numero,x,1)
if asc(ch)>=48 and asc(ch)<=57 then
s=s & ch
end if
next
numero = s

'Valida numeros genericos
If numero = "4111111111111111" OR numero = "5500000000000004" OR numero = "340000000000009" OR numero = "30000000000004" OR numero = "60110000000004" then
erro = strLg210
abredb.close
set abredb = nothing
response.redirect "formaspagamento.asp?erro=" & erro & "&endereco="&strEndereco&"&bairro="&strBairro&"&cidade="&strCidade&"&cep="&strCep&"&fone="&strFone&"&estado="&strEstado&"&pais="&strPais&"&outropais="&strOutropais&"&#pagamento"
end if

if len(vencimento) > 7 or strTitular= "" then
erro = strLg251
abredb.close
set abredb = nothing
response.redirect "formaspagamento.asp?erro=" & erro & "&endereco="&strEndereco&"&bairro="&strBairro&"&cidade="&strCidade&"&cep="&strCep&"&fone="&strFone&"&estado="&strEstado&"&pais="&strPais&"&outropais="&strOutropais&"&#pagamento"
end if

'Valida os numeros
If numero <> "" then
chk=checkcc(numero,strCartao)
If chk = 1 then
erro = strLg210
abredb.close
set abredb = nothing
response.redirect "formaspagamento.asp?erro="&erro
elseif chk = 2 then
erro = strLg211
abredb.close
set abredb = nothing
response.redirect "formaspagamento.asp?erro="&erro
elseif chk = 3 then
erro =  strLg212
abredb.close
set abredb = nothing
response.redirect "formaspagamento.asp?erro="&erro
elseif chk = 4 then
erro =  strLg213
abredb.close
set abredb = nothing
response.redirect "formaspagamento.asp?erro="&erro
elseif chk = 5 then
erro =  strLg214
abredb.close
set abredb = nothing
response.redirect "formaspagamento.asp?erro="&erro
elseif chk = 6 then
erro =  strLg215
abredb.close
set abredb = nothing
response.redirect "formaspagamento.asp?erro="&erro
elseif chk = 7 then
erro =  strLg216
abredb.close
set abredb = nothing
response.redirect "formaspagamento.asp?erro="&erro
elseif chk = 8 then
erro = strLg210
abredb.close
set abredb = nothing
response.redirect "formaspagamento.asp?erro="&erro
end if
else
erro = strLg217
abredb.close
set abredb = nothing
response.redirect "formaspagamento.asp?erro="&erro
end if
If strExpmes = "" OR strExpano = "" then
erro = strLg218
abredb.close
set abredb = nothing
response.redirect "formaspagamento.asp?erro="&erro
end if
validadata = day(now) & "/" & strExpmes & "/" & strExpano
if cdate(validadata) < cdate(date) then
erro = strLg219
abredb.close
set abredb = nothing
response.redirect "formaspagamento.asp?erro="&erro
end  if
If strTitular = "" OR len(strTitular) <5 then
erro = strLg220
abredb.close
set abredb = nothing
response.redirect "formaspagamento.asp?erro="&erro
end if
end if

'Grava os dados da compra na matriz
intOrderID = Request.form("idcompra")
if strCartao = "M" then
txtpagamento = strLg221
strCartao = "1"
venccob = "-"
numerocob = "-"
end if
if strCartao = "V" then
txtpagamento = strLg222
strCartao = "0"
venccob = "-"
numerocob = "-"
end if
if strCartao = "A" then
txtpagamento = strLg223
strCartao = "3"
venccob = "-"
numerocob = "-"
end if
if strCartao = "D" then
txtpagamento = strLg224
strCartao = "2"
venccob = "-"
numerocob = "-"
end if
if strCartao = "sc" then
txtpagamento = strLg225
strCartao = "4"
venccob = cdate(date) + vencboleto
end if
if strCartao = "di" then
txtpagamento = strLg226
strCartao = "5"
venccob = cdate(date) + vencboleto
end if
if strCartao = "db" then
txtpagamento = strLg227
venccob = cdate(date) + vencboleto
'numerocob = "-"
strCartao = "6"
end if

if strCartao = "bl" then
txtpagamento = strLg266
venccob = cdate(date) + vencboleto
numerocob = "-"
strCartao = "7"
end if

if strCartao = "BRpay" then
txtpagamento = strLg300
venccob = "-"
'numerocob = "-"
strCartao = "8"
end if

if strCartao = "ch" then
txtpagamento = strLg323
venccob = cdate(date) + vencboleto
numerocob = "-"
strCartao = "9"
end if

'Formata  a data
datacob = venccob
if len(day(date)) = 1 then
diadata = "0"&day(date)
else
diadata = day(date)
end if
if len(month(date)) = 1 then
mesdata = "0"&month(date)
else
mesdata = month(date)
end if
entdiax = cdate(date) + diasentrega
if len(day(entdiax)) = 1 then
diadatax = "0"&day(entdiax)
else
diadatax = day(entdiax)
end if
if len(month(entdiax)) = 1 then
mesdatax = "0"&month(entdiax)
else
mesdatax = month(entdiax)
end if
entdiaxz = cdate(date) + vencboleto
if len(day(entdiaxz)) = 1 then
diadataxz = "0"&day(entdiaxz)
else
diadataxz = day(entdiaxz)
end if
if len(month(entdiaxz)) = 1 then
mesdataxz = "0"&month(entdiaxz)
else
mesdataxz = month(entdiaxz)
end if

'Valida a compra
set valida = abredb.Execute("SELECT status from compras WHERE idcompra = " & intOrderID & ";")
estatusdela = valida("status")
valida.close
set valida = nothing
if estatusdela = "Compra em Aberto" then


'Atualiza o pagamento e status da compra no banco de dados
set cadnovo = abredb.Execute("UPDATE compras SET pagamentovia = '"&strCartao&"', numero = '"&Cripto(numero,true)&"',codigo_seguranca = '"&Cripto(codigo_seguranca,true)&"',vencimento = '"&Cripto(vencimento,true)&"', titular= '"&Cripto(strTitular,true)&"', status = '0' WHERE idcompra = " & intOrderID & ";")
set cadnovo = Nothing


'Atualiza o valor da compra com 1% de acrescimo cobrado pelos Correios em caso de Sedex a Cobrar e se no config.asp estiver como cobrar_seguro_produto = "N"
if strCartao = "4" AND session("modo_entrega")="sedex" AND entrega_sedex_a_cobrar="Sim" AND cobrar_seguro_produto = "N" then
	strCompq=session("compra1")*1.01
	valor_seguro=session("compra1")*0.01
	set atualizaseguro = abredb.Execute("UPDATE compras SET totalcompra = '"&Cripto(strCompq,true)&"' WHERE idcompra = " & intOrderID & ";")
	set atualizaseguro = Nothing
end if
%>
  	  		   <table><tr><td align="left" valign="top">
			   				  <table border="0" cellspacing="4" cellpadding="4" width=580><tr><td><font face="<%=fonte%>" style=font-size:11px;color:000000> <a href=default.asp style=text-decoration:none; onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg4%>';return true;"><b><%=strLg4%></b></a> » <%=strLg285%><br>

<table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=20 bgcolor=f0f0f0>
<font face="<%=fonte%>" style=font-size:10px;color:#808080>
&nbsp;&nbsp;&nbsp;
1. <%=strLg282%> &nbsp;&nbsp;&nbsp;
2. <%=strLg283%> &nbsp;&nbsp;&nbsp;
3. <%=strLg284%> &nbsp;&nbsp;&nbsp;
<font color="<%= Cor_texto_menu_fechamento_compras %>">4. <%=strLg285%></font> </td></tr><tr><td height=5></td></tr></table>

<div align=left> <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table></div>
							  		 <table border=0 cellSpacing=0 width=575><TR><TD colSpan=4 height=42><DIV align=center><B><FONT style=font-size:17px color=000000><%=tituloloja%></FONT></B><BR><FONT style=font-size:11px><%=endereco11%> - <%=bairro11%><BR><%=cidade11%>/<%=estado11%> - <%=pais11%> - <a href="mailto:<%=emailloja%>" style=text-decoration:none;><%=emailloja%><BR></DIV></TD></TR>
									 <tr><td colspan=4><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table></td></tr>
									 <tr><td colSpan=2 align=left><FONT style=font-size:11px color=000000><B>Compra de <%=Request.Form("nome1")%></B><TD colSpan=2 align=right><B><FONT style=font-size:11px color=000000>Data: </B> <%=diadata&"/"&mesdata&"/"&year(date)%></div></TD></TR>
									 <tr><td colspan=4><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table></td></tr>
									 <tr><td colspan=4><font style=font-size:11px;color:000000><b>Dados da entrega e do pedido <br><br></b></td></tr>
									 <tr><td colSpan=2><font style=font-size:11px color=000000><b>Endereço: </b><%=strEndereco%>
									 <br><b>Bairro: </b> <%=strBairro%><br>
									 <b> Local:</b> <%=strCidade%>-<%=strEstado%></td>
									 <td colSpan=2><font style=font-size:11px color=000000><b> CEP:</b> <%=strCep%><br><b> País:</b> <%=strPais%><br><b> Telefone:</b> <%=strFone%></td></TR>
<%
valortotalx = 1 + freteqwy + strCompq - 1

'Chama o nome da forma de pagamento escolhida
if strCartao="0" then
forma = strLg222
end if
if strCartao="1" then
forma = strLg221
end if
if strCartao="2" then
forma = strLg224
end if
if strCartao="3" then
forma = strLg223
end if
if strCartao="4" then
forma = strLg225
end if
if strCartao="6" then
forma = "Transferência Eletrônica"
end if
if strCartao="5" then
forma = "Depósito Bancário"
end if
if strCartao="7" then
forma = "Boleto Bancário"
end if
if strCartao="8" then
forma = "BRpay"
end if
if strCartao="9" then
forma = strLg323
end if
%>

	  			  		   		<tr><td colspan=4><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><font style=font-size:11px;font-family:<%=fonte%>;color:000000><b>Informações sobre sua compra</b></td></tr>
								<tr><td width=30%><font style=font-size:11px;font-family:<%=fonte%>;color:000000><b>Sub-total:</b>&nbsp;<%= strLgMoeda & " " & formatnumber(strCompq,2)%></td><td width=30%><font style=font-size:11px;font-family:<%=fonte%>;color:000000><b>Frete:&nbsp;</b><%= strLgMoeda & " " & formatnumber(freteqwy,2)%></td><td width=25%><font style=font-size:11px;font-family:<%=fonte%>;color:000000><b>Valor Total:&nbsp;</b><%=strLgMoeda & " " & formatnumber(valortotalx,2)%></td>
<!--###############################
    Valores por extenso
    Rogério Silva
    ###############################//-->
								<tr><td width=30%><font style=font-size:11px;font-family:<%=fonte%>;color:000000>&nbsp;<%=Extenso(strCompq)%></td><td width=20%><font style=font-size:11px;font-family:<%=fonte%>;color:000000><%=Extenso(freteqwy)%></td><td width=25%><font style=font-size:11px;font-family:<%=fonte%>;color:000000><%=Extenso(valortotalx)%></td>
<!--###############################################################//-->
								<td width=40%></td></tr>
								<tr><td colspan=4><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><font style=font-size:11px;font-family:<%=fonte%>;color:000000><b>Informações de pagamento (<%=forma%>)</b></td></tr>

<%
'Chama pela forma de pagamento a tela final
if strCartao="0" OR strCartao="1" OR strCartao="2" OR strCartao="3" then%>
   				 				  <tr><td colspan=2><font style=font-family:<%=fonte%>;font-size:11px;color:#000000;><b>Últimos Dígitos:</b> <%=right(numero,4)%><br><b>Titular:</b> <%=strTitular%> <br></td><td colspan=2 valign=top><font style=font-family:<%=fonte%>;font-size:11px;color:#000000;><b>Expiração do Cartão:</b> <%=strExpmes & "/" & strExpano%><br></td></tr> <tr><td colspan=4><font style=font-family:<%=fonte%>;font-size:11px;color:#000000;><br><center><b>Status da transação:</b><font color=#a51905> <b>Compra confirmada com a operadora do <%=forma%>!</font></b></center></td></tr>
<%end if

if strCartao="4" then%>
		  <tr><td colspan=4><font style=font-family:<%=fonte%>;font-size:11px;color:#000000;><center><font color=#a51905> <br><b>
Nas compras enviados via Sedex a Cobrar, os Correios cobram obrigatoriamente o Seguro sobre o valor do seu pedido (1% do valor do pedido) <% If valor_seguro<>"" then %>, no caso do seu pedido será de <%= strLgMoeda & " " & formatnumber(valor_seguro,2)%> <% End If %>, já incluído no Sub-total acima.<br><br>

O seu pedido deverá ser retirado na agência dos CORREIOS mais próxima do endereço informado para entrega e o pagamento será feito no ato, agradecemos a preferência! </b></font></center></td></tr>
<%
end if

if strCartao="5" then
%>
   				 	 		<tr><td colspan=2>
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                                  <img border="0" src="<%=dirlingua%>/imagens/trans.gif" width="10" height="10"></td><td colspan=2>
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                                  <img border="0" src="<%=dirlingua%>/imagens/trans.gif" width="10" height="10"></td></tr>
   				 	 		
   				 	 		<tr><td colspan=2>
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                                  <img border="0" src="<%=dirlingua%>/imagens/trans.gif" width="10" height="10"></td><td colspan=2>
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                                  <img border="0" src="<%=dirlingua%>/imagens/trans.gif" width="10" height="10"></td></tr>
								  
   				 	 		<tr><td colspan=2 bgcolor="#F0F0F0"><font style=font-family:<%=fonte%>;font-size:11px;color:#000000;><b>Banco:</b> <%=bancopag%><br><b>Agência:</b> <%=agpag%>
                              </td><td colspan=2 bgcolor="#F0F0F0">
                              <font style="font-family:<%=fonte%>;font-size:11px;color:#000000; font-weight:700" face="<%=fonte%>">
                              </font><font style=font-family:<%=fonte%>;font-size:11px;color:#000000;><b>Conta:</b> <%=contapag%><br><b>Cedente: </b><%=pagpara%>
                              </td></tr>
			
							<% If bancopag2<>"" then %>
							<tr><td colspan=4>
                              &nbsp;<br></td></tr>
							  							  
   				 	 		<tr><td colspan=2 bgcolor="#F0F0F0"><font style=font-family:<%=fonte%>;font-size:11px;color:#000000;><b>Banco:</b> <%=bancopag2%><br><b>Agência:</b> <%=agpag2%>
                              </td><td colspan=2 bgcolor="#F0F0F0">
                              <font style="font-family:<%=fonte%>;font-size:11px;color:#000000; font-weight:700" face="<%=fonte%>">
                              </font><font style=font-family:<%=fonte%>;font-size:11px;color:#000000;><b>Conta:</b> <%=contapag2%><br><b>Cedente: </b><%=pagpara2%>
                              </td></tr>
							 <% End If %>
							  							  
							<tr><td colspan=4><font style=font-family:<%=fonte%>;font-size:11px;color:#000000;><center>
                              <p align="left">
                              <font style="font-family:<%=fonte%>;font-size:11px;color:000000;" face="<%=fonte%>" color="#a51905">
                              <b><br>
                              Código para o Depósito: #</b></font><font style="font-size:11px; color:000000" color=000000 face="<%=fonte%>"><b><%=replace(strPedido,",","")%></b></font></p>
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>"><center>
                              <p><font color=#a51905> <b>Envie-nos um e-mail com o código de depósito para confirmação do pagamento. Após a verificação, seu pedido será liberado imediatamente para entrega!</b></font></p>
                              </center></center></td></tr>
<%
'Atualiza o numero do deposito identificdo
end if
if strCartao="6" then%>
   			   				 	 		<tr><td colspan=2>
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                                  <img border="0" src="<%=dirlingua%>/imagens/trans.gif" width="10" height="10"></td><td colspan=2>
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                                  <img border="0" src="<%=dirlingua%>/imagens/trans.gif" width="10" height="10"></td></tr>
   				 	 		
   				 	 		<tr><td colspan=2>
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                                  <img border="0" src="<%=dirlingua%>/imagens/trans.gif" width="10" height="10"></td><td colspan=2>
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                                  <img border="0" src="<%=dirlingua%>/imagens/trans.gif" width="10" height="10"></td></tr>
   				 	 		
							<tr><td colspan=2 bgcolor="#F0F0F0"><font style=font-family:<%=fonte%>;font-size:11px;color:#000000;><b>Banco:</b> <%=bancopag%><br><b>Agência:</b> <%=agpag%>
                              </td><td colspan=2 bgcolor="#F0F0F0">
                              <font style="font-family:<%=fonte%>;font-size:11px;color:#000000; font-weight:700" face="<%=fonte%>">
                              </font><font style=font-family:<%=fonte%>;font-size:11px;color:#000000;><b>Conta:</b> <%=contapag%><br><b>Cedente: </b><%=pagpara%>
                              </td></tr>
							  
							<% If bancopag2<>"" then %>
							<tr><td colspan=4>
                              &nbsp;<br></td></tr>
							  
   				 	 		<tr><td colspan=2 bgcolor="#F0F0F0"><font style=font-family:<%=fonte%>;font-size:11px;color:#000000;><b>Banco:</b> <%=bancopag2%><br><b>Agência:</b> <%=agpag2%>
                              </td><td colspan=2 bgcolor="#F0F0F0">
                              <font style="font-family:<%=fonte%>;font-size:11px;color:#000000; font-weight:700" face="<%=fonte%>">
                              </font><font style=font-family:<%=fonte%>;font-size:11px;color:#000000;><b>Conta:</b> <%=contapag2%><br><b>Cedente: </b><%=pagpara2%>
                              </td></tr>
							  <% End If %>
							  							  
							<tr><td colspan=4>
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>"><center>
                              <p><font color=#a51905> <b><br>
                              <br>
                              Após a confirmação do pagamento seu pedido será imediatamente liberado para entrega!</b></font></p>
                              </center></td></tr>
<%
end if

'* ANTENÇÃO: precisa ter no banco a tabela BOLETO com o campo NOSSO. *
'Pagamento por Boleto

if strCartao="7" then

'Pega o último nosso número
Set rsNosso = abredb.Execute("SELECT nosso from boleto;")
strNosso = rsNosso("nosso")

strNosso = strNosso + 1

'Atualiza o nosso número
set rsNosso = abredb.Execute("UPDATE boleto SET nosso = '"&strNosso&"';")

%>

							  <tr><td colspan=4>
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>"><center>
                              <p>
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">

<% 
link_boleto_site =caminho_boleto&"?sacador="&Request.Form("nome1")&"&endereco="&strEndereco&"&bairro="&strBairro&"&cidade="&strCidade&"&estado="&strEstado&"&cep="&strCep&"&nossonumero="&strNosso&"&datadocumento="&diadata&"/"&mesdata&"/"&year(date)&"&datavencimento="&diadatax&"/"&mesdatax&"/"&year(entdiax)&"&valordocumento="&formatnumber(valortotalx,2)&"&numerodoc="&replace(strPedido,",","")&""
%>
                                  <img border="0" src="<%=dirlingua%>/imagens/trans.gif" width="10" height="10">
<script LANGUAGE="JavaScript">
       function Boleto() {
                remote = window.open("","remotewin","'toolbar=no,location=no,directories=no,status=yes,menubar=yes,scrollbars=yes,resizable=no,copyhistory=no,width=720,height=500'");
                remote.location.href = "<%=link_boleto_site%>";
                remote.opener = window;
                remote.opener.name = "imagem1";
                }

                              </script>
                                  </font></font><font color=#a51905><b><br>
							  <a href="javascript:Boleto()">
                              <img border="0" src="<%=dirlingua%>/imagens/boleto_news_2.gif"></a><br>
                              </b></font>
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                              <font style=font-family:<%=fonte%>;font-size:11px;color:#000000; face="<%=fonte%>">
                              <img border="0" src="<%=dirlingua%>/imagens/trans.gif" width="10" height="10">
							  </font></font><font color=#a51905><b><br>
                              
							  <a href="javascript:Boleto()">
                              <img border="0" src="<%=dirlingua%>/imagens/ver_boleto.gif"></a><br>
                              <br>
                              
							  Após a confirmação do pagamento do BOLETO seu pedido será imediatamente liberado para entrega!<br><br>Clique no botão acima para ver o seu boleto bancário</b></font></p>
                              </center></td></tr>

<%
'rsNosso.close
'Set rsNosso = Nothing
end if

'Pagamento via BRpay

if strCartao="8" then
%>
		  <tr><td colspan=4><font style=font-family:<%=fonte%>;font-size:11px;color:#000000;><center><font color=#a51905> <br><b>
Clique no botão "Finalizar Compra" para ser redirecionado ao site da BRpay e finalizar o pagamento.
<br><br>
O seu pedido será enviado tão logo seja confirmado o pagamento pela BRpay.
<br><br>
Obrigado pela preferência!</b></font></center></td></tr>
<%
end if
%>
<%

if strCartao="9" then%>
		  <tr><td colspan=4><font style=font-family:<%=fonte%>;font-size:11px;color:#000000;><center>
		    <p><font color=#a51905> <br>
		          <b> Nas compras entregues em domicílio a forma de pagamento escolhido foi CHEQUE BANCÁRIO. Preencha o Cheque no Valor Total de <%=strLgMoeda & " " & formatnumber(valortotalx,2)%> (<%=Extenso(valortotalx)%>).<br>
	              <br>
	              Entregue o cheque ao funcionário credenciado da <%=tituloloja%> no ato do recebimento da compra junto com seu recibo de entrga. Pagamento com cheque somente para entrega em domicílio</b></font></p>
		    <p>
		      <%
end if
%>
		    </p>
		  </center></td></tr>

	  	  					<tr><td colspan=4><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5><br>&nbsp;</td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><font style=font-size:11px;font-family:<%=fonte%>;color:000000><b>Entrega da compra
                              após a confirmação do pagamento</b></td></tr>
							<tr><td colspan=4><font style=font-size:11px;font-family:<%=fonte%>;color:000000><b>Compra efetuada em:</b> <%=diadata&"/"&mesdata&"/"&year(date)%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<% if session("modo_entrega")="sedex" or session("modo_entrega")="motoboy" then %>
<font style=font-size:11px;font-family:<%=fonte%>;color:000000><b>Previsão de entrega do pedido:</b> <%=diadatax&"/"&mesdatax&"/"&year(entdiax)%>
<% End If %></td></tr>


<% '*** Area de Envio de Emails - Inicio %>

<%
'Corpo do e-mail de envio de compras
strMensagem = "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>"
strMensagem = strMensagem & "<HTML><HEAD>"
strMensagem = strMensagem & "<META content='text/html; charset=iso-8859-1' http-equiv=Content-Type>"
strMensagem = strMensagem & "<META content='MSHTML 5.00.2614.3500' name=GENERATOR></HEAD>"
strMensagem = strMensagem & "<BODY>"
strMensagem = strMensagem & "<DIV align=justify>"
strMensagem = strMensagem & "<TABLE border=0 cellSpacing=0 width='98%'>"
strMensagem = strMensagem & "  <TBODY>"
strMensagem = strMensagem & "  <TR>"
strMensagem = strMensagem & "    <TD colSpan=4 height=42>"
strMensagem = strMensagem & "      <DIV align=center><font face="&fonte&"><B><FONT style=font-size:17px color=000000>"&tituloloja&"</FONT></B><BR><FONT style=font-size:11px>"&endereco11&" - "&bairro11&"<BR>"&cidade11&"/"&estado11&" - "&pais11&" - <a href='mailto:"&emailloja&"'>"&emailloja&"<BR></FONT></DIV></FONT></TD></TR>"
strMensagem = strMensagem & "  <TR>"
strMensagem = strMensagem & "    <TD colSpan=4><FONT face="&fonte&">"
strMensagem = strMensagem & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
strMensagem = strMensagem & "     </FONT></TD></TR>"
strMensagem = strMensagem & "  <TR>"
strMensagem = strMensagem & "    <TD align=left colSpan=2><FONT face="&fonte&"><FONT color=#000000" 
strMensagem = strMensagem & "      style='FONT-SIZE: 11px'><B>Compra de "&strNome&"</B></FONT>" 
strMensagem = strMensagem & "      </FONT>"
strMensagem = strMensagem & "    <TD align=right colSpan=2><B><FONT face="&fonte&"><FONT color=#000000" 
strMensagem = strMensagem & "      style='FONT-SIZE: 11px'>Data: </B>"&diadata&"/"&mesdata&"/"&year(date)&" </FONT>"
strMensagem = strMensagem & "      <DIV></DIV></FONT></TD></TR>"
strMensagem = strMensagem & "  <TR>"
strMensagem = strMensagem & "    <TD colSpan=4>"
strMensagem = strMensagem & "      <DIV><FONT face="&fonte&">"
strMensagem = strMensagem & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
strMensagem = strMensagem & "      </FONT></DIV>"
strPedidoz = replace(strPedido,",","")
strMensagem = strMensagem & "      <DIV><FONT face="&fonte&" style='FONT-SIZE: 11px'>Obrigado por comprar na" 
strMensagem = strMensagem & "      "&nomeloja&"!<BR>Esta é a confirmação de que seu pedido de No. <STRONG>"&strPedidoz&"" 
strMensagem = strMensagem & "      </STRONG>foi finalizado com sucesso.</FONT></DIV>"
strMensagem = strMensagem & "      <DIV><FONT face="&fonte&">"
strMensagem = strMensagem & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
strMensagem = strMensagem & "      </FONT><FONT face="&fonte&"><FONT color=#000000" 
strMensagem = strMensagem & "      style='FONT-SIZE: 11px'>&nbsp; </DIV>"
strMensagem = strMensagem & "      <DIV>"

'*** Mensagem de Entrega
strMensagem = strMensagem & "      <DIV align=justify><FONT face="&fonte&"" 
strMensagem = strMensagem & "      style='FONT-SIZE: 11px'><STRONG>Entrega"

if session("modo_entrega")="motoboy"  then
strMensagem = strMensagem & "      via "&descricao_forma_entrega_motoboy
end if
if session("modo_entrega")="sedex" then
strMensagem = strMensagem & "      via Sedex"
end if
if session("modo_entrega")="download" then
strMensagem = strMensagem & "      via "&descricao_forma_entrega_download
end if

strMensagem = strMensagem & "      </STRONG></FONT></DIV>"
strMensagem = strMensagem & "      <DIV align=justify>&nbsp;</DIV>"
strMensagem = strMensagem & "      <DIV align=justify><FONT face="&fonte&" style='FONT-SIZE: 11px'>" 

if session("modo_entrega")="motoboy" or session("modo_entrega")="sedex" then
strMensagem = strMensagem & "      &nbsp;&nbsp;&nbsp; Para que o pedido chegue o mais" 
strMensagem = strMensagem & "      rápido possível, realizamos a entrega imediata do(s) item(ns) que já estão "
strMensagem = strMensagem & "      disponíveis no estoque. Os outros itens são enviados tão logo entregues "
strMensagem = strMensagem & "      pelos fornecedores, conforme o prazo informado no momento da "
strMensagem = strMensagem & "     compra.<BR>&nbsp;&nbsp;&nbsp; "
strMensagem = strMensagem & "      Para evitar extravios e garantir que a entrega seja feita corretamente, o" 
strMensagem = strMensagem & "      pedido somente será deixado no endereço solicitado mediante a assinatura "
strMensagem = strMensagem & "      de quem for recebê-lo.</FONT></DIV>"
end if

if session("modo_entrega")="download" then
strMensagem = strMensagem & "      &nbsp;&nbsp;&nbsp; Para que o pedido chegue rapidamente e desta forma garantir " 
strMensagem = strMensagem & "      que a entrega seja feita corretamente, "
strMensagem = strMensagem & "      as instruções para a liberação/entrega dos produtos "
strMensagem = strMensagem & "      serão informados para o email ou telefone informado no seu pedido abaixo.</FONT></DIV>"
end if

strMensagem = strMensagem & "      <DIV align=justify>&nbsp;</DIV>"
strMensagem = strMensagem & "      <DIV align=justify><FONT face="&fonte&" style='FONT-SIZE: 11px'>"
strMensagem = strMensagem & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
strMensagem = strMensagem & "      &nbsp;</DIV></FONT>"

'*** Mensagem de Frete
if session("modo_entrega")="motoboy" or session("modo_entrega")="sedex" then
strMensagem = strMensagem & "      <DIV align=left><FONT face="&fonte&"" 
strMensagem = strMensagem & "      style='FONT-SIZE: 11px'><STRONG>Frete</STRONG></FONT></DIV>"
strMensagem = strMensagem & "      <DIV align=left>&nbsp;</DIV>"
strMensagem = strMensagem & "      <DIV align=justify><FONT face="&fonte&"><FONT" 
strMensagem = strMensagem & "      style='FONT-SIZE: 11px'>&nbsp;&nbsp;&nbsp; Todos os produtos comprados" 
strMensagem = strMensagem & "      na&nbsp;"&nomeloja&" são acrescidos do valor de frete. " 
end if

if session("modo_entrega")="motoboy" then
strMensagem = strMensagem & "      O valor do frete é calculado baseando-se na taxas de entrega cobrado pelo serviço de "&descricao_forma_entrega_motoboy& "." 
end if

if session("modo_entrega")="sedex" then
strMensagem = strMensagem & "      O valor do frete é calculado baseando-se nas taxas de envio cobrado pelo serviço dos Correios. "
strMensagem = strMensagem & "      Ambas variam por região. O valor total do frete está associado ao" 
strMensagem = strMensagem & "      pedido e sempre será cobrado integralmente no primeiro envio. Caso haja "
strMensagem = strMensagem & "      indisponibilidade de produtos para envios posteriores, a taxa cobrada por" 
strMensagem = strMensagem & "      aquele item será restituída de acordo com a política de "
strMensagem = strMensagem & "      reembolso.<BR></FONT></FONT></DIV>"
strMensagem = strMensagem & "      <DIV align=justify><FONT face="&fonte&"" 
strMensagem = strMensagem & "      style='FONT-SIZE: 11px'>&nbsp;&nbsp;&nbsp; O&nbsp;envio parcial do pedido" 
strMensagem = strMensagem & "      não implica no pagamento de vários fretes. A taxa de frete é sempre "
strMensagem = strMensagem & "      calculada em função da compra integral."
end if

if session("modo_entrega")="motoboy" or session("modo_entrega")="sedex" then
strMensagem = strMensagem & "      </FONT></DIV><DIV align=justify><FONT face="&fonte&" style='FONT-SIZE: 11px'><FONT" 
strMensagem = strMensagem & "      face="&fonte&" style='FONT-SIZE: 11px'>&nbsp; "
strMensagem = strMensagem & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
strMensagem = strMensagem & "      </FONT></FONT></DIV>"
strMensagem = strMensagem & "      <DIV>&nbsp;</DIV>"
end if


'*** Mensagem de Pagamento
strMensagem = strMensagem & "     <DIV align=left><FONT face="&fonte&"" 
strMensagem = strMensagem & "      style='FONT-SIZE: 11px'><STRONG>Pagamento</STRONG></FONT></DIV>"
strMensagem = strMensagem & "      <DIV>&nbsp;</DIV>"
strMensagem = strMensagem & "      <DIV align=left><FONT face="&fonte&" style='FONT-SIZE: 11px'>ATENÇÃO: como o" 
strMensagem = strMensagem & "      pedido já foi concluído, não é possível alterar a forma de "
strMensagem = strMensagem & "      pagamento.</FONT></DIV>"
strMensagem = strMensagem & "      <DIV>&nbsp;</DIV>"
strMensagem = strMensagem & "      <DIV align=justify><FONT face="&fonte&"" 
strMensagem = strMensagem & "      style='FONT-SIZE: 11px'>&nbsp;&nbsp;&nbsp; Nos pedidos feitos com cartão" 
strMensagem = strMensagem & "      de crédito, o débito é feito parcialmente à medida que os itens são "
strMensagem = strMensagem & "      disponibilizados para envio. Desta forma, pedidos com opção de "
strMensagem = strMensagem & "      parcelamento, podem sofrer alteração na quantidade de parcelas "
strMensagem = strMensagem & "      solicitadas.<BR>&nbsp;&nbsp;&nbsp; A confirmação de pagamento dos pedidos" 
strMensagem = strMensagem & "      feitos com boleto bancário, depósito bancário simples ou identificado "
strMensagem = strMensagem & "      deve ser feita em até 5 (cinco) úteis , é preciso entrar em contato via e-mail ou telefone nos enviando os dados para confirmação de pagamento.</FONT></DIV>"
strMensagem = strMensagem & "      <DIV align=justify>&nbsp;</DIV>"
strMensagem = strMensagem & "      <DIV align=justify><FONT face="&fonte&" style='FONT-SIZE: 11px'>LEMBRE-SE de" 
strMensagem = strMensagem & "      acrescentar este prazo (do período da sua confirmação de pagamento) ao prazo de envio do(s) item(ns) "
strMensagem = strMensagem & "      do seu pedido abaixo.</FONT></DIV>"

	'*** Se for Boleto Bancário

if strCartao="7" then
strMensagem = strMensagem & "      <DIV align=justify>&nbsp;</DIV>"
strMensagem = strMensagem & "      <DIV align=left><FONT face="&fonte&" style='FONT-SIZE: 11px'><strong>Forma de Pagamento via Boleto Bancário</strong><br>Acesse o link abaixo em caso de necessidade de reimpressão do seu Boleto Bancário para o pagamento:<br>"
strMensagem = strMensagem & "      <FONT face="&fonte&" "
strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'><A "
strMensagem = strMensagem & "      href='http://"&urlloja&"/"&link_boleto_site&"' target=""_blank"">Ver o meu Boleto Bancário</A></FONT></FONT></DIV>"
end if

	'*** Se for Depósito ou Trasferencia Eletronica ou até mesmo Boleto Bancário ;-)

if strCartao="5" or strCartao="6" or strCartao="7" then
strMensagem = strMensagem & "      <DIV align=justify>&nbsp;</DIV>"
strMensagem = strMensagem & "      <DIV align=left><FONT face="&fonte&" style='FONT-SIZE: 11px'><strong>Forma de Pagamento via Depósito ou Transferência eletrônica</strong></FONT></DIV><br>"
	'Banco 1
	strMensagem = strMensagem & "      <DIV align=left><FONT face="&fonte&" "
	strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'>Banco: "&bancopag&"  &nbsp;&nbsp;&nbsp;&nbsp;Agência: "&agpag&" &nbsp;&nbsp;&nbsp;&nbsp;Conta: "&contapag&"<br>Cedente: "&pagpara&"</FONT></DIV>"
	'Banco 2
	If bancopag2<>"" then
	strMensagem = strMensagem & "      <DIV align=left><br><FONT face="&fonte&" "
	strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'>Banco: "&bancopag2&"  &nbsp;&nbsp;&nbsp;&nbsp;Agência: "&agpag2&" &nbsp;&nbsp;&nbsp;&nbsp;Conta: "&contapag2&"<br>Cedente: "&pagpara2&"</FONT></DIV>"
	end if
end if

strMensagem = strMensagem & "      <DIV><FONT face=Arial style='FONT-SIZE: 11px'><FONT face="&fonte&"" 
strMensagem = strMensagem & "      style='FONT-SIZE: 11px'>&nbsp; "

strMensagem = strMensagem & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
strMensagem = strMensagem & "      </FONT></FONT></DIV>"
strMensagem = strMensagem & "      <DIV align=left><FONT face="&fonte&" style='FONT-SIZE: 11px'><FONT" 
strMensagem = strMensagem & "      face="&fonte&" size=2>&nbsp;</FONT></FONT></DIV>"
strMensagem = strMensagem & "      <DIV align=left><FONT face="&fonte&" style='FONT-SIZE: 11px'><STRONG>Seu" 
strMensagem = strMensagem & "      Pedido</STRONG></FONT></FONT></FONT><FONT face="&fonte&" "
strMensagem = strMensagem & "      style='FONT-SIZE: 11px'><BR><BR></DIV></DIV></FONT></TD></TR>"
strMensagem = strMensagem & "  <TR>"
strMensagem = strMensagem & "    <TD colSpan=2><FONT face="&fonte&"><FONT color=#000000 style='COLOR: #000000; FONT-SIZE: 11px'><B>Nome:" 
strMensagem = strMensagem & "      </B>"&strNome&"<BR><B>Endereço:" 
strMensagem = strMensagem & "      </B>"&strEndereco&"<BR><B>Bairro: </B>"&strBairro&" "
strMensagem = strMensagem & "      <BR><B>Local:</B> "&strCidade&"-"&strEstado&" </FONT></FONT></TD>"
strMensagem = strMensagem & "    <TD colSpan=2><FONT face="&fonte&"><FONT color=#000000 style='COLOR: #000000; FONT-SIZE: 11px'><B>Email:</B>" 
strMensagem = strMensagem & "      "&session("usuario")&" <BR><B>CEP:</B>" 
strMensagem = strMensagem & "      "&strCep&" <BR><B>País:</B> "&strPais&" <BR><B>Telefone:</B> "&strFone&" "
strMensagem = strMensagem & "      </FONT></FONT></TD></TR>"
strMensagem = strMensagem & "<tr><td><br></td></tr>"

strMensagem = strMensagem & "  <TR bgColor="&cor3&">"
strMensagem = strMensagem & "    <TD align=left noWrap vAlign=center width='15%'><FONT color=#000000" 
strMensagem = strMensagem & "      face="&fonte&" style='COLOR: #000000; FONT-SIZE: 11px' "
strMensagem = strMensagem & "      style='BACKGROUND-COLOR: "&cor3&"'><STRONG>Quantidade<STRONG></FONT></STRONG></STRONG></TD>"
strMensagem = strMensagem & "    <TD align=left noWrap vAlign=center width='44%'><FONT color=#000000 "
strMensagem = strMensagem & "      face="&fonte&" style='COLOR: #000000; FONT-SIZE: 11px' "
strMensagem = strMensagem & "      style='BACKGROUND-COLOR: "&cor3&"'><STRONG>Produto<STRONG></FONT></STRONG></STRONG></TD>"
strMensagem = strMensagem & "    <TD align=left vAlign=center width='16%'><FONT color=#000000 face="&fonte&" "
strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px' style='BACKGROUND-COLOR: "&cor3&"'><STRONG>Preço "
strMensagem = strMensagem & "      Unitário<STRONG></FONT></STRONG></STRONG></TD>"
strMensagem = strMensagem & "    <TD align=right noWrap vAlign=center width='25%'><FONT color=#000000" 
strMensagem = strMensagem & "      face="&fonte&" style='COLOR: #000000; FONT-SIZE: 11px' style='BACKGROUND-COLOR: "&cor3&"'><STRONG>Preço" 
strMensagem = strMensagem & "      Total<STRONG></FONT></STRONG></STRONG></TD></TR>"

'Chama os produtos comprados

set pedidos = abredb.Execute("SELECT idprod, quantidade FROM pedidos WHERE idcompra='"&intOrderID&"';")
while not pedidos.EOF
idprod = pedidos("idprod")
quantidade = pedidos("quantidade")

'#########################################################################################
'#  CONTROLE DE ESTOQUE
'#  Rogério Silva - 15/01/2004 - WBSolutions - http://www.libihost.net/wbsolutions.
'#  Elizeu Alcantara - 10/02/2004 - Atualizacoes e Correcoes - elizeu@onda.com.br / elizeu@cristaosite.com.br
'#
'#  Este controle estava originalmente nos arquivos comprar.asp e atualizapedido.asp e foi removido destes 
'#  e readaptado aqui para que a "baixa" do estoque seja realizado somente na Finalizacao da Compra,
'#  qdo houve a real saída do produto do estoque 
'#########################################################################################
	SelEstoque = "SELECT ESTOQUE FROM ESTOQUE WHERE IDPRODUTO="&idprod
	Set RsEst = abredb.Execute(SelEstoque)
		IF NOT RsEst.EOF THEN
		Atual = (RsEst("ESTOQUE") - quantidade)
			abredb.Execute("UPDATE ESTOQUE set ESTOQUE = "& Atual &"  WHERE IDPRODUTO="&idprod&";")
			abredb.Execute("UPDATE PRODUTOS set VENDAS = VENDAS + "& quantidade &" WHERE IDPROD="&idprod&";")
		END IF

'#########################################################################################
'# Mostrar Esgotado ou Nao Visisvel e Email de Aviso de produto ZERADO -  ROGERIO SILVA / ELIZEU ALCANTARA
'# Este controle estava originalmente no arquivo carrinhodecompras.asp e foi removido deste 
'#  e readaptado aqui para que a mudanca do status de "Nao Visivel" (qdo setado no config.asp) 
'#  seja realizado somente na Finalizacao da Compra, qdo houve a real saída do produto do estoque 
'#########################################################################################
	Set Zerado = abredb.Execute("SELECT ESTOQUE FROM ESTOQUE WHERE IDPRODUTO="&idprod&";")
	if NOT Zerado.EOF THEN
		IF Zerado("ESTOQUE") < cInt("1") and mostrar_produto_esgotado<>"Sim" THEN
		 abredb.Execute("UPDATE PRODUTOS SET ESTOQUE='n' WHERE IDPROD="&idprod&";")
		 prod_nao_visivel="Sim"
		END IF
		IF Zerado("ESTOQUE") < cInt("1") THEN
		 enviar_email_prod_zerado="Sim"
		END IF
	END IF
'#########################################################################################
'#----------------------------------------------------------------------------------------
'#########################################################################################


set produtos = abredb.Execute("SELECT preco, nome,fabricante, peso FROM produtos WHERE idprod="&idprod&";")
preco = produtos("preco")
peso = produtos("peso")
nome = produtos("nome")
fabricante = produtos("fabricante")

'#########################################################################################
'# Gera os INPUT's necessários para o formulário da BRpay
If brpay_aceitar_pagamentos = "Sim" Then
	brpay_count = brpay_count + 1
	brpay_imputs = brpay_imputs & "<input type=hidden name=item_id_" & brpay_count & " value=""" & MID(idprod, 1, 100) & """>" & vbcrlf
	brpay_imputs = brpay_imputs & "<input type=hidden name=item_descr_" & brpay_count & " value=""" & MID(nome, 1, 100) & """>" & vbcrlf
	brpay_imputs = brpay_imputs & "<input type=hidden name=item_quant_" & brpay_count & " value=""" & quantidade & """>" & vbcrlf
	brpay_imputs = brpay_imputs & "<input type=hidden name=item_valor_" & brpay_count & " value=""" & Replace(Replace(FormatNumber(preco, 2), ",", ""), ".", "") & """>" & vbcrlf
	If brpay_tipo_calculo_frete = "0" Then
		'
	ElseIf brpay_tipo_calculo_frete = "1" Then
		brpay_imputs = brpay_imputs & "<input type=hidden name=item_frete_" & brpay_count & " value=""" & Replace(Replace(FormatNumber(freteqwy, 2), ",", ""), ".", "") & """>" & vbcrlf
	ElseIf brpay_tipo_calculo_frete = "2" Then
		brpay_imputs = brpay_imputs & "<input type=hidden name=item_frete_" & brpay_count & " value=""" & Replace(Replace(FormatNumber(freteqwy, 2), ",", ""), ".", "") & """>" & vbcrlf
	ElseIf brpay_tipo_calculo_frete = "3" Then
		brpay_imputs = brpay_imputs & "<input type=hidden name=item_peso_" & brpay_count & " value=""" & Replace(Replace(FormatNumber(peso, 3), ",", ""), ".", "") & """>" & vbcrlf
	End If
End If
'#########################################################################################

intProdID = idprod
strProdNome = nome
strFab = fabricante
pesoz = peso
intProdPric = preco
intQuant = quantidade
prodvalor = formatNumber(intProdPric,2)
prodvalort = formatNumber((intQuant * intProdPric),2)

if enviar_email_prod_zerado="Sim" then %>
<!--#include file="email_prod_zerado.asp"-->
<%
end if

'*** Reseta os status das variaveis usados no enviar_email_prod_zerado, p/ nao influir no proximo loop
enviar_email_prod_zerado="" 
prod_nao_visivel=""


strMensagem = strMensagem & "  <TR>"
strMensagem = strMensagem & "    <TD align=left vAlign=center width='15%'><FONT face="&fonte&" size=2><FONT" 
strMensagem = strMensagem & "      face="&fonte&" style='COLOR: #000000; FONT-SIZE: 11px'>"&intQuant&" </FONT></FONT></TD>"
strMensagem = strMensagem & "   <TD align=left width='44%'><FONT face="&fonte&" "
strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'>&nbsp;"&strProdNome&" </FONT></TD>"
strMensagem = strMensagem & "    <TD align=right width='16%'><FONT face="&fonte&" "
strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'>" & strLgMoeda & " " & prodvalor&" </FONT></TD>"
strMensagem = strMensagem & "    <TD align=right width='25%'><FONT face="&fonte&" "
strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'>" & strLgMoeda & " " &prodvalort&" </FONT></TD></TR>"

pedidos.MoveNext
wend
pedidos.Close
set pedidos = Nothing
produtos.Close
set produtos = Nothing

strMensagem = strMensagem & "  <TR bgColor="&cor3&">"
strMensagem = strMensagem & "    <TD colSpan=4 heigth='5'></TD>"
strMensagem = strMensagem & "  <TR>"
strMensagem = strMensagem & "    <TD align=left colSpan=2 vAlign=center><FONT face="&fonte&"" 
strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'><STRONG>Total da" 
strMensagem = strMensagem & "      compra<STRONG></FONT></STRONG></STRONG></TD>"
strMensagem = strMensagem & "    <TD align=right colSpan=2 vAlign=center><FONT face="&fonte&"" 
strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'><STRONG><B>" & strLgMoeda & " "&formatnumber(strCompq,2)&"</B>" 
strMensagem = strMensagem & "      <STRONG></FONT></STRONG></STRONG></TD></TR>"
strMensagem = strMensagem & "  <TR>"
strMensagem = strMensagem & "   <TD align=left colSpan=2 vAlign=center><FONT face="&fonte&"" 
strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'><STRONG>Valor da Entrega<STRONG></FONT></STRONG></STRONG></TD>"
strMensagem = strMensagem & "    <TD align=right colSpan=2 vAlign=center><FONT face="&fonte&" "
strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'><STRONG><B>" & strLgMoeda & " " &formatnumber(request.form("frete1"),2)&"</B>" 
strMensagem = strMensagem & "      <STRONG></FONT></STRONG></STRONG></TD></TR>"
strMensagem = strMensagem & "  <TR>"
strMensagem = strMensagem & "    <TD align=left colSpan=2 vAlign=center><FONT face="&fonte&"" 
strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'><STRONG>Sua "
strMensagem = strMensagem & "      compra<STRONG></FONT></STRONG></STRONG></TD>"
strMensagem = strMensagem & "    <TD align=right colSpan=2 vAlign=center><FONT face="&fonte&"" 
strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'><STRONG><B>" & strLgMoeda & " " &formatnumber(Request.form("totalae"),2)&"</B>" 
strMensagem = strMensagem & "      <STRONG></FONT></STRONG></STRONG></TD></TR>"
strMensagem = strMensagem & "  <TR>"
strMensagem = strMensagem & "    <TD colSpan=4></TD></TR>"
strMensagem = strMensagem & "  <TR bgColor=#ffffff>"
strMensagem = strMensagem & "    <TD colSpan=4><FONT color=#000000 style='FONT-SIZE: 11px'>"
strMensagem = strMensagem & "      <DIV align=left>&nbsp;</DIV>"
strMensagem = strMensagem & "      <DIV align=left><FONT face=Arial size=2>"
strMensagem = strMensagem & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
strMensagem = strMensagem & "      &nbsp;</FONT></DIV>"
strMensagem = strMensagem & "      <DIV align=left><FONT face="&fonte&"><FONT style='FONT-SIZE: 11px'>LEMBRE-SE" 
strMensagem = strMensagem & "      de que os dados acima devem estar corretos e completos para não haver "
strMensagem = strMensagem & "      demora e dificuldade no atendimento do pedido.<BR></DIV>"
strMensagem = strMensagem & "      <DIV>&nbsp;</DIV>"
strMensagem = strMensagem & "      <DIV align=left><FONT face="&fonte&"><FONT" 
strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'>Atenciosamente,<BR>Atendimento ao" 
strMensagem = strMensagem & "      Cliente</FONT><BR></FONT></DIV></FONT></TD>"
strMensagem = strMensagem & "  <TR>"
strMensagem = strMensagem & "    <TD colSpan=4 vAlign=top>"
strMensagem = strMensagem & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
strMensagem = strMensagem & "    </TD></TD>"
strMensagem = strMensagem & "  <TR>"
strMensagem = strMensagem & "    <TD colSpan=4><FONT face="&fonte&"><B><FONT style=font-size:13px>Equipe" 
strMensagem = strMensagem & "      "&nomeloja&"</FONT></B><BR><FONT face="&fonte&" "
strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'><A "
strMensagem = strMensagem & "      href='http://"&urlloja&"'>"&urlloja&"</A><BR><FONT" 
strMensagem = strMensagem & "      face="&fonte&" style='COLOR: #000000; FONT-SIZE: 11px'><A "
strMensagem = strMensagem & "      href='mailto:"&emailloja&"'>"&emailloja&"</A><BR></FONT></FONT></FONT></TD></TR></TBODY></TABLE></DIV></BODY></HTML>"

'Envia o e-mail

EnviaEmail Application("HostLoja"), Application("ComponenteLoja"), emailloja, "", session("usuario"), "Confirmação de sua compra na "&nomeloja&"! - Pedido N."&strPedidoz, strMensagem
EnviaEmail Application("HostLoja"), Application("ComponenteLoja"), emailloja, "", emailloja, "Nova compra na "&nomeloja&"! - Pedido N."&strPedidoz, strMensagem

else
end if%>


<% '*** Area de Envio de Emails - Fim %>


							<tr><td colspan=4><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table></td></tr>
							<tr bgcolor=#ffffff><td colspan=4><font style=font-size:11px color=000000><center>Detalhes e informações sobre a sua compra já foram enviadas para o e-mail <b><%=request.form("email1")%></b>.<br><br>O número do seu pedido é <b>#<%=replace(strPedido,",","")%></b>, anote-o em um local seguro.<br><br>Sua compra foi recebida com sucesso e agradecemos o seu pedido.<br><br> Equipe <%= nomeloja %><br><br></tr>
				   	  		  <tr><td colspan=4 valign=top><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table></tr></td>
				   	  			<%
								'Pagamento via BRpay
								if strCartao="8" then
								%>
				   	  			<form action=https://www.brpay.com.br/security/webpagamentos/webpagto.aspx ID="Form1" method=post>
									<input type="hidden" name="email_cobranca" value="<%= brpay_email %>" >
									<input type="hidden" name="tipo" value="CP" >
									<input type="hidden" name="moeda" value="<%= brpay_moeda %>">
									<input type=hidden name=ref_transacao value="<%= strPedidoz %>">
									<input type=hidden name=cliente_nome value="<%= MID(strNome, 1, 100) %>">
									<input type=hidden name=cliente_cep value="<%= strCep %>">
									<input type=hidden name=cliente_end value="<%= MID(strEndereco, 1, 200) %>">
									<input type=hidden name=cliente_bairro value="<%= MID(strBairro, 1, 100) %>">
									<input type=hidden name=cliente_cidade value="<%= MID(strCidade, 1, 100) %>">
									<input type=hidden name=cliente_uf value="<%= MID(strEstado, 1, 2) %>">
									<input type=hidden name=cliente_tel value="<%= strFone %>">
									<input type=hidden name=cliente_email value="<%= session("usuario") %>">
									<%= brpay_imputs %>
								<tr align=center>
								  <td colspan=2 valign=top>
								    <div id="Div1">
								      <input type="image" name="fecha" src="<%=dirlingua%>/imagens/finaliza.gif" onMouseOut="window.status='';return true;" onMouseOver="window.status='Finalizar Compras';return true;"  alt="Pague com BRpay - é rápido, grátis e seguro!" ID="Image1">
									</div>
								  </td>
								<td colspan=2 valign=top>
                                </form>
								<%
								Else
								%>
				   	  			<form action=fim.asp ID="Form2">
				   	  			<input type=hidden name=usuario value="<%= strUser %>" >
								<tr align=center>
								  <td colspan=2 valign=top>
								    <div id="Div2">
								      <input type="image" name="fecha" src="<%=dirlingua%>/imagens/finaliza.gif" onMouseOut="window.status='';return true;" onMouseOver="window.status='Finalizar Compras';return true;" >
								    </div>
								  </td>
								  <td colspan=2 valign=top>
                                </form>
								<%
								End If
								%><div id="layer1"><input type="image" name="fecha" src=<%=dirlingua%>/imagens/printrecibo.gif onMouseOut="window.status='';return true;" onMouseOver="window.status='Imprimir Recibo';return true;" OnClick="javascript: print()"></div></td></tr>
						</table></form></td></tr>
				</table></td></tr>
		</table>
		</font></font></font></b>
<% 
'*** Mostrando a mensagem para testes
'response.write "<br><br><br>"
'response.write strMensagem
'response.write "<br><br><br>"
%>

<%
if Session("admin")="logado" THEN
			id_acesso_admin=Session("IdAdm")
			login_admin=Session("NOME")
			ult_acesso_admin=Session("Acesso")
			acesso_admin=Session("UltAcesso")
end if

'Abandona a sessão de compras do cliente, encerrando todas as sessoes usadas pelo cliente, mas mantendo o do Admin caso esteja usando
session.abandon

if id_acesso_admin<>"" and login_admin<>"" then
			Session("IdAdm")=id_acesso_admin
			Session("NOME")=login_admin
			Session("Acesso") = acesso_admin
			Session("UltAcesso") = ult_acesso_admin
			Session("admin")="logado"
end if
%>

		<!-- #include file="baixo.asp" -->