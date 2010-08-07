<!--#include file="funcoes.asp"-->
<%
If Session("SOS_admin") = "" And Session("SOS_ipadmin") <> Request.ServerVariables("REMOTE_ADDR") Then
  Response.Write "<script language='javascript'>window.open('admin_login.asp','_top')</script>"
Else
%>

<html>
<head>
<title><%=Application("SOS_titulo")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="copyright" content="SuperAsp">
<meta name="keywords" content="sos, suporte online, suporteonline, superasp, suporte, online">
<meta name="robots" content="ALL">
<SCRIPT language="JavaScript">
<!--
function abre_popup(width, height, nome) {
  var top; var left;
  top = ( (screen.height/2) - (height/2) )
  left = ( (screen.width/2) - (width/2) )
  window.open('',nome,'width='+width+',height='+height+',scrollbars=no,toolbar=no,location=no,status=no,menubar=no,resizable=no,left='+left+',top='+top);
}
//-->
</SCRIPT>
<style type="text/css">
<!--
.texto{
font-family: Tahoma, Arial;
font-size: 11px;
}
-->
</style>
</head>
<body class="texto" bgcolor="white" leftmargin="20" topmargin="20" bottommargin="20" rightmargin="20">
<a href="<%=Request.ServerVariables("SCRIPT_NAME")%>"><img src="imagens/bt_atualizar.gif" width="129" height="25" border="0"></a> 
<hr size=1 color=gainsboro>

<%
Response.Write "<table width='100%' border=0 cellspacing=0 cellpadding=10 class=texto>"
Response.Write "  <tr><td width='70%' valign=top>"

Dim Conexao, var_conversa, objRS_departamentos, objRS_atendentes, ComandoSQL, atendentes_online, atendentes_offline

Set Conexao = Server.CreateObject("ADODB.Connection")
Conexao.Open Application("SOS_conexao")

ComandoSQL = " SELECT * FROM departamentos"
Set objRS_departamentos = Server.CreateObject("ADODB.Recordset")
objRS_departamentos.CursorLocation = 2
objRS_departamentos.CursorType = 0
objRS_departamentos.LockType = 1
objRS_departamentos.Open ComandoSQL, Conexao,,, &H0001

