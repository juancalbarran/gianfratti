<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<!-- #include virtual="/SmartCare/Pacientes/Js/Validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 18/01/2005
' Descrição: Pagina de administração de Pacientes
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim id,id_cobertura,Nome,Sexo,Data_Nascimento,Responsavel,Endereco,Cep,UF,Cidade,Bairro,Particular,id_Convenio,Telefones, Cuidador , RG , CPF,Obs,Religiao,NumeroConvenio

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE JÁ EXISTEM
Function VisualizarPacientes

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

	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.Pacientes_Visualizar '"&Replace(Request("Busca"),"'","")&"' , '"&id_Convenio&"' , '"&Request("UF")&"' , '"&Request("Particular")&"' ,  '"&Trim(Replace(Replace(Request("CPF"),".",""),"-",""))&"' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
				rs.absolutepage = pag
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>&nbsp;</Td>" & Chr(10)
							Response.Write "<Td>Nº:</Td>" & Chr(10)
							Response.Write "<Td>Nome:</Td>" & Chr(10)
							Response.Write "<Td>CPF:</Td>" & Chr(10)
							Response.Write "<Td>Convenio:</Td>" & Chr(10)
							Response.Write "<Td>Particular:</Td>" & Chr(10)
							Response.Write "<Td>Reincidência:</Td>" & Chr(10)
							Response.Write "<Td>&nbsp;</Td>" & Chr(10)
							Response.Write "<Td>&nbsp;</Td>" & Chr(10)
						Response.Write"</Tr>"
					For x = 1 To Rs.Pagesize
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If Rs("Particular") = True Then Particular = "Sim" Else Particular = "Não" End If
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						if Cstr(request("PintaTR")) = Cstr(Rs("id")) Then zebrado = "zebra3" End if 'Somente para traser pintado o registroda lista que ele selecionou
						If Verifica_Paciente_Atendimento(Rs("id"),"1") Then 'Verifica o paciente esta em atendimento
							Flg_Imagem = "<img src='/SmartCare/images/Flg_azul.gif' border='0' alt='Em Atendimento'>"
							ElseIf Verifica_Paciente_Atendimento(Rs("id"),"5") Then
							Flg_Imagem = "<img src='/SmartCare/images/Flg_preto.gif' border='0' alt='Óbito'>"
							Else
								Flg_Imagem = "<img src='/SmartCare/images/Flg_verde.gif' border='0' alt='Livre para atendimento'>"
						End if
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Flg_Imagem&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' >"&Rs("id")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' >"&Rs("Nome")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' >"&MascaraCPF(Rs("CPF"))&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' >"&Rs("Convenio")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' >"&Particular&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' >"&Rs("Total_Reincidencia")&"</Td>" & Chr(10)
							Response.Write "<td class='"&zebrado&"' align='center' >"&"<a href='default.asp?action=EditarPacientes&id=" &rs("id")& "'><img src='/SmartCare/images/ico_editar.gif' border='0' alt='Alterar'></a>"&"</td>" & Chr(10) 
							Response.Write "<Td class='"&zebrado&"' align='center'  >"&"<a href=""javascript:Confirmar(" & rs("id") & " , '" & rs("Nome") & "' , 'ATENÇÂO !!\nDeseja mesmo excluir o paciente:' , 'default.asp?action=ExcluirPacientes&id="&rs("id")&"' )"" ><img src='/SmartCare/images/ico_excluir.gif' border='0' alt='Apagar'></a>"&"</td>" & Chr(10) 
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
					Response.Write "</Table>"
				Else 'Caso não seja encontrado nenhum registro
					Response.Write "<Table><tr><td class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
					'Inicio da paginação
							'Caso tenha algum campo de busca na pagina coloque aqui o nome dele. Isso foi feito para nãi ter que ficar colocando em varios lugares
							VariaveisBusca = "Action="&Request("action")&"&Busca="&Request("Busca")&"&CPF="&Request("CPF")&"&id_Convenio="&Request("id_Convenio")&"&Particular="&Request("Particular")&"&UF="&Request("UF")&" "
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

Function Verifica_Paciente_Atendimento(id_Paciente,Status_Tipo)

	SQL	=	"SELECT dbo.HomeCare_Solicitacao_Atendimento.id_Paciente "&_ 
			"FROM dbo.HomeCare_Atendimento INNER JOIN " &_ 
			"dbo.HomeCare_Solicitacao_Atendimento ON  " &_ 
			"dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento = dbo.HomeCare_Solicitacao_Atendimento.id "&_ 
			"WHERE (dbo.HomeCare_Atendimento.id_Atendimento_Status_Condicoes_Alta = '"&Status_Tipo&"' And dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = '"&id_Paciente&"') "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			If Not Rs.Eof Then
				Verifica_Paciente_Atendimento = True
				Else
				Verifica_Paciente_Atendimento = False
			End If
			Rs.Close
			Set Rs = Nothing

