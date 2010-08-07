<%
'##########################################################################################
'#-----------------------------------------------------------------------------------------
'##########################################################################################
'#
'##########################################################################################
'# Criado por: Cirilo Jose Veloso - http://www.veloso.adm.br                              #
'# Objetivo  : Executar os componentes da RedeCard para pagamento com cartão              #
'# Fluxo     : Executa o função para criação do codigo de verificação, getcod() em df.asp #
'#             Venda Relizada: vai para pagamentoKomerci.asp                              #
'#             Venda Negada  : vai para pagamentoKomerci.asp                              #
'#                                                                                        #
'# Observação: Não pode ser copiado ou distribuído sem autorização do autor               #
'#-----------------------------------------------------------------------------------------
'##########################################################################################
'#-----------------------------------------------------------------------------------------
'##########################################################################################

'INÍCIO DO CÓDIGO

'----------------------------------------------------------- ----------------------------------------------------- 
'Este código está otimizado e roda tanto em Windows 2000/NT/XP/ME/98 quanto em servidores UNIX-LINUX com chilli!ASP
Dim varContador1x, varContador2x
varContador1x = timer
'----------------------------------------------------------- ----------------------------------------------------- 

 

'########################################################### ##############################
'### Mostra oferta criado por Antonio, sistema implantado com popup inteligente por
'### Rogério Silva - 09/01/2004 - WBSolutions - http://www.libihost.net/wbsolutions.
'### POPUP - OFERTA INTERVALO DE 5 EM 5 MINUTOS, CASO DESEJE ALTERE O VALOR APOS O MOD
'### NO CASO 5 - DEFAULT
'########################################################### ##############################

  tempo = cInt(Minute(time))
'----------------------------------------------------------- ----------------------------------------------------- 
  Response.Cookies("VSOferta").Expires =  DateAdd("d",1,date()) 'VENCE SEMPRE NO PROXIMO DIA
  IF tempo MOD 5 = 0 then
    IF Request.Cookies("VSOferta")("Abriu") = "Nao" THEN
    pop =  "function envio()"&VBCrlf&_
      "{"&VBCrlf&_
      "generico('mostraoferta. asp','contato',290,130,20,20,'no','no');"&VBCrlf&_ 
      "}"&VBCrlf&_
      "envio()"&VBCrlf
    Response.Cookies("VSOferta")("Abriu" ) = "Sim"
    END IF
  ELSE
  Response.Cookies("VSOferta")("Abriu") = "Nao"
  END IF
'----------------------------------------------------------- ----------------------------------------------------- %>

<!-- #include file="df.asp" -->
<!-- #include file="estats.asp"-->
<!-- #include file="banner/include/admentor2.asp"-->

<%
'INICIO DO HTML
'----------------------------------------------------------- ------------------------------------------ 
response.Write "<html>"&VBCRlf &_
    "<head>"&VBCRlf &_
    "<title>"&tituloloja&" </title>"&VBCRlf &_
    "<script language=""JavaScript"" src=""layer.js""></script>"&VBCRlf &_
    "<script language=""JavaScript"" src=""Browser_OS_Detection_css.js""></script>"& VBCRlf &_
    "<script language='JavaScript1.2'>"&VBCRlf &_
    "function click() {"&VBCRlf &_
    "if (event.button==2||event.button==3) {"&VBCRlf &_
    "oncontextmenu='return false';"&VBCRlf &_
    "}"&VBCRlf &_
    "}"&VBCRlf &_
    "document.onmousedown=click"&VBCRlf &_
    "document.oncontextmenu = new Function(""return false;"")"&VBCRlf &_
    pop & VBCRlf &_
      "</script>"&VBCRlf &_
    "<style type=""text/css"">"&VBCRlf &_
    "<!--"&VBCRlf &_
    "a:link      ;  { color: "&cor4&" }"&VBCRlf &_
    "a:visited    { color: "&cor4&" }"&VBCRlf &_
    "a:hover    &nbs p; { color: "&cor5&" }"&VBCRlf &_
    ".menu:link { color:"&fontebranca&"; text-decoration: none;}"&VBCRlf &_
    ".menu:visited { color:"&fontebranca&"; text-decoration: none;}"&VBCRlf &_
    ".menu:hover { color:"&fontebranca&"; text-decoration: underline;}"&VBCRlf &_
    ".baixo:link { color:"&cor4&"; text-decoration: none;}"&VBCRlf &_
    ".baixo:visited { color:"&cor4&"; text-decoration: none;}"&VBCRlf &_
    ".baixo:hover { color:"&cor4&"; text-decoration: underline;}"&VBCRlf &_
    "-->"&VBCRlf &_
    "</style>"&VBCRlf &_
    "</head>"&VBCRlf &_
    "<body bgcolor="&application("corfundo")&" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 text="&cor4&" onload='document.form_card.submit();' >"&VBCRlf

'----------------------------------------------------------- ------------------------------------------ 
'Personaliza os links do  menu se o cliente estiver efetuando a compra
'----------------------------------------------------------- ------------------------------------------ 
if session("usuario") = "" then
 link = "fechapedido.asp?compra=login"
else
 link = "fechapedido.asp?compra=ok"
end if
'----------------------------------------------------------- ------------------------------------------ 
if session("ende1") = "" then
 link = link
else
 link = "formaspagamento.asp"
end if
'----------------------------------------------------------- ------------------------------------------ 
response.Write  "<table width=778 cellpadding=""0"" cellspacing=""0"" align=""center"" >"&VBCRlf &_
    "<tr>"&VBCRlf &_
    " <td>"&VBCRlf &_
    "<basefont face="&fonte&">"&VBCRlf &_
    "<table border=""0"" width=""778"" bgcolor=#ffffff cellpadding=""1"" cellspacing=""1"">"&VBCRlf
response.write "   <tr>"&VBCRlf &_
    "   <td valign=""bottom"" nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="" "&dirlingua&"/imagens/"&arquivo_logo_loja&"" "  border=""0""></td>"&VBCRlf

if Banner_AdMentor="Sim" then
response.Write "     <td valign=""middle"" align=""center"" width=234 height=60>"&VBCRlf &_
        AdMentor_Get AdASP("F=0&Z=0&N=1") &VBCRlf &_
    "    </td>"&VBCRlf
