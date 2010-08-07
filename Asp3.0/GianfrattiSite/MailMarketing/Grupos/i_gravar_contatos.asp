<%
	On Error Resume Next
	
	If Session("gravado") = 0 Then
	
		Grupo_CD = Request("Grupo_CD")

		Call Conecta()
		
			Conn.BeginTrans
	
				For Each sItem in Request.Form("chk")
					sSql = " INSERT INTO GRUPOS_CONTATOS (Contato_CD,Grupo_CD) VALUES (" & sItem & "," & Grupo_CD & "); "
					If not isEmpty(sSQL) Then Conn.Execute(sSql)
				Next
			
				Lista = request("Lista")
				If Lista <> "" Then
					sItem = Split(right(Lista, len(Lista)-1), ",")
					For i=0 to uBound(sItem)-1
						sSql = " INSERT INTO GRUPOS_CONTATOS (Contato_CD,Grupo_CD) VALUES (" & sItem(i) & "," & Grupo_CD & "); "
						If not isEmpty(sSQL) Then Conn.Execute(sSql)
					Next
				End If
			
				If Err.Number <> 0 Then
					Conn.RollBackTrans
					mensagem = "ERRO AO TENTAR GRAVAR, TENTE NOVAMENTE!"
					Erro=1
				Else
					Conn.CommitTrans
					mensagem = "CONTATOS ADICONADOS COM SUCESSO!"
					Session("gravado")=1
				End If
				
				
		Call DesConecta()
	
	Else
		
		mensagem = "CONTATOS ADICONADOS COM SUCESSO!"
	
	End If
		
	On Error GoTo 0

	
%>
<table cellpadding="0" cellspacing="0" width="100%" height="90%" border="0">
	<tr>
		<td align="center" class="Font10Vermelho"><% =mensagem %><br><br>
			<input type="buttom" name="Alterar" value="Adicionar novos contatos" style="width:200px" class="buttom" onclick="location.href('p_grupos.asp?opcao=5&acao=1&Grupo_CD=<%=Grupo_CD%>');">
		</td>
	</tr>
</table>