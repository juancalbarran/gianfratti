<Script>
// Autor: Fabrizio Gianfratti Manes
// Data: 30/09/2005
// Descrição: Pagina de Scripts JS
// Atualizado por: -
// Data: -
// Atualização: -
</Script>

<Script>
//Função respomsavel por inserir os campos onde será feito a solicitação médica
function cria_opcoes(Incrementa_Campo)
	{
		var Incrementa_Campo //Variavel responsavel por incrementar mais campos se a pessoa precisar
		var qtd //Variavel resposavel por namipulçar a quandidade de campos que ira precisar
		if (Incrementa_Campo == null) { qtd = '4' }	else { qtd = Incrementa_Campo } //Este IF verefica se a pessoa acabou de entrar na pagina entao a quantidade de campos que aparecera sera 5 senao, se a pessoa clicou no link para inserir mais campos entao sera incrementado de 1 em 1, coforme necessidade
		
		for (var i = 1; i <= qtd; i++) //Faz o laço conforme a variavel qtd
		{
			//usamos a instrução innerHTML para retornarmos o HTML com o campos
			//para chamar na pagina basta usar isso: <div id=Solicitacao_Medica></div> 
			Solicitacao_Medica.innerHTML = Solicitacao_Medica.innerHTML + 
				"<table width='100%' border='0' cellspacing='1' cellpadding='0'>" +
					"<tr class='zebra_orange1'>" +
						"<td class='texto' width='13%'><input class=campos name=Prescricao_Medica_Descricao id=Prescricao_Medica_Descricao type=text size=14 maxlength=500></td>" +
						"<td class='texto' width='07%'><input class=campos name=Prescricao_Medica_Dose id=Prescricao_Medica_Dose type=text size=05 maxlength=500></td>" +
						"<td class='texto' width='15%'><%=gerar_listbox_Automatico("HomeCare_Via_Administracao","","id","id_Via_Administracao","Descricao","--Selecione--","")%></td>" +
						"<td class='texto' width='15%'><%=gerar_listbox_Automatico("Periodicidade","","id","id_Periodicidade","Descricao","--Selecione--","")%></td>" + 
						"<td class='texto' width='15%'><%=gerar_listbox_Automatico("Intervalo","","id","id_Intervalo","Descricao","--Selecione--","")%></td>" + 
						"<td class='texto' width='10%'><input class=campos name=Prescricao_Medica_Qtd_Dias id=Prescricao_Medica_Qtd_Dias type=text size=8 maxlength=100></td>" + 
						"<td class='texto' width='15%'><%=gerar_listbox_Automatico("HomeCare_Prescricao_Tipo","","id","id_Prescricao_Tipo","Descricao","","1")%></td>" + 
						"<td class='texto' width='10%'><%=gerar_listbox_Automatico("HomeCare_Prescricao_Prioridade","","id","id_Prescricao_Prioridade","Descricao","","1")%></td>" + 
					"</tr>" + 
				"</Table>"
		}
	}
</Script>

<Script>
//Função respomsavel por inserir os campos onde será inserido o CID10
	var posicao = 1 //Define uma variavel que ira controlar a posicao do vetor dos campos. Este valor é usado para passar no imput como parametro
function CriaOpcoesCid10()
{
	posicao += 1 //Vai incrementando 1
	Mostra_Campos_Cid10.innerHTML = Mostra_Campos_Cid10.innerHTML +  //Vai concatenando para exibir na Div
		"<table width=100% border=0 cellspacing=1 cellpadding=0>" +
			"<tr class=zebra_orange1>" +
				"<td width=10%><input name=CID10 type=text class=campos id=CID10 onchange=CarregaCid10(formCadastro.CID10,'" + posicao + "') size=6 maxlength=6></TD>" +
				"<td width=86%><input readonly name=Diagnostico type=text class=campos id=Diagnostico size=110></Td>" +
				"<td><a href=javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Busca_Cid10/default.asp?posicao=" + posicao + "','800','600',this,event)><img src=/SmartCare/images/busca3.gif border=0></a></Td>" + 
			"</tr>" + 
		"</Table>"
 }
