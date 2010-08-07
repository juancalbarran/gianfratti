<%
'******************************************************************
'  Suporte Online SuperAsp 1.0 - SuperASP.com.br - Ano 2003
'  Autor: Fabiano Dias - fdmail@ibest.com.br
'******************************************************************
'
'       DIREITOS AUTORIAIS DO SUPORTE ONLINE SUPERASP
'
'  Você não pode revender este script, alugar, disponibilizar  para
'  download ou fazer qualquer outro tipo  de  redistribuição  sem a
'  nossa autorização.
'
'  Este código de programação usa uma técnica de criptografia,  que
'  identifica sua autoria, ou seja, alterar este código ou revender
'  o mesmo sem contatar o autor significa estar infrigindo todas as
'  leis de direitos autorais e intelectuais,  e como tal passivo de
'  todas as aplicações na forma da lei.
'
'******************************************************************
If Session("SOS_admin") = "" And Session("SOS_ipadmin") <> Request.ServerVariables("REMOTE_ADDR") Then
  Response.Write "<script language='javascript'>window.open('admin_login.asp','_top')</script>"
Else
%>

<HTML>
<HEAD>
<TITLE>Alterar Registro</TITLE>
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

<%
If Not IsEmpty(Request.Form("salvar")) Then
  Set objCon = Server.CreateObject("ADODB.Connection")
  objCon.Open Application("SOS_conexao")

  Set objRS = Server.CreateObject("ADODB.Recordset")
  objRS.CursorLocation = 3
  objRS.CursorType = 0
  objRS.LockType = 3
  strQ = " SELECT * FROM admin"
  objRS.Open strQ, objCon, , , &H0001
  objRS("admin") = Trim(Request.Form("login_atendimento"))
  objRS("senha") = Trim(Request.Form("senha_atendimento"))
  objRS.UpdateBatch
  objRS.Requery
  objRS.Close
  Set objRS = Nothing

  Set objRS = Server.CreateObject("ADODB.Recordset")
  objRS.CursorLocation = 3
  objRS.CursorType = 0
  objRS.LockType = 3
  strQ = "SELECT * FROM configuracoes"
  objRS.Open strQ, objCon, , , &H0001
  Application.Lock()
  objRS("titulo_atendimento") = Trim(Request.Form("titulo_atendimento"))
  Application("SOS_titulo") = Trim(Request.Form("titulo_atendimento"))
  objRS("url_atendimento") = Trim(Request.Form("url_atendimento"))
  Application("SOS_url") = Trim(Request.Form("url_atendimento"))
  objRS("email_atendimento") = Trim(Request.Form("email_atendimento"))
  Application("SOS_email_atendimento") = Trim(Request.Form("email_atendimento"))
  objRS("email_componente") = Trim(Request.Form("email_componente"))
  Application("SOS_componente") = Trim(Request.Form("email_componente"))
  objRS("email_servidor") = Trim(Request.Form("email_servidor"))
  Application("SOS_servidor") = Trim(Request.Form("email_servidor"))
  objRS("titulo_email") = Trim(Request.Form("titulo_email"))
  Application("SOS_titulo_email") = Trim(Request.Form("titulo_email"))
  objRS("titulo_janela") = Trim(Request.Form("titulo_janela"))
  Application("SOS_titulo_janela") = Trim(Request.Form("titulo_janela"))
  objRS("tempo_espera_cliente") = Trim(Request.Form("tempo_espera_cliente"))
  Application("SOS_tempo_espera") = Trim(Request.Form("tempo_espera_cliente"))
  If Request.Form("som") <> "" Then
    objRS("som") = 1
	Application("SOS_som") = 1
  Else
    objRS("som") = 0
	Application("SOS_som") = 0
  End If
  If Request.Form("foto") <> "" Then
    objRS("foto") = 1
	Application("SOS_foto") = 1
  Else
    objRS("foto") = 0
	Application("SOS_foto") = 0
  End If
  Application("SOS_tempo_expiracao") = Trim(objRS("tempo_espera_cliente"))
  Application.Unlock()
  objRS.UpdateBatch
  objRS.Close
  Set objRS = Nothing
  objCon.Close
  Set objCon = Nothing
%>

<B><font color="#CC0000">Configura&ccedil;&otilde;es atualizadas</font></B><BR>
Os dados de configura&ccedil;&atilde;o do sistema forma atualizados com sucesso.<BR>
<BR>

<%
Else
  Set objCon = Server.CreateObject("ADODB.Connection")
  objCon.Open Application("SOS_conexao")
  Set objRS = Server.CreateObject("ADODB.Recordset")
  objRS.CursorLocation = 2
  objRS.CursorType = 0
  objRS.LockType = 1
  strQ = " SELECT * FROM configuracoes"
  objRS.Open strQ, objCon, , , &H0001
%>

<B><font color="#CC0000">Configura&ccedil;&otilde;es do sistema</font></B><BR>
Informe corretamente os dados do sistema abaixo:<BR>
<form name="form_incluir" method="post" action="<%=Request.ServerVariables("SCRIPT_NAME")%>" onsubmit="return verifica_form(this);">
<INPUT type=hidden name=recordno value="<%=Request.Form("recordno")%>">
<INPUT type=hidden name=strQ value="<%=Request.Form("strQ")%>">
<INPUT type="hidden" name="indice" value="<%=indice%>">
  <TABLE border=0 cellpadding=4 cellspacing=0 class=tabela_formulario>
    <%
  Dim objRS_admin
  Set objRS_admin = Server.CreateObject("ADODB.Recordset")
  objRS_admin.CursorLocation = 2
  objRS_admin.CursorType = 0
  objRS_admin.LockType = 1
  strQ = " SELECT * FROM admin"
  objRS_admin.Open strQ, objCon, , , &H0001
