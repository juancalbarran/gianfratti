<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 28/09/2005
' Descrição: Pagina de Preenchimento de formulario de Admissão
' Atualizado por: -
' Data: -
' Atualização: -
%>
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim Nome_Funcionario,Nome_Departamento,Cargo,Data_Evolucao,Data_Cadastro_Atendimento,Data_Fechamento_Atendimento
'[CONEXÃO COM O BANCO DE DADOS]
set Conn = Server.CreateObject( "ADODB.Connection" )
Conn.CursorLocation = 3 'adUserClient
Conn.Open application("connstring")

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

'Função que carrega todos os medicamentos que o paciente esta usando
Function Lista_Medicamentos_Em_Uso(id_Atendimento)

	SQL	=	"SELECT dbo.View_Prescricao.*, dbo.HomeCare_Prescricao_Prioridade.Descricao AS Prescricao_Prioridade, dbo.Periodicidade.Descricao AS Periodicidade, "&_ 
			"dbo.Intervalo.Descricao AS Intervalo, dbo.HomeCare_Via_Administracao.Descricao AS Via_Administracao,  "&_ 
			"dbo.Funcionarios.nome AS Funcionario_Nome "&_ 
			"FROM dbo.HomeCare_Atendimento_Prescricao_Medica INNER JOIN "&_ 
			"dbo.View_Prescricao ON dbo.HomeCare_Atendimento_Prescricao_Medica.id = dbo.View_Prescricao.id INNER JOIN "&_ 
			"dbo.HomeCare_Prescricao_Prioridade ON dbo.View_Prescricao.id_prioridade = dbo.HomeCare_Prescricao_Prioridade.id INNER JOIN "&_ 
			"dbo.Periodicidade ON dbo.View_Prescricao.id_Periodicidade = dbo.Periodicidade.id INNER JOIN "&_ 
			"dbo.Intervalo ON dbo.View_Prescricao.id_Intervalo = dbo.Intervalo.id INNER JOIN "&_ 
			"dbo.HomeCare_Via_Administracao ON dbo.View_Prescricao.id_Via_Administracao = dbo.HomeCare_Via_Administracao.id INNER JOIN "&_ 
			"dbo.Funcionarios ON dbo.HomeCare_Atendimento_Prescricao_Medica.Id_Funcionario = dbo.Funcionarios.id "&_ 
			"WHERE  (dbo.HomeCare_Atendimento_Prescricao_Medica.id_Atendimento = '"&id_Atendimento&"') AND (NOT EXISTS " &_ 
			"(SELECT  id_Prescricao_Medica FROM HomeCare_Atendimento_Prescricao_Medica_Suspensa WHERE id_Prescricao_Medica = View_Prescricao.id)) " &_ 
			"Order by View_Prescricao.Data_Cadastro Desc "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Prescrição:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Dose:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Via Adm.:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='12%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Intervalo:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='7%' valign='top'><b>Qtd Dias:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Prioridade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='13%' valign='top'><b>Médico:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						'If faz a verificacao para saber se a prescricao já foi vinculada a um medicamento. Caso na tabela de medicamento o campo de id_prescricao_Medica for diferente de vazio entao e colocado o icone do cadeado
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"">" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Dose"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Via_Administracao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Intervalo"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qdt_Dias"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Prescricao_Prioridade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Left(Rs("Funcionario_Nome"),15))&"</td>" & CHR(10)
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

'Função que carrega todos os Sinais Vitais do paciente
Function Lista_SinaisVitais(id_Atendimento)

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

