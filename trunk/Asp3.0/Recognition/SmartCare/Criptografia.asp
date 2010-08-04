<%
if Request("senha") <> "" then
set objCrypt = server.CreateObject("CriptoASP.clsCryptASP")
strCri = objCrypt.CriptSenha(Request("senha"))
end if
%>
<html>
<head>
<title>Criptografia</title>
</head>

<body bgcolor="#FFFFFF" text="#000000">
<center>
<form name="form1" method="post" action="Criptografia.asp">
<table border="0" width="212">
<tr> 
<td><font face="Arial" size="2"><b>Senha:</b></font>&nbsp; 
<input type="text" name="senha" maxlength="10">
</td>
</tr>
<tr> 
<td align="center">
<font face="Arial" size="2"><b><%=strCri%></b></font>
</td>
</tr>
<tr>
<td>
<div align="center">
<input type="submit" name="Submit" value="Criptografar">
</div>
</td>
</tr>
</table>
</form>
</center>
</body>
</html>

