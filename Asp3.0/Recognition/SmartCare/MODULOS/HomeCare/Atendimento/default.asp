<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.Js" -->
<!-- #include virtual="/SmartCare/Modulos/HomeCare/Atendimento/JS/validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 27/07/2005
' Descrição: Pagina de administração de atendimentos
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim id,id_Solicitacao_Atendimento,id_Atendimento_Status,id_Atendimento_Status_Condicoes_Alta,Data_Cadastro_Atendimento,Data_Fechamento_Atendimento,Solicitacao_Requisicao_Tipo,Data_fechamento_Solicitacao
Dim id_Paciente,Zona,id_cobertura,Data_Cadastro_Paciente,Nome_Paciente,Data_Nascimento,RG,CPF,Convenio,Particular,Endereco,Cidade,Bairro,UF,Telefones,Responsavel,Cuidador
Dim id_Solicitacao_Requisicao_Tipo,id_Hospital, Hospital_Nome,Tipo_Requisicao_Outros,Medico_Solicitante,Medico_Solicitante_CRM,Medico_Solicitante_Contato
Dim id_Funcionario_Medico_Avaliador,Medico_Avaliador_Data,id_Funcionario_Enfermeiro_Avaliador,Enfermeiro_Avaliador_Data,id_Funcionario_Assistente_Social_Avaliador,Assistente_Social_Avaliador_Data,id_Funcionario_Fisioterapeuta_Avaliador,Assistente_Fisioterapeuta_Data
Dim id_Solicitacao_Status,Motivo_Solicitacao_Negada,Solicitacao_Status,Data_Cadastro_Solicitacao,Data_Fechamento

'[CONEXÃO COM O BANCO DE DADOS]
set Conn = Server.CreateObject( "ADODB.Connection" )
Conn.CursorLocation = 3 'adUserClient
Conn.Open application("connstring")

