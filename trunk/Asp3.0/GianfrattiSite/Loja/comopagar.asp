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

'Desenvolvido por: Cirilo José Veloso  (cjveloso@ig.com.br - www.veloso.kit.net)

%>
<!-- #include file="topo.asp" -->
<table>
 <tr><td align="left" valign="top">
   <table border="0" cellspacing="4" cellpadding="4" width=590>
     <tr><td><font face="<%=fonte%>" style=font-size:11px;color:000000> <a href=default.asp style=text-decoration:none; onMouseOut="window.status='';return true;" onMouseOver="window.status='Home';return true;"><b>Home</b></a> » Como Pagar?<br><br><div align=left> <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table>
       </div>
    <font face="<%=fonte%>" style=font-size:13px><strong><br>Como pagar na <%=nomeloja%></strong></font><br><br><br>
    <div align=center>
<!--CONTEUDO-->
<!--cartão de crédito-->
    <table width="100%" align="center" border="0">
      <% If brpay_aceitar_pagamentos="Sim" then %>
	  <TR bgColor=#006666>
        <TD bgColor=#f0f0f0 height=20><FONT 
                              style="FONT-SIZE: 11px" 
                              face=tahoma,verdana,arial,helvetica 
                              color=#000000><STRONG><FONT 
                              style="FONT-SIZE: 15px"><B>&raquo;</B></FONT> Pagamento 
          pelo BRpay.com.br </STRONG></FONT></TD>
      </TR>
      <TR>
        <TD>&nbsp;</TD>
      </TR>
      <TR>
        <TD><DIV align=center>
            <P><A href="http://www.brpay.com.br/" 
                              target=_blank><IMG 
                              src="<%=dirlingua%>/imagens/brpay.gif" border=0><BR>
              </A><SPAN 
                              style="FONT-WEIGHT: bold; FONT-SIZE: 12px; COLOR: #1a6c44; FONT-FAMILY: Tahoma">&Eacute; 
                R&Aacute;PIDO, GR&Aacute;TIS E SEGURO !!</SPAN></P>
          <P style="FONT-SIZE: 11px; FONT-FAMILY: Tahoma" 
                              align=left>Este meio de Pagamento &eacute; um dos mais 
            utilizados na Internet. A BRpay, possui um sistema 
            muito seguro e automatizado de pagamentos, 100% 
            SEGURO. </P>
          <P style="FONT-SIZE: 10px; FONT-FAMILY: Tahoma" 
                              align=left>- <SPAN 
                              style="FONT-WEIGHT: bold">CART&Atilde;O DE CR&Eacute;DITO VISA </SPAN><BR>
            - <SPAN 
                              style="FONT-WEIGHT: bold">CART&Atilde;O DE CR&Eacute;DITO 
              AMEX</SPAN> (PODE SER FINANCIADO EM AT&Eacute; 24X) <BR>
            - <SPAN style="FONT-WEIGHT: bold">TRANSFER&Ecirc;NCIA 
              ELETR&Ocirc;NICA BANCO DO BRASIL</SPAN> <BR>
            - <SPAN 
                              style="FONT-WEIGHT: bold">TRANSFER&Ecirc;NCIA ELETR&Ocirc;NICA 
              ITA&Uacute;</SPAN><BR>
            - <SPAN 
                              style="FONT-WEIGHT: bold">BOLETO BANC&Aacute;RIO</SPAN> (PAGAVEL EM QUALQUER AG&Ecirc;NCIA BANC&Aacute;RIA OU LOT&Eacute;RICA) <BR>
            - <SPAN style="FONT-WEIGHT: bold">DEP&Oacute;SITO 
              BANC&Aacute;RIO</SPAN> (EM CONTAS BRPAY) <BR>
            <BR>
          </P>
        </DIV></TD>
      </TR>
	  <%End IF%>
	
	<% If mostrar_pgtos_com_cartoescredito="Sim" then %>
      <tr bgColor="#006666">
        <td height="20" bgcolor="#FFFFFF">&nbsp;</td>
      </tr>
	        <tr bgColor="#006666">
        <td width="100%" height="20" bgcolor="#f0f0f0"><font face="<%=fonte%>"  style=font-size:11px color=000000><strong><font style=font-size:15px><b>»</b></font> Cartão de crédito</strong></font></td>
      </tr>
      <tr><td>&nbsp;</td></tr>
      <tr><td> 
      <table>
      <tr vAlign="center">
          <td align="center"><font style=font-size:11px face="<%=fonte%>"><img src=<%=dirlingua%>/imagens/visa.gif border=0></td>
          <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
          <td align="center"><font style=font-size:11px face="<%=fonte%>"><img src=<%=dirlingua%>/imagens/mastercard.gif border=0></td>
          <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
          <td align="center"><font style=font-size:11px face="<%=fonte%>"> <img src=<%=dirlingua%>/imagens/amex.gif border=0></td>
          <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
          <td align="center"><font style=font-size:11px face="<%=fonte%>"> <img src=<%=dirlingua%>/imagens/diners.jpg border=1></td>
        </tr>
        <tr>
          <td align="center"><font style=font-size:11px face="<%=fonte%>">Visa</td>
          <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
          <td align="center"><font style=font-size:11px face="<%=fonte%>">MasterCard</td>
          <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
          <td align="center"><font style=font-size:11px face="<%=fonte%>">Amex</td>
          <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
          <td align="center"><font style=font-size:11px face="<%=fonte%>">Diners</td>
        </tr>
       </table><br><br>
	   
       </td></tr>
       <tr><td width=100% valign=bottom>&nbsp;</td></tr>
	<% End If %>
		
       <tr bgColor="#006666">
        <td width="100%" height="20" bgcolor="#f0f0f0"><font face="<%=fonte%>"  style=font-size:11px color=000000><strong><font style=font-size:15px><b>»</b></font> Boleto Bancário</strong></font></td>	   
      </tr>

      <tr vAlign="center">
       <td><br>
        <p><font face="<%=fonte%>" style=font-size:11px;color:000000>
        <img height="44" src="./linguagens/portuguesbr/imagens/pg_boleto.gif" width="87" align="baseline">
        <br><br>
         O pagamento através de <strong>Boleto bancário</strong>
         é a forma mais prática e segura para compras realizadas na Internet,
         pois os clientes não necessitam inserir dados como numero de cartão de
         crédito ou senha.</font></p>
         <div align="justify">
           <ul>
           <li><font face="<%=fonte%>" style=font-size:11px;color:000000>O boleto deverá ser impresso ao
            final de sua compra e pode ser pago em qualquer agência bancária do
            país ou via <strong>Home-Bank.</strong></font>
           <li><font face="<%=fonte%>" style=font-size:11px;color:000000>Os pedidos serão
            enviados após confirmação do pagamento pela instituição bancária, conforme o prazo de entrega.</font></li>
          </ul>
         </div>          </tr> </td>

