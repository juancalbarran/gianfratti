<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="db.asp"-->
<!--#include file="mysConfiguracoes.asp"-->
<%

	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	Session.LCID = 1046
	
strStatus = OK(Request.QueryString("status"))
	
If strStatus = "TimeOut" AND Session("mysConversaID") <> "" Then
	Call AbreDB
	strSQL = "UPDATE conversas SET status = False WHERE id = " & Session("mysConversaID")
	Conexao.Execute(strSQL)
	Call FechaDB
End If


'***** incluida sub sendmail CDO sys por JuvendsJ

Sub SendMail(strFrom, strTo, strSubject, strMessage)
  Dim cdoConfig
  Dim objMail
  


sch = "http://schemas.microsoft.com/AspEmail/configuration/" 
Set AspEmailConfig = Server.CreateObject("AspEmail.Configuration") 
cdoConfig.Fields.Item(sch & "sendusing") = 2 
cdoConfig.Fields.Item(sch & "smtpserver") = "localhost" 
cdoConfig.fields.update 
 
  Set objMail = Server.CreateObject("Persits.MailSender")
 
  With objMail
   Set .Configuration = AspEmailConfig
   .From = strFrom
   .To = strTo
   
   .Subject = strSubject 

.HTMLBody = strMessage

   .Send
  End With
End Sub

' Final da sub para envio html


  Dim acao, nome, ddd, fone, email, cidade, uf, pergunta, assunto, recado, mensagem, Mail, corpo
  
  acao = Request("acao")
  nome = Request("nome")
  ddd = Request("ddd")
  fone = Request("fone")
  email = Request("email")
  cidade = Request("cidade")
  uf = Request("uf")
  pergunta = Request("pergunta")
  assunto = Trim(Replace(Request.Form("assunto"),"'","''"))
  recado = Trim(Replace(Request.Form("recado"),"'","''"))
  
  If Request("acao") <> "" Then
  
'*** Enviar para o Administrador

        corpo = "<html><body bgcolor='#F4F4F4' text='#333333' link='#6699CC' vlink='#6699CC' alink='#6699CC'>"
	corpo = corpo & "<font face='Arial, Helvetica, sans-serif' size='-1' color='#003366'><b>Visitante:</b> " & nome & "<font face='Arial, Helvetica, sans-serif' size='-1' color='#003366'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>E-mail:</b> " & email & "</font><br>"
	corpo = corpo & "<font face='Arial, Helvetica, sans-serif' size='-1' color='#003366'><b>Fone:</b> (" & ddd & ") " & fone & "<font face='Arial, Helvetica, sans-serif' size='-1' color='#003366'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Cidade:</b> " & cidade & "<font face='Arial, Helvetica, sans-serif' size='-1' color='#003366'>/<b>Estado:</b> " & uf & "</font><br><br>"
	corpo = corpo & "<font face='Arial, Helvetica, sans-serif' size='-1' color='#336699'><b>Pergunta:</b> Como você chegou até nós?</font><br>"
	corpo = corpo & "<font face='Arial, Helvetica, sans-serif' size='-1' color='#336699'><b>Resposta:</b> " & pergunta & "</font><br><br>"
	corpo = corpo & "<font face='Arial, Helvetica, sans-serif' size='-1' color='#CC6633'><b>Assunto:</b> " & assunto & "</font><br><br>"
	corpo = corpo & "<font face='Arial, Helvetica, sans-serif' size='-1' color='#CC6633'><b>Mensagem:</b><br> " & recado & "</font><br><br><br>"

'*** Escreve o nome do seu site no local indicado abaixo

Subject = " Nome do Seu site - Atendimento On-line!"

'*** Escreve o seu e-mail no local indicado 

Call SendMail(nome & " <" & email & ">", "Seu E-mail aqui", subject, corpo)



'*** Escreve na linha abaixo no local indicado o nome do seu site

  	mensagem = "Sua mensagem foi enviada com sucesso.<br>Estaremos entrando em contato o mais breve possível.<br><br><b> Escreve o nome do  seu site, Agradece!</b><br><br>"
End If


%>
<html>
<head>
<title><%=strConfigNome%></title>
<style>
a:link	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:visited	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:hover	{font-size:8pt; font-family: Tahoma, Verdana; color:F4B511; TEXT-DECORATION: none;}
body	{ font-family: Tahoma, Verdana; font-size: 8pt; color: <%=strConfigFonte%>; }
td		{ font-family: Tahoma, Verdana; font-size: 8pt; color: <%=strConfigFonte%>; }
..campo{				
		font-family: Arial, Verdana; 
		font-size: 11px; 
		background-color: #FFFFFF;	
		border-left: 1px solid #68A4C8; 
		border-right: 1px solid #B8D0D8; 
		border-top: 1px solid #68A4C8; 
		border-bottom: 1px solid #B8D0D8;
		}
				
..botao 	{
			background-color: #E8E8E8; 
			color: black; 
			border-color: #FFFFFF; 
			border-width: 1px; 
			font-family: Tahoma, Verdana; 
			font-size: 8pt;
		}
