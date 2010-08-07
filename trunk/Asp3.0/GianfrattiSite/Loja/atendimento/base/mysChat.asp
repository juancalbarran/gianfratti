<%
'MYSUPPORT - ALGUNS DIREITOS RESERVADOS
'http://www.mysupport.com.br
'
'TERMOS DE LICENÇA DESTE SISTEMA
'
'Você pode:
'
'- Copiar, distribuir, exibir e executar a obra;
'- Criar obras derivadas.
'
'Sob as seguintes condições:
'
'- Atribuição. Você deve dar crédito ao autor original.
'- Uso Não-Comercial. Você não pode utilizar esta obra com finalidades comerciais.
'- Compartilhamento pela mesma Licença. Se você alterar, transformar, ou criar outra obra com base nesta, você somente poderá distribuir a obra resultante sob uma licença idêntica a esta.
'
'Para cada novo uso ou distribuição, você deve deixar claro para outros os termos da licença desta obra.
'Qualquer uma destas condições podem ser renunciadas, desde que você obtenha permissão do autor.
'Qualquer direito de uso legítimo (ou "fair use") concedido por lei, ou qualquer outro direito protegido pela legislação local, não são em hipótese alguma afetados pelo disposto acima.
'
'Este é um sumário para leigos da Licença Jurídica (na íntegra).
'
'LICENSE
'
'You are free:
'
'to copy, distribute, display, and perform the work;
'to make derivative works.
'
'Under the following conditions:
'
'- Attribution. You must give the original author credit.
'- Noncommercial. You may not use this work for commercial purposes.
'- Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under a license identical to this one. 
'
'For any reuse or distribution, you must make clear to others the license terms of this work.
'Any of these conditions can be waived if you get permission from the copyright holder.
'Your fair use and other rights are in no way affected by the above.
'
'This is a human-readable summary of the Legal Code (the full license).
%>
<!--#include file="db.asp"-->
<!--#include file="mysConfiguracoes.asp"-->
<%
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	Session.LCID = 1033
	
	If Session("mysConversaID") = "" Then
		Response.Write "<script>window.close();</script>"
		Response.End
	Else
		Call AbreDB
		strSQL = "SELECT op.nome as NomeOP, op.imgFoto, dp.nome as NomeDP "
		strSQL = strSQL & "FROM conversas, departamentos dp, operadores op "
		strSQL = strSQL & "WHERE conversas.departamentoID = dp.id "
		strSQL = strSQL & "AND conversas.operador = op.id "
		strSQL = strSQL & "AND conversas.id = " & Session("mysConversaID")
		'Response.Write strSQL
		'Response.End
		Set rs = Conexao.Execute(strSQL)
		strNomeOP = rs("NomeOP")
		strNomeDP = rs("NomeDP")
		strImgFoto= rs("imgFoto")
		rs.close
		Set rs = Nothing
		Call FechaDB
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
		document.all("chat").src="mysConversa.asp"
		}
}
function checkNewMsg(){
	img_check.src = "mysImg.asp"
	img_check.onload = checkImg;
	if (isOk)
		window.setTimeout("checkNewMsg();",refreshTime);
}

checkNewMsg();


var start ;
var timer_switch = 0 ;
var final_switch = "on" ;
var display_timer = "" ;
var current_switch_value = 'on' ;

var temp = setTimeout( "timer_cycle()", 1000 ) ;

function timer_cycle(){
var the_timer;
var minutes;
var seconds;
var inicio = new Date(<%=Year(now)%>,<%=Day(now)%>,<%=Month(now)%>,<%=Hour(now)%>,<%=Minute(now)%>,<%=Second(now)%>);

		if ( final_switch == "on" )
		{
			now = new Date() ;
			the_timer = new Date( now.getTime() - inicio ) ;
			minutes = the_timer.getMinutes() ;
			seconds = the_timer.getSeconds() ;
			if ( minutes <= 9 ) minutes = "0" + minutes ;
			if ( seconds <= 9 ) seconds = "0" + seconds ;

			display_timer = minutes + ":" + seconds ;
			tempo.innerHTML = display_timer ;

			if ( timer_switch && ( final_switch == "on" ) )
				var temp = setTimeout( "timer_cycle()", 1000 ) ;
		}
		else
		{
			if ( display_timer == "" )
				display_timer = '' ;
			tempo.innerHTML = display_timer ;
		}
	temp = setTimeout( "timer_cycle()", 1000 ) ;
	}
