<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<!-- #include virtual="/SmartCare/Especializacoes/Js/Validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 13/01/2005
' Descrição: Pagina de administração de Especializacoes
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim id,Descricao
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE JÁ EXISTEM
Function VisualizarEspecializacoes

	SQL	=	"SELECT * From ESPECIALIZACOES Order by Descricao"
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Titulo_Tabela'>" & Chr(10)&_
							"<Td>Especializacoes:</Td>" & Chr(10)&_
							"<Td>Editar:</Td>" & Chr(10)&_
							"<Td>Excluir:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Descricao")&"</Td>" & Chr(10)&_
							"<td class='"&zebrado&"'>"&"<a href='default.asp?action=EditarEspecializacoes&id=" &rs("id")& "'>Editar</a>"&"</td>" & Chr(10) &_ 
							"<Td class='"&zebrado&"'>"&"<a href=""javascript:Confirmar(" & rs("id") & " , '" & rs("Descricao") & "' , 'ATENÇÂO !!\nDeseja mesmo excluir o cargo:' , 'default.asp?action=ExcluirEspecializacoes&id="&rs("id")&"' )"" >Excluir</a>"&"</td>" & Chr(10) &_ 
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
			VisualizarEspecializacoes = Content

End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR NOVOS REGISTROS
Function IncluirEspecializacoes

	SQL = 	"INSERT INTO ESPECIALIZACOES (Descricao) VALUES ( '"&Trim(Replace(Request("Descricao"),"'","''"))&"'  ) "
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUNÇÃO RESPONSAVEL POR CARREGAR OS REGISTROS PARA MOSTRAR NO FORMULARIO
Public Function EditarEspecializacoes

	SQL	=	"Select * From ESPECIALIZACOES Where id = "&Cint(Request("id"))&" "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				id = Rs("id")
				Descricao = Trim(Rs("Descricao"))
				
			Rs.Close
			Set Rs = Nothing

End Function

'FUNÇÃO RESPONSAVEL POR ALTERAR REGISTROS
Function AlterarEspecializacoes

	SQL	=	"Update ESPECIALIZACOES SET Descricao= '"&Trim(Replace(Request("Descricao"),"'",""))&"' Where id = "&Cint(Request("id"))
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUNÇÃO RESPONSAVEL POR EXCLUIR REGISTROS
Function ExcluirEspecializacoes

	SQL	=	"DELETE FROM ESPECIALIZACOES Where id ="&Cint(request("id"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "IncluirEspecializacoes"
		Call IncluirEspecializacoes 'CHAMA A FUNÇÃO QUE IRA INCLUIR UM NOVO REGISTRO
		
	Case "EditarEspecializacoes"
		Call EditarEspecializacoes 'CHAMA A FUNÇÃO QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
%>
	<!-- #include virtual="/SmartCare/Especializacoes/modelos/Form_Editar_Especializacoes.htm" -->
<%		
	Case "AlterarEspecializacoes"
		Call AlterarEspecializacoes 'CHAMA A FUNÇÃO QUE IRA ALTERAR
		
	Case "ExcluirEspecializacoes"
		Call ExcluirEspecializacoes 'CHAMA A FUNÇÃO QUE IRA EXCLUIR
		
	Case Else
%>
	<!-- #include virtual="/SmartCare/Especializacoes/modelos/Form_Incluir_Especializacoes.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

