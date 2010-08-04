<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Agenda/js/validacoes.js" -->
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim conn
Dim Descricao , Data_Inicio , Hora_Inicio , Minuto_Inicio ,  Hora_Fim , Minuto_Fim , id_Status , id_Tipo
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

Function VisualizarPacientes

	SQL	=	"SELECT DISTINCT "&_ 
			"Pacientes.id AS id_Paciente, Pacientes.nome, Convenios.Convenio, "&_ 
			"HomeCare_Atendimento_Status.Descricao AS Status_Atendimento,  "&_ 
			"HomeCare_Atendimento_Status_Condicoes_Alta.Descricao AS Atendimento_Status_Condicoes_Alta, "&_ 
			"HomeCare_Atendimento.id AS id_Atendimento, HomeCare_Atendimento.id_Atendimento_Status_Condicoes_Alta "&_ 
			"FROM Pacientes INNER JOIN "&_ 
			"HomeCare_Solicitacao_Atendimento ON Pacientes.id = HomeCare_Solicitacao_Atendimento.id_Paciente INNER JOIN "&_ 
			"HomeCare_Atendimento ON HomeCare_Solicitacao_Atendimento.id = HomeCare_Atendimento.id_Solicitacao_Atendimento INNER JOIN "&_ 
			"View_Atendimento_Funcionarios ON HomeCare_Atendimento.id = View_Atendimento_Funcionarios.id_Atendimento INNER JOIN "&_
			"Convenios ON HomeCare_Solicitacao_Atendimento.id_Convenio = Convenios.id INNER JOIN "&_ 
			"HomeCare_Atendimento_Status ON HomeCare_Atendimento.id_Atendimento_Status = HomeCare_Atendimento_Status.id INNER JOIN "&_ 
			"HomeCare_Atendimento_Status_Condicoes_Alta ON  "&_ 
			"HomeCare_Atendimento.id_Atendimento_Status_Condicoes_Alta = HomeCare_Atendimento_Status_Condicoes_Alta.id "&_ 
			"WHERE (View_Atendimento_Funcionarios.id_Funcionario = '"&Session("id_Funcionario")&"') " &_ 
			"Order By HomeCare_Atendimento.id_Atendimento_Status_Condicoes_Alta "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>&nbsp;</Td>" & Chr(10)
							Response.Write "<Td>Nº Atend.:</Td>" & Chr(10)
							Response.Write "<Td>Paciente:</Td>" & Chr(10)
							Response.Write "<Td>Convênio:</Td>" & Chr(10)
							Response.Write "<Td>Status:</Td>" & Chr(10)
							Response.Write "<Td>Status de Alta:</Td>" & Chr(10)	
							Response.Write "<Td colspan='2'>&nbsp;</Td>" & Chr(10)
						Response.Write "</Tr>"

					For x = 1 To Rs.Pagesize
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit

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
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						if Cstr(request("PintaTR")) = Cstr(Rs("id_Paciente")) Then zebrado = "zebra3" End if 'Somente para traser pintado o registroda lista que ele selecionou
						Response.Write "<Tr "& "style='Cursor: Pointer;'  onClick=""location.href='default.asp?action=Form_Agenda&id_Atendimento=" &rs("id_Atendimento")& "&id_Paciente="&Rs("id_Paciente")&" '""" &" >" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Flg_Imagem&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("id_Atendimento")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Nome")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Convenio")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Status_Atendimento")&"<br>"&Solicitacao_Texto&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Atendimento_Status_Condicoes_Alta")&"<br>"&Solicitacao_Texto&"</Td>" & Chr(10)
							Response.Write "<td class='"&zebrado&"' align='center'>"& "<a href='default.asp?action=Form_Agenda&id_Atendimento=" &rs("id_Atendimento")& "&id_Paciente="&Rs("id_Paciente")&"'><img src='/SmartCare/images/ico_editar.gif' border='0' alt='Ver Agendamentos'   ></a>" & "</td>" & Chr(10) 
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
					Response.Write "</Table>"
				Else 'Caso não seja encontrado nenhum registro
					Response.Write "<Table width='100%' border='0'><tr><td align ='center' class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if

			Rs.Close
			Set Rs = Nothing
