<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
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

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

Function Visualizar

	SQL	=	"SELECT DISTINCT dbo.HomeCare_Atendimento.id, dbo.Pacientes.nome, dbo.Convenios.Convenio, dbo.Funcionarios.nome AS Medico " &_ 
			"FROM dbo.HomeCare_Atendimento_Prescricao_Medica INNER JOIN "&_ 
			"dbo.HomeCare_Atendimento ON dbo.HomeCare_Atendimento_Prescricao_Medica.id_Atendimento = dbo.HomeCare_Atendimento.id INNER JOIN " &_ 
			"dbo.HomeCare_Solicitacao_Atendimento ON  " &_ 
			"dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento = dbo.HomeCare_Solicitacao_Atendimento.id INNER JOIN " &_ 
			"dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id INNER JOIN " &_ 
			"dbo.Convenios ON dbo.HomeCare_Solicitacao_Atendimento.id_Convenio = dbo.Convenios.id INNER JOIN " &_  
			"dbo.HomeCare_Atendimento_Medicos ON dbo.HomeCare_Atendimento.id = dbo.HomeCare_Atendimento_Medicos.id_Atendimento INNER JOIN " &_ 
			"dbo.Funcionarios ON dbo.HomeCare_Atendimento_Medicos.id_Funcionario = dbo.Funcionarios.id " &_ 
			"WHERE  (dbo.HomeCare_Atendimento_Prescricao_Medica.id NOT IN (SELECT     id_Prescricao_Medica FROM HomeCare_Atendimento_Medicamentos)) "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Titulo_Tabela'>" & Chr(10)&_
							"<Td>Nº Atendimento:</Td>" & Chr(10)&_
							"<Td>Paciente:</Td>" & Chr(10)&_
							"<Td>Médico:</Td>" & Chr(10)&_
							"<Td>Convênio:</Td>" & Chr(10)&_
							"<Td>&nbsp;</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("id")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Nome")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Medico")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Convenio")&"</Td>" & Chr(10)&_
							"<td class='"&zebrado&"'>"&"<a href='default.asp?action=Visualizar_Medicamentos&id=" &rs("id")& "'>Ver Medicamentos</a>"&"</td>" & Chr(10) &_ 
						"</Tr>" 
					Rs.MoveNext
					Next
					Content = Content &_
					"</Table>"
				Else 'Caso não seja encontrado nenhum registro
					Content = Content & "<Table><tr><td class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
			Rs.Close
			Set Rs = Nothing
			Visualizar = Content

