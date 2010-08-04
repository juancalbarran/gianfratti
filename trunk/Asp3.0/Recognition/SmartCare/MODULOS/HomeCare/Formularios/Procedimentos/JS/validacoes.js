<Script>
// Autor: Fabrizio Gianfratti Manes
// Data: 02/02/2005
// Descrição: Pagina de Scripts JS
// Atualizado por: -
// Data: -
// Atualização: -
</Script>

<Script>
//Função resposavel por carregar o procedimento inserindo o Codigo da AMB
//Usamos o ActiveX XMLHTTP para buscar o nome do medicamento
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function CarregaAMB(Cod_AMB) //Função que recebe o value(valor) do campos e a posicao do vetor que é passado
{
	try //Inicio de tratamento de erro
		{ 
			//alert(PosicaoVetor)
			var Dados; //Varivel onde ficare arazenado o resultado final
			xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
			xmlHTTP.Open('POST', 'carrega.asp?Action=BuscaAMB&Cod_AMB=' + document.formCadastro.Cod_AMB.value, false); // Seta a pagina onde ira buscar os dados.
			xmlHTTP.Send(); //Envia
 
			Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
			Dados = Dados.split("#") //Da um splite no retorno pois o registro veio concatenado com # que é o separador

			if (Dados == "") //Verifica se a variavel esta vazia
				{ 
					alert('Código AMB não encontrado\n\nCodigo nº:'+Cod_AMB.value ) //Caso esteje vazia entao é retornado a MSG de não encontrado
					document.formCadastro.Cod_AMB.value = "";
					document.formCadastro.Descricao_AMB.value = "";
					document.formCadastro.QTD_CH.value = ""; 
					document.formCadastro.Numero_Auxiliares.value = ""; 
				 }
			else //Caso a Variavel não for vazia então e atrubuido a variavel DADOS com o valor
				{ 
					//alert(Dados); //Caso queira depurar qualquer tipo de retorno que esta tenho, basta habilitar esta linha
					document.formCadastro.Descricao_AMB.value = Dados[0]; //Mostra o valor do registo no compo indicado
					document.formCadastro.QTD_CH.value = Dados[1]; //Mostra o valor do registo no compo indicado
					document.formCadastro.Numero_Auxiliares.value = Dados[2]; //Mostra o valor do registo no compo indicado
				}

		}
	catch(e)//Caso houve erro então é mostrado a descrição do erro
			{ 
				alert(e.descripition); //Descricao do erro
			}
}
</script>

<script language="JavaScript">
//FUNÇÃO QUE FAZ AS VALIDAÇÕES DO FORMULARIO
function valida_campo()
{
<!--
if (document.formCadastro.id_Atendimento.value==""){
	alert("Para gravar um procedimento é obrigatório o preenchimento do número do atendimento");
	return false
	}
if (document.formCadastro.Data_Procedimento.value==""){
	alert("Selecione a data do procedimento");
	document.formCadastro.Data_Procedimento.focus()
	return false
	}
if (document.formCadastro.Cod_AMB.value==""){
	alert("Digite o código AMB para gravar um procedimento");
	document.formCadastro.Cod_AMB.focus()
	return false
	}
	document.formCadastro.submit.value="Aguarde..!!" //Se todos os campos obrigatorios foram preenchidos o botão sera desabilitado para não haver duplicação de registros caso ele clique mais um uma vez
 	document.formCadastro.submit.disabled=true;
}
//-->
</script>

