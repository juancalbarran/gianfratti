<!--#include file="funcoes.asp"-->

<%
atendente = Trim(Request.QueryString("atendente"))
If atendente <> "" Then
  atualiza_status_atendente atendente
End If
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