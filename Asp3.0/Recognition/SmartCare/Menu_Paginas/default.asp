<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<!-- #include virtual="/SmartCare/Menu_Paginas/Js/Validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 22/04/2005
' Descrição: Pagina de administração das Paginas dos menus
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim id,id_Menu_Categorias_Admin,Nome,Link,Parametros,Ordem,FlgAtivo

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE JÁ EXISTEM
Function VisualizarPaginas

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "Select * From Menu_Categorias_Admin Order By Ordem "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
					For x = 1 To Rs.RecordCount
						'If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						If Rs("FlgAtivo") Then FlgAtivo = "Publicado" Else FlgAtivo = "Não Publicado" End If
						Content = Content &_
						"<Tr >" & Chr(10)&_
							"<Td class='zebra1'>"&Ucase(Rs("Categoria"))&"</Td>" & Chr(10)&_
							"<Td class='zebra1'>Ordem: "&Rs("Ordem")&"</Td>" & Chr(10)&_
							"<Td class='zebra1'>"&FlgAtivo&"</Td>" & Chr(10)&_
							"<Td class='zebra1'>&nbsp;</Td>" & Chr(10)&_
							"<Td class='zebra1'>&nbsp;</Td>" & Chr(10)&_
						"</Tr>" 

							Set RS2 = Server.CreateObject("ADODB.Recordset")
							RS2.CursorLocation = 3 
							'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
							SQL = "Select * From Menu_Paginas_Admin Where id_Menu_Categorias_Admin = "&Rs("id")&" Order By Ordem "
									Rs2.open SQL, CONN, 3
										IF not rs2.eof then 'Verifica se existem registros
											For y = 1 To Rs2.RecordCount
												'If Rs2.Eof Then Exit For 'Quando chegar no fim entao exit
												If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
												If Rs2("FlgAtivo") Then FlgAtivo = "Publicado" Else FlgAtivo = "Não Publicado" End If
												Content = Content &_
												"<Tr>" & Chr(10)&_
													"<Td valign='middle' class='zebra2'><p><img src='"&Application("dominio")&"/images/icone_paginas.gif'>"&Rs2("Nome")&"</p></Td>" & Chr(10)&_
													"<Td valign='middle' class='zebra2'>Ordem: "&Rs2("Ordem")&"</Td>" & Chr(10)&_
													"<Td valign='middle' class='zebra2'>"&FlgAtivo&"</Td>" & Chr(10)&_
													"<td class='"&zebrado&"'>"&"<a href='default.asp?action=EditarPaginas&id=" &rs2("id")& "'>Editar</a>"&"</td>" & Chr(10) &_ 
													"<Td class='"&zebrado&"'>"&"<a href=""javascript:Confirmar(" & rs2("id") & " , '" & rs2("Nome") & "' , 'ATENÇÂO !!\nOs funcionarios que tem permissão para esta página perderão a permissão de acesso\n\nDeseja mesmo excluir este modulo do sistema:' , 'default.asp?action=ExcluirPaginas&id="&rs2("id")&"' )"" >Excluir</a>"&"</td>" & Chr(10) &_ 
												"</Tr>" 
											Rs2.MoveNext
											Next
										End if
									Rs2.Close
									Set Rs2 = Nothing

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

'FUNÇÃO RESPONSAVEL POR NÃO DEIXAR GRAVAR A MESMA ORDEM 2X NO BANCO DE DADOS.
'EXEMPLO 2 PAGINAS DISTINTAS TEREM A MESMA ORDEM NA MESMA CATEGORIA
Function Verifica_Ordem(Ordem,id_Menu_Categorias_Admin)

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = 	"Select * From Menu_Paginas_Admin Where Ordem = "&Ordem&" and id_Menu_Categorias_Admin = "&id_Menu_Categorias_Admin&" "
			Rs.open SQL, CONN, 3
				
				If Not Rs.Eof Then		
					Nome = Trim(Rs("Nome"))
					Response.write "<Script>alert('A ordem de nº "&Rs("Ordem")&" selecionada já está em uso para esta categoria  ');</Script>"
					response.write "<script>location = 'javascript:history.go(-1)' </script>"
					Response.end
				End if
				
			Rs.Close
			Set Rs = Nothing


