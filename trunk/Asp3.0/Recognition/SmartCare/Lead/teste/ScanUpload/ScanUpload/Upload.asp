<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset="ascii"><%
Session("User_ID") = 1 'Demo
Set Upload		= Server.CreateObject("LEAD.Upload")
Set LeadRaster		= Server.CreateObject("LEADRaster.LEADRaster.140")
Set LeadRasterIO	= Server.CreateObject("LEADRasterIO.LEADRasterIO.140")

Const FILE_JFIF      = 10
Const FILE_CMP       = 5
Const SAVE_OVERWRITE = 0

Dim nBits
Dim nQFactor
Dim FileFormat
Dim sSuffix
Dim nSave

Dim DiskPath
Dim URLPath
Dim OutputToClient

nBits = 24
nQFactor = 2
FileFormat = FILE_JFIF
sSuffix = "jpg"
nSave = SAVE_OVERWRITE
set files = Upload.Upload
'Process all files received
DiskPath= "C:\Inetpub\wwwroot\ScanUpload\Uploads\"
URLPath = "//travis/ScanUpload/Uploads/"
Randomize
For each file in files
	ImageName = cstr(rnd)
	'ImageName = Session.SessionID
	result = LeadRasterIO.LoadArray2(LeadRaster, File.Data, 0, 1, 1, file.size)
	if result = 0 then
            ImageName = ImageName & "." & sSuffix	  
            result = LeadRasterIO.Save(LeadRaster, DiskPath & ImageName, FileFormat, nBits, nQFactor, nSave)
            OutputToClient = "<html><img src=" + URLPath & ImageName + "> </img></html>"
            Response.Write OutputToClient
	  if result <> 0 then
		Response.Write "Error in Save to Disk: " + CStr(result)
	  End If
	Else
		Response.Write "Error in LoadArray2: " + CStr(result)
	End if 
next 


%> <META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY>
<P>&nbsp;</P></BODY></HTML>
