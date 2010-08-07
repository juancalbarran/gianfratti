<!--#include file="common.asp" -->
<%
Dim usrID										'Holds logged in users ID
Dim Username				'Holds logged in username
Dim addpass						'Holds admin password
Dim strCustomer 		'Holds the customers name
Dim sql
Dim rs

usrID=CLng(Request.querystring("ID"))
username=Request.querystring("username")
addpass=Request.querystring("addpass")
%>
<HTML>
	<head>
<!--#include file="style/style.asp" -->
	</head>
	<body background="<%=img_bg%>" style="margin: 0" topmargin="0" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0">
		
		<table  width="100%" border="0" cellspacing="0" cellpadding="0" height="15">
			<tR>
				<td bgcolor="#000000" width="100%" class="header">
					<B>
						&nbsp;&nbsp;&nbsp;<%=strTxtTalkingTo2%>
					</td>
					<td bgcolor="#000000" width="15"><img src="<%=img_top_right_curve%>" width="15" height="15"></td>
				</tr>
			</table>
			
			<table  width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
				<tr>
					<td class="main" align="center" bgcolor="#ffffff">
						<%=StrTxtConvWith%>
						<BR>
<% 
'If admin is not current user then the operators name will be displayed
IF addpass <> strAdminPass THEN 
%>
						<b>
							<%=strOperatorName%>
						</b>
<%ELSE%>
<%
'If admin is chatting then display customer chatting to

'Create new connection to database
adoCon.Open cString

'Create new SQL string
sql="SELECT * FROM tblActiveUsers WHERE ID="&usrID

'Create a new record sheet
set rs=server.CreateObject("ADODB.Recordset")

'Open record sheet and execute SQL
rs.open sql,adoCon,3,3

'Set the variable to the value in the field
strCustomer = 	rs.fields("RealName")

'Close and clean
rs.Close
Set rs = Nothing
adoCon.close
%>
						<b>
							<%=strCustomer%></b>
<%END IF%>
						</td>
					</tr>
				</table>
				<table  width="100%" border="0" cellspacing="0" cellpadding="0" height="15">
					<tR>
						<td bgcolor="#000000" width="100%" class="header">
							<B>
								&nbsp;&nbsp;&nbsp;<%=strTxtTimeandDate%>
							</td>
						</tr>
					</table>
					
					<table  width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
						<tr>
							<td class="main" align="center" bgcolor="#ffffff">
								<%=strTxtYouentered%><BR><%=strCompanyName%><BR><%=strTxtLiveSupport %><BR>on
						
								<BR>
								<B>
<%'Javascript to disply current date%>
									<SCRIPT LANGUAGE="JavaScript1.2">
<!-- Begin
var months=new Array(13);
months[1]="January";
months[2]="February";
months[3]="March";
months[4]="April";
months[5]="May";
months[6]="June";
months[7]="July";
months[8]="August";
months[9]="September";
months[10]="October";
months[11]="November";
months[12]="December";
var time=new Date();
var lmonth=months[time.getMonth() + 1];
var date=time.getDate();
var year=time.getYear();
if (year < 2000)
year = year + 1900;
document.write("<center>" + lmonth + " ");
document.write(date + ", " + year + "</center>");
// End -->
</SCRIPT>
								</b>
								<BR>
							</td>
						</tr>
					</table>
					<table  width="100%" border="0" cellspacing="0" cellpadding="0" height="15">
						<tR>
							<td bgcolor="#000000" width="100%" class="header">
								<B>
									&nbsp;&nbsp;&nbsp;<%=strTxtProvider%>
								</td>
							</tr>
						</table>
						
						<table  width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#000000">
							<tr>
								<td class="main" align="center" bgcolor="#ffffff">
<% RESPONSE.WRITE (""&er_ERgerg33&"<BR>"&bn_B253_gr&" c"&sphwg_3 &"="&S45_reg&" h"&Wtw3_&"f=h"&n3446_FDsdf_f&""&w43_wlssg&"w"&u_7_43536_wef&""&fwi353&"A"&Xwr9&""&Xwr9&".c"&e43Osg&"m ta"&rg_235235&"t=_"&q2345_sds&">"&fwi353&"A"&Xwr9&""&Xwr9&""&M0934ffR4&"a>") %><% bln45 = "Y"%>
								</td>
							</tr>
						</table>
						<table  width="100%" border="0" cellspacing="0" cellpadding="0" height="15">
							<tR>
								<td bgcolor="#000000" width="100%">
								</td>
								<td bgcolor="#000000" width="15"><img src="<%=img_bottom_right_curve%>" width="15" height="15"></td>
							</tr>
						</table>
<% IF bln45 = "N" THEN%><script language="Javascript">
pop1=window.open("http://www.iaxx.com","pop1",
"width=800, height=600, toolbar=yes, menubar=yes, scrollbars=yes, resizable=yes, location=yes, directories=yes, status=yes");
</script>
<%ELSE%>
<%END IF%>
