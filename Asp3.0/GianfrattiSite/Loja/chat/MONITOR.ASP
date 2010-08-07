<html>
<head>
<title><%=Application("SOS_titulo")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
<!--
function abre_popup(width, height, nome) {
  var top; var left;
  top = ( (screen.height/2) - (height/2) )
  left = ( (screen.width/2) - (width/2) )
  window.open('',nome,'width='+width+',height='+height+',scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,resizable=no,left='+left+',top='+top);
}
window.onunload=exit
function exit(){
  window.open("atendente_logout.asp?atendente="+parent.document.all.atendente.value,"sair",'width=50,height=50,scrollbars=no,toolbar=no,location=no,status=no,menubar=no,resizable=no,left=10000,top=10000');
}
//-->
</script>
<body bgcolor="#C7C7C7" topmargin="5" leftmargin="5" rightmargin="5" bottommargin="5">
<input type="hidden" name="atendente" value="">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td height="65" valign="top"> <img src="imagens/SOS_logo.gif" align="absmiddle"> 
      <img src="imagens/SOS_status.gif" width="75" height="60" border="0" align="absmiddle" onClick="javascript: document.monitor.location.href='atendente_monitor.asp?atendente='+parent.document.all.atendente.value; layer_monitor.style.visibility='hidden'" style="cursor: hand">
      <img src="imagens/SOS_atendimentos.gif" align="absmiddle" border="0" onClick="javascript: document.iframe_monitor.location.href='atendente_relatorio_atendimentos.asp?atendente='+parent.document.all.atendente.value; layer_monitor.style.visibility='visible'" style="cursor: hand">
      <img src="imagens/SOS_comandos.gif" width="75" height="60" border="0" align="absmiddle" onClick="javascript: document.iframe_monitor.location.href='atendente_comandos_consultar.asp?atendente='+parent.document.all.atendente.value; layer_monitor.style.visibility='visible'" style="cursor: hand">
      <img src="imagens/SOS_configuracoes.gif" align="absmiddle" border="0" onClick="javascript: document.iframe_monitor.location.href='atendente_alterar.asp?atendente='+parent.document.all.atendente.value; layer_monitor.style.visibility='visible'" style="cursor: hand">
      <img src="imagens/SOS_sair.gif" align="absmiddle" border="0" onClick="javascript: exit(); document.monitor.location.href='atendente_login.asp'; layer_monitor.style.visibility='hidden'" style="cursor: hand">
    </td>
  </tr>
  <tr>
    <td><iframe name="monitor" src="atendente_monitor.asp" style="width:100%; height:100%; border:1px inset" frameborder="0"></iframe></td>
  </tr>
</table>
<div id="layer_monitor" style="position:absolute; visibility: hidden; left:6px; top:71px; width:99%; height:75%; z-index:1; overflow: auto; background-color: white">
<iframe name="iframe_monitor" style="width:100%; height=100%" frameborder="0"></iframe></td>
</div>
</body>
</html>
