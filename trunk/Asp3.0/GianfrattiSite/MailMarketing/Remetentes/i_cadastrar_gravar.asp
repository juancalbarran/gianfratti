<%
Remetente_CD 		= fnInteger(Request("Remetente_CD"))
Remetente_NM		= fnString(Request("Remetente_NM"))
Remetente_eMail		= fnString(Request("Remetente_eMail"))
Remetente_SMTP		= fnString(Request("Remetente_SMTP"))

iUser			= Session("iUser")

sSql = Empty

If opcao=1 AND acao=2 Then

	If Session("gravado") <> 1 Then
		
		sSql = sSql & " Insert Into Remetentes (Remetente_NM, Remetente_eMail, Remetente_SMTP) Values "
		sSql = sSql & " (" & Remetente_NM & "," & Remetente_eMail & "," & Remetente_SMTP & ")"
		
		ExecuteSQL(sSql)
		
		Session("gravado")=1
		
	End If

	mensagem = "GRAVADO COM SUCESSO!"

Elseif opcao=2 And acao=3 Then
	
	sSql = sSql & " UPDATE Remetentes SET "
	
	sSql = sSql & " Remetente_NM = " 			& Remetente_NM
	sSql = sSql & " ,Remetente_eMail = " 		& Remetente_eMail
	sSql = sSql & " ,Remetente_SMTP = " 		& Remetente_SMTP
	
	sSql = sSql & " Where Remetente_CD = " & Remetente_CD
	
	ExecuteSQL(sSql)
	
	mensagem = "ATUALIZADO COM SUCESSO!"

ElseIf Opcao=3 And Acao=2 Then
	
	Id = request("Id")
	chk = request("chk")
	
	sSql = "Delete * from Remetentes Where Remetente_CD "
	If id <> "" Then
		sSql = sSql & " = " & Id
	Else
		sSql = sSql & " In (" & chk & ")"
	End If
	
	ExecuteSQL(sSql)
	mensagem = "Registro(s) apagado(s) com sucesso!"
	
	Response.Redirect("p_remetentes.asp?opcao=3&acao=1&mensagem=" & mensagem)
	
End if
%>
<table cellpadding="0" cellspacing="0" width="100%" height="90%" border="0">
	<tr>
		<td align="center" class="Font10Vermelho"><% =mensagem %><br><br>
			<% If opcao=1 Then %>
				<input type="buttom" name="Cadastrar" value="Cadastrar novo" class="buttom" onclick="location.href('p_remetentes.asp?opcao=1&acao=1');">
			<% Else %>
				<input type="buttom" name="Alterar" value="Alterar Outro" class="buttom" onclick="location.href('p_remetentes.asp?opcao=2&acao=1&id=<%=Remetente_CD%>');">
			<% End if %>
		</td>
	</tr>
</table>