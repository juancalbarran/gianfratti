<!--#include file="common.asp" -->
<!--#include file="check.asp" -->
<%
Dim usrID					'Holds logged in users ID
Dim Username			'Holds logged in username
Dim addpass				'Holds admin password

usrID = CLng(Request.querystring("ID"))
username = Request.querystring("username")
addpass = Request.querystring ("addpass")
if addpass="" Then addpass = "qrr"
%>
<script>
function popup()
{
var win = window.open('exit.asp?ID=<%=usrID%><%IF Request.querystring("addpass") = strAdminPass THEN Response.write("&addpass="&strAdminPass&"") %>','','height=200,width=200');
}
window.onunload=popup;
</script> 
<head>
<!--#include file="style/style.asp" -->
	<title>
		<%=strCompanyName%> <%=strTxtLiveSupport %>
	</title>
</head>

<body style="margin: 0" topmargin="0" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0"  background="<%=img_bg%>">
	<Center>
		<% IF ADDPASS = strAdminPass THEN%>
<% 
'Create some new vairbales
Dim rsAdmin 'New record sheet

'Open new connection to database
adoCon.Open cString

'Create new SQL string
strsql="SELECT * FROM tblActiveUsers WHERE ID="&usrID&" "
set rsAdmin=server.CreateObject("ADODB.Recordset")
rsAdmin.open strsql,adocon,3,3
rsAdmin.fields("AdminIn")="Yes"
	rsAdmin.Update

rsAdmin.close
adoCon.close
set rsAdmin = nothing
%>

		<BR>
		<BR>
		<table  width="400" border="0" cellspacing="0" cellpadding="0" height="15">
			<tR>
				<td bgcolor="#000000" width="100%" class="header">
					<B>
						&nbsp;&nbsp;&nbsp;<%=strTxtRules%>
					</td>
					<td bgcolor="#000000" width="15">
						<img src="<%=img_top_right_curve%>" width="15" height="15">
					</td>
				</tr>
			</table>
			<table  width="400" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
				<tr>
					<td bgcolor="#ffffff" class="main" align="center">
						<%=strTxtGuidelines%>
						<a href="rules.txt" target="_blank" class="domains">
							<%=strTxtHere%>
						</a>
					</td>
				</tr>
			</table>
			<BR>
			<%ELSE%>
			<%END IF%>
			<iframe name="frameTop" src="chat_top.asp?ID=<%=usrID%>&addpass=<%=addpass%>&username=<%=username%>" frameborder="0" border="0" width="400" height="40">
			</iframe>
			<table  width="400" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td >
						<iframe name="FrameMain" src="chat_main.asp?ID=<%=usrID%>&addpass=<%=addpass%>&username=<%=username%>&event=login" frameborder="0" border="0" border="0" width="280" height="240" scrollbars="no">
						</iframe>
					</td>
					<td align="left">
						<iframe name="FrameRight" src="chat_right.asp?ID=<%=usrID%>&addpass=<%=addpass%>&username=<%=username%>" frameborder="0" border="0" width="120" height="240">
						</iframe>
					</td>
				</tr>
			</table>
			<iframe name="FrameBottom" src="infobar.asp" frameborder="0" border="0" width="400" height="44">
			</iframe>
