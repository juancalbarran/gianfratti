<%
usuario = Trim(Request.QueryString("usuario"))
atendente = Trim(Request.QueryString("atendente"))
id_conversa = Trim(Request.QueryString("id_conversa"))

If atendente <> "" Then
%>

<html>
<head>
<title><%=Application("SOS_titulo")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="STYLESHEET" type="text/css" href="estilos.css">
<style type="text/css">
<!--
.panel {
background-color: #EAEAEA;
border: 1px outset;
border-top: 0px solid;
height: 100%;
}
.tabOn {
border: 1px outset;
border-bottom: 0px solid;
text-align: center;
background-color: #EAEAEA;
cursor: default;
color: crimson;
height: 20px;
}
.tab {
border: 1px outset;
border-bottom: 1px solid silver;
text-align: center;
background-color: #CCCCCC;
color: dimgray;
height: 25px;
cursor: hand;
}
.space{
border-bottom: 1px solid silver;
width: 3px;
}
.texto {
font-family: Tahoma, Verdana, sans-serif;
font-size: 11px
}
-->
</style>
<script language="JavaScript">
function Verificar() 
{
var ctrl=window.event.ctrlKey;
var tecla=window.event.keyCode; 
if (tecla==116) {event.keyCode=0; event.returnValue=false;}
if (tecla==122) {event.keyCode=0; event.returnValue=false;}
}
//-->
</script>
<script language="JavaScript">
<!--
function verifica_form(form) {
var passed = true;
  if (form["mensagem"].value == ""){
  alert("Digite a mensagem para enviar")
  form["mensagem"].focus();
  passed = false
  }
return passed;
}function tabselect(n){
  for(x=1;x<=5;x++){
    tab=eval('document.all.tab' + x + ';');
	panel=eval('document.all.panel' + x + '.style;');
    if(x==n){
      tab.className='tabOn';
      panel.display='';
    }else {
      tab.className='tab';
	  panel.display='none';
    }
  }
}
//-->
</script>
</head>

