<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 13/01/2005
' Descrição: Pagina de visualizao para impressão da solicitacao de atendimento
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%

Dim Nome,Sexo,Data_Nascimento,Responsavel,Endereco,Cep,UF,Cidade,Bairro,Idade,Telefones,Cuidador,Particular,Convenio,RG,CPF,Obs,id_Paciente,Data_Cadastro_Paciente
Dim id,Hospital_Nome,Solicitacao_Tipo,Tipo_Requisicao_Outros,Solicitacao_Tipo_Descricao,Medico_Solicitante,Medico_Solicitante_CRM,Medico_Solicitante_Contato,Medico_Avaliador,Medico_Avaliador_Data,Enfermeiro_Avaliador,Enfermeiro_Avaliador_Data
Dim Assistente_Social_Avaliador,Assistente_Social_Avaliador_Data,Fisioterapeuta_Avaliador,Fisioterapeuta_Avaliador_Data
Dim Data_Cadastro_Solicitacao,Solicitacao_Status,Motivo_Solicitacao_Negada,id_Solicitacao_Status,Data_Fechamento

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

Function Visualiza_Cadastro_Paciente

	SQL	=	"SELECT   dbo.HomeCare_Solicitacao_Atendimento.id, HomeCare_Solicitacao_Tipo.Descricao AS Solicitacao_Tipo , dbo.HomeCare_Solicitacao_Atendimento.obs , dbo.Pacientes.nome, dbo.Pacientes.responsavel, dbo.Pacientes.endereco, dbo.Pacientes.cep, dbo.Pacientes.cidade, dbo.Pacientes.uf, " &_ 
                      "dbo.Pacientes.bairro, dbo.Pacientes.sexo, dbo.Pacientes.telefones, dbo.Pacientes.cuidador, dbo.Pacientes.data_nascimento, "&_
                      "dbo.Pacientes.data_cadastro As Data_Cadastro_Paciente, dbo.Pacientes.RG, dbo.Pacientes.CPF, dbo.Convenios.Convenio, dbo.Pacientes.particular, "&_ 
                      "dbo.HomeCare_Solicitacao_Requisicao_Tipo.Descricao AS Solicitacao_Tipo_Descricao, "&_ 
                      "dbo.HomeCare_Solicitacao_Atendimento.Medico_Solicitante, "&_ 
                      "dbo.HomeCare_Solicitacao_Atendimento.Medico_Solicitante_CRM, dbo.HomeCare_Solicitacao_Atendimento.Medico_Solicitante_Contato, "&_ 
                      "dbo.FuncaoFuncionarioNome(dbo.HomeCare_Solicitacao_Atendimento.id_Funcionario_Medico_Avaliador) AS Medico_Avaliador, "&_ 
                      "dbo.FuncaoFuncionarioNome(dbo.HomeCare_Solicitacao_Atendimento.id_Funcionario_Enfermeiro_Avaliador) AS Enfermeiro_Avaliador, "&_ 
                      "dbo.FuncaoFuncionarioNome(dbo.HomeCare_Solicitacao_Atendimento.id_Funcionario_Assistente_Social_Avaliador) AS Assistente_Social_Avaliador, "&_ 
                      "dbo.FuncaoFuncionarioNome(dbo.HomeCare_Solicitacao_Atendimento.id_Funcionario_Fisioterapeuta_Avaliador) AS Fisioterapeuta_Avaliador, "&_ 
                      "dbo.HomeCare_Solicitacao_Atendimento.Medico_Avaliador_Data, dbo.HomeCare_Solicitacao_Atendimento.Enfermeiro_Avaliador_Data, "&_ 
                      "dbo.HomeCare_Solicitacao_Atendimento.Assistente_Social_Avaliador_Data, dbo.HomeCare_Solicitacao_Atendimento.Fisioterapeuta_Avaliador_Data, "&_ 
                      "dbo.HomeCare_Solicitacao_Atendimento.Data_Cadastro_Solicitacao, dbo.HomeCare_Solicitacao_Atendimento.Motivo_Solicitacao_Negada, "&_ 
                      "dbo.Pacientes.id AS id_Paciente , dbo.FuncaoHospitalNome(dbo.HomeCare_Solicitacao_Atendimento.id_Hospital) AS Hospital_Nome, "&_ 
					  "dbo.HomeCare_Solicitacao_Atendimento.Tipo_Requisicao_Outros, dbo.FuncaoSolicitacao_Status(dbo.HomeCare_Solicitacao_Atendimento.id_Solicitacao_Status) AS Solicitacao_Status, " &_ 
					  "dbo.HomeCare_Solicitacao_Atendimento.id_Solicitacao_Status,Data_Fechamento " &_ 
			"FROM     dbo.HomeCare_Solicitacao_Atendimento INNER JOIN  "&_ 
                      "dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id INNER JOIN "&_ 
                      "dbo.Convenios ON dbo.Pacientes.id_convenio = dbo.Convenios.id INNER JOIN "&_ 
                      "dbo.HomeCare_Solicitacao_Requisicao_Tipo ON  "&_ 
                      "dbo.HomeCare_Solicitacao_Atendimento.id_Solicitacao_Requisicao_Tipo = dbo.HomeCare_Solicitacao_Requisicao_Tipo.id INNER JOIN "&_ 
					  "HomeCare_Solicitacao_Tipo ON HomeCare_Solicitacao_Atendimento.id_Solicitacao_Tipo = HomeCare_Solicitacao_Tipo.id " &_
			"WHERE     (dbo.HomeCare_Solicitacao_Atendimento.id = '"&Request("id_Solicitacao_Atendimento")&"') "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not rs.eof then 'Verifica se existem registros

					id = Rs("id")
					id_Solicitacao_Status = Rs("id_Solicitacao_Status")
					Nome = Trim(Rs("Nome"))
					Sexo = Trim(Rs("Sexo"))
					Solicitacao_Tipo = Rs("Solicitacao_Tipo")
					Data_Nascimento = Trim(ArrumaData(Rs("Data_Nascimento")))
					Idade = Year(Date) - Year(Rs("Data_Nascimento"))
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
					Solicitacao_Tipo_Descricao = Replace(Trim(Rs("Solicitacao_Tipo_Descricao")),"(Especificar)","")
					Hospital_Nome = Rs("Hospital_Nome")
					Tipo_Requisicao_Outros = Rs("Tipo_Requisicao_Outros")
					Medico_Solicitante = Trim(Rs("Medico_Solicitante"))
					Medico_Solicitante_CRM = Trim(Rs("Medico_Solicitante_CRM"))
					Medico_Solicitante_Contato = Trim(Rs("Medico_Solicitante_Contato"))
					Medico_Avaliador = Rs("Medico_Avaliador")
					Medico_Avaliador_Data = ArrumaDataHora(Rs("Medico_Avaliador_Data"))
					Enfermeiro_Avaliador = Rs("Enfermeiro_Avaliador")
					Enfermeiro_Avaliador_Data = ArrumaDataHora(Rs("Enfermeiro_Avaliador_Data"))
					Assistente_Social_Avaliador = Rs("Assistente_Social_Avaliador")
					Assistente_Social_Avaliador_Data = ArrumaDataHora(Rs("Assistente_Social_Avaliador_Data"))
					Fisioterapeuta_Avaliador = Rs("Fisioterapeuta_Avaliador")
					Fisioterapeuta_Avaliador_Data = ArrumaDataHora(Rs("Fisioterapeuta_Avaliador_Data"))
					Data_Cadastro_Solicitacao = ArrumaDataHora(Rs("Data_Cadastro_Solicitacao"))
					Solicitacao_Status = Rs("Solicitacao_Status")
					Motivo_Solicitacao_Negada = Rs("Motivo_Solicitacao_Negada")
					Data_Fechamento = ArrumaDataHora(Rs("Data_Fechamento"))
					Obs = Trim(Rs("Obs"))

				End IF
			Rs.Close
			Set Rs = Nothing

