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
<%
'Chama o produto a partir da variavel
intProdID = Request.QueryString("produto")
if intProdID = "" then
intProdID = "0000000000"
end if
'Chama o produto

'#########################################################################################
'#----------------------------------------------------------------------------------------
'# CONTROLE DE ESTOQUE POR ROGERIO SILVA
'#########################################################################################
sql="SELECT A.*,A.Estoque as Est, B.*, B.Estoque as ESTM FROM produtos as A, ESTOQUE as B where B.IDPRODUTO = A.idprod AND A.idprod="&intProdID
'response.write "<br>sql :"&sql
'response.end
Set prodinfo  = abredb.Execute(sql)
'#########################################################################################
if prodinfo.EOF then%>
   				  		<table><tr><td align="left" valign="top">
									   <table border="0" cellspacing="4" cellpadding="4" width=590><tr><td><font face="<%=fonte%>" style=font-size:11px;color:000000> <a href=default.asp style=text-decoration:none; onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg4%>';return true;"><b><%=strLg4%></b></a> » <%=strLg229%> <br><br><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><br><br><br><center><b><%=strLg230%> <%=nomeloja%>!</b></center><br><br><br><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><center><a HREF="default.asp" style=text-decoration:none onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg41%>';return true;"><font face="tahoma,arial,helvetica" style=font-size:11px>:: <b><%=strLg41%></b> ::</a></font></center></center></td></tr>
									   </table></td></tr>
						</table>
						<!-- #include file="baixo.asp" -->
<%
response.end
else
%>
  						<table><tr><td align="left" valign="top">
									   <table border=0 cellspacing="4" cellpadding="4" width=590><tr><td> 
<%
'Variaveis do cadastro do produto
strIdProd = prodinfo("idprod")
strName = prodinfo("nome")
strDesc = prodinfo("detalhe")
strId = prodinfo("idprod")
strFabricante = prodinfo("fabricante")
intPrice = prodinfo("preco")
intPricev = prodinfo("precovelho")
strEstoq = prodinfo("Est") 
idsessao = prodinfo("idsessao")
economiza = intPricev - intPrice
imgrande=prodinfo("imgra")
qt_max_prod=prodinfo("QTDMAXIMA")
qt_atual_estoque=prodinfo("ESTM")


'Verifica se tem em estoque o minimo indicado como Compra Maxima por produto
if qt_atual_estoque<qt_max_prod then
qt_maxima_compra_do_produto=qt_atual_estoque
else
qt_maxima_compra_do_produto=qt_max_prod
end if

'Chama o idsessao do subdepartamento
Set subnomes = abredb.Execute("SELECT nome,idsessao FROM categoria where idcategoria="&idsessao)
strIdsessao = subnomes("idsessao")
strSubnome = subnomes("nome")

subnomes.Close
set subnomes = Nothing

'Chama o nome do departamento
Set nomes = abredb.Execute("SELECT nome FROM sessoes where id="&strIdsessao)
strNome = nomes("nome")

nomes.Close
set nomes = Nothing

intQuant=1
%>

<script LANGUAGE="JScript">
		function AbortEntry(sMsg, eSrc){window.alert(sMsg);eSrc.focus();}
		function HandleError(eSrc){var val = parseInt(eSrc.value);
				 if (isNaN(val)){
				 	document.registro1.intQuant.value = '<%=intQuant%>';
				}

				// if (val > <%=qt_max_prod%>){
				//   alert('<%=strLg270%> <%=qt_max_prod%> <%=strLg271%>');
				// 	document.registro1.intQuant.value = '<%=intQuant%>';
				// }

if  ((val > <%=qt_atual_estoque%>) && (<%=qt_max_prod%> > <%=qt_atual_estoque%>))
			{
			/// Avisa qdo o cliente tenta comprar mais do que tem no estoque (e ve se nao passa do Maximo) 
			alert('<%=strLg277&" "&qt_atual_estoque&" "& strLg278%>');
				if(confirm("<%=strLg279&" "&qt_atual_estoque&" "& strLg280%>")==true)
				{		
				document.registro1.intQuant.value = '<%= qt_atual_estoque %>';
				document.registro1.submit();				
				}
				else
				{
				document.registro1.intQuant.value = '<%=intQuant%>';
				document.registro1.intQuant.select;
				}
			}
			else
			{
			/// Avisa q o cliente pode só comprar um maximo X do produto
				if (val > <%=qt_max_prod%>)
				{
				alert('<%=strLg270%> <%=qt_max_prod%> <%=strLg271%>');
				document.registro1.intQuant.value = '<%=qt_max_prod%>';
				document.registro1.intQuant.focus();
				}
			}
				

				if (val <= 0) {
				   document.registro1.intQuant.value = '<%=intQuant%>';
				}
			}
		
		
		function amigo(){
				 window.open('enviaamigo.asp?acao=abre&produto=<%=intProdID%>','email','resizable=no,width=270,height=225,scrollbars=no');
				}

        function apaga() {
	             document.form2.email.value='';
	    }
