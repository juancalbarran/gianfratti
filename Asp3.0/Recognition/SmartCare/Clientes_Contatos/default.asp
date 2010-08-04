<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<!-- #include virtual="/SmartCare/Clientes_Contatos/Js/Validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 01/03/2005
' Descrição: Pagina de administração de Contatos dos Clientes
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim id,id_Usuario,id_ClienteDepartamento,Nome,Telefone,Cargo,Endereco,CEP,UF,Cidade,email,senha,data_cadastro,Departamento,Login
Dim Solicitacao,Atendimento,Evolucao
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE JÁ EXISTEM
Function VisualizarClientes_Contatos

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.ClientesContatos_Visualizar '"&Trim(Replace(Request("Busca"),"'",""))&"' , '"&Trim(Request("id_Cliente"))&"' , '"&Trim(Request("id_Local"))&"' , '"&Trim(Request("id_ClienteDepartamento"))&"' , '"&Trim(Request("UF"))&"' , '"&Trim(Request("id_Cobertura"))&"' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Titulo_Tabela'>" & Chr(10)&_
							"<Td>Nome:</Td>" & Chr(10)&_
							"<Td>Cliente:</Td>" & Chr(10)&_
							"<Td>Local:</Td>" & Chr(10)&_
							"<Td>Cobertura:</Td>" & Chr(10)&_
							"<Td>Departamento:</Td>" & Chr(10)&_
							"<Td>Cidade:</Td>" & Chr(10)&_
							"<Td>UF:</Td>" & Chr(10)&_
							"<Td>Editar:</Td>" & Chr(10)&_
							"<Td>Excluir:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Nome")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Cliente_Nome")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Local_Descricao")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Cobertura_Nome")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Departamento_Descricao")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Cidade")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("UF")&"</Td>" & Chr(10)&_
							"<td class='"&zebrado&"'>"&"<a href='default.asp?action=EditarClientes_Contatos&id=" &rs("id")& "'>Editar</a>"&"</td>" & Chr(10) &_ 
							"<Td class='"&zebrado&"'>"&"<a href=""javascript:Confirmar(" & rs("id_Usuario") & " , '" & rs("Nome") & "' , 'ATENÇÂO !!\nDeseja mesmo excluir o contato:' , 'default.asp?action=ExcluirClientes_Contatos&id_Usuario="&rs("id_Usuario")&"' )"" >Excluir</a>"&"</td>" & Chr(10) &_ 
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
			VisualizarClientes_Contatos = Content

End Function

'Função responsavel por incluir as permiossões de recebimento de acompanhamento de email
Function Incluir_Acompanhamento_Email(id_contato)

		SQL =	"INSERT INTO ClientesContatos_PermissaoEmail (id_Contato,Solicitacao,Atendimento,Evolucao) VALUES ( '"&id_contato&"' , '"&Trim(Replace(Request("Solicitacao"),"'","''"))&"' , '"&Trim(Replace(Request("Atendimento"),"'","''"))&"' ,  '"&Trim(Replace(Request("Evolucao"),"'","''"))&"'  ) "
				Conn.execute(SQL) 'Executa a Query que insere o usuario

End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR NOVOS REGISTROS
Function IncluirClientes_Contatos

	On Error Resume Next 'Inicia o Tratamento de erro

		SQL_1 =	"INSERT INTO USUARIOS (Login,Senha,Tipo) VALUES ( '"&Trim(Replace(Request("Login"),"'","''"))&"' , '"&Trim(Replace(Request("Senha"),"'","''"))&"' , 2  ) "
				Conn.BeginTrans  'Inicia a Transação
				Conn.execute(SQL_1) 'Executa a Query que insere o usuario
				id_Usuario = Conn.execute("SELECT @@IDENTITY")(0).Value


		SQL =	"INSERT INTO ClientesContatos (id_ClienteDepartamento,id_Usuario,Nome,Telefone,Cargo,Endereco,CEP,UF,Cidade,email,login,senha) VALUES ( '"&Cint(Request("id_Departamento"))&"' , '"&id_Usuario&"' , '"&Trim(Replace(Request("Nome"),"'","''"))&"' , '"&Trim(Replace(Request("Telefone"),"'","''"))&"' , '"&Trim(Replace(Request("Cargo"),"'","''"))&"' , '"&Trim(Replace(Request("Endereco"),"'","''"))&"' , '"&Trim(Replace(Request("CEP"),"'","''"))&"' , '"&Trim(Replace(Request("UF"),"'","''"))&"' , '"&Trim(Replace(Request("Cidade"),"'","''"))&"' , '"&Trim(Replace(Request("Email"),"'","''"))&"' , '"&Trim(Replace(Request("Login"),"'","''"))&"' , '"&Trim(Replace(Request("Senha"),"'","''"))&"'  ) "
				conn.execute(SQL)
				id_Contato = Conn.execute("SELECT @@IDENTITY")(0).Value
				
				Call IncluirPermissoes(id_Usuario) 'CHAMA A FUNÇÃO QUE INSERE AS PERMISSOES DE ACESSO
				Call Incluir_Acompanhamento_Email(id_Contato) 'CHAMA A FUNÇÃ OQUE INSERE AS PERMISSÕES DE ACOMPANHAMENTO POR EMAIL
			If Err <> 0 Then 'Verifica se ocorreu algum erro
				Conn.RollbackTrans 'Se foi detectado algum erro entao a Transação é desfeita e nao é inserido nenhum registro
				Response.Write "Foi detectado um erro e a ação foi cancelada: " & Err.Description
				Response.End
				Else
					Conn.CommitTrans 'Caso não tenha ocorrido nenhum erro entao a transação é efeutuado com sucesso
					response.write "<script>location = 'default.asp' </script>"
			End If

