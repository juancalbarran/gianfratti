<!-- #include virtual="/icdl/admin/menu/default.htm" -->
<!-- #include virtual="/icdl/admin/Certificados/js/validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Email: fabrizio@gianfratti.con	
' Data: 12/07/2004
' Descrição: Pagina de administração de Certificações ICDL
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DECLARAÇÃO DE VARIAVEIS]
Dim id, Nome, Numero_Certificado, Centro_Certificador, Data_Emissao

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR TODAS AS CERTIFICAÇÕES CADASTRADAS
Function VisualizarCertificados

	SQL	=	"SELECT * From CERTIFICADOS Order by Data_Emissao Desc"
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Tit_Box_Orange'>" & Chr(10)&_
							"<Td>Nome:</Td>" & Chr(10)&_
							"<Td>Nº Certificado:</Td>" & Chr(10)&_
							"<Td>Centro Certificador:</Td>" & Chr(10)&_
							"<Td>Dt. Emissão:</Td>" & Chr(10)&_
							"<Td>Editar:</Td>" & Chr(10)&_
							"<Td>Excluir:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Trim(Rs("Nome"))&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Trim(Rs("Numero_Certificado"))&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Trim(Rs("Centro_Certificador"))&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&ArrumaData(Rs("Data_Emissao"))&"</Td>" & Chr(10)&_
							"<td class='"&zebrado&"'>"&"<a href='default.asp?action=EditarCertificados&id=" &rs("id")& "'>Editar</a>"&"</td>" & Chr(10) &_ 	
							"<Td class='"&zebrado&"'>"&"<a href=""javascript:Confirmar(" & rs("id") & " , '" & rs("Nome") & "' , 'ATENÇÂO !!\nDeseja mesmo excluir:' , 'default.asp?action=ExcluirCertificados&id="&rs("id")&"' )"" >Excluir</a>"&"</td>" & Chr(10) &_ 
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
			VisualizarCertificados = Content

End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR NOVAS CERTIFICAÇÕES
Function IncluirCertificados
 
	SQL = 	"INSERT INTO CERTIFICADOS (Nome,Numero_Certificado,Centro_Certificador,Data_Emissao) VALUES ( '"&Trim(Replace(Request("Nome"),"'","''"))&"' , '"&Trim(Replace(Request("Numero_Certificado"),"'","''"))&"' , '"&Trim(Replace(Request("Centro_Certificador"),"'","''"))&"' , '"&Trim(Request("Data_Emissao"))&"' ) "
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

Function EditarCertificados

	SQL	=	"Select * From CERTIFICADOS Where id = "&Cint(Request("id"))&" "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				id = Rs("id")
				Nome = Rs("Nome")
				Numero_Certificado = Rs("Numero_Certificado")
				Centro_Certificador = Rs("Centro_Certificador")
				Data_Emissao = ArrumaData(Rs("Data_Emissao"))
				
			Rs.Close
			Set Rs = Nothing

End Function

Function AlterarCertificados

	SQL	=	"Update CERTIFICADOS SET Nome = '"&Trim(Replace(Request("Nome"),"'","''"))&"' , Numero_Certificado = '"&Trim(Replace(Request("Numero_Certificado"),"'","''"))&"' , Centro_Certificador = '"&Trim(Replace(Request("Centro_Certificador"),"'","''"))&"' , Data_Emissao = '"&Trim(Request("Data_Emissao"))&"' Where id = "&Cint(Request("id"))
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

Function ExcluirCertificados

	SQL	=	"DELETE FROM CERTIFICADOS Where id ="&Cint(request("id"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Form_Incluir"
%>
	<!-- #include virtual="/icdl/admin/Certificados/modelos/form_incluir.htm" -->
<%
	Case "IncluirCertificados"
		Call IncluirCertificados 'CHAMA A FUNÇÃO QUE IRA INCLUIR A NOVA CERTIFICAÇÃO
		
	Case "EditarCertificados"
		Call EditarCertificados 'CHAMA A FUNÇÃO QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
%>
	<!-- #include virtual="/icdl/admin/Certificados/modelos/form_editar.htm" -->
<%		
	Case "AlterarCertificados"
		Call AlterarCertificados 'CHAMA A FUNÇÃO QUE IRA ALTERAR A CERTIFICAÇÃO
		
	Case "ExcluirCertificados"
		Call ExcluirCertificados 'CHAMA A FUNÇÃO QUE IRA EXCLUIR A CERTIFICAÇÃO
		
	Case Else
%>
	<!-- #include virtual="/icdl/admin/Certificados/modelos/form_Visualizar.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>