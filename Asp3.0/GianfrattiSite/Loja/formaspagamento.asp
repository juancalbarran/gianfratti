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
<!-- #include file="topo.asp" -->
<!-- #include file="geraopcoes.inc" -->
<%
'Ve se o usuario está logado
if session("usuario") = "" then
response.redirect "fechapedido.asp?compra=login"
end if

intOrderID = cstr(Session("orderID"))%>
		   <table><tr><td align="left" valign="top"><table border="0" cellspacing="4" cellpadding="4" width=590><tr><td>
	   				  <script language="javascript">
  function limpar(){
  document.registro1.reset()
  }

  function hideLevel(id) {
    var thisLevel = document.getElementById(id);
    thisLevel.style.display = "none";
  }

  function showLevel(id) {
    var thisLevel = document.getElementById(id );
    thisLevel.style.display = "block";
  }

  function digitarcc(){
   var habilita = document.registro1.cartao[4].checked;
   if (habilita == true){
      document.registro1.parcelacartao[3].checked=true;
   }
   else{
       document.registro1.cartao[2].checked;
       if (document.registro1.parcelacartao[3].checked==true)
       { 
         document.registro1.parcelacartao[1].checked=true;
       }
   }
 }

  function checa_form(){
   document.registro1.action="pagamento.asp"
   if (document.registro1.cartao[1].checked==true || document.registro1.cartao[4].checked==true){
     document.registro1.action="processavisa.asp";
   }
   if (document.registro1.cartao[2].checked==true || document.registro1.cartao[3].checked==true){
     document.registro1.action="processakomerci.asp";
   }
   if (document.registro.cartao==[0].checked==true){
    document.registro1.action="pagamento.asp";
   }    
   return true;
  }
						  </script>
  		   <form action=pagamento.asp method=post name=registro1 onsubmit="return checa_form()">
				 <input type="hidden" name="frete1" value="<%=session("PesoTotalValor")%>">
				 <input type="hidden" name="email1" value="<%=session("usuario")%>">
				 <input type="hidden" name="pedido1" value="<%=session("pedido1")%>">
				 <input type="hidden" name="nome1" value="<%=session("nome1")%>">
				 <input type="hidden" name="ende1" value="<%=session("ende1")%>">
				 <input type="hidden" name="bairro1" value="<%=session("bairro1")%>">
				 <input type="hidden" name="cidade1" value="<%=session("cidade1")%>">
				 <input type="hidden" name="est1" value="<%=session("est1")%>">
				 <input type="hidden" name="cep1" value="<%=session("cep1")%>">
				 <input type="hidden" name="pais1" value="<%=session("pais1")%>">
				 <input type="hidden" name="fone1" value="<%=session("fone1")%>">
				 <input type="hidden" name="compra1" value="<%=session("compra1")%>">
				 <input type="hidden" name="totalae" value="<%=1 + session("compra1") + session("PesoTotalValor") - 1%>">
				 <input type="hidden" name="idcompra" value="<%=intOrderID%>">
				 		<font face="<%=fonte%>" style=font-size:11px;color:000000> <a href=default.asp style=text-decoration:none; onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg4%>';return true;"><b><%=strLg4%></b></a> » <%=strLg286%><br>

<table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=20 bgcolor=f0f0f0>
<font face="<%=fonte%>" style=font-size:10px;color:#808080>
&nbsp;&nbsp;&nbsp;
1. <%=strLg282%> &nbsp;&nbsp;&nbsp;
2. <%=strLg283%> &nbsp;&nbsp;&nbsp;
<font color="<%= Cor_texto_menu_fechamento_compras %>">3. <%=strLg284%> </font>&nbsp;&nbsp;&nbsp;
4. <%=strLg285%></td></tr><tr><td height=5></td></tr></table>


							  <div align=left> <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table></div>
<%
'Verifica se há itens na compra
if cstr(Session("orderID")) = "" then%>
   							<br><br><div align=center><p><font face=<%=fonte%> style=font-size:17px><b><%=strLg49%><br><%=strLg50%><br><br></b><a href=default.asp><img src="<%=dirlingua%>/imagens/continuar.gif" onMouseOut="window.status='';return true;" onMouseOver="window.status='Continuar Compras';return true;" border=0></a><b></font></p></div><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table>
				</td></tr>
			</table></td></tr>
		</table>
		<!-- #include file="baixo.asp" -->
