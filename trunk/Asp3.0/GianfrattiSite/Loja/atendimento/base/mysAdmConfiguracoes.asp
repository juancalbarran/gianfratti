<%
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	Session.LCID = 1033
	
	If NOT Session("mysAdmin") Then Response.Redirect "mysAdmSair.asp"
%>
<!--#include file="db.asp"-->
<%
Dim strSQL

Call AbreDB

If Request.ServerVariables("HTTP_METHOD") = "POST" Then
	strNome		= Server.HTMLEncode(OK(Request.Form("nome")))
	strEndereco	= Server.HTMLEncode(OK(Request.Form("endereco")))
	strEmail	= Server.HTMLEncode(OK(Request.Form("email")))
	strTopo		= Server.HTMLEncode(OK(Request.Form("topo")))
	strFonte	= Server.HTMLEncode(OK(Request.Form("fonte")))
	strTempo	= Server.HTMLEncode(OK(Request.Form("tempo")))
	strLogo		= Server.HTMLEncode(OK(Request.Form("logo")))
	strOnline	= Server.HTMLEncode(OK(Request.Form("online")))
	strOffline	= Server.HTMLEncode(OK(Request.Form("offline")))
	
	strSQL = "UPDATE config SET nome = '" & strNome & "', endereco = '" & strEndereco & "', email = '" & strEmail & "', corTopo = '" & strTopo & "', corFonte = '" & strFonte & "', tempoEspera = " & strTempo & ", imgOn = '" & strOnline & "', imgOff = '" & strOffline & "', logo = '" & strLogo & "'"
	Conexao.Execute(strSQL)
	Response.Redirect "mysAdmConfiguracoes.asp?msg_ok=Configurações alteradas com sucesso"
Else
	strSQL = "SELECT * FROM config"
	Set rs = Conexao.Execute(strSQL)
	If rs.BOF AND rs.EOF Then
		Response.Redirect "mysAdmConfiguracoes.asp?msg_erro=Erro de leitura das configurações"
	Else
		strNome			= rs("nome")
		strEndereco		= rs("endereco")
		strEmail		= rs("email")
		strLogo			= rs("logo")
		strOnline		= rs("imgOn")
		strOffline		= rs("imgOff")
		strTopo			= rs("corTopo")
		strFonte		= rs("corFonte")
		strTempo		= rs("tempoEspera")
	End If
End If
rs.Close
Call FechaDB
%>
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
<script language="JavaScript">
function validarForm(){
	if(form.nome.value == '') {
		alert('Você deve preencher o campo nome!');
		form.nome.focus();
		return false;
	}
	if(form.endereco.value == '') {
		alert('Você deve preencher o campo endereço!');
		form.endereco.focus();
		return false;
	}
	if(form.email.value == '') {
		alert('Você deve preencher o campo email!');
		form.email.focus();
		return false;
	}
	if(form.logo.value == '') {
		alert('Você deve preencher o campo logo!');
		form.logo.focus();
		return false;
	}
	if(form.online.value == '') {
		alert('Você deve preencher o campo Imagem Online!');
		form.online.focus();
		return false;
	}
	if(form.offline.value == '') {
		alert('Você deve preencher o campo Imagem Offline!');
		form.offline.focus();
		return false;
	}
return true;
}
</script>
<body topmargin="0" leftmargin="0" bottommargin="0">
<table width="95%" cellpadding="1" align="center">
	<tr><td colspan="2" height="15"></td></tr>
	<td valign="top"><img src="img/t_configuracoes.gif" alt="" border="0">
	</td><td align="right"></td></tr>
	<tr><td colspan="2" height="1" bgcolor="DDDDDD"></td></tr>
</table>
<form name="form" action="mysAdmConfiguracoes.asp" method="post" onSubmit="return validarForm();">
<table width="100%" cellpadding="1" align="center">
<tr>
	<td colspan="2" align="center">
<%
If Ok(Request.QueryString("msg_erro")) <> "" Then
	Response.Write "<center><FONT COLOR=""#FF0000"">" & Ok(Request.QueryString("msg_erro")) & "</FONT></center>"
End If
If Ok(Request.QueryString("msg_ok")) <> "" Then
	Response.Write "<center><FONT COLOR=""#009900"">" & Ok(Request.QueryString("msg_ok")) & "</FONT></center>"
End If
%>
	</td>
</tr>
<tr>
	<td colspan="2" height="15"></td>
</tr>
<tr><td width="50%" valign="top">
			<table width="80%" align="center">
				<tr>
					<td width="50%">Nome:</td>
					<td><input type="text" name="nome" value="<%=strNome%>" size="30" maxlength="100" class="campo"></td></tr>
				<tr>
					<td width="50%">Endereço:</td>
					<td><input type="text" name="endereco" value="<%=strEndereco%>" size="30" maxlength="100" class="campo"></td></tr>
				<tr>
					<td width="50%">Email:</td>
					<td><input type="text" name="email" value="<%=strEmail%>" size="30" maxlength="100" class="campo"></td></tr>
				<tr>
					<td width="50%">Tempo de Espera:</td>
					<td><select class="campo" name="tempo" size="1" style="width: 180px">
				<%For i = 5 to 60 Step 5
					Response.Write "<option "
					If strTempo = i Then Response.Write "selected"
					Response.Write " value='"&i&"'>"&i
					Response.Write "&nbsp;segundos</option>"
				Next%>
				</select>
				</td></tr>
				<tr>
					<td width="50%">Cor Topo:</td>
					<td>
					<select class="campo" name="topo" size="1" style="width: 180px">
