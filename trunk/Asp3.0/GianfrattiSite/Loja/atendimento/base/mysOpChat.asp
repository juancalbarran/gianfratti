<!--#include file="db.asp"-->
<%
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	Session.LCID = 1033
	
	intID		  =		OK(Request.QueryString("ID"))
	intOperadorID =		OK(Request.QueryString("OperadorID"))
	
	Call AbreDB
	
	strSQL = "SELECT nome FROM operadores WHERE id = " & intOperadorID
	Set rs = Conexao.Execute(strSQL)
	If NOT rs.EOF Then
		Session("mysOpNome") = rs("nome")
	End If
	
	strSQL = "SELECT operador FROM conversas WHERE status = True AND id = " & intID
	Set rs = Conexao.Execute(strSQL)
	If NOT rs.EOF Then
		If rs("operador") <> 0 Then
			Response.Write "<script>window.close();</script>"
			Response.End
		End If
	Else
		Response.Write "<script>window.close();</script>"
		Response.End
	End If
	
	strSQL = "SELECT conteudo FROM comandos, operadores WHERE comandos.id = operadores.msg_inicio AND operadores.id = "& intOperadorID
	
	Set rs = Conexao.Execute(strSQL)
	
	If rs.EOF Then
		strSQL = "UPDATE conversas SET operador = "& intOperadorID &" WHERE id = " & intID
	Else
		strUltMsg 		  = FormataData(now,"yyyy/mm/dd hh:nn:ss")
		
		strMensagem = "<font color=""#000000""><b>" & Session("mysOpNome") & "&nbsp;&raquo;&nbsp;</b>" & rs("conteudo") & "</font><br><br>"
		strMensagem = ReplaceTags(strMensagem)
		strSQL = "UPDATE conversas SET ult_msg = #"& strUltMsg &"#, texto = '" & strMensagem & "', operador = " & intOperadorID & " WHERE id = " & intID
	End If
	Conexao.Execute(strSQL)
	
	strSQL = "SELECT usuario, assunto, email, ip FROM conversas WHERE operador = " & intOperadorID & " AND id = " & intID
	Set rs = Conexao.Execute(strSQL)
	If NOT rs.EOF Then
		strUsuario	= rs("usuario")
		Session("mysCliente") = strUsuario
		strAssunto	= rs("assunto")
		strEmail	= rs("email")
		strIP		= rs("ip")
	End If
	rs.Close
	Call FechaDB
%>
<html>
<head>
<title> &#9658;&#9658;&#9658; MySupport - Atendimento Online</title>
<style>
a:link	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:visited	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:hover	{font-size:8pt; font-family: Tahoma, Verdana; color:F4B511; TEXT-DECORATION: none;}
body	{ font-family: Tahoma, Verdana; font-size: 8pt; }
td		{ font-family: Tahoma, Verdana; font-size: 8pt; }
.campo{				
		font-family: Arial, Verdana; 
		font-size: 11px; 
		background-color: #FFFFFF;	
		border-left: 1 solid #68A4C8; 
		border-right: 1 solid #B8D0D8; 
		border-top: 1 solid #68A4C8; 
		border-bottom: 1 solid #B8D0D8;
		}
				
.botao 	{
			background-color: #E8E8E8; 
			color: black; 
			border-color: #FFFFFF; 
			border-width: 1px; 
			font-family: Tahoma, Verdana; 
			font-size: 8pt;
		}
</style>
</head>
<script language="JavaScript">
function validarForm(){
	if(form.mensagem.value == '') {
		alert('Você deve preencher o campo mensagem!');
		form.mensagem.focus();
		return false;
	}
return true;
}

function getTime(){
  var date = new Date();
  return date.getTime();
 }
 	
var stTime    = getTime();
var img_check = new Image ;
var refreshTime = 5 * 1000;
var isOk = true;

function checkImg(){
	imgStatus = 0 ;
	imgStatus = img_check.height;
	if ( imgStatus == 1 ){
		document.all("chat").src="mysOpConversa.asp?ID=<%=intID%>"
		}
}
function checkNewMsg(){
	img_check.src = "mysOpImg.asp?OperadorID=<%=intOperadorID%>&ID=<%=intID%>&opcao=1"
	img_check.onload = checkImg;
	if (isOk)
		window.setTimeout("checkNewMsg();",refreshTime);
}

