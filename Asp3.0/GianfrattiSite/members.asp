<%@ LANGUAGE = "VBScript" %>
<%
	Option Explicit
	With Response
		.Buffer = true
		.Expires = -1000
		.AddHeader "pragma", "no-cache"
		.ContentType = "csv/plain"
		'.ContentType = "application/x-msdownload"
		.AddHeader "content-disposition", "attachment; filename=members.csv"
	End With
%>
<!-- #include file="Engine/CFullXMLEngine.asp" -->
<%		
	Dim oFullXMLEngine	
	set oFullXMLEngine = new CFullXMLEngine
		oFullXMLEngine.GrantAccess("administrator")
		call oFullXMLEngine.ExportMember()
	set oFullXMLEngine = nothing
%>