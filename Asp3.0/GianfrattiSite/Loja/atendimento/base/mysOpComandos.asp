<%
	Session.LCID = 1033
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	
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
	<td valign="top"><img src="img/t_comandos.gif" alt="" border="0">
	</td><td align="right"><a href="mysOpComandosForm.asp"><img title="Adicionar Comando"  src="img/t_adicionar.gif" alt="" border="0"></a></td></tr>
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
<table width="95%" cellpadding="1" align="center" style="border: 1 solid #F2F2F2">
<tr bgcolor="#F5F5F5">
	<td align="center" width="5%" height="20">&nbsp;<b>#</b></td>
	<td width="35%">&nbsp;<b>Descrição</b></td>
	<td width="45%">&nbsp;<b>Conteúdo</b></td>
	<td align="center" width="15%">&nbsp;<b>Opção</b></td>
</tr>
<%
Call AbreDB

Dim intContador

strSQL = "SELECT id, descricao, conteudo FROM comandos WHERE operador = " & Session("mysOperadorID")

Set rs = Conexao.Execute(strSQL)
If NOT rs.EOF Then
	intContador = 0
	While Not rs.EOF
		intContador = intContador + 1
		Response.Write "<tr onMouseOver=""this.bgColor='#F5F5F5'"" onMouseOut=""this.bgColor='#FFFFFF'"">"
		Response.Write "<td align=""right"">"& intContador &".&nbsp;</td>"
		Response.Write "<td>&nbsp;"& rs("descricao") &"</td>"
		Response.Write "<td>&nbsp;"& rs("conteudo") &"</td>"
		Response.Write "<td align=""center"">&nbsp;<a  href=""mysOpComandosForm.asp?acao=Editar&ID="&rs("id")&""">Editar</a> | <a  href=""mysOpComandosForm.asp?acao=Deletar&ID="&rs("id")&""">Deletar</a></td></tr>"
		Response.Write "<tr><td bgcolor=""#EDEDED"" colspan=""6"" height=""1""></td></tr>"
		rs.movenext
	Wend
Else
	Response.Write "<tr><td colspan=""6"" align=""center"">Nenhum comando cadastrado</td></tr>"
End If

rs.close
Call FechaDB
%>
<tr><td colspan="6" height="2"></td></tr>
</table>
</body>
</html>
