<!-- #include file="df.asp" -->
<html>
<head>
<title>Carregando...</title>
<style>
body
{
	margin:0px;
}
</style>
<script>
self.moveTo((screen.width-200)/2, (screen.height-200)/2);
function doTitle()
{
	document.title="Produto em Oferta!!!";
}
</script>
</head>
<body scroll="no" onload="doTitle();self.focus()">
<a href=javascript:window.close()><%
'Função para chamar os produtos aleatoreamente na vitime inicial
set rs = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and estoque <> 'n' and impeq <> '';")
if rs.eof or rs.bof then
rs.close
set rs = nothing
set atualizar = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok';")
set rs = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and estoque <> 'n' and impeq <> '';")
if rs.eof or rs.bof then
rs.close
set rs = nothing
set atualizar = abredb.Execute("UPDATE produtos SET status = 'nao' WHERE status = 'ok';")
set rs = abredb.execute("SELECT * FROM produtos WHERE status <> 'ok' and estoque <> 'n' and impeq <> '' ;")
end if
else
set atualizar = abredb.Execute("UPDATE produtos SET status = 'ok' WHERE idprod = "&rs("idprod")&";")
end if
intProdID1 = rs("idprod")
'Formatação dos preços dos produtos
precito1 = formatNumber(rs("preco"), 2)%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="0">
<tr><td bgcolor=#bfbfbf>
             <form action="comprar.asp" method="post" name="comprar1">
		 	  <table BORDER="0" CELLSPACING="1" CELLPADDING="3"><tr><td bgcolor=#ffffff>		 
				  <table align=center width=280 cellspacing="1" cellpadding="1">
				  
				  <% If rs.fields("impeq")="" then impeq="img_nao_disp.gif" else impeq=rs.fields("impeq")  end if%>
				  <tr>
				  <td width=80 height=130><img src="produtos/<%=impeq%>" border="0">
				  </td>
				  <td valign=center width=200>
				  <font style=font-size:11px;font-family:<%=fonte%>><b><font color=000000><%=rs.fields("nome")%></b><br><br><b><%=strLg29%></b>&nbsp;<%= strlgmoeda & " " & precito1%><br><b><%=strLg28%></b>

						<% '***  Verifica se tem Estoque do Produto
						set rs_estoque = abredb.execute("SELECT estoque FROM estoque WHERE idproduto="&intProdID1&" ;")
						if not rs_estoque.eof then
						estoque_atual=rs_estoque("estoque")
						end if
						rs_estoque.close
						set rs_estoque = nothing
						 %>

						 
<%if estoque_atual > 0 then response.write " " & strLg26 else response.write " " & strLg27 end if%><div align=right><br><input type="hidden" name="intProdID" value="<%= intProdID1 %>"><input type="hidden" name="intQuant" value=1>
				  &nbsp;&nbsp;<a href="javascript:window.opener.location='produtos.asp?produto=<%=rs.fields("idprod")%>';window.close()"  onMouseOut="window.status='';return true;" onMouseOver="window.status='+ Detalhes';return true;" style="color:#FFFFFF;text-decoration:none;">
				  <img src=<%=dirlingua%>/imagens/detalhes.gif border="0">
				  </a></div></td></form></tr>
		        </table>
		  </table>
	  </table>
<%
'Fecha as tabelas
rs.close
set rs=nothing
%>
</body>
</html>