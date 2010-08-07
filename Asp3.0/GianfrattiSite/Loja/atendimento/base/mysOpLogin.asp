<!--#include file="db.asp"-->
<%
Dim strOpcao, strSenha, strLogin, strSQL

strSenha = OK(Request.Form("senha"))
strLogin = OK(Request.Form("login"))
strOpcao = OK(Request.Form("opcao"))

Call AbreDB()

strSQL	= "SELECT id, departamentoID, login, senha, nivel FROM operadores WHERE login='"&strLogin&"'"
Set rs = Conexao.execute(strSQL)

If rs.BOF AND rs.EOF Then
	Response.Write "<script>alert(""Usuário ou senha inválidos!"");</script>"
	Response.Write "<script>location.href=""default.asp"";</script>"
Else
	If rs("senha") = strSenha Then
		
		If rs("nivel") => 5 AND strOpcao = "admin" Then
			Session("mysAdmin")  = True
			Session("mysAdminID")= rs("id")
			Response.Write "<script>location.href=""mysAdmIndex.asp"";</script>"
		ElseIf strOpcao = "atend" Then
			Session("mysOP") = True
			Session("mysDepartamentoID") = rs("departamentoID")
			Session("mysOperadorID") 	  = rs("id")
			Session("mysChamados") 	  = 0
			Response.Write "<script>location.href=""mysOpIndex.asp"";</script>"
		Else
			Response.Write "<script>alert(""Acesso negado!"");</script>"
		Response.Write "<script>location.href=""default.asp"";</script>"
		End If
		
	Else
		Response.Write "<script>alert(""Usuário ou senha inválidos!"");</script>"
		Response.Write "<script>location.href=""default.asp"";</script>"
	End If
End If

rs.close
Call FechaDB()
%>