<%
response.end
else
%>


  			 		  <font face="<%=fonte%>" style=font-size:13px><strong><%=strLg91%></strong></font></p>
					  <font face="<%=fonte%>" style=font-size:11px><%=strLg92%><br><%=strLg93%> <a href=fechapedido.asp?compra=ok onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg71%>';return true;"><b><%=strLg71%></b></a>
					  		<div align=left> <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table></div>

<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse" bordercolor="#111111">
  
  <% If brpay_aceitar_pagamentos = "Sim" then %>
  <tr><td colspan=2><font style=font-size:15px><b>»</b>  <font face="<%=fonte%>" style=font-size:11px;color:000000><strong><%=strLg300%></strong></font> <font style=font-size:11px color=red><%=request.querystring("erro")%></font><br></td></tr><tr><td width="93%" valign=bottom>
    <div align="center">
      <center>
        <table width="475" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><table border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#111111" id="AutoNumber2" style="border-collapse: collapse">
            <tr>
              <% If brpay_aceitar_cartao_credito = "Sim" Then %>
              <td align="center"><br />
                  <img src="http://www.brpay.com.br/Security/Imagens/btnWebprefC.gif" border="0" /></td>
              <% Else %>
              <td align="center"><br />
                  <img src="http://www.brpay.com.br/Security/Imagens/btnWebpref.gif" border="0" /></td>
              <% End If %>
            </tr>
            <tr>
              <td align="center" height="25"><input type="radio" name="cartao" value="BRpay" checked="checked" /></td>
            </tr>
          </table></td>
          <td>&nbsp;</td>
          <td><table width="229" border="0">
            <tr>
              <td width="236"><b>Voc&ecirc; poder&aacute; pagar com:</b></td>
            </tr>
            <tr>
              <td><ul>
                  <% If brpay_aceitar_cartao_credito = "Sim" Then %>
                  <li>Cart&atilde;o de Cr&eacute;dito</li>
                <% End If %>
                  <li>Transfer&ecirc;ncia Online</li>
                <li>Boleto Banc&aacute;rio</li>
                <li>Dep&oacute;sito Identificado</li>
              </ul></td>
            </tr>
          </table></td>
        </tr>
      </table>
      </center>
    </div>
    </td>
    <td width="7%" rowspan=3>&nbsp;</td>
  </tr>
											<tr><td valign=top>&nbsp;</td></tr>
	   </font>
					  <font face="Tahoma" style=font-size:11px color="#FF0000">
	   </font>
					  <font face="<%=fonte%>" style=font-size:11px><tr><td colspan=2><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table></td></tr>

 <% 
 End IF
 If mostrar_pgtos_com_cartoescredito="Sim" then %>
  <tr><td colspan=2><font style=font-size:15px><b>»</b>  <font face="<%=fonte%>" style=font-size:11px;color:000000><strong><%=strLg96%></strong></font> <font style=font-size:11px color=red><%=request.querystring("erro")%></font><br></td></tr><tr><td valign=botton><font style=font-size:11px>&nbsp;&nbsp;&nbsp;<%=strLg97%><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <div align="center">
      <center>
      <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" id="AutoNumber2">
        <tr>
          <td align="center"><font style=font-size:11px face="<%=fonte%>"><img src=<%=dirlingua%>/imagens/visa.gif border=0>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
          <td align="center"><font style=font-size:11px face="<%=fonte%>"> <img src=<%=dirlingua%>/imagens/mastercard.gif border=0>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<!--
          <td align="center"><font style=font-size:11px face="<%=fonte%>"> <img src=<%=dirlingua%>/imagens/amex.gif border=0>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
-->
          <td align="center"><font style=font-size:11px face="<%=fonte%>"> <img src=<%=dirlingua%>/imagens/diners.jpg border=0>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
          <td align="center"><font style=font-size:11px face="<%=fonte%>"><img src=<%=dirlingua%>/imagens/visa_electron.jpg border=0>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>

        </tr>
        <tr>
          <td align="center"><input type=radio name=cartao value=V onClick="javascript: digitarcc();">
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
          <td align="center"><input type=radio name=cartao value=M onClick="javascript: digitarcc();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<!--
          <td align="center"><input type=radio name=cartao value=A onclick="javascript: digitarcc();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;</td>