</script>

<Script>
//Função respomsavel por inserir os campos onde será inserido o CID10
	var posicaoExame = 1 //Define uma variavel que ira controlar a posicao do vetor dos campos. Este valor é usado para passar no imput como parametro
function CriaOpcoesExames()
{
	posicaoExame += 1 //Vai incrementando 1
	Mostra_Campos_Exames.innerHTML = Mostra_Campos_Exames.innerHTML +  //Vai concatenando para exibir na Div
		"<table width=100% border=0 cellspacing=1 cellpadding=0>" +
			"<tr class=zebra_orange1>" +
			  		"<td width=11%><input name=Cod_Exame type=text class=campos id=Cod_Exame onchange=CarregaExames(formCadastro.Cod_Exame,'" + posicaoExame + "') size=7 maxlength=7  > </td>" +
			  		"<td width=76%><input readonly name=Descricao_Exame type=text class=campos id=Descricao_Exame size=107></td>" +
			  		"<td width=4%> <a href=javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Busca_Exames/default.asp?Tipo_Busca_Simpro=50&Tipo_Produto_Simpro=50&Posicao_Vetor=" + posicaoExame + "','800','600',this,event)><img src=/SmartCare/images/busca3.gif border=0></a> </td>" + 
			"</tr>" + 
		"</Table>"
 }
</script>

<script>
function isArray(obj){return(typeof(obj.length)=="undefined")?false:true;}

//Função resposavel por carregar o CID10 inserindo o Codigo
//Usamos o ActiveX XMLHTTP para buscar o nome do Diagnostico
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function CarregaCid10(Cid10, PosicaoVetor) //Função que recebe o value(valor) do campos e a posicao do vetor que é passado
{
	try //Inicio de tratamento de erro
		{ 
			//alert(PosicaoVetor)
			var Dados; //Varivel onde ficare arazenado o resultado final
			xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
			xmlHTTP.Open('POST', '/SmartCare/Modulos/HomeCare/Atendimento/carrega.asp?Action=BuscaCid10&Cid10=' + Cid10[PosicaoVetor].value, false); // Seta a pagina onde ira buscar os dados.
			xmlHTTP.Send(); //Envia
 
			Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel

			if (Dados == "") //Verifica se a variavel esta vazia
				{ 
					alert('CID 10 não encontrado\n\nCid10:'+Cid10[PosicaoVetor].value ) //Caso esteje vazia entao é retornado a MSG de não encontrado
					document.formCadastro.Diagnostico[PosicaoVetor].value = "" //apaga o campo do nome do CID casa tenha ocorrido uma busca antes
					Cid10[PosicaoVetor].value = ''; //Apaga o campo com o codigo cid10
					Cid10[PosicaoVetor].focus(); //Retorna o Focus para o campo
				 }
			else //Caso a Variavel não for vazia então e atrubuido a variavel DADOS com o valor
				{ 
					//alert(Dados); //Caso queira depurar qualquer tipo de retorno que esta tenho, basta habilitar esta linha
					//mostra_formulario.style.display = ''; //Quando encontrado o registro entao habilita o formulario que esta escondido por um DIV para ser preenchido
					document.formCadastro.Diagnostico[PosicaoVetor].value = Dados; //Mostra o valor do registo no compo indicado
				}

		}
	catch(e)//Caso houve erro então é mostrado a descrição do erro
			{ 
				alert(e.descripition); //Descricao do erro
			}
}
</script>

