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
'----------------------------------------------------------------------------------------------------------------
'Este código está otimizado e roda tanto em Windows 2000/NT/XP/ME/98 quanto em servidores UNIX-LINUX com chilli!ASP
%>
<script language="JavaScript">
var NomeAtual;
var quantItem = 3;
	function mostraDiv(NomeDiv){
		for (cont=0;cont<=quantItem;cont++){
			eval('document.all.menu'+cont+'.style.display = "none"');
		}
		if (NomeAtual!=NomeDiv){
			eval('document.all.menu'+NomeDiv+'.style.display = ""');
			NomeAtual = NomeDiv;
		}else{
			NomeAtual = "";
		}
	}
</script>
  	  <!-- #include file="topo.asp" -->
	 <div id="layer1" style="position:absolute; left:600px; top:60px; z-index:1"></div>
	 	  <table><tr><td align="left" valign="top">
		  				 <table border="0" cellspacing="4" cellpadding="4" width=590><tr><td><font face="<%=fonte%>" style=font-size:11px;color:000000> <a href=default.asp style=text-decoration:none; onMouseOut="window.status='';return true;" onMouseOver="window.status='Home';return true;"><b>Home</b></a> » Política de Trocas<br><br><div align=left> <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table></div><font face="<%=fonte%>" style=font-size:13px><strong><br>Política de trocas</strong></font></p><div align=justify><font style=font-size:11px face=<%=fonte%>> Veja as políticas de troca de produtos comprados através da  <%=  nomeloja %>. Aqui, você conta com a nossa total assistência após a compra de seu produto. Fique tranqüilo e conte conosco!<br><br>
						 
						 <table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		<tr>
		  <td><br><br>				  
				  1.&nbsp;<a href="javascript:onclick=mostraDiv('0');" class="link">Insatisfação do Cliente</a>
		  </td>
		</tr>
		<tr>
		  <td><div id="menu0" style="display:none">
		  <br><br>
		    <table width="100%" cellpadding="0" cellspacing="0" align="center" border="0">
		<tr>
		  <td height="1" bgcolor="#009933"></td>
		</tr>
		<tr>		  
		  <td>	  <font style=font-size:11px face="<%=fonte%>">
				  <br><b>Desistência de Compra:</b><br><br>
				  Se você efetuou a compra através da <%= nomeloja %>, recebeu o produto em perfeitas condições, e ainda sim não se sentiu feliz com a compra, você poderá solicitar através de nossa central de atendimento o cancelamento da compra. Mas fique atento para as regras abaixo.<br><br>
				  Prazo para desistência de compra:<br><br>
				  Conforme ditam as normas do CDC (Código de Defesa do Consumidor), o cliente que realiza compras através de lojas virtuais, gozam de até 7 (sete) dias após o recebimento do produto para registrar a desistência da compra.<br><br>
				  O desejo de cancelamento deve ser imediatamente comunicado ao fornecedor do serviço, seguindo as seguintes regras:<br><br>
				  <b>Devolução da Mercadoria:</b>
                  <ul>
				    <li> A mercadoria deverá ser devolvida através dos correios com porte pago pelo cliente, para o endereço constante na Nota Fiscal de compra.</li>
				    <li> O produto deve ser devolvido em sua embalagem original, acompanhado de todos os acessórios e manuais.</li>
				    <li> O produto deve ser devolvido acompanhado da 2ª via da Nota Fiscal de Compra.</li>
				    <li> O produto não poderá apresentar qualquer indício de uso.</li>
				  </ul>
				  <font color="#CC0000">ATENÇÃO:</font> O produto que não atender as condições exigidas acima, não será aceito como devolução, e, automaticamente será remetido de volta ao endereço de origem. Nessas condições, a <%= nomeloja %> se reservará no direito de fazer nova cobrança de frete.<br><br>

				  <b>Restituição dos Valores:</b>
				  <ul>
				  	<% If mostrar_pgtos_com_cartoescredito="Sim" then %>
				    <li> <b>Cartão de crédito:</b> O estorno poderá ocorrer em até 2 faturas subsequentes.</li>
					<% End If %>
				    <li> <b>Boleto Bancário:</b> Crédito em conta corrente em até 10 dias úteis.</li>
				    <li> Não haverá restituição do valor do frete.</li>
				  </ul>
				  <font color = "#CC0000">ATENÇÃO:</font> A restituição dos valores serão processadas somente após o recebimento e análise das condições do(s) produto(s) em nosso Estoque. (O produto não poderá trazer qualquer indício de uso).<br><br>

				  <font color = "#CC0000">NOTA:</font> <strong>Toda intenção de cancelamento deverá obrigatoriamente ser comunicada à <%= nomeloja %> antes do envio do(s) produto(s). Caso contrário, os pedidos não serão aceitos.</strong><br><br>
				</font>
  		  </td>
		</tr>
		<tr>
		  <td height="1" bgcolor="#009933"></td>
		</tr>
		    </table>
		  </div></td>
		</tr>
		<tr>
		  <td><br><br>
		    	 2.&nbsp;<a href="javascript:onclick=mostraDiv('1');" class="link">Produtos sem defeito</a>
		  </td>
		</tr>
		<tr>
		  <td><div id="menu1" style="display:none">
		  <br><br>
		    <table width="100%" cellpadding="0" cellspacing="0" align="center" border="0">
		<tr>
		  <td height="1" bgcolor="#009933"></td>
		</tr>
		<tr>
		  <td>
				  <font style=font-size:11px face="<%=fonte%>">
				  <br><b>Produto Novo:</b><br><br>
				  O produto novo goza de até 30 dias para ser substituído. Desde que este seja apresentado nas mesmas condições em que foi recebido/comprado (na embalagem original e sem uso).<br><br> 
				  <b>"Lembre-se que para efetuarmos a troca, o produto deverá estar na embalagem original e sem uso."</b><br><br>
				  Se você escolheu seu produto em nossa loja virtual, mas ao recebê-lo não se agradou e deseja fazer a substituição por outro item. Observe as regras:<br><br>
				  <b>Devolução da Mercadoria:</b>
				  <ul>
				    <li> O produto não poderá apresentar qualquer indício de uso.</li>
				    <li> O produto deve ser devolvido acompanhado da 2ª via da Nota Fiscal de Compra.</li>
				    <li> O produto deve ser devolvido em sua embalagem original, acompanhado de todos os acessórios e manuais.</li>
				    <li> A mercadoria deverá ser devolvida através dos correios com porte pago e remetido ao endereço constante na Nota Fiscal de compra.</li>
				  </ul>
				  <b>Substituição da Mercadoria:</b>
				  <ul>
				    <li> Você poderá fazer a escolha de outro item conforme estoque disponível em nossa loja virtual.</li>
				    <li> A escolha deverá se limitar ao valor limite do produto. Se houver diferença de preço para maior, deverá ser providenciado o pagamento da diferença, via opções existentes no site.</li>
				    <li> O cliente deverá indicar no verso da 2ª via da Nota Fiscal de compra, o item escolhido para troca.</li>
				    <li> O produto será despachado para a residência do cliente, mediante pagamento de novo frete.</li>
				  </ul>
				  <br>
				  </font>
		  </td>
		</tr>
		<tr>
		  <td height="1" bgcolor="#009933"></td>
		</tr>
		    </table>
		  </div></td>
		</tr>
		<tr>
		  <td><br><br>
		    	  3.&nbsp;<a href="javascript:onclick=mostraDiv('2');" class="link">Produtos com defeito</a>
		  </td>
		</tr>
		<tr>
		  <td><div id="menu2" style="display:none">
		  <br><br>
		    <table width="100%" cellpadding="0" cellspacing="0" align="center" border="0">
		<tr>
		  <td height="1" bgcolor="#009933"></td>
		</tr>
		<tr>
		  <td>
		    	<font style=font-size:11px face="<%=fonte%>">
				<br><b>Produto com suposta Falha de Fabricação:</b><br><br>
				Os produtos comercializados pela <%= nomeloja %>, gozam de 90 dias de garantia para falhas naturais de fabricação. Salvo a determinados produtos, onde o próprio fabricante indica em seu certificado de garantia o prazo de garantia de fábrica e presta atendimento direto ao cliente através dos postos de Assistência Técnica.<br><br>
				Veja como solicitar o pedido de avaliação de supostas falhas de fabricação:<br><br>
	
				<b>Devolução da Mercadoria:</b>
				<ul>
				  <li>A mercadoria deverá ser encaminhada através dos correios para o endereço constante na Nota Fiscal de compra.</li>
				  <li>Devolver o produto na embalagem original.</li>
				  <li>Obrigatoriamente o cliente deverá encaminhar a 2ª via da Nota Fiscal de Compra juntamente com o produto.</li>
				  <li>O cliente deverá enviar por escrito, um breve relato sobre o suposto defeito a qual se refere a reclamação, esclarecendo sobre o problema ocorrido, etc.</li>
				</ul>
				<font color = "#CC0000">ATENÇÃO:</font> Produtos encaminhados fora das especificações acima, não será aceito para análise de defeitos e automaticamente será devolvido ao remetente.<br><br>

				<b>Análise de defeitos dos produtos:</b><br><br>
				A avaliação de defeitos será realizada pelos nossos fornecedores, de onde receberemos o laudo final do pedido de troca.<br><br>
				Prazo médio de conclusão: 15 dias úteis após o recebimento do produto.<br><br>

				<b>Laudo Favorável a troca:</b>
				<ul>	
				  <li> O cliente receberá no endereço de origem, sem custos adicionais, a substituição pelo mesmo produto.</li>
				  <li> Na ausência do mesmo produto em estoque, o cliente será comunicado e  poderá escolher um outro produto para troca, entre as opções existentes no site, respeitando o valor limite do crédito.</li>
				  <li> Se houver diferença de preço entre o produto escolhido e o produto reclamado, deverá ser providenciado o pagamento da diferença.</li>
				</ul>
				
				<b>Laudo Contrário a troca:</b><br><br>
				O produto será devolvido ao cliente com a carta/laudo da reprovação, sem direito de substituição.<br><br>
				Itens de reprovação:
				<ul>
				  <li>Ausência de defeito (não constatação do dano apontado pelo cliente).</li>
				  <li>Indícios de uso inadequado do produto.</li>
				  <li>Indícios de dano acidental.</li>
				  <li>Desgaste natural em decorrência do uso.</li>
				  </font>
			</ul><br>
		  </td>
		</tr>
		<tr>
		  <td height="1" bgcolor="#009933"></td>
		</tr>
		    </table>
		  </div></td>
		</tr>
		<tr>
		  <td><br><br>
		    	  4.&nbsp;<a href="javascript:onclick=mostraDiv('3');" class="link">Por parte da <%= nomeloja %></a>
		  </td>
		</tr>
		<tr>
		  <td><div id="menu3" style="display:none">
		  <br><br>
		    <table width="100%" cellpadding="0" cellspacing="0" align="center" border="0">
		<tr>
		  <td height="1" bgcolor="#009933"></td>
		</tr>
		<tr>
		  <td>
		    	<font style=font-size:11px face="<%=fonte%>">
				<br><b>Cancelamento Automático de compra:</b><br><br>
				O Cancelamento do pedido e liberação dos produtos adquiridos por iniciativa da <%= nomeloja %> será automático nas seguintes situações:
				<ul>
				  <li>Impossibilidade de execução do débito correspondente à compra no cartão de crédito. </li>
				  <li>Inconsistência de dados preenchidos no pedido.</li>
				  <li>Não pagamento do boleto bancário.</li>
				  <li>Ausência de estoque.</li>
				</ul>
				A Restituição de valores por iniciativa da <%= nomeloja %> ocorrerá nas seguintes situações:
				<ul>
				  <li>Impossibilidade de entrega da mercadoria adquirida, tendo em vista a inexistência do endereço de entrega como indicado pelo comprador, ou a sua não acessibilidade. Na impossibilidade da entrega por essa razão, o produto retornará para o nosso Centro de Distribuição, gerando devolução por parte da <%= nomeloja %> dos valores correspondentes aos preços dos produtos, excluindo-se os custos com frete.</li><br><br>
				  <li>Caso ocorra a falta da mercadoria adquirida pelo comprador no site da <%= nomeloja %>, em função de ocorrência de vendas do produto, haverá a devolução dos valores pagos ao comprador, através do mesmo meio de pagamento utilizado na compra. Nessas situações, o comprador será comunicado do ocorrido.</li>
				</ul><br>
				</font>
		  </td>
		</tr>
		    </table>
		  </div></td>
		</tr>
		
</table>
						<br> 
						 <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><center><a HREF="default.asp" style=text-decoration:none onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg41%>';return true;"><font face="<%=fonte%>" style=font-size:11px>:: <b><%=strLg41%></b> ::</a></font></center></td></tr>
						 </table></td></tr>
		 </table>
		 <!-- #include file="baixo.asp" -->