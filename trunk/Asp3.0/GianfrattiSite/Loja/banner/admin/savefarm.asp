<!--#include file="../include/admentor2.asp"-->
<%
'''''''''''  (C) Stefan Holmberg 1999  
'''''''''''  Free to use if these sourcecode lines is not deleted 
'''''''''''  Contact me at webmaster@sqlexperts.com
'''''''''''  http://www.sqlexperts.com
'''''''''''  AdMentor homepage at http://www.create-a-webshop.com


    Set oConn = AdMentor_DBOpenConnection2()
    
    Set oRS = Server.CreateObject("ADODB.Recordset")
    Set oRS.ActiveConnection = oConn
    oRS.Open "select * from bannerfarm",,adOpenKeyset,adLockOptimistic
    
    	'New
    	'
	If g_AdMentor_Demo = False Then
    	oRS.AddNew
    	oRS("name").Value = Request.Form("name")
    	oRS("description").Value = Request.Form("description")
    	oRS.Update
	End If
	oRS.Close
	Set oRS = Nothing
	oConn.Close
	Set oConn = Nothing
	
    Response.Redirect "adminfarms.asp"
%>