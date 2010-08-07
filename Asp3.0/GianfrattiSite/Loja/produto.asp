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


'Produto Destaque

'Opção 1
'set rs9 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' AND destaque='s';")
'if rs9.eof or rs9.bof then
'	rs9.close
'	set rs9 = nothing
'	set atualizar = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok' AND destaque='s';")
'	set rs9 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' AND destaque='s';")
'	if rs9.eof or rs9.bof then
'	rs9.close
'	set rs9 = nothing
'	set atualizar = abredb.Execute("UPDATE produtos SET status = 'ok' WHERE idprod = "&rs9("idprod")&" ;")	
'	end if
'else
'set atualizar = abredb.Execute("UPDATE produtos SET status = 'ok' WHERE idprod = "&rs9("idprod")&" AND destaque='s';")
'end if


'Opcao 2 : Sorteio aleatório de Produto do grupo de produtos que foram setados como DESTAQUE na área Administrativa
'		   (Para funcionar esta rotina é preciso que no config.asp esteja como mostrar_produto_destaque_fachada="Sim"

Set rs9 = Server.CreateObject("ADODB.Recordset")
rs9.Open "SELECT * FROM produtos WHERE destaque='s'" , abredb, adOpenStatic, adLockReadOnly
rmax=rs9.recordcount
	if rs9.eof or rs9.bof then
		mostrar_produto_destaque_fachada="Nao"
	rs9.close
	set rs9 = nothing
	end if

	t=Timer
	Randomize t
	rnum = Int(RND * rmax)
	rs9.move rnum
	set atualizar = abredb.Execute("UPDATE produtos SET status = 'ok' WHERE idprod = "&rs9("idprod")&" ;")



'Produto 1
set rs = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' AND estoque='s' ;")
if rs.eof or rs.bof then
rs.close
set rs = nothing
set atualizar = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok' AND estoque='s' ;")
set rs = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' AND estoque='s' ;")
if rs.eof or rs.bof then
rs.close
set rs = nothing
set atualizar = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok' AND estoque='s' ;")
set rs = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' AND estoque='s' ;")
end if
else
set atualizar = abredb.Execute("UPDATE produtos SET status = 'ok' WHERE idprod = "&rs("idprod")&" AND estoque='s' ;")
end if

'Produto 2
set rs2 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" AND estoque='s' ;")
if rs2.eof or rs2.bof then
rs2.close
set rs2 = nothing
set atualizar2 = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok' AND estoque='s' ;")
set rs2 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" AND estoque='s' ;")
if rs2.eof or rs2.bof then
rs2.close
set rs2 = nothing
set atualizar2 = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok' AND estoque='s' ;")
set rs2 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" AND estoque='s' ;")
end if
else
set atualizar2 = abredb.Execute("UPDATE produtos SET status = 'ok' WHERE idprod = "&rs2("idprod")&" AND estoque='s' ;")
end if

'Produto 3
set rs3 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" and idprod <> "&rs2("idprod")&" AND estoque='s' ;")
if rs3.eof or rs3.bof then
rs3.close
set rs3 = nothing
set atualizar3 = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok' AND estoque='s' ;")
set rs3 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" and idprod <> "&rs2("idprod")&" AND estoque='s' ;")
if rs3.eof or rs3.bof then
rs3.close
set rs3 = nothing
set atualizar3 = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok' AND estoque='s' ;")
set rs3 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" and idprod <> "&rs2("idprod")&" AND estoque='s' ;")
end if
else
set atualizar3 = abredb.Execute("UPDATE produtos SET status = 'ok' WHERE idprod = "&rs3("idprod")&" AND estoque='s' ;")
end if

'Produto 4
set rs4 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" and idprod <> "&rs2("idprod")&" and idprod <> "&rs3("idprod")&" AND estoque='s' ;")
if rs4.eof or rs4.bof then
rs4.close
set rs4 = nothing
set atualizar4 = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok' AND estoque='s' ;")
set rs4 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" and idprod <> "&rs2("idprod")&" and idprod <> "&rs3("idprod")&" AND estoque='s' ;")
if rs4.eof or rs4.bof then
rs4.close
set rs4 = nothing
set atualizar4 = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok' AND estoque='s' ;")
set rs4 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> '"&rs("idprod")&"' and idprod <> '"&rs2("idprod")&"' and idprod <> '"&rs3("idprod")&"' AND estoque='s' ;")
end if
else
set atualizar4 = abredb.Execute("UPDATE produtos SET status = 'ok' WHERE idprod = "&rs4("idprod")&" AND estoque='s' ;")
end if