End Function

'Função que retorna a cadastro do pacinte, porem tem que ser passado os parametros de busca para isso
Function Carrega_Dados_Cadastro_Pacientes(id_Paciente)

	SQL =	"SELECT  TOP 1 Pacientes.*, dbo.FuncaoConvenioNome(Pacientes.id_convenio) AS Convenio_Nome, Cobertura.Nome AS Zona, "&_ 
			"Pacientes.id_cobertura AS id_Cobertura "&_ 
			"FROM Pacientes INNER JOIN "&_ 
			"Cobertura ON Pacientes.id_cobertura = Cobertura.id " &_ 
			"WHERE (Pacientes.id = '"&id_Paciente&"') "  
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				IF not rs.eof then 'Verifica se existem registros
				
					IF Rs("Particular")	Then Tipo_Plano = "Pessoa Fisica" Else Tipo_Plano = "Pessoa Juridica" End if
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

'Function que monta um list box com os horarios
Function ListBoxHora(NomeCampo,valor)

	Content = ""
	Content = Content & "<select name='"&NomeCampo&"'>"
	Content = Content & "<option value=''><-></option>"
	For x = 0 To 23
		Selected = ""
		If Cstr(x) = Cstr(valor) Then Selected = "selected"	End if
		if Len(x) = 1 Then x = "0" & x End if
		Content = Content & "<option value='"&x&"' "&Selected&" >"&x&"h</option>" & Chr(10)
	Next
	Content = Content & "</select>"
	ListBoxHora = Content

End Function

'Function que monta um list box com os minutos
Function ListBoxMinuto(NomeCampo,valor)

	Content = ""
	Content = Content & "<select name='"&NomeCampo&"'>"
	Content = Content & "<option value=''><-></option>"
	For x = 0 To 59
		Selected = ""
		If Cstr(x) = Cstr(valor) Then Selected = "selected"	End if
		if Len(x) = 1 Then x = "0" & x End if
		Content = Content & "<option value='"&x&"' "&Selected&" >"&x&"m</option>" & Chr(10)
	Next
	Content = Content & "</select>"
	ListBoxMinuto = Content

End Function

