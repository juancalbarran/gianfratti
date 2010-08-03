<script language="JavaScript">
//FUNÇÃO QUE FAZ AS VALIDAÇÕES DO FORMULARIO
function valida_campo()
{
<!--
var Nome = document.form.Nome.value
if (Nome==""){
	alert("Entre com o nome");
	document.form.Nome.focus()
	return false
	}
var Email = document.form.Email.value
if (Email==""){
	alert("Entre com o Email");
	document.form.Email.focus()
	return false
	}
	document.form.submit.value="Aguarde..!!" //Se todos os campos obrigatorios foram preenchidos o botão sera desabilitado para não haver duplicação de registros caso ele clique mais um uma vez
 	document.form.submit.disabled=true;
}

//Chamado no formo que envia o email
function valida_campo_enviar()
{
<!--
var De = document.form.De.value
if (De==""){
	alert("Entre com o nome do remetente");
	document.form.De.focus()
	return false
	}
var Assunto = document.form.Assunto.value
if (Assunto==""){
	alert("Entre com o Assunto do email");
	document.form.Assunto.focus()
	return false
	}
var Texto = document.form.Texto.value
if (Texto==""){
	alert("Entre com o texto do email");
	document.form.Texto.focus()
	return false
	}

	document.form.submit.value="Aguarde..!!" //Se todos os campos obrigatorios foram preenchidos o botão sera desabilitado para não haver duplicação de registros caso ele clique mais um uma vez
 	document.form.submit.disabled=true;
}

//-->
</script>