End Function

Function Carrega_RH(id_Solicitcao_Atendimento)

	SQL = 	"SELECT id, id_Solicitacao_Atendimento, Profissional, Periodicidade, ISNULL(Valor, 0) AS Valor, " &_
			"ISNULL((SELECT SUM(Valor) FROM HomeCare_Solicitacao_Profissionais WHERE id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"'), 0) AS Total " &_ 
			"FROM HomeCare_Solicitacao_Profissionais " &_ 
			"WHERE (id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"') "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' bordercolor='#000000'>"
					 Response.Write "<tr class='texto'>" & CHR(10)
					 	Response.Write "<td class='texto' width='10%' valign='top'><b>Profissional:</b></td>" & CHR(10)
						Response.Write "<td class='texto' width='80%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
						Response.Write "<td class='texto' width='10%' valign='top' align='right'><b>Valor:</b></td>" & CHR(10)
					 Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						Total = Rs("Total")
						  Response.Write "<tr class='texto'>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'>"&Trim(Rs("Profissional"))&"&nbsp;</td>" & CHR(10)
							Response.Write "<td class='texto' width='80%' valign='top'>"&Trim(Rs("Periodicidade"))&"&nbsp;</td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top' align='right'>"&Trim(FormatCurrency(Rs("Valor")))&"&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "<tr>" & CHR(10)
							Response.Write "<td colspan='4' class='texto' align='right' valign='top'>Total:&nbsp;<b>"&FormatCurrency(Total)&"</b></td>" & CHR(10)
						 Response.Write "</tr>" & CHR(10)
						Response.Write "</table>" & CHR(10)
						Else
						Response.Write("Sem registro(s)")
				End If
			Rs.Close
			Set Rs = Nothing