</script>

<%
'Formata os valores do produto
precitonx = formatnumber(intPrice,2)
precitoex = formatnumber(economiza,2)
precitovx = formatnumber(intPricev,2)
if prodinfo("parcela")="v" then
intparc = 1
else
intparc = prodinfo("parcela")
end if
cparcela = precitonx / intparc
cparcela = formatnumber(cparcela,2)%>

  		   			<font face="<%=fonte%>" style=font-size:11px;color:000000><%=strLg273%> > <a href=default.asp style=text-decoration:none; onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg4%>';return true;"><b><%=strLg4%></b></a> > <b><%= strNome %></b> > <a href=sessoes.asp?item=<%=strIdsessao%>&categoria=<%=idsessao%> style=text-decoration:none; onMouseOut="window.status='';return true;" onMouseOver="window.status='<%= strSubNome %>';return true;"><b><%= strSubNome %></b></a> > <%= strName %><br><br>
					 <table BORDER="0" CELLSPACING="1" CELLPADDING="0" width=550 align=center><tr><td bgcolor=#bfbfbf>
					 		<table BORDER="0" CELLSPACING="1" CELLPADDING="3" width=550><tr><td bgcolor=#ffffff>
								   <table border="0" align=center width=550 cellspacing="1" cellpadding="1"><tr><form action="comprar.asp" method="post" name="registro1"><td><p><font face="<%=fonte%>" style=font-size:17px;color:000000;font-weight:bold><%= strName %></font></b>
<br>
<% If prodinfo("fabricante")<>"" then %>
<font face="<%=fonte%>" style=font-size:11px;color:000000><%=strLg31%> <b><%=prodinfo("fabricante")%></b>
<% end if %>
</p>
								   		  <table border="0" cellspacing="2" cellpadding="4"><tr align=center><td width=220 valign=top align=center>
				  <%  If len(cstr(imgrande))<3 then imgra="img_nao_disp.gif" else imgra=imgrande end if%>
										  <center><img src="produtos/<%=imgra%>" ><br><br><font face="<%=fonte%>" style=font-size:11px;color:000000>
										  <div align="left"><b><%=strLg37%></b></div>
										  		 <table border=0 align=center>
												  <!--
												  MODIFICADO POR: ROGÉRIO SILVA
												  CASO O VALOR DE DESCONTO FOR DIFERENTE DO ATUAL..
												  MOSTRE ELE NA TELA....
												  //-->												 
												 <%IF precitovx <> precitonx THEN%>
												 <tr><td><font face="<%=fonte%>" style=font-size:11px;color:000000><%=strLg39%> </td>
												 <td><font face="<%=fonte%>" style=font-size:11px;color:000000><b><%= strlgmoeda & " " & precitovx%></b></td></tr>
												 <tr><td><font face="<%=fonte%>" style=font-size:11px;color:000000><%=strLg38%></td>
												 <td><font face="<%=fonte%>" style=font-size:17px;color:cc0000><b><%=strlgmoeda & " " & precitonx%></b></font></td></tr></td></tr>
												 <%ELSE%>
												 <td><font face="<%=fonte%>" style=font-size:17px;color:cc0000><b><%=strlgmoeda & " " & precitonx%></b></font></td></tr></td></tr>
												 <%END IF%>
												 </table>
												         <% if prodinfo("parcela") <> "v" then%>
												 		 <div align="left"><b>ou ainda:</b></div>
														 <table border=0 width=220 align=center><tr><td><font face="<%=fonte%>" style=font-size:11px;color:000000><b><%=prodinfo("parcela")%>x</b> <%=strLg46%> <font face="<%=fonte%>" style=font-size:17px;color:cc0000><b><%=strlgmoeda & " " & cparcela%></b></font></td></tr></table>
														 <%end if%>
														 
<% '*** Voce pode optar por mostrar ou nao o seu estoque (nao aconselhavel , a nao ser qdo é politica da empresa ;-)  %>

						<% '***  Verifica se tem Estoque do Produto
						set rs_estoque = abredb.execute("SELECT estoque FROM estoque WHERE idproduto="&strIDprod&" ;")
						if not rs_estoque.eof then
						estoque_atual=rs_estoque("estoque")
						end if
						rs_estoque.close
						set rs_estoque = nothing
						 %>														 
															 		<br>&nbsp;
																	<% if estoque_atual > 0 then%>
																	<a href="javascript: amigo()" onMouseOut="window.status='';return true;" onMouseOver="window.status='<%= strLg275 %>!';return true;"><img src=<%=dirlingua%>/imagens/amigo.gif border=0></a><% End If %></center></font>
																<td><font face="<%=fonte%>" style=font-size:11px;color:000000><div align=justify><%= strDesc %><br><br><br><font face="<%=fonte%>" style=font-size:11px;color:000000><b><%=strLg28%></b> 


						 