End Function

'FUNÇÃO RESPONSAVEL POR CARREGAR OS REGISTROS PARA MOSTRAR NO FORMULARIO
Public Function EditarPacientes

	SQL	=	"Select * From PACIENTES Where id = "&Cint(Request("id"))&" "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				id = Rs("id")
				id_cobertura = Rs("id_cobertura")
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
				Particular = Cint(Rs("Particular"))
				id_Convenio = Trim(Rs("id_Convenio"))
				RG = Trim(MascaraRG(Rs("RG")))
				CPF = Trim(MascaraCPF(Rs("CPF")))
				Obs = Trim(Rs("Obs"))
				if not isnull(Trim(Rs("Religiao"))) then Religiao = Trim(Rs("Religiao")) Else Religiao = " " End if
				NumeroConvenio = Trim(Rs("NumeroConvenio"))
								
			Rs.Close
			Set Rs = Nothing

End Function

Function IncluirPacientes

	conn.execute "set dateformat dmy" 'Faz a formatacao da data para dd/mm/aaaa no formato brasileiro
	SQL = 	"INSERT INTO PACIENTES (id_cobertura,Nome,Sexo,Data_Nascimento,Responsavel,Endereco,Cep,UF,Cidade,Bairro,Telefones,Cuidador,Particular,id_Convenio,RG,CPF,Obs,Religiao,NumeroConvenio) VALUES ( '"&Trim(Replace(Request("id_cobertura"),"'","''"))&"' , '"&Trim(Replace(Request("Nome"),"'","''"))&"' , '"&Trim(Replace(Request("Sexo"),"'","''"))&"' , '"&Trim(Replace(Request("Data_Nascimento"),"'","''"))&"'  , '"&Trim(Replace(Request("Responsavel"),"'","''"))&"' , '"&Trim(Replace(Request("Endereco"),"'","''"))&"' , '"&Trim(Replace(Request("Cep"),"'","''"))&"' , '"&Trim(Replace(Request("UF"),"'","''"))&"' , '"&Trim(Replace(Request("Cidade"),"'","''"))&"' , '"&Trim(Replace(Request("Bairro"),"'","''"))&"' , '"&Trim(Replace(Replace(Replace(Request("Telefones"),"(",""),")",""),"-",""))&"' , '"&Trim(Replace(Request("Cuidador"),"'","''"))&"'  , '"&Trim(Replace(Request("Particular"),"'","''"))&"' , '"&Trim(Replace(Request("id_Convenio"),"'","''"))&"' ,  '"&Trim(Replace(Replace(Request("RG"),".",""),"-",""))&"' ,  '"&Trim(Replace(Replace(Request("CPF"),".",""),"-",""))&"' , '"&Trim(Replace(Request("Obs"),"'","''"))&"' , '"&Trim(Replace(Request("Religiao"),"'","''"))&"' , '"&Trim(Replace(Request("NumeroConvenio"),"'","''"))&"'   ) "
				conn.execute(SQL)
				If Trim(Request("PaginaSolicitacao")) = "1" Then 'Caso o requisição de paciente veio da solicitacao
					Response.write "<script>location = '/SmartCare/Modulos/HomeCare/Solicitacao/default.asp?action=Form_Incluir_Solicitacao&busca="&Trim(Request("CPF"))&"' </script>"
				Else 'Caso seja da pagina de pacientes
					response.write "<script>location = 'default.asp?PintaTR="&Conn.execute("SELECT @@IDENTITY")(0).Value&"' </script>"
				End if


End Function

