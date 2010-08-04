<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 03/04/2006
' Descrição: Página de visualização de documentos já capturados
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE JÁ EXISTEM
Function VisualizarDocumentos

	If Trim(Replace(Request("id_Atendimento"),"'","''")) = "" Then
		Response.Write "<br>"
		Response.Write "<fieldset align='center'>" & Chr(10)
		Response.Write "<div align='center'>Insira o número do atendimento para visualizar os documentos capturados</div>"
		Response.end
		Response.Write "</fieldset>" 
	End If
	SQL	=	"SELECT dbo.Documento.id, dbo.Documento.id_Paciente, dbo.Pacientes.nome, dbo.Documento.id_Atendimento, dbo.Documento.Data , dbo.Documento.SessionID " &_ 
			"FROM dbo.Documento INNER JOIN dbo.Pacientes ON dbo.Documento.id_Paciente = dbo.Pacientes.id "
			clausula = " WHERE  "
			if Trim(Request("Id_Atendimento")) <> "" Then
				sql = sql & clausula & " Documento.id_Atendimento = '"&Trim(Replace(Request("id_Atendimento"),"'","''"))&"'  "
				clausula = "and "
			end if
			sql = sql & "Order By Data Desc "

			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						Response.Write "<fieldset>" & Chr(10)
						Response.Write "<legend  align='left' >&nbsp;"&Rs("Nome")&"&nbsp;</legend>" & Chr(10)
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0' >"
							Response.Write "<Tr class='zebra_orange1'>" & Chr(10)
								Response.Write "<Td colspan='7' >"&Rs("Data")&"</Td>" & Chr(10)
							Response.Write "</Tr>" & Chr(10)

						Call MostraImg(Rs("id"),Rs("id_Paciente"),Rs("id_Atendimento"),Rs("SessionID"),Rs("Data"))
						Response.Write "</Table>" & Chr(10)
						Response.Write "</fieldset>"						
					Rs.MoveNext
					Next
				Else 'Caso não seja encontrado nenhum registro
					Response.Write "<Table><tr><td class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
			Rs.Close
			Set Rs = Nothing
			Response.Write VisualizarCargos

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction
				
	Case Else
%>
	<!-- #include virtual="/SmartCare/Doc_Capturados/modelos/Form_Visualizar.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