-->
          <td align="center"><input type=radio name=cartao value=D onClick="javascript: digitarcc();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
          <td align="center"><input type=radio name=cartao value=E         onclick="javascript: digitarcc();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
      </table>
      </center>
    </div>
    </td>
<!--
    <td id='dadoscc' rowspan=3><font style=font-size:11px><br><%strLg98%> </font><br>
     <input type="text" name="numerocartao" size="30" style=font-family:<%=fonte%>;font-size:11px;color:#000000;>&nbsp;&nbsp;&nbsp;
     <input type="text" name="codigo_seguranca" size="4" style=font-family:<%=fonte%>;font-size:11px;color:#000000;>&nbsp;&nbsp;<a href="img_cod_seg_cartao_cred.asp" TARGET=img_cod_seg_cartao_cred onclick="window.open('','img_cod_seg_cartao_cred','width=400,height=250,resizable=no,scrollbars=no')"><img src=adm_imagens/icon_duvida.gif border=0 align="absbottom"></a>
     <br><font style=font-size:11px><%=strLg99%> </font><br>
     <select style="font-family:<%=fonte%>;font-size:11px;color:#000000;" name="cartaomes"><option value=""> <%=strLg148%> <option value="01">Jan <option value="02">Fev<option value="03">Mar<option value="04">Abr<option value="05">Mai <option value="06">Jun <option value="07">Jul<option value="08">Ago<option value="09">Set<option value="10">Out<option value="11">Nov<option value="12">Dez</option></select><b>/</b>
     <select name='cartaoano' style=font-size:11px;font-family:<%=fonte%>;> <Option value=""><%=strLg101%></Option>
<% ano = year(now)
   'Calcula o ano da data atual + 10
    For data = ano to ano + 10
     response.write "<Option value="&data&">"&data&"</Option>"
    next
%>
    </select><br><font style=font-size:11px><%=strLg102%> </font><br>
    <input type="text" name="titularcartao" size="43" style=font-family:<%=fonte%>;font-size:11px;color:#000000;></td></tr>
-->
    </font>
    <tr><td id='dadoscc2'><br><%call geraopcoes(session("totalcompra1"),1)%></td></tr>
    <% 'Esta Função AUTHENTTYPE é utilizada para que o lojista decida se o valor da compra pode ser ou não  autorizada, caso houver uma falha na autenticação do banco %>
    <% If session("totalcompra1") < ValorAutenticacao Then %>
<!-- O correntista não necessitará digitar conta e senha do banco-->
    <input type="hidden" name="AUTHENTTYPE" value="0">
    <% Else %>
    <input type="hidden" name="AUTHENTTYPE" value="1">
    <% End If %>
    <tr><td valign=top>&nbsp;</td></tr>
    <tr>
      <td id='dadoscc1' align=center><font face="arial" style=font-size:12px color="#FF0000"><br><B>VISA e VISAELECTRON</B><br>
       Loja abrir&aacute; uma Janela "Popup" segura da VISA para digita&ccedil;&atilde;o dos dados do cart&atilde;o.<br>
       Caso possua um programa anti-popup instalado, DESABILITE antes de prosseguir a compra.<br></font>
       <a href="#" onClick="window.open('xppopup.asp','Teste','width=700,height=480,top=0,left=0,resizable=yes,scrollbars=yes');">Veja como fazer no Windows XP Service Pack 2</a>
       <br>Obs:A partir de R$ <%=formatnumber(ValorAutenticacao,2)%> o cliente dever&aacute digitar a conta e senha do banco emissor do cart&atilde;o.
    </td></tr>
    <font face="<%=fonte%>" style=font-size:11px>   
    <tr><td colspan=2><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table></td></tr>
<% End If %>

