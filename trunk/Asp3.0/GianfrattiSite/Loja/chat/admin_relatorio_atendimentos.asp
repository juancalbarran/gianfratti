<%
'******************************************************************
'  Suporte Online SuperAsp 1.0 - SuperASP.com.br - Ano 2003
'  Autor: Fabiano Dias - fdmail@ibest.com.br
'******************************************************************
'
'       DIREITOS AUTORIAIS DO SUPORTE ONLINE SUPERASP
'
'  Você não pode revender este script, alugar, disponibilizar  para
'  download ou fazer qualquer outro tipo  de  redistribuição  sem a
'  nossa autorização.
'
'  Este código de programação usa uma técnica de criptografia,  que
'  identifica sua autoria, ou seja, alterar este código ou revender
'  o mesmo sem contatar o autor significa estar infrigindo todas as
'  leis de direitos autorais e intelectuais,  e como tal passivo de
'  todas as aplicações na forma da lei.
'
'******************************************************************
'Número total de registros a serem exibidos por página
Const RegPorPag = 10

'Número de páginas a ser exibido no índice de paginação
VarPagMax = 10

If Session("SOS_admin") = "" And Session("SOS_ipadmin") <> Request.ServerVariables("REMOTE_ADDR") Then
  Response.Write "<script language='javascript'>window.open('admin_login.asp','_top')</script>"
Else

Response.Expires=-1000
Response.Buffer = False
%>

<html>
<head>
<title><%=Application("SOS_titulo")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="copyright" content="SuperAsp">
<meta name="keywords" content="sos, suporte online, suporteonline, superasp, suporte, online">
<meta name="robots" content="ALL">
<SCRIPT language="JavaScript">
<!--
function abre_popup(width, height, nome) {
  var top; var left;
  top = ( (screen.height/2) - (height/2) )
  left = ( (screen.width/2) - (width/2) )
  window.open('',nome,'width='+width+',height='+height+',scrollbars=no,toolbar=no,location=no,status=no,menubar=no,resizable=no,left='+left+',top='+top);
}
function definir_data(dia,mes,ano) {
  form_pesquisar.dia.value=dia;
  form_pesquisar.mes.value=mes;
  form_pesquisar.ano.value=ano;
  form_pesquisar.submit();
}
function up_dia() {
  if(form_pesquisar.dia.value==''){
    form_pesquisar.dia.value=1;
  }
  else {
    if(isNaN(form_pesquisar.dia.value)){
	  form_pesquisar.dia.value=1;
	}
	else {
	  if (parseInt(form_pesquisar.dia.value) < 31){
	    form_pesquisar.dia.value=parseFloat(form_pesquisar.dia.value)+1;
	  }
	}
  }
}
function down_dia() {
  if(form_pesquisar.dia.value==''){
    form_pesquisar.dia.value=1;
  }
  else {
    if(isNaN(form_pesquisar.dia.value)){
	  form_pesquisar.dia.value=1;
	}
	else {
	  if (parseInt(form_pesquisar.dia.value) > 1){
	    form_pesquisar.dia.value=parseFloat(form_pesquisar.dia.value)-1;
	  }
	}
  }
}
function up_mes() {
  if(form_pesquisar.mes.value==''){
    form_pesquisar.mes.value=1;
  }
  else {
    if(isNaN(form_pesquisar.mes.value)){
	  form_pesquisar.mes.value=1;
	}
	else {
	  if (parseInt(form_pesquisar.mes.value) < 12){
	    form_pesquisar.mes.value=parseFloat(form_pesquisar.mes.value)+1;
	  }
	}
  }
}
function down_mes() {
  if(form_pesquisar.mes.value==''){
    form_pesquisar.mes.value=1;
  }
  else {
    if(isNaN(form_pesquisar.mes.value)){
	  form_pesquisar.mes.value=1;
	}
	else {
	  if (parseInt(form_pesquisar.mes.value) > 1){
	    form_pesquisar.mes.value=parseFloat(form_pesquisar.mes.value)-1;
	  }
	}
  }
}

