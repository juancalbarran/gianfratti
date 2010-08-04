<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.Js" -->
<!-- #include virtual="/SmartCare/Modulos/HomeCare/Prontuario_Medico/Formulario_Evolucao/Js/Validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 28/09/2005
' Descrição: Pagina de Preenchimento de formulario de Admissão
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim Data_Cadastro_Atendimento,Data_Fechamento_Atendimento
'[CONEXÃO COM O BANCO DE DADOS]
set Conn = Server.CreateObject( "ADODB.Connection" )
Conn.CursorLocation = 3 'adUserClient
Conn.Open application("connstring")

Function Visualiza_Pacientes

	SQL =	"SELECT DISTINCT "&_ 
			"dbo.Pacientes.nome, dbo.Convenios.Convenio,  "&_ 
			"dbo.HomeCare_Atendimento_Status_Condicoes_Alta.Descricao AS Descricao_Status_Alta, "&_ 
			"dbo.HomeCare_Atendimento.id_Atendimento_Status_Condicoes_Alta, dbo.View_Atendimento_Funcionarios.id_Atendimento "&_ 
			"FROM dbo.View_Atendimento_Funcionarios INNER JOIN "&_ 
			"dbo.HomeCare_Atendimento ON dbo.View_Atendimento_Funcionarios.id_Atendimento = dbo.HomeCare_Atendimento.id INNER JOIN "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento ON  "&_ 
			"dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento = dbo.HomeCare_Solicitacao_Atendimento.id INNER JOIN "&_ 
			"dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id INNER JOIN "&_ 
			"dbo.HomeCare_Atendimento_Status_Condicoes_Alta ON  "&_ 
			"dbo.HomeCare_Atendimento.id_Atendimento_Status_Condicoes_Alta = dbo.HomeCare_Atendimento_Status_Condicoes_Alta.id INNER JOIN "&_ 
			"dbo.Convenios ON dbo.HomeCare_Solicitacao_Atendimento.id_Convenio = dbo.Convenios.id" 
			clausula = " WHERE  "
				if Trim(Session("Tipo_Login")) = "2" Then 'Caso o usuario logado seja um contato entao ele somente vera o pacientes dele, caso contrario se ele for um funcionario entao ele vero todos os pacientes
					sql = sql & clausula & " dbo.HomeCare_Solicitacao_Atendimento.id_Convenio = '"&Session("id_Convenio")&"'  "
					clausula = "and "
				end if
				if Trim(Request("Nome")) <> "" Then
					sql = sql & clausula & " Pacientes.Nome like '%"&Trim(Replace(Request("Nome"),"'","''"))&"%'  "
					clausula = "and "
				end if
			sql = sql & " Order by id_Atendimento_Status_Condicoes_Alta "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						  Response.Write "<tr class='Titulo_Tabela'>" & CHR(10)
							Response.Write "<td  valign='top' width='9%'&nbsp;</td>" & CHR(10)
							Response.Write "<td  valign='top' width='9%'>Nº Atend.</td>" & CHR(10)
							Response.Write "<td  valign='top' width='31%'>Paciente</td>" & CHR(10)
							Response.Write "<td  valign='top' width='20%'>Convênio</td>" & CHR(10)
							Response.Write "<td  valign='top' width='16%'>Status</td>" & CHR(10)
							Response.Write "<td  valign='top' align='center' width='3%'>&nbsp;</td>" & CHR(10)
							Response.Write "<td  valign='top' align='center' width='3%'>&nbsp;</td>" & CHR(10)

						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
							If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
							if rs("id_Atendimento_Status_Condicoes_Alta") <> "1" Then  'Faz a verificação para saber se o status não esta em analise, caso nao esteja entao coloca uma figura do cadeado e nao habilita o link para edicao 
								Imagem = "<img src='\SmartCare\images\ico_cadeado.gif' border='0' alt='Paciente não se econtra mais em atendimento, para visualizar o prontiario clique na imagem ao lado' >"
								Elseif rs("id_Atendimento_Status_Condicoes_Alta") = "1" And Session("Tipo_Login") = "1" Then  'Caso ainda esteja em edicao entao é colocado a imagem de edicao e o link de acesso e o Link 
								Imagem = "<a href='default.asp?action=Form_Incluir_Atendimento&id_Atendimento=" &rs("id_Atendimento")& "'><img src='/SmartCare/images/ico_editar.gif' border='0' alt='Alterar Atendimento'   ></a>"
							End if
						If rs("id_Atendimento_Status_Condicoes_Alta") = "1" Then 'Verifica o Status para colocar as images pintadas
							Flg_Imagem = "<img src='/SmartCare/images/Flg_verde.gif' border='0' alt='Em Atendimento'>"
							ElseIf rs("id_Atendimento_Status_Condicoes_Alta") = "2" Then
								Flg_Imagem = "<img src='/SmartCare/images/Flg_azul.gif' border='0' alt='Alta Clínica'>"
							ElseIf rs("id_Atendimento_Status_Condicoes_Alta") = "3" Then
								Flg_Imagem = "<img src='/SmartCare/images/Flg_amerelo_Escuro.gif' border='0' alt='Alta por reinternação SmartCare'>"
							ElseIf rs("id_Atendimento_Status_Condicoes_Alta") = "4" Then
								Flg_Imagem = "<img src='/SmartCare/images/Flg_vermelho.gif' border='0' alt='Exclusão Contratual'>"
							ElseIf rs("id_Atendimento_Status_Condicoes_Alta") = "5" Then
								Flg_Imagem = "<img src='/SmartCare/images/Flg_preto.gif' border='0' alt='Óbito'>"
						End if
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Flg_Imagem&"</Td>" & Chr(10)
							Response.Write "<td class='"&zebrado&"' valign='top' >"&Trim(Rs("id_Atendimento"))&"</td>" & CHR(10)
							Response.Write "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Nome"))&"</td>" & CHR(10)
							Response.Write "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Convenio"))&"</td>" & CHR(10)
							Response.Write "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Descricao_Status_Alta"))&"</td>" & CHR(10)		
							Response.Write "<td class='"&zebrado&"' valign='top' align='center'>"&Imagem&"&nbsp;</td>" & CHR(10)
							Response.Write "<td class='"&zebrado&"' valign='top' align='center'>"&"<a href=""javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Prontuario_Medico/Formulario_Evolucao/historico.asp?id_Atendimento="&rs("id_Atendimento")&"','1024','678',this,event)""><img src='/SmartCare/images/ico_impressora.gif' border='0' Alt='Visualizar Solicitação / Imprimir Solicitação'   ></a>"&"</td>" & CHR(10)

						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
						Response.Write "<Table width='100%' border='0' ><Tr><td align ='center' class='texto'>Total de registros encontrado: <b>"&Rs.RecordCount&"</b></td></tr></Table>"	
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Você não esta fazendo nenhum atendimento até o momento</b></TD></TR></Table>"
				End if

