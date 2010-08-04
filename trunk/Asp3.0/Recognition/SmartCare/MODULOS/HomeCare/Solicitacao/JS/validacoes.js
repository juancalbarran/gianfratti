<Script>
// Autor: Fabrizio Gianfratti Manes
// Data: 02/02/2005
// Descrição: Pagina de Scripts JS
// Atualizado por: -
// Data: -
// Atualização: -
</Script>

<script>
//Função resposavel por carregar os dados do Paciente
//Usamos o ActiveX XMLHTTP para buscar os dados do paciente, esta forma de recuperação é muito boa
//O XMLHTTP vai ate a pagia onde esta a consulta e busca todo o resultado apresentado por ela
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function CarregaPacientes()
{
	//Antes de carregar os dados do paciente verifca se o CPF é valido
	if (!Valida_CPF(document.form.busca.value)){document.form.busca.value = "";return false;}

	try //Inicio de tratamento de erro
		{ 
			var Dados; //Varivel onde ficare arazenado o resultado final
			xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
			xmlHTTP.Open('POST', 'carrega.asp?Action=Carrega_Dados_Cadastro_Pacientes&Busca=' + document.form.busca.value, false); // Seta a pagina onde ira buscar os dados.
			xmlHTTP.Send(); //Envia
 
			Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
			if (Dados == "") //Verifica se a variavel esta vazia
				{ 
					if (confirm("Paciente não encontrado\n\nDeseja cadastrar um novo paciente ?"  ))
						{
							location = "/SmartCare/Pacientes/default.asp?action=Confere_CPF&PaginaSolicitacao=1&Confere_CPF=" + document.form.busca.value  ;
						}
					//alert('Paciente não encontrado') //Caso esteje vazia entao é retornado a MSG de não encontrado
					document.form.busca.focus(); //Retorna o Focus para o campo
					document.form.busca.select(); //Quando retorna para o campo com o comando acima ele traz o valor selecionado
				 }
			else //Caso a Variavel não for vazia então e atrubuido a variavel DADOS com o valor
				{ 
					//alert(Dados); //Caso queira depurar qualquer tipo de retorno que esta tenho, basta habilitar esta linha
					mostra_formulario.style.display = ''; //Quando encontrado o registro entao habilita o formulario que esta escondido por um DIV para ser preenchido
					Cadastro_Paciente.innerHTML = Dados //Armazena o conteudo da variavel DADOS em Cadastro_Pacienteo que é o id da DIV para usar mostrar na pagina basta usar isso: <div id=Cadastro_Paciente></div>
					//document.form.Nome.value = Dados; //Mostra o valor do registo no compo indicado

				}
		}
	catch(e)//Caso houve erro então é mostrado a descrição do erro
			{ 
				alert(e.descripition); //Descricao do erro
			}
}
</script>

