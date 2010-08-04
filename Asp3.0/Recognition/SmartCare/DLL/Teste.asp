<% Option Explicit

Dim oCalculo 
Dim Resultado 
Dim numero 

numero = 111 


Set oCalculo = CreateObject("ParImpar.Calculo")

Resultado = oCalculo.Calcula(numero)

Set oCalculo = Nothing


%>
<HTML>
<HEAD>
<TITLE>Par ou Impar ?</TITLE>
</HEAD>
<BODY>
<%
If Resultado = True Then
Response.Write "<P>O numero é <b> Par </b></P>"
Else
Response.Write "<P>O numero é <b> Impar </b></P>"
End If
%>
</BODY>
</HTML>