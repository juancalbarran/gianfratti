<%
Dim meuArray(2,3) 'meuArray(Coluna,Linha)

'1º linha do Array
meuArray(0,0) = "toyota"
meuArray(1,0) = "branca"
meuArray(2,0) = "22.000"

'2º linha do Array
meuArray(0,1) = "ford"
meuArray(1,1) = "azul"
meuArray(2,1) = "12.500"

'3º linha do Array
meuArray(0,2) = "porshe"
meuArray(1,2) = "vermelha"
meuArray(2,2) = "50.000"

'4º linha do Array
meuArray(0,3) = "bmw"
meuArray(1,3) = "amarelo"
meuArray(2,3) = "26.000"

Response.Write "<table border='0'>" 
Response.Write "<tr><td>Linha</td><td>Carro</td>" 
Response.Write "<td>Cor</td><td>Valor</td></tr>" 

For i = 0 to UBound(meuArray,2) 
Response.Write "<tr><td>" & i & "</td>" 
Response.Write "<td>" & meuArray(0,i) & "</td>" 
Response.Write "<td>" & meuArray(1,i) & "</td>" 
Response.Write "<td>" & meuArray(2,i) & "</td></tr>" 
Next 
Response.Write "</table>"
%>

