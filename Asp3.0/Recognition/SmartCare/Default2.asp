<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Documento sem t&iacute;tulo</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<fieldset>
<legend >&nbsp;Usuário&nbsp;</legend>
<table width="100%">
  <tr class="zebra1"> 
    <td colspan="5" class="texto">Cliente:<strong>&nbsp;<%=Session("Convenio_Nome")%></strong></td>
  </tr>
  <tr class="zebra1"> 
    <td width="44%" class="texto">Bem vindo(a): <strong><%=Session("Funcionario_Nome")%></strong></td>
    <td width="5%" class="texto">Login:</td>
    <td width="14%" class="texto"><strong><%=Session("Login")%></strong></td>
    <td width="6%" class="texto">E-Mail:</td>
    <td width="31%" class="texto"><strong><%=Session("Email")%></strong></td>
  </tr>
</table>
</fieldset>
<fieldset>
<legend >&nbsp;Pacientes&nbsp;</legend>
<table width="100%">
  <tr class="zebra1"> 
    <td class="texto">Pacientes:<strong>&nbsp;250</strong></td>
  </tr>
  <tr class="zebra1"> 
    <td class="texto">Pacientes em atendimento: <strong>150</strong></td>
  </tr>
  <tr class="zebra1">
    <td class="texto">Pacientes com &Oacute;bito: <strong>1</strong></td>
  </tr>
</table>
</fieldset>
<fieldset>
<legend >&nbsp;Solicitações&nbsp;</legend>
<table width="100%">
  <tr class="zebra1"> 
    <td class="texto">Solicita&ccedil;&otilde;es:<strong>&nbsp;350</strong></td>
  </tr>
  <tr class="zebra1"> 
    <td class="texto">Solicita&ccedil;&otilde;es aprovadas: <strong>150</strong></td>
  </tr>
  <tr class="zebra1"> 
    <td class="texto">Solicita&ccedil;&otilde;es negadas: <strong>1</strong></td>
  </tr>
  <tr class="zebra1">
    <td class="texto">Solicita&ccedil;&otilde;es canceladas: <strong>1</strong></td>
  </tr>
</table>
</fieldset>
<fieldset>
<legend >&nbsp;Atendimentos&nbsp;</legend>
<table width="100%">
  <tr class="zebra1"> 
    <td class="texto">Atendimentos:<strong>&nbsp;450</strong></td>
  </tr>
  <tr class="zebra1"> 
    <td class="texto">Solicita&ccedil;&otilde;es aprovadas: <strong>150</strong></td>
  </tr>
  <tr class="zebra1"> 
    <td class="texto">Solicita&ccedil;&otilde;es negadas: <strong>1</strong></td>
  </tr>
  <tr class="zebra1"> 
    <td class="texto">Solicita&ccedil;&otilde;es canceladas: <strong>1</strong></td>
  </tr>
</table>
</fieldset>
</body>
</html>

