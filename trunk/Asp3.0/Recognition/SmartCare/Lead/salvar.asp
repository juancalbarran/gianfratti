<%
'   Set FTPObj = CreateObject("LEADRasterFTP.LEADRasterFTP")
'   Set RasterObj = CreateObject("LEADRaster.LEADRaster")
'   Set IOObj = CreateObject("LEADRasterIO.LEADRasterIO")
'   FTPObj.EnableMethodErrors = False

'Response.Buffer = false
Set Upload		= Server.CreateObject("LEAD.Upload.1")
Set Raster 		= Server.CreateObject("LEADRaster.LEADRaster")
Set RasterProc 	= Server.CreateObject("LEADRasterProcess.LEADRasterProcess")
Set RasterIO 	= Server.CreateObject("LEADRasterIO.LEADRasterIO")
Set RVar 	= Server.CreateObject("LEADRasterVariant.LEADRasterVariant")



%>