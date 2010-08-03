<%
Grupo_CD 		= fnInteger(Request("Grupo_CD"))
Grupo_NM		= fnString(Request("Grupo_NM"))
Grupo_Descricao	= fnString(Request("Grupo_Descricao"))

iUser			= Session("iUser")

sSql = Empty

If opcao=1 AND acao=2 Then

	If Session("gravado") <> 1 Then
		
		sSql = sSql & " Insert Into Grupos (Grupo_NM, Grupo_Descricao) Values "
		sSql = sSql & " (" & Grupo_NM & ", " & Grupo_Descricao & ")"
		
		ExecuteSQL(sSql)
		
		Session("gravado")=1
		
	End If

	mensagem = "GRAVADO COM SUCESSO!"

Elseif opcao=2 And acao=3 Then
	
	sSql = sSql & " UPDATE Grupos SET "
	
	sSql = sSql & " Grupo_NM = " 			& Grupo_NM
	sSql = sSql & ", Grupo_Descricao = " 	& Grupo_Descricao
	
	sSql = sSql & " Where Grupo_CD = " & Grupo_CD
	
	ExecuteSQL(sSql)
	
	mensagem = "ATUALIZADO COM SUCESSO!"

ElseIf Opcao=3 And Acao=2 Then
	
	Id = request("Id")
	chk = request("chk")
	
	On Error Resume Next
		
		sSQL = "Delete * From Grupos where Grupo_CD"
		If id <> "" Then
			Where = " = " & Id
		Else
			Where = " In (" & chk & ")"
		End If
		
		ExecuteSQL(sSql & Where)
		
		If Err.Number <> 0 Then
			sSql = "update Grupos set deletado = 1 where Grupo_CD " & Where
			ExecuteSQL(sSql)
		End If
	
	On Error GoTo 0 
	
	ExecuteSQL(sSql)
	mensagem = "Registro(s) apagado(s) com sucesso!"
	
	Response.Redirect("p_grupos.asp?opcao=3&acao=1&mensagem=" & mensagem)

	
End if
%>
<table cellpadding="0" cellspacing="0" width="100%" height="90%" border="0">
	<tr>
		<td align="center" class="Font10Vermelho"><% =mensagem %><br><br>
			<% If opcao=1 Then %>
				<input type="buttom" name="Cadastrar" value="Cadastrar novo" class="buttom" onclick="location.href('p_grupos.asp?opcao=1&acao=1');">
			<% Else %>
				<input type="buttom" name="Alterar" value="Alterar Outro" class="buttom" onclick="location.href('p_grupos.asp?opcao=2&acao=1&id=<%=Grupo_CD%>');">
			<% End if %>
		</td>
	</tr>
</table>