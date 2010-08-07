<%
'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
'Tabela de Variáveis disponíveis no seu servidor web
'Parte integrante da VirtuaStore Open 3.0
'Colaboração: Elizeu Alcantara - elizeu@onda.com.br / elizeu@cristaosite.com.br
'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
%>
<!--#include file="config.asp"-->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title><%= Nome_da_sua_loja %> - Verificando variáveis no servidor</title>
</head>

<body>


<%
FOR EACH name IN REQUEST.SERVERVARIABLES

RESPONSE.WRITE(name & " = ")

RESPONSE.WRITE(REQUEST.SERVERVARIABLES(name))&"<br><br>"

NEXT
%>
</body>
</html>
