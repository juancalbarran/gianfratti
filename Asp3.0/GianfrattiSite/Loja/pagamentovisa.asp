<%
'#########################################################################################
'#----------------------------------------------------------------------------------------
'#########################################################################################
'#
'#
'#########################################################################################
'# Criado por: Cirilo Jose Veloso - http://www.veloso.adm.br                                                       #
'# Objetivo  : Tratar o arquivo gerado pelo processaVisa.asp e gerar o pedido no BD      #
'# Fluxo     :                                                                           #
'#           :                                                                           #
'#           :                                                                           #
'# Observação: Não pode ser copiado ou distribuído sem autorização do autor              # 
'#                                                                                       #
'#########################################################################################
'#----------------------------------------------------------------------------------------
'#########################################################################################

'INÍCIO DO CÓDIGO
'----------------------------------------------------------------------------------------------------------------
'Este código está otimizado e roda tanto em Windows 2000/NT/XP/ME/98 quanto em servidores UNIX-LINUX com chilli!ASP
%>
<!-- #include file="topo.asp" -->
<!--CONTEUDO-->
<tr>
<td>
<%	
   strPedido      =  session("pedido1")
   strNome        =  session("nome1")
   strContato     =  session("contato1")
   strCPF         =  session("Cpf1")
   strRg          =  session("Rg1")
   strEndereco    =  session("ende1")
   strBairro      =  session("bairro1")
   strCidade      =  session("cidade1")
   strEstado      =  session("est1")
   strCep         =  session("cep1")
   strPais        =  session("pais1")
   strFone        =  session("fone1")
   strCompq       =  session("compra1")
   freteqwy       =  session("frete1")
   strCartao      =  session("cartao")
   strTitular     =  session("titularcartao")
   strExpmes      =  session("cartaomes")
   strExpano      =  session("cartaoano")
   strTotalCompra =  session("totalcompra")
   strTCompra     =  session("totalae")
   intOrderID     =  session("idCompra")
   numero         = "confidencial" 'session("ccn")
   vencimento     = "mm/aa"        'session("cartaomes") & "/" & session("cartaoano")

   varTid = Request.form("tid") 'Cod. da Transação 'Vem PELO BROWSER POST
   Set objXML = Server.CreateObject("Microsoft.XMLDOM")
   objXML.async = False 
   caminho=URLComponentesVisa & "\results\" & vartid & ".xml"
   objXML.load(caminho)
   if CStr(objXML.parseError.errorCode) <> "0" Then 'Se NAO conseguiu ler o arquivo (ele NAO FOI CRIADO...PAU)
      varMsg = Request.form("ars") 'Descricao do Erro
      varLr = Request.form("lr") 'Codigo de Retorno
      varFree = Request.form("free") 'Campo livre
      varOrderId = Request.form("orderid") 'Número do Pedido interno da Loja
      sPan = Request.Form("Pan")'Hash do cartão
      varPrice = Request.Form("Price") 'valor da compra
      varAUTHENT = Request.Form("AUTHENT")'tipo de Autenticação
      varArp = Request.Form("arp")' Código de Autorização
   Else
      Set LR = objXML.getElementsByTagName("LR")
      Set ARP = objXML.getElementsByTagName("ARP")
      Set ARS = objXML.getElementsByTagName("ARS")
      Set PRICE = objXML.getElementsByTagName("PRICE")
      Set ORDERID = objXML.getElementsByTagName("ORDERID")
      Set FREE = objXML.getElementsByTagName("FREE")
      Set PAN = objXML.getElementsByTagName("PAN")
      Set AUTHENT = objXml.GetElementsByTagName("AUTHENT")
      Set fso = CreateObject("Scripting.FileSystemObject")
      If fso.FileExists(caminho) Then		
	 ' fso.DeleteFile(caminho)
      End If					
      set fso=nothing
      'Carregar Variaveis
      varMsg = ARS.item(0).text 'Descricao do Erro
      varLr = LR.item(0).text 'Codigo de Retorno
      if len(FREE.item(0).text)> 0 then
         varFree = FREE.item(0).text 'Campo livre
      end if
      varOrderId = ORDERID.item(0).text 'Número do Pedido interno da Loja
      if len(ARP.item(0).text) > 0 then
         varArp = ARP.item(0).text ' Código de aprovação bancária
      end if					   	
      varPrice=PRICE.item(0).text 'valor da transacao
      varAUTHENT = AUTHENT.item(0).text
   End If
   set objXML=nothing
   If cstr(varLr) <> "0" and cstr(varLr) <> "00" and cstr(varLr) <> "11" then  'Transação foi Negada