<script>
//Função resposavel por carregar o nome do medico inserindo o CRM
//Usamos o ActiveX XMLHTTP para buscar o nome do medico
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function CarregaMedico()
{
	try //Inicio de tratamento de erro
		{ 
			var Dados; //Varivel onde ficare arazenado o resultado final
			xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
			xmlHTTP.Open('POST', 'carrega.asp?Action=BuscaMedico&CRM=' + document.formCadastro.Medico_Solicitante_CRM.value, false); // Seta a pagina onde ira buscar os dados.
			xmlHTTP.Send(); //Envia
 
			Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel

			if (Dados == "") //Verifica se a variavel esta vazia
				{ 
					alert('Medico não encontrado\n\nCRM:'+document.formCadastro.Medico_Solicitante_CRM.value ) //Caso esteje vazia entao é retornado a MSG de não encontrado
					document.formCadastro.Medico_Solicitante.value = "" //apaga o campo do nome do medico casa tenha ocorrido uma busca antes
					document.formCadastro.Medico_Solicitante_CRM.focus(); //Retorna o Focus para o campo
					document.formCadastro.Medico_Solicitante_CRM.select(); //Quando retorna para o campo com o comando acima ele traz o valor selecionado
				 }
			else //Caso a Variavel não for vazia então e atrubuido a variavel DADOS com o valor
				{ 
					//alert(Dados); //Caso queira depurar qualquer tipo de retorno que esta tenho, basta habilitar esta linha
					//mostra_formulario.style.display = ''; //Quando encontrado o registro entao habilita o formulario que esta escondido por um DIV para ser preenchido
					document.formCadastro.Medico_Solicitante.value = Dados; //Mostra o valor do registo no compo indicado
				}
		}
	catch(e)//Caso houve erro então é mostrado a descrição do erro
			{ 
				alert(e.descripition); //Descricao do erro
			}
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
			xmlHTTP.Open('POST', 'carrega.asp?Action=BuscaCid10&Cid10=' + Cid10[PosicaoVetor].value, false); // Seta a pagina onde ira buscar os dados.
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
//Função respomsavel por inserir os campos onde será inserido o CID10
function CriaOpcoesProfissional()
{
	
	Mostra_Campos_Profissional.innerHTML = Mostra_Campos_Profissional.innerHTML +  //Vai concatenando para exibir na Div
		"<table width=100% border=0 cellspacing=1 cellpadding=0>" +
			"<tr class=zebra_orange1>" +
				"<td width=9%>Profissional: </td>" +
			  	"<td width=19%> " + 
					  "<select class=texto name=Profissional id=Profissional>" +
						  "<option value=>&lt;&lt;--Selecione--&gt;&gt;</option>" +
						  "<option value=M&eacute;dico>M&eacute;dico</option>" +
						  "<option value=Enfermeira>Enfermeira</option>" +
						  "<option value=Aux. Enfermegem>Aux. Enfermegem</option>" +
						  "<option value=Fisioterapeuta>Fisioterapeuta</option>" +
						  "<option value=Psic&oacute;logo>Psic&oacute;logo</option>" +
						  "<option value=Terapeuta Ocupacional>Terapeuta Ocupacional</option>" +
						  "<option value=Psiquiatra>Psiquiatra</option>" +
						  "<option value=Fonoaudióloga>Fonoaudióloga</option>" +
						  "<option value=Nutricionista>Nutricionista</option>" +
						"</select>" +
				"</td> " +
				"<td width=9%>Periodicidade:</td>" +
			  	"<td width=44%><input name=Profissional_Periodicidade type=text class=campos id=Profissional_Periodicidade size=63></td>" +
				"<td width=11%>Valor: (9999.99)</td>" +
			  	"<td width=8%><input name=ValorProfissional type=text class=campos id=ValorProfissional size=9></td>" +
			"</tr>" + 
		"</Table>"
 }
</script>

<Script>
//Função respomsavel por inserir os campos onde será inserido o Equipamento
function CriaOpcoesEquipamento()
{
	
	Mostra_Campos_Equipamento.innerHTML = Mostra_Campos_Equipamento.innerHTML +  //Vai concatenando para exibir na Div
		"<table width=100% border=0 cellspacing=1 cellpadding=0>" +
			"<tr class=zebra_orange1>" +
				"<td width=9%>Equipamentos: </td>" +
			  	"<td width=49%> " + 
					  "<input name=Equipamento type=text class=campos id=Equipamento size=71>" +
				"</td> " +
				"<td width=6%>Qtd:</td>" +
			  	"<td width=17%><input name=QtdEquipamento class=campos type=text id=QtdEquipamento size=17></td>" +
				"<td width=11%>Valor: (9999.99)</td>" +
			  	"<td width=8%><input name=ValorEquipamento type=text class=campos id=ValorEquipamento size=9></td>" +
			"</tr>" + 
		"</Table>"
 }
</script>

<Script>
//Função respomsavel por inserir os campos onde será inserido o Material
function CriaOpcoesMaterial()
{
	
	Mostra_Campos_Material.innerHTML = Mostra_Campos_Material.innerHTML +  //Vai concatenando para exibir na Div
		"<table width=100% border=0 cellspacing=1 cellpadding=0>" +
			"<tr class=zebra_orange1>" +
				"<td width=9%>Material: </td>" +
			  	"<td width=49%> " + 
					  "<input name=Material type=text class=campos id=Material size=71>" +
				"</td> " +
				"<td width=6%>Qtd:</td>" +
			  	"<td width=17%><input name=QtdMaterial class=campos type=text id=QtdMaterial size=17></td>" +
				"<td width=11%>Valor: (9999.99)</td>" +
			  	"<td width=8%><input name=ValorMaterial type=text class=campos id=ValorMaterial size=9></td>" +
			"</tr>" + 
		"</Table>"
 }
</script>

<Script>
//Função respomsavel por inserir os campos onde será inserido o Material
function CriaOpcoesDieta()
{
	
	Mostra_Campos_Dieta.innerHTML = Mostra_Campos_Dieta.innerHTML +  //Vai concatenando para exibir na Div
		"<table width=100% border=0 cellspacing=1 cellpadding=0>" +
			"<tr class=zebra_orange1>" +
				"<td width=9%>Dieta: </td>" +
			  	"<td width=49%> " + 
					  "<input name=Dieta type=text class=campos id=Dieta size=71>" +
				"</td> " +
				"<td width=6%>Qtd:</td>" +
			  	"<td width=17%><input name=QtdDieta class=campos type=text id=QtdDieta size=17></td>" +
				"<td width=11%>Valor: (9999.99)</td>" +
			  	"<td width=8%><input name=ValorDieta type=text class=campos id=ValorDieta size=9></td>" +
			"</tr>" + 
		"</Table>"
 }
</script>


<Script>
//Função respomsavel por inserir os campos onde será inserido o CID10
	var posicao = 1 //Define uma variavel que ira controlar a posicao do vetor dos campos. Este valor é usado para passar no imput como parametro
function CriaOpcoesCid10()
{
	
	posicao += 1 //Vai incrementando 1
	Mostra_Campos_Cid10.innerHTML = Mostra_Campos_Cid10.innerHTML +  //Vai concatenando para exibir na Div
		"<table width=100% border=0 cellspacing=1 cellpadding=0>" +
			"<tr class=zebra_orange1>" +
				"<td width=6%>Cid 10: </td>" +
			  	"<td width=7%><input name=CID10 type=text class=campos id=CID10 onchange=CarregaCid10(formCadastro.CID10,'" + posicao + "') size=6 maxlength=6  ></td> " +
				"<td width=10%>Diagnostico: </td>" +
			  	"<td width=69%><input readonly name=Diagnostico type=text class=campos id=Diagnostico size=90></td>" +
			  	"<td width=8%><a href=javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Busca_Cid10/default.asp?posicao=" + posicao + "','800','600',this,event)><img src=/SmartCare/images/busca3.gif border=0></a></td>" +
			"</tr>" + 
		"</Table>"
 }
</script>

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
						"<td class='texto' width='35%'>Prescrição:&nbsp;<input class='campos' name='Solicitacao_Medica_Descricao' type='text' size='37' maxlength='500'></td>" +
						"<td class='texto' width='25%'>Periodicidade:&nbsp;<input class='campos' name='Periodicidade' type='text' size='18' maxlength='100'></td>" + 
						"<td class='texto' width='25%'>Qdt Dias:&nbsp;<input class='campos' name='Qtd_Dias' type='text' size='17' maxlength='100'></td>" + 
						"<td class='texto' width='15%'>Valor:&nbsp;(9999.99)&nbsp;<input class='campos' name='ValorPrescricao' type='text' size='9' maxlength='100'></td>" + 
					"</tr>" + 
				"</Table>"
		}
	}
