
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
		  				       <p>Voc&ecirc; pode compor suas cestas com itens e   quantidades que melhor atendam as suas necessidades. Monte sua cesta e solicite uma cota&ccedil;&atilde;o</p>
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
if (cadastro.fone.value == ""){
alert("Por favor informe o seu telefone !");
cadastro.fone.focus();
return (false);
}
if (cadastro.qtcesta.value == ""){
alert("Por favor informe a quantidade de cestas !");
cadastro.qtcesta.focus();
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
		  				     <form 
                        action="envia_montacesta.asp" 
                        method="post" name="form" id="form" 
                        onSubmit="return checar_formulario(this)">
		  				       <input 
                        name="assunto" 
                        type="hidden" id="assunto" value="Monte sua Cesta | Cota&ccedil;&atilde;o" />
		  				       <table cellspacing="0" cellpadding="0" width="566" border="0">
                                 <tbody>
                                   <tr>
                                     <td width="566"><table class="menuesq" cellspacing="0" cellpadding="0" 
                              width="562" border="0">
                                         <tbody>
                                           <tr>
                                             <td width="53" bgcolor="#341c88"><div align="center"><strong><font 
                                color="#ffffff">QTD.</font></strong></div></td>
                                             <td bgcolor="#341c88"><font 
                                color="#ffffff"><strong>PRODUTO</strong></font></td>
                                             <td width="136" bgcolor="#341c88"><strong><font 
                                color="#ffffff">MARCA</font></strong></td>
                                             <td align="middle" width="134" 
                                bgcolor="#341c88"><strong><font 
                                color="#ffffff">OUTRA </font></strong></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input id="qt1" 
                                size="3" name="qt1" />
                                             </div></td>
                                             <td width="239">&nbsp;A&ccedil;&uacute;car refinado - 1kg</td>
                                             <td><select id="marca1" name="marca1">
                                               <option>Uni&atilde;o</option>
                                               <option>Amoroso</option>
                                                 <option>Guarani</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro1" size="20" 
                                name="outro1" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                                 <input 
                                id="qt44" size="3" 
                                name="qt44" />
                                             </div></td>
                                             <td>&nbsp;A&ccedil;ucar Cristal - 5kg </td>
                                             <td><select id="marca44" 
                                name="marca44">
                                               <option>Capela</option>
                                               <option>Tryumpho</option>
                                               <option>Gram Petit</option>
                                                 <option>Outro</option>
                                                                                          </select></td>
                                             <td align="middle"><input 
                                id="outro44" size="20" 
                                name="outro44" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                                 <input 
                                id="qt45" size="3" 
                                name="qt45" />
                                             </div></td>
                                             <td>&nbsp;A&ccedil;ucar Cristal - 2kg </td>
                                             <td><select id="marca45" 
                                name="marca45">
                                               <option>Capela</option>
                                               <option>Tryumpho</option>
                                               <option>Gram Petit</option>
                                               <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input 
                                id="outro45" size="20" 
                                name="outro45" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt2" size="3" 
                                name="qt2" />
                                             </div></td>
                                             <td>&nbsp;Achocolatado - 200g</td>
                                             <td><select id="marca2" 
                                name="marca2">
                                                 <option>Toddy</option>
                                                 <option>Nescau</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input 
                                id="outro2" size="20" 
                                name="outro2" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt3" size="3" 
                                name="qt3" />
                                             </div></td>
                                             <td>&nbsp;Achocolatado - 400g</td>
                                             <td><select id="marca3" 
                                name="marca3">
                                               <option>Apti</option>
                                                 <option>Toddy</option>
                                                 <option>Nescau</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input 
                                id="outro3" size="20" 
                                name="outro3" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt4" size="3" 
                                name="qt4" />
                                             </div></td>
                                             <td>&nbsp;Arroz Agulhinha Tipo 1 - 5kg</td>
                                             <td><select id="marca4" 
                                name="marca4">
                                                 <option 
                                selected="selected">Camil</option>
                                                 <option>Tia J&uacute;</option>
                                                 <option>Tio Jo&atilde;o</option>
                                                 <option>Prato Fino</option>
                                                 <option>Niemayer</option>
                                                 <option>Vibrante</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro4" 
                                size="20" name="outro4" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt5" size="3" 
                                name="qt5" />
                                             </div></td>
                                             <td>&nbsp;Arroz Agulhinha Tipo 2 - 5kg</td>
                                             <td><select id="marca5" 
                                name="marca5">
                                               <option>Tia Amelia</option>
                                               <option>Rei do Sul</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro5" 
                                size="20" name="outro5" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt6" size="3" 
                                name="qt6" />
                                             </div></td>
                                             <td>&nbsp;Arroz Agulhinha Tipo 1 - 1kg</td>
                                             <td><select id="marca6" 
                                name="marca6">
                                                 <option 
                                selected="selected">Camil</option>
                                                 <option>Tia J&uacute;</option>
                                                 <option>Vibrante</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input name="outro6" id="outro6" 
                                size="20" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt7" size="3" name="qt7" />
                                             </div></td>
                                             <td>&nbsp;Azeitonas Verdes - 100g</td>
                                             <td><select id="marca7" 
                                name="marca7">
                                               <option>Villefrut</option>
                                               <option>Tio Paco</option>
                                                 <option>Outros</option>
                                             </select></td>
                                             <td align="middle"><input id="outro7" 
                                size="20" name="outro7" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt9" size="3" 
                                name="qt9" />
                                             </div></td>
                                             <td>&nbsp;Biscoito Doce - 150g</td>
                                             <td><select id="marca9" 
                                name="marca9">
                                                 <option 
                                selected="selected">Festiva</option>
                                                 <option>Faville</option>
                                                 <option>Aymor&eacute;</option>
                                                 <option>Outros</option>
                                             </select></td>
                                             <td align="middle"><input 
                                id="outro9" size="20" 
                                name="outro9" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt10" size="3" 
                                name="qt10" />
                                             </div></td>
                                             <td>&nbsp;Biscoito Maizena - 200g</td>
                                             <td><select id="marca10" 
                                name="marca10">
                                               <option>Aymor&eacute;</option>
                                               <option>Faville</option>
                                               <option>Xereta</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input 
                                id="outro10" size="20" 
                                name="outro10" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt11" size="3" 
                                name="qt11" />
                                             </div></td>
                                             <td>&nbsp;Biscoito Recheado - 180g</td>
                                             <td><select id="marca11" 
                                name="marca11">
                                               <option>Aymor&eacute;</option>
                                               <option>Parmalat</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input 
                                id="outro11" size="20" 
                                name="outro11" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt12" size="3" 
                                name="qt12" />
                                             </div></td>
                                             <td>&nbsp;Biscoito Salgado - 200g</td>
                                             <td><select id="marca12" 
                                name="marca12">
                                               <option>Aymor&eacute;</option>
                                               <option>Faville</option>
                                               <option>Xereta</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input 
                                id="outro12" size="20" 
                                name="outro12" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt13" size="3" 
                                name="qt13" />
                                             </div></td>
                                             <td>&nbsp;Caf&eacute; Torrado - 250g</td>
                                             <td><select id="marca13" 
                                name="marca13">
                                               <option>Villa Real</option>
                                               <option>Malta</option>
                                               <option>3 Cora&ccedil;&otilde;es</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro13" 
                                size="20" name="outro13" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt14" size="3" 
                                name="qt14" />
                                             </div></td>
                                             <td>&nbsp;Caf&eacute; Torrado - 500g</td>
                                             <td><select id="marca14" 
                                name="marca14">
                                               <option>Villa Real</option>
                                               <option>Malta</option>
                                               <option>3 Cora&ccedil;&otilde;es</option>
                                               <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro14" size="20" 
                                name="outro14" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt15" size="3" 
                                name="qt15" />
                                             </div></td>
                                             <td>&nbsp;Creme Dental - 50g</td>
                                             <td><select id="marca15" 
                                name="marca15">
                                                 <option 
                                selected="selected">Sorriso</option>
                                                 <option>Colgate</option>
                                                 <option>Freedent</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro15" 
                                size="20" name="outro15" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt16" size="3" 
                                name="qt16" />
                                             </div></td>
                                             <td>&nbsp;Extrato de Tomate - 140g</td>
                                             <td><select id="marca16" 
                                name="marca16">
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro16" 
                                size="20" name="outro16" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt17" size="3" 
                                name="qt17" />
                                             </div></td>
                                             <td>&nbsp;Farinha de Mandioca - 500g</td>
                                             <td><select id="marca17" 
                                name="marca17">
                                                 <option 
                                selected="selected">Alhil</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input 
                                id="outro17" size="020" 
                                name="outro17" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt18" size="3" 
                                name="qt18" />
                                             </div></td>
                                             <td>&nbsp;Farinha de Trigo Especial - 1kg</td>
                                             <td><select id="marca18" 
                                name="marca18">
                                               <option selected="selected">Rosa Branca</option>
                                                 <option>Dona Benta</option>
                                                 <option>Dona Benta</option>
                                                 <option>Clarice</option>
                                                 <option>N&uacute;mero 1</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro18" 
                                size="20" name="outro18" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input id="qt19" 
                                size="3" name="qt19" />
                                             </div></td>
                                             <td>&nbsp;Feij&atilde;o Carioca - 1kg</td>
                                             <td><select id="marca19" name="marca19">
                                               <option>G Minas</option>
                                               <option>Turam&atilde;</option>
                                               <option>Gordinho</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro19" size="20" 
                                name="outro19" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt20" size="3" 
                                name="qt20" />
                                             </div></td>
                                             <td>&nbsp;Farinha de Milho - 1kg</td>
                                             <td><select id="marca20" 
                                name="marca20">
                                               <option>Pach&aacute;</option>
                                               <option>Solar</option>
                                               <option>Sa&uacute;de</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro20" 
                                size="20" name="outro20" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input id="qt21" 
                                size="3" name="qt21" />
                                             </div></td>
                                             <td>&nbsp;Fub&aacute; Mimoso - 500g</td>
                                             <td><select id="marca21" name="marca21">
                                               <option>Pramar</option>
                                               <option>Pach&aacute;</option>
                                               <option>Dumilho</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro21" size="20" 
                                name="outro21" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt22" size="3" name="qt22" />
                                             </div></td>
                                             <td>&nbsp;P&oacute; para gelatina - 85g</td>
                                             <td><select id="marca22" 
                                name="marca22">
                                               <option>Apti</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro22" size="20" 
                                name="outro22" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt23" size="3" name="qt23" />
                                             </div></td>
                                             <td>&nbsp;Goiabada - 500g</td>
                                             <td><select id="marca23" 
                                name="marca23">
                                                 <option 
                                selected="selected">Val</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro23" size="20" 
                                name="outro23" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input id="qt24" 
                                size="3" name="qt24" />
                                             </div></td>
                                             <td>&nbsp;L&atilde; de a&ccedil;o - 8 unidades</td>
                                             <td><select id="marca24" name="marca24">
                                               <option>Sanybril</option>
                                               <option>Help</option>
                                               <option>Bombril</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro24" size="20" 
                                name="outro24" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt25" size="3" 
                                name="qt25" />
                                             </div></td>
                                             <td>&nbsp;Leite Condensado - 395g</td>
                                             <td><select id="marca25" 
                                name="marca25">
                                               <option>Itamb&eacute;</option>
                                               <option>Gl&oacute;ria</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input 
                                id="outro25" size="020" 
                                name="outro25" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt26" size="3" 
                                name="qt26" />
                                             </div></td>
                                             <td>&nbsp;Leite em P&oacute; Integral - 400g</td>
                                             <td><select id="marca26" 
                                name="marca26">
                                               <option>Pink</option>
                                               <option>Leitbom</option>
                                                 <option>Outro</option>
                                             </select>                                             </td>
                                             <td align="middle"><input id="outro26" 
                                size="20" name="outro26" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt27" size="3" 
                                name="qt27" />
                                             </div></td>
                                             <td>&nbsp;Leite em P&oacute; Modificado - 400g</td>
                                             <td><select id="marca27" 
                                name="marca27">
                                               <option>Pink</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input 
                                id="outro27" size="20" 
                                name="outro27" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt29" size="3" name="qt29" />
                                             </div></td>
                                             <td>&nbsp;Macarr&atilde;o Espagueti - 500g</td>
                                             <td><select id="marca29" 
                                name="marca29">
                                               <option>Vila</option>
                                               <option>Yara</option>
                                               <option>Santa Am&eacute;lia</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro29" 
                                size="20" name="outro29" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt30" size="3" name="qt30" />
                                             </div></td>
                                             <td>&nbsp;Macarr&atilde;o Parafuso - 500g</td>
                                             <td><select id="marca30" 
                                name="marca30">
                                               <option>Vila</option>
                                               <option>Yara</option>
                                               <option>Santa Am&eacute;lia</option>
                                               <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro30" size="20" 
                                name="outro30" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt31" size="3" 
                                name="qt31" />
                                             </div></td>
                                             <td>&nbsp;Milho Verde em Conserva - 200g</td>
                                             <td><select id="marca31" name="marca31">
                                               <option>Goias Verde</option>
                                               <option>Quero</option>
                                               <option>Twist</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro31" size="020" 
                                name="outro31" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input id="qt32" 
                                size="3" name="qt32" />
                                             </div></td>
                                             <td>&nbsp;Mistura para Bolo - 450g</td>
                                             <td><select id="marca32" name="marca32">
                                                 <option>Santa Am&eacute;lia</option>
                                                 <option>Boa Sorte</option>
                                                 <option>Vilma</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro32" size="20" 
                                name="outro32" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input name="qt34" id="qt34" 
                                size="3" />
                                             </div></td>
                                             <td>&nbsp;&Oacute;leo de Soja Refinado - 900ml</td>
                                             <td><select id="marca34" name="marca34">
                                               <option>Ville</option>
                                                 <option>Soya</option>
                                                 <option>Villa Velha</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro34" size="20" 
                                name="outro34" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt35" size="3" name="qt35" />
                                             </div></td>
                                             <td>&nbsp;Papel Higi&ecirc;nico Branco - 4 unid.</td>
                                             <td><select id="marca35" name="marca35">
                                               <option>Mitsy</option>
                                               <option>Bombom</option>
                                               <option>Personal</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro35" size="20" 
                                name="outro35" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt36" size="3" 
                                name="qt36" />
                                             </div></td>
                                             <td>&nbsp;Polpa de Tomate - 520g</td>
                                             <td><select id="marca36" 
                                name="marca36">
                                               <option>Quero</option>
                                               <option>Cica</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro36" 
                                size="020" name="outro36" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt37" size="3" 
                                name="qt37" />
                                             </div></td>
                                             <td>&nbsp;Pur&ecirc; de Tomate - 340g</td>
                                             <td><select id="marca37" 
                                name="marca37">
                                               <option>Quero</option>
                                               <option>Cica</option>
                                               <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro37" 
                                size="20" name="outro37" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input id="qt38" 
                                size="3" name="qt38" />
                                             </div></td>
                                             <td>&nbsp;Sab&atilde;o em Pedra 5 peda&ccedil;os - 1kg </td>
                                             <td><select id="marca38" name="marca38">
                                                 <option selected="selected">Razzo</option>
                                                 <option>Ip&ecirc;</option>
                                                 <option>Bica</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro38" size="20" 
                                name="outro38" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt39" size="3" name="qt39" />
                                             </div></td>
                                             <td>&nbsp;Sabonete - 90g</td>
                                             <td><select id="marca39" 
                                name="marca39">
                                               <option>Nips</option>
                                               <option>Yp&ecirc;</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro39" size="20" 
                                name="outro39" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input id="qt34" 
                                size="3" name="qt34" />
                                             </div></td>
                                             <td>&nbsp;Sal Refinado - 1kg</td>
                                             <td><select id="marca40" name="marca40">
                                                 <option 
                                selected="selected">Lebre</option>
                                                 <option>Cai&ccedil;ara</option>
                                                 <option>Marlim</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro40" size="20" 
                                name="outro40" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt41" size="3" name="qt41" />
                                             </div></td>
                                             <td>&nbsp;Salsicha em Conserva - 180g</td>
                                             <td><select id="marca41" 
                                name="marca41">
                                                 <option 
                                selected="selected">Anglo</option>
                                                 <option>Friboi</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro41" size="20" 
                                name="outro41" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input 
                                id="qt42" size="3" name="qt42" />
                                             </div></td>
                                             <td>&nbsp;Sardinha em Conserva - 130g</td>
                                             <td><select id="marca42" 
                                name="marca42">
                                               <option>Gomes da Costa</option>
                                               <option>Nave</option>
                                               <option>Coqueiro</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro42" size="020" 
                                name="outro42" /></td>
                                           </tr>
                                           <tr>
                                             <td align="middle" height="30"><div align="center">
                                               <input id="qt43" 
                                size="3" name="qt43" />
                                             </div></td>
                                             <td>&nbsp;Tempero Completo - 300g</td>
                                             <td><select id="marca43" name="marca43">
                                               <option>Eros</option>
                                               <option>Pirata</option>
                                               <option>Imperial</option>
                                                 <option>Outro</option>
                                             </select></td>
                                             <td align="middle"><input id="outro43" size="20" 
                                name="outro43" /></td>
                                           </tr>
                                         </tbody>
                                     </table></td>
                                   </tr>
                                   <tr>
                                     <td class="menuesq" height="40">Os campos marcados com 
                                       <span class="style3" style="font-weight: bold">*</span> s&atilde;o de preenchimento obrigat&oacute;rio.</td>
                                   </tr>
                                   <tr>
                                     <td><table class="menuesq" cellspacing="0" cellpadding="0" 
                              width="554" border="0">
                                         <tbody>
                                           <tr>
                                             <td width="186"><div align="left"><strong>* Quantidade de 
                                             Cestas:</strong></div></td>
                                             <td width="14">&nbsp;</td>
                                             <td width="354"><input id="qtcesta" size="10" 
                                name="qtcesta" />
                                             &nbsp;</td>
                                           </tr>
                                           <tr>
                                             <td width="186"><div align="left"><strong>* 
                                             Empresa:</strong></div></td>
                                             <td width="14">&nbsp;</td>
                                             <td><input id="empresa" size="34" 
                                name="empresa" /></td>
                                           </tr>
                                           <tr>
                                             <td width="186"><div align="left"><strong>* CNPJ / CPF:</strong></div></td>
                                             <td width="14">&nbsp;</td>
                                             <td><input id="cnpj" size="34" name="cnpj" /></td>
                                           </tr>
                                           <tr>
                                             <td width="186"><div align="left"><strong>* Endere&ccedil;o:</strong></div></td>
                                             <td width="14">&nbsp;</td>
                                             <td><input id="endereco" size="34" name="endereco" />
                                               &nbsp;<strong>&nbsp;</strong></td>
                                           </tr>
                                           <tr>
                                             <td width="186"><div align="left"><strong>* Bairro:</strong></div></td>
                                             <td width="14">&nbsp;</td>
                                             <td><input id="bairro" size="34" 
                                name="bairro" /></td>
                                           </tr>
                                           <tr>
                                             <td width="186"><div align="left"><strong> Complemento:</strong></div></td>
                                             <td width="14">&nbsp;</td>
                                             <td><input id="complemento" size="34" 
                                name="complemento" />
                                               &nbsp;<strong>&nbsp;</strong></td>
                                           </tr>
                                           <tr>
                                             <td width="186"><div align="left"><strong>* Cidade:</strong></div></td>
                                             <td width="14">&nbsp;</td>
                                             <td><input id="cidade" size="34" name="cidade" /></td>
                                           </tr>
                                           <tr>
                                             <td><div align="left"><strong>* 
                                               Nome:</strong></div></td>
                                             <td>&nbsp;</td>
                                             <td><input id="nome" size="34" name="nome" /></td>
                                           </tr>
                                           <tr>
                                             <td height="22"><div align="left"><strong>Cargo:</strong></div></td>
                                             <td>&nbsp;</td>
                                             <td><input name="cargo" id="cargo" size="34" /></td>
                                           </tr>
                                           <tr>
                                             <td><div align="left"><strong>* 
                                               E-mail:</strong></div></td>
                                             <td>&nbsp;</td>
                                             <td><input id="email" size="34" 
name="email" /></td>
                                           </tr>
                                           <tr>
                                             <td><div align="left"><strong>* 
                                               Telefone:</strong></div></td>
                                             <td>&nbsp;</td>
                                             <td><input id="ddd1" size="5" name="ddd1" />
                                               &nbsp;
                                               <input id="fone" size="20" name="fone" />
                                               &nbsp;</td>
                                           </tr>
                                           <tr>
                                             <td><div align="left"><strong>Fax:</strong></div></td>
                                             <td>&nbsp;</td>
                                             <td><input id="ddd2" size="5" name="ddd2" />
                                               &nbsp;
                                               <input id="fax" size="20" name="fax" />
                                               &nbsp;</td>
                                           </tr>
                                           <tr>
                                             <td><div align="left"><strong>Celular:</strong></div></td>
                                             <td>&nbsp;</td>
                                             <td><input id="ddd3" size="5" 
                                name="ddd3" />
                                               &nbsp;
                                               <input id="celular" 
                                size="20" name="celular" /></td>
                                           </tr>
                                           <tr>
                                             <td height="10"><div align="left"></div></td>
                                             <td></td>
                                             <td></td>
                                           </tr>
                                           <tr>
                                             <td 
                                align="right"><div align="left"><strong>Observa&ccedil;&otilde;es:</strong></div></td>
                                             <td>&nbsp;</td>
                                             <td><textarea id="mensagem" name="mensagem" rows="5" cols="31"></textarea></td>
                                           </tr>
                                           <tr>
                                             <td>&nbsp;</td>
                                             <td>&nbsp;</td>
                                             <td>&nbsp;</td>
                                           </tr>
                                           <tr>
                                             <td>&nbsp;</td>
                                             <td>&nbsp;</td>
                                             <td><input name="Submit" type="submit" id="Submit" value="Solicitar Cota&ccedil;&atilde;o" />
                                             &nbsp;&nbsp;&nbsp;&nbsp;
                                             <input name="Reset" type="reset" id="Submit" value="Come&ccedil;ar de Novo" /></td>
                                           </tr>
                                         </tbody>
                                     </table></td>
                                   </tr>
                                 </tbody>
                               </table>
	  				         </form>
		  				     <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><center><a HREF="default.asp" style=text-decoration:none onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg41%>';return true;"><font face="<%=fonte%>" style=font-size:11px>:: <b><%=strLg41%></b> ::</a></font></center></td>
		  				 </tr>
						 </table></td></tr>
		 </table>
		 <!-- #include file="baixo.asp" -->