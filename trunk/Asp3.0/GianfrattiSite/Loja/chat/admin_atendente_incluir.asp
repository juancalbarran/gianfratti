<%
'Nome da página de consulta
pagina_consulta = "admin_atendente_consultar.asp"

'Nome da página de alteração
pagina_alteracao = "admin_atendente_alterar.asp"

'Nome da página de inclusão
pagina_inclusao = "admin_atendente_incluir.asp"
'*******************************************************************
If Session("SOS_admin") = "" And Session("SOS_ipadmin") <> Request.ServerVariables("REMOTE_ADDR") Then
  Response.Write "<script language='javascript'>window.open('admin_login.asp','_top')</script>"
Else
%>

<HTML>
<HEAD>
<TITLE>Incluir Registro</TITLE>
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
background-color: white;
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
<script language="JavaScript" type="text/javascript">
<!--
function abre_janela(width, height, nome) {
var top; var left;
top = ( (screen.height/2) - (height/2) )
left = ( (screen.width/2) - (width/2) )
window.open('',nome,'width='+width+',height='+height+',scrollbars=no,toolbar=no,location=no,status=no,menubar=no,resizable=no,left='+left+',top='+top);
}
function recebe_imagem(campo, imagem){
var foto = 'img_' + campo
document.form_incluir[campo].value = imagem;
document.form_incluir[foto].src = imagem;
}
function verifica_form(form) {
var passed = false;
var ok = false
var campo
for (i = 0; i < form.length; i++) {
  campo = form[i].name;
  if (form[i].df_verificar == "sim") {
    if (form[i].type == "text"  | form[i].type == "textarea" | form[i].type == "select-one") {
      if (form[i].value == "" | form[i].value == "http://") {
		form[campo].className='campo_alerta'
        form[campo].focus();
        alert("Preencha corretamente o campo");
        return passed;
        stop;
      }
    }
    else if (form[i].type == "radio") {
      for (x = 0; x < form[campo].length; x++) {
        ok = false;
        if (form[campo][x].checked) {
          ok = true;
          break;
        }
      }
      if (ok == false) {
        form[campo][0].focus();
		form[campo][0].select();
        alert("Informe uma das opcões");
        return passed;
        stop;
      }
    }
    var msg = ""
    if (form[campo].df_validar == "cpf") msg = checa_cpf(form[campo].value);
    if (form[campo].df_validar == "cnpj") msg = checa_cnpj(form[campo].value);
    if (form[campo].df_validar == "cpf_cnpj") {
	  msg = checa_cpf(form[campo].value);
	  if (msg != "") msg = checa_cnpj(form[campo].value);
	}
    if (form[campo].df_validar == "email") msg = checa_email(form[campo].value);
    if (form[campo].df_validar == "numerico") msg = checa_numerico(form[campo].value);
    if (msg != "") {
	  if (form[campo].df_validar == "cpf_cnpj") msg = "informe corretamente o número do CPF ou CNPJ";
	  form[campo].className='campo_alerta'
      form[campo].focus();
      form[campo].select();
      alert(msg);
      return passed;
      stop;
    }
  }
}
passed = true;
return passed;
}
function desabilita_cor(campo) {
campo.className='campos_formulario'
}
function checa_numerico(String) {
var mensagem = "Este campo aceita somente números"
var msg = "";
if (isNaN(String)) msg = mensagem;
return msg;
}
function checa_email(campo) {
var mensagem = "Informe corretamente o email"
var msg = "";
var email = campo.match(/(\w+)@(.+)\.(\w+)$/);
if (email == null){
  msg = mensagem;
  }
return msg;
}
function checa_cpf(CPF) {
var mensagem = "informe corretamente o número do CPF"
var msg = "";
if (CPF.length != 11 || CPF == "00000000000" || CPF == "11111111111" ||
  CPF == "22222222222" ||	CPF == "33333333333" || CPF == "44444444444" ||
  CPF == "55555555555" || CPF == "66666666666" || CPF == "77777777777" ||
  CPF == "88888888888" || CPF == "99999999999")
msg = mensagem;
soma = 0;
for (y=0; y < 9; y ++)
soma += parseInt(CPF.charAt(y)) * (10 - y);
resto = 11 - (soma % 11);
if (resto == 10 || resto == 11)resto = 0;
if (resto != parseInt(CPF.charAt(9)))
  msg = mensagem; soma = 0;
for (y = 0; y < 10; y ++)
  soma += parseInt(CPF.charAt(y)) * (11 - y);
resto = 11 - (soma % 11);
if (resto == 10 || resto == 11) resto = 0;
if (resto != parseInt(CPF.charAt(10)))
  msg = mensagem;
return msg;
}
function checa_cnpj(s) {
var mensagem = "informe corretamente o número do CNPJ"
var msg = "";
var y;
var c = s.substr(0,12);
var dv = s.substr(12,2);
var d1 = 0;
for (y = 0; y < 12; y++)
{
d1 += c.charAt(11-y)*(2+(y % 8));
}
if (d1 == 0) msg = mensagem;
d1 = 11 - (d1 % 11);
if (d1 > 9) d1 = 0;
if (dv.charAt(0) != d1)msg = mensagem;
d1 *= 2;
for (y = 0; y < 12; y++)
{
d1 += c.charAt(11-y)*(2+((y+1) % 8));
}
d1 = 11 - (d1 % 11);
if (d1 > 9) d1 = 0;
if (dv.charAt(1) != d1) msg = mensagem;
return msg;
}
function mascara_data(data){ 
var mydata = ''; 
mydata = mydata + data; 
if (mydata.length == 2){ 
mydata = mydata + '/'; 
} 
if (mydata.length == 5){ 
mydata = mydata + '/'; 
} 
return mydata; 
} 
function verifica_data(data) { 
if (data.value != "") {
dia = (data.value.substring(0,2));
mes = (data.value.substring(3,5)); 
ano = (data.value.substring(6,10)); 
situacao = ""; 
if ((dia < 01)||(dia < 01 || dia > 30) && (  mes == 04 || mes == 06 || mes == 09 || mes == 11 ) || dia > 31) { 
situacao = "falsa"; 
} 
if (mes < 01 || mes > 12 ) { 
situacao = "falsa"; 
}
if (mes == 2 && ( dia < 01 || dia > 29 || ( dia > 28 && (parseInt(ano / 4) != ano / 4)))) { 
situacao = "falsa"; 
} 
if (situacao == "falsa") { 
data.focus();
data.select();
alert("Data inválida!"); 
}
} 
}
//-->
</script>
</HEAD>
<body bgcolor="white" leftmargin="20" topmargin="20" bottommargin="20" rightmargin="20" class=texto_pagina>
<a href="<%=pagina_consulta%>" class="texto_pagina"><img src="imagens/bt_consultaratendentes.gif" border="0" align="absmiddle"></a>
| <a href="<%=pagina_inclusao%>" class="texto_pagina"><img src="imagens/bt_incluiratendente.gif" border="0" align="absmiddle"></a>
<hr size=1 color=gainsboro>
<br>

