<!-- #include virtual="/icdl/admin/menu/default.htm" -->
<!-- #include virtual="/icdl/admin/noticias/js/validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Email: fabrizio@gianfratti.con	
' Data: 12/12/2004
' Descrição: Pagina de administração de Noticias
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DECLARAÇÃO DE VARIAVEIS]
Dim id_noticia, noticia_titulo, Noticia_Sinopse, Noticia_Texto, Noticia_Flag_Publicado

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR TODAS AS NOTICIAS CADASTRADAS
Function VisualizarNOTICIAS

	SQL	=	"SELECT * From NOTICIAS Order by Data Desc "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Tit_Box_Orange'>" & Chr(10)&_
							"<Td>Noticias:</Td>" & Chr(10)&_
							"<Td>Publicação:</Td>" & Chr(10)&_
							"<Td>Data Cadastro:</Td>" & Chr(10)&_
							"<Td>Editar:</Td>" & Chr(10)&_
							"<Td>Excluir:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						If Rs("Noticia_Flag_Publicado") Then Noticia_Flag_Publicado = "Sim" Else Noticia_Flag_Publicado = "Não" End If 'VERIFICA SE A NOTICIA ESTA PUBLICADO, COMO É UM CAMPO BIT ENTAO RETORNA VERDADEIRO OU FALSO
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("noticia_titulo")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Noticia_Flag_Publicado&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&ArrumaDataHora(Rs("Data"))&"</Td>" & Chr(10)&_
							"<td class='"&zebrado&"'>"&"<a href='default.asp?action=EditarNoticias&id_noticia=" &rs("id_noticia")& "'>Editar</a>"&"</td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&"<a href=""javascript:Confirmar(" & rs("id_noticia") & " , '" & rs("noticia_titulo") & "' , 'ATENÇÂO !!\nDeseja mesmo excluir a noticia:' , 'default.asp?action=ExcluirNoticias&id_noticia="&rs("id_noticia")&"' )"" >Excluir</a>"&"</td>" & Chr(10)&_
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
			VisualizarNOTICIAS = Content

End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR NOVAS NOTICIAS
Function IncluirNoticias

	SQL = 	"INSERT INTO NOTICIAS (noticia_titulo,noticia_sinopse,noticia_texto,Noticia_Flag_Publicado,data) VALUES ( '"&Trim(Replace(Request("noticia_titulo"),"'","''"))&"' , '"&Trim(Replace(Request("noticia_sinopse"),"'","''"))&"' , '"&Trim(Replace(Request("noticia_texto"),"'","''"))&"' , '"&Cint(Request("Noticia_Flag_Publicado"))&"', '"&ArrumaDataHora(Now)&"' ) "
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

Function EditarNoticias

	SQL	=	"Select * From NOTICIAS Where id_noticia = "&Cint(Request("id_noticia"))&" "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				id_noticia = Rs("id_noticia")
				noticia_titulo = Rs("noticia_titulo")
				noticia_sinopse = Rs("noticia_sinopse")
				noticia_texto = Rs("noticia_texto")
				Noticia_Flag_Publicado = Rs("Noticia_Flag_Publicado")
				
			Rs.Close
			Set Rs = Nothing

End Function

Function AlterarNoticias

	SQL	=	"Update NOTICIAS SET noticia_titulo = '"&Trim(Replace(Request("noticia_titulo"),"'",""))&"' , noticia_sinopse = '"&Trim(Replace(Request("noticia_sinopse"),"'",""))&"' , noticia_texto = '"&Trim(Replace(Request("noticia_texto"),"'",""))&"' , Noticia_Flag_Publicado = '"&Cint(Request("Noticia_Flag_Publicado"))&"' Where id_noticia = "&Cint(Request("id_noticia"))
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

Function ExcluirNoticias

	SQL	=	"DELETE FROM NOTICIAS Where id_noticia ="&Cint(request("id_noticia"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "IncluirNoticias"
		Call IncluirNoticias 'CHAMA A FUNÇÃO QUE IRA INCLUIR A NOVA NOTICIA

	Case "Form_Incluir"
%>
	<!-- #include virtual="/icdl/admin/noticias/modelos/form_incluir.htm" -->
<%		
		
	Case "EditarNoticias"
		Call EditarNoticias 'CHAMA A FUNÇÃO QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
%>
	<!-- #include virtual="/icdl/admin/noticias/modelos/form_editar.htm" -->
<%		
	Case "AlterarNoticias"
		Call AlterarNoticias 'CHAMA A FUNÇÃO QUE IRA ALTERAR A NOTICIA
		
	Case "ExcluirNoticias"
		Call ExcluirNoticias 'CHAMA A FUNÇÃO QUE IRA EXCLUIR A NOTICIA
		
	Case Else
%>
	<!-- #include virtual="/icdl/admin/noticias/modelos/form_visualizar.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>