End Function

Function Carrega_CID10_Itens(id_Solicitcao_Atendimento)

	SQL = 	"SELECT dbo.Diagnostico.CID10, dbo.Diagnostico.DESCRICAO , Data_Cadastro " &_ 
			"FROM dbo.Diagnostico INNER JOIN " &_ 
            "dbo.HomeCare_Diagnostico_Entrada ON dbo.Diagnostico.CID10 = dbo.HomeCare_Diagnostico_Entrada.CID10 " &_ 
			"Where id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' bordercolor='#000000'>"
					 Response.Write "<tr class='texto'>" & CHR(10)
					 	Response.Write "<td class='texto' width='10%' valign='top'><b>CID10:</b></td>" & CHR(10)
						Response.Write "<td class='texto' width='90%' valign='top'><b>Diagnostico:</b></td>" & CHR(10)
					 Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  Response.Write "<tr class='texto'>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("CID10"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
					Response.Write "</table>" & CHR(10)
						Else
						Response.Write("Sem registro(s)")
				End If
			Rs.Close
			Set Rs = Nothing

End Function

Function Carrega_Solicitacao_Medica_Itens(id_Solicitcao_Atendimento)

	SQL = 	"Select id, id_Solicitacao_Atendimento, Descricao, Periodicidade, Qdt_Dias, ISNULL(Valor, 0) AS Valor, Data_Cadastro, " &_ 
			"ISNULL((SELECT SUM(Valor) FROM HomeCare_Solicitacao_Medica_Itens WHERE  (id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"')), 0) AS Total " &_ 
			"From HomeCare_Solicitacao_Medica_Itens Where id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' >" & CHR(10)
						Response.Write "<tr class='texto'>" & CHR(10)
						Response.Write "<td  width='40%' valign='top'><b>Prescrição:</b></td>" & CHR(10)
						Response.Write "<td  width='30%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
						Response.Write "<td  width='20%' valign='top'><b>Qtd Dias:</b></td>" & CHR(10)
						Response.Write "<td  width='10%' valign='top' align='right'><b>Valor:</b></td>" & CHR(10)
						Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
					IF Rs.eof Then Exit For
						Total = FormatCurrency(Rs("Total"))
						Response.Write "<tr class='texto'>" & CHR(10)
							Response.Write "<td  valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td  valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td  valign='top'>"&Trim(Rs("Qdt_Dias"))&"</td>" & CHR(10)
							Response.Write "<td  valign='top' align='right'>"&Trim(FormatCurrency(Rs("Valor")))&"</td>" & CHR(10)
						Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "<tr>" & CHR(10)
							Response.Write "<td colspan='4' class='texto' align='right' valign='top'>Total:&nbsp;<b>"&FormatCurrency(Total)&"</b></td>" & CHR(10)
						 Response.Write "</tr>" & CHR(10)
						Response.Write "</table>" & CHR(10)
						Else
						Response.Write("Sem registro(s)")
				End If
			Rs.Close
			Set Rs = Nothing

