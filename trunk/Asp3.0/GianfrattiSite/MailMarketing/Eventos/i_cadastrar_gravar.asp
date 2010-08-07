<%
Evento_CD 		= fnInteger(Request("Evento_CD"))
Evento_NM		= fnString(Request("Evento_NM"))
Remetente_CD	= fnString(Request("Remetente_CD"))
Evento_Texto	= fnString(Request("Evento_Texto"))

iUser			= Session("iUser")

sSql = Empty

If opcao=1 AND acao=2 Then

	If Session("gravado") <> 1 Then
		
		On Error Resume Next
		
		Call Conecta()
		
			Conn.BeginTrans
			
				sSql = sSql & " Insert Into Eventos (Evento_NM, Evento_Texto, Remetente_CD, Usuario_CD) Values "
				sSql = sSql & " (" & Evento_NM & ", " & Evento_Texto & "," & Remetente_CD & "," & iUser & ")"
				Conn.Execute(sSql)
					
						Evento_CD = Conn.Execute(" Select @@Identity ")(0).Value
					
							For Each sItem in Request.Form("Grupo_CD")
								sSql = " INSERT INTO Eventos_Grupos (Evento_CD,Grupo_CD) VALUES (" & Evento_CD & ",'" & sItem & "'); "
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
			
					sSql = sSql & " UPDATE Eventos SET "
					
					sSql = sSql & " Evento_NM = " 		& Evento_NM
					sSql = sSql & ", Evento_Texto = " 	& Evento_Texto
					sSql = sSql & ", Remetente_CD = " 	& Remetente_CD
					sSql = sSql & ", Usuario_CD = " 	& iUser
				
					sSql = sSql & " Where Evento_CD = " & Evento_CD
					Conn.Execute(sSql)
					
						sSQL = " Delete * from Eventos_Grupos Where Evento_CD = " & Evento_CD
						Conn.Execute(sSql)
						
							For Each sItem in Request.Form("Grupo_CD")
								sSql = " INSERT INTO Eventos_Grupos (Evento_CD,Grupo_CD) VALUES (" & Evento_CD & ",'" & sItem & "'); "
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
		
		sSQL = "Delete * From Eventos where Evento_CD"
		If id <> "" Then
			Where = " = " & Id
		Else
			Where = " In (" & chk & ")"
		End If
		
		ExecuteSQL(sSql & Where)
		
		If Err.Number <> 0 Then
			sSql = "update Eventos set deletado = 1 where Evento_CD " & Where
			ExecuteSQL(sSql)
		End If
	
	On Error GoTo 0 
	
	mensagem = "Registro(s) apagado(s) com sucesso!"
	
	Response.Redirect("p_Eventos.asp?opcao=3&acao=1&mensagem=" & mensagem)
	
End if
%>
<table cellpadding="0" cellspacing="0" width="100%" height="90%" border="0">
	<tr>
		<td align="center" class="Font10Vermelho"><% =mensagem %><br><br>
			<% If opcao=1 Then %>
				<input type="buttom" name="Cadastrar" value="<%if Erro <> "" Then%>Tentar Novamente<%Else%>Cadastrar novo<%End If%>" class="buttom" onclick="<%if Erro <> "" Then%>history.back(0)<%Else%>location.href('p_Eventos.asp?opcao=1&acao=1');<%End If%>">
			<% Else %>
				<input type="buttom" name="Alterar" value="<%if Erro <> "" Then%>Tentar Novamente<%Else%>Alterar Outro<%End If%>" class="buttom" onclick="<%if Erro <> "" Then%>history.back(0)<%Else%>location.href('p_Eventos.asp?opcao=2&acao=1&id=<%=Evento_CD%>');<%End If%>">
			<% End if %>
		</td>
	</tr>
</table>