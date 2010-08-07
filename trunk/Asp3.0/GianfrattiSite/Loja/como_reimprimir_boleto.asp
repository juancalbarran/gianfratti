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
     <tr><td><font face="<%=fonte%>" style=font-size:11px;color:000000> <a href=default.asp style=text-decoration:none; onMouseOut="window.status='';return true;" onMouseOver="window.status='Home';return true;"><b>Home</b></a> » Como Reimprimir o Boleto Bancário?<br><br><div align=left>
       <table border=0 cellspacing=0 width=100% cellpadding=0>
         <tr><td height=5></td></tr>
         <tr><td height=1 bgcolor=<%=cor3%>></td></tr>
         <tr><td height=5></td></tr>
       </table>
       </div>
    <br><br><font face="<%=fonte%>" style=font-size:13px><strong>Como reimprimir o Boleto na <%=nomeloja%></strong></font><br><br>
    <div align=center>
<!--CONTEUDO-->
<!--Personaliza o menu se o cliente estiver logado-->
<% if session("usuario") = "" then %>

    <table width="100%" align="center" border="0">
      <tr bgColor="#006666">
        <td width="100%" height="20" bgcolor="#f0f0f0"><font face="<%=fonte%>"  style=font-size:11px color=000000><strong>Roteiro</strong></font></td>        
      </tr>
      <tr><td>&nbsp;</td></tr>
      <tr>
        <td><font face="<%=fonte%>" style=font-size:11px>
           <ul>1. Clicar no bot&atilde;o <A href="fechapedido.asp?compra=login&menu=sim"><IMG src="<%= dirlingua %>/imagens/botao_superior_login.gif" border=0 target="home"></A></ul>
           <ul>2. Em seguida aparecer&aacute; o bot&atilde;o <A href="minhascompras.asp"><IMG src="<%= dirlingua %>/imagens/botao_superior_historico_compras.gif" border=0 target="home"></A> clique nele !</ul>
           <ul>3. Na p&aacute;gina de <%=strLg119%> voc&ecirc;, clicar no bot&atilde;o <img border="0" src="<%=dirlingua%>/imagens/detalhes.gif"></ul>
           <ul>4. Em detalhes da Compra, clicar no bot&atilde;o <img border="0" src="<%=dirlingua%>/imagens/2via_boleto.gif"></ul>
        </td></font>
      </tr>
    </table>

<%else%>

    <table width="100%" align="center" border="0">
      <tr bgColor="#006666">
        <td width="100%" height="20" bgcolor="#f0f0f0"><font face="<%=fonte%>"  style=font-size:11px color=000000><strong>Roteiro</strong></font></td>        
      </tr>
      <tr><td>&nbsp;</td></tr>
      <tr>
        <td><font face="<%=fonte%>" style=font-size:11px>
           <ul>1. Clicar no bot&atilde;o <A href="minhascompras.asp"><IMG src="<%= dirlingua %>/imagens/botao_superior_historico_compras.gif" border=0 target="home"></A></ul>
           <ul>2. Na p&aacute;gina de <%=strLg119%>&nbsp;&nbsp;<%=strNome%>, clicar no bot&atilde;o <img border="0" src="<%=dirlingua%>/imagens/detalhes.gif"></ul>
           <ul>3. Em detalhes da Compra, clicar no bot&atilde;o <img border="0" src="<%=dirlingua%>/imagens/2via_boleto.gif"></ul>
        </td></font>
      </tr>
    </table>

<%end if%>
<br>
<br>
<br>
<!--FIM DO CONTEUDO-->
       <table border=0 cellspacing=0 width=100% cellpadding=0>
         <tr><td height=5></td></tr>
         <tr><td height=1 bgcolor=<%=cor3%>></td></tr>
         <tr><td height=5></td></tr>
       </table>
       <A HREF="javascript:history.back();" style=text-decoration:none onMouseOut="window.status='';return true;" onMouseOver="window.status='Voltar';return true;"><font face="<%=fonte%>" style=font-size:11px>:: <b>Voltar</b> ::</font></A></div></ul></td></tr>
   </table></td></tr>
</table>
<!-- #include file="baixo.asp" -->