<!--#include file="common.asp" -->
<!--#include file="check.asp" -->
<%
Dim strQ
strQ = Request.querystring("Q")
IF strQ = "1" THEN strQ = strTxtAdminRequest ELSE strQ = "" END IF
%>
<%
'Set some variables
Dim rsChatRequest2 'Chat request record sheet

'Open a new connection to the database
adoCon.Open cString

'Create new SQL string
StrSQL="SELECT * FROM tblActiveUsers WHERE IP='" & strIPAddress & "';"

'Create new record sheet
set rsChatRequest2	=Server.CreateObject("ADODB.Recordset")

'Set cursor and locktypes
rsChatRequest2.CursorType = 2
rsChatRequest2.LockType = 3

'Open row data where the logged in users IP equals the IP in the database
rsChatRequest2.open StrSQL, CString

'Set
rsChatRequest2.fields("ChatRequest")=0

rsChatRequest2.Update

'Close record sheet and clean up
rsChatRequest2.Close
Set rsChatRequest2 = Nothing
%>

<%
	'Redirect the administrator if the password in query string matches the one in the database
	IF strAdminPass	 = QstrAdminPass THEN Response.redirect("chat.asp?addpass="&strAdminPass&"&ID="&intUsrID)
%>
<html>
	<head>
		<title>
			<%=strCompanyName%> <%=strTxtLiveSupport %>
		</title>
		<!--#include file="style/style.asp" -->
	</head>
	<body background="<%=img_bg%>" style="margin: 0" topmargin="0" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0">
		<Center>
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" height="45">
				<tr>
					<td>
					</td>
				</tr>
			</table>
			<table  width="300" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><img src="<%=img_top_left_curve%>"></td>
					<td class="header" align="center" bgcolor="#000000" width="100%">
						<b><%=strCompanyName%></b>
					</td>
					<td><img src="<%=img_top_right_curve%>"></td>
				</tr>
			</table>
			<table  width="300" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center">
						<table  width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
							<tr>
								<td bgcolor="#ffffff" align="center">
									<table  width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td align="center">	
												<table  width="100%" border="0" cellspacing="2" cellpadding="0">
													<tr>
														<td>
															<table  width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
																<tr>
																	<td bgcolor="<%=img_bg_colour%>" <% IF strColourScheme <> "white" THEN Response.write("class=header")%> align="center">
																		<b>
																			 <% IF strColourScheme="white" THEN%><font color="#808080"><%ELSE%><%END IF%><%=strTxtLogin%>
																		</b>
																	</td>
																</tr>
																<tr>
																	<td bgcolor="#ffffff" class="main" align="center"><font color="#008040"><b><%=strQ%></b></font>
																		<table  width="100%" border="0" cellspacing="0" cellpadding="2">
																			<tr>
																				<td class="main" align="center">
																					<BR>
																					<form action="chat_sort.asp" method="post">
																						<input type="text" name="login" size="10" class="textbox">
																						<input type="submit" value="<%=strTxtEnter%>" class="button">
																					</form>
																					<b>
																						<%=strOperatorName%>
																					</b>
																					<%=strTxtWelcome%>
																			 		<BR>
																					<BR>																					
																				</td>
																			</tr>
																		</table>																		
																	</tr>
																</table>
															</td>
														</tr>
													</table>					
												</td>
											</tr>
										</table>										
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<table  width="300" border="0" cellspacing="0" cellpadding="0" height="15">
					<tr>
						<td width="15"><img src="<%=img_bottom_left_curve%>" width="15" height="15"></td>
						<td class="header" align="center" bgcolor="#000000">
							&copy; <a href="http://www.iaxx.com" class="whitelink" target="_blank">iaxx.com</a> 2002 onwards
						</td>
						<td width="15"><img src="<%=img_bottom_right_curve%>" width="15" height="15"></td>
					</tr>
					<tr>
						<td>
						</td>
					</tr>
				</table>
			</center>
		</body>
	</html>
	
	