'Função que carrega todos os medicamentos que foram suspensos pelo médico
Function Lista_Medicamentos_Suspensos(id_Atendimento)

	SQL	=	"SELECT dbo.View_Prescricao.*, dbo.HomeCare_Prescricao_Prioridade.Descricao AS Prescricao_Prioridade, " &_ 
			"dbo.Periodicidade.Descricao AS Periodicidade, dbo.Intervalo.Descricao AS Intervalo, "&_ 
			"dbo.HomeCare_Via_Administracao.Descricao AS Via_Administracao,  "&_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica_Suspensa.Data AS Data_Suspensa, dbo.Funcionarios.nome AS Funcionario_Nome "&_ 
			"FROM dbo.HomeCare_Atendimento_Paciente_Evolucao INNER JOIN "&_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica ON  "&_ 
			"dbo.HomeCare_Atendimento_Paciente_Evolucao.id = dbo.HomeCare_Atendimento_Prescricao_Medica.id_Evolucao INNER JOIN "&_ 
			"dbo.View_Prescricao ON dbo.HomeCare_Atendimento_Prescricao_Medica.id = dbo.View_Prescricao.id INNER JOIN "&_ 
			"dbo.HomeCare_Prescricao_Prioridade ON dbo.View_Prescricao.id_prioridade = dbo.HomeCare_Prescricao_Prioridade.id INNER JOIN "&_ 
			"dbo.Periodicidade ON dbo.View_Prescricao.id_Periodicidade = dbo.Periodicidade.id INNER JOIN "&_ 
			"dbo.Intervalo ON dbo.View_Prescricao.id_Intervalo = dbo.Intervalo.id INNER JOIN "&_ 
			"dbo.HomeCare_Via_Administracao ON  "&_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica.id_Via_Administracao = dbo.HomeCare_Via_Administracao.id INNER JOIN "&_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica_Suspensa ON  "&_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica.id = dbo.HomeCare_Atendimento_Prescricao_Medica_Suspensa.id_Prescricao_Medica INNER JOIN "&_ 
			"dbo.Funcionarios ON dbo.HomeCare_Atendimento_Prescricao_Medica.Id_Funcionario = dbo.Funcionarios.id "&_ 
			"WHERE (dbo.HomeCare_Atendimento_Prescricao_Medica.id_Atendimento = '"&id_Atendimento&"') " &_ 
			"Order by Data_Suspensa Desc "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem regiAstros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						   Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							 Response.Write "<td width='12%' valign='top' class='texto'><b>Prescrição:</b></td>" & CHR(10)
							 Response.Write "<td width='7%' valign='top' class='texto'><b>Dose:</b></td>" & CHR(10)
							 Response.Write "<td width='10%' valign='top' class='texto'><b>Via Adm.::</b></td>" & CHR(10)
							 Response.Write "<td width='12%' valign='top' class='texto'><b>Periodicidade:</b></td>" & CHR(10)
							 Response.Write "<td width='10%' valign='top' class='texto'><b>Intervalo:</b></td>" & CHR(10)
							 Response.Write "<td width='07%' valign='top' class='texto'><b>Qtd Dias:</b></td>" & CHR(10)
							 Response.Write "<td width='10%' valign='top' class='texto'><b>Prioridade:</b></td>" & CHR(10)
							 Response.Write "<td width='13%' valign='top' class='texto'><b>Cadastro:</b></td>" & CHR(10)
							 Response.Write "<td width='13%' valign='top' class='texto'><b>Suspenso:</b></td>" & CHR(10)
							 Response.Write "<td width='13%' valign='top' class='texto'><b>Médico:</b></td>" & CHR(10)
						   Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"">" & CHR(10)  
							Response.Write "<td class='texto' valign='top'> "&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Dose"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Via_Administracao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Periodicidade"))&"&nbsp;</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Intervalo"))&"&nbsp;</td>" & CHR(10) 
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qdt_Dias"))&"&nbsp;</td>" & CHR(10) 
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Prescricao_Prioridade"))&"</td>" & CHR(10) 
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10) 
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Suspensa"))&"</td>" & CHR(10) 
							Response.Write "<td class='texto' valign='top'>"&Trim(Left(Rs("Funcionario_Nome"),15))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10) 
					Rs.MoveNext
					Next
						 Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR ><TD align='center' class=legenda><b>Não foi encontrado prescrições para esta evolução</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function


'Função que carrega todos os diagnosticos que o paciente tem, desde a entrada da solicitacao ate o presente momento
Function Lista_Diagnosticos(id_Atendimento)

	SQL	=	"SELECT * FROM View_Diagnosticos WHERE id_Atendimento = '"&id_Atendimento&"' ORDER BY Data_Cadastro DESC "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Tipo:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='30%' valign='top'><b>Médico:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>CRM:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='5%' valign='top'><b>CID10:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='30%' valign='top'><b>Descrição:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='20%' valign='top'><b>Data:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						IF Trim(Rs("Tipo")) = "1" Then Tipo = "Entrada" Else Tipo = "Atendimento" End If
						'If faz a verificacao para saber se a prescricao já foi vinculada a um medicamento. Caso na tabela de medicamento o campo de id_prescricao_Medica for diferente de vazio entao e colocado o icone do cadeado
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"">" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Tipo&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Medico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("CRM"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("CID10"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Data_Cadastro"))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Não foram encontrado disgnostico(s) no atendimento</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function


'Função que carrega todos os medicamentos que foram suspensos pelo médico
Function Lista_Exames(id_Atendimento)

	SQL = 	"SELECT HomeCare_Atendimento_Exames.id, HomeCare_Atendimento_Exames.id_Exames, Exames.tit_exame, " &_ 
			"HomeCare_Atendimento_Exames.Data_Realizacao_Exame, HomeCare_Atendimento_Exames.Data_Cadastro, Fornecedores.Fornecedor, " &_ 
			"HomeCare_Atendimento_Exames.id_Atendimento " &_ 
			"FROM Exames INNER JOIN " &_ 
			"HomeCare_Atendimento_Exames ON Exames.id = HomeCare_Atendimento_Exames.id_Exames LEFT OUTER JOIN " &_ 
			"Fornecedores ON HomeCare_Atendimento_Exames.id_Fornecedor = Fornecedores.id " &_ 
			"WHERE (HomeCare_Atendimento_Exames.id_Atendimento = '"&id_Atendimento&"') " &_ 
			"ORDER BY HomeCare_Atendimento_Exames.Data_Cadastro Desc "
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

'Função que carrega todos os documentos que foram capturaros
Function Lista_Documentos(id_Atendimento)

	SQL	=	"SELECT dbo.Documento.id, dbo.Documento.id_Paciente, dbo.Pacientes.nome, dbo.Documento.id_Atendimento, dbo.Documento.Data , dbo.Documento.SessionID " &_ 
			"FROM dbo.Documento INNER JOIN dbo.Pacientes ON dbo.Documento.id_Paciente = dbo.Pacientes.id "
			clausula = " WHERE  "
			if id_Atendimento <> "" Then
				sql = sql & clausula & " Documento.id_Atendimento = '"&Trim(Replace(Request("id_Atendimento"),"'","''"))&"'  "
				clausula = "and "
			end if
			sql = sql & "Order By Data Desc "

			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0' >"
							Response.Write "<Tr class='zebra_orange1'>" & Chr(10)
								Response.Write "<Td colspan='7' >"&Rs("Data")&"</Td>" & Chr(10)
							Response.Write "</Tr>" & Chr(10)

						Call MostraImg(Rs("id"),Rs("id_Paciente"),Rs("id_Atendimento"),Rs("SessionID"),Rs("Data"))
						Response.Write "</Table>" & Chr(10)						
					Rs.MoveNext
					Next
				Else 'Caso não seja encontrado nenhum registro
					Response.Write "<Table><tr><td class='erro' >Nenhum documento foi capturado</td></tr></Table>"
				End if
			Rs.Close
			Set Rs = Nothing
			Response.Write Lista_Documentos