elseif Banner_Fixo<>"" then
response.Write "     <td valign=""middle"" align=""center"" width=234 height=60><img src="" banners/"&Banner_Fixo&"""  border=""0""></td>"&VBCRlf
end if

response.Write "     <td valign=""bottom"" nowrap align=""right"">"&VBCRlf &_
    "     <table>"&VBCRlf &_
    "      <tr>"&VBCRlf &_
    "       <td valign=center><a href=""carrinhodecompras.asp""  style=""color:#000000;text-decoration:none;"" onMouseOut=""window.status='';return true;"" onMouseOver=""window.status='"&strLg1&"';return true;""><img src="&dirlingua&"/imagens/carrinho_novo.gif border=0></a></td>"&VBCRlf &_
    "       ;<td valign=top>"&VBCRlf 
'----------------------------------------------------------- ------------------------------------------ 
'#### INICIO DO 1º IF 
'----------------------------------------------------------- ------------------------------------------ 
'Cria o carrinho de compras no topo superior da loja
'----------------------------------------------------------- ------------------------------------------ 
if cstr(Session("orderID")) = "" then
 '----------------------------------------------------- -------------------------------------------- 
 'Chama o nome do cliente da tabela clientes
 '----------------------------------------------------- -------------------------------------------- 
 Set dados = abredb.Execute("SELECT email,nome FROM clientes WHERE email='"&Cripto(session("usuario"),true)&"';")
  '----------------------------------------------------------- ------------------------------------------ 
 'Faz aparecer somento o primeiro nome do cliente
  '----------------------------------------------------------- ------------------------------------------ 
 if dados.eof then
  nomez = ""
 else
  nomeq = Cripto(dados("nome"),false)
  numeroz = Instr(1,nomeq," ")
  var5000 = Left(nomeq,numeroz)
  '----------------------------------------------------------- ------------------------------------------ 
   if var5000 = "" then
    var5000 = nomeq
   else
    var5000 =  Left(nomeq,numeroz)
   end if
  '----------------------------------------------------------- ------------------------------------------   
 nomez = "&nbsp;"&var5000
 end if
  '----------------------------------------------------------- ------------------------------------------ 
 'Fecha tabela clientes
  '----------------------------------------------------------- ------------------------------------------ 
 dados.Close
 set dados = Nothing
  '----------------------------------------------------------- ------------------------------------------ 
 response.Write "   <table width=""100%"" border=""0"" onMouseOver=""window.status='"&strLg1&"';return true;"" onMouseOut=""window.status='';return true;"">"&VBCrlf &_
     " <tr><td >"&VBCrlf &_
     "    <table>"&VBCrlf &_
     "      <tr><td bgcolor=#ffffff>"&VBCrlf
          %>
    <!-- ////  Quadro Superior  de  Carrinho de Compras -->
                  
       <TABLE cellSpacing=0 cellPadding=0 width=210 border=0 >
                     <TR><TD style="BACKGROUND: <%= Cor_principal %>; HEIGHT: 24px" colSpan=3> &nbsp;&nbsp;<B><font color="#FFFFFF"><%= "<a href=""carrinhodecompras.asp""  style=""color:#000000;text-decoration:none;"" onMouseOut=""window.status='';return true;"" onMouseOver=""window.status='"&strLg1&"';return true;"">&nbsp;<b><font color='#FFFFFF'>"&left(strLg7,Len(strLg7)-3)&"< ;/font></a><b>" %></font></B></TD></TR>
                     </TBODY></TABLE>
       
     <TABLE cellSpacing=0 cellPadding=2 width=210 border=0 bgcolor="#ffffff" style="BACKGROUND: #f0f0f0; BORDER-LEFT: #bbbaba 1px solid; BORDER-RIGHT: #bbbaba 1px solid; BORDER-BOTTOM: #bbbaba 1px solid">
                      <TR><TD align=left nowrap ><font color="#0000ff"><%= strLg2 %> </font></TD><TD align=left nowrap><font color="#0000ff"> 0 </font></TD></TR>
                      <TR><TD align=left nowrap><font color="#0000ff"><%= strLg3 %> </font></TD><TD align=left nowrap><font color="#0000ff"><%= strLgMoeda %> 0,00</font></TD></TR></TBODY></TA BLE>

    <!-- ////  Fim do Quadro Superior  de  Carrinho de Compras -->
         
     <%
    response.Write " </td></tr></table>"
'----------------------------------------------------------- ------------------------------------------ 
else
'----------------------------------------------------------- ------------------------------------------ 
 intOrderID = cstr(Session("orderID"))
  '----------------------------------------------------------- ------------------------------------------ 
 'Chama o nome do cliente da tabela clientes
  '----------------------------------------------------------- ------------------------------------------ 
 Set dados = abredb.Execute("SELECT email, nome FROM clientes WHERE email='"&Cripto(session("usuario"),true)&"';")
  '----------------------------------------------------------- ------------------------------------------ 
 'Faz aparecer somento o primeiro nome do cliente
  '----------------------------------------------------------- ------------------------------------------ 
 if dados.EOF then
  nomez = ""
 else
  nomeq = Cripto(dados("nome"),true)
  numeroz = Instr(1,nomeq," ")
  var5000 = Left(nomeq,numeroz)
  if var5000 = "" then
   var5000 = nomeq
  else
   var5000 =  Left(nomeq,numeroz)
  end if
 nomez = "&nbsp;"&var5000
 end if
'----------------------------------------------------------- ------------------------------------------ 
'Fecha tabela clientes
'----------------------------------------------------------- ------------------------------------------ 
dados.Close
set dados = Nothing
'----------------------------------------------------------- ------------------------------------------ 
'Chama os dados dos produtos comprados e monta o carrinho
'----------------------------------------------------------- ------------------------------------------ 
 set pedidos = abredb.Execute("SELECT idprod, quantidade FROM pedidos WHERE idcompra='"&intOrderID&"';")
 while not pedidos.EOF
  idprod = pedidos("idprod")
  quantidade = pedidos("quantidade")
  set produtos = abredb.Execute("SELECT preco, nome FROM produtos WHERE idprod="&idprod&";")
  preco = produtos("preco")
  nome = produtos("nome")
 '----------------------------------------------------- -------------------------------------------- -
 'Calcula os dados
 '----------------------------------------------------- -------------------------------------------- -
  intProdID = idprod
  strProdName = nome
  intProdPrice = preco
  intQuant = cint(quantidade)
  intQuantx = cint(intQuantx) + cint(intQuant) 
  intTotal = intTotal + (intQuant * intProdPrice)
  inTotal = cint(inTotal)
  pedidos.MoveNext
 wend
'----------------------------------------------------------- ------------------------------------------ 
'Fecha os dados dos produtos comprados
'----------------------------------------------------------- ------------------------------------------ 
pedidos.Close
set pedidos = Nothing
'----------------------------------------------------------- ------------------------------------------ 
'Valor do preço total
'----------------------------------------------------------- ------------------------------------------ 
precito1 = formatNumber(intTotal,2)

Response.Write " <table onMouseOut=""window.status='';return true;"" onMouseOver=""window.status='"&strLg1&"';return true;"">"&VBCrlf &_
    "<tr>"&VBCrlf &_
    "<td >"&VBCrlf &_
       "<table width=""100%"">"&VBCrlf &_
    "    <tr>"&VBCrlf &_
    "<td bgcolor=#ffffff>"&VBCrlf
          %>
    <!-- ////  Quadro Superior  de  Carrinho de Compras -->
                  
       <TABLE cellSpacing=0 cellPadding=0 width=210 border=0 >
                     <TR><TD style="BACKGROUND: <%= Cor_principal %>; HEIGHT: 24px" colSpan=3> &nbsp;&nbsp;<B><font color="#FFFFFF"><%= "<a href=""carrinhodecompras.asp""  style=""color:#000000;text-decoration:none;"" onMouseOut=""window.status='';return true;"" onMouseOver=""window.status='"&strLg1&"';return true;"">&nbsp;<b><font color='#FFFFFF'>"&left(strLg7,Len(strLg7)-3)&"< ;/font></a><b>" %></font></B></TD></TR>
                     </TBODY></TABLE>
       
     <TABLE cellSpacing=0 cellPadding=2 width=210 border=0 bgcolor="#ffffff" style="BACKGROUND: #f0f0f0; BORDER-LEFT: #bbbaba 1px solid; BORDER-RIGHT: #bbbaba 1px solid; BORDER-BOTTOM: #bbbaba 1px solid">
                      <TR><TD align=left nowrap ><font color="#0000ff"><%= strLg2 %> </font></TD><TD align=left nowrap><font color="#0000ff"> <%= intQuantx %> </font></TD></TR>
                      <TR><TD align=left nowrap><font color="#0000ff"><%= strLg3 %> </font></TD><TD align=left nowrap><font color="#0000ff"><%= strLgMoeda %> <%= precito1 %></font></TD></TR></TBODY></T ABLE>

    <!-- ////  Fim do Quadro Superior  de  Carrinho de Compras -->
         
     <%
    response.Write " </td></tr></table>"&VBCrlf &_
    "</td>"&VBCrlf &_
    "</tr>"&VBCrlf &_
    "</table>"&VBCrlf 
end if
'----------------------------------------------------------- ------------------------------------------ 
'#### TÉRMINO DO 1º IF 
'----------------------------------------------------------- ------------------------------------------ 
Response.Write "</td>"&VBCrlf &_
    "</tr>"&VBCrlf &_
    "</table>"&VBCrlf &_
    "</td>"&VBCrlf &_
    "</tr>"&VBCrlf &_
    "</table>"&VBCrlf
'----------------------------------------------------------- ------------------------------------------ 
set rs = abredb.execute("SELECT nome FROM clientes where email='" & Cripto(Session("usuario"),true) & "'")
'----------------------------------------------------------- ------------------------------------------ 
if rs.eof then
 strNome = strLg264
else
 nomeq = Cripto(rs("nome"),false)
 numeroz = Instr(1,nomeq," ")
 var5000 = Left(nomeq,numeroz)
'----------------------------------------------------------- ------------------------------------------ 
  if var5000 = "" then
   var5000 = nomeq
  else
   var5000 =  Left(nomeq,numeroz)
  end if
'----------------------------------------------------------- ------------------------------------------ 
strNome = Trim(var5000)
strNome2 = Trim(Cripto(rs("nome"),false))
end if
'----------------------------------------------------------- ------------------------------------------ 
rs.close
set rs = nothing

'----------------------------------------------------------- ------------------------------------------ 
'Personaliza o menu se o cliente estiver logado
'----------------------------------------------------------- ------------------------------------------ 
%>


<!-- ////   Sombra da Barra de Botoes -->


<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD bgColor=#808080><IMG height=1 
      src="<%= dirlingua %>/imagens/spacer.gif" width=1></TD></TR></TBODY></TABLE> ;

<!-- ////   Fim da Sombra da Barra de Botoes -->

 

<!-- ////    Barra de Botoes -->


<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#f0f0f0 border=0>
  <TBODY>
  <TR>
    <TD><IMG height=32 src="<%= dirlingua %>/imagens/spacer.gif" width=5></TD>
    <TD align=left width="40%"><!-- <IMG height=35 
      src="<%= dirlingua %>/imagens/telephone_151x35.gif" width=151 border=0> --></TD>
    <TD><IMG height=32 src="<%= dirlingua %>/imagens/spacer.gif" width=5></TD>
    <TD vAlign=center noWrap align=middle><!--- start SEARCH ---><!--- end SEARCH ---></TD>
    <TD noWrap align=right width="40%">
 
<% 
if session("usuario") = "" or InStr(Request.ServerVariables("SCRIPT_NAME"),"/pagamento.asp ") > 0 then
'*** Se for a tela final de compra (pagamento.asp) tb, pois aparecia o menu errado (pois era encerrado a 'sessao' na tela final de compra apos já ter aparecido o menu de 'logado') 
%> 
      <TABLE cellSpacing=0 cellPadding=0 width=240 border=0>
        <TBODY>
        <TR>
          <TD><A href="default.asp"><IMG src="<%= dirlingua %>/imagens/botao_superior_home.gif" border=0 target="home"></A></TD>
          <TD><IMG height=1 src="<%= dirlingua %>/imagens/spacer_1x1.gif" 
             width=3 border=0></TD>
          <TD><A href="carrinhodecompras.asp"><IMG src="<%= dirlingua %>/imagens/botao_superior_finalizar_compras.gif" border=0 target="home"></A></TD>
          <TD><IMG height=1 src="<%= dirlingua %>/imagens/spacer_1x1.gif" 
             width=3 border=0></TD>
          <TD><A href="registro.asp"><IMG src="<%= dirlingua %>/imagens/botao_superior_registro_clientes.gif" border=0 target="home"></A></TD>
          <TD><IMG height=1 src="<%= dirlingua %>/imagens/spacer_1x1.gif" 
             width=3 border=0></TD>
          <TD><A href="fechapedido.asp?compra=login&menu=sim"><IMG src="<%= dirlingua %>/imagens/botao_superior_login.gif" border=0 target="home"></A></TD>
          <TD><IMG height=1 src="<%= dirlingua %>/imagens/spacer_1x1.gif" 
             width=3 border=0></TD>
          <TD><A href="como.asp"><IMG src="<%= dirlingua %>/imagens/botao_superior_como_comprar.gif" border=0 target="home"></A></TD>
          <TD><IMG height=1 src="<%= dirlingua %>/imagens/spacer_1x1.gif" 
             width=3 border=0></TD></TR></TBODY></TABLE&g t;
<% Else  %>
      <TABLE cellSpacing=0 cellPadding=0 width=240 border=0>
        <TBODY>
        <TR>
          <TD><A href="default.asp"><IMG src="<%= dirlingua %>/imagens/botao_superior_home.gif" border=0 target="home"></A></TD>
          <TD><IMG height=1 src="<%= dirlingua %>/imagens/spacer_1x1.gif" 
             width=3 border=0></TD>
          <TD><A href="carrinhodecompras.asp"><IMG src="<%= dirlingua %>/imagens/botao_superior_finalizar_compras.gif" border=0 target="home"></A></TD>
          <TD><IMG height=1 src="<%= dirlingua %>/imagens/spacer_1x1.gif" 
             width=3 border=0></TD>
          <TD><A href="dados.asp"><IMG src="<%= dirlingua %>/imagens/botao_superior_meus_dados.gif" border=0 target="home"></A></TD>
          <TD><IMG height=1 src="<%= dirlingua %>/imagens/spacer_1x1.gif" 
             width=3 border=0></TD>
          <TD><A href="minhascompras.asp"><IMG src="<%= dirlingua %>/imagens/botao_superior_historico_compras.gif" border=0 target="home"></A></TD>
          <TD><IMG height=1 src="<%= dirlingua %>/imagens/spacer_1x1.gif" 
             width=3 border=0></TD>
    <TD><A href="conf_pagamento.asp"><IMG src="<%= dirlingua %>/imagens/botao_superior_pagamento.gif" border=0 target="home"></A></TD>
          <TD><IMG height=1 src="<%= dirlingua %>/imagens/spacer_1x1.gif" 
             width=3 border=0></TD>
          <TD><A href="logout.asp"><IMG src="<%= dirlingua %>/imagens/botao_superior_logout.gif" border=0 target="home"></A></TD></TR></TBODY& gt;</TABLE>
<% End If %>
</TD>
    <TD><IMG height=32 src="<%= dirlingua %>/imagens/spacer.gif" 
  width=5></TD></TR></TBODY></TABLE> ;
  
  
<!-- ////   Fim da  Barra de Botoes -->

 

<!-- ////   Sombra da Barra de Botoes  -->


<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD bgColor=#808080><IMG height=1 
      src="<%= dirlingua %>/imagens/spacer.gif" width=1></TD></TR></TBODY></TABLE> ;

<!-- ////   Fim da Sombra da Barra de Botoes   -->

 


   
<!-- //////   Inicio do Azulao (Barra de cor) -->


<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=<%= Cor_principal %> border=0>
  <TBODY>
  <TR>
    <TD rowSpan=2><IMG height=20 src="<%= dirlingua %>/imagens/spacer.gif" 
      width=5></TD>
    <TD width="100%"><IMG height=3 src="<%= dirlingua %>/imagens/spacer.gif" 
      width=270></TD>
    <TD rowSpan=2><IMG height=20 src="<%= dirlingua %>/imagens/spacer.gif" 
      width=5></TD></TR>
  <TR>
    <TD align=middle></TD></TR>
  <TR>
    <TD colSpan=3><IMG height=3 src="<%= dirlingua %>/imagens/spacer.gif" 
      width=1></TD></TR></TBODY></TABLE> ;
   
   
   
<!-- //////   Fim do Azulao (Barra de cor) -->

 

<!--   //////    Sombra do Azulao  - shadow -->


<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD bgColor=#000000><IMG height=1 
      src="<%= dirlingua %>/imagens/spacer.gif" width=1></TD></TR></TBODY></TABLE> ;
   
   
<!--   //////  Fim da Sombra do Azulao  - shadow -->

 

<!-- ////    Barra de Procura   -->


<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#f0f0f0 border=0>
  <TBODY>
  <TR>
    <TD><IMG height=32 src="<%= dirlingua %>/imagens/spacer.gif" width=5></TD>
    <TD align=left width="40%"><IMG height=35 
      src="<%= dirlingua %>/imagens/disque_loja.gif" width=151 border=0></TD>
    <TD><IMG height=32 src="<%= dirlingua %>/imagens/spacer.gif" width=5></TD>
    <TD vAlign=center noWrap align=middle><!--- start SEARCH --->

      <FORM style="DISPLAY: inline" name=newsearch action=pesquisa.asp method=get>
      <TABLE cellSpacing=0 cellPadding=1 border=0>
        <TBODY>
        <TR>
          <TD nowrap>
           <input type=text name=pesq value="<%= request.querystring("pesq") %>" size=25 style=font-size:11px;font-family:<%=fonte%>;><br >
          <select name=cat style=font-size:11px;font-family:<%=fonte%>>
          <option value=todos><%=strLg15%> </option>
          <option value=xxx>------------------------------</option>
          
<%Dim scat
'----------------------------------------------------------- --------------------------------------- 
'Monta a select de pesquisa
'----------------------------------------------------------- --------------------------------------- 
Set cat = abredb.Execute("SELECT * FROM sessoes WHERE ver = 's' ORDER by nome;")
While Not cat.EOF 
'Response.Write "<option value="& cat("id") &" style=color:#808080;>"&CHR(187)&"&nbsp;"& cat("nome") &"</option>"&VBCRlf 
Response.Write "<option value="""" style=color:#808080;>"&CHR(187)&"&nbsp;"& cat("nome") &"</option>"&VBCRlf 
  '########################################################### ##############################
  '#---------------------------------------------------------- ------------------------------
  '########################################################### ##############################
 '### Mostra categorias e sub-categorias
 '### Rogério Silva - WBSolutions - http://www.libihost.net/wbsolutions.
 '###    SUB MENU / CATEGORIA
  '########################################################### ##############################
  SQL = "SELECT C.idcategoria, C.nome FROM categoria as c ,sessoes as s  WHERE s.id = c.idsessao and c.idsessao = "&cat("id")&" AND C.ver = 's' ORDER by c.nome"
  Set scat = abredb.Execute(SQL)
   While Not scat.EOF
    Response.Write "<option value="&scat("idcategoria")&">&nbsp;&nbsp ; " &CHR(149)&"&nbsp;" & scat("nome")&"</option>"&VBCRlf 
    scat.MoveNext
   Wend
