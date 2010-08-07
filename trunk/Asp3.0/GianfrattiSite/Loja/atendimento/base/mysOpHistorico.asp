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
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	Session.lCid = 1033
	
	If NOT Session("mysOP") Then Response.Redirect "mysOpSair.asp"
%>
<!--#include file="db.asp"-->
<html>
<head>
<title> &#9658;&#9658;&#9658; MySupport - Atendimento Online</title>
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
	<td valign="top"><img src="img/t_historico.gif" alt="" border="0">
	</td><td align="right"></td></tr>
	<tr><td colspan="2" height="1" bgcolor="DDDDDD"></td></tr>
	<tr><td colspan="2" height="15"></td></tr>
</table>
<%
If Ok(Request.QueryString("msg_erro")) <> "" Then
	Response.Write "<center><FONT COLOR=""#FF0000"">" & Ok(Request.QueryString("msg_erro")) & "</FONT></center><br><br>"
End If
If Ok(Request.QueryString("msg_ok")) <> "" Then
	Response.Write "<center><FONT COLOR=""#009900"">" & Ok(Request.QueryString("msg_ok")) & "</FONT></center><br><br>"
End If
%>
<table width="95%" cellpadding="0" cellspacing="0" align="center">
<tr><td width="20%" valign="top">
	<table width="95%" cellpadding="1" align="center" style="border: 1 solid #F2F2F2">
	<tr><td><select class="campo" name="chamados" size="12" style="width: 180px" onchange="javascript:location.href='mysOpHistorico.asp?ID='+this.value;">
	<%
	Call AbreDB
	
	Dim intConversa
	
	intConversa = OK(Request.QueryString("id"))
	
	strSQL = "SELECT TOP 30 inicio, id, usuario FROM conversas WHERE operador = " & Session("mysOperadorID") & " ORDER BY ID DESC"
	Set rs = Conexao.Execute(strSQL)
	If NOT rs.EOF Then
		While Not rs.EOF
			Response.Write "<option value='"& rs("id") &"'"
			If CStr(rs("id")) = intConversa Then Response.Write "SELECTED"
			Response.Write ">&nbsp;" & FormataData(rs("inicio"),"dd.mm.yyyy") & " - " & rs("usuario")
			rs.movenext
		Wend
	Else
		Response.Write "Nenhum Chamado"
	End If
	rs.close
	Call FechaDB
	%>
	</select></td></tr></table>
</td><td valign="top">
	<table width="95%" height="100%" cellpadding="1" align="center" style="border: 1 solid #F2F2F2">
	<%
	If intConversa <> "" AND isNumeric(intConversa) Then
		Call AbreDB
		strSQL = "SELECT id, usuario, assunto, email, ip, inicio, texto FROM conversas WHERE operador = " & Session("mysOperadorID") & " AND id = " & intConversa
		Set rs = Conexao.Execute(strSQL)
		If NOT rs.EOF Then
			Response.Write "<tr bgcolor=""F5F5F5""><td valign=""top"" width=""50%"">"
			Response.Write "<b>&nbsp;Chamado:</b>&nbsp; #" & rs("id") & "<br>"
			Response.Write "<b>&nbsp;Usuário:</b>&nbsp;" & rs("usuario") & "<br>"
			Response.Write "<b>&nbsp;Assunto:</b>&nbsp;" & rs("assunto") & "<br>"
			Response.Write "</td><td>"
			Response.Write "<b>&nbsp;Email:</b>&nbsp;" & rs("email") & "<br>"
			Response.Write "<b>&nbsp;IP:</b>&nbsp;" & rs("ip") & "<br>"
			Response.Write "<b>&nbsp;Inicio:</b>&nbsp;" & FormataData(rs("inicio"),"dd.mm.yyyy") & "<br>"
			Response.Write "</td></tr>"
			Response.Write "<tr><td colspan=""2"" height=""1"" bgcolor=""F5F5F5""></td></tr>"
			Response.Write "<tr><td colspan=""2"">"
			Response.Write rs("texto") & "</td></tr>"
		Else
			Response.Write "Nenhum Chamado"
		End If
		rs.close
		Call FechaDB
	End If
	%>
	<tr><td colspan="2">&nbsp;</td></tr>
	</table>
</td></tr>
</table>
</body>
</html>