</Script>

<script>
//Função resposavel por deletar os itens da solicitaçaõ
//O XMLHTTP vai ate a pagia onde esta a consulta e busca todo o resultado apresentado por ela
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function DeletarItensSolicitacao(id_Solicitacao_Medica_Itens,Solicitacao_Descricao)
{
	if (confirm("Tem certeza que deseja apagar a prescrição médica:\n\n " + Solicitacao_Descricao ))
		{
			try //Inicio de tratamento de erro
				{ 
					var Dados; //Varivel onde ficare arazenado o resultado final
					xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
					xmlHTTP.Open('POST', 'carrega.asp?Action=DeletarItensSolicitacao&id_Solicitacao_Medica_Itens=' + id_Solicitacao_Medica_Itens + '&id_Solicitacao_Atendimento=' + document.formCadastro.id.value , false); // Seta a pagina onde ira apagar o registro.
					xmlHTTP.Send(); //Envia
		 
					Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
							Carrega_Solicitacao_Medica_Itens.innerHTML = Dados //Armazena o conteudo da variavel DADOS em Cadastro_Pacienteo que é o id da DIV para usar mostrar na pagina basta usar isso: <div id=Cadastro_Paciente></div>
				}
			catch(e)//Caso houve erro então é mostrado a descrição do erro
					{ 
						alert(e.descripition); //Descricao do erro
					}
		}
}
</script>