</style>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<script language=JavaScript>
<!--
function Aviso(campo, nome) {
  alert("Preencha corretamente o campo: " + nome + "!");
  campo.focus();
}

function Valida() {
  nome = document.faleconosco.nome.value;
  email = document.faleconosco.email.value;
  ddd = document.faleconosco.ddd.value;
  fone = document.faleconosco.fone.value;
  cidade = document.faleconosco.cidade.value;
  uf = document.faleconosco.uf.value;
  pergunta = document.faleconosco.pergunta.value;
  assunto = document.faleconosco.assunto.value;
  recado = document.faleconosco.recado.value;
  
  
  if (nome == "") {
    Aviso(document.faleconosco.nome, "Nome");
	return;
  }
  if (cidade == "") {
    Aviso(document.faleconosco.cidade, "Cidade");
	return;
  }
  if (uf == "") {
    Aviso(document.faleconosco.uf, "Estado");
	return;
  }
  if (email == "") {
    Aviso(document.faleconosco.email, "E-mail");
	return;
  }
  pos1 = email.indexOf("@");
  pos2 = email.indexOf(".");
  if (pos1 <= 0 || pos2 < 1) {
    Aviso(document.faleconosco.email, "E-mail");
    return;
  }
  if (pergunta == "") {
    Aviso(document.faleconosco.pergunta, "Pergunta");
	return;
  }
  if (assunto == "") {
    Aviso(document.faleconosco.assunto, "Assunto");
	return;
  }
  if (recado == "") {
    Aviso(document.faleconosco.recado, "Mensagem");
	return;
  }
  document.faleconosco.submit();
}
//-->
</script>
</head>
<body bgcolor="#F4f4f4" topmargin=0 marginwidth="0" marginheight="0" leftmargin="1">
<table cellspacing=0 cellpadding=0 width="98%" align=center 
      border=0><tr><td align=center width="90%" valign="top"><div align="LEFT"><img src="<%=strConfigLogo%>" alt="" border="0"></div></td></tr> 
<tbody> <tr> <td align=center width="90%" valign="top"> <% If mensagem = "" Then %><form id=faleconosco name=faleconosco onSubmit="Valida(); return false;" action="mysChatOff.asp" method=post> 
<table width="430" border="0" cellspacing="0" cellpadding="0" bgcolor="#e8e8e8" align="CENTER"><tr><td><table width="100%" border="0" cellspacing="1" cellpadding="0"><tr><td bgcolor="#FFFFFF"><table cellspacing=0 cellpadding=2 border=0 width="100%"><tr valign=center><td align=right colspan="5"><div align="CENTER"><font size="2"><b>No 
momento nosso suporte está indisponível...</b></font><br>Deixe uma mensagem, em 
breve um de nossos atendentes entrará em contato.<br> Utilize o formulário abaixo 
para deixar sua mensagem.</div></td></tr><tr valign=center><td align=right colspan="5"><img alt="" border="0" width="1" height="3"></td></tr> 
<tbody> <tr valign=center> <td align=right width="45"><font color="#666666"><font color="#993333">*</font>&nbsp;Nome:</font></td><td align=left width="163"> 
<div align=left> <font color="#666666"><input id=nome class="campo"
                                onBlur="if (this.value == '') this.value='';" 
                                onFocus="if (this.value == '') this.value = '';" 
                                tabindex=1 size=30 name=nome> </font></div></td><td align=right width="3"><font color="#666666">&nbsp;</font></td><td align=right width="47"><font color="#666666">Fone:</font></td><td align=left width="150"> 
<font color="#666666"><input id=ddd class="campo"
                                onBlur="if (this.value == '') this.value='';" 
                                onFocus="if (this.value == '') this.value = '';" 
                                tabindex=2 maxlength=2 size=1 name=ddd> - <input class="campo"
                                id=fone 
                                onBlur="if (this.value == '') this.value='';" 
                                onFocus="if (this.value == '') this.value = '';" 
                                tabindex=3 maxlength=9 size=12 name=fone> </font></td></tr> 
<tr valign=center> <td align=right width="45"><font color="#666666"><font color="#993333">*</font>&nbsp;E-mail:</font></td><td align=left width="163"> 
<div align=left> <font color="#666666"><input id=email class="campo"
                                onBlur="if (this.value == '') this.value='';" 
                                onFocus="if (this.value == '') this.value = '';" 
                                tabindex=4 size=30 name=email> </font></div></td><td align=right width="3"><font color="#666666">&nbsp;</font></td><td align=right width="47"><font color="#666666"><font color="#993333">*</font>&nbsp;Cidade:</font></td><td align=left width="150"> 
<font color="#666666"><input id=cidade class="campo"
                                onBlur="if (this.value == '') this.value='';" 
                                onFocus="if (this.value == '') this.value = '';" 
                                tabindex=5 size=10 name=cidade> - <select class="campo"
                                onBlur="if (this.value == '') this.value='';" 
                                onFocus="if (this.value == '') this.value = '';" 
                                tabindex=6 name=uf> <option value="" selected></option> 