cat.MoveNext
Wend
Response.Write "</select></font>"&VBCRlf %>
          
   </TD>
          <TD>
   
    <INPUT class=searchforms type=image alt="Pesquisar" src="<%= dirlingua %>/imagens/botao_pesquisar.gif" onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg21%>';return true;" align="absmiddle"> </TD></TR></TBODY></TABLE></FORM& gt;<!--- end SEARCH ---></TD>
    <TD noWrap align=right width="40%" valign="middle"><%= strLg265 %> <b><%=strNome%></b>! &nbsp;&nbsp;</TD></TR></TBODY>< /TABLE>
  
  
<!-- ////   Fim da  Barra de Procura  -->

 

<!-- ////   Sombra da Barra de Procura   -->


<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD bgColor=#808080><IMG height=1 
      src="<%= dirlingua %>/imagens/spacer.gif" width=1></TD></TR></TBODY></TABLE> ;

<!-- ////   Fim da Sombra da Barra de Procura   -->


<!-- ////   Area Branca Divisor   -->


<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD bgColor=#ffffff><IMG height=25 
      src="<%= dirlingua %>/imagens/spacer.gif" width=1></TD></TR></TBODY></TABLE> ;

<!-- ////   Fim Area Branca Divisor   -->

 

<%
'----------------------------------------------------------- ------------------------------------------ 
%>

 

  <!-- LAYER PRINCIPAL -->
  
  
  <div id="layer1" style="position:absolute; top:200px; z-index:1">
  
    <table border="0" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0" width="750">
    <tr>
    <td width="161" valign="top" align="center">
      <table border="0" cellspacing="4" cellpadding="4" width="161">
 <tr>
 <td>
  
