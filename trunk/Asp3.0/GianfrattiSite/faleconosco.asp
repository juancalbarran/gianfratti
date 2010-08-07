<%
Function EnviarEmail

	Set Mailer = Server.CreateObject("SMTPsvg.Mailer") 
	Mailer.FromName = "Serra Dos Cristais" 
	Mailer.FromAddress= "tiago@gianfratti.com" 
	Mailer.RemoteHost = "mail.serradoscristais.com.br"
	Mailer.AddRecipient Request("EmailUsuario")
	Mailer.ContentType = "text/html" ' formatação html 
	Mailer.Subject = "Fale Conosco Serra dos Cristais" 
	Mailer.BodyText = "Noma: "&Request("nome") 
	If Mailer.SendMail Then 
	    Response.Write "Mensagem enviada com sucesso" 
	Else 
	    Response.Write "Erro " & Mailer.Response 
	End If

End Function


'Monta o Select Case para chamar a função EnviaEmail que ira enviar o email
dim useraction
useraction=request("acao") 'Recebe a acao que o formulario esta passando como parametro
select case useraction
	case "EnviarEmail" 'Caso a acao passada seja EnviarEmail entao chama a função
		Call EnviarEmail 'Chama a função para enviar o email

End Select
%>

<form action="faleconosco.asp?acao=EnviarEmail" method="post" name="form" id="form"onSubmit="return valida_campo()">
	<Table>
		<tr>
			<Td>Email:<input name="EmailUsuario" type="text" id="assunto" size="30" maxlength="100"></td>
		</tr>

		<tr>
			<Td>Nome:<input name="Nome" type="text" id="assunto" size="30" maxlength="100"></td>
		</tr>
		
		<tr>
			<Td>Nome:<input name="Submit" type="submit"  value="Enviar"> </td>
		</tr>
	</Table>
</Form>