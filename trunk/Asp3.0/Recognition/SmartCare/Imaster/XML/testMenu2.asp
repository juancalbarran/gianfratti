<%@ Language=VBScript %>
<%
dim xml
dim xsl
if isEmpty(Application("menuXML")) or Request("refresh") = "true" then
	Response.Write "Loading from disk"	
	set xml = Server.CreateObject("MSXML2.FreeThreadedDOMDocument.4.0")
	set xsl = Server.CreateObject("MSXML2.FreeThreadedDOMDocument.4.0")
	xml.load Server.MapPath(".") & "\menu.xml"
	xsl.load Server.MapPath(".") & "\menu.xsl"
	Application.Lock
	set Application("menuXML") = xml
	set Application("menuXSL") = xsl
	Application.UnLock
else
	Response.Write "Loading from cache"
	set xml = Application("menuXML")
	set xsl = Application("menuXSL")
end if

%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%Response.write xml.transformNode(xsl)%>

</BODY>
</HTML>
