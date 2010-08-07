<%
response.buffer = true
response.expires = 0
response.expiresabsolute = Now() - 1
response.addHeader "pragma","no-cache"
response.addHeader "cache-control","private"
Response.CacheControl = "no-cache"
Session.lCid = 1033

If inStr(LCase(Request.ServerVariables("HTTP_REFERER")), "http://" & LCase(Request.ServerVariables("HTTP_HOST"))) = 0 Then Response.End

%>
<!--#include file="db.asp"-->
<%
Call AbreDB

Dim opcao

opcao = Request.QueryString("opcao")

If opcao = "" Then	'Verifica Atualizacao Chat
	
	agora = FormataData(now,"yyyy/mm/dd hh:nn:ss")
	strSQL = "UPDATE conversas SET ping_usuario = #"&agora&"# WHERE id = " & Session("mysConversaID")
	Conexao.Execute(strSQL)
	
	strSQL = "SELECT DateDiff(""s"", ult_msg, ping_usuario) AS Segundos FROM conversas WHERE id = " & Session("mysConversaID")
	Set rs = Conexao.Execute(strSQL)
	
	If cint(rs("Segundos")) <= 5 Then
		Response.Redirect "1px.gif"
	Else
		Response.Redirect "2px.gif"
	End If
Else 'Verifica inicio atendimento
	strSQL = "SELECT operador FROM conversas WHERE status = True AND id = " & Session("mysConversaID")
	Set rs = Conexao.Execute(strSQL)
	If rs("operador") = 0 OR isNull(rs("operador")) Then
		Response.Redirect "1px.gif" 'nao atendido
	Else
		Response.Redirect "2px.gif" 'atendido
	End If
End If

rs.close
Call FechaDB
%>