<script LANGUAGE="JavaScript">
  function Boleto() {
  remote = window.open("","remotewin","'toolbar=no,location=no,directories=no,status=yes,menubar=yes,scrollbars=yes,resizable=no,copyhistory=no,width=720,height=500'");
  remote.location.href = "boleto_bradesco.asp?sacador=RAZÃO SOCIAL OU NOME DO COMPRADOR&Cpf=11111111111&endereco=ENDEREÇO DO COMPRADOR, 1000&bairro=BAIRRO&cidade=CIDADE&estado=UF&cep=64999000&nossonumero=1234567890&datadocumento=01/01/2003&datavencimento=06/01/2003&valordocumento=<%=formatnumber(10000,2)%>&numerodoc=999999";
  remote.opener = window;
  remote.opener.name = "imagem1";
 }
</script>
   <tr><td valign=center><font face="<%=fonte%>" style=font-size:11px;color:000000>Veja um teste de impress&atilde;o do boleto<br><br></font><a href="javascript:Boleto()"><img border="0" src="<%=dirlingua%>/imagens/ver_boleto.gif"></a></td></tr>
</table>

  <tr><td width=50% valign=bottom>&nbsp;</td></tr>

<!--Depósito Bancário-->
<!--INICIO DESABILITAR DEPOSITO BANCÁRIO-->
    <table width="100%" align="center" border="0">
     <tbody>
      <tr bgColor="#006666">
        <td width="100%" height="20" bgcolor="#f0f0f0"><font face="<%=fonte%>"  style=font-size:11px color=000000><strong><font style=font-size:15px><b>»</b></font> Dep&oacute;sito Banc&aacute;rio ou Transfer&ecirc;ncia</strong></font></td>	   
      </tr>
      <tr vAlign="center">
       <td>
        <p><font face="<%=fonte%>" style=font-size:11px;color:000000><br>
        <img border="0" src="<%=dirlingua%>/imagens/pg_deposito.gif" width="87" height="44">
		&nbsp;&nbsp;&nbsp;
        <img src="<%=dirlingua%>/imagens/pg_transf.gif" border=0>
        <br><br>
        O pagamento através de <strong>Depósito Bancário,
        Tranferência Eletrônica (entre contas) ou DOC</strong> são também uma forma prática e segura para
        compras realizadas na Internet, pois os clientes não necessitam inserir
        dados como numero de cartão de crédito ou senha.
		<br><br>
		A forma de pagamento por Transferência Eletrônica consiste na simples trasnferência entre contas, seja entre contas do mesmo banco ou entre contas de bancos diferentes (chamado de DOC) , que você pode fazer pelo seu banco na Internet ou em qualquer agência bancária do seu banco.</font></p>
        <div align="justify">
          <ul>
            <li><font face="<%=fonte%>" style=font-size:11px;color:000000>As contas bancárias aparecerão na
              finalização da compra, podendo ser feito o pagamento de uma das 3 formas acima, da maneira que for melhor para você no(s) banco(s) abaixo:</font><br><br>
			  <font face="<%=fonte%>" style=font-size:11px;color:blue>
			  - <%= Seu_banco %><br><br>
			  <% If Seu_banco2<>"" then %>
			  - <%= Seu_banco2 %>
			  <br><br>
			  <% End If %></font>
            <li><font face="<%=fonte%>" style=font-size:11px;color:000000>Os pedidos serão
              enviados após confirmação do pagamento, que pode ser feita via
              e-mail <a href=mailto:<%=emailloja%>><%=emailloja%></a>
              ou via fone/fax <%=fone11%>.*</font></li>
          </ul>
        </div>       </td>
      </tr>

      <tr>
        <td valign=bottom>&nbsp;</td>
		<% If mostrar_pagamento_por_cheque="Sim" then %>
      </tr>
      <tr>
        <td valign=bottom bgcolor="#f0f0f0"><font face="<%=fonte%>"  style=font-size:11px color=000000><strong><font style=font-size:15px><b>&raquo;</b></font> Cheque a Vista </strong></font></td>
      </tr>
      <tr>
        <td valign=bottom><p><br>
          <img border="0" src="./linguagens/portuguesbr/imagens/cheque.gif" width="130" height="50"></p>
          <ul>
            <li>              <font face="<%=fonte%>">Cheque &agrave; vista</font></li>
            <li><font face="<%=fonte%>">Voc&ecirc; dever&aacute; fornecer o  nome do banco emissor, o n&uacute;mero de sua ag&ecirc;ncia, n&uacute;mero de sua conta corrente e  do cheque. O cheque, no valor do seu pedido, dever&aacute; ser entregue no ato do  recebimento de sua compra.<br>
              <br>
            </font></li>
            <li><font face="<%=fonte%>">Observa&ccedil;&atilde;o 1: A  concretiza&ccedil;&atilde;o da opera&ccedil;&atilde;o depende de consulta &agrave; SERASA e ao SPC. </font></li>
            <li><font face="<%=fonte%>">Observa&ccedil;&atilde;o 2: N&atilde;o  aceitamos cheque de terceiros.</font></li>
            <li><font face="<%=fonte%>">Observa&ccedil;&atilde;o 3: N&atilde;o  aceitamos cheque em sua primeira compra no site e televendas</font></li>
          </ul>
          <blockquote>
            <p><br>
                </p>
        </blockquote></td><%end if %>
      </tr>
      <tr><td width=50% valign=bottom>&nbsp;</td></tr>

