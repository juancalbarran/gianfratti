<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.Js" -->
<!-- #include virtual="/SmartCare/Modulos/HomeCare/Solicitacao/JS/validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 10/07/2005
' Descrição: Pagina de administração de solicitações de atendimento
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim id
Dim id_Paciente,Data_Cadastro_Paciente,Nome_Paciente,Data_Nascimento,RG,CPF,Idade,Convenio,Particular,Endereco,Cidade,Bairro,UF,Telefones,Responsavel,Cuidador
Dim id_Solicitacao_Tipo,id_Solicitacao_Requisicao_Tipo,id_Hospital, Hospital_Nome,Tipo_Requisicao_Outros,Medico_Solicitante,Medico_Solicitante_CRM,Medico_Solicitante_Contato
Dim id_Funcionario_Medico_Avaliador,Medico_Avaliador_Data,id_Funcionario_Enfermeiro_Avaliador,Enfermeiro_Avaliador_Data,id_Funcionario_Assistente_Social_Avaliador,Assistente_Social_Avaliador_Data,id_Funcionario_Fisioterapeuta_Avaliador,Assistente_Fisioterapeuta_Data
Dim id_Solicitacao_Status,Motivo_Solicitacao_Negada,Solicitacao_Status,Data_Cadastro_Solicitacao,Data_Fechamento,id_Solicitacao_Remocao_Tipo,Obs

'[CONEXÃO COM O BANCO DE DADOS]
set Conn = Server.CreateObject( "ADODB.Connection" )
Conn.CursorLocation = 3 'adUserClient
Conn.Open application("connstring")

'Função que mostra todas as solicitações
Function VisualizarSolicitacao

	dim pag
	regs = 20 'Aqui setamos quantos registros serão listados por página. 
	pag = request.querystring("pagina")
	if pag = "" Then pag = 1 end if
	set rs = createobject("adodb.recordset")
	rs.cursortype = 3 'Definimos o cursor a ser utilizado
	rs.pagesize = regs

	RS.CursorLocation = 3 

	'ESTE IF VERIFICA SE O USUARIO LOGADO É UM FUNCIONARIO OU UM CONTATO DO CONVENIO, ESTE IF É IMPORTANTE POIS SE FOR UM CONTATO DO CONVENIO ENTÃO SEMPRE FILTRA AS SOLICITAÇÕES DO CONVENIO E NAO DOS OUTROS CONVENIOS
	IF Session("id_Convenio") = "0" Then id_Convenio = Request("id_Convenio") Else id_Convenio = Session("id_Convenio") End if
	
	SQL	=	"EXEC HomeCare_Solicitacao_Atendimento_Visualizar '"&Trim(Replace(Request("id_Solicitacao"),"'",""))&"' , '"&Trim(Replace(Request("Busca"),"'",""))&"' , '"&Trim(Replace(Request("Date"),"'",""))&"' , '"&Trim(Replace(Request("id_Solicitacao_Status"),"'",""))&"' , '"&id_Convenio&"' ,  '"&Trim(Replace(Request("id_Solicitacao_Requisicao_Tipo"),"'",""))&"' , '"&Trim(Request("Data_Inicial"))&"' , '"&Trim(Request("Data_Final"))&"' , '"&Trim(Request("id_Hospital"))&"' , '"&Trim(Request("Particular"))&"' , '"&Trim(Replace(Request("Cid10"),"'",""))&"' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					rs.absolutepage = pag
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>&nbsp;</Td>" & Chr(10)
							Response.Write "<Td>Nº:</Td>" & Chr(10)
							Response.Write "<Td>Status:</Td>" & Chr(10)
							Response.Write "<Td>Dt. Abertura:</Td>" & Chr(10)
							Response.Write "<Td>Tempo:</Td>" & Chr(10)
							Response.Write "<Td>Tipo Solicitação:</Td>" & Chr(10)
							Response.Write "<Td>Paciente:</Td>" & Chr(10)
							Response.Write "<Td colspan='2'>&nbsp;</Td>" & Chr(10)
						Response.Write "</Tr>"
					For x = 1 To Rs.Pagesize
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						if Trim(Rs("id_Solicitacao_Requisicao_Tipo")) = "1" Then Solicitacao_Texto = Rs("Hospital_Nome") End if
						if Trim(Rs("id_Solicitacao_Requisicao_Tipo")) = "2" Then Solicitacao_Texto = "" End if
						If Trim(Rs("id_Solicitacao_Requisicao_Tipo")) = "3" Then Solicitacao_Texto = Rs("Tipo_Requisicao_Outros") End IF
						if rs("id_Solicitacao_Status") <> "1" Then  'Faz a verificação para saber se o status não esta em analise, caso nao esteja entao coloca uma figura do cadeado e nao habilita o link para edicao e o link da TR somente abrira a Popup para visualizar a solicitacao
							imagem = "<img src='/SmartCare/images/ico_cadeado.gif' border='0' alt='Solicitação não esta mais em analise'   >" 
							Link_Tr =  "style='Cursor: Pointer;' onClick="" javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Solicitacao/ImprimirSolicitacao.asp?id_Solicitacao_Atendimento="&rs("id")&"','850','680',this,event)  "" "
							Else  'Caso ainda esteja em edicao entao é colocado a imagem de edicao e o link de acesso e o Link da TR servira tb para editar a solicitacao
							imagem = "<a href='default.asp?action=Editar_Solicitacao&id=" &rs("id")& "'><img src='/SmartCare/images/ico_editar.gif' border='0' alt='Alterar Solicitação'   ></a>"
							Link_Tr = "style='Cursor: Pointer;'  onClick=""location.href='default.asp?action=Editar_Solicitacao&id=" &rs("id")& " '"" "
						End if
						If rs("id_Solicitacao_Status") = "1" Then 'Verifica o Status para colocar as images pintadas
							Flg_Imagem = "<img src='/SmartCare/images/Flg_azul.gif' border='0' alt='Em analise'>"
							ElseIf rs("id_Solicitacao_Status") = "2" Then
								Flg_Imagem = "<img src='/SmartCare/images/Flg_verde.gif' border='0' alt='Aceito'>"
							ElseIf rs("id_Solicitacao_Status") = "3" Then
								Flg_Imagem = "<img src='/SmartCare/images/Flg_preto.gif' border='0' alt='Não Aceito'>"
							ElseIf rs("id_Solicitacao_Status") = "5" Then
								Flg_Imagem = "<img src='/SmartCare/images/Flg_vermelho.gif' border='0' alt='Cancelado'>"
						End if
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						if Cstr(request("PintaTR")) = Cstr(Rs("id")) Then zebrado = "zebra3" End if 'Somente para traser pintado o registroda lista que ele selecionou
						Response.Write "<Tr "&Link_Tr&" >" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Flg_Imagem&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Rs("id")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Solicitacao_Status")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&ArrumaDataHora(Rs("Data_Cadastro_Solicitacao"))&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&TempoDecorrido(ArrumaDataHora(Rs("Data_Cadastro_Solicitacao")),ArrumaDataHora(Rs("Data_Fechamento")))&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Solicitacao_Requisicao_Tipo")&"<br>"&Solicitacao_Texto&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Paciente_Nome")&"</Td>" & Chr(10)
							Response.Write "<td class='"&zebrado&"' align='center'>"& imagem& "</td>" & Chr(10) 
							Response.Write "<td class='"&zebrado&"' align='center'>"&"<a href=""javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Solicitacao/ImprimirSolicitacao.asp?id_Solicitacao_Atendimento="&rs("id")&"','850','680',this,event)""><img src='/SmartCare/images/ico_impressora.gif' border='0' Alt='Visualizar Solicitação / Imprimir Solicitação'   ></a>" &  "</td>" & Chr(10) 
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
					Response.Write "</Table>"
				Else 'Caso não seja encontrado nenhum registro
					Response.Write "<Table width='100%' border='0'><tr><td align ='center' class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
					'Inicio da paginação
							'Caso tenha algum campo de busca na pagina coloque aqui o nome dele. Isso foi feito para nãi ter que ficar colocando em varios lugares
							VariaveisBusca = "Action="&Request("action")&"&data_inicial="&Request("data_inicial")&"&data_final="&Request("data_final")&"&id_Solicitacao="&Request("id_Solicitacao")&"&Busca="&Request("Busca")&"&Cid10="&Request("Cid10")&"&id_Solicitacao_Status="&Request("id_Solicitacao_Status")&"&id_Solicitacao_Requisicao_Tipo="&Request("id_Solicitacao_Requisicao_Tipo")&"&id_Convenio="&Request("id_Convenio")&"&Particular="&Request("Particular")&"  "
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