End Function

'Função que retorna a cadastro do pacinte, porem tem que ser passado os parametros de busca para isso
Function Carrega_Dados_Cadastro_Pacientes(id_Atendimento)

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL =	"SELECT TOP 1 dbo.Pacientes.*, dbo.FuncaoConvenioNome(dbo.Pacientes.id_convenio) AS Convenio_Nome, dbo.Cobertura.Nome AS Zona, " &_ 
			"dbo.Pacientes.id_cobertura AS id_Cobertura , dbo.HomeCare_Atendimento.Data_Cadastro AS Data_Cadastro_Atendimento,   dbo.HomeCare_Atendimento.Data_Fechamento AS Data_Fechamento_Atendimento " &_ 
			"FROM dbo.Pacientes INNER JOIN " &_ 
			"dbo.HomeCare_Solicitacao_Atendimento ON dbo.Pacientes.id = dbo.HomeCare_Solicitacao_Atendimento.id_Paciente INNER JOIN " &_ 
			"dbo.Cobertura ON dbo.Pacientes.id_cobertura = dbo.Cobertura.id INNER JOIN " &_ 
			"dbo.HomeCare_Atendimento ON dbo.HomeCare_Solicitacao_Atendimento.id = dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento " &_ 
			"WHERE dbo.HomeCare_Atendimento.id = '"&Cint(id_Atendimento)&"' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Data_Cadastro_Atendimento = Rs("Data_Cadastro_Atendimento")
					Data_Fechamento_Atendimento = Rs("Data_Fechamento_Atendimento")
					IF Rs("Particular")	Then Tipo_Plano = "Pessoa Fisica" Else Tipo_Plano = "Pessoa Juridica" End if
					Response.Write "<input name='id_Atendimento' type='hidden' value='"&Request("id_Atendimento")&"'>"
					Response.Write "<input name='id_Paciente' type='hidden' value='"&Rs("id")&"'>"
					Response.Write "<input name='Paciente_Nome' type='hidden' value='"&Rs("Nome")&"'>"
					Response.Write "<fieldset>"
					Response.Write "<legend>&nbsp;Paciente&nbsp;</legend>"

					Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>" & Chr(10)
					  Response.Write "<tr class='zebra_orange1'> "& Chr(10)
						Response.Write "<td width='8%'><b>Identificação:</b></td>" & Chr(10)
						Response.Write "<td width='25%'>"&Rs("Nome")&"</td>" & Chr(10)
						Response.Write "<td width='13%'><b>Data Nasc.:</b></td>" & Chr(10)
						Response.Write "<td width='22%'>"&ArrumaData(Rs("data_nascimento"))&"</td>" & Chr(10)
						Response.Write "<td width='8%'><b>Raça:</b></td>" & Chr(10)
						Response.Write "<td colspan='3'>Branca</td>" & Chr(10)
					  Response.Write "</tr>" & Chr(10)
					  Response.Write "<tr class='zebra_orange1'> " & Chr(10)
						Response.Write "<td><b>RG:</b></td>" & Chr(10)
						Response.Write "<td>"&Rs("RG")&"</td>" & Chr(10)
						Response.Write "<td><b>CPF:</b></td>" & Chr(10)
						Response.Write "<td>"&Rs("CPF")&"</td>" & Chr(10)
						Response.Write "<td><b>Zona:</b></td>" & Chr(10)
						Response.Write "<td colspan='4'>"&Rs("Zona")&"</td>" & Chr(10)
					  Response.Write "</tr>" & Chr(10)
					  Response.Write "<tr class='zebra_orange1'> " & Chr(10)
						Response.Write "<td><b>Convênio:</b></td>" & Chr(10)
						Response.Write "<td>"&Rs("Convenio_Nome")&"</td>" & Chr(10)
						Response.Write "<td><b>Tipo Plano:</b></td>" & Chr(10)
						Response.Write "<td colspan='5'>"&Tipo_Plano&"</td>" & Chr(10)
					  Response.Write "</tr>" & Chr(10)
					  Response.Write "<tr class='zebra_orange1'>" & Chr(10) 
						Response.Write "<td><b>Endereço:</b></td>" & Chr(10)
						Response.Write "<td>"&Trim(Rs("Endereco"))&"</td>" & Chr(10)
						Response.Write "<td><b>Cidade:</b></td> " & Chr(10)
						Response.Write "<td>"&Trim(Rs("Cidade"))&"</td> " & Chr(10)
						Response.Write "<td><b>Bairro:</b></td>" & Chr(10)
						Response.Write "<td width='17%'>"&Trim(Rs("Bairro"))&"</td>" & Chr(10)
						Response.Write "<td width='3%'><b>UF:</b></td>" & Chr(10)
						Response.Write "<td width='4%'>"&Trim(Rs("UF"))&"</td> " & Chr(10)
					  Response.Write "</tr>" & Chr(10)
					  Response.Write "<tr class='zebra_orange1'> " & Chr(10)
						Response.Write "<td><b>Telefones:</b></td>" & Chr(10)
						Response.Write "<td>"&Trim(Rs("Telefones"))&"</td>" & Chr(10)
						Response.Write "<td><b>Responsavel:</b></td>" & Chr(10)
						Response.Write "<td>"&Trim(Rs("Responsavel"))&"</td>" & Chr(10)
						Response.Write "<td><b>Cuidador:</b></td>" & Chr(10)
						Response.Write "<td colspan='3'>"&Trim(Rs("Cuidador"))&"</td>" & Chr(10)
					  Response.Write "</tr>"& Chr(10)
					Response.Write "</table>" & Chr(10)
						Response.Write "</fieldset>"
		
				End IF
			Rs.Close
			Set Rs = Nothing

