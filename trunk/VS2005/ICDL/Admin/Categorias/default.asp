<!-- #include virtual="/icdl/admin/menu/default.htm" -->
<!-- #include virtual="/icdl/admin/categorias/js/validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Email: fabrizio@gianfratti.con	
' Data: 30/12/2004
' Descrição: Pagina de administração de Categorias
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DECLARAÇÃO DE VARIAVEIS]
Dim id_Categoria, Categoria_Nome, Categoria_Flag_Publicado,Ordem

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR TODAS AS CATEGORIAS CADASTRADAS
Function VisualizarCategorias

	SQL	=	"SELECT * From CATEGORIAS Order by Ordem"
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Tit_Box_Orange'>" & Chr(10)&_
							"<Td>Categorias:</Td>" & Chr(10)&_
							"<Td>Publicação:</Td>" & Chr(10)&_
							"<Td>Ordem:</Td>" & Chr(10)&_
							"<Td>Editar:</Td>" & Chr(10)&_
							"<Td>Excluir:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						If Rs("Categoria_Flag_Publicado") Then Categoria_Flag_Publicado = "Sim" Else Categoria_Flag_Publicado = "Não" End If 'VERIFICA SE A CATEGORIA ESTA PUBLICADO, COMO É UM CAMPO BIT ENTAO RETORNA VERDADEIRO OU FALSO
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Categoria_Nome")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Categoria_Flag_Publicado&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Ordem")&"</Td>" & Chr(10)&_
							"<td class='"&zebrado&"'>"&"<a href='default.asp?action=EditarCategorias&id_Categoria=" &rs("id_Categoria")& "'>Editar</a>"&"</td>" & Chr(10) &_ 	
							"<Td class='"&zebrado&"'>"&"<a href=""javascript:Confirmar(" & rs("id_Categoria") & " , '" & rs("Categoria_Nome") & "' , 'ATENÇÂO !!\nDeseja mesmo excluir a categoria:' , 'default.asp?action=ExcluirCategorias&id_Categoria="&rs("id_categoria")&"' )"" >Excluir</a>"&"</td>" & Chr(10) &_ 
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
			VisualizarCategorias = Content

End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR NOVAS CATEGORIAS
Function IncluirCategorias

	SQL = 	"INSERT INTO CATEGORIAS (Categoria_Nome,Categoria_Flag_Publicado,Ordem) VALUES ( '"&Trim(Replace(Request("Categoria_Nome"),"'","''"))&"' , '"&Cint(Request("Categoria_Flag_Publicado"))&"' , '"&Cint(Request("Ordem"))&"' ) "
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

Function EditarCategorias

	SQL	=	"Select * From CATEGORIAS Where id_Categoria = "&Cint(Request("id_Categoria"))&" "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				id_Categoria = Rs("id_Categoria")
				Categoria_Nome = Rs("Categoria_Nome")
				Categoria_Flag_Publicado = Rs("Categoria_Flag_Publicado")
				Ordem = Rs("Ordem")
				
			Rs.Close
			Set Rs = Nothing

End Function

Function AlterarCategorias

	SQL	=	"Update CATEGORIAS SET Categoria_Nome = '"&Trim(Replace(Request("Categoria_Nome"),"'",""))&"' , Categoria_Flag_Publicado = '"&Cint(Request("Categoria_Flag_Publicado"))&"' , Ordem = '"&Cint(Request("Ordem"))&"' Where id_Categoria = "&Cint(Request("id_Categoria"))
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

Function ExcluirCategorias

	SQL	=	"DELETE FROM CATEGORIAS Where id_Categoria ="&Cint(request("id_Categoria"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Form_Incluir"
%>
	<!-- #include virtual="/icdl/admin/categorias/modelos/form_incluir.htm" -->
<%
	Case "IncluirCategorias"
		Call IncluirCategorias 'CHAMA A FUNÇÃO QUE IRA INCLUIR A NOVA CATEGORIA
		
	Case "EditarCategorias"
		Call EditarCategorias 'CHAMA A FUNÇÃO QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
%>
	<!-- #include virtual="/icdl/admin/categorias/modelos/form_editar.htm" -->
<%		
	Case "AlterarCategorias"
		Call AlterarCategorias 'CHAMA A FUNÇÃO QUE IRA ALTERAR A CATEGORIA
		
	Case "ExcluirCategorias"
		Call ExcluirCategorias 'CHAMA A FUNÇÃO QUE IRA EXCLUIR A CATEGORIA
		
	Case Else
%>
	<!-- #include virtual="/icdl/admin/categorias/modelos/form_Visualizar.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>