'Produto 5
set rs5 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" and idprod <> "&rs2("idprod")&" and idprod <> "&rs3("idprod")&" and idprod <> "&rs4("idprod")&" AND estoque='s' ;")
if rs5.eof or rs5.bof then
rs5.close
set rs5 = nothing
set atualizar5 = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok' AND estoque='s' ;")
set rs5 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" and idprod <> "&rs2("idprod")&" and idprod <> "&rs3("idprod")&" and idprod <> "&rs4("idprod")&" AND estoque='s' ;")
if rs5.eof or rs5.bof then
rs5.close
set rs5 = nothing
set atualizar5 = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok' AND estoque='s' ;")
set rs5 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" and idprod <> "&rs2("idprod")&" and idprod <> "&rs3("idprod")&" and idprod <> "&rs4("idprod")&" AND estoque='s' ;")
end if
else
set atualizar5 = abredb.Execute("UPDATE produtos SET status = 'ok' WHERE idprod = "&rs5("idprod")&" AND estoque='s' ;")
end if


'Produto 6
set rs6 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" and idprod <> "&rs2("idprod")&" and idprod <> "&rs3("idprod")&" and idprod <> "&rs4("idprod")&" and idprod <> "&rs5("idprod")&" AND estoque='s' ;")
if rs6.eof or rs6.bof then
rs6.close
set rs6 = nothing
set atualizar6 = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok' AND estoque='s' ;")
set rs6 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" and idprod <> "&rs2("idprod")&" and idprod <> "&rs3("idprod")&" and idprod <> "&rs4("idprod")&" and idprod <> "&rs5("idprod")&" AND estoque='s' ;")
if rs6.eof or rs6.bof then
rs6.close
set rs6 = nothing
set atualizar6 = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok' AND estoque='s' ;")
set rs6 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" and idprod <> "&rs2("idprod")&" and idprod <> "&rs3("idprod")&" and idprod <> "&rs4("idprod")&" and idprod <> "&rs5("idprod")&" AND estoque='s' ;")
end if
else
set atualizar6 = abredb.Execute("UPDATE produtos SET status = 'ok' WHERE idprod = "&rs6("idprod")&" AND estoque='s' ;")
end if


'Produto 7
set rs7 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" and idprod <> "&rs2("idprod")&" and idprod <> "&rs3("idprod")&" and idprod <> "&rs4("idprod")&" and idprod <> "&rs5("idprod")&" and idprod <> "&rs6("idprod")&" AND estoque='s' ;")
if rs7.eof or rs7.bof then
rs7.close
set rs7 = nothing
set atualizar7 = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok' AND estoque='s' ;")
set rs7 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" and idprod <> "&rs2("idprod")&" and idprod <> "&rs3("idprod")&" and idprod <> "&rs4("idprod")&" and idprod <> "&rs5("idprod")&" and idprod <> "&rs6("idprod")&" AND estoque='s' ;")
if rs7.eof or rs7.bof then
rs7.close
set rs7 = nothing
set atualizar7 = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok' AND estoque='s' ;")
set rs7 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" and idprod <> "&rs2("idprod")&" and idprod <> "&rs3("idprod")&" and idprod <> "&rs4("idprod")&" and idprod <> "&rs5("idprod")&" and idprod <> "&rs6("idprod")&" AND estoque='s' ;")
end if
else
set atualizar7 = abredb.Execute("UPDATE produtos SET status = 'ok' WHERE idprod = "&rs7("idprod")&" AND estoque='s' ;")
end if

'Produto 8
set rs8 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" and idprod <> "&rs2("idprod")&" and idprod <> "&rs3("idprod")&" and idprod <> "&rs4("idprod")&" and idprod <> "&rs5("idprod")&" and idprod <> "&rs6("idprod")&" and idprod <> "&rs7("idprod")&" AND estoque='s' ;")
if rs8.eof or rs8.bof then
rs8.close
set rs8 = nothing
set atualizar8 = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok' AND estoque='s' ;")
set rs8 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" and idprod <> "&rs2("idprod")&" and idprod <> "&rs3("idprod")&" and idprod <> "&rs4("idprod")&" and idprod <> "&rs5("idprod")&" and idprod <> "&rs6("idprod")&" and idprod <> "&rs7("idprod")&" AND estoque='s' ;")
if rs8.eof or rs8.bof then
rs8.close
set rs8 = nothing
set atualizar8 = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok' AND estoque='s' ;")
set rs8 = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and idprod <> "&rs("idprod")&" and idprod <> "&rs2("idprod")&" and idprod <> "&rs3("idprod")&" and idprod <> "&rs4("idprod")&" and idprod <> "&rs5("idprod")&" and idprod <> "&rs6("idprod")&" and idprod <> "&rs7("idprod")&" AND estoque='s' ;")
end if
else
set atualizar8 = abredb.Execute("UPDATE produtos SET status = 'ok' WHERE idprod = "&rs8("idprod")&" AND estoque='s' ;")
end if