Function Visualiza_Agendamentos

	SQL =	"SELECT dbo.Agenda.id AS id_Agenda, dbo.Agenda.id_Funcionario, dbo.Agenda.id_Atendimento, dbo.Agenda.Descricao, "&_ 
			"dbo.Agenda.Data_Inicio, dbo.Agenda.Data_Final, dbo.Pacientes.nome AS Nome_Paciente, dbo.Convenios.Convenio, dbo.Pacientes.id AS id_Paciente, "&_ 
			"dbo.Agenda_Status.Descricao AS Agenda_Status, dbo.Agenda_Tipo.Descricao AS Agenda_Tipo "&_ 
			"FROM dbo.Agenda INNER JOIN "&_ 
			"dbo.HomeCare_Atendimento ON dbo.Agenda.id_Atendimento = dbo.HomeCare_Atendimento.id INNER JOIN "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento ON " &_ 
			"dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento = dbo.HomeCare_Solicitacao_Atendimento.id INNER JOIN "&_ 
			"dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id INNER JOIN "&_ 
			"dbo.Convenios ON dbo.HomeCare_Solicitacao_Atendimento.id_Convenio = dbo.Convenios.id INNER JOIN "&_ 
			"dbo.Agenda_Status ON dbo.Agenda.id_Status = dbo.Agenda_Status.id INNER JOIN "&_ 
			"dbo.Agenda_Tipo ON dbo.Agenda.id_Tipo = dbo.Agenda_Tipo.id AND dbo.Agenda.id_Tipo = dbo.Agenda_Tipo.id "&_ 
			"WHERE (dbo.Agenda.id_Funcionario = '"&Session("id_Funcionario")&"') AND (dbo.Agenda.id_Atendimento = '"&Request("id_Atendimento")&"') "&_ 
			"ORDER BY dbo.Agenda.Data_Inicio Desc "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>Código:</Td>" & Chr(10)
							Response.Write "<Td>Nº Atend.:</Td>" & Chr(10)
							Response.Write "<Td>Paciente:</Td>" & Chr(10)
							Response.Write "<Td>Tipo:</Td>" & Chr(10)
							Response.Write "<Td>Status:</Td>" & Chr(10)
							Response.Write "<Td>Convênio:</Td>" & Chr(10)
							Response.Write "<Td>Data e Hora Inicial:</Td>" & Chr(10)
							Response.Write "<Td>Data e Hora Final:</Td>" & Chr(10)
							Response.Write "<Td colspan='2'>&nbsp;</Td>" & Chr(10)
						Response.Write "</Tr>"

					For x = 1 To Rs.Pagesize
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit

						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						if Cstr(request("PintaTR")) = Cstr(Rs("Nome_Paciente")) Then zebrado = "zebra3" End if 'Somente para traser pintado o registroda lista que ele selecionou
						Response.Write "<Tr "& "style='Cursor: Pointer;'  onClick=""location.href='default.asp?action=EditarAgenda&id_Atendimento=" &rs("id_Atendimento")& "&id_Agenda="&Rs("id_Agenda")&"&id_Paciente="&Rs("Id_Paciente")&" '""" &" >" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("id_Agenda")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("id_Atendimento")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Nome_Paciente")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Agenda_Tipo")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Agenda_Status")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Convenio")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Data_Inicio")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Data_Final")&"</Td>" & Chr(10)
							Response.Write "<td class='"&zebrado&"' align='center'>"& "<a href='default.asp?action=EditarAgenda&id_Atendimento=" &rs("id_Atendimento")& "&id_Agenda="&Rs("id_Agenda")&"&id_Paciente="&Rs("id_Paciente")&" '><img src='/SmartCare/images/ico_editar.gif' border='0' alt='Ver Agendamentos'   ></a>" & "</td>" & Chr(10) 
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
					Response.Write "</Table>"
				Else 'Caso não seja encontrado nenhum registro
					Response.Write "<Table width='100%' border='0'><tr><td align ='center' class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if

			Rs.Close
			Set Rs = Nothing

End Function

Function Validacao


if Request("Hora_Final") < Request("Hora_Inicio") Then
	Response.Write "<script>alert('A hora final esta incompativel com a hora inicial do agendamento')</script>"
	Response.Write "<script>javascript:history.go(-1)</script>"
	response.end
End if

End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR NOVOS REGISTROS
Function IncluirCargos

Call Validacao

'Formato da data dd/mmmm/aa hh:mm:ss
Data_Inicio =  Request("Data_Inicio") & " " & Request("Hora_Inicio") & ":" & Request("Minuto_Inicio") & ":" & "00"
Data_Final =   Date & " " & Request("Hora_Final") & ":" & Request("Minuto_Final") & ":" & "00"

	SQL = 	"INSERT INTO AGENDA (id_Atendimento,id_Funcionario,id_Tipo,id_Status,Descricao,Data_Inicio,Data_Final) VALUES ( '"&Cint(Request("id_Atendimento"))&"' , '"&Session("id_Funcionario")&"' , '"&Cint(Request("id_Tipo"))&"' , '"&Cint(Request("id_Status"))&"' , '"&Trim(Replace(Request("Descricao"),"'","''"))&"' , '"&Data_Inicio&"' ,  '"&Data_Final&"'  ) "
			conn.execute(SQL)
			response.write "<script>location = 'default.asp?Action=Form_Agenda&id_Atendimento="&Request("id_Atendimento")&"&id_Paciente="&Request("id_Paciente")&"' </script>"