'*********************************** Gerar Página de Negado *********************************** %>
    <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=20 bgcolor=f0f0f0>
     <font face="<%=fonte%>" style=font-size:10px;color:#808080>
      &nbsp;&nbsp;&nbsp;
      1. <%=strLg282%> &nbsp;&nbsp;&nbsp;
      2. <%=strLg283%> &nbsp;&nbsp;&nbsp;
      <font color="<%= Cor_texto_menu_fechamento_compras %>">3. <%=strLg284%></font> &nbsp;&nbsp;&nbsp;
      4. <%=strLg285%></td></tr><tr><td height=5></td></tr>
    </table>

     <table width="595" border="0" cellspacing="0" cellpadding="0" align="center">
     <tr> 
      <td></td>
     </tr>
     <tr> 
      <td>
      <center><h3>Autorização Negada pela Operadora de cart&atilde;o</h3></center>
      <BR>
      <BR>
      <center>
      <b>C&oacute;digo:</b> <%=varLr%> <BR>
      <FONT COLOR=red><B><%= varMsg %></B></FONT>
      <BR>
      <BR>
      <B>Identificação do Pedido:</B>&nbsp;<%= varTid %> 
      </center>
      <br>
<!--VOLTAR-->
     <table border=0 cellspacing=0 width=100% cellpadding=0>
        <tr><td height=5></td></tr>
        <tr><td height=1 bgcolor=<%=cor3%>></td></tr>
        <tr><td height=5></td></tr>
     </table>
      <center>
<!--  <A HREF="default.asp" style=text-decoration:none onMouseOut="window.status='';return true;" onMouseOver="window.status='Voltar';return true;"><font face="<%=fonte%>" style=font-size:11px>:: <b>Voltar</b> ::</font></A>&nbsp;&nbsp;&nbsp;&nbsp;-->
      <A Href="carrinhodecompras.asp"><img src=<%=dirlingua%>/imagens/continuar_compras.gif border=0 onMouseOut="window.status='';return true;" onMouseOver="window.status='Voltar ao carinho de compras';return true;"></a>
      </center>
     </td></tr>
    </td></tr>
</table>
<!--
**********************************************************************************************
-->
<%
 Else 'Transação Aprovada
'Chama as variaveis para finalizar compra
'Grava os dados da compra na matriz
 intOrderID = session("idcompra")
 if strCartao = "V" then
     txtpagamento = strLg222
     strCartao = "0"
     venccob = "-"
     numerocob = "-"
 end if
 if strCartao = "E" then
     txtpagamento = "com cartão de débito VisaElectron"
     strCartao = "8"
     venccob = "-"
     numerocob = "-"
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

   dtVencto= datetostr(date + 5)
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
'*********************************************************
'Valida a compra
   set valida = abredb.Execute("SELECT status from compras WHERE idcompra = " & intOrderID & ";")
   estatusdela = valida("status")
   valida.close
   set valida = nothing
'alerta("Status:"&estatusdela)
if estatusdela = "Compra em Aberto" then

'Atualiza o pagamento e status da compra no banco de dados
   set cadnovo = abredb.Execute("UPDATE compras SET pagamentovia = '"&strCartao&"', numero = '"&Cripto(numero,true)&"',vencimento = '"&Cripto(vencimento,true)&"', titular= '"&Cripto(strTitular,true)&"', status = '0', tid='"&varTid&"', parcelas='"&Session("parcelas")&"' WHERE idcompra = " & intOrderID & ";")
   set cadnovo = Nothing