intProdID1 = rs("idprod")
intProdID2 = rs2("idprod")
intProdID3 = rs3("idprod")
intProdID4 = rs4("idprod")
intProdID5 = rs5("idprod")
intProdID6 = rs6("idprod")
intProdID7 = rs7("idprod")
intProdID8 = rs8("idprod")
intProdID9 = rs9("idprod")


'Formatação dos preços dos produtos
precito1 = formatNumber(rs("preco"), 2)
precito2 = formatNumber(rs2("preco"), 2)
precito3 = formatNumber(rs3("preco"), 2)
precito4 = formatNumber(rs4("preco"), 2)
precito5 = formatNumber(rs5("preco"), 2)
precito6 = formatNumber(rs6("preco"), 2)
precito7 = formatNumber(rs7("preco"), 2)
precito8 = formatNumber(rs8("preco"), 2)
precito9 = formatNumber(rs9("preco"), 2)%>



<% If mostrar_produto_destaque_fachada="Sim" and intProdID9<>"" then %>
<tr><td width="570" height="180" >

<%'############################   INÍCIO DO PRODUTO DESTAQUE   ##############################

' Esta área mostra um produto em destaque acima dos produtos da vitrine.
' Adaptacao do codigo feito por henrique@metasupri.com.br
%>
	  <table style="BORDER: silver 2px dotted; cellSpacing=1 cellPadding=1 width=213 border=0" BORDER="0" CELLSPACING="1" CELLPADDING="0"><tr><td bgcolor="<%=fontebranca%>">
	         <form action="comprar.asp" method="post" name="comprar9">
	   		 <table BORDER="0" CELLSPACING="1" CELLPADDING="3"><tr><td bgcolor="<%=fontebranca%>">
			 
			 <% If len(cstr(rs9.fields("imgra")))<3 then imgra="img_nao_disp.gif" else imgra=rs9.fields("imgra")  end if%>
			  		<table align=center width=560 cellspacing="1" cellpadding="1"><tr>
					<td width=500 align="center" height=180><a href="produtos.asp?produto=<%=rs9.fields("idprod")%>"  onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style="color:"<%=fontebranca%>";text-decoration:none;"><img src="produtos/<%=imgra%>" border="0"></a></td>
				  <td align="left" valign=center width=560><font style=font-size:13px;font-family:<%=fonte%>><b><font color=<%=fontepreta%>><%=rs9.fields("nome")%></b><br><br><b><%=strLg29%></b>
<FONT face="arial, helvetica" color=#0000ff size=2><B>&nbsp;<%= strlgmoeda & " " & precito9%></b></font><br><br><b><%=strLg28%></b>
						
						<% '***  Verifica se tem Estoque do Produto 9 (Produto Destaque)
						set rs_estoque9 = abredb.execute("SELECT estoque FROM estoque WHERE idproduto="&rs9.fields("idprod")&" ;")
						if not rs_estoque9.eof then
						estoque_atual_9=rs_estoque9("estoque")
						end if
						rs_estoque9.close
						set rs_estoque9 = nothing
						 %>
						
<%if estoque_atual_9 > 0 then response.write " " & strLg26 else response.write " " & strLg27 end if%><br><b>Entrega:</b> &nbsp; <%=application("diasentrega")%> dias(s) + transporte<div align=right><br><input type="hidden" name="intProdID" value="<%= intProdID9 %>"><input type="hidden" name="intQuant" value=1><%if estoque_atual_9 > 0 then response.write "<a href=""JavaScript: document.comprar9.submit();""><img src="&dirlingua&"/imagens/comprar_2.gif border=0 alt='"& strLg276 & "' onMouseOut=""window.status='';return true;"" onMouseOver=""window.status='"& strLg276 & "';return true;""></a>&nbsp;&nbsp;" end if%>&nbsp;&nbsp;<a href="produtos.asp?produto=<%=rs9.fields("idprod")%>"  onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style="color:"<%=fontebranca%>";text-decoration:none;"><img src=<%=dirlingua%>/imagens/detalhes.gif border="0"></a></div></td></form></tr>					
				    </table>
		     </table>
	  </table>
