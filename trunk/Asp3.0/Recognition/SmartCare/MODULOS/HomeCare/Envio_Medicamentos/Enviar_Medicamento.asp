<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<!-- #include virtual="/SmartCare/Modulos/HomeCare/Envio_Medicamentos/Js/Validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 05/01/2005
' Descrição: Pagina de envio de medicamentos
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim Medico , Paciente_Nome , Texto , id_Atendimento
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

Function Visualizar

	SQL	=	"SELECT dbo.FuncaoFuncionarioNome(dbo.HomeCare_Atendimento_Paciente_Evolucao.id_Funcionario) AS Medico, dbo.Pacientes.nome AS Paciente_Nome, "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento.id AS id_Atendimento, dbo.HomeCare_Atendimento_Paciente_Evolucao.id AS id_Evolucao, "&_ 
			"dbo.HomeCare_Atendimento_Paciente_Evolucao.Texto "&_ 
			"FROM dbo.HomeCare_Atendimento INNER JOIN "&_ 
			"dbo.HomeCare_Atendimento_Paciente_Evolucao ON  "&_ 
			"dbo.HomeCare_Atendimento.id = dbo.HomeCare_Atendimento_Paciente_Evolucao.id_Atendimento INNER JOIN "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento ON  "&_ 
			"dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento = dbo.HomeCare_Solicitacao_Atendimento.id INNER JOIN "&_  
			"dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id "&_ 
			"WHERE (dbo.HomeCare_Atendimento_Paciente_Evolucao.id = '"&Cint(Request("id_Evolucao"))&"' ) "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					
					id_Atendimento = Rs("id_Atendimento")
					Medico = Rs("Medico")
					Paciente_Nome = Rs("Paciente_Nome")
					Texto = Rs("texto")

				Else 'Caso não seja encontrado nenhum registro
					Content = Content & "<Table><tr><td class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
			Rs.Close
			Set Rs = Nothing

End Function

Function Visualiza_Itens_Prescricoes(id_Evolucao)

	SQL	=	"SELECT  dbo.View_Prescricao.id AS id_Prescricao_Medica , dbo.View_Prescricao.Nova, dbo.View_Prescricao.Descricao, dbo.View_Prescricao.Dose, dbo.View_Prescricao.Qdt_Dias, "&_ 
			"dbo.HomeCare_Prescricao_Prioridade.Descricao AS Prioridade, dbo.HomeCare_Via_Administracao.Descricao AS Via_Administracao, "&_
			"dbo.Periodicidade.Descricao AS Periodicidade, dbo.Intervalo.Descricao AS Intervalo, dbo.HomeCare_Atendimento_Paciente_Evolucao.Texto "&_
			"FROM dbo.View_Prescricao INNER JOIN "&_
			"dbo.HomeCare_Atendimento_Paciente_Evolucao ON  "&_
			"dbo.View_Prescricao.id_Evolucao = dbo.HomeCare_Atendimento_Paciente_Evolucao.id INNER JOIN "&_
			"dbo.HomeCare_Prescricao_Prioridade ON dbo.View_Prescricao.id_prioridade = dbo.HomeCare_Prescricao_Prioridade.id INNER JOIN "&_
			"dbo.HomeCare_Via_Administracao ON dbo.View_Prescricao.id_Via_Administracao = dbo.HomeCare_Via_Administracao.id INNER JOIN "&_
			"dbo.Periodicidade ON dbo.View_Prescricao.id_Periodicidade = dbo.Periodicidade.id INNER JOIN "&_
			"dbo.Intervalo ON dbo.View_Prescricao.id_Intervalo = dbo.Intervalo.id "&_
			"WHERE  (dbo.View_Prescricao.id NOT IN (SELECT id_Prescricao_Medica FROM HomeCare_Atendimento_Medicamentos)) AND (dbo.View_Prescricao.id_Evolucao = '"&Id_Evolucao&"') "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
						Response.Write "<table width='100%'>" 
						Response.Write  "<tr class='zebra_orange1'>" 
						Response.Write	"<td>Prescrição:</td>" 
						Response.Write	"<td>Dose:</td>" 
						Response.Write	"<td>Via Administração:</td>" 
						Response.Write	"<td>Periodicidade:</td>" 
						Response.Write	"<td>Intervalo:</td>" 
						Response.Write	"<td>Qdt Dias:</td>" 
						Response.Write	"<td>Prioridade:</td>" 
						Response.Write  "</tr>" 
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						Response.Write  "<tr class='zebra1'>" 
						Response.Write	"<td>"&Rs("Descricao")&"</td>" 
						Response.Write	"<td>"&Rs("Dose")&"</td>" 
						Response.Write	"<td>"&Rs("Via_Administracao")&"</td>" 
						Response.Write	"<td>"&Rs("Periodicidade")&"</td>" 
						Response.Write	"<td>"&Rs("Intervalo")&"</td>" 
						Response.Write	"<td>"&Rs("Qdt_Dias")&"</td>" 
						Response.Write	"<td>"&Rs("Prioridade")&"</td>" 
						Response.Write  "</tr>" 
					Rs.MoveNext
					Next
						Response.Write"</table>"
				Else 'Caso não seja encontrado nenhum registro
					Content = Content & "<Table><tr><td class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
			Rs.Close
			Set Rs = Nothing

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Visualizar_Medicamentos"
		
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Envio_Medicamentos/modelos/form_editar.htm" -->
<%		
	Case Else
		Call Visualizar
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Envio_Medicamentos/modelos/form_enviar_Medicamento.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>
