<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<!-- #include virtual="/SmartCare/Convenios/Js/Validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 13/01/2005
' Descrição: Pagina de administração de Convenios
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim id,Convenio,Tbl_Procedimentos, CH
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE JÁ EXISTEM
Function VisualizarConvenios

	SQL	=	"SELECT * From CONVENIOS Order by Convenio"
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Titulo_Tabela'>" & Chr(10)&_
							"<Td>Convenios:</Td>" & Chr(10)&_
							"<Td>Tbl Procedimentos:</Td>" & Chr(10)&_
							"<Td>CH:</Td>" & Chr(10)&_
							"<Td>Editar:</Td>" & Chr(10)&_
							"<Td>Excluir:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Convenio")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Tbl_Procedimentos")&"&nbsp;</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("CH")&"&nbsp;</Td>" & Chr(10)&_
							"<td class='"&zebrado&"'>"&"<a href='default.asp?action=EditarConvenios&id=" &rs("id")& "'>Editar</a>"&"</td>" & Chr(10) &_ 
							"<Td class='"&zebrado&"'>"&"<a href=""javascript:Confirmar(" & rs("id") & " , '" & rs("Convenio") & "' , 'ATENÇÂO !!\nDeseja mesmo excluir o Convenio:' , 'default.asp?action=ExcluirConvenios&id="&rs("id")&"' )"" >Excluir</a>"&"</td>" & Chr(10) &_ 
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
			VisualizarConvenios = Content

End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR NOVOS REGISTROS
Function IncluirConvenios

	SQL = 	"INSERT INTO CONVENIOS (Convenio,Tbl_Procedimentos,CH) VALUES ( '"&Trim(Replace(Request("Convenio"),"'","''"))&"' , '"&Trim(Replace(Request("Tbl_Procedimentos"),"'","''"))&"' , '"&Trim(Replace(Request("CH"),"'","''"))&"'  ) "
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUNÇÃO RESPONSAVEL POR CARREGAR OS REGISTROS PARA MOSTRAR NO FORMULARIO
Public Function EditarConvenios

	SQL	=	"Select * From CONVENIOS Where id = "&Cint(Request("id"))&" "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				id = Rs("id")
				Convenio = Trim(Rs("Convenio"))
				Tbl_Procedimentos = Rs("Tbl_Procedimentos")
				CH = Rs("CH")
				
			Rs.Close
			Set Rs = Nothing

End Function

'FUNÇÃO RESPONSAVEL POR ALTERAR REGISTROS
Function AlterarConvenios

	SQL	=	"Update CONVENIOS SET Convenio= '"&Trim(Replace(Request("Convenio"),"'",""))&"' Where id = "&Cint(Request("id"))
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUNÇÃO RESPONSAVEL POR EXCLUIR REGISTROS
Function ExcluirConvenios

	SQL	=	"DELETE FROM CONVENIOS Where id ="&Cint(request("id"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "IncluirConvenios"
		Call IncluirConvenios 'CHAMA A FUNÇÃO QUE IRA INCLUIR UM NOVO REGISTRO
		
	Case "EditarConvenios"
		Call EditarConvenios 'CHAMA A FUNÇÃO QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
%>
	<!-- #include virtual="/SmartCare/Convenios/modelos/Form_Editar_Convenios.htm" -->
<%		
	Case "AlterarConvenios"
		Call AlterarConvenios 'CHAMA A FUNÇÃO QUE IRA ALTERAR
		
	Case "ExcluirConvenios"
		Call ExcluirConvenios 'CHAMA A FUNÇÃO QUE IRA EXCLUIR
		
	Case Else
%>
	<!-- #include virtual="/SmartCare/Convenios/modelos/Form_Incluir_Convenios.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