End Function

'Função que mostra todos os textos da evolucao
Function Historico_Evolucao(id_Atendimento)

	SQL	=	"SELECT dbo.HomeCare_Atendimento_Paciente_Evolucao.*, dbo.Funcionarios.nome AS Nome_Funcionario, dbo.Cargos.Cargo, " &_ 
			"dbo.Departamentos.descricao AS Nome_Departamento " &_ 
			"FROM dbo.Cargos INNER JOIN " &_ 
			"dbo.Funcionarios ON dbo.Cargos.id = dbo.Funcionarios.id_cargo INNER JOIN " &_ 
			"dbo.HomeCare_Atendimento_Paciente_Evolucao ON dbo.Funcionarios.id = dbo.HomeCare_Atendimento_Paciente_Evolucao.id_Funcionario INNER JOIN " &_ 
			"dbo.Departamentos ON dbo.Funcionarios.id_departamento = dbo.Departamentos.id "  &_
			"WHERE dbo.HomeCare_Atendimento_Paciente_Evolucao.id_Atendimento = '"&Cint(id_Atendimento)&"' " &_ 
			"Order by Data_Evolucao Desc "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
					Response.Write "<fieldset>" & Chr(10)
					Response.Write "<legend style='font-size:12px'>&nbsp;Evolução Multidiciplinar&nbsp;"&ArrumaData(Rs("Data_Evolucao"))&" - "&Rs("Nome_Funcionario")&"</legend>" & Chr(10)
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0'>"
							  Response.Write "<tr > "& Chr(10)
								Response.Write "<td class='textoJust' valign='Top'>"&Replace(Rs("Texto"),Chr(10),"<br>")&"</td>" & Chr(10)
							  Response.Write "</tr>" & Chr(10)
					Response.Write "</table>" & Chr(10)
					Response.Write "</fieldset>"
					Response.Write "<br>"
				Rs.MoveNext
					Next
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Nenhuma evolução encontrada</b></TD></TR></Table>"
				End if

			Rs.Close
			Set Rs = Nothing

End function