End Function

Function Carrega_Medico

	SQL	=	"SELECT Funcionarios.nome, HomeCare_Atendimento_Medicos.id_Funcionario, Cargos.Cargo, Departamentos.descricao AS Departamento " &_ 
			"FROM HomeCare_Atendimento_Medicos INNER JOIN " &_ 
			"Funcionarios ON HomeCare_Atendimento_Medicos.id_Funcionario = Funcionarios.id INNER JOIN " &_ 
			"Cargos ON Funcionarios.id_cargo = Cargos.id INNER JOIN " &_ 
			"Departamentos ON Funcionarios.id_departamento = Departamentos.id "&_ 
			"Where HomeCare_Atendimento_Medicos.id_Atendimento  = '"&Request("id_Atendimento")&"' AND HomeCare_Atendimento_Medicos.id_Funcionario_Status = 1 "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
					Response.Write "<input name='id_Funcionario_Medico' type='hidden' value='"&Rs("id_Funcionario")&"'>"
					Response.Write "<input name='Medico_Nome' type='hidden' value='"&Rs("Nome")&"'>"
					Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'> " 
					  Response.Write "<tr class='zebra_orange1'>  " 
						Response.Write "<td width='6%' class='texto'><strong>Nome:</strong></td> " 
						Response.Write "<td width='30%' class='texto'>"&Rs("Nome")&"</td> " 
						Response.Write "<td width='13%' class='texto'><strong>Departamento:</strong></td> " 
						Response.Write "<td width='25%' class='texto'>"&Rs("Departamento")&"</td> " 
						Response.Write "<td width='6%' class='texto'><strong>Cargo:</strong></td> " 
						Response.Write "<td width='20%' class='texto'>"&Rs("Cargo")&"</td> " 
					  Response.Write "</tr> " 
					Response.Write "</table> " 
				Else
					Response.Write "O atendimento nº "&Request("id_Atendimento")&" esta médico responsavel. "
					Response.end
				End if
	
End Function