<!--  ///  Inicio do Menu Departamentos -->

      <TABLE cellSpacing=0 cellPadding=0 width=161 border=0>
        <TBODY>
        <TR>
          <TD colSpan=3 valign="top">

             <TABLE style="BORDER-RIGHT: #bbbaba 1px solid; BORDER-TOP: #bbbaba 1px solid; BORDER-LEFT: #bbbaba 1px solid; BORDER-BOTTOM: #bbbaba 1px solid; HEIGHT: 24px" cellSpacing=0 cellPadding=0 width="100%" align=center  border=0>
               <TBODY>
               <TR>
                 <TD bgColor=#ebefef>&nbsp;<B><%=(strLg12)%>&l t;/B></TD></TR></TBODY></TABLE>&l t;/TD></TR>
        <TR>
          <TD bgColor=#cccccc><IMG height=1 
             src="<%= dirlingua %>/imagens/spacer.gif" width=1></TD>
          <TD align=middle>
     <div id="masterdiv">
             <TABLE cellSpacing=0 cellPadding=2 width=159 bgColor=#ffffff 
             border=0>
               <TBODY>
         <!--      <TR>
                 <TD><FONT face="verdana, arial, helvetica" color=#000000 
                    size=2><B>Hardware</B></FONT> </TD></TR> -->
               <TR>
                 <TD>&nbsp; </TD></TR>
