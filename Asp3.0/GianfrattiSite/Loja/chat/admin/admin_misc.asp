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
										&nbsp;&nbsp;&nbsp;Opções Gerais
									</B>
								</td>
								<td bgcolor="#000000" width="15"><img src="<%=strDBpathCorrection%><%=img_top_right_curve%>"></td>
							</tr>
						</table>
						<table  width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
							<tr>
								<td bgcolor="#ffffff">
									<table  width="100%" border="0" cellspacing="0" cellpadding="2">
										<tr>
												<td class="main" valign="top" align="center">
													<table  width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="0%">
																<img src="images/misc.gif">
															</td>
															<td class="main" valign="top">Você pode escolher algumas opções abaixo para o seu sistema de chat.  Visite o site <a href="http://www.iaxx.com" target="_blank" class="bluelink">iAXX</a> para upgrades
															</td>
														</tr>
													</table>
<center>
<table  width="80%" border="0" cellspacing="0" cellpadding="0">
	<tr><form action="admin_change.asp?addpass=<% Response.write Request.querystring("addpass")%>&function=AUTOR" method="post">
		<td align="right" class="main" nowrap>
		&nbsp;	Atualizar lista de Visitantes a cada 10 segundos? <select name="AutoRefresh" class="button">
<option value="Yes" <%IF strAdminAutoRefresh = "Yes" THEN RESPONSE.WRITE("Selected")%>>Sim
<option value="No" <%IF strAdminAutoRefresh <> "Yes" THEN RESPONSE.WRITE("Selected")%>>Não
</select> &nbsp; <input type="submit" value="Atualizar" class="button">
		</td></form>
	</tr>
</table>
<table  width="80%" border="0" cellspacing="0" cellpadding="0">
	<tr><form action="admin_change.asp?addpass=<% Response.write Request.querystring("addpass")%>&function=AUTOP" method="post">
		<td align="right" class="main" nowrap>
		Abrir uma nova janela de chat quando o visitante está aguardando o Atendimento? <select name="AutoPopup" class="button">
<option value="Yes" <%IF strAdminAutoPopup = "Yes" THEN RESPONSE.WRITE("Selected")%>>Sim
<option value="No" <%IF strAdminAutoPopup <> "Yes" THEN RESPONSE.WRITE("Selected")%>>Não
</select> &nbsp; <input type="submit" value="Atualizar" class="button">&nbsp;
		</td></form>
	</tr>
</table>
<table  width="80%" border="0" cellspacing="0" cellpadding="0">
	<tr><form action="admin_change.asp?addpass=<% Response.write Request.querystring("addpass")%>&function=RERAT" method="post">
		<td align="right" class="main" nowrap>
		&nbsp; Atualizar a janela de conversa a cada  <input type="text" name="RefreshRate" size="5" maxlength="2" value="<%=intRefreshRate%>" class="textbox"> segundos &nbsp;&nbsp;&nbsp; <input type="submit" value="Atualizar" class="button">
		</td></form>
	</tr>
</table>
												</center>
											</td>
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
