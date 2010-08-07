<!-- #include virtual="/MailMarketing/Shared/inc/logado.asp" -->
<!-- #include virtual="/MailMarketing/Shared/inc/Config.asp" -->
<!-- #include virtual="/MailMarketing/Shared/inc/Conn.asp" -->
<!-- #include virtual="/MailMarketing/Shared/inc/Functions.asp" -->
<%
'[RECUPERA O CÓDIGO DO EVENTO]
Evento_CD = Request("Evento_CD")

'[VARIAVEIS]
eMail = "" : Contatos = ""


'[SELECIONA OS DADOS DO EVENTO]
sSQL = "Select Top 1 Remetente_eMail, Remetente_SMTP, Remetente_NM, Evento_CD, Evento_NM, Evento_Texto, Enviou From Eventos inner join Remetentes on (Eventos.Remetente_CD = Remetentes.Remetente_CD) Where Evento_CD = " & cDbl(Evento_CD)
Set oRs = RetornaSQL(sSQL)

If Not oRs.Eof Then
	Remetente_NM	= oRs.Fields("Remetente_NM")
	Remetente_SMTP	= oRs.Fields("Remetente_SMTP")
	Remetente_eMail	= oRs.Fields("Remetente_eMail")
	Evento_CD 		= oRs.Fields("Evento_CD")
	Evento_NM		= oRs.Fields("Evento_NM")
	Evento_Texto	= oRs.Fields("Evento_Texto")
	Enviou			= oRs.Fields("Enviou")
End If


'[SELECIONA OS CONTATOS A SEREM ENVIADOS]
sSQL = "Exec vEnviar_Email " & cDbl(Evento_CD)
Set oRs = RetornaSQL(sSQL)

'[CONCATENA OS CONTATOS PARA SEREM ENVIADOS]
If Not oRs.Eof Then

		on error resume next

		Registros = oRs.RecordCount
	
	'[INICIO ENVIA E-MAIL]
	
		Set mySmartMail = Server.CreateObject("aspSmartMail.SmartMail")
	
		'[ Server TimeOut ]
		mySmartMail.ServerTimeOut = 60
		
		'[ Mail Server ] [ mail.yourdomain.com ]
		mySmartMail.Server = Remetente_SMTP 
	
		'[ From ] [ SenderName / SenderAddress] 
		mySmartMail.SenderName = Remetente_NM
		mySmartMail.SenderAddress = Remetente_eMail
	
		'[ ContentType ] [ "text/html" / "text/plain"]
		mySmartMail.ContentType = "text/html"
	
		'[ Message ] [ Subject / Body]
		mySmartMail.Subject = Evento_NM
		mySmartMail.Body = Evento_Texto
		
		mySmartMail.Recipients.Add "teste@gianfratti.com"
		
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
		
		
		'[ Limpa os recipientes] 
		mySmartMail.ReplyTos.Clear
		
		'[ Destroi o Objeto ]
		Set mySmartMail = Nothing
		
		'[ destroi o objeto de conexão]
		Set oRs = Nothing

	
	'[FIM ENVIA E-MAIL]
	
	
	Contatos = left(Contatos, (len(Contatos)-1) )
	ExecuteSQL("Update eMails_Enviados Set QTD = (QTD + 1), Enviou = 1 Where Contato_CD IN (" & Contatos & ")" )

	%>
	<meta http-equiv="refresh" content="1">
	<script language="JavaScript">
		parent.document.getElementById('04').innerHTML = Math.abs(parent.document.getElementById('04').innerHTML) + <%=Registros%>
	</script>
	<%
Else
	ExecuteSQL("Update Eventos Set QTD = (QTD + 1), Enviou = 1 Where Evento_CD = " & Evento_CD)
	
	%>
	<script language="JavaScript">
		parent.document.getElementById('Alerta').style.display='none'
		parent.document.getElementById('01').style.display='none'
		parent.document.getElementById('02').style.display='none'
		parent.document.getElementById('03').style.display='block'
		parent.document.getElementById('table1').height='100%'
		//parent.fnStopPiscar()
		parent.document.getElementById('05').innerHTML = parent.document.getElementById('04').innerHTML
	</script>
	<%
End If
%>