<%
Mostrar = Request.QueryString("item")
Dim Smenu

'----------------------------------------------------------- ------------------------------------------ 
'Monta o menu de departamentos (Sessoes e Categorias)
'----------------------------------------------------------- ------------------------------------------ 

   '########################################################### ##############################
  '### Mostra as Sessoes da Loja
  '### Rogério Silva - WBSolutions - http://www.libihost.net/wbsolutions.
  '###    MENU PRINCIPAL (Tabela Sessoes)
   '########################################################### ##############################

Set menu = abredb.Execute("SELECT * FROM sessoes WHERE ver = 's' ORDER by nome;")
DO While Not menu.EOF

'Verifica se existe alguma categoria sem sub-categoria, ou seja, se o produto estiver cadastrado em uma SubCategoria chamado 'Todos' , a Categoria será 'linkado' diretamente para os seus produtos

 SQL = "SELECT nome FROM categoria WHERE nome = 'Todos' AND idsessao = "&menu("id")&""
 Set sem_categ = abredb.Execute(SQL)
 if not sem_categ.EOF then %>
  <TR><TD onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=menu("nome")%>';return true;">
  <a href="sessoes.asp?item=<%=menu("id")%>&Categoria=" style="text-decoration:none;" onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=menu("nome")%>';return true;">
    &nbsp; <%=menu("nome")%></a><BR>
  </TD></TR>
