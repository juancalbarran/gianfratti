<Script>
// Autor: Fabrizio Gianfratti Manes
// Data: 02/02/2005
// Descrição: Pagina de Scripts JS
// Atualizado por: -
// Data: -
// Atualização: -
</Script>

<Script>
//Função respomsavel por inserir os campos onde será inserido o CID10
	var posicaoMedicamento = 1 //Define uma variavel que ira controlar a posicao do vetor dos campos. Este valor é usado para passar no imput como parametro
function CriaOpcoesSimproMedicamentos()
{
	posicaoMedicamento += 1 //Vai incrementando 1
	Mostra_Campos_Simpro_Medicamentos.innerHTML = Mostra_Campos_Simpro_Medicamentos.innerHTML +  //Vai concatenando para exibir na Div
		"<table width=100% border=0 cellspacing=1 cellpadding=0>" +
			"<tr class=zebra_orange1>" +
			  		"<td width=10%><input name=Cod_Simpro_Medicamento type=text class=campos id=Cod_Simpro_Medicamento onchange=CarregaSimproMedicamento(formCadastro.Cod_Simpro_Medicamento,'" + posicaoMedicamento + "') size=7 maxlength=7  > </td>" +
			  		"<td width=40%><input readonly name=Descricao_Medicamento type=text class=campos id=Descricao_Medicamento size=47></td>" +
					"<td width=13%><input name=qtd_Medicamentos type=text class=campos id=qtd_Medicamentos size=10 maxlength=10></td> " + 
			  		"<td width=4%> <a href=javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Busca_Simpro/default.asp?Tipo_Busca_Simpro=50&Tipo_Produto_Simpro=50&Posicao_Vetor=" + posicaoMedicamento + "','800','600',this,event)><img src=/SmartCare/images/busca3.gif border=0></a> </td>" + 
			"</tr>" + 
		"</Table>"
 }
</script>

<Script>
function isArray(obj){return(typeof(obj.length)=="undefined")?false:true;}
//Função resposavel por carregar o medicamento inserindo o Codigo
//Usamos o ActiveX XMLHTTP para buscar o nome do medicamento
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function CarregaSimproMedicamento(Cod_Simpro_Medicamento, PosicaoVetor) //Função que recebe o value(valor) do campos e a posicao do vetor que é passado
{
	try //Inicio de tratamento de erro
		{ 
			if (isArray(Cod_Simpro_Medicamento)){
				aux_Cod_Simpro_Medicamento = Cod_Simpro_Medicamento[PosicaoVetor].value
				aux = true
			}else{
				aux_Cod_Simpro_Medicamento = Cod_Simpro_Medicamento.value
				aux = false
			}
		
			//alert(PosicaoVetor)
			var Dados; //Varivel onde ficare arazenado o resultado final
			xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
			xmlHTTP.Open('POST', '/SmartCare/Modulos/HomeCare/Atendimento/carrega.asp?Action=BuscaSimproMedicamento&Cod_Simpro_Medicamento=' + aux_Cod_Simpro_Medicamento, false); // Seta a pagina onde ira buscar os dados.
			xmlHTTP.Send(); //Envia
 
			Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
			
			if (aux == true){
				if (Dados == "") //Verifica se a variavel esta vazia
					{ 
						alert('Medicamento não encontrado\n\nCodigo nº:'+Cod_Simpro_Medicamento[PosicaoVetor].value ) //Caso esteje vazia entao é retornado a MSG de não encontrado
						document.formCadastro.Descricao_Medicamento[PosicaoVetor].value = "" //apaga o campo do nome do Nedicamento casa tenha ocorrido uma busca antes
						document.formCadastro.qtd_Medicamentos[PosicaoVetor].value = "" //apaga o campo da quantidade casa tenha ocorrido uma busca antes
						Cod_Simpro_Medicamento[PosicaoVetor].value = ''; //Apaga o campo com o codigo
						Cod_Simpro_Medicamento[PosicaoVetor].focus(); //Retorna o Focus para o campo
					 }
				else //Caso a Variavel não for vazia então e atrubuido a variavel DADOS com o valor
					{ 
						//alert(Dados); //Caso queira depurar qualquer tipo de retorno que esta tenho, basta habilitar esta linha
						//mostra_formulario.style.display = ''; //Quando encontrado o registro entao habilita o formulario que esta escondido por um DIV para ser preenchido
						document.formCadastro.Descricao_Medicamento[PosicaoVetor].value = Dados; //Mostra o valor do registo no compo indicado
					}
					
			}else{
				
				if (Dados == "") //Verifica se a variavel esta vazia
					{ 
						alert('Medicamento não encontrado\n\nCodigo nº:'+Cod_Simpro_Medicamento.value ) //Caso esteje vazia entao é retornado a MSG de não encontrado
						document.formCadastro.Descricao_Medicamento.value = "" //apaga o campo do nome do Nedicamento casa tenha ocorrido uma busca antes
						document.formCadastro.qtd_Medicamentos.value = "" //apaga o campo da quantidade casa tenha ocorrido uma busca antes
						Cod_Simpro_Medicamento.value = ''; //Apaga o campo com o codigo
						Cod_Simpro_Medicamento.focus(); //Retorna o Focus para o campo
					 }
				else //Caso a Variavel não for vazia então e atrubuido a variavel DADOS com o valor
					{ 
						//alert(Dados); //Caso queira depurar qualquer tipo de retorno que esta tenho, basta habilitar esta linha
						//mostra_formulario.style.display = ''; //Quando encontrado o registro entao habilita o formulario que esta escondido por um DIV para ser preenchido
						document.formCadastro.Descricao_Medicamento.value = Dados; //Mostra o valor do registo no compo indicado
					}
			}

		}
	catch(e)//Caso houve erro então é mostrado a descrição do erro
			{ 
				alert(e.descripition); //Descricao do erro
			}
}
</script>

