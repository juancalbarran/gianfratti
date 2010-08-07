
<%
If Request.QueryString("acao") = "1" then
acao = "Mensagem enviada com sucesso!!! Obrigado pelo seu interesse em nossas cestas, retornaremos este seu e-mail em breve."
End If
%>

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
	 <div id="layer1" style="position:absolute; left:600px; top:60px; z-index:1"></div>
	 	  <table><tr><td align="left" valign="top">
		  				 <table border="0" cellspacing="4" cellpadding="4" width=590><tr>
		  				   <td><font face="<%=fonte%>" style=font-size:11px;color:000000> <a href=default.asp style=text-decoration:none; onMouseOut="window.status='';return true;" onMouseOver="window.status='Home';return true;"><b>Home</b></a> » Cota&ccedil;&atilde;o Online <br>
		  				     <br><div align=left> <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table></div>
		  				     <p><font face="<%=fonte%>" style=font-size:13px><strong>	  				         Cota&ccedil;&atilde;o Online</strong></font>
  				             </p>
		  				       <div align=justify>
		  				       <font style=font-size:11px face=<%=fonte%>><br />
		  				       <span class="style14" style="font-size: 12px">Fa&ccedil;a agora uma cota&ccedil;&atilde;o das cestas b&aacute;sicas <strong>Sindicato</strong> e   <strong>Natalinas</strong>.<br />
  				             Os campos marcados com <span class="style3" style="font-weight: bold">*</span> s&atilde;o   de preenchimento obrigat&oacute;rio.</span></p>
		  				     <p class="style3" style="font-size: 12px; font-weight: bold"><%=acao%></p>
							 							 <script language="JavaScript">
function checar_formulario(cadastro){
if (cadastro.nome.value == ""){
alert("Por favor informe o seu nome !");
cadastro.nome.focus();
return (false);
}
if (cadastro.email.value == ""){
alert("Por favor informe o seu e-mail !");
cadastro.email.focus();
return (false);
}
if (cadastro.email.value.indexOf('@', 0) == -1){
alert("O e-mail digitado é invalido !");
cadastro.email.focus();
return (false);
}
if (cadastro.telefone.value == ""){
alert("Por favor informe o seu telefone !");
cadastro.telefone.focus();
return (false);
}
if (cadastro.empresa.value == ""){
alert("Por favor digite o nome da sua empresa !");
cadastro.empresa.focus();
return (false);
}
if (cadastro.cnpj.value == ""){
alert("Por favor digite o CNPJ da empresa !");
cadastro.cnpj.focus();
return (false);
}
if (cadastro.endereco.value == ""){
alert("Por favor digite o endereço da empresa !");
cadastro.endereco.focus();
return (false);
}
if (cadastro.bairro.value == ""){
alert("Por favor digite o nome do bairro !");
cadastro.bairro.focus();
return (false);
}
if (cadastro.cidade.value == ""){
alert("Por favor digite o nome da cidade !");
cadastro.cidade.focus();
return (false);
}
return (true);
}
</script>
		  				     <form id="form1" name="form1" method="post" action="envia_cotacao.asp" onSubmit="return checar_formulario(this)">
		  				       <table width="552" border="0" cellspacing="0" cellpadding="0">
                                 <tr>
                                   <td width="102">* Empresa:</td>
                                   <td width="31">&nbsp;</td>
                                   <td width="394"><input name="empresa" type="text" id="empresa" size="50" /></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td>* CNPJ/CPF:</td>
                                   <td>&nbsp;</td>
                                   <td><input name="cnpj" type="text" id="cnpj" size="50" /></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td>* Endere&ccedil;o:</td>
                                   <td>&nbsp;</td>
                                   <td><input name="endereco" type="text" id="endereco" size="50" maxlength="255" /></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td>* Bairro:</td>
                                   <td>&nbsp;</td>
                                   <td><input name="bairro" type="text" id="bairro" size="50" /></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td>* Cidade:</td>
                                   <td>&nbsp;</td>
                                   <td><input name="cidade" type="text" id="cidade" size="50" /></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td>* Nome:</td>
                                   <td>&nbsp;</td>
                                   <td><input name="nome" type="text" id="nome" size="50" /></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td>Cargo:</td>
                                   <td>&nbsp;</td>
                                   <td><input name="cargo" type="text" id="cargo" size="50" /></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td>* E-mail:</td>
                                   <td>&nbsp;</td>
                                   <td><input name="email" type="text" id="email" size="50" /></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td>* Telefone:</td>
                                   <td>&nbsp;</td>
                                   <td><input name="ddd1" type="text" id="ddd1" size="5" /> 
                                     - 
                                     <input name="telefone" type="text" id="telefone" size="20" /></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td>Fax:</td>
                                   <td>&nbsp;</td>
                                   <td><input name="ddd2" type="text" id="ddd2" size="5" />
-
  <input name="fax" type="text" id="fax" size="20" /></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td>Celular:</td>
                                   <td>&nbsp;</td>
                                   <td><input name="ddd3" type="text" id="ddd3" size="5" />
