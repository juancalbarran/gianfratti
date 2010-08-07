<!--#include file="funcoes.asp"-->

<%
If Trim(Request("atendente")) = "" Then
  Response.Redirect "atendente_login.asp"
Else

  If  Trim(Request.QueryString("usuario")) <> "" And Trim(Request.QueryString("atendente")) <> "" Then
    If Request.QueryString("recusa") = "ok" Then
      remove_usuario Trim(Request.QueryString("usuario")), Trim(Request.QueryString("atendente"))
	Else
	  usuario = Trim(Request.QueryString("usuario"))
	  atendente = Trim(Request.QueryString("atendente"))
	
      Application.Lock()
	  
      SOS_usuario = Application("SOS_usuario")
      SOS_atendente = Application("SOS_atendente")
      SOS_assunto = Application("SOS_assunto")
      SOS_email = Application("SOS_email")
      SOS_ip = Application("SOS_ip")
      SOS_entrada = Application("SOS_entrada")
      SOS_ativo = Application("SOS_ativo")
      SOS_id = Application("SOS_id")
      SOS_controle = Application("SOS_controle")
      n = UBound(SOS_usuario)
      For i = 0 To n
        If Trim(SOS_atendente(i)) <> "" Then
          If Lcase(Trim(SOS_usuario(i))) = Lcase(usuario) And Int(SOS_atendente(i)) = Int(atendente) Then
	        SOS_ativo(i) = True
	        assunto = SOS_assunto(i)
	        email = SOS_email(i)
	        ip = SOS_ip(i)
	        entrada = SOS_entrada(i)

            'Cria historico para a conversa
            Set Conexao = Server.CreateObject("ADODB.Connection")
            Conexao.Open Application("SOS_conexao")
            ComandoSQL = " SELECT * FROM historico Where 1<>1"
            Set objRS_historico = Server.CreateObject("ADODB.Recordset")
            objRS_historico.CursorLocation = 3
            objRS_historico.CursorType = 1
            objRS_historico.LockType = 2
            objRS_historico.Open ComandoSQL, Conexao,,, &H0001
            objRS_historico.AddNew()
            objRS_historico("usuario") = usuario
            objRS_historico("atendente") = atendente
            objRS_historico("assunto") = assunto
            objRS_historico("email") = email
            objRS_historico("ip") = ip
            objRS_historico("entrada") = entrada

            strQ = "SELECT msg_entrada FROM atendentes WHERE id=" & atendente
            Set objRS_msg = Conexao.Execute(strQ)
	        msg_entrada = objRS_msg("msg_entrada")
	        Set objRS_msg = Nothing

            objRS_historico("conversa") = "<font color=""orangered""><b>&#8250; Atendente</b><br>" & Replace(msg_entrada,"<usuario>", usuario) & "</font><br><br>"
            objRS_historico.Update
            id_conversa = objRS_historico("id")
            objRS_historico.Close
            Conexao.Close

	        SOS_id(i) = id_conversa
            SOS_controle(i) = Now + ((1/24/60/60)*Application("SOS_tempo_expiracao"))

	        Exit For
	      End If
	    End If
      Next
      Application("SOS_ativo") = SOS_ativo
      Application("SOS_id") = SOS_id
      Application("SOS_controle") = SOS_controle
  
      Application.UnLock()

       janela = Time()
       janela = CStr(janela)
       janela = Lcase(janela)
       janela = Replace(janela,"pm","")
       janela = Replace(janela,"am","")
       janela = Replace(janela,":","")
       janela = Replace(janela," ","")
%>

<SCRIPT LANGUAGE="JavaScript">
<!--
function atende_usuario(url, janela){
  var top; var left; var width; var height
  width = 450; height = 400
  top = ( (screen.height/2) - (height/2) )
  left = ( (screen.width/2) - (width/2) )
  window.open(url,janela,'width='+width+',height='+height+',scrollbars=no,toolbar=no,location=no,status=no,menubar=no,resizable=no,left='+left+',top='+top);
  document.location.href="atendente_monitor.asp?atendente=<%=Request.QueryString("atendente")%>"
}
atende_usuario("atendente.asp?usuario=<%=Server.URLEncode(usuario)%>&atendente=<%=atendente%>&id_conversa=<%=id_conversa%>", "<%=janela%>")
//-->
</SCRIPT>


<%  
       Set janela = Nothing
	End If
  End If
%>

<html>
<head>
<title><%=Application("SOS_titulo")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.texto{
font-family: Tahoma, Arial;
font-size: 11px;
}
.titulos_monitor{
color: white;
background-color: gray;
font-weight: bold;
}
.usuarios_monitor{
color: black;
background-color: whitesmoke;
}
a{
color: #3E6497;
}
-->
</style>
</head>
<body topmargin="5" leftmargin="5" rightmargin="5" bottommargin="5">