<% '*** Opcao de NAO Mostrar Estoque
    if estoque_atual > 0 then response.write strLg26  else response.write "<font color=red>" & strLg27 & "</font>" end if
%>

<% '*** Opcao de Mostrar Estoque
   ' if estoque_atual > 0 then response.write prodinfo("ESTM")&strLg272&"<BR>"&strLg26  else response.write strLg27 end if
%>


<br><br><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><br>
																<% if estoque_atual > 0 then%>
																		  <table border="0" cellspacing="0" cellpadding="0" width=100% align=center><tr><td align=center><input type=hidden name=frete value="<%=estado2%>"><font face="<%=fonte%>" size="2">
																		  <input type="hidden" name="intProdID" value="<%= intProdID %>">
																		  <font style=font-size:11px;font-family:<%=fonte%>;color:000000> <%=strLg32%>
																		   <input type="text" size="2" name="intQuant" value="1" maxlength=2 <% If mostrar_limite_max_prod_compra="Sim" then%> onChange="HandleError(this)" <% End If %> style=font-size:11px;font-family:<%=fonte%>> <%=strLg33%></b>&nbsp;<BR>
<% If mostrar_limite_max_prod_compra="Sim" then%> 
<%=strLg270%> <B><%=qt_maxima_compra_do_produto%></b> <%=strLg271%> <br>
<% End If %>
																		  <br><input type="image" src=<%=dirlingua%>/imagens/comprar.gif onMouseOver="window.status='<%= strLg276 %>';return true;" onMouseOut="window.status='';return true;" id="submit1" name="submit1"></font></td></tr></table></td>
																		  <tr></table><br>
																	  <!--
																	  MODIFICADO POR: ROGÉRIO SILVA
																	  //-->
																		  <%IF precitovx <> precitonx THEN%>
																		  <table border="0" width="100%" cellspacing="2" cellpadding="2" bgcolor=#eeeeee><tr><td valign=center align=center><font face="<%=fonte%>" style=font-size:11px;color:000000><b><%=strLg34%>&nbsp;<font color="#cc0000"><%=strName%></font>&nbsp;<%=strLg35%>&nbsp;<%=nomeloja%><br><%=strLg36%>&nbsp;<b><%=precitoex%></b> <%= strLgMoedax%>!</td></tr></table>
																		  <%ELSE%>
																		  <table border="0" width="100%" cellspacing="2" cellpadding="2" bgcolor=#eeeeee><tr><td valign=center align=center><font face="<%=fonte%>" style=font-size:11px;color:000000><b><%=strLg257%>&nbsp;<font color="#cc0000"><%=strName%></font>&nbsp;<%=strLg35%>&nbsp;<%=nomeloja%>&nbsp;!</td></tr></table>
																		  <%end if%>
																		  </td></tr></form>
																		  </table>
																		  </table>
															   <%else%>
															              </form>
																		  
																		  <% If mostrar_form_email_prod_esgotado="Sim" then %>
																		  <form action="email_prod.asp" method="post" name="form2">
																		  <table border="0" cellspacing="0" cellpadding="0" width=350 align=center>												
																		  <tr><td align=center><font face=<%=fonte%> style=font-size:11px;color:ff0000><%= request.querystring("erro")%></td></tr>
																		  <tr><td align=left><br>
																		  <font face=<%=fonte%> style=font-size:11px;color:000000><strong>Solicite por e-mail:</strong><br>
																		  <input type="text" name="email" size=25 value="Digite seu e-mail" onClick="apaga();" style=font-size:11px;font-family:<%=fonte%>>&nbsp;
																		  <input type=image src=<%=dirlingua%>/imagens/envi.gif align=top>
																		  <input type="hidden" name="idProd" value="<%=strIDprod%>">
																		  <input type="hidden" name="nome" value="<%=strName%>">
																		  <input type="hidden" name="fabricante" value="<%=strFabricante%>">     																	  																
																		  </td></tr></table></td></form>
																		  <% End If %>
																		  
																		  <tr></table><br>
																		  <%IF precitovx <> precitonx THEN%>
																		  <table border="0" width="100%" cellspacing="2" cellpadding="2" bgcolor=#eeeeee><tr><td valign=center align=center><font face="<%=fonte%>" style=font-size:11px;color:000000><b><%=strLg34%>&nbsp;<font color="#cc0000"><%=strName%></font>&nbsp;<%=strLg35%>&nbsp;<%=nomeloja%><br><%=strLg36%>&nbsp;<b><%=precitoex%></b>&nbsp;<%=strLgMoedax%>!</td></tr></table><% End If %>
																		  </td></tr>
																		  </table>
																		  </table>
																<%end if%>
															</table><br><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><br><center><a HREF="javascript:history.back()" style=text-decoration:none onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg41%>';return true;"><font face="<%=fonte%>" style=font-size:11px>:: <b><%=strLg41%></b> ::</a></font></center>
<%end if%>
	  	  									</td></tr></table>
									</td></tr></table>
									<!-- #include file="baixo.asp" -->
