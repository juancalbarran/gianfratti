<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 07/04/2005
' Descrição: Pagina de Busca de Procedimentos
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim id,Codigo,Descricao,unidade,preco,FlgAtivo
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE JÁ EXISTEM
Function VisualizarProcedimentos

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.Procedimentos_Visualizar '"&Replace(Request("Codigo"),"'","")&"' , '"&Replace(Request("Descricao"),"'","")&"' , '1' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Tit_Box_Orange'>" & Chr(10)&_
							"<Td>Código:</Td>" & Chr(10)&_
							"<Td>Procedimento:</Td>" & Chr(10)&_
							"<Td>Unidade:</Td>" & Chr(10)&_
							"<Td>Preço:</Td>" & Chr(10)&_
							"<Td>Qtd:</Td>" & Chr(10)&_
							"<Td>Ativado:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						If Rs("FlgAtivo") Then FlgAtivo = "Sim" Else FlgAtivo = "Não" End If
						Content = Content &_
						"<Tr style='cursor: hand'  onClick=""location.href='default.asp?action=IncluirProcedimentos&id_Procedimento="&rs("id")&"&id_Atendimento="&Request("id_Atendimento")&"&id_Funcionario_Medico="&Request("id_Funcionario_Medico")&" '""    >" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Codigo")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Descricao")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Unidade")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&FormatCurrency(Rs("Preco"))&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&"<input class='campos' name='qtd' type='text' id='qtd' size='4' maxlength='3'>"&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&FlgAtivo&"</Td>" & Chr(10)&_
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
			VisualizarProcedimentos = Content

End Function

'FUNÇÃO RESPONSEVEL POR INCLUIR OS DIAGNOSTICOS NO ATENDIMENTO
Function IncluirProcedimentos

	SQL = 	"INSERT INTO AtendimentosXProcedimento (id_atendimento,id_Funcionario_Medico,id_procedimento) VALUES ( '"&Trim(Replace(Request("id_atendimento"),"'","''"))&"' , '"&Trim(Replace(Request("id_Funcionario_Medico"),"'","''"))&"' , '"&Trim(Replace(Request("id_procedimento"),"'","''"))&"'  ) "
			conn.execute(SQL)
			'APOS INCLUIR A PAGINA DE BAIXO É ATUALIZADA
			Response.Write "<Script>window.opener.location.reload();</Script>"
			Response.Write "<script>alert('Procedimento Incluido Com Sucesso')</script>"
			'APOS A PAGINA DE BAIXO SER ATUALIZADA A PAGINA ATUAL RETORNA PARA A DEFAULT COM O ID DO ATENDIMENTO PARA SER INCLUIDO UM NOVO DIAGBOSTICO
			Response.write "<script>location = 'default.asp?id_atendimento="&Request("id_atendimento")&"' </script>"
				
End Function


'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "IncluirProcedimentos"
		Call IncluirProcedimentos
		
	Case Else
%>
	<!-- #include virtual="/SmartCare/Bibliotecas/Buscas/Procedimentos/modelos/Form_Visualizar_Procedimentos.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>