<Script>
//Função resposavel por carregar os exames inserindo o Codigo
//Usamos o ActiveX XMLHTTP para buscar o nome do exame
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function CarregaExames(Cod_Exame, PosicaoVetor) //Função que recebe o value(valor) do campos e a posicao do vetor que é passado
{
	try //Inicio de tratamento de erro
		{ 
			//alert(PosicaoVetor)
			var Dados; //Varivel onde ficare arazenado o resultado final
			xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
			xmlHTTP.Open('POST', '/SmartCare/Modulos/HomeCare/Atendimento/carrega.asp?Action=BuscaExame&Cod_Exame=' + Cod_Exame[PosicaoVetor].value, false); // Seta a pagina onde ira buscar os dados.
			xmlHTTP.Send(); //Envia
 
			Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel

			if (Dados == "") //Verifica se a variavel esta vazia
				{ 
					alert('Exame não encontrado\n\nCodigo nº:'+Cod_Exame[PosicaoVetor].value ) //Caso esteje vazia entao é retornado a MSG de não encontrado
					document.formCadastro.Descricao_Exame[PosicaoVetor].value = "" //apaga o campo do nome do Exame casa tenha ocorrido uma busca antes
					Cod_Exame[PosicaoVetor].value = ''; //Apaga o campo com o codigo
					Cod_Exame[PosicaoVetor].focus(); //Retorna o Focus para o campo
				 }
			else //Caso a Variavel não for vazia então e atrubuido a variavel DADOS com o valor
				{ 
					//alert(Dados); //Caso queira depurar qualquer tipo de retorno que esta tenho, basta habil????????ò?e???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????>itar esta linha
					//mostra_formulario.style.display = ''; //Quando encontrado o registro entao habilita o formulario que esta escondido por um DIV para ser preenchido
					document.formCadastro.Descricao_Exame[PosicaoVetor].value = Dados; //Mostra o valor do registo no compo indicado
				}

		}
	catch(e)//Caso houve erro então é mostrado a descrição do erro
			{ 
				alert(e.descripition); //Descricao do erro
			}
}
</script>


<script>
//FUNÇÃO QUE FAZ AS VALIDAÇÕES DO FORMULARIO
function valida_campo()
{
<!--
var Data_Evolucao = document.formCadastro.Data_Evolucao.value
if (Data_Evolucao==""){
	alert("Entre com a Data Evolução");
	document.formCadastro.Data_Evolucao.focus()
	return false
	}
var Texto = document.formCadastro.Texto.value
if (Texto==""){
	alert("Entre com o texto de evolução do paciente");
	document.formCadastro.Texto.focus()
	return false
	}
//Valida o bloco de campos para prescricoes medicas
	marcado = -1
	for (i=0; i<formCadastro.Prescricao_Medica_Descricao.length; i++) 
	{
		if (formCadastro.Prescricao_Medica_Descricao[i].value) 
		{
			marcado = i
		}
		/*if (marcado == -1)  //Verifica se não foi preenchido nenhum campo
		{
			alert("É obrigatorio o preenchimento de pelo menos 1 material");
			formCadastro.Prescricao_Medica_Descricao[i].focus();
			return false;
		}
		*/
		if (formCadastro.Prescricao_Medica_Descricao[i].value != "" && formCadastro.id_Prescricao_Prioridade[i].value == "" ) //Verifica se foi selecionado um material e se nao foi preenchido a quantidade
		{
			alert("Selecione a prioridade para a prescrição:\n\n" + document.formCadastro.Prescricao_Medica_Descricao[i].value);
			formCadastro.id_Prescricao_Prioridade[i].focus();
			return false;
		}
	}
//Valida o bloco de campos para exames
	marcado = -1
	for (i=0; i<formCadastro.Cod_Exame.length; i++) 
	{
		if (formCadastro.Cod_Exame[i].value) 
		{
			marcado = i
		}
		/*if (marcado == -1)  //Verifica se não foi preenchido nenhum campo
		{
			alert("É obrigatorio o preenchimento de pelo menos 1 exame");
			formCadastro.Cod_Exame[i].focus();
			return false;
		}
		*/

	}
	


	//document.formCadastro.submit.value="Aguarde..!!" //Se todos os campos obrigatorios foram preenchidos o botão sera desabilitado para não haver duplicação de registros caso ele clique mais um uma vez
 	//document.formCadastro.submit.disabled=true;
}
//-->
</script>

