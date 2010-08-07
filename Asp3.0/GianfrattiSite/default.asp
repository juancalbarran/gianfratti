<%@ LANGUAGE = "VBScript" %>
<%
	Option Explicit
	
	With Response
	.Buffer = True
	.ExpiresAbsolute = Now() - 1
	.AddHeader "cache-control", "must-revalidate"
	.AddHeader "cache-control", "private"
	.AddHeader "pragma", "no-cache"
	End With
%>
<!-- #include file="Engine/CFullXMLEngine.asp" -->
<%		
	Dim oFullXMLEngine
	
	set oFullXMLEngine = new CFullXMLEngine
		'oFullXMLEngine.DebugMode = true
		Response.Write oFullXMLEngine.Show	
	set oFullXMLEngine = nothing
%>