function up_ano() {
  if(form_pesquisar.ano.value==''){
    form_pesquisar.ano.value=2000;
  }
  else {
    if(isNaN(form_pesquisar.ano.value)){
	  form_pesquisar.ano.value=1;
	}
	else {
	  form_pesquisar.ano.value=parseFloat(form_pesquisar.ano.value)+1;
	}
  }
}
function down_ano() {
  if(form_pesquisar.ano.value==''){
    form_pesquisar.ano.value=2000;
  }
  else {
    if(isNaN(form_pesquisar.ano.value)){
	  form_pesquisar.ano.value=1;
	}
	else {
	  if (parseInt(form_pesquisar.ano.value) > 2000){
	    form_pesquisar.ano.value=parseFloat(form_pesquisar.ano.value)-1;
	  }
	}
  }
}
//-->
</SCRIPT>
<style type="text/css">
<!--
.texto{
font-family: Tahoma, Arial;
font-size: 11px;
}
-->
</style>
</head>
<body class="texto" bgcolor="white" leftmargin="20" topmargin="20" bottommargin="20" rightmargin="20">

<%
Dim Conexao, objRS_atendimentos, ComandoSQL

If Request.QueryString("PagAtual") = "" Then
  PagAtual = 1
  NumPagMax = VarPagMax
Else
  NumPagMax = CInt(Request.QueryString("NumPagMax"))
  PagAtual = CInt(Request.QueryString("PagAtual"))
  Select Case Request.QueryString("Submit")
    Case "Anterior" : PagAtual = PagAtual - 1
    Case "Proxima" : PagAtual = PagAtual + 1
    Case "Menos" : NumPagMax = NumPagMax - VarPagMax
    Case "Mais" : NumPagMax = NumPagMax + VarPagMax
    Case Else : PagAtual = CInt(Request.QueryString("Submit"))
  End Select
  If NumPagMax < PagAtual then
    NumPagMax = NumPagMax + VarPagMax
  End If
  If NumPagMax - (VarPagMax - 1) > PagAtual then
    NumPagMax = NumPagMax - VarPagMax
  End If
End If

Set Conexao = Server.CreateObject("ADODB.Connection")
Conexao.Open Application("SOS_conexao")

If Request("PagAtual") <> "" Then
  ComandoSQL = Session("ComandoSQL")
Else
  ComandoSQL = " SELECT * FROM historico WHERE 1=1"
  If Request("id") <> "" Then
    ComandoSQL = ComandoSQL & "AND atendente = " & Request("id")
  End If
  If Request("usuario") <> "" Then
    ComandoSQL = ComandoSQL & "AND usuario like '%" & Request("usuario") & "%'"
  End If
  If Request("#id") <> "" Then
    ComandoSQL = ComandoSQL & "AND id = " & Request("#id")
  End If
  If Request("assunto") <> "" Then
    ComandoSQL = ComandoSQL & "AND assunto like '%" & Request("assunto") & "%'"
  End If
  If Request("dia") <> "" Then ComandoSQL = ComandoSQL & " And Day(entrada) like '" & Request("dia") & "'"
  If Request("mes") <> "" Then ComandoSQL = ComandoSQL & " And Month(entrada) like '" & Request("mes") & "'"
  If Request("mes") <> "" Then ComandoSQL = ComandoSQL & " And Year(entrada) like '" & Request("ano") & "'"
  If Request("nota") <> "" Then
    Select Case Request("nota")
    Case 0 : ComandoSQL = ComandoSQL & "AND nota = 0"
    Case 1 : ComandoSQL = ComandoSQL & "AND nota = 1"
    Case 2 : ComandoSQL = ComandoSQL & "AND nota = 2"
    Case 3 : ComandoSQL = ComandoSQL & "AND nota = 3"
    Case 4 : ComandoSQL = ComandoSQL & "AND nota = 4"
    End Select
  End If
  ComandoSQL = ComandoSQL & " ORDER BY id DESC"
  Session("ComandoSQL") = ComandoSQL
