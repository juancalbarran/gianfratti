<!--#include file="funcoes.asp"-->

<%
Response.Expires=-1000
Response.Buffer = False

If Not IsEmpty(Request.Form("enviar")) Then

  login = Trim(Lcase(Request.Form("login")))
  login = Replace(login, "'", "")
  login = Replace(login, "|", "")
  senha = Trim(Lcase(Request.Form("senha")))
  senha = Replace(senha, "'", "")
  senha = Replace(senha, "|", "")
  atendente = ""

  Set objCon = Server.CreateObject("ADODB.Connection")
  objCon.Open Application("SOS_conexao")
  ComandoSQL = "SELECT id, id_departamento FROM atendentes WHERE atendente LIKE '" & login & "' AND senha LIKE '" & senha & "'"
  Set objRS = objCon.Execute(ComandoSQL)

  If Not objRS.EOF Then
    atendente = objRS("id")
    departamento = objRS("id_departamento")
  End If
  
  objRS.Close
  objCon.Close

  Set objCon = Nothing
  Set objRS = Nothing

  If atendente <> "" Then
    adiciona_atendente atendente, departamento
	Response.Redirect "atendente_monitor.asp?atendente=" & atendente
  Else
%>

  <BR><BR>
  <strong>Acesso Negado</strong><br>
  O login ou a senha informados n&atilde;o correspondem<br>
  <BR>
  <a href="<%=Request.ServerVariables("SCRIPT_NAME")%>">Clique aqui</a> para tentar novamente<BR><BR>

<%
  End If

Else
%>

<HTML>
<HEAD>
<TITLE>Efetuar Login</TITLE>
<meta name="copyright" content="SuperAsp">
<meta name="keywords" content="sos, suporte online, suporteonline, superasp, suporte, online">
<meta name="robots" content="ALL">
<style type="text/css">
<!--
.campo_alerta
{
font-family: Tahoma, Verdana, Arial;
font-size: 11px;
border: 1px solid black;
background-color: #ffff99;
}
.texto_pagina
{
font-family: Tahoma, Verdana, Arial;
font-size: 11px;
color: dimgray;
}

.tabela_formulario
{
width: 200;
background-color: whitesmoke;
}

.titulo_campos
{
font-family: Tahoma, Verdana, Arial;
font-size: 11px;
color: dimgray;
background-color: whitesmoke;
}

.campos_formulario
{
font-family: Tahoma, Verdana, Arial;
font-size: 11px;
color: dimgray;
background-color: gainsboro;
border: 1px inset;
}

.botao_enviar
{
font-family: Tahoma, Verdana, Arial;
font-size: 11px;
color: white;
background-color: gray;
}
-->
</style>
</HEAD>
<body bgcolor="whitesmoke" topmargin="5" leftmargin="5" rightmargin="5" bottommargin="5" class=texto_pagina>
<img src="imagens/login.gif" align="left">

<B>Efetuar Login</B><BR>
<BR>Informe abaixo seu login e senha para ter<br>
acesso as p&aacute;ginas protegidas do sistema:<BR>
<form name="form_incluir" method="post" action="<%=Request.ServerVariables("SCRIPT_NAME")%>">
<INPUT type=hidden name=recordno value="<%=Request.Form("recordno")%>">
<INPUT type=hidden name=strQ value="<%=Request.Form("strQ")%>">
  <TABLE border=0 cellpadding=2 cellspacing=1 class=tabela_formulario>
    <TR class=titulo_campos>
      <TD>Login<br>
        <INPUT type="text" name="login" maxlength="50" class=campos_formulario>
      </TD>
    </TR>
    <TR class=titulo_campos>
      <TD>Senha<br>
        <INPUT type="password" name="senha" maxlength="10" class=campos_formulario>
      </TD>
    </TR>
  </TABLE>
  <input name="enviar" type="submit" value="Enviar">
</form>
</BODY>
</HTML>

<%
End If
%>