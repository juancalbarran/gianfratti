<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Modulos/HomeCare/Relatorios_Internos/Convenios_Atendimento_Tipo/Js/Validacoes.js" -->

<%
' Autor: Fabrizio Gianfratti Manes
' Data: 12/01/2006
' Descrição: Pagina de relatorio tipo de atendimento por convênio
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

	SQL	=	"EXEC Relatorio_Atendimento_Convenio_Tipo_Monitoramento  '"&Request("Mes")&"' , '"&Request("Ano")&"' "
			Set rs = server.createobject("adodb.recordset")
			RS.CursorLocation = 3 
			Rs.open SQL, CONN, 3
				If Not Rs.Eof Then
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>Convênio</Td>" & Chr(10)
							Response.Write "<Td >Home Care:</Td>" & Chr(10)
							Response.Write "<Td >Monitoramento:</Td>" & Chr(10)
							Response.Write "<Td >Monitotamento e Home Care:</Td>" & Chr(10)
						Response.Write"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Total_Home_Care = Ttoal_Home_Care + Rs("Home_Care")
						Total_Monitoramento = Total_Monitoramento + Rs("Monitoramento")
						Total_Monitoramento_Home_Care = Total_Monitoramento_Home_Care + Rs("Monitoramento_Home_Care")
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' >"&Rs("Convenio")&"</Td>" & Chr(10)						
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Home_Care")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Monitoramento")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Monitoramento_Home_Care")&"</Td>" & Chr(10)
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td class='zebra2'><font color='#FF0000'><b>Total Geral:</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='zebra2' align='center'><font color='#FF0000'><b>"&Total_Home_Care&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='zebra2' align='center'><font color='#FF0000'><b>"&Total_Monitoramento&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='zebra2' align='center'><font color='#FF0000'><b>"&Total_Monitoramento_Home_Care&"</b></Font></Td>" & Chr(10)
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
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Relatorios_Internos/Convenios_Atendimento_Tipo/modelos/Form_Visualizar.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

