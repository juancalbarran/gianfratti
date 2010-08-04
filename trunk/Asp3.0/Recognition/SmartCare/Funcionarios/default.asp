<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Upload/Default.asp" -->
<!-- #include virtual="/SmartCare/Funcionarios/Js/Validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 17/01/2005
' Descrição: Pagina de administração de Funcionarios
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim id,id_Usuario,Nome,id_Cargo,id_Departamento,id_Cor_Pele,Contato1,Contato2,Contato3,DataContratacao,DataDemissao,RG,CPF,Endereco,CEP,Banco1,Agencia1,CC1,Banco2,Agencia2,CC2,Email,Ramal,id_OperadoraPager,Pager,Sexo
Dim Login, Senha, CODIGO_MEDICO,TelefoneResidencial,TelefoneCelular,Bairro,Cidade,UF,Qtd_Maxima_Atendimento
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE JÁ EXISTEM
Function VisualizarFuncionarios

	dim pag
	regs = 15 'Aqui setamos quantos registros serão listados por página. 
	pag = request.querystring("pagina")
		if pag = "" Then
		   pag = 1
		end if
	set rs = createobject("adodb.recordset")
	rs.cursortype = 3 'Definimos o cursor a ser utilizado
	rs.pagesize = regs

	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.Funcionarios_Visualizar '"&Request("Nome")&"' , '"&Request("id_Departamento")&"' , '"&Request("id_Cargo")&"' , '"&Request("id_Especializacao")&"' , '"&Request("id_Disponibilidade")&"' , '"&Request("id_Cobertura")&"', '' , '' , '', '' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					rs.absolutepage = pag
					For x = 1 To Rs.Pagesize
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If Not Response.IsClientConnected  Then Rs.close : Set Rs = Nothing : Conn.Close : set Conn = nothing  : Response.end 'Verifica se o usuario ainda esta conectado na consulta
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						if Cstr(request("PintaTR")) = Cstr(Rs("id")) Then zebrado = "zebra3" End if 'Somente para traser pintado o registroda lista que ele selecionou
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>Funcionarios:</Td>" & Chr(10)
							Response.Write "<Td>Departamento:</Td>" & Chr(10)
							Response.Write "<Td>Cargo:</Td>" & Chr(10)
							Response.Write "<Td>Editar:</Td>" & Chr(10)
							Response.Write "<Td>Excluir:</Td>" & Chr(10)
						Response.Write "</Tr>"& Chr(10)

						Response.Write "<Tr class='"&zebrado&"'>" & Chr(10)
							Response.Write "<Td >"&Rs("Nome")&"</Td>" & Chr(10)
							Response.Write "<Td >"&Rs("Departamento")&"</Td>" & Chr(10)
							Response.Write "<Td >"&Rs("Cargo")&"</Td>" & Chr(10)
							Response.Write "<td >"&"<a href='default.asp?action=EditarFuncionarios&id=" &rs("id")& "&id_Usuario="&Rs("id_Usuario")&"'>Editar</a>"&"</td>" & Chr(10) 
							Response.Write "<Td >"&"<a href=""javascript:Confirmar(" & rs("id_Usuario") & " , '" & rs("Nome") & "' , 'ATENÇÂO !!\nDeseja mesmo excluir o funcionario:' , 'default.asp?action=ExcluirFuncionarios&id_Usuario="&rs("id_Usuario")&"' )"" >Excluir</a>"&"</td>" & Chr(10) 
						Response.Write "</Tr>" & Chr(10)
							Response.Write "<Tr class='"&zebrado&"'>" & Chr(10)
								Response.Write "<Td colspan='5'>" & Chr(10)
									Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0'>" & Chr(10)
										Response.Write "<tr>" & Chr(10)
											Response.Write "<td valign='top' width='15%'>"&Funcionario_Imagem(Rs("id"),"60","80")&"</td>" & Chr(10)
											Response.Write "<td valign='top' width='25%'> <img src='/SmartCare/images/placa_Especializacoes.gif' >"&Funcionarios_Especializacao(Rs("id"))&"</td>" & Chr(10)
											Response.Write "<td valign='top' width='25%'><img src='/SmartCare/images/placa_Disponibilidades.gif'  >"&Funcionarios_Disponibilidade(Rs("id"))&"</td>" & Chr(10)
											Response.Write "<td valign='top' width='35%'><img src='/SmartCare/images/placa_Cobertura.gif'  >"&Funcionarios_Cobertura(Rs("id"))&"</td>" & Chr(10)
										Response.Write "</tr>" & Chr(10)
								    Response.Write "</table> " & Chr(10)
								Response.Write "</Td>" & Chr(10)
							Response.Write "</Tr>" & Chr(10)
							Response.Write "</Table>"
					Rs.MoveNext
					Next
					Response.Write "<Table width='100%' border='0' ><Tr><td align ='center' class='texto'>Total de registros encontrado: <b>"&Rs.RecordCount&"</b></td></tr></Table>"
				Else 'Caso não seja encontrado nenhum registro
					Content = Content & "<Table><tr><td class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
					'Inicio da paginação
							'Caso tenha algum campo de busca na pagina coloque aqui o nome dele. Isso foi feito para nãi ter que ficar colocando em varios lugares
							VariaveisBusca = "Action="&Request("action")&"&Nome="&Request("Nome")&"&id_Departamento="&Request("id_Departamento")&"&id_Cargo="&Request("id_Cargo")&"&id_Cobertura="&Request("id_Cobertura")&"&id_Especializacao="&Request("id_Especializacao")&"&id_Disponibilidade="&Request("id_Disponibilidade")&" "
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

