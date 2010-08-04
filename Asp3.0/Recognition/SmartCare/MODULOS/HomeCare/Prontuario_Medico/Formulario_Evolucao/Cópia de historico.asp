<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
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


Function Historico_Evolucao(id_Atendimento)

	SQL	=	"SELECT dbo.HomeCare_Atendimento_Paciente_Evolucao.*, dbo.Funcionarios.nome AS Nome_Funcionario, dbo.Cargos.Cargo, " &_ 
			"dbo.Departamentos.descricao AS Nome_Departamento " &_ 
			"FROM dbo.Cargos INNER JOIN " &_ 
			"dbo.Funcionarios ON dbo.Cargos.id = dbo.Funcionarios.id_cargo INNER JOIN " &_ 
			"dbo.HomeCare_Atendimento_Paciente_Evolucao ON dbo.Funcionarios.id = dbo.HomeCare_Atendimento_Paciente_Evolucao.id_Funcionario INNER JOIN " &_ 
			"dbo.Departamentos ON dbo.Funcionarios.id_departamento = dbo.Departamentos.id " 
			clausula = " WHERE  "
				if Trim(Request("id_Atendimento")) <> "" Then
					sql = sql & clausula & " (dbo.HomeCare_Atendimento_Paciente_Evolucao.id_Atendimento = '"&Cint(id_Atendimento)&"')  "
					clausula = "and "
				end if
				if Trim(Request("id_Funcionario")) <> "" Then
					sql = sql & clausula & " id_Funcionario = '"&Cint(Request("id_Funcionario"))&"'  "
					clausula = "and "
				end if
				if Trim(Request("data_inicial")) <> "" AND Trim(Request("data_final")) <> "" Then
					sql = sql & clausula &  "CONVERT(CHAR, Data_Evolucao, 103) BETWEEN '"&Trim(Request("data_inicial"))&"' AND '"&Trim(Request("data_final"))&"'  "	
					clausula = "and "
				end if
				if Trim(Request("date")) <> "" AND Trim(Request("data_inicial")) = "" Then
					sql = sql & clausula & " Data_Evolucao = '"&Request("date")&"'  "
					clausula = "and "
				end if		
			sql = sql & "Order by Data_Evolucao Desc "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
					Response.Write "<fieldset>" & Chr(10)
					Response.Write "<legend>&nbsp;Evolução Multidiciplinar&nbsp;</legend>" & Chr(10)
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda'>"
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
							  Response.Write "<tr class='Cabecalho'> "& Chr(10)
								Response.Write "<td colspan='3' align='left'>Evolução - "&ArrumaData(Rs("Data_Evolucao"))&" - "&Rs("Nome_Funcionario")&" </td>"& Chr(10)
							  Response.Write "</tr>" & Chr(10)
							  Response.Write "<tr class='zebra1'> "& Chr(10)
								Response.Write "<td class='textoJust' colspan='3'>"&Replace(Rs("Texto"),Chr(10),"<br>")&"</td>" & Chr(10)
							  Response.Write "</tr>" & Chr(10)
							  Response.Write "<tr> " & Chr(10)
								Response.Write "<td valign='top'>"&Carrega_Prescricao_Medica_Itens(Cint(id_Atendimento),Rs("id_Funcionario"),Rs("id"))&"</td>" & Chr(10)
							  Response.Write "</tr>"& Chr(10)
							  Response.Write "<tr> " & Chr(10)
								Response.Write "<td valign='top'>"&Carrega_CID10_Itens(Cint(id_Atendimento),Rs("id_Funcionario"),Rs("id"))&"</td>" & Chr(10)
							  Response.Write "</tr>"& Chr(10)
							  Response.Write "<tr> " & Chr(10)
							  	Response.Write "<td valign='top'>"&Carrega_Exames_Itens(Cint(id_Atendimento),Rs("id_Funcionario"),Rs("id"))&"</td>" & Chr(10)
							  Response.Write "</tr>"& Chr(10)
					Rs.MoveNext
					Next
					Response.Write "</table>" & Chr(10)
					Response.Write "</fieldset>"
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

