<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 12/01/2006
' Descrição: Pagina de relatorio de status da solicitacao
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

Function Visualizar

	SQL	=	"SELECT id, Descricao, " &_ 
				"(SELECT COUNT(id_Solicitacao_Status) " &_ 
				"FROM dbo.HomeCare_Solicitacao_Atendimento "&_ 
				"WHERE dbo.HomeCare_Solicitacao_Atendimento.id_Solicitacao_Status = dbo.HomeCare_Solicitacao_Status.id AND (id_Convenio = '"&Session("id_Convenio")&"')) AS Total "&_ 
				"FROM dbo.HomeCare_Solicitacao_Status "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				If Not Rs.Eof Then
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>Status</Td>" & Chr(10)
							Response.Write "<Td>Total:</Td>" & Chr(10)
						Response.Write"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' >"&Rs("Descricao")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Rs("Total")&"</Td>" & Chr(10)
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
					Response.Write "</Table>"

				End if
			Rs.Close
			Set Rs = Nothing

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case Else
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Relatorios/Atendimento_Tipo/modelos/Form_Visualizar.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