'Corpo do e-mail de envio de compras
   strMensagem = ""
   strMensagem = strMensagem & " <!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>"
   strMensagem = strMensagem & "  <HTML><HEAD>"
   strMensagem = strMensagem & "  <META content='text/html; charset=iso-8859-1' http-equiv=Content-Type>"
   strMensagem = strMensagem & "  <META content='Microsoft FrontPage 5.0' name=GENERATOR></HEAD>"
   strMensagem = strMensagem & "  <BODY>"
   strMensagem = strMensagem & "  <DIV align=justify>"
   strMensagem = strMensagem & "  <TABLE border=0 cellSpacing=0 width=""98%"">"
   strMensagem = strMensagem & "    <TBODY>"
   strMensagem = strMensagem & "    <TR>"
   strMensagem = strMensagem & "      <TD colSpan=4 height=42>"
   strMensagem = strMensagem & "        <DIV align=center><font face="&fonte&"><B><FONT style=font-size:17px color=000000>"&tituloloja&"</FONT></B><BR><FONT style=font-size:11px>"&endereco11&" - "&bairro11&"<BR>"&cidade11&"/"&estado11&" - "&pais11&" - <a href='mailto:"&emailloja&"'>"&emailloja&"<BR></FONT></DIV></FONT></TD></TR>"
   strMensagem = strMensagem & "    <TR>"
   strMensagem = strMensagem & "      <TD colSpan=4><FONT face="&fonte&">"
   strMensagem = strMensagem & "        <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
   strMensagem = strMensagem & "       </FONT></TD></TR>"
   strMensagem = strMensagem & "    <TR>"
   strMensagem = strMensagem & "      <TD align=left colSpan=2><FONT face="&fonte&"><FONT color=#000000"
   strMensagem = strMensagem & "        style='FONT-SIZE: 11px'><B>Pedido de "&strNome&"</B></FONT> "
   strMensagem = strMensagem & "        </FONT>"
   strMensagem = strMensagem & "      <TD align=right colSpan=2><B><FONT face="&fonte&"><FONT color=#000000"
   strMensagem = strMensagem & "        style='FONT-SIZE: 11px'>Data: </B>"&diadata&"/"&mesdata&"/"&year(date)&" </FONT>"
   strMensagem = strMensagem & "        <DIV></DIV></FONT></TD></TR>"
   strMensagem = strMensagem & "    <TR>"
   strMensagem = strMensagem & "      <TD colSpan=4>"
   strMensagem = strMensagem & "        <DIV><FONT face="&fonte&">"
   strMensagem = strMensagem & "        <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
   strMensagem = strMensagem & "        </FONT></DIV>"
   'strMensagem = strMensagem & strPedidoz = replace(strPedido,",","")
   strMensagem = strMensagem & "        <DIV><FONT face="&fonte&" style='FONT-SIZE: 14px'>Obrigado por comprar na"
   strMensagem = strMensagem & "        "&nomeloja&"!<BR>Esta é a confirmação de que seu pedido de No. <STRONG>#"&strPedido&""
   strMensagem = strMensagem & "        </STRONG>foi finalizado com sucesso.</FONT></DIV>"
   strMensagem = strMensagem & "        <DIV><FONT face="&fonte&">"
   strMensagem = strMensagem & "        <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
   strMensagem = strMensagem & "        </FONT><FONT face="&fonte&"><FONT color=#000000"
   strMensagem = strMensagem & "        style='FONT-SIZE: 11px'>  </DIV>"
