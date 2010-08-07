<%
	Option Explicit
	With Response
		.Buffer = True
		.Expires = -1000
		.AddHeader "pragma", "no-cache"
	End With
%>
<!-- #include file="Engine/CFullXMLEngine.asp" -->
<%		
	Dim oFullXMLEngine	
	set oFullXMLEngine = new CFullXMLEngine
		Response.Write oFullXMLEngine.Redirect(request("type"), request("id"))	
	set oFullXMLEngine = nothing
%>