<script>
//Função resposavel por deletar os profissionais da solicitacao
//O XMLHTTP vai ate a pagia onde esta a consulta e busca todo o resultado apresentado por ela
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function DeletarProfissionais(Id_Profissional,Profissional)
{
	if (confirm("Tem certeza que deseja apagar o profissional:\n\n " + Profissional ))
		{
			try //Inicio de tratamento de erro
				{ 
					var Dados; //Varivel onde ficare arazenado o resultado final
					xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
					xmlHTTP.Open('POST', 'carrega.asp?Action=DeletarProfissionais&Id_Profissional=' + Id_Profissional + '&id_Solicitacao_Atendimento=' + document.formCadastro.id.value , false); // Seta a pagina onde ira apagar o registro.
					xmlHTTP.Send(); //Envia
		 
					Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
							Carrega_Profissionais.innerHTML = Dados //Armazena o conteudo da variavel DADOS em Cadastro_Pacienteo que é o id da DIV para usar mostrar na pagina basta usar isso: <div id=Cadastro_Paciente></div>
				}
			catch(e)//Caso houve erro então é mostrado a descrição do erro
					{ 
						alert(e.descripition); //Descricao do erro
					}
		}
}
</script>


<script>
//Função resposavel por deletar os itens do CID10 da solicitacao
//O XMLHTTP vai ate a pagia onde esta a consulta e busca todo o resultado apresentado por ela
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function DeletarItensCid10(Id_Diagnostico_Entrada,Cid10_Descricao)
{
	if (confirm("Tem certeza que deseja apagar o Diagnostico:\n\n " + Cid10_Descricao ))
		{
			try //Inicio de tratamento de erro
				{ 
					var Dados; //Varivel onde ficare arazenado o resultado final
					xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
					xmlHTTP.Open('POST', 'carrega.asp?Action=DeletarItensCid10&Id_Diagnostico_Entrada=' + Id_Diagnostico_Entrada + '&id_Solicitacao_Atendimento=' + document.formCadastro.id.value , false); // Seta a pagina onde ira apagar o registro.
					xmlHTTP.Send(); //Envia
		 
					Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
							Carrega_Itens_Cid10.innerHTML = Dados //Armazena o conteudo da variavel DADOS em Cadastro_Pacienteo que é o id da DIV para usar mostrar na pagina basta usar isso: <div id=Cadastro_Paciente></div>
				}
			catch(e)//Caso houve erro então é mostrado a descrição do erro
					{ 
						alert(e.descripition); //Descricao do erro
					}
		}
}
</script>

<script>
//Função resposavel por deletar os equipamentos da solicitacao
//O XMLHTTP vai ate a pagia onde esta a consulta e busca todo o resultado apresentado por ela
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function DeletarEquipamentos(Id_Equipamento,Equipamento)
{
	if (confirm("Tem certeza que deseja apagar o equipamento:\n\n " + Equipamento ))
		{
			try //Inicio de tratamento de erro
				{ 
					var Dados; //Varivel onde ficare arazenado o resultado final
					xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
					xmlHTTP.Open('POST', 'carrega.asp?Action=DeletarEquipamentos&Id_Equipamento=' + Id_Equipamento + '&id_Solicitacao_Atendimento=' + document.formCadastro.id.value , false); // Seta a pagina onde ira apagar o registro.
					xmlHTTP.Send(); //Envia
		 
					Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
					Carrega_Equipamentos.innerHTML = Dados //Armazena o conteudo da variavel DADOS em Cadastro_Pacienteo que é o id da DIV para usar mostrar na pagina basta usar isso: <div id=Cadastro_Paciente></div>
				}
			catch(e)//Caso houve erro então é mostrado a descrição do erro
					{ 
						alert(e.descripition); //Descricao do erro
					}
		}
}
</script>