'  strMensagem = strMensagem & "        <DIV><FONT face="&fonte&" style='FONT-SIZE: 14px'><STRONG>Leitor para ser utilizado em "&Session("conector")&"</STRONG></FONT></DIV><br>"
   strMensagem = strMensagem & "        <DIV><FONT face="&fonte&" style='FONT-SIZE: 14px'><STRONG>Após a confirmação com operadora de Cart&atilde;o de cr&eacute;dito, seu pedido será liberado para entrega em até 10 dias!</STRONG></FONT></DIV><br>"
   strMensagem = strMensagem & "        <DIV><FONT face="&fonte&" style='FONT-SIZE: 11px'>Data e Hora:&nbsp;"&date()&" - "&time()&"</FONT></DIV><br>"
   strMensagem = strMensagem & "        <DIV><FONT face="&fonte&" style='FONT-SIZE: 11px'>Identifica&ccedil&atilde;o(TID):&nbsp;"&varTid&"</FONT></DIV><br>"
   strMensagem = strMensagem & "        <DIV><FONT face="&fonte&" style='FONT-SIZE: 11px'>c&oacute;digo de autoriza&ccedil&atilde;o:&nbsp;"&varArp&"</FONT></DIV><br>"
   strMensagem = strMensagem & "        <DIV><FONT face="&fonte&" style='FONT-SIZE: 11px'>Parcelamento:&nbsp;"&Session("Parcelas")&"</FONT></DIV><br>"

   strMensagem = strMensagem & "        <DIV><FONT face=Arial style='FONT-SIZE: 11px'><FONT face="&fonte&""
   strMensagem = strMensagem & "        style='FONT-SIZE: 11px'>  "
   strMensagem = strMensagem & "        <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
   strMensagem = strMensagem & "        </FONT></FONT></DIV>"
   strMensagem = strMensagem & "        <DIV align=left><FONT face="&fonte&" style='FONT-SIZE: 11px'><FONT "
   strMensagem = strMensagem & "        face="&fonte&" size=2> </FONT></FONT></DIV>"
   strMensagem = strMensagem & "        <DIV align=left><FONT face="&fonte&" style='FONT-SIZE: 11px'><STRONG>Seu"
   strMensagem = strMensagem & "        Pedido</STRONG></FONT></FONT></FONT><FONT face="&fonte&" "
   strMensagem = strMensagem & "        style='FONT-SIZE: 11px'><BR><BR></DIV></DIV></FONT></TD></TR>"
   strMensagem = strMensagem & "    <TR>"
   strMensagem = strMensagem & "      <TD colSpan=2 width='70%'><FONT face="&fonte&"><FONT color=#000000 style='COLOR: #000000; FONT-SIZE: 11px'><B>CNPJ/CPF:"
   strMensagem = strMensagem & "        </B>"&strCPF&"</FONT></FONT></TD>"
   strMensagem = strMensagem & "      <TD colSpan=2 width='30%'><FONT face="&fonte&"><FONT color=#000000 style='COLOR: #000000; FONT-SIZE: 11px'><B>RG/Inscr.:"
   strMensagem = strMensagem & "        </B>"&strRg&"</FONT></FONT></TD></TR>"
   if Len(strCPF)>11 then
     strMensagem = strMensagem & "    <TR>"
     strMensagem = strMensagem & "      <TD colSpan=2 width='70%'><FONT face="&fonte&"><FONT color=#000000 style='COLOR: #000000; FONT-SIZE: 11px'><B>Nome/Razão Social:"
     strMensagem = strMensagem & "        </B>"&strNome&"</FONT></FONT></TD></TR>"
   end if
   strMensagem = strMensagem & "    <TR>"
   strMensagem = strMensagem & "      <TD colSpan=2 width='70%'><FONT face="&fonte&"><FONT color=#000000 style='COLOR: #000000; FONT-SIZE: 11px'><B>Contato:"
   strMensagem = strMensagem & "        </B>"&strContato&"</FONT></FONT></TD></TR>"
   strMensagem = strMensagem & "    <TR>"
   strMensagem = strMensagem & "      <TD colSpan=2 width='70%'><FONT face="&fonte&"><FONT color=#000000 style='COLOR: #000000; FONT-SIZE: 11px'><B>E-Mail:"
   strMensagem = strMensagem & "        </B>"&session("usuario")&"</FONT></FONT></TD></TR>"
   strMensagem = strMensagem & "    <TR>"
   strMensagem = strMensagem & "      <TD colSpan=2 width='70%'><FONT face="&fonte&"><FONT color=#000000 style='COLOR: #000000; FONT-SIZE: 11px'><B>Endereço:"
   strMensagem = strMensagem & "        </B>"&strEndereco&"<BR><B>Bairro: </B>"&strBairro&" "
   strMensagem = strMensagem & "        <BR><B>Local:</B> "&strCidade&"-"&strEstado&" </FONT></FONT></TD>"
   strMensagem = strMensagem & "      <TD colSpan=2 width='30%'><FONT face="&fonte&"><FONT color=#000000 style='COLOR: #000000; FONT-SIZE: 11px'><B>CEP:</B> "
   strMensagem = strMensagem & "        "&strCep&" <BR><B>País:</B> "&strPais&" <BR><B>Telefone:</B> "&strFone&" "
   strMensagem = strMensagem & "        </FONT></FONT></TD></TR>"
   strMensagem = strMensagem & "    <TR bgColor=#ffffff>"
   strMensagem = strMensagem & "      <TD colSpan=4><b><FONT face="&fonte&"><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table><FONT color=#000000 style='COLOR: #000000; FONT-SIZE: 11px'>Forma de Pagamento:</b> "&txtpagamento&"</font>&nbsp;&nbsp; - TID:</b> "&varTID&"</font><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table></TD></TR><table>"
   strMensagem = strMensagem & "    <TR bgColor="&cor3&">"
   strMensagem = strMensagem & "      <TD align=left noWrap vAlign=center width='15%'><FONT color=#FFFF00"
   strMensagem = strMensagem & "        face="&fonte&" style='COLOR: #FFFF00; FONT-SIZE: 11px' "
   strMensagem = strMensagem & "        style='BACKGROUND-COLOR: "&cor3&"'><STRONG>Quantidade<STRONG></FONT></STRONG></STRONG></TD>"
   strMensagem = strMensagem & "      <TD align=left noWrap vAlign=center width='44%'><FONT color=#FFFF00"
   strMensagem = strMensagem & "        face="&fonte&" style='COLOR: #FFFF00; FONT-SIZE: 11px' "
   strMensagem = strMensagem & "        style='BACKGROUND-COLOR: "&cor3&"'><STRONG>Produto<STRONG></FONT></STRONG></STRONG></TD>"
   strMensagem = strMensagem & "      <TD align=left vAlign=center width='16%'><FONT color=#FFFF00 face="&fonte&" "
   strMensagem = strMensagem & "        style='COLOR: #FFFF00; FONT-SIZE: 11px' style='BACKGROUND-COLOR: "&cor3&"'><STRONG>Preço "
   strMensagem = strMensagem & "        Unitário<STRONG></FONT></STRONG></STRONG></TD>"
   strMensagem = strMensagem & "      <TD align=right noWrap vAlign=center width='25%'><FONT color=#FFFF00"
   strMensagem = strMensagem & "        face="&fonte&" style='COLOR: #FFFF00; FONT-SIZE: 11px' style='BACKGROUND-COLOR: "&cor3&"'><STRONG>Preço"
   strMensagem = strMensagem & "        Total<STRONG></FONT></STRONG></STRONG></TD></TR>"