<%
  Application.Lock()

  Dim atendente_online
  atendente_online = False

  SOS_atendentes = Application("SOS_atendentes")
  n = UBound(SOS_atendentes)
  For i = 0 To n
    If Int(SOS_atendentes(i)) = Int(Request("atendente")) Then atendente_online = True
  Next
  
  If atendente_online = False Then
    Response.write "<script language='javascript'>parent.document.location.href='monitor.asp'</script>"
    Set atendente_online = Nothing
	Stop
  End If
  Set atendente_online = Nothing

  SOS_usuario = Application("SOS_usuario")
  SOS_atendente = Application("SOS_atendente")
  SOS_ip = Application("SOS_ip")
  SOS_entrada = Application("SOS_entrada")
  SOS_ativo = Application("SOS_ativo")
  SOS_email = Application("SOS_email")
  SOS_assunto = Application("SOS_assunto")
  SOS_id = Application("SOS_id")
  SOS_controle = Application("SOS_controle")
  n = UBound(SOS_usuario)

  Response.Write "<table width=100% border=1 class=texto cellpadding=3 cellspacing=0 bordercolor=silver>"
  Response.Write "  <tr class=titulos_monitor>"
  Response.Write "    <td colspan=2>Atendimento</td>"
  Response.Write "    <td width=""33%"">Nome</td>"
  Response.Write "    <td width=""33%"">Email</td>"
  Response.Write "    <td width=""33%"">Assunto</td>"
  Response.Write "    <td>IP</td>"
  Response.Write "    <td>Solicitação</td>"
  Response.Write "  </tr>"
  x = 0
  For i = 0 To n
    If Trim(SOS_atendente(i)) <> "" Then
      If Int(SOS_atendente(i)) = Int(Request("atendente")) And SOS_ativo(i) = False And SOS_id(i) = 0 Then
	    x = x + 1
        Response.Write "<tr class=""usuarios_monitor"">"
        Response.Write "  <td><a href=""atendente_monitor.asp?usuario=" & SOS_usuario(i) & "&atendente=" & SOS_atendente(i) & """ onMouseOver=""clearTimeout(atualiza)"" onMouseOut=""atualiza = setTimeout('atualiza_pagina()',1000);"">Aceitar</a></td>"
        Response.Write "  <td><a href=""atendente_monitor.asp?usuario=" & SOS_usuario(i) & "&atendente=" & SOS_atendente(i) & "&recusa=ok"" onMouseOver=""clearTimeout(atualiza)"" onMouseOut=""atualiza = setTimeout('atualiza_pagina()',1000);"">Recusar</a></td>"
        Response.Write "  <td><b>&nbsp;" & SOS_usuario(i) & "</b>&nbsp;</td>"
        Response.Write "  <td nowrap>" & SOS_email(i) & "&nbsp;</td>"
        Response.Write "  <td nowrap>" & SOS_assunto(i) & "&nbsp;</td>"
        Response.Write "  <td nowrap>" & SOS_ip(i) & "&nbsp;</td>"
        Response.Write "  <td nowrap>" & SOS_entrada(i) & "&nbsp;</td>"
        Response.Write "</tr>"
        alerta = True
      End If
    End If
  Next

  If alerta = False Then
    Response.Write "<tr class=""usuarios_monitor"">"
    Response.Write "  <td colspan=7>&nbsp;&nbsp;&#8250;&nbsp;Nenhum usuário solicitando atendimento</td>"
    Response.Write "</tr>"
  End If

  Response.Write "</table>"

  If alerta = True Then
    If Application("SOS_som") = 1 Then Response.Write "<bgsound src=beep.au loop=4>"
    Response.Write "<script>parent.document.location.href='monitor.asp#" & x & "'</script>"
  Else
    Response.Write "<script>parent.document.location.href='monitor.asp#'</script>"
  End If

  Application.UnLock()

  Set n = Nothing
  Set i = Nothing
  Set x = Nothing
%>

<iframe src="status_atendente.asp?atendente=<%=Trim(Request("atendente"))%>" frameborder="0" style="width:1;height:1"></iframe>
<SCRIPT LANGUAGE="JavaScript">
<!--
parent.document.all.atendente.value="<%=Request.QueryString("atendente")%>";
function atualiza_pagina(){
  document.location.href="atendente_monitor.asp?atendente=<%=Request.QueryString("atendente")%>"
}
atualiza = setTimeout("atualiza_pagina()",7000);
//-->
</SCRIPT>

</body>
</html>

<%
End If
%>