%>
    <TR class=titulo_campos> 
      <TD><strong>Login</strong><br> <INPUT style="width=350" type="text" name="login_atendimento" maxlength="255" value="<%=(objRS_admin.Fields.Item("admin").Value)%>" onKeyPress="desabilita_cor(this)"  df_verificar="sim" class=campos_formulario> 
      </TD>
    </TR>
    <TR class=titulo_campos> 
      <TD><strong>Senha</strong><br> <INPUT style="width=350" type="password" name="senha_atendimento" maxlength="10" value="<%=(objRS_admin.Fields.Item("senha").Value)%>" onKeyPress="desabilita_cor(this)"  df_verificar="sim" class=campos_formulario> 
      </TD>
    </TR>
    <%
objRS_admin.Close
Set objRS_admin = Nothing
%>
    <TR class=titulo_campos> 
      <TD>Título do sistema<br> <INPUT style="width=350" type="text" name="titulo_atendimento" maxlength="255" value="<%=(objRS.Fields.Item("titulo_atendimento").Value)%>" onKeyPress="desabilita_cor(this)"  df_verificar="sim" class=campos_formulario> 
      </TD>
    </TR>
    <TR class=titulo_campos> 
      <TD>URL do sistema<br> <INPUT style="width=350" type="text" name="url_atendimento" maxlength="255" value="<%=(objRS.Fields.Item("url_atendimento").Value)%>" onKeyPress="desabilita_cor(this)"  df_verificar="sim" class=campos_formulario> 
      </TD>
    </TR>
    <TR class=titulo_campos> 
      <TD>Email do sistema<br> <INPUT style="width=350" type="text" name="email_atendimento" maxlength="255" value="<%=(objRS.Fields.Item("email_atendimento").Value)%>" onKeyPress="desabilita_cor(this)"  df_verificar="sim" class=campos_formulario> 
      </TD>
    </TR>
    <TR class=titulo_campos> 
      <TD>Servidor do email (SMPT)<br> <INPUT style="width=350" type="text" name="email_servidor" maxlength="255" value="<%=(objRS.Fields.Item("email_servidor").Value)%>" onKeyPress="desabilita_cor(this)"  df_verificar="sim" class=campos_formulario> 
      </TD>
    </TR>
    <TR class=titulo_campos> 
      <TD>Componete para envio de email<br> <select style="width=350" type="text" name="email_componente" class=campos_formulario>
          <option value="CDONTS" <%If objRS.Fields.Item("email_componente").Value = "CDONTS" Then Response.Write "selected"%>>CDONTS</option>
          <option value="AspMail" <%If objRS.Fields.Item("email_componente").Value = "AspMail" Then Response.Write "selected"%>>AspMail</option>
          <option value="AspEmail" <%If objRS.Fields.Item("email_componente").Value = "AspEmail" Then Response.Write "selected"%>>AspEmail</option>
          <option value="AspQmail" <%If objRS.Fields.Item("email_componente").Value = "AspQmail" Then Response.Write "selected"%>>AspQmail</option>
        </select> </TD>
    </TR>
    <TR class=titulo_campos> 
      <TD>Título do email enviado pelo sistema<br> <INPUT style="width=350" type="text" name="titulo_email" maxlength="255" value="<%=(objRS.Fields.Item("titulo_email").Value)%>" onKeyPress="desabilita_cor(this)"  df_verificar="sim" class=campos_formulario> 
      </TD>
    </TR>
    <TR class=titulo_campos> 
      <TD>Título da janela do usuário<br> <INPUT style="width=350" type="text" name="titulo_janela" maxlength="255" value="<%=(objRS.Fields.Item("titulo_janela").Value)%>" onKeyPress="desabilita_cor(this)"  df_verificar="sim" class=campos_formulario> 
      </TD>
    </TR>
    <TR class=titulo_campos> 
      <TD>Tempo de espera (segundos) do usuário quando solicitado atendimento<br> 
        <INPUT style="width=350" type="text" name="tempo_espera_cliente" maxlength="255" value="<%=(objRS.Fields.Item("tempo_espera_cliente").Value)%>" onKeyPress="desabilita_cor(this)"  df_verificar="sim" df_validar="numerico" class=campos_formulario> 
      </TD>
    </TR>
    <TR class=titulo_campos> 
      <TD> <input name="som" type="checkbox" <% if objRS.Fields.Item("som").Value = 1 then : Response.Write " checked" : End If %>>
        Emitir som quando solicitado atendimento </TD>
    </TR>
    <TR class=titulo_campos> 
      <TD> <input name="foto" type="checkbox" <% if objRS.Fields.Item("foto").Value = 1 then : Response.Write " checked" : End If %>>
        Exibir fotos dos atendente no atendimento </TD>
    </TR>
  </TABLE>
<input type="submit" name="salvar" value="Enviar" class=botao_enviar>
</form>

<%
End If
%>

</BODY>
</HTML>

<%
End If
%>