'Chama os produtos comprados
   set pedidos = abredb.Execute("SELECT idprod, quantidade FROM pedidos WHERE idcompra='"&intOrderID&"';")
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
     intProdPric = preco
     intQuant = quantidade
     prodvalor = formatNumber(intProdPric,2)
     prodvalort = formatNumber((intQuant * intProdPric),2)
     strMensagem = strMensagem & "  <TR>"
     strMensagem = strMensagem & "    <TD align=left vAlign=center width='15%'><FONT face="&fonte&" size=2><FONT"
     strMensagem = strMensagem & "      face="&fonte&" style='COLOR: #000000; FONT-SIZE: 11px'>"&intQuant&" </FONT></FONT></TD>"
     strMensagem = strMensagem & "   <TD align=left width='44%'><FONT face="&fonte&" "
     strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'> "&strProdNome&" </FONT></TD>"
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
   strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'><STRONG><B>" & strLgMoeda & " " &formatnumber(session("frete1"),2)&"</B>"
   strMensagem = strMensagem & "      <STRONG></FONT></STRONG></STRONG></TD></TR>"
   strMensagem = strMensagem & "  <TR>"
   strMensagem = strMensagem & "    <TD align=left colSpan=2 vAlign=center><FONT face="&fonte&""
   strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'><STRONG>Sua "
   strMensagem = strMensagem & "      compra<STRONG></FONT></STRONG></STRONG></TD>"
   strMensagem = strMensagem & "    <TD align=right colSpan=2 vAlign=center><FONT face="&fonte&""
   strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'><STRONG><B>" & strLgMoeda & " " &formatnumber(session("totalae"),2)&"</B>"
   strMensagem = strMensagem & "      <STRONG></FONT></STRONG></STRONG></TD></TR>"
   strMensagem = strMensagem & "  <TR>"
   strMensagem = strMensagem & "    <TD colSpan=4></TD></TR>"
   strMensagem = strMensagem & "  <TR bgColor=#ffffff>"
   strMensagem = strMensagem & "    <TD colSpan=4><FONT color=#000000 style='FONT-SIZE: 11px'>"
   strMensagem = strMensagem & "      <DIV align=left> </DIV>"
   strMensagem = strMensagem & "      <DIV align=left><FONT face=Arial size=2>"
   strMensagem = strMensagem & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
   strMensagem = strMensagem & "      &nbsp;</FONT></DIV>"
   strMensagem = strMensagem & "      <DIV align=left><FONT face="&fonte&"><FONT style='FONT-SIZE: 11px'>LEMBRE-SE"
   strMensagem = strMensagem & "      de que os dados acima devem estar corretos e completos para não haver "
   strMensagem = strMensagem & "      demora e dificuldade na entrega do pedido.<BR></DIV>"
   strMensagem = strMensagem & "      <DIV> </DIV>"
   strMensagem = strMensagem & "      <DIV align=left><FONT face="&fonte&"><FONT"
   strMensagem = strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'>Atenciosamente,<BR><BR>Atendimento ao"
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
   %>
   <!--#include file="email.asp"-->
   <%
   EnviaEmail Application("HostLoja"), Application("ComponenteLoja"), emailloja, "", session("usuario"), "Confirmação do Pedido na "&nomeloja&"!", strMensagem
   EnviaEmail Application("HostLoja"), Application("ComponenteLoja"), emailloja, "", emailloja, "Pedido "&nomeloja&"!", strMensagem
