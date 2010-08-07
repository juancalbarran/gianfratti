<%
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	Session.LCID = 1033
	
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
<script language="JavaScript">
function popup(chamado){
	var width = 450;
	var height = 400;
	var esquerda = (screen.width/2) - (width/2);
	var topo = (screen.height/2) - (height/2);
	window.open("mysOpChat.asp?OperadorID=<%=Session("mysOperadorID")%>&ID="+chamado,"MySupport"+chamado,"top="+topo+",left="+esquerda+",width="+width+",height="+height+",scrollbars=yes, menu=0,status=yes");
}
</script>
</head>
<body topmargin="0" leftmargin="0" bottommargin="0">
<table width="95%" cellpadding="1" align="center">
	<tr><td colspan="2" height="15"></td></tr>
	<td valign="top"><img src="img/t_chamados.gif" alt="" border="0">
	</td></tr>
	<tr><td colspan="2" height="1" bgcolor="DDDDDD"></td></tr>
	<tr><td colspan="2" height="15"></td></tr>
</table>
<table width="95%" cellpadding="1" align="center" style="border: 1 solid #F2F2F2">
<tr bgcolor="#F5F5F5">
	<td width="20%" height="20">&nbsp;<b>Nome</b></td>
	<td width="20%">&nbsp;<b>Email</b></td>
	<td width="15%">&nbsp;<b>Assunto</b></td>
	<td width="15%">&nbsp;<b>IP</b></td>
	<td width="15%">&nbsp;<b>Horario Chamado</b></td>
	<td width="15%" align="center"><b>Chamado</b></td>
</tr>
<%
Call AbreDB

Dim intContador

intRecusarID	=	OK(Request.QueryString("RecusarID"))

If isNumeric(intRecusarID) Then
	strSQL = "UPDATE conversas SET status = False, operador = " & Session("mysOperadorID") & " WHERE id = " & intRecusarID
	Conexao.Execute(strSQL)
End If

strSQL = "SELECT id, usuario, email, assunto, ip, inicio FROM conversas WHERE status = True AND operador = 0 AND departamentoID = " & Session("mysDepartamentoID") & " ORDER BY inicio DESC"

Set rs = Conexao.Execute(strSQL)
intContador = 0
If NOT rs.EOF Then
	While Not rs.EOF
		intContador = intContador + 1
		Response.Write "<tr onMouseOver=""this.bgColor='#F5F5F5'"" onMouseOut=""this.bgColor='#FFFFFF'"">"
		Response.Write "<td>&nbsp;"& rs("usuario") &"</td>"
		Response.Write "<td>&nbsp;"& rs("email") &"</td>"
		Response.Write "<td>&nbsp;"& rs("assunto") &"</td>"
		Response.Write "<td align=""center"">&nbsp;"& rs("ip") &"</td>"
		Response.Write "<td align=""center"">&nbsp;"& rs("inicio") &"</td>"
		Response.Write "<td align=""center""><bgsound src=""som.wav"" loop=""5"">&nbsp;<a  href=""javascript:popup('"&rs("id")&"');"">Aceitar</a>&nbsp;|&nbsp;<a  href=""mysOpChamados.asp?RecusarID="&rs("id")&""">Recusar</a></td></tr>"
		Response.Write "<tr><td bgcolor=""#EDEDED"" colspan=""6"" height=""1""></td></tr>"
		rs.movenext
	Wend
	strMensagem = cStr(intContador)
Else
	Response.Write "<tr><td colspan=""6"" align=""center"">Nenhum chamado no momento</td></tr>"
	strMensagem = "0"
End If

rs.close
Call FechaDB
%>
<tr><td colspan="6" height="2"></td></tr>
</table>
<script>
	window.status = "<%=strMensagem%>";
</script>
</body>
</html>









