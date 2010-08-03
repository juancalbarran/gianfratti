<!-- #include virtual="/MailMarketing/Shared/inc/logado.asp" -->
<!-- #include virtual="/MailMarketing/Shared/inc/Config.asp" -->
<!-- #include virtual="/MailMarketing/Shared/inc/Conn.asp" -->
<%
	'[VERIFICAÇÃO DE ERROS NOS PROCESSOS]
	ON ERROR RESUME NEXT


		'[RECUPERA O CÓDIGO DO EVENTO]
		Evento_CD = Request("Evento_CD")
		
		'[SELECIONA OS DADOS DO EVENTO]
		sSQL = "Select top 1 Evento_CD, Enviou From Eventos Where Evento_CD = " & cDbl(Evento_CD)
		Set oRs = RetornaSQL(sSQL)
		
		If Not oRs.Eof Then
			Evento_CD		= oRs.Fields("Evento_CD")
			Enviou			= oRs.Fields("Enviou")
		End If
		
		If Enviou = 0 Then
			If Session("Gravado") <> 1 Then
				
				'[INSERE NA TABELA EMAIL_ENVIADOS OS EMAILS A SEREM ENVIADOS A PARTIR DESTA CONSULTA] 
				sSQL = "Exec Insere_eMail_Enviados " & cDbl(Evento_CD)
				
				ExecuteSQL(sSQL)
				Session("Gravado")=1
				
				
			End If
		Else
			If Session("Gravado") <> 1 Then
				
				'[CASO SEJA REENVIO DE E-MAIL ATUIALIZA A TABELA DE E-MAILS ENVIADOS PARA QUE SEJA ENVIADOS OS E-MAILS] 
				sSQL = " Update eMails_Enviados Set Enviou = 0 Where Evento_CD =" & cDbl(Evento_CD)
				ExecuteSQL(sSQL)
				
				sSQL = "Exec Insere_eMail_Enviados " & cDbl(Evento_CD)
				ExecuteSQL(sSQL)
				
				Session("Gravado")=1
				
			End If
		End If
	
	
	IF ERR.NUMBER <> 0 THEN
		ON ERROR GOTO 0
		RESPONSE.WRITE "OCORREU UM ERRO AO DISPARAR O EVENTO."
	ELSE
		RESPONSE.REDIRECT "i_enviar_eMail_PassoB.asp?Evento_CD="&Evento_CD
	END IF
%>