<!--FIM DESABILITAR DEPOSITO BANCÁRIO-->
<!--Sedex a Cobrar-->
<!--INICIO DESABILITAR SEDEX-->

<% If entrega_sedex_a_cobrar="Sim" then %>
      <tr bgColor="#006666">
	  
        <td width="100%" height="20" bgcolor="#f0f0f0"><font face="<%=fonte%>"  style=font-size:11px color=000000><strong><font style=font-size:15px><b>»</b></font> Sedex a Cobrar</strong></font></td>		  
      </tr>
      <tr>
       <td vAlign="top">
        <p align="left"><br>
        <img border="0" src="./linguagens/portuguesbr/imagens/pg_sedexacobrar.gif" width="130" height="50"></p><br>
        <ul>
          <li><font align="left" face="<%=fonte%>" style=font-size:11px;color:000000>O pagamento é feito na
            retirada do (s) produto (s) nas agências dos <strong>Correios</strong>,
            com uma taxa diferenciada, que é cobrada pelos Correios.</font>
          <li><font face="<%=fonte%>" style=font-size:11px;color:000000>Você receberá um aviso quando seu
            (s) produto (s) estiver (em) disponível para retirada na agência
            dos Correios mais próxima do endereço informado no seu pedido.</font></li>
          <li><font face="<%=fonte%>" style=font-size:11px;color:000000>Uma&nbsp; forma&nbsp; segura de comprar
            na internet, haja visto que o pagamento do valor total é feito somente
            no ato do recebimento da mercadoria na agência dos correios.</font></li>
        </ul>
        <div align="justify">
          <ul>
            <li><font style=font-size:11px;color:000000><strong><font face="<%=fonte%>">Obs.</font></strong><font face="<%=fonte%>">
              O pagamento só podera ser feito em <strong>Dinheiro</strong>, pois os
              correios não aceitam cheques</font></font></li>
            <li><font style=font-size:11px;color:000000><font face="<%=fonte%>">
              Tempo de entrega: 2 a 3 dia após  liberação</font></font></li>
          </ul>

          <p><font face="<%=fonte%>" style=font-size:11px;color:000000>&nbsp;</font></p>
        </div>       </td>
      </tr>
	  <% End If %>
     </tbody>
    </table>
<!--FIM DESABILITAR SEDEX-->
<!--FIM DO CONTEUDO-->
     <table border=0 cellspacing=0 width=100% cellpadding=0>
         <tr><td height=5></td></tr>
         <tr><td height=1 bgcolor=<%=cor3%>></td></tr>
         <tr><td height=5></td></tr>
</table>
	   <div align="center">
       <A HREF="javascript:history.back();" style=text-decoration:none onMouseOut="window.status='';return true;" onMouseOver="window.status='Voltar';return true;"><font face="<%=fonte%>" style=font-size:11px>:: <b>Voltar</b> ::</font></A></div></ul></td></tr>
   </table>

<!-- #include file="baixo.asp" -->
