<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 01/09/2005
' Descrição: Pagina de visualizao para impressão do atendimento
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%

Dim Nome,Sexo,Data_Nascimento,Responsavel,Endereco,Cep,UF,Cidade,Bairro,Telefones,Cuidador,Particular,Convenio,RG,CPF,id_Paciente,Data_Cadastro_Paciente
Dim id,id_Atendimento,id_Solicitacao_Atendimento,Status_Descricao,Status_Descricao_Alta,Data_Cadastro,Data_Fechamento

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

Call Visualiza_Cadastro_Paciente 'Ja executa a função desta pagina para carregar os dados do paciente
Call Visualiza_Atendimento 'Ja executa a função desta pagina para carregar os dados do atendimento

Function Visualiza_Atendimento

	SQL	=	"SELECT dbo.HomeCare_Atendimento.id, dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento, " &_ 
			"dbo.HomeCare_Atendimento_Status.Descricao AS Status_Descricao,  " &_ 
			"dbo.HomeCare_Atendimento_Status_Condicoes_Alta.Descricao AS Status_Descricao_Alta, dbo.HomeCare_Atendimento.Data_Cadastro, " &_ 
			"dbo.HomeCare_Atendimento.Data_Fechamento " &_
			"FROM dbo.HomeCare_Atendimento INNER JOIN " &_ 
			"dbo.HomeCare_Atendimento_Status ON dbo.HomeCare_Atendimento.id_Atendimento_Status = dbo.HomeCare_Atendimento_Status.id INNER JOIN " &_ 
			"dbo.HomeCare_Atendimento_Status_Condicoes_Alta ON " &_ 
			"dbo.HomeCare_Atendimento.id_Atendimento_Status_Condicoes_Alta = dbo.HomeCare_Atendimento_Status_Condicoes_Alta.id " &_ 
			"WHERE dbo.HomeCare_Atendimento.id = '"&Cint(Request("id_Atendimento"))&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not rs.eof then 'Verifica se existem registros
					id_Atendimento = Rs("id")
					id_Solicitacao_Atendimento = Rs("id_Solicitacao_Atendimento")
					Status_Descricao = Rs("Status_Descricao")
					Status_Descricao_Alta = Rs("Status_Descricao_Alta")
					Data_Cadastro = ArrumaDataHora(Rs("Data_Cadastro"))
					Data_Fechamento = ArrumaDataHora(Rs("Data_Fechamento"))
				End if
			Rs.Close
			Set Rs = Nothing			
			
End Function

Function Visualiza_Cadastro_Paciente

	SQL	=	"SELECT dbo.Pacientes.nome, dbo.Pacientes.responsavel, dbo.Pacientes.endereco, dbo.Pacientes.cep, dbo.Pacientes.cidade, dbo.Pacientes.uf, " &_ 
			"dbo.Pacientes.bairro, dbo.Pacientes.sexo, dbo.Pacientes.telefones, dbo.Pacientes.cuidador, dbo.Pacientes.data_nascimento, " &_
			"dbo.Pacientes.data_cadastro AS Data_Cadastro_Paciente, dbo.Pacientes.RG, dbo.Pacientes.CPF, dbo.Convenios.Convenio, dbo.Pacientes.particular, " &_
			"dbo.Pacientes.id AS id_Paciente " &_
			"FROM dbo.Pacientes INNER JOIN " &_
			"dbo.Convenios ON dbo.Pacientes.id_convenio = dbo.Convenios.id INNER JOIN " &_ 
			"dbo.HomeCare_Solicitacao_Atendimento ON dbo.Pacientes.id = dbo.HomeCare_Solicitacao_Atendimento.id_Paciente INNER JOIN " &_
			"dbo.HomeCare_Atendimento ON dbo.HomeCare_Solicitacao_Atendimento.id = dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento " &_
			"WHERE  (dbo.HomeCare_Atendimento.id = '"&Cint(Request("id_Atendimento"))&"') " 
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not rs.eof then 'Verifica se existem registros

					Nome = Trim(Rs("Nome"))
					Sexo = Trim(Rs("Sexo"))
					Data_Nascimento = Trim(ArrumaData(Rs("Data_Nascimento")))
					Responsavel = Trim(Rs("Responsavel"))
					Endereco = Trim(Rs("Endereco"))
					Cep = Trim(Rs("Cep"))
					UF = Trim(Rs("UF"))
					Cidade = Trim(Rs("Cidade"))
					Bairro = Trim(Rs("Bairro"))
					Telefones = Trim(Rs("Telefones"))
					Cuidador = Trim(Rs("Cuidador"))
					If Rs("Particular") Then Particular = "Pessoa Fisica" Else Particular = "Pessoa Juridica" End if
					Convenio = Trim(Rs("Convenio"))
					RG = Trim(Rs("RG"))
					CPF = Trim(Rs("CPF"))
					id_Paciente = Trim(Rs("id_Paciente"))
					Data_Cadastro_Paciente = ArrumaDataHora(Rs("Data_Cadastro_Paciente"))

				End IF
			Rs.Close
			Set Rs = Nothing

