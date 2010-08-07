<!--#include file="include/admentor2.asp"-->
<%
'''''''''''  (C) Stefan Holmberg 1999  
'''''''''''  Free to use if these sourcecode lines is not deleted 
'''''''''''  Contact me at webmaster@sqlexperts.com
'''''''''''  http://www.sqlexperts.com
'''''''''''  AdMentor homepage at http://www.create-a-webshop.com



Dim sId 
Dim sWay
Dim sRedir

sId = Request.QueryString("id")
sWay = Request.QueryString("way")
sRedir = AdMentor_ClickAd( sId, sWay )
Response.Redirect sRedir
%>