<%'############################   FIM DO PRODUTO DESTAQUE   ##############################%>
</td></tr>
<% End If %>


<tr>
<td valign="top" colspan=3>
<br>
<!-- INI DA 1º TABELA//-->
<table BORDER="0" CELLSPACING="0" CELLPADDING="5" style="border-collapse: collapse" bordercolor="#111111">
  <tr>
    <td width="295" valign="top">
	
	<% 'Produto 1 %>
 <form action="comprar.asp" method="post" name="comprar1">	
 <TABLE cellSpacing=2 cellPadding=0 width="100%" border=0>
                    <TBODY>
                    <TR>
                      <TD colSpan=2><FONT face="verdana, arial, helvetica" 
                        color=#000000 size=2><B><%=rs.fields("fabricante")%></B></FONT><BR><a href="produtos.asp?produto=<%=rs.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=rs.fields("nome")%></FONT></A><BR></TD></TR>
						<% If len(cstr(rs.fields("impeq")))<3 then impeq="img_nao_disp.gif" else impeq=rs.fields("impeq")  end if%>
                    <TR>
                      <TD><a href="produtos.asp?produto=<%=rs.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;"><IMG alt='<%=rs.fields("nome")%>' src="produtos/<%=impeq%>" border=0 ></A></TD>
                      <TD width="100%"><BR>
                      <FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=2><B><%= strlgmoeda & " " & precito1%><BR></B></FONT><BR>
                        
                        <% '***  Verifica se tem Estoque do Produto 1
						set rs_estoque1 = abredb.execute("SELECT estoque FROM estoque WHERE idproduto="&rs.fields("idprod")&" ;")
						if not rs_estoque1.eof then
						estoque_atual_1=rs_estoque1("estoque")
						end if
						rs_estoque1.close
						set rs_estoque1 = nothing
						 %>
                        
                        <font size="1" face="arial"><%=strLg28%> <%if estoque_atual_1 > 0 then response.write " " & strLg26 else response.write " <font color=red>" & strLg27 & "</font> " end if%></font>
                        <br><BR><br>
                        
                        <%if estoque_atual_1 > 0 then 
				response.write "<a href=""JavaScript: document.comprar1.submit();""><img src="&dirlingua&"/imagens/comprar_2.gif border=0 alt='"& strLg276 & "' onMouseOut=""window.status='';return true;"" onMouseOver=""window.status='"& strLg276 & "';return true;""></a>&nbsp;&nbsp;"
				end if%>                                  
                        <input type="hidden" name="intProdID" value="<%= intProdID1 %>">
                        <input type="hidden" name="intQuant" value="1">
                        <br>
                        <a href="produtos.asp?produto=<%=rs.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;">
                          <img src="<%=dirlingua%>/imagens/detalhes.gif" border="0"></a>
                        
                        <BR></TD></TR></TBODY>
					</form>
					</TABLE>
							

    
	</td>
    <td width="295" valign="top">
    
	<% 'Produto 2 %>

 <form action="comprar.asp" method="post" name="comprar2">	
 <TABLE cellSpacing=2 cellPadding=0 width="100%" border=0>
                    <TBODY>
                    <TR>
                      <TD colSpan=2><FONT face="verdana, arial, helvetica" 
                        color=#000000 size=2><B><%=rs2.fields("fabricante")%></B></FONT><BR><a href="produtos.asp?produto=<%=rs2.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=rs2.fields("nome")%></FONT></A><BR></TD></TR>
						<% If len(cstr(rs2.fields("impeq")))<3 then impeq="img_nao_disp.gif" else impeq=rs2.fields("impeq")  end if%>
                    <TR>
                      <TD><a href="produtos.asp?produto=<%=rs2.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;"><IMG alt='<%=rs2.fields("nome")%>' src="produtos/<%=impeq%>" border=0 ></A></TD>
                      <TD width="100%"><BR>
                      <FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=2><B><%= strlgmoeda & " " & precito2%><BR></B></FONT><BR>
                        
                        <% '***  Verifica se tem Estoque do Produto 2
						set rs_estoque2 = abredb.execute("SELECT estoque FROM estoque WHERE idproduto="&rs2.fields("idprod")&" ;")
						if not rs_estoque2.eof then
						estoque_atual_2=rs_estoque2("estoque")
						end if
						rs_estoque2.close
						set rs_estoque2 = nothing
						 %>
                        
                        <font size="1" face="arial"><%=strLg28%> <%if estoque_atual_2 > 0 then response.write " " & strLg26 else response.write " <font color=red>" & strLg27 & "</font> " end if%></font>
                        <br><BR><br>
                        
                        <%if estoque_atual_2 > 0 then 
				response.write "<a href=""JavaScript: document.comprar2.submit();""><img src="&dirlingua&"/imagens/comprar_2.gif border=0 alt='"& strLg276 & "' onMouseOut=""window.status='';return true;"" onMouseOver=""window.status='"& strLg276 & "';return true;""></a>&nbsp;&nbsp;"
				end if%>                                  
                        <input type="hidden" name="intProdID" value="<%= intProdID2 %>">
                        <input type="hidden" name="intQuant" value="1">
                        <br>
                        <a href="produtos.asp?produto=<%=rs2.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;">
                          <img src="<%=dirlingua%>/imagens/detalhes.gif" border="0"></a>
                        
                        <BR></TD></TR></TBODY>
					</form>
					</TABLE>
	</td>
  </tr>
