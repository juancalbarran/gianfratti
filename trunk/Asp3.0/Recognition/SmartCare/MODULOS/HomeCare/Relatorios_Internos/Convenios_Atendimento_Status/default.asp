<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Modulos/HomeCare/Relatorios_Internos/Convenios_Atendimento_Status/js/validacoes.js" -->

<%
' Autor: Fabrizio Gianfratti Manes
' Data: 12/01/2006
' Descrição: Pagina de relatorio estatus de atendimento por convênio
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

	SQL	=	"EXEC Relatorio_Atendimento_Status '"&Request("Mes")&"' , '"&Request("Ano")&"' "
			Set rs = server.createobject("adodb.recordset")
			RS.CursorLocation = 3 
			Rs.open SQL, CONN, 3
				If Not Rs.Eof Then
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>Convênio</Td>" & Chr(10)
							Response.Write "<Td >Atendimento:</Td>" & Chr(10)
							Response.Write "<Td >Alta Clínica:</Td>" & Chr(10)
							Response.Write "<Td >Reinternação:</Td>" & Chr(10)
							Response.Write "<Td >Exclusão Contratual:</Td>" & Chr(10)
							Response.Write "<Td >Óbito:</Td>" & Chr(10)
						Response.Write"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Total_Atendimento = Total_Atendimento + Rs("Atendimento")
						Total_Alta_Clinica = Total_Alta_Clinica + Rs("Alta_Clinica")
						Total_Alta_reinternacao_SmartCare = Total_Alta_reinternacao_SmartCare + Rs("Alta_reinternacao_Hospitalar")
						Total_Exclusao_Contratual = Total_Exclusao_Contratual + Rs("Exclusao_Contratual")
						Total_Obito = Total_Obito + Rs("Obito")
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' >"&Rs("Convenio")&"</Td>" & Chr(10)						
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Atendimento")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Alta_Clinica")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Alta_reinternacao_Hospitalar")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Exclusao_Contratual")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Obito")&"</Td>" & Chr(10)
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td class='zebra2'><font color='#FF0000'><b>Total Geral:</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='zebra2' align='center'><font color='#FF0000'><b>"&Total_Atendimento&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='zebra2' align='center'><font color='#FF0000'><b>"&Total_Alta_Clinica&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='zebra2' align='center'><font color='#FF0000'><b>"&Total_Alta_reinternacao_SmartCare&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='zebra2' align='center'><font color='#FF0000'><b>"&Total_Exclusao_Contratual&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='zebra2' align='center'><font color='#FF0000'><b>"&Total_Obito&"</b></Font></Td>" & Chr(10)
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
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Relatorios_Internos/Convenios_Atendimento_Status/modelos/Form_Visualizar.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

