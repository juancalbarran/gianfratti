<!-- #include virtual="/icdl/admin/menu/default.htm" -->
<!-- #include virtual="/icdl/admin/Newsletter/js/validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Email: fabrizio@gianfratti.con	
' Data: 18/02/2004
' Descrição: Pagina de administração de Newsletter
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DECLARAÇÃO DE VARIAVEIS]
Dim ID_Newsletter, Nome, Email, FlgAtivo

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR TODAS AS Newsletter CADASTRADAS
Function VisualizarNewsletter

	SQL	=	"SELECT * From Newsletter Order by Nome"
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Tit_Box_Orange'>" & Chr(10)&_
							"<Td>Nome:</Td>" & Chr(10)&_
							"<Td>Email:</Td>" & Chr(10)&_
							"<Td>Ativo:</Td>" & Chr(10)&_
							"<Td>Editar:</Td>" & Chr(10)&_
							"<Td>Excluir:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If Rs("FlgAtivo")  Then FlgAtivo = "Sim" Else FlgAtivo = "Não" End If
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Nome")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Email")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&FlgAtivo&"</Td>" & Chr(10)&_
							"<td class='"&zebrado&"'>"&"<a href='default.asp?action=EditarNewsletter&ID_Newsletter=" &rs("ID_Newsletter")& "'>Editar</a>"&"</td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&"<a href=""javascript:Confirmar(" & rs("ID_Newsletter") & " , '" & rs("Nome") & "' , 'ATENÇÂO !!\nDeseja mesmo excluir:' , 'default.asp?action=ExcluirNewsletter&ID_Newsletter="&rs("ID_Newsletter")&"' )"" >Excluir</a>"&"</td>" & Chr(10)&_
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
			VisualizarNewsletter = Content

End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR NOVAS Newsletter
Function IncluirNewsletter

	SQL = 	"INSERT INTO Newsletter (Nome,Email,FlgAtivo) VALUES ( '"&Trim(Replace(Request("Nome"),"'","''"))&"' , '"&Trim(Replace(Request("Email"),"'","''"))&"' , '"&Trim(Replace(Request("FlgAtivo"),"'","''"))&"'  ) "
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

Function EditarNewsletter

	SQL	=	"Select * From Newsletter Where ID_Newsletter = "&Cint(Request("ID_Newsletter"))&" "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				ID_Newsletter = Rs("ID_Newsletter")
				Nome = Rs("Nome")
				Email = Rs("Email")
				FlgAtivo = Rs("FlgAtivo")
				
			Rs.Close
			Set Rs = Nothing

End Function

Function AlterarNewsletter

	SQL	=	"Update Newsletter SET Nome = '"&Trim(Replace(Request("Nome"),"'",""))&"' , Email = '"&Trim(Replace(Request("Email"),"'",""))&"' , FlgAtivo = '"&Trim(Replace(Request("FlgAtivo"),"'",""))&"'  Where ID_Newsletter = "&Cint(Request("ID_Newsletter"))
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

Function ExcluirNewsletter

	SQL	=	"DELETE FROM Newsletter Where ID_Newsletter ="&Cint(request("ID_Newsletter"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'Funcao que envia email para todos cadastrados
Function EnviarEmail

	SQL	=	"Select * From Newsletter Where FlgAtivo = True "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3

				For x = 1 To Rs.RecordCount
				
					'Chama a função que envia o email. Basta passar os parametros na ordem (de,para,com_copia,copia_oculta,assunto,texto)
					Call enviar_email(Trim(Request("De")),"","",Rs("email"),Trim(Request("Assunto")),Trim(Request("Texto")))

				Rs.MoveNext
				Next
			
			Response.Write "<script>alert('Total de emails enviados "&Rs.RecordCount&"  ')</script>"			
			Rs.Close
			Set Rs = Nothing
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Form_Incluir"
%>
	<!-- #include virtual="/icdl/admin/Newsletter/modelos/form_incluir.htm" -->
<%	
	Case "IncluirNewsletter"
		Call IncluirNewsletter 'CHAMA A FUNÇÃO QUE IRA INCLUIR A NOVA USUARIOS
		
	Case "EditarNewsletter"
		Call EditarNewsletter 'CHAMA A FUNÇÃO QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
%>
	<!-- #include virtual="/icdl/admin/Newsletter/modelos/form_editar.htm" -->
<%		
	Case "AlterarNewsletter"
		Call AlterarNewsletter 'CHAMA A FUNÇÃO QUE IRA ALTERAR A USUARIOS
		
	Case "ExcluirNewsletter"
		Call ExcluirNewsletter 'CHAMA A FUNÇÃO QUE IRA EXCLUIR A USUARIOS

	Case "Form_Enviar" 'CHAMA AO FORMULARIO QUE SERA FEITO PARA ENVIAR O EMAIL
%>
	<!-- #include virtual="/icdl/admin/Newsletter/modelos/form_Enviar.htm" -->
<%	
	Case "EnviarEmail" 'FUNCAO RESPONSAVEL POR ENVIAR O EMAIL		
		Call EnviarEmail
		
	Case Else
%>
	<!-- #include virtual="/icdl/admin/Newsletter/modelos/form_Visualizar.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>