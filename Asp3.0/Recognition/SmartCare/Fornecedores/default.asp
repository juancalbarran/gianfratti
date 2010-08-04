<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<!-- #include virtual="/SmartCare/Fornecedores/Js/Validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 04/10/2005
' Descrição: Pagina de administração de Fornecedores
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim action,id,id_Fornecedores_Categoria,Faturamento_Minimo,Fornecedor,Razao_Social,Endereco,Bairro,CEP,Cidade,UF,Telefone,Fax,CNPJ,IE,Contato,Email,Obs
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE JÁ EXISTEM
Function VisualizarCargos

	SQL	=	"SELECT Fornecedores.id, Fornecedores.Fornecedor, Fornecedores.Endereco, Fornecedores.Telefone, Fornecedores_Categoria.Descricao AS Categoria  " &_ 
			"FROM Fornecedores INNER JOIN " &_ 
            "Fornecedores_Categoria ON Fornecedores.id_Fornecedores_Categoria = Fornecedores_Categoria.id " &_ 
			"ORDER BY Fornecedores.Fornecedor "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Titulo_Tabela'>" & Chr(10)&_
							"<Td width='20%'>Categoria:</Td>" & Chr(10)&_
							"<Td width='30%'>Fornecedor:</Td>" & Chr(10)&_
							"<Td width='30%'>Endereço:</Td>" & Chr(10)&_
							"<Td width='10%'>Telefone:</Td>" & Chr(10)&_
							"<Td width='3%'>&nbsp;</Td>" & Chr(10)&_
							"<Td width='3%'>&nbsp;</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						if Cstr(request("PintaTR")) = Cstr(Rs("id")) Then zebrado = "zebra3" End if 'Somente para traser pintado o registroda lista que ele selecionou
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Categoria")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Fornecedor")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Endereco")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Telefone")&"</Td>" & Chr(10)&_
							"<td class='"&zebrado&"' align='center'>"&"<a href='default.asp?action=Form_EditarFornecedor&id=" &rs("id")& "'><img src='/SmartCare/images/ico_editar.gif' border='0' alt='Alterar Fornecedor'   ></a>"&"</td>" & Chr(10) &_ 
							"<Td class='"&zebrado&"' align='center'>"&"<a href=""javascript:Confirmar(" & rs("id") & " , '" & rs("Fornecedor") & "' , 'ATENÇÂO !!\nDeseja mesmo excluir o fornecedor:' , 'default.asp?action=ExcluirFornecedor&id="&rs("id")&"' )"" ><img src='/SmartCare/images/ico_excluir.gif' border='0' alt='Apagar'   ></a></a>"&"</td>" & Chr(10) &_ 
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
			VisualizarCargos = Content

End Function

'FUNÇÃO RESPONSAVEL POR INCLUIR NOVOS REGISTROS
Function IncluirFornecedor

	SQL = 	"INSERT INTO Fornecedores ( id_Fornecedores_Categoria,Faturamento_Minimo,Fornecedor,Razao_Social,Endereco,Bairro,CEP,Cidade,UF,Telefone,Fax,CNPJ,IE,Contato,Email,Obs ) VALUES ( '"&Cint(Request("id_Fornecedores_Categoria"))&"','"&Request("Faturamento_Minimo")&"','"&Request("Fornecedor")&"','"&Request("Razao_Social")&"','"&Request("Endereco")&"','"&Request("Bairro")&"','"&Request("CEP")&"','"&Request("Cidade")&"','"&Request("UF")&"','"&Request("Telefone")&"','"&Request("Fax")&"','"&Request("CNPJ")&"','"&Request("IE")&"','"&Request("Contato")&"','"&Request("Email")&"','"&Request("Obs")&"'  ) "
				conn.execute(SQL)
				response.write "<script>location = 'default.asp?PintaTR="&Conn.execute("SELECT @@IDENTITY")(0).Value&"' </script>"

End Function