else

end if%>
  <table><tr><td align="left" valign="top">
    <table border="0" cellspacing="4" cellpadding="4" width=580>
     <a href=default.asp style=text-decoration:none; onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg4%>';return true;"><b><%=strLg4%></b></a> » <%=strLg285%><br>
     <tr><td><font face="<%=fonte%>" style=font-size:11px;color:000000>
<!--CABECALHO DE ANDAMENTO DA COMPRA-->
       <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=20 bgcolor=f0f0f0>
       <font face="<%=fonte%>" style=font-size:10px;color:#808080>
        &nbsp;&nbsp;&nbsp;
        1. <%=strLg282%> &nbsp;&nbsp;&nbsp;
        2. <%=strLg283%> &nbsp;&nbsp;&nbsp;
        3. <%=strLg284%> &nbsp;&nbsp;&nbsp;
        <font color="<%= Cor_texto_menu_fechamento_compras %>">4. <%=strLg285%></font> </td></tr><tr><td height=5></td></tr>
       </table>

       <table border=0 cellspacing=0 width=100% cellpadding=0>
        <tr><td height=5></td></tr>
        <tr><td height=1 bgcolor=<%=cor3%>></td></tr>
        <tr><td height=5></td></tr>
       </table></div>
      <table border=0 cellSpacing=0 width=575>
       <TR><TD colSpan=4 height=42><DIV align=center><B><FONT style=font-size:17px color=000000><%=tituloloja%></FONT></B><BR><FONT style=font-size:11px><%=endereco11%> - <%=bairro11%><BR><%=cidade11%>/<%=estado11%> - <%=pais11%> - <a href="mailto:<%=emailloja%>" style=text-decoration:none;><%=emailloja%><BR></DIV></TD></TR>
       <tr><td colspan=4>
        <table border=0 cellspacing=0 width=100% cellpadding=0>
         <tr><td height=5></td></tr>
         <tr><td height=1 bgcolor=<%=cor3%>></td></tr>
         <tr><td height=5></td></tr>
        </table>
       </td></tr>
       <tr><td colSpan=2 align=left><FONT style=font-size:11px color=000000><B>Compra de <%=session("nome1")%></B><TD colSpan=2 align=right><B><FONT style=font-size:11px color=000000>Data: </B> <%=diadata&"/"&mesdata&"/"&year(date)%></div></TD></TR>
       <tr><td colspan=4>
        <table border=0 cellspacing=0 width=100% cellpadding=0>
         <tr><td height=5></td></tr>
         <tr><td height=1 bgcolor=<%=cor3%>></td></tr>
         <tr><td height=5></td></tr>
        </table>
       </td></tr>
       <tr><td colspan=4><font style=font-size:11px;color:000000><b>Dados da entrega e do pedido </b></td></tr>
       <tr><td colSpan=2><font style=font-size:11px color=000000><b>Endereço: </b><%=strEndereco%><br><b>Bairro: </b> <%=strBairro%><br><b> Local:</b> <%=strCidade%>-<%=strEstado%></td><td colSpan=2><font style=font-size:11px color=000000><b> CEP:</b> <%=strCep%><br><b> País:</b> <%=strPais%><br><b> Telefone:</b> <%=strFone%></td></TR>