<%
If Request.Form <> "" Then

  Dim Conexao, var_conversa, objRS_conversa, ComandoSQL

  Set Conexao = Server.CreateObject("ADODB.Connection")
  Conexao.Open Application("SOS_conexao")
  ComandoSQL = " SELECT id, conversa FROM historico Where id = " & id_conversa
  Set objRS_conversa = Server.CreateObject("ADODB.Recordset")
  objRS_conversa.CursorLocation = 3
  objRS_conversa.CursorType = 0
  objRS_conversa.LockType = 3
  objRS_conversa.Open ComandoSQL, Conexao,,, &H0001

  If Request.Form("mensagem") <> "" Then
    var_conversa = "<b><font color=orangered>&#8250; Atendente</b><br>"
    var_conversa = var_conversa & Replace(Request.Form("mensagem"), chr(13), "<BR>") & "</font><br><br>"
  ElseIf Request.Form("comando1") <> "" Then
    ComandoSQL = " SELECT * FROM Comandos Where id = " & Int(Request.Form("comando1"))
    Set objRS_comando = Server.CreateObject("ADODB.Recordset")
    objRS_comando.CursorLocation = 2
    objRS_comando.CursorType = 0
    objRS_comando.LockType = 1
    objRS_comando.Open ComandoSQL, Conexao,,, &H0001
    var_conversa = "<b><font color=orangered>&#8250; Atendente</b><br>"
    var_conversa = var_conversa & objRS_comando("valor") & "</font><br><br>"
	objRS_comando.Close
	Set objRS_comando = Nothing
  ElseIf Request.Form("comando2") <> "" Then
    ComandoSQL = " SELECT * FROM Comandos Where id = " & Int(Request.Form("comando2"))
    Set objRS_comando = Server.CreateObject("ADODB.Recordset")
    objRS_comando.CursorLocation = 2
    objRS_comando.CursorType = 0
    objRS_comando.LockType = 1
    objRS_comando.Open ComandoSQL, Conexao,,, &H0001
    var_conversa = var_conversa & "<img src='" & objRS_comando("valor") & "'><br><br>"
	objRS_comando.Close
	Set objRS_comando = Nothing
  ElseIf Request.Form("comando3") <> "" Then
    ComandoSQL = " SELECT * FROM Comandos Where id = " & Int(Request.Form("comando3"))
    Set objRS_comando = Server.CreateObject("ADODB.Recordset")
    objRS_comando.CursorLocation = 2
    objRS_comando.CursorType = 0
    objRS_comando.LockType = 1
    objRS_comando.Open ComandoSQL, Conexao,,, &H0001
    var_conversa = "<b><font color=orangered>&#8250; Atendente</b><br>"
    var_conversa = var_conversa & "<a href='" & objRS_comando("valor") & "' target='_blank'>" & objRS_comando("valor") & "</a></font><br><br>"
	objRS_comando.Close
	Set objRS_comando = Nothing
  ElseIf Request.Form("comando4") <> "" Then
    ComandoSQL = " SELECT * FROM Comandos Where id = " & Int(Request.Form("comando4"))
    Set objRS_comando = Server.CreateObject("ADODB.Recordset")
    objRS_comando.CursorLocation = 2
    objRS_comando.CursorType = 0
    objRS_comando.LockType = 1
    objRS_comando.Open ComandoSQL, Conexao,,, &H0001
	var_conversa = var_conversa & "<#tag#If trim(usuario) <> """" Then#tag#>"
    var_conversa = var_conversa & "<script language='javascript'>window.open('" & objRS_comando("valor") & "','_blank')</script>"
	var_conversa = var_conversa & "<#tag#End If#tag#>"
	var_conversa = Replace(var_conversa,"#tag#","%")
	objRS_comando.Close
	Set objRS_comando = Nothing
  End If


  objRS_conversa("conversa") = objRS_conversa("conversa") & var_conversa
  objRS_conversa.UpdateBatch
  objRS_conversa.Requery
  objRS_conversa.Close
  Conexao.Close

  Set ComandoSQL = Nothing
  Set objRS_conversa = Nothing
  Set var_conversa = Nothing
  Set Conexao = Nothing
  Response.Write "<script>parent.suporte.document.location.href=parent.suporte.document.location.href</script>"
End If
%>

<body onLoad="tabselect(1)" topmargin="5" bottommargin="5" leftmargin="5" rightmargin="5" class="msg" onKeyDown="Verificar()">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
  <tr>
    <td class="tab" width="75" id="tab1" onClick="javascript:tabselect(1);" nowrap><img src="imagens/tab_1.gif" style="cursor:hand" width="75" height="30" border="0"></td>
    <td class="space"></td>
    <td class="tab" width="75" id="tab2" onClick="javascript:tabselect(2);" nowrap><img src="imagens/tab_2.gif" style="cursor:hand" width="75" height="30" border="0"></td>
    <td class="space"></td>
    <td class="tab" width="75" id="tab3" onClick="javascript:tabselect(3);" nowrap><img src="imagens/tab_3.gif" style="cursor:hand" width="75" height="30" border="0"></td>
    <td class="space"></td>
    <td class="tab" width="75" id="tab4" onClick="javascript:tabselect(4);" nowrap><img src="imagens/tab_4.gif" style="cursor:hand" width="75" height="30" border="0"></td>
    <td class="space"></td>
    <td class="tab" width="75" id="tab5" onClick="javascript:tabselect(5);" nowrap><img src="imagens/tab_5.gif" style="cursor:hand" width="75" height="30" border="0"></td>
    <td class="space">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
  <form name="form1" id="form1" method="post" action="atendente_msg.asp?id_conversa=<%=id_conversa%>&usuario=<%=Server.URLEncode(usuario)%>&atendente=<%=Trim(atendente)%>" onsubmit='return verifica_form(this);'>
  <tr id="panel1" style="">
    <td class="panel" colspan="10">&nbsp;
      <textarea name="mensagem" class="texto" style="width:80%; height:40px"></textarea>
	  &nbsp;&nbsp;<input name="submit" type="submit" value="Enviar" class="texto">
	</td>
  </tr>
  </form>
  <form name="form2" method="post" action="atendente_msg.asp?id_conversa=<%=id_conversa%>&usuario=<%=Server.URLEncode(usuario)%>&atendente=<%=Trim(atendente)%>">
  <tr id="panel2"style="display:none">
    <td class="panel" colspan="12">&nbsp;&nbsp;Enviar mensagem predefinida<br>&nbsp;
      <select name="comando1" class="texto" style="width:80%" onChange="if(this.value!=''){form2.submit.disabled=false}else{form2.submit.disabled=true}">
	  <option value="">Escolha a mensagem</option>
	  <option value="">--------------------------------------------------</option>

<%
Dim objCon, objRS_consulta, StrQ
Set objCon = Server.CreateObject("ADODB.Connection")
objCon.Open Application("SOS_conexao")
Set objRS_consulta = Server.CreateObject("ADODB.Recordset")
objRS_consulta.CursorLocation = 2
objRS_consulta.CursorType = 0
objRS_consulta.LockType = 1

StrQ = "SELECT * FROM Comandos WHERE tipo = 1"
objRS_consulta.Open StrQ, objCon, , , &H0001
If Not objRS_consulta.EOF Then
  While Not objRS_consulta.EOF
    Response.Write "<option value='" & objRS_consulta("id") & "'>" & objRS_consulta("descricao")  & "</option>"
	objRS_consulta.MoveNext
  Wend
End If
objRS_consulta.Close
%>

	  </select>
	  &nbsp;&nbsp;<input name= "submit" type="submit" value="Enviar" class="texto" disabled>
	</td>
  </tr>
  </form>
  <form name="form3" method="post" action="atendente_msg.asp?id_conversa=<%=id_conversa%>&usuario=<%=Server.URLEncode(usuario)%>&atendente=<%=Trim(atendente)%>">
  <tr id="panel3" style="display:none">
    <td class="panel" colspan="12">&nbsp;&nbsp;Enviar imagem<br>&nbsp;
      <select name="comando2" class="texto" style="width:80%" onChange="if(this.value!=''){form3.submit.disabled=false}else{form3.submit.disabled=true}">
	  <option value="">Escolha a imagem</option>
	  <option value="">--------------------------------------------------</option>
<%
StrQ = "SELECT * FROM Comandos WHERE tipo = 2"
objRS_consulta.Open StrQ, objCon, , , &H0001
If Not objRS_consulta.EOF Then
  While Not objRS_consulta.EOF
    Response.Write "<option value='" & objRS_consulta("id") & "'>" & objRS_consulta("descricao")  & "</option>"
	objRS_consulta.MoveNext
  Wend
End If
objRS_consulta.Close
%>
	  </select>
	  &nbsp;&nbsp;<input name="submit" type="submit" value="Enviar" class="texto" disabled>
	</td>
  </tr>
  </form>
  <form name="form4" method="post" action="atendente_msg.asp?id_conversa=<%=id_conversa%>&usuario=<%=Server.URLEncode(usuario)%>&atendente=<%=Trim(atendente)%>">
  <tr id="panel4" style="display:none">
    <td class="panel" colspan="12">&nbsp;&nbsp;Enviar link<br>&nbsp;
      <select name="comando3" class="texto" style="width:80%" onChange="if(this.value!=''){form4.submit.disabled=false}else{form4.submit.disabled=true}">
	  <option value="">Escolha o link</option>
	  <option value="">--------------------------------------------------</option>
<%
StrQ = "SELECT * FROM Comandos WHERE tipo = 3"
objRS_consulta.Open StrQ, objCon, , , &H0001
If Not objRS_consulta.EOF Then
  While Not objRS_consulta.EOF
    Response.Write "<option value='" & objRS_consulta("id") & "'>" & objRS_consulta("descricao")  & "</option>"
	objRS_consulta.MoveNext
  Wend
End If
objRS_consulta.Close
%>
	  </select>
	  &nbsp;&nbsp;<input name="submit" type="submit" value="Enviar" class="texto" disabled>
	</td>
  </tr>
  </form>
  <form name="form5" method="post" action="atendente_msg.asp?id_conversa=<%=id_conversa%>&usuario=<%=Server.URLEncode(usuario)%>&atendente=<%=Trim(atendente)%>">
  <tr id="panel5" style="display:none">
    <td class="panel" colspan="12">&nbsp;&nbsp;Abrir uma janela para a url especificada<br>&nbsp;
      <select name="comando4" class="texto" style="width:80%" onChange="if(this.value!=''){form5.submit.disabled=false}else{form5.submit.disabled=true}">
	  <option value="">Escolha a janela</option>
	  <option value="">--------------------------------------------------</option>
<%
StrQ = "SELECT * FROM Comandos WHERE tipo = 4"
objRS_consulta.Open StrQ, objCon, , , &H0001
If Not objRS_consulta.EOF Then
  While Not objRS_consulta.EOF
    Response.Write "<option value='" & objRS_consulta("id") & "'>" & objRS_consulta("descricao")  & "</option>"
	objRS_consulta.MoveNext
  Wend
End If
objRS_consulta.Close

objCon.Close
Set objCon = Nothing
Set objRS_consulta = Nothing
Set StrQ = Nothing
%>
	  </select>
	  &nbsp;&nbsp;<input name="submit" type="submit" value="Enviar" class="texto" disabled>
	</td>
  </tr>
  </form>
</table>
<script language="JavaScript">document.form1.mensagem.focus();</script>
<iframe src="status_atendente.asp?atendente=<%=atendente%>" frameborder="0" style="width:1;height:100"></iframe>
</body>
</html>

<%
End If
Set usuario = Nothing
Set atendente = Nothing
Set id_conversa = Nothing
%>