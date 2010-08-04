<%



s = request.servervariables("REMOTE_ADDR")
IP	= Left(S,3)



Response.Write(IP)


If IP = "192" Then
	Response.Write("Endereço Interno"
Else
	Response.Write("Endereço Externo")
End If



%>