End Function
Dim y
Function Visualizar_Medicamentos

	SQL	=	"SELECT DISTINCT "&_ 
			"dbo.Pacientes.nome AS Paciente_Nome, dbo.Convenios.Convenio, dbo.Funcionarios.nome AS Medico_Nome, "&_
			"dbo.HomeCare_Atendimento_Paciente_Evolucao.id AS id_Evolucao, dbo.HomeCare_Atendimento.id AS id_Atendimento, "&_
			"dbo.HomeCare_Atendimento_Paciente_Evolucao.Data_Cadastro_Sistema "&_
			"FROM dbo.HomeCare_Atendimento_Paciente_Evolucao INNER JOIN "&_
			"dbo.HomeCare_Atendimento ON dbo.HomeCare_Atendimento_Paciente_Evolucao.id_Atendimento = dbo.HomeCare_Atendimento.id INNER JOIN "&_
			"dbo.HomeCare_Solicitacao_Atendimento ON  "&_
			"dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento = dbo.HomeCare_Solicitacao_Atendimento.id INNER JOIN "&_
			"dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id INNER JOIN "&_
			"dbo.Convenios ON dbo.HomeCare_Solicitacao_Atendimento.id_Convenio = dbo.Convenios.id INNER JOIN "&_
			"dbo.HomeCare_Atendimento_Prescricao_Medica ON  "&_
			"dbo.HomeCare_Atendimento.id = dbo.HomeCare_Atendimento_Prescricao_Medica.id_Atendimento INNER JOIN "&_
			"dbo.Funcionarios ON dbo.HomeCare_Atendimento_Prescricao_Medica.Id_Funcionario = dbo.Funcionarios.id INNER JOIN "&_
			"dbo.View_Prescricao ON dbo.HomeCare_Atendimento_Paciente_Evolucao.id = dbo.View_Prescricao.id_Evolucao  "&_
			"WHERE (dbo.HomeCare_Atendimento.id = '"&Cint(Request("id"))&"') AND (dbo.View_Prescricao.id NOT IN (SELECT id_Prescricao_Medica FROM HomeCare_Atendimento_Medicamentos)) "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					For x = 0 To Rs.RecordCount
					Response.Write"<table width='100%'>" & Chr(10)
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						Response.Write  "<tr class='zebra_orange1'>"  & Chr(10)
						Response.Write	"<td width='26%'><b>Evolução Nº:</b>&nbsp;"&Rs("id_Evolucao")&"</td>"  & Chr(10)
						Response.Write	"<td><b>Atendimento Nº:</b>&nbsp;"&Rs("id_Atendimento")&"</td>"  & Chr(10)
						Response.Write	"<td width='37%'><b>Data:</b>&nbsp;"&ArrumaDataHora(Rs("Data_Cadastro_Sistema"))&"</td>"  & Chr(10)
						Response.Write  "</tr>"  & Chr(10)
						Response.Write  "<tr class='zebra_orange1'>"  & Chr(10)
						Response.Write	"<td width='37%'><b>Médico:</b>&nbsp;"&Rs("Medico_Nome")&"</td>"  & Chr(10)
						Response.Write	"<td colspan='2'><b>Paciente:</b>&nbsp;"&Rs("Paciente_Nome")&"</td>"  & Chr(10)
						Response.Write  "</tr>"   & Chr(10)
						Call Visualiza_Itens_Prescricoes(Rs("id_Evolucao"))
					Rs.MoveNext
					Next
					Response.Write"</table>" & Chr(10)
				Else 'Caso não seja encontrado nenhum registro
					Content = Content & "<Table><tr><td class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
			Rs.Close
			Set Rs = Nothing
			Session("y") = ""
			Visualizar_Medicamentos = Content
			
End Function

