<%
' Security functions
Dim sUser
Dim sPwd

If Request.QueryString("login") = "yes" Then
	sUser = Request.Form("userid")
	sPwd = Request.Form("pwd")
	
	Dim oConn
	Dim oRS
	
	Set oConn = AdMentor_DBOpenConnection2("0")
	Set oRS = oConn.Execute ("select admin, fullname, fldAuto from users where name = '" & sUser & "' AND pwd='" & sPwd & "'" )
	If oRS.EOF Then
		oRS.Close
		oConn.Close
		Response.Redirect g_AdMentor_PathToAdServe & "admin/login.asp?reason=loginerror"
	End If

	'We are logged in!
	Session("loginname")	= sUser
	Session("admin") = oRS("admin").Value
	Session("fullname") = oRS("fullname").Value
	Session("userfldauto") = oRS("fldauto").Value


	oRS.Close
	oConn.Close
End if 

If Session("loginname") = "" Then
	Response.Redirect g_AdMentor_PathToAdServe & "admin/login.asp"
Else
End If
%>