<%  else %>
               <TR>
                 <TD onMouseOut="window.status='';return true;" onMouseOver="window.status='<%= menu("nome") %>';return true;">
    <div class="menutitle" onclick="SwitchMenu('<%=menu("nome")%>')" style="cursor:hand">
    &nbsp; <%=menu("nome")%>
    </div>
    <%IF cInt(Mostrar) = menu("id") then
    Response.Write "<span class=""submenu"" id="""&menu("nome")&""" style=""display:block"">"
    ELSE
    Response.Write "<span class=""submenu"" id="""&menu("nome")&""" style=""display:none"">"
    END IF

   '########################################################### ##############################
  '### Mostra as Categorias das Sessoes da Loja
  '### Rogério Silva - WBSolutions - http://www.libihost.net/wbsolutions.
  '###    SUB MENU (Tabela Categoria)
   '########################################################### ##############################
   SQL = "SELECT C.idcategoria, C.nome FROM categoria as c ,sessoes as s  WHERE s.id = c.idsessao and c.idsessao = "&menu("id")&" AND C.ver = 's' AND C.nome <> 'Todos' ORDER by c.nome"
   Set Smenu = abredb.Execute(SQL)
   While Not Smenu.EOF%>
  <a href="sessoes.asp?item=<%=menu("id")%>&Categoria=& lt;%=Smenu("idcategoria")%>" style="text-decoration:none;" onMouseOut="window.status='';return true;" onMouseOver="window.status='<%= menu("nome")&" > "&Smenu("nome") %>';return true;">
    <B>&nbsp;&nbsp;&nbsp;<img src='<%=dirlingua%>/imagens/flechav.gif' border=0>&nbsp;&nbsp;<%=Smenu("nome")%>< /B></a><BR>
    <%Smenu.MoveNext
    Wend %></span>
    </TD></TR>
<% end if 
 sem_categ.close
 set sem_categ=Nothing%>    

<%
menu.MoveNext
Loop
'----------------------------------------------------------- ------------------------------------------ 
'Fecha o menu
'----------------------------------------------------------- ------------------------------------------ 
menu.Close
Set menu = Nothing


'----------------------------------------------------------- ------------------------------------------ 
'Response.Write "</table>"   %>
   </TBODY></TABLE><BR>< /TD>
          <TD bgColor=#cccccc><IMG height=1 
             src="<%= dirlingua %>/imagens/spacer.gif" width=1></TD></TR>
        <TR>
          <TD bgColor=#cccccc colSpan=3><IMG height=1 
             src="<%= dirlingua %>/imagens/spacer.gif" 
      width=1></TD></TR></TBODY></TABLE> ;
   
<!-- ////    Fim do Menu Departamentos  -->

 <BR><IMG height=10 
             src="<%= dirlingua %>/imagens/spacer.gif" width=1><BR>


<!-- /////     Quadro Atendimento - Lateral Esquerdo  -->

   
             <TABLE cellSpacing=0 cellPadding=0 width=160 border=0 >
                     <TR><TD style="BACKGROUND: <%= Cor_principal %>; HEIGHT: 22px" colSpan=3> &nbsp;&nbsp;<B><font color="#FFFFFF"><%=strLg14%></font></B> </TD></TR>
                     </TBODY></TABLE>
       
     <TABLE cellSpacing=0 cellPadding=2 width=160 border=0 bgcolor="#ffffff" style="BACKGROUND: #ffffff; BORDER-LEFT: #bbbaba 1px solid; BORDER-RIGHT: #bbbaba 1px solid; BORDER-BOTTOM: #bbbaba 1px solid">

                      <TR>
                        <TD class=ti><IMG alt="Blue Arrow" 
                          src="<%= dirlingua %>/imagens/arrow_blue.gif" 
                          border=0>&nbsp;<A class=bbh 
                          href="como.asp"><%=strLg16%></A></TD>&l t;/TR>

                      <TR>
                        <TD class=ti><IMG alt="Blue Arrow" 
                          src="<%= dirlingua %>/imagens/arrow_blue.gif" 
                          border=0>&nbsp;<A class=bbh 
                          href="comopagar.asp"><%=strLg287%></A></TD ></TR>
                      <TR>
                        <TD class=ti><IMG alt="Blue Arrow" 
                          src="<%= dirlingua %>/imagens/arrow_blue.gif" 
                          border=0>&nbsp;<A class=bbh 
                          href="como_reimprimir_boleto.asp"><%=strLg288%>< /A></TD></TR>     &n bsp;
                      <TR>
                        <TD class=ti><IMG alt="Blue Arrow" 
                          src="<%= dirlingua %>/imagens/arrow_blue.gif" 
                          border=0>&nbsp;<A class=bbh 
                          href="como_conf_pagamento.asp"><%=strLg313%></A& gt;</TD></TR>       ;
                      <TR>
                        <TD class=ti><IMG alt="Blue Arrow" 
                          src="<%= dirlingua %>/imagens/arrow_blue.gif" 
                          border=0>&nbsp;<A class=bbh 
                          href="ajuda_email.asp"><%=strLg17%></A></T D></TR>
                      <TR>
                        <TD class=ti><IMG alt="Blue Arrow" 
                          src="<%= dirlingua %>/imagens/arrow_blue.gif" 
                          border=0>&nbsp;<A class=bbh 
                          href="quemsomos.asp"><%=strLg20%></A></TD& gt;</TR>
                      <TR>
                        <TD class=ti><IMG alt="Blue Arrow" 
                          src="<%= dirlingua %>/imagens/arrow_blue.gif" 
                          border=0>&nbsp;<A class=bbh 
                          href="seguranca.asp"><%=strLg22%></A></TD& gt;</TR>
      <% If mostrar_politica_de_trocas="Sim" then%>
                      <TR>
                        <TD class=ti><IMG alt="Blue Arrow" 
                          src="<%= dirlingua %>/imagens/arrow_blue.gif" 
                          border=0>&nbsp;<A class=bbh 
                          href="politica_de_trocas.asp"><%=strLg296%></A&g t;</TD></TR>
      <% End If %>

</TBODY></TABLE>
     
     
     <BR><IMG height=10 src="<%= dirlingua %>/imagens/spacer.gif" width=1><BR>
   

     
<!-- /////    Fim do Quadro Atendimento - Lateral Esquerdo  -->

 

 

<!-- /////     Quadro Linguagens - Lateral Esquerdo  -->
<%
If mostrar_quadro_linguagens="Sim" then 

 '*** Colcoado este filtro, pois se for usado a traducao nesta pagina, ocorrerá um erro, pois é ENCERRADO a sessão no pagamento.asp
  If InStr(Request.ServerVariables("SCRIPT_NAME"),"pagamento.asp" ) = 0 then %>
   
             <TABLE cellSpacing=0 cellPadding=0 width=160 border=0 >
                     <TR><TD style="BACKGROUND: <%= Cor_principal %>; HEIGHT: 22px" colSpan=3> &nbsp;&nbsp;<B><font color="#FFFFFF"><%=strLg260%></font></B> ;</TD></TR>
                     </TBODY></TABLE>
       
     <TABLE cellSpacing=0 cellPadding=2 width=160 border=0 bgcolor="#ffffff" style="BACKGROUND: #ffffff; BORDER-LEFT: #bbbaba 1px solid; BORDER-RIGHT: #bbbaba 1px solid; BORDER-BOTTOM: #bbbaba 1px solid">

                      <TR>
                        <TD class=ti align="center"><%= OpcaoLingua %></TD></TR>

</TBODY></TABLE>
     
     
<BR><IMG height=10 src="<%= dirlingua %>/imagens/spacer.gif" width=1><BR>
   

<%
 end If
end if %>     
<!-- /////    Fim do Quadro Linguagens - Lateral Esquerdo  -->


<!-- /////    Quadro Atendimento Online - Lateral Esquerdo  -->

<%
Set Conn= Server.CreateObject("adodb.connection")
Conn.open  "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="& Server.MapPath("chat/LiveSupport.mdb") 
'----------------------------------------------------------- ---------------------------------------       
SQl = "select * from tblSettings where Online = '0'"
set Rs = Conn.execute(SQL)
'----------------------------------------------------------- --------------------------------------- 
 if Rs.eof then

  '*** Para aparecer a imagem de Atendimento "Online"

  Response.Write " <img src="&dirlingua&"/imagens/atend_on.gif onclick=""javascript:generico('chat/default.asp','aol',400,3 00,20,20,'no','no')""  border=0 style=""cursor:hand"" onMouseOut=""window.status='';return true;"" onMouseOver=""window.status='"&strLg258&"';return true;""><BR><br><br>"
 else

  '*** Para aparecer a imagem de Atendimento "Offline"  >>> Ative se vc quiser que avise que nao em ninguem "Online"

  'Response.Write " <img src="&dirlingua&"/imagens/atend_off.gif border=0 onMouseOut=""window.status='';return true;"" onMouseOver=""window.status='"&strLg259&"';return true;"" alt="&strLg259&"><BR><br><br>"
 end if
'----------------------------------------------------------- ---------------------------------------  
set rs = nothing
set atend = nothing%>
<!-- /////    Fim do Quadro Atendimento Online - Lateral Esquerdo  -->

<br>   

<a href="seguranca.asp"><IMG src="<%= dirlingua %>/imagens/site_seguro2.gif" border=0 ></a>
<br><br><br><br>
<% If entrega_sedex="Sim" then %>
<IMG src="<%= dirlingua %>/imagens/sedex.gif" border=0 >
<br><br><br><br>
<% End If %>

<% If entrega_motoboy="Sim" then %>
&nbsp;&nbsp;&nbsp;&nbsp;<IMG align="absmiddle" src="<%= dirlingua %>/imagens/motoboy.gif"  border=0 >
<br><br><br><br>
<% End If %>

<!-- /////    Inicio do Quadro Contador - Lateral Esquerdo  -->  
      
<!--#include file="contador.asp"-->

<% If mostrar_contador="Sim" then %>
              <TABLE cellSpacing=0 cellPadding=0 width=160 border=0 >
                     <TR><TD style="BACKGROUND: <%= Cor_principal %>; HEIGHT: 22px" colSpan=3> &nbsp;&nbsp;<font color="#FFFFFF" size="1"><%=strLg263&date%></font></TD ></TR>
                     </TBODY></TABLE>
       
     <TABLE cellSpacing=0 cellPadding=2 width=160 border=0 bgcolor="#ffffff" style="BACKGROUND: #ffffff; BORDER-LEFT: #bbbaba 1px solid; BORDER-RIGHT: #bbbaba 1px solid; BORDER-BOTTOM: #bbbaba 1px solid">

                      <TR>
                        <TD class=ti align="center"><strong><font face="Tahoma" color="#555555" style=font-size:12px><%=formatazeros(UltimoNumero, 6)%></strong></TD></TR>

</TBODY></TABLE>
<% End If %>

<br><br><br>
<!-- /////    Fim do Quadro Contador - Lateral Esquerdo  -->
        
   
   
        
</div>      

</td>
</tr>
  </table>
    </td><td width="1" height=500 ><img src="<%=dirlingua%>/imagens/spacer.gif" width="1" height="10" border="0"><!-- <img src="<%=dirlingua%>/imagens/dot_gray_1x1.gif" width="1" height="100%" border="0"> --></td>
    <td align="left" valign="top">
    <!-- TABELA PRINCIPAL -->
    <table border="0" cellspacing="0" cellpadding="2" valign=top>
    <tr>
    <td valign=top> 

<!--INICIO DO CONTEUDO PARA MASTERCARD-->
<%
'Chama as variaveis para finalizar compra
strPedido   = Request.Form("pedido1")
strNome     = request.form("nome1")
strContato  = request.form("contato1")
strCPF      = request.form("cpf1")
strRg       = request.form("cg1")
strEndereco = request.form("ende1")
strBairro   = request.form("bairro1")
strCidade   = request.form("cidade1")
strEstado   = request.form("est1")
strCep      = request.form("cep1")
strPais     = request.form("pais1")
strFone     = request.form("fone1")
strCompq    = request.form("compra1")
freteqwy    = request.form("frete1")
strCartao   = Request.Form("cartao")
strTitular  = Request.Form("titularcartao")
strExpmes   = Request.Form("cartaomes")
strExpano   = Request.Form("cartaoano")
strTotalCompra = Request.form("totalcompra")
strTCompra     = FormatNumber(Session("totalcompra1") + session("PesoTotalValor"),2)
numero         = Request.Form("numerocartao")
vencimento     = Request.form("cartaomes") & "/" & Request.form("cartaoano")
strParcela  = Request.Form("parcelacartao")
if strParcela = "1001" then
   sTransacao = "04"
   sParcelas  = "00"
else
   sTransacao = "08" 'parcelado pelo estabelecimento, sem juros.
   sParcelas  = mid(strParcela,3,2)
end if
If strCartao = "D" then
   sBandeira = "DINERS"
else
   sBandeira = "MASTERCARD"
end if

  intOrderID = Request.form("idcompra")
  session("pedido1") = strPedido
  session("nome1")   = strNome
  session("contato1")= strContato
  session("cpf1")    = strCPF
  session("rg1")     = strRg
  session("ende1")   = strEndereco
  session("bairro1") = strBairro
  session("cidade1") = strCidade
  session("est1")    = strEstado
  session("cep1")    = strCep
  session("pais1")   = strPais
  session("fone1")   = strFone
  session("compra1")      =strCompq
  session("frete1")       =freteqwy
  session("cartao")       =strCartao
  session("titularcartao")=strTitular
  session("cartaomes")    =strExpmes
  session("cartaoano")    =strExpano
  session("totalcompra")  =strTotalCompra
  session("totalae")      =strTCompra
  session("idcompra")     =intOrderID
  
  session("filiacao")  = Filiacao_RedeCard
  session("transacao") = sTransacao
  session("parcelas")  = sParcelas
  session("distribuidor") = ""

%>
<br>
<table>
 <tr><td align="left" valign="top">
   <table border="0" cellspacing="4" cellpadding="4" width=590>
    <font face="<%=fonte%>" style=font-size:18px;color:0000ff><strong>Aguarde, conectando com a operadora de cartão...</strong></font><br><br>&nb sp;  
    <br>N&uacute;mero do Pedido: <%=strPedido%>
    <br>Total da Compra:R$ <%=Replace(strTCompra,",",".")%>
    <table border=0 cellspacing=0 width=100% cellpadding=0>
     <tr><td height=5></td></tr>
     <tr><td height=1 bgcolor=<%=cor3%>></td></tr>
     <tr><td height=5></td></tr>
    </table>
    <p><font size="3" face="<%=fonte%>" color=ff0000>O seu pagamento j&aacute; foi iniciado. Aguarde enquanto a transa&ccedil;&atilde;o &eacute; conclu&iacute;da.</font><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><BR>&nbsp;</font><BR>
    <tr><td height=1 bgcolor=<%=cor3%>></td></tr>
    <div align=center>
  </tr>
  <tr><td align=center>
  <a href="#" onclick="javascript:history.back();"><img src="<%=dirlingua%>/imagens/cancelar.gif" border=0></a>
  </td></tr>
<!--VOLTAR-->
  </table>
  </td>
 </tr>
</table>
<%
  strOrder="<b>Dados do consumidor:</b>" & "<BR>"
  strOrder=strOrder & "<b>Nome:</b> " & strNome & " - " & session("usuario") & " - " & strFone & "<BR>"
  strOrder=strOrder & "   " & " <BR>"
  strorder=strOrder & "<b>Dados de entrega:</b>" & "<BR>"
  strOrder=strOrder & "<b>Nome:</b> " & strNome & " - " & strEndereco & " - " & strBairro & " - " & strCidade & " - " & strEstado & " - " & strCep & "<BR><BR>"
  strOrder=strOrder & "<table border='0' cellspacing='0' width='100%'>" & _
                        "<tr bgcolor=#CCCCCC>" & _
                        "<td width='68' height='15'><b>Quant.</b></td>" & _
                        "<td width='68' height='15'><b>Item</b></td>" & _
                        "<td width='210' height='15'><b>Descri&ccedil;&atilde;o</ b></td>" & _
                        "<td width='88' height='15'><b>Pre&ccedil;o</b></td> ;" & _
                        "<td width='88' height='15'><b>Sub-Total:</b></td>" & _
                        "</tr></table>"

  session("order") = strOrder 

  sEndIP=Request.ServerVariables("REMOTE_ADDR")
  
  Filiacao = session("filiacao")
  valor = strTCompra
  
  codv=getCod(Filiacao, valor, SEndIP)

%>
  <form name="form_card" method="POST" target="vpos" action="https://ecommerce.redecard.com.br/pos_virtual/form_card.asp">
  <input type="hidden" name="TOTAL" value="<%=Replace(strTCompra,",",".")%>">
  <input type="hidden" name="TRANSACAO" value="<%=sTransacao%>">
  <input type="hidden" name="PARCELAS" value="<%=sParcelas%>">
  <input type="hidden" name="FILIACAO" value="<%=session("filiacao")%>">
  <input type="hidden" name="DISTRIBUIDOR" value="">
  <input type="hidden" name="BANDEIRA" value="<%=sBandeira%>">
  <input type="hidden" name="NUMPEDIDO" value="000<%=strPedido%>">
  <input type="hidden" name="PAX1" value="OPCIONAL">
  <input type="hidden" name="CODVER" value="<%=codv%>">
  <input type="hidden" name="URLBACK" value="<%=URL_Retorno_RedeCard%>">
  </form>
<%                                                       
 

'----------------------------------------------------------- ------------------------------------------ 
Sub BaixoC()
response.write "<a class=menu  href=""http://www.virtuastore.com.br"" target=_new>Powered by VirtuaStore OPEN</a>"
End Sub

Sub BaixoComunidade()
response.write application("link_comunidade") 
End Sub
'----------------------------------------------------------- ------------------------------------------ 

'----------------------------------------------------------- ------------------------------------------ 
Function formatazeros(dado, numero)
 if len(dado) > numero then
 dado = right(dado, numero)
 end if
 '----------------------------------------------------- -------------------------------------------- -
 for i = 1 to len(dado)
  varn = (numero - 1) - i
  numezero = "0"
   if varn <> 0 then
    for i2 = 1 to varn
     numezero = numezero & "0"
    next
   end if
 next
formatazeros = right(numezero & dado, numero)
End Function
'----------------------------------------------------------- ------------------------------------------ 
%> 