Function Visualiza_Itens_Prescricoes(id_Evolucao)

	SQL	=	"SELECT  dbo.View_Prescricao.id AS id_Prescricao_Medica , dbo.View_Prescricao.Nova, dbo.View_Prescricao.Descricao, dbo.View_Prescricao.Dose, dbo.View_Prescricao.Qdt_Dias, "&_ 
			"dbo.HomeCare_Prescricao_Prioridade.Descricao AS Prioridade, dbo.HomeCare_Via_Administracao.Descricao AS Via_Administracao, "&_
			"dbo.Periodicidade.Descricao AS Periodicidade, dbo.Intervalo.Descricao AS Intervalo, dbo.HomeCare_Atendimento_Paciente_Evolucao.Texto, dbo.View_Prescricao.id_Prescricao_Tipo "&_
			"FROM dbo.View_Prescricao INNER JOIN "&_
			"dbo.HomeCare_Atendimento_Paciente_Evolucao ON  "&_
			"dbo.View_Prescricao.id_Evolucao = dbo.HomeCare_Atendimento_Paciente_Evolucao.id INNER JOIN "&_
			"dbo.HomeCare_Prescricao_Prioridade ON dbo.View_Prescricao.id_prioridade = dbo.HomeCare_Prescricao_Prioridade.id LEFT OUTER JOIN "&_
			"dbo.HomeCare_Via_Administracao ON dbo.View_Prescricao.id_Via_Administracao = dbo.HomeCare_Via_Administracao.id LEFT OUTER JOIN "&_
			"dbo.Periodicidade ON dbo.View_Prescricao.id_Periodicidade = dbo.Periodicidade.id LEFT OUTER JOIN "&_
			"dbo.Intervalo ON dbo.View_Prescricao.id_Intervalo = dbo.Intervalo.id "&_
			"WHERE  (dbo.View_Prescricao.id NOT IN (SELECT id_Prescricao_Medica FROM HomeCare_Atendimento_Medicamentos))  AND (dbo.View_Prescricao.id_Evolucao = '"&Id_Evolucao&"') "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
						Response.Write"<table width='100%'>"   & Chr(10)
						Response.Write  "<tr class='zebra_orange1'>"  & Chr(10)
						Response.Write	"<td colspan='3'><b>Evolução:</b></td>"  & Chr(10)
						Response.Write  "</tr>"  & Chr(10)
						Response.Write  "<tr class='zebra1'>"  & Chr(10)
						Response.Write	"<td colspan='3' class='texto'>"&Rs("Texto")&"</td>" & Chr(10) 
						Response.Write  "</tr>"  & Chr(10)
						Response.Write"</table>"  & Chr(10)

						Response.Write "<table width='100%'>"  & Chr(10)
						Response.Write  "<tr class='zebra_orange1'>"  & Chr(10)
							Response.Write	"<td>Prescrição:</td>"  & Chr(10)
							Response.Write	"<td>Dose:</td>"  & Chr(10)
							Response.Write	"<td>Via Administração:</td>"  & Chr(10)
							Response.Write	"<td>Periodicidade:</td>"  & Chr(10)
							Response.Write	"<td>Intervalo:</td>" & Chr(10)
							Response.Write	"<td>Qdt Dias:</td>" & Chr(10)
							Response.Write	"<td>Prioridade:</td>" & Chr(10)
							Response.Write	"<td>&nbsp;</td>" & Chr(10)
						Response.Write  "</tr>"  & Chr(10)
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If Session("y") = "" Then Session("y") = "0" Else Session("y") = Session("y") + 1 End if
						Response.Write  "<tr class='zebra1'>"  & Chr(10)
							Response.Write	"<td>"&Rs("Descricao")&"</td>" & Chr(10) 
							Response.Write	"<td>"&Rs("Dose")&"</td>"  & Chr(10)
							Response.Write	"<td>"&Rs("Via_Administracao")&"</td>"  & Chr(10)
							Response.Write	"<td>"&Rs("Periodicidade")&"</td>"  & Chr(10)
							Response.Write	"<td>"&Rs("Intervalo")&"</td>"  & Chr(10)
							Response.Write	"<td>"&Rs("Qdt_Dias")&"</td>"  & Chr(10) 
							Response.Write	"<td>"&Rs("Prioridade")&"</td>" & Chr(10)
							Response.Write	"<td><img style='cursor:hand;' onclick=""if(document.getElementById('Mostra_Simpro_"&Session("y")&"').style.display=='none') {document.getElementById('Mostra_Simpro_"&Session("y")&"').style.display='block'}else{document.getElementById('Mostra_Simpro_"&Session("y")&"').style.display='none'}"" src='\SmartCare\images\pesquisa.gif' border='0' WIDTH='15' HEIGHT='13' ALT='Enviar Medicamento'></td>"  & Chr(10)
						Response.Write  "</tr>"  & Chr(10)
						
						Response.Write  "<tr class='zebra1' style='display:none' id='Mostra_Simpro_"&Session("y")&"'>"  & Chr(10)
							Response.Write	"<td colspan='8'>" &_
											"<input name='id_Prescricao_Medica' type='hidden' id='id_Prescricao_Medica' value='"&Rs("id_Prescricao_Medica")&"'>"&_ 
											"<input name='id_Prescricao_Tipo' type='hidden' id='id_Prescricao_Tipo' value='"&Rs("id_Prescricao_Tipo")&"'>"&_ 
											"<b>Código Simpro:</b>&nbsp;<input name='Cod_Simpro_Medicamento' type='text' class='campos' id='Cod_Simpro_Medicamento' onchange=""CarregaSimproMedicamento(formCadastro.Cod_Simpro_Medicamento,'"&Session("y")&"')"" size='7' maxlength='7'  >"&_
											"&nbsp;<b>Descrição:</b>&nbsp;<input readonly name='Descricao_Medicamento' type='text' class='campos' size='30'>" &_ 
											"&nbsp;<b>Qantidade:</b>&nbsp;<input name='qtd_Medicamentos' type='text' class='campos' id='qtd_Medicamentos' size='5' maxlength='5'>"&_
											"&nbsp;<b>Data Devolução:</b>&nbsp;<input name='dt_evolucao' type='text' class='campos' id='dt_evolucao' size='11' maxlength='11'>" &_ 
											"&nbsp;&nbsp;<input type='submit' name='Submit' value='Ok'>"
							Response.Write 	"</td>" 
						Response.Write  "</tr>"  & Chr(10)
					Rs.MoveNext
					Next
						Response.Write"</table>" & Chr(10)
						Response.Write"<hr>" & Chr(10)
				Else 'Caso não seja encontrado nenhum registro
					Content = Content & "<Table><tr><td class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
			Rs.Close
			Set Rs = Nothing