</a> 
<%
If Not IsEmpty(Request.Form) Then
  Set objCon = Server.CreateObject("ADODB.Connection")
  objCon.Open Application("SOS_conexao")

  campo_duplicado = false
  campo_msg = ""
  Set objRS_duplic = Server.CreateObject("ADODB.Recordset")
  objRS_duplic.CursorLocation = 3
  objRS_duplic.CursorType = 0
  objRS_duplic.LockType = 3
  strQ_duplic = "SELECT atendente FROM atendentes Where atendente Like '" & Trim(Request.Form("atendente")) & "'"
  objRS_duplic.Open strQ_duplic, objCon, , , &H0001
  If Not objRS_duplic.EOF Then
    If Trim(campo_msg) = "" Then
      campo_msg = "Nome do atendente"
      valor_msg = Trim(Request.Form("atendente"))
    End If
    campo_duplicado = true
  End If
  objRS_duplic.Close
  Set objRS_duplic = Nothing
  Set strQ_duplic = Nothing

  If campo_duplicado = false Then
    Set objRS= Server.CreateObject("ADODB.Recordset")
    objRS.CursorLocation = 3
    objRS.CursorType = 0
    objRS.LockType = 3
    strQ = "SELECT * FROM atendentes Where 1 <> 1"
    objRS.Open strQ, objCon, , , &H0001
    objRS.Addnew()
    If objRS.Fields("atendente").properties("IsAutoIncrement") = False Then
      objRS("atendente") = Trim(Request.Form("atendente"))
    End If
    If objRS.Fields("senha").properties("IsAutoIncrement") = False Then
      objRS("senha") = Trim(Request.Form("senha"))
    End If
    If objRS.Fields("email").properties("IsAutoIncrement") = False Then
      objRS("email") = Trim(Request.Form("email"))
    End If
    If objRS.Fields("id_departamento").properties("IsAutoIncrement") = False Then
      objRS("id_departamento") = Trim(Request.Form("id_departamento"))
    End If
    If objRS.Fields("msg_entrada").properties("IsAutoIncrement") = False Then
      objRS("msg_entrada") = Trim(Request.Form("msg_entrada"))
    End If
    If objRS.Fields("foto").properties("IsAutoIncrement") = False Then
      objRS("foto") = Trim(Request.Form("foto"))
    End If
    If objRS.Fields("total_usuarios").properties("IsAutoIncrement") = False Then
      objRS("total_usuarios") = Trim(Request.Form("total_usuarios"))
    End If
    objRS.Update
    objRS.Close
    Set objRS = Nothing
%>
<B><font color="#CC0000">Cadastro efetuado</font></B><BR>
O atendente foi adicionado com sucesso.<BR>
<BR>
<%
  Else
%>
<B><font color="#CC0000">Atenção!</font></B><BR>
<BR>
    O campo <%=campo_msg%> <i>"<%=valor_msg%>"</i> não pode ser salvo, pois já está cadastrado na tabela.
    <BR><A href="javascript:history.go(-1)">Clique aqui</a> para voltar ao cadastro</A><BR><BR>
