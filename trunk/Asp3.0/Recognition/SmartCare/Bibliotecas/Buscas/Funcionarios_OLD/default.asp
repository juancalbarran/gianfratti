<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 07/04/2005
' Descrição: Pagina de busca de Funcionarios
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim id,Nome,id_Cargo,id_Departamento,Contato1,Contato2,Contato3,DataContratacao,DataDemissao,RG,CPF,Endereco,CEP,Banco1,Agencia1,CC1,Banco2,Agencia2,CC2,Email,Ramal,id_OperadoraPager,Pager
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE JÁ EXISTEM
Function VisualizarFuncionarios

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.Funcionarios_Visualizar '"&Request("Nome")&"' , '"&Request("id_Departamento")&"' , '"&Request("id_Cargo")&"' , '"&Request("id_Especializacao")&"' , '"&Request("id_Disponibilidade")&"' , '"&Request("id_Cobertura")&"' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' style='cursor: hand'  onClick=""location.href='default.asp?action=IncluirFuncionarios&id_Funcionario="&rs("id")&"&id_Atendimento="&Request("id_Atendimento")&" '"" >" & Chr(10)&_
						"<Tr class='Tit_Box_Orange'>" & Chr(10)&_
							"<Td>Funcionario:</Td>" & Chr(10)&_
							"<Td>Departamento:</Td>" & Chr(10)&_
							"<Td>Cargo:</Td>" & Chr(10)&_
						"</Tr>"& Chr(10)&_

						"<Tr class='"&zebrado&"'>" & Chr(10)&_
							"<Td><B>"&UCASE(Rs("Nome"))&"</B></Td>" & Chr(10)&_
							"<Td><B>"&UCASE(Rs("Departamento"))&"</B></Td>" & Chr(10)&_
							"<Td><B>"&UCASE(Rs("Cargo"))&"</B></Td>" & Chr(10)&_
						"</Tr>" & Chr(10)&_
							"<Tr class='"&zebrado&"'>" & Chr(10)&_
								"<Td colspan='5'>" & Chr(10)&_
									"<table width='100%' border='0' cellspacing='0' cellpadding='0'>" & Chr(10)&_
										"<tr>" & Chr(10)&_
											"<td valign='top' width='15%'>"&Funcionario_Imagem(Rs("id"),"120","160")&"</td>" & Chr(10)&_
											"<td valign='top' width='25%'> <img src='/SmartCare/images/placa_Especializacoes.gif' >"&Funcionarios_Especializacao(Rs("id"))&"</td>" & Chr(10)&_
											"<td valign='top' width='25%'><img src='/SmartCare/images/placa_Disponibilidades.gif'  >"&Funcionarios_Disponibilidade(Rs("id"))&"</td>" & Chr(10)&_
											"<td valign='top' width='35%'><img src='/SmartCare/images/placa_Cobertura.gif'  >"&Funcionarios_Cobertura(Rs("id"))&"</td>" & Chr(10)&_
										"</tr>" & Chr(10)&_
								    "</table> " & Chr(10)&_
								"</Td>" & Chr(10)&_
							"</Tr>" & Chr(10)&_
							"</Table>"
					Rs.MoveNext
					Next
				Else 'Caso não seja encontrado nenhum registro
					Content = Content & "<Table><tr><td class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
			Rs.Close
			Set Rs = Nothing
			VisualizarFuncionarios = Content

End Function


'FUNÇÃO RESPONSEVEL POR INCLUIR OS FUNCIONARIOS NO ATENDIMENTO
Function IncluirFuncionarios

	'Abre o Select para verificar se o funcionario selecionado ja pertende ao atendimento
	SQL	=	"Select * From AtendimentosXFuncionario Where id_atendimento = '"&Trim(Replace(Request("id_atendimento"),"'","''"))&"' AND id_funcionario = '"&Trim(Replace(Request("id_funcionario"),"'","''"))&"'  "
			Set RS = Server.CreateObject("ADODB.Recordset")
			Rs.open SQL, CONN, 3
			IF Rs.Eof Then	'Caso o funcionario selecionado não pertenca ao atendimento entao é feito a inclusão
				SQL = 	"INSERT INTO AtendimentosXFuncionario (id_atendimento,id_Funcionario) VALUES ( '"&Trim(Replace(Request("id_atendimento"),"'","''"))&"' , '"&Trim(Replace(Request("id_funcionario"),"'","''"))&"'  ) "
						conn.execute(SQL)
						Rs.Close 'Fecha o Recordset aberto
						Set Rs = Nothing 'Destroi o Objeto
						'APOS INCLUIR A PAGINA DE BAIXO É ATUALIZADA
						Response.Write "<Script>window.opener.location.reload();</Script>"
						'APOS A PAGINA DE BAIXO SER ATUALIZADA A PAGINA ATUAL RETORNA PARA A DEFAULT COM O ID DO ATENDIMENTO PARA SER INCLUIDO UM NOVO DIAGBOSTICO
						Response.Write "<script>alert('Incluido Com Sucesso')</script>"
						response.write "<script>location = 'default.asp?id_atendimento="&Request("id_atendimento")&"' </script>"
			Else 'Caso o Funcionario selecionado já pertença ao atendimento entao e apresentado a MSG abaixo
				Rs.Close 'Fecha o Recordset aberto
				Set Rs = Nothing 'Destroi o Objeto
				Response.Write "<script>alert('Operação não efetuada\nO Funcionário selecionado já esta incluído no atendimento')</script>"
				Response.Write "<script>location = 'default.asp?id_atendimento="&Request("id_atendimento")&"' </script>"
				Response.end
			End IF
				
End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "IncluirFuncionarios"
		Call IncluirFuncionarios
		
	Case Else
%>
	<!-- #include virtual="/SmartCare/Bibliotecas/Buscas/Funcionarios/modelos/Form_Visualizar_Funcionarios.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>
