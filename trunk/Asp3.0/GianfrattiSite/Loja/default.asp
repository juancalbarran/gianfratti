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

<script>
function cadmail()
{
window.open('cadmail.asp?email='+document.emailx.email.value+'&Opcao='+document.emailx.tipo.value,'email','resizable=no,width=270,height=180,scrollbars=no');
		document.emailx.reset()
	}
	function limpa() {
	document.emailx.email.value=''
	}
	
</script>
<style>
SELECT
{
    BACKGROUND-COLOR: #ffffff;
    BORDER-BOTTOM-COLOR: #000000;
    BORDER-BOTTOM-STYLE: groove;
    BORDER-LEFT-COLOR: #000000;
    BORDER-LEFT-STYLE: groove;
    BORDER-RIGHT-COLOR: #000000;
    BORDER-RIGHT-STYLE: groove;
    BORDER-TOP-COLOR: #000000;
    BORDER-TOP-STYLE: groove;
    COLOR: #000000;
    FONT-FAMILY: Arial, Helvetica, sans-serif;
    FONT-SIZE: xx-small;
}
</style>
		 <table width=596 cellspacing="4" cellpadding="4" align=right border=0>
		 		<tr><td colspan=3>

				<!-- Tabela de Publicidade -->
				
<!-- 				<div align="center">
				<TABLE cellSpacing=0 cellPadding=0 width="470" border=0>
                <TBODY><tr><td width=470 valign="top" colspan=3 >
				<a href="http://www.cristaosite.com.br" target="_blank"><img src='banners/banner_cristaosite_01.gif' border=0></a>
				</td></tr>
				<tr>
				<td HEIGHT="10" width=470 colspan=3 align=right><font size=1 face=arial color="#a9a9a9">Publicidade</font></td>
				</tr>
				</TBODY></TABLE>
				</div>
				<br>
-->
				  			
				<!-- Tabela da Imagem de Ofertas do Dia -->	
				<TABLE cellSpacing=0 cellPadding=0 width="98%" border=0>
                <TBODY>
                <TR>
                <TD rowSpan=2><IMG height=18 
                  src="<%= dirlingua %>/imagens/ofertas_do_dia.gif" 
                  width=160 border=0></TD>
                <TD align=right width="100%" bgColor=#3399ff><IMG height=12 
                  src="<%= dirlingua %>/imagens/blue_white_curve_7x12.gif" 
                  width=7 border=0></TD></TR>
                <TR>
                <TD><IMG height=6 src="<%= dirlingua %>/imagens/spacer.gif" 
                  width=1 border=0></TD></TR></TBODY></TABLE>
				  
				</td></tr>

				<!-- #include file="produto.asp" -->
				<tr><td>

				<!-- #include file="top_vendas_newsletter.asp" -->
					
				</td></tr>
 		</table>
	
	<%rs.close%>
	<%set rs = nothing%>
				
	<!-- #include file="baixo.asp" -->