<script>
//Função resposavel por deletar os materiais da solicitacao
//O XMLHTTP vai ate a pagia onde esta a consulta e busca todo o resultado apresentado por ela
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function DeletarMaterial(Id_Material,Material)
{
	if (confirm("Tem certeza que deseja apagar o material:\n\n " + Material ))
		{
			try //Inicio de tratamento de erro
				{ 
					var Dados; //Varivel onde ficare arazenado o resultado final
					xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
					xmlHTTP.Open('POST', 'carrega.asp?Action=DeletarMateriais&Id_Material=' + Id_Material + '&id_Solicitacao_Atendimento=' + document.formCadastro.id.value , false); // Seta a pagina onde ira apagar o registro.
					xmlHTTP.Send(); //Envia
		 
					Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
					Carrega_Materiais.innerHTML = Dados //Armazena o conteudo da variavel DADOS em Cadastro_Pacienteo que é o id da DIV para usar mostrar na pagina basta usar isso: <div id=Cadastro_Paciente></div>
				}
			catch(e)//Caso houve erro então é mostrado a descrição do erro
					{ 
						alert(e.descripition); //Descricao do erro
					}
		}
}
</script>

<script>
//Função resposavel por deletar as dietas da solicitacao
//O XMLHTTP vai ate a pagia onde esta a consulta e busca todo o resultado apresentado por ela
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function DeletarDieta(Id_Dieta,Dieta)
{
	if (confirm("Tem certeza que deseja apagar a dieta:\n\n " + Dieta ))
		{
			try //Inicio de tratamento de erro
				{ 
					var Dados; //Varivel onde ficare arazenado o resultado final
					xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
					xmlHTTP.Open('POST', 'carrega.asp?Action=DeletarDietas&Id_Dieta=' + Id_Dieta + '&id_Solicitacao_Atendimento=' + document.formCadastro.id.value , false); // Seta a pagina onde ira apagar o registro.
					xmlHTTP.Send(); //Envia
		 
					Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
					Carrega_Dietas.innerHTML = Dados //Armazena o conteudo da variavel DADOS em Cadastro_Pacienteo que é o id da DIV para usar mostrar na pagina basta usar isso: <div id=Cadastro_Paciente></div>
				}
			catch(e)//Caso houve erro então é mostrado a descrição do erro
					{ 
						alert(e.descripition); //Descricao do erro
					}
		}
}
</script>

<Script>
//Função responsavel por mostrar as DIV que estao escondidas no formulario
function Tipo_Requisicao_Opcao()
{
	document.all.Mostra_Tipo_Hospital.style.display='none';
	document.all.Mostra_Tipo_Hospital.disabled='true';
	document.all.botao3.style.display='none';
	document.all.botao3.disabled='true';

	if (document.formCadastro.id_Solicitacao_Requisicao_Tipo[0].checked==1)
	{
		document.all.Mostra_Tipo_Hospital.style.display='';
		document.all.Mostra_Tipo_Hospital.disabled='';
	}
	if (document.formCadastro.id_Solicitacao_Requisicao_Tipo[2].checked==1)
	{
		document.all.botao3.style.display='';
		document.all.botao3.disabled='';
	}

}
</script>

<Script>
//Função responsavel por mostrar as DIV que estao escondidas no formulario
function Cancelar_Solicitacao(id_Solicitacao,Nome_Paciente)
{
	
	if (confirm("<%=Session("Funcionario_Nome")%>\n\nTem certeza que deseja cancelar a solicitação nº " + id_Solicitacao + "?"  ))
		{
		location = "default.asp?action=Cancelar_Solicitacao&id_Solicitacao=" + id_Solicitacao ;
		}

}
</script>

<Script>
//Função Resposavel por verificar o status da solicitação quando for alterar
function VerificaStatus(id_Solicitacao_Status)
{	//Verifica o Status da Solicitacao
	//Caso a solicitação seja diferente de 'Em Analise' entao o botao para alterar é desabilitado
	if (id_Solicitacao_Status == "2" || id_Solicitacao_Status == "3") //Verifica os status
	{
		alert('Solicitação não pode ser alterada porque não esta mais em analise')
		return false
	}
}
</Script>

