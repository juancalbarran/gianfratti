<%
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	Session.lCid = 1033
%>
<html>
<head>
<title></title>
<style>
a:link	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:visited	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:hover	{font-size:8pt; font-family: Tahoma, Verdana; color:F4B511; TEXT-DECORATION: none;}
body	{ font-family: Tahoma, Verdana; font-size: 8pt; }
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
return true;
}
</script>
<body topmargin="0" leftmargin="0" bottommargin="0">
<table height="100%" width="100%" cellspacing="0">
	<tr bgcolor="F5F5F5">
		<td valign="top" width="50%" height="10%">
			<img src="img/mysupport.gif" alt="" border="0">
		</td>
		<td valign="top">
		</td>
	</tr>
	<tr>
		<td colspan="2" height="75%" valign="middle" style="border: 1 solid #DDDDDD" align="center">
		<form action="mysOpLogin.asp" method="post">
<table width="40%" align="center" style="border: 1 solid #F1F1F1">
<tr><td colspan="2" bgcolor="#F5F5F5" height="25">&nbsp;<b>Atendimento Online</b></td></tr>
<tr><td colspan="2" height="10"></td></tr>
<tr>
	<td width="45%" align="right">área:</td>
	<td><select class="campo" name="opcao" size="1" style="width: 131px">
		<option value="admin">Administração
		<option value="atend" selected>Atendimento
		</select>
	</td>
</tr>
<tr>
	<td width="45%" align="right">login:</td>
	<td><input type="text" name="login" size="20" maxlength="25" class="campo"></td>
</tr>
<tr>
	<td width="45%" align="right">senha:</td>
	<td><input type="password" name="senha" size="20" maxlength="25" class="campo"></td>
</tr>
<tr>
	<td height="35" width="45%" align="right"></td>
	<td><input type="submit" name="OK" value="   Entrar   " class="botao"></td>
</tr>
<tr><td colspan="2" height="10"></td></tr>
</table>
</form>

		</td>
	</tr>
	<tr bgcolor="F5F5F5">
		<td align="center" valign="middle" colspan="2">
			<br>
		</td>
	</tr>
	<tr bgcolor="F5F5F5">
		<td valign="top" colspan="2" align="center">
			<font size="1">

			</font>
		</td>
	</tr>
</table>
</body>
</html>