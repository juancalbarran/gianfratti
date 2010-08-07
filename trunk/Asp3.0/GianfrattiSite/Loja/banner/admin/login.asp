<!--#include file="../include/admentor2.asp"-->
<!--#include file="menu.inc"-->
<%
'''''''''''  (C) Stefan Holmberg 1999  
'''''''''''  Free to use if these sourcecode lines is not deleted 
'''''''''''  Contact me at webmaster@sqlexperts.com
'''''''''''  http://www.sqlexperts.com
'''''''''''  AdMentor homepage at http://www.create-a-webshop.com

        Dim strMessage
        If Request.QueryString("reason") = "noauth" Then 
        strMessage = "Error: You appeared to have accessed a page without proper authorization.<br>If you where logged on, you now have to re-login."
        Session("loginname")	= ""
        Session("admin") = False
        Session("userid") = ""
        ElseIf Request.QueryString("reason") = "loginerror" Then
        strMessage = "Error: It is possible that you have made typo in your username or password. Please try again."
        Session("loginname")	= ""
        Session("admin") = False
        Session("userid") = ""
        Else
        strMessage = "Log In"
        End If

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Advertising Admin Login</title>
<style type="text/css">
<!--
     body {  font-family: Arial, Geneva, Helvetica, Verdana; font-size: smaller; color: #000000}
     td {  font-family: Arial, Geneva, Helvetica, Verdana; font-size: smaller; color: #000000}
     th {  font-family: Arial, Geneva, Helvetica, Verdana; font-size: smaller; color: #000000}
     A:link {text-decoration: none;}
     A:visited {text-decoration: none;}
     A:hover {text-decoration: underline;}
-->
</style>
</head>

<body bgcolor="#DDDDDD">

<table bgColor="#003399" border="0" cellPadding="3" cellSpacing="0" height="100%" width="100%">
  <tbody>
    <tr>
      <td vAlign="middle" width="50%" height="60">
      <img src="../images/administration.gif" border="0">
      </td>
      <td vAlign="baseline" width="468" height="60" align="right"><%=GetAdminPagesBannerCode()%>
</td>
    </tr>
    <tr>
      <td height="100%" vAlign="top" width="100%" colspan="2">
        <table align="center" bgColor="#ffffff" border="0" cellPadding="0" cellSpacing="0" height="100%" width="100%">
          <tbody>
            <tr>
              <td height="100%" vAlign="top" width="85%">
                <table bgColor="#ffffff" border="0" cellPadding="10" cellSpacing="0" height="100%" width="100%">
                  <tbody>
                    <tr>
                      <td align="left" height="100%" vAlign="top" width="65%">
                        <table border="0" width="100%">
                          <tr>
                            <td width="100%" valign="middle" align="left" colspan="2" ><font color="#aa3333" face="Arial, Geneva, Helvetica, Verdana" size="4"><b><%=strMessage%></b></font>
                            </td>
                          </tr>
                        </table>
                        <hr color="#000066" noShade SIZE="1">
                        <table border="0" width="100%">
                          <tr>
                            <td width="50%">
                             <form method="POST" action="admin.asp?login=yes">
                                <table border="0" width="100%">
                                  <tr>
                                    <td width="22%"><font face="Arial"><b>Usuário</b>:</font></td>
                                    <td width="78%"><input type="text" name="userid" size="15"></td>
                                  </tr>
                                  <tr>
                                    <td width="22%"><font face="Arial"><b>Senha</b>:</font></td>
                                    <td width="78%"><input type="password" name="pwd" size="15"></td>
                                  </tr>
                                </table>
                                <p><input type="submit" value="Submit" name="B1">
                                <input type="reset" value="Reset" name="B2"></p>
                              </form>
                              <p>
                             
                           </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </td>
            </tr>
          </tbody>
        </table>
      </td>
    </tr>
  </tbody>
</table>
<font face=tahoma size=2>Cortesia do <a href='http://www.bregapop.com/bregashopping' target='_blank' style="text-decoration:none;">José Roberto - Comunidade Vs</a></font>
</body>

</html>







