<!--#include file="admentor/include/admentor2.asp"-->
<html>

<head>
<%
'''''''''''  (C) Stefan Holmberg 1999  
'''''''''''  Free to use if these sourcecode lines is not deleted 
'''''''''''  Contact me at webmaster@sqlexperts.com
'''''''''''  http://www.sqlexperts.com
'''''''''''  AdMentor homepage at http://www.create-a-webshop.com

%>


<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>New Page 1</title>
</head>

<body>

<table align="center" bgColor="#003399" border="0" cellPadding="3" cellSpacing="0" height="100%" width="100%">
  <tbody>
    <tr>
      <td vAlign="top" width="50%" height="60" bgcolor="#003399">
      <img border="0" src="images/administration.gif" WIDTH="200" HEIGHT="60">
      <b><font color="#FFFFFF" face="verdana,arial,helvetica" size="1"><br>
      </font><a href="http://www.create-a-webshop.com">
      <font color="#ECECD9" face="verdana,arial,helvetica" size="1">http://www.create-a-webshop.com</font></a><font color="#FFFFFF" face="verdana,arial,helvetica" size="1">&nbsp;</font></b>
      </td>
      <td vAlign="top" width="468" height="60">
      <font color="#FFFFFF" face="verdana,arial,helvetica" size="+2">
      <b>Administration<br>
      </b>
      </font><b><font color="#ECECD9" face="verdana,arial,helvetica" size="1">&nbsp;&nbsp;</font></b>
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
                            <td width="50%">
                        <font color="#aa3333" face="verdana,arial,helvetica" size="+2"><b>
                        Admin start page</b>
                        </font>
                            </td>
                            <td width="50%">
<%=GetAdminPagesBannerCode()%>

</td>
                          </tr>
                        </table>
                        <font color="#aa3333" face="verdana,arial,helvetica" size="+2">
                        <hr color="#000066" noShade SIZE="1">
                        </font>
                        <p>Welcome to the AdMentor demo. Version 2.10 contains a
                        lot of new features. Mostly a updated GUI and
                        possibility for advertisers to login to check their
                        stats. Account management is also supported.&nbsp;</p>
                        <p>These accounts are available here:&nbsp;</p>
                        <table border="0" width="100%">
                          <tr>
                            <td width="33%" bgcolor="#ECECD9"><b>Loginid</b></td>
                            <td width="33%" bgcolor="#ECECD9"><b>Password</b></td>
                            <td width="34%" bgcolor="#ECECD9"><b>Role</b></td>
                          </tr>
                          <tr>
                            <td width="33%">test</td>
                            <td width="33%">stefan</td>
                            <td width="34%">system administrator</td>
                          </tr>
                          <tr>
                            <td width="33%">ad1</td>
                            <td width="33%">ad1</td>
                            <td width="34%">Advertiser. He/she has three banners</td>
                          </tr>
                          <tr>
                            <td width="33%">ad2</td>
                            <td width="33%">ad2</td>
                            <td width="34%">Advertiser. He/she has two banners.</td>
                          </tr>
                        </table>
                        <p>Do log in to the system <a href="admentor/admin/admin.asp">HERE</a>
                        as all of them to see how much of the functions they
                        see, how there own stats looks etc.</p>
                        <p>No zoning has been setup in this demo, and only a
                        single farm ( ad position ) as well.</p>
                        <p>Changes and additions you make won't be saved in this
                        version.&nbsp;</p>
                        <p>&nbsp;</p>
                        <p>Demo of banners:</p>
							<%=AdMentor_GetAdASP("F=0&Z=0&N=1")%>                        
							<%=AdMentor_GetAdASP("F=0&Z=0&N=2")%>                        
							<%=AdMentor_GetAdASP("F=0&Z=0&N=3")%>                        
							<%=AdMentor_GetAdASP("F=0&Z=1&N=3")%>                        
							<table border="0" width="100%">
                          <tr>
                            <td width="50%"></td>
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

