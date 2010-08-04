<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 12/01/2006
' Descrição: Pagina de relatorio de tipo de atendimentos mensal 
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

	SQL	=	"EXEC Relatorio_Atendimento_Tipo_Mensal '"&Request("Ano")&"' "
			Set rs = server.createobject("adodb.recordset")
			RS.CursorLocation = 3 
			Rs.open SQL, CONN, 3
			
				If Not Rs.Eof Then
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>Status</Td>" & Chr(10)
							Response.Write "<Td >Jan.:</Td>" & Chr(10)
							Response.Write "<Td >Fev.:</Td>" & Chr(10)
							Response.Write "<Td >Mar.:</Td>" & Chr(10)
							Response.Write "<Td >Abr.:</Td>" & Chr(10)
							Response.Write "<Td >Mai.:</Td>" & Chr(10)
							Response.Write "<Td >Jun.:</Td>" & Chr(10)
							Response.Write "<Td >Jul.:</Td>" & Chr(10)
							Response.Write "<Td >Ago.:</Td>" & Chr(10)
							Response.Write "<Td >Set.:</Td>" & Chr(10)
							Response.Write "<Td >Out.:</Td>" & Chr(10)
							Response.Write "<Td >Nov.:</Td>" & Chr(10)
							Response.Write "<Td >Dez.:</Td>" & Chr(10)
						Response.Write"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Total_Janeiro = Total_Janeiro + Rs("Jan")
						Total_Fevereiro = Total_Fevereiro + Rs("Fev")
						Total_Marco = Total_Marco + Rs("Mar")
						Total_Abril = Total_Abril + Rs("Abr")
						Total_Maio = Total_Maio + Rs("Mai")
						Total_Junho = Total_Junho + Rs("Jun")
						Total_Julho = Total_Julho + Rs("Jul")
						Total_Agosto = Total_Agosto + Rs("Ago")
						Total_Setembro = Total_Setembro + Rs("Set")
						Total_Outubro = Total_Outubro + Rs("Out")
						Total_Novembro = Total_Novembro + Rs("Nov")
						Total_Dezembro = Total_Dezembro + Rs("Dez")
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' >"&Rs("Descricao")&"</Td>" & Chr(10)						
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Jan")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Fev")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Mar")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Abr")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Mai")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Jun")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Jul")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Ago")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Set")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Out")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Nov")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'>"&Rs("Dez")&"</Td>" & Chr(10)
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' ><font color='#FF0000'><b>Total Geral:</b></Font></Td>" & Chr(10)						
							Response.Write "<Td class='"&zebrado&"' align = 'center'><font color='#FF0000'><b>"&Total_Janeiro&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'><font color='#FF0000'><b>"&Total_Fevereiro&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'><font color='#FF0000'><b>"&Total_Marco&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'><font color='#FF0000'><b>"&Total_Abril&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'><font color='#FF0000'><b>"&Total_Maio&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'><font color='#FF0000'><b>"&Total_Junho&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'><font color='#FF0000'><b>"&Total_Julho&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'><font color='#FF0000'><b>"&Total_Agosto&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'><font color='#FF0000'><b>"&Total_Setembro&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'><font color='#FF0000'><b>"&Total_Outubro&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'><font color='#FF0000'><b>"&Total_Novembro&"</b></Font></Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align = 'center'><font color='#FF0000'><b>"&Total_Dezembro&"</b></Font></Td>" & Chr(10)
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
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Relatorios_Internos/Atendimento_Tipo_Mensal/modelos/Form_Visualizar.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

