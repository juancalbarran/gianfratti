<% @ LANGUAGE = VBSCRIPT %>
<%
Response.expires = -1000
Response.expiresabsolute = Now() - 1
Response.addHeader "pragma","no-cache"
Response.addHeader "cache-control","private"
Response.CacheControl = "no-cache"
Server.ScriptTimeout = 900
%>
<% Response.buffer = false%>

<html>
<head>
<title>LEAD Image Processing Web Server Demo</title>
<script language="JavaScript" src="menucode.js"></script>
<%
CONST 	IMAGE_FOLDER		= "C:\Inetpub\wwwroot\ScanUpload\Images\"
CONST 	UPLOAD_FOLDER		= "C:\Inetpub\wwwroot\ScanUpload\Uploads\"
CONST 	LOGO_IMAGE 		= "C:\Inetpub\wwwroot\ScanUpload\LEAD.jpg"

Sub OnSessionEnd()
	sNewFileName = IMAGE_FOLDER & Session.SessionID & ".jpg"
	sOldFileName = IMAGE_FOLDER & Session.SessionID & "Temp.jpg"

	if fs.FileExists(sNewFileName) then
		fs.DeleteFile sNewFileName
	end if

	if fs.FileExists(sOldFileName) then
		fs.DeleteFile sOldFileName
	end if

	Session.Abandon 

End Sub

Sub OnSessionStart()
	dim sStartImage

	Session("Start") = "false"

	sStartImage = IMAGE_FOLDER & Session.SessionID & ".jpg"

	set fs=CreateObject("Scripting.FileSystemObject")
	fs.CopyFile LOGO_IMAGE, sStartImage
	Set fs = nothing
End Sub

%>
<link rel="STYLESHEET" href="../stylegeneric.css" media="screen" type="text/css">
<script ID="clientEventHandlersJS" LANGUAGE="javascript">
<!--

function RasterTwain_AquirePageEvent(pBitmap)
{
    var strResponse;
    var hWnd;
    RasterView.Raster.RasterUNK.Bitmap = pBitmap;
    strResponse = HTTPSubmit();
    hWnd = window.open("", "", "width=336,height=336,menubar=0,dependent=0,scrollbars=0,resizable=1");    
    hWnd.document.write(strResponse);
}

var ImgCounter=0;
function Scan_onclick() 
{
   if (HTTPSite.value == "")
   {
      alert("Enter http site to upload");
      return;
   }
   
   //if(hWnd != 0)
   //{
   //    window.close("strResponse");
   //}
   
    ScanImage();
}
function window_onload() {
   var i;   

    hWnd = 0;
   RasterTwain.InitSession(RasterView.Window);
   RasterTwain.EnableMethodErrors = false;
   TwainSource.length = RasterTwain.SourceCount;
   for (i = 0; i < RasterTwain.SourceCount; i++)
        TwainSource.options(i).text = RasterTwain.SourceName(i);
   TwainSource.selectedIndex = 0;
}

function window_onunload(){
  RasterTwain.EndSession();
}

//-->
</script>
<SCRIPT LANGUAGE=javascript FOR=RasterTwain EVENT="AcquirePageEvent(pBitmap)" >
<!--
 RasterTwain_AquirePageEvent(pBitmap)
//-->
</SCRIPT>

</head>
<body BGCOLOR="#ffffff" LANGUAGE=javascript onload="return window_onload()" onunload="return window_onunload()">
<script language="JavaScript" src="buildmenu.js"></script>
<div align="center">
<table width="700" align="center">
<tr><td>
      <center>
<br><br><br></center>
      <center><br>
<p align="center">
<IMG height=49 src="lead.jpg" width=237>
</p>
<font face="Arial" size="2"><strong>Scan Upload Demo using LEAD COM Objects on the Server</strong></font></center>
      <CENTER><em>Scan your image to upload it.</em> </center>
      <CENTER><em>The image scanned will be saved on the server.</em></CENTER>
      <CENTER><em>A pop will then appear with the image from the server.</em></CENTER>      
      <CENTER><font face="Arial" size="2"><strong>Note: Disable your popup blocker to see the popup!</strong></font></center>
      <CENTER>&nbsp;</CENTER>
      <CENTER>Please&nbsp;specify your server (www.): &nbsp; <INPUT id=HTTPSite name=HTTPSite></CENTER>
      <CENTER>&nbsp;</CENTER>
      <CENTER>&nbsp;Please select your twain source 
      <SELECT 
      id=TwainSource style="WIDTH: 200px" name=TwainSource LANGUAGE="javascript""> <OPTION 
        selected></OPTION><OPTION></OPTION></SELECT></CENTER>
      <CENTER>&nbsp;</CENTER>
      <CENTER><input id="Scan" style="LEFT: 318px; TOP: 121px" type="button" value="Scan" name="Scan" LANGUAGE="javascript" onclick="return Scan_onclick()"></CENTER>
      <CENTER>&nbsp;</CENTER>
<%
	Dim pathInfo
	Dim bFlag

	if Session("Finish")= "true" or Response.IsClientConnected = false  then
		OnSessionEnd()
	end if

	if Session("Start") = "true" then
		OnSessionStart
	end if
	
	Session("CurAction")= Request.Form("MenuItem")	   
%>
</td></tr>
</table></div>
<p align="center">

