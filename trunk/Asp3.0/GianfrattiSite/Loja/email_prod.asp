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

' Dados do e-mail
strEmail    = request.form("email")
strIdProd   = request.form("idProd")
strNomeProd = request.form("nome")
strFab      = request.form("fabricante")
strAssunto  = "Solicitação de Produtos em Falta"

'Busca o nome do cliente
set rs = abredb.execute("select nome from clientes where email='" & Cripto(Session("usuario"),true) & "'")
if not rs.eof then
strNome = Cripto(rs("nome"),false)
end if
rs.close
set rs = nothing

If strEmail = "" Or instr(strEmail, "@") = 0 Or instr(strEmail, ".") = 0 then
   response.redirect "produtos.asp?produto="&strIdProd&"&erro=Preencha o E-Mail Corretamente!"
end if

'Monta a Mensagem

StrMsg = "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>"
StrMsg = StrMsg & "<HTML><HEAD>"
StrMsg = StrMsg & "<META content='text/html; charset=iso-8859-1' http-equiv=Content-Type>"
StrMsg = StrMsg & "<META content='MSHTML 5.00.2614.3500' name=GENERATOR></HEAD>"
StrMsg = StrMsg & "<BODY>"
StrMsg = StrMsg & "<DIV align=justify>"
StrMsg = StrMsg & "<TABLE border=0 cellSpacing=0 width='98%'>"
StrMsg = StrMsg & "  <TBODY>"
StrMsg = StrMsg & "  <TR>"
StrMsg = StrMsg & "    <TD colSpan=4 height=42>"
StrMsg = StrMsg & "      <DIV align=center><font face="&fonte&"><B><FONT style=font-size:17px color=000000>"&tituloloja&"</FONT></B><BR><FONT style=font-size:11px>"&endereco11&" - "&bairro11&"<BR>"&cidade11&"/"&estado11&" - "&pais11&" - <a href='mailto:"&emailloja&"'>"&emailloja&"<BR></FONT></DIV></FONT></TD></TR>"
StrMsg = StrMsg & "  <TR>"
StrMsg = StrMsg & "    <TD colSpan=4><FONT face="&fonte&">"
StrMsg = StrMsg & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
StrMsg = StrMsg & "     </FONT></TD></TR>"
StrMsg = StrMsg & "  <TR>"
StrMsg = StrMsg & "    <TD align=left colSpan=2><FONT face="&fonte&"><FONT color=#000000" 
StrMsg = StrMsg & "      style='FONT-SIZE: 11px'><B>Solicitação de Produtos em Falta</B></FONT>" 
StrMsg = StrMsg & "      </FONT>"
StrMsg = StrMsg & "    <TD align=right colSpan=2><B><FONT face="&fonte&"><FONT color=#000000" 
StrMsg = StrMsg & "      style='FONT-SIZE: 11px'>Data: </B>"&day(now)&"/"&month(now)&"/"&year(date)&" </FONT>"
StrMsg = StrMsg & "      <DIV></DIV></FONT></TD></TR>"
StrMsg = StrMsg & "  <TR>"
StrMsg = StrMsg & "    <TD colSpan=4>"
StrMsg = StrMsg & "      <DIV><FONT face="&fonte&">"
StrMsg = StrMsg & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
StrMsg = StrMsg & "      </FONT></DIV>"
StrMsg = StrMsg & "      <DIV><FONT face="&fonte&" style='FONT-SIZE: 11px'>Um cliente acessou o produto abaixo e o mesmo está em falta no estoque da loja virtual. <br>Avisá-lo quando este produto estiver em Estoque, pelo email <A "
StrMsg = StrMsg & "      href='mailto:"&strEmail&"'>" 
StrMsg = StrMsg & "      "&strEmail&"</a></FONT></DIV>"
StrMsg = StrMsg & "      <DIV><FONT face=Arial style='FONT-SIZE: 11px'><FONT face="&fonte&"" 
StrMsg = StrMsg & "      style='FONT-SIZE: 11px'>&nbsp; "
StrMsg = StrMsg & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
StrMsg = StrMsg & "      </FONT></FONT></DIV>"
StrMsg = StrMsg & "<tr><td><br></td></tr>"
StrMsg = StrMsg & "      <DIV align=left><FONT face="&fonte&"><FONT style='FONT-SIZE: 11px'>" 
StrMsg = StrMsg & "      </DIV>"
StrMsg = StrMsg & "      <DIV align=left><FONT face="&fonte&"><FONT style='FONT-SIZE: 11px'>" 
StrMsg = StrMsg & "    <TD colSpan=4><FONT face="&fonte&"><FONT face="&fonte&"><FONT color=#000000 style='COLOR: #000000; FONT-SIZE: 11px'><B>Nome do produto:" 
StrMsg = StrMsg & "      </B>"&strNomeProd&"<BR><B>Fabricante: </B>"&strFab&" "
StrMsg = StrMsg & "      <BR><B>Código do Produto:</B> "&strIdProd&" "
StrMsg = StrMsg & "      <BR><B>Link do Produto na loja:</B> <A "
StrMsg = StrMsg & "      href='http://"&urlloja&"/produtos.asp?produto="&strIdProd&"'>http://"&urlloja&"/produtos.asp?produto="&strIdProd&"</A> </FONT></FONT></B><BR><br></FONT></TD></TR></TBODY></TABLE></DIV></BODY></HTML>"
StrMsg = StrMsg & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"

%>

<!--#include file="email.asp"-->
<%EnviaEmail Application("HostLoja"), Application("ComponenteLoja"), strEmail, "", emailloja, strAssunto, strMsg%>

   			   	 <table><tr><td align="left" valign="top">
				 				<table border="0" cellspacing="4" cellpadding="4" width=590><tr><td><font face="tahoma,arial,helvetica" style=font-size:11px;color:000000> <a href=default.asp style=text-decoration:none; onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg4%>';return true;"><b><%=strLg4%></b></a> » <%=strLg14%><br><br><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><br><br><p align=center><font style=font-size:17px; color=#000000><b><%=strLg124%></b></font></p><p align=center><%=strLg125%> <b><%if strNome="" then Response.Write "Visitante" else Response.Write strNome end if %></b>, <%=strLg252%><br><%=strLg127%><br></p><p align=center></b><a href=default.asp><img src="<%=dirlingua%>/imagens/continuar.gif" onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg68%>';return true;" border=0></a></p> <br><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table></td></tr>
								</table></td></tr>
				</table>
<!-- #include file="baixo.asp" -->

<%' response.write StrMsg  '*** Usado para testes (comentar a linha do EnviaEmail) %>