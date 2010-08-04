<script language="JavaScript">
//FUNÇÃO QUE FAZ AS VALIDAÇÕES DO FORMULARIO
function valida_campo()
{
<!--
var id_Departamento = document.form.id_Departamento.value
if (id_Departamento==""){
	alert("Entre com o departamento");
	document.form.id_Departamento.focus()
	return false
	}
var id_Cargo = document.form.id_Cargo.value
if (id_Cargo==""){
	alert("Entre com o cargo");
	document.form.id_Cargo.focus()
	return false
	}
var DataContratacao = document.form.DataContratacao.value
if (DataContratacao==""){
	alert("Entre com a data de contratação do funcionario");
	document.form.DataContratacao.focus()
	return false
	}
var Nome = document.form.Nome.value
if (Nome==""){
	alert("Entre com o nome completo do funcionario");
	document.form.Nome.focus()
	return false
	}
var Endereco = document.form.Endereco.value
if (Endereco==""){
	alert("Entre com o endereço do funcionario");
	document.form.Endereco.focus()
	return false
	}
var CEP = document.form.CEP.value
if (CEP==""){
	alert("Entre com o CEP onde reside o funcionario");
	document.form.CEP.focus()
	return false
	}
var Bairro = document.form.Bairro.value
if (Bairro==""){
	alert("Entre com o bairro onde reside o funcionario");
	document.form.Bairro.focus()
	return false
	}
var Cidade = document.form.Cidade.value
if (Cidade==""){
	alert("Entre com a cidade onde reside o funcionario");
	document.form.Cidade.focus()
	return false
	}
var UF = document.form.UF.value
if (UF==""){
	alert("Entre com o estado onde reside o funcionario");
	document.form.UF.focus()
	return false
	}
var TelefoneResidencial = document.form.TelefoneResidencial.value
if (TelefoneResidencial==""){
	alert("Entre com o telefone residencial");
	document.form.TelefoneResidencial.focus()
	return false
	}
var Contato1 = document.form.Contato1.value
if (Contato1==""){
	alert("Entre com o contato do funcionario\n\nEx: Telefone, Celular, etc..");
	document.form.Contato1.focus()
	return false
	}

	document.form.submit.value="Aguarde..!!" //Se todos os campos obrigatorios foram preenchidos o botão sera desabilitado para não haver duplicação de registros caso ele clique mais um uma vez
 	document.form.submit.disabled=true;
}
//-->
</script>

<script language=javascript>
function AdicionaCobertura(dropdown,count){
 var x=document.form
 if (document.form.saidaCobertura.length==0){return;}
 for (i=0;i<=document.form.saidaCobertura.length;i++){
 if (document.form.saidaCobertura.options[i].selected){
  document.form.entradaCobertura[document.form.entradaCobertura.length]=new Option(document.form.saidaCobertura.options[document.form.saidaCobertura.selectedIndex].text,document.form.saidaCobertura.options[document.form.saidaCobertura.selectedIndex].value,1,1);
  document.form.saidaCobertura.remove(document.form.saidaCobertura.selectedIndex);i--;}
  if (document.form.saidaCobertura.length<=0||i>=document.form.saidaCobertura.length-1)break}}

function RemoveCobertura(count){
 var x=document.form
 if (document.form.entradaCobertura.length==0){return;}
 for (i=0;i<=document.form.entradaCobertura.length;i++){
  if (document.form.entradaCobertura.options[i].selected){
  document.form.saidaCobertura[document.form.saidaCobertura.length]=new Option(document.form.entradaCobertura.options[document.form.entradaCobertura.selectedIndex].text,document.form.entradaCobertura.options[document.form.entradaCobertura.selectedIndex].value,1,1);
  document.form.entradaCobertura.remove(document.form.entradaCobertura.selectedIndex);i--;}
  if (document.form.entradaCobertura.length<=0||i>=document.form.entradaCobertura.length-1)break}}
</script>

