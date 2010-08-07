<!--#include file="include/admentor2.asp"-->
<%
''' Version 2.01 Fix: Stefan Holmberg: Deleting call to getDownStuff

'Setable parameters
Dim sZones, nFarm, nBannerId, nBannerOnPage, sCode, sRetHTML
	
sZones = Request.QueryString("Z")
nFarm = Request.QueryString("F")
nBannerId = Request.QueryString("B")
nBannerOnPage = Request.QueryString("N")
If nBannerOnPage = "" Then
	nBannerOnPage = 1
End if
Response.Buffer = TRUE
Response.ContentType = "application/x-javascript"

sRetHTML = AdMentor_GetAdEx( True, sZones, nFarm, nBannerId, nBannerOnPage, True )
'sRetHTML = Replace( sRetHTML, """", "\""" )
sRetHTML = Replace( sRetHTML, "'", "\'" )
sCode = "code='" & sRetHTML & "'"
Response.Write Replace(sCode, vbCrLf, " ")
%>