'Função que mostra todas os atendimento
Function VisualizarAtendimentos

	dim pag
	regs = 20 'Aqui setamos quantos registros serão listados por página. 
	pag = request.querystring("pagina")
	if pag = "" Then pag = 1 end if
	set rs = createobject("adodb.recordset")
	rs.cursortype = 3 'Definimos o cursor a ser utilizado
	rs.pagesize = regs

	RS.CursorLocation = 3 

	'ESTE IF VERIFICA SE O USUARIO LOGADO É UM FUNCIONARIO OU UM CONTATO DO CONVENIO, ESTE IF É IMPORTANTE POIS SE FOR UM CONTATO DO CONVENIO ENTÃO SEMPRE FILTRA OS ATENDIMENTOS DO CONVENIO E NAO DOS OUTROS CONVENIOS
	IF Session("id_Convenio") = "0" Then id_Convenio = Request("id_Convenio") Else id_Convenio = Session("id_Convenio") End if

	SQL	=	"EXEC HomeCare_Atendimento_Visualizar '"&Trim(Replace(Request("id_Atendimento"),"'",""))&"' , '"&Trim(Replace(Request("id_Solicitacao"),"'",""))&"' , '"&Trim(Replace(Request("Busca"),"'",""))&"' , '"&Trim(Replace(Request("Date"),"'",""))&"' , '"&id_Convenio&"' , '"&Trim(Request("Data_Inicial"))&"' , '"&Trim(Request("Data_Final"))&"' , '"&Trim(Request("Particular"))&"' , '"&Trim(Request("id_Atendimento_Status"))&"' , '"&Trim(Request("id_Atendimento_Status_Condicoes_Alta"))&"' ,  '"&Trim(Replace(Request("id_Funcionario"),"'",""))&"' ,  '"&Trim(Replace(Request("id_Contrato_Servico"),"'",""))&"'  "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					rs.absolutepage = pag
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>&nbsp;</Td>" & Chr(10)
							Response.Write "<Td>Nº:</Td>" & Chr(10)
							Response.Write "<Td>Solicitação:</Td>" & Chr(10)
							Response.Write "<Td>Dt. Abertura:</Td>" & Chr(10)
							Response.Write "<Td>Tempo:</Td>" & Chr(10)
							Response.Write "<Td>Paciente:</Td>" & Chr(10)
							Response.Write "<Td>Convênio:</Td>" & Chr(10)
							Response.Write "<Td>Status:</Td>" & Chr(10)
							Response.Write "<Td>Status de Alta:</Td>" & Chr(10)
							Response.Write "<Td>Total Func.:</Td>" & Chr(10)	
							Response.Write "<Td colspan='2'>&nbsp;</Td>" & Chr(10)
						Response.Write "</Tr>"
					For x = 1 To Rs.Pagesize
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						if rs("id_Atendimento_Status_Condicoes_Alta") <> "1" Then  'Faz a verificação para saber se o status não esta em analise, caso nao esteja entao coloca uma figura do cadeado e nao habilita o link para edicao e o link da TR somente abrira a Popup para visualizar o atendimento
							imagem = "<img src='/SmartCare/images/ico_cadeado.gif' border='0' alt='Paciente não esta em atendimento'   >" 
							Link_Tr =  "style='Cursor: Pointer;' onClick="" javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Atendimento/ImprimirAtendimento.asp?id_Atendimento="&rs("id")&"','850','680',this,event)  "" "
							Else  'Caso ainda esteja em edicao entao é colocado a imagem de edicao e o link de acesso e o Link da TR servira tb para editar o atendimento
								If Session("Tipo_Login") = "1" Then
							imagem = "<a href='default.asp?action=Editar_Atendimento&id_Atendimento=" &rs("id")& "&id_Solicitacao_Atendimento="&Rs("id_Solicitacao_Atendimento")&"'><img src='/SmartCare/images/ico_editar.gif' border='0' alt='Alterar Atendimento'   ></a>"
							Link_Tr = "style='Cursor: Pointer;'  onClick=""location.href='default.asp?action=Editar_Atendimento&id_Atendimento=" &rs("id")& "&id_Solicitacao_Atendimento="&Rs("id_Solicitacao_Atendimento")&" '"" "
							End if
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
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						if Cstr(request("PintaTR")) = Cstr(Rs("id")) Then zebrado = "zebra3" End if 'Somente para traser pintado o registroda lista que ele selecionou
						Response.Write "<Tr "&Link_Tr&" >" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Flg_Imagem&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' ><b>"&Rs("id")&"</b></Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("id_Solicitacao_Atendimento")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&TempoDecorrido(ArrumaDataHora(Rs("Data_Cadastro")),ArrumaDataHora(Rs("Data_Fechamento")))&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Nome")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Convenio")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Status_Atendimento")&"<br>"&Solicitacao_Texto&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Atendimento_Status_Condicoes_Alta")&"<br>"&Solicitacao_Texto&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Total_Funcionarios")&"</Td>" & Chr(10)
							Response.Write "<td class='"&zebrado&"' align='center'>&nbsp;"& imagem & "</td>" & Chr(10) 
							Response.Write "<td class='"&zebrado&"' align='center'>"&"<a href=""javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Atendimento/ImprimirAtendimento.asp?id_Atendimento="&rs("id")&"','850','680',this,event)""><img src='/SmartCare/images/ico_impressora.gif' border='0' Alt='Visualizar Solicitação / Imprimir Atendimento'   ></a>" &  "</td>" & Chr(10) 
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
					Response.Write "</Table>"
				Else 'Caso não seja encontrado nenhum registro
					Response.Write "<Table width='100%' border='0'><tr><td align ='center' class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
					'Inicio da paginação
							'Caso tenha algum campo de busca na pagina coloque aqui o nome dele. Isso foi feito para nãi ter que ficar colocando em varios lugares
							VariaveisBusca = "Action="&Request("action")&"&data_inicial="&Request("data_inicial")&"&data_final="&Request("data_final")&"&id_Atendimento="&Request("id_Atendimento")&"&id_Solicitacao="&Request("id_Solicitacao")&"&Busca="&Request("Busca")&"&id_Atendimento_Status="&Request("id_Atendimento_Status")&"&id_Atendimento_Status_Condicoes_Alta="&Request("id_Atendimento_Status_Condicoes_Alta")&"&id_Convenio="&Request("id_Convenio")&"&Particular="&Request("Particular")&"&id_Funcionario="&Request("id_Funcionario")&"&Contrato_Servico="&Request("Contrato_Servico")&"  "
							Response.Write "<div align='center' class='texto'>"&"Total de registros encontrados: " & rs.RecordCount & "</Div>"
							Response.Write "<div align='center' class='texto'>Página <b>" & pag & "</b> de " & rs.PageCount & "</Div>"
							If rs.PageCount <= 5 Then
								pinicial = 1
								pfinal = rs.PageCount
							Else
								pinicial = pag - pag mod 15 + 1
								pfinal = pag - pag mod 15 + 15
								If pinicial = pag + 1 Then
									pinicial = pinicial - 15
									pfinal = pfinal - 15
								End If
								If pfinal > rs.PageCount Then
									pfinal = rs.PageCount
								End If
							End If
							Response.Write "<div align='center' class='texto'>"
							If pag > 1 Then Response.Write "<a href=""" & SCRIPT_NAME & "?"&VariaveisBusca&"&pagina=" & pag - 1 & """>&lt;&lt; Anterior</a> |" 
							While pinicial <= pfinal
								If trim(pinicial) = trim(n) Then Response.Write "<b>" 
								Response.Write	"<a href=""" & SCRIPT_NAME & "?"&VariaveisBusca&"&pagina=" & pinicial & """>" & pinicial & "</a> " 
								If trim(pinicial) = trim(n) Then Response.Write "</b>"
								pinicial = pinicial + 1
							Wend
							If Abs(pag) < Abs(rs.PageCount) Then Response.Write "| <a href=""" & SCRIPT_NAME & "default.asp?"&VariaveisBusca&"&pagina=" & pag + 1 & """>Próxima &gt;&gt;</a>" 
							Response.Write "</div>"
					'Fim da paginação					

			Rs.Close
			Set Rs = Nothing

End Function

'Função responsavel por verificar se a solicitacao existe
Function VerificaSolicitacaoStatus(id_Solicitacao)

If Trim(id_Solicitacao) <> "" Then
	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = 	"SELECT dbo.HomeCare_Solicitacao_Atendimento.id, dbo.HomeCare_Solicitacao_Atendimento.id_Solicitacao_Status, ISNULL(dbo.HomeCare_Atendimento.id, 0) AS id_Atendimento " &_ 
			"FROM dbo.HomeCare_Solicitacao_Atendimento LEFT OUTER JOIN " &_ 
			"dbo.HomeCare_Atendimento ON dbo.HomeCare_Solicitacao_Atendimento.id = dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento " &_ 
			"WHERE (dbo.HomeCare_Solicitacao_Atendimento.id = '"&id_Solicitacao&"') "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
						If Rs("id_Atendimento") <> "0" Then 'Verifica se a solicitacao tem um atendimento em aberto
							VerificaSolicitacaoStatus = False
							Response.Write("<Script>alert('Já existe um atendimento aberto para a solicitação nº "& id_Solicitacao &" \nAtendimento nº "& Rs("id_Atendimento") &" ')</Script>")
							Response.end
						Else
							If Rs("id_Solicitacao_Status") = "2" Then 'Solicitacao esta aceita
								VerificaSolicitacaoStatus = True
								Else 'Colicitacao esta com outro status que nao é o aceito
								VerificaSolicitacaoStatus = False
								Response.Write("<Script>alert('A solicitação nº "& id_Solicitacao &" encontra-se com status em Analise')</Script>")
								Response.end
							End if
						End if
					Else 'Solicitacao nao encontrada
						VerificaSolicitacaoStatus = False
						Response.Write("<Script>alert('A solicitação nº "& id_Solicitacao &" não foi localizada')</Script>")
						Response.end
				End IF
			Rs.Close
			Set Rs = Nothing
End if
			
End Function

'Função que retorna a cadastro do pacinte, porem tem que ser passado os parametros de busca para isso
Function Carrega_Dados_Cadastro_Pacientes(id_Solicitacao_Atendimento)

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL =	"SELECT TOP 1 dbo.HomeCare_Solicitacao_Atendimento.id AS id_Solicitacao_Atendimento, dbo.Pacientes.*, "&_ 
            "dbo.FuncaoConvenioNome(dbo.Pacientes.id_convenio) AS Convenio_Nome, dbo.Cobertura.Nome AS Zona , dbo.Pacientes.id_cobertura AS id_Cobertura " &_ 
			"FROM dbo.Pacientes INNER JOIN "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento ON dbo.Pacientes.id = dbo.HomeCare_Solicitacao_Atendimento.id_Paciente INNER JOIN "&_ 
			"dbo.Cobertura ON dbo.Pacientes.id_cobertura = dbo.Cobertura.id "&_ 
			"WHERE (dbo.HomeCare_Solicitacao_Atendimento.id = '"&Cint(id_Solicitacao_Atendimento)&"') AND (dbo.HomeCare_Solicitacao_Atendimento.id_Solicitacao_Status = 2) " 
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					id_cobertura = Rs("id_cobertura")
					IF Rs("Particular")	Then Tipo_Plano = "Pessoa Fisica" Else Tipo_Plano = "Pessoa Juridica" End if
					Response.Write "<input name='id_Atendimento' type='hidden' value='"&Request("id_Atendimento")&"'>"
					Response.Write "<input name='id_Solicitacao_Atendimento' type='hidden' value='"&Rs("id_Solicitacao_Atendimento")&"'>"
					Response.Write "<input name='id_cobertura' type='hidden' value='"&Rs("id_cobertura")&"'>"
					Response.Write "<fieldset>"
					Response.Write "<legend>&nbsp;Cadastro Paciente&nbsp;</legend>"

					Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>" & Chr(10)
					  Response.Write "<tr class='zebra_orange1'> "& Chr(10)
						Response.Write "<td width='8%'><b>Identificação:</b></td>" & Chr(10)
						Response.Write "<td width='25%'>"&Rs("Nome")&"</td>" & Chr(10)
						Response.Write "<td width='13%'><b>Data Nasc.:</b></td>" & Chr(10)
						Response.Write "<td width='22%'>"&ArrumaData(Rs("data_nascimento"))&"</td>" & Chr(10)
						Response.Write "<td width='8%'>&nbsp;</td>" & Chr(10)
						Response.Write "<td colspan='3'>&nbsp;</td>" & Chr(10)
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

'Função que carrega todos os CID10 que a solicitacao tem
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

'Função que carrega todos os CID10 que o paciente deu entrada na solicitacao
Function Carrega_CID10_Entrada(id_Solicitcao_Atendimento)

	SQL = 	"SELECT dbo.HomeCare_Diagnostico_Entrada.id,dbo.Diagnostico.CID10, dbo.Diagnostico.DESCRICAO , Data_Cadastro " &_ 
			"FROM dbo.Diagnostico INNER JOIN " &_ 
            "dbo.HomeCare_Diagnostico_Entrada ON dbo.Diagnostico.CID10 = dbo.HomeCare_Diagnostico_Entrada.CID10 " &_ 
			"Where id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"' " &_ 
			"Order by dbo.HomeCare_Diagnostico_Entrada.Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>CID10:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='59%' valign='top'><b>Diagnostico:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='13%' valign='top'><b>Data:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' valign='top' align='center'>"&Trim(Rs("CID10"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)

					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todas as solicitações que a solicitacao tem
Function Carrega_Prescricao_Medica_Itens(id_Atendimento)

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
			"WHERE (HomeCare_Atendimento_Prescricao_Medica.id_Atendimento = '"&id_Atendimento&"') " &_ 
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
							Response.Write "<td class='texto' valign='middle' align='center' >"&img&"</td>" & CHR(10)
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

'Função que carrega todas as solicitações de entrada
Function Carrega_Solicitacao_Medica_Entrada(id_Solicitcao_Atendimento)

	SQL = "Select *  From HomeCare_Solicitacao_Medica_Itens Where id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"' Order by Solicitacao_Entrada "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='27%' valign='top'><b>Prescrição:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='12%' valign='top'><b>Qtd Dias:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='12%' valign='top'><b>Data:</b></td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						
						  Response.Write "<tr class='zebra_orange1' >" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qdt_Dias"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todos os médicos envolvidos no atendimento
Function Carrega_Lista_Medicos(id_Atendimento)

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
			"WHERE (dbo.HomeCare_Atendimento_Medicos.id_Atendimento = '"&id_Atendimento&"') " &_
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
							imagem = "<img src='/SmartCare/images/ico_editar.gif' border='0' Onclick=""DeletarMedicos( "&Rs("id")&" , "&Rs("id_Atendimento")&" , '"&Rs("Nome")&"' )"" >"
						    'Foi colocado esta campo hidden pois quando for gravar a prescriçaõ é obrigatorio gravar o medico que esta fazendo a prescrição e como o atendimento só pode ter um medico resposavel entao foi adicionado este campo hidden para saber quem é o medico resposavel para ser gravado na tabela de prescrições	
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

'Função que carrega todos os enfermeiros envolvidos no atendimento
Function Carrega_Lista_Enfermeiros(id_Atendimento)

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
			"WHERE (dbo.HomeCare_Atendimento_Enfermeiro.id_Atendimento = '"&id_Atendimento&"') " &_
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
						  	imagem = "<img src='/SmartCare/images/ico_cadeado.gif' border='0' alt='Enfermeiro foi desativado deste atendimento'   >" 
							Else  'Caso ainda esteja em edicao entao é colocado a imagem de edicao e o link de acesso e o Link da TR servira tb para editar o atendimento
							imagem = "<img src='/SmartCare/images/ico_editar.gif' border='0' Onclick=""DeletarEnfermeiros( "&Rs("id")&" , "&Rs("id_Atendimento")&" , '"&Rs("Nome")&"' )"" >"
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

'Função que carrega todos os Aux. Enfermagem envolvidos no atendimento
Function Carrega_Lista_Enfermagem(id_Atendimento)

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
			"WHERE (dbo.HomeCare_Atendimento_Enfermagem.id_Atendimento =  '"&id_Atendimento&"') " &_ 
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

'Função que carrega todos os fisioterapeutas envolvidos no atendimento
Function Carrega_Lista_Fisioterapeuta(id_Atendimento)

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
			"WHERE (dbo.HomeCare_Atendimento_Fisioterapia.id_Atendimento = '"&id_Atendimento&"') " &_ 
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

'Função que carrega todos os outros servicos envolvidos no atendimento
Function Carrega_Lista_Outros_Servicos(id_Atendimento)

	SQL = 	"SELECT dbo.HomeCare_Atendimento_Outros_Servicos.id, dbo.Funcionarios.nome, dbo.Funcionarios.CODIGO_MEDICO, " &_ 
			"dbo.HomeCare_Periodicidade.Descricao AS Periodicidade, dbo.HomeCare_Atendimento_Outros_Servicos.QTD, " &_ 
			"dbo.Contrato_Servico.Nome AS Contrato_Servico, dbo.HomeCare_Atendimento_Outros_Servicos.Data_Cadastro, " &_ 
			"dbo.HomeCare_Atendimento_Outros_Servicos.id_Atendimento, dbo.HomeCare_Atendimento_Outros_Servicos.id_Funcionario, dbo.HomeCare_Atendimento_Outros_Servicos.obs "&_ 
			"FROM dbo.HomeCare_Atendimento_Outros_Servicos INNER JOIN " &_ 
			"dbo.Contrato_Servico ON dbo.HomeCare_Atendimento_Outros_Servicos.id_Contrato_Servico = dbo.Contrato_Servico.id INNER JOIN " &_ 
			"dbo.Funcionarios ON dbo.HomeCare_Atendimento_Outros_Servicos.id_Funcionario = dbo.Funcionarios.id INNER JOIN " &_ 
			"dbo.HomeCare_Periodicidade ON dbo.HomeCare_Atendimento_Outros_Servicos.id_Periodicidade = dbo.HomeCare_Periodicidade.id "&_ 
			"WHERE (dbo.HomeCare_Atendimento_Outros_Servicos.id_Atendimento = '"&id_Atendimento&"' ) " &_ 
			"ORDER BY dbo.HomeCare_Atendimento_Outros_Servicos.Data_Cadastro "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
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
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"">" & CHR(10)
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
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Nenhum serviço foi encontrado</b></TD></TR></Table>"	
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todos os equipamentos envolvidos no atendimento
Function Carrega_Lista_Equipamentos(id_Atendimento)

	SQL = 	"SELECT dbo.HomeCare_Atendimento_Equipamentos.Simpro, dbo.SIMPRO.DESCRICAO, dbo.HomeCare_Atendimento_Equipamentos.qtd, "&_ 
			"dbo.Fornecedores.Fornecedor, dbo.HomeCare_Atendimento_Equipamentos.Data_Cadastro, " &_ 
			"dbo.HomeCare_Atendimento_Equipamentos.id,  dbo.HomeCare_Atendimento_Equipamentos.id_Atendimento " &_ 
			"FROM dbo.HomeCare_Atendimento_Equipamentos INNER JOIN " &_ 
			"dbo.Fornecedores ON dbo.HomeCare_Atendimento_Equipamentos.id_Fornecedor = dbo.Fornecedores.id INNER JOIN " &_ 
			"dbo.SIMPRO ON dbo.HomeCare_Atendimento_Equipamentos.Simpro = dbo.SIMPRO.CD_SIMPRO " &_ 
			"WHERE (dbo.HomeCare_Atendimento_Equipamentos.id_Atendimento = '"&id_Atendimento&"') " &_ 
			"Order By Data_Cadastro "
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

'Função que carrega todos os materiais envolvidos no atendimento
Function Carrega_Lista_Materiais(id_Atendimento)

	SQL = 	"SELECT dbo.HomeCare_Atendimento_Materiais.Simpro, dbo.SIMPRO.DESCRICAO, dbo.HomeCare_Atendimento_Materiais.Qtd, dbo.Fornecedores.Fornecedor, " &_ 
			"dbo.HomeCare_Atendimento_Materiais.Data_Cadastro, dbo.HomeCare_Atendimento_Materiais.id,  " &_ 
			"dbo.HomeCare_Atendimento_Materiais.id_atendimento " &_ 
			"FROM dbo.HomeCare_Atendimento_Materiais INNER JOIN " &_ 
			"dbo.Fornecedores ON dbo.HomeCare_Atendimento_Materiais.id_Fornecedor = dbo.Fornecedores.id INNER JOIN " &_ 
			"dbo.SIMPRO ON dbo.HomeCare_Atendimento_Materiais.Simpro = dbo.SIMPRO.CD_SIMPRO " &_ 
			"WHERE     (dbo.HomeCare_Atendimento_Materiais.id_atendimento = '"&id_Atendimento&"') " &_ 
			"Order By Data_Cadastro "
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

'Função que carrega todos os medicamentos envolvidos no atendimento
Function Carrega_Lista_Medicamentos(id_Atendimento)

	SQL = 	"SELECT dbo.HomeCare_Atendimento_Medicamentos.Simpro, dbo.SIMPRO.DESCRICAO, dbo.HomeCare_Atendimento_Medicamentos.qtd, "&_ 
			"dbo.Fornecedores.Fornecedor, dbo.HomeCare_Atendimento_Medicamentos.Data_Cadastro, dbo.HomeCare_Atendimento_Medicamentos.id, " &_ 
			"dbo.HomeCare_Atendimento_Medicamentos.id_Atendimento " &_ 
			"FROM dbo.HomeCare_Atendimento_Medicamentos INNER JOIN " &_ 
			"dbo.Fornecedores ON dbo.HomeCare_Atendimento_Medicamentos.id_Fornecedor = dbo.Fornecedores.id INNER JOIN " &_ 
			"dbo.SIMPRO ON dbo.HomeCare_Atendimento_Medicamentos.Simpro = dbo.SIMPRO.CD_SIMPRO " &_ 
			"WHERE (dbo.HomeCare_Atendimento_Medicamentos.id_Atendimento = '"&id_Atendimento&"') " &_ 
			"Order By Data_Cadastro "
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
							Response.Write "<td class='texto' width='16%' valign='top'><b>Fornecedor:</b></td>" & CHR(10)
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

'Função resposavel por inserir a solicitação
Function IncluirAtendimento
	
	'Faz o insert do atendimento
	SQL = 	"INSERT INTO HomeCare_Atendimento (id_Solicitacao_Atendimento,id_Atendimento_Status,id_Atendimento_Status_Condicoes_Alta) VALUES ( '"&Cint(Request("id_Solicitacao_Atendimento"))&"' , '"&Cint(Request("id_Atendimento_Status"))&"' , 1 ) "
			On Error Resume Next 'Inicia o Tratamento de erro
				Conn.BeginTrans  'Inicia a Transação
				Conn.execute(SQL) 'Executa a Query
				id_Transacao = Conn.execute("SELECT @@IDENTITY")(0).Value
				Call Grava_Cid10(id_Transacao) 'Chama a funçao que ira inserir os disgnosticos. Já é passao do ID da transação atual
				Call Grava_Prescricao_Medica(id_Transacao) 'Chama a funçao que ira inserir as prescrições medicas. Já é passao do ID da transação atual
				Call Grava_Medico(id_Transacao) 'Chama a funçao que ira inserir o médico. Já é passao do ID da transação atual
				Call Grava_Enfermeiro(id_Transacao) 'Chama a funçao que ira inserir o Enfermeiro. Já é passao do ID da transação atual
				Call Grava_Enfermagem(id_Transacao) 'Chama a funçao que ira inserir a Enfermagem. Já é passao do ID da transação atual
				Call Grava_Fisioterapeuta(id_Transacao) 'Chama a funçao que ira inserir o Fisioterapeuta. Já é passao do ID da transação atual
				Call Grava_Outros_Servicos(id_Transacao) 'Chama a funçao que ira inserir Outros Serviços. Já é passao do ID da transação atual
				Call Grava_Equipamentos(id_Transacao) 'Chama a funçao que ira inserir os Equipamentos. Já é passao do ID da transação atual
				Call Grava_Materiais(id_Transacao) 'Chama a funçao que ira inserir os Materiais. Já é passao do ID da transação atual
				'Call Grava_Medicamentos(id_Transacao) 'Chama a funçao que ira inserir os Medicamentos. Já é passao do ID da transação atual
				Call Grava_Exames(id_Transacao) 'Chama a funçao que ira inserir os Exames. Já é passao do ID da transação atual
			If Err <> 0 Then 'Verifica se ocorreu algum erro
				Conn.RollbackTrans 'Se foi detectado algum erro entao a Transação é desfeita e nao é inserido nenhum registro
				Response.Write "Foi detectado um erro e a ação foi cancelada: " & Err.Description
				Response.End
				Else
					Conn.CommitTrans 'Caso não tenha ocorrido nenhum erro entao a transação é efeutuado com sucesso
					Call Dispara_Email_Abertura_Atendimento(id_Transacao) 'Chama a função responsavel por disparar o email avisando sobre o nome atendimento
					response.write "<script>location = 'default.asp?Date="&ArrumaData(Date)&"&PintaTR="&id_Transacao&"' </script>"
			End If

End Function

Function AlterarAtendimento

	If Request("id_Atendimento_Status_Condicoes_Alta") <> "1" Then Data_Fechamento = "'"&ArrumaDataHora(Now)&"'" Else Data_Fechamento = "Null" End if
	'Faz o update do atendimento
	SQL	=	"Update HomeCare_Atendimento SET id_Atendimento_Status = '"&Trim(Replace(Request("id_Atendimento_Status"),"'",""))&"' , id_Atendimento_Status_Condicoes_Alta = '"&Trim(Replace(Request("id_Atendimento_Status_Condicoes_Alta"),"'",""))&"' , Data_Fechamento = "&Data_Fechamento&" Where id = "&Cint(Request("id_Atendimento"))
			On Error Resume Next 'Inicia o Tratamento de erro
				Conn.BeginTrans  'Inicia a Transação
				Conn.execute(SQL) 'Executa a Query
				id_Transacao = Cint(Request("id_Atendimento"))
				Call Grava_Cid10(id_Transacao) 'Chama a funçao que ira inserir os disgnosticos. Já é passao do ID da transação atual
				Call Grava_Prescricao_Medica(id_Transacao) 'Chama a funçao que ira inserir as prescrições medicas. Já é passao do ID da transação atual
				Call Grava_Medico(id_Transacao) 'Chama a funçao que ira inserir o médico. Já é passao do ID da transação atual
				Call Grava_Enfermeiro(id_Transacao) 'Chama a funçao que ira inserir o Enfermeiro. Já é passao do ID da transação atual
				Call Grava_Enfermagem(id_Transacao) 'Chama a funçao que ira inserir a Enfermagem. Já é passao do ID da transação atual
				Call Grava_Fisioterapeuta(id_Transacao) 'Chama a funçao que ira inserir o Fisioterapeuta. Já é passao do ID da transação atual
				Call Grava_Outros_Servicos(id_Transacao) 'Chama a funçao que ira inserir Outros Serviços. Já é passao do ID da transação atual
				Call Grava_Equipamentos(id_Transacao) 'Chama a funçao que ira inserir os Equipamentos. Já é passao do ID da transação atual
				Call Grava_Materiais(id_Transacao) 'Chama a funçao que ira inserir os Materiais. Já é passao do ID da transação atual
				Call Grava_Medicamentos(id_Transacao) 'Chama a funçao que ira inserir os Medicamentos. Já é passao do ID da transação atual
				Call Grava_Exames(id_Transacao) 'Chama a funçao que ira inserir os Exames. Já é passao do ID da transação atual
			If Err <> 0 Then 'Verifica se ocorreu algum erro
				Conn.RollbackTrans 'Se foi detectado algum erro entao a Transação é desfeita e nao é inserido nenhum registro
				Response.Write "Foi detectado um erro e a ação foi cancelada: " & Err.Description
				Response.End
				Else
					Conn.CommitTrans 'Caso não tenha ocorrido nenhum erro entao a transação é efeutuado com sucesso
					'Verifica antes de enviar o email se os campos ocultos hidden são identicos aos campos oroginais que o usuario alterou
					if Request("id_Atendimento_Status") <> Request("id_Atendimento_Status_Verifica") OR Request("id_Atendimento_Status_Condicoes_Alta") <> Request("id_Atendimento_Status_Condicoes_Alta_Verifica")  Then
						Call Dispara_Email_Atendimento_Alteracao_Status(id_Transacao) 'Chama a função que ira Enviar um emails avisando a aleração de status do atendimento
					End if
					response.write "<script>location = 'default.asp?PintaTR="&request("id_atendimento")&"' </script>"
			End If

End Function

'Função que insere os CID10, Diagnosticos.
'Recebe o ID da trasação que esta sendo inserida o atendimento
Function Grava_Cid10(id_Atendimento)

	'Atenção no IF abaixo - Todo diagnostico tem que ter um medico resposavel. Vale lembrar quem existe uma função JS que faz a verificação quando o formulario é enviado para saber se o atendimento tem um medico resposavel
	'Verifica se o campo hidden com o id_funcionario esta vazio, ele pode estar vazio caso a pessoa delete o medico, entao, no caso se o campo hidden estar vazio e o campo do CRM estar preenchido entao ele chama a função que passa o CRM e retorna o id_funcionario
	If Request("id_Funcionario_Medico") = "" And Request("Medico_CRM") <> "" Then 
		id_Funcionario_Medico = Busca_ID_Funcionario(Request("Medico_CRM")) 'chama a função que passado o CRM devolve o id_Funcionario
	Else
		id_Funcionario_Medico = Request("id_Funcionario_Medico") 'Caso o campo hidden esteja com o id_funcionario entao é apenas atribuido
	End if
	
	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("CID10").Count

		'Verifica se o campo esta vazio
		If Request.Form("CID10")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Atendimento_Diagnostico (id_Atendimento,id_Funcionario,CID10) VALUES ( '"&id_Atendimento&"' , '"&TiraAspas(id_Funcionario_Medico)&"' , '"&TiraAspas(Request("CID10")(x))&"'  ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função que insere as Prescrições Medicas.
'Recebe o ID da trasação que esta sendo inserida o atendimento
Function Grava_Prescricao_Medica(id_Atendimento)
	'Atenção no IF abaixo - Toda prescrição medica tem que ter um medico resposavel. Vale lembrar quem existe uma função JS que faz a verificação quando o formulario é enviado para saber se o atendimento tem um medico resposavel
	'Verifica se o campo hidden com o id_funcionario esta vazio, ele pode estar vazio caso a pessoa delete o medico, entao, no caso se o campo hidden estar vazio e o campo do CRM estar preenchido entao ele chama a função que passa o CRM e retorna o id_funcionario
	If Request("id_Funcionario_Medico") = "" And Request("Medico_CRM") <> "" Then 
		id_Funcionario_Medico = Busca_ID_Funcionario(Request("Medico_CRM")) 'chama a função que passado o CRM devolve o id_Funcionario
	Else
		id_Funcionario_Medico = Request("id_Funcionario_Medico") 'Caso o campo hidden esteja com o id_funcionario entao é apenas atribuido
	End if
	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Prescricao_Medica_Descricao").Count

		'Verifica se o campo esta vazio
		If Request.Form("Prescricao_Medica_Descricao")(x) <> "" Then

			SQL = 	"INSERT INTO HomeCare_Atendimento_Prescricao_Medica (id_Atendimento,id_Funcionario,id_Periodicidade,id_Intervalo,id_Prescricao_Tipo,id_Prioridade,Descricao,Qdt_Dias,Dose,id_Via_Administracao) VALUES ( '"&id_Atendimento&"' , '"&TiraAspas(id_Funcionario_Medico)&"' , '"&Cint(Request("id_Periodicidade")(x))&"' , '"&Cint(Request("id_Intervalo")(x))&"' , '"&TiraAspas(Request("id_Prescricao_Tipo")(x))&"' , '"&TiraAspas(Request("id_Prescricao_Prioridade")(x))&"' , '"&TiraAspas(Request("Prescricao_Medica_Descricao")(x))&"' , '"&TiraAspas(Request("Prescricao_Medica_Qtd_Dias")(x))&"' , '"&TiraAspas(Request("Prescricao_Medica_Dose")(x))&"' , '"&Cint(Request("id_Via_Administracao")(x))&"' ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função que passado CODIGO do funcionario, que é o CRM,COREN,CREFITO,ETC, é feito a consulta e pegamos o ID do funcionario para vincular na tabela onde sera inserido
Function Busca_ID_Funcionario(CODIGO)

	If CODIGO <> "" Then
		Set RS = Server.CreateObject("ADODB.Recordset")
		RS.CursorLocation = 3 
		'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
		SQL = "Select Top 1 id From Funcionarios Where Codigo_Medico = '"&CODIGO&"'  "
				Rs.open SQL, CONN, 3
					IF not rs.eof then 'Verifica se existem registros
						Busca_ID_Funcionario = Rs("id")
					End if
				Rs.Close
				Set Rs = Nothing
	End if

End Function

'Função que insere os Médicos. Hj somente é inserido apenas 1 porem já fiz dessa forma para no futuro se isso mudar nao teremos problemas
'Recebe o ID da trasação que esta sendo inserida o atendimento
Function Grava_Medico(id_Atendimento)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Medico_CRM").Count

		'Verifica se o campo esta vazio
		If Request.Form("Medico_CRM")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Atendimento_Medicos (id_Atendimento,id_Contrato_Servico,id_Funcionario,id_Periodicidade,QTD) VALUES ( '"&id_Atendimento&"' , '"&TiraAspas(Request("id_Contrato_Servico_Medico")(x))&"' , '"&TiraAspas(Busca_ID_Funcionario(Request("Medico_CRM")(x)))&"' , '"&TiraAspas(Request("id_Periodicidade_Medico")(x))&"' , '"&TiraAspas(Request("Qtd_Periodicidade_Medico")(x))&"' ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função que insere os Enfermeiros. Hj somente é inserido apenas 1 porem já fiz dessa forma para no futuro se isso mudar nao teremos problemas
'Recebe o ID da trasação que esta sendo inserida o enfermeiro
Function Grava_Enfermeiro(id_Atendimento)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Enfermeiro_COREN").Count

		'Verifica se o campo esta vazio
		If Request.Form("Enfermeiro_COREN")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Atendimento_Enfermeiro (id_Atendimento,id_Contrato_Servico,id_Funcionario,id_Periodicidade,QTD) VALUES ( '"&id_Atendimento&"' , '"&TiraAspas(Request("id_Contrato_Servico_Enfermeiro")(x))&"' , '"&TiraAspas(Busca_ID_Funcionario(Request("Enfermeiro_COREN")(x)))&"' , '"&TiraAspas(Request("id_Periodicidade_Enfermeiro")(x))&"' , '"&TiraAspas(Request("Qtd_Periodicidade_Enfermeiro")(x))&"' ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função que insere a enfermegem. Hj somente é inserido apenas 1 porem já fiz dessa forma para no futuro se isso mudar nao teremos problemas
'Recebe o ID da trasação que esta sendo inserida o enfermeiro
Function Grava_Enfermagem(id_Atendimento)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Enfermagem_COREN").Count

		'Verifica se o campo esta vazio
		If Request.Form("Enfermagem_COREN")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Atendimento_Enfermagem (id_Atendimento,id_Contrato_Servico,id_Funcionario,id_Periodicidade,QTD) VALUES ( '"&id_Atendimento&"' , '"&TiraAspas(Request("id_Contrato_Servico_Enfermagem")(x))&"' , '"&TiraAspas(Busca_ID_Funcionario(Request("Enfermagem_COREN")(x)))&"' , '"&TiraAspas(Request("id_Periodicidade_Enfermagem")(x))&"' , '"&TiraAspas(Request("Qtd_Periodicidade_Enfermagem")(x))&"' ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função que insere o Fisioterapeuta. Hj somente é inserido apenas 1 porem já fiz dessa forma para no futuro se isso mudar nao teremos problemas
'Recebe o ID da trasação que esta sendo inserida o fisioterapeuta
Function Grava_Fisioterapeuta(id_Atendimento)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Fisioterapeuta_CREFITO").Count

		'Verifica se o campo esta vazio
		If Request.Form("Fisioterapeuta_CREFITO")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Atendimento_Fisioterapia (id_Atendimento,id_Contrato_Servico,id_Funcionario,id_Periodicidade,Qtd_Sessoes) VALUES ( '"&id_Atendimento&"' , '"&TiraAspas(Request("id_Contrato_Servico_Fisioterapeuta")(x))&"' , '"&TiraAspas(Busca_ID_Funcionario(Request("Fisioterapeuta_CREFITO")(x)))&"' , '"&TiraAspas(Request("id_Periodicidade_Fisioterapeuta")(x))&"' , '"&TiraAspas(Request("Qtd_Sessoes")(x))&"' ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função que insere outros serviços.
'Recebe o ID da trasação que esta sendo inserida o serviço
Function Grava_Outros_Servicos(id_Atendimento)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Outros_Servicos_Codigo").Count

		'Verifica se o campo esta vazio
		If Request.Form("Outros_Servicos_Codigo")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Atendimento_Outros_Servicos (id_Atendimento,id_Contrato_Servico,id_Funcionario,id_Periodicidade,QTD,Obs) VALUES ( '"&id_Atendimento&"' , '"&TiraAspas(Request("id_Contrato_Servico_Outros_Servicos")(x))&"' , '"&TiraAspas(Busca_ID_Funcionario(Request("Outros_Servicos_Codigo")(x)))&"' , '"&TiraAspas(Request("id_Periodicidade_Outros_Servicos")(x))&"' , '"&TiraAspas(Request("Qtd_Periodicidade_Outros_Servicos")(x))&"' , '"&TiraAspas(Request("Outros_Servicos_Obs")(x))&"' ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função que insere os Equipamentos.
Function Grava_Equipamentos(id_Atendimento)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Cod_Simpro_Equipamentos").Count

		'Verifica se o campo esta vazio
		If Request.Form("Cod_Simpro_Equipamentos")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Atendimento_Equipamentos (id_Atendimento,id_Fornecedor,SIMPRO,Qtd) VALUES ( '"&id_Atendimento&"' , '"&TiraAspas(Request("id_Fornecedor_Equipamento")(x))&"' , '"&TiraAspas(Request("Cod_Simpro_Equipamentos")(x))&"' , '"&TiraAspas(Request("qtd_Equipamentos")(x))&"'  ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função que insere os Materiais.
Function Grava_Materiais(id_Atendimento)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Cod_Simpro_Materiais").Count

		'Verifica se o campo esta vazio
		If Request.Form("Cod_Simpro_Materiais")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Atendimento_Materiais (id_Atendimento,id_Fornecedor,SIMPRO,Qtd) VALUES ( '"&id_Atendimento&"' , '"&TiraAspas(Request("id_Fornecedor_Material")(x))&"' , '"&TiraAspas(Request("Cod_Simpro_Materiais")(x))&"' , '"&TiraAspas(Request("qtd_Material")(x))&"'  ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função que insere os Medicamentos.
Function Grava_Medicamentos(id_Atendimento)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Cod_Simpro_Medicamento").Count

		'Verifica se o campo esta vazio
		If Request.Form("Cod_Simpro_Medicamento")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Atendimento_Medicamentos (id_Atendimento,id_Prescricao_Medica,id_Fornecedor,SIMPRO,Qtd) VALUES ( '"&id_Atendimento&"' , '"&TiraAspas(Request("id_Prescricao_Medicamento")(x))&"' , '"&TiraAspas(Request("id_Fornecedor_Medicamento")(x))&"' , '"&TiraAspas(Request("Cod_Simpro_Medicamento")(x))&"' , '"&TiraAspas(Request("qtd_Medicamentos")(x))&"'  ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função que insere os Exames.
Function Grava_Exames(id_Atendimento)

	'Atenção no IF abaixo - Toda prescrição medica tem que ter um medico resposavel. Vale lembrar quem existe uma função JS que faz a verificação quando o formulario é enviado para saber se o atendimento tem um medico resposavel
	'Verifica se o campo hidden com o id_funcionario esta vazio, ele pode estar vazio caso a pessoa delete o medico, entao, no caso se o campo hidden estar vazio e o campo do CRM estar preenchido entao ele chama a função que passa o CRM e retorna o id_funcionario
	If Request("id_Funcionario_Medico") = "" And Request("Medico_CRM") <> "" Then 
		id_Funcionario_Medico = Busca_ID_Funcionario(Request("Medico_CRM")) 'chama a função que passado o CRM devolve o id_Funcionario
	Else
		id_Funcionario_Medico = Request("id_Funcionario_Medico") 'Caso o campo hidden esteja com o id_funcionario entao é apenas atribuido
	End if

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Cod_Exame").Count

		'Verifica se o campo esta vazio
		If Request.Form("Cod_Exame")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Atendimento_Exames (id_Atendimento,id_Funcionario,id_Exames,id_Fornecedor,Data_Realizacao_Exame) VALUES ( '"&id_Atendimento&"' , '"&TiraAspas(id_Funcionario_Medico)&"' , '"&TiraAspas(Request("Cod_Exame")(x))&"' ,  '"&TiraAspas(Request("id_Fornecedor_Exame")(x))&"' , '"&TiraAspas(Request("Data_Realizacao_Exame")(x))&"'  ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

Function EditarAtendimento

	SQL	=	"SELECT dbo.HomeCare_Atendimento.id, dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento, dbo.HomeCare_Atendimento.id_Atendimento_Status, " &_ 
			"dbo.HomeCare_Atendimento.id_Atendimento_Status_Condicoes_Alta, dbo.HomeCare_Atendimento.Data_Cadastro, " &_ 
			"dbo.HomeCare_Atendimento.Data_Fechamento, dbo.HomeCare_Solicitacao_Requisicao_Tipo.Descricao AS Solicitacao_Requisicao_Tipo, " &_ 
			"dbo.HomeCare_Solicitacao_Atendimento.Data_Fechamento AS Data_fechamento_Solicitacao,  dbo.HomeCare_Solicitacao_Atendimento.Data_Cadastro_Solicitacao " &_ 
			"FROM dbo.HomeCare_Atendimento INNER JOIN " &_ 
			"dbo.HomeCare_Solicitacao_Atendimento ON  " &_ 
			"dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento = dbo.HomeCare_Solicitacao_Atendimento.id INNER JOIN " &_ 
			"dbo.HomeCare_Solicitacao_Requisicao_Tipo ON  " &_ 
			"dbo.HomeCare_Solicitacao_Atendimento.id_Solicitacao_Requisicao_Tipo = dbo.HomeCare_Solicitacao_Requisicao_Tipo.id " &_ 
			"Where dbo.HomeCare_Atendimento.id = '"&Cint(Request("id_Atendimento"))&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				id = Rs("id")
				id_Solicitacao_Atendimento = Rs("id_Solicitacao_Atendimento")
				id_Atendimento_Status = Rs("id_Atendimento_Status")
				id_Atendimento_Status_Condicoes_Alta = Rs("id_Atendimento_Status_Condicoes_Alta")
				Data_Cadastro_Atendimento = Rs("Data_Cadastro")
				Data_Fechamento_Atendimento = Rs("Data_Fechamento")
				Solicitacao_Requisicao_Tipo = Rs("Solicitacao_Requisicao_Tipo")
				Data_Cadastro_Solicitacao = Rs("Data_Cadastro_Solicitacao")
				Data_fechamento_Solicitacao = Rs("Data_fechamento_Solicitacao")
				
				
			Rs.Close
			Set Rs = Nothing

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction
		
	Case "Form_Incluir_Atendimento"
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Atendimento/modelos/Form_Incluir_Atendimento.htm" -->
<%
	Case "IncluirAtendimento"
		Call IncluirAtendimento

	Case "Editar_Atendimento"
		Call EditarAtendimento
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Atendimento/modelos/Form_Editar_Atendimento.htm" -->
<%
	Case "AlterarAtendimento"
		Call AlterarAtendimento
		
	Case Else 'Chama o formulario para solicitação
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Atendimento/modelos/Form_Visualizar_Atendimentos.htm" -->
<%
End Select

'[Fecha Conexão Com Banco De Dados]
Conn.close
set Conn = nothing
%>