</script>
<script language="JavaScript">
function Sair(){
	var width = 450;
	var height = 350;
	var esquerda = (screen.width/2) - (width/2);
	var topo = (screen.height/2) - (height/2);
	window.open("mysChatSair.asp","mys","top="+topo+",left="+esquerda+",width="+width+",height="+height+",scrollbars=yes, menu=0,status=yes");
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
		imgKey.src = "mysImgTecla.asp?origem=us&modo=update&tecla=" + tecla;
		imgKey.onload = 1;
	}
}

var imgKeyPress = new Image ;

function checkTecla(){
var imgSize = 0;
	imgSize = imgKeyPress.height;
	if ( imgSize == 1 ){
		document.all('tecla').innerHTML = "Operador está digitando uma mensagem...";
		}
	else{
		document.all('tecla').innerHTML = "&nbsp;";
		}
}

function checkKeyPress(){
	imgKeyPress.src = "mysImgTecla.asp?origem=us&modo=verifica"
	imgKeyPress.onload = checkTecla;
	var xyz = setTimeout("checkKeyPress();",5000);
}
checkKeyPress();
</script>
<body topmargin="0" leftmargin="0" bottommargin="0" onunload="Sair();">
<form name="form" action="mysConversa.asp" target="chat" method="post" onSubmit="return validarForm();">
<table height="100%" width="100%" cellspacing="0">
	<tr bgcolor="<%=strConfigTopo%>">
		<td valign="top" width="50%" height="10%">
			<img src="<%=strConfigLogo%>" alt="" border="0">
		</td>
		<td valign="middle" align="right">
			<table border="0" cellspacing="0" width="100%">
			  <tr>
			    <td></td>
			    <td width="80%"><font size="1"><b>Atendente:&nbsp;</b><%=strNomeOP%></font></td>
			    <td rowspan="3">
				<%If strImgFoto = "" Then%>
				<img src="img/semfoto.gif" style="border: 1 solid <%=strConfigFonte%>">
				<%Else%>
				<img width="30" height="40" src="<%=strImgFoto%>" style="border: 1 solid <%=strConfigFonte%>">
				<%End If%>
				</td>
			  </tr>
			  <tr>
			    <td></td>
			    <td><font size="1"><b>Departamento:&nbsp;</b><%=strNomeDP%></font></td>
			  </tr>
			  <tr>
			    <td></td>
			    <td><font size="1"><b>Tempo:&nbsp;</b><span id="tempo">00:00</span></font>
				</td>
			  </tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2" height="75%" valign="top">
			<iframe src="mysConversa.asp" name="chat" id="chat" width="100%" height="100%" frameborder="0" style="border: 1 solid #DDDDDD"></iframe>
		</td>
	</tr>
	<tr bgcolor="<%=strConfigTopo%>">
		<td align="center" valign="middle" colspan="2">
			<br>
			Mensagem:&nbsp;
			<input onkeydown="keyChat();" type="text" name="mensagem" size="40" class="campo">
			&nbsp;
			<input type="submit" value=" Enviar " class="botao">
			<p style="margin-top: 2; margin-bottom: 3">
				<font size="1">
					<span id="tecla">&nbsp;</span>
				</font>
			</p>
		</td>
	</tr>
	<tr bgcolor="<%=strConfigTopo%>">
		<td valign="middle" colspan="2" align="center">
			<font size="1">
			
			</font>
		</td>
	</tr>
</table>
</form>
</body>
</html>
