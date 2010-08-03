<!-- #include virtual="/icdl/admin/menu/default.htm" -->
<!-- #include virtual="/icdl/admin/conteudos/js/validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Email: fabrizio@gianfratti.con	
' Data: 04/01/2005
' Descrição: Pagina de administração de Conteudos
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DECLARAÇÃO DE VARIAVEIS]
Dim id_Conteudo,id_Pagina, Conteudo_Titulo, Conteudo, Conteudo_Flag_Publicado, Data_Cadastro , Data_Atualizacao, Ordem

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR TODAS OS CONTEUDOS CADASTRADOS
Function VisualizarConteudos

	SQL	=	"SELECT PAGINAS.Pagina_Titulo, CONTEUDOS.id_Conteudo, CONTEUDOS.Conteudo_Titulo, CONTEUDOS.Conteudo_Flag_Publicado, CONTEUDOS.data_atualizacao, CONTEUDOS.data_cadastro, CONTEUDOS.Ordem " &_ 
			"FROM PAGINAS INNER JOIN CONTEUDOS ON PAGINAS.id_Pagina = CONTEUDOS.id_pagina "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Tit_Box_Orange'>" & Chr(10)&_
							"<Td>Conteudo Titulo:</Td>" & Chr(10)&_
							"<Td>Pagina:</Td>" & Chr(10)&_
							"<Td>Publicação:</Td>" & Chr(10)&_
							"<Td>Ordem:</Td>" & Chr(10)&_
							"<Td>Data Cadastro:</Td>" & Chr(10)&_
							"<Td>Data Atualização:</Td>" & Chr(10)&_
							"<Td>Editar:</Td>" & Chr(10)&_
							"<Td>Excluir:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						If Rs("Conteudo_Flag_Publicado") Then Conteudo_Flag_Publicado = "Sim" Else Conteudo_Flag_Publicado = "Não" End If 'VERIFICA SE A CATEGORIA ESTA PUBLICADO, COMO É UM CAMPO BIT ENTAO RETORNA VERDADEIRO OU FALSO
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Conteudo_Titulo")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Pagina_Titulo")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Conteudo_Flag_Publicado&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Ordem")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&ArrumaDataHora(Rs("Data_Atualizacao"))&"&nbsp;</Td>" & Chr(10)&_
							"<td class='"&zebrado&"'>"&"<a href='default.asp?action=EditarConteudos&id_conteudo=" &rs("id_conteudo")& "'>Editar</a>"&"</td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&"<a href=""javascript:Confirmar(" & rs("id_conteudo") & " , '" & rs("Conteudo_Titulo") & "' , 'ATENÇÂO !!\nDeseja mesmo excluir o conteudo:' , 'default.asp?action=ExcluirConteudos&id_Conteudo="&rs("id_Conteudo")&"' )"" >Excluir</a>"&"</td>" & Chr(10)&_
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
			VisualizarConteudos = Content

End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR NOVOS CONTEUDOS
Function IncluirConteudos

	SQL = 	"INSERT INTO CONTEUDOS (id_Pagina,Conteudo_Titulo,Conteudo,Conteudo_Flag_Publicado,Ordem,Data_Cadastro) VALUES ( '"&Cint(Request("id_Pagina"))&"' , '"&Trim(Replace(Request("Conteudo_Titulo"),"'","''"))&"' , '"&Trim(Replace(Request("Conteudo"),"'","''"))&"' , '"&Cint(Request("Conteudo_Flag_Publicado"))&"' , '"&Cint(Request("Ordem"))&"' , '"&ArrumaDataHora(Now)&"' ) "
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUNÇÃO RESPONSAVEL POR CARREGAR OS REGISTROS PARA FAZER A EDIÇÃO DO CONTEUDO
Function EditarConteudos

	SQL	=	"Select * From CONTEUDOS Where id_Conteudo = "&Cint(Request("id_Conteudo"))&" "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				id_Conteudo = Rs("id_Conteudo")
				id_Pagina = Rs("id_Pagina")
				Conteudo_Titulo = Rs("Conteudo_Titulo")
				Conteudo = Rs("Conteudo")
				Conteudo_Flag_Publicado = Rs("Conteudo_Flag_Publicado")
				Ordem = Rs("Ordem")
				
			Rs.Close
			Set Rs = Nothing

End Function

'FUNÇÃO RESPONSAVEL POR ALTERAR OS REGISTROS DO CONTEUDO
Function AlterarConteudos

	SQL	=	"Update CONTEUDOS SET id_Pagina = '"&Cint(Request("id_Pagina"))&"' , Conteudo_Titulo = '"&Trim(Replace(Request("Conteudo_Titulo"),"'","''"))&"' , Conteudo = '"&Trim(Replace(Request("Conteudo"),"'","''"))&"' , Conteudo_Flag_Publicado = '"&Cint(Request("Conteudo_Flag_Publicado"))&"' , Ordem = '"&Cint(Request("Ordem"))&"' , Data_Atualizacao = '"&ArrumaDataHora(Now)&"'  Where id_Conteudo = "&Cint(Request("id_Conteudo"))
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUNÇÃO RESPOSAVEL POR EXCLUIR OS REGISTROS DO CONTEUDO
Function ExcluirConteudos

	SQL	=	"DELETE FROM CONTEUDOS Where id_Conteudo ="&Cint(request("id_Conteudo"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Form_Incluir"
%>
	<!-- #include virtual="/icdl/admin/conteudos/modelos/Form_Incluir.htm" -->
<%		

	Case "IncluirConteudos"
		Call IncluirConteudos 'CHAMA A FUNÇÃO QUE IRA INCLUIR O NOVO CONTEUDO
		
	Case "EditarConteudos"
		Call EditarConteudos 'CHAMA A FUNÇÃO QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
%>
	<!-- #include virtual="/icdl/admin/Conteudos/modelos/form_editar.htm" -->
<%		
	Case "AlterarConteudos"
		Call AlterarConteudos 'CHAMA A FUNÇÃO QUE IRA ALTERAR O CONTEUDO
		
	Case "ExcluirConteudos"
		Call ExcluirConteudos 'CHAMA A FUNÇÃO QUE IRA EXCLUIR O CONTEUDO
		
	Case Else
%>
	<!-- #include virtual="/icdl/admin/Conteudos/modelos/form_visualizar.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>