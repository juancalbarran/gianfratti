<%
Contato_CD 		= fnInteger(Request("Contato_CD"))
Contato_NM		= fnString(Request("Contato_NM"))
Contato_eMail	= fnString(Request("Contato_eMail"))

iUser			= Session("iUser")

sSql = Empty

If opcao=1 AND acao=2 Then

	If Session("gravado") <> 1 Then
		
		On Error Resume Next
		
		Call Conecta()
		
			Conn.BeginTrans
			
				sSql = sSql & " Insert Into Contatos (Contato_NM, Contato_eMail) Values "
				sSql = sSql & " (" & Contato_NM & ", " & Contato_eMail & ")"
				Conn.Execute(sSql)
					
						Contato_CD = Conn.Execute(" Select @@Identity ")(0).Value
					
							For Each sItem in Request.Form("Grupo_CD")
								sSql = " INSERT INTO GRUPOS_CONTATOS (Contato_CD,Grupo_CD) VALUES (" & Contato_CD & ",'" & sItem & "'); "
								If not isEmpty(sSQL) Then Conn.Execute(sSql)
							Next
						
									
			If Err.Number <> 0 Then
				Conn.RollBackTrans
				mensagem = "ERRO AO TENTAR GRAVAR, TENTE NOVAMENTE!"
				Erro=1
			Else
				Conn.CommitTrans
				mensagem = "GRAVADO COM SUCESSO!"
				Session("gravado")=1
			End If
			
			
		Call DesConecta()
		
		On Error GoTo 0
	
	Else
	
		mensagem="GRAVADO COM SUCESSO!"
			
	End If


Elseif opcao=2 And acao=3 Then
	
	If Session("gravado") <> 1 Then
		
		On Error Resume Next
		
		Call Conecta()
		
			Conn.BeginTrans
			
					sSql = sSql & " UPDATE Contatos SET "
					
					sSql = sSql & " Contato_NM = " 		& Contato_NM
					sSql = sSql & ", Contato_eMail = " 	& Contato_eMail
				
					sSql = sSql & " Where Contato_CD = " & Contato_CD
					Conn.Execute(sSql)
					
						sSQL = " Delete * from GRUPOS_CONTATOS Where Contato_CD = " & Contato_CD
						Conn.Execute(sSql)
						
							For Each sItem in Request.Form("Grupo_CD")
								sSql = " INSERT INTO GRUPOS_CONTATOS (Contato_CD,Grupo_CD) VALUES (" & Contato_CD & ",'" & sItem & "'); "
								If not isEmpty(sSQL) Then Conn.Execute(sSql)
							Next
							
			If Err.Number <> 0 Then
				Conn.RollBackTrans
				mensagem = "ERRO AO TENTAR ATUALIZAR, TENTE NOVAMENTE!"
				Erro=1
			Else
				Conn.CommitTrans
				mensagem = "ATUALIZADO COM SUCESSO!"
				Session("gravado")=1
			End If
			
			
		Call DesConecta()
		
		On Error GoTo 0
	Else
	
		mensagem = "ATUALIZADO COM SUCESSO!"
		
	End If

ElseIf Opcao=3 And Acao=2 Then
	
	Id = request("Id")
	chk = request("chk")
	
	On Error Resume Next
		
		sSQL = "Delete * From Contatos where Contato_CD"
		If id <> "" Then
			Where = " = " & Id
		Else
			Where = " In (" & chk & ")"
		End If
		
		ExecuteSQL(sSql & Where)
		
		If Err.Number <> 0 Then
			sSql = "update Contatos set deletado = 1 where Contato_CD " & Where
			ExecuteSQL(sSql)
		End If
	
	On Error GoTo 0 
	
	mensagem = "Registro(s) apagado(s) com sucesso!"
	
	Response.Redirect("p_Contatos.asp?opcao=3&acao=1&mensagem=" & mensagem)
	
End if
%>
<table cellpadding="0" cellspacing="0" width="100%" height="90%" border="0">
	<tr>
		<td align="center" class="Font10Vermelho"><% =mensagem %><br><br>
			<% If opcao=1 Then %>
				<input type="buttom" name="Cadastrar" value="<%if Erro <> "" Then%>Tentar Novamente<%Else%>Cadastrar novo<%End If%>" class="buttom" onclick="<%if Erro <> "" Then%>history.back(0)<%Else%>location.href('p_Contatos.asp?opcao=1&acao=1');<%End If%>">
			<% Else %>
				<input type="buttom" name="Alterar" value="<%if Erro <> "" Then%>Tentar Novamente<%Else%>Alterar Outro<%End If%>" class="buttom" onclick="<%if Erro <> "" Then%>history.back(0)<%Else%>location.href('p_Contatos.asp?opcao=2&acao=1&id=<%=Contato_CD%>');<%End If%>">
			<% End if %>
		</td>
	</tr>
</table>