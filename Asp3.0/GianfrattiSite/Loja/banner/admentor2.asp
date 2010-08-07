<!--#include file="admentordb.asp"-->
<%

'''''''''''  (C) Stefan Holmberg 1999  
'''''''''''  Free to use if these sourcecode lines is not deleted 
'''''''''''  Contact me at webmaster@sqlexperts.com
'''''''''''  http://www.sqlexperts.com
'''''''''''  AdMentor homepage at http://www.create-a-webshop.com




''''''''''''''''The public functions

'This should be called from ASP pages on SAME server
'The QueryString parameter is just that - a querystring string
'where you specify zone etc the same way as when
'using NonSSI version

Public Function AdMentor_GetAdASP( strQueryString )
	Dim sArr, n
	Dim sArr2
	'Setable parameters
	Dim sZones, nFarm, nBannerId
	
	sArr = Split( strQueryString, "&" )

	For n=LBound(sArr) To UBound(sArr)
		sArr2 = Split( sArr(n), "=" )
		
		Select Case sArr2(0)
			Case "Z"
				sZones = sArr2(1)
			Case "F"
				nFarm = sArr2(1)
			Case "B"
				nBannerId = sArr2(1)
			Case "N"
				nBannerOnPage = sArr2(1)
		End Select
	Next
	
	'If we have selected a certain banner to run on this
	'specific spot then just don't care about the rest...
	AdMentor_GetAdASP = AdMentor_GetAdEx( True, sZones, nFarm, nBannerId, nBannerOnPage, True )
End Function

Public Function AdMentor_GetAdNonSSI()
	'Setable parameters
	Dim sZones, nFarm, nBannerId, nBannerOnPage
	
	sZones = Request.QueryString("Z")
	nFarm = Request.QueryString("F")
	nBannerId = Request.QueryString("B")
	nBannerOnPage = Request.QueryString("N")
	
	AdMentor_GetAdNonSSI = AdMentor_GetAdEx( False, sZones, nFarm, nBannerId, nBannerOnPage, False )
End Function


'Private functions 

Private Function AdMentor_AddToUsedList( nBannerId )
	If strAdmentor_strAlreadyOnPage <> "" Then
		strAdmentor_strAlreadyOnPage = strAdmentor_strAlreadyOnPage & ","		
	End If
	strAdmentor_strAlreadyOnPage = strAdmentor_strAlreadyOnPage & CStr(nBannerId)
End Function


' If ASP then it returns the HTML
' else it simply returns the bannerid

