<!--#include file="funcoes.asp"-->

<html>
<head>
<title>Status</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">
<!--
function abre_popup(width, height, nome) {
  var top; var left;
  top = ( (screen.height/2) - (height/2) )
  left = ( (screen.width/2) - (width/2) )
  window.open('',nome,'width='+width+',height='+height+',scrollbars=no,toolbar=no,location=no,status=no,menubar=no,resizable=no,left='+left+',top='+top);
}
function atualiza_pagina(){
  document.location.href=document.location.href
}
atualiza = setTimeout("atualiza_pagina()",999999);
//-->
</SCRIPT>
</head>
<body class="texto" bgcolor="#ffffff" topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">

<%
janela = Time()
janela = CStr(janela)
janela = Lcase(janela)
janela = Replace(janela,"pm","")
janela = Replace(janela,"am","")
janela = Replace(janela,":","")
janela = Replace(janela," ","")

If verifica_status = True Then
  Response.Write "<a href=""" & endereco_virtual & "/usuario_entrar.asp"" onMouseOver=""clearTimeout(atualiza)"" onMouseOut=""atualiza = setTimeout('atualiza_pagina()',9999);"" onclick=""abre_popup(450, 400, '" & janela & "')"" target='" & janela & "'>"
  Response.Write "<img src='" & endereco_virtual & "/imagens/status_online.gif' border=0>"
  Response.Write "</a>"
Else
  Response.Write "<a href=""" & endereco_virtual & "/enviar_mensagem.asp"" onclick=""abre_popup(450, 400, '" & janela & "')"" target='" & janela & "'>"
  Response.Write "<img src='" & endereco_virtual & "/imagens/status_offline.gif' border=0>"
  Response.Write "</a>"
End If
Set janela = Nothing
%>

</body>
</html>