<option style="background-color: #FFFFFF;" value="#FFFFFF" <%If strTopo = "#FFFFFF" Then Response.Write "SELECTED"%>>
<option style="background-color: #000000;" value="#000000" <%If strTopo = "#000000" Then Response.Write "SELECTED"%>>
<option style="background-color: #F5F5F5;" value="#F5F5F5" <%If strTopo = "#F5F5F5" Then Response.Write "SELECTED"%>>
<option style="background-color: #DDDDDD;" value="#DDDDDD" <%If strTopo = "#DDDDDD" Then Response.Write "SELECTED"%>>
<option style="background-color: #EC5454;" value="#EC5454" <%If strTopo = "#EC5454" Then Response.Write "SELECTED"%>>
<option style="background-color: #B94949;" value="#B94949" <%If strTopo = "#B94949" Then Response.Write "SELECTED"%>>
<option style="background-color: #477A47;" value="#477A47" <%If strTopo = "#477A47" Then Response.Write "SELECTED"%>>
<option style="background-color: #D6CA41;" value="#D6CA41" <%If strTopo = "#D6CA41" Then Response.Write "SELECTED"%>>
<option style="background-color: #EA9213;" value="#EA9213" <%If strTopo = "#EA9213" Then Response.Write "SELECTED"%>>
<option style="background-color: #3A4BCA;" value="#3A4BCA" <%If strTopo = "#3A4BCA" Then Response.Write "SELECTED"%>>
<option style="background-color: #3ACAC5;" value="#3ACAC5" <%If strTopo = "#3ACAC5" Then Response.Write "SELECTED"%>>
					</select>
					</td></tr>
				<tr>
					<td width="50%">Cor Fonte:</td>
					<td>
					<select class="campo" name="fonte" size="1" style="width: 180px">
<option style="background-color: #FFFFFF;" value="#FFFFFF" <%If strFonte = "#FFFFFF" Then Response.Write "SELECTED"%>>
<option style="background-color: #000000;" value="#000000" <%If strFonte = "#000000" Then Response.Write "SELECTED"%>>
<option style="background-color: #F5F5F5;" value="#F5F5F5" <%If strFonte = "#F5F5F5" Then Response.Write "SELECTED"%>>
<option style="background-color: #DDDDDD;" value="#DDDDDD" <%If strFonte = "#DDDDDD" Then Response.Write "SELECTED"%>>
<option style="background-color: #EC5454;" value="#EC5454" <%If strFonte = "#EC5454" Then Response.Write "SELECTED"%>>
<option style="background-color: #B94949;" value="#B94949" <%If strFonte = "#B94949" Then Response.Write "SELECTED"%>>
<option style="background-color: #477A47;" value="#477A47" <%If strFonte = "#477A47" Then Response.Write "SELECTED"%>>
<option style="background-color: #D6CA41;" value="#D6CA41" <%If strFonte = "#D6CA41" Then Response.Write "SELECTED"%>>
<option style="background-color: #EA9213;" value="#EA9213" <%If strFonte = "#EA9213" Then Response.Write "SELECTED"%>>
<option style="background-color: #3A4BCA;" value="#3A4BCA" <%If strFonte = "#3A4BCA" Then Response.Write "SELECTED"%>>
<option style="background-color: #3ACAC5;" value="#3ACAC5" <%If strFonte = "#3ACAC5" Then Response.Write "SELECTED"%>>
					</select><br><br>
					</td></tr>
					<tr><td colspan="2" height="1" bgcolor="#DDDDDD"></td></tr>
					<tr><td><br>Código:</td>
						<td><br><textarea readonly cols="32" class="campo">&lt;script language=&quot;JavaScript&quot; src=&quot;<%=strEndereco%>/mysStatus.asp&quot;&gt;
&lt;/script&gt;</textarea></td>
					</tr>
			</table>
</td><td valign="top">

			<table width="80%" align="center">
				<tr>
					<td width="50%">Logo:</td>
					<td><input type="text" name="logo" value="<%=strLogo%>" size="30" maxlength="100" class="campo"></td></tr>
				<tr>
					<td width="50%"></td>
					<td><img border="0" src="<%=strEndereco%>/<%=strLogo%>"></td></tr>
				<tr>
					<td width="50%">Imagem Online:</td>
					<td><input type="text" name="online" value="<%=strOnline%>" size="30" maxlength="100" class="campo"></td></tr>
				<tr>
					<td width="50%"></td>
					<td><img border="0" src="<%=strEndereco%>/<%=strOnline%>"></td></tr>
				<tr>
					<td width="50%">Imagem Offline:</td>
					<td><input type="text" name="offline" value="<%=strOffline%>" size="30" maxlength="100" class="campo"></td></tr>
				<tr>
					<td width="50%"></td>
					<td><img border="0" src="<%=strEndereco%>/<%=strOffline%>"></td></tr>
			</table>
</td></tr>
<tr>
	<td colspan="2" align="center"><input type="submit" value="    Atualizar    " class="botao"></td>
</tr>
</table>
</form>
</body>
</html>
