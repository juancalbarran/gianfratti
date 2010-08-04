<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" --> 
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 10/07/2005
' Descrição: Pagina de apoio ao JavaScript que usa o metodo XMLHTTP para buscar o paciente e o medico
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'Usado para quando usar o XMLHTTP não retornat caracteres estranhos, principalmente quando tem acentos e outros caracteres estranhas
Response.CharSet="iso-8859-1"

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

Function BuscaAMB

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "Select Top 1 tbcodCodTabela, tbcodDescricao, Qtd_CH, tbcodNroAuxiliar From AMB_90 Where tbcodCodTabela = '"&Request("Cod_AMB")&"' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Response.Write Trim(Rs("tbcodDescricao")) & "#" & Trim(Rs("Qtd_CH")) & "#" & Trim(Rs("tbcodNroAuxiliar"))
				End IF
			Rs.Close
			Set Rs = Nothing

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "BuscaAMB"
		Call BuscaAMB
		
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>