'Busca as categorias das peginas
Function Categorias

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = 	"SELECT  * " &_ 
			"FROM Menu_Categorias_Admin Where FlgAtivo = 1 Order By Ordem" 
			Rs.open SQL, CONN, 3
			If Not Rs.Eof Then
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' >" & Chr(10)
					For x = 1 To Rs.Recordcount
						If Rs.Eof Then Exit For
							Response.Write "<Tr>"  & Chr(10)
								Response.Write "<Td class=texto><b>"&Ucase(Rs("Categoria"))&"</b></Td>" & Chr(10)
							Response.Write "</Tr>" & Chr(10)
							Response.Write "<Tr>"  & Chr(10)
								Response.Write "<Td class=texto>"&Paginas(Rs("id"))&"</Td>" & Chr(10)
							Response.Write "</Tr>" & Chr(10)
					Rs.MoveNext
					Next
					Response.Write "</Table>" & Chr(10)
			End if

End Function

'Busca as paginas de acesso
Function Paginas(id_Categoria)

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = 	"SELECT  dbo.Menu_Paginas_Admin.id, dbo.Menu_Paginas_Admin.id_Menu_Categorias_Admin, dbo.Menu_Paginas_Admin.Nome, " &_ 
			"dbo.Menu_Paginas_Admin.Link, dbo.Menu_Paginas_Admin.Ordem, dbo.Menu_Paginas_Admin.FlgAtivo, dbo.Menu_Categorias_Admin.Categoria " &_ 
			"FROM dbo.Menu_Categorias_Admin INNER JOIN " &_ 
			"dbo.Menu_Paginas_Admin ON dbo.Menu_Categorias_Admin.id = dbo.Menu_Paginas_Admin.id_Menu_Categorias_Admin " &_ 
			"Where id_Menu_Categorias_Admin = '"&id_Categoria&"' AND Menu_Paginas_Admin.FlgAtivo = 1 "
			Rs.open SQL, CONN, 3
			If Not Rs.Eof Then
				For x = 1 To Rs.RecordCount
					If rs.eof then exit for
					If Request("id") <> "" Then
						If SelecionaChecked(Request("id_Usuario"),rs("id")) = True Then checked = "checked" Else checked = "" End if
					End if
					Response.Write 	"<td class='texto' ><input name='id_Menu_Paginas_Admin' type='checkbox'  id='id_Menu_Paginas_Admin' value='"&Rs("id")&"' "&checked&">"&Rs("Nome")&"</td>" & Chr(10)
					If x mod 3 = 0 Then 'Quebra por coluna, o numero que estiver dividinho sera o numero de colunas
						Response.Write "</tr><tr>"
					End if
					
				Rs.MoveNext
				Next
			End if


