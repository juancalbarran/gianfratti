<!--#include file="funcoes.asp"-->

<%
usuario = Trim(Request.QueryString("usuario"))
atendente = Trim(Request.QueryString("atendente"))

Application.Lock()

SOS_usuario = Application("SOS_usuario")
SOS_atendente = Application("SOS_atendente")
SOS_ativo = Application("SOS_ativo")

n = UBound(SOS_usuario)
For i = 1 To n
  If Lcase(Trim(SOS_usuario(i))) = Lcase(usuario) And Int(SOS_atendente(i)) = Int(atendente) Then
	SOS_ativo(i) = False
    Exit For
  End If
Next
Application("SOS_ativo") = SOS_ativo

Application.UnLock()

'Elimina variaveis da memoria
Set usuario = Nothing
Set atendente = Nothing
%>
<script language="JavaScript">window.close()</script>