End If
Set objRS_atendimentos = Server.CreateObject("ADODB.Recordset")
objRS_atendimentos.CursorLocation = 3
objRS_atendimentos.CursorType = 2
objRS_atendimentos.LockType = 1
objRS_atendimentos.CacheSize = RegPorPag
objRS_atendimentos.Open ComandoSQL, Conexao,,, &H0001
objRS_atendimentos.PageSize = RegPorPag

  Response.Write "<table border=0 cellpadding=0 cellspancing=0 class=texto>"
  Response.Write "  <form name='form_pesquisar' method='post' action='" & Request.ServerVariables("SCRIPT_NAME") & "'>"
  Response.Write "  <tr>"
  Response.Write "    <td>"

  Response.Write "<table border=0 cellpadding=0 cellspancing=0 class=texto>"
  Response.Write "  <tr>"
  Response.Write "    <td><font color=gray><b>#ID</b></font></td>"
  Response.Write "    <td><font color=gray><b>Atendente</b></font></td>"
  Response.Write "    <td><font color=gray><b>Usuário</b></font></td>"
  Response.Write "    <td><font color=gray><b>Assunto</b></font></td>"
  Response.Write "    <td><font color=gray><b>Dia</b></font></td>"
  Response.Write "    <td><font color=gray><b>Mês</b></font></td>"
  Response.Write "    <td><font color=gray><b>Ano</b>&nbsp;( <span style='cursor:hand' onclick=""definir_data('" & Day(Date) & "','" & Month(Date) & "','" & Year(Date) & "')"">hoje</span>&nbsp;,&nbsp;<span style='cursor:hand' onclick=""definir_data('','" & Month(Date) & "','" & Year(Date) & "')"">mês atual</span> )</font></td>"
  Response.Write "  </tr>"
  Response.Write "  <tr>"
  Response.Write "    <td><input type='text' name='#id' value='" & Request("#id") & "' style='width:25' size=2 class=texto></td>"

  Response.Write "    <td>"
  Response.Write "      <select name='id' class='texto' style='width:100'>"
  Response.Write "      <option value=''></option>"

  ComandoSQL = " SELECT * FROM atendentes"
  Set objRS_atendente = Server.CreateObject("ADODB.Recordset")
  objRS_atendente.CursorLocation = 2
  objRS_atendente.CursorType = 0
  objRS_atendente.LockType = 1
  objRS_atendente.Open ComandoSQL, Conexao,,, &H0001
  If Not objRS_atendente.EOF Then
    While Not objRS_atendente.EOF
	  Response.Write "      <option value='" & objRS_atendente("id") & "'"
	  If Request("id") <> "" Then
	    If objRS_atendente("id") = Int(Request("id")) Then Response.Write " selected"
	  End If
	  Response.Write ">" & objRS_atendente("atendente") & "</option>"
	  objRS_atendente.MoveNext
	Wend
  End If
  objRS_atendente.Close
  Set objRS_atendente = Nothing

  Response.Write "      </select>"
  Response.Write "    </td>"

  Response.Write "    <td><input type='text' name='usuario' value='" & Request("usuario") & "' style='width:100' size=2 class=texto></td>"
  Response.Write "    <td><input type='text' name='assunto' value='" & Request("assunto") & "' style='width:100' size=2 class=texto></td>"
  Response.Write "    <td><input type='text' name='dia' value='" & Request("dia") & "' style='width:22' size=2 class=texto>&nbsp;<img src='imagens/updown.gif' width='12' height='17' border=0 align='absmiddle' usemap='#map_dia'></td>"
  Response.Write "    <td><input type='text' name='mes' value='" & Request("mes") & "' style='width:22' size=2 class=texto>&nbsp;<img src='imagens/updown.gif' width='12' height='17' border=0 align='absmiddle' usemap='#map_mes'></td>"
  Response.Write "    <td nowrap><input type='text' name='ano' value='" & Request("ano") & "' style='width:35' size=2 class=texto>&nbsp;<img src='imagens/updown.gif' width='12' height='17' border=0 align='absmiddle' usemap='#map_ano'>&nbsp;&nbsp;<input type='submit' value='Pesquisar' class='texto'></td>"
  Response.Write "  </tr>"
  Response.Write "</table>"

  Response.Write "    </td>"
  Response.Write "  </tr>"
  Response.Write "  </form>"
  Response.Write "</table>"

  Response.Write "<map name='map_dia'>"
  Response.Write "<area shape='rect' coords='0,0,12,8' href='#' onclick='up_dia()'>"
  Response.Write "<area shape='rect' coords='0,9,12,17' href='#' onclick='down_dia()'>"
  Response.Write "</map>"

  Response.Write "<map name='map_mes'>"
  Response.Write "<area shape='rect' coords='0,0,12,8' href='#' onclick='up_mes()'>"
  Response.Write "<area shape='rect' coords='0,9,12,17' href='#' onclick='down_mes()'>"
  Response.Write "</map>"

  Response.Write "<map name='map_ano'>"
  Response.Write "<area shape='rect' coords='0,0,12,8' href='#' onclick='up_ano()'>"
  Response.Write "<area shape='rect' coords='0,9,12,17' href='#' onclick='down_ano()'>"
  Response.Write "</map>"

