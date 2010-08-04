<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 12/01/2006
' Descrição: Pagina de relatorio de tipo de atendimento
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

	SQL	=	"SELECT id, Descricao, "&_ 
				"(SELECT COUNT(HomeCare_Atendimento.id) " &_ 
				"FROM HomeCare_Atendimento INNER JOIN HomeCare_Solicitacao_Atendimento ON HomeCare_Atendimento.id_Solicitacao_Atendimento = HomeCare_Solicitacao_Atendimento.id "&_ 
				"WHERE id_Atendimento_Status = HomeCare_Atendimento_Status.id AND id_Atendimento_Status_Condicoes_Alta = 1 AND id_Convenio = '"&Session("id_Convenio")&"') AS Total_Atendimento_Status_Em_Atendimento, "&_ 
				"(SELECT COUNT(HomeCare_Atendimento.id) "&_ 
				"FROM HomeCare_Atendimento INNER JOIN HomeCare_Solicitacao_Atendimento ON HomeCare_Atendimento.id_Solicitacao_Atendimento = HomeCare_Solicitacao_Atendimento.id "&_ 
				"WHERE id_Atendimento_Status = HomeCare_Atendimento_Status.id AND id_Atendimento_Status_Condicoes_Alta <> 1 AND id_Convenio = '"&Session("id_Convenio")&"') AS Total_Atendimento_Status_Anteriores, "&_ 
				"(SELECT COUNT(HomeCare_Atendimento.id) "&_ 
				"FROM HomeCare_Atendimento INNER JOIN HomeCare_Solicitacao_Atendimento ON HomeCare_Atendimento.id_Solicitacao_Atendimento = HomeCare_Solicitacao_Atendimento.id "&_ 
				"WHERE id_Atendimento_Status = HomeCare_Atendimento_Status.id AND id_Convenio = '"&Session("id_Convenio")&"') AS Total " &_ 
			"FROM dbo.HomeCare_Atendimento_Status "&_ 
			"ORDER BY Descricao "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				If Not Rs.Eof Then
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>Monitoramento</Td>" & Chr(10)
							Response.Write "<Td>Em Atendimento</Td>" & Chr(10)
							Response.Write "<Td>Atendimentos anteriores:</Td>" & Chr(10)
							Response.Write "<Td>Total:</Td>" & Chr(10)
						Response.Write"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Total_Atendimento_Status_Em_Atendimento = Total_Atendimento_Status_Em_Atendimento +  Rs("Total_Atendimento_Status_Em_Atendimento") 
						Total_Atendimento_Status_Anteriores = Total_Atendimento_Status_Anteriores + Rs("Total_Atendimento_Status_Anteriores")
						Total = Total + Rs("Total")
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' >"&Rs("Descricao")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Rs("Total_Atendimento_Status_Em_Atendimento")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Rs("Total_Atendimento_Status_Anteriores")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Rs("Total")&"</Td>" & Chr(10)
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td class='zebra2'><font color='#FF0000'><b>Total:</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='zebra2' align='center'><font color='#FF0000'><b>"&Total_Atendimento_Status_Em_Atendimento&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='zebra2' align='center'><font color='#FF0000'><b>"&Total_Atendimento_Status_Anteriores&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='zebra2' align='center'><font color='#FF0000'><b>"&Total&"</b></Font></Td>" & Chr(10)
						Response.Write "</Tr>" 
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