<%
   valortotalx = session("totalae")
  'Chama o nome da forma de pagament escolhida
   if strCartao="0" then
      forma = strLg222
   elseif strCartao="8" then
      forma = "Pagamento com cartão de débito VisaElectron."
   end if
%>
       <tr><td colspan=4>
        <table border=0 cellspacing=0 width=100% cellpadding=0>
         <tr><td height=5></td></tr>
         <tr><td height=1 bgcolor=<%=cor3%>></td></tr>
         <tr><td height=5></td></tr>
        </table>
        <font style=font-size:11px;font-family:<%=fonte%>;color:000000><b>Informações sobre sua compra</b>
       </td></tr>
       <tr>
        <td width=30%><font style=font-size:11px;font-family:<%=fonte%>;color:000000><b>Sub-total:</b>&nbsp;<%= strLgMoeda & " " & formatnumber(strCompq,2)%></td>
        <td width=20%><font style=font-size:11px;font-family:<%=fonte%>;color:000000><b>Frete:&nbsp;</b><%= strLgMoeda & " " & formatnumber(session("frete1"),2)%></td>
        <td width=25%><font style=font-size:11px;font-family:<%=fonte%>;color:000000><b>Valor Total:&nbsp;</b><%=strLgMoeda & " " & formatnumber(valortotalx,2)%></td><td width=40%></td>
       </tr>
       <tr><td colspan=4>
        <table border=0 cellspacing=0 width=100% cellpadding=0>
         <tr><td height=5></td></tr>
         <tr><td height=1 bgcolor=<%=cor3%>></td></tr>
         <tr><td height=5></td></tr>
        </table> 
        <font style=font-size:11px;font-family:<%=fonte%>;color:000000><b>Informações de pagamento (<%=forma%>)</b>
       </td></tr>
      <%