End Function

Function Carrega_CID10_Entrada(id_Solicitcao_Atendimento)

	SQL = 	"SELECT dbo.Diagnostico.CID10, dbo.Diagnostico.DESCRICAO , Data_Cadastro " &_ 
			"FROM dbo.Diagnostico INNER JOIN " &_ 
            "dbo.HomeCare_Diagnostico_Entrada ON dbo.Diagnostico.CID10 = dbo.HomeCare_Diagnostico_Entrada.CID10 " &_ 
			"Where id_Solicitacao_Atendimento = '"&Cint(id_Solicitcao_Atendimento)&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' bordercolor='#000000'>"
						  Response.Write "<tr class='texto'>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>CID10:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Diagnostico:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='5%' valign='top'><b>Data:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  Response.Write "<tr class='texto'>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top' align='center'><i>"&Trim(Rs("CID10"))&"</i></td>" & CHR(10)
							Response.Write "<td class='texto' width='57%' valign='top'><i>"&Trim(Rs("Descricao"))&"</i></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><i>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</i></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
					Response.Write "</table>" & CHR(10)
				End If
			Rs.Close
			Set Rs = Nothing

End Function

Function Carrega_Solicitacao_Medica_Entrada(id_Solicitcao_Atendimento)

	SQL = "Select *  From HomeCare_Solicitacao_Medica_Itens Where id_Solicitacao_Atendimento = '"&Cint(id_Solicitcao_Atendimento)&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' >" & CHR(10)
						Response.Write "<tr class='texto'>" & CHR(10)
							Response.Write "<td  width='8%' valign='top'><b>Prescrição:</b></td>" & CHR(10)
							Response.Write "<td  width='10%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td  width='7%' valign='top'><b>Qtd Dias:</b></td>" & CHR(10)
							Response.Write "<td  width='4%' valign='top'><b>Data:</b></td>" & CHR(10)
						Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
					IF Rs.eof Then Exit For
						Response.Write "<tr class='texto'>" & CHR(10)
							Response.Write "<td  width='24%' valign='top'><i>"&Trim(Rs("Descricao"))&"&nbsp;</i></td>" & CHR(10)
							Response.Write "<td  width='16%' valign='top'><i>"&Trim(Rs("Periodicidade"))&"&nbsp;</i></td>" & CHR(10)
							Response.Write "<td  width='16%' valign='top'><i>"&Trim(Rs("Qdt_Dias"))&"&nbsp;</i></td>" & CHR(10)
							Response.Write "<td  width='15%' valign='top'><i>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</i></td>" & CHR(10)
						Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todos os CID10 que o atendimento tem