End Function

'Função que insere os Medicamentos.
Function Grava_Medicamentos(id_Atendimento)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Cod_Simpro_Medicamento").Count

		'Verifica se o campo esta vazio
		If Request.Form("Cod_Simpro_Medicamento")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Atendimento_Medicamentos (id_Atendimento,id_Prescricao_Medica,SIMPRO,Qtd) VALUES ( '"&id_Atendimento&"' , '"&TiraAspas(Request("id_Prescricao_Medica")(x))&"' , '"&TiraAspas(Request("Cod_Simpro_Medicamento")(x))&"' , '"&TiraAspas(Request("qtd_Medicamentos")(x))&"'  ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função que insere os Materiais.
Function Grava_Materiais(id_Atendimento)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Cod_Simpro_Medicamento").Count

		'Verifica se o campo esta vazio
		If Request.Form("Cod_Simpro_Medicamento")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Atendimento_Materiais (id_Atendimento,SIMPRO,Qtd) VALUES ( '"&id_Atendimento&"' , '"&TiraAspas(Request("Cod_Simpro_Medicamento")(x))&"' , '"&TiraAspas(Request("qtd_Medicamentos")(x))&"'  ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função que insere os Equipamentos.
Function Grava_Equipamentos(id_Atendimento)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Cod_Simpro_Medicamento").Count

		'Verifica se o campo esta vazio
		If Request.Form("Cod_Simpro_Medicamento")(x) <> "" Then
		
			SQL = 	"INSERT INTO HomeCare_Atendimento_Equipamentos (id_Atendimento,SIMPRO,Qtd) VALUES ( '"&id_Atendimento&"' , '"&TiraAspas(Request("Cod_Simpro_Medicamento")(x))&"' , '"&TiraAspas(Request("qtd_Medicamentos")(x))&"'  ) "
					Conn.execute(SQL) 'Executa a Query
					
		End IF
	
	Next

End Function


Function Gravar

	For X = 1 To Request.Form("Cod_Simpro_Medicamento").Count
		'Verifica se o campo esta vazio
		If Request.Form("Cod_Simpro_Medicamento")(x) <> "" Then
			'Verifica qual o tipo da prescrição para ser mandando para a função correta e fazer o insert
			if Request.Form("id_Prescricao_Tipo")(x) = "1" Then call Grava_Medicamentos(Request("id_Atendimento"))
			if Request.Form("id_Prescricao_Tipo")(x) = "2" Then call Grava_Equipamentos(Request("id_Atendimento"))
			if Request.Form("id_Prescricao_Tipo")(x) = "3" Then call Grava_Materiais(Request("id_Atendimento"))
		End IF	
	Next	

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Visualizar_Medicamentos"
		'Call Visualizar_Medicamentos
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Envio_Medicamentos/modelos/form_editar.htm" -->
<%	
	Case "Gravar"	
		Call Gravar
	
	Case Else
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Envio_Medicamentos/modelos/Form_Visualizar.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

