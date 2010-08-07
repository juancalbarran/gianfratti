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

origem	= Request.QueryString("origem")
modo	= Request.QueryString("modo")
tecla	= Request.QueryString("tecla")
intID	= Request.QueryString("ID")

If origem = "us" Then
	
	If modo = "verifica" Then
		strSQL = "SELECT tecla_op FROM conversas WHERE id = " & Session("mysConversaID")
		Set rs = Conexao.Execute(strSQL)
		If rs("tecla_op") Then
			Response.Redirect "1px.gif" 'Teclando
		Else
			Response.Redirect "2px.gif" 'Não teclando
		End If
	Else
		If tecla = "SIM" Then
			strSQL = "UPDATE conversas SET tecla_us = True WHERE id = " & Session("mysConversaID")
		Else
			strSQL = "UPDATE conversas SET tecla_us = False WHERE id = " & Session("mysConversaID")
		End If
		Conexao.Execute(strSQL)
		Response.Redirect "1px.gif" 'Teclando
	End If
Else

	If modo = "verifica" Then
		strSQL = "SELECT tecla_us FROM conversas WHERE id = " & intID
		Set rs = Conexao.Execute(strSQL)
		If rs("tecla_us") Then
			Response.Redirect "1px.gif" 'Teclando
		Else
			Response.Redirect "2px.gif" 'Não teclando
		End If
	Else
		If tecla = "SIM" Then
			strSQL = "UPDATE conversas SET tecla_op = True WHERE id = " & intID
		Else
			strSQL = "UPDATE conversas SET tecla_op = False WHERE id = " & intID
		End If
		Conexao.Execute(strSQL)
		Response.Redirect "1px.gif" 'Teclando
	End If

End If
rs.close
Call FechaDB
%>
