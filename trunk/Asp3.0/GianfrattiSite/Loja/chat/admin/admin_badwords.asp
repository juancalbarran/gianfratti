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
										&nbsp;&nbsp;&nbsp;Dicionário de Palavras Proibidas									</B>
								</td>
								<td bgcolor="#000000" width="15"><img src="<%=strDBpathCorrection%><%=img_top_right_curve%>	"></td>
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
																<img src="images/badbook.gif">
															</td>
		<td class="main">Esta página mostra a lista das palavras proibidas nas conversas de chat, que caso seja digitada, elas serão substituídas por outras. É importante que você crie este dicionário, ou seja, este "filtro" de palavras proibidas para que não haja ofensas com palavras de ataque pessoal durante quaisquer conversas e que sejam digitadas por visitantes mal intencionados. Procure deixar sempre atualizado esta lista abaixo, a medida que surjam outras palavras</td>
														</tr>
													</table><BR>
       <table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000" height="14">
        <tr> 
         <td bgcolor="#c0c0c0" width="40%" class="main" align="center"><b>Palavra proibida</td>
         <td bgcolor="#c0c0c0" width="40%" class="main" align="center"><b>Substituir por</td>
         <td bgcolor="#c0c0c0" width="20%" class="main" align="center"><b>Deletar</td>
        </tr>

<%
Dim rsBadWords		'Record sheet for user details
Dim badcount		'Holds number of users browsing
Dim intBadWordID		'Holds unique Id number of bad word

badcount = 0 	'Set to 0

'Open database
adoCon.Open cString

'Create new record sheet
Set rsBadWords = Server.CreateObject("ADODB.Recordset")

'Create new SQL string
strSQL = "SELECT tblBadWordFilter.BadWord, tblBadWordFilter.ID, tblBadWordFilter.ReplaceWith FROM tblBadWordFilter;"

'Open recordsheet and execute SQL
rsBadWords.Open strSQL, adoCon

'Loop through the recordset 
Do While not rsBadWords.EOF

intBadWordID=rsBadWords("ID")
Response.Write "<Tr>" 
Response.Write "<TD bgcolor=#ffffff class=main align=center>" 
Response.Write (rsBadWords("badword")) 
Response.Write "</TD>"
Response.Write "<TD bgcolor=#ffffff class=main align=center>" 
Response.Write (rsBadWords("replacewith")) 
Response.Write "</TD>"
Response.Write "<form action=admin_change.asp?addpass="&addpass&"&function=DeleteBadWord&ID="&intBadWordID&" method=post>"
Response.Write "<TD bgcolor=#ffffff class=main align=center>" 
Response.Write "<input type=submit value=Delete class=button>"
Response.Write "</TD>" 
Response.Write "</form>" 
Response.Write "</Tr>" 

badcount = badcount+1 'Add one to the badcount

'Move to the next record in the recordset 
rsBadWords.MoveNext

Loop 

'Close and clean up
rsBadWords.Close
Set rsBadWords = Nothing
adoCon.close

%></table>
<BR>Existe <b><%=badcount%></b> filtros de palavras proibidas.<BR><BR><b>Adicione uam nova palavra proibida</b>
<form action="admin_change.asp?addpass=<% Response.write Request.querystring("addpass")%>&function=AddBadWord" method="post">
<b>Palavra proibida - <input type="text" name="badword" size="40" maxlength="40" class="textbox"><BR>
<b>Substituir por - <input type="text" name="replacewith" size="37" maxlength="40" class="textbox"><BR>
<input type="submit" value="Adicionar" class="button">

</form>
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