End Function

Function Carrega_Equipamentos_Itens(id_Solicitcao_Atendimento)

	SQL =	"SELECT  id, id_Solicitacao_Atendimento, Equipamento, Qtd, ISNULL(Valor, 0) AS Valor, Data_Cadastro, " &_ 
			"ISNULL((SELECT SUM(Valor)  FROM  HomeCare_Solicitacao_Equipamentos  WHERE id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"'), 0) AS Total " &_ 
			"FROM HomeCare_Solicitacao_Equipamentos " &_
			"Where id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"' "	
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof And Rs(0).Name <> "sum" then 'Verifica se existem registros e se a coluna é diferente se SUM que é o total
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' width='70%' valign='top'><b>Equipamento:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='20%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top' align='right'><b>Valor:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						Total = Trim(FormatCurrency(Rs("Total")))
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' valign='top' >"&Trim(Rs("Equipamento"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qtd"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top' align='right'>"&Trim(FormatCurrency(Rs("Valor")))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "<tr>" & CHR(10)
							Response.Write "<td colspan='4' class='texto' align='right' valign='top'>Total:&nbsp;<b>"&FormatCurrency(Total)&"</b></td>" & CHR(10)
						 Response.Write "</tr>" & CHR(10)
						Response.Write "</table>" & CHR(10)
						Else
						Response.Write("Sem registro(s)")
				End If
			Rs.Close
			Set Rs = Nothing

End Function

Function Carrega_Materiais_Itens(id_Solicitcao_Atendimento)

	SQL =	"SELECT id, id_Solicitacao_Atendimento, Material, Qtd, ISNULL(Valor, 0) AS Valor, Data_Cadastro, " &_ 
			"ISNULL((SELECT Sum(Valor) FROM HomeCare_Solicitacao_Materiais WHERE id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"'), 0) AS Total " &_ 
			"FROM dbo.HomeCare_Solicitacao_Materiais " &_ 
			"WHERE (id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"') "			
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof And Rs(0).Name <> "sum" then 'Verifica se existem registros e se a coluna é diferente se SUM que é o total
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' width='70%' valign='top'><b>Material:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='20%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top' align='right'><b>Valor:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						Total = Trim(FormatCurrency(Rs("Total")))
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' valign='top' >"&Trim(Rs("Material"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qtd"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top' align='right'>"&Trim(FormatCurrency(Rs("Valor")))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "<tr>" & CHR(10)
							Response.Write "<td colspan='4' class='texto' align='right' valign='top'>Total:&nbsp;<b>"&FormatCurrency(Total)&"</b></td>" & CHR(10)
						 Response.Write "</tr>" & CHR(10)
						Response.Write "</table>" & CHR(10)
						Else
						Response.Write("Sem registro(s)")
				End If
			Rs.Close
			Set Rs = Nothing

End Function