'Função resposavel por verificar antes da abertura se o paciente já tem alguma solicitacao em status de Analise
Function Verificar_Solicitacao_Aberta

	SQL	=	"Select id,id_Paciente From HomeCare_Solicitacao_Atendimento Where id_Solicitacao_Status = 1 And id_paciente = '"&Request("id_Paciente")&"'  "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					
					Response.Write "<Script>alert('<====ATENÇÃO====>\n\nJá Existe uma solicitação em analise para esta paciente\n\nSolicitação nº "&Rs("id")&"')</Script>"
					Response.Write "<Script>history.back()</Script>"
					Response.End
				
				End if

End Function

'Função resposavel por inserir a solicitação
Function IncluirSolicitacao
	
	Call Verificar_Solicitacao_Aberta 'Chama a função para veriricar se o paciente já tem alguma solicitacao em Analise
	
	'Faz as juncoes de DATA e HORA para gravar apenas no campo unico de DATA
	If Request("id_Funcionario_Medico_Avaliador") <> "" Then Medico_Avaliador_Data = "'"&Request("Medico_Avaliador_Data") & " " & Request("Medico_Avaliador_Hora")&"'" Else Medico_Avaliador_Data = "Null" End if
	If Request("id_Funcionario_Enfermeiro_Avaliador") <> "" Then Enfermeiro_Avaliador_Data = "'"&Request("Enfermeiro_Avaliador_Data") & " " & Request("Enfermeiro_Avaliador_Hora")&"'" Else Enfermeiro_Avaliador_Data = "Null" End if
	If Request("id_Funcionario_Assistente_Social_Avaliador") <> "" Then Assistente_Social_Avaliador_Data = "'"&Request("Assistente_Social_Avaliador_Data") & " " & Request("Assistente_Social_Avaliador_Hora")&"'" Else Assistente_Social_Avaliador_Data = "Null" End if
	If Request("id_Funcionario_Fisioterapeuta_Avaliador") <> "" Then Fisioterapeuta_Avaliador_Data = "'"&Request("Fisioterapeuta_Avaliador_Data") & " " & Request("Fisioterapeuta_Avaliador_Hora")&"'" Else Fisioterapeuta_Avaliador_Data = "Null" End if

	'Faz Verificacao para saber se o status selecione é o ACEITO ou Nâo ACEITO, Caso for um desses entao é gravada a data
	If Request("id_Solicitacao_Status") = "3" Or Request("id_Solicitacao_Status") = "2" Then 
		Data_Fechamento = "'"&ArrumaDataHora(Now)&"'" 
		id_Usuario_Fechamento = Session("id_Usuario")
	Else 
		Data_Fechamento = "Null" 
		id_Usuario_Fechamento = "Null"
	End if
	
	If Request("id_Solicitacao_Status") = "" Then id_Solicitacao_Status = "1" Else id_Solicitacao_Status = Request("id_Solicitacao_Status") End if
	
	SQL = 	"INSERT INTO HomeCare_Solicitacao_Atendimento (id_Paciente,id_Convenio,id_Solicitacao_Tipo,id_Solicitacao_Remocao_Tipo,id_Solicitacao_Requisicao_Tipo,id_Hospital,Tipo_Requisicao_Outros,Medico_Solicitante,Medico_Solicitante_CRM,Medico_Solicitante_Contato,id_Funcionario_Medico_Avaliador,Medico_Avaliador_Data,id_Funcionario_Enfermeiro_Avaliador,Enfermeiro_Avaliador_Data,id_Funcionario_Assistente_Social_Avaliador,Assistente_Social_Avaliador_Data,id_Funcionario_Fisioterapeuta_Avaliador,Fisioterapeuta_Avaliador_Data,id_Solicitacao_Status,Motivo_Solicitacao_Negada,id_Usuario_Abertura,id_Usuario_Fechamento,Data_Fechamento,Obs) VALUES ( '"&Cint(Request("id_Paciente"))&"', '"&Cint(Request("id_Convenio"))&"' , '"&Cint(Request("id_Solicitacao_Tipo"))&"' , '"&Cint(Request("id_Solicitacao_Remocao_Tipo"))&"'  , '"&Cint(Request("id_Solicitacao_Requisicao_Tipo"))&"' , "&IfNumBrancoNull(Request("id_Hospital"))&" , "&IfTxtBrancoNull(TiraAspas(Request("Tipo_Requisicao_Outros")))&" , '"&TiraAspas(Request("Medico_Solicitante"))&"' , '"&TiraAspas(Request("Medico_Solicitante_CRM"))&"' , '"&TiraAspas(Request("Medico_Solicitante_Contato"))&"' , "&IfNumBrancoNull(Request("id_Funcionario_Medico_Avaliador"))&" , "&Medico_Avaliador_Data&" , "&IfNumBrancoNull(Request("id_Funcionario_Enfermeiro_Avaliador"))&" , "&Enfermeiro_Avaliador_Data&" , "&IfNumBrancoNull(Request("id_Funcionario_Assistente_Social_Avaliador"))&" ,  "&Assistente_Social_Avaliador_Data&" , "&IfNumBrancoNull(Request("id_Funcionario_Fisioterapeuta_Avaliador"))&" , "&Fisioterapeuta_Avaliador_Data&" ,  "&Cint(id_Solicitacao_Status)&" , "&IfTxtBrancoNull(TiraAspas(Request("Motivo_Solicitacao_Negada")))&" , '"&Session("id_Usuario")&"' , "&id_Usuario_Fechamento&" , "&Data_Fechamento&"  , '"&TiraAspas(Request("Obs"))&"' ) "
			On Error Resume Next 'Inicia o Tratamento de erro
				Conn.BeginTrans  'Inicia a Transação
				Conn.execute(SQL) 'Executa a Query
				id_Transacao = Conn.execute("SELECT @@IDENTITY")(0).Value
				Call Itens_Solicitacao_Medica(id_Transacao) 'Chama a funçao que ira inserir os itens da solicitação medica. Já é passao do ID da transação atual
				Call Itens_Profissionais(id_Transacao) 'Chama a funçao que ira inserir os profissionais. Já é passao do ID da transação atual
				Call Itens_Cid10(id_Transacao) 'Chama a funçao que ira inserir os itens do CID10. Já é passao do ID da transação atual
				Call Itens_Equipamentos(id_Transacao) 'Chana a função que vai inserir todos os equipamentos
				Call Itens_Materiais(id_Transacao) 'Chama a função oque vai inserir os materiais
				Call Itens_Dietas(id_Transacao) 'Chama a função que vai inserir as dietas
			If Err <> 0 Then 'Verifica se ocorreu algum erro
				Conn.RollbackTrans 'Se foi detectado algum erro entao a Transação é desfeita e nao é inserido nenhum registro
				Response.Write "Foi detectado um erro e a ação foi cancelada: " & Err.Description
				Response.End
				Else
					Conn.CommitTrans 'Caso não tenha ocorrido nenhum erro entao a transação é efeutuado com sucesso
					Call Dispara_Email_Abertura_Solicitacao(id_Transacao) 'Dispara o email avisando sobre a nova solicitação
					response.write "<script>location = 'default.asp?Date="&ArrumaData(Date)&"&PintaTR="&id_Transacao&"' </script>"
			End If

