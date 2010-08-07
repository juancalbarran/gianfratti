<%
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	Session.LCID = 1033

Call AbreDB
	strSQL = "SELECT * FROM config"
	Set rs = Conexao.Execute(strSQL)
	If NOT rs.EOF Then
		strConfigNome		= rs("nome")
		strConfigEndereco	= rs("endereco")
		strConfigEmail		= rs("email")
		strConfigLogo		= rs("logo")
		strConfigOnline		= strConfigEndereco& "/"& rs("imgOn")
		strConfigOffline	= strConfigEndereco& "/"& rs("imgOff")
		strConfigTopo		= rs("corTopo")
		strConfigFonte		= rs("corFonte")
		strConfigTempo		= rs("tempoEspera")
	End If
Call FechaDB
%>