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
'Chama os dados do cliente
Set dados = abredb.Execute("SELECT nome,contato,email FROM clientes WHERE email='"&Cripto(session("usuario"),true)&"';")
'response.write "<br>sql :"&sql
'response.write "<br>sessao :"&session("usuario")
'response.end

if dados.EOF OR dados.BOF then
abredb.close
set abredb = nothing
response.redirect "default.asp"
else

'Chama as variaveis
strNome = Cripto(dados("nome"),false)
strEmail = Cripto(dados("email"),false)

end if
dados.Close
set dados = Nothing
%>


<%
'Requisita os dados para o e-mail
if request.querystring("acao") = "envio" then
strNome = request.form("nome")
strEmail = request.form("email")
strPagamento = request.form("pagamento")
strData = request.form("data")
strHora = request.form("hora")
strAgencia = request.form("agencia")
strValor = request.form("valor")
strMsg = request.form("msg")
strCCEmail = ""

If strNome = "" then
response.redirect "conf_pagamento.asp?erro=- Por favor preencha o seu nome corretamente!&nome="&strNome&"&email="&strEmail&"&data="&strData&"&hora="&strHora&"&agencia="&strAgencia&"&valor="&strValor&"&msg="&strMsg
end if

'Verifica se o e-mail é existente
If strEmail = "" Or instr(strEmail, "@") = 0 Or instr(strEmail, ".") = 0 then
response.redirect "conf_pagamento.asp?erro=- Por favor preencha o seu e-mail corretamente&nome="&strNome&"&email="&strEmail&"&data="&strData&"&hora="&strHora&"&agencia="&strAgencia&"&valor="&strValor&"&msg="&strMsg
end if

'Valida a data é existente
If strData = "" Or instr(strData, "/") = 0 then
response.redirect "conf_pagamento.asp?erro=- Por favor digite uma data válida do pagamento&nome="&strNome&"&email="&strEmail&"&data="&strData&"&hora="&strHora&"&agencia="&strAgencia&"&valor="&strValor&"&msg="&strMsg
end if

'Verifica se hora é existente
If strHora = "" Or instr(strHora, ":") = 0 then
response.redirect "conf_pagamento.asp?erro=- Por favor preencha a hora aproximada do pagamento&nome="&strNome&"&email="&strEmail&"&data="&strData&"&hora="&strHora&"&agencia="&strAgencia&"&valor="&strValor&"&msg="&strMsg
end if

'Valida a Agencia Origem é existente
'If strAgencia = "" then
'response.redirect "conf_pagamento.asp?erro=- Por favor digite a Agência origem do pagamento&nome="&strNome&"&email="&strEmail&"&data="&strData&"&hora="&strHora&"&agencia="&strAgencia&"&valor="&strValor&"&msg="&strMsg
'end if

'Verifica o valor é existente
If strHora = "" Or instr(strHora, ",")then
response.redirect "conf_pagamento.asp?erro=- Por favor preencha o valor do pagamento&nome="&strNome&"&email="&strEmail&"&data="&strData&"&hora="&strHora&"&agencia="&strAgencia&"&valor="&strValor&"&msg="&strMsg
end if
%>
<!--#include file="email_conf_pgto.asp"-->

   			   	 <table><tr><td align="left" valign="top">
				 				<table border="0" cellspacing="4" cellpadding="4" width=590><tr><td><font face="tahoma,arial,helvetica" style=font-size:11px;color:000000> <a href=default.asp style=text-decoration:none; onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg4%>';return true;"><b><%=strLg4%></b></a> » <%=strLg311%><br><br><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><br><br><p align=center><font style=font-size:17px; color=#000000><b><%=strLg124%></b></font></p><p align=center><%=strLg125%> <b><%=strNome%></b>, <%=strLg308%><br><br><%=strLg309%><br></p><p align=center></b><a href=default.asp><img src="<%=dirlingua%>/imagens/continuar.gif" onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg68%>';return true;" border=0></a></p> <br><hr size=1 color=<%=cor3%> width=100%></td></tr>
								</table></td></tr>
				</table>
				<!-- #include file="baixo.asp" -->
