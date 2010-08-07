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
Response.Buffer = False
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
-->
</style>
</head>
<body class="texto" bgcolor="white" leftmargin="0" topmargin="0" bottommargin="0" rightmargin="0">

<%
Dim Conexao, objRS_conversacao, ComandoSQL

Set Conexao = Server.CreateObject("ADODB.Connection")
Conexao.Open Application("SOS_conexao")
ComandoSQL = " SELECT * FROM historico WHERE id = " & Request("id")

Set objRS_conversacao = Server.CreateObject("ADODB.Recordset")
objRS_conversacao.CursorLocation = 2
objRS_conversacao.CursorType = 0
objRS_conversacao.LockType = 1
objRS_conversacao.Open ComandoSQL, Conexao,,, &H0001

If Not objRS_conversacao.EOF Then
Response.Write "<table width='100%' height=100% border='1' cellspacing='0' cellpadding='2' class='texto' bordercolor=silver>"
Response.Write "  <tr height=1% style='font-weight:bold; color:white; background-color: gray'>"
Response.Write "    <td>#ID</td>"
Response.Write "    <td>Usuário</td>"
Response.Write "    <td>Assunto</td>"
Response.Write "    <td>IP</td>"
Response.Write "    <td>Entrada</td>"
Response.Write "    <td>Saída</td>"
Response.Write "    <td>Avaliação</td>"
Response.Write "  </tr>"
Response.Write "  <tr height=10% style='background-color: gainsboro'>"
Response.Write "    <td width=25 align=center>" & objRS_conversacao("id") & "&nbsp;</td>"
Response.Write "    <td width='40%' nowrap><b>" & objRS_conversacao("usuario") & "</b><br>" & objRS_conversacao("email") & "&nbsp;</td>"
Response.Write "    <td width='20%'>" & objRS_conversacao("assunto") & "&nbsp;</td>"
Response.Write "    <td>" & objRS_conversacao("ip") & "&nbsp;</td>"
Response.Write "    <td>" & objRS_conversacao("entrada") & "&nbsp;</td>"
Response.Write "    <td>" & objRS_conversacao("saida") & "&nbsp;</td>"

Select Case objRS_conversacao("nota")
Case 0 : Response.Write "    <td align=center>Não avaliou</td>"
Case 1 : Response.Write "    <td align=center>Péssimo atendimento</td>"
Case 2 : Response.Write "    <td align=center>Atendimento regular</td>"
Case 3 : Response.Write "    <td align=center>Bom atendimento</td>"
Case 4 : Response.Write "    <td align=center>Ótimo atendimento</td>"
End Select

Response.Write "  </tr>"
Response.Write "  <tr>"
Response.Write "    <td colspan=7 valign=top>"
Response.Write "      <div id=Layer1 style='width:100%; height:100%; z-index:1; overflow: auto;'>"
Response.Write objRS_conversacao("conversa")

Response.Write "      </div>"
Response.Write "    </td>"
Response.Write "  </tr>"

  Response.Write "</table>"

End If

Conexao.Close
Set ComandoSQL = Nothing
Set objRS_conversacao = Nothing
Set Conexao = Nothing


%>

</body>
</html>