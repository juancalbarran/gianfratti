<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<%
response.write "<br> modo_entrega: "&session("modo_entrega")
response.write "<br> usuario: "&session("usuario")
response.write "<br> pedido1: "&session("pedido1")
response.write "<br> orderID: "&Session("orderID")
response.write "<br> MaiorID: "&Session("MaiorID")
response.write "<br> PesoTotalValor: "&session("PesoTotalValor")
response.write "<br> sql: "&session("sql")
response.write "<br> sql_max: "&session("sql_max")
response.write "<br> dados_gravados_compra: "&session("dados_gravados_compra")
response.write "<br> textosql_registros: "&session("textosql_registros")

 %>


</body>
</html>