<script>
//FUNÇÃO QUE FAZ AS VALIDAÇÕES DO FORMULARIO
function valida_campo()
{
<!--
//validacao box  de tipo solicitação
var id_Solicitacao_Tipo = document.formCadastro.id_Solicitacao_Tipo.value
if (id_Solicitacao_Tipo==""){
	alert("Selecione o tipo de solicitação");
	document.formCadastro.id_Solicitacao_Tipo.focus()
	return false
	}
//Fim box  de tipo de remoção

//validacao box  de tipo de remoção
var id_Solicitacao_Remocao_Tipo = document.formCadastro.id_Solicitacao_Remocao_Tipo.value
if (id_Solicitacao_Remocao_Tipo==""){
	alert("Selecione o tipo de remoção do paciente");
	document.formCadastro.id_Solicitacao_Remocao_Tipo.focus()
	return false
	}
//Fim box  de tipo de remoção


//validacao de radio buttons do campos id_Solicitacao_Requisicao_Tipo
	marcado = -1
	for (i=0; i<formCadastro.id_Solicitacao_Requisicao_Tipo.length; i++) {
		if (formCadastro.id_Solicitacao_Requisicao_Tipo[i].checked) {
			marcado = i
			resposta = formCadastro.id_Solicitacao_Requisicao_Tipo[i].value
		}
	}
	if (marcado == -1) {
		alert("Escolha o tipo de requisição da solicitação");
		formCadastro.id_Solicitacao_Requisicao_Tipo[0].focus();
		return false;
	}
	else { //esse else so foi colocado para evitar que o form desse o submit
		if (resposta == 1 && document.formCadastro.id_Hospital.value == "" ) 
		{
			alert("Selecione o hospital que fez a solicitação");
			document.formCadastro.id_Hospital.focus()
			return false;
		}
		if (resposta == 3 && document.formCadastro.Tipo_Requisicao_Outros.value == "" ) 
		{
			alert("Especifique o tipo de requisição");
			document.formCadastro.Tipo_Requisicao_Outros.focus()
			return false;
		}
	} 

//Fim validação campo radio

var Medico_Solicitante_CRM = document.formCadastro.Medico_Solicitante_CRM.value
if (Medico_Solicitante_CRM==""){
	alert("Entre com o CRM do médico");
	document.formCadastro.Medico_Solicitante_CRM.focus()
	return false
	}
	
var Medico_Solicitante = document.formCadastro.Medico_Solicitante.value
if (Medico_Solicitante==""){
	alert("Entre com o CRM do médico para buscar o nome do médico");
	document.formCadastro.Medico_Solicitante.focus()
	return false
	}

/*
//Como este campo pode ter varios campos com o mesmo nome entao pelo menos 1 deles tem que ser preenchido
	marcado = -1
	for (i=0; i<formCadastro.CID10.length; i++) 
	{
		if (formCadastro.CID10[i].value) 
		{
			marcado = i
			resposta = formCadastro.CID10[i].value
		}
	}
	if (marcado == -1) 
	{
		alert("É obrigatorio o preenchimento de pelo menos 1 diagnostico de entrada");
		formCadastro.CID10[0].focus();
		return false;
	}
//Fim validação 
*/

/*
//Como este campo pode ter varios campos com o mesmo nome entao pelo menos 1 deles tem que ser preenchido
	marcado = -1
	for (i=0; i<formCadastro.Solicitacao_Medica_Descricao.length; i++) 
	{
		if (formCadastro.Solicitacao_Medica_Descricao[i].value) 
		{
			marcado = i
			resposta = formCadastro.Solicitacao_Medica_Descricao[i].value
		}
	}
	if (marcado == -1) 
	{
		alert("É obrigatorio o preenchimento de pelo menos 1 campo na solicitação médica");
		formCadastro.Solicitacao_Medica_Descricao[0].focus();
		return false;
	}
//Fim validação 
*/

var id_Funcionario_Medico_Avaliador = document.formCadastro.id_Funcionario_Medico_Avaliador.value
if (id_Funcionario_Medico_Avaliador != "" && (document.formCadastro.Medico_Avaliador_Data.value =="" || document.formCadastro.Medico_Avaliador_Hora.value =="")){
	alert("Entre com a data e a hora que o médico avaliador fez a avaliação");
	document.formCadastro.Medico_Avaliador_Data.focus()
	return false
	}

var id_Funcionario_Enfermeiro_Avaliador = document.formCadastro.id_Funcionario_Enfermeiro_Avaliador.value
if (id_Funcionario_Enfermeiro_Avaliador != "" && (document.formCadastro.Enfermeiro_Avaliador_Data.value =="" || document.formCadastro.Enfermeiro_Avaliador_Hora.value =="")){
	alert("Entre com a data e a hora que o enfermeiro avaliador fez a avaliação");
	document.formCadastro.Enfermeiro_Avaliador_Data.focus()
	return false
	}

var id_Funcionario_Assistente_Social_Avaliador = document.formCadastro.id_Funcionario_Assistente_Social_Avaliador.value
if (id_Funcionario_Assistente_Social_Avaliador != "" && (document.formCadastro.Assistente_Social_Avaliador_Data.value =="" || document.formCadastro.Assistente_Social_Avaliador_Hora.value =="")){
	alert("Entre com a data e a hora que a assistente avaliadora fez a avaliação");
	document.formCadastro.Assistente_Social_Avaliador_Data.focus()
	return false
	}

var id_Funcionario_Fisioterapeuta_Avaliador = document.formCadastro.id_Funcionario_Fisioterapeuta_Avaliador.value
if (id_Funcionario_Fisioterapeuta_Avaliador != "" && (document.formCadastro.Fisioterapeuta_Avaliador_Data.value =="" || document.formCadastro.Fisioterapeuta_Avaliador_Hora.value =="")){
	alert("Entre com a data e a hora que a fisioterapeura avaliadora fez a avaliação");
	document.formCadastro.Fisioterapeuta_Avaliador_Data.focus()
	return false
	}

var id_Solicitacao_Status = document.formCadastro.id_Solicitacao_Status.value
if (id_Solicitacao_Status==""){
	alert("Selecione o status dessa solicitação");
	document.formCadastro.id_Solicitacao_Status.focus()
	return false
	}

var id_Solicitacao_Status = document.formCadastro.id_Solicitacao_Status.value
if (id_Solicitacao_Status=="3" && document.formCadastro.Motivo_Solicitacao_Negada.value =="" ){
	alert("Entre com o motivo da negação desta solicitação");
	document.formCadastro.Motivo_Solicitacao_Negada.focus()
	return false
	}

	//document.formCadastro.submit.value="Aguarde..!!" //Se todos os campos obrigatorios foram preenchidos o botão sera desabilitado para não haver duplicação de registros caso ele clique mais um uma vez
 	//document.formCadastro.submit.disabled=true;
}
//-->
</script>

