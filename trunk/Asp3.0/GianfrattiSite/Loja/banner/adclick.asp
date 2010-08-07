<!--#include file="include/admentor2.asp"-->
<%
Dim sId 
Dim sWay 
Dim sRedir

sId = GetId()
sWay = "ban"
sRedir = AdMentor_ClickAd( sId, sWay )
Response.Redirect sRedir



Function GetId()
	' How to get id from clicked banner
	' Oh, yes we stored it in session...
	Dim nBanNoOnPage
	If Request.QueryString("N") = "" Then
		nBanNoOnPage = 1
	Else
		nBanNoOnPage = Request.QueryString("N") 
	End If
	
	GetId = Session("AdMentor_BannerId" & nBanNoOnPage )
End Function
%>