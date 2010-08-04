<Script>
// Autor: Fabrizio Gianfratti Manes
// Data: 02/02/2005
// Descrição: Pagina de Scripts JS
// Atualizado por: -
// Data: -
// Atualização: -
</Script>

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
			xmlHTTP.Open('POST', 'carrega.asp?Action=BuscaMedico&CRM=' + document.formCadastro.Medico_CRM.value, false); // Seta a pagina onde ira buscar os dados.
			xmlHTTP.Send(); //Envia
 
			Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
			
			if (Dados =="Bloqueado")//Este if cerifica se o resultado da busca na pagina asp obteve o resultado Bloqueado, caso foi entao o medico chegou no limite de atendimentos setado a ele
				{
					alert('O médico selecionado não pode fazer parte desse atendimento pois atingiu seu limite max. de atendimentos abertos\n\nCRM:'+document.formCadastro.Medico_CRM.value )
					document.formCadastro.Medico_CRM.value = '' //Apaga o codigo
					document.formCadastro.Medico_Nome.value = '' //apaga o campo do nome do medico casa tenha ocorrido uma busca antes
					return;
				}

			if (Dados == "") //Verifica se a variavel esta vazia ou seja a consulta nao obteve retorno
				{ 
					alert('Medico não encontrado\n\nCRM:'+document.formCadastro.Medico_CRM.value ) //Caso esteje vazia entao é retornado a MSG de não encontrado
					document.formCadastro.Medico_CRM.value = '' //Apaga o codigo
					document.formCadastro.Medico_Nome.value = '' //apaga o campo do nome do medico casa tenha ocorrido uma busca antes
					document.formCadastro.Medico_CRM.focus(); //Retorna o Focus para o campo
					document.formCadastro.Medico_CRM.select(); //Quando retorna para o campo com o comando acima ele traz o valor selecionado
				 }
			else //Caso a Variavel não for vazia então e atrubuido a variavel DADOS com o valor
				{ 
					//alert(Dados); //Caso queira depurar qualquer tipo de retorno que esta tenho, basta habilitar esta linha
					//mostra_formulario.style.display = ''; //Quando encontrado o registro entao habilita o formulario que esta escondido por um DIV para ser preenchido
					document.formCadastro.Medico_Nome.value = Dados; //Mostra o valor do registo no compo indicado
				}
		}
	catch(e)//Caso houve erro então é mostrado a descrição do erro
			{ 
				alert(e.descripition); //Descricao do erro
			}
}
</script>

<script>
//Função resposavel por carregar o nome do enfermeiro chefe inserindo o COREN
//Usamos o ActiveX XMLHTTP para buscar o nome do enfermeiro
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro

function CarregaEnfermeiro()
{
	try //Inicio de tratamento de erro
		{ 
			var Dados; //Varivel onde ficare arazenado o resultado final
			xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
			xmlHTTP.Open('POST', 'carrega.asp?Action=BuscaEnfermeiro&Enfermeiro_Coren=' + document.formCadastro.Enfermeiro_COREN.value, false); // Seta a pagina onde ira buscar os dados.
			xmlHTTP.Send(); //Envia
 
			Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel

			if (Dados =="Bloqueado")//Este if cerifica se o resultado da busca na pagina asp obteve o resultado Bloqueado, caso foi entao o enfermeiro chegou no limite de atendimentos setado a ele
				{
					alert('O enfermeiro selecionado não pode fazer parte desse atendimento pois atingiu seu limite max. de atendimentos abertos\n\nCOREN:'+document.formCadastro.Enfermeiro_COREN.value )
					document.formCadastro.Enfermeiro_COREN.value = '' //Apaga o codigo
					document.formCadastro.Enfermeiro_Nome.value = '' //apaga o campo do nome do enfermeiro casa tenha ocorrido uma busca antes
					return;
				}

			if (Dados == "") //Verifica se a variavel esta vazia
				{ 
					alert('Enfemeiro não encontrado\n\nCoren:'+document.formCadastro.Enfermeiro_COREN.value ) //Caso esteje vazia entao é retornado a MSG de não encontrado
					document.formCadastro.Enfermeiro_COREN.value = '' //Apaga o Codigo
					document.formCadastro.Enfermeiro_Nome.value = '' //apaga o campo do nome do medico casa tenha ocorrido uma busca antes
					document.formCadastro.Enfermeiro_COREN.focus(); //Retorna o Focus para o campo
					document.formCadastro.Enfermeiro_COREN.select(); //Quando retorna para o campo com o comando acima ele traz o valor selecionado
				 }
			else //Caso a Variavel não for vazia então e atrubuido a variavel DADOS com o valor
				{ 
					//alert(Dados); //Caso queira depurar qualquer tipo de retorno que esta tenho, basta habilitar esta linha
					//mostra_formulario.style.display = ''; //Quando encontrado o registro entao habilita o formulario que esta escondido por um DIV para ser preenchido
					document.formCadastro.Enfermeiro_Nome.value = Dados; //Mostra o valor do registo no compo indicado
				}
		}
	catch(e)//Caso houve erro então é mostrado a descrição do erro
			{ 
				alert(e.descripition); //Descricao do erro
			}
}
</script>

<script>
//Função resposavel por carregar os Aux. de Enfermagem inserindo o COREN
//Usamos o ActiveX XMLHTTP para buscar o nome do Aux Enfermagem
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function CarregaEnfermagem(Enfermagem_Coren, PosicaoVetor) //Função que recebe o value(valor) do campos e a posicao do vetor que é passado
{
	try //Inicio de tratamento de erro
		{ 
			//alert(PosicaoVetor)
			var Dados; //Varivel onde ficare arazenado o resultado final
			xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
			xmlHTTP.Open('POST', 'carrega.asp?Action=BuscaEnfermagem&Enfermagem_Coren=' + Enfermagem_Coren[PosicaoVetor].value, false); // Seta a pagina onde ira buscar os dados.
			xmlHTTP.Send(); //Envia
 
			Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
			
			if (Dados =="Bloqueado")//Este if cerifica se o resultado da busca na pagina asp obteve o resultado Bloqueado, caso foi entao o Aux. Enfermagem chegou no limite de atendimentos setado a ele
				{
					alert('O Aux. enfermagem selecionado não pode fazer parte desse atendimento pois atingiu seu limite max. de atendimentos abertos\n\nCOREN:'+document.formCadastro.Enfermagem_COREN[PosicaoVetor].value )
					document.formCadastro.Enfermagem_COREN[PosicaoVetor].value = '' //Apaga o codigo
					document.formCadastro.Enfermagem_Nome[PosicaoVetor].value = '' //apaga o campo do nome do enfermeiro casa tenha ocorrido uma busca antes
					return;
				}

			if (Dados == "") //Verifica se a variavel esta vazia
				{ 
					alert('Aux. de Enfemagem não encontrado\n\nCOREN:' + Enfermagem_Coren[PosicaoVetor].value ) //Caso esteje vazia entao é retornado a MSG de não encontrado
					document.formCadastro.Enfermagem_COREN[PosicaoVetor].value = '' //Apaga o Codigo
					document.formCadastro.Enfermagem_Nome[PosicaoVetor].value = '' //apaga o campo do nome do medico casa tenha ocorrido uma busca antes
					document.formCadastro.Enfermagem_COREN[PosicaoVetor].focus(); //Retorna o Focus para o campo
				 }
			else //Caso a Variavel não for vazia então e atrubuido a variavel DADOS com o valor
				{ 
					//alert(Dados); //Caso queira depurar qualquer tipo de retorno que esta tenho, basta habilitar esta linha
					//mostra_formulario.style.display = ''; //Quando encontrado o registro entao habilita o formulario que esta escondido por um DIV para ser preenchido
					document.formCadastro.Enfermagem_Nome[PosicaoVetor].value = Dados; //Mostra o valor do registo no compo indicado
				}

		}
	catch(e)//Caso houve erro então é mostrado a descrição do erro
			{ 
				alert(e.descripition); //Descricao do erro
			}
}
</script>

<script>
//Função resposavel por carregar os fisioterapeuta inserindo o CREFITO
//Usamos o ActiveX XMLHTTP para buscar o nome do Fisioterapeuta
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function CarregaFisiterapeuta(Fisioterapeuta_Cretifo, PosicaoVetor) //Função que recebe o value(valor) do campos e a posicao do vetor que é passado
{
	try //Inicio de tratamento de erro
		{ 
			//alert(PosicaoVetor)
			var Dados; //Varivel onde ficare arazenado o resultado final
			xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
			xmlHTTP.Open('POST', 'carrega.asp?Action=BuscaFisioterapeuta&Fisioterapeuta_Cretifo=' + Fisioterapeuta_Cretifo[PosicaoVetor].value, false); // Seta a pagina onde ira buscar os dados.
			xmlHTTP.Send(); //Envia
 
			Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel

			if (Dados =="Bloqueado")//Este if cerifica se o resultado da busca na pagina asp obteve o resultado Bloqueado, caso foi entao o fisioterapeuta chegou no limite de atendimentos setado a ele
				{
					alert('O fisioterapeuta selecionado não pode fazer parte desse atendimento pois atingiu seu limite max. de atendimentos abertos\n\nCOREN:'+document.formCadastro.Fisioterapeuta_CREFITO[PosicaoVetor].value )
					document.formCadastro.Fisioterapeuta_CREFITO[PosicaoVetor].value = ''
					document.formCadastro.Fisioterapeuta_Nome[PosicaoVetor].value = '' //Apaga o codigo
					return;
				}

			if (Dados == "") //Verifica se a variavel esta vazia
				{ 
					alert('Fisioterapeuta não encontrado\n\nCREFITO:'+Fisioterapeuta_Cretifo[PosicaoVetor].value ) //Caso esteje vazia entao é retornado a MSG de não encontrado
					document.formCadastro.Fisioterapeuta_Nome[PosicaoVetor].value = '' //apaga o campo do nome do CID casa tenha ocorrido uma busca antes
					document.formCadastro.Fisioterapeuta_CREFITO[PosicaoVetor].value = ''; //Apaga o campo 
					document.formCadastro.Fisioterapeuta_CREFITO[PosicaoVetor].focus(); //Retorna o Focus para o campo
				 }
			else //Caso a Variavel não for vazia então e atrubuido a variavel DADOS com o valor
				{ 
					//alert(Dados); //Caso queira depurar qualquer tipo de retorno que esta tenho, basta habilitar esta linha
					//mostra_formulario.style.display = ''; //Quando encontrado o registro entao habilita o formulario que esta escondido por um DIV para ser preenchido
					document.formCadastro.Fisioterapeuta_Nome[PosicaoVetor].value = Dados; //Mostra o valor do registo no compo indicado
				}

		}
	catch(e)//Caso houve erro então é mostrado a descrição do erro
			{ 
				alert(e.descripition); //Descricao do erro
			}
}
</script>