<tr><td colspan=2>
<% If brpay_aceitar_pagamentos = "Sim" then %>
<font style=font-size:15px><b>»</b> <font face="<%=fonte%>" style=font-size:11px;color:000000><strong><%=strLg95%></strong></font>
<% 
End If
If mostrar_pgtos_com_cartoescredito="Sim" then %>
<font style=font-size:15px><b>»</b> <font face="<%=fonte%>" style=font-size:11px;color:000000><strong><%=strLg95%></strong></font>
<% Else  %>
<font style=font-size:15px><b>»</b> <font face="<%=fonte%>" style=font-size:11px;color:000000><strong><%=strLg94%></strong></font>
<% End If %>
 <br></td></tr>
											<tr><td valign=botton widht=100% colspan=2>
                                              <p align="center"><font style=font-size:11px>
                                              <br>
                                              <% If brpay_aceitar_pagamentos="Sim" then %>
											  <br>&nbsp;<%=strLg94%><% 
											  End If											  
											  If mostrar_pgtos_com_cartoescredito="Sim" then %>
											  <br>&nbsp;<%=strLg94%><% End If %></font></p>
                                              <div align="center">
                                                <center>
                                                <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" id="AutoNumber1">
                                                  <tr>
                                                    <td width="25%" align="center"><% If session("modo_entrega")="motoboy" and mostrar_pagamento_por_cheque="Sim" then %>
                                                        <font style="font-size:11px" face="<%=fonte%>"> <img src="<%=dirlingua%>/imagens/cheque.gif" border="0" /></font>
                                                        <% Else  %>
                                                        <img height="1" src="<%= dirlingua %>/imagens/spacer.gif" width="100" />
                                                        <% End If %></td>
                                                    <td width="25%" align="center">
                                                    <font style=font-size:11px face="<%=fonte%>"><img src="<%=dirlingua%>/imagens/pg_deposito.gif" border=0></font></td>
                                                    <td align="center"><font style="font-size:11px" face="<%=fonte%>"><img src="<%=dirlingua%>/imagens/pg_transf.gif" border="0" /></font></td>
                                                    <td width="25%" align="center">
													
												<% If mostrar_pagamento_por_boleto="Sim" then %>
                                                <font style=font-size:11px face="<%=fonte%>">
                                                <img src="<%=dirlingua%>/imagens/pg_boleto.gif" border=0>
											  	<% Else  %>
												<IMG height=1 src="<%= dirlingua %>/imagens/spacer.gif" width=100>
												<% End If %>												</td>
                                                
												    <td width="25%" align="center">
													<% If session("modo_entrega")="sedex" and entrega_sedex_a_cobrar="Sim" then %>
                                                    <font style=font-size:11px face="<%=fonte%>">
                                                    <img src="<%=dirlingua%>/imagens/pg_sedexacobrar.gif" border=0></font>
													<% Else  %>
													<IMG height=1 src="<%= dirlingua %>/imagens/spacer.gif" width=100>
													<% End If %></td>
                                                  </tr>
                                                  <tr>
                                                    <td width="25%" align="center"><% If session("modo_entrega")="motoboy" and mostrar_pagamento_por_cheque="Sim" then %>
                                                        <font face="<%=fonte%>" style="font-size:11px">
                                                        <input type="radio" name="cartao" value="ch" />
                                                        </font>
                                                        <% End If %></td>
                                                    <td width="25%" align="center">
					  <font face="<%=fonte%>" style=font-size:11px>
                                              <input type=radio name=cartao value=di></font></td>
                                                    <td width="25%" align="center"><font face="<%=fonte%>" style="font-size:11px">
                                                      <input type="radio" name="cartao" value="db" />
                                                    </font></td>
                                                    <td width="25%" align="center">
													<% If mostrar_pagamento_por_boleto="Sim" then %>
					  <font face="<%=fonte%>" style=font-size:11px><input type=radio name=cartao value=bl></font>
					  								<% End If %>													 
			                                       <td width="25%" align="center">
													<% If session("modo_entrega")="sedex" and entrega_sedex_a_cobrar="Sim" then %>
					  <font face="<%=fonte%>" style=font-size:11px><input type=radio name=cartao value=sc></font>
					  								<% End If %></td>             
			                                      </tr>
                                                </table>
                                                </center>
                                              </div>
                                              </td></tr>
											<tr><td valign=top colspan=2>&nbsp;</td></tr>
											<tr><td colspan=2><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5>
                                              <p align="center">
					  <font face="<%=fonte%>" style=font-size:11px><br>
                                              <input type=image src=<%=dirlingua%>/imagens/prosseguir.gif onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg67%>';return true;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type=image src=<%=dirlingua%>/imagens/limpar.gif onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg89%>';return true;" OnClick="javascript: limpar()"></font></td></tr></table></td></tr><tr align=center><td valign=top>&nbsp;</td><td valign=top></form></td></tr>
							</table>
						</center>
</div>
<p><br>
&nbsp;</p>
						</form></a></td></tr>
				</table></td></tr>
		</table>
	   </font>
	   <!-- #include file="baixo.asp" -->
<%end if%>

