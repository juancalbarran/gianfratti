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
		<Center>
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" height="8">
				<tr>
					<td >
					</td>
				</tr>
			</table>
			<table border="0" cellspacing="0" cellpadding="0" width="90%">
				<tr>
					<td>
						<table  border="0" cellspacing="0" cellpadding="0" height="15">
							<tr>
								<td bgcolor="#000000" width="15"><img src="<%=strDBpathCorrection%><%=img_top_left_curve%>"></td>
								<td bgcolor="#000000" width="100%" class="header">
									<B>
										&nbsp;&nbsp;&nbsp;Status do Chat de Atendimento Online no site
									</B>
								</td>
								<td bgcolor="#000000" width="15"><img src="<%=strDBpathCorrection%><%=img_top_right_curve%>	"></td>
							</tr>
						</table>
						<table  width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
							<tr>
								<td bgcolor="#ffffff">
									<table  width="100%" border="0" cellspacing="0" cellpadding="2">
										<tr>
											<form name="form1" method="post" action="admin_change.asp?addpass=<% Response.write Request.querystring("addpass")%>&function=<% IF intOnline = "5" THEN Response.write("Soff") ELSE Response.write("Son") END IF%>">
												<td class="main" valign="top" align="center">
													<table  width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="40%">
																<img src="images/cube.gif">
															</td>
		<td><input name="mode" type="submit" id="mode" value="Mudar Status" class="button"></td>
														</tr>
													</table><BR>
Atendimento Online está <b><% IF intOnline = "5" THEN Response.write("<font color=#008000>Ativo</font>") ELSE Response.write("<font color=#FF0000>Inativo</font>") END IF%></b> para o público<BR><br>
O Status do Chat, se Ativo, mostrará a imagem de "Atendimento Online" em todas o seu site, ou caso contrário, mostrará a imagem de "Atendimento Offline" ou não exibirá nenhuma imagem (conforme a sua programação no código da pagina).  Ë muito importante que você deixe como <strong>Inativo</strong> quando não há ninguem "online" na Tela de Administração do Chat.<BR><BR>
												</center>
											</td>
										</form>
									</tr>
								</table>
							</td>
						</tr>
					</table>					
					<table  border="0" cellspacing="0" cellpadding="0" height="15">
						<tr>
							<td bgcolor="#000000" width="15"><img src="<%=strDBpathCorrection%><%=img_bottom_left_curve%>"></td>
							<td bgcolor="#000000" width="100%" >
							</td>
							<td bgcolor="#000000" width="15"><img src="<%=strDBpathCorrection%><%=img_bottom_right_curve%>"></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<table  width="100%" border="0" cellspacing="0" cellpadding="0" height="8">
			<tr>
				<td >
				</td>
			</tr>
		</table>
	</center>
</body>
</html>
