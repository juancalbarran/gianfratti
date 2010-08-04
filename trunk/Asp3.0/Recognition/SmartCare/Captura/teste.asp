<%

Set Upload = Server.CreateObject("LEAD.Upload")


set files = Upload.Upload

Upload.Save "c:\inetpub\wwwroot\SmartCare\Captura\Imagens\"

' Process all files received
For Each File in Files
      Response.Write File.Name & " = " & File.FileName & "<BR>"
      Response.Write "Size = " & File.Size & "<BR>"
      Response.Write "<BR><BR>"
Next
%>