<%
response.buffer = true
response.expires = 0
response.expiresabsolute = Now() - 1
response.addHeader "pragma","no-cache"
response.addHeader "cache-control","private"
Response.CacheControl = "no-cache"
Session.LCID = 1033

If inStr(LCase(Request.ServerVariables("HTTP_REFERER")), "http://" & LCase(Request.ServerVariables("HTTP_HOST"))) = 0 Then Response.End

%>
<!--#include file="db.asp"-->
<%
Call AbreDB

Dim opcao

opcao 	=	Request.QueryString("opcao")
intID	=	OK(Request.QueryString("ID"))

If Session("mysOperadorID") = "" Then
	intOperadorID = OK(Request.QueryString("OperadorID"))
Else
	intOperadorID = Session("mysOperadorID")
End If

agora = FormataData(now,"yyyy/mm/dd hh:nn:ss")
strSQL = "UPDATE operadores SET ping = #"&agora&"# WHERE id = " & intOperadorID
Conexao.Execute(strSQL)

If opcao = "" Then	'Verifica Novo Chamado
	strSQL = "SELECT count(id) AS Total FROM conversas WHERE status = True AND operador = 0 AND departamentoID = " & Session("mysDepartamentoID")
	Set rs = Conexao.Execute(strSQL)
	If CInt(rs("Total")) <> Session("mysChamados") Then
		Session("mysChamados") = CInt(rs("Total"))
		Response.Redirect "1px.gif"
	Else
		Response.Redirect "2px.gif"
	End If
Else 'Verifica ultima msg
	strSQL = "UPDATE conversas SET ping_operador = #"&agora&"# WHERE id = " & intID
	
	Conexao.Execute(strSQL)
	strSQL = "SELECT DateDiff(""s"", ult_msg, ping_operador) AS Segundos FROM conversas WHERE id = " & intID
	Set rs = Conexao.Execute(strSQL)
	If cint(rs("Segundos")) <= 5 Then
		Response.Redirect "1px.gif"
	Else
		Response.Redirect "2px.gif"
	End If
End If

rs.close
Call FechaDB
%>