Function Verifica_Prescricao_Suspensa(id_Prescricao_Medica)

	SQL	=	"Select * From HomeCare_Atendimento_Prescricao_Medica_Suspensa Where id_Prescricao_Medica = '"&id_Prescricao_Medica&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
					Verifica_Prescricao_Suspensa = True
				Else
					Verifica_Prescricao_Suspensa = False
				End If
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
						Content = Content & "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10) 
						   Content = Content & "<tr class='Titulo_Tabela'>" & CHR(10)
							 Content = Content & "<td width='15%' valign='top'><b>Prescrição:</b></td>" & CHR(10)
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
						If Verifica_Prescricao_Suspensa(Rs("id")) = True Then Strike = "<strike>" : img = "<img src='/SmartCare/Images/suspenso.gif' width='70' height='15' alt='Prescrição suspensa'>" Else Strike = "" : img = "" End if 
						  Content = Content & "<tr>" & CHR(10)  
							Content = Content & "<td class='"&zebrado&"' valign='top'> "&Strike&" "& img & "<br>" & Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'> "&Strike&" "&Trim(Rs("Dose"))&"</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'> "&Strike&" "&Trim(Rs("Via_Administracao"))&"</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'> "&Strike&" "&Trim(Rs("Periodicidade"))&"&nbsp;</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'> "&Strike&" "&Trim(Rs("Intervalo"))&"&nbsp;</td>" & CHR(10) 
							Content = Content & "<td class='"&zebrado&"' valign='top'> "&Strike&" "&Trim(Rs("Qdt_Dias"))&"&nbsp;</td>" & CHR(10) 
							Content = Content & "<td class='"&zebrado&"' valign='top'> "&Strike&" "&Trim(Rs("Prescricao_Prioridade"))&"</td>" & CHR(10) 
							Content = Content & "<td class='"&zebrado&"' valign='top'> "&Strike&" "&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10) 
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
			"HomeCare_Atendimento_Exames ON Exames.id = HomeCare_Atendimento_Exames.id_Exames INNER JOIN " &_ 
			"Fornecedores ON HomeCare_Atendimento_Exames.id_Fornecedor = Fornecedores.id " &_ 
			"WHERE dbo.HomeCare_Atendimento_Exames.id_Atendimento = '"&id_Atendimento&"' AND dbo.HomeCare_Atendimento_Exames.id_Funcionario = '"&id_Funcionario&"' And dbo.HomeCare_Atendimento_Exames.id_Evolucao = '"&id_Evolucao&"' " &_ 
			"Order by Data_Cadastro " 
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Content = ""
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
						If zebrado = "zebra4" Then zebrado = "zebra5" Else zebrado = "zebra4" End If
						  Content = Content & "<tr>" & CHR(10)  
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("id_Exames"))&"</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Tit_Exame"))&"&nbsp;</td>" & CHR(10)
							Content = Content & "<td class='"&zebrado&"' valign='top'>"&Trim(ArrumaDataHora(Rs("Data_Realizacao_Exame")))&"&nbsp;</td>" & CHR(10) 
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

Function Carrega_Funcionarios

	SQL	=	"SELECT DISTINCT id_Atendimento, id_Funcionario , dbo.FuncaoFuncionarioNome(id_Funcionario) AS Funcionario_Nome, COUNT(id) AS Total " &_ 
			"FROM HomeCare_Atendimento_Paciente_Evolucao " &_ 
			"WHERE (id_Atendimento = '"&Request("id_Atendimento")&"') " &_ 
			"GROUP BY id_Atendimento, id_Funcionario "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
					Content = ""
					Content = Content & "<table width='100%' border='0' cellspacing='1' cellpadding='0'>" & CHR(10)
					Content = Content & "<tr class='zebra_orange1'> "& CHR(10)
					Content = Content & "<td width='75%'><strong>Médico(s):</strong></td>"& CHR(10)
					Content = Content & "<td width='25%'><strong>Evoluções:</strong></td>"& CHR(10)
					Content = Content &  "</tr>" & CHR(10)
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For
						  Content = Content & "<tr>" & CHR(10)  
							Content = Content & "<td class='texto_grd_blue' valign='top'>"&"<a href='/SmartCare/Modulos/HomeCare/Prontuario_Medico/Formulario_Evolucao/historico.asp?id_Atendimento="&Rs("id_Atendimento")&"&id_Funcionario="&Rs("id_Funcionario")&"'>"&Rs("Funcionario_Nome")&"</a>"&"</td>" & CHR(10) 
							Content = Content & "<td class='texto_grd_blue' align='center' valign='top'>"&Rs("Total")&"</td>" & CHR(10) 
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
					'Content = Content & "<tr class='zebra_orange1'> "& CHR(10)
					'Content = Content & "<td width='75%'><strong>Médico(s):</strong></td>"& CHR(10)
					'Content = Content & "<td width='25%'><strong>Evoluções:</strong></td>"& CHR(10)
					'Content = Content &  "</tr>" & CHR(10)
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For
						  Content = Content & "<tr>" & CHR(10)  
							Content = Content & "<td class='texto' valign='top'>"&Rs("Nome")&"</td>" & CHR(10) 
							Content = Content & "<td class='texto' valign='top'>"&Rs("Cargo")&"</td>" & CHR(10) 
							Content = Content & "<td class='texto' valign='top'>"&Rs("Funcionario_Status")&"</td>" & CHR(10) 
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
<legend>&nbsp;Atendimento&nbsp;</legend>
<table width="100%" height="531">
  <tr valign="top"> 
    <td height="21" colspan="2"><%=Carrega_Dados_Cadastro_Pacientes(Request("id_Atendimento"))%> </td>
  </tr>
  <tr> 
    <td width="40%" valign="top"> 
      <fieldset>
      <legend>&nbsp;Atendimento&nbsp;</legend>
      <table width="100%" border="0" cellspacing="1" cellpadding="0">
        <tr class='zebra_orange1'> 
          <td width="32%"><strong>N&ordm; Atendimento:</strong></td>
          <td width="68%"><strong><font size="3"><%=Request("id_Atendimento")%></font></strong></td>
        </tr>
        <tr class='zebra_orange1'> 
          <td><strong>Data admiss&atilde;o:</strong></td>
          <td><strong><font size="3"><%=ArrumaDataHora(Data_Cadastro_Atendimento)%></font></strong></td>
        </tr>
        <tr class='zebra_orange1'> 
          <td><strong>Dias em Atend.:</strong></td>
          <td ><strong><font size="3"><%=TempoDecorrido(ArrumaDataHora(Data_Cadastro_Atendimento),ArrumaDataHora(Data_Fechamento_Atendimento))%></font></strong></td>
        </tr>
      </table>
      </fieldset>
