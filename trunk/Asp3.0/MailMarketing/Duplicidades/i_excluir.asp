<%
	Id = request("Id")
	chk = request("chk")
	
	sSQL = "Delete * from Contatos Where Contato_CD "
	If id <> "" Then
		sSQL = sSQL & " = " & id
	Else
		sSQL = sSQL & " In (" & chk & ")"
	End If
	
	ExecuteSQL(sSQL)
	mensagem = "Registro(s) apagado(s) com sucesso!"

	Response.Redirect("p_duplicidades.asp?opcao=1&acao=1&mensagem=" & mensagem)
	
%>