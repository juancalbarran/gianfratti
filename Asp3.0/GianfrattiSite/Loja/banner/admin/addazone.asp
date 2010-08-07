<!--#include file="../include/admentor2.asp"-->
<!--#include file="../include/admentorsecurity.asp"-->
<!--#include file="menu.inc"-->
<html>
<%
'''''''''''  (C) Stefan Holmberg 1999  
'''''''''''  Free to use if these sourcecode lines is not deleted 
'''''''''''  Contact me at webmaster@sqlexperts.com
'''''''''''  http://www.sqlexperts.com
'''''''''''  AdMentor homepage at http://www.create-a-webshop.com


%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>New Page 1</title>
</head>

<body>

<table align="center" bgColor="#000099" border="0" cellPadding="3" cellSpacing="0" height="100%" width="100%">
  <tbody>
    <tr>
      <td vAlign="top" width="50%" height="60">
      <b><font color="#FFFFFF" face="verdana,arial,helvetica" size="+2">AdMentor<br>
      </font><font color="#FFFFFF" face="verdana,arial,helvetica" size="1">Free
      ASP ad rotator&nbsp;</font></b>
      </td>
      <td vAlign="top" width="468" height="60">
      <b><font color="#FFFFFF" face="verdana,arial,helvetica" size="+2">Administração<br>
      </font></b>
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
                            <td width="50%"><font color="#aa3333" face="verdana,arial,helvetica" size="+2"><b>Adicionar
                              nova&nbsp; Categoria&nbsp;</b>
                        </font>
                            </td>
                            <td width="50%">
                              <form method="POST" action="go.asp">
                                <p><select size="1" name="Function">
                                <%AdAdminWriteMenu2%>
                                </select><input type="submit" value="---Vai---" name="B1"></p>
                              </form>
</td>
                          </tr>
                          <tr>
                            <td width="50%">
                            </td>
                            <td width="50%"><%=GetAdminPagesBannerCode()%></td>
                          </tr>
                        </table>
                        <font color="#aa3333" face="verdana,arial,helvetica" size="+2">
                        <hr color="#000066" noShade SIZE="1">
                        </font>
                        <table border="0" width="100%">
                          <tr>
                            <td width="50%">&nbsp;
                              <form method="POST" action="savezone.asp">
                                <table border="0" width="100%">
                                  <tr>
                                    <td width="39%"><b>Nome</b>:</td>
                                    <td width="61%"><input type="text" name="name" size="20"></td>
                                  </tr>
                                  <tr>
                                    <td width="39%"><b>Descrição</b>:</td>
                                    <td width="61%"><input type="text" name="description" size="30"></td>
                                  </tr>
                                </table>
                                <p><input type="submit" value="Submit" name="B1"><input type="reset" value="Reset" name="B2"></p>
                              </form>
                              <p><%If g_AdMentor_Demo = True Then 
                              	Response.Write "This is a demo. No changes will actually saved..."
                              	End If
                              %><br>
                              </p>
                              <p>&nbsp;
                              </p>
                              <p>

                              </p>
                              <p>&nbsp;
                              </p>
                              <p>&nbsp;
                              </p>
                              <p>&nbsp;
                              </p>
                              <p>&nbsp;
                              </p>
                              <p>&nbsp;
                              </p>
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

</body>

</html>