End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR NOVOS REGISTROS
Function IncluirPaginas

	'CHAMA A FUNÇÃO QUE CONTROLA AS ORDENS, PARA NAO GRAVAR ORDENS DO MESMO NUMERO
	Call Verifica_Ordem(Replace(Request("Ordem"),"'",""),Replace(Request("id_Menu_Categorias_Admin"),"'",""))
	
	'EXECUTA A PROCEDURE QUE IRA INCLUIR O REGISTRO
	SQL = 	"INSERT INTO Menu_Paginas_Admin (id_Menu_Categorias_Admin,Nome,Link,Parametros,Ordem,FlgAtivo) VALUES ( '"&Trim(Replace(Request("id_Menu_Categorias_Admin"),"'",""))&"' , '"&Trim(Replace(Request("Nome"),"'",""))&"' , '"&Trim(Replace(Request("Link"),"'",""))&"' , '"&Trim(Replace(Request("Parametros"),"'",""))&"' , '"&Trim(Replace(Request("Ordem"),"'",""))&"' , '"&Trim(Replace(Request("FlgAtivo"),"'",""))&"'   ) "
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'FUNÇÃO RESPONSAVEL POR CARREGAR OS REGISTROS PARA MOSTRAR NO FORMULARIO
Public Function EditarPaginas

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = 	"Select id,id_Menu_Categorias_Admin,Nome,Link,Parametros,Ordem,FlgAtivo " &_
			"From Menu_Paginas_Admin " &_ 
			"Where id = '"&Replace(Cint(Request("id")),"'","")&"'  " 
			Rs.open SQL, CONN, 3
			
				'FAZ O CARREGAMENTO DOS CAMPOS NO BANCO DE DADOS PARA EDIÇÃO DO REGISTRO
				id = Rs("id")
				id_Menu_Categorias_Admin = Trim(Rs("id_Menu_Categorias_Admin"))
				Nome = Trim(Rs("Nome"))
				Link = Trim(Rs("Link"))
				Parametros = Trim(Rs("Parametros"))
				Ordem = Trim(Rs("Ordem"))
				FlgAtivo = ABS(Rs("FlgAtivo"))
				
			Rs.Close
			Set Rs = Nothing

End Function

'FUNÇÃO RESPONSAVEL POR ALTERAR REGISTROS
Function AlterarPaginas

	If Request("Ordem_Antiga") <> Request("Ordem") Then
		'CHAMA A FUNÇÃO QUE CONTROLA AS ORDENS, PARA NAO GRAVAR ORDENS DO MESMO NUMERO
		Call Verifica_Ordem(Replace(Request("Ordem"),"'",""),Replace(Request("id_Menu_Categorias_Admin"),"'",""))
	End if
	
	'EXECUTA A PROCEDURE QUE IRA ALTERAR O REGISTRO
	SQL	=	"Update Menu_Paginas_Admin SET id_Menu_Categorias_Admin = '"&Trim(Replace(Request("id_Menu_Categorias_Admin"),"'",""))&"' , Nome = '"&Trim(Replace(Request("Nome"),"'",""))&"' , Link = '"&Trim(Replace(Request("Link"),"'",""))&"' , Parametros = '"&Trim(Replace(Request("Parametros"),"'",""))&"' , Ordem = '"&Trim(Replace(Request("Ordem"),"'",""))&"' , FlgAtivo = '"&Trim(Replace(Request("FlgAtivo"),"'",""))&"'  Where id = '"&Cint(Request("id"))&"' " 
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'FUNÇÃO RESPONSAVEL POR EXCLUIR REGISTROS
Function ExcluirPaginas

	'EXECUTA A PROCEDURE QUE IRA EXCLUIR O REGISTRO
	SQL = 	"Delete From Menu_Paginas_Admin Where id = '"&Replace(Cint(Request("id")),"'","")&"'  "
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Form_Incluir_Paginas" 
%>
	<!-- #include virtual="/SmartCare/Menu_Paginas/modelos/Form_Incluir_Paginas.htm" -->
<%
	Case "IncluirPaginas"
		Call IncluirPaginas 'CHAMA A FUNÇÃO QUE IRA INCLUIR UM NOVO REGISTRO
		
	Case "EditarPaginas"
		Call EditarPaginas 'CHAMA A FUNÇÃO QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
%>
	<!-- #include virtual="/SmartCare/Menu_Paginas/modelos/Form_Editar_Paginas.htm" -->
<%		
	Case "AlterarPaginas"
		Call AlterarPaginas 'CHAMA A FUNÇÃO QUE IRA ALTERAR
		
	Case "ExcluirPaginas"
		Call ExcluirPaginas 'CHAMA A FUNÇÃO QUE IRA EXCLUIR
		
	Case Else
%>
	<!-- #include virtual="/SmartCare/Menu_Paginas/modelos/Form_Visualizar_Paginas.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