'Chama pela forma de pagamento a tela final
      if strCartao="0" OR strCartao="1" OR strCartao="2" OR strCartao="3" OR strCartao="8" then%>
       <tr>
        <td colspan=2><font style=font-family:<%=fonte%>;font-size:11px;color:#000000;><b>Últimos Dígitos:</b> <%=left(numero,2) & "/" & right(numero,5)%><br><b>Titular:</b> <%=strTitular%> <br></td>
        <td colspan=2 valign=top><font style=font-family:<%=fonte%>;font-size:11px;color:#000000;><b>Expiração do Cartão:</b> <%=strExpmes & "/" & strExpano%><br></td>
       </tr>
       <tr>
         <td valign=top><font style=font-family:<%=fonte%>;font-size:11px;color:#000000;><br><b>Status da transação:</b></font></td>
         <td colspan=2><font style=font-family:<%=fonte%>;font-size:11px;color=#a51905> <b>Compra confirmada com a operadora do <%=forma%>!</font></b></td>
       </tr>
       <TR> 
        <TD><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><B> Data/hora: </B></font></TD>
        <TD colspan=2><font size="1" face="Verdana, Arial, Helvetica, sans-serif"> <%=date()%>-<%=time()%></font></TD>
       </TR>
       <TR> 
        <TD><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><B> Identificação do pedido:</B></font> </TD>
        <TD colspan=2><font size="1" face="Verdana, Arial, Helvetica, sans-serif"> <%=varTid%> </font></TD>
       </TR>
       <TR> 
        <TD><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><B> Código de Autorização: </B></font> </TD>
        <TD colspan=2><font size="1" face="Verdana, Arial, Helvetica, sans-serif"> <%=varArp%> <%if cStr(varLr) = "0" or cStr(varLr) = "00" Then%> - Cartão emitido no Brasil <%else%>                          - Cartão emitido no exterior <%End IF%></font></TD>
       </TR>
       <TR> 
        <TD VALIGN=top><B> Código de Autenticação:</B></TD>
        <TD  VALIGN=top colspan="2"><%=varAUTHENT%>
          <%if cStr(varAUTHENT) = "1" Then%> 
            - Autenticação com Sucesso 
          <%elseif  cStr(varAUTHENT) = "2" Then%>
            - Autenticação Negada
          <%elseif  cStr(varAUTHENT) = "3" Then%>
            - Falha na Autenticação
          <%elseif  cStr(varAUTHENT) = "" Then%>
            - Transação Sem Autenticação 				            				            
          <%End IF%>
        </TD>
       </TR>
    <%end if%>
      <tr><td colspan=4>
       <table border=0 cellspacing=0 width=100% cellpadding=0>
         <tr><td height=5></td></tr>
         <tr><td height=1 bgcolor=<%=cor3%>></td></tr>
         <tr><td height=5></td></tr>
       </table>
       <font style=font-size:11px;font-family:<%=fonte%>;color:000000><b>Entrega da compra após a confirmação do pagamento</b>
      </td></tr>
      <tr><td colspan=2><font style=font-size:11px;font-family:<%=fonte%>;color:000000><b>Compra efetuada em:</b> <%=diadata&"/"&mesdata&"/"&year(date)%></td><td colspan=2><font style=font-size:11px;font-family:<%=fonte%>;color:000000><b>Previsão de entrega do pedido:</b> <%=diadatax&"/"&mesdatax&"/"&year(entdiax)%></td></tr>
      <tr><td colspan=4><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table></td></tr>
      <tr bgcolor=#ffffff><td colspan=4><font style=font-size:11px color=000000><center>Detalhes e informações sobre a sua compra já foram enviadas para o e-mail <b><%=session("email1")%></b>.<br>O número do seu pedido é <b>#<%=replace(strPedido,",","")%></b>, anote-o em um local seguro.<br>Sua sessão foi finalizada e todos os produtos do seu Carrinho de Compras foram removidos.</tr>
     <%
     'Abandona a sessão de compras do cliente
      session.abandon %>
      <tr><td colspan=4 valign=top>
      <table border=0 cellspacing=0 width=100% cellpadding=0>
       <tr><td height=5></td></tr>
       <tr><td height=1 bgcolor=<%=cor3%>></td></tr>
       <tr><td height=5></td></tr>
      </table>
      </tr></td>
      <form action=fim.asp>
        <input type=hidden name=usuario value="<%= strUser %>">
        <tr align=center><td colspan=2 valign=top><div id="layer1">
        <input type="image" name="fecha" src=<%=dirlingua%>/imagens/finaliza.gif onMouseOut="window.status='';return true;" onMouseOver="window.status='Finalizar Compras';return true;"></div></td><td colspan=2 valign=top>
      </form>
      <div id="layer1">
       <input type="image" name="fecha" src=<%=dirlingua%>/imagens/printrecibo.gif onMouseOut="window.status='';return true;" onMouseOver="window.status='Imprimir Recibo';return true;" OnClick="javascript: print()">
      </div>
      </td></tr>
     </table></form></td></tr>
    </table></td></tr>
   </table>
   </font></font></font></b>
<%
 end if
%>

<!-- #include file="baixo.asp" -->
