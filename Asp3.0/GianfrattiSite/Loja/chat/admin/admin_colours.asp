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
										&nbsp;&nbsp;&nbsp;Esquema de Cores
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
											<form action="admin_change.asp?addpass=<% Response.write Request.querystring("addpass")%>&function=COLO" method="post">
												<td class="main" valign="top" align="center">
													<table  width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="35%">
																<img src="images/paint.gif">
															</td>
															<td >
																<select name="colour">
<option value="Red" <%IF strColourScheme = "Red" THEN Response.write ("selected")%>>Vermelho
<option value="Green" <%IF strColourScheme = "Green" THEN Response.write ("selected")%>>Verde
<option value="Blue" <%IF strColourScheme = "Blue" THEN Response.write ("selected")%>>Azul
<option value="Yellow" <%IF strColourScheme = "Yellow" THEN Response.write ("selected")%>>Amarelo
<option value="White" <%IF strColourScheme = "White" THEN Response.write ("selected")%>>Branco
</select>
																<BR>
																<input type="submit" value="Mudar" class="button">
															</td></form>
														</tr>
													</table>
													<BR>
Selecione a cor que será usado no sistema do seu chat.  Recomenda-se usar cores semelhante ou próxima das cores já mais usadas no seu site!  Você também pode <a href="../colour/how to make your own colour scheme.txt" target="_blank" class="bluelink">criar o seu esquema de cores</a>
<BR>
<BR>
<center>
<b>Esquema de Cores</b>
<table  width="40%" border="0" cellspacing="0" cellpadding="0">
	<tr><form action="admin_change.asp?addpass=<% Response.write Request.querystring("addpass")%>&function=style" method="post">
		<td class="main" align="right" valign="top">
			Cor de Cabeçalho / Títulos: <input type="text" name="HColour" size="8" maxlength="7" value="<%=strHeaderColour%>" class="textbox"><BR>
			Cor Textos : <input type="text" name="TColour" size="8" maxlength="7" value="<%=strMainTextColour%>" class="textbox"><BR>
			Cor de Link : <input type="text" name="LColour" size="8" maxlength="7" value="<%=strLinkColour%>" class="textbox"><BR>
			Cor de Saídas : <input type="text" name="EColour" size="8" maxlength="7" value="<%=strExitColour%>" class="textbox"><BR>
			Fonte : <input type="text" name="Font" size="8" maxlength="20" value="<%=strFontFace%>" class="textbox"><BR>
<input type="submit" value="Atualizar" class="button">
		</td>										</form>
<Td valign="top">
<table  width="10" border="0" cellspacing="1" cellpadding="0">
	<tr>
		<td >
<table  width="10" height="10" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
	<tr>
		<td bgcolor="<%=strHeaderColour%>">
		</td>
	</tr>
</table>
<table height="9 " border="0" cellspacing="0" cellpadding="0">	<tr>
	</tr>
	<tr>
		<td >
		</td>
	</tr>
</table>

		</td>
	</tr>
	<tr>
		<td >
<table  width="10" height="10" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
	<tr>
		<td bgcolor="<%=strMainTextColour%>">
		</td>
	</tr>
</table>
<table height="9" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td >
		</td>
	</tr>
</table>
		</td>
	</tr>
	<tr>
		<td >
<table  width="10" height="10" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
	<tr>
		<td bgcolor="<%=strLinkColour%>">
		</td>
	</tr>
</table>
<table height="10" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td >
		</td>
	</tr>
</table>
<table  width="10" height="10" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
	<tr>
		<td bgcolor="<%=strExitColour%>">
		</td>
	</tr>
</table>
<table height="9" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td >
		</td>
	</tr>
</table>
		</td>
	</tr>
	<tr>
		<td class="main">
			<font face="<%=strFontFace%>">&nbsp;Text</font>
		</td>
	</tr>
</table>

</td>
</form>
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
