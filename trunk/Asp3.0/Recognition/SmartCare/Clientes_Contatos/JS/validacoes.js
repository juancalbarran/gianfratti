<script language="JavaScript">
//FUNÇÃO QUE FAZ AS VALIDAÇÕES DO FORMULARIO
function valida_campo()
{
<!--
var id_Departamento = document.form.id_Departamento.value
if (id_Departamento==""){
	alert("Clique na figura ao lado do campo do departamento e selecione o departamento");
	document.form.id_Departamento.focus()
	return false
	}
var Nome = document.form.Nome.value
if (Nome==""){
	alert("Entre com o nome do contato que sera cadastrado");
	document.form.Nome.focus()
	return false
	}
var Telefone = document.form.Telefone.value
if (Telefone==""){
	alert("Entre com o telefone de contato");
	document.form.Telefone.focus()
	return false
	}
var Endereco = document.form.Endereco.value
if (Endereco==""){
	alert("Entre com o endereço de contato");
	document.form.Endereco.focus()
	return false
	}
var Cidade = document.form.Cidade.value
if (Cidade==""){
	alert("Entre com a cidade");
	document.form.Cidade.focus()
	return false
	}
var UF = document.form.UF.value
if (UF==""){
	alert("Entre com o estado");
	document.form.UF.focus()
	return false
	}
var Email = document.form.Email.value
if (Email==""){
	alert("Entre com o email do contato");
	document.form.Email.focus()
	return false
	}
var Cargo = document.form.Cargo.value
if (Cargo==""){
	alert("Entre com o cargo do contato");
	document.form.Cargo.focus()
	return false
	}
if (document.form.Login.value!="" && document.form.Senha.value=="" ){
	alert("Entre com a senha de acesso ao sistema para o funcionário");
	document.form.Senha.focus()
	return false
	}
if (document.form.Senha.value!="" && document.form.Login.value=="" ){
	alert("Entre com um login de acesso ao sistema para o funcionário");
	document.form.Senha.focus()
	return false
	}
if (document.form.Senha.value!="" && document.form.Senha_Confere.value=="" ){
	alert("Por favor, confirme a senha");
	document.form.Senha_Confere.focus()
	return false
	}
if (document.form.Senha.value != document.form.Senha_Confere.value){
	alert("As senhas digitadas não conferem.\n\nRedigite as senhas.");
	document.form.Senha_Confere.focus()
	return false
	}
if (document.form.Login.value != "" && document.form.Login.value.length < "6"){
		alert("O LOGIN DEVE TER NO MINIMO 6 CARACTERES");
		document.form.Login.value = ''
		document.form.Login.focus()
		return false
	}
if (document.form.Senha.value != "" && document.form.Senha.value.length < "6"){
		alert("A SENHA DEVE TER NO MINIMO 6 CARACTERES");
		document.form.Senha.value = ''
		document.form.Senha_Confere.value = ''
		document.form.Senha.focus()
		return false
	}

	document.form.submit.value="Aguarde..!!" //Se todos os campos obrigatorios foram preenchidos o botão sera desabilitado para não haver duplicação de registros caso ele clique mais um uma vez
 	document.form.submit.disabled=true;
}
//-->
</script>
