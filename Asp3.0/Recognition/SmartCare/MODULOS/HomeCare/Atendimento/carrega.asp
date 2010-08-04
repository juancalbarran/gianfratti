<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" --> 
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 10/07/2005
' Descrição: Pagina de apoio ao JavaScript que usa o metodo XMLHTTP para buscar o paciente e o medico
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'Usado para quando usar o XMLHTTP não retornat caracteres estranhos, principalmente quando tem acentos e outros caracteres estranhas
Response.CharSet="iso-8859-1"

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'Função que retorna a cadastro do pacinte, porem tem que ser passado os parametros de busca para isso
Function Carrega_Dados_Cadastro_Pacientes

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL =	"SELECT TOP 1  dbo.HomeCare_Solicitacao_Atendimento.id AS id_Solicitcao_Atendimento , dbo.Pacientes.*, dbo.FuncaoConvenioNome(dbo.Pacientes.id_convenio) AS Convenio_Nome " &_ 
		  	"FROM dbo.Pacientes INNER JOIN " &_ 
            "dbo.HomeCare_Solicitacao_Atendimento ON dbo.Pacientes.id = dbo.HomeCare_Solicitacao_Atendimento.id_Paciente " &_ 
			"WHERE (dbo.HomeCare_Solicitacao_Atendimento.id = '"&Cint(Request("Busca"))&"') AND (dbo.HomeCare_Solicitacao_Atendimento.id_Solicitacao_Status = 2) " 
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					IF Rs("Particular")	Then Tipo_Plano = "Pessoa Fisica" Else Tipo_Plano = "Pessoa Juridica" End if
					Response.Write "<input name='id_Solicitcao_Atendimento' type='hidden' value='"&Rs("id_Solicitcao_Atendimento")&"'>"
					Response.Write "<fieldset>"
					Response.Write "<legend>&nbsp;Cadastro Paciente&nbsp;</legend>"

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
						Response.Write "<td colspan='5'>"&Rs("CPF")&"</td>" & Chr(10)
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

'Função responsavel por contar a quantidade de atendimentos que o médico tem em aberto, este função e chama sempre que é consultado um profissional
Function Verifica_Qtd_Max_Atendimento(id_Funcionario)

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = 	"SELECT COUNT(dbo.View_Atendimento_Funcionarios.id_Atendimento) AS Total " &_ 
			"FROM dbo.View_Atendimento_Funcionarios INNER JOIN " &_ 
            "dbo.HomeCare_Atendimento ON dbo.View_Atendimento_Funcionarios.id_Atendimento = dbo.HomeCare_Atendimento.id " &_ 
			"WHERE (dbo.View_Atendimento_Funcionarios.id_Funcionario = '"&Trim(id_Funcionario)&"') AND (dbo.HomeCare_Atendimento.id_Atendimento_Status_Condicoes_Alta = 1) AND (dbo.View_Atendimento_Funcionarios.id_Funcionario_Status = 1) "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
						Verifica_Qtd_Max_Atendimento = Rs("Total")
				End IF
			Rs.Close
			Set Rs = Nothing


End Function

'Função que retorna o nome do médico por CRM
Function BuscaMedico

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "Select Top 1 id,Codigo_Medico, Nome , Qtd_Maxima_Atendimento From Funcionarios Where Codigo_Medico = '"&Request("CRM")&"' AND id_Departamento = 5 AND id_Cargo = 3 "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					'IF que verificar se a quantidade que o medico tem em aberto é maior do que a quantidade maxima que foi setado para ele atender
					If  Verifica_Qtd_Max_Atendimento(Rs("id")) < Rs("Qtd_Maxima_Atendimento") Then
						Response.Write Trim(Rs("Nome"))
					Else 'Caso ele ja tenha ultrapassado a quantidade max de atendimento entao é enviado a MSG abaixo para a função JAVASCRIOT tratar e apresentar um erro amigavel
						Response.Write "Bloqueado"
					End if
				End IF
			Rs.Close
			Set Rs = Nothing

