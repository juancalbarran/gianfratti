<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<!-- #include virtual="/SmartCare/Clientes/Js/Validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 02/02/2005
' Descrição: Pagina de administração de Clientes
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim id,id_Convenio,Nome,RazaoSocial,EnderecoMatriz,Cidade,UF,CEP,Fone,CGC,IE
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE JÁ EXISTEM
Function VisualizarClientes

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.Clientes_Visualizar '"&Trim(Replace(Request("Busca"),"'",""))&"' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Titulo_Tabela'>" & Chr(10)&_
							"<Td>Clientes:</Td>" & Chr(10)&_
							"<Td>Razão Social:</Td>" & Chr(10)&_
							"<Td>Editar:</Td>" & Chr(10)&_
							"<Td>Excluir:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Nome")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("RazaoSocial")&"&nbsp;</Td>" & Chr(10)&_
							"<td class='"&zebrado&"'>"&"<a href='default.asp?action=EditarClientes&id=" &rs("id")& "'>Editar</a>"&"</td>" & Chr(10) &_ 
							"<Td class='"&zebrado&"'>"&"<a href=""javascript:Confirmar(" & rs("id") & " , '" & rs("Nome") & "' , 'ATENÇÂO !!\nDeseja mesmo excluir o cliente:' , 'default.asp?action=ExcluirClientes&id="&rs("id")&"' )"" >Excluir</a>"&"</td>" & Chr(10) &_ 
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
			VisualizarClientes = Content

End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR NOVOS REGISTROS
Function IncluirClientes

	SQL = 	"INSERT INTO CLIENTES (Nome,RazaoSocial,EnderecoMatriz,Fone,CGC,Cidade,UF,Cep,id_Convenio) VALUES ( '"&Trim(Replace(Request("Nome"),"'","''"))&"' , '"&Trim(Replace(Request("RazaoSocial"),"'","''"))&"' , '"&Trim(Replace(Request("EnderecoMatriz"),"'","''"))&"' , '"&Trim(Replace(Request("Fone"),"'","''"))&"' , '"&Trim(Replace(Request("CGC"),"'","''"))&"' , '"&Trim(Replace(Request("Cidade"),"'","''"))&"' , '"&Trim(Replace(Request("UF"),"'","''"))&"' , '"&Trim(Replace(Request("CEP"),"-",""))&"' , '"&Trim(Replace(Request("id_Convenio"),"'","''"))&"'   ) "
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUNÇÃO RESPONSAVEL POR CARREGAR OS REGISTROS PARA MOSTRAR NO FORMULARIO
Public Function EditarClientes

	SQL	=	"Select * From CLIENTES Where id = "&Cint(Request("id"))&" "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				id = Rs("id")
				id_Convenio = Trim(Rs("id_Convenio"))
				Nome = Trim(Rs("Nome"))
				RazaoSocial = Trim(Rs("RazaoSocial"))
				EnderecoMatriz = Trim(Rs("EnderecoMatriz"))
				Fone = Trim(Rs("Fone"))
				CGC = Trim(Rs("CGC"))
				Cidade = Trim(Rs("Cidade"))
				UF = Trim(Rs("UF"))
				Cep = Trim(Rs("Cep"))
				
			Rs.Close
			Set Rs = Nothing

End Function

'FUNÇÃO RESPONSAVEL POR ALTERAR REGISTROS
Function AlterarClientes

	SQL	=	"Update CLIENTES SET Nome= '"&Trim(Replace(Request("Nome"),"'",""))&"' , RazaoSocial = '"&Trim(Replace(Request("RazaoSocial"),"'","''"))&"' , EnderecoMatriz = '"&Trim(Replace(Request("EnderecoMatriz"),"'","''"))&"' , Fone = '"&Trim(Replace(Request("Fone"),"'","''"))&"' , CGC ='"&Trim(Replace(Request("CGC"),"'","''"))&"' , Cidade = '"&Trim(Replace(Request("Cidade"),"'","''"))&"' , UF = '"&Trim(Replace(Request("UF"),"'","''"))&"' , CEP = '"&Trim(Replace(Request("CEP"),"-",""))&"' , id_Convenio = '"&Trim(Replace(Request("id_Convenio"),"'","''"))&"' Where id = "&Cint(Request("id"))
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUNÇÃO RESPONSAVEL POR EXCLUIR REGISTROS
Function ExcluirClientes

	SQL	=	"DELETE FROM CLIENTES Where id ="&Cint(request("id"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Form_Incluir_Clientes"
%>
	<!-- #include virtual="/SmartCare/Clientes/modelos/Form_Incluir_Clientes.htm" -->
<%
	Case "IncluirClientes"
		Call IncluirClientes 'CHAMA A FUNÇÃO QUE IRA INCLUIR UM NOVO REGISTRO
		
	Case "EditarClientes"
		Call EditarClientes 'CHAMA A FUNÇÃO QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
%>
	<!-- #include virtual="/SmartCare/Clientes/modelos/Form_Editar_Clientes.htm" -->
<%		
	Case "AlterarClientes"
		Call AlterarClientes 'CHAMA A FUNÇÃO QUE IRA ALTERAR
		
	Case "ExcluirClientes"
		Call ExcluirClientes 'CHAMA A FUNÇÃO QUE IRA EXCLUIR
		
	Case Else
%>
	<!-- #include virtual="/SmartCare/Clientes/modelos/Form_Visualizar_Clientes.htm" -->
<%

End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

