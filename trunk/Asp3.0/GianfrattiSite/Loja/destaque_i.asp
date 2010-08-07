<table width="550"  border="0" cellpadding="5" cellspacing="5">
  <tr>
    <td><% If mostrar_produto_destaque_fachada="Sim" and intProdID9<>"" then %>
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
					<td width=500 align="center" height=180><a href="produtos.asp?produto=<%=rs9.fields("idprod")%>"  onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style="color:"<%=fontebranca%>";text-decoration:none;"><img src="produtos/<%=imgra%>" width="150" border="0"></a></td>
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
</td>
  </tr>
</table>
