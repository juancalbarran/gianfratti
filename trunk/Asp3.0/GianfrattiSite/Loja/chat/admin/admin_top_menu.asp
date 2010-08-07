<%
Dim strDBpathCorrection					'Variable to hold database path correction
strDBpathCorrection = "../"
%>
<!--#include file="../common.asp" -->
<!--#include file="check_admin.asp" -->
<html>
<head>
<!--#include file="../style/style.asp" -->
</head>
<body style="margin: 0" topmargin="0" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0" background="<%=strDBpathCorrection%><%=img_bg%>">
<table  width="100%" border="0" cellspacing="2" cellpadding="0">
	<tr>

		<td width="10%">
			<table  width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
	<tr>
		<td bgcolor="#c0c0c0" class="footer" onmouseover="this.style.backgroundColor='#ffffff'; this.style.cursor= 'hand';" onmouseout="this.style.backgroundColor='#c0c0c0';" align="center"><img src="images/op.gif"></td>
	</tr><Tr><Td bgcolor="#ffffff" class="main" align="center"><a href="admin_operators.asp?addpass=<%=addpass%>" target="main" class="bluelink">Operadores</a></td></tr>
</table>
		</td>
		<td width="10%">
			<table  width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
	<tr>
		<td bgcolor="#c0c0c0" class="footer" onmouseover="this.style.backgroundColor='#ffffff'; this.style.cursor= 'hand';" onmouseout="this.style.backgroundColor='#c0c0c0';" align="center"><img src="images/Cube.gif"></td>
	</tr><Tr><Td bgcolor="#ffffff" class="main" align="center"><a href="admin_status.asp?addpass=<%=addpass%>" target="main" class="bluelink">Status</a></td></tr>
</table>
		</td>
		
		<td width="10%">
			<table  width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
	<tr>
		<td bgcolor="#c0c0c0" class="footer" onmouseover="this.style.backgroundColor='#ffffff'; this.style.cursor= 'hand';" onmouseout="this.style.backgroundColor='#c0c0c0';" align="center"><img src="images/ppl.gif"></td>
	</tr><Tr><Td bgcolor="#ffffff" class="main" align="center"><a href="admin_visitors.asp?addpass=<%=addpass%>" target="main" class="bluelink">Visitantes</a></td></tr>
</table>
		</td>
		<td width="10%">
			<table  width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
	<tr>
		<td bgcolor="#c0c0c0" class="footer" onmouseover="this.style.backgroundColor='#ffffff'; this.style.cursor= 'hand';" onmouseout="this.style.backgroundColor='#c0c0c0';" align="center"><img src="images/house.gif"></td>
	</tr><Tr><Td bgcolor="#ffffff" class="main" align="center"><a href="admin_company.asp?addpass=<%=addpass%>" target="main" class="bluelink">Empresa</a></td></tr>
</table>
		</td>
		<td width="10%">
			<table  width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
	<tr>
		<td bgcolor="#c0c0c0" class="footer" onmouseover="this.style.backgroundColor='#ffffff'; this.style.cursor= 'hand';" onmouseout="this.style.backgroundColor='#c0c0c0';" align="center"><img src="images/pass.gif"></td>
	</tr><Tr><Td bgcolor="#ffffff" class="main" align="center"><a href="admin_password.asp?addpass=<%=addpass%>" target="main" class="bluelink">Senha</a></td></tr>
</table>
		</td>
		<td width="10%">
			<table  width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
	<tr>
		<td bgcolor="#c0c0c0" class="footer" onmouseover="this.style.backgroundColor='#ffffff'; this.style.cursor= 'hand';" onmouseout="this.style.backgroundColor='#c0c0c0';" align="center"><img src="images/paint.gif"></td>
	</tr><Tr><Td bgcolor="#ffffff" class="main" align="center"><a href="admin_colours.asp?addpass=<%=addpass%>" target="main" class="bluelink">Cores</a></td></tr>
</table>
		</td>
		<td width="10%">
			<table  width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
	<tr>
		<td bgcolor="#c0c0c0" class="footer" onmouseover="this.style.backgroundColor='#ffffff'; this.style.cursor= 'hand';" onmouseout="this.style.backgroundColor='#c0c0c0';" align="center"><img src="images/misc.gif"></td>
	</tr><Tr><Td bgcolor="#ffffff" class="main" align="center"><a href="admin_misc.asp?addpass=<%=addpass%>" target="main" class="bluelink">Opções</a></td></tr>
</table>
		</td>
		<td width="10%">
			<table  width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
	<tr>
		<td bgcolor="#c0c0c0" class="footer" onmouseover="this.style.backgroundColor='#ffffff'; this.style.cursor= 'hand';" onmouseout="this.style.backgroundColor='#c0c0c0';" align="center"><img src="images/bar.gif"></td>
	</tr><Tr><Td bgcolor="#ffffff" class="main" align="center"><a href="admin_stats.asp?addpass=<%=addpass%>" target="main" class="bluelink">Estatísticas</a></td></tr>
</table>
		</td>
		<td width="10%">
			<table  width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
	<tr>
		<td bgcolor="#c0c0c0" class="footer" onmouseover="this.style.backgroundColor='#ffffff'; this.style.cursor= 'hand';" onmouseout="this.style.backgroundColor='#c0c0c0';" align="center"><img src="images/badbook.gif"></td>
	</tr><Tr><Td bgcolor="#ffffff" class="main" align="center"><a class="bluelink" href="admin_badwords.asp?addpass=<%=addpass%>" target="main">Dicionário</a></td></tr>
</table>
		</td>		
		<td width="10%">
			<table  width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
	<tr>
		<td bgcolor="#c0c0c0" class="footer" onmouseover="this.style.backgroundColor='#ffffff'; this.style.cursor= 'hand';" onmouseout="this.style.backgroundColor='#c0c0c0';" align="center"><img src="images/book.gif"></td>
	</tr><Tr><Td bgcolor="#ffffff" class="main" align="center"><a href="admin_history.asp?addpass=<%=addpass%>" target="main" class="bluelink">Historico</a></td></tr>
</table>
		</td>
	</tr>
</table>
</body>
</html>