<object classid="clsid:5220cb21-c88d-11cf-b347-00aa00a28331"
align="baseline" border="0" width="1" height="1">
<param name="LPKPath" value="LTRVW14n.lpk">
</object>

<OBJECT id=RasterView 
style="LEFT: 0px; WIDTH: 370px; TOP: 0px; HEIGHT: 294px; BACKGROUND-COLOR: #e1e6ff" 
height=294 width=370 
data=data:application/x-oleobject;base64,CAcTALqxzhGrxvWy552ePwICAAA+JgAAYx4AABMA4ODgAAMAAAAAAAMAAAAAAAMAAAAAAAkAAAAAAAAAAAAAAAAAAAAAAAsA//8EAAAAAAAEAAAAAAAEAAAAAAAEAAAAAAADAAMAAAALAP//CwAAAAsA//8LAAAACwD//wMAAAAAAAMAAAAAAAMAAAAAAAQAAADIQgsAAAADAAEAAAALAAAAAgAAAAIAZAACAAAACwAAAAMAAAAAAAsAAAAEAAAAAAATAAAAAAADAAAAAAAEAAAAAAATAP///wATAICAgAADAAAAAAAEAAAAAAATAP///wATAICAgAALAP//CwAAAAQAAAAAAAQAAAAAAAQAAAAWQwQAAAAWQxMAAAAAAAgAAgAAAAAACwD//wMAAAAAAAMAAAAAAAMAAAAAAAMAAAAAAAkAAAAAAAAAAAAAAAAAAAAAAAkAAAAAAAAAAAAAAAAAAAAAAAIAAAADAOgDAAADAAAAAAADAOgDAAADAAAAAAATAAAA/wATAAAAAAACABAAAwAAAAAAEwAAAAAAEwAAAAAAAgABAAIABQACAAAAAgAAABMAAAAAAAIAAAALAP//AgABAAsAAAADAAAAAAALAAAAAgAAAAIAAQACAAEACwAAAAsA//8CAAAAAgBkAAIAAAA= 
classid=CLSID:00140708-B1BA-11CE-ABC6-F5B2E79D9E3F codebase="ScanUpload_n.cab"  name=RasterView 
VIEWASTEXT></OBJECT>

<OBJECT id=RasterTwain classid=CLSID:00140752-B1BA-11CE-ABC6-F5B2E79D9E3F 
name=RasterTwain></OBJECT>

<OBJECT id=RasterHTTP classid=CLSID:00140741-B1BA-11CE-ABC6-F5B2E79D9E3F 
name=RasterHTTP></OBJECT>

</p>
<p align="center">
<script language="vbscript">

Function ScanImage()
   L_LTWAIN_SHOW_USER_INTERFACE = 1

   RasterTwain.AcquireSourceName = RasterTwain.SourceName(TwainSource.selectedIndex)
   RasterTwain.Acquire L_LTWAIN_SHOW_USER_INTERFACE
End Function

Function HTTPSubmit() 

 Dim nRet, strResponse, nStatus, NV
 Dim HTTP_RQST_GET, HTTP_STATUS_OK
 Dim FILE_JFIF
 
 HTTP_RQST_GET  = 0
 HTTP_STATUS_OK = 200
 FILE_JFIF      = 10
 FILE_CMP       = 5
 
 window.status="Uploading and processing Image " & cstr(imgCounter)

   RasterHTTP.EnableMethodErrors = false
   Set NV = CreateObject("NAMEVALUEItem.NAMEVALUEItem.140")

   nRet = RasterHTTP.InetHttpConnect(HTTPSite.value, 80, "", "")
   If nRet = 0 Then
      nRet = RasterHTTP.InetHttpOpenRequest(HTTP_RQST_GET, "/ScanUpload/Upload.asp?", "", "HTTP/1.0")
      If nRet = 0 Then
	Dim raster
			
	NV.pszName = HTTPSite.value
	NV.pszValue = HTTPSite.value
	nStatus = RasterHTTP.InetHttpGetServerStatus() 
			
	Set raster = RasterView.Raster	nRet = RasterHTTP.InetHttpSendBitmap(RasterView.Raster, FILE_JFIF, 24, 50, "image/jpg", NV)
	'nRet = RasterHTTP.InetHttpSendBitmap(RasterView.Raster, FILE_CMP, 24, -1, "image/cmp", NV)			
        If nRet <> 0 Then
           MsgBox "Error Sending Image: " + CStr(nRet), , "Error"
              RasterHTTP.InetHttpCloseRequest
              RasterHTTP.InetHttpDisconnect
              Exit Function
        End If
         
        nStatus = RasterHTTP.InetHttpGetServerStatus()
        If nStatus = HTTP_STATUS_OK Then
            strResponse = RasterHTTP.InetHttpGetResponse()
            If strcomp(strResponse, "refresh", 1) = 0 Then 
               RefreshBrowser = -1
            else                
                HTTPSubmit = strResponse                
            End if               
        Else
           strResponse = RasterHTTP.InetHttpGetResponse()	   
           Document.Write strResponse	   
        End If

        RasterHTTP.InetHttpCloseRequest
      End If
      RasterHTTP.InetHttpDisconnect
   End If
   window.status =""
End Function
</script></p>
</body>
</html>

