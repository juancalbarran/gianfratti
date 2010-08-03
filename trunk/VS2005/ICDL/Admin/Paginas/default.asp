<!-- #include virtual="/icdl/admin/menu/default.htm" -->
<!-- #include virtual="/icdl/admin/paginas/js/validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Email: fabrizio@gianfratti.con	
' Data: 04/01/2005
' Descrição: Pagina de administração de Páginas
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DECLARAÇÃO DE VARIAVEIS]
Dim id_Pagina,id_Categoria, Pagina_Titulo, Pagina_Destaque_Home, Pagina_Conteudo,Pagina_Flag_Publicado,Ordem

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR TODAS AS PÁGINAS CADASTRADAS
Function VisualizarPaginas

	SQL	=	"SELECT PAGINAS.id_Pagina,PAGINAS.Data_Atualizacao,PAGINAS.Data_Cadastro,PAGINAS.Pagina_Destaque_Home,PAGINAS.Pagina_Titulo, PAGINAS.Pagina_Flag_Publicado, PAGINAS.Ordem , CATEGORIAS.Categoria_Nome " &_ 
			"FROM CATEGORIAS INNER JOIN PAGINAS ON CATEGORIAS.id_Categoria = PAGINAS.id_Categoria " &_ 
			"Order By PAGINAS.Ordem "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Tit_Box_Orange'>" & Chr(10)&_
							"<Td>Página Titulo:</Td>" & Chr(10)&_
							"<Td>Categoria:</Td>" & Chr(10)&_
							"<Td>Publicação:</Td>" & Chr(10)&_
							"<Td>Destaque Home:</Td>" & Chr(10)&_
							"<Td>Ordem:</Td>" & Chr(10)&_
							"<Td>Data Cadastro:</Td>" & Chr(10)&_
							"<Td>Data Atualização:</Td>" & Chr(10)&_
							"<Td>Editar:</Td>" & Chr(10)&_
							"<Td>Excluir:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						If Rs("Pagina_Flag_Publicado") Then Pagina_Flag_Publicado = "Sim" Else Pagina_Flag_Publicado = "Não" End If 'VERIFICA SE A CATEGORIA ESTA PUBLICADO, COMO É UM CAMPO BIT ENTAO RETORNA VERDADEIRO OU FALSO
						If Trim(Rs("Pagina_Destaque_Home")) <> "" Then Pagina_Destaque_Home = "Sim" Else Pagina_Destaque_Home = "Não" End If 'VERIFICA SE A PÁGINA ESTA COMO DESTAQUE NA HOME
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Pagina_Titulo")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Categoria_Nome")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Pagina_Flag_Publicado&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Pagina_Destaque_Home&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Ordem")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&ArrumaDataHora(Rs("Data_Atualizacao"))&"</Td>" & Chr(10)&_
							"<td class='"&zebrado&"'>"&"<a href='default.asp?action=EditarPaginas&id_pagina=" &rs("id_pagina")& "'>Editar</a>"&"</td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&"<a href=""javascript:Confirmar(" & rs("id_pagina") & " , '" & rs("Pagina_Titulo") & "' , 'ATENÇÂO !!\nAo excluir está página todos os conteudos relacionados a ela será excluido automaticamente\nDeseja mesmo excluir a página:' , 'default.asp?action=ExcluirPaginas&id_Pagina="&rs("id_pagina")&"' )"" >Excluir</a>"&"</td>" & Chr(10)&_
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
			VisualizarPaginas = Content

End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR NOVAS CATEGORIAS
Function IncluirPaginas

	SQL = 	"INSERT INTO PAGINAS (id_Categoria,Pagina_Titulo,Pagina_Conteudo,Pagina_Destaque_Home,Pagina_Flag_Publicado,Ordem,data_cadastro) VALUES ( '"&Cint(Request("id_Categoria"))&"' , '"&Trim(Replace(Request("Pagina_Titulo"),"'","''"))&"' , '"&Trim(Replace(Request("Pagina_Conteudo"),"'","''"))&"' , '"&Trim(Replace(Request("Pagina_Destaque_Home"),"'","''"))&"' , '"&Cint(Request("Pagina_Flag_Publicado"))&"' , '"&Cint(Request("Ordem"))&"' , '"&ArrumaDataHora(Now)&"' ) "
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUNÇÃO RESPONSAVEL POR CARREGAR OS REGISTROS PARA FAZER A EDIÇÃO DA PAGINA
Function EditarPaginas

	SQL	=	"Select * From PAGINAS Where id_Pagina = "&Cint(Request("id_Pagina"))&" "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				id_Pagina = Rs("id_Pagina")
				id_categoria = Rs("id_categoria")
				Pagina_Titulo = Rs("Pagina_Titulo")
				Pagina_Destaque_Home = Rs("Pagina_Destaque_Home")
				pagina_Conteudo = Rs("Pagina_Conteudo")
				Pagina_Flag_Publicado = Rs("Pagina_Flag_Publicado")
				Ordem = Rs("Ordem")
				
			Rs.Close
			Set Rs = Nothing

End Function

'FUNÇÃO RESPONSAVEL POR ALTERAR OS REGISTROS DA PAGINA
Function AlterarPaginas

	SQL	=	"Update PAGINAS SET id_categoria = '"&Cint(Request("id_categoria"))&"' , Pagina_Titulo = '"&Trim(Replace(Request("Pagina_Titulo"),"'","''"))&"' , Pagina_Destaque_Home = '"&Trim(Replace(Request("Pagina_Destaque_Home"),"'","''"))&"' , Pagina_Conteudo = '"&Trim(Replace(Request("Pagina_Conteudo"),"'","''"))&"' , Pagina_Flag_Publicado = '"&Cint(Request("Pagina_Flag_Publicado"))&"' , Ordem = '"&Cint(Request("Ordem"))&"' , Data_Atualizacao = '"&ArrumaDataHora(Now)&"' Where id_Pagina = "&Cint(Request("id_pagina"))
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUNÇÃO RESPOSAVEL POR EXCLUIR OS REGISTROS DA PAGINA
Function ExcluirPaginas

	SQL	=	"DELETE FROM PAGINAS Where id_Pagina ="&Cint(request("id_Pagina"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Form_Incluir"
%>
	<!-- #include virtual="/icdl/admin/paginas/modelos/Form_Incluir.htm" -->
<%		

	Case "IncluirPaginas"
		Call IncluirPaginas 'CHAMA A FUNÇÃO QUE IRA INCLUIR A NOVA PÁGINA
		
	Case "EditarPaginas"
		Call EditarPaginas 'CHAMA A FUNÇÃO QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
%>
	<!-- #include virtual="/icdl/admin/paginas/modelos/form_editar.htm" -->
<%		
	Case "AlterarPaginas"
		Call AlterarPaginas 'CHAMA A FUNÇÃO QUE IRA ALTERAR A PÁGINA
		
	Case "ExcluirPaginas"
		Call ExcluirPaginas 'CHAMA A FUNÇÃO QUE IRA EXCLUIR A PÁGINA
		
	Case Else
%>
	<!-- #include virtual="/icdl/admin/paginas/modelos/form_visualizar.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>