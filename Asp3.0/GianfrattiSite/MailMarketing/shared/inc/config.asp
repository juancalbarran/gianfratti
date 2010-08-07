<%
	'[CONFIGURAÇÕES DA PÁGINA]
	Response.Charset = "ISO-8859-1"
	Response.Expires = -1
	Response.ExpiresAbsolute = Now() - 1
	Response.AddHeader "Cache-Control", "Private"
	Response.AddHeader "Pragma", "No-Cache"
	Server.ScriptTimeout = 7200 'NSeconds
	Session.Timeout = 60 'NMinutes
	Response.Buffer = True
	Session.LCID = 1046
%>