<Script>
//FUNÇÃO QUE FAZ AS VALIDAÇÕES DO FORMULARIO QUANDO ESTA FAZENDO A EDICAO
function valida_campo_editar()
{
<!--
//validacao box  de tipo solicitação
var id_Solicitacao_Tipo = document.formCadastro.id_Solicitacao_Tipo.value
if (id_Solicitacao_Tipo==""){
	alert("Selecione o tipo de solicitação");
	document.formCadastro.id_Solicitacao_Tipo.focus()
	return false
	}
//Fim box  de tipo de remoção

//validacao de radio buttons do campos id_Solicitacao_Requisicao_Tipo
	marcado = -1
	for (i=0; i<formCadastro.id_Solicitacao_Requisicao_Tipo.length; i++) {
		if (formCadastro.id_Solicitacao_Requisicao_Tipo[i].checked) {
			marcado = i
			resposta = formCadastro.id_Solicitacao_Requisicao_Tipo[i].value
		}
	}
	if (marcado == -1) {
		alert("Escolha o tipo de requisição da solicitação");
		formCadastro.id_Solicitacao_Requisicao_Tipo[0].focus();
		return false;
	}
	else { //esse else so foi colocado para evitar que o form desse o submit
		if (resposta == 1 && document.formCadastro.id_Hospital.value == "" ) 
		{
			alert("Selecione o hospital que fez a solicitação");
			document.formCadastro.id_Hospital.focus()
			return false;
		}
		if (resposta == 3 && document.formCadastro.Tipo_Requisicao_Outros.value == "" ) 
		{
			alert("Especifique o tipo de requisição");
			document.formCadastro.Tipo_Requisicao_Outros.focus()
			return false;
		}
	} 

//Fim validação campo radio

//validacao box  de tipo de remoção
var id_Solicitacao_Remocao_Tipo = document.formCadastro.id_Solicitacao_Remocao_Tipo.value
if (id_Solicitacao_Remocao_Tipo==""){
	alert("Selecione o tipo de remoção do paciente");
	document.formCadastro.id_Solicitacao_Remocao_Tipo.focus()
	return false
	}
//Fim box  de tipo de remoção

var Medico_Solicitante_CRM = document.formCadastro.Medico_Solicitante_CRM.value
if (Medico_Solicitante_CRM==""){
	alert("Entre com o CRM do médico");
	document.formCadastro.Medico_Solicitante_CRM.focus()
	return false
	}
	

var id_Funcionario_Medico_Avaliador = document.formCadastro.id_Funcionario_Medico_Avaliador.value
if (id_Funcionario_Medico_Avaliador != "" && (document.formCadastro.Medico_Avaliador_Data.value =="" || document.formCadastro.Medico_Avaliador_Hora.value =="")){
	alert("Entre com a data e a hora que o médico avaliador fez a avaliação");
	document.formCadastro.Medico_Avaliador_Data.focus()
	return false
	}

var id_Funcionario_Enfermeiro_Avaliador = document.formCadastro.id_Funcionario_Enfermeiro_Avaliador.value
if (id_Funcionario_Enfermeiro_Avaliador != "" && (document.formCadastro.Enfermeiro_Avaliador_Data.value =="" || document.formCadastro.Enfermeiro_Avaliador_Hora.value =="")){
	alert("Entre com a data e a hora que o enfermeiro avaliador fez a avaliação");
	document.formCadastro.Enfermeiro_Avaliador_Data.focus()
	return false
	}

var id_Funcionario_Assistente_Social_Avaliador = document.formCadastro.id_Funcionario_Assistente_Social_Avaliador.value
if (id_Funcionario_Assistente_Social_Avaliador != "" && (document.formCadastro.Assistente_Social_Avaliador_Data.value =="" || document.formCadastro.Assistente_Social_Avaliador_Hora.value =="")){
	alert("Entre com a data e a hora que a assistente avaliadora fez a avaliação");
	document.formCadastro.Assistente_Social_Avaliador_Data.focus()
	return false
	}

var id_Funcionario_Fisioterapeuta_Avaliador = document.formCadastro.id_Funcionario_Fisioterapeuta_Avaliador.value
if (id_Funcionario_Fisioterapeuta_Avaliador != "" && (document.formCadastro.Fisioterapeuta_Avaliador_Data.value =="" || document.formCadastro.Fisioterapeuta_Avaliador_Hora.value =="")){
	alert("Entre com a data e a hora que a fisioterapeura avaliadora fez a avaliação");
	document.formCadastro.Fisioterapeuta_Avaliador_Data.focus()
	return false
	}

var id_Solicitacao_Status = document.formCadastro.id_Solicitacao_Status.value
if (id_Solicitacao_Status==""){
	alert("Selecione o status dessa solicitação");
	document.formCadastro.id_Solicitacao_Status.focus()
	return false
	}

var id_Solicitacao_Status = document.formCadastro.id_Solicitacao_Status.value
if (id_Solicitacao_Status=="3" && document.formCadastro.Motivo_Solicitacao_Negada.value =="" ){
	alert("Entre com o motivo da negação desta solicitação");
	document.formCadastro.Motivo_Solicitacao_Negada.focus()
	return false
	}

	//document.formCadastro.submit.value="Aguarde..!!" //Se todos os campos obrigatorios foram preenchidos o botão sera desabilitado para não haver duplicação de registros caso ele clique mais um uma vez
 	//document.formCadastro.submit.disabled=true;
}
//-->
</script>
