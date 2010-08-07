<%
dim useraction
useraction=request("action")
select case useraction
case "enviar"

' *********** E-mail de confirmação para o Administrador ***********
if  request.form("mensagem") = "" then
			mensagem = " "
	else
			mensagem = request.form("mensagem")
			mensagem = replace(mensagem, chr(13), "<BR>", 1)
			mensagem = replace(mensagem, "'", "''", 1)
	end if

set objMail = server.createobject("CDONTS.NewMail")
objMail.From = ""& Request.form("de") &""
objMail.To = ""& Request.form("para") &""
objMail.Subject = ""& Request.form("assunto") &""
objMail.Body = Request.form("nome") &"<br>"& mensagem &"</body></html>"
'Para formatação em HTML ultiliza 0 e para formato texto 1
objMail.BodyFormat = 0
objMail.MailFormat = 0
'Importancia 2 quer dizer alta e 1 normal
objMail.Importance = 2
objMail.Send
set objMail = Nothing
%>

<%
' *********** E-mail de confirmação para o usuario ***********
if  request.form("mensagem") = "" then
			mensagem = " "
	else
			mensagem = request.form("mensagem")
			mensagem = replace(mensagem, chr(13), "<BR>", 1)
			mensagem = replace(mensagem, "'", "''", 1)
	end if
resposta = Request.form("nome") &"<br>A Gianfratti.com agradece por nos enviar um e-mail.<br>Em breve responderemos ao seu e-mail.<br>www.gianfratti.com"
set objMail = server.createobject("CDONTS.NewMail")
objMail.From = ""& Request.form("para") &""
objMail.To = ""& Request.form("de") &""
objMail.Subject = ""& Request.form("assunto") &""
objMail.Body = resposta
'Para formatação em HTML ultiliza 0 e para formato texto 1
objMail.BodyFormat = 0
objMail.MailFormat = 0
'Importancia 2 quer dizer alta e 1 normal
objMail.Importance = 2
objMail.Send
set objMail = Nothing
%>
<%
response.write "<Script>alert('Email Enviado\n\n Em breve entraremos em contato')</Script>"
end select
%>
<body bgcolor="#000000">
<table border="0" cellspacing="0" cellpadding="0" align="center">
  <form action="contato.asp?action=enviar" method="post" name="form" id="form"onSubmit="return valida_campo()">
    <tr> 
      <td colspan="4"><font color="#FFFFFF" size="2" face="Verdana, Arial, Helvetica, sans-serif">A 
        Gianfratti.com n&atilde;o mede esfor&ccedil;os para corresponder &agrave;s 
        expectativas de seus clientes e oferecer os melhores servi&ccedil;os. 
        Aqui voc&ecirc; pode tirar todas as suas d&uacute;vidas. Sua opini&atilde;o 
        &eacute; importante para n&oacute;s ! </font></td>
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td width="66"><font color="#FFFFFF" size="1" face="Verdana, Arial, Helvetica, sans-serif">Nome:</font><font size="2"><b><font size="1"><b><font size="2"><b><font size="1"><b><font size="2"><b><font size="1"><b><font size="2"><b><font size="1"><b><font face="Verdana, Arial, Helvetica, sans-serif" color="#000000"> 
        <input name="para" type="hidden" id="para" value="fabrizio@gianfratti.com">
        </font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></td>
      <td width="178"><font color="#FFFFFF"> 
        <input name="nome" type="text" id="nome" style="font-family: Verdana; font-size: 8 pt; COLOR: 0000CC;" onBlur="confere()" size="20" maxlength="100">
        </font><font size="2"><b><font size="1"><b><font size="2"><b><font size="1"><b><font size="2"><b><font size="1"><b><font size="2"><b><font size="1"><b><font face="Verdana, Arial, Helvetica, sans-serif" color="#000000"> 
        </font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font><font color="#FFFFFF">&nbsp; 
        </font></td>
      <td width="132"><font color="#FFFFFF" size="1" face="Verdana, Arial, Helvetica, sans-serif">E-mail:</font></td>
      <td width="620"><font color="#FFFFFF"> 
        <input name="de" type="text" id="de2" style="font-family: Verdana; font-size: 8 pt; COLOR: 0000CC;" onBlur="confere()" size="20" maxlength="100">
        </font></td>
    </tr>
    <tr> 
      <td><font color="#FFFFFF" size="1" face="Verdana, Arial, Helvetica, sans-serif"> 
        Assunto:</font></td>
      <td colspan="3"> <input name="assunto" type="text" id="assunto" size="50" maxlength="100"></td>
    </tr>
    <tr> 
      <td valign="top"><font color="#FFFFFF" size="1" face="Verdana, Arial, Helvetica, sans-serif"> 
        Mensagem:</font></td>
      <td colspan="3" valign="top"> <textarea name="mensagem" cols="40" rows="3" wrap="VIRTUAL"></textarea>
      </td>
    </tr>
    <tr> 
      <td valign="top">&nbsp;</td>
      <td colspan="3" valign="top"><input name="Submit" type="submit" class="botao" value="Enviar"> 
        &nbsp; <input name="reset" type="reset" class="botao" value="Limpar"></td>
    </tr>
  </Form>
</table>
<script language="JavaScript">
function valida_campo()
{
<!--
var nome = document.form.nome.value
if (nome==""){
	alert("Entre com o seu nome!");
	document.form.nome.focus()
	return false
	}
var de = document.form.de.value
if (de==""){
	alert("Entre com o seu e-mail!");
	document.form.de.focus()
	return false
	}
var mensagem = document.form.mensagem.value
if (mensagem==""){
	alert("Entre com a mensagem do e-mail!");
	document.form.mensagem.focus()
	return false
	}
	}
function confere(){
if (document.form.de.value.indexOf('@', 0) == -1 || document.form.de.value.indexOf('.', 0) == -1){ alert("E-mail invalido!");
	document.form.de.focus()
	}
}
//-->
</script>
