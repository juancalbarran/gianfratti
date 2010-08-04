<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<!-- #include virtual="/SmartCare/ClientesDepartamentos/Js/Validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 01/03/2005
' Descrição: Pagina de administração de Departamentos dos Clientes
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim id,id_cliente,id_local,descricao
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE JÁ EXISTEM
Function VisualizarClientesDepartamentos

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.ClientesDepartamentos_Visualizar '"&Trim(Replace(Request("Busca"),"'",""))&"' , '"&Trim(Request("id_Cliente"))&"' , '"&Trim(Request("id_Local"))&"' , '"&Trim(Request("id_Cobertura"))&"' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Titulo_Tabela'>" & Chr(10)&_
							"<Td>Departamento:</Td>" & Chr(10)&_
							"<Td>Cliente:</Td>" & Chr(10)&_
							"<Td>Local:</Td>" & Chr(10)&_
							"<Td>Cobertura:</Td>" & Chr(10)&_
							"<Td>Editar:</Td>" & Chr(10)&_
							"<Td>Excluir:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Descricao")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Nome")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Local_Descricao")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Cobertura_Nome")&"</Td>" & Chr(10)&_
							"<td class='"&zebrado&"'>"&"<a href='default.asp?action=EditarClientesDepartamentos&id=" &rs("id")& "'>Editar</a>"&"</td>" & Chr(10) &_ 
							"<Td class='"&zebrado&"'>"&"<a href=""javascript:Confirmar(" & rs("id") & " , '" & rs("Descricao") & "' , 'ATENÇÂO !!\nDeseja mesmo excluir o departamento:' , 'default.asp?action=ExcluirClientesDepartamentos&id="&rs("id")&"' )"" >Excluir</a>"&"</td>" & Chr(10) &_ 
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
			VisualizarClientesDepartamentos = Content

End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR NOVOS REGISTROS
Function IncluirClientesDepartamentos

	SQL = 	"INSERT INTO ClientesDepartamentos (id_cliente,id_local,descricao) VALUES ( '"&Cint(Request("id_cliente"))&"' , '"&Cint(Request("id_local"))&"' , '"&Trim(Replace(Request("Descricao"),"'","''"))&"'  ) "
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUNÇÃO RESPONSAVEL POR CARREGAR OS REGISTROS PARA MOSTRAR NO FORMULARIO
Public Function EditarClientesDepartamentos

	SQL	=	"Select * From ClientesDepartamentos Where id = "&Cint(Request("id"))&" "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				id = Rs("id")
				id_cliente = Rs("id_cliente")
				id_local = Rs("id_local")
				Descricao = Trim(Rs("Descricao"))
				
			Rs.Close
			Set Rs = Nothing

End Function

'FUNÇÃO RESPONSAVEL POR ALTERAR REGISTROS
Function AlterarClientesDepartamentos

	SQL	=	"Update ClientesDepartamentos SET id_cliente = '"&Cint(Request("id_Cliente"))&"' , id_local = '"&Cint(Request("id_Local"))&"' , Descricao= '"&Trim(Replace(Request("Descricao"),"'",""))&"' Where id = "&Cint(Request("id"))
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUNÇÃO RESPONSAVEL POR EXCLUIR REGISTROS
Function ExcluirClientesDepartamentos

	SQL	=	"DELETE FROM ClientesDepartamentos Where id ="&Cint(request("id"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Form_Incluir_ClientesDepartamentos"
%>
	<!-- #include virtual="/SmartCare/ClientesDepartamentos/modelos/Form_Incluir_ClientesDepartamentos.htm" -->
<%		
	Case "IncluirClientesDepartamentos"
		Call IncluirClientesDepartamentos 'CHAMA A FUNÇÃO QUE IRA INCLUIR UM NOVO REGISTRO
		
	Case "EditarClientesDepartamentos"
		Call EditarClientesDepartamentos 'CHAMA A FUNÇÃO QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
%>
	<!-- #include virtual="/SmartCare/ClientesDepartamentos/modelos/Form_Editar_ClientesDepartamentos.htm" -->
<%		
	Case "AlterarClientesDepartamentos"
		Call AlterarClientesDepartamentos 'CHAMA A FUNÇÃO QUE IRA ALTERAR
		
	Case "ExcluirClientesDepartamentos"
		Call ExcluirClientesDepartamentos 'CHAMA A FUNÇÃO QUE IRA EXCLUIR
		
	Case Else
%>
	<!-- #include virtual="/SmartCare/ClientesDepartamentos/modelos/Form_Visualizar_ClientesDepartamentos.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

