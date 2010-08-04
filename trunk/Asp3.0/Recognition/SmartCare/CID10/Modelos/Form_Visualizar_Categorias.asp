<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 04/05/2005
' Descrição: Pagina de administração de Diagnosticos - CID10 - Pagina que monta as categorias do CID10
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR TODAS AS CATEGORIAS DO CID10
Function VisualizarCategorias

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "Exec Diagnostico_Visualizar '"&Request("Busca")&"' , 'S' , '' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda'> "
					For X  = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Response.Write "<TR>"
						Response.Write "<TD class='"&zebrado&"' >"&"<a href='Form_Visualizar_SubCategorias.asp?CID10="&Rs("CID10")&"' target='SubCategoria' >"&Rs("Descricao")&"</a>" & "</TD>"
						Response.Write "</TR>"
					Rs.MoveNext
					Next
						Response.Write "</Table>"
					Rs.Close
					Set Rs = Nothing
				End IF

End Function

%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="form" method="post" action="">
  <tr class="zebra1">
      <td> 
        <input name="Busca" type="text" class="campos" id="Busca" size="35" maxlength="50">
        <input class="botoes" type="submit" name="Submit" value=" Buscar">
      </td>
  </tr>
  </form>
</table>
<%=VisualizarCategorias%>

<%
'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>