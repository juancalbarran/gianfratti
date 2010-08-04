<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<!-- #include virtual="/SmartCare/Cargos/Js/Validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 13/07/2006
' Descrição: Pagina de relatorio de procedimentos
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

	If Request.ServerVariables("REQUEST_METHOD") <> "POST" Then
		Response.Write "<Table width='100%' height='110' ><tr><td align='center' class='texto'>Use pelo menos um dos critérios de filtro para visualizar os dados</td></tr></table>"
		Response.End()
	End if
	SQL	=	"SELECT dbo.Funcionarios.nome, dbo.Cargos.Cargo, dbo.HomeCare_Atendimento_Status_Condicoes_Alta.Descricao AS Status, dbo.Cargos.id AS id_Cargo, " &_ 
			"dbo.HomeCare_Atendimento_Procedimentos.*, dbo.AMB_90.tbcodDescricao " &_ 
			"FROM  dbo.HomeCare_Atendimento_Procedimentos INNER JOIN " &_ 
			"dbo.Funcionarios ON dbo.HomeCare_Atendimento_Procedimentos.Id_Funcionario = dbo.Funcionarios.id INNER JOIN " &_ 
			"dbo.Cargos ON dbo.Funcionarios.id_cargo = dbo.Cargos.id INNER JOIN " &_ 
			"dbo.HomeCare_Atendimento ON dbo.HomeCare_Atendimento_Procedimentos.id_Atendimento = dbo.HomeCare_Atendimento.id INNER JOIN " &_ 
			"dbo.HomeCare_Atendimento_Status_Condicoes_Alta ON  " &_ 
			"dbo.HomeCare_Atendimento.id_Atendimento_Status_Condicoes_Alta = dbo.HomeCare_Atendimento_Status_Condicoes_Alta.id INNER JOIN " &_ 
			"dbo.AMB_90 ON dbo.HomeCare_Atendimento_Procedimentos.Cod_AMB = dbo.AMB_90.tbcodCodTabela "
			clausula = " WHERE  "
				if Trim(Request("id_Atendimento")) <> "" Then
					sql = sql & clausula & " id_Atendimento = '"&Trim(Replace(Request("id_Atendimento"),"'","''"))&"'  "
					clausula = "and "
				end if
				if Trim(Request("Cod_AMB")) <> "" Then
					sql = sql & clausula & " Cod_AMB = '"&Trim(Replace(Request("Cod_AMB"),"'","''"))&"'  "
					clausula = "and "
				end if
				if Trim(Request("Descricao")) <> "" Then
					sql = sql & clausula & " tbCodDescricao Like '%"&Trim(Replace(Request("Descricao"),"'","''"))&"%'  "
					clausula = "and "
				end if
				if Trim(Request("id_Funcionario")) <> "" Then
					sql = sql & clausula & " id_Funcionario ='"&Trim(Replace(Request("id_Funcionario"),"'","''"))&"'  "
					clausula = "and "
				end if
				if Trim(Request("id_Cargo")) <> "" Then
					sql = sql & clausula & " id_Cargo ='"&Trim(Replace(Request("id_Cargo"),"'","''"))&"'  "
					clausula = "and "
				end if
				if Trim(Request("data_inicial")) <> "" Then
					sql = sql & clausula & " CONVERT(CHAR, Data_Procedimento, 103) BETWEEN '"&Request("data_inicial")&"' AND '"&Request("data_final")&"'  "
					clausula = "and "
				end if
				
				sql = sql & "ORDER BY dbo.HomeCare_Atendimento_Procedimentos.id_Atendimento, dbo.HomeCare_Atendimento_Procedimentos.Id,  dbo.HomeCare_Atendimento_Procedimentos.Data "
				
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >"
					Response.Write "<Tr class='Titulo_Tabela'>"
					Response.Write "<Td>Data</Td>"
					Response.Write "<Td>NºAtend.</Td>"
					Response.Write "<Td>Funcionário</Td>"
					Response.Write "<Td>Cargo</Td>"
					Response.Write "<Td>Tabela</Td>"
					Response.Write "<Td>Código</Td>"
					Response.Write "<Td>Procedimento</Td>"
					Response.Write "<Td>CH_Convênio</Td>"
					Response.Write "<Td>CH_AMB</Td>"
					Response.Write "<Td>Ordem</Td>"
					Response.Write "<Td>Valor</Td>"
					Response.Write "</tr>"
					Total = 0
				For x = 1 To Rs.recordCount
					If Rs.Eof then Exit For
					If Rs("Ordem_Auxiliar") <> "" then Ordem = Rs("Ordem_Auxiliar") & "ºAuxiliar" Else Ordem = "Médico" End if
					If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
					Total = Total + Rs("Valor") 
					Response.Write "<Tr>"
					Response.Write "<Td class='"&zebrado&"'>"&ArrumaData(Rs("Data_Procedimento"))&"</Td>"
					Response.Write "<Td class='"&zebrado&"'>"&Rs("id_Atendimento")&"</Td>"
					Response.Write "<Td class='"&zebrado&"'>"&Rs("Nome")&"</Td>"
					Response.Write "<Td class='"&zebrado&"'>"&Rs("Cargo")&"</Td>"
					Response.Write "<Td class='"&zebrado&"'>"&Rs("Tbl_Procedimento")&"</Td>"
					Response.Write "<Td class='"&zebrado&"'>"&Rs("Cod_AMB")&"</Td>"
					Response.Write "<Td class='"&zebrado&"'>"&Rs("TbCodDescricao")&"</Td>"
					Response.Write "<Td class='"&zebrado&"'>"&Rs("CH_Convenio")&"</Td>"
					Response.Write "<Td class='"&zebrado&"'>"&Rs("QTD_CH")&"</Td>"
					Response.Write "<Td class='"&zebrado&"'>"&Ordem&"</Td>"
					Response.Write "<Td class='"&zebrado&"'><b>"& FormatCurrency(Rs("Valor")) &"</b></Td>"
					Response.Write "</tr>"
				
				Rs.MoveNext
				Next
					Response.Write "<Tr align='right' class='zebra_orange1'>"
					Response.Write "<td colspan='11' class='"&zebrado&"' >Total:&nbsp;&nbsp;<b><font color='#FF0000'>"&FormatCurrency(Total)&"</Font></b></td>"
					Response.Write "</tr>"
					Response.Write "</table>"
			
			Rs.Close
			Set Rs = Nothing

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case Else
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Relatorios_Internos/Procedimentos/modelos/Form_Visualizar.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>
