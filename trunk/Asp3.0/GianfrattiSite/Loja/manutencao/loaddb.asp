<!-- #include file="includetop.asp" -->
<%if session("nome") = "" or session("nome")= false then
response.redirect "../administrador.asp"
end if

Session("dbPath") = Request.Form("server") & Request.Form("dbPath")
Session("dbUser") = Request.Form("dbUser")
Session("dbPassword") = Request.Form("dbPassword")
If IsBlank(Session("dbPath")) = False Then
	Response.Redirect "index.asp"
Else
%>
	<!-- EDITOR MDB -->
	<!-- Do Not remove These Headers -->
	<html>
		<head>
			<title>Acesso - EDITOR</title>
			
			
		<link rel="stylesheet" type="text/css" href="extern/style.css">
		<script src="extern/jscript.js" type="text/javascript"></script>
		<script language= "JavaScript">
		<!--Break out of frames
			if (top.frames.length!=0)
			top.location=self.document.location;
			//-->
		</script>
		</head>
	
		<body>
		<br><br><br>
		<table id="table1" cellpadding="5" cellspacing="0" border="0" align="center" width="450">
			<tr>
				<td>
					<table id="tdrow2" cellpadding="4" cellspacing="1" border="0" width="100%">
						<tr>
							<td id="tdrow1" colspan="1">
								<font size="1"><b>Entre com o caminho:</b></font>
							</td>
						</tr>
						<tr id="detail">
							<td align="center" nowrap>
								<p>Verifique o caminho correto do banco de dados.</p>
								<form action="loaddb.asp" method="post" id=form1 name=form1>
								<table width="80%" id="tdrow2" cellpadding="0" cellspacing="1" border="0">
									<tr>
										<td align="left" colspan="2">
										<b>Database Path</b> - 
										<a href="javascript:openwindow('selectdb.asp', '250', '400', '250', '25');">
										Database List
										</a>
										</td>
									<tr>
									<tr>
										<td align="left" colspan="2">
										<input type="checkbox" name="server" value="<%= Server.MapPath("\") %>\">
										<i><%= Server.MapPath("\") %>\</i><input id="textinput" type="text" name="dbPath">
										<br><br>
										</td>
									</tr>
									<tr>
										<td align="left" colspan="2">
										<b>Usuário</b> (pode ficar em branco)
										</td>
									</tr>
									<tr>
										<td align="left" colspan="2">
										<input type="text" id="textinput" name="dbUser">
										<br><br>
										</td>
									</tr>
									<tr>
										<td align="left" colspan="2">
										<b>Senha</b> (Pode ficar em branco)
										</td>
									</tr>
									<tr>
										<td align="left" colspan="2">
										<input type="password" id="textinput" name="dbPassword">
										</td>
									</tr>
									<tr>
										<td align="center">
										<input id="button" type="submit" name="submit" value="Abrir base de dados">
										</td>
										<td align="center">
										<input id="button" type="button" name="createdb" value="Criar um novo banco de dados" OnClick="javascript:document.location = 'createdb.asp'">
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td></form>
			</tr>
		</table>
		
		</body>
	</html>

<%
End If
%>

		