<%
response.end
else%>
	  	<script language="javascript">
			function limpa () {
			 document.registro2.nome.value = ''
			 document.registro2.email.value = ''
			 document.registro2.data.value = ''
			 document.registro2.hora.value = ''
			 document.registro2.agencia.value = ''
			 document.registro2.valor.value = ''
			 document.registro2.msg.value = ''
			 document.registro2.pagamento.value = '<%=strLg305%>'
		   }
		</script>
				 <table><tr><td align="left" valign="top">
				 			<table border="0" cellspacing="4" cellpadding="4" width=590><tr><td><font face="<%=fonte%>" style=font-size:11px;color:000000> <a href=default.asp style=text-decoration:none; onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg4%>';return true;"><b><%=strLg4%></b></a> » <%=strLg311%><br><br><div align=left> <hr size=1 color=<%=cor3%> width=100%>  </div><font face="<%=fonte%>" style=font-size:13px><strong><br><%=strLg311%></strong></font><font color=red size=1><%=request.querystring("erro")%></FONT></p><div align=center>
								   <table border="0" cellspacing="3" cellpadding="3" width=500 align=center><font face="<%=fonte%>" style=font-size:11px>Este formulário é exclusivo para que o cliente possa nos enviar os dados de seu pagamento das compras efetuadas em nossa loja virtual.<br><br>Após efetuar o pagamento (depósito / transferência / boleto bancário), preecha o formulário com os dados do pagamento para assim agilizarmos com maior rapidez o processamento de seu pedido.</strong></font><br><form action="conf_pagamento.asp?acao=envio" name=registro2 method=post><tr><td><font style=font-family:<%=fonte%>;font-size=11px; color=#000000> <%=strLg129%> </FONT></TD><td><input type="text" name="nome" value="<%=strNome%>" size="50" maxlength="60" style="font-family: <%=fonte%>; font-size:11px;" value="<%=request.querystring("nome")%>"></TD></tr>
								    <tr><td><font style="font-family: <%=fonte%>; font-size:11px;" color=#000000> <%=strLg108%></FONT></TD><td>
									
<%
'Requisita os dados do cliente
Set dados = abredb.Execute("SELECT email FROM clientes WHERE email='"&Cripto(session("usuario"),true)&"';")
emailatual = Cripto(dados("email"),false)%>
		<INPUT TYPE="TEXT" NAME="email" value="<%=emailatual%>" size="30" MAXLENGTH=60 style="font-family: <%=fonte%>; font-size:11px;" value="<%=request.querystring("email")%>"></TD></TR>
<%dados.Close
set dados = Nothing%>
									<tr><td COLSPAN=2 ALIGN="LEFT"><font style=font-family:<%=fonte%>;font-size:10px;color:#808080;><%=strLg130%></TD></TR>
									<tr><td><font style="font-family: <%=fonte%>; font-size:11px;" color=#000000><%=strLg91%>: </FONT></TD><TD><select name=pagamento style="font-family: <%=fonte%>; font-size:11px;" color:808080; font-weight:bold"><option value="<%=strLg298%>"><%=strLg298%></option>
									<option value="<%=strLg299%>"><%=strLg299%></option>
									<option value="<%=strLg300%>"><%=strLg300%></option>
									<option value="<%=strLg301%>"><%=strLg301%></option>
									<option value="<%=strLg302%>"><%=strLg302%></option></select></TD></TR>
									<tr><td><font style="font-family: <%=fonte%>; font-size:11px;" color=#000000><%=strLg303%> </FONT></TD><TD><INPUT TYPE="Text" NAME="data" SIZE="20" MAXLENGTH="8" style="font-family: <%=fonte%>; font-size:11px;" value="<%=request.querystring("data")%>"> Ex: 01/10/04</TD></TR>
									<tr><td><font style="font-family: <%=fonte%>; font-size:11px;" color=#000000><%=strLg305%> </FONT></TD><TD><INPUT TYPE="Text" NAME="hora" SIZE="20" MAXLENGTH="5" style="font-family: <%=fonte%>; font-size:11px;" value="<%=request.querystring("hora")%>"> Ex: 15:00</TD></TR>
									<tr><td><font style="font-family: <%=fonte%>; font-size:11px;" color=#000000><%=strLg306%> </FONT></TD><TD><INPUT TYPE="Text" NAME="agencia" SIZE="20" MAXLENGTH="8" style="font-family: <%=fonte%>; font-size:11px;" value="<%=request.querystring("agencia")%>"> Ex: 1234-5</TD></TR>
									<tr><td><font style="font-family: <%=fonte%>; font-size:11px;" color=#000000><%=strLg307%> </FONT></TD><TD><INPUT TYPE="Text" NAME="valor" SIZE="20" MAXLENGTH="12" style="font-family: <%=fonte%>; font-size:11px;" value="<%=request.querystring("valor")%>"> Ex: 150,90</TD></TR>
									<tr><td><br><font style="font-family: <%=fonte%>; font-size:11px;" color=#000000><%=strLg304%><BR></TD><TD>&nbsp;</TD></TR>
									<tr><td COLSPAN=2><textarea style="font-family: <%=fonte%>; font-size:11px;" cols="100" rows="5" name="msg" wrap="hard" ><%=request.querystring("msg")%></textarea></TD></TR>
									</table>
											<table align=center><tr><td><input type=image src=<%=dirlingua%>/imagens/confirmar.gif onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg311%>';return true;"></td></form><form action="javascript: limpa()"><td>&nbsp;&nbsp;&nbsp;<input type=image src=<%=dirlingua%>/imagens/limpar.gif onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg89%>';return true;"></td></tr></form></table>
										</CENTER><br><div align=left> <hr size=1 color=<%=cor3%> width=100%></div></FORM></td></tr>
							</table></td></tr>
				</table>
			<!-- #include file="baixo.asp" -->
<%end if%>
