<!--#include file="admentorconfig.asp"-->
<!--#include file="adovbs.inc"-->
<%

'''''''''''  (C) Stefan Holmberg 1999  
'''''''''''  Free to use if these sourcecode lines is not deleted 
'''''''''''  Contact me at webmaster@sqlexperts.com
'''''''''''  http://www.sqlexperts.com
'''''''''''  AdMentor homepage at http://www.create-a-webshop.com

' Version 1.11 contains contribution from Shawn Willmon - traceclicks code

Function Internal_AdMentordb_GetDateFunction()
	If g_AdMentor_DatabaseType = "SQLServer" Then
		Internal_AdMentordb_GetDateFunction = "getdate()"
	Else
		Internal_AdMentordb_GetDateFunction = "date()"
	End If
End Function

Function Internal_AdMentordb_GetBoolValue( fTrue )
	If g_AdMentor_DatabaseType = "SQLServer" Then
		If fTrue = True Then
			Internal_AdMentordb_GetBoolValue = "1"
		Else
			Internal_AdMentordb_GetBoolValue = "0"
		End If			
	Else
		If fTrue = true Then
			Internal_AdMentordb_GetBoolValue = "true"
		Else
			Internal_AdMentordb_GetBoolValue = "false"
		End If	
	End If
	
End Function



Function AdMentor_DBOpenConnection()

Dim oConn, g_Admentor_strConnect
Set oConn = Server.CreateObject("ADODB.Connection")

caminho = "banner/ad2k.mdb"

g_Admentor_strConnect = "DBQ="&  server.mappath(caminho) & ";Driver={Microsoft Access Driver (*.mdb)}"


oConn.Open g_Admentor_strConnect
		Set AdMentor_DBOpenConnection = oConn
End Function

Function AdMentor_DBOpenConnection2(caminho)

Dim oConn, g_Admentor_strConnect
Set oConn = Server.CreateObject("ADODB.Connection")

if caminho = "0" then
	caminho = "../ad2k.mdb"
else
	caminho = "ad2k.mdb"
end if

g_Admentor_strConnect = "DBQ="&  server.mappath(caminho) & ";Driver={Microsoft Access Driver (*.mdb)}"

oConn.Open g_Admentor_strConnect
		Set AdMentor_DBOpenConnection2 = oConn
End Function


Function AdMentor_DBGetBannersInFarm( oConn, nBannerFarm )
	 Dim oRS
    Set oRS = CreateObject("ADODB.Recordset")
    oRS.CursorLocation = adUseClient
    oRS.MaxRecords = g_AdMentor_MaxRecords
    oRS.CacheSize = g_AdMentor_MaxRecords
    oRS.CursorType = adOpenForwardOnly
	oRS.Open "select bannerid, gifurl, weight, alttext, undertext, xsize, ysize from banner  where farmid=" & nBannerFarm & " and weight > 0 and showcount < maximpressions AND clickcount+underclickcount < maxclicks AND validtodate >= " & Internal_AdMentordb_GetDateFunction() & " AND validfromdate <= " & Internal_AdMentordb_GetDateFunction(), oConn
    
    Set oRS.ActiveConnection = Nothing
    Set  AdMentor_DBGetBannersInFarm = oRS
End Function

Sub AdMentor_DBAddShowCount( oConn, nBanner )
	oConn.Execute "update banner set showcount=showcount+1 where bannerid=" & nBanner
End Sub 


Sub AdMentor_DBUpdateClickCount( oConn, nBanner, fUnderText )
	Dim sSQL
	Dim oRSTC

	If fUnderText = True Then
		sSQL = "update banner set underclickcount = underclickcount +1 where bannerid = " & nBanner
	Else
		sSQL = "update banner set clickcount = clickcount +1 where bannerid = " & nBanner
	End if
	oConn.Execute ( sSQL )

	Set oRSTC = Server.CreateObject("ADODB.Recordset")
	Set oRSTC.ActiveConnection = oConn
	oRSTC.Open "select * from traceclicks where bannerid = -1 ", ,adOpenKeyset,adLockOptimistic
	oRSTC.AddNew()
	oRSTC("bannerid")=nBanner
	oRSTC("page")=Request.ServerVariables("HTTP_REFERER")
	oRSTC("dt") = now()
	oRSTC("ip")=Request.ServerVariables( "REMOTE_ADDR" )
	oRSTC("undertext")=fUndertext
	oRSTC.Update
	oRSTC.Close
        Set oRSTC = Nothing
End Sub

Function  AdMentor_DBGetUrl( oConn, nBanner, fUnderText )    	
	Dim oRS
	Dim sSQL2

	If fUnderText = True Then
        sSQL2 = "select underurl as url from banner where bannerid= " & nBanner
	Else
        sSQL2 = "select redirurl as url from banner where bannerid= " & nBanner
	End if
	
	Set oRS = oConn.Execute ( sSQL2 )
	AdMentor_DBGetUrl = oRS("url").Value
	oRS.Close
	Set oRS = Nothing
End Function









Function AdSQL_AddAndWhere( strWhere, strWhat )
	If strWhere = "" Then
		strWhere = " WHERE "
	Else
		strWhere = strWhere & " AND "
	End If
	strWhere = strWhere & " " & strWhat
	AdSQL_AddAndWhere = strWhere
End Function



Function AdMentor_DBGetAvailBanners( oConn, fASP, strZones, nFarm, nBannerId, fCanUseHTML  )
	 Dim oRS
    Set oRS = CreateObject("ADODB.Recordset")
    oRS.CursorLocation = adUseClient
    oRS.MaxRecords = g_AdMentor_MaxRecords
    oRS.CacheSize = g_AdMentor_MaxRecords
    oRS.CursorType = adOpenStatic
    oRS.Open GetAdSQL(fASP, strZones, nFarm, nBannerId, fCanUseHTML ), oConn
    
    Set oRS.ActiveConnection = Nothing
    Set  AdMentor_DBGetAvailBanners = oRS
End Function

Function AdMentor_GetHTMLCode( oConn, nBannerId )
	 Dim oRS
    Set oRS = CreateObject("ADODB.Recordset")
    oRS.CursorLocation = adUseClient
    oRS.MaxRecords = 1
    oRS.CacheSize = 1
    oRS.CursorType = adOpenForwardOnly
    oRS.Open "select htmlcode from banner where bannerid="&nBannerId, oConn
    AdMentor_GetHTMLCode = oRS("htmlcode").Value
    
    oRS.Close
    Set oRS = Nothing		
End Function


Function GetAdSQL( fASP, sZone, nFarm, nBannerId, fCanUseHTML  )
	Dim strSQL
	Dim strWhere
	
	strSQL = 	"select distinct banner.bannerid, banner.gifurl, banner.weight " 
	If fASP Then
		strSQL = strSQL & ", banner.AltText, banner.UnderText, banner.xsize, banner.ysize "
	End If
	If fCanUseHTML Then
		strSQL = strSQL & ",ishtml"
	End If
	
	If 	strAdmentor_strAlreadyOnPage <> "" Then
		strWhere = AdSQL_AddAndWhere( strWhere, "banner.bannerid not in ( " & 	strAdmentor_strAlreadyOnPage & ")" )
	End If
	
	strSQL = strSQL & " from banner "
	If sZone <> "0" Then
			strSQL = strSQL & ",banzone "
			strWhere = AdSQL_AddAndWhere( strWhere, "banner.bannerid=banzone.bannerid" )
			strWhere = AdSQL_AddAndWhere( strWhere, "banzone.zoneid in ( " & sZone & ")" )
	End If	
	
	
	If nBannerId <> "" Then
		strWhere = AdSQL_AddAndWhere( strWhere, "banner.bannerid=" & nBannerId )
	Else
		If nFarm <> 0 Then
			strWhere = AdSQL_AddAndWhere( strWhere, "banner.farmid=" & nFarm )
		End If
		strWhere = AdSQL_AddAndWhere( strWhere, "weight > 0 and showcount < maximpressions AND validtodate >= " & Internal_AdMentordb_GetDateFunction() & " AND validfromdate <= " & Internal_AdMentordb_GetDateFunction() )
		If fCanUseHTML = True Then
			strWhere = AdSQL_AddAndWhere( strWhere, " ( ( clickcount+underclickcount < maxclicks ) OR ishtml=" & Internal_AdMentordb_GetBoolValue(true) & " )"  )
		Else
			strWhere = AdSQL_AddAndWhere( strWhere, "ishtml <> " & Internal_AdMentordb_GetBoolValue(true)  )
		End If
	End If
	
	
	strSQL = strSQL & strWhere
	

' If you want banners with no zoning to mean all zones then add these 
' lines

'	If sZone <> "0" Then
'			strSQL = strSQL & "union select  distinct banner.bannerid, banner.gifurl, banner.weight "
'		If fASP Then
'			strSQL = strSQL & ", banner.AltText, banner.UnderText, banner.xsize, banner.ysize "
'		End If
'		If fCanUseHTML Then
'			strSQL = strSQL & ",ishtml"
'		End If
'		strSQL = strSQL & " from banner "
'		strSQL = strSQL & " where bannerid not in (select bannerid from banzone)"
'		If 	strAdmentor_strAlreadyOnPage <> "" Then
'			strSQL = strSQL & " AND banner.bannerid not in ( " & 	strAdmentor_strAlreadyOnPage & ")" 
'		End If
'	End If	


	GetAdSQL = strSQL
	
End Function



%>

