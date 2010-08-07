<%
Private Function EnviarEmail_mySmartMail(sSQL, sServer, sFromName, sFromMail, sSubject, sBody)

	On Error Resume Next
	
	Set mySmartMail = Server.CreateObject("aspSmartMail.SmartMail")
	
	'[ Server TimeOut ]
	mySmartMail.ServerTimeOut = 60
	
	'[ Mail Server ] [ mail.yourdomain.com ]
	mySmartMail.Server = sServer 

	'[ Username / Password] [ myUsername / myPassword ]
	'mySmartMail.Username = sUsername
	'mySmartMail.Password = sPassword

	'[ From ] [ SenderName / SenderAddress] 
	mySmartMail.SenderName = sFromName
	mySmartMail.SenderAddress = sFromMail

	'[ ContentType ] [ "text/html" / "text/plain"]
	mySmartMail.ContentType = "text/html"

	'[ Message ] [ Subject / Body]
	mySmartMail.Subject = sSubject
	mySmartMail.Body = sBody
	
	'[ to (para)]
	'If sToName <> "" Then
	'	mySmartMail.Recipients.Add sToMail, sToName
	'Else
	'	mySmartMail.Recipients.Add sToMail
	'End If

	'[ to (para) com cópia]
	'If sCCsName <> "" Then
	'	mySmartMail.CCs.Add sCCsMail, sCCsName
	'Else
	'	mySmartMail.CCs.Add sCCsMail
	'End If
	
	Set oRs = RetornaSQL(sSQL)
	Do Until oRs.Eof
		
		sBCCsName = oRs.Fields(0).Value
		sBCCsMail = oRs.Fields(1).Value
		Contatos = Contatos & oRs.Fields(2).Value & ","
		
		'[ to (para) com cópia oculta]
		If sBCCsName <> "" Then
			mySmartMail.BCCs.Add sBCCsMail, sBCCsName
		Else
			mySmartMail.BCCs.Add sBCCsMail
		End If
		
		oRs.MoveNext
	Loop


	'[ Send the message ]
	mySmartMail.SendMail
	
	
	'If Err.Number <> 0 Then
	'	msg = "[1]" & "Error n°: " &  Err.Number - vbobjecterror & "=" & Err.Description
	'Else
	'	msg = "[2]" & Contatos
	'End If
	
	'[ Limpa os recipientes] 
	mySmartMail.ReplyTos.Clear
	
	'[ Destroi o Objeto ]
	Set mySmartMail = Nothing
	
	'[ destroi o objeto de conexão]
	Set oRs = Nothing
	
	EnviarEmail_mySmartMail = Contatos
	
	On Error GoTo 0
	
End Function
%>