
<%


Dim str
Dim Token
DIM TransacaoID, CliNome


Token = "A03E03A0EAEA599A8EC37EC47AC73D6D"


' Recebe o POST enviado pela BRpay e armazena na variável str
str = Request.Form & "&Comando=validar&Token=" & Token


' Envia para a BRpay a string para validação dos dados
SET objHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
' SET objHttp = Server.CreateObject("Msxml2.ServerXMLHTTP.4.0")
' SET objHttp = Server.CreateObject("Microsoft.XMLHTTP")

objHttp.OPEN "POST", "https://www.brpay.com.br/Security/NPI/Default.aspx", false
objHttp.SetRequestHeader "Content-type", "application/x-www-form-urlencoded"
objHttp.Send str


' Recupera as variáveis postadas pela BRpay e armazena nas variáveis locais
TransacaoID = Request.Form("TransacaoID")
CliNome = Request.Form("CliNome")


' Confirma quando o NPI está VERIFICADO ou FALSO. Se FALSO, então ignore o NPI
' SOMENTE SALVE OS DADOS CASO O RESULTADO SEJA IGUAL À "VERIFICADO"
If (objHttp.status <> 200 ) Then
  ' Erro de cabeçalho HTTP
ElseIf (objHttp.responseText = "VERIFICADO") Then
  ' Salva os dados no Banco de Dados
Else
  ' Não faz nada
End If


SET objHttp = NOTHING


%>









<body>
ok ok ok ok em teste 
</body>
</html>
