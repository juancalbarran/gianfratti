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
'Requisita os dados para o e-mail
if request.querystring("acao") = "ajuda" then
strNome = request.form("nome")
strEmail = request.form("email")
strDuv = request.form("duvida")
strAssunto = request.form("assunto")
strMsg = request.form("msg")
strCCEmail = ""
If strNome = "" then
response.redirect "ajuda_email.asp?erro=- Por favor preencha o seu nome corretamente!&nome="&strNome&"&email="&strEmail&"&assunto="&strAssunto&"&msg="&strMsg
end if

'Verifica se o e-mail é exixtente
If strEmail = "" Or instr(strEmail, "@") = 0 Or instr(strEmail, ".") = 0 then
response.redirect "ajuda_email.asp?erro=- Por favor preencha o seu e-mail corretamente!&nome="&strNome&"&email="&strEmail&"&assunto="&strAssunto&"&msg="&strMsg
end if

'Valida a mensagem
If strMsg = "" then
response.redirect "ajuda_email.asp?erro=- Por favor escreva sua mensagem!&nome="&strNome&"&email="&strEmail&"&assunto="&strAssunto&"&msg="&strMsg
end if
If strAssunto = "" then
strAssunto = "Esclarecimento de dúvida do Cliente"
end if


StrMsg2 = "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>"
StrMsg2 = StrMsg2 & "<HTML><HEAD>"
StrMsg2 = StrMsg2 & "<META content='text/html; charset=iso-8859-1' http-equiv=Content-Type>"
StrMsg2 = StrMsg2 & "<META content='MSHTML 5.00.2614.3500' name=GENERATOR></HEAD>"
StrMsg2 = StrMsg2 & "<BODY>"
StrMsg2 = StrMsg2 & "<DIV align=justify>"
StrMsg2 = StrMsg2 & "<TABLE border=0 cellSpacing=0 width='98%'>"
StrMsg2 = StrMsg2 & "  <TBODY>"
StrMsg2 = StrMsg2 & "  <TR>"
StrMsg2 = StrMsg2 & "    <TD colSpan=4 height=42>"
StrMsg2 = StrMsg2 & "      <DIV align=center><font face="&fonte&"><B><FONT style=font-size:17px color=000000>"&tituloloja&"</FONT></B><BR><FONT style=font-size:11px>"&endereco11&" - "&bairro11&"<BR>"&cidade11&"/"&estado11&" - "&pais11&" - <a href='mailto:"&emailloja&"'>"&emailloja&"<BR></FONT></DIV></FONT></TD></TR>"
StrMsg2 = StrMsg2 & "  <TR>"
StrMsg2 = StrMsg2 & "    <TD colSpan=4><FONT face="&fonte&">"
StrMsg2 = StrMsg2 & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
StrMsg2 = StrMsg2 & "     </FONT></TD></TR>"
StrMsg2 = StrMsg2 & "  <TR>"
StrMsg2 = StrMsg2 & "    <TD align=left colSpan=2><FONT face="&fonte&"><FONT color=#000000" 
StrMsg2 = StrMsg2 & "      style='FONT-SIZE: 11px'><B>Duvida de Cliente enviado através da da sua loja!</B></FONT>" 
StrMsg2 = StrMsg2 & "      </FONT>"
StrMsg2 = StrMsg2 & "    <TD align=right colSpan=2><B><FONT face="&fonte&"><FONT color=#000000" 
StrMsg2 = StrMsg2 & "      style='FONT-SIZE: 11px'>Data: </B>"&day(now)&"/"&month(now)&"/"&year(date)&" </FONT>"
StrMsg2 = StrMsg2 & "      <DIV></DIV></FONT></TD></TR>"
StrMsg2 = StrMsg2 & "  <TR>"
StrMsg2 = StrMsg2 & "    <TD colSpan=4>"
StrMsg2 = StrMsg2 & "      <DIV><FONT face="&fonte&">"
StrMsg2 = StrMsg2 & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
StrMsg2 = StrMsg2 & "      </FONT></DIV>"
StrMsg2 = StrMsg2 & "      <DIV><FONT face="&fonte&" style='FONT-SIZE: 11px'><br>Um cliente acessou o site e acessou o menu Atendimento > Por Email , com dúvidas sobre <strong>"&strDuv&"</strong>. Abaixo segue a mensagem do cliente: <br><br> Nome: "&strNome&" <br><br> Email: "&strEmail&" <br><br> Mensagem: "&strMsg&" </FONT></DIV></FONT></FONT></B><br></FONT></TD></TR></TBODY></TABLE></DIV></BODY></HTML>"
StrMsg2 = StrMsg2 & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
'Corpo do e-mail
strMensagem = StrMsg2

