<%
'MYSUPPORT - ALGUNS DIREITOS RESERVADOS
'http://www.mysupport.com.br
'
'TERMOS DE LICENÇA DESTE SISTEMA
'
'Você pode:
'
'- Copiar, distribuir, exibir e executar a obra;
'- Criar obras derivadas.
'
'Sob as seguintes condições:
'
'- Atribuição. Você deve dar crédito ao autor original.
'- Uso Não-Comercial. Você não pode utilizar esta obra com finalidades comerciais.
'- Compartilhamento pela mesma Licença. Se você alterar, transformar, ou criar outra obra com base nesta, você somente poderá distribuir a obra resultante sob uma licença idêntica a esta.
'
'Para cada novo uso ou distribuição, você deve deixar claro para outros os termos da licença desta obra.
'Qualquer uma destas condições podem ser renunciadas, desde que você obtenha permissão do autor.
'Qualquer direito de uso legítimo (ou "fair use") concedido por lei, ou qualquer outro direito protegido pela legislação local, não são em hipótese alguma afetados pelo disposto acima.
'
'Este é um sumário para leigos da Licença Jurídica (na íntegra).
'
'LICENSE
'
'You are free:
'
'to copy, distribute, display, and perform the work;
'to make derivative works.
'
'Under the following conditions:
'
'- Attribution. You must give the original author credit.
'- Noncommercial. You may not use this work for commercial purposes.
'- Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under a license identical to this one. 
'
'For any reuse or distribution, you must make clear to others the license terms of this work.
'Any of these conditions can be waived if you get permission from the copyright holder.
'Your fair use and other rights are in no way affected by the above.
'
'This is a human-readable summary of the Legal Code (the full license).
%>
<%
	Session.LCID = 1033
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	
	If NOT Session("mysAdmin") Then Response.Redirect "mysAdmSair.asp"
%>
<!--#include file="db.asp"-->
<html>
<head>
<title> MySupport - Atendimento Online</title>
<style>
a:link	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:visited	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:hover	{font-size:8pt; font-family: Tahoma, Verdana; color:F4B511; TEXT-DECORATION: none;}
body	{ font-family: Tahoma, Verdana; font-size: 8pt; }

body 			{ scrollbar-face-color: #E2E5EA;}
body 			{ scrollbar-shadow-color: #687888;}
body 			{ scrollbar-highlight-color: #ffffff;}
body 			{ scrollbar-3dlight-color: #687888;}
body 			{ scrollbar-darkshadow-color: #E2E5EA;}
body 			{ scrollbar-track-color: #bcbfc0;}
body 			{ scrollbar-arrow-color: #6e7e88;}

td		{ font-family: Tahoma, Verdana; font-size: 8pt; }
.campo{				
		font-family: Arial, Verdana; 
		font-size: 11px; 
		background-color: #FFFFFF;	
		border-left: 1 solid #68A4C8; 
		border-right: 1 solid #B8D0D8; 
		border-top: 1 solid #68A4C8; 
		border-bottom: 1 solid #B8D0D8;
		}
				
.botao 	{
			background-color: #E8E8E8; 
			color: black; 
			border-color: #FFFFFF; 
			border-width: 1px; 
			font-family: Tahoma, Verdana; 
			font-size: 8pt;
		}
</style>
</head>
<body topmargin="0" leftmargin="0" bottommargin="0">
<table width="95%" cellpadding="1" align="center">
	<tr><td colspan="2" height="15"></td></tr>
	<td valign="top"><img src="img/t_estatisticas.gif" alt="" border="0">
	</td><td align="right"></td></tr>
	<tr><td colspan="2" height="1" bgcolor="DDDDDD"></td></tr>
	<tr><td colspan="2" height="15"></td></tr>
</table>
<table width="95%" align="center">
<tr>
	<td valign="top" width="22%"><!--#include file="inc_calendario.asp"--></td>
	<td valign="top" align="center">
<%
Call AbreDB

strSQL = "SELECT Count(conversas.id) AS Total, departamentos.nome, hour(conversas.inicio) as hora, conversas.nota FROM conversas, departamentos WHERE departamentos.id = conversas.departamentoID AND conversas.inicio BETWEEN #"& calA & "/" & adZero(calM,2) & "/" & adZero(calD,2) &" 00:00:00# AND #"& calA & "/" & adZero(calM,2) & "/" & adZero(calD,2) &" 23:59:59# GROUP BY departamentos.nome, hour(conversas.inicio), conversas.nota ORDER BY departamentos.nome"

set rs = conexao.execute(strSQL)
If NOT rs.EOF Then
strDpto = ""
With Response
	While NOT rs.EOF
		If rs("nome") <> strDpto Then
			strDpto = rs("nome")
			.Write "<table width='100%' cellpadding='2' cellspacing='2' style='border: 1 solid #F2F2F2'>"
			.Write "<tr><td colspan='3' bgcolor='#F5F5F5'><b>&nbsp;"
			.Write strDpto & "</b></td></tr>"
			.Write "<tr>"
			.Write "<td width='33%' bgcolor='FAFAFA' align='center'><b>Horário</b></td>"
			.Write "<td width='33%' bgcolor='FAFAFA' align='center'><b>Avaliação</b></td>"
			.Write "<td bgcolor='FAFAFA' align='center'><b>Atendimentos</b></td>"
			.Write "</tr>"
		End If
		.Write "<tr>"
		.Write "<td align='center'>"&adZero(rs("hora"),2)&"h00 às  "&adZero(rs("hora"),2)&"h59</td>"
		.Write "<td bgcolor='FAFAFA' align='center'>"&textoNota(rs("nota"))&"</td>"
		.Write "<td align='center'>"&adZero(rs("total"),3)&"</td>"
		.Write "</tr>"
		.Write "<tr><td colspan='3' height='1' bgcolor='FAFAFA'></td></tr>"
		rs.movenext
	Wend
End With
Else
	Response.Write "<br><br><br>Nenhum Atendimento em " & adZero(calD,2) & "/" & adZero(calM,2) & "/" & calA
End If
Call FechaDB
%>
</table>
</td>
</tr>
<tr><td colspan="2" height="2"></td></tr>
</table>
</body>
</html>
<%
Function textoNota(intValor)
	Select Case intValor
		Case 1 : textoNota = "Ruim"
		Case 2 : textoNota = "Regular"
		Case 3 : textoNota = "Bom"
		Case 4 : textoNota = "Muito Bom"
		Case 5 : textoNota = "Excelente"
		Case Else : textoNota = "Não Avaliado"
	End Select
End Function
%>