<fieldset>
      <legend>&nbsp;Médicos&nbsp;</legend>
      <table width="100%" border="0" cellspacing="1" cellpadding="0">
        <tr class='zebra_orange1'> 
          <td valign="top"><%=Carrega_Funcionarios%></td>
        </tr>
      </table>
      </fieldset>
      <fieldset>
      <legend>&nbsp;Equipe de Atendimento&nbsp;</legend>
      <table width="100%" border="0" cellspacing="1" cellpadding="0">
        <tr class='zebra_orange1'> 
          <td valign="top"><%=Carrega_Equipe%></td>
        </tr>
      </table>
     
      </fieldset>

	  </td>
    <td width="60%" valign="top"> 
	<fieldset>
      <legend>&nbsp;Calendario de evoluçãos&nbsp;</legend>
      <table width="100%" border="0" cellspacing="1" cellpadding="0">
        <form name="form" method="post" action="">
		<tr class='zebra_orange1'> 
          <td width="10%" valign="top"> 
            <!-- #include virtual="/SmartCare/Modulos/HomeCare/Prontuario_Medico/Formulario_Evolucao/calendario.asp" -->
          </td>
          <td width="90%" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr> 
                  <td class="texto">Data Inicial:<b><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong> 
                    </strong></font></b></td>
                  <td class="texto">Data Final:</td>
                </tr>
                <tr> 
                  <td class="texto"><input class="campos" name="data_inicial" value="" size="12" onFocus="this.blur()" readonly> 
                    <a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fStartPop(document.form.data_inicial,document.form.data_final);return false;" HIDEFOCUS><img name="popcal" align="absmiddle" src="/SmartCare/bibliotecas/calendario/calbtn.gif" width="34" height="22" border="0" alt=""></a></td>
                  <td class="texto"><input class="campos" name="data_final" value="" size="12" onfocus="this.blur()" readonly> 
                    <a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fEndPop(document.form.data_inicial,document.form.data_final);return false;" HIDEFOCUS><img name="popcal" align="absmiddle" src="/SmartCare/bibliotecas/calendario/calbtn.gif" width="34" height="22" border="0" alt=""></a> 
                    <iframe width=132 height=142 name="gToday:contrast:/SmartCare/bibliotecas/calendario/agenda.js" id="gToday:contrast:/SmartCare/bibliotecas/calendario/agenda.js" src="/SmartCare/bibliotecas/calendario/ipopeng.htm" scrolling="no" frameborder="0" style="visibility:visible; z-index:999; position:absolute; left:-500px; top:0px;"> 
                    </iframe> </td>
                </tr>
                <tr> 
                  <td class="texto">Prescri&ccedil;&atilde;o:</td>
                  <td class="texto">&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="2"><input name="textfield" type="text" size="30"> 
                    <input type="submit" name="Submit" value="Buscar"></td>
                </tr>
                <tr> 
                  <td class="texto" colspan="2">&nbsp;</td>
                </tr>
                <tr>
                  <td class="texto" colspan="2">Para ver todas as prescri&ccedil;&otilde;es 
                    clique <a href="historico.asp?id_Atendimento=<%=Cint(Request("id_Atendimento"))%>">aqui</a>.</td>
                </tr>
                <tr align="center"> 
                  <td colspan="2">&nbsp; </td>
                </tr>
              </table>
			</td>
        </tr>
		</Form>
      </table>
      </fieldset>
      <table width="100%">
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
