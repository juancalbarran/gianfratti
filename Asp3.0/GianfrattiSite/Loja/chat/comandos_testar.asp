<%
'******************************************************************
'  Suporte Online SuperAsp 1.0 - SuperASP.com.br - Ano 2003
'  Autor: Fabiano Dias - fdmail@ibest.com.br
'******************************************************************
'
'       DIREITOS AUTORIAIS DO SUPORTE ONLINE SUPERASP
'
'  Você não pode revender este script, alugar, disponibilizar  para
'  download ou fazer qualquer outro tipo  de  redistribuição  sem a
'  nossa autorização.
'
'  Este código de programação usa uma técnica de criptografia,  que
'  identifica sua autoria, ou seja, alterar este código ou revender
'  o mesmo sem contatar o autor significa estar infrigindo todas as
'  leis de direitos autorais e intelectuais,  e como tal passivo de
'  todas as aplicações na forma da lei.
'
'******************************************************************
Dim Comando, tipo, Conexao, ComandoSQL, objRS_comandos

Set Conexao = Server.CreateObject("ADODB.Connection")
Conexao.Open Application("SOS_conexao")
Set objRS_comandos = Server.CreateObject("ADODB.Recordset")
ComandoSQL = "SELECT * FROM comandos WHERE id =" & Request("id")
objRS_comandos.CursorLocation = 3
objRS_comandos.CursorType = 2
objRS_comandos.LockType = 1
objRS_comandos.Open ComandoSQL, Conexao,,, &H0001
comando = objRS_comandos("valor")
tipo = objRS_comandos("tipo")
objRS_comandos.Close()
Conexao.Close()
Set Conexao = Nothing
Set ComandoSQL = Nothing
Set objRS_comandos = Nothing

Select Case tipo
Case 1 : Response.Write comando
Case 2 : Response.Write "<img src='" & comando & "'>"
Case 3 : Response.Write "<a href='" & comando & "'>" & comando & "</a>"
Case 4 : Response.Write "<script>document.location='" & comando & "'</script>"
End Select

Set comando = Nothing
Set tipo = Nothing
%>