'Função que carrega todos os Sinais Vitais do paciente
Function Carrega_SinaisVitais(id_Atendimento)

	SQL =	"SELECT id_Atendimento, PressaoArterial, FreqCardiaca, Temperatura, FreqRespiratoria, Urina, Evacuacao, Data_Evolucao " &_ 
			"FROM HomeCare_Atendimento_Paciente_Evolucao " &_ 
			"WHERE id_Atendimento = '"&Cint(id_Atendimento)&"' " &_
			"ORDER BY Data_Evolucao "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='14%' valign='top'><b>P.A:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>F.C:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='13%' valign='top'><b>T.:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>F.R:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='18%' valign='top'><b>Diurese:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='16%' valign='top'><b>Evac.:</b></td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'><b>Data:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"" >" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("PressaoArterial"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("FreqCardiaca"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Temperatura"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("FreqRespiratoria"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Urina"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Evacuacao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Data_Evolucao"))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
				Else
					Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Não foram encontrados sinais vitais</b></TD></TR></Table>"
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todos os CID10 do  atendimento
Function Carrega_CID10_Itens(id_Atendimento)

	SQL =	"SELECT dbo.HomeCare_Atendimento_Diagnostico.id, dbo.HomeCare_Atendimento_Diagnostico.CID10, dbo.Diagnostico.Descricao, " &_ 
            "dbo.HomeCare_Atendimento_Diagnostico.Data_Cadastro " &_ 
			"FROM  dbo.HomeCare_Atendimento_Diagnostico INNER JOIN " &_ 
			"dbo.Diagnostico ON dbo.HomeCare_Atendimento_Diagnostico.CID10 = dbo.Diagnostico.CID10 " &_ 
			"WHERE (dbo.HomeCare_Atendimento_Diagnostico.id_Atendimento = '"&Cint(id_Atendimento)&"') " &_ 
			"ORDER BY dbo.HomeCare_Atendimento_Diagnostico.Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>CID10:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='62%' valign='top'><b>Diagnostico:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='13%' valign='top'><b>Data:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"" >" & CHR(10)
							Response.Write "<td class='texto' valign='top' align='center'>"&Trim(Rs("CID10"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
				Else
					Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Não foi encontrado diagnostico(s) no atendimento</b></TD></TR></Table>"
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todas as prescrições medicas que tem no atendimento
Function Carrega_Prescricao_Medica_Itens(id_Atendimento)

	SQL =	"SELECT HomeCare_Prescricao_Prioridade.Descricao AS Prescricao_Prioridade, HomeCare_Atendimento_Prescricao_Medica.*, " &_ 
			"HomeCare_Atendimento_Prescricao_Medica_Suspensa.id AS id_Prescricao_Medica_Suspensa,  " &_ 
			"HomeCare_Atendimento_Prescricao_Medica_Suspensa.Data AS Data_Suspensa, " &_ 
			"(SELECT COUNT(id_Prescricao_Medica) " &_ 
			"FROM HomeCare_Atendimento_Prescricao_Medica_Manter " &_ 
			"WHERE id_Prescricao_Medica = HomeCare_Atendimento_Prescricao_Medica.id) AS Total_Prescricao_Mantida, " &_ 
			"HomeCare_Prescricao_Tipo.Descricao AS Prescricao_Tipo, Periodicidade.Descricao AS Periodicidade, Intervalo.Descricao AS Intervalo,  " &_ 
			"HomeCare_Via_Administracao.Descricao AS Via_Administracao, HomeCare_Atendimento_Prescricao_Medica.Dose AS Dose " &_ 
			"FROM HomeCare_Atendimento_Prescricao_Medica INNER JOIN " &_ 
			"HomeCare_Prescricao_Prioridade ON HomeCare_Atendimento_Prescricao_Medica.id_Prioridade = HomeCare_Prescricao_Prioridade.id INNER JOIN " &_ 
			"Periodicidade ON HomeCare_Atendimento_Prescricao_Medica.id_Periodicidade = Periodicidade.id INNER JOIN " &_ 
			"Intervalo ON HomeCare_Atendimento_Prescricao_Medica.id_Intervalo = Intervalo.id INNER JOIN " &_ 
			"HomeCare_Via_Administracao ON  " &_ 
			"HomeCare_Atendimento_Prescricao_Medica.id_Via_Administracao = HomeCare_Via_Administracao.id LEFT OUTER JOIN " &_ 
			"HomeCare_Prescricao_Tipo ON HomeCare_Atendimento_Prescricao_Medica.id_Prescricao_Tipo = HomeCare_Prescricao_Tipo.id LEFT OUTER JOIN " &_ 
			"HomeCare_Atendimento_Prescricao_Medica_Suspensa ON  " &_ 
			"HomeCare_Atendimento_Prescricao_Medica.id = HomeCare_Atendimento_Prescricao_Medica_Suspensa.id_Prescricao_Medica " &_ 
			"WHERE (dbo.HomeCare_Atendimento_Prescricao_Medica.id_Atendimento = '"&id_Atendimento&"') " &_ 
			"Order By Data_Cadastro Desc "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='legenda' width='02%' valign='top'><b>Manter:</b></td>" & CHR(10)
							Response.Write "<td class='legenda' width='15%' valign='top'><b>Prescrição:</b></td>" & CHR(10)
							Response.Write "<td class='legenda' width='05%' valign='top'><b>Dose:</b></td>" & CHR(10)
							Response.Write "<td class='legenda' width='12%' valign='top'><b>Via Administração:</b></td>" & CHR(10)
							Response.Write "<td class='legenda' width='10%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td class='legenda' width='9%' valign='top'><b>Intervalo:</b></td>" & CHR(10)
							Response.Write "<td class='legenda' width='10%' valign='top'><b>Qtd Dias:</b></td>" & CHR(10)
							Response.Write "<td class='legenda' width='08%' valign='top'><b>Prioridade:</b></td>" & CHR(10)
							Response.Write "<td class='legenda' width='8%' valign='top'><b>Tipo:</b></td>" & CHR(10)
							Response.Write "<td class='legenda' width='08%' valign='top'><b>Suspender:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						IF IsNull(Rs("Data_Suspensa"))  Then
							'ATENCAO a variavel "checkbox_Mater_Prescricao" monta um checkbox e quando clica nesse checkbox ele transfere o id da prescricao para um campo hidden chamado de "id_prescricao_medica"
							checkbox_Mater_Prescricao =  "<input name='checkbox' type='checkbox' value='"&Trim(Rs("id"))&"' onClick=""if(mostrar_"&Rs("id")&".style.display=='block'){mostrar_"&Rs("id")&".style.display='none'; document.getElementById('id_prescricao_medica_"&rs("id")&"').value=''}else{mostrar_"&Rs("id")&".style.display='Block'; document.getElementById('id_prescricao_medica_"&rs("id")&"').value='"&rs("id")&"'};""     >"
							checkbox_Suspender_Prescricao = "<input name='SuspenderPrescricao' type='checkbox' id='SuspenderPrescricao' value='"&Trim(Rs("id"))&"'>"
							Else
							checkbox_Mater_Prescricao = "<img src='/SmartCare/images/ico_cadeado.gif' border='0' alt='Prescrição suspensa'>"
							checkbox_Suspender_Prescricao =  "<img src='/SmartCare/images/ico_cadeado.gif' border='0' alt='Prescrição suspensa'>"
						End if
						  Periodicidade = Rs("Periodicidade") : Qdt_Dias = Rs("Qdt_Dias") : id_Prioridade = Rs("id_Prioridade") : id_Via_Administracao = Rs("id_Via_Administracao")
						  'Este campo hidden abaixo recebe o id da prescricao que é transferido via javascript oa clicar no checkbox para manter a mesma prescricao
						  Response.Write "<input type='hidden' name='id_prescricao_medica'  id='id_prescricao_medica_"&Trim(Rs("id"))&"' value=''>"
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"">" & CHR(10)
							Response.Write "<td class='legenda' valign='top' align='center'>"&checkbox_Mater_Prescricao&"</td>" & CHR(10)
							Response.Write "<td class='legenda' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='legenda' valign='top'>"&Trim(Rs("Dose"))&"</td>" & CHR(10)
							Response.Write "<td class='legenda' valign='top'>"&Trim(Rs("Via_Administracao"))&"</td>" & CHR(10)
							Response.Write "<td class='legenda' valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td class='legenda' valign='top'>"&Trim(Rs("Intervalo"))&"</td>" & CHR(10)
							Response.Write "<td class='legenda' valign='top'>"&Trim(Rs("Qdt_Dias"))&"</td>" & CHR(10)
							Response.Write "<td class='legenda' valign='top'>"&Trim(Rs("Prescricao_Prioridade"))&"</td>" & CHR(10)
							Response.Write "<td class='legenda' valign='top'>"&Trim(Rs("Prescricao_Tipo"))&"</td>" & CHR(10)
							Response.Write "<td class='legenda' valign='top' align='center'>"&checkbox_Suspender_Prescricao&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)

						SQL2 = "SELECT dbo.HomeCare_Atendimento_Prescricao_Medica_Manter.*, dbo.HomeCare_Prescricao_Prioridade.Descricao AS Prescricao_Prioridade, " &_ 
								"dbo.Periodicidade.Descricao AS Periodicidade, dbo.Intervalo.Descricao AS Intervalo,  " &_ 
								"dbo.HomeCare_Via_Administracao.Descricao AS Via_Administracao " &_ 
								"FROM dbo.HomeCare_Atendimento_Prescricao_Medica_Manter INNER JOIN " &_ 
								"dbo.HomeCare_Prescricao_Prioridade ON  " &_ 
								"dbo.HomeCare_Atendimento_Prescricao_Medica_Manter.id_Prioridade = dbo.HomeCare_Prescricao_Prioridade.id INNER JOIN " &_ 
								"dbo.Periodicidade ON dbo.HomeCare_Atendimento_Prescricao_Medica_Manter.id_Periodicidade = dbo.Periodicidade.id INNER JOIN " &_ 
								"dbo.Intervalo ON dbo.HomeCare_Atendimento_Prescricao_Medica_Manter.id_Intervalo = dbo.Intervalo.id INNER JOIN " &_ 
								"dbo.HomeCare_Via_Administracao ON  " &_ 
								"dbo.HomeCare_Atendimento_Prescricao_Medica_Manter.id_Via_Administracao = dbo.HomeCare_Via_Administracao.id " &_ 								
								"Where id_Prescricao_Medica = '"&Rs("id")&"' "
								Set rs2 = server.createobject("adodb.recordset")
								Rs2.open SQL2, CONN, 3
						IF not rs2.eof then 'Verifica se existem registros
							For y = 1 To Rs2.RecordCount
								If Rs2.Eof Then Exit for
								  id_Periodicidade = Rs2("id_Periodicidade") : id_Intervalo = Rs2("id_Intervalo") : Qdt_Dias = Rs2("Qdt_Dias") : id_Prioridade = Rs2("id_Prioridade") : Prescricao_Prioridade = Rs2("Prescricao_Prioridade") : Dose = Rs2("Dose") : id_Via_Administracao = Rs2("id_Via_Administracao")
						
								  Response.Write "<tr class='zebra_orange2'>" & CHR(10)
									Response.Write "<td class='legenda' valign='top' align='center'>&nbsp;</td>" & CHR(10)
									Response.Write "<td class='legenda' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
									Response.Write "<td class='legenda' valign='top'>"&Trim(Rs2("Dose"))&"</td>" & CHR(10)
									Response.Write "<td class='legenda' valign='top'>"&Trim(Rs2("Via_Administracao"))&"</td>" & CHR(10)
									Response.Write "<td class='legenda' valign='top'>"&Trim(Rs2("Periodicidade"))&"</td>" & CHR(10)
									Response.Write "<td class='legenda' valign='top'>"&Trim(Rs2("Intervalo"))&"</td>" & CHR(10)
									Response.Write "<td class='legenda' valign='top'>"&Trim(Rs2("Qdt_Dias"))&"</td>" & CHR(10)
									Response.Write "<td class='legenda' valign='top' >"&Trim(Prescricao_Prioridade)&"</td>" & CHR(10)
									Response.Write "<td class='legenda' valign='top' colspan='4'>"&Trim(ArrumaDataHora(Rs2("Data")))&"</td>" & CHR(10)
								  Response.Write "</tr>" & CHR(10)
							Rs2.MoveNext
							Next
						Else
							id_Periodicidade = Rs("id_Periodicidade") : id_Intervalo = Rs("id_Intervalo") : Qdt_Dias = Rs("Qdt_Dias") : id_Prioridade = Rs("id_Prioridade") : Prescricao_Prioridade = Rs("Prescricao_Prioridade") : Dose = Rs("Dose") : id_Via_Administracao = Rs("id_Via_Administracao")
						End if
						  'nesta tr colocamos um id e um style para quando o for clicado em manter a prescricao aparecer esse bloco
						  Response.Write "<tr class='zebra_orange2' id='mostrar_"&Rs("id")&"' style='display: none;'>" & CHR(10)
							Response.Write "<td class='legenda' valign='top' align='center'>&nbsp;</td>" & CHR(10)
							Response.Write "<td class='legenda' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='legenda' valign='top'><input class=campos name=Prescricao_Medica_Dose_Manter id=Prescricao_Medica_Dose_Manter value='"&Dose&"' type=text size=05 maxlength=50></td>" & CHR(10)
							Response.Write "<td class='legenda' valign='top'>"&gerar_listbox_Automatico("HomeCare_Via_Administracao","","id","id_Via_Administracao_Manter","Descricao","",id_Via_Administracao)&"</td>" & CHR(10)
							Response.Write "<td class='legenda' valign='top'>"&gerar_listbox_Automatico("Periodicidade","","id","id_Periodicidade_Manter","Descricao","",id_Periodicidade)&"</td>" & CHR(10)
							Response.Write "<td class='legenda' valign='top'>"&gerar_listbox_Automatico("Intervalo","","id","id_Intervalo_Manter","Descricao","",id_Intervalo)&"</td>" & CHR(10)
							Response.Write "<td class='legenda' valign='top'>"&"<input class='campos' name='Qdt_Dias' type='text' id='Qdt_Dias' value='"&Trim(Qdt_Dias)&"' size='8'>"&"</td>" & CHR(10)
							Response.Write "<td class='legenda' valign='top' colspan='5'>"&gerar_listbox_Automatico("HomeCare_Prescricao_Prioridade","","id","id_Prescricao_Prioridade_Manter","Descricao","",id_Prioridade)&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)	
		
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)

					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Não foram encontrado prescrições(s) no atendimento</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todos os Exames envolvidos no atendimento