'Função que carrega todas os diagnosticos que os profissionais fizeram, ou seja sexiste um id de evolucao
Function Carrega_CID10_Itens(id_Atendimento,id_Funcionario,id_Evolucao)

	SQL =	"SELECT dbo.HomeCare_Atendimento_Diagnostico.id, dbo.HomeCare_Atendimento_Diagnostico.CID10, dbo.Diagnostico.Descricao, " &_ 
            "dbo.HomeCare_Atendimento_Diagnostico.Data_Cadastro " &_ 
			"FROM  dbo.HomeCare_Atendimento_Diagnostico INNER JOIN " &_ 
			"dbo.Diagnostico ON dbo.HomeCare_Atendimento_Diagnostico.CID10 = dbo.Diagnostico.CID10 " &_ 
			"WHERE dbo.HomeCare_Atendimento_Diagnostico.id_Atendimento = '"&Cint(id_Atendimento)&"' AND HomeCare_Atendimento_Diagnostico.id_Funcionario = '"&id_Funcionario&"' And HomeCare_Atendimento_Diagnostico.id_Evolucao = '"&id_Evolucao&"' " &_ 
			"ORDER BY dbo.HomeCare_Atendimento_Diagnostico.Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
					Content = ""
						Content = Content & "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='testexx'>" & Chr(10) 
						   Content = Content & "<tr >" & CHR(10)
						   	 Content = Content & "<td colspan='8' width='15%' valign='top'><b>Diagnosticos:</b></td>" & CHR(10)
						   Content = Content & "</tr>" & CHR(10)
						Content = Content & "</table>" & CHR(10)
						Content = Content & "<div style='height:4px'><img width='0' height='0'></div>"
						Content = Content & "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda'>"
						  Content = Content & "<tr class='Titulo_Tabela'>" & CHR(10)
							Content = Content & "<td width='05%' valign='top'><b>CID10:</b></td>" & CHR(10)
							Content = Content & "<td width='59%' valign='top'><b>Diagnostico:</b></td>" & CHR(10)
							Content = Content & "<td width='13%' valign='top'><b>Data:</b></td>" & CHR(10)
						  Content = Content & "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						If zebrado = "zebra4" Then zebrado = "zebra5" Else zebrado = "zebra4" End If
						  Content = Content & "<tr>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("CID10"))&"</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Content = Content &"<td class='"&zebrado&"' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
						  Content = Content & "</tr>" & CHR(10)

					Rs.MoveNext
					Next
						Content = Content & "</table>" & CHR(10)
				Else
					'Content = Content & "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR ><TD align='center' class=legenda><b>Não foi encontrado diagnostico(s) para esta evolução</b></TD></TR></Table>"
				End If
				Carrega_CID10_Itens = Content
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todas os diagnosticos que os profissionais fizeram, ou seja sexiste um id de evolucao
Function Carrega_CID10_Itens_Urgencia(id_Atendimento)

	SQL	=	"SELECT dbo.HomeCare_Atendimento_Diagnostico.id, dbo.HomeCare_Atendimento_Diagnostico.CID10, dbo.Diagnostico.DESCRICAO, " &_ 
			"dbo.HomeCare_Atendimento_Diagnostico.Data_Cadastro, dbo.Funcionarios.nome " &_ 
			"FROM dbo.HomeCare_Atendimento_Diagnostico INNER JOIN " &_ 
			"dbo.Diagnostico ON dbo.HomeCare_Atendimento_Diagnostico.CID10 = dbo.Diagnostico.CID10 INNER JOIN " &_ 
			"dbo.Funcionarios ON dbo.HomeCare_Atendimento_Diagnostico.id_Funcionario = dbo.Funcionarios.id " &_ 
			"WHERE dbo.HomeCare_Atendimento_Diagnostico.id_Atendimento = '"&Cint(id_Atendimento)&"'  " &_ 
			"ORDER BY dbo.HomeCare_Atendimento_Diagnostico.Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Content = ""
						Content = Content & "<table width='100%'  border='0' cellspacing='0' cellpadding='0' class='borda'>"
						  Content = Content & "<tr class='Titulo_Tabela'>" & CHR(10)
							Content = Content & "<td width='05%' valign='top'><b>CID10:</b></td>" & CHR(10)
							Content = Content & "<td width='59%' valign='top'><b>Diagnostico:</b></td>" & CHR(10)
							Content = Content & "<td width='13%' valign='top'><b>Médico:</b></td>" & CHR(10)
							Content = Content & "<td width='13%' valign='top'><b>Data:</b></td>" & CHR(10)
						  Content = Content & "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						If zebrado = "zebra4" Then zebrado = "zebra5" Else zebrado = "zebra4" End If
						  Content = Content & "<tr class='zebra_orange1' >" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top' align='center'>"&Trim(Rs("CID10"))&"</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Nome"))&"</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
						  Content = Content & "</tr>" & CHR(10)

					Rs.MoveNext
					Next
						Content = Content & "</table>" & CHR(10)
				Else
					'Content = Content & "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Não foi encontrado diagnostico(s) no atendimento</b></TD></TR></Table>"
				End If
				Carrega_CID10_Itens_Urgencia = Content
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todas as prescrições que os profissionais fizeram, ou seja sexiste um id de evolucao
Function Carrega_Prescricao_Medica_Itens(id_Atendimento,id_Funcionario,id_Evolucao)

	SQL	=	"SELECT dbo.View_Prescricao.*, dbo.HomeCare_Prescricao_Prioridade.Descricao AS Prescricao_Prioridade, dbo.Periodicidade.Descricao AS Periodicidade, "&_ 
			"dbo.Intervalo.Descricao AS Intervalo, dbo.HomeCare_Via_Administracao.Descricao AS Via_Administracao,  " &_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica.Dose "&_ 
			"FROM dbo.HomeCare_Atendimento_Paciente_Evolucao INNER JOIN "&_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica ON "&_ 
			"dbo.HomeCare_Atendimento_Paciente_Evolucao.id = dbo.HomeCare_Atendimento_Prescricao_Medica.id_Evolucao INNER JOIN "&_ 
			"dbo.View_Prescricao ON dbo.HomeCare_Atendimento_Prescricao_Medica.id = dbo.View_Prescricao.id INNER JOIN "&_ 
			"dbo.HomeCare_Prescricao_Prioridade ON dbo.View_Prescricao.id_prioridade = dbo.HomeCare_Prescricao_Prioridade.id INNER JOIN "&_ 
			"dbo.Periodicidade ON dbo.View_Prescricao.id_Periodicidade = dbo.Periodicidade.id INNER JOIN "&_ 
			"dbo.Intervalo ON dbo.View_Prescricao.id_Intervalo = dbo.Intervalo.id INNER JOIN "&_ 
			"dbo.HomeCare_Via_Administracao ON  "&_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica.id_Via_Administracao = dbo.HomeCare_Via_Administracao.id "&_ 
			"WHERE (dbo.HomeCare_Atendimento_Prescricao_Medica.id_Atendimento = '"&id_Atendimento&"') AND (dbo.View_Prescricao.id_Funcionario = '"&id_Funcionario&"') AND (dbo.View_Prescricao.id_Evolucao = '"&id_Evolucao&"') "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Content = ""
						Content = Content & "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='testexx'>" & Chr(10) 
						   Content = Content & "<tr >" & CHR(10)
						   	 Content = Content & "<td colspan='8' width='15%' valign='top'><b>Novas Prescrições:</b></td>" & CHR(10)
						   Content = Content & "</tr>" & CHR(10)
						Content = Content & "</table>" & CHR(10)
						Content = Content & "<div style='height:4px'><img width='0' height='0'></div>"
						Content = Content & "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10) 
						   Content = Content & "<tr class='Titulo_Tabela'>" & CHR(10)
							 Content = Content & "<td width='15%' valign='top' class='textopq'><b>Prescrição:</b></td>" & CHR(10)
							 Content = Content & "<td width='10%' valign='top'><b>Dose:</b></td>" & CHR(10)
							 Content = Content & "<td width='10%' valign='top'><b>Via Adm.::</b></td>" & CHR(10)
							 Content = Content & "<td width='15%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							 Content = Content & "<td width='10%' valign='top'><b>Intervalo:</b></td>" & CHR(10)
							 Content = Content & "<td width='10%' valign='top'><b>Qtd Dias:</b></td>" & CHR(10)
							 Content = Content & "<td width='20%' valign='top'><b>Prioridade:</b></td>" & CHR(10)
							 Content = Content & "<td width='10%' valign='top'><b>Data:</b></td>" & CHR(10)
						   Content = Content & "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						If zebrado = "zebra4" Then zebrado = "zebra5" Else zebrado = "zebra4" End If
						  Content = Content & "<tr>" & CHR(10)  
							Content = Content & "<td class='"&zebrado&"' valign='top'> "&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Dose"))&"</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Via_Administracao"))&"</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Periodicidade"))&"&nbsp;</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Intervalo"))&"&nbsp;</td>" & CHR(10) 
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Qdt_Dias"))&"&nbsp;</td>" & CHR(10) 
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Prescricao_Prioridade"))&"</td>" & CHR(10) 
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10) 
						  Content = Content & "</tr>" & CHR(10) 
					Rs.MoveNext
					Next
						 Content = Content & "</table>" & CHR(10)
					Else
						'Content = Content & "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR ><TD align='center' class=legenda><b>Não foi encontrado prescrições para esta evolução</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing
			Carrega_Prescricao_Medica_Itens = Content

