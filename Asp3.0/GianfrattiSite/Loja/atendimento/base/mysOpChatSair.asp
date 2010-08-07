<!--#include file="db.asp"-->
<%
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	Session.LCID = 1033
	
intID = Request.QueryString("ID")
	
If intID <> "" Then
	
	Call AbreDB
	
	strUltMsg 		  = FormataData(now,"yyyy/mm/dd hh:nn:ss")
	
	intOperadorID =		OK(Request.QueryString("OperadorID"))
	
	strMensagem = Session("mysOpNome") & " deixou o atendimento."
	
	strMensagem = "<font id=""mysChatFinalizado"" color=""#0000FF""><b>&nbsp;</b>" & Server.HTMLEncode(strMensagem) & "</font><br><br>"
		strSQL = "UPDATE conversas SET ult_msg = #"& strUltMsg &"#, texto = texto & '" & strMensagem & "' WHERE operador = "& intOperadorID &" AND id = " & intID
	Conexao.Execute(strSQL)
	Call FechaDB
End If
%>
<script language="JavaScript">
	window.close();
</script>
