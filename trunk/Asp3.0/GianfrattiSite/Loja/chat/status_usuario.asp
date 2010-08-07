<!--#include file="funcoes.asp"-->

<%
usuario = Trim(Request("usuario"))
atendente = Trim(Request("atendente"))

If usuario <> "" Then
  atualiza_status_usuario usuario, atendente
End If
Set usuario = Nothing
Set atendente = Nothing
%>

<SCRIPT LANGUAGE="JavaScript">
<!--
function atualiza_pagina(){
  document.location.href=document.location.href
}
setTimeout("atualiza_pagina()",7000);
//-->
</SCRIPT>