If Not objRS_atendimentos.EOF Then
  objRS_atendimentos.AbsolutePage = PagAtual
  TotPag = objRS_atendimentos.PageCount

  Response.Write "<table width='100%' border='1' cellspacing='0' cellpadding='2' class='texto' bordercolor=silver>"
  Response.Write "  <tr style='font-weight:bold; color:white; background-color: gray'>"
  Response.Write "    <td valign=top nowrap>#ID</td>"
  Response.Write "    <td valign=top nowrap>Atendente</td>"
  Response.Write "    <td valign=top nowrap>Usuário</td>"
  Response.Write "    <td valign=top nowrap>Assunto</td>"
  Response.Write "    <td valign=top nowrap>IP</td>"
  Response.Write "    <td valign=top nowrap>Entrada</td>"
  Response.Write "    <td valign=top nowrap>Saída</td>"
  Response.Write "    <td valign=top nowrap>Avaliação</td>"
  Response.Write "    <td valign=top nowrap>Obs</td>"
  Response.Write "    <td>Diálogo</td>"
  Response.Write "  </tr>"

  For Cont = 1 to objRS_atendimentos.PageSize
    Response.Write "  <tr bgcolor='whitesmoke' onMouseOver=""this.style.backgroundColor='gainsboro';"" onMouseOut=""this.style.backgroundColor='';"">"
    Response.Write "    <td width=25 align=center>" & objRS_atendimentos("id") & "&nbsp;</td>"
    Response.Write "    <td width=25 align=center><font color='#3E6497'><b>" 
    Set objRS_atendente = Server.CreateObject("ADODB.Recordset")
    objRS_atendente.CursorLocation = 2
    objRS_atendente.CursorType = 0
    objRS_atendente.LockType = 2
    strQ_atendente = "SELECT atendente FROM atendentes WHERE id =" & objRS_atendimentos("atendente")
    objRS_atendente.Open strQ_atendente, Conexao, , , &H0001
    Response.Write objRS_atendente.Fields.Item("atendente").Value
    objRS_atendente.Close
    Set objRS_atendente = Nothing
    Set strQ_atendente = Nothing
	Response.Write "    </b></font></td>"
    Response.Write "    <td width='30%' nowrap><b>" & objRS_atendimentos("usuario") & "</b><br>" & objRS_atendimentos("email") & "&nbsp;</td>"
    Response.Write "    <td width='30%'>" & objRS_atendimentos("assunto") & "&nbsp;</td>"
    Response.Write "    <td>" & objRS_atendimentos("ip") & "&nbsp;</td>"
    Response.Write "    <td>" & objRS_atendimentos("entrada") & "&nbsp;</td>"
    Response.Write "    <td>" & objRS_atendimentos("saida") & "&nbsp;</td>"
    Select Case objRS_atendimentos("nota")
    Case 0 : Response.Write "    <td>Não avaliou</td>"
    Case 1 : Response.Write "    <td>Péssimo atendimento</td>"
    Case 2 : Response.Write "    <td>Atendimento regular</td>"
    Case 3 : Response.Write "    <td>Bom atendimento</td>"
    Case 4 : Response.Write "    <td>Ótimo atendimento</td>"
    End Select
    Response.Write "    <td>" & objRS_atendimentos("obs_nota") & "&nbsp;</td>"
    Response.Write "    <td><a href='admin_exibe_conversacao.asp?id=" & objRS_atendimentos("id") & "' onclick=""abre_popup(600, 300, 'popup')"" target='popup'>Abrir</a></td>"
    Response.Write "  </tr>"
	objRS_atendimentos.MoveNext
    If objRS_atendimentos.Eof then Exit For
  Next
  Response.Write "</table>"
  LinksNavegacao()