End Function

'Função responsavel por carregar as prescrições que foram suspensas.
Function Carrega_Prescricao_Medica_Suspensas(id_Atendimento,id_Funcionario,id_Evolucao)

	SQL	=	"SELECT dbo.View_Prescricao.*, dbo.HomeCare_Prescricao_Prioridade.Descricao AS Prescricao_Prioridade, dbo.Periodicidade.Descricao AS Periodicidade, "&_ 
			"dbo.Intervalo.Descricao AS Intervalo, dbo.HomeCare_Via_Administracao.Descricao AS Via_Administracao, "&_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica.Dose, dbo.HomeCare_Atendimento_Prescricao_Medica_Suspensa.Data AS Data_Suspensa "&_ 
			"FROM dbo.HomeCare_Atendimento_Paciente_Evolucao INNER JOIN "&_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica ON  "&_ 
			"dbo.HomeCare_Atendimento_Paciente_Evolucao.id = dbo.HomeCare_Atendimento_Prescricao_Medica.id_Evolucao INNER JOIN "&_ 
			"dbo.View_Prescricao ON dbo.HomeCare_Atendimento_Prescricao_Medica.id = dbo.View_Prescricao.id INNER JOIN "&_ 
			"dbo.HomeCare_Prescricao_Prioridade ON dbo.View_Prescricao.id_prioridade = dbo.HomeCare_Prescricao_Prioridade.id INNER JOIN "&_ 
			"dbo.Periodicidade ON dbo.View_Prescricao.id_Periodicidade = dbo.Periodicidade.id INNER JOIN "&_ 
			"dbo.Intervalo ON dbo.View_Prescricao.id_Intervalo = dbo.Intervalo.id INNER JOIN "&_ 
			"dbo.HomeCare_Via_Administracao ON  "&_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica.id_Via_Administracao = dbo.HomeCare_Via_Administracao.id INNER JOIN "&_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica_Suspensa ON  "&_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica.id = dbo.HomeCare_Atendimento_Prescricao_Medica_Suspensa.id_Prescricao_Medica "&_ 
			"WHERE (dbo.HomeCare_Atendimento_Prescricao_Medica_Suspensa.id_Evolucao = '"&id_Evolucao&"') AND  "&_ 
			"(dbo.HomeCare_Atendimento_Prescricao_Medica_Suspensa.id_Funcionario = '"&id_Funcionario&"') AND  "&_ 
			"(dbo.HomeCare_Atendimento_Prescricao_Medica.id_Atendimento = '"&id_Atendimento&"') "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Content = ""
						Content = Content & "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='testexx'>" & Chr(10) 
						   Content = Content & "<tr >" & CHR(10)
						   	 Content = Content & "<td colspan='8' width='15%' valign='top'><b>Prescrições Suspensas:</b></td>" & CHR(10)
						   Content = Content & "</tr>" & CHR(10)
						Content = Content & "</table>" & CHR(10)
						Content = Content & "<div style='height:4px'><img width='0' height='0'></div>"
						Content = Content & "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10) 
						   Content = Content & "<tr class='Titulo_Tabela'>" & CHR(10)
							 Content = Content & "<td width='15%' valign='top' class='textopq'><b>Prescrição:</b></td>" & CHR(10)
							 Content = Content & "<td width='10%' valign='top'><b>Dose:</b></td>" & CHR(10)
							 Content = Content & "<td width='10%' valign='top'><b>Via Adm.::</b></td>" & CHR(10)
							 Content = Content & "<td width='14%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							 Content = Content & "<td width='10%' valign='top'><b>Intervalo:</b></td>" & CHR(10)
							 Content = Content & "<td width='05%' valign='top'><b>Qtd Dias:</b></td>" & CHR(10)
							 Content = Content & "<td width='10%' valign='top'><b>Prioridade:</b></td>" & CHR(10)
							 Content = Content & "<td width='13%' valign='top'><b>Data Cadastro:</b></td>" & CHR(10)
							 Content = Content & "<td width='13%' valign='top'><b>Data Suspenso:</b></td>" & CHR(10)
						   Content = Content & "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						If zebrado = "zebra4" Then zebrado = "zebra5" Else zebrado = "zebra4" End If
						  Content = Content & "<tr>" & CHR(10)  
							Content = Content & "<td class='"&zebrado&"' valign='top'> "&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Dose"))&"</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Via_Administracao"))&"</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Periodicidade"))&"&nbsp;</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Intervalo"))&"&nbsp;</td>" & CHR(10) 
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Qdt_Dias"))&"&nbsp;</td>" & CHR(10) 
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Prescricao_Prioridade"))&"</td>" & CHR(10) 
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10) 
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&ArrumaDataHora(Rs("Data_Suspensa"))&"</td>" & CHR(10) 
						  Content = Content & "</tr>" & CHR(10) 
					Rs.MoveNext
					Next
						 Content = Content & "</table>" & CHR(10)
					Else
						'Content = Content & "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR ><TD align='center' class=legenda><b>Não foi encontrado prescrições para esta evolução</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing
			Carrega_Prescricao_Medica_Suspensas = Content

