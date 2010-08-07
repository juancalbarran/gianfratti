<%
Dim strDBpathCorrection					'Variable to hold database path correction
strDBpathCorrection = "../"
%>
<!--#include file="../common.asp" -->
<!--#include file="check_admin.asp" -->
<html>
<head>
<!--#include file="../style/style.asp" -->
<title>Menu Administrativo - Atendimento Online</title>
</head>
<!-- Start the HTML body -->
<body background="<%=strDBpathCorrection%><%=img_bg%>">
<Center>
<table  width="450" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><img src="<%=strDBpathCorrection%><%=img_top_left_curve%>"></td>
					<td bgcolor="#000000" width="100%">
					</td>
					<td><img src="<%=strDBpathCorrection%><%=img_top_right_curve%>"></td>
				</tr>
			</table>
<table width="450" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="#000000">
  <tr> 
    <td class="main" align="center" bgcolor="#ffffff">
<BR><BR>
  <table width="100%" border="0" align="center" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
    <tr>
      <td width="100%" class="main" align="center">
<a href=# onClick="javascript:window.open('admin_control_frames.asp?addpass=<%=addpass%>','popup','width=750, height=400, toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no')" class="bluelink">Painel de Controle</a><BR><BR>
<a href="http://www.iaxx.com" target="_blank" class="bluelink">Created and &copy; iAXX</a>
      </td>
    </tr>
  </table>
<BR><BR>

    </td>
  </tr>
</table>
<table  width="450" border="0" cellspacing="0" cellpadding="0" height="15">
							<tr>
								<td width="15"><img src="<%=strDBpathCorrection%><%=img_bottom_left_curve%>" width="15" height="15"></td>
								<td bgcolor="#000000" width="100%">
								</td>
								<td width="15"><img src="<%=strDBpathCorrection%><%=img_bottom_right_curve%>" width="15" height="15"></td>
							</tr>
</table>
</body>
</html>