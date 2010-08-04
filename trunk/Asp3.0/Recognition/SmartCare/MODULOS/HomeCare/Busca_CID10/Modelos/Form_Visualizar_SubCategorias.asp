<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'Função que carrega todas as SubCategorias da Categoria passada
Function SubCategorias(Cid10)

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "Select * From Diagnostico Where CID10 LIKE '%"&Cid10&"%'   Order by Cid10 "
			Rs.open SQL, CONN, 3
			IF not rs.eof then 'Verifica se existem registros
				Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda'> "
					Response.Write "<TR class='Tit_Box_Orange'>"
					Response.Write "<TD width='15%'  align='center' >Classificação</TD>"
					Response.Write "<TD width='50%'  align='center' >Código - Descrição</TD>"
					Response.Write "<TD width='35%'  align='center' >Restrição de Sexo</TD>"
					Response.Write "</TR>"
				For Y = 1 To Rs.RecordCount
					If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
					Response.Write "<TR>"
					Response.Write "<TD width='5%' class='"&zebrado&"' align='center' >&nbsp;"&Rs("OPC")& "</TD>"
					Response.Write "<TD width='50%' class='"&zebrado&"' >"&Rs("Descricao")& "</TD>"
					Response.Write "<TD width='45%' class='"&zebrado&"' align='center' >&nbsp;"&Rs("RestrSexo")& "</TD>"
					Response.Write "</TR>"
				Rs.MoveNext
				Next
					Response.Write "</Table>"
				Else
					Response.Write "<Table><tr><td class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
			End if
			Rs.Close
			Set Rs = Nothing

End Function
%>

<%
If Request("CID10") <> "" Then
	SubCategorias(Request("CID10"))
	Else
	Response.Write "<BR><BR><BR><Table><tr><td align='center' class='erro' >Selecione uma categoria ao lado para visualizar as subcategorias das doenças</td></tr></Table>"
End if
%>
<%
'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="borda">
  <tr> 
    <td class="zebra1"  colspan="2">Legenda:</td>
  </tr>
  <tr> 
    <td  class="zebra1 legenda" width="13%">Classifica&ccedil;&atilde;o:</td>
    <td  class="zebra2 legenda" width="87%" valign="top">Indicativo do sistema 
      "cruz" e "asterisco": <br> "+": classificação por etiologia <br> "*": classificação 
      por manifestação<br>
      em branco: não tem dupla classificação</td>
  </tr>
  <tr> 
    <td  class="zebra1 legenda">Descri&ccedil;&atilde;o:</td>
    <td  class="zebra2 legenda" valign="top">Descri&ccedil;&atilde;o da categoria 
      ou subcategoria, sendo que as 5 primeiras posi&ccedil;&otilde;es cont&eacute;m 
      o seu c&oacute;digo, com o ponto, e a 6&ordf; posi&ccedil;&atilde;o est&aacute; 
      em branco.</td>
  </tr>
  <tr>
    <td  class="zebra1 legenda">Restri&ccedil;&atilde;o de Sexo:</td>
    <td  class="zebra2 legenda" valign="top">Indica se a categoria/subcategoria 
      est&aacute; limitada a homens ou mulheres, de acordo com os seguintes c&oacute;digos: 
      <br>
      1: v&aacute;lida apenas para homens; <br>
      3: v&aacute;lida apenas para mulheres; e <br>
      5: v&aacute;lida tanto para homens como para mulheres. <br>
      Estas restri&ccedil;&otilde;es correspondem &agrave;s indicadas no Manual 
      de Instru&ccedil;&atilde;o da CID-10 (Volume II), &agrave;s p&aacute;ginas 
      26 e 27. </td>
  </tr>
</table>
