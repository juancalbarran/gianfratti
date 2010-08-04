<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Modulos/HomeCare/Relatorios_Internos/Convenios_Solicitacao_Status/Js/Validacoes.js" -->

<%
' Autor: Fabrizio Gianfratti Manes
' Data: 12/01/2006
' Descrição: Pagina de relatorio de solicitações convenio por status
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

	SQL	=	"EXEC Relatorio_Convenio_Solicitacao_Status '"&Request("Mes")&"' , '"&Request("Ano")&"' "
			Set rs = server.createobject("adodb.recordset")
			RS.CursorLocation = 3 
			Rs.open SQL, CONN, 3

				If Not Rs.Eof Then
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>Convênio</Td>" & Chr(10)
							Response.Write "<Td >Analise:</Td>" & Chr(10)
							Response.Write "<Td >Aceito:</Td>" & Chr(10)
							Response.Write "<Td >Não Aceito:</Td>" & Chr(10)
							Response.Write "<Td >Cancelado:</Td>" & Chr(10)
						Response.Write"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Total_Analise = Total_Analise + Rs("Analise")
						Total_Aceito = Total_Aceito + Rs("Aceito")
						Total_Nao_Aceito = Total_Nao_Aceito + Rs("Nao_Aceito")
						Total_Cancelado = Total_Cancelado + Rs("Cancelado")	
	
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' >"&Rs("Convenio")&"</Td>" & Chr(10)						
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Analise")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Aceito")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Nao_Aceito")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Cancelado")&"</Td>" & Chr(10)
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' ><font color='#FF0000'><b>Total Geral:</b></Font></Td>" & Chr(10)						
							Response.Write "<Td class='"&zebrado&"' align = 'center'><font color='#FF0000'><b>"&Total_Analise&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'><font color='#FF0000'><b>"&Total_Aceito&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'><font color='#FF0000'><b>"&Total_Nao_Aceito&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'><font color='#FF0000'><b>"&Total_Cancelado&"</b></Font></Td>" & Chr(10)
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
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Relatorios_Internos/Convenios_Solicitacao_Status/modelos/Form_Visualizar.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

