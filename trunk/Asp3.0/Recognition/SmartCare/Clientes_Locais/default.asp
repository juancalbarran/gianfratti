<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<!-- #include virtual="/SmartCare/Clientes_Locais/Js/Validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 03/02/2005
' Descrição: Pagina de administração de Locais dos Clientes
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim id,id_cliente,id_cobertura,Descricao,Endereco,Bairro,CEP,Telefone,Contato,Cidade,UF
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE JÁ EXISTEM
Function VisualizarLocais

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.Locais_Visualizar '"&Replace(Request("Busca"),"'","")&"' , '"&Replace(Request("UF"),"'","")&"' , '"&Replace(Request("id_Cliente"),"'","")&"' , '"&Replace(Request("id_Cobertura"),"'","")&"' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Titulo_Tabela'>" & Chr(10)&_
							"<Td>Cliente:</Td>" & Chr(10)&_
							"<Td>Cobertura:</Td>" & Chr(10)&_
							"<Td>Local:</Td>" & Chr(10)&_
							"<Td>UF:</Td>" & Chr(10)&_
							"<Td>Editar:</Td>" & Chr(10)&_
							"<Td>Excluir:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("ClienteNome")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("CoberturaNome")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Descricao")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("UF")&"&nbsp;</Td>" & Chr(10)&_
							"<td class='"&zebrado&"'>"&"<a href='default.asp?action=EditarLocais&id=" &rs("id")& "'>Editar</a>"&"</td>" & Chr(10) &_ 
							"<Td class='"&zebrado&"'>"&"<a href=""javascript:Confirmar(" & rs("id") & " , '" & rs("Descricao") & "' , 'ATENÇÂO !!\nDeseja mesmo excluir o local:' , 'default.asp?action=ExcluirLocais&id="&rs("id")&"' )"" >Excluir</a>"&"</td>" & Chr(10) &_ 
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
			VisualizarLocais = Content

End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR NOVOS REGISTROS
Function IncluirLocais

	SQL = 	"INSERT INTO Locais (id_cliente,id_cobertura,Descricao,Endereco,Bairro,CEP,Telefone,Contato,Cidade,UF) VALUES ( '"&Trim(Cint(Request("id_Cliente")))&"','"&Trim(Cint(Request("id_Cobertura")))&"','"&Trim(Replace(Request("Descricao"),"'","''"))&"','"&Trim(Replace(Request("Endereco"),"'","''"))&"','"&Trim(Replace(Request("Bairro"),"'","''"))&"', '"&Trim(Replace(Request("CEP"),"-",""))&"','"&Trim(Replace(Request("Telefone"),"'","''"))&"','"&Trim(Replace(Request("Contato"),"'","''"))&"' ,'"&Trim(Replace(Request("Cidade"),"'","''"))&"' ,'"&Trim(Replace(Request("UF"),"'","''"))&"'  ) "
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUNÇÃO RESPONSAVEL POR CARREGAR OS REGISTROS PARA MOSTRAR NO FORMULARIO
Public Function EditarLocais

	SQL	=	"Select * From Locais Where id = "&Cint(Request("id"))&" "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				id = Rs("id")
				id_cliente = Trim(Rs("id_cliente"))
				id_cobertura = Trim(Rs("id_cobertura"))
				Descricao = Trim(Rs("Descricao"))
				Endereco = Trim(Rs("endereco"))
				Bairro = Trim(Rs("bairro"))
				CEP = Trim(Rs("CEP"))
				Telefone = Trim(Rs("Telefone"))
				Contato = Trim(Rs("Contato"))
				Cidade = Trim(Rs("Cidade"))
				UF = Trim(Rs("UF"))
				
			Rs.Close
			Set Rs = Nothing

End Function

'FUNÇÃO RESPONSAVEL POR ALTERAR REGISTROS
Function AlterarLocais

	SQL	=	"Update Locais SET id_Cliente = '"&Trim(Cint(Request("id_Cliente")))&"',id_Cobertura='"&Trim(Cint(Request("id_Cobertura")))&"',Descricao='"&Trim(Replace(Request("Descricao"),"'","''"))&"',Endereco='"&Trim(Replace(Request("Endereco"),"'","''"))&"',Bairro='"&Trim(Replace(Request("Bairro"),"'","''"))&"', CEP='"&Trim(Replace(Request("CEP"),"-",""))&"',Telefone='"&Trim(Replace(Request("Telefone"),"'","''"))&"',Contato='"&Trim(Replace(Request("Contato"),"'","''"))&"' ,Cidade='"&Trim(Replace(Request("Cidade"),"'","''"))&"' ,UF='"&Trim(Replace(Request("UF"),"'","''"))&"' Where id = "&Cint(Request("id"))
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUNÇÃO RESPONSAVEL POR EXCLUIR REGISTROS
Function ExcluirLocais

	SQL	=	"DELETE FROM Locais Where id ="&Cint(request("id"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Form_Incluir_Locais"
%>
	<!-- #include virtual="/SmartCare/Clientes_Locais/modelos/Form_Incluir_Local.htm" -->
<%
	Case "IncluirLocais"
		Call IncluirLocais 'CHAMA A FUNÇÃO QUE IRA INCLUIR UM NOVO REGISTRO
		
	Case "EditarLocais"
		Call EditarLocais 'CHAMA A FUNÇÃO QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
%>
	<!-- #include virtual="/SmartCare/Clientes_Locais/modelos/Form_Editar_Local.htm" -->
<%		
	Case "AlterarLocais"
		Call AlterarLocais 'CHAMA A FUNÇÃO QUE IRA ALTERAR
		
	Case "ExcluirLocais"
		Call ExcluirLocais 'CHAMA A FUNÇÃO QUE IRA EXCLUIR
		
	Case Else
%>
	<!-- #include virtual="/SmartCare/Clientes_Locais/modelos/Form_Visualizar_Local.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