Else
  Response.Write "&nbsp;&nbsp;Nenhum atendimento foi encontrado"
End If

Conexao.Close
Set ComandoSQL = Nothing
Set objRS_atendimentos = Nothing
Set Conexao = Nothing
%>

</body>
</html>

<%
Sub LinksNavegacao()
'O código a seguir insere uma tabela com todos os links de navegação das páginas
Response.Write "<TABLE border=0 cellPadding=2 cellSpacing=0 class=texto>"
Response.Write "<TR><TD vAlign=top noWrap colspan=5>"
Response.Write "Página " & PagAtual & " de " & TotPag
Response.Write "</TD></TR><TR><TD width=33% align=right vAlign=top noWrap>"
If PagAtual > 1 Then
  Response.Write "<A href=""" & Request.ServerVariables("SCRIPT_NAME") & "?PagAtual=" &  PagAtual &"&VarPagMax=" & VarPagMax & "&NumPagMax=" & NumPagMax & "&Submit=Anterior&string_busca=" & Server.URLEncode(Request("string_busca")) & "&campo_busca=" & Server.URLEncode(Request("campo_busca"))  & """ style='text-decoration=none'><font color=blue>&lt; Anterior</font></A>"
End If
Response.Write "</TD><TD width=33% align=middle vAlign=top noWrap>"
If NumPagMax - VarPagMax <> 0 then
  Response.Write "&nbsp;<A href=""" & Request.ServerVariables("SCRIPT_NAME") & "?PagAtual=" & NumPagMax - VarPagMax & "&VarPagMax=" & VarPagMax & "&NumPagMax=" & NumPagMax - VarPagMax & "&Submit=Menos&string_busca=" & Server.URLEncode(Request("string_busca")) & "&campo_busca=" & Server.URLEncode(Request("campo_busca")) & """ style='text-decoration=none'><font color=blue>&lt;&lt;<font></A>&nbsp;&nbsp;"
End If
for i = NumPagMax - (VarPagMax - 1) to NumPagMax
  If i <= TotPag then
    If i <> CInt(PagAtual) then
      Response.Write "&nbsp;<A href=""" & Request.ServerVariables("SCRIPT_NAME") & "?PagAtual=" & PagAtual & "&VarPagMax=" & VarPagMax & "&NumPagMax=" & NumPagMax & "&Submit=" & i & "&string_busca=" & Server.URLEncode(Request("string_busca")) & "&campo_busca=" & Server.URLEncode(Request("campo_busca")) & """ style='text-decoration=none'><font color=blue>" & i & "</font></A>&nbsp;"
    Else
      If PagAtual <> TotPag Then
        Response.Write "&nbsp;" & i & "&nbsp;"
      End If
    End If
  End If
Next
If NumPagMax  < TotPag then
  Response.Write "&nbsp;&nbsp;<A href=""" & Request.ServerVariables("SCRIPT_NAME") & "?PagAtual=" & NumPagMax + 1 & "&VarPagMax=" & VarPagMax & "&NumPagMax=" & NumPagMax + VarPagMax & "&Submit=Mais&string_busca=" & Server.URLEncode(Request("string_busca")) & "&campo_busca=" & Server.URLEncode(Request("campo_busca")) & """ style='text-decoration=none'><font color=blue>&gt;&gt;</font></A>"
End If
Response.Write "</TD><TD width=33% align=left vAlign=top noWrap>"
If PagAtual <> TotPag Then
  Response.Write "&nbsp;&nbsp;<A href=""" & Request.ServerVariables("SCRIPT_NAME") & "?PagAtual=" & PagAtual & "&VarPagMax=" & VarPagMax & "&NumPagMax=" & NumPagMax & "&Submit=Proxima&string_busca=" & Server.URLEncode(Request("string_busca")) & "&campo_busca=" & Server.URLEncode(Request("campo_busca")) & """ style='text-decoration=none'><font color=blue>Proxima &gt;</font></A>"
End If
Response.Write "</TD></TR></TABLE>"
End Sub

End If
%>