End Function

'Função que retorna o nome do enfermeiro chefe.
'Query filtra por departamento e cargo
Function BuscaEnfermeiro

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "Select Top 1 id, Codigo_Medico, Nome , Qtd_Maxima_Atendimento From Funcionarios Where Codigo_Medico = '"&Trim(Request("Enfermeiro_Coren"))&"' AND id_Departamento = 5  AND id_Cargo = 12 "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					If  Verifica_Qtd_Max_Atendimento(Rs("id")) < Rs("Qtd_Maxima_Atendimento") Then
						Response.Write Trim(Rs("Nome"))
					Else 'Caso ele ja tenha ultrapassado a quantidade max de atendimento entao é enviado a MSG abaixo para a função JAVASCRIOT tratar e apresentar um erro amigavel
						Response.Write "Bloqueado"
					End if
				End IF
			Rs.Close
			Set Rs = Nothing

End Function

'Função que retorna o nome do Aux. Enfermagem
'Query filtra por departamento e cargo
Function BuscaEnfermagem

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "Select Top 1 id,Codigo_Medico, Nome , Qtd_Maxima_Atendimento  From Funcionarios Where Codigo_Medico = '"&Request("Enfermagem_Coren")&"' AND id_Departamento = 5 AND id_Cargo = 13 "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					If  Verifica_Qtd_Max_Atendimento(Rs("id")) < Rs("Qtd_Maxima_Atendimento") Then
						Response.Write Trim(Rs("Nome"))
					Else 'Caso ele ja tenha ultrapassado a quantidade max de atendimento entao é enviado a MSG abaixo para a função JAVASCRIOT tratar e apresentar um erro amigavel
						Response.Write "Bloqueado"
					End if
				End IF
			Rs.Close
			Set Rs = Nothing

End Function

'Função que retorna o nome do Aux. Enfermagem
'Query filtra por departamento e cargo
Function BuscaFisioterapeuta

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "Select Top 1 id, Codigo_Medico, Nome , Qtd_Maxima_Atendimento From Funcionarios Where Codigo_Medico = '"&Request("Fisioterapeuta_Cretifo")&"' AND id_Departamento = 5 AND id_Cargo = 16 "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					If  Verifica_Qtd_Max_Atendimento(Rs("id")) < Rs("Qtd_Maxima_Atendimento") Then
						Response.Write Trim(Rs("Nome"))
					Else 'Caso ele ja tenha ultrapassado a quantidade max de atendimento entao é enviado a MSG abaixo para a função JAVASCRIOT tratar e apresentar um erro amigavel
						Response.Write "Bloqueado"
					End if
				End IF
			Rs.Close
			Set Rs = Nothing

End Function

'Função que retorna o nome do funcionario
'Query filtra por departamento
Function BuscaOutrosServicos

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "Select Top 1 Codigo_Medico, Nome  From Funcionarios Where Codigo_Medico = '"&Request("Outros_Servicos_Codigo")&"' AND id_Departamento = 5 "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Response.Write Trim(Rs("Nome"))
				End IF
			Rs.Close
			Set Rs = Nothing

End Function

'Função que retorna o CID10
Function BuscaCid10

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "Select Top 1 Cid10, Descricao  From Diagnostico Where Cid10 = '"&Request("Cid10")&"' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Response.Write Trim(Rs("Descricao"))
				End IF
			Rs.Close
			Set Rs = Nothing

End Function

Function BuscaSimproEquipamento

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "Select Top 1 Cd_Simpro, Descricao  From Simpro Where CD_Simpro = '"&Request("Cod_Simpro_Equipamentos")&"' AND Cd_Mercado = 20 "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Response.Write Trim(Rs("Descricao"))
				End IF
			Rs.Close
			Set Rs = Nothing

End Function

Function BuscaSimproMaterial

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "Select Top 1 Cd_Simpro, Descricao  From Simpro Where CD_Simpro = '"&Request("Cod_Simpro_Materiais")&"' AND Cd_Mercado = 20 "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Response.Write Trim(Rs("Descricao"))
				End IF
			Rs.Close
			Set Rs = Nothing