End Function

Function EditarAgenda

	SQL =	"SELECT dbo.Agenda.id AS id_Agenda, dbo.Agenda.id_Funcionario, dbo.Agenda.id_Atendimento, dbo.Agenda.Descricao, " &_ 
            "dbo.Agenda.Data_Inicio, dbo.Agenda.Data_Final, dbo.Pacientes.nome AS Nome_Paciente, dbo.Convenios.Convenio, dbo.Agenda.id_Status, dbo.Agenda.id_Tipo "&_ 
			"FROM dbo.Agenda INNER JOIN "&_ 
			"dbo.HomeCare_Atendimento ON dbo.Agenda.id_Atendimento = dbo.HomeCare_Atendimento.id INNER JOIN "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento ON "&_ 
			"dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento = dbo.HomeCare_Solicitacao_Atendimento.id INNER JOIN "&_ 
			"dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id INNER JOIN "&_ 
			"dbo.Convenios ON dbo.HomeCare_Solicitacao_Atendimento.id_Convenio = dbo.Convenios.id "&_ 
			"WHERE (dbo.Agenda.id = '"&Request("id_Agenda")&"') AND (dbo.Agenda.id_Atendimento = '"&Request("id_Atendimento")&"') "&_ 
			"ORDER BY dbo.Agenda.Data_Inicio "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
				
					Descricao = Rs("Descricao")
					Data_Inicio = Day(Rs("Data_Inicio")) & "/" &  Month(Rs("Data_Inicio")) & "/" & Year(Rs("Data_Inicio"))
					Hora_Inicio = Hour(Rs("Data_Inicio"))
					Minuto_Inicio = Minute(Rs("Data_Inicio"))
					Hora_Fim = Hour(Rs("Data_Final"))
					Minuto_Fim = Minute(Rs("Data_Final"))
					id_Status = Rs("id_Status")
					id_Tipo = Rs("id_Tipo")	
					
					
				End if

			Rs.Close
			Set Rs = Nothing


End Function

Function AlterarAgenda

	'Formato da data dd/mmmm/aa hh:mm:ss
	Data_Inicio =  Request("Data_Inicio") & " " & Request("Hora_Inicio") & ":" & Request("Minuto_Inicio") & ":" & "00"
	Data_Final =   Date & " " & Request("Hora_Final") & ":" & Request("Minuto_Final") & ":" & "00"

	SQL	=	"Update Agenda SET id_Status = '"&Trim(Replace(Request("id_Status"),"'",""))&"' , id_Tipo = '"&Trim(Replace(Request("id_Tipo"),"'",""))&"' , Descricao = '"&Trim(Replace(Request("Descricao"),"'",""))&"' , Data_Inicio = '"&Data_Inicio&"' , Data_Final = '"&Data_Final&"' Where id = "&Cint(Request("id_Agenda"))
				conn.execute(SQL)
				response.write "<script>location = 'default.asp?action=Form_Agenda&id_Atendimento="&Request("id_Atendimento")&"&id_Paciente="&Request("id_Paciente")&"' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "IncluirCargos"
		Call IncluirCargos
		
	Case "EditarAgenda"
		Call EditarAgenda
%>
	<!-- #include virtual="/SmartCare/Agenda/Modelos/Form_Agenda_Editar.htm" -->
<%	
	Case "Form_Agenda"
%>
	<!-- #include virtual="/SmartCare/Agenda/Modelos/Form_Agenda.htm" -->
<%
	Case "AlterarAgenda"
		Call AlterarAgenda
	
	Case Else
%>
	<!-- #include virtual="/SmartCare/Agenda/Modelos/Form_Visualizar.htm" -->
<%

End Select


%>


