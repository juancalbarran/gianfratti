<%
Private Function FormatField(byVal sField, byVal sType)
	
	On Error Resume Next
	
	Select Case int(sType)
		Case 5 'Float
			sField = "R$&nbsp;" & FormatNumber(sField,2, -1)
		Case 6 'Money
			sField = "R$&nbsp;" & FormatNumber(sField,2, -1)
		'Case 135 'SmallDateTime
		'	sField = 
		Case Else
			sField = sField
	End Select
	
	On Error Goto 0
	
	FormatField = sField
	
End Function


Private Function CorStatus(byVal sStatus)
	
	On Error Resume Next
	
	Select Case lCase(sStatus)
		Case "ativo"
			sStatus = "Black"
		Case "inativo"
			sStatus = "Red"
		Case "fechada"
			sStatus = "Red"
		Case Else
			sStatus = "Black"
	End Select
	
	On Error Goto 0
	
	CorStatus = sStatus
	
End Function


Function ExibeData(data_exibe)
	if Len(Day(CDate(data_exibe)))<2 then
		dia_data = "0" & Day(CDate(data_exibe))
	else
		dia_data = Day(CDate(data_exibe))
	end if

	if Len(Month(CDate(data_exibe)))<2 then
		mes_data = "0" & Month(CDate(data_exibe))
	else
		mes_data = Month(CDate(data_exibe))
	end if

	ExibeData = dia_data & "/" & mes_data & "/" & Year(CDate(data_exibe))
End Function

Private Function fnCarregaCombo(sNomeCombo, sValueCombo, sTextCombo, sTabela, sCondicao, sOrderBy, sSelected, iTamanhoCombo, Required, Erro, Eventos)

	Dim sSQL, oRs, sValorRetorno
	
	sSQL = "Select " & sValueCombo & ","  & sTextCombo & " From " & sTabela
	
	If sCondicao <> "" Then
		sSQL = sSQL & " Where " & sCondicao 
	End If
	
	If sOrderBy <> "" Then
		sSQL = sSQL & " Order By " & sOrderBy & " Asc "
	Else
		sSQL = sSQL & " Order By " & sTextCombo & " Asc "
	End If
	
	Set oRs = RetornaSQL(sSQL)
	
	sValorRetorno = Empty
	sValorRetorno = sValorRetorno & "<Select name='" & sNomeCombo & "' style='width:" & iTamanhoCombo & "px' tabIndex='" & iTabIndex & "' required='" & Required & "' Error='" & Erro & "' " & Eventos & ">" & vbCrlf
		
		If Erro <> "" Then
			sValorRetorno = sValorRetorno & "<Option value=''>" & Erro & "</Option>"
		End If
	
		Do Until oRs.Eof
		
			sValorRetorno = sValorRetorno & vbTab & "<Option value='" & oRs.Fields(0).value & "'"
			
				If cStr(sSelected) = cStr(oRs.Fields(0).value) Then
					sValorRetorno = sValorRetorno & " selected"
				End If
				
			sValorRetorno = sValorRetorno & ">" & Trim(oRs.Fields(1).value) & "</Option>" & vbCrlf
			
			
			oRs.MoveNext
			
		Loop
	
	sValorRetorno = sValorRetorno & "</Select>"
	
	oRs.Close
	Set oRs = Nothing
	
	'fnCarregaCombo = sSQL
	fnCarregaCombo = sValorRetorno
	
End Function

'=============================================================================
'Função para enviar email, basta passar os parametros requeridos pela função
'Função muito util, todo o sistema esta usando esta função, entao cuidado quando fizer alterações brusca
'=============================================================================
Function Enviar_eMail(de,para,com_copia,copia_oculta,assunto,texto)

	Set Mailer = CreateObject("CDONTS.NewMail") 'Componente usado e o Cdonts
		Mailer.From = de ' e-mail de quem esta enviando a mensagem 
		Mailer.To = para' e-mail de quem vai receber a mensagem 
		Mailer.CC = com_copia ' Com Cópia 
		Mailer.BCC = copia_oculta ' Com Cópia Oculta
		Mailer.BodyFormat = 0 ' parametro de formatação para HTML
		Mailer.MailFormat = cdoMailFormatText ' parametro de formatação 
		Mailer.Subject = assunto 'Assunto do email
		Mailer.Body = texto 'texto que sera enviado por email
		On Error Resume Next 'Inicia o Tratamento de erro
			Mailer.Send 'envia o email
		If Err <> 0 Then 'Caso tenha acontecido um erro
			Response.Write "Erro ao enviar o email. " & Err.Description
		End If
	Set Mailer = Nothing 'Destroi o objeto criado

End Function

%>