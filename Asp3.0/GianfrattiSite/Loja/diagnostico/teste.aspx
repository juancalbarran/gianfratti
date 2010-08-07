<%@ Page Language="VB" Debug="False" %>
<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="System.Drawing.Imaging" %>
<%@ Import Namespace="System.Drawing.Text" %>
<%
Dim objBMP        As System.Drawing.Bitmap
Dim objGraphics   As System.Drawing.Graphics
Dim objFont       As System.Drawing.Font
objBMP = New Bitmap(280, 28)
objGraphics = System.Drawing.Graphics.FromImage(objBMP)
objGraphics.Clear(Color.Blue)
objGraphics.TextRenderingHint = TextRenderingHint.AntiAlias
objFont = New Font("Verdana", 8, FontStyle.Bold)
objGraphics.DrawString(Request.QueryString("text"), objFont, Brushes.White,  50, 5)
Response.ContentType = "image/GIF"
objBMP.Save(Response.OutputStream, ImageFormat.Gif)
objFont.Dispose()
objGraphics.Dispose()
objBMP.Dispose()
%>