</table>

<!-- FIM DA 1º TABELA//-->
<br><br>
<!-- INI DA 2º TABELA//-->
<table BORDER="0" CELLSPACING="0" CELLPADDING="5" style="border-collapse: collapse" bordercolor="#111111">
  <tr>
    <td width="295" valign="top">
	
	<% 'Produto 3 %>
 <form action="comprar.asp" method="post" name="comprar3">	
 <TABLE cellSpacing=2 cellPadding=0 width="100%" border=0>
                    <TBODY>
                    <TR>
                      <TD colSpan=2><FONT face="verdana, arial, helvetica" 
                        color=#000000 size=2><B><%=rs3.fields("fabricante")%></B></FONT><BR><a href="produtos.asp?produto=<%=rs3.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=rs3.fields("nome")%></FONT></A><BR></TD></TR>
						<% If len(cstr(rs3.fields("impeq")))<3 then impeq="img_nao_disp.gif" else impeq=rs3.fields("impeq")  end if%>
                    <TR>
                      <TD><a href="produtos.asp?produto=<%=rs3.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;"><IMG alt='<%=rs3.fields("nome")%>' src="produtos/<%=impeq%>" border=0 ></A></TD>
                      <TD width="100%"><BR>
                      <FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=2><B><%= strlgmoeda & " " & precito3%><BR></B></FONT><BR>
                        
                        <% '***  Verifica se tem Estoque do Produto 3
						set rs_estoque3 = abredb.execute("SELECT estoque FROM estoque WHERE idproduto="&rs3.fields("idprod")&" ;")
						if not rs_estoque3.eof then
						estoque_atual_3=rs_estoque3("estoque")
						end if
						rs_estoque3.close
						set rs_estoque3 = nothing
						 %>
                        
                        <font size="1" face="arial"><%=strLg28%> <%if estoque_atual_3 > 0 then response.write " " & strLg26 else response.write " <font color=red>" & strLg27 & "</font> " end if%></font>
                        <br><BR><br>
                        
                        <%if estoque_atual_3 > 0 then 
				response.write "<a href=""JavaScript: document.comprar3.submit();""><img src="&dirlingua&"/imagens/comprar_2.gif border=0 alt='"& strLg276 & "' onMouseOut=""window.status='';return true;"" onMouseOver=""window.status='"& strLg276 & "';return true;""></a>&nbsp;&nbsp;"
				end if%>                                  
                        <input type="hidden" name="intProdID" value="<%= intProdID3 %>">
                        <input type="hidden" name="intQuant" value="1">
                        <br>
                        <a href="produtos.asp?produto=<%=rs3.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;">
                          <img src="<%=dirlingua%>/imagens/detalhes.gif" border="0"></a>
                        
                        <BR></TD></TR></TBODY>
					</form>
					</TABLE>
							

    
	</td>
    <td width="295" valign="top">
    
	<% 'Produto 4 %>

 <form action="comprar.asp" method="post" name="comprar4">	
 <TABLE cellSpacing=2 cellPadding=0 width="100%" border=0>
                    <TBODY>
                    <TR>
                      <TD colSpan=2><FONT face="verdana, arial, helvetica" 
                        color=#000000 size=2><B><%=rs4.fields("fabricante")%></B></FONT><BR><a href="produtos.asp?produto=<%=rs4.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=rs4.fields("nome")%></FONT></A><BR></TD></TR>
						<% If len(cstr(rs4.fields("impeq")))<3 then impeq="img_nao_disp.gif" else impeq=rs4.fields("impeq")  end if%>
                    <TR>
                      <TD><a href="produtos.asp?produto=<%=rs4.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;"><IMG alt='<%=rs4.fields("nome")%>' src="produtos/<%=impeq%>" border=0 ></A></TD>
                      <TD width="100%"><BR>
                      <BR><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=2><B><%= strlgmoeda & " " & precito4%><BR></B></FONT><BR>
                        
                        <% '***  Verifica se tem Estoque do Produto 4
						set rs_estoque4 = abredb.execute("SELECT estoque FROM estoque WHERE idproduto="&rs4.fields("idprod")&" ;")
						if not rs_estoque4.eof then
						estoque_atual_4=rs_estoque4("estoque")
						end if
						rs_estoque4.close
						set rs_estoque4 = nothing
						 %>
                        
                        <font size="1" face="arial"><%=strLg28%> <%if estoque_atual_4 > 0 then response.write " " & strLg26 else response.write " <font color=red>" & strLg27 & "</font> " end if%></font>
                        <br><BR><br>
                        
                        <%if estoque_atual_4 > 0 then 
				response.write "<a href=""JavaScript: document.comprar4.submit();""><img src="&dirlingua&"/imagens/comprar_2.gif border=0 alt='"& strLg276 & "' onMouseOut=""window.status='';return true;"" onMouseOver=""window.status='"& strLg276 & "';return true;""></a>&nbsp;&nbsp;"
				end if%>                                  
                        <input type="hidden" name="intProdID" value="<%= intProdID4 %>">
                        <input type="hidden" name="intQuant" value="1">
                        <br>
                        <a href="produtos.asp?produto=<%=rs4.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;">
                          <img src="<%=dirlingua%>/imagens/detalhes.gif" border="0"></a>
                        
                        <BR></TD></TR></TBODY>
					</form>
					</TABLE>
	</td>
  </tr>