'Envia o e-mail
%><!--#include file="email.asp"-->
<%EnviaEmail Application("HostLoja"), Application("ComponenteLoja"), strEmail, "", emailloja, strAssunto, strMensagem%>

   			   	 <table><tr><td align="left" valign="top">
				 				<table border="0" cellspacing="4" cellpadding="4" width=590><tr><td><font face="tahoma,arial,helvetica" style=font-size:11px;color:000000> <a href=default.asp style=text-decoration:none; onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg4%>';return true;"><b><%=strLg4%></b></a> » <%=strLg14%><br><br><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><br><br><p align=center><font style=font-size:17px; color=#000000><b><%=strLg124%></b></font></p><p align=center><%=strLg125%> <b><%=strNome%></b>, <%=strLg126%><br><%=strLg127%><br></p><p align=center></b><a href=default.asp><img src="<%=dirlingua%>/imagens/continuar.gif" onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg68%>';return true;" border=0></a></p> <br><hr size=1 color=<%=cor3%> width=100%></td></tr>
								</table></td></tr>
				</table>
				<!-- #include file="baixo.asp" -->
<%
response.end
else%>
	  	<script language="javascript">
			function limpa () {
			 document.registro1.nome.value = ''
			 document.registro1.email.value = ''
			 document.registro1.assunto.value = ''
			 document.registro1.msg.value = ''
			 document.registro1.duvida.value = '<%=strLg128%> <%=nomeloja%>?'
		   }
		</script><% duvida = request("duvida") %>
				 <table><tr><td align="left" valign="top">
				 			<table border="0" cellspacing="4" cellpadding="4" width=590><tr><td><font face="<%=fonte%>" style=font-size:11px;color:000000> <a href=default.asp style=text-decoration:none; onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg4%>';return true;"><b><%=strLg4%></b></a> » <%=strLg14%><br><br><div align=left> <hr size=1 color=<%=cor3%> width=100%>  </div><font face="<%=fonte%>" style=font-size:13px><strong><br><%=strLg17%></strong></font> <font color=red size=1><%=request.querystring("erro")%></p><div align=center>
								   <table border="0" cellspacing="3" cellpadding="3" width=500 align=center><form action="ajuda_email.asp?acao=ajuda" name=registro1 method=post><tr><td><font style=font-family:<%=fonte%>;font-size=11px; color=#000000> <%=strLg129%> </FONT></TD><td><input type="text" name="nome" size="50" maxlength="60" style="font-family: <%=fonte%>; font-size:11px;" value="<%=request.querystring("nome")%>"></TD></tr>
								    <tr><td><font style="font-family: <%=fonte%>; font-size:11px;" color=#000000> <%=strLg108%></FONT></TD><td><INPUT TYPE="TEXT" NAME="email"  size="30" MAXLENGTH=60 style="font-family: <%=fonte%>; font-size:11px;" value="<%=request.querystring("email")%>"></TD></TR>
									<tr><td COLSPAN=2 ALIGN="LEFT"><font style=font-family:<%=fonte%>;font-size:10px;color:#808080;><%=strLg130%></TD></TR>
									<tr><td><font style="font-family: <%=fonte%>; font-size:11px;" color=#000000><%=strLg131%> </FONT></TD><TD>
<select name=duvida style="font-family: <%=fonte%>; font-size:11px;" color:808080; font-weight:bold">
<option value="<%=strLg128%> <%=nomeloja%>?"><%=strLg128%> <%=nomeloja%>?</option>
									<option value="<%=strLg134%>"><%=strLg134%></option>
									<option value="<%=strLg318%>" <% If duvida = "2" Then Response.Write "SELECTED"%>><%=strLg318%></option>
									<option value="<%=strLg135%>"><%=strLg135%></option>
									<option value="<%=strLg136%>"><%=strLg136%></option>
									<option value="<%=strLg137%>"><%=strLg137%></option>
									<option value="<%=strLg138%>"><%=strLg138%></option>
									<option value="<%=strLg139%>"><%=strLg139%></option>
									</select></TD></TR>
									<tr><td><font style="font-family: <%=fonte%>; font-size:11px;" color=#000000><%=strLg132%> </FONT></TD><TD><INPUT TYPE="Text" NAME="assunto" SIZE="60" MAXLENGTH="60" style="font-family: <%=fonte%>; font-size:11px;" value="<%=request.querystring("assunto")%>"></TD></TR>
									<tr><td><font style="font-family: <%=fonte%>; font-size:11px;" color=#000000><%=strLg133%><BR></TD><TD>&nbsp;</TD></TR>
									<tr><td COLSPAN=2><textarea style="font-family: <%=fonte%>; font-size:11px;" cols="100" rows="5" name="msg" wrap="hard" ><%=request.querystring("msg")%></textarea></TD></TR>
									</table>
											<table align=center><tr><td><input type=image src=<%=dirlingua%>/imagens/envi.gif onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg140%>';return true;"></td></form><form action="javascript: limpa()"><td><input type=image src=<%=dirlingua%>/imagens/limpar.gif onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg89%>';return true;"></td></tr></form></table>
										</CENTER><br><div align=left> <hr size=1 color=<%=cor3%> width=100%></div></FORM></td></tr>
							</table></td></tr>
				</table>
			<!-- #include file="baixo.asp" -->
<%end if%>
