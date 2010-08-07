<!--#include file="../include/admentor2.asp"-->
<%
'''''''''''  (C) Stefan Holmberg 1999  
'''''''''''  Free to use if these sourcecode lines is not deleted 
'''''''''''  Contact me at webmaster@sqlexperts.com
'''''''''''  http://www.sqlexperts.com
'''''''''''  AdMentor homepage at http://www.create-a-webshop.com

Main


Sub Main()
	Dim oConn, oRS, nId
	
	
	If g_AdMentor_Demo = True Then
		Response.Redirect "adminbanners.asp"
	End If
	
	Set oConn = AdMentor_DBOpenConnection2("0")
	Set oRS = Server.CreateObject("ADODB.Recordset")

	nId = Request.QueryString("id")
	oRS.Open "select * from banner where bannerid = " &  nId,oConn ,adOpenKeyset,adLockOptimistic

   	If nId = 0 Then
   		oRS.AddNew
   	End If
    	
	oRS("name") = Request.Form("name") 
	oRS("weight") = Request.Form("weight")
	oRS("advid") = Request.Form("userid") 

	If Request.Form("farmid") = "" Then
		oRS("farmid") = 0
	Else
		oRS("farmid") = Request.Form("farmid")
	End If
		If Request.Form("showcount") = "" Then
		oRS("showcount") =0
	Else
		oRS("showcount") = Request.Form("showcount")
	End If
	If Request.Form("validfromdate") = "" Then
		oRS("validfromdate") = Date()
	Else
		oRS("validfromdate") = Request.Form("validfromdate")
	End if
		
	If Request.Form("validtodate") = "" Then
		oRS("validtodate") = g_MaxEndDate ' Virtually forever
	Else
		oRS("validtodate") = Request.Form("validtodate")
	End if

	If Request.Form("maximpressions") = "" Then
		oRS("maximpressions") = g_MaxLongInt ' Virtually forever, max for a long integer in Access
	Else
		oRS("maximpressions") = Request.Form("maximpressions")
	End If

		
   	If Request.QueryString("HTML") = "True" Then
   		oRS("ishtml") = True
		oRS("redirurl") = ""
		oRS("gifurl") = ""
		oRS("alttext") = ""
		oRS("clickcount") = 0
		oRS("undertext") = ""
		oRS("underurl") = ""
		oRS("underclickcount") = 0
		oRS("xsize") = 0
		oRS("ysize") = 0
		oRS("maxclicks") = 0
		oRS("htmlcode")=Request.Form("htmlcode")
   	Else
   		oRS("ishtml") = False
		oRS("redirurl") = Request.Form("redirurl")
		oRS("gifurl") = Request.Form("gifurl")
		oRS("alttext") = Request.Form("alttext")
		If Request.Form("clickcount") = "" Then
			oRS("clickcount") = 0
		Else
			oRS("clickcount") = Request.Form("clickcount")
		End If
		oRS("undertext") = Request.Form("undertext")
		oRS("underurl") = Request.Form("underurl")
		If oRS("underclickcount") = "" Then
			oRS("underclickcount") = 0
		Else
			oRS("underclickcount") = Request.Form("underclickcount")
		End If
		oRS("xsize") = Request.Form("xsize")
		oRS("ysize") = Request.Form("ysize")
		If Request.Form("maxclicks") = "" Then
			oRS("maxclicks") = g_MaxLongInt ' Virtually forever, max for a long integer in Access
		Else
			oRS("maxclicks") = Request.Form("maxclicks")
		End If
		oRS("htmlcode")=""
	End If
	
	oRS.Update
	If nId = 0 Then
		If g_AdMentor_DatabaseType = "SQLServer" Then
			Dim oRS2
			Set oRS2 = oConn.Execute("select @@identity as bannerid")
			nId = oRS2("bannerid").Value
			oRS2.Close
			Set oRS2 = Nothing
		Else 'In Access it is very easy...
			nId = oRS("bannerid")
		End If
	End If
	oRS.Close
	Set oRS = Nothing
	
	Dim sZones, n, sArr
	sZones = Request.Form("zones")
	sArr = Split(sZones, "," )
	
	oConn.Execute "delete from banzone where bannerid=" & nID
	Set oRS = Server.CreateObject("ADODB.Recordset")
	oRS.Open "select * from banzone where bannerid = " &  nId, oConn ,adOpenKeyset,adLockOptimistic
	For n = LBound(sArr) To UBound(sArr)
		oRS.AddNew
		oRS("bannerid").Value = nId
		oRS("zoneid").Value = CInt(sArr(n))
		oRS.Update
	Next
	oRS.Close
	Set oRS = Nothing
	oConn.Close
	Set oConn = Nothing
 
	Response.Redirect "adminbanners.asp"
End Sub
%>