'FUNÇÃO RESPONSAVEL POR ALTERAR REGISTROS
Function AlterarPacientes

	conn.execute "set dateformat dmy" 'Faz a formatacao da data para dd/mm/aaaa no formato brasileiro
	SQL	=	"Update PACIENTES SET id_cobertura = '"&Trim(Replace(Request("id_cobertura"),"'","''"))&"' , Nome= '"&Trim(Replace(Request("Nome"),"'",""))&"' , Sexo='"&Trim(Replace(Request("Sexo"),"'",""))&"' , Data_Nascimento= '"&Request("Data_Nascimento")&"' , Responsavel='"&Trim(Replace(Request("Responsavel"),"'",""))&"' , Endereco='"&Trim(Replace(Request("Endereco"),"'",""))&"' , Cep='"&Trim(Replace(Request("Cep"),"'",""))&"' , UF='"&Trim(Replace(Request("UF"),"'",""))&"' , Cidade='"&Trim(Replace(Request("Cidade"),"'",""))&"' , Bairro='"&Trim(Replace(Request("Bairro"),"'",""))&"' , Telefones='"&Trim(Replace(Request("Telefones"),"'",""))&"' , Cuidador='"&Trim(Replace(Request("Cuidador"),"'",""))&"' , Particular='"&Trim(Replace(Request("Particular"),"'",""))&"' , id_Convenio = '"&Trim(Replace(Request("id_Convenio"),"'",""))&"' , RG = '"&Trim(Replace(Replace(Request("RG"),".",""),"-",""))&"' , CPF = '"&Trim(Replace(Replace(Request("CPF"),".",""),"-",""))&"' , Obs = '"&Trim(Replace(Request("Obs"),"'","''"))&"' , Religiao = '"&Trim(Replace(Request("Religiao"),"'","''"))&"' , NumeroConvenio = '"&Trim(Replace(Request("NumeroConvenio"),"'","''"))&"'   Where id = "&Cint(Request("id"))
				conn.execute(SQL)
				If Trim(Request("PaginaSolicitacao")) = "1" Then 'Caso o requisição de paciente veio da solicitacao
					Response.write "<script>location = '/SmartCare/Modulos/HomeCare/Solicitacao/default.asp?action=Form_Incluir_Solicitacao&busca="&Trim(Replace(Replace(Request("CPF"),".",""),"-",""))&"' </script>"
				Else 'Caso seja da pagina de pacientes
					Response.write "<script>location = 'default.asp?PintaTR="&Request("id")&"' </script>"
				End if

End Function

Function Confere_CPF


	If Trim(Replace(Replace(Request("Confere_CPF"),".",""),"-","")) <> "" Then
	
		SQL	=	"Select id,Nome,CPF From PACIENTES Where CPF = '"&Trim(Replace(Replace(Request("Confere_CPF"),".",""),"-",""))&"' "
				Set rs = server.createobject("adodb.recordset")
				Rs.open SQL, CONN, 3
				If Request("PaginaSolicitacao") = "1" Then PaginaSolicitacao = Request("PaginaSolicitacao") Else PaginaSolicitacao = "" End if
				If Rs.Eof Then
					Response.Redirect "default.asp?action=Form_Incluir_Pacientes&Liberado=1&PaginaSolicitacao="&PaginaSolicitacao&"&CPF="&Request("Confere_CPF")&" "
				Else
					Response.Redirect "default.asp?action=EditarPacientes&id="&Rs("id")&"&Cpf="&Rs("cpf")&"&PaginaSolicitacao="&PaginaSolicitacao&"&CPF="&Request("Confere_CPF")&" "
				End if
				Rs.Close
				Set Rs = Nothing
	Else
		Response.Redirect "default.asp?action=Form_Incluir_Pacientes"
	End if
	

End Function

'FUNÇÃO RESPONSAVEL POR EXCLUIR REGISTROS
Function ExcluirPacientes

	SQL	=	"DELETE FROM PACIENTES Where id ="&Cint(request("id"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Form_Incluir_Pacientes"
		action = "default.asp?action=IncluirPacientes"
%>
	<!-- #include virtual="/SmartCare/Pacientes/modelos/Form_Incluir_Pacientes.htm" -->
<%
	Case "IncluirPacientes"
		Call IncluirPacientes 'CHAMA A FUNÇÃO QUE IRA INCLUIR UM NOVO PACIENTE
		
	Case "EditarPacientes"
		Call EditarPacientes 'CHAMA A FUNÇÃO QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
		action = "default.asp?action=AlterarPacientes"
%>
	<!-- #include virtual="/SmartCare/Pacientes/modelos/Form_Incluir_Pacientes.htm" -->
<%		
	Case "AlterarPacientes"
		Call AlterarPacientes 'CHAMA A FUNÇÃO QUE IRA ALTERAR

	Case "Confere_CPF"		
		Call Confere_CPF
		
	Case "ExcluirPacientes"
		Call ExcluirPacientes 'CHAMA A FUNÇÃO QUE IRA EXCLUIR
		
	Case Else
%>
	<!-- #include virtual="/SmartCare/Pacientes/modelos/Form_Visualizar_Pacientes.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