End Function

'FUNÇÃO RESPONSAVEL POR CARREGAR OS REGISTROS PARA MOSTRAR NO FORMULARIO
Public Function EditarClientes_Contatos

	SQL	=	"SELECT ClientesContatos.id, ClientesContatos.id_ClienteDepartamento, ClientesContatos.Nome, ClientesContatos.Telefone, ClientesContatos.Cargo, "&_ 
			"ClientesContatos.Endereco, ClientesContatos.CEP, ClientesContatos.UF, ClientesContatos.Cidade, ClientesContatos.email, ClientesContatos.Login, "&_ 
			"ClientesContatos.Senha, ClientesContatos.data_cadastro, ClientesDepartamentos.descricao AS Departamento, ClientesContatos.id_Usuario, "&_ 
			"ClientesContatos_PermissaoEmail.Solicitacao, ClientesContatos_PermissaoEmail.Atendimento, ClientesContatos_PermissaoEmail.Evolucao "&_ 
			"FROM ClientesContatos INNER JOIN "&_ 
			"ClientesDepartamentos ON ClientesContatos.id_ClienteDepartamento = ClientesDepartamentos.id INNER JOIN "&_ 
			"ClientesContatos_PermissaoEmail ON ClientesContatos.id = ClientesContatos_PermissaoEmail.id_Contato  "&_ 
			"Where ClientesContatos.id = "&Cint(Request("id"))&" "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				id = Trim(Rs("id"))
				id_Usuario = Rs("id_Usuario")
				id_ClienteDepartamento = Trim(Rs("id_ClienteDepartamento"))
				Nome = Trim(Rs("Nome"))
				Telefone = Trim(Rs("Telefone"))
				Cargo = Trim(Rs("Cargo"))
				Endereco = Trim(Rs("Endereco"))
				CEP = Trim(Rs("CEP"))
				UF = Trim(Rs("UF"))
				Cidade = Trim(Rs("Cidade"))
				email = Trim(Rs("email"))
				data_cadastro = Trim(Rs("Data_Cadastro"))
				Departamento = Trim(Rs("Departamento"))
				Login = Trim(rs("Login"))
				Senha = Trim(Rs("Senha"))
				If Cint(Rs("Solicitacao")) Then Solicitacao = "checked" Else Solicitacao = "" End if
				If Cint(Rs("Atendimento")) Then Atendimento = "checked" Else Atendimento = "" End if
				If Cint(Rs("Evolucao")) Then Evolucao = "checked" Else Evolucao = "" End if

			Rs.Close
			Set Rs = Nothing

End Function

'Função responsavel por alterar as pernmissões de emails que os contatos vai receber.
Function Alterar_Acompanhamento_Email

		SQL_1 =	"Update ClientesContatos_PermissaoEmail SET Solicitacao = '"&Trim(Replace(Request("Solicitacao"),"'",""))&"',Atendimento = '"&Trim(Replace(Request("Atendimento"),"'",""))&"' ,Evolucao = '"&Trim(Replace(Request("Evolucao"),"'",""))&"' Where id_Contato = "&Cint(Request("id"))
				Conn.execute(SQL_1) 'Executa a Query	

End Function