<%
  End If

  objCon.Close
  Set objCon = Nothing
Else
  Set objCon = Server.CreateObject("ADODB.Connection")
  objCon.Open Application("SOS_conexao")

  Set objRS= Server.CreateObject("ADODB.Recordset")
  objRS.CursorLocation = 2
  objRS.CursorType = 0
  objRS.LockType = 3
  strQ = "SELECT * FROM atendentes Where 1 <> 1"
  objRS.Open strQ, objCon, , , &H0001
%>
<B><font color="#CC0000">Incluir Atendente</font></B><BR>
Preencha corretamente os dados do atendente abaixo:<BR>
<form name="form_incluir" method="post" action="<%=Request.ServerVariables("SCRIPT_NAME")%>" onsubmit="return verifica_form(this);">
<TABLE border=0 cellpadding=2 cellspacing=1 class=tabela_formulario>
  <TR class=titulo_campos><TD>Nome do atendente<br>
<%If objRS.Fields("atendente").properties("IsAutoIncrement") = False Then%>
<INPUT style="width=350" type="text" name="atendente" maxlength="255" value="" onKeyPress="desabilita_cor(this)" class=campos_formulario df_verificar="sim">
<%
Else
  Response.Write "<B>(Automático)</B>"
End If
%>
  </TD></TR>
  <TR class=titulo_campos><TD>Senha<br>
<%If objRS.Fields("senha").properties("IsAutoIncrement") = False Then%>
<INPUT style="width=350" type="password" name="senha" maxlength="10" value="" onKeyPress="desabilita_cor(this)"  df_verificar="sim" class=campos_formulario>
<%
Else
  Response.Write "<B>(Automático)</B>"
End If
%>
  </TD></TR>
  <TR class=titulo_campos><TD>Email<br>
<%If objRS.Fields("email").properties("IsAutoIncrement") = False Then%>
<INPUT style="width=350" type="text" name="email" maxlength="255" value="" onKeyPress="desabilita_cor(this)"  df_verificar="sim" df_validar="email" class=campos_formulario>
<%
Else
  Response.Write "<B>(Automático)</B>"
End If
%>
  </TD></TR>
  <TR class=titulo_campos><TD>Departamento<BR>
    <SELECT style="width=350" name="id_departamento" df_verificar="sim" onChange="desabilita_cor(this)" class=campos_formulario>
      <OPTION value=""></OPTION>

<%
  Set objRS2 = Server.CreateObject("ADODB.Recordset")
  objRS2.CursorLocation = 3
  objRS2.CursorType = 3
  objRS2.LockType = 1
  strQ = "SELECT id, departamento FROM departamentos ORDER BY id ASC"
  objRS2.Open strQ, objCon, , , &H0001
  If Not objRS2.EOF Then
    While Not objRS2.EOF
	  If Trim(objRS2.Fields.Item("id").Value) <> "" Then
	    Response.Write "      <OPTION value='" & (objRS2.Fields.Item("id").Value) & "'>" & (objRS2.Fields.Item("departamento").Value) & "</OPTION>"
	  End If
      objRS2.MoveNext
    Wend
  End If
  Response.Write("ok")
%>

    </SELECT>
  </TD></TR>
  <TR class=titulo_campos><TD>Mensagem inicial do atendimento<br>
<%If objRS.Fields("msg_entrada").properties("IsAutoIncrement") = False Then%>
<INPUT style="width=350" type="text" name="msg_entrada" maxlength="255" value="Olá <usuario>, em que posso lhe ajudar?" onKeyPress="desabilita_cor(this)"  df_verificar="sim" class=campos_formulario>
<%
Else
  Response.Write "<B>(Automático)</B>"
End If
%>
  </TD></TR>
  <TR class=titulo_campos><TD>Foto<br>
    <INPUT type="hidden" name="foto" value="imagens/noimage.gif" df_verificar="sim">
    <DIV id="Layer1" style="width: 1px; height:1px; visibility: visible; border:1px solid black"><img name="img_foto" src="imagens/noimage.gif" border="0"></DIV>
    &#8250;&nbsp;<a href="upload_fotos_atendentes.asp?campo=<%=Server.URLEncode("foto")%>&pasta=<%=Server.URLEncode("atendentes")%>" onClick="abre_janela(250, 300, 'alterar_imagem')" target="alterar_imagem" class="texto_pagina">Enviar Imagem</a>
  </TD></TR>
  <TR class=titulo_campos><TD>Nº máximo de usuários atendidos simultaneamente<br>
<%If objRS.Fields("total_usuarios").properties("IsAutoIncrement") = False Then%>
<INPUT style="width=350" type="text" name="total_usuarios" maxlength="255" value="3" onKeyPress="desabilita_cor(this)"  df_verificar="sim" class=campos_formulario>
<%
Else
  Response.Write "<B>(Automático)</B>"
End If
%>
  </TD></TR>
</TABLE>
<input type="submit" name="submit" value="Enviar" class=botao_enviar>
</form>

<%
  objCon.Close
  Set objCon = Nothing
End If
%>

</BODY>
</HTML>

<%
End If
%>