End Function

'FUNÇÃO RESPONSAVEL POR VERIFICAR SE O FUNCIONARIO TEM PERMISSÃO A UMA DETERMINADA PAGINA
'CASO TENHA PERMISSAO ENTAO É SETADO COMO TRUE
Function SelecionaChecked(id_Usuario,id_Menu_Paginas_Admin)

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = 	"Select * From UsuariosXMenu_Paginas_Admin Where id_Usuario = "&id_Usuario&" and id_Menu_Paginas_Admin = "&id_Menu_Paginas_Admin&" "
			Rs.open SQL, CONN, 3
			If Not Rs.Eof Then
				For x  = 1 To Rs.RecordCount
					IF Rs.Eof Then Exit For
					
					SelecionaChecked = True
				
				Rs.MoveNext
				Next
			End if
			Rs.Close
			Set Rs = Nothing

End Function


'FUNÇÃO QUE MONTA A LISTA DE COBERTURAS PARA SEREM SELECIONADAS DIVERSAS COBERTURAS
Function Cobertura
	
	SQL = 	"SELECT  * " &_
	  		"FROM FuncionariosXCobertura " &_
			"Where id_Funcionario = '"&request("id")&"' "
			set rs2 = createobject("adodb.recordset")
			Rs2.open SQL, CONN, 3

	SQL = 	"SELECT  * " &_
	  		"FROM COBERTURA " &_
			"Order By nome "
			set Rs = createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				If Rs.eof Then
   					response.write  "Nenhuma cobertura encontrada " & "<br>"
					else
						Content = ""
						Content = Content &_
						"<select name='id_cobertura' size='12' multiple>"
							For x = 1 to rs.recordcount
								IF Not Rs2.eof then
									selected = ""
										For y=1 to rs2.recordcount
											If trim(rs("id")) = Trim(rs2("id_cobertura")) Then
												selected = "selected"
											End If
										rs2.movenext
										next
										rs2.movefirst
								End if
										Content = Content &_
										"<option value=""" & rs("id") & """ " & selected & ">" & rs("nome") & "</option>"
							rs.movenext
							next
							Rs.Close
							Set Rs = Nothing
							Rs2.Close
							Set Rs2 = Nothing
				End if
				Cobertura = Content & "</select>"

End Function

'FUNÇÃO QUE MONTA A LISTA DE COBERTURAS PARA SEREM SELECIONADAS DIVERSAS COBERTURAS
Function Especializacao
	
	SQL = 	"SELECT  * " &_
	  		"FROM FuncionariosXEspecializacao " &_
			"Where id_Funcionario = '"&request("id")&"' "
			set rs2 = createobject("adodb.recordset")
			Rs2.open SQL, CONN, 3

	SQL = 	"SELECT  * " &_
	  		"FROM ESPECIALIZACOES " &_
			"Order By Descricao "
			set Rs = createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				If Rs.eof Then
   					response.write  "Nenhuma especialização encontrada " & "<br>"
					else
						Content = ""
						Content = Content &_
						"<select name='id_especializacao' size='12' multiple>"
							For x = 1 to rs.recordcount
								IF Not Rs2.eof then
									selected = ""
										For y=1 to rs2.recordcount
											If trim(rs("id")) = Trim(rs2("id_especializacao")) Then
												selected = "selected"
											End If
										rs2.movenext
										next
										rs2.movefirst
								End if
										Content = Content &_
										"<option value=""" & rs("id") & """ " & selected & ">" & rs("Descricao") & "</option>"
							rs.movenext
							next
							Rs.Close
							Set Rs = Nothing
							Rs2.Close
							Set Rs2 = Nothing
				End if
				Especializacao = Content & "</select>"

End Function

'FUNÇÃO QUE MONTA A LISTA DE DISPONIBILIDADES PARA SEREM SELECIONADAS
Function Disponibilidade
	
	SQL = 	"SELECT  * " &_
	  		"FROM FuncionariosXDisponibilidade " &_
			"Where id_Funcionario = '"&request("id")&"' "
			set rs2 = createobject("adodb.recordset")
			Rs2.open SQL, CONN, 3

	SQL = 	"SELECT  * " &_
	  		"FROM DISPONIBILIDADES " &_
			"Order By Descricao "
			set Rs = createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				If Rs.eof Then
   					response.write  "Nenhuma disponibilidade encontrada " & "<br>"
					else
						Content = ""
						Content = Content &_
						"<select name='id_disponibilidade' size='12' multiple>"
							For x = 1 to rs.recordcount
								IF Not Rs2.eof then
									selected = ""
										For y=1 to rs2.recordcount
											If trim(rs("id")) = Trim(rs2("id_disponibilidade")) Then
												selected = "selected"
											End If
										rs2.movenext
										next
										rs2.movefirst
								End if
										Content = Content &_
										"<option value=""" & rs("id") & """ " & selected & ">" & rs("Descricao") & "</option>"
							rs.movenext
							next
							Rs.Close
							Set Rs = Nothing
							Rs2.Close
							Set Rs2 = Nothing
				End if
				Disponibilidade = Content & "</select>"

End Function


'FUNÇÃO RESPONSAVEL POR INCLUIR AS COBERTURAS SELECIONADAS NA LISTA
Function IncluirCobertura

	SQL	=	"Select Max(id) As ID From FUNCIONARIOS "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				id = Rs("id")
			Rs.close
			Set Rs = Nothing

	For x  = 1 To Request.Form("id_Cobertura").Count		
		SQL = 	"INSERT INTO FuncionariosXCobertura (id_Cobertura,id_Funcionario) VALUES ( '"&Request("id_Cobertura")(x)&"' , '"&id&"'  ) "
			Conn.execute(SQL)	
	Next

End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR AS ESPECIALIZACOES SELECIONADAS NA LISTA
Function IncluirEspecializacao

	SQL	=	"Select Max(id) As ID From FUNCIONARIOS "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				id = Rs("id")
			Rs.close
			Set Rs = Nothing

	For x  = 1 To Request.Form("id_especializacao").Count		
		SQL = 	"INSERT INTO FuncionariosXEspecializacao (id_Especializacao,id_Funcionario) VALUES ( '"&Request("id_especializacao")(x)&"' , '"&id&"'  ) "
			Conn.execute(SQL)	
	Next

End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR AS DISPONIBILIDADES SELECIONADAS NA LISTA
Function IncluirDisponibilidade

	SQL	=	"Select Max(id) As ID From FUNCIONARIOS "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				id = Rs("id")
			Rs.close
			Set Rs = Nothing

	For x  = 1 To Request.Form("id_Disponibilidade").Count		
		SQL = 	"INSERT INTO FuncionariosXDisponibilidade (id_Disponibilidade,id_Funcionario) VALUES ( '"&Request("id_Disponibilidade")(x)&"' , '"&id&"'  ) "
			Conn.execute(SQL)	
	Next

End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR AS Permissoes SELECIONADAS NA LISTA
Function IncluirPermissoes(id_Usuario)

	For x  = 1 To Request.Form("id_Menu_Paginas_Admin").Count		
		SQL = 	"INSERT INTO UsuariosXMenu_Paginas_Admin (id_Menu_Paginas_Admin,id_Usuario) VALUES ( '"&Request("id_Menu_Paginas_Admin")(x)&"' , '"&id_Usuario&"' ) "
			Conn.execute(SQL)	
	Next

End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR NOVOS REGISTROS
Function IncluirFuncionarios

			On Error Resume Next 'Inicia o Tratamento de erro

				SQL_1 = 	"INSERT INTO USUARIOS (Login,Senha,Tipo) VALUES ( '"&Trim(Replace(Request("Login"),"'","''"))&"' , '"&Trim(Replace(Request("Senha"),"'","''"))&"' , 1  ) "
				Conn.BeginTrans  'Inicia a Transação
				Conn.execute(SQL_1) 'Executa a Query que insere o usuario
				id_Usuario = Conn.execute("SELECT @@IDENTITY")(0).Value
					
				'FAZ A VERIFICAÇÃO PARA SABER SE FOI PREENCHIDO O CAMPO DATA DEMISSAO,  CASO TENHA SIDO ENTAO E COLOCADO A DATA DE DEMISSAO, CASO CONTRARIO É POSTADO O VALOR NULL
				If Trim(Request("DataDemissao")) <> "" Then DataDemissao = "'"&Request("DataDemissao")&"'" Else DataDemissao = "NULL" End If
			
				SQL_2 = 	"INSERT INTO FUNCIONARIOS (id_Usuario,id_Cargo,id_Departamento,id_Cor_Pele,Nome,CODIGO_MEDICO,TelefoneResidencial,TelefoneCelular,Contato1,Contato2,Contato3,DataContratacao,DataDemissao,RG,CPF,Endereco,CEP,Bairro,Cidade,UF,Banco1,Agencia1,CC1,Banco2,Agencia2,CC2,Email,Ramal,id_OperadoraPager,Pager,Sexo,Qtd_Maxima_Atendimento) VALUES ( '"&id_Usuario&"' , '"&Trim(Cint(Request("id_Cargo")))&"','"&Trim(Cint(Request("id_Departamento")))&"','"&Trim(Cint(Request("id_Cor_Pele")))&"','"&Trim(Replace(Request("Nome"),"'","''"))&"','"&Trim(Replace(Request("CODIGO_MEDICO"),"'","''"))&"','"&Trim(Replace(Request("TelefoneResidencial"),"'","''"))&"','"&Trim(Replace(Request("TelefoneCelular"),"'","''"))&"','"&Trim(Replace(Request("Contato1"),"'","''"))&"','"&Trim(Replace(Request("Contato2"),"'","''"))&"','"&Trim(Replace(Request("Contato3"),"'","''"))&"','"&Trim(Replace(Request("DataContratacao"),",","."))&"',"&Trim(IfTxtBrancoNull(Request("DataDemissao")))&",'"&Trim(Replace(Replace(Request("RG"),".",""),"-",""))&"','"&Trim(Replace(Request("CPF"),"-",""))&"','"&Trim(Replace(Request("Endereco"),"'","''"))&"','"&Trim(Replace(Request("CEP"),"-",""))&"','"&Trim(Request("Bairro"))&"','"&Trim(Request("Cidade"))&"','"&Trim(Request("UF"))&"','"&Trim(Request("Banco1"))&"','"&Trim(Replace(Request("Agencia1"),"-",""))&"','"&Trim(Replace(Request("CC1"),"-",""))&"','"&Trim(Request("Banco2"))&"','"&Trim(Replace(Request("Agencia2"),"-",""))&"','"&Trim(Replace(Request("CC2"),"-",""))&"','"&Trim(Replace(Request("email"),"'","''"))&"','"&Trim(Request("Ramal"))&"','"&Trim(Request("id_OperadoraPager"))&"','"&Trim(Request("Pager"))&"' , '"&Trim(Replace(Request("Sexo"),"'","''"))&"' , '"&Trim(Replace(Request("Qtd_Maxima_Atendimento"),"'","''"))&"'  ) "
				Conn.execute(SQL_2) 'Executa a Query que insere o funcionario
				Call IncluirCobertura 'CHAMA A FUNÇÃO QUE INSERE AS COBERTURAS SELECIONADAS
				Call IncluirEspecializacao 'CHAMA A FUNÇÃO QUE INSERE AS ESPECIALIZAÇÕES SELECIONADAS
				Call IncluirDisponibilidade 'CHAMA A FUNÇÃO QUE INSERE AS DISPONIBILIDADES SELECIONADAS
				Call IncluirPermissoes(id_Usuario) 'CHAMA A FUNÇÃO QUE INSERE AS PERMISSOES DE ACESSO
			If Err <> 0 Then 'Verifica se ocorreu algum erro
				Conn.RollbackTrans 'Se foi detectado algum erro entao a Transação é desfeita e nao é inserido nenhum registro
				Response.Write "Foi detectado um erro e a ação foi cancelada: " & Err.Description
				Response.End
				Else
					Conn.CommitTrans 'Caso não tenha ocorrido nenhum erro entao a transação é efeutuado com sucesso
					response.write "<script>location = 'default.asp?PintaTR="&Conn.execute("SELECT @@IDENTITY")(0).Value&"' </script>"
			End If

End Function

'FUNÇÃO RESPONSAVEL POR CARREGAR OS REGISTROS PARA MOSTRAR NO FORMULARIO
Public Function EditarFuncionarios

	SQL	=	"SELECT dbo.Funcionarios.*, dbo.Usuarios.Login, dbo.Usuarios.Senha " &_ 
			"FROM dbo.Funcionarios INNER JOIN " &_ 
			"dbo.Usuarios ON dbo.Funcionarios.id_Usuario = dbo.Usuarios.id " &_ 
			"Where dbo.Funcionarios.id = "&Cint(Request("id"))&" "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				id = Rs("id")
				id_Usuario = Rs("id_Usuario")
				Nome = Trim(Rs("Nome"))
				id_Cargo = Trim(Rs("id_Cargo"))
				id_Departamento = Trim(Rs("id_Departamento"))
				id_Cor_Pele = Rs("id_Cor_Pele")
				CODIGO_MEDICO = Trim(Rs("CODIGO_MEDICO"))
				TelefoneResidencial = Trim(Rs("TelefoneResidencial"))
				TelefoneCelular = Trim(Rs("TelefoneCelular"))
				Contato1 = Trim(Rs("Contato1"))
				Contato2 = Trim(Rs("Contato2"))
				Contato3 = Trim(Rs("Contato3"))
				DataContratacao = Trim(ArrumaData(Rs("DataContratacao")))
				DataDemissao = Trim(ArrumaData(Rs("DataDemissao")))
				RG = Trim(Rs("RG"))
				CPF = Trim(Rs("CPF"))
				Endereco = Trim(Rs("Endereco"))
				CEP = Trim(Rs("CEP"))
				Bairro = Trim(Rs("Bairro"))
				Cidade = Trim(Rs("Cidade"))
				UF = Trim(Rs("UF"))
				Banco1 = Trim(Rs("Banco1"))
				Agencia1 = Trim(Rs("Agencia1"))
				CC1 = Trim(Rs("CC1"))
				Banco2 = Trim(Rs("Banco2"))
				Agencia2 = Trim(Rs("Agencia2"))
				CC2 = Trim(Rs("CC2"))
				Email = Trim(Rs("Email"))
				Ramal = Trim(Rs("Ramal"))
				id_OperadoraPager = Trim(Rs("id_OperadoraPager"))
				Pager = Trim(Rs("Pager"))
				Sexo = Trim(Rs("Sexo"))
				Qtd_Maxima_Atendimento = Trim(Rs("Qtd_Maxima_Atendimento"))
				Login = Rs("Login")
				Senha = Rs("Senha")
				
			Rs.Close
			Set Rs = Nothing

End Function

'FUNÇÃO RESPONSAVEL POR ALTERAR A LISTA DE COBERTURAS
Function AlterarCobetura

	SQL	=	"DELETE FROM FuncionariosXCobertura Where id_Funcionario ="&Cint(request("id"))
			conn.execute(SQL)

	For x  = 1 To Request.Form("id_Cobertura").Count		
		SQL = 	"INSERT INTO FuncionariosXCobertura (id_Cobertura,id_Funcionario) VALUES ( '"&Request("id_Cobertura")(x)&"' , '"&Cint(request("id"))&"'  ) "
			Conn.execute(SQL)	
	Next

End Function

'FUNÇÃO RESPONSAVEL POR ALTERAR A LISTA DE ESPECIALIZAÇÕES
Function AlterarEspecializacao

	SQL	=	"DELETE FROM FuncionariosXEspecializacao Where id_Funcionario ="&Cint(request("id"))
			conn.execute(SQL)

	For x  = 1 To Request.Form("id_Especializacao").Count		
		SQL = 	"INSERT INTO FuncionariosXEspecializacao (id_Especializacao,id_Funcionario) VALUES ( '"&Request("id_Especializacao")(x)&"' , '"&Cint(request("id"))&"'  ) "
			Conn.execute(SQL)	
	Next

End Function

'FUNÇÃO RESPONSAVEL POR ALTERAR A LISTA DE DISPONIBILIDADES
Function AlterarDisponibilidade

	SQL	=	"DELETE FROM FuncionariosXDisponibilidade Where id_Funcionario ="&Cint(request("id"))
			conn.execute(SQL)

	For x  = 1 To Request.Form("id_Disponibilidade").Count		
		SQL = 	"INSERT INTO FuncionariosXDisponibilidade (id_Disponibilidade,id_Funcionario) VALUES ( '"&Request("id_Disponibilidade")(x)&"' , '"&Cint(request("id"))&"'  ) "
			Conn.execute(SQL)	
	Next

End Function

'FUNÇÃO RESPONSAVEL POR ALTERAR A LISTA DE DISPONIBILIDADES
Function AlterarPermissoes

	SQL	=	"DELETE FROM UsuariosXMenu_Paginas_Admin Where id_Usuario ="&Cint(Request("id_Usuario"))
			conn.execute(SQL)

	For x  = 1 To Request.Form("id_Menu_Paginas_Admin").Count		
		SQL = 	"INSERT INTO UsuariosXMenu_Paginas_Admin (id_Menu_Paginas_Admin,id_Usuario) VALUES ( '"&Request("id_Menu_Paginas_Admin")(x)&"' , '"&Cint(Request("id_Usuario"))&"'  ) "
			Conn.execute(SQL)	
	Next

End Function


'FUNÇÃO RESPONSAVEL POR ALTERAR REGISTROS
Function AlterarFuncionarios

			On Error Resume Next 'Inicia o Tratamento de erro
				SQL_1	=	"Update USUARIOS SET Login = '"&Trim(Replace(Request("Login"),"'",""))&"',Senha = '"&Trim(Replace(Request("Senha"),"'",""))&"' Where id = "&Cint(Request("id_Usuario"))
				Conn.BeginTrans  'Inicia a Transação
				Conn.execute(SQL_1) 'Executa a Query	
				SQL_2	=	"Update FUNCIONARIOS SET id_Cargo = '"&Trim(Cint(Request("id_Cargo")))&"',id_Departamento = '"&Trim(Cint(Request("id_Departamento")))&"',id_Cor_Pele = '"&Trim(Cint(Request("id_Cor_Pele")))&"',Nome='"&Trim(Replace(Request("Nome"),"'","''"))&"',CODIGO_MEDICO='"&Trim(Replace(Request("CODIGO_MEDICO"),"'","''"))&"',TelefoneResidencial='"&Trim(Replace(Request("TelefoneResidencial"),"'","''"))&"',TelefoneCelular='"&Trim(Replace(Request("TelefoneCelular"),"'","''"))&"',Contato1='"&Trim(Replace(Request("Contato1"),"'","''"))&"',Contato2='"&Trim(Replace(Request("Contato2"),"'","''"))&"',Contato3='"&Trim(Replace(Request("Contato3"),"'","''"))&"',DataContratacao='"&Trim(Replace(Request("DataContratacao"),",","."))&"',DataDemissao="&Trim(IfTxtBrancoNull(Request("DataDemissao")))&",RG='"&Trim(Replace(Replace(Request("RG"),".",""),"-",""))&"',CPF='"&Trim(Replace(Request("CPF"),"-",""))&"',Endereco='"&Trim(Replace(Request("Endereco"),"'","''"))&"',CEP='"&Trim(Replace(Request("CEP"),"-",""))&"',Bairro = '"&Trim(Request("Bairro"))&"',Cidade = '"&Trim(Request("Cidade"))&"',UF = '"&Trim(Request("UF"))&"',Banco1='"&Trim(Request("Banco1"))&"',Agencia1='"&Trim(Replace(Request("Agencia1"),"-",""))&"',CC1='"&Trim(Replace(Request("CC1"),"-",""))&"',Banco2='"&Trim(Request("Banco2"))&"',Agencia2='"&Trim(Replace(Request("Agencia2"),"-",""))&"',CC2='"&Trim(Replace(Request("CC2"),"-",""))&"',Email='"&Trim(Replace(Request("email"),"'","''"))&"',Ramal='"&Trim(Request("Ramal"))&"',id_OperadoraPager='"&Trim(Request("id_OperadoraPager"))&"',Pager='"&Trim(Request("Pager"))&"' , Sexo = '"&Trim(Replace(Request("Sexo"),"'","''"))&"' , Qtd_Maxima_Atendimento = '"&Trim(Replace(Request("Qtd_Maxima_Atendimento"),"'","''"))&"'   Where id = "&Cint(Request("id"))
				Conn.execute(SQL_2) 'Executa a Query
				Call AlterarCobetura 'CHAMA A FUNÇÃO QUE ALTERA AS COBERTURAS SELECIONADAS
				Call AlterarEspecializacao 'CHAMA A FUNÇÃO QUE ALTERA AS ESPECIALIZAÇÕES SELECIONADAS
				Call AlterarDisponibilidade 'CHAMA A FUNÇÃO QUE ALTERA AS DISPONIBILIDADES SELECIONADAS
				Call AlterarPermissoes 'CHAMA A FUNÇÃO QUE ALTERA AS PERMISSÕES DE ACCESSO SELECIONADAS
			If Err <> 0 Then 'Verifica se ocorreu algum erro
				Conn.RollbackTrans 'Se foi detectado algum erro entao a Transação é desfeita e nao é inserido nenhum registro
				Response.Write "Foi detectado um erro e a ação foi cancelada: " & Err.Description
				Response.End
				Else
					Conn.CommitTrans 'Caso não tenha ocorrido nenhum erro entao a transação é efeutuado com sucesso
					response.write "<script>location = 'default.asp?PintaTR="&Request("id")&"' </script>"
			End If
				
End Function

'FUNÇÃO RESPONSAVEL POR FAZER O UPLOAD DA IMAGEM DO FUNCIONARIO
Function Upload()

	Dim Uploader, File
	Set Uploader = New FileUploader
	Server.ScriptTimeout = 10000000
	Uploader.Upload()
	For Each File In Uploader.Files.Items
		If lcase(Right(File.FileName, 4)) <> ".jpg"	then
			Response.write "<Script>alert('A imagem nao foi enviada porque seu formato é diferente da extenção JPG');</Script>"
			exit for
		end if
		File.FileName = Uploader.Form("id") &".jpg" 'a imagem ira ser salva com o nome do profissional id para nao ter duplicidade
		img = File.FileName
		'salva a imagem
		File.SaveToDisk request.servervariables("appl_physical_path")&"funcionarios/Img_Funcionarios/"

		'faz o update no campo da imagem
		SQL	=	"Update FUNCIONARIOS SET img = '"&img&"' Where id = "&Uploader.Form("id")
				conn.execute(SQL)
	Next
	
	response.write "<script>location = 'default.asp?action=EditarFuncionarios&id="&Uploader.Form("id")&"' </script>"
	
End Function

'FUNÇÃO RESPONSAVEL POR EXCLUIR REGISTROS
Function ExcluirFuncionarios

	SQL	=	"DELETE FROM USUARIOS Where id ="&Cint(request("id_Usuario"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Form_Incluir_Funcionarios"
		action = "default.asp?action=IncluirFuncionarios"
%>
	<!-- #include virtual="/SmartCare/Funcionarios/modelos/Form_Incluir_Funcionarios.htm" -->
<%			
	Case "IncluirFuncionarios"
		Call IncluirFuncionarios 'CHAMA A FUNÇÃO QUE IRA INCLUIR UM NOVO REGISTRO
		
	Case "EditarFuncionarios"
		Call EditarFuncionarios 'CHAMA A FUNÇÃO QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
		action = "default.asp?action=AlterarFuncionarios"
%>
	<!-- #include virtual="/SmartCare/Funcionarios/modelos/Form_Incluir_Funcionarios.htm" -->
<%		
	Case "AlterarFuncionarios"
		Call AlterarFuncionarios 'CHAMA A FUNÇÃO QUE IRA ALTERAR
		
	Case "ExcluirFuncionarios"
		Call ExcluirFuncionarios 'CHAMA A FUNÇÃO QUE IRA EXCLUIR
	
	Case "Upload"
		Call Upload
			
	Case Else
%>
	<!-- #include virtual="/SmartCare/Funcionarios/modelos/Form_Visualizar_Funcionarios.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

