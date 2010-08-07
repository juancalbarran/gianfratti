<%
Set Mailer = CreateObject("CDONTS.NewMail")
Mailer.From = "fabrizio@gianfratti.com" ' e-mail de quem esta enviando a mensagem 
Mailer.To = "fabrizio@gianfratti.com" ' e-mail de quem vai receber a mensagem 
Mailer.CC = "fabrizio@gianfratti.com" ' Com Cópia 
Mailer.BodyFormat = 1 ' parametro de formatação 
Mailer.MailFormat = cdoMailFormatText ' parametro de formatação 
'Mailer.AttachFile "e:\home\login\dados\arquivo.txt" 'caso queira anexar algum arquivo ao seu e-mail
Mailer.Subject = "Assunto do E-mail" 
Mailer.Body = "Corpo da Mensagem" 
Mailer.Send 
Set Mailer = Nothing 

'=============================================================================
'Função para enviar email, basta passar os parametros requeridos pela função
'Função muito util, todo o sistema esta usando esta função, entao cuidado quando fizer alterações brusca
'=============================================================================
Function enviar_email(de,para,com_copia,copia_oculta,assunto,texto)

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
			Response.end
		End If
	Set Mailer = Nothing 'Destroi o objeto criado

End Function

Call enviar_email("fabrizio@gianfratti.com","1193171464@clarotorpedo.com.br","fabrizio@gianfratti.com","","Torpedo Web",Request("msg"))
Response.Write "<script>alert('Torpedo enviado com sucesso')</script>"
Response.Write "<script>window.close()</script>"
%>