'FUNÇÃO RESPONSAVEL POR ALTERAR REGISTROS
Function AlterarClientes_Contatos
	
	On Error Resume Next 'Inicia o Tratamento de erro
		SQL_1 =	"Update USUARIOS SET Login = '"&Trim(Replace(Request("Login"),"'",""))&"',Senha = '"&Trim(Replace(Request("Senha"),"'",""))&"' Where id = "&Cint(Request("id_Usuario"))
				Conn.BeginTrans  'Inicia a Transação
				Conn.execute(SQL_1) 'Executa a Query	

		SQL	=	"Update ClientesContatos SET id_ClienteDepartamento = '"&Cint(Request("id_Departamento"))&"' , Nome = '"&Trim(Replace(Request("Nome"),"'","''"))&"' , Telefone = '"&Trim(Replace(Request("Telefone"),"'","''"))&"' , Cargo = '"&Trim(Replace(Request("Cargo"),"'","''"))&"' , Endereco = '"&Trim(Replace(Request("Endereco"),"'","''"))&"' , CEP = '"&Trim(Replace(Request("CEP"),"'","''"))&"' , UF = '"&Trim(Replace(Request("UF"),"'","''"))&"' , Cidade ='"&Trim(Replace(Request("Cidade"),"'","''"))&"' , Email = '"&Trim(Replace(Request("Email"),"'","''"))&"' , Login = '"&Trim(Replace(Request("Login"),"'","''"))&"' , Senha = '"&Trim(Replace(Request("Senha"),"'","''"))&"' Where id = "&Cint(Request("id"))
				conn.execute(SQL)
				Call Alterar_Acompanhamento_Email 'CHAMA A FUNÇÃO QUE IRA DAR AS PERMISSÕES DE RECEBIMENTO DE EMAIL AOS CONTATOS
				Call AlterarPermissoes 'CHAMA A FUNÇÃO QUE ALTERA AS PERMISSOES DE ACESSO
		If Err <> 0 Then 'Verifica se ocorreu algum erro
			Conn.RollbackTrans 'Se foi detectado algum erro entao a Transação é desfeita e nao é inserido nenhum registro
			Response.Write "Foi detectado um erro e a ação foi cancelada: " & Err.Description
			Response.End
			Else
				Conn.CommitTrans 'Caso não tenha ocorrido nenhum erro entao a transação é efeutuado com sucesso
				response.write "<script>location = 'default.asp' </script>"
		End If

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
						If SelecionaChecked(id_Usuario,rs("id")) = True Then checked = "checked" Else checked = "" End if
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

'FUNÇÃO RESPONSAVEL POR INCLUIR AS Permissoes SELECIONADAS NA LISTA
Function IncluirPermissoes(id_Usuario)

	For x  = 1 To Request.Form("id_Menu_Paginas_Admin").Count		
		SQL = 	"INSERT INTO UsuariosXMenu_Paginas_Admin (id_Menu_Paginas_Admin,id_Usuario) VALUES ( '"&Request("id_Menu_Paginas_Admin")(x)&"' , '"&id_Usuario&"'  ) "
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


'FUNÇÃO RESPONSAVEL POR EXCLUIR REGISTROS
Function ExcluirClientes_Contatos

	SQL	=	"DELETE FROM USUARIOS Where id ="&Cint(request("id_Usuario"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Form_Incluir_Clientes_Contatos"
%>
	<!-- #include virtual="/SmartCare/Clientes_Contatos/modelos/Form_Incluir_Clientes_Contatos.htm" -->
<%		
	Case "IncluirClientes_Contatos"
		Call IncluirClientes_Contatos 'CHAMA A FUNÇÃO QUE IRA INCLUIR UM NOVO REGISTRO
		
	Case "EditarClientes_Contatos"
		Call EditarClientes_Contatos 'CHAMA A FUNÇÃO QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
%>
	<!-- #include virtual="/SmartCare/Clientes_Contatos/modelos/Form_Editar_Clientes_Contatos.htm" -->
<%		
	Case "AlterarClientes_Contatos"
		Call AlterarClientes_Contatos 'CHAMA A FUNÇÃO QUE IRA ALTERAR
		
	Case "ExcluirClientes_Contatos"
		Call ExcluirClientes_Contatos 'CHAMA A FUNÇÃO QUE IRA EXCLUIR
		
	Case Else
%>
	<!-- #include virtual="/SmartCare/Clientes_Contatos/modelos/Form_Visualizar_ClientesContatos.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