Function Carrega_Lista_Exames(id_Atendimento)

	SQL = 	"SELECT HomeCare_Atendimento_Exames.id, HomeCare_Atendimento_Exames.id_Exames, Exames.tit_exame, " &_ 
			"HomeCare_Atendimento_Exames.Data_Realizacao_Exame, HomeCare_Atendimento_Exames.Data_Cadastro, Fornecedores.Fornecedor, " &_ 
			"HomeCare_Atendimento_Exames.id_Atendimento " &_ 
			"FROM Exames INNER JOIN " &_ 
			"HomeCare_Atendimento_Exames ON Exames.id = HomeCare_Atendimento_Exames.id_Exames LEFT OUTER JOIN " &_ 
			"Fornecedores ON HomeCare_Atendimento_Exames.id_Fornecedor = Fornecedores.id " &_ 
			"WHERE (HomeCare_Atendimento_Exames.id_Atendimento = '"&id_Atendimento&"') " &_ 
			"ORDER BY HomeCare_Atendimento_Exames.Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='4%' valign='top'><b>Código:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='41%' valign='top'><b>Exame:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='18%' valign='top'><b>Data Cadastro:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='18%' valign='top'><b>Data Realização:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='19%' valign='top'><b>Laboratório:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						IF Trim(ArrumaDataHora(Rs("Data_Realizacao_Exame"))) = "" Then Data_Realizacao_Exame = "Aguardando aprovação" Else Data_Realizacao_Exame = Trim(ArrumaDataHora(Rs("Data_Realizacao_Exame"))) End if
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.bAackgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"">" & CHR(10)
							Response.Write "<td valign='top'>"&Trim(Rs("id"))&"</td>" & CHR(10)
							Response.Write "<td valign='top'>"&Trim(Rs("Tit_Exame"))&"</td>" & CHR(10)
							Response.Write "<td valign='top'>"&Trim(ArrumaDataHora(Rs("Data_Cadastro")))&"</td>" & CHR(10)
							Response.Write "<td valign='top'>"&Data_Realizacao_Exame&"</td>" & CHR(10)
							Response.Write "<td valign='top'>"&Rs("Fornecedor")&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Nenhum exame encontrado</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function