' fASP = true or false
Private Function AdMentor_GetAdEx( fASP, strZone, nFarm, nBannerId, nBannerOnPage, fCanUseHTML )
    Dim oConn
    Dim oRS
    Dim nSumWeight
    Dim nTempIndex
    Dim nWeight
    Dim nTempIndex2
    Dim nBanner
    Dim nCurRow
    Dim nMax
    
    Set oConn = AdMentor_DBOpenConnection()
    
    If strZone = "" Then
    	strZone = "0"
    End If

    If nFarm = "" Then
    	nFarm = "0"
    End If
    
    ' Get Total Weight
    Set oRS = AdMentor_DBGetAvailBanners( oConn, fASP, strZone, nFarm, nBannerId, fCanUseHTML  )
    If oRS.EOF Then
       'There is no banner in this banner farm
       'TODO: RETURN DEFAULT BANNER!!!!!
        oRS.Close
		Set oRS = Nothing
    	oConn.Close
    	Set oConn = Nothing
       AdMentor_GetAd = "No banner in farm"
		Exit Function
    End If
    
    'Now lets get the total weight
    nSumWeight = 0
    While Not oRS.EOF
        nSumWeight = nSumWeight + oRS("weight").Value
        oRS.MoveNext
    Wend
    
    ' Lets get a random banner
    Randomize
    nBanner = Int((nSumWeight * Rnd) + 1)
    
    oRS.MoveFirst
    nCurVal = 0
    While nCurVal + oRS("weight").Value < nBanner
        nCurVal = nCurVal + oRS("weight").Value
        oRS.MoveNext
    Wend
    
    nBanner = oRS("bannerid").Value
    
    AdMentor_AddToUsedList nBanner
    
    If Not fASP Then
       oRS.Close
		Set oRS = Nothing
    	AdMentor_GetAdEx = nBanner & "---" & oRS("gifurl").Value
    	AdMentor_DBAddShowCount oConn, nBanner 
    	oConn.Close
    	Set oConn = Nothing
    	Exit Function
    End If
    
    
    If fCanUseHTML And oRS("ishtml").Value = True Then
    	Dim sHTMCode
    	oRS.Close
		Set oRS = Nothing
    	sHTMCode = AdMentor_GetHTMLCode( oConn, nBanner )
    	AdMentor_GetAdEx = FixupSpecialVariables(sHTMCode)
    	AdMentor_DBAddShowCount oConn, nBanner 
    	oConn.Close
    	Set oConn = Nothing
    	Exit Function
    End If
        
    ' Now we have the banner id, lets create the actual HTML
    
    'Move into temp variables only to make it more readable
    Dim sRedirUrl
    Dim sGifUrl
    Dim sAltText
    Dim sUnderText
    Dim sUnderUrl
    Dim sRet
    Dim nXSize
    Dim nYSize
    
    
    sRedirUrl = g_AdMentor_AdMentorRedirPath & "?id=" & nBanner & "&way=ban"
	If IsNull( oRS("gifurl").Value ) Then
		sGifUrl = ""
	Else
		sGifUrl = oRS("gifurl").Value
	End if
	If IsNull( oRS("AltText").Value ) Then
		sAltText = ""
	Else
		sAltText = oRS("AltText").Value
	End if
	If IsNull( oRS("UnderText").Value ) Then
		sUnderText = ""
	Else
		sUnderText = oRS("UnderText").Value
	End if
    sUnderUrl = g_AdMentor_AdMentorRedirPath & "?id=" & nBanner & "&way=txt"
    
    nXSize=oRS("xsize").Value
    nYSize=oRS("ysize").Value
 '--------------------   
 extensao = Right(oRS("gifurl").Value, 4) 
	if extensao <> ".swf" then    
    
    sRet = "<center><a href=""" & sRedirUrl & """ target='_blank' >" & "<img src=images/"& sGifUrl &" alt=""" & sAltText & """" & " border=0  width=""" & nXSize & """" & " height=""" & nYSize & """" &  ">"  & "</a>"
    If sUnderText <> "" Then
        sRet = sRet & "<br><font face=""arial"" size=""1""><a href=""" & sUnderUrl & """" & ">" & sUnderText & "</a></font>"
    Else
        '
    End If
    sRet = sRet & "</center>"
    
    Else
    sRet="<center><embed src=images/"&oRS("gifurl").Value&" quality=high WIDTH=468 HEIGHT=60 TYPE=application/x-shockwave-flash></center>"
    End If    
    '-----------------------------------
    
    AdMentor_GetAdEx = sRet
    
    ' Lets update impression for it
    AdMentor_DBAddShowCount oConn, nBanner 
    oRS.Close
    Set oRS = Nothing	 
    oConn.Close
    Set oConn = Nothing
End Function



Public Function AdMentor_ClickAd(nBannerId, sWay)
    Dim oConn
    Dim sSQL
    Dim sSQL2
    Dim oRS
    Dim sRedir
	Dim fIsUnderText    
	
	If sWay ="txt" Then
		fIsUnderText = true
	Else
		fIsUnderText = false ' Clicked on actual banner
	End If
    
    
    'Pretty easy...
    Set oConn = AdMentor_DBOpenConnection()
    
   	AdMentor_DBUpdateClickCount oConn, nBannerId, fIsUnderText 
	sRedir = AdMentor_DBGetUrl( oConn, nBannerId, fIsUnderText )    	
    
    oConn.Close
    Set oConn = Nothing
    
    AdMentor_ClickAd = sRedir
End Function


Private Function FixupSpecialVariables( sHTML )
	'Now check for '<ADM_RANDOM
	Dim fCont
	fCont = True
	While fCont = True
		Dim nIndStart, nIndEnd, sSubStr, vData, nLow, nHigh, nNumber
		Dim sLeftHTML, sRightHTML
		
		nIndStart = InStr( 1,CStr(sHTML), "<ADM_RANDOM" )
		If nIndStart > 0 Then
			sLeftHTML = Left( sHTML, nIndStart -1 )
			
			nIndEnd = InStr( nIndStart, sHTML, ">" )

			sRightHTML = Mid( sHTML, nIndEnd + 1 )

			sSubStr = Mid( sHTML, nIndStart, nIndEnd - nIndStart )

			vData = Split( sSubStr, "-")
			If vData(1) = "LAST" Then
				nNumber = Session("AdMentor_RndNumber")
			Else
				nLow = CLng(vData(1))
				nHigh = CLng(vData(2))
    			Randomize
    			nNumber = CLng((nHigh * Rnd) + nLow)
    			Session("AdMentor_RndNumber") = nNumber
    		End If
			sHTML = sLeftHTML & CStr(nNumber) & sRightHTML
		End If
		If InStr( 1,CStr(sHTML), "<ADM_RANDOM" ) > 0 Then
			fCont = True
		Else
			fCont = False
		End If
	Wend
	FixupSpecialVariables = sHTML
End Function


Public Function GetAdminPagesBannerCode()
	'Want to advertise on your admin pages?
	'Then just change this function to what you want...
	'What I do is just call AdMentorGetAd with a special banner id
	'to get by Datais-banners showed
'	Dim sRet
'	sRet = AdMentor_GetAdASP("B=93")
	GetAdminPagesBannerCode = ""
End Function

%>