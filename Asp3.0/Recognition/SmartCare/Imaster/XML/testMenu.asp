<%@ Language=VBScript %>
<%
dim xml
dim xsl
set xml = Server.CreateObject("MSXML2.DOMDocument.4.0")
set xsl = Server.CreateObject("MSXML2.DOMDocument.4.0")
xml.load Server.MapPath(".") & "\menu.xml"
xsl.load Server.MapPath(".") & "\menu.xsl"
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%Response.write xml.transformNode(xsl)%>

</BODY>
</HTML>