End Function

Function BuscaSimproMedicamento

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "Select Top 1 Cd_Simpro, Descricao  From Simpro Where CD_Simpro = '"&Request("Cod_Simpro_Medicamento")&"' AND Cd_Mercado = 50 "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Response.Write Trim(Rs("Descricao"))
				End IF
			Rs.Close
			Set Rs = Nothing

End Function

Function BuscaExame

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "Select Top 1 id, Tit_Exame  From Exames Where id = '"&Request("Cod_Exame")&"' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Response.Write Trim(Rs("Tit_Exame"))
				End IF
			Rs.Close
			Set Rs = Nothing

End Function

Function BuscaAMB

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "Select Top 1 tbcodCodTabela, tbcodDescricao, Qtd_CH, tbcodNroAuxiliar From AMB_90 Where tbcodCodTabela = '"&Request("Cod_AMB")&"' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Response.Write Trim(Rs("tbcodDescricao")) & "#" &  Trim(Rs("tbcodNroAuxiliar")) 
				End IF
			Rs.Close
			Set Rs = Nothing

End Function

'Função responsavel por deletar os itens da prescricao do atendimento
Function DeletarItensPrescricao()

	'Deleta o iten
	SQL	=	"DELETE FROM HomeCare_Atendimento_Prescricao_Medica Where id ='"&Cint(request("id_Prescricao_Medica"))&"' "
			conn.execute(SQL)

	'Apos deletar o item carrega os registros ja com os novos valores para o XMLHTTP carregar
	SQL =	"SELECT HomeCare_Atendimento_Prescricao_Medica.*, HomeCare_Prescricao_Prioridade.Descricao AS Prioridade, " &_ 
			"HomeCare_Atendimento_Medicamentos.id_Prescricao_Medica, HomeCare_Prescricao_Tipo.Descricao AS Prescricao_Tipo, " &_ 
			"Periodicidade.Descricao AS Periodicidade, Intervalo.Descricao AS Intervalo, HomeCare_Via_Administracao.Descricao AS Via_Administracao,  HomeCare_Atendimento_Prescricao_Medica.Dose AS Dose " &_ 
			"FROM HomeCare_Atendimento_Prescricao_Medica INNER JOIN " &_ 
			"HomeCare_Prescricao_Prioridade ON HomeCare_Atendimento_Prescricao_Medica.id_Prioridade = HomeCare_Prescricao_Prioridade.id INNER JOIN " &_ 
			"HomeCare_Prescricao_Tipo ON HomeCare_Atendimento_Prescricao_Medica.id_Prescricao_Tipo = HomeCare_Prescricao_Tipo.id INNER JOIN " &_ 
			"Periodicidade ON HomeCare_Atendimento_Prescricao_Medica.id_Periodicidade = Periodicidade.id INNER JOIN " &_ 
			"Intervalo ON HomeCare_Atendimento_Prescricao_Medica.id_Intervalo = Intervalo.id INNER JOIN " &_ 
			"HomeCare_Via_Administracao ON  " &_ 
			"HomeCare_Atendimento_Prescricao_Medica.id_Via_Administracao = HomeCare_Via_Administracao.id LEFT OUTER JOIN " &_ 
			"HomeCare_Atendimento_Medicamentos ON  " &_ 
			"HomeCare_Atendimento_Prescricao_Medica.id = HomeCare_Atendimento_Medicamentos.id_Prescricao_Medica " &_ 
			"WHERE (HomeCare_Atendimento_Prescricao_Medica.id_Atendimento = '"&Request("id_Atendimento")&"') " &_ 
			"ORDER BY HomeCare_Atendimento_Prescricao_Medica.Data_Cadastro " 
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='13%' valign='top'><b>Prescrição:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>Dose:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Via Adm:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='6%' valign='top'><b>Intervalo:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='7%' valign='top'><b>Qtd Dias:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='08%' valign='top'><b>Tipo:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='07%' valign='top'><b>Prioridade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='07%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center' >&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						'If faz a verificacao para saber se a prescricao já foi vinculada a um medicamento. Caso na tabela de medicamento o campo de id_prescricao_Medica for diferente de vazio entao e colocado o icone do cadeado
						IF Not IsNull(Rs("id_Prescricao_Medica")) Then
							Img = "<img src='/SmartCare/images/ico_cadeado.gif' border='0' alt='Esta prescrição não pode ser apagada pois já foi vinculada a um medicamento' >"
							Else 'Caso a prescrição nao tenha sico vinculada a um medicamento entao libera a opcao de exluir a prescricao
							Img = "<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarItensPrescricao( "&Rs("id")&" , '"&Rs("Descricao")&"' )"" >"
						End IF					
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"">" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Dose"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Via_Administracao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Intervalo"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qdt_Dias"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Prescricao_Tipo"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Prioridade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center' >"&"<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarItensPrescricao( "&Rs("id")&" , '"&Rs("Descricao")&"' )"" >"&"</td>" & CHR(10)
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