If Not objRS_departamentos.EOF Then
  Response.Write "<font color=dimgray><b>Status atual do atendimento</b><br>"
  Response.Write "Clique no nome do atendente para exibir maiores informações sobre o mesmo<br><br></font>"
  Response.Write "<TABLE border='1' width='100%' cellspacing='0' cellpadding='2' bordercolor=silver class=texto>"
  While Not objRS_departamentos.EOF
    Response.Write "<tr><td bgcolor='gray'>&nbsp;<font color='white'><b>" & Ucase(objRS_departamentos("departamento")) & "</b></font></td><tr><td bgcolor='whitesmoke' style='border-top:2px solid gainsboro'>"
    ComandoSQL = " SELECT * FROM atendentes WHERE id_departamento = " & objRS_departamentos("id")
    Set objRS_atendentes = Server.CreateObject("ADODB.Recordset")
    objRS_atendentes.CursorLocation = 2
    objRS_atendentes.CursorType = 0
    objRS_atendentes.LockType = 1
    objRS_atendentes.Open ComandoSQL, Conexao,,, &H0001
    If Not objRS_atendentes.EOF Then
	  Dim atendimentos, atendimentos_hoje, objRS_solicitacoes
      atendentes_online = ""
      atendentes_offline = ""
      Response.Write "<p style='margin-left: 15px; margin-top: 5px'>"
      While Not objRS_atendentes.EOF
	    ComandoSQL = "SELECT COUNT(atendente) AS total FROM historico WHERE atendente = " & objRS_atendentes("id")
		Set objRS_solicitacoes = Server.CreateObject("ADODB.Recordset")
		objRS_solicitacoes.CursorLocation = 2
		objRS_solicitacoes.CursorType = 0
		objRS_solicitacoes.LockType = 1
		objRS_solicitacoes.Open ComandoSQL, Conexao,,, &H0001
		atendimentos = objRS_solicitacoes("total")
		objRS_solicitacoes.Close
		If atendimentos = 0 Then
		  atendimentos = "Nenhum atendimento"
		Else
	      ComandoSQL = "SELECT COUNT(atendente) AS total FROM historico WHERE atendente = " & objRS_atendentes("id") & " And Day(entrada) Like '" & Day(Date) & "'"
		  objRS_solicitacoes.Open ComandoSQL, Conexao,,, &H0001
		  atendimentos_hoje = objRS_solicitacoes("total")
		  objRS_solicitacoes.Close
		  If atendimentos = 1 Then
		    atendimentos = atendimentos & " atendimento"
			If atendimentos_hoje > 0 Then
			  atendimentos = atendimentos & " (" & atendimentos_hoje & " hoje)"
			Else
			  atendimentos = atendimentos & " (Nenhum hoje)"
			End If
		  Else
		    atendimentos = atendimentos & " atendimentos"
			If atendimentos_hoje > 0 Then
			  atendimentos = atendimentos & " (" & atendimentos_hoje & " hoje)"
			Else
			  atendimentos = atendimentos & " (Nenhum hoje)"
			End If
		  End If
		End If
        If objRS_atendentes("status") = 1 Then
		  Dim x, total, usuarios, atendentes, status_atendimento, usuarios_online
		  Application.Lock()
		  usuarios_online = ""
		  If Not IsEmpty(Application("SOS_usuario")) Then
            If IsArray(Application("SOS_usuario")) Then
              total = 0
              usuarios = Application("SOS_usuario")
              atendentes = Application("SOS_atendente") 
              ativos = Application("SOS_ativo") 
              ids = Application("SOS_id") 
              n = UBound(usuarios)
              For i = 0 To n
                If atendentes(i) = "" & objRS_atendentes("id") And ativos(i) = True Then
                  total = total + 1
	              usuarios_online = usuarios_online & "&nbsp;<a href='admin_exibe_conversacao.asp?id=" & ids(i) & "' onclick=""abre_popup(600, 300, 'popup')"" target='popup'>"& usuarios(i) & "</a>&nbsp;|"
                End If
              Next
			  usuarios_online = usuarios_online & "++"
			  usuarios_online = Replace(usuarios_online,"|++","")
              If total > 0  Then
	            status_atendimento = "&nbsp;&nbsp;&nbsp;Atendendo: " & usuarios_online & "<br>"
              Else
	            status_atendimento = "&nbsp;&nbsp;&nbsp;O atendente está livre no momento<br>"
              End If
            End If
          End If
          Application.UnLock()
          Set x = Nothing
          Set total = Nothing
          Set usuarios = Nothing
          Set atendentes = Nothing
	      atendentes_online = atendentes_online & "<a href='admin_status_atendente.asp?id=" & objRS_atendentes("id") & "' style='text-decoration:none'>&nbsp;&nbsp;&nbsp;<font color='#3E6497'><b>" & objRS_atendentes("atendente") & "</b><br>&nbsp;&nbsp;&nbsp;" & atendimentos & "<br>" & status_atendimento & "</font></a><br>"
		  Set status_atendimento = Nothing
		  Set usuarios_online = Nothing
  	    Else
	      atendentes_offline = atendentes_offline & "<a href='admin_status_atendente.asp?id=" & objRS_atendentes("id") & "' style='text-decoration:none'>&nbsp;&nbsp;&nbsp;<font color='#3E6497'><b>" & objRS_atendentes("atendente") & "</b><br>&nbsp;&nbsp;&nbsp;" & atendimentos & "</font></a><br><br>"
	    End If
	    objRS_atendentes.MoveNext
      Wend
      Set objRS_solicitacoes = Nothing
	  Set atendimentos_hoje = Nothing
      If atendentes_online <> "" Then Response.Write "<font color='#009900'><b>Online</b></font><br>" & atendentes_online
      If atendentes_offline <> "" Then Response.Write "<font color='#CC0000'><b>Offline</b></font><br>" & atendentes_offline
      Response.Write "<br></p>"
    Else
      Response.Write "<p style='margin-left: 15px; margin-top: 5px'>"
      Response.Write "<font color='#3E6497'>Nenhum atendente cadastrado</font>"
      Response.Write "<br></p>"
    End If
    Response.Write "</td>"

    objRS_atendentes.Close
    objRS_departamentos.MoveNext
  Wend
  Response.Write "</table>"
Else
  Response.Write "<br><font color='#CC0000'><b>Nenhum departamento cadastrado</b></font>"
End If

objRS_departamentos.Close
Conexao.Close

Set atendentes_online = Nothing
Set atendentes_offline = Nothing
Set ComandoSQL = Nothing
Set objRS_departamentos = Nothing
Set objRS_atendentes = Nothing
Set var_conversa = Nothing
Set Conexao = Nothing
Response.Write "  </td><td width='30%' valign=top>"

%>
<!--#include file="admin_codigo_status.asp"-->
<%
Response.Write "  </td></tr>"
Response.Write "</table>"
%>
</body>
</html>

<%
End If
%>