</table>

<!-- FIM DA 2º TABELA//-->
<br><br>
<!-- INI DA 3º TABELA//-->

<% If mostrar_produtos_fachada>5 then %>

<table BORDER="0" CELLSPACING="0" CELLPADDING="5" style="border-collapse: collapse" bordercolor="#111111">
  <tr>
    <td width="295" valign="top">
	
	<% 'Produto 5 %>
 <form action="comprar.asp" method="post" name="comprar5">	
 <TABLE cellSpacing=2 cellPadding=0 width="100%" border=0>
                    <TBODY>
                    <TR>
                      <TD colSpan=2><FONT face="verdana, arial, helvetica" 
                        color=#000000 size=2><B><%=rs5.fields("fabricante")%></B></FONT><BR><a href="produtos.asp?produto=<%=rs5.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=rs5.fields("nome")%></FONT></A><BR></TD></TR>
						<% If len(cstr(rs5.fields("impeq")))<3 then impeq="img_nao_disp.gif" else impeq=rs5.fields("impeq")  end if%>
                    <TR>
                      <TD><a href="produtos.asp?produto=<%=rs5.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;"><IMG alt='<%=rs5.fields("nome")%>' src="produtos/<%=impeq%>" border=0 ></A></TD>
                      <TD width="100%"><BR>
                      <FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=2><B><%= strlgmoeda & " " & precito5%><BR></B></FONT><BR>
                        
                        <% '***  Verifica se tem Estoque do Produto 5
						set rs_estoque5 = abredb.execute("SELECT estoque FROM estoque WHERE idproduto="&rs5.fields("idprod")&" ;")
						if not rs_estoque5.eof then
						estoque_atual_5=rs_estoque5("estoque")
						end if
						rs_estoque5.close
						set rs_estoque5 = nothing
						 %>
                        
                        <font size="1" face="arial"><%=strLg28%> <%if estoque_atual_5 > 0 then response.write " " & strLg26 else response.write " <font color=red>" & strLg27 & "</font> " end if%></font>
                        <br><BR><br>
                        
                        <%if estoque_atual_5 > 0 then 
				response.write "<a href=""JavaScript: document.comprar5.submit();""><img src="&dirlingua&"/imagens/comprar_2.gif border=0 alt='"& strLg276 & "' onMouseOut=""window.status='';return true;"" onMouseOver=""window.status='"& strLg276 & "';return true;""></a>&nbsp;&nbsp;"
				end if%>  
                        
                        
                        <input type="hidden" name="intProdID" value="<%= intProdID5 %>">
                        <input type="hidden" name="intQuant" value="1">
                        <br>
                        <a href="produtos.asp?produto=<%=rs5.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;">
                          <img src="<%=dirlingua%>/imagens/detalhes.gif" border="0"></a>
                        
                        <BR></TD></TR></TBODY>
					</form>
					</TABLE>
							

    
	</td>
    <td width="295" valign="top">
    
	<% 'Produto 6 %>

 <form action="comprar.asp" method="post" name="comprar6">	
 <TABLE cellSpacing=2 cellPadding=0 width="100%" border=0>
                    <TBODY>
                    <TR>
                      <TD colSpan=2><FONT face="verdana, arial, helvetica" 
                        color=#000000 size=2><B><%=rs6.fields("fabricante")%></B></FONT><BR><a href="produtos.asp?produto=<%=rs6.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=rs6.fields("nome")%></FONT></A><BR></TD></TR>
						<% If len(cstr(rs6.fields("impeq")))<3 then impeq="img_nao_disp.gif" else impeq=rs6.fields("impeq")  end if%>
                    <TR>
                      <TD><a href="produtos.asp?produto=<%=rs6.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;"><IMG alt='<%=rs6.fields("nome")%>' src="produtos/<%=impeq%>" border=0 ></A></TD>
                      <TD width="100%"><BR>
                      <FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=2><B><%= strlgmoeda & " " & precito6%><BR></B></FONT><BR>
                        
                        <% '***  Verifica se tem Estoque do Produto 6
						set rs_estoque6 = abredb.execute("SELECT estoque FROM estoque WHERE idproduto="&rs6.fields("idprod")&" ;")
						if not rs_estoque6.eof then
						estoque_atual_6=rs_estoque6("estoque")
						end if
						rs_estoque6.close
						set rs_estoque6 = nothing
						 %>
                        
                        <font size="1" face="arial"><%=strLg28%> <%if estoque_atual_6 > 0 then response.write " " & strLg26 else response.write " <font color=red>" & strLg27 & "</font> " end if%></font>
                        <br><BR><br>
                        
                        <%if estoque_atual_6 > 0 then 
				response.write "<a href=""JavaScript: document.comprar6.submit();""><img src="&dirlingua&"/imagens/comprar_2.gif border=0 alt='"& strLg276 & "' onMouseOut=""window.status='';return true;"" onMouseOver=""window.status='"& strLg276 & "';return true;""></a>&nbsp;&nbsp;"
				end if%>                                  
                        <input type="hidden" name="intProdID" value="<%= intProdID6 %>">
                        <input type="hidden" name="intQuant" value="1">
                        <br>
                        <a href="produtos.asp?produto=<%=rs6.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;">
                          <img src="<%=dirlingua%>/imagens/detalhes.gif" border="0"></a>
                        
                        <BR></TD></TR></TBODY>
					</form>
					</TABLE>
	</td>
  </tr>