End Function

'Função que carrega todas as prescrições que foram adicionadas no atendimento, isto é, nao tem um ID de evolucao
Function Carrega_Prescricao_Medica_Itens_Urgencia(id_Atendimento)

	SQL = 	"SELECT dbo.HomeCare_Atendimento_Prescricao_Medica.*, dbo.Funcionarios.nome AS Nome_Funcionario, " &_ 
			"dbo.Cargos.Cargo AS Cargo " &_ 
			"FROM dbo.HomeCare_Atendimento_Prescricao_Medica INNER JOIN " &_ 
			"dbo.Funcionarios ON dbo.HomeCare_Atendimento_Prescricao_Medica.Id_Funcionario = dbo.Funcionarios.id INNER JOIN " &_ 
			"dbo.Cargos ON dbo.Funcionarios.id_cargo = dbo.Cargos.id " &_ 
			"WHERE     (dbo.HomeCare_Atendimento_Prescricao_Medica.id_Atendimento = '"&Cint(id_Atendimento)&"') AND (dbo.HomeCare_Atendimento_Prescricao_Medica.id_Evolucao IS NULL) " &_ 
			"ORDER BY dbo.HomeCare_Atendimento_Prescricao_Medica.Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						If zebrado = "zebra4" Then zebrado = "zebra5" Else zebrado = "zebra4" End If
						Content = Content &_
						"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10) &_ 
						   "<tr class='Titulo_Tabela'>" & CHR(10) &_
							 "<td width='36%' valign='top'><b>Prescrição:</b></td>" & CHR(10) &_
							 "<td width='25%' valign='top'><b>Periodicidade:</b></td>" & CHR(10) &_
							 "<td width='22%' valign='top'><b>Qtd Dias:</b></td>" & CHR(10) &_
							 "<td width='17%' valign='top'><b>Médico:</b></td>" & CHR(10) &_
							 "<td width='17%' valign='top'><b>Data:</b></td>" & CHR(10) &_
						   "</tr>" & CHR(10) &_
						  "<tr>" & CHR(10)  &_
							"<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Descricao"))&"&nbsp;</td>" & CHR(10) &_
							"<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Periodicidade"))&"&nbsp;</td>" & CHR(10) &_
							"<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Qdt_Dias"))&"&nbsp;</td>" & CHR(10) &_
							"<td class='"&zebrado&"' valign='top'>"&Rs("Nome_Funcionario")&"</td>" & CHR(10) &_
							"<td class='"&zebrado&"' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10) &_
						  "</tr>" & CHR(10) 
					Rs.MoveNext
					Next
						 Content = Content &_
						"</table>" & CHR(10) 
					Else
						' Content = Content & "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Nenhuma prescrição</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing
			Carrega_Prescricao_Medica_Itens_Urgencia = Content

End Function

'Função que carrega todas os exames que os profissionais fizeram, ou seja sexiste um id de evolucao
Function Carrega_Exames_Itens(id_Atendimento,id_Funcionario,id_Evolucao)

	SQL = 	"SELECT HomeCare_Atendimento_Exames.id, HomeCare_Atendimento_Exames.id_Exames, Exames.tit_exame, " &_ 
			"HomeCare_Atendimento_Exames.Data_Realizacao_Exame, HomeCare_Atendimento_Exames.Data_Cadastro, Fornecedores.Fornecedor, " &_ 
			"HomeCare_Atendimento_Exames.id_Atendimento " &_ 
			"FROM Exames INNER JOIN " &_ 
			"HomeCare_Atendimento_Exames ON Exames.id = HomeCare_Atendimento_Exames.id_Exames LEFT OUTER JOIN " &_ 
			"Fornecedores ON HomeCare_Atendimento_Exames.id_Fornecedor = Fornecedores.id " &_ 
			"WHERE dbo.HomeCare_Atendimento_Exames.id_Atendimento = '"&id_Atendimento&"' AND dbo.HomeCare_Atendimento_Exames.id_Funcionario = '"&id_Funcionario&"' And dbo.HomeCare_Atendimento_Exames.id_Evolucao = '"&id_Evolucao&"' " &_ 
			"Order by Data_Cadastro " 
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Content = ""
						Content = Content & "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='testexx'>" & Chr(10) 
						   Content = Content & "<tr >" & CHR(10)
						   	 Content = Content & "<td colspan='8' width='15%' valign='top'><b>Exames:</b></td>" & CHR(10)
						   Content = Content & "</tr>" & CHR(10)
						Content = Content & "</table>" & CHR(10)
						Content = Content & "<div style='height:4px'><img width='0' height='0'></div>"
						Content = Content & "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10) 
						   Content = Content & "<tr class='Titulo_Tabela'>" & CHR(10)
							 Content = Content & "<td width='36%' valign='top'><b>Código:</b></td>" & CHR(10)
							 Content = Content & "<td width='25%' valign='top'><b>Exame:</b></td>" & CHR(10)
							 Content = Content & "<td width='22%' valign='top'><b>Data Cadastro:</b></td>" & CHR(10)
							 Content = Content & "<td width='22%' valign='top'><b>Data Realização:</b></td>" & CHR(10)
							 Content = Content & "<td width='17%' valign='top'><b>Laboratório:</b></td>" & CHR(10)
						   Content = Content & "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						IF Trim(ArrumaDataHora(Rs("Data_Realizacao_Exame"))) = "" Then Data_Realizacao_Exame = "Aguardando aprovação" Else Data_Realizacao_Exame = Trim(ArrumaDataHora(Rs("Data_Realizacao_Exame"))) End if
						If zebrado = "zebra4" Then zebrado = "zebra5" Else zebrado = "zebra4" End If
						  Content = Content & "<tr>" & CHR(10)  
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("id_Exames"))&"</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Tit_Exame"))&"&nbsp;</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Data_Realizacao_Exame&"&nbsp;</td>" & CHR(10) 
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(ArrumaDataHora(Rs("Data_Cadastro")))&"</td>" & CHR(10) 
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Rs("Fornecedor")&"</td>" & CHR(10) 
						  Content = Content & "</tr>" & CHR(10) 
					Rs.MoveNext
					Next
						 Content = Content & "</table>" & CHR(10)
					Else
						'Content = Content & "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR ><TD align='center' class=legenda><b>Não foi encontrado exame para esta evolução</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing
			Carrega_Exames_Itens = Content

