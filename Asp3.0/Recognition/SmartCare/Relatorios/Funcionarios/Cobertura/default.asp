<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 20/05/2005
' Descrição: Página de Relatorio de Area de Cobertura, Funcionarios que estão em determinada area de Cobertura
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'Função responsavel por trazer todas as areas de cobertura e chamar a função que ira trazer os funcionarios que estao naquela area de cobertura
Function Visualizar_Cobertura_Funcionario

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.Cobertura_Visualizar '"&Replace(Request("id_Cobertura"),"'","")&"' , '' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='1'class='borda'  >" & Chr(10) 
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Response.Write "<Tr >" & Chr(10)
							Response.Write "<Td class='Tit_Box_Orange' >"&Rs("Nome")&"</Td>" & Chr(10)
						Response.Write "</Tr>"
						Response.Write "<Tr >" & Chr(10)
							Response.Write "<Td >"&Cobertura_Funcionarios(rs("id"))&"</Td>" & Chr(10) 
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
					Response.Write "</Table>"
				Else 'Caso não seja encontrado nenhum registro
					Response.Write "<Table><tr><td class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
			Rs.Close
			Set Rs = Nothing
			Response.Write Visualizar_Cobertura_Funcionario 

End Function

'Função resposavel por trazer todos os funcionarios de uma determinada area de cobertura
Function Cobertura_Funcionarios(id_Cobertura)

	'[CONEXÃO COM O BANCO DE DADOS]
	set conn=server.createobject("adodb.connection")
	conn.open application("connstring")

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC Cobertura_Funcionarios '"&id_Cobertura&"'  "
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof Then 'Verifica se existem registros			
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0'  cellspacing='0' cellpadding='0' class='borda' >" 
					For x = 1 To Rs.RecordCount
					If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
					Content = Content &_
							"<Tr>" & Chr(10)&_
								"<Td class='"&zebrado&"'>"&Trim(Rs("Funcionario_Nome"))&"</Td>"  & Chr(10)&_
							"</Tr>"
					Rs.MoveNext
					Next
						Content = Content &_
					"</Table>"		
				Else 'Caso não seja encontrado nenhum registro
					Content = Content & "<Table><tr><td class='erro' >Nenhum funcionário encontrado para está cobertura</td></tr></Table>"
				End IF
				Rs.Close
				Set Rs = Nothing
				Cobertura_Funcionarios = Content

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case Else
%>
	<!-- #include virtual="/SmartCare/Relatorios/Funcionarios/Cobertura/Modelos/Form_Visualizar_Cobertura.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

