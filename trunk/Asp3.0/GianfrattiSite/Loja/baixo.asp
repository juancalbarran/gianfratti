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
'#	   http://comunidade.virtuastore.com.br
'#	   http://br.groups.yahoo.com/group/virtuastore
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
	  </td></tr></table>
	</table>
		

<!-- ////   Sombra do Rodape -->


<!-- ////   Fim da Sombra do Rodape -->


<!--   /////   Rodape    -->


<TABLE cellSpacing=0 cellPadding=0 width="780" bgColor=#f0f0f0 border=0>
  <TBODY>
  <TR>
    <TD align=middle><IMG height=3 
      src="<%= dirlingua %>/imagens/spacer_1x1.gif" width=1 border=0><BR>
      <TABLE cellSpacing=0 cellPadding=2 width="50%" border=0>
        <TBODY>
        <TR>
          <TD align="center"><a href="default.asp"  onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg4%>';return true;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=strLg4%></font></a><SPAN 
            > | </SPAN>
<%
Set menui = abredb.Execute("SELECT * FROM sessoes WHERE ver='s' ORDER by nome;")
While Not menui.EOF%>
	  	  				<a href="sessoes.asp?item=<%= menui("id") %>"  onMouseOut="window.status='';return true;" onMouseOver="window.status='<%= menui("nome") %>';return true;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%= menui("nome") %></font></a> <SPAN> | </SPAN>
<%menui.MoveNext
Wend
menui.Close
Set menui = Nothing%> 
</TD></TR><TR>
          <TD noWrap align="center">
		  <br>
		  <a href="quemsomos.asp"  onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg20%>';return true;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=strLg20%></font></a><SPAN > | </SPAN>
			<a href="seguranca.asp"  onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg19%>';return true;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=strLg19%></font></a><SPAN 
            > | </SPAN>
			<a href="como.asp"  onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg16%>';return true;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=strLg16%></font></a><SPAN 
            > | </SPAN>
			<a href="carrinhodecompras.asp"  onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg51%>';return true;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=strLg51%></font></a><SPAN 
            > | </SPAN>
			<a href="<%=link%>"  onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg8%>';return true;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=strLg8%></font></a><SPAN 
            > | </SPAN><a href="registro.asp"  onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg5%>';return true;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=strLg5%></font></a>
			<SPAN ></SPAN></TD></TR></TBODY></TABLE>
     <br></TD></TR></TBODY></TABLE>



<!-- ////   Sombra do Rodape -->


<!-- ////   Fim da Sombra do Rodape -->
			
<TABLE cellSpacing=0 cellPadding=0 width="780" border=0>
  <TBODY>
  <TR>
    <TD bgColor=#ffffff><div align="center"><img src="fundo_baixo.jpg" width="778" height="27" /></div></TD>
  </TR></TBODY></TABLE>
			

<!-- ////   Sombra da Barra de Botoes -->


<TABLE cellSpacing=0 cellPadding=0 width="780" border=0>
  <TBODY>
  <TR>
    <TD bgColor=#808080><IMG height=1 
      src="<%= dirlingua %>/imagens/spacer.gif" width=1></TD></TR></TBODY></TABLE>

<!-- ////   Fim da Sombra da Barra de Botoes -->

			
<TABLE cellSpacing=0 cellPadding=0 width="780" bgColor=<%= Cor_principal%> border=0>
  <TBODY>
  <TR>
    <TD align=middle><IMG height=3 
      src="<%= dirlingua %>/imagens/spacer_1x1.gif" width=1 border=0><BR>
      <TABLE cellSpacing=0 cellPadding=2 width="50%" border=0>
        <TBODY>
        <TR>
          <TD noWrap align="center"> 
<font size="1" color="#ffffff"><%= nomeloja %> - <%= Slogan_da_sua_loja %>
<br>
VirtuaStore Open 3.0 &nbsp;| &nbsp;<Êll BaixoC()%> &nbsp;| &nbsp;<Êll BaixoComunidade() %></font><br><br>
</TD></TR></TBODY></TABLE>
      </TD></TR></TBODY></TABLE>
			
			


<!--   /////   Fim do Rodape    -->
	

<%
'Fecha o banco de bados
abredb.close
set abredb = nothing
%>