End Function

'Função por carregar os medicos do atendimento
Function Carrega_Funcionarios

	SQL	=	"SELECT dbo.FuncaoFuncionarioNome(id_Funcionario) AS Funcionario_Nome, id_Atendimento , id_Funcionario, COUNT(id) AS Total " &_ 
			"FROM dbo.View_Atendimento_Funcionarios "&_ 
			"WHERE (id_Atendimento = '"&Cint(Request("id_Atendimento"))&"') AND (Tipo_Profissional = 1) "&_ 
			"GROUP BY id_Atendimento, id_Funcionario, id_Atendimento "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
					Content = ""
					Content = Content & "<table width='100%' border='0' cellspacing='1' cellpadding='0'>" & CHR(10)
					Content = Content & "<tr class='zebra_orange1'> "& CHR(10)
					Content = Content & "<td width='90%'><strong>Médico(s):</strong></td>"& CHR(10)
					Content = Content & "<td width='10%'><strong>Evoluções:</strong></td>"& CHR(10)
					Content = Content &  "</tr>" & CHR(10)
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For
						  Content = Content & "<tr class='zebra_orange1'>" & CHR(10)  
							Content = Content & "<td valign='top' class='texto'>"&Rs("Funcionario_Nome")&"</td>" & CHR(10) 
							Content = Content & "<td align='center' class='texto' valign='top'>"&Rs("Total")&"</td>" & CHR(10) 
						  Content = Content & "</tr>" & CHR(10) 
					Rs.MoveNext
					Next
					Content = Content & "</table>" & CHR(10)
				End if
			Rs.Close
			Set Rs = Nothing
			Carrega_Funcionarios = Content
End Function

'Função resposavel por carregar todos os funcionarios envolvidos no atendimento
Function Carrega_Equipe

	SQL	=	"SELECT dbo.Funcionarios.nome, dbo.Cargos.Cargo,  " &_ 
            "dbo.HomeCare_Atendimento_Funcionario_Status.Descricao AS Funcionario_Status " &_ 
			"FROM dbo.View_Atendimento_Funcionarios INNER JOIN " &_ 
            "dbo.Funcionarios ON dbo.View_Atendimento_Funcionarios.id_Funcionario = dbo.Funcionarios.id INNER JOIN " &_ 
			"dbo.Cargos ON dbo.Funcionarios.id_cargo = dbo.Cargos.id INNER JOIN " &_ 
			"dbo.HomeCare_Atendimento_Funcionario_Status ON  " &_ 
			"dbo.View_Atendimento_Funcionarios.id_Funcionario_Status = dbo.HomeCare_Atendimento_Funcionario_Status.id " &_ 
			"WHERE (View_Atendimento_Funcionarios.id_Atendimento = '"&Request("id_Atendimento")&"') " &_ 
			"ORDER BY dbo.View_Atendimento_Funcionarios.Tipo_Profissional "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
					Content = ""
					Content = Content & "<table width='100%' border='0' cellspacing='1' cellpadding='0'>" & CHR(10)
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For
						  Content = Content & "<tr class='zebra_orange1'>" & CHR(10)  
							Content = Content & "<td class='texto' width='10%' valign='top'>"&Rs("Funcionario_Status")&"</td>" & CHR(10) 
							Content = Content & "<td class='texto' width='58%' valign='top'>"&Rs("Nome")&"</td>" & CHR(10) 
							Content = Content & "<td class='texto' width='42%' valign='top'>"&Rs("Cargo")&"</td>" & CHR(10) 
						  Content = Content & "</tr>" & CHR(10) 
					Rs.MoveNext
					Next
					Content = Content & "</table>" & CHR(10)
				End if
			Rs.Close
			Set Rs = Nothing
			Carrega_Equipe = Content

End Function
%>
<html>
	<head>
		<Meta http-equiv='Pragma' content='no-cache'>
		<Meta http-equiv=expires content='Thu, 01 Jan 1970 00:00:00 GMT'>
		<Meta http-equiv='Cache-Control' content='no-store'>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	</head>
<body>
<fieldset>
<legend align="center">&nbsp;Resumo do prontuário &nbsp;</legend>
<table width="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr valign="top"> 
    <td height="21"><table width="100%">
        <tr> 
          <td><%=Carrega_Dados_Cadastro_Pacientes(Request("id_Atendimento"))%></td>
        </tr>
      </table>
      <table width="100%">
        <tr> 
          <td valign="top">