'Função responsavel por deletar os diagnosticos incluidos no atendimento
Function DeletarItensCid10()

	'Deleta o iten
	SQL	=	"DELETE FROM HomeCare_Atendimento_Diagnostico  Where id ='"&Request("Id_Atendimento_Diagnostico")&"'  "
			conn.execute(SQL)

	'Apos deletar o item carrega os registros ja com os novos valores para o XMLHTTP carregar
	SQL =	"SELECT dbo.HomeCare_Atendimento_Diagnostico.id, dbo.HomeCare_Atendimento_Diagnostico.CID10, dbo.Diagnostico.Descricao, " &_ 
            "dbo.HomeCare_Atendimento_Diagnostico.Data_Cadastro " &_ 
			"FROM  dbo.HomeCare_Atendimento_Diagnostico INNER JOIN " &_ 
			"dbo.Diagnostico ON dbo.HomeCare_Atendimento_Diagnostico.CID10 = dbo.Diagnostico.CID10 " &_ 
			"WHERE (dbo.HomeCare_Atendimento_Diagnostico.id_Atendimento = '"&Request("id_Atendimento")&"') " &_ 
			"ORDER BY dbo.HomeCare_Atendimento_Diagnostico.Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>CID10:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='59%' valign='top'><b>Diagnostico:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='13%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center'>&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"" >" & CHR(10)
							Response.Write "<td class='texto' valign='top' align='center'>"&Trim(Rs("CID10"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center'>"&"<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarItensCid10("&Rs("id")&" , '"&Rs("Descricao")&"' )"" >"&"</td>" & CHR(10)
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

'Função responsavel por verificar se existe algum médico para o atendimento na edicao do registro.
'Esta função é chamada pelo JS
Function Verifica_Medico_Atendimento

	SQL = "Select * From HomeCare_Atendimento_Medicos Where id_Atendimento = '"&Request("id_Atendimento")&"' AND id_Funcionario_Status = 1 "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Rs.Eof then 'Caso nao exista o médico entao o emite o comando de "errado" para o JS que vai tratar isso
					Response.Write "errado" 'Retorna a msg de erro para o JS tratar
				End if

End Function

'Função responsavel por deletar os médicos incluidos no atendimento
Function DeletarMedicos

	'Faz o Update na tabela
	SQL	=	"Update HomeCare_Atendimento_Medicos SET  id_Funcionario_Status = '"&Trim(Replace(Request("RespostaMotivo"),"'",""))&"' Where id = "&Cint(Request("Id_Funcionario_Medico"))
			conn.execute(SQL)

	'Apos deletar o item carrega os registros ja com os novos valores para o XMLHTTP carregar
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
			"WHERE (dbo.HomeCare_Atendimento_Medicos.id_Atendimento = '"&Request("id_Atendimento")&"') " &_
			"Order By Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>CRM:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='20%' valign='top'><b>Nome:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='18%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Contrato:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Status:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center' >&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  If Rs("id_Funcionario_Status") <> "1" Then  'Faz a verificação para saber se o status não esta em analise, caso nao esteja entao coloca uma figura do cadeado e nao habilita o link para edicao e o link da TR somente abrira a Popup para visualizar o atendimento
						  	imagem = "<img src='/SmartCare/images/ico_cadeado.gif' border='0' alt='Médico foi desativado deste atendimento'   >" 
							Else  'Caso ainda esteja em edicao entao é colocado a imagem de edicao e o link de acesso e o Link da TR servira tb para editar o atendimento
							imagem = "<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarMedicos( "&Rs("id")&" , "&Rs("id_Atendimento")&" , '"&Rs("Nome")&"' )"" >"
						 	Response.Write "<input type='hidden' name='id_Funcionario_Medico' value='"&Rs("id_Funcionario")&"'>" & CHR(10)
						  End if
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"">" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Codigo_Medico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Nome"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("QTD"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Contrato_Servico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Rs("Status_Funcionario")&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center' >"&imagem&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Nenhum médico encontrado</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função responsavel por deletar os enfermeiros incluidos no atendimento
Function DeletarEnfermeiros

	'Faz o Update na tabela
	SQL	=	"Update HomeCare_Atendimento_Enfermeiro SET id_Funcionario_Status = '"&Trim(Replace(Request("RespostaMotivo"),"'",""))&"' Where id = "&Cint(Request("Id_Funcionario_Enfermeiro"))
			conn.execute(SQL)

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
			"WHERE (dbo.HomeCare_Atendimento_Enfermeiro.id_Atendimento = '"&Request("id_Atendimento")&"') " &_ 
			"ORDER BY dbo.HomeCare_Atendimento_Enfermeiro.Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>CRM:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='20%' valign='top'><b>Nome:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='18%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Contrato:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Status:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center' >&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  If Rs("id_Funcionario_Status") <> "1" Then  'Faz a verificação para saber se o status não esta em analise, caso nao esteja entao coloca uma figura do cadeado e nao habilita o link para edicao e o link da TR somente abrira a Popup para visualizar o atendimento
						  	imagem = "<img src='/SmartCare/images/ico_cadeado.gif' border='0' alt=Enfermeiro desativado deste atendimento'   >" 
							Else  'Caso ainda esteja em edicao entao é colocado a imagem de edicao e o link de acesso e o Link da TR servira tb para editar o atendimento
							imagem = "<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarEnfermeiros( "&Rs("id")&" , "&Rs("id_Atendimento")&" , '"&Rs("Nome")&"' )"" >"
						  End if
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"">" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Codigo_Medico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Nome"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("QTD"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Contrato_Servico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Rs("Status_Funcionario")&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center' >"&imagem&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Nenhum enfemeiro encontrado</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função responsavel por deletar os Aux. de enfermagem incluidos no atendimento
Function DeletarEnfermagem

	'Faz o Update na tabela
	SQL	=	"Update HomeCare_Atendimento_Enfermagem SET id_Funcionario_Status = '"&Trim(Replace(Request("RespostaMotivo"),"'",""))&"' Where id = "&Cint(Request("Id_Funcionario_Enfermagem"))
			conn.execute(SQL)

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
			"WHERE (dbo.HomeCare_Atendimento_Enfermagem.id_Atendimento =  '"&Request("id_Atendimento")&"') " &_ 
			"ORDER BY dbo.HomeCare_Atendimento_Enfermagem.Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>COREN:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='30%' valign='top'><b>Nome:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='18%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Contrato:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Status:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center' >&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  If Rs("id_Funcionario_Status") <> "1" Then  'Faz a verificação para saber se o status não esta em analise, caso nao esteja entao coloca uma figura do cadeado e nao habilita o link para edicao e o link da TR somente abrira a Popup para visualizar o atendimento
						  	imagem = "<img src='/SmartCare/images/ico_cadeado.gif' border='0' alt='Aux. Enfermagem foi desativado deste atendimento'   >" 
							Else  'Caso ainda esteja em edicao entao é colocado a imagem de edicao e o link de acesso e o Link da TR servira tb para editar o atendimento
							imagem = "<img src='/SmartCare/images/ico_editar.gif' border='0' Onclick=""DeletarEnfermagem( "&Rs("id")&" , "&Rs("id_Atendimento")&" , '"&Rs("Nome")&"' )"" >"
						  End if
						   Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"">" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Codigo_Medico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Nome"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("QTD"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Contrato_Servico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Rs("Status_Funcionario")&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center' >"&imagem&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Nenhum Aux. enfemeiro encontrado</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing
			
End Function

'Função responsavel por deletar os fisioterapeutas incluidos no atendimento
Function DeletarFisioterapeuta

	'Faz o Update na tabela
	SQL	=	"Update HomeCare_Atendimento_Fisioterapia SET id_Funcionario_Status = '"&Trim(Replace(Request("RespostaMotivo"),"'",""))&"' Where id = "&Cint(Request("Id_Funcionario_Fisioterapeuta"))
			conn.execute(SQL)

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
			"WHERE (dbo.HomeCare_Atendimento_Fisioterapia.id_Atendimento = '"&Request("id_Atendimento")&"' ) " &_ 
			"ORDER BY dbo.HomeCare_Atendimento_Fisioterapia.Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>COREN:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='30%' valign='top'><b>Nome:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='18%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Contrato:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Status:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center' >&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  If Rs("id_Funcionario_Status") <> "1" Then  'Faz a verificação para saber se o status não esta em analise, caso nao esteja entao coloca uma figura do cadeado e nao habilita o link para edicao e o link da TR somente abrira a Popup para visualizar o atendimento
						  	imagem = "<img src='/SmartCare/images/ico_cadeado.gif' border='0' alt='Fisioterapeuta foi desativado deste atendimento'   >" 
							Else  'Caso ainda esteja em edicao entao é colocado a imagem de edicao e o link de acesso e o Link da TR servira tb para editar o atendimento
							imagem = "<img src='/SmartCare/images/ico_editar.gif' border='0' Onclick=""DeletarFisioterapeuta( "&Rs("id")&" , "&Rs("id_Atendimento")&" , '"&Rs("Nome")&"' )"" >"
						  End if
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"">" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Codigo_Medico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Nome"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qtd_Sessoes"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Contrato_Servico"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Rs("Status_Funcionario")&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center' >"&imagem&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Nenhum fisioterapeuta encontrado</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing
			
End Function

'Função responsavel por deletar os equipamentos incluidos no atendimento
Function DeletarEquipamentos

	'Deleta o iten
	SQL	=	"DELETE FROM HomeCare_Atendimento_Equipamentos Where id ='"&Request("Id_Equipamento")&"'  "
			conn.execute(SQL)

	SQL = 	"SELECT dbo.HomeCare_Atendimento_Equipamentos.Simpro, dbo.SIMPRO.DESCRICAO, dbo.HomeCare_Atendimento_Equipamentos.qtd, "&_ 
			"dbo.Fornecedores.Fornecedor, dbo.HomeCare_Atendimento_Equipamentos.Data_Cadastro, " &_ 
			"dbo.HomeCare_Atendimento_Equipamentos.id,  dbo.HomeCare_Atendimento_Equipamentos.id_Atendimento " &_ 
			"FROM dbo.HomeCare_Atendimento_Equipamentos INNER JOIN " &_ 
			"dbo.Fornecedores ON dbo.HomeCare_Atendimento_Equipamentos.id_Fornecedor = dbo.Fornecedores.id INNER JOIN " &_ 
			"dbo.SIMPRO ON dbo.HomeCare_Atendimento_Equipamentos.Simpro = dbo.SIMPRO.CD_SIMPRO " &_ 
			"WHERE (dbo.HomeCare_Atendimento_Equipamentos.id_Atendimento = '"&Request("id_Atendimento")&"') " 
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Simpro:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='30%' valign='top'><b>Descricao:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Fornecedor:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center' >&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"">" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Simpro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("QTD"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Fornecedor"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center' >"&"<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarEquipamenros( "&Rs("id")&" , "&Rs("id_Atendimento")&" , '"&Rs("Descricao")&"' )"" >"&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Nenhum equipamento encontrado</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função responsavel por deletar os materiais incluidos no atendimento
Function DeletarMaterial

	'Deleta o iten
	SQL	=	"DELETE FROM HomeCare_Atendimento_Materiais Where id ='"&Request("Id_Material")&"'  "
			conn.execute(SQL)

	SQL = 	"SELECT dbo.HomeCare_Atendimento_Materiais.Simpro, dbo.SIMPRO.DESCRICAO, dbo.HomeCare_Atendimento_Materiais.Qtd, dbo.Fornecedores.Fornecedor, " &_ 
			"dbo.HomeCare_Atendimento_Materiais.Data_Cadastro, dbo.HomeCare_Atendimento_Materiais.id,  " &_ 
			"dbo.HomeCare_Atendimento_Materiais.id_atendimento " &_ 
			"FROM dbo.HomeCare_Atendimento_Materiais INNER JOIN " &_ 
			"dbo.Fornecedores ON dbo.HomeCare_Atendimento_Materiais.id_Fornecedor = dbo.Fornecedores.id INNER JOIN " &_ 
			"dbo.SIMPRO ON dbo.HomeCare_Atendimento_Materiais.Simpro = dbo.SIMPRO.CD_SIMPRO " &_ 
			"WHERE (dbo.HomeCare_Atendimento_Materiais.id_atendimento = '"&Request("id_Atendimento")&"') "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Simpro:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='30%' valign='top'><b>Descricao:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Fornecedor:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center' >&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.bAackgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"">" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Simpro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("QTD"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Fornecedor"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center' >"&"<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarMateriais( "&Rs("id")&" , "&Rs("id_Atendimento")&" , '"&Rs("Descricao")&"' )"" >"&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Nenhum material encontrado</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função responsavel por deletar os Medicamentos incluidos no atendimento
Function DeletarMedicamento

	'Deleta o iten
	SQL	=	"DELETE FROM HomeCare_Atendimento_Medicamentos Where id ='"&Request("id_Medicamento")&"'  "
			conn.execute(SQL)

	SQL = 	"SELECT dbo.HomeCare_Atendimento_Medicamentos.Simpro, dbo.SIMPRO.DESCRICAO, dbo.HomeCare_Atendimento_Medicamentos.qtd, "&_ 
			"dbo.Fornecedores.Fornecedor, dbo.HomeCare_Atendimento_Medicamentos.Data_Cadastro, dbo.HomeCare_Atendimento_Medicamentos.id, " &_ 
			"dbo.HomeCare_Atendimento_Medicamentos.id_Atendimento " &_ 
			"FROM dbo.HomeCare_Atendimento_Medicamentos INNER JOIN " &_ 
			"dbo.Fornecedores ON dbo.HomeCare_Atendimento_Medicamentos.id_Fornecedor = dbo.Fornecedores.id INNER JOIN " &_ 
			"dbo.SIMPRO ON dbo.HomeCare_Atendimento_Medicamentos.Simpro = dbo.SIMPRO.CD_SIMPRO " &_ 
			"WHERE (dbo.HomeCare_Atendimento_Medicamentos.id_Atendimento = '"&Request("id_Atendimento")&"') "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Simpro:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='30%' valign='top'><b>Descricao:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Fornecedor:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center' >&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.bAackgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"">" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Simpro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("QTD"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Fornecedor"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center' >"&"<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarMedicamentos( "&Rs("id")&" , "&Rs("id_Atendimento")&" , '"&Rs("Descricao")&"' )"" >"&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Nenhum medicamento encontrado</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função responsavel por deletar os Exames incluidos no atendimento
Function DeletarExame

	'Deleta o iten
	SQL	=	"DELETE FROM HomeCare_Atendimento_Exames Where id ='"&Request("id_Exame")&"'  "
			conn.execute(SQL)

	SQL = 	"SELECT HomeCare_Atendimento_Exames.id, HomeCare_Atendimento_Exames.id_Exames, Exames.tit_exame, " &_ 
			"HomeCare_Atendimento_Exames.Data_Realizacao_Exame, HomeCare_Atendimento_Exames.Data_Cadastro, Fornecedores.Fornecedor, " &_ 
			"HomeCare_Atendimento_Exames.id_Atendimento " &_ 
			"FROM Exames INNER JOIN " &_ 
			"HomeCare_Atendimento_Exames ON Exames.id = HomeCare_Atendimento_Exames.id_Exames LEFT OUTER JOIN " &_ 
			"Fornecedores ON HomeCare_Atendimento_Exames.id_Fornecedor = Fornecedores.id " &_ 
			"WHERE (HomeCare_Atendimento_Exames.id_Atendimento = '"&Request("id_Atendimento")&"') " &_ 
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
							Response.Write "<td class='texto' width='16%' valign='top'><b>Laboratório:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center' >&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						IF Trim(ArrumaDataHora(Rs("Data_Realizacao_Exame"))) = "" Then Data_Realizacao_Exame = "Aguardando aprovação" Else Data_Realizacao_Exame = Trim(ArrumaDataHora(Rs("Data_Realizacao_Exame"))) End if
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.bAackgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"">" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("id_Exames"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Tit_Exame"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(ArrumaDataHora(Rs("Data_Cadastro")))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Data_Realizacao_Exame&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Rs("Fornecedor")&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center' >"&"<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarExames( "&Rs("id")&" , "&Rs("id_Atendimento")&" , '"&Rs("Tit_Exame")&"' )"" >"&"</td>" & CHR(10)
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


'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Carrega_Dados_Cadastro_Pacientes"
		Call Carrega_Dados_Cadastro_Pacientes 'Carrega os dados do paciente chamando a função global

	Case "BuscaSimproEquipamento"
		Call BuscaSimproEquipamento
		
	Case "BuscaSimproMaterial"
		Call BuscaSimproMaterial
	
	Case "BuscaSimproMedicamento"
		Call BuscaSimproMedicamento
		
	Case "BuscaMedico"		
		Call BuscaMedico 'Carrega os dados do medico chamando a função global

	Case "BuscaEnfermeiro"
		Call BuscaEnfermeiro
	
	Case "BuscaEnfermagem"
		Call BuscaEnfermagem
	
	Case "BuscaFisioterapeuta"
		Call BuscaFisioterapeuta
	
	Case "BuscaOutrosServicos"
		Call BuscaOutrosServicos
		
	Case "BuscaCid10"		
		Call BuscaCid10
	
	Case "BuscaExame"
		Call BuscaExame
		
	Case "BuscaAMB"
		Call BuscaAMB
	
	Case "DeletarItensPrescricao"	
		Call DeletarItensPrescricao()
	
	Case "DeletarItensCid10"
		Call DeletarItensCid10()
		
	Case "DeletarMedicos"
		Call DeletarMedicos()
	
	Case "DeletarEnfermeiros"
		Call DeletarEnfermeiros() 
		
	Case "DeletarEnfermagem"
		Call DeletarEnfermagem()
	
	Case "DeletarFisioterapeuta"
		Call DeletarFisioterapeuta()
	
	Case "DeletarEquipamentos"
		Call DeletarEquipamentos()
	
	Case "DeletarMaterial"
		Call DeletarMaterial()
	
	Case "DeletarMedicamento"
		Call DeletarMedicamento()
	
	Case "DeletarExame"
		Call DeletarExame()
	
	Case "Verifica_Medico_Atendimento"
		Call Verifica_Medico_Atendimento
		
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>