Function Carrega_CID10_Itens

	SQL =	"SELECT dbo.HomeCare_Atendimento_Diagnostico.id, dbo.HomeCare_Atendimento_Diagnostico.CID10, dbo.Diagnostico.Descricao, " &_ 
            "dbo.HomeCare_Atendimento_Diagnostico.Data_Cadastro " &_ 
			"FROM  dbo.HomeCare_Atendimento_Diagnostico INNER JOIN " &_ 
			"dbo.Diagnostico ON dbo.HomeCare_Atendimento_Diagnostico.CID10 = dbo.Diagnostico.CID10 " &_ 
			"WHERE (dbo.HomeCare_Atendimento_Diagnostico.id_Atendimento = '"&Cint(Request("id_Atendimento"))&"') " &_ 
			"ORDER BY dbo.HomeCare_Atendimento_Diagnostico.Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>CID10:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='62%' valign='top'><b>Diagnostico:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='13%' valign='top'><b>Data:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' valign='top' align='center'>"&Trim(Rs("CID10"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
				Else
					Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR><TD align='center' class=legenda><b>Não foi encontrado diagnostico(s) no atendimento</b></TD></TR></Table>"
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todas as prescrições que o atendimento tem
Function Carrega_Prescricao_Medica_Itens

	SQL =	"SELECT dbo.HomeCare_Atendimento_Prescricao_Medica.Descricao, dbo.Periodicidade.Descricao AS Periodicidade, " &_ 
			"dbo.Intervalo.Descricao AS Intervalo, dbo.HomeCare_Atendimento_Prescricao_Medica.Qdt_Dias, "&_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica.Data_Cadastro, dbo.HomeCare_Via_Administracao.Descricao AS Via_Administracao, "&_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica.Dose, dbo.HomeCare_Prescricao_Tipo.Descricao AS Prescricao_Tipo "&_ 
			"FROM dbo.HomeCare_Atendimento_Prescricao_Medica INNER JOIN "&_ 
			"dbo.Periodicidade ON dbo.HomeCare_Atendimento_Prescricao_Medica.id_Periodicidade = dbo.Periodicidade.id INNER JOIN "&_ 
			"dbo.Intervalo ON dbo.HomeCare_Atendimento_Prescricao_Medica.id_Intervalo = dbo.Intervalo.id INNER JOIN "&_ 
			"dbo.HomeCare_Via_Administracao ON  "&_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica.id_Via_Administracao = dbo.HomeCare_Via_Administracao.id INNER JOIN "&_ 
			"dbo.HomeCare_Prescricao_Tipo ON dbo.HomeCare_Atendimento_Prescricao_Medica.id_Prescricao_Tipo = dbo.HomeCare_Prescricao_Tipo.id "&_ 
			"Where id_Atendimento = '"&Cint(Request("id_Atendimento"))&"' Order by Data_Cadastro " 
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Prescrição:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Dose:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Via Adm.:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Intervalo:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='08%' valign='top'><b>Qtd Dias:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='12%' valign='top'><b>Tipo:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Dose"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Via_Administracao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Intervalo"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qdt_Dias"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Prescricao_Tipo"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR><TD align='center' class=legenda><b>Não foram encontrado prescrições(s) no atendimento</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todos os médicos envolvidos no atendimento
Function Carrega_Lista_Medicos

	SQL = 	"SELECT dbo.HomeCare_Atendimento_Medicos.id, dbo.Funcionarios.nome, dbo.Funcionarios.CODIGO_MEDICO, " &_ 
			"dbo.HomeCare_Periodicidade.Descricao AS Periodicidade, dbo.HomeCare_Atendimento_Medicos.QTD, " &_ 
			"dbo.Contrato_Servico.Nome AS Contrato_Servico, dbo.HomeCare_Atendimento_Medicos.Data_Cadastro,  " &_ 
			"dbo.HomeCare_Atendimento_Medicos.id_Atendimento, dbo.HomeCare_Atendimento_Medicos.id_Funcionario,  " &_ 
			"dbo.HomeCare_Atendimento_Medicos.id_Funcionario_Status, dbo.HomeCare_Atendimento_Funcionario_Status.Descricao AS Status_Funcionario " &_ 
			"FROM dbo.HomeCare_Atendimento_Medicos INNER JOIN " &_ 
			"dbo.Contrato_Servico ON dbo.HomeCare_Atendimento_Medicos.id_Contrato_Servico = dbo.Contrato_Servico.id INNER JOIN " &_ 
			"dbo.Funcionarios ON dbo.HomeCare_Atendimento_Medicos.id_Funcionario = dbo.Funcionarios.id INNER JOIN " &_ 
			"dbo.HomeCare_Periodicidade ON dbo.HomeCare_Atendimento_Medicos.id_Periodicidade = dbo.HomeCare_Periodicidade.id INNER JOIN " &_ 
			"dbo.HomeCare_Atendimento_Funcionario_Status ON  " &_ 
			"dbo.HomeCare_Atendimento_Medicos.id_Funcionario_Status = dbo.HomeCare_Atendimento_Funcionario_Status.id " &_ 
			"WHERE (dbo.HomeCare_Atendimento_Medicos.id_Atendimento = '"&Cint(Request("id_Atendimento"))&"') " &_
			"Order By Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>CRM:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='23%' valign='top'><b>Nome:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='18%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Contrato:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Status:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Codigo_Medico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Nome"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("QTD"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Contrato_Servico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Rs("Status_Funcionario")&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR><TD align='center' class=legenda><b>Nenhum médico encontrado</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todos os enfermeiros envolvidos no atendimento
Function Carrega_Lista_Enfermeiros

	SQL	=	"SELECT dbo.HomeCare_Atendimento_Enfermeiro.id, dbo.Funcionarios.nome, dbo.Funcionarios.CODIGO_MEDICO, " &_
			"dbo.HomeCare_Periodicidade.Descricao AS Periodicidade, dbo.HomeCare_Atendimento_Enfermeiro.QTD, " &_
			"dbo.Contrato_Servico.Nome AS Contrato_Servico, dbo.HomeCare_Atendimento_Enfermeiro.Data_Cadastro, " &_
			"dbo.HomeCare_Atendimento_Enfermeiro.id_Atendimento, dbo.HomeCare_Atendimento_Enfermeiro.id_Funcionario,  " &_
			"dbo.HomeCare_Atendimento_Enfermeiro.id_Funcionario_Status,  " &_
			"dbo.HomeCare_Atendimento_Funcionario_Status.Descricao AS Status_Funcionario " &_
			"FROM dbo.HomeCare_Atendimento_Enfermeiro INNER JOIN " &_
			"dbo.Contrato_Servico ON dbo.HomeCare_Atendimento_Enfermeiro.id_Contrato_Servico = dbo.Contrato_Servico.id INNER JOIN " &_
			"dbo.Funcionarios ON dbo.HomeCare_Atendimento_Enfermeiro.id_Funcionario = dbo.Funcionarios.id INNER JOIN " &_
			"dbo.HomeCare_Periodicidade ON dbo.HomeCare_Atendimento_Enfermeiro.id_Periodicidade = dbo.HomeCare_Periodicidade.id INNER JOIN " &_
			"dbo.HomeCare_Atendimento_Funcionario_Status ON  " &_
			"dbo.HomeCare_Atendimento_Enfermeiro.id_Funcionario_Status = dbo.HomeCare_Atendimento_Funcionario_Status.id " &_
			"WHERE (dbo.HomeCare_Atendimento_Enfermeiro.id_Atendimento = '"&Cint(Request("id_Atendimento"))&"') " &_
			"ORDER BY dbo.HomeCare_Atendimento_Enfermeiro.Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>CRM:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='23%' valign='top'><b>Nome:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='18%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Contrato:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Status:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Codigo_Medico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Nome"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("QTD"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Contrato_Servico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Rs("Status_Funcionario")&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR><TD align='center' class=legenda><b>Nenhum enfemeiro encontrado</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todos os Aux. Enfermagem envolvidos no atendimento
Function Carrega_Lista_Enfermagem

	SQL	=	"SELECT dbo.HomeCare_Atendimento_Enfermagem.id, dbo.Funcionarios.nome, dbo.Funcionarios.CODIGO_MEDICO, " &_ 
			"dbo.HomeCare_Periodicidade.Descricao AS Periodicidade, dbo.HomeCare_Atendimento_Enfermagem.QTD, " &_ 
			"dbo.Contrato_Servico.Nome AS Contrato_Servico, dbo.HomeCare_Atendimento_Enfermagem.Data_Cadastro, " &_ 
			"dbo.HomeCare_Atendimento_Enfermagem.id_Atendimento, dbo.HomeCare_Atendimento_Enfermagem.id_Funcionario, " &_  
			"dbo.HomeCare_Atendimento_Enfermagem.id_Funcionario_Status,  " &_ 
			"dbo.HomeCare_Atendimento_Funcionario_Status.Descricao AS Status_Funcionario " &_ 
			"FROM dbo.HomeCare_Atendimento_Enfermagem INNER JOIN " &_ 
			"dbo.Contrato_Servico ON dbo.HomeCare_Atendimento_Enfermagem.id_Contrato_Servico = dbo.Contrato_Servico.id INNER JOIN " &_ 
			"dbo.Funcionarios ON dbo.HomeCare_Atendimento_Enfermagem.id_Funcionario = dbo.Funcionarios.id INNER JOIN " &_ 
			"dbo.HomeCare_Periodicidade ON dbo.HomeCare_Atendimento_Enfermagem.id_Periodicidade = dbo.HomeCare_Periodicidade.id INNER JOIN " &_ 
			"dbo.HomeCare_Atendimento_Funcionario_Status ON  " &_ 
			"dbo.HomeCare_Atendimento_Enfermagem.id_Funcionario_Status = dbo.HomeCare_Atendimento_Funcionario_Status.id " &_ 
			"WHERE (dbo.HomeCare_Atendimento_Enfermagem.id_Atendimento =  '"&Cint(Request("id_Atendimento"))&"') " &_ 
			"ORDER BY dbo.HomeCare_Atendimento_Enfermagem.Data_Cadastro " 
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>COREN:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='23%' valign='top'><b>Nome:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='18%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Contrato:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Status:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Codigo_Medico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Nome"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("QTD"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Contrato_Servico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Rs("Status_Funcionario")&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR><TD align='center' class=legenda><b>Nenhum Aux. enfemeiro encontrado</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todos os fisioterapeutas envolvidos no atendimento
Function Carrega_Lista_Fisioterapeuta

	SQL	=	"SELECT dbo.HomeCare_Atendimento_Fisioterapia.id, dbo.Funcionarios.nome, dbo.Funcionarios.CODIGO_MEDICO, " &_ 
			"dbo.HomeCare_Periodicidade.Descricao AS Periodicidade, dbo.HomeCare_Atendimento_Fisioterapia.Qtd_Sessoes, " &_ 
			"dbo.Contrato_Servico.Nome AS Contrato_Servico, dbo.HomeCare_Atendimento_Fisioterapia.Data_Cadastro, " &_ 
			"dbo.HomeCare_Atendimento_Fisioterapia.id_Atendimento, dbo.HomeCare_Atendimento_Fisioterapia.id_Funcionario,  " &_ 
			"dbo.HomeCare_Atendimento_Fisioterapia.id_Funcionario_Status, " &_ 
			"dbo.HomeCare_Atendimento_Funcionario_Status.Descricao AS Status_Funcionario " &_ 
			"FROM dbo.HomeCare_Atendimento_Fisioterapia INNER JOIN " &_ 
			"dbo.Contrato_Servico ON dbo.HomeCare_Atendimento_Fisioterapia.id_Contrato_Servico = dbo.Contrato_Servico.id INNER JOIN " &_ 
			"dbo.Funcionarios ON dbo.HomeCare_Atendimento_Fisioterapia.id_Funcionario = dbo.Funcionarios.id INNER JOIN " &_ 
			"dbo.HomeCare_Periodicidade ON dbo.HomeCare_Atendimento_Fisioterapia.id_Periodicidade = dbo.HomeCare_Periodicidade.id INNER JOIN " &_ 
			"dbo.HomeCare_Atendimento_Funcionario_Status ON  " &_ 
			"dbo.HomeCare_Atendimento_Fisioterapia.id_Funcionario_Status = dbo.HomeCare_Atendimento_Funcionario_Status.id " &_ 
			"WHERE (dbo.HomeCare_Atendimento_Fisioterapia.id_Atendimento = '"&Cint(Request("id_Atendimento"))&"') " &_ 
			"ORDER BY dbo.HomeCare_Atendimento_Fisioterapia.Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>COREN:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='23%' valign='top'><b>Nome:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='18%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Contrato:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Status:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Codigo_Medico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Nome"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qtd_Sessoes"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Contrato_Servico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Rs("Status_Funcionario")&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR><TD align='center' class=legenda><b>Nenhum fisioterapeuta encontrado</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todos os outros servicos envolvidos no atendimento
Function Carrega_Lista_Outros_Servicos

	SQL = 	"SELECT dbo.HomeCare_Atendimento_Outros_Servicos.id, dbo.Funcionarios.nome, dbo.Funcionarios.CODIGO_MEDICO, " &_ 
			"dbo.HomeCare_Periodicidade.Descricao AS Periodicidade, dbo.HomeCare_Atendimento_Outros_Servicos.QTD, " &_ 
			"dbo.Contrato_Servico.Nome AS Contrato_Servico, dbo.HomeCare_Atendimento_Outros_Servicos.Data_Cadastro, " &_ 
			"dbo.HomeCare_Atendimento_Outros_Servicos.id_Atendimento, dbo.HomeCare_Atendimento_Outros_Servicos.id_Funcionario, dbo.HomeCare_Atendimento_Outros_Servicos.obs "&_ 
			"FROM dbo.HomeCare_Atendimento_Outros_Servicos INNER JOIN " &_ 
			"dbo.Contrato_Servico ON dbo.HomeCare_Atendimento_Outros_Servicos.id_Contrato_Servico = dbo.Contrato_Servico.id INNER JOIN " &_ 
			"dbo.Funcionarios ON dbo.HomeCare_Atendimento_Outros_Servicos.id_Funcionario = dbo.Funcionarios.id INNER JOIN " &_ 
			"dbo.HomeCare_Periodicidade ON dbo.HomeCare_Atendimento_Outros_Servicos.id_Periodicidade = dbo.HomeCare_Periodicidade.id "&_ 
			"WHERE (dbo.HomeCare_Atendimento_Outros_Servicos.id_Atendimento = '"&Cint(request("id_Atendimento"))&"' ) " &_ 
			"ORDER BY dbo.HomeCare_Atendimento_Outros_Servicos.Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>CODIGO:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='24%' valign='top'><b>Nome:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Contrato:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Motivo:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='16%' valign='top'><b>Data:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Codigo_Medico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Nome"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qtd"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Contrato_Servico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Rs("Obs")&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR><TD align='center' class=legenda><b>Nenhum serviço foi encontrado</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todos os equipamentos envolvidos no atendimento
Function Carrega_Lista_Equipamentos

	SQL = 	"SELECT dbo.HomeCare_Atendimento_Equipamentos.Simpro, dbo.SIMPRO.DESCRICAO, dbo.HomeCare_Atendimento_Equipamentos.qtd, "&_ 
			"dbo.Fornecedores.Fornecedor, dbo.HomeCare_Atendimento_Equipamentos.Data_Cadastro, " &_ 
			"dbo.HomeCare_Atendimento_Equipamentos.id,  dbo.HomeCare_Atendimento_Equipamentos.id_Atendimento " &_ 
			"FROM dbo.HomeCare_Atendimento_Equipamentos INNER JOIN " &_ 
			"dbo.Fornecedores ON dbo.HomeCare_Atendimento_Equipamentos.id_Fornecedor = dbo.Fornecedores.id INNER JOIN " &_ 
			"dbo.SIMPRO ON dbo.HomeCare_Atendimento_Equipamentos.Simpro = dbo.SIMPRO.CD_SIMPRO " &_ 
			"WHERE (dbo.HomeCare_Atendimento_Equipamentos.id_Atendimento = '"&Cint(Request("id_Atendimento"))&"') " &_ 
			"Order By Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Simpro:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='33%' valign='top'><b>Descricao:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Fornecedor:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Simpro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("QTD"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Fornecedor"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR><TD align='center' class=legenda><b>Nenhum equipamento encontrado</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todos os materiais envolvidos no atendimento
Function Carrega_Lista_Materiais

	SQL = 	"SELECT dbo.HomeCare_Atendimento_Materiais.Simpro, dbo.SIMPRO.DESCRICAO, dbo.HomeCare_Atendimento_Materiais.Qtd, dbo.Fornecedores.Fornecedor, " &_ 
			"dbo.HomeCare_Atendimento_Materiais.Data_Cadastro, dbo.HomeCare_Atendimento_Materiais.id,  " &_ 
			"dbo.HomeCare_Atendimento_Materiais.id_atendimento " &_ 
			"FROM dbo.HomeCare_Atendimento_Materiais INNER JOIN " &_ 
			"dbo.Fornecedores ON dbo.HomeCare_Atendimento_Materiais.id_Fornecedor = dbo.Fornecedores.id INNER JOIN " &_ 
			"dbo.SIMPRO ON dbo.HomeCare_Atendimento_Materiais.Simpro = dbo.SIMPRO.CD_SIMPRO " &_ 
			"WHERE (dbo.HomeCare_Atendimento_Materiais.id_atendimento = '"&Cint(request("id_Atendimento"))&"') " &_ 
			"Order By Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Simpro:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='33%' valign='top'><b>Descricao:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Fornecedor:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Simpro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("QTD"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Fornecedor"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR><TD align='center' class=legenda><b>Nenhum material encontrado</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todos os materiais envolvidos no atendimento
Function Carrega_Lista_Medicamentos

	SQL = 	"SELECT dbo.HomeCare_Atendimento_Medicamentos.Simpro, dbo.SIMPRO.DESCRICAO, dbo.HomeCare_Atendimento_Medicamentos.qtd, "&_ 
			"dbo.Fornecedores.Fornecedor, dbo.HomeCare_Atendimento_Medicamentos.Data_Cadastro, dbo.HomeCare_Atendimento_Medicamentos.id, " &_ 
			"dbo.HomeCare_Atendimento_Medicamentos.id_Atendimento " &_ 
			"FROM dbo.HomeCare_Atendimento_Medicamentos INNER JOIN " &_ 
			"dbo.Fornecedores ON dbo.HomeCare_Atendimento_Medicamentos.id_Fornecedor = dbo.Fornecedores.id INNER JOIN " &_ 
			"dbo.SIMPRO ON dbo.HomeCare_Atendimento_Medicamentos.Simpro = dbo.SIMPRO.CD_SIMPRO " &_ 
			"WHERE (dbo.HomeCare_Atendimento_Medicamentos.id_Atendimento = '"&Cint(Request("id_Atendimento"))&"') " &_ 
			"Order By Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Simpro:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='33%' valign='top'><b>Descricao:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Fornecedor:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Simpro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("QTD"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Fornecedor"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR><TD align='center' class=legenda><b>Nenhum medicamento encontrado</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function
%>
<html>
<body>
<fieldset>
<legend>&nbsp;Atendimento&nbsp;</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="97%" valign="top">
	<table width='100%' border='0' cellpadding='0' cellspacing='0' >
        <tr class="texto" > 
          <td width="15%"><b>Atendimento N&ordm;:</b></td>
          <td width="85%" ><b><font size="2"><%=id_Atendimento%></font></b></td>
        </tr>
        <tr class="texto" > 
          <td><b>Status:</b></td>
          <td ><font color="#FF0000"><b><%=Ucase(Status_Descricao)%></b></font></td>
        </tr>
        <tr class="texto" >
          <td><b>Status de Alta:</b></td>
          <td ><font color="#FF0000"><b><%=Ucase(Status_Descricao_Alta)%></b></font></td>
        </tr>
        <%If Trim(id_Solicitacao_Status) = "3" Then%>
        <tr class="texto" > 
          <td>&nbsp;</td>
          <td ><font color="#FF0000"><b><%=Ucase(Motivo_Solicitacao_Negada)%></b></font></td>
        </tr>
        <%End If%>
        <tr class="texto" > 
          <td><b>Data Inicio:</b></td>
          <td ><%=Data_Cadastro%><b>&nbsp;&nbsp; 
            <%If Data_Fechamento <> "" Then%>
            Data Termino:</b>&nbsp;<%=Data_Fechamento%> <%End If%> </td>
        </tr>
        <tr class="texto" > 
          <td><b>Tempo Decorrido:</b></td>
          <td ><%=TempoDecorrido(Data_Cadastro,Data_Fechamento)%></td>
        </tr>
      </table></td>
    <td width="3%" valign="middle"><a href="#"><img src="/SmartCare/images/impressora4.jpg"  border="0" OnClick="javascript:Imprimir()"></a></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<fieldset>
<legend>&nbsp;Cadastro Paciente&nbsp;</legend>
<table width='100%' border='0' cellspacing='0' cellpadding='0'>
  <tr class='texto'> 
    <td width='8%'>Nome:</td>
    <td width='25%'><%=Nome%></td>
    <td width='13%'>Data Nasc.:</td>
    <td width='22%'><%=data_nascimento%></td>
    <td width='8%'>&nbsp;</td>
    <td colspan='3'>&nbsp;</td>
  </tr>
  <tr class='texto'> 
    <td>RG:</td>
    <td><%=RG%></td>
    <td>CPF:</td>
    <td colspan='5'><%=CPF%></td>
  </tr>
  <tr class='texto'> 
    <td>Convênio:</td>
    <td><%=Convenio%></td>
    <td>Tipo Plano:</td>
    <td colspan='5'><%=Particular%></td>
  </tr>
  <tr class='texto'> 
    <td>Endereço:</td>
    <td><%=Endereco%></td>
    <td>Cidade:</td>
    <td><%=Cidade%></td>
    <td>Bairro:</td>
    <td width='17%'><%=Bairro%></td>
    <td width='3%'>UF:</td>
    <td width='4%'><%=UF%></td>
  </tr>
  <tr class='texto'> 
    <td>Telefones:</td>
    <td><%=Telefones%></td>
    <td>Responsavel:</td>
    <td><%=Responsavel%></td>
    <td>Cuidador:</td>
    <td colspan='3'><%=Cuidador%></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<fieldset>
<legend>&nbsp;Diagnostico de Entrada&nbsp;</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="texto">
    <td><%=Carrega_CID10_Entrada(id_Solicitacao_Atendimento)%></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<fieldset>
<legend>&nbsp;Check List - Prescrição Médica (Solicitação)&nbsp;</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="texto"> 
    <td><%=Carrega_Solicitacao_Medica_Entrada(id_Solicitacao_Atendimento)%></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<fieldset>
<legend>&nbsp;Diagnosticos de Atendimento</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="texto"> 
    <td><%=Carrega_CID10_Itens%></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<fieldset>
<legend>&nbsp;Prescrição Médica</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="texto"> 
    <td><%=Carrega_Prescricao_Medica_Itens%></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<fieldset>
<legend>&nbsp;Equipe M&eacute;dica</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="texto"> 
    <td><fieldset>
      <legend>&nbsp;Médico</legend>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="texto"> 
          <td><%=Carrega_Lista_Medicos%></td>
        </tr>
      </table>
      </fieldset>
      <BR style="font-size:5px;">
      <fieldset>
      <legend>&nbsp;Enfermeiro Chefe</legend>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="texto"> 
          <td><%=Carrega_Lista_Enfermeiros%></td>
        </tr>
      </table>
      </fieldset>
      <BR style="font-size:5px;">
      <fieldset>
      <legend>&nbsp;Aux. Enfermeiro</legend>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="texto"> 
          <td><%=Carrega_Lista_Enfermagem%></td>
        </tr>
      </table>
      </fieldset>
      <BR style="font-size:5px;">
      <fieldset>
      <legend>&nbsp;Fisioterapeuta</legend>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="texto"> 
          <td><%=Carrega_Lista_Fisioterapeuta%></td>
        </tr>
      </table>
      </fieldset>
      <BR style="font-size:5px;">
      <fieldset>
      <legend>&nbsp;Outros Serviços</legend>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="texto"> 
          <td><%=Carrega_Lista_Outros_Servicos%></td>
        </tr>
      </table>
      </fieldset></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<fieldset>
<legend>&nbsp;Equipamentos</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="texto"> 
    <td><%=Carrega_Lista_Equipamentos%></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<fieldset>
<legend>&nbsp;Materiais</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="texto"> 
    <td><%=Carrega_Lista_Materiais%></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<fieldset>
<legend>&nbsp;Medicamentos</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="texto"> 
    <td><%=Carrega_Lista_Medicamentos%></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
</Body>
</Html>
<%
'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
Response.Flush()
%>