<fieldset>
            <legend>&nbsp;Atendimento&nbsp;</legend>
            <table width="100%" border="0" cellspacing="1" cellpadding="0">
              <tr class='zebra_orange1'> 
                <td width="14%"><strong>N&ordm; Atendimento:</strong></td>
                <td width="20%"><%=Request("id_Atendimento")%></td>
                <td width="13%"><strong>Data admiss&atilde;o:</strong></td>
                <td width="21%"><%=ArrumaDataHora(Data_Cadastro_Atendimento)%></td>
                <td width="22%"><strong>Dias em Atendimento:</strong></td>
                <td width="10%"><%=TempoDecorrido(ArrumaDataHora(Data_Cadastro_Atendimento),ArrumaDataHora(Data_Fechamento_Atendimento))%></td>
              </tr>
            </table>
            </fieldset></td>
        </tr>
      </table>
      <fieldset>
      <legend>&nbsp;Médicos&nbsp;</legend>
      <table width="100%" border="0" cellspacing="1" cellpadding="0">
        <tr> 
          <td valign="top"><%=Carrega_Funcionarios%></td>
        </tr>
      </table>
      </fieldset>
      <BR style="font-size:5px;"> <fieldset>
      <legend>&nbsp;Equipe de Atendimento&nbsp;</legend>
      <table width="100%" border="0" cellspacing="1" cellpadding="0">
        <tr> 
          <td valign="top"><%=Carrega_Equipe%></td>
        </tr>
      </table>
      </fieldset>
      <BR style="font-size:5px;"> <fieldset>
      <legend>&nbsp;Formulário de Admissão Médica&nbsp;</legend>
      <table width="100%" border="0" cellspacing="1" cellpadding="0">
        <tr class='zebra_orange1'> 
          <td width="3%" valign="top"><a href="<%=Application("dominio")%>/Modulos/HomeCare/Prontuario_Medico/Formulario_Admissao/default.asp?action=MostraPDF&URL=<%=Application("dominio")%>/Modulos/HomeCare/Prontuario/Default.asp?id_Atendimento=<%=Request("id_Atendimento")%>-id_Formulario_Dinamico=1" target="_blank"><img src="/SmartCare/images/ico_pdf.gif" width="16" height="16" border="0"></a></td>
          <td width="97%" valign="top"> Anamnese</td>
        </tr>
        <tr class='zebra_orange1'> 
          <td valign="top"><a href="<%=Application("dominio")%>/Modulos/HomeCare/Prontuario_Medico/Formulario_Admissao/default.asp?action=MostraPDF&URL=<%=Application("dominio")%>/Modulos/HomeCare/Prontuario/Default.asp?id_Atendimento=<%=Request("id_Atendimento")%>-id_Formulario_Dinamico=2" target="_blank"><img src="/SmartCare/images/ico_pdf.gif" width="16" height="16" border="0"></a></td>
          <td valign="top">Exame F&iacute;sico Adulto</td>
        </tr>
      </table>
      </fieldset>
      <BR style="font-size:5px;">
      <fieldset>
      <legend>&nbsp;Médicamentos em uso&nbsp;</legend>
      <table width="100%" border="0" cellspacing="1" cellpadding="0">
        <tr> 
          <td valign="top" height="60"><%=Lista_Medicamentos_Em_Uso(Request("id_Atendimento"))%></td>
        </tr>
      </table>
      </fieldset>
      <BR style="font-size:5px;">
      <fieldset>
      <legend>&nbsp;Sinais vitais&nbsp;</legend>
      <table width="100%" border="0" cellspacing="1" cellpadding="0">
        <tr> 
          <td valign="top" height="20"><%=Lista_SinaisVitais(Request("id_Atendimento"))%></td>
        </tr>
      </table>
      </fieldset>
      <BR style="font-size:5px;">
      <fieldset>
      <legend>&nbsp;Médicamentos suspensos&nbsp;</legend>
      <table width="100%" border="0" cellspacing="1" cellpadding="0">
        <tr> 
          <td valign="top" height="20"><%=Lista_Medicamentos_Suspensos(Request("id_Atendimento"))%></td>
        </tr>
      </table>
      </fieldset>
       <BR style="font-size:5px;">
      <fieldset>
      <legend>&nbsp;Disgnosticos&nbsp;</legend>
      <table width="100%" border="0" cellspacing="1" cellpadding="0">
        <tr> 
          <td valign="top" height="15"><%=Lista_Diagnosticos(Request("id_Atendimento"))%>&nbsp;</td>
        </tr>
      </table>
      </fieldset>
	  <BR style="font-size:5px;">
      <fieldset>
      <legend>&nbsp;Exames&nbsp;</legend>
      <table width="100%" border="0" cellspacing="1" cellpadding="0">
        <tr> 
          <td valign="top" height="20"><%=Lista_Exames(Request("id_Atendimento"))%></td>
        </tr>
      </table>
      </fieldset>
      <BR style="font-size:5px;">
      <fieldset>
      <legend>&nbsp;Documentos Capturados&nbsp;</legend>
      <table width="100%" border="0" cellspacing="1" cellpadding="0">
        <tr> 
          <td valign="top" height="20"><%=Lista_Documentos(Request("id_Atendimento"))%></td>
        </tr>
      </table>
      </fieldset>
      <BR style="font-size:5px;"></td>
  </tr>
  <tr> 
    <td width="60%" valign="top"> 
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td><%=Historico_Evolucao(Request("id_Atendimento"))%></td>
        </tr>
		
      </table>
	  </td>
  </tr>
</table>
</fieldset>
</body>
</html>
