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
										&nbsp;&nbsp;&nbsp;Nome do Operador
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
											<form action="admin_change.asp?addpass=<% Response.write Request.querystring("addpass")%>&function=OP" method="post">
												<td class="main" valign="top" align="center">
													<table  width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="35%">
																<img src="images/op.gif">
															</td>
															<td >
																<input type="text" name="opname" size="40" maxlength="80" value="<%=strOperatorName%>" class="textbox">
																<BR>
																<input type="submit" value="Atualizar" class="button">
															</td>
														</tr>
													</table>
													<BR>
													Digite o novo nome do operador no campo acima e clique em Atualizar. O nome do novo operador será atualizado automaticamente.<BR><BR>
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