<script>
//Função resposavel por carregar os funcionarios inserindo o codigo, como é outros serviços entao pode ser qualquer codigo que tenha cadastrado no campo codigo_medico do funcionario
//Usamos o ActiveX XMLHTTP para buscar o nome do Funcionario
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function CarregaOutrosServicos(Outros_Servicos_Codigo, PosicaoVetor) //Função que recebe o value(valor) do campos e a posicao do vetor que é passado
{
	try //Inicio de tratamento de erro
		{ 
			//alert(PosicaoVetor)
			var Dados; //Varivel onde ficare arazenado o resultado final
			xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
			xmlHTTP.Open('POST', 'carrega.asp?Action=BuscaOutrosServicos&Outros_Servicos_Codigo=' + Outros_Servicos_Codigo[PosicaoVetor].value, false); // Seta a pagina onde ira buscar os dados.
			xmlHTTP.Send(); //Envia
 
			Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel

			if (Dados == "") //Verifica se a variavel esta vazia
				{ 
					alert('Não encontrado\n\nCodigo:'+Outros_Servicos_Codigo[PosicaoVetor].value ) //Caso esteje vazia entao é retornado a MSG de não encontrado
					document.formCadastro.Outros_Servicos_Funcionario[PosicaoVetor].value = "" //apaga o campo do nome do funcionario
					document.formCadastro.Outros_Servicos_Codigo[PosicaoVetor].value = ''; //Apaga o campo 
					document.formCadastro.Outros_Servicos_Obs[PosicaoVetor].value = ''; //Apaga o campo  obs
					document.formCadastro.Outros_Servicos_Codigo[PosicaoVetor].focus(); //Retorna o Focus para o campo
				 }
			else //Caso a Variavel não for vazia então e atrubuido a variavel DADOS com o valor
				{ 
					//alert(Dados); //Caso queira depurar qualquer tipo de retorno que esta tenho, basta habilitar esta linha
					//mostra_formulario.style.display = ''; //Quando encontrado o registro entao habilita o formulario que esta escondido por um DIV para ser preenchido
					document.formCadastro.Outros_Servicos_Funcionario[PosicaoVetor].value = Dados; //Mostra o valor do registo no compo indicado
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
//Função resposavel por carregar os equipamentos inserindo o Codigo
//Usamos o ActiveX XMLHTTP para buscar o nome do Equipamento
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function CarregaSimproEquipamentos(Cod_Simpro_Equipamentos, PosicaoVetor) //Função que recebe o value(valor) do campos e a posicao do vetor que é passado
{
	try //Inicio de tratamento de erro
		{ 
			//alert(PosicaoVetor)
			var Dados; //Varivel onde ficare arazenado o resultado final
			xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
			xmlHTTP.Open('POST', 'carrega.asp?Action=BuscaSimproEquipamento&Cod_Simpro_Equipamentos=' + Cod_Simpro_Equipamentos[PosicaoVetor].value, false); // Seta a pagina onde ira buscar os dados.
			xmlHTTP.Send(); //Envia
 
			Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel

			if (Dados == "") //Verifica se a variavel esta vazia
				{ 
					alert('Equipamento não encontrado\n\nCodigo nº:'+Cod_Simpro_Equipamentos[PosicaoVetor].value ) //Caso esteje vazia entao é retornado a MSG de não encontrado
					document.formCadastro.Descricao_Equipamentos[PosicaoVetor].value = "" //apaga o campo do nome do equipamento casa tenha ocorrido uma busca antes
					document.formCadastro.qtd_Equipamentos[PosicaoVetor].value = "" //apaga o campo da quantidade casa tenha ocorrido uma busca antes
					document.formCadastro.id_Fornecedor_Equipamento[PosicaoVetor].value = "" //apaga o campo do fornecedor casa tenha ocorrido uma busca antes
					Cod_Simpro_Equipamentos[PosicaoVetor].value = ''; //Apaga o campo com o codigo
					Cod_Simpro_Equipamentos[PosicaoVetor].focus(); //Retorna o Focus para o campo
				 }
			else //Caso a Variavel não for vazia então e atrubuido a variavel DADOS com o valor
				{ 
					//alert(Dados); //Caso queira depurar qualquer tipo de retorno que esta tenho, basta habilitar esta linha
					//mostra_formulario.style.display = ''; //Quando encontrado o registro entao habilita o formulario que esta escondido por um DIV para ser preenchido
					document.formCadastro.Descricao_Equipamentos[PosicaoVetor].value = Dados; //Mostra o valor do registo no compo indicado
				}

		}
	catch(e)//Caso houve erro então é mostrado a descrição do erro
			{ 
				alert(e.descripition); //Descricao do erro
			}
}
</script>

<Script>
//Função resposavel por carregar os materiais inserindo o Codigo
//Usamos o ActiveX XMLHTTP para buscar o nome do material
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function CarregaSimproMateriais(Cod_Simpro_Materiais, PosicaoVetor) //Função que recebe o value(valor) do campos e a posicao do vetor que é passado
{
	try //Inicio de tratamento de erro
		{ 
			//alert(PosicaoVetor)
			var Dados; //Varivel onde ficare arazenado o resultado final
			xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
			xmlHTTP.Open('POST', 'carrega.asp?Action=BuscaSimproMaterial&Cod_Simpro_Materiais=' + Cod_Simpro_Materiais[PosicaoVetor].value, false); // Seta a pagina onde ira buscar os dados.
			xmlHTTP.Send(); //Envia
 
			Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel

			if (Dados == "") //Verifica se a variavel esta vazia
				{ 
					alert('Material não encontrado\n\nCodigo nº:'+Cod_Simpro_Materiais[PosicaoVetor].value ) //Caso esteje vazia entao é retornado a MSG de não encontrado
					document.formCadastro.Descricao_Material[PosicaoVetor].value = "" //apaga o campo do nome do Material casa tenha ocorrido uma busca antes
					document.formCadastro.qtd_Material[PosicaoVetor].value = "" //apaga o campo da quantidade casa tenha ocorrido uma busca antes
					document.formCadastro.id_Fornecedor_Material[PosicaoVetor].value = "" //apaga o campo do fornecedor casa tenha ocorrido uma busca antes
					Cod_Simpro_Materiais[PosicaoVetor].value = ''; //Apaga o campo com o codigo 
					Cod_Simpro_Materiais[PosicaoVetor].focus(); //Retorna o Focus para o campo
				 }
			else //Caso a Variavel não for vazia então e atrubuido a variavel DADOS com o valor
				{ 
					//alert(Dados); //Caso queira depurar qualquer tipo de retorno que esta tenho, basta habilitar esta linha
					//mostra_formulario.style.display = ''; //Quando encontrado o registro entao habilita o formulario que esta escondido por um DIV para ser preenchido
					document.formCadastro.Descricao_Material[PosicaoVetor].value = Dados; //Mostra o valor do registo no compo indicado
				}

		}
	catch(e)//Caso houve erro então é mostrado a descrição do erro
			{ 
				alert(e.descripition); //Descricao do erro
			}
}
</script>

<Script>
//Função resposavel por carregar o medicamento inserindo o Codigo
//Usamos o ActiveX XMLHTTP para buscar o nome do medicamento
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function CarregaSimproMedicamento(Cod_Simpro_Medicamento, PosicaoVetor) //Função que recebe o value(valor) do campos e a posicao do vetor que é passado
{
	try //Inicio de tratamento de erro
		{ 
			//alert(PosicaoVetor)
			var Dados; //Varivel onde ficare arazenado o resultado final
			xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
			xmlHTTP.Open('POST', 'carrega.asp?Action=BuscaSimproMedicamento&Cod_Simpro_Medicamento=' + Cod_Simpro_Medicamento[PosicaoVetor].value, false); // Seta a pagina onde ira buscar os dados.
			xmlHTTP.Send(); //Envia
 
			Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel

			if (Dados == "") //Verifica se a variavel esta vazia
				{ 
					alert('Medicamento não encontrado\n\nCodigo nº:'+Cod_Simpro_Medicamento[PosicaoVetor].value ) //Caso esteje vazia entao é retornado a MSG de não encontrado
					document.formCadastro.Descricao_Medicamento[PosicaoVetor].value = "" //apaga o campo do nome do Nedicamento casa tenha ocorrido uma busca antes
					document.formCadastro.qtd_Medicamentos[PosicaoVetor].value = "" //apaga o campo da quantidade casa tenha ocorrido uma busca antes
					document.formCadastro.id_Fornecedor_Medicamento[PosicaoVetor].value = "" //apaga o campo do fornecedor casa tenha ocorrido uma busca antes
					Cod_Simpro_Medicamento[PosicaoVetor].value = ''; //Apaga o campo com o codigo
					Cod_Simpro_Medicamento[PosicaoVetor].focus(); //Retorna o Focus para o campo
				 }
			else //Caso a Variavel não for vazia então e atrubuido a variavel DADOS com o valor
				{ 
					//alert(Dados); //Caso queira depurar qualquer tipo de retorno que esta tenho, basta habilitar esta linha
					//mostra_formulario.style.display = ''; //Quando encontrado o registro entao habilita o formulario que esta escondido por um DIV para ser preenchido
					document.formCadastro.Descricao_Medicamento[PosicaoVetor].value = Dados; //Mostra o valor do registo no compo indicado
				}

		}
	catch(e)//Caso houve erro então é mostrado a descrição do erro
			{ 
				alert(e.descripition); //Descricao do erro
			}
}
</script>

<Script>
//Função resposavel por carregar o procedimento inserindo o Codigo da AMB
//Usamos o ActiveX XMLHTTP para buscar o nome do medicamento
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRUÇÃO Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function CarregaAMB(Cod_AMB, PosicaoVetor) //Função que recebe o value(valor) do campos e a posicao do vetor que é passado
{
	try //Inicio de tratamento de erro
		{ 
			//alert(PosicaoVetor)
			var Dados; //Varivel onde ficare arazenado o resultado final
			xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
			xmlHTTP.Open('POST', 'carrega.asp?Action=BuscaAMB&Cod_AMB=' + Cod_AMB[PosicaoVetor].value, false); // Seta a pagina onde ira buscar os dados.
			xmlHTTP.Send(); //Envia
 
			Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
			Dados = Dados.split("#")//Da um splite no retorno pois o registro veio concatenado com # que é o separador

			if (Dados == "") //Verifica se a variavel esta vazia
				{ 
					document.formCadastro.Cod_AMB[PosicaoVetor].value = ""
					document.formCadastro.Descricao_AMB[PosicaoVetor].value = ""
					document.formCadastro.Numero_Auxiliares[PosicaoVetor].value = ""
					alert('Código AMB não encontrado\n\nCodigo nº:'+Cod_AMB[PosicaoVetor].value ) //Caso esteje vazia entao é retornado a MSG de não encontrado
				 }
			else //Caso a Variavel não for vazia então e atrubuido a variavel DADOS com o valor
				{ 
					//alert(Dados); //Caso queira depurar qualquer tipo de retorno que esta tenho, basta habilitar esta linha
					document.formCadastro.Descricao_AMB[PosicaoVetor].value = Dados[0]; //Mostra o valor do registo no compo indicado
					document.formCadastro.Numero_Auxiliares[PosicaoVetor].value = Dados[1]; //Mostra o valor do registo no compo indicado
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
			xmlHTTP.Open('POST', 'carrega.asp?Action=BuscaExame&Cod_Exame=' + Cod_Exame[PosicaoVetor].value, false); // Seta a pagina onde ira buscar os dados.
			xmlHTTP.Send(); //Envia
 
			Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel

			if (Dados == "") //Verifica se a variavel esta vazia
				{ 
					alert('Exame não encontrado\n\nCodigo nº:'+Cod_Exame[PosicaoVetor].value ) //Caso esteje vazia entao é retornado a MSG de não encontrado
					document.formCadastro.Descricao_Exame[PosicaoVetor].value = "" //apaga o campo do nome do Exame casa tenha ocorrido uma busca antes
					document.formCadastro.Data_Realizacao_Exame[PosicaoVetor].value = "" //apaga o campo da Data casa tenha ocorrido uma busca antes
					document.formCadastro.id_Fornecedor_Exame[PosicaoVetor].value = "" //apaga o campo do fornecedor casa tenha ocorrido uma busca antes
					Cod_Exame[PosicaoVetor].value = ''; //Apaga o campo com o codigo
					Cod_Exame[PosicaoVetor].focus(); //Retorna o Focus para o campo
				 }
			else //Caso a Variavel não for vazia então e atrubuido a variavel DADOS com o valor
				{ 
					//alert(Dados); //Caso queira depurar qualquer tipo de retorno que esta tenho, basta habilitar esta linha
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
	var posicaoEnfermagem = 1 //Define uma variavel que ira controlar a posicao do vetor dos campos. Este valor é usado para passar no imput como parametro
function CriaOpcoesEnfermagem()
{
	
	posicaoEnfermagem += 1 //Vai incrementando 1
	Mostra_Campos_Enfermagem.innerHTML = Mostra_Campos_Enfermagem.innerHTML +  //Vai concatenando para exibir na Div
		"<table width=100% border=0 cellspacing=1 cellpadding=0>" +
			"<tr class=zebra_orange1>" +
					"<td width=10%><input name=Enfermagem_COREN type=text class=campos id=Enfermagem_COREN onchange=CarregaEnfermagem(formCadastro.Enfermagem_COREN,'" + posicaoEnfermagem + "') size=6 maxlength=10></td>" +
					"<td width=36%><input readonly name=Enfermagem_Nome type=text class=campos id=Enfermagem_Nome size=40> </td>" +
					"<td width=18%><%=gerar_listbox_Automatico("HomeCare_Periodicidade","Where id_Periodicidade_Tipo = 3 ","id","id_Periodicidade_Enfermagem","Descricao","--Selecione--","")%></td>" +
					"<td width=9%><input name=Qtd_Periodicidade_Enfermagem type=text class=campos id=Qtd_Periodicidade_Enfermagem size=5 maxlength=4></td>" +
					"<td width=25%><%=gerar_listbox_Automatico("Contrato_Servico","","id","id_Contrato_Servico_Enfermagem","Nome","--Selecione--","")%></td>" +
					"<td><a href=javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Busca_Funcionario/default.asp?Tipo_Funcionario=3&Posicao_Vetor=" + posicaoEnfermagem + "&id_Departamento=5&id_Cargo=13&id_cobertura=" + document.formCadastro.id_cobertura.value + "','900','600',this,event)><img src=/SmartCare/images/busca3.gif border=0></a></td>" + 
			"</tr>" + 
		"</Table>"
 }
</script>

<Script>
//Função respomsavel por inserir os campos onde será inserido o CID10
	var posicaoFisioterapeuta = 1 //Define uma variavel que ira controlar a posicao do vetor dos campos. Este valor é usado para passar no imput como parametro
function CriaOpcoesFisioterapeuta()
{
	
	posicaoFisioterapeuta += 1 //Vai incrementando 1
	Mostra_Campos_Fisioterapeuta.innerHTML = Mostra_Campos_Fisioterapeuta.innerHTML +  //Vai concatenando para exibir na Div
		"<table width=100% border=0 cellspacing=1 cellpadding=0>" +
			"<tr class=zebra_orange1>" +
					"<td width=10%><input name=Fisioterapeuta_CREFITO type=text class=campos id=Fisioterapeuta_CREFITO onchange=CarregaFisiterapeuta(formCadastro.Fisioterapeuta_CREFITO,'" + posicaoFisioterapeuta + "') size=10 maxlength=10> </td>" +
					"<td width=36%><input readonly name=Fisioterapeuta_Nome type=text class=campos id=Fisioterapeuta_Nome size=40> </td>" +
					"<td width=18%><%=gerar_listbox_Automatico("HomeCare_Periodicidade","Where id_Periodicidade_Tipo = 4 ","id","id_Periodicidade_Fisioterapeuta","Descricao","--Selecione--","")%></td>" + 
					"<td width=9%><input name=Qtd_Sessoes type=text class=campos id=Qtd_Sessoes size=5 maxlength=5> </td>" +
					"<td width=25%><%=gerar_listbox_Automatico("Contrato_Servico","","id","id_Contrato_Servico_Fisioterapeuta","Nome","--Selecione--","")%></td>" +
					"<td><a href=javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Busca_Funcionario/default.asp?Tipo_Funcionario=4&Posicao_Vetor=" + posicaoFisioterapeuta + "&id_Departamento=5&id_Cargo=16&id_cobertura=" + document.formCadastro.id_cobertura.value + "','800','600',this,event)><img src=/SmartCare/images/busca3.gif border=0></a> </td>" + 
			"</tr>" + 
		"</Table>"
 }
</script>

<Script>
//Função respomsavel por inserir os campos onde será inserido o CID10
	var posicaoOutrosServicos = 1 //Define uma variavel que ira controlar a posicao do vetor dos campos. Este valor é usado para passar no imput como parametro
function CriaOpcoesOutrosServicos()
{
	
	posicaoOutrosServicos += 1 //Vai incrementando 1
	Mostra_Campos_Outros_Servicos.innerHTML = Mostra_Campos_Outros_Servicos.innerHTML +  //Vai concatenando para exibir na Div
		"<table width=100% border=0 cellspacing=1 cellpadding=0>" +
			"<tr class=zebra_orange1>" +
					"<td width=10%><input name=Outros_Servicos_Codigo type=text class=campos id=Outros_Servicos_Codigo onchange=CarregaOutrosServicos(formCadastro.Outros_Servicos_Codigo,'" + posicaoOutrosServicos + "') size=10 maxlength=10></td>" +
					"<td width=30%><input readonly name=Outros_Servicos_Funcionario type=text class=campos id=Outros_Servicos_Funcionario size=30></td>" +
					"<td width=18%><%=gerar_listbox_Automatico("HomeCare_Periodicidade","Where id_Periodicidade_Tipo = 5 ","id","id_Periodicidade_Outros_Servicos","Descricao","--Selecione--","")%></td>" + 
					"<td width=10%><input name=Qtd_Periodicidade_Outros_Servicos type=text class=campos id=Qtd_Periodicidade_Outros_Servicos size=5 maxlength=4></td>" + 
					"<td width=16%><%=gerar_listbox_Automatico("Contrato_Servico","","id","id_Contrato_Servico_Outros_Servicos","Nome","--Selecione--","")%></td>" +
					"<td width=13%><input name=Outros_Servicos_Obs type=text class=campos id=Outros_Servicos_Obs size=10 maxlength=190> </td>" + 
					"<td><a href=javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Busca_Funcionario/default.asp?Tipo_Funcionario=5&Posicao_Vetor=" + posicaoOutrosServicos + "&id_Departamento=5','800','600',this,event)><img src=/SmartCare/images/busca3.gif border=0></a></td>" + 
			"</tr>" + 
		"</Table>"
 }
</script>

<Script>
//Função respomsavel por inserir os campos onde será inserido o CID10
	var posicaoEquipamento = 1 //Define uma variavel que ira controlar a posicao do vetor dos campos. Este valor é usado para passar no imput como parametro
function CriaOpcoesSimproEquipamentos()
{
	
	posicaoEquipamento += 1 //Vai incrementando 1
	Mostra_Campos_Simpro_Equipamentos.innerHTML = Mostra_Campos_Simpro_Equipamentos.innerHTML +  //Vai concatenando para exibir na Div
		"<table width=100% border=0 cellspacing=1 cellpadding=0>" +
			"<tr class=zebra_orange1>" +
					"<td width=10%><input name=Cod_Simpro_Equipamentos type=text class=campos id=Cod_Simpro_Equipamentos onchange=CarregaSimproEquipamentos(formCadastro.Cod_Simpro_Equipamentos,'" + posicaoEquipamento + "') size=7 maxlength=7> </td>" +
					"<td width=50%><input readonly name=Descricao_Equipamentos type=text class=campos id=Descricao_Equipamentos size=60> </td>" +
					"<td width=13%><input name=qtd_Equipamentos type=text class=campos id=qtd_Equipamentos size=10 maxlength=50> </td>" + 
					"<td width=22%><%=gerar_listbox_Automatico("Fornecedores"," Where id_Fornecedores_Categoria = 1  ","id","id_Fornecedor_Equipamento","Fornecedor","--Selecione--","")%></td>" +
					"<td width=4%><a href=javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Busca_Simpro/default.asp?Tipo_Busca_Simpro=200&Tipo_Produto_Simpro=20&Posicao_Vetor=" + posicaoEquipamento + "','800','600',this,event)><img src=/SmartCare/images/busca3.gif border=0></a> </td>" + 
			"</tr>" + 
		"</Table>"
 }
</script>

<Script>
//Função respomsavel por inserir os campos onde será inserido o CID10
	var posicaoMaterial = 1 //Define uma variavel que ira controlar a posicao do vetor dos campos. Este valor é usado para passar no imput como parametro
function CriaOpcoesSimproMateriais()
{
	
	posicaoMaterial += 1 //Vai incrementando 1
	Mostra_Campos_Simpro_Materiais.innerHTML = Mostra_Campos_Simpro_Materiais.innerHTML +  //Vai concatenando para exibir na Div
		"<table width=100% border=0 cellspacing=1 cellpadding=0>" +
			"<tr class=zebra_orange1>" +
					"<td width=11%> <input name=Cod_Simpro_Materiais type=text class=campos id=Cod_Simpro_Materiais onchange=CarregaSimproMateriais(formCadastro.Cod_Simpro_Materiais,'" + posicaoMaterial + "') size=7 maxlength=7  ></td>  " +
					"<td width=50%> <input readonly name=Descricao_Material type=text class=campos id=Descricao_Material size=60> </td> " +
					"<td width=13%> <input name=qtd_Material type=text class=campos id=qtd_Material size=10 maxlength=10> </td>" + 
					"<td width=22%><%=gerar_listbox_Automatico("Fornecedores"," Where id_Fornecedores_Categoria = 2  ","id","id_Fornecedor_Material","Fornecedor","--Selecione--","")%></td>" +
					"<td width=4%> <a href=javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Busca_Simpro/default.asp?Tipo_Busca_Simpro=20&Tipo_Produto_Simpro=20&Posicao_Vetor=" + posicaoMaterial + "','800','600',this,event)><img src=/SmartCare/images/busca3.gif border=0></a></td> " +
			"</tr>" + 
		"</Table>"
 }
</script>

<Script>
//Função respomsavel por inserir os campos onde será inserido o CID10
	var posicaoMedicamento = 1 //Define uma variavel que ira controlar a posicao do vetor dos campos. Este valor é usado para passar no imput como parametro
function CriaOpcoesSimproMedicamentos()
{
	posicaoMedicamento += 1 //Vai incrementando 1
	Mostra_Campos_Simpro_Medicamentos.innerHTML = Mostra_Campos_Simpro_Medicamentos.innerHTML +  //Vai concatenando para exibir na Div
		"<table width=100% border=0 cellspacing=1 cellpadding=0>" +
			"<tr class=zebra_orange1>" +
					"<td width=11%><input readonly name=id_Prescricao_Medicamento type=text class=campos id=id_Prescricao_Medicamento size=6> <a href=javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Busca_Prescricoes/default.asp?Tipo_Busca=1&id_Atendimento=<%=Request("id_Atendimento")%>&Posicao_Vetor=" + posicaoMedicamento + "','900','600',this,event)><img src=/SmartCare/images/lupa.gif border=0></a></td>" +
			  		"<td width=10%><input name=Cod_Simpro_Medicamento type=text class=campos id=Cod_Simpro_Medicamento onchange=CarregaSimproMedicamento(formCadastro.Cod_Simpro_Medicamento,'" + posicaoMedicamento + "') size=7 maxlength=7  > </td>" +
			  		"<td width=40%><input readonly name=Descricao_Medicamento type=text class=campos id=Descricao_Medicamento size=47></td>" +
					"<td width=13%><input name=qtd_Medicamentos type=text class=campos id=qtd_Medicamentos size=10 maxlength=10></td> " + 
					"<td width=22%><%=gerar_listbox_Automatico("Fornecedores"," Where id_Fornecedores_Categoria = 3  ","id","id_Fornecedor_Medicamento","Fornecedor","--Selecione--","")%></td>" +
			  		"<td width=4%> <a href=javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Busca_Simpro/default.asp?Tipo_Busca_Simpro=50&Tipo_Produto_Simpro=50&Posicao_Vetor=" + posicaoMedicamento + "','800','600',this,event)><img src=/SmartCare/images/busca3.gif border=0></a> </td>" + 
			"</tr>" + 
		"</Table>"
 }
</script>

<Script>
//Função respomsavel por inserir os campos onde será inserido os procedimentos AMB
	var posicaoAMB = 1 //Define uma variavel que ira controlar a posicao do vetor dos campos. Este valor é usado para passar no imput como parametro
function CriaOpcoesAMB()
{
	posicaoAMB += 1 //Vai incrementando 1
	Mostra_Campos_AMB.innerHTML = Mostra_Campos_AMB.innerHTML +  //Vai concatenando para exibir na Div
		"<table width=100% border=0 cellspacing=1 cellpadding=0>" +
			"<tr class=zebra_orange1>" +
			  		"<td width=11%><input name=Cod_AMB type=text class=campos id=Cod_AMB onchange=CarregaAMB(formCadastro.Cod_AMB,'" + posicaoAMB + "') size=8 maxlength=8  > </td>" +
			  		"<td width=63%><input readonly name=Descricao_AMB type=text class=campos id=Descricao_AMB size=87></td>" +
					"<td width=22%><input readonly name=Numero_Auxiliares type=text class=campos id=Numero_Auxiliares size=3></td>" +
			  		"<td width=4%> <a href=javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Busca_AMB/default.asp?Tipo_Busca_Simpro=50&Tipo_Produto_Simpro=50&Posicao_Vetor=" + posicaoMedicamento + "','800','600',this,event)><img src=/SmartCare/images/busca3.gif border=0></a> </td>" + 
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
			  		"<td width=50%><input readonly name=Descricao_Exame type=text class=campos id=Descricao_Exame size=60></td>" +
					"<td width=13%><input name=Data_Realizacao_Exame type=text class=campos id=Data_Realizacao_Exame size=10 maxlength=10></td> " + 
					"<td width=22%><%=gerar_listbox_Automatico("Fornecedores"," Where id_Fornecedores_Categoria = 4  ","id","id_Fornecedor_Exame","Fornecedor","--Selecione--","")%></td>" +
			  		"<td width=4%> <a href=javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Busca_Exames/default.asp?Tipo_Busca_Simpro=50&Tipo_Produto_Simpro=50&Posicao_Vetor=" + posicaoExame + "','800','600',this,event)><img src=/SmartCare/images/busca3.gif border=0></a> </td>" + 
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

<script>
//Função resposavel por deletar os itens da prescricao medica
function DeletarItensPrescricao(id_Prescricao_Medica,Descricao)
{
	if (confirm("Tem certeza que deseja apagar a prescrição médica:\n\n " + Descricao ))
		{
			try //Inicio de tratamento de erro
				{ 
					var Dados; //Varivel onde ficare arazenado o resultado final
					xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
					xmlHTTP.Open('POST', 'carrega.asp?Action=DeletarItensPrescricao&id_Prescricao_Medica=' + id_Prescricao_Medica + '&id_Atendimento=' + document.formCadastro.id_Atendimento.value , false); // Seta a pagina onde ira apagar o registro.
					xmlHTTP.Send(); //Envia
		 
					Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
							Carrega_Prescricao_Medica.innerHTML = Dados //Armazena o conteudo da variavel DADOS em Carrega_Prescricao_Medica que é o id da DIV para usar mostrar na pagina basta usar isso: <div id=Carrega_Prescricao_Medica></div>
				}
			catch(e)//Caso houve erro então é mostrado a descrição do erro
					{ 
						alert(e.descripition); //Descricao do erro
					}
		}
}
</script>

<script>
//Função resposavel por deletar os CID10, diagnostico apresentado no atendimento
function DeletarItensCid10(Id_Atendimento_Diagnostico,Cid10_Descricao)
{
	if (confirm("Tem certeza que deseja apagar o Diagnostico:\n\n " + Cid10_Descricao ))
		{
			try //Inicio de tratamento de erro
				{ 
					var Dados; //Varivel onde ficare arazenado o resultado final
					xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
					xmlHTTP.Open('POST', 'carrega.asp?Action=DeletarItensCid10&Id_Atendimento_Diagnostico=' + Id_Atendimento_Diagnostico + '&id_Atendimento=' + document.formCadastro.id_Atendimento.value , false); // Seta a pagina onde ira apagar o registro.
					xmlHTTP.Send(); //Envia
		 
					Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
							Carrega_Itens_Cid10.innerHTML = Dados //Armazena o conteudo da variavel DADOS em Carrega_Itens_Cid10 que é o id da DIV para usar mostrar na pagina basta usar isso: <div id=Carrega_Itens_Cid10></div>
				}
			catch(e)//Caso houve erro então é mostrado a descrição do erro
					{ 
						alert(e.descripition); //Descricao do erro
					}
		}
}
</script>

<script>
//Função resposavel por deletar o medico que faz parte do atendimento
function DeletarMedicos(id_Funcionario_Medico,id_Atendimento,Nome)
{
	if (confirm("Tem certeza que deseja alterar o status do médico:\n\n " + Nome ))
		{
			try //Inicio de tratamento de erro
				{ 
					//Cria uma variavel e abre a janela onde vai buscar o id do status que o funcionario sera desabilitado
					var RespostaMotivo = window.showModalDialog('Funcionario_Status.asp', "","dialogHeight:250px; edge: sunken; status: no; help: no; unadorned: no;dialogWidth:400px; edge: sunken; status: no; help: no; unadorned: no;dialogTop:300;dialogLeft:300")
					if (RespostaMotivo != null) //Se o conteudo da janela nao for nulo entao faz a modificação
						{
							var Dados; //Varivel onde ficare arazenado o resultado final
							xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
							xmlHTTP.Open('POST', 'carrega.asp?Action=DeletarMedicos&id_Funcionario_Medico=' + id_Funcionario_Medico + '&id_Atendimento=' + document.formCadastro.id_Atendimento.value + '&RespostaMotivo=' + RespostaMotivo , false); // Seta a pagina onde ira apagar o registro.
							xmlHTTP.Send(); //Envia
							Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
							Carrega_Lista_Medicos.innerHTML = Dados //Armazena o conteudo da variavel DADOS em Carrega_Lista_Medicos que é o id da DIV para usar mostrar na pagina basta usar isso: <div id=Carrega_Lista_Medicos></div>
						}
				}
			catch(e)//Caso houve erro então é mostrado a descrição do erro
					{ 
						alert(e.descripition); //Descricao do erro
					}
		}
}
</script>

<script>
//Função resposavel por deletar o enfermeiro que faz parte do atendimento
function DeletarEnfermeiros(id_Funcionario_Enfermeiro,id_Atendimento,Nome)
{
	if (confirm("Tem certeza que deseja alterar o status do enfermeiro:\n\n " + Nome ))
		{
			try //Inicio de tratamento de erro
				{ 
				//Abre o prompt para digitar o motivo que o medico esta sendo desabilitado no atendimento
					//Cria uma variavel e abre a janela onde vai buscar o id do status que o funcionario sera desabilitado
					var RespostaMotivo = window.showModalDialog('Funcionario_Status.asp', "","dialogHeight:250px; edge: sunken; status: no; help: no; unadorned: no;dialogWidth:400px; edge: sunken; status: no; help: no; unadorned: no;dialogTop:300;dialogLeft:300")
					if (RespostaMotivo != null) //Se o conteudo da janela nao for nulo entao faz a modificação
						{
							var Dados; //Varivel onde ficare arazenado o resultado final
							xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
							xmlHTTP.Open('POST', 'carrega.asp?Action=DeletarEnfermeiros&id_Funcionario_Enfermeiro=' + id_Funcionario_Enfermeiro + '&id_Atendimento=' + document.formCadastro.id_Atendimento.value + '&RespostaMotivo=' + RespostaMotivo , false); // Seta a pagina onde ira apagar o registro.
							xmlHTTP.Send(); //Envia
				 
							Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
							Carrega_Lista_Enfermeiros.innerHTML = Dados //Armazena o conteudo da variavel DADOS em Carrega_Lista_Enfermeiros que é o id da DIV para usar mostrar na pagina basta usar isso: <div id=Carrega_Lista_Enfermeiros></div>
						}							
				}
			catch(e)//Caso houve erro então é mostrado a descrição do erro
					{ 
						alert(e.descripition); //Descricao do erro
					}
		}
}
</script>

<script>
//Função resposavel por deletar a equipe de enfermagem que faz parte do atendimento
function DeletarEnfermagem(id_Funcionario_Enfermagem,id_Atendimento,Nome)
{
	if (confirm("Tem certeza que deseja alterar o status do Aux. Emfermagem:\n\n " + Nome ))
		{
			try //Inicio de tratamento de erro
				{ 
				//Abre o prompt para digitar o motivo que o medico esta sendo desabilitado no atendimento
					//Cria uma variavel e abre a janela onde vai buscar o id do status que o funcionario sera desabilitado
					var RespostaMotivo = window.showModalDialog('Funcionario_Status.asp', "","dialogHeight:250px; edge: sunken; status: no; help: no; unadorned: no;dialogWidth:400px; edge: sunken; status: no; help: no; unadorned: no;dialogTop:300;dialogLeft:300")
					if (RespostaMotivo != null) //Se o conteudo da janela nao for nulo entao faz a modificação
						{
							var Dados; //Varivel onde ficare arazenado o resultado final
							xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
							xmlHTTP.Open('POST', 'carrega.asp?Action=DeletarEnfermagem&id_Funcionario_Enfermagem=' + id_Funcionario_Enfermagem + '&id_Atendimento=' + document.formCadastro.id_Atendimento.value + '&RespostaMotivo=' + RespostaMotivo , false); // Seta a pagina onde ira apagar o registro.
							xmlHTTP.Send(); //Envia
				 
							Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
							Carrega_Lista_Enfermagem.innerHTML = Dados //Armazena o conteudo da variavel DADOS em Carrega_Lista_Enfermagem que é o id da DIV para usar mostrar na pagina basta usar isso: <div id=Carrega_Lista_Enfermagem></div>
						}
				}
			catch(e)//Caso houve erro então é mostrado a descrição do erro
					{ 
						alert(e.descripition); //Descricao do erro
					}
		}
}
</script>

<script>
//Função resposavel por deletar os fisioterapeutas que fazem parte do atendimento
function DeletarFisioterapeuta(id_Funcionario_Fisioterapeuta,id_Atendimento,Nome)
{
	if (confirm("Tem certeza que deseja alterar o status do fisioterapeuta:\n\n " + Nome ))
		{
			try //Inicio de tratamento de erro
				{ 
				//Abre o prompt para digitar o motivo que o medico esta sendo desabilitado no atendimento
					//Cria uma variavel e abre a janela onde vai buscar o id do status que o funcionario sera desabilitado
					var RespostaMotivo = window.showModalDialog('Funcionario_Status.asp', "","dialogHeight:250px; edge: sunken; status: no; help: no; unadorned: no;dialogWidth:400px; edge: sunken; status: no; help: no; unadorned: no;dialogTop:300;dialogLeft:300")
					if (RespostaMotivo != null) //Se o conteudo da janela nao for nulo entao faz a modificação
						{
							var Dados; //Varivel onde ficare arazenado o resultado final
							xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
							xmlHTTP.Open('POST', 'carrega.asp?Action=DeletarFisioterapeuta&id_Funcionario_Fisioterapeuta=' + id_Funcionario_Fisioterapeuta + '&id_Atendimento=' + document.formCadastro.id_Atendimento.value + '&RespostaMotivo=' + RespostaMotivo , false); // Seta a pagina onde ira apagar o registro.
							xmlHTTP.Send(); //Envia
				 
							Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
							Carrega_Lista_Fisioterapeuta.innerHTML = Dados //Armazena o conteudo da variavel DADOS em Carrega_Lista_Fisioterapeuta que é o id da DIV para usar mostrar na pagina basta usar isso: <div id=Carrega_Lista_Fisioterapeuta></div>
						}
				}
			catch(e)//Caso houve erro então é mostrado a descrição do erro
					{ 
						alert(e.descripition); //Descricao do erro
					}
		}
}
</script>

<script>
//Função resposavel por deletar os equipamentos que fazem parte do atendimento
function DeletarEquipamenros(id_Equipamento,id_Atendimento,Descricao)
{
	if (confirm("Tem certeza que deseja apagar o equipamento:\n\n " + Descricao ))
		{
			try //Inicio de tratamento de erro
				{ 
					var Dados; //Varivel onde ficare arazenado o resultado final
					xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
					xmlHTTP.Open('POST', 'carrega.asp?Action=DeletarEquipamentos&id_Equipamento=' + id_Equipamento + '&id_Atendimento=' + document.formCadastro.id_Atendimento.value , false); // Seta a pagina onde ira apagar o registro.
					xmlHTTP.Send(); //Envia
		 
					Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
							Carrega_Lista_Equipamentos.innerHTML = Dados //Armazena o conteudo da variavel DADOS em Carrega_Lista_Equipamentos que é o id da DIV para usar mostrar na pagina basta usar isso: <div id=Carrega_Lista_Equipamentos></div>
				}
			catch(e)//Caso houve erro então é mostrado a descrição do erro
					{ 
						alert(e.descripition); //Descricao do erro
					}
		}
}
</script>

<script>
//Função resposavel por deletar os equipamentos que fazem parte do atendimento
function DeletarMateriais(id_Material,id_Atendimento,Descricao)
{
	if (confirm("Tem certeza que deseja apagar o material:\n\n " + Descricao ))
		{
			try //Inicio de tratamento de erro
				{ 
					var Dados; //Varivel onde ficare arazenado o resultado final
					xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
					xmlHTTP.Open('POST', 'carrega.asp?Action=DeletarMaterial&id_Material=' + id_Material + '&id_Atendimento=' + document.formCadastro.id_Atendimento.value , false); // Seta a pagina onde ira apagar o registro.
					xmlHTTP.Send(); //Envia
		 
					Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
							Carrega_Lista_Materiais.innerHTML = Dados //Armazena o conteudo da variavel DADOS em Carrega_Lista_Materiais que é o id da DIV para usar mostrar na pagina basta usar isso: <div id=Carrega_Lista_Materiais></div>
				}
			catch(e)//Caso houve erro então é mostrado a descrição do erro
					{ 
						alert(e.descripition); //Descricao do erro
					}
		}
}
</script>

<script>
//Função resposavel por deletar os equipamentos que fazem parte do atendimento
function DeletarMedicamentos(id_Medicamento,id_Atendimento,Descricao)
{
	if (confirm("Tem certeza que deseja apagar o medicamento:\n\n " + Descricao ))
		{
			try //Inicio de tratamento de erro
				{ 
					var Dados; //Varivel onde ficare arazenado o resultado final
					xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
					xmlHTTP.Open('POST', 'carrega.asp?Action=DeletarMedicamento&id_Medicamento=' + id_Medicamento + '&id_Atendimento=' + document.formCadastro.id_Atendimento.value , false); // Seta a pagina onde ira apagar o registro.
					xmlHTTP.Send(); //Envia
		 
					Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
							Carrega_Lista_Medicamentos.innerHTML = Dados //Armazena o conteudo da variavel DADOS em Carrega_Lista_Medicamentos que é o id da DIV para usar mostrar na pagina basta usar isso: <div id=Carrega_Lista_Medicamentos></div>
				}
			catch(e)//Caso houve erro então é mostrado a descrição do erro
					{ 
						alert(e.descripition); //Descricao do erro
					}
		}
}
</script>

<script>
//Função resposavel por deletar os equipamentos que fazem parte do atendimento
function DeletarExames(id_Exame,id_Atendimento,Descricao)
{
	if (confirm("Tem certeza que deseja apagar o exame:\n\n " + Descricao ))
		{
			try //Inicio de tratamento de erro
				{ 
					var Dados; //Varivel onde ficare arazenado o resultado final
					xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
					xmlHTTP.Open('POST', 'carrega.asp?Action=DeletarExame&id_Exame=' + id_Exame + '&id_Atendimento=' + document.formCadastro.id_Atendimento.value , false); // Seta a pagina onde ira apagar o registro.
					xmlHTTP.Send(); //Envia
		 
					Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
							Carrega_Lista_Exames.innerHTML = Dados //Armazena o conteudo da variavel DADOS em Carrega_Lista_Medicamentos que é o id da DIV para usar mostrar na pagina basta usar isso: <div id=Carrega_Lista_Medicamentos></div>
				}
			catch(e)//Caso houve erro então é mostrado a descrição do erro
					{ 
						alert(e.descripition); //Descricao do erro
					}
		}
}
</script>

<script>
//Função resposavel verificar se no atendimento existe um médico responsavel ativo
//Isso foi feito porque a pessoa pode deletar um medico e se esquecer ou fechar o navegador e nao colocar um novo médico resposavel no lugar do que foi deletado
//E tambén porque para fazer a prescrição nova é preciso ter o id do funcionario(medico)
var Verifica_Existencia_Medico; //Variavel é globla pois quando é submetido o Form ela sera usado para veriifcação
function Verifica_Medico_Atendimento(id_Atendimento) 
{
	var Dados; //Varivel onde ficare arazenado o resultado final
	xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
	xmlHTTP.Open('POST', 'carrega.asp?Action=Verifica_Medico_Atendimento&id_Atendimento=' + document.formCadastro.id_Atendimento.value , false); // Seta a pagina onde ira apagar o registro.
	xmlHTTP.Send(); //Envia

	Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
	Verifica_Existencia_Medico = Dados
}
</script>


<script>
//FUNÇÃO QUE FAZ AS VALIDAÇÕES DO FORMULARIO ANTES DE INSERIR
function valida_campo()
{
<!--
//Valida o Status
if (document.formCadastro.id_Atendimento_Status.value==""){
	alert("Selecione o status do atendimento");
	document.formCadastro.id_Atendimento_Status.focus()
	return false
	}
//Valida os compos do medico
if (document.formCadastro.Medico_CRM.value==""){
	alert("Entre com o CRM do médico");
	document.formCadastro.Medico_CRM.focus()
	return false
	}
if (document.formCadastro.Medico_CRM.value !="" && document.formCadastro.id_Periodicidade_Medico.value == "" ){
	alert("Selecione a periodicidade do médico");
	document.formCadastro.id_Periodicidade_Medico.focus()
	return false
	}
if (document.formCadastro.Medico_CRM.value !="" && document.formCadastro.Qtd_Periodicidade_Medico.value == "" ){
	alert("Entre com a quantidade de periodicidade para o médico");
	document.formCadastro.Qtd_Periodicidade_Medico.focus()
	return false
	}
	var digitos = "0123456789";	//Treco de codigo somente feito para verificar se foi realmente digitado numeros
	for (var j = 0; j < document.formCadastro.Qtd_Periodicidade_Medico.value.length; j++)
		{
		if (digitos.indexOf(document.formCadastro.Qtd_Periodicidade_Medico.value.charAt(j)) == -1)
			{
			alert("Por favor, digite somente números no campo de quantidade de periodicidade para o médico:\n\n " + document.formCadastro.Medico_Nome.value );
			document.formCadastro.Qtd_Periodicidade_Medico.value = "";
			document.formCadastro.Qtd_Periodicidade_Medico.focus();
			return false;
			}
		}
if (document.formCadastro.Medico_CRM.value !="" && document.formCadastro.id_Contrato_Servico_Medico.value == "" ){
	alert("Selecione um contrato de serviço para o médico " + document.formCadastro.Medico_Nome.value );
	document.formCadastro.id_Contrato_Servico_Medico.focus()
	return false
	}
//Valida os campos do enfermeiro chefe
if (document.formCadastro.Enfermeiro_COREN.value==""){
	alert("Entre com o COREN do enfermeiro chefe");
	document.formCadastro.Enfermeiro_COREN.focus()
	return false
	}
if (document.formCadastro.Enfermeiro_COREN.value !="" && document.formCadastro.id_Periodicidade_Enfermeiro.value == "" ){
	alert("Selecione a periodicidade do enfermeiro chefe");
	document.formCadastro.id_Periodicidade_Enfermeiro.focus()
	return false
	}
if (document.formCadastro.Enfermeiro_COREN.value !="" && document.formCadastro.Qtd_Periodicidade_Enfermeiro.value == "" ){
	alert("Entre com a quantidade de periodicidade para o enfermeito chefe");
	document.formCadastro.Qtd_Periodicidade_Enfermeiro.focus()
	return false
	}
	var digitos = "0123456789";	//Treco de codigo somente feito para verificar se foi realmente digitado numeros
	for (var j = 0; j < document.formCadastro.Qtd_Periodicidade_Enfermeiro.value.length; j++)
		{
		if (digitos.indexOf(document.formCadastro.Qtd_Periodicidade_Enfermeiro.value.charAt(j)) == -1)
			{
			alert("Por favor, digite somente números no campo de quantidade de periodicidade para o enfermeiro chefe:\n\n " + document.formCadastro.Enfermeiro_Nome.value );
			document.formCadastro.Qtd_Periodicidade_Enfermeiro.value = "";
			document.formCadastro.Qtd_Periodicidade_Enfermeiro.focus();
			return false;
			}
		}
if (document.formCadastro.Enfermeiro_COREN.value !="" && document.formCadastro.id_Contrato_Servico_Enfermeiro.value == "" ){
	alert("Selecione um contrato de serviço para o enfermeiro chefe " + document.formCadastro.Enfermeiro_Nome.value );
	document.formCadastro.id_Contrato_Servico_Enfermeiro.focus()
	return false
	}
//Valida o bloco de campos da equipe de enfermagem
	marcado = -1
	for (i=0; i<formCadastro.Enfermagem_COREN.length; i++) 
	{
		if (formCadastro.Enfermagem_COREN[i].value) 
		{
			marcado = i
		}
		/*
		if (marcado == -1)  //Verifica se não foi preenchido nenhum campo
		{
			alert("É obrigatorio o preenchimento de pelo menos 1 Aux. de enfermagem");
			formCadastro.Enfermagem_COREN[i].focus();
			return false;
		}
		*/
		if (formCadastro.Enfermagem_COREN[i].value != "" && formCadastro.id_Periodicidade_Enfermagem[i].value == "" ) //Verifica se foi seleciona um Aux de enfemagem e se nao foi preenchido a periodicidade
		{
			alert("Selecione a periodicidade de vista para o enfermeiro(a):\n\n" + document.formCadastro.Enfermagem_Nome[i].value);
			formCadastro.id_Periodicidade_Enfermagem[i].focus();
			return false;
		}
		if (formCadastro.Enfermagem_COREN[i].value != "" && formCadastro.Qtd_Periodicidade_Enfermagem[i].value == "" ) //Verifica se foi seleciona um Aux de enfemagem e se nao foi preenchido a periodicidade
		{
			alert("Entra com a quantidade de periodicidade de vista para o enfermeiro(a):\n\n" + document.formCadastro.Enfermagem_Nome[i].value);
			formCadastro.Qtd_Periodicidade_Enfermagem[i].focus();
			return false;
		}
		var digitos = "0123456789";	//Treco de codigo somente feito para verificar se foi realmente digitado numeros
		for (var j = 0; j < document.formCadastro.Qtd_Periodicidade_Enfermagem[i].value.length; j++)
			{
			if (digitos.indexOf(document.formCadastro.Qtd_Periodicidade_Enfermagem[i].value.charAt(j)) == -1)
				{
				alert("Por favor, digite somente números no campo de quantidade de periodicidade para o Aux. enfermagem:\n\n " + document.formCadastro.Enfermagem_Nome[i].value );
				document.formCadastro.Qtd_Periodicidade_Enfermagem[i].value = "";
				document.formCadastro.Qtd_Periodicidade_Enfermagem[i].focus();
				return false;
				}
			}
		if (formCadastro.Enfermagem_COREN[i].value != "" && formCadastro.id_Contrato_Servico_Enfermagem[i].value == "" ) //Verifica se foi seleciona um Aux de enfemagem e se nao foi preenchido a periodicidade
		{
			alert("Selecione um contrato de serviço para o Aux. enfermagem " + document.formCadastro.Enfermagem_Nome[i].value);
			formCadastro.id_Contrato_Servico_Enfermagem[i].focus();
			return false;
		}
	}
//Valida o bloco de campos da equipe de fisioterapeutas
	marcado = -1
	for (i=0; i<formCadastro.Fisioterapeuta_CREFITO.length; i++) 
	{
		if (formCadastro.Fisioterapeuta_CREFITO[i].value) 
		{
			marcado = i
		}
		/*if (marcado == -1)  //Verifica se não foi preenchido nenhum campo
		{
			alert("É obrigatorio o preenchimento de pelo menos 1 fisioterapeuta");
			formCadastro.Fisioterapeuta_CREFITO[i].focus();
			return false;
		}
		*/
		if (formCadastro.Fisioterapeuta_CREFITO[i].value != "" && formCadastro.id_Periodicidade_Fisioterapeuta[i].value == "" ) //Verifica se foi seleciona um fisioterapeuta e se nao foi preenchido a periodicidade
		{
			alert("Selecione a peridicidade de vista para o fisioterapeuta:\n\n" + document.formCadastro.Fisioterapeuta_Nome[i].value);
			formCadastro.id_Periodicidade_Fisioterapeuta[i].focus();
			return false;
		}
		if (formCadastro.Fisioterapeuta_CREFITO[i].value != "" && formCadastro.id_Periodicidade_Fisioterapeuta[i].value != "" && formCadastro.Qtd_Sessoes[i].value == "" ) //Verifica se foi seleciona um fisioterapeuta e se a Periodicidade foi preenchida e se o campo quantidade esta vazio, se estiver vai mostrar o erro
		{
			alert("Entre com a quantidade de sessoes que o fisioterapeuta "+ document.formCadastro.Fisioterapeuta_Nome[i].value +" ira aplicar no paciente:\n\n" + document.formCadastro.Qtd_Sessoes[i].value);
			formCadastro.Qtd_Sessoes[i].focus();
			return false;
		}
		var digitos = "0123456789";	//Treco de codigo somente feito para verificar se foi realmente digitado numeros
		for (var j = 0; j < document.formCadastro.Qtd_Sessoes[i].value.length; j++)
			{
			if (digitos.indexOf(document.formCadastro.Qtd_Sessoes[i].value.charAt(j)) == -1)
				{
				alert("Por favor, digite somente números no campo de quantidade de sessoes de fisioterapia:\n\n " + document.formCadastro.Fisioterapeuta_Nome[i].value );
				document.formCadastro.Qtd_Sessoes[i].value = "";
				document.formCadastro.Qtd_Sessoes[i].focus();
				return false;
				}
			}
		if (formCadastro.Fisioterapeuta_CREFITO[i].value != "" && formCadastro.id_Contrato_Servico_Fisioterapeuta[i].value == ""  ) //Verifica se foi seleciona um fisioterapeuta e se a Periodicidade foi preenchida e se o campo quantidade esta vazio, se estiver vai mostrar o erro
		{
			alert("Selecione um contrato de serviço para o fisiterapeuta " + document.formCadastro.Fisioterapeuta_Nome[i].value );
			formCadastro.id_Contrato_Servico_Fisioterapeuta[i].focus();
			return false;
		}
	}
//Valida o bloco de campos de Outros Serviços
	marcado = -1
	for (i=0; i<formCadastro.Outros_Servicos_Codigo.length; i++) 
	{
		if (formCadastro.Outros_Servicos_Codigo[i].value) 
		{
			marcado = i
		}
		if (formCadastro.Outros_Servicos_Codigo[i].value != "" && formCadastro.id_Periodicidade_Outros_Servicos[i].value == "" ) //Verifica se foi selecionado um funcionario e se nao selecionado a periodicidade
		{
			alert("Selecione a peridicidade de vista para o funcionario:\n\n" + document.formCadastro.Outros_Servicos_Funcionario[i].value);
			formCadastro.id_Periodicidade_Outros_Servicos[i].focus();
			return false;
		}
		if (formCadastro.Outros_Servicos_Codigo[i].value != "" && formCadastro.Qtd_Periodicidade_Outros_Servicos[i].value == "" ) //Verifica se foi seleciona um funcionario e se a quantidade esta vazio, se estiver vai mostrar o erro
		{
			alert("Entre com a quantidade de visita que o funcionario "+ document.formCadastro.Outros_Servicos_Funcionario[i].value +" ira aplicar no paciente:\n\n" );
			formCadastro.Qtd_Periodicidade_Outros_Servicos[i].focus();
			return false;
		}
		var digitos = "0123456789";	//Treco de codigo somente feito para verificar se foi realmente digitado numeros
		for (var j = 0; j < document.formCadastro.Qtd_Periodicidade_Outros_Servicos[i].value.length; j++)
			{
			if (digitos.indexOf(document.formCadastro.Qtd_Periodicidade_Outros_Servicos[i].value.charAt(j)) == -1)
				{
				alert("Por favor, digite somente números no campo de quantidade para outros servicos do funcionario:\n\n " + document.formCadastro.Outros_Servicos_Funcionario[i].value );
				document.formCadastro.Qtd_Periodicidade_Outros_Servicos[i].value = "";
				document.formCadastro.Qtd_Periodicidade_Outros_Servicos[i].focus();
				return false;
				}
			}
		if (formCadastro.Outros_Servicos_Codigo[i].value != "" && formCadastro.id_Contrato_Servico_Outros_Servicos[i].value == ""  ) //Verifica se foi seleciona um funcionario e o campo contrato esta vazio, se estiver vai mostrar o erro
		{
			alert("Selecione um contrato de serviço para o funcionario " + document.formCadastro.Outros_Servicos_Funcionario[i].value );
			formCadastro.id_Contrato_Servico_Outros_Servicos[i].focus();
			return false;
		}
		if (formCadastro.Outros_Servicos_Codigo[i].value != "" && formCadastro.Outros_Servicos_Obs[i].value == "" ) //Verifica se foi selecionado um funcionario e se nao foi preenchido a obs
		{
			alert("Digite no campo observação o motivo pelo qual esta sendo usado o serviço do funcionario:\n\n" + document.formCadastro.Outros_Servicos_Funcionario[i].value);
			formCadastro.Outros_Servicos_Obs[i].focus();
			return false;
		}
	}
//Valida o bloco de campos para equipamentos simpro
	marcado = -1
	for (i=0; i<formCadastro.Cod_Simpro_Equipamentos.length; i++) 
	{
		if (formCadastro.Cod_Simpro_Equipamentos[i].value) 
		{
			marcado = i
		}
		/*if (marcado == -1)  //Verifica se não foi preenchido nenhum campo
		{
			alert("É obrigatorio o preenchimento de pelo menos 1 equipamento");
			formCadastro.Cod_Simpro_Equipamentos[i].focus();
			return false;
		}
		*/
		if (formCadastro.Cod_Simpro_Equipamentos[i].value != "" && formCadastro.qtd_Equipamentos[i].value == "" ) //Verifica se foi selecionado um equipamento e se nao foi preenchido a quantidade
		{
			alert("Entre com uma quantidade para o equipamento:\n\n" + document.formCadastro.Descricao_Equipamentos[i].value);
			formCadastro.qtd_Equipamentos[i].focus();
			return false;
		}
		var digitos = "0123456789";	//Treco de codigo somente feito para verificar se foi realmente digitado numeros
		for (var j = 0; j < document.formCadastro.qtd_Equipamentos[i].value.length; j++)
			{
			if (digitos.indexOf(document.formCadastro.qtd_Equipamentos[i].value.charAt(j)) == -1)
				{
				alert("Por favor, digite somente números no campo de quantidade para o equipamento:\n\n " + document.formCadastro.Descricao_Equipamentos[i].value );
				document.formCadastro.qtd_Equipamentos[i].value = "";
				document.formCadastro.qtd_Equipamentos[i].focus();
				return false;
				}
			}
		if (formCadastro.Cod_Simpro_Equipamentos[i].value != "" && formCadastro.qtd_Equipamentos[i].value != "" && formCadastro.id_Fornecedor_Equipamento[i].value == "" ) //Verifica se foi selecionado um equipamento e se a quantidade foi preenchida e se o campo fornecedor esta vazio, se estiver vai mostrar o erro
		{
			alert("Selecione um fornecedor para o equipamento:\n\n" + document.formCadastro.Descricao_Equipamentos[i].value);
			formCadastro.id_Fornecedor_Equipamento[i].focus();
			return false;
		}
	}
//Valida o bloco de campos para materiais simpro
	marcado = -1
	for (i=0; i<formCadastro.Cod_Simpro_Materiais.length; i++) 
	{
		if (formCadastro.Cod_Simpro_Materiais[i].value) 
		{
			marcado = i
		}
		/*if (marcado == -1)  //Verifica se não foi preenchido nenhum campo
		{
			alert("É obrigatorio o preenchimento de pelo menos 1 material");
			formCadastro.Cod_Simpro_Materiais[i].focus();
			return false;
		}
		*/
		if (formCadastro.Cod_Simpro_Materiais[i].value != "" && formCadastro.qtd_Material[i].value == "" ) //Verifica se foi selecionado um material e se nao foi preenchido a quantidade
		{
			alert("Entre com uma quantidade para o material:\n\n" + document.formCadastro.Descricao_Material[i].value);
			formCadastro.qtd_Material[i].focus();
			return false;
		}
		var digitos = "0123456789";	//Treco de codigo somente feito para verificar se foi realmente digitado numeros
		for (var j = 0; j < document.formCadastro.qtd_Material[i].value.length; j++)
			{
			if (digitos.indexOf(document.formCadastro.qtd_Material[i].value.charAt(j)) == -1)
				{
				alert("Por favor, digite somente números no campo de quantidade para o material:\n\n " + document.formCadastro.Descricao_Material[i].value );
				document.formCadastro.qtd_Material[i].value = "";
				document.formCadastro.qtd_Material[i].focus();
				return false;
				}
			}
		if (formCadastro.Cod_Simpro_Materiais[i].value != "" && formCadastro.qtd_Material[i].value != "" && formCadastro.id_Fornecedor_Material[i].value == "" ) //Verifica se foi selecionado um material e se a quantidade foi preenchida e se o campo fornecedor esta vazio, se estiver vai mostrar o erro
		{
			alert("Selecione um fornecedor para o material:\n\n" + document.formCadastro.Descricao_Material[i].value);
			formCadastro.id_Fornecedor_Material[i].focus();
			return false;
		}
	}
//Valida o bloco de campos para medicamentos simpro
	marcado = -1
	for (i=0; i<formCadastro.Cod_Simpro_Medicamento.length; i++) 
	{
		if (formCadastro.Cod_Simpro_Medicamento[i].value) 
		{
			marcado = i
		}
		/*if (marcado == -1)  //Verifica se não foi preenchido nenhum campo
		{
			alert("É obrigatorio o preenchimento de pelo menos 1 medicamento");
			formCadastro.Cod_Simpro_Medicamento[i].focus();
			return false;
		}
		*/
		if (formCadastro.Cod_Simpro_Medicamento[i].value != "" && formCadastro.qtd_Medicamentos[i].value == "" ) //Verifica se foi selecionado um medicamento e se nao foi preenchido a quantidade
		{
			alert("Entre com uma quantidade para o medicamento:\n\n" + document.formCadastro.Descricao_Medicamento[i].value);
			formCadastro.qtd_Medicamentos[i].focus();
			return false;
		}
		var digitos = "0123456789";	//Treco de codigo somente feito para verificar se foi realmente digitado numeros
		for (var j = 0; j < document.formCadastro.qtd_Medicamentos[i].value.length; j++)
			{
			if (digitos.indexOf(document.formCadastro.qtd_Medicamentos[i].value.charAt(j)) == -1)
				{
				alert("Por favor, digite somente números no campo de quantidade para o medicamento:\n\n " + document.formCadastro.Descricao_Medicamento[i].value );
				document.formCadastro.qtd_Medicamentos[i].value = "";
				document.formCadastro.qtd_Medicamentos[i].focus();
				return false;
				}
			}
		if (formCadastro.Cod_Simpro_Medicamento[i].value != "" && formCadastro.qtd_Medicamentos[i].value != "" && formCadastro.id_Fornecedor_Medicamento[i].value == "" ) //Verifica se foi selecionado um material e se a quantidade foi preenchida e se o campo fornecedor esta vazio, se estiver vai mostrar o erro
		{
			alert("Selecione um fornecedor para o medicamento:\n\n" + document.formCadastro.Descricao_Medicamento[i].value);
			formCadastro.id_Fornecedor_Medicamento[i].focus();
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
		if (formCadastro.Cod_Exame[i].value != "" && formCadastro.Data_Realizacao_Exame[i].value == "" ) //Verifica se foi preenchido a data de realizacao do exame
		{
			alert("Entre com a data de realização do exame:\n\n" + document.formCadastro.Descricao_Exame[i].value);
			formCadastro.Data_Realizacao_Exame[i].focus();
			return false;
		}
		if (formCadastro.Cod_Exame[i].value != "" && formCadastro.id_Fornecedor_Exame[i].value == "" ) //Verifica se foi selecionado um exame e se o campo fornecedor esta vazio, se estiver vai mostrar o erro
		{
			alert("Selecione um laboratório para realizar o exame:\n\n" + document.formCadastro.Descricao_Exame[i].value);
			formCadastro.id_Fornecedor_Exame[i].focus();
			return false;
		}
	}



}
//-->
</script>


<script>
//FUNÇÃO QUE FAZ AS VALIDAÇÕES DO FORMULARIO ANTES DE FAZER O UPDATE
function valida_campo_Editar()
{
<!--
//Valida o Status
if (document.formCadastro.id_Atendimento_Status.value==""){
	alert("Selecione o status do atendimento");
	document.formCadastro.id_Atendimento_Status.focus()
	return false
	}
//Valida os compos do medico
Verifica_Medico_Atendimento(document.formCadastro.id_Atendimento.value) //De inicio é chamada a função JS que ira retornar uma variavel global (Verifica_Existencia_Medico) que sera usado para verificação
if (Verifica_Existencia_Medico == "errado" && document.formCadastro.Medico_CRM.value ==""){
	alert("O atendimento não pode ficar sem um médico resposável");
	document.formCadastro.Medico_CRM.focus()
	return false
	}
if (document.formCadastro.Medico_CRM.value !="" && document.formCadastro.id_Periodicidade_Medico.value == "" ){
	alert("Selecione a periodicidade do médico");
	document.formCadastro.id_Periodicidade_Medico.focus()
	return false
	}
if (document.formCadastro.Medico_CRM.value !="" && document.formCadastro.Qtd_Periodicidade_Medico.value == "" ){
	alert("Entre com a quantidade de periodicidade para o médico");
	document.formCadastro.Qtd_Periodicidade_Medico.focus()
	return false
	}
	var digitos = "0123456789";	//Treco de codigo somente feito para verificar se foi realmente digitado numeros
	for (var j = 0; j < document.formCadastro.Qtd_Periodicidade_Medico.value.length; j++)
		{
		if (digitos.indexOf(document.formCadastro.Qtd_Periodicidade_Medico.value.charAt(j)) == -1)
			{
			alert("Por favor, digite somente números no campo de quantidade de periodicidade para o médico:\n\n " + document.formCadastro.Medico_Nome.value );
			document.formCadastro.Qtd_Periodicidade_Medico.value = "";
			document.formCadastro.Qtd_Periodicidade_Medico.focus();
			return false;
			}
		}
if (document.formCadastro.Medico_CRM.value !="" && document.formCadastro.id_Contrato_Servico_Medico.value == "" ){
	alert("Selecione um contrato de serviço para o médico " + document.formCadastro.Medico_Nome.value );
	document.formCadastro.id_Contrato_Servico_Medico.focus()
	return false
	}
//Valida os campos do enfermeiro chefe
if (document.formCadastro.Enfermeiro_COREN.value !="" && document.formCadastro.id_Periodicidade_Enfermeiro.value == "" ){
	alert("Selecione a periodicidade do enfermeiro chefe");
	document.formCadastro.id_Periodicidade_Enfermeiro.focus()
	return false
	}
if (document.formCadastro.Enfermeiro_COREN.value !="" && document.formCadastro.Qtd_Periodicidade_Enfermeiro.value == "" ){
	alert("Entre com a quantidade de periodicidade para o enfermeito chefe");
	document.formCadastro.Qtd_Periodicidade_Enfermeiro.focus()
	return false
	}
	var digitos = "0123456789";	//Treco de codigo somente feito para verificar se foi realmente digitado numeros
	for (var j = 0; j < document.formCadastro.Qtd_Periodicidade_Enfermeiro.value.length; j++)
		{
		if (digitos.indexOf(document.formCadastro.Qtd_Periodicidade_Enfermeiro.value.charAt(j)) == -1)
			{
			alert("Por favor, digite somente números no campo de quantidade de periodicidade para o enfermeiro chefe:\n\n " + document.formCadastro.Enfermeiro_Nome.value );
			document.formCadastro.Qtd_Periodicidade_Enfermeiro.value = "";
			document.formCadastro.Qtd_Periodicidade_Enfermeiro.focus();
			return false;
			}
		}
if (document.formCadastro.Enfermeiro_COREN.value !="" && document.formCadastro.id_Contrato_Servico_Enfermeiro.value == "" ){
	alert("Selecione um contrato de serviço para o enfermeiro chefe " + document.formCadastro.Enfermeiro_Nome.value );
	document.formCadastro.id_Contrato_Servico_Enfermeiro.focus()
	return false
	}
//Valida o bloco de campos da equipe de enfermagem
	marcado = -1
	for (i=0; i<formCadastro.Enfermagem_COREN.length; i++) 
	{
		if (formCadastro.Enfermagem_COREN[i].value) 
		{
			marcado = i
		}
		/*
		if (marcado == -1)  //Verifica se não foi preenchido nenhum campo
		{
			alert("É obrigatorio o preenchimento de pelo menos 1 Aux. de enfermagem");
			formCadastro.Enfermagem_COREN[i].focus();
			return false;
		}
		*/
		if (formCadastro.Enfermagem_COREN[i].value != "" && formCadastro.id_Periodicidade_Enfermagem[i].value == "" ) //Verifica se foi seleciona um Aux de enfemagem e se nao foi preenchido a periodicidade
		{
			alert("Selecione a periodicidade de vista para o enfermeiro(a):\n\n" + document.formCadastro.Enfermagem_Nome[i].value);
			formCadastro.id_Periodicidade_Enfermagem[i].focus();
			return false;
		}
		if (formCadastro.Enfermagem_COREN[i].value != "" && formCadastro.Qtd_Periodicidade_Enfermagem[i].value == "" ) //Verifica se foi seleciona um Aux de enfemagem e se nao foi preenchido a periodicidade
		{
			alert("Entra com a quantidade de periodicidade de vista para o enfermeiro(a):\n\n" + document.formCadastro.Enfermagem_Nome[i].value);
			formCadastro.Qtd_Periodicidade_Enfermagem[i].focus();
			return false;
		}
		var digitos = "0123456789";	//Treco de codigo somente feito para verificar se foi realmente digitado numeros
		for (var j = 0; j < document.formCadastro.Qtd_Periodicidade_Enfermagem[i].value.length; j++)
			{
			if (digitos.indexOf(document.formCadastro.Qtd_Periodicidade_Enfermagem[i].value.charAt(j)) == -1)
				{
				alert("Por favor, digite somente números no campo de quantidade de periodicidade para o Aux. enfermagem:\n\n " + document.formCadastro.Enfermagem_Nome[i].value );
				document.formCadastro.Qtd_Periodicidade_Enfermagem[i].value = "";
				document.formCadastro.Qtd_Periodicidade_Enfermagem[i].focus();
				return false;
				}
			}
		if (formCadastro.Enfermagem_COREN[i].value != "" && formCadastro.id_Contrato_Servico_Enfermagem[i].value == "" ) //Verifica se foi seleciona um Aux de enfemagem e se nao foi preenchido a periodicidade
		{
			alert("Selecione um contrato de serviço para o Aux. enfermagem " + document.formCadastro.Enfermagem_Nome[i].value);
			formCadastro.id_Contrato_Servico_Enfermagem[i].focus();
			return false;
		}
	}
//Valida o bloco de campos da equipe de fisioterapeutas
	marcado = -1
	for (i=0; i<formCadastro.Fisioterapeuta_CREFITO.length; i++) 
	{
		if (formCadastro.Fisioterapeuta_CREFITO[i].value) 
		{
			marcado = i
		}
		/*if (marcado == -1)  //Verifica se não foi preenchido nenhum campo
		{
			alert("É obrigatorio o preenchimento de pelo menos 1 fisioterapeuta");
			formCadastro.Fisioterapeuta_CREFITO[i].focus();
			return false;
		}
		*/
		if (formCadastro.Fisioterapeuta_CREFITO[i].value != "" && formCadastro.id_Periodicidade_Fisioterapeuta[i].value == "" ) //Verifica se foi seleciona um fisioterapeuta e se nao foi preenchido a periodicidade
		{
			alert("Selecione a peridicidade de vista para o fisioterapeuta:\n\n" + document.formCadastro.Fisioterapeuta_Nome[i].value);
			formCadastro.id_Periodicidade_Fisioterapeuta[i].focus();
			return false;
		}
		if (formCadastro.Fisioterapeuta_CREFITO[i].value != "" && formCadastro.id_Periodicidade_Fisioterapeuta[i].value != "" && formCadastro.Qtd_Sessoes[i].value == "" ) //Verifica se foi seleciona um fisioterapeuta e se a Periodicidade foi preenchida e se o campo quantidade esta vazio, se estiver vai mostrar o erro
		{
			alert("Entre com a quantidade de sessoes que o fisioterapeuta "+ document.formCadastro.Fisioterapeuta_Nome[i].value +" ira aplicar no paciente:\n\n" + document.formCadastro.Qtd_Sessoes[i].value);
			formCadastro.Qtd_Sessoes[i].focus();
			return false;
		}
		var digitos = "0123456789";	//Treco de codigo somente feito para verificar se foi realmente digitado numeros
		for (var j = 0; j < document.formCadastro.Qtd_Sessoes[i].value.length; j++)
			{
			if (digitos.indexOf(document.formCadastro.Qtd_Sessoes[i].value.charAt(j)) == -1)
				{
				alert("Por favor, digite somente números no campo de quantidade de sessoes de fisioterapia:\n\n " + document.formCadastro.Fisioterapeuta_Nome[i].value );
				document.formCadastro.Qtd_Sessoes[i].value = "";
				document.formCadastro.Qtd_Sessoes[i].focus();
				return false;
				}
			}
		if (formCadastro.Fisioterapeuta_CREFITO[i].value != "" && formCadastro.id_Contrato_Servico_Fisioterapeuta[i].value == ""  ) //Verifica se foi seleciona um fisioterapeuta e se a Periodicidade foi preenchida e se o campo quantidade esta vazio, se estiver vai mostrar o erro
		{
			alert("Selecione um contrato de serviço para o fisiterapeuta " + document.formCadastro.Fisioterapeuta_Nome[i].value );
			formCadastro.id_Contrato_Servico_Fisioterapeuta[i].focus();
			return false;
		}
	}
//Valida o bloco de campos de Outros Serviços
	marcado = -1
	for (i=0; i<formCadastro.Outros_Servicos_Codigo.length; i++) 
	{
		if (formCadastro.Outros_Servicos_Codigo[i].value) 
		{
			marcado = i
		}
		if (formCadastro.Outros_Servicos_Codigo[i].value != "" && formCadastro.id_Periodicidade_Outros_Servicos[i].value == "" ) //Verifica se foi selecionado um funcionario e se nao selecionado a periodicidade
		{
			alert("Selecione a peridicidade de vista para o funcionario:\n\n" + document.formCadastro.Outros_Servicos_Funcionario[i].value);
			formCadastro.id_Periodicidade_Outros_Servicos[i].focus();
			return false;
		}
		if (formCadastro.Outros_Servicos_Codigo[i].value != "" && formCadastro.Qtd_Periodicidade_Outros_Servicos[i].value == "" ) //Verifica se foi seleciona um funcionario e se a quantidade esta vazio, se estiver vai mostrar o erro
		{
			alert("Entre com a quantidade de visita que o funcionario "+ document.formCadastro.Outros_Servicos_Funcionario[i].value +" ira aplicar no paciente:\n\n" );
			formCadastro.Qtd_Periodicidade_Outros_Servicos[i].focus();
			return false;
		}
		var digitos = "0123456789";	//Treco de codigo somente feito para verificar se foi realmente digitado numeros
		for (var j = 0; j < document.formCadastro.Qtd_Periodicidade_Outros_Servicos[i].value.length; j++)
			{
			if (digitos.indexOf(document.formCadastro.Qtd_Periodicidade_Outros_Servicos[i].value.charAt(j)) == -1)
				{
				alert("Por favor, digite somente números no campo de quantidade para outros servicos do funcionario:\n\n " + document.formCadastro.Outros_Servicos_Funcionario[i].value );
				document.formCadastro.Qtd_Periodicidade_Outros_Servicos[i].value = "";
				document.formCadastro.Qtd_Periodicidade_Outros_Servicos[i].focus();
				return false;
				}
			}
		if (formCadastro.Outros_Servicos_Codigo[i].value != "" && formCadastro.id_Contrato_Servico_Outros_Servicos[i].value == ""  ) //Verifica se foi seleciona um funcionario e o campo contrato esta vazio, se estiver vai mostrar o erro
		{
			alert("Selecione um contrato de serviço para o funcionario " + document.formCadastro.Outros_Servicos_Funcionario[i].value );
			formCadastro.id_Contrato_Servico_Outros_Servicos[i].focus();
			return false;
		}
		if (formCadastro.Outros_Servicos_Codigo[i].value != "" && formCadastro.Outros_Servicos_Obs[i].value == "" ) //Verifica se foi selecionado um funcionario e se nao foi preenchido a obs
		{
			alert("Digite no campo observação o motivo pelo qual esta sendo usado o serviço do funcionario:\n\n" + document.formCadastro.Outros_Servicos_Funcionario[i].value);
			formCadastro.Outros_Servicos_Obs[i].focus();
			return false;
		}
	}
//Valida o bloco de campos para equipamentos simpro
	marcado = -1
	for (i=0; i<formCadastro.Cod_Simpro_Equipamentos.length; i++) 
	{
		if (formCadastro.Cod_Simpro_Equipamentos[i].value) 
		{
			marcado = i
		}
		/*if (marcado == -1)  //Verifica se não foi preenchido nenhum campo
		{
			alert("É obrigatorio o preenchimento de pelo menos 1 equipamento");
			formCadastro.Cod_Simpro_Equipamentos[i].focus();
			return false;
		}
		*/
		if (formCadastro.Cod_Simpro_Equipamentos[i].value != "" && formCadastro.qtd_Equipamentos[i].value == "" ) //Verifica se foi selecionado um equipamento e se nao foi preenchido a quantidade
		{
			alert("Entre com uma quantidade para o equipamento:\n\n" + document.formCadastro.Descricao_Equipamentos[i].value);
			formCadastro.qtd_Equipamentos[i].focus();
			return false;
		}
		var digitos = "0123456789";	//Treco de codigo somente feito para verificar se foi realmente digitado numeros
		for (var j = 0; j < document.formCadastro.qtd_Equipamentos[i].value.length; j++)
			{
			if (digitos.indexOf(document.formCadastro.qtd_Equipamentos[i].value.charAt(j)) == -1)
				{
				alert("Por favor, digite somente números no campo de quantidade para o equipamento:\n\n " + document.formCadastro.Descricao_Equipamentos[i].value );
				document.formCadastro.qtd_Equipamentos[i].value = "";
				document.formCadastro.qtd_Equipamentos[i].focus();
				return false;
				}
			}
		if (formCadastro.Cod_Simpro_Equipamentos[i].value != "" && formCadastro.qtd_Equipamentos[i].value != "" && formCadastro.id_Fornecedor_Equipamento[i].value == "" ) //Verifica se foi selecionado um equipamento e se a quantidade foi preenchida e se o campo fornecedor esta vazio, se estiver vai mostrar o erro
		{
			alert("Selecione um fornecedor para o equipamento:\n\n" + document.formCadastro.Descricao_Equipamentos[i].value);
			formCadastro.id_Fornecedor_Equipamento[i].focus();
			return false;
		}
	}
//Valida o bloco de campos para materiais simpro
	marcado = -1
	for (i=0; i<formCadastro.Cod_Simpro_Materiais.length; i++) 
	{
		if (formCadastro.Cod_Simpro_Materiais[i].value) 
		{
			marcado = i
		}
		/*if (marcado == -1)  //Verifica se não foi preenchido nenhum campo
		{
			alert("É obrigatorio o preenchimento de pelo menos 1 material");
			formCadastro.Cod_Simpro_Materiais[i].focus();
			return false;
		}
		*/
		if (formCadastro.Cod_Simpro_Materiais[i].value != "" && formCadastro.qtd_Material[i].value == "" ) //Verifica se foi selecionado um material e se nao foi preenchido a quantidade
		{
			alert("Entre com uma quantidade para o material:\n\n" + document.formCadastro.Descricao_Material[i].value);
			formCadastro.qtd_Material[i].focus();
			return false;
		}
		var digitos = "0123456789";	//Treco de codigo somente feito para verificar se foi realmente digitado numeros
		for (var j = 0; j < document.formCadastro.qtd_Material[i].value.length; j++)
			{
			if (digitos.indexOf(document.formCadastro.qtd_Material[i].value.charAt(j)) == -1)
				{
				alert("Por favor, digite somente números no campo de quantidade para o material:\n\n " + document.formCadastro.Descricao_Material[i].value );
				document.formCadastro.qtd_Material[i].value = "";
				document.formCadastro.qtd_Material[i].focus();
				return false;
				}
			}
		if (formCadastro.Cod_Simpro_Materiais[i].value != "" && formCadastro.qtd_Material[i].value != "" && formCadastro.id_Fornecedor_Material[i].value == "" ) //Verifica se foi selecionado um material e se a quantidade foi preenchida e se o campo fornecedor esta vazio, se estiver vai mostrar o erro
		{
			alert("Selecione um fornecedor para o material:\n\n" + document.formCadastro.Descricao_Material[i].value);
			formCadastro.id_Fornecedor_Material[i].focus();
			return false;
		}
	}
//Valida o bloco de campos para medicamentos simpro
	marcado = -1
	for (i=0; i<formCadastro.Cod_Simpro_Medicamento.length; i++) 
	{
		if (formCadastro.Cod_Simpro_Medicamento[i].value) 
		{
			marcado = i
		}
		/*if (marcado == -1)  //Verifica se não foi preenchido nenhum campo
		{
			alert("É obrigatorio o preenchimento de pelo menos 1 medicamento");
			formCadastro.Cod_Simpro_Medicamento[i].focus();
			return false;
		}
		*/
		if (formCadastro.Cod_Simpro_Medicamento[i].value != "" && formCadastro.id_Prescricao_Medicamento[i].value == "" ) //Verifica se foi selecionado uma prescreicao medica para o medicamento
		{
			alert("Selecione uma prescrição para o medicamento:\n\n" + document.formCadastro.Descricao_Medicamento[i].value);
			formCadastro.id_Prescricao_Medicamento[i].focus();
			return false;
		}
		if (formCadastro.Cod_Simpro_Medicamento[i].value != "" && formCadastro.qtd_Medicamentos[i].value == "" ) //Verifica se foi selecionado um medicamento e se nao foi preenchido a quantidade
		{
			alert("Entre com uma quantidade para o medicamento:\n\n" + document.formCadastro.Descricao_Medicamento[i].value);
			formCadastro.qtd_Medicamentos[i].focus();
			return false;
		}
		var digitos = "0123456789";	//Treco de codigo somente feito para verificar se foi realmente digitado numeros
		for (var j = 0; j < document.formCadastro.qtd_Medicamentos[i].value.length; j++)
			{
			if (digitos.indexOf(document.formCadastro.qtd_Medicamentos[i].value.charAt(j)) == -1)
				{
				alert("Por favor, digite somente números no campo de quantidade para o medicamento:\n\n " + document.formCadastro.Descricao_Medicamento[i].value );
				document.formCadastro.qtd_Medicamentos[i].value = "";
				document.formCadastro.qtd_Medicamentos[i].focus();
				return false;
				}
			}
		if (formCadastro.Cod_Simpro_Medicamento[i].value != "" && formCadastro.qtd_Medicamentos[i].value != "" && formCadastro.id_Fornecedor_Medicamento[i].value == "" ) //Verifica se foi selecionado um material e se a quantidade foi preenchida e se o campo fornecedor esta vazio, se estiver vai mostrar o erro
		{
			alert("Selecione um fornecedor para o medicamento:\n\n" + document.formCadastro.Descricao_Medicamento[i].value);
			formCadastro.id_Fornecedor_Medicamento[i].focus();
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
		if (formCadastro.Cod_Exame[i].value != "" && formCadastro.Data_Realizacao_Exame[i].value == "" ) //Verifica se foi preenchido a data de realizacao do exame
		{
			alert("Entre com a data de realização do exame:\n\n" + document.formCadastro.Descricao_Exame[i].value);
			formCadastro.Data_Realizacao_Exame[i].focus();
			return false;
		}
		if (formCadastro.Cod_Exame[i].value != "" && formCadastro.id_Fornecedor_Exame[i].value == "" ) //Verifica se foi selecionado um exame e se o campo fornecedor esta vazio, se estiver vai mostrar o erro
		{
			alert("Selecione um laboratório para realizar o exame:\n\n" + document.formCadastro.Descricao_Exame[i].value);
			formCadastro.id_Fornecedor_Exame[i].focus();
			return false;
		}
	}


}
//-->
</script>
