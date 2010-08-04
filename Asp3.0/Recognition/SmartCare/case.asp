<%
dom = Request.ServerVariables("SERVER_NAME")

Select Case dom
	Case "fmanes"
		Response.Write "sds"
		'Response.Redirect "http://www.seusite.com/subdominio/index.html"
	Case "www.seusite.com"
		'Response.Redirect "/home.html"
	'Case Else
		'response.Write "sdfds"
End Select
%> 