checkNewMsg();
</script>
<script language="JavaScript"> 
function Sair(){
window.open('mysOpChatSair.asp?OperadorID=<%=intOperadorID%>&ID=<%=intID%>','Saida','status=no,width=1,height=1,scrollbars=no');
window.close();
}

function keyChat(){
var imgKey = new Image ;
var tamanho = form.mensagem.value.length;
var tecla;
	if(tamanho<=3){
		if(tamanho<=1)
			{ tecla = "NAO"; }
		else
			{ tecla = "SIM"; }
		imgKey.src = "mysImgTecla.asp?ID=<%=intID%>&origem=op&modo=update&tecla=" + tecla;
		imgKey.onload = 1;
	}
}

var imgKeyPress = new Image ;

function checkTecla(){
var imgSize = 0;
	imgSize = imgKeyPress.height;
	if ( imgSize == 1 ){
		document.all('tecla').innerHTML = "&nbsp;Cliente está digitando uma mensagem...";
		}
	else{
		document.all('tecla').innerHTML = "&nbsp;";
		}
}

function checkKeyPress(){
	imgKeyPress.src = "mysImgTecla.asp?ID=<%=intID%>&origem=op&modo=verifica"
	imgKeyPress.onload = checkTecla;
	var xyz = setTimeout("checkKeyPress();",5000);
}
checkKeyPress();
</script>
<body topmargin="0" leftmargin="0" bottommargin="0" onUnload="Sair();">
<form name="form" action="mysOpConversa.asp?ID=<%=intID%>" target="chat" method="post" onSubmit="return validarForm();">
<table height="100%" width="100%" cellspacing="0">
	<tr bgcolor="F5F5F5">
		<td valign="top" width="50%" height="10%">
			<img src="img/mysupport.gif" alt="" border="0">
		</td>
		<td valign="top">
			<table width="80%" align="center"><tr><td>
			<font size="1">
			<b>Usuário:</b>&nbsp;<%=strUsuario%><br>
			<b>Assunto:</b>&nbsp;<%=strAssunto%><br>
			<b>Email:</b>&nbsp;<%=strEmail%><br>
			<b>IP:</b>&nbsp;<%=strIP%><br>
			</font>
			</td></tr></table>
		</td>
	</tr>
	<tr>
		<td colspan="2" height="75%" valign="top">
			<iframe src="mysOpConversa.asp?ID=<%=intID%>" name="chat" id="chat" width="100%" height="100%" frameborder="0" style="border: 1 solid #DDDDDD"></iframe>
		</td>
	</tr>
	<tr bgcolor="F5F5F5">
		<td align="center" valign="middle" colspan="2"><br>
			<table width="90%" align="center"><tr>
			<td height="20" align="right" width="20%">
			Mensagem:&nbsp;
			</td><td>
			<input onKeyDown="keyChat();" type="text" name="mensagem" size="40" class="campo">
			&nbsp;
			<input type="submit" value=" Enviar " class="botao">
			</td></tr></table>
			</form>
		</td>
	</tr>
	<tr bgcolor="F5F5F5">
		<td align="center" valign="middle" colspan="2">
			<form name="form2" action="mysOpConversa.asp?ID=<%=intID%>" target="chat" method="post">
			<table width="90%" align="center"><tr>
			<td height="20" align="right" width="20%">
			Comando:&nbsp;
			</td><td>
			<select class="campo" name="mensagem" size="1" style="width: 230px">
	<%
		Call AbreDB
		strSQL = "SELECT id, descricao, conteudo FROM comandos WHERE operador = " & intOperadorID & " ORDER BY descricao"
		Set rs = Conexao.Execute(strSQL)
		If NOT rs.EOF Then
			While Not rs.EOF
				Response.Write "<option value='"& rs("conteudo") &"'"
				Response.Write ">&nbsp;" & rs("descricao")
				rs.movenext
			Wend
		End If
		rs.Close
		Call FechaDB
	%>
			</select>
			&nbsp;
			<input type="submit" value=" Enviar " class="botao">
			<p style="margin-top: 2; margin-bottom: 3">
				<font size="1">
					<span id="tecla">&nbsp;</span>
				</font>
			</p>			
			</td></tr></table>
		</td>
	</tr>
	<tr bgcolor="F5F5F5">
		<td valign="top" colspan="2" align="center">
			<font size="1">

			</font>
		</td>
	</tr>
</table>
</form>
</body>
</html>
