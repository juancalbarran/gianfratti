<!--#include file="include/admentor2.asp"-->
<%
Dim sBanner
sBanner = AdMentor_GetAdNonSSI()
Dim sArr
sArr = Split( sBanner, "---" )
nBanner = sArr(0)
sGifUrl = sArr(1)

nBanNoOnPage = Request.QueryString("N")
If nBanNoOnPage = "" Then
	nBanNoOnPage = 1
End if



Session("AdMentor_BannerId" & nBanNoOnPage) = nBanner
Response.Redirect sGifUrl
%>