'FUNÇÃO RESPONSAVEL POR CARREGAR OS REGISTROS PARA MOSTRAR NO FORMULARIO
Public Function EditarFornecedor

	SQL	=	"SELECT dbo.Fornecedores_Categoria.Descricao AS Categoria, dbo.Fornecedores.* " &_ 
			"FROM dbo.Fornecedores INNER JOIN " &_ 
			"dbo.Fornecedores_Categoria ON dbo.Fornecedores.id_Fornecedores_Categoria = dbo.Fornecedores_Categoria.id " &_ 
			"WHERE dbo.Fornecedores.id = '"&Cint(Request("id"))&"' " &_ 
			"ORDER BY dbo.Fornecedores.Fornecedor "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				id = Rs("id")
				id_Fornecedores_Categoria = Rs("id_Fornecedores_Categoria")
				Faturamento_Minimo = Rs("Faturamento_Minimo")
				Fornecedor = Rs("Fornecedor")
				Razao_Social = Rs("Razao_Social")
				Endereco = Rs("Endereco")
				Bairro = Rs("Bairro")
				CEP = Rs("CEP")
				Cidade = Rs("Cidade")
				UF = Rs("UF")
				Telefone = Rs("Telefone")
				Fax = Rs("Fax")
				CNPJ = Rs("CNPJ")
				IE = Rs("IE")
				Contato = Rs("Contato")
				Email = Rs("Email")
				Obs = Rs("Obs")
				
			Rs.Close
			Set Rs = Nothing

End Function

'FUNÇÃO RESPONSAVEL POR ALTERAR REGISTROS
Function AlterarFornecedor

	SQL	=	"Update Fornecedores SET id_Fornecedores_Categoria = '"&Cint(Request("id_Fornecedores_Categoria"))&"',Faturamento_Minimo='"&Request("Faturamento_Minimo")&"',Fornecedor='"&Request("Fornecedor")&"',Razao_Social='"&Request("Razao_Social")&"',Endereco='"&Request("Endereco")&"',Bairro='"&Request("Bairro")&"',CEP='"&Request("CEP")&"',Cidade='"&Request("Cidade")&"',UF='"&Request("UF")&"',Telefone='"&Request("Telefone")&"',Fax='"&Request("Fax")&"',CNPJ='"&Request("CNPJ")&"',IE='"&Request("IE")&"',Contato='"&Request("Contato")&"',Email='"&Request("Email")&"',Obs='"&Request("Obs")&"' Where id = '"&Request("id")&"' "
				conn.execute(SQL)
				response.write "<script>location = 'default.asp?PintaTR="&Request("id")&"' </script>"

End Function

'FUNÇÃO RESPONSAVEL POR EXCLUIR REGISTROS
Function ExcluirFornecedor

	SQL	=	"DELETE FROM Fornecedores Where id ="&Cint(request("id"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Form_Incluir_Fornecedor"
		action = "default.asp?action=IncluirFornecedor"
%>
	<!-- #include virtual="/SmartCare/Fornecedores/modelos/Form_Incluir_Fornecedor.htm" -->
<%
	Case "IncluirFornecedor"
		Call IncluirFornecedor 'CHAMA A FUNÇÃO QUE IRA INCLUIR UM NOVO REGISTRO
		
	Case "Form_EditarFornecedor"
		Call EditarFornecedor 'CHAMA A FUNÇÃO QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
		action = "default.asp?action=AlterarFornecedor"
%>
	<!-- #include virtual="/SmartCare/Fornecedores/modelos/Form_Incluir_Fornecedor.htm" -->
<%		
	Case "AlterarFornecedor"
		Call AlterarFornecedor 'CHAMA A FUNÇÃO QUE IRA ALTERAR
		
	Case "ExcluirFornecedor"
		Call ExcluirFornecedor 'CHAMA A FUNÇÃO QUE IRA EXCLUIR
		
	Case Else
%>
	<!-- #include virtual="/SmartCare/Fornecedores/modelos/Form_Visualizar_Fornecedores.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