'Função resposavel por inserir a solicitação
Function IncluirEvolucao

	'Faz o insert do atendimento
	SQL = 	"INSERT INTO HomeCare_Atendimento_Paciente_Evolucao (id_Atendimento,id_Funcionario,Texto,PressaoArterial,FreqCardiaca,Temperatura,FreqRespiratoria,Urina,Evacuacao,Data_Evolucao) VALUES ( '"&Cint(Request("id_Atendimento"))&"' , '"&Cint(Request("id_Funcionario_Medico"))&"' , '"&Replace(Request("Texto"),"'","''")&"', '"&Replace(Request("PressaoArterial"),"'","''")&"' , '"&Replace(Request("FreqCardiaca"),"'","''")&"' , '"&Replace(Request("Temperatura"),"'","''")&"' , '"&Replace(Request("FreqRespiratoria"),"'","''")&"' , '"&Replace(Request("Urina"),"'","''")&"' , '"&Replace(Request("Evacuacao"),"'","''")&"' , '"&Request("Data_Evolucao")&"' ) "
			'Response.Write SQL : Response.end
			On Error Resume Next 'Inicia o Tratamento de erro
				Conn.BeginTrans  'Inicia a Transação
				Conn.execute(SQL) 'Executa a Query
				id_Transacao = Conn.execute("SELECT @@IDENTITY")(0).Value
				Call Grava_Cid10(Cint(Request("id_Atendimento")),id_Transacao) 'Chama a funçao que ira inserir as prescrições medicas. Já é passa o do ID do atendimento
				Call Grava_Prescricao_Medica(Cint(Request("id_Atendimento")),id_Transacao) 'Chama a funçao que ira inserir as prescrições medicas. Já é passa o do ID do atendimento
				Call Grava_Prescricao_Manter(id_Transacao) 'Chama a funçao que ira inserir as prescrições que o medico quer me mantem. Já é passa o do ID do atendimento
				Call SuspenderPrescricao(id_Transacao)
				Call Grava_Exames(Cint(Request("id_Atendimento")),id_Transacao) 'Chama a funçao que ira inserir os exames. Já é passa o do ID do atendimento
			If Err <> 0 Then 'Verifica se ocorreu algum erro
				Conn.RollbackTrans 'Se foi detectado algum erro entao a Transação é desfeita e nao é inserido nenhum registro
				Response.Write "Foi detectado um erro e a ação foi cancelada: " & Err.Description
				Response.End
				Else
					Conn.CommitTrans 'Caso não tenha ocorrido nenhum erro entao a transação é efeutuado com sucesso
					Call Dispara_Email_Evolucao_Paciente(id_Transacao) 'Dispara um email avisando sobre a evolucao do paciente
					response.write "<script>location = 'default.asp' </script>"
			End If

