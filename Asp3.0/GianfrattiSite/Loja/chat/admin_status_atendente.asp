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
If Session("SOS_admin") = "" And Session("SOS_ipadmin") <> Request.ServerVariables("REMOTE_ADDR") Then
  Response.Write "<script language='javascript'>window.open('admin_login.asp','_top')</script>"
Else
%>

<html>
<head>
<title><%=Application("SOS_titulo")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="copyright" content="SuperAsp">
<meta name="keywords" content="sos, suporte online, suporteonline, superasp, suporte, online">
<meta name="robots" content="ALL">
<style type="text/css">
<!--
.texto{
font-family: Tahoma, Arial;
font-size: 11px;
}
a{
color: blue;
}
-->
</style>
</head>
<body class="texto" bgcolor="white" leftmargin="20" topmargin="20" bottommargin="20" rightmargin="20">

<%
Dim Conexao, objRS_atendente, ComandoSQL

Set Conexao = Server.CreateObject("ADODB.Connection")
Conexao.Open Application("SOS_conexao")
ComandoSQL = " SELECT * FROM atendentes WHERE id = " & Request("id")
Set objRS_atendente = Server.CreateObject("ADODB.Recordset")
objRS_atendente.CursorLocation = 2
objRS_atendente.CursorType = 0
objRS_atendente.LockType = 1
objRS_atendente.Open ComandoSQL, Conexao,,, &H0001

Response.Write "<table width=100% cellpadding=5 cellspacing=0 border=1 bordercolor=silver>"
Response.Write "<tr><td bgcolor='gray' class=texto valign=top width='10%' colspan=2><font color=white><b>DADOS DO ATENDENTE</b></font></td></tr>"
Response.Write "<tr><td bgcolor='whitesmoke' class=texto valign=top width='10%'>"

Response.Write "<img src='" & objRS_atendente("foto") & "'>"
If Int(objRS_atendente("status")) = 1 Then
  Response.Write "<br><br>Status<br><font color='#009900'><b>Online</b></font>"
Else
  Response.Write "<br><br>Status<br><font color='#CC0000'><b>Offline</b></font>"
End If
Response.Write "<br><br>Nome<br><b>" & objRS_atendente("atendente") & "</b>"


ComandoSQL = " SELECT departamento FROM departamentos WHERE id = " & objRS_atendente("id_departamento")
Set objRS_departamento = Server.CreateObject("ADODB.Recordset")
objRS_departamento.CursorLocation = 2
objRS_departamento.CursorType = 0
objRS_departamento.LockType = 1
objRS_departamento.Open ComandoSQL, Conexao,,, &H0001
Response.Write "<br><br>Departamento<br><b>" & objRS_departamento("departamento") & "</b>"
objRS_departamento.Close
Set objRS_departamento = Nothing

Response.Write "<br><br>Email<br><b>" & objRS_atendente("email") & "</b>"
Response.Write "<br><br>Senha<br><b>" & objRS_atendente("senha") & "</b>"
Response.Write "<br><br>Mensagem de entrada<br><b>" & Replace(objRS_atendente("msg_entrada"),"<usuario>","usuário") & "</b>"
Response.Write "<br><br>Nº máximo de usuários atendidos simultaneamente<br><b>" & objRS_atendente("total_usuarios") & " usuários</b>"
Response.Write "<br><br>Data de cadastro<br><b>" & objRS_atendente("data") & "</b>"

Response.Write "</td></tr></table>"