<option value="AC">AC</option> <option value="AL">AL</option> <option value="AM">AM</option> 
<option value="AP">AP</option> <option value="BA">BA</option> <option value="CE">CE</option> 
<option value="DF">DF</option> <option value="ES">ES</option> <option value="GO">GO</option> 
<option value="MA">MA</option> <option value="MG">MG</option> <option value="MS">MS</option> 
<option value="MT">MT</option> <option value="PA">PA</option> <option value="PB">PB</option> 
<option value="PE">PE</option> <option value="PI">PI</option> <option value="PR">PR</option> 
<option value="RJ">RJ</option> <option value="RN">RN</option> <option value="RO">RO</option> 
<option value="RR">RR</option> <option value="RS">RS</option> <option value="SC">SC</option> 
<option value="SE">SE</option> <option value="SP">SP</option> <option value="TO">TO</option> 
</select> </font></td></tr><tr valign=center><td align=right colspan="5"><img alt="" border="0" width="1" height="2"></td></tr> 
<tr valign=center align=center> <td colspan=5><font color="#666666" size="1">*Como 
você chegou até nós?</font> <font color="#666666" size="2"><select class="campo"
                                id=pergunta tabindex=7 name=pergunta> <option value="" selected></option> 
<option value="Atrav&eacute;s de um Amigo">Atrav&eacute;s de um Amigo</option> 
<option value="E-mail (Mala Direta)">E-mail (Mala Direta)</option> <option value="Site de Busca">Site 
de Busca</option> <option value="Escreve seu site aqui">Escreve seu site 
aqui</option> <option value="Outros">Outros</option> 
</select></font></td></tr> <tr valign=center align=middle> <td colspan=5><img alt="" border="0" width="1" height="2"></td></tr> 
<td colspan=5 height="15"><table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td width="20%"><font color="#666666"><font color="#993333"> 
&nbsp;*</font>Assunto:</font></td><td width="80%"><font face="Arial, Helvetica, sans-serif" size="2" color="#666666"><b><font face="Verdana, Arial, Helvetica, sans-serif"> 
<input id=assunto class="campo"
                                onBlur="if (this.value == '') this.value='';" 
                                onFocus="if (this.value == '') this.value = '';" 
                                tabindex=8 size=50 name=assunto></font></b></font></td></tr></table></td></tr> 
<tr valign=center align=middle> <td colspan=5><img alt="" border="0" width="1" height="2"></td></tr> 
<tr valign=center align=center> <td colspan=5> <table cellspacing=0 cellpadding=0 border=0 width="100%"> 
<tbody> <tr> <td><font color="#666666"><font color="#993333">&nbsp;*</font>Mensagem:</font></td><td valign=top><font face="Arial, Helvetica, sans-serif" color="#666666" size="2"><b>&nbsp; 
<textarea class="campo" id=recado tabindex=9 name=recado rows=3 cols=51></textarea></b></font></td></tr> 
<tr> <td valign=center align=left colspan="2"> <div align=center></div><font color="#666666">* 
Campos de preenchimento obrigatório.</font></td></tr> <tr> <td valign=center align=left>&nbsp;</td><td valign=center align=center> 
<table cellspacing=0 cellpadding=0 border=0 width="241"> <tbody> <tr valign=center> 
<td><div align=right><font color="#666666"><input id=enviar class="botao" type=submit value="Enviar agora" name=enviar> 
&nbsp; </font></div></td><td><div align=center><font color="#666666">&nbsp; <input id=limpar class="botao" tabindex=11 type=reset value=Limpar name=limpar> 
</font></div></td><td> <font color="#666666"><input id=acao type=hidden value=enviar name=acao> 
</font></td></tr> </tbody> </table></td></tr> </tbody> </table></td></tr></TBODY> 
</table></td></tr></table></td></tr></table></form><p><% Else %> <font size="-1" face="Arial, Helvetica, sans-serif"><br> 
<br> <br> </font> </p><table border="0" cellspacing="0" cellpadding="0" bgcolor="#e8e8e8" align="center"> 
<tr> <td valign="top"> <table width="100%" border="0" cellspacing="1" cellpadding="0"><tr><td bgcolor="#FFFFFF"><table border="0" cellspacing="5" cellpadding="0"> 
<tr> <td> <div align="left"><font color="#FFCC66" size="2" face="Arial, Helvetica, sans-serif"><b><font color="#333333" size="3">Nome 
do site </font><font color="#333333"> <i>[ Atendimento On-line! ]</i></font></b></font></div></td></tr> 
<tr> <td valign="top" align="center">&nbsp;</td></tr> <tr> <td valign="top" align="center"><font face="Arial, Helvetica, sans-serif" size="3" color="#333333"> 
<%= mensagem%></font> </td></tr> </table></td></tr></table></td></tr> </table><p><font size="-1" face="Arial, Helvetica, sans-serif"><br> 
</font> <% End If %><font face="Arial, Helvetica, sans-serif" color=#ffffff size=2></font></p></td></tr><tr>
  <td align=center width="90%" valign="top" height="20"><font size="1">Powered&nbsp;by&nbsp;radio-h<a href="http://www.radio-h.com" target="_blank"></a>&nbsp;-&nbsp;Alguns 
direitos reservados. </font></td>
</tr></TBODY></table>
</body></html>