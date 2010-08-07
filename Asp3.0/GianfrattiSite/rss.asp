<%
	Option Explicit
	With Response
		.Buffer = True
		.Expires = -1000
		.AddHeader "pragma", "no-cache"
		.ContentType="text/xml"
		.Write("<?xml version='1.0' encoding='ISO-8859-1'?>")
	End With
%> <!-- #include file="Engine/CFullXMLEngine.asp" -->
<%		
	Dim oFullXMLEngine
	Dim sRSS, sOutput
	set oFullXMLEngine = new CFullXMLEngine
		Response.Write oFullXMLEngine.Rss		
	set oFullXMLEngine = nothing
%>