Function Carrega_Dietas_Itens(id_Solicitcao_Atendimento)

	SQL =	"SELECT id, id_Solicitacao_Atendimento, Dieta, Qtd, ISNULL(Valor, 0) AS Valor, Data_Cadastro, " &_ 
			"ISNULL((SELECT SUM(Valor) FROM HomeCare_Solicitacao_Dietas WHERE id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"'), 0) AS Total " &_ 
			"FROM HomeCare_Solicitacao_Dietas " &_ 
			"WHERE (id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"') "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof And Rs(0).Name <> "sum" then 'Verifica se existem registros e se a coluna é diferente se SUM que é o total
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' width='70%' valign='top'><b>Dieta:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='20%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top' align='right'><b>Valor:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						Total = Trim(FormatCurrency(Rs("Total")))
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='texto' valign='top' >"&Trim(Rs("Dieta"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qtd"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top' align='right'>"&Trim(FormatCurrency(Rs("Valor")))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "<tr>" & CHR(10)
							Response.Write "<td colspan='4' class='texto' align='right' valign='top'>Total:&nbsp;<b>"&FormatCurrency(Total)&"</b></td>" & CHR(10)
						 Response.Write "</tr>" & CHR(10)
						Response.Write "</table>" & CHR(10)
						Else
						Response.Write("Sem registro(s)")
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que soma todos os serviços
Function Total_Geral(id_Solicitcao_Atendimento)

	SQL	=	"Select " &_
				"(SELECT  ISNULL(SUM(Valor),0) AS Valor FROM HomeCare_Solicitacao_Medica_Itens WHERE (id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"') ) As Total_Prescricao , " &_
				"(SELECT  ISNULL(SUM(Valor),0) AS Valor FROM HomeCare_Solicitacao_Profissionais WHERE (id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"') ) As Total_Profissionais , " &_
				"(SELECT  ISNULL(SUM(Valor),0) AS Valor FROM HomeCare_Solicitacao_Equipamentos WHERE (id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"') ) As Total_Equipamentos , " &_ 
				"(SELECT  ISNULL(SUM(Valor),0) AS Valor FROM HomeCare_Solicitacao_Materiais WHERE (id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"') ) As Total_Materiais , " &_ 
				"(SELECT  ISNULL(SUM(Valor),0) AS Valor FROM HomeCare_Solicitacao_Dietas WHERE (id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"') ) As Total_Dietas "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				Total = Cdbl(Rs("Total_Prescricao")) + Cdbl(Rs("Total_Profissionais")) + Cdbl(Rs("Total_Equipamentos")) + Cdbl(Rs("Total_Materiais")) + Cdbl(Rs("Total_Dietas"))
			Rs.Close
			Set Rs = Nothing
			Total_Geral = FormatCurrency(Total)

End Function

Call Visualiza_Cadastro_Paciente

%>
<html>
<body>
<fieldset>
<legend align="center">&nbsp;Avaliação&nbsp;</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="97%" valign="top">
	<table width='100%' border='0' cellpadding='0' cellspacing='0' >
        <tr class="texto" > 
          <td width="15%"><b>Avalia&ccedil;&atilde;o N&ordm;:</b></td>
          <td width="85%" ><b><font size="2"><%=ID%></font></b></td>
        </tr>
        <tr class="texto" >
          <td>Tipo de Avalia&ccedil;&atilde;o:</td>
          <td ><b><font size="2"><%=Solicitacao_Tipo%></font></b></td>
        </tr>
        <tr class="texto" > 
          <td><b>Status:</b></td>
          <td ><font color="#FF0000"><b><%=Ucase(Solicitacao_Status)%></b></font></td>
        </tr>
        <%If Trim(id_Solicitacao_Status) = "3" OR Trim(id_Solicitacao_Status) = "5" Then%>
        <tr class="texto" > 
          <td>&nbsp;</td>
          <td ><font color="#FF0000"><b><%=Ucase(Motivo_Solicitacao_Negada)%></b></font></td>
        </tr>
        <%End If%>
        <tr class="texto" > 
          <td><b>Data Inicio:</b></td>
          <td ><%=Data_Cadastro_Solicitacao%><b>&nbsp;&nbsp; 
            <%If Data_Fechamento <> "" Then%>
            Data Termino:</b>&nbsp;<%=Data_Fechamento%> <%End If%> </td>
        </tr>
        <tr class="texto" > 
          <td><b>Tempo Decorrido:</b></td>
          <td ><%=TempoDecorrido(Data_Cadastro_Solicitacao,Data_Fechamento)%></td>
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
    <td width='8%'>Idade:</td>
    <td colspan='3'><%=Idade%></td>
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
<legend>&nbsp;Tipo de Requisi&ccedil;&atilde;o&nbsp;</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="texto"> 
    <td><%=Solicitacao_Tipo_Descricao%></td>
  </tr>
  <tr class="texto">
    <td><%=Hospital_Nome%><%=Tipo_Requisicao_Outros%></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<fieldset>