End Function

'Função que insere os itens da solicitação medica
'Recebe o ID da trasação que esta sendo inserida a Solicitação
Function Itens_Solicitacao_Medica(id_Solicitacao_Atendimento)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Solicitacao_Medica_Descricao").Count

		'Verifica se o campo esta vazio
		If Request.Form("Solicitacao_Medica_Descricao")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Solicitacao_Medica_Itens (id_Solicitacao_Atendimento,Descricao,Periodicidade,Qdt_Dias,Valor,Solicitacao_Entrada) VALUES ( '"&id_Solicitacao_Atendimento&"' , '"&TiraAspas(Request("Solicitacao_Medica_Descricao")(x))&"' , '"&TiraAspas(Request("Periodicidade")(x))&"' , '"&TiraAspas(Request("Qtd_Dias")(x))&"' , "&TiraAspas(Request("ValorPrescricao")(x))&" , 1 ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função que insere os profissionais
'Recebe o ID da trasação que esta sendo inserida a Solicitação
Function Itens_Profissionais(id_Solicitacao_Atendimento)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Profissional").Count

		'Verifica se o campo esta vazio
		If Request.Form("Profissional")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Solicitacao_Profissionais (id_Solicitacao_Atendimento,Profissional,Periodicidade,Valor) VALUES ( '"&id_Solicitacao_Atendimento&"' , '"&TiraAspas(Request("Profissional")(x))&"' , '"&TiraAspas(Request("Profissional_Periodicidade")(x))&"' , "&TiraAspas(Request("ValorProfissional")(x))&" ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função que insere os itens do CID10
'Recebe o ID da trasação que esta sendo inserida a Solicitação
Function Itens_Cid10(id_Solicitacao_Atendimento)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("CID10").Count

		'Verifica se o campo esta vazio
		If Request.Form("CID10")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Diagnostico_Entrada (id_Solicitacao_Atendimento,CID10) VALUES ( '"&id_Solicitacao_Atendimento&"' , '"&TiraAspas(Request("CID10")(x))&"'  ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função que insere os Equipamentos
'Recebe o ID da trasação que esta sendo inserida a Solicitação
Function Itens_Equipamentos(id_Solicitacao_Atendimento)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Equipamento").Count

		'Verifica se o campo esta vazio
		If Request.Form("Equipamento")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Solicitacao_Equipamentos (id_Solicitacao_Atendimento,Equipamento,Qtd,Valor) VALUES ( '"&id_Solicitacao_Atendimento&"' , '"&TiraAspas(Request("Equipamento")(x))&"' , '"&TiraAspas(Request("QtdEquipamento")(x))&"' , "&TiraAspas(Request("ValorEquipamento")(x))&"  ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função que insere os Materiais
'Recebe o ID da trasação que esta sendo inserida a Solicitação
Function Itens_Materiais(id_Solicitacao_Atendimento)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Material").Count

		'Verifica se o campo esta vazio
		If Request.Form("Material")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Solicitacao_Materiais (id_Solicitacao_Atendimento,Material,Qtd,Valor) VALUES ( '"&id_Solicitacao_Atendimento&"' , '"&TiraAspas(Request("Material")(x))&"' , '"&TiraAspas(Request("QtdMaterial")(x))&"' , "&TiraAspas(Request("ValorMaterial")(x))&"  ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função que insere as Dietas
'Recebe o ID da trasação que esta sendo inserida a Solicitação
Function Itens_Dietas(id_Solicitacao_Atendimento)

	'Faz um loço para recuperar os campos que tem o mesmo nome para fazer o insert
	For X = 1 To Request.Form("Dieta").Count

		'Verifica se o campo esta vazio
		If Request.Form("Dieta")(x) <> "" Then
			
			SQL = 	"INSERT INTO HomeCare_Solicitacao_Dietas (id_Solicitacao_Atendimento,Dieta,Qtd,Valor) VALUES ( '"&id_Solicitacao_Atendimento&"' , '"&TiraAspas(Request("Dieta")(x))&"' , '"&TiraAspas(Request("QtdDieta")(x))&"' , "&TiraAspas(Request("ValorDieta")(x))&"  ) "
					Conn.execute(SQL) 'Executa a Query

		End IF
	
	Next

End Function

'Função resposavel por verificar antes da edicao da solicitação se a mesma se encontra aberta
Function Verificar_Solicitacao_Fechada

	SQL	=	"Select id,id_Paciente From HomeCare_Solicitacao_Atendimento Where data_fechamento <> '' And id = '"&Request("id")&"'  "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					
					Response.Write "<Script>alert('<====ATENÇÃO====>\n\n"&Session("Funcionario_Nome")&"\n\nA solicitação que você esta tentando acessar não esta mais disponivel para edição.\n\nSolicitação nº "&Rs("id")&"')</Script>"
					Response.Write "<Script>history.back()</Script>"
					Response.End
				
				End if
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega a solictação para a edicao
Function Editar_Solicitacao

	Call Verificar_Solicitacao_Fechada 'Chama a função que verifica se a solicitacao esta aberta ainda. Isso foi feito pois a pessoa pode fechar uma solicitação e depois editar ela mudando a URL
	
	SQL = 	"SELECT dbo.HomeCare_Solicitacao_Atendimento.id, dbo.HomeCare_Solicitacao_Atendimento.id_Solicitacao_Tipo ,dbo.HomeCare_Solicitacao_Atendimento.id_Solicitacao_Remocao_Tipo,dbo.HomeCare_Solicitacao_Atendimento.id_Hospital , dbo.Pacientes.nome As Nome_Paciente, dbo.Pacientes.responsavel, dbo.Pacientes.endereco, dbo.Pacientes.cep, "&_ 
			"dbo.Pacientes.cidade, dbo.Pacientes.uf, dbo.Pacientes.bairro, dbo.Pacientes.sexo, dbo.Pacientes.telefones, dbo.Pacientes.cuidador, "&_ 
			"dbo.Pacientes.data_nascimento, dbo.Pacientes.data_cadastro AS Data_Cadastro_Paciente, dbo.Pacientes.RG, dbo.Pacientes.CPF, dbo.Pacientes.particular, "&_ 
			"dbo.Convenios.Convenio, dbo.HomeCare_Solicitacao_Atendimento.id_Paciente AS id_Paciente, "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento.id_Solicitacao_Status,  dbo.HomeCare_Solicitacao_Atendimento.id_Solicitacao_Requisicao_Tipo, "&_ 
			" dbo.FuncaoHospitalNome(dbo.HomeCare_Solicitacao_Atendimento.id_Hospital) AS Hospital_Nome, dbo.HomeCare_Solicitacao_Atendimento.Tipo_Requisicao_Outros, "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento.Medico_Solicitante, dbo.HomeCare_Solicitacao_Atendimento.Medico_Solicitante_CRM, "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento.Medico_Solicitante_Contato, dbo.HomeCare_Solicitacao_Atendimento.id_Funcionario_Medico_Avaliador, "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento.Medico_Avaliador_Data, dbo.HomeCare_Solicitacao_Atendimento.id_Funcionario_Enfermeiro_Avaliador, "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento.Enfermeiro_Avaliador_Data, "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento.id_Funcionario_Assistente_Social_Avaliador, "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento.Assistente_Social_Avaliador_Data, "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento.id_Funcionario_Fisioterapeuta_Avaliador, "&_
			"dbo.HomeCare_Solicitacao_Atendimento.Fisioterapeuta_Avaliador_Data, dbo.HomeCare_Solicitacao_Atendimento.Data_Cadastro_Solicitacao, "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento.Requisicao_Tipo_Residencia, "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento.Motivo_Solicitacao_Negada,dbo.FuncaoSolicitacao_Status(dbo.HomeCare_Solicitacao_Atendimento.id_Solicitacao_Status) AS Solicitacao_Status, "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento.Data_Fechamento, " &_ 
			"dbo.HomeCare_Solicitacao_Atendimento.Obs " &_ 
			"FROM dbo.HomeCare_Solicitacao_Atendimento INNER JOIN "&_ 
			"dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id INNER JOIN " &_ 
			"dbo.Convenios ON dbo.Pacientes.id_convenio = dbo.Convenios.id " &_ 
			"Where dbo.HomeCare_Solicitacao_Atendimento.id = '"&Request("id")&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
				
					id = Rs("id")
					id_Paciente = Rs("id_Paciente")
					id_Solicitacao_Status = Rs("id_Solicitacao_Status")
					id_Solicitacao_Tipo = Rs("id_Solicitacao_Tipo")
					id_Solicitacao_Remocao_Tipo = Rs("id_Solicitacao_Remocao_Tipo")
					id_Hospital = Rs("id_Hospital")
					id_Solicitacao_Requisicao_Tipo = Rs("id_Solicitacao_Requisicao_Tipo")
					Data_Cadastro_Paciente = ArrumaDataHora(Rs("Data_Cadastro_Paciente"))
					Nome_Paciente = Rs("Nome_Paciente")
					Data_Nascimento = Rs("Data_Nascimento")
					Idade = Year(Date) - Year(Rs("Data_Nascimento"))
					RG = Rs("RG")
					CPF = Rs("CPF")
					Convenio = Rs("Convenio")
					If Rs("Particular") Then Particular = "Pessoa Fisica" Else Particular = "Pessoa Juridica" End if
					Endereco = Rs("Endereco")
					Cidade = Rs("Cidade")
					Bairro = Rs("Bairro")
					UF = Rs("UF")
					Telefones = Rs("Telefones")
					Responsavel = Rs("Responsavel")
					Cuidador = Rs("Cuidador")
					Hospital_Nome = Rs("Hospital_Nome")
					Tipo_Requisicao_Outros = Rs("Tipo_Requisicao_Outros")
					Medico_Solicitante = Rs("Medico_Solicitante")
					Medico_Solicitante_CRM = Rs("Medico_Solicitante_CRM")
					Medico_Solicitante_Contato = Rs("Medico_Solicitante_Contato")
					id_Funcionario_Medico_Avaliador = Rs("id_Funcionario_Medico_Avaliador")
					Medico_Avaliador_Data = Rs("Medico_Avaliador_Data")
					id_Funcionario_Enfermeiro_Avaliador = Rs("id_Funcionario_Enfermeiro_Avaliador")
					Enfermeiro_Avaliador_Data = Rs("Enfermeiro_Avaliador_Data")
					id_Funcionario_Assistente_Social_Avaliador = Rs("id_Funcionario_Assistente_Social_Avaliador")
					Assistente_Social_Avaliador_Data = Rs("Assistente_Social_Avaliador_Data")
					id_Funcionario_Fisioterapeuta_Avaliador = Rs("id_Funcionario_Fisioterapeuta_Avaliador")
					Assistente_Fisioterapeuta_Data = Rs("Fisioterapeuta_Avaliador_Data")
					Motivo_Solicitacao_Negada = Rs("Motivo_Solicitacao_Negada")
					Solicitacao_Status = Rs("Solicitacao_Status")
					Data_Cadastro_Solicitacao = ArrumaDataHora(Rs("Data_Cadastro_Solicitacao"))
					Data_Fechamento = ArrumaDataHora(Rs("Data_Fechamento"))
					Obs = Rs("Obs")
				
				End IF
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todas as solicitações que a solicitacao tem
Function Carrega_Solicitacao_Medica_Itens(id_Solicitcao_Atendimento)

	SQL = 	"Select id, id_Solicitacao_Atendimento, Descricao, Periodicidade, Qdt_Dias, ISNULL(Valor, 0) AS Valor, Data_Cadastro, " &_ 
			"ISNULL((SELECT SUM(Valor) FROM HomeCare_Solicitacao_Medica_Itens WHERE  (id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"')), 0) AS Total " &_ 
			"From HomeCare_Solicitacao_Medica_Itens Where id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='27%' valign='top'><b>Prescrição:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='12%' valign='top'><b>Qtd Dias:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='12%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Valor:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center' >&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						Total = FormatCurrency(Rs("Total"))
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"">" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qdt_Dias"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top' align='right'>"&FormatCurrency(Rs("Valor"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center' >"&"<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarItensSolicitacao( "&Rs("id")&" , '"&Rs("Descricao")&"' )"" >"&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td colspan='5' class='texto' align='right' valign='top'><b>"&Total&"</b></td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>&nbsp;</td>" & CHR(10)
						 Response.Write "</tr>" & CHR(10)
						Response.Write "</table>" & CHR(10)
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todos os profissionais que a solicitacao tem
Function Carrega_Profissionais(id_Solicitacao_Atendimento)

	SQL = 	"SELECT id, id_Solicitacao_Atendimento, Profissional, Periodicidade, ISNULL(Valor, 0) AS Valor, Data, " &_
			"IsNull((SELECT SUM(Valor) FROM dbo.HomeCare_Solicitacao_Profissionais WHERE id_Solicitacao_Atendimento = '"&id_Solicitacao_Atendimento&"'),0) AS Total  " &_ 
			"FROM HomeCare_Solicitacao_Profissionais " &_ 
			"Where id_Solicitacao_Atendimento = '"&id_Solicitacao_Atendimento&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='30%' valign='top'><b>Profissional:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='42%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Valor:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center'>&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						Total = Trim(FormatCurrency(Rs("Total")))
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"" >" & CHR(10)
							Response.Write "<td class='texto' valign='top' >"&Trim(Rs("Profissional"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top' align='right'>"&Trim(FormatCurrency(Rs("Valor")))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center'>"&"<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarProfissionais("&Rs("id")&" , '"&Rs("Profissional")&"' )"" >"&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td colspan='4' class='texto' align='right' valign='top'><b>"&Total&"</b></td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>&nbsp;</td>" & CHR(10)
						 Response.Write "</tr>" & CHR(10)
						Response.Write "</table>" & CHR(10)
				End If
			Rs.Close
			Set Rs = Nothing

End Function


'Função que carrega todos os CID10 que a solicitacao tem
Function Carrega_CID10_Itens(id_Solicitcao_Atendimento)

	SQL = 	"SELECT dbo.HomeCare_Diagnostico_Entrada.id,dbo.Diagnostico.CID10, dbo.Diagnostico.DESCRICAO , Data_Cadastro " &_ 
			"FROM dbo.Diagnostico INNER JOIN " &_ 
            "dbo.HomeCare_Diagnostico_Entrada ON dbo.Diagnostico.CID10 = dbo.HomeCare_Diagnostico_Entrada.CID10 " &_ 
			"Where id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"' "
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
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todos os Equipamentos que a solicitacao tem
Function Carrega_Equipamentos_Itens(id_Solicitcao_Atendimento)

	SQL =	"SELECT  id, id_Solicitacao_Atendimento, Equipamento, Qtd, Valor, Data_Cadastro, " &_ 
			"ISNULL((SELECT SUM(Valor)  FROM  HomeCare_Solicitacao_Equipamentos  WHERE id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"'), 0) AS Total " &_ 
			"FROM HomeCare_Solicitacao_Equipamentos " &_
			"Where id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"' "
			
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof And Rs(0).Name <> "sum" then 'Verifica se existem registros e se a coluna é diferente se SUM que é o total
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='52%' valign='top'><b>Equipamento:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='20%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Valor:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center'>&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						Total = Trim(FormatCurrency(Rs("Total")))
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"" >" & CHR(10)
							Response.Write "<td class='texto' valign='top' >"&Trim(Rs("Equipamento"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qtd"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top' align='right'>"&Trim(FormatCurrency(Rs("Valor")))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center'>"&"<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarEquipamentos("&Rs("id")&" , '"&Rs("Equipamento")&"' )"" >"&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td colspan='4' class='texto' align='right' valign='top'><b>"&FormatCurrency(Total)&"</b></td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>&nbsp;</td>" & CHR(10)
						 Response.Write "</tr>" & CHR(10)
						Response.Write "</table>" & CHR(10)
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todos os Materiais que a solicitacao tem
Function Carrega_Materiais_Itens(id_Solicitcao_Atendimento)

	SQL =	"SELECT id, id_Solicitacao_Atendimento, Material, Qtd, Valor, Data_Cadastro, " &_ 
			"ISNULL((SELECT Sum(Valor) FROM HomeCare_Solicitacao_Materiais WHERE id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"'), 0) AS Total " &_ 
			"FROM dbo.HomeCare_Solicitacao_Materiais " &_ 
			"WHERE (id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"') "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof And Rs(0).Name <> "sum" then 'Verifica se existem registros e se a coluna é diferente se SUM que é o total
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='52%' valign='top'><b>Material:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='20%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Valor:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center'>&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						Total = Trim(FormatCurrency(Rs("Total")))
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"" >" & CHR(10)
							Response.Write "<td class='texto' valign='top' >"&Trim(Rs("Material"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qtd"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top' align='right'>"&Trim(FormatCurrency(Rs("Valor")))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center'>"&"<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarMaterial("&Rs("id")&" , '"&Rs("Material")&"' )"" >"&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td colspan='4' class='texto' align='right' valign='top'><b>"&FormatCurrency(Total)&"</b></td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>&nbsp;</td>" & CHR(10)
						 Response.Write "</tr>" & CHR(10)
						Response.Write "</table>" & CHR(10)
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que carrega todos as Dietas que a solicitacao tem
Function Carrega_Dietas_Itens(id_Solicitcao_Atendimento)

	SQL =	"SELECT id, id_Solicitacao_Atendimento, Dieta, Qtd, Valor, Data_Cadastro, " &_ 
			"ISNULL((SELECT SUM(Valor) FROM HomeCare_Solicitacao_Dietas WHERE id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"'), 0) AS Total " &_ 
			"FROM HomeCare_Solicitacao_Dietas " &_ 
			"WHERE (id_Solicitacao_Atendimento = '"&id_Solicitcao_Atendimento&"') "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof And Rs(0).Name <> "sum" then 'Verifica se existem registros e se a coluna é diferente se SUM que é o total
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='52%' valign='top'><b>Dieta:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='20%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Valor:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center'>&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						Total = Trim(FormatCurrency(Rs("Total")))
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"" >" & CHR(10)
							Response.Write "<td class='texto' valign='top' >"&Trim(Rs("Dieta"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qtd"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top' align='right'>"&Trim(FormatCurrency(Rs("Valor")))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center'>"&"<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarDieta("&Rs("id")&" , '"&Rs("Dieta")&"' )"" >"&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td colspan='4' class='texto' align='right' valign='top'><b>"&FormatCurrency(Total)&"</b></td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>&nbsp;</td>" & CHR(10)
						 Response.Write "</tr>" & CHR(10)
						Response.Write "</table>" & CHR(10)
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que faz o Update na solicitaçao
Function Alterar_Solicitacao

	Call Verificar_Solicitacao_Fechada 'Chama a função que verifica se a solicitacao esta aberta ainda. Isso foi feito pois a pessoa pode fechar uma solicitação e depois editar ela mudando a URL
	
	'Faz as juncoes de DATA e HORA para gravar apenas no campo unico de DATA
	If Request("id_Funcionario_Medico_Avaliador") <> "" Then Medico_Avaliador_Data = "'"&Request("Medico_Avaliador_Data") & " " & Request("Medico_Avaliador_Hora")&"'" Else Medico_Avaliador_Data = "Null" End if
	If Request("id_Funcionario_Enfermeiro_Avaliador") <> "" Then Enfermeiro_Avaliador_Data = "'"&Request("Enfermeiro_Avaliador_Data") & " " & Request("Enfermeiro_Avaliador_Hora")&"'" Else Enfermeiro_Avaliador_Data = "Null" End if
	If Request("id_Funcionario_Assistente_Social_Avaliador") <> "" Then Assistente_Social_Avaliador_Data = "'"&Request("Assistente_Social_Avaliador_Data") & " " & Request("Assistente_Social_Avaliador_Hora")&"'" Else Assistente_Social_Avaliador_Data = "Null" End if
	If Request("id_Funcionario_Fisioterapeuta_Avaliador") <> "" Then Fisioterapeuta_Avaliador_Data = "'"&Request("Fisioterapeuta_Avaliador_Data") & " " & Request("Fisioterapeuta_Avaliador_Hora")&"'" Else Fisioterapeuta_Avaliador_Data = "Null" End if

	'Faz Verificacao para saber se o status selecione é o ACEITO , Nâo ACEITO ou CANCELADO, Caso for um desses entao é gravada a data de fechamento
	If Request("id_Solicitacao_Status") = "3" Or Request("id_Solicitacao_Status") = "2" Or Request("id_Solicitacao_Status") = "5" Then 
		Data_Fechamento = "'"&ArrumaDataHora(Now)&"'" 
		id_Usuario_Fechamento = Session("id_Usuario")
		Else 
		Data_Fechamento = "Null" 
		id_Usuario_Fechamento = "Null"
	End if
	
	If Request("id_Solicitacao_Status") = "" Then id_Solicitacao_Status = "1" Else id_Solicitacao_Status = Request("id_Solicitacao_Status") End if
	
	SQL	=	"Update HomeCare_Solicitacao_Atendimento SET  id_Solicitacao_Tipo = '"&Trim(Request("id_Solicitacao_Tipo"))&"' , id_Solicitacao_Remocao_Tipo = '"&Trim(Request("id_Solicitacao_Remocao_Tipo"))&"' , id_Solicitacao_Requisicao_Tipo= '"&Trim(Request("id_Solicitacao_Requisicao_Tipo"))&"' , id_Hospital = "&IfNumBrancoNull(Request("id_Hospital"))&" , Tipo_Requisicao_Outros = "&IfTxtBrancoNull(TiraAspas(Request("Tipo_Requisicao_Outros")))&" , Medico_Solicitante = '"&Trim(Request("Medico_Solicitante"))&"' , Medico_Solicitante_CRM = '"&Trim(Request("Medico_Solicitante_CRM"))&"' , Medico_Solicitante_Contato = '"&TiraAspas(Request("Medico_Solicitante_Contato"))&"' , id_Funcionario_Medico_Avaliador = "&IfNumBrancoNull(Request("id_Funcionario_Medico_Avaliador"))&" , Medico_Avaliador_Data = "&Medico_Avaliador_Data&" , id_Funcionario_Enfermeiro_Avaliador = "&IfNumBrancoNull(Request("id_Funcionario_Enfermeiro_Avaliador"))&" , Enfermeiro_Avaliador_Data = "&Enfermeiro_Avaliador_Data&" , id_Funcionario_Assistente_Social_Avaliador = "&IfNumBrancoNull(Request("id_Funcionario_Assistente_Social_Avaliador"))&" , Assistente_Social_Avaliador_Data = "&Assistente_Social_Avaliador_Data&" , id_Funcionario_Fisioterapeuta_Avaliador = "&IfNumBrancoNull(Request("id_Funcionario_Fisioterapeuta_Avaliador"))&" , Fisioterapeuta_Avaliador_Data = "&Fisioterapeuta_Avaliador_Data&" ,  Obs = '"&TiraAspas(Request("Obs"))&"' ,id_Solicitacao_Status = "&Cint(id_Solicitacao_Status)&" , Motivo_Solicitacao_Negada = "&IfTxtBrancoNull(TiraAspas(Request("Motivo_Solicitacao_Negada")))&" , id_Usuario_Fechamento = "&id_Usuario_Fechamento&" , Data_Fechamento =  "&Data_Fechamento&"  Where id = "&Cint(Request("id"))
			On Error Resume Next 'Inicia o Tratamento de erro
				Conn.BeginTrans  'Inicia a Transação
				Conn.execute(SQL) 'Executa a Query
				Call Itens_Solicitacao_Medica(Request("id")) 'Chama a funçao que ira inserir os itens da solicitação medica. Já é passao do ID da trasação atual
				Call Itens_Profissionais(Request("id")) 'Chama a funçao que ira inserir os profissionais. Já é passao do ID da transação atual
				Call Itens_Cid10(Request("id")) 'Chama a funçao que ira inserir os itens do CID10. Já é passao do ID da transação atual
				Call Itens_Equipamentos(Request("id")) 'Chana a função que vai inserir todos os equipamentos
				Call Itens_Materiais(Request("id")) 'Chama a função oque vai inserir os materiais
				Call Itens_Dietas(Request("id")) 'Chama a função que vai inserir as dietas
			If Err <> 0 Then 'Verifica se ocorreu algum erro
				Conn.RollbackTrans 'Se foi detectado algum erro entao a Transação é desfeita e nao é inserido nenhum registro
				Response.Write "Foi detectado um erro e a ação foi cancelada: " & Err.Description
				Response.End
				Else
					Conn.CommitTrans 'Caso não tenha ocorrido nenhum erro entao a transação é efeutuado com sucesso
					Call Dispara_Email_Solicitacao_Alteracao_Status(Request("id")) 'Chama a função que dispara o email evisando se teve alteração no status
					Response.Redirect "Default.asp?PintaTR="&Request("id")&""
			End If

End Function

'Função responsavel por cancelar a solicitação
Function Cancelar_Solicitacao

	SQL	=	"Update HomeCare_Solicitacao_Atendimento SET  id_Solicitacao_Status = 5 , Data_Fechamento = '"&ArrumaDataHora(Now)&"' , Motivo_Solicitacao_Negada = 'Cancelada pelo funcionario "&Session("Funcionario_Nome")&". "&Session("Convenio_Nome")&" ' Where id = "&Cint(Request("id_Solicitacao"))
			On Error Resume Next 'Inicia o Tratamento de erro
				Conn.BeginTrans  'Inicia a Transação
				Conn.execute(SQL) 'Executa a Query
				Call Dispara_Email_Cancelamento_Solicitacao(Request("id_Solicitacao")) 'Dispara o email avisando sobre o cancelamento da solicitacao
			If Err <> 0 Then 'Verifica se ocorreu algum erro
				Conn.RollbackTrans 'Se foi detectado algum erro entao a Transação é desfeita e nao é inserido nenhum registro
				Response.Write "Foi detectado um erro e a ação foi cancelada: " & Err.Description
				Response.End
				Else
					Conn.CommitTrans 'Caso não tenha ocorrido nenhum erro entao a transação é efeutuado com sucesso
					Response.Redirect "Default.asp?PintaTR="&Request("id_Solicitacao")&""
			End If
	
End Function

'FUNÇÃO RESPONSAVEL POR EXCLUIR REGISTROS
Function ExcluirSolicitacao

	SQL	=	"DELETE FROM HomeCare_Solicitacao_Atendimento Where id ="&Cint(request("id"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction
		
	Case "Form_Incluir_Solicitacao"
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Solicitacao/modelos/Form_Incluir_Solicitacao.htm" -->
<%
	Case "IncluirSolicitacao"
		Call IncluirSolicitacao 'Chama a função para incluir a solicitação

	Case "ExcluirSolicitacao"
		Call ExcluirSolicitacao 'Chama a função para excluir a solicitação

	Case "Editar_Solicitacao"
		Call Editar_Solicitacao 'Chama a função para editar a solicitação
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Solicitacao/modelos/Form_Editar_Solicitacao.htm" -->
<%
	Case "Alterar_Solicitacao"
		Call Alterar_Solicitacao 'Chama a função para alterar a solicitação
		
	Case "Cancelar_Solicitacao"
		Call Cancelar_Solicitacao 'Chama a função que ira cancelar a solicitacao
		
	Case Else 'Chama o formulario para solicitação
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Solicitacao/modelos/Form_Visualizar_Solicitacao.htm" -->
<%
End Select

'[Fecha Conexão Com Banco De Dados]
Conn.close
set Conn = nothing
%>

