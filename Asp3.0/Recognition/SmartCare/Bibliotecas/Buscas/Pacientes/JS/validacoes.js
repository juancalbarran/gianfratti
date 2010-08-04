<script language="JavaScript">
//FUNÇÃO QUE FAZ AS VALIDAÇÕES DO FORMULARIO
function valida_campo()
{
<!--

var Nome = document.form.Nome.value
if (Nome==""){
	alert("Entre com o nome do paciente");
	document.form.Nome.focus()
	return false
	}
var Sexo = document.form.Sexo.value
if (Sexo==""){
	alert("Entre com o sexo do paciente");
	document.form.Sexo.focus()
	return false
	}
var Data_Nascimento = document.form.Data_Nascimento.value
if (Data_Nascimento==""){
	alert("Entre com a data de nascimento do paciente");
	document.form.Data_Nascimento.focus()
	return false
	}
var Estado_Civil = document.form.Estado_Civil.value
if (Estado_Civil==""){
	alert("Entre com o estado civil do paciente");
	document.form.Estado_Civil.focus()
	return false
	}
var Conjuge = document.form.Conjuge.value
if (Estado_Civil =="Casado" && Conjuge == ""){
	alert("Entre com o nome do conjuge do paciente");
	document.form.Conjuge.focus()
	return false
	}
var Endereco = document.form.Endereco.value
if (Endereco==""){
	alert("Entre com endereço do paciente");
	document.form.Endereco.focus()
	return false
	}
var Cep = document.form.Cep.value
if (Cep==""){
	alert("Entre com o cep do paciente");
	document.form.Cep.focus()
	return false
	}
var UF = document.form.UF.value
if (UF==""){
	alert("Entre com o estado onde o paciente reside");
	document.form.UF.focus()
	return false
	}
var Cidade = document.form.Cidade.value
if (Cidade==""){
	alert("Entre com a cidade onde o paciente reside");
	document.form.Cidade.focus()
	return false
	}
var Bairro = document.form.Bairro.value
if (Bairro==""){
	alert("Entre com o bairro onde o paciente reside");
	document.form.Bairro.focus()
	return false
	}
var Fone1 = document.form.Fone1.value
if (Fone1==""){
	alert("Entre com o telefone do paciente");
	document.form.Fone1.focus()
	return false
	}
var Contato1 = document.form.Contato1.value
if (Contato1==""){
	alert("Entre um contato do paciente em caso de urgência");
	document.form.Contato1.focus()
	return false
	}
var id_Convenio = document.form.id_Convenio.value
if (id_Convenio==""){
	alert("Entre com o convenio do paciente");
	document.form.id_Convenio.focus()
	return false
	}
var Data_Vencimento = document.form.Data_Vencimento.value
if (Data_Vencimento==""){
	alert("Entre com a data de vencimento do convenio");
	document.form.Data_Vencimento.focus()
	return false
	}
var Particular = document.form.Particular.value
if (Particular==""){
	alert("Selecione se o convenio é particular ou não");
	document.form.Particular.focus()
	return false
	}
var Numero_Convenio = document.form.Numero_Convenio.value
if (Numero_Convenio==""){
	alert("Entre com o numero do convenio");
	document.form.Numero_Convenio.focus()
	return false
	}
var Tipo_Sanguineo = document.form.Tipo_Sanguineo.value
if (Tipo_Sanguineo==""){
	alert("Selecione o tipo sanguineo do paciente");
	document.form.Tipo_Sanguineo.focus()
	return false
	}

	document.form.submit.value="Aguarde..!!" //Se todos os campos obrigatorios foram preenchidos o botão sera desabilitado para não haver duplicação de registros caso ele clique mais um uma vez
 	document.form.submit.disabled=true;
}
//-->
</script>