<legend>&nbsp;M&eacute;dico Solicitante&nbsp;</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="texto"> 
    <td width="7%" height="19"><strong>CRM:</strong></td>
    <td width="52%"><strong>Nome:</strong></td>
    <td width="41%"><strong>Contato:</strong></td>
  </tr>
  <tr class="texto"> 
    <td height="19"><%=Medico_Solicitante_CRM%></td>
    <td><%=Medico_Solicitante%></td>
    <td><%=Medico_Solicitante_Contato%></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<fieldset>
<legend>&nbsp;Diagnostico de Entrada&nbsp;</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="texto"> 
    <td><%=Carrega_CID10_Itens(Request("id_Solicitacao_Atendimento"))%></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<fieldset>
<legend>&nbsp;Recursos Humanos&nbsp;</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="texto"> 
    <td><%=Carrega_RH(Request("id_Solicitacao_Atendimento"))%></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<fieldset>
<legend>&nbsp;Prescri&ccedil;&atilde;o M&eacute;dica&nbsp;</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="texto"> 
    <td><%=Carrega_Solicitacao_Medica_Itens(Request("id_Solicitacao_Atendimento"))%></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<fieldset>
<legend>&nbsp;Equipamentos&nbsp;</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="texto"> 
    <td><%=Carrega_Equipamentos_Itens(Request("id_Solicitacao_Atendimento"))%></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<fieldset>
<legend>&nbsp;Materiais&nbsp;</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="texto"> 
    <td><%=Carrega_Materiais_Itens(Request("id_Solicitacao_Atendimento"))%></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<fieldset>
<legend>&nbsp;Dietas&nbsp;</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="texto"> 
    <td><%=Carrega_Dietas_Itens(Request("id_Solicitacao_Atendimento"))%></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<fieldset>
<legend>&nbsp;Total Geral&nbsp;</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="texto"> 
    <td align="right"><strong><font size="3"><%=Total_Geral(Request("id_Solicitacao_Atendimento"))%></font></strong></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<fieldset>
<legend>&nbsp;Observação&nbsp;</legend>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="texto"> 
    <td><%If trim(Obs) <> "" Then%><%=Obs%><%Else%>Sem registro(s)<%End if%></td>
  </tr>
</table>
</fieldset>
<BR style="font-size:5px;">
<BR style="font-size:5px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="50%" align="center" valign="top"> 
      <fieldset>
<legend>&nbsp;De Acordo&nbsp;</legend>
      <table width="90%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="40">&nbsp;</td>
        </tr>
      </table>
	  </fieldset>
	  </td>
    <td width="50%" align="center" valign="top"> 
      <fieldset >
<legend>&nbsp;Cliente&nbsp;</legend>
      <table width="90%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="40">&nbsp;</td>
        </tr>
      </table>
</fieldset>
	  </td>
  </tr>
</table>
</Body>
</Html>
<%
'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
Response.Flush()
%>