End Function


'Função que insere os CID10, Diagnosticos.
'Recebe o ID da trasação que esta sendo inserida o atendimento
Function Grava_Cid10(id_Atendimento,id_Transacao)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("CID10").Count

		'Verifica se o campo esta vazio
		If Request.Form("CID10")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Atendimento_Diagnostico (id_Atendimento,id_Funcionario,id_Evolucao,CID10) VALUES ( '"&id_Atendimento&"' , '"&Cint(Request("id_Funcionario_Medico"))&"' , '"&id_Transacao&"' , '"&TiraAspas(Request("CID10")(x))&"'  ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função que insere as Prescrições Medicas.
'Recebe o ID da trasação que esta sendo inserida o atendimento
Function Grava_Prescricao_Medica(id_Atendimento,id_Transacao)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Prescricao_Medica_Descricao").Count

		'Verifica se o campo esta vazio
		If Request.Form("Prescricao_Medica_Descricao")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Atendimento_Prescricao_Medica (id_Atendimento,id_Funcionario,id_Periodicidade,id_Intervalo,id_Prescricao_Tipo,id_Prioridade,id_Evolucao,Descricao,Qdt_Dias,Dose,id_Via_Administracao) VALUES ( '"&id_Atendimento&"' , '"&Cint(Request("id_Funcionario_Medico"))&"' , '"&Request("id_Periodicidade")(x)&"' , '"&Request("id_Intervalo")(x)&"' , '"&TiraAspas(Request("id_Prescricao_Tipo")(x))&"' , '"&TiraAspas(Request("id_Prescricao_Prioridade")(x))&"' , '"&id_Transacao&"' , '"&TiraAspas(Request("Prescricao_Medica_Descricao")(x))&"' , '"&TiraAspas(Request("Prescricao_Medica_Qtd_Dias")(x))&"' , '"&TiraAspas(Request("Prescricao_Medica_Dose")(x))&"' , '"&Request("id_Via_Administracao")(x)&"' ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next
	
End Function

'Função que grava as prescrições que foram mantidas
'Recebe o ID da trasação que esta sendo inserida o atendimento
Function Grava_Prescricao_Manter(id_Transacao)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("id_Prescricao_Medica").Count
		'Verifica se o campo esta vazio
		If Request.Form("id_Prescricao_Medica")(x) <> "" Then

			SQL = 	"INSERT INTO HomeCare_Atendimento_Prescricao_Medica_Manter (id_Prescricao_Medica,id_Funcionario,id_Periodicidade,id_Intervalo,id_Evolucao,id_Prioridade,Qdt_Dias,Dose,id_Via_Administracao) VALUES ( '"&Cint(Request("id_Prescricao_Medica")(x))&"' , '"&Cint(Request("id_Funcionario_Medico"))&"' , '"&Cint(Request("id_Periodicidade_Manter")(x))&"' , '"&Cint(Request("id_Intervalo_Manter")(x))&"' , '"&Cint(id_Transacao)&"' , '"&Cint(Request("id_Prescricao_Prioridade_Manter")(x))&"' , '"&TiraAspas(Request("Qdt_Dias")(x))&"' , '"&TiraAspas(Request("Prescricao_Medica_Dose_Manter")(x))&"' , '"&Cint(Request("id_Via_Administracao_Manter")(x))&"'  ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

Function SuspenderPrescricao(id_Transacao)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("SuspenderPrescricao").Count

		'Verifica se o campo esta vazio
		If Request.Form("SuspenderPrescricao")(x) <> "" Then
	
			SQL = 	"INSERT INTO HomeCare_Atendimento_Prescricao_Medica_Suspensa (id_Prescricao_Medica,id_Evolucao,id_Funcionario) VALUES ( '"&Request("SuspenderPrescricao")(x)&"' , '"&id_Transacao&"' , '"&Cint(Request("id_Funcionario_Medico"))&"' ) "
					Conn.execute(SQL) 'Executa a Query
	
		End IF
	Next

End Function

'Função que insere os Exames.
Function Grava_Exames(id_Atendimento,id_Transacao)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Cod_Exame").Count

		'Verifica se o campo esta vazio
		If Request.Form("Cod_Exame")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Atendimento_Exames (id_Atendimento,id_Funcionario,id_Exames,id_Evolucao) VALUES ( '"&id_Atendimento&"' , '"&Cint(Request("id_Funcionario_Medico"))&"' , '"&TiraAspas(Request("Cod_Exame")(x))&"' ,  '"&id_Transacao&"'   ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Form_Incluir_Atendimento"
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Prontuario_Medico/Formulario_Evolucao/modelos/Form_Incluir_Evolucao.htm" -->
<%
	Case "IncluirEvolucao"
		Call IncluirEvolucao
		
	Case Else
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Prontuario_Medico/Formulario_Evolucao/modelos/Form_Visualizar.htm" -->
<%

End Select

'[Fecha Conexão Com Banco De Dados]
Conn.close
set Conn = nothing
%>
