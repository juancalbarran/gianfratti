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
If Session("SOS_usuario") <> "" Then

Dim SOS_entradas, SOS_avaliacoes, n, i

Application.Lock()

SOS_ids = Application("SOS_ids")
SOS_avaliacoes = Application("SOS_avaliacoes")
n = UBound(SOS_ids)
For i = 1 To n
  If SOS_ids(i) = Int(Request("SOS_id")) Then
    Session("nota") = Request("nota")
    SOS_avaliacoes(i) = Request("nota")
	Application("SOS_avaliacoes") = SOS_avaliacoes
    Exit For
  End If
Next

Application.UnLock()

Set SOS_entradas = Nothing
Set SOS_avaliacoes = Nothing
Set n = Nothing
Set i = Nothing

End If
%>