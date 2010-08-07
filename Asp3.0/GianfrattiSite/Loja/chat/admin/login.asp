<%
Dim strDBpathCorrection					'Variable to hold database path correction
strDBpathCorrection = "../"
%>
<!--#include file="../common.asp" -->
<%IF Request.querystring("p") = "p" THEN%>
<%
Dim addpass 'holds admin password from form

'Set the variable to the input the user sent
addpass = Request.form("pass")

'Redirect to admin page where checks will take pelase
Response.redirect("admin_menu.asp?addpass="&addpass&"")

%>
<%ELSE%>
<%END IF%>
<html>
<head>
<!--#include file="../style/style.asp" -->
<title>Menu Administrativo - Atendimento Online</title>
</head>
<!-- Start the HTML body -->
<body text="#000000" background="<%=strDBpathCorrection%><%=img_bg%>" link="#0000FF" vlink="#990099" alink="#FF0000">
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
      <form name="Login" method="post" action="login.asp?p=p">
  <table width="273" border="0" align="center" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
    <tr>
      <td align="right" width="94" class="main">Senha: </td>
      <td width="172" class="main"> 
        <input type="password" name="Pass" class="textbox"><BR>( Caso sensitivo )
      </td>
    </tr>
    <tr> 
      <td align="right" height="44" width="94">&nbsp;</td>
      <td height="44" width="172"> 
        <input type="submit" name="Submit" value="Enter" class="button">
      </td>
    </tr>
  </table>
</form>

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