ComandoSQL = " SELECT * FROM historico WHERE atendente = " & Request("id")
Set objRS_nota = Server.CreateObject("ADODB.Recordset")
objRS_nota.CursorLocation = 2
objRS_nota.CursorType = 1
objRS_nota.LockType = 1
objRS_nota.Open ComandoSQL, Conexao,,, &H0001
Dim total, nota_0, nota_1, nota_2, nota_3, nota_4
Dim perc_0, perc_1, perc_2, perc_3, perc_4
total = objRS_nota.RecordCount
nota_0 = 0
nota_1 = 0
nota_2 = 0
nota_3 = 0
nota_4 = 0
perc_0 = 0
perc_1 = 0
perc_2 = 0
perc_3 = 0
perc_4 = 0
While Not objRS_nota.EOF
  Select case objRS_nota("nota")
  Case 0 : nota_0 = nota_0 + 1
  Case 1 : nota_1 = nota_1 + 1
  Case 2 : nota_2 = nota_2 + 1
  Case 3 : nota_3 = nota_3 + 1
  Case 4 : nota_4 = nota_4 + 1
  End Select
  objRS_nota.MoveNext
Wend

Response.Write "<br><table width=100% cellpadding=5 cellspacing=0 border=1 bordercolor=silver>"
Response.Write "<tr><td bgcolor='gray' class=texto valign=top width='10%' colspan=2><font color=white><b>DADOS DO ATENDENTE</b></font></td></tr>"
Response.Write "<tr><td bgcolor='whitesmoke' class=texto valign=top width='10%'>"
Response.Write "<b>" & total & " atendimentos prestados desde a data de cadastro</b></font> <a href='admin_relatorio_atendimentos.asp?id=" & objRS_atendente("id") & "'>Visualizar</a>"

If nota_0 > 0 Then perc_0 = Fix((nota_0 * 100) / total)
If nota_1 > 0 Then perc_1 = Fix((nota_1 * 100) / total)
If nota_2 > 0 Then perc_2 = Fix((nota_2 * 100) / total)
If nota_3 > 0 Then perc_3 = Fix((nota_3 * 100) / total)
If nota_4 > 0 Then perc_4 = Fix((nota_4 * 100) / total)

Response.Write "<br>"
If perc_0 > 0 Then Response.Write "<br><img src='imagens/nota_0.gif' height=20 width=" & perc_0 * 2 & " align='absmiddle'> Não avaliou <b>(" & nota_0 & " usuários)</b> <a href='admin_relatorio_atendimentos.asp?id=" & objRS_atendente("id") & "&nota=0'>Visualizar</a>"
If perc_1 > 0 Then Response.Write "<br><img src='imagens/nota_1.gif' height=20 width=" & perc_1 * 2 & " align='absmiddle'> Péssimo atendimento <b>(" & nota_1 & " usuários)</b> <a href='admin_relatorio_atendimentos.asp?id=" & objRS_atendente("id") & "&nota=1'>Visualizar</a>"
If perc_2 > 0 Then Response.Write "<br><img src='imagens/nota_2.gif' height=20 width=" & perc_2 * 2 & " align='absmiddle'> Atendimento Regular <b>(" & nota_2 & " usuários)</b> <a href='admin_relatorio_atendimentos.asp?id=" & objRS_atendente("id") & "&nota=2'>Visualizar</a>"
If perc_3 > 0 Then Response.Write "<br><img src='imagens/nota_3.gif' height=20 width=" & perc_3 * 2 & " align='absmiddle'> Bom atendimento <b>(" & nota_3 & " usuários)</b> <a href='admin_relatorio_atendimentos.asp?id=" & objRS_atendente("id") & "&nota=3'>Visualizar</a>"
If perc_4 > 0 Then Response.Write "<br><img src='imagens/nota_4.gif' height=20 width=" & perc_4 * 2 & " align='absmiddle'> Ótimo atendimento <b>(" & nota_4 & " usuários)</b> <a href='admin_relatorio_atendimentos.asp?id=" & objRS_atendente("id") & "&nota=4'>Visualizar</a>"

Response.Write "<br><br>"
Response.Write "</td></tr></table>"


objRS_atendente.Close
Conexao.Close
Set ComandoSQL = Nothing
Set objRS_atendente = Nothing
Set objRS_atendentes = Nothing
Set Conexao = Nothing


%>

</body>
</html>

<%
End If
%>