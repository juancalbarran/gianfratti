<%
Const adTypeBinary = 1
Dim strFilePath

response.AddHeader "Content-Type","application/x-msdownload"
response.AddHeader "Content-Disposition","attachment; filename=" & Request("ArquivoZ")
Response.Flush

Set objStream = Server.CreateObject("ADODB.Stream")
objStream.Open
objStream.Type = adTypeBinary
objStream.LoadFromFile Replace(Request("NomeZ"), "~barra~", "\")
Response.BinaryWrite objStream.Read
objStream.Close
Set objStream = Nothing
Response.Flush
%>