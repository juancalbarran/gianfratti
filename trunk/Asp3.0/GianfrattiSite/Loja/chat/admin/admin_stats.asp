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
										&nbsp;&nbsp;&nbsp;Estatísticas
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
															<td width="8%">
																<img src="images/bar.gif">
															</td>
															<td class="main" valign="top">Veja as suas estatísticas aqui. O   CheckChat.asp é o arquivo que contabiliza as estatísticas, portanto adicione este include nas páginas do seu site ou na página inicial!  Antes leia o arquivo readme.txt para maiores instruções. Visite o site <a href="http://www.iaxx.com" target="_blank" class="bluelink">iAXX</a> para upgrades.
															</td>
														</tr>
													</table>
<center>
<%
Dim rsDetails		'Record sheet for user details
Dim usercount		'Holds number of users browsing

usercount = 0 	'Set to 0

'Open database
adoCon.Open cString

'Create new record sheet
Set rsDetails = Server.CreateObject("ADODB.Recordset")

'Create new SQL string
strSQL = "SELECT * FROM tblActiveUsers;"

'Open recordsheet and execute SQL
rsDetails.Open strSQL, adoCon

'Loop through the recordset 
Do While not rsDetails.EOF 
usercount = usercount +1 'Add one to the usercount
'Move to the next record in the recordset 
rsDetails.MoveNext

Loop 

'Close and clean up
rsDetails.Close
Set rsDetails = Nothing
adoCon.close

%>
<%
Dim rsStats
Dim int_pageviews
'Open the table tblSettings
set rsStats = server.createobject("ADODB.RecordSet")
StrSql="SELECT * FROM tblStats "
rsStats.open StrSql,cString,3,3

'Take the values from the database field and put them in the variables
int_pageviews	 = rsStats("PageViews")

'Close the record sheet and clean up
rsStats.Close
Set rsStats = Nothing
%>
Seu site teve um total de <b><%=int_pageviews%></b> páginas visitadas<BR>
<% IF usercount = "1" THEN Response.write("Houve somente <b>1</b> visita no seu site") ELSE Response.write("Houve "&usercount&" visitantes no seu site")%>
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