</table>
<% End If %>

<!-- FIM DA 3º TABELA//-->
<br><br>
<!-- INI DA 4º TABELA//-->

<% If mostrar_produtos_fachada>7 then %>

<table BORDER="0" CELLSPACING="0" CELLPADDING="5" style="border-collapse: collapse" bordercolor="#111111">
  <tr>
    <td width="295" valign="top">
	
	<% 'Produto 7 %>
 <form action="comprar.asp" method="post" name="comprar7">	
 <TABLE cellSpacing=2 cellPadding=0 width="100%" border=0>
                    <TBODY>
                    <TR>
                      <TD colSpan=2><FONT face="verdana, arial, helvetica" 
                        color=#000000 size=2><B><%=rs7.fields("fabricante")%></B></FONT><BR><a href="produtos.asp?produto=<%=rs7.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=rs7.fields("nome")%></FONT></A><BR></TD></TR>
						<% If len(cstr(rs7.fields("impeq")))<3 then impeq="img_nao_disp.gif" else impeq=rs7.fields("impeq")  end if%>
                    <TR>
                      <TD><a href="produtos.asp?produto=<%=rs7.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;"><IMG alt='<%=rs7.fields("nome")%>' src="produtos/<%=impeq%>" border=0 ></A></TD>
                      <TD width="100%"><BR>
                      <BR><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=2><B><%= strlgmoeda & " " & precito7%><BR></B></FONT><BR>
                        
                        <% '***  Verifica se tem Estoque do Produto 7
						set rs_estoque7 = abredb.execute("SELECT estoque FROM estoque WHERE idproduto="&rs7.fields("idprod")&" ;")
						if not rs_estoque7.eof then
						estoque_atual_7=rs_estoque7("estoque")
						end if
						rs_estoque7.close
						set rs_estoque7 = nothing
						 %>
                        
                        <font size="1" face="arial"><%=strLg28%> <%if estoque_atual_7 > 0 then response.write " " & strLg26 else response.write " <font color=red>" & strLg27 & "</font> " end if%></font>
                        <br><BR><br>
                        
                        <%if estoque_atual_7 > 0 then 
				response.write "<a href=""JavaScript: document.comprar7.submit();""><img src="&dirlingua&"/imagens/comprar_2.gif border=0 alt='"& strLg276 & "' onMouseOut=""window.status='';return true;"" onMouseOver=""window.status='"& strLg276 & "';return true;""></a>&nbsp;&nbsp;"
				end if%>  
                        
                        
                        <input type="hidden" name="intProdID" value="<%= intProdID7 %>">
                        <input type="hidden" name="intQuant" value="1">
                        <br>
                        <a href="produtos.asp?produto=<%=rs7.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;">
                          <img src="<%=dirlingua%>/imagens/detalhes.gif" border="0"></a>
                        
                        <BR></TD></TR></TBODY>
					</form>
					</TABLE>
							

    
	</td>
    <td width="295" valign="top">
    
	<% 'Produto 8 %>

 <form action="comprar.asp" method="post" name="comprar8">	
 <TABLE cellSpacing=2 cellPadding=0 width="100%" border=0>
                    <TBODY>
                    <TR>
                      <TD colSpan=2><FONT face="verdana, arial, helvetica" 
                        color=#000000 size=2><B><%=rs8.fields("fabricante")%></B></FONT><BR><a href="produtos.asp?produto=<%=rs8.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=rs8.fields("nome")%></FONT></A><BR></TD></TR>
						<% If len(cstr(rs8.fields("impeq")))<3 then impeq="img_nao_disp.gif" else impeq=rs8.fields("impeq")  end if%>
                    <TR>
                      <TD><a href="produtos.asp?produto=<%=rs8.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;"><IMG alt='<%=rs8.fields("nome")%>' src="produtos/<%=impeq%>" border=0 ></A></TD>
                      <TD width="100%"><BR>
                      <BR><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=2><B><%= strlgmoeda & " " & precito8%><BR></B></FONT><BR>
                        
                        <% '***  Verifica se tem Estoque do Produto 8
						set rs_estoque8 = abredb.execute("SELECT estoque FROM estoque WHERE idproduto="&rs8.fields("idprod")&" ;")
						if not rs_estoque8.eof then
						estoque_atual_8=rs_estoque8("estoque")
						end if
						rs_estoque8.close
						set rs_estoque8 = nothing
						 %>
                        
                        <font size="1" face="arial"><%=strLg28%> <%if estoque_atual_8 > 0 then response.write " " & strLg26 else response.write " <font color=red>" & strLg27 & "</font> " end if%></font>
                        <br><BR><br>
                        
                        <%if estoque_atual_8 > 0 then 
				response.write "<a href=""JavaScript: document.comprar8.submit();""><img src="&dirlingua&"/imagens/comprar_2.gif border=0 alt='"& strLg276 & "' onMouseOut=""window.status='';return true;"" onMouseOver=""window.status='"& strLg276 & "';return true;""></a>&nbsp;&nbsp;"
				end if%>                                  
                        <input type="hidden" name="intProdID" value="<%= intProdID8 %>">
                        <input type="hidden" name="intQuant" value="1">
                        <br>
                        <a href="produtos.asp?produto=<%=rs8.fields("idprod")%>" onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style <%=fontebranca%>";text-decoration:none;">
                          <img src="<%=dirlingua%>/imagens/detalhes.gif" border="0"></a>
                        
                        <BR></TD></TR></TBODY>
					</form>
					</TABLE>
	</td>
  </tr>
</table>

<% End If %>

<!-- FIM DA 4º TABELA//-->

<br>

</td>
</tr>
<!-- <tr>
<td colspan="4">
<img src="<%=dirlingua%>/imagens/ofertasbaixo.gif" border="0"></td></tr> -->
<%
'Fecha as tabelas
rs.close
set rs=nothing
rs2.close
set rs2=nothing
rs3.close
set rs3=nothing
rs4.close
set rs4=nothing
rs5.close
set rs5=nothing
rs6.close
set rs6=nothing
rs7.close
set rs7=nothing
rs8.close
set rs8=nothing
%>















