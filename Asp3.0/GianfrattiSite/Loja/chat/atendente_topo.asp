<!--#include file="funcoes.asp"-->

<html>
<head>
<title><%=Application("titulo")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="copyright" content="SuperAsp">
<meta name="keywords" content="sos, suporte online, suporteonline, superasp, suporte, online">
<meta name="robots" content="ALL">
<script language="JavaScript">
function Verificar() 
{
var ctrl=window.event.ctrlKey;
var tecla=window.event.keyCode; 
if (tecla==116) {event.keyCode=0; event.returnValue=false;}
if (tecla==122) {event.keyCode=0; event.returnValue=false;}
}
var inicio = new Date() ;
var hora_entrada = inicio.getTime() ;;
function tempo_decorrido(){
now = new Date();
the_timer = new Date( now.getTime() - hora_entrada);
minutes = the_timer.getMinutes();
seconds = the_timer.getSeconds();
if ( minutes <= 9 ) minutes = "0" + minutes;
if ( seconds <= 9 ) seconds = "0" + seconds;
display_timer = minutes + ":" + seconds;
tempo.value = display_timer;
var temp = setTimeout( "tempo_decorrido()", 1000);
}
//-->
</script>
<link rel="STYLESHEET" type="text/css" href="estilos.css">
</head>
<BODY bgcolor="#EAEAEA" topMargin=5 leftMargin=0 rightMargin=0 bottomMargin=0 class='msg_topo' onKeyDown="Verificar()" style="color:dimgray">
<table borde=0 cellpadding=2 cellspacing=0 class=texto width="100%" height="100%">
  <tr>
    <td width="85" valign="top"><img src="imagens/SOS_logo.gif" align="absmiddle"></td>
    <td width="20">&nbsp;&nbsp;</td>
    <td valign="top">

<%
usuario = Trim(Request.QueryString("usuario"))
atendente = Trim(Request.QueryString("atendente"))
id_conversa = Trim(Request.QueryString("id_conversa"))

Application.Lock()

SOS_usuario = Application("SOS_usuario")
SOS_atendente = Application("SOS_atendente")
SOS_assunto = Application("SOS_assunto")
SOS_email = Application("SOS_email")

Application.UnLock()

n = UBound(SOS_usuario)
For i = 0 To n
  If Trim(SOS_atendente(i)) <> "" Then
    If Lcase(Trim(SOS_usuario(i))) = Lcase(usuario) And Int(SOS_atendente(i)) = Int(atendente) Then
	  assunto = SOS_assunto(i)
	  email = SOS_email(i)
      Exit For
    End If
  End If
Next


Response.Write "<font color='#3E6497'><b>" & Application("SOS_titulo") & "</b></font>"
Response.Write "<br>Usuário: <b>" & usuario & "</b>"
Response.Write "<br>Email: " & email & ""
Response.Write "<br>Assunto: " & assunto
%>

	</td>
    <td width="5%" nowrap valign="top">
    Tempo: <input type="text" name=tempo class=form style='color:dimgray;border:none;width:40;background-color=#EAEAEA;' readonly value="">
	<br><br>#ID:&nbsp;<b><%=id_conversa%></b>&nbsp;&nbsp;&nbsp;
	</td>
  </tr>
</table>
<script language="JavaScript">tempo_decorrido()</script>
</body>
</html>

<%
'Elimina variaveis da memoria
Set usuario = Nothing
Set assunto = Nothing
Set email = Nothing
Set i = Nothing
Set n = Nothing
Set id = Nothing
%>