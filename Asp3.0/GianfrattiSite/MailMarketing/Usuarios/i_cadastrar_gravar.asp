<%
Usuario_CD 		= fnInteger(Request("Usuario_CD"))
Usuario_NM		= fnString(Request("Usuario_NM"))
Usuario_eMail	= fnString(Request("Usuario_eMail"))
Usuario_Login	= fnString(Request("Usuario_Login"))
Usuario_Senha	= fnString(Request("Usuario_Senha"))


iUser			= Session("iUser")

sSql = Empty

If opcao=1 AND acao=2 Then

	If Session("gravado") <> 1 Then
		
		sSql = sSql & " Insert Into Usuarios (Usuario_NM, Usuario_eMail, Usuario_Login, Usuario_Senha) Values "
		sSql = sSql & " (" & Usuario_NM & ", " & Usuario_eMail & "," & Usuario_Login & "," & Usuario_Senha & ")"
		
		ExecuteSQL(sSql)
		
		Session("gravado")=1
		
	End If

	mensagem = "GRAVADO COM SUCESSO!"

Elseif opcao=2 And acao=3 Then
	
	sSql = sSql & " UPDATE Usuarios SET "
	
	sSql = sSql & " Usuario_NM = " 		& Usuario_NM
	sSql = sSql & ", Usuario_eMail = " 	& Usuario_eMail
	sSql = sSql & ", Usuario_Login = " 	& Usuario_Login
	sSql = sSql & ", Usuario_Senha = " 	& Usuario_Senha

	sSql = sSql & " Where Usuario_CD = " & Usuario_CD
	
	ExecuteSQL(sSql)
	
	mensagem = "ATUALIZADO COM SUCESSO!"

ElseIf Opcao=3 And Acao=2 Then

	Id = request("Id")
	chk = request("chk")
	
	On Error Resume Next
		
		sSQL = "Delete * From Usuarios where Usuario_CD"
		If id <> "" Then
			Where = " = " & Id
		Else
			Where = " In (" & chk & ")"
		End If
		
		ExecuteSQL(sSql & Where)
		
		If Err.Number <> 0 Then
			sSql = "update Usuarios set deletado = 1 where Usuario_CD " & Where
			ExecuteSQL(sSql)
		End If
	
	On Error GoTo 0 

	mensagem = "Registro(s) apagado(s) com sucesso!"
	
	Response.Redirect("p_Usuarios.asp?opcao=3&acao=1&mensagem=" & mensagem)
	
End if
%>
<table cellpadding="0" cellspacing="0" width="100%" height="90%" border="0">
	<tr>
		<td align="center" class="Font10Vermelho"><% =mensagem %><br><br>
			<% If opcao=1 Then %>
				<input type="buttom" name="Cadastrar" value="Cadastrar novo" class="buttom" onclick="location.href('p_Usuarios.asp?opcao=1&acao=1');">
			<% Else %>
				<input type="buttom" name="Alterar" value="Alterar Outro" class="buttom" onclick="location.href('p_Usuarios.asp?opcao=2&acao=1&id=<%=Usuario_CD%>');">
			<% End if %>
		</td>
	</tr>
</table>