-
  <input name="celular" type="text" id="celular" size="20" /></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td colspan="3"><div align="center"><strong>Escolha abaixo o(s) tipo(s) de cesta(s) e a quantidade que   deseja.</strong></div></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td><select name="lista1" id="lista1">
                                     <option>Escolha</option>
                                     <option>------------------------------</option>
                                     <option>NATAL TURMALINA</option>
                                     <option>NATAL P&Eacute;ROLA</option>
                                     <option>NATAL ESMERALDA</option>
                                     <option>NATAL DIAMANTE</option>
                                     <option>NATAL CRISTAL</option>
                                     <option>IND&Uacute;STRIAS TEXTEIS 28,57KG</option>
                                     <option>IND&Uacute;STRIAS TEXTEIS 31,91KG</option>
                                     <option>IND&Uacute;STRIAS GR&Aacute;FICAS 29,96KG</option>
                                     <option>HOSPITAIS 27,62kG</option>
                                     <option>ESCOLAS 26,83kG</option>
                                     <option>ESCOLAS 20,88kG</option>
                                     <option>CONSTRU&Ccedil;&Atilde;O CIVIL 25,89kG</option>
                                     <option>CONDOM&Iacute;NIOS 27,25KG</option>
                                     <option>POSTOS COMBUST&Iacute;VEIS 29KG</option>
                                   </select>
                                   &nbsp;&nbsp;&nbsp;&nbsp;
                                   <input name="qt1" type="text" id="qt1" value="00" size="5" /></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td><select name="lista2" id="lista2">
                                     <option>Escolha</option>
                                     <option>------------------------------</option>
                                     <option>NATAL TURMALINA</option>
                                     <option>NATAL P&Eacute;ROLA</option>
                                     <option>NATAL ESMERALDA</option>
                                     <option>NATAL DIAMANTE</option>
                                     <option>NATAL CRISTAL</option>
                                     <option>IND&Uacute;STRIAS TEXTEIS 28,57KG</option>
                                     <option>IND&Uacute;STRIAS TEXTEIS 31,91KG</option>
                                     <option>IND&Uacute;STRIAS GR&Aacute;FICAS 29,96KG</option>
                                     <option>HOSPITAIS 27,62kG</option>
                                     <option>ESCOLAS 26,83kG</option>
                                     <option>ESCOLAS 20,88kG</option>
                                     <option>CONSTRU&Ccedil;&Atilde;O CIVIL 25,89kG</option>
                                     <option>CONDOM&Iacute;NIOS 27,25KG</option>
                                     <option>POSTOS COMBUST&Iacute;VEIS 29KG</option>
                                   </select>
&nbsp;&nbsp;&nbsp;&nbsp;
<input name="qt2" type="text" id="qt2" value="00" size="5" /></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td><select name="lista3" id="lista3">
                                     <option>Escolha</option>
                                     <option>------------------------------</option>
                                     <option>NATAL TURMALINA</option>
                                     <option>NATAL P&Eacute;ROLA</option>
                                     <option>NATAL ESMERALDA</option>
                                     <option>NATAL DIAMANTE</option>
                                     <option>NATAL CRISTAL</option>
                                     <option>IND&Uacute;STRIAS TEXTEIS 28,57KG</option>
                                     <option>IND&Uacute;STRIAS TEXTEIS 31,91KG</option>
                                     <option>IND&Uacute;STRIAS GR&Aacute;FICAS 29,96KG</option>
                                     <option>HOSPITAIS 27,62kG</option>
                                     <option>ESCOLAS 26,83kG</option>
                                     <option>ESCOLAS 20,88kG</option>
                                     <option>CONSTRU&Ccedil;&Atilde;O CIVIL 25,89kG</option>
                                     <option>CONDOM&Iacute;NIOS 27,25KG</option>
                                     <option>POSTOS COMBUST&Iacute;VEIS 29KG</option>
                                   </select>
&nbsp;&nbsp;&nbsp;&nbsp;
<input name="qt3" type="text" id="qt3" value="00" size="5" /></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td>Data do fechamento: </td>
                                   <td>&nbsp;</td>
                                   <td><input name="data1" type="text" id="data1" size="20" /></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td>Data da entrega: </td>
                                   <td>&nbsp;</td>
                                   <td><input name="data2" type="text" id="data2" size="20" /></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td><span style="font-weight: bold">Observa&ccedil;&otilde;es:</span></td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td><textarea name="mensagem" cols="40" rows="10" id="mensagem"></textarea></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td><input type="submit" name="Submit" value="Enviar cota&ccedil;&atilde;o" />
                                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                   <input type="reset" name="Submit2" value="Refazer Cota&ccedil;&atilde;o" /></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td><input name="assunto" type="hidden" id="assunto" value="Formul&aacute;rio de cota&ccedil;&atilde;o online" /></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td colspan="3"><p class="style14" style="font-size: 12px">Se voc&ecirc; preferir, poder&aacute; montar a sua pr&oacute;pria cesta, com a composi&ccedil;&atilde;o que   melhor atender a necessidade da sua empresa. <a href="montacesta.asp"><strong>Monte sua Cesta</strong></a></p>
                                     <p style="font-size: 12px"><span class="style14">A<font size="1" color="#ffffff"> <%= nomeloja %></font> garante a qualidade dos produtos da embalagem e a pontualidade da   entrega. Cliente<font size="1" color="#ffffff"> <%= nomeloja %></font></span> <span class="style14">&eacute; cliente 100% satisfeito.</span></p>
                                     <p>&nbsp;</p></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                   <td>&nbsp;</td>
                                 </tr>
                               </table>
                             </form>
		  				     <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><center><a HREF="default.asp" style=text-decoration:none onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg41%>';return true;"><font face="<%=fonte%>" style=font-size:11px>:: <b><%=strLg41%></b> ::</a></font></center></td>
		  				 </tr>
						 </table></td></tr>
		 </table>
		 <!-- #include file="baixo.asp" -->