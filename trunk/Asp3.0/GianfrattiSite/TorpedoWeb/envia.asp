<img src="http://www.gianfratti.com/Media/images_temp/aguarde.gif">
<script language="JavaScript">
		//window.resizeTo(200,200)	
		window.moveTo(250,250);
</script>
<%
	set objMail = server.createobject("CDONTS.NewMail")
	objMail.From = "gianfratti@gmail.com"
	objMail.To = "1193171464@clarotorpedo.com.br"
	objMail.Subject = Request("nome_de") & " - Site"
	objMail.Body = Request("ddd_de") & " " & Request("telefone_de") & Request.form("Msg")
	'Para formatação em HTML ultiliza 0 e para formato texto 1
	objMail.BodyFormat = 0
	objMail.MailFormat = 0
	'Importancia 2 quer dizer alta e 1 normal
	objMail.Importance = 2
	On Error Resume Next 'Inicia o Tratamento de erro
		objMail.Send 'envia o email
		Response.Write "<script>alert('Torpedo enviado com sucesso')</script>"
		Response.Write "<script>window.close()</script>"
	If Err <> 0 Then 'Caso tenha acontecido um erro
		Response.Write "Erro ao enviar o email. " & Err.Description
	End If
	set objMail = Nothing

%>