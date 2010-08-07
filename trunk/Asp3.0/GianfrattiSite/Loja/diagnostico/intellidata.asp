<%@ Language=VBScript %>
<% 
'#########################################################
'#     Diagnóstico de Servidores - 10/03/2003
'#     Para enviar suas dúvidas, sugestões ou contratar os serviços da Intellidata.
'#     entre em contato através do e-mail:
'#     intellidata@intellidata.com.br
'#     Joel Scatolin Junior
'#     www.intellidata.com.br
'#	   Intellidata(c)2002-2003,Joel Scatolin Junior.http://www.intellidata.com.br
'#########################################################
%>
<% Response.Buffer = True 

public const ver="2.0"
Function GetScriptEngineInfo
  Dim s
  s = ""
  s = ScriptEngine & " Versão "
  s = s & ScriptEngineMajorVersion & "."
  s = s & ScriptEngineMinorVersion & "."
  s = s & ScriptEngineBuildVersion 
  GetScriptEngineInfo =  s
End Function

Function ShowDriveInfo(drvpath)
  Dim fso, d, s, t
  Set fso = CreateObject("Scripting.FileSystemObject")
  Set d = fso.GetDrive(fso.GetDriveName(fso.GetAbsolutePathName(drvpath)))
  Select Case d.DriveType
    Case 0: t = "Desconhecido"
    Case 1: t = "Removivel"
    Case 2: t = "Fixo"
    Case 3: t = "Rede"
    Case 4: t = "CD-ROM"
    Case 5: t = "Disco de RAM"
  End Select
  s = "Drive " & d.DriveLetter & ": - " & t & ", Vol: " & d.VolumeName & _
  ", SN: " & Hex(d.SerialNumber) & _
  ", " & d.FileSystem & ", Espaço livre: " & FormatNumber(d.FreeSpace/1024, 0) & " Kb " & _
  "Tamanho total: " & FormatNumber(d.TotalSize/1024, 0) & " Kbytes. "
  ShowDriveInfo = s
End Function

function CheckSO(str)
Dim so, ret, s
on error resume next  
Set so = CreateObject(str)
if err then 
ret= "<font color=black>Não encontrado</font>" '& "Erro:" & Err.Description
err.clear
else ret="<font color=blue>Encontrado e OK</font>"
s=trim(so.version)
if s<>"" and s<>"Não disponível" then ret=ret & ". Versão: " & s
'if err=0 then ret=ret & ". Versão: " & s
end if
so=nothing
CheckSO=ret
end function

'Functions
private sub sc
Response.Write " :: Componentes básicos</i></font><hr size=1 noshade><b>"

Response.Write "<table align= center cellspacing=1 cellpadding=4 border=0 bgColor=#000000>"
Response.Write "<tr><td bgColor=#aabde8 colspan=2><b>Servidor: " & Request.ServerVariables("SERVER_SOFTWARE")
Response.Write "<br>Script Engine: " & GetScriptEngineInfo & "</b>"
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>FileSystemObject</td><td>" & CheckSO("Scripting.FileSystemObject")
Response.Write "</td></tr><tr bgColor=#e0e0fe><td>ADODB.Connection</td><td>" & CheckSO("ADODB.Connection")
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>CDONTS.NewMail</td><td>" & CheckSO("CDONTS.NewMail")
Response.Write "</td></tr><tr bgColor=#e0e0fe><td>CDO.Message</td><td>" & CheckSO("CDO.Message")
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>MSWC.BrowserType</td><td>" & CheckSO("MSWC.BrowserType")
Response.Write "</td></tr><tr bgColor=#e0e0fe><td>MSWC.AdRotator</td><td>" & CheckSO("MSWC.AdRotator")
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>MSWC.NextLink</td><td>" & CheckSO("MSWC.NextLink")
Response.Write "</td></tr><tr bgColor=#e0e0fe><td>MSWC.ContentRotator</td><td>" & CheckSO("MSWC.ContentRotator")
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>MSWC.Counters</td><td>" & CheckSO("MSWC.Counters")
Response.Write "</td></tr><tr bgColor=#e0e0fe><td>MSWC.IISLog</td><td>" & CheckSO("MSWC.IISLog")
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>MSWC.MyInfo</td><td>" & CheckSO("MSWC.MyInfo")
Response.Write "</td></tr><tr bgColor=#e0e0fe><td>MSWC.PageCounter</td><td>" & CheckSO("MSWC.PageCounter")
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>MSWC.PermissionChecker</td><td>" & CheckSO("MSWC.PermissionChecker")
Response.Write "</td></tr><tr bgColor=#e0e0fe><td>MSWC.Status</td><td>" & CheckSO("MSWC.Status")
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>MSWC.Tools</td><td>" & CheckSO("MSWC.Tools")
Response.Write "</td></tr><tr bgColor=#e0e0fe><td>InetCtls (este componente normalmente é ausente)</td><td>" & CheckSO("InetCtls.Inet.1")
Response.Write "</td></tr><tr><td bgColor=#aabde8 colspan=2>" & _
"Todos os componentes acima são entregues com o IIS 5.0 no Windows 2000 e não requerem instalação adicional." & _
"</td></tr></table>"

end sub

private sub sa
Response.Write " :: Componentes mais conhecidos</i></font><hr size=1 noshade>"
Response.Write "<table align= center cellspacing=1 cellpadding=4 border=0 bgColor=#000000>"
Response.Write "<tr bgColor=#aabde8><td colspan=2><b>Enviando mensagens de e-mail</b>"
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>CDONTS.NewMail</td><td>" & CheckSO("CDONTS.NewMail")
Response.Write "</td></tr><tr bgColor=#e0e0fe><td>CDO.Message</td><td>" & CheckSO("CDO.Message")
Response.Write "</td></tr><tr bgColor=#f0f0fe><td><a href=http://www.serverobjects.com target=_new>AspMail / AspQMAil</a></td><td>" & CheckSO("SMTPsvg.Mailer")
Response.Write "</td></tr><tr bgColor=#e0e0fe><td><a href=http://www.aspemail.com target=_new>Persits AspEmail</a></td><td>" & CheckSO("Persits.MailSender")
Response.Write "</td></tr><tr bgColor=#f0f0fe><td><a href=http://www.aspsmart.com target=_new>AspSmartMail</a></td><td>" & CheckSO("aspSmartMail.SmartMail")
Response.Write "</td></tr><tr bgColor=#e0e0fe><td><a href=http://www.dimac.net target=_new>JMail</a></td><td>" & CheckSO("JMail.Message")

Response.Write "</td></tr><tr bgColor=#aabde8><td colspan=2><b>Upload de arquivos</b>"
Response.Write "</td></tr><tr bgColor=#e0e0fe><td><a href=http://www.asphelp.com target=_new>ASPSimpleUpload</a></td><td>" & CheckSO("ASPSimpleUpload.Upload")
Response.Write "</td></tr><tr bgColor=#f0f0fe><td><a href=http://www.aspupload.com target=_new>Persits AspUpload</a></td><td>" & CheckSO("Persits.Upload.1")
Response.Write "</td></tr><tr bgColor=#e0e0fe><td><a href=http://www.aspsmart.com target=_new>AspSmartUpload</a></td><td>" & CheckSO("aspSmartUpload.SmartUpload")
Response.Write "</td></tr><tr bgColor=#f0f0fe><td><a href=http://www.softartisans.com/ target=_new>SoftArtisans FileUpload</a></td><td>" & CheckSO("SoftArtisans.FileUp")
Response.Write "</td></tr><tr bgColor=#aabde8><td colspan=2><b>Trabalhando com imagens</b>"
Response.Write "</td></tr><tr bgColor=#e0e0fe><td><a href=http://www.aspupload.com target=_new>Persits AspJpeg</a></td><td>" & CheckSO("Persits.Jpeg")
Response.Write "</td></tr><tr bgColor=#f0f0fe><td><a href=http://www.aspsmart.com target=_new>AspSmartImage</a></td><td>" & CheckSO("aspSmartImage.SmartImage")
Response.Write "</td></tr><tr bgColor=#aabde8><td colspan=2><b>Miscelâneos</b>"
Response.Write "</td></tr><tr bgColor=#e0e0fe><td><a href=http://www.geocel.com/devmailer target=_new>Geocel DevMailer</a></td><td>" & CheckSO("Geocel.Mailer")
Response.Write "</td></tr><tr bgColor=#f0f0fe><td><a href=http://www.cyscape.com target=_new>BrowserHawk</a></td><td>" & CheckSO("cyScape.browserObj")
Response.Write "</td></tr><tr bgColor=#e0e0fe><td><a href=http://www.aspgrid.com target=_new>Persits AspGrid</a></td><td>" & CheckSO("Persits.Grid")
Response.Write "</td></tr><tr bgColor=#f0f0fe><td><a href=http://www.aspuser.com target=_new>Persits AspUser</a></td><td>" & CheckSO("Persits.AspUser")

'Componentes que estavam listados no arq componentes_no_servidor.asp

Response.Write "</td></tr><tr bgColor=#f0f0fe><td>AB Mailer</td><td>" & CheckSO("ABMailer.Mailman" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>ABC Upload</td><td>" & CheckSO("ABCUpload4.XForm" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>ActiveFile</td><td>" & CheckSO("ActiveFile.Post" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>ADODB</td><td>" & CheckSO("ADODB.Connection" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Adiscon SimpleMail</td><td>" & CheckSO("ADISCON.SimpleMail.1" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>ASP DNS</td><td>" & CheckSO("AspDNS.Lookup" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>ASP HTTP</td><td>" & CheckSO("AspHTTP.Conn" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>ASP Image</td><td>" & CheckSO("AspImage.Image" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>ASP Mail</td><td>" & CheckSO("SMTPsvg.Mailer" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>ASP NNTP News</td><td>" & CheckSO("AspNNTP.Conn" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>ASP POP 3</td><td>" & CheckSO("POP3svg.Mailer" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>ASP Simple Upload</td><td>" & CheckSO("ASPSimpleUpload.Upload" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>ASP Smart Cache</td><td>" & CheckSO("aspSmartCache.SmartCache" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>ASP Smart Mail</td><td>" & CheckSO("aspSmartMail.SmartMail" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>ASP Smart Upload</td><td>" & CheckSO("aspSmartUpload.SmartUpload" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>ASP Tear</td><td>" & CheckSO("SOFTWING.ASPtear" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>ASP Thumbnailer</td><td>" & CheckSO("ASPThumbnailer.Thumbnail" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>ASP WhoIs</td><td>" & CheckSO("WhoIs2.WhoIs" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>ASPSoft NT Object</td><td>" & CheckSO("ASPSoft.NT" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>ASPSoft Upload</td><td>" & CheckSO("ASPSoft.Upload" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>CDO NTS</td><td>" & CheckSO("CDONTS.NewMail" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Chestysoft Image</td><td>" & CheckSO("csImageFile.Manage" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Chestysoft Upload</td><td>" & CheckSO("csASPUpload.Process" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>JMail Dimac</td><td>" & CheckSO("JMail.Message" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Distinct SMTP</td><td>" & CheckSO("DistinctServerSmtp.SmtpCtrl" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Dundas Mailer</td><td>" & CheckSO("Dundas.Mailer" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Dundas Upload</td><td>" & CheckSO("Dundas.Upload.2" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Dundas PieChartServer</td><td>" & CheckSO("Dundas.ChartServer.2")
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Dundas 2D Chart</td><td>" & CheckSO("Dundas.ChartServer2D.1")
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Dundas 3D Chart</td><td>" & CheckSO("Dundas.ChartServer")
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Dynu Encrypt</td><td>" & CheckSO("Dynu.Encrypt" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Dynu HTTP</td><td>" & CheckSO("Dynu.HTTP" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Dynu Mail</td><td>" & CheckSO("Dynu.Email" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Dynu Upload</td><td>" & CheckSO("Dynu.Upload" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Dynu WhoIs</td><td>" & CheckSO("Dynu.Whois" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Easy Mail</td><td>" & CheckSO("EasyMail.SMTP.5" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>File System Object</td><td>" & CheckSO("Scripting.FileSystemObject" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Ticluse Teknologi HTTP</td><td>" & CheckSO("InteliSource.Online" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Last Mod</td><td>" & CheckSO("LastMod.FileObj" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Microsoft XML Engine</td><td>" & CheckSO("Microsoft.XMLDOM" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Persits ASP JPEG</td><td>" & CheckSO("Persits.Jpeg" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Persits ASPEmail</td><td>" & CheckSO("Persits.MailSender" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Persits ASPEncrypt</td><td>" & CheckSO("Persits.CryptoManager" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Persits File Upload</td><td>" & CheckSO("Persits.Upload.1" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>SMTP Mailer</td><td>" & CheckSO("SmtpMail.SmtpMail.1" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Soft Artisans File Upload</td><td>" & CheckSO("SoftArtisans.FileUp" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Image Size</td><td>" & CheckSO("ImgSize.Check" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>Microsoft XML HTTP</td><td>" & CheckSO("Microsoft.XMLHTTP" )
Response.Write "</td></tr><tr bgColor=#f0f0fe><td>AutoImageSize</td><td>" & CheckSO("UnitedBinary.AutoImageSize" )

Response.Write "</td></tr><tr bgColor=#aabde8><td colspan=2>" & _
"Todos os componentes acima são adicionais e não são entregues com o IIS 5.0 no Windows 2000<br>" & _
"</td></tr></table>"
end sub


function sa2()
Response.Write(" :: Componentes adicionais</i></font><hr size=1 noshade>")
Dim fso, myFile, data, i
data=""
on error resume next
Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set myFile = fso.OpenTextFile(Server.MapPath("./intellidata.dat"), 1, False)
if err then Response.Write("Erro abrindo arquivo: " & err.Description)
myFile.SkipLine
while myFile.AtEndOfStream <> True
data = split(mid(myFile.ReadLine,1,80),";",-1,1)
Response.Write "<br><b>Teste do <a href=" & data(0) & " target=_new>" & data(1) & "</a>: " & CheckSO(data(2)) & "</b>"
wend
myFile.Close
Set myFile = Nothing
Set fso = Nothing
Response.Write "<br><br>* Dica: Você pode descrever sua própria lista de componentes no arquivo <i>intellidata.dat</i><br>"
end function

private sub sf
Response.Write " :: Arquivos de sistema</i></font><hr size=1 noshade>"
Dim fso, t
Set fso = CreateObject("Scripting.FileSystemObject")
Set t = fso.GetSpecialFolder(0)
Response.Write "Pasta do Windows: " & t.path
Set t = fso.GetSpecialFolder(1)
Response.Write "<br>Pasta de sistema: " & t.path
Set t = fso.GetSpecialFolder(2)
Response.Write "<br>Pasta temporária: " & t.path
set t=nothing
set fso=nothing
Response.Write "<br>" & ShowDriveInfo("c:\")
Response.Write "<br>" & ShowDriveInfo("d:\")
end sub

private sub sv
Response.Write " :: Variáveis - http://" & Request.ServerVariables("SERVER_NAME") & ":" & Request.ServerVariables("SERVER_PORT")&"</i></font><hr size=1 noshade>"
Response.Write "Servidor: " & Request.ServerVariables("SERVER_SOFTWARE")
Response.Write "<br>Script Engine: " & GetScriptEngineInfo

Response.Write "<br>DATA LOCAL: " & Now
Response.Write "<br>USERAGENT: " & Request.ServerVariables("HTTP_USER_AGENT")
Response.Write "<br>REFERER: " & Request.ServerVariables("HTTP_REFERER")
Response.Write "<br>QUERYSTRING: " & Request.ServerVariables("QUERY_STRING")
Response.Write "<br>IDIOMA: " & Request.ServerVariables("HTTP_ACCEPT_LANGUAGE") & "<br>"
 dim userip
 userip=""
 userip="" & Request.ServerVariables("HTTP_X_FORWARDED_FOR")
 if userip="" then 
 userip="" & Request.ServerVariables("REMOTE_ADDR")
 else Response.Write "<br>Seu IP: " & userip
 end if
 Response.Write "<br>REMOTE_ADDR: " & Request.ServerVariables("REMOTE_ADDR")
 userip="" & Request.ServerVariables("HTTP_VIA")
 if userip<>"" then Response.Write "<br>Seu Proxy: " & userip
Response.Write "<br><br><a href=intellidata.asp?pg=6>Ver todas as variáveis do servidor</a><br>"
end sub

private sub sv2
Response.Write " :: Todas as variáveis</i></font><hr size=1 noshade>" & _
"<table align= center cellspacing=4 cellpadding=0><tr><td width=780>"
For each item in request.ServerVariables
 response.write "<br><b>" & item & "</b>: " & request.servervariables(item)
Next
Response.Write "</td></tr></table><br>" & _
"<div align=left><a href='javascript:history.back()'>voltar</a></div>"
end sub

private sub checkerr 
if err then
Response.Write("<br>Erro nº. " & CStr(Err.Number) & " " & Err.Description & " " & Err.Source)
err.clear
end if
end sub%>


<SCRIPT LANGUAGE="JScript" RUNAT=SERVER>
function TestJavaScript(str) {
   Response.Write(str);
}
</SCRIPT>

<%private sub s0%>
 :: Home</i></font><hr size=1 noshade>
<br>Teste do Server Side Inludes: <!--#include file="teste.inc"--> (Se você vê um espaço em branco antes desta frase o servidor não suporta SSI).
<% on error resume next
Response.Write "<br>Server Side VBScript está OK."
checkerr
TestJavaScript "<br>Server Side JavaScript está OK."
checkerr
Session("st01")="SST01"
if err or Session("st01")<>"SST01" then 
Response.Write "<br>ERRO: O servidor não suporta Sessions !"
else Response.Write "<br>Suporte à Sessions está OK."
end if
Response.Write  "<hr size=1 noshade><div align=absmiddle><b>Teste do .Net framework:</b>&nbsp;&nbsp;&nbsp;&nbsp;<img align=absmiddle src='teste.aspx?text=Suporte%20ASP.NET%20OK' alt='Se você não vê a imagem, o servidor não suporta aspx' width=280 height=28></div>" & _
"<hr size=1 noshade><b>Testar PHP no seu Servidor:</b><br>" & _
"<br>&#149; <a href=phpinfo.php target=_php1> Informações PHP</a> - Informações PHP completas precisam ser mostradas."
end sub%>

<HTML><HEAD>
<META NAME=keywords content="intellidata, asp, php, diagnostico, ferramentas">
<META NAME=description content="Intellidata - Web Design & Projetos - Diagnóstico de Servidores">
<META NAME=author content="Joel Scatolin Junior (c) 2003">
<style type="text/css">
<!-- 
BODY {
BACKGROUND-COLOR: #ffffff;
SCROLLBAR-FACE-COLOR:#d5d5b3;
SCROLLBAR-TRACK-COLOR:#E1E1E1
scrollbar-arrow-color: #E1E1E1;
}
TABLE {
FONT-SIZE: 10px; COLOR: #000000; FONT-FAMILY: Verdana
}
TD {
FONT-SIZE: 10px; COLOR: #000000; FONT-FAMILY: Verdana
}
.topmenu {	
 color: #000000;
 background: #F5F5F5;
 FONT-SIZE: 10px;
 text-decoration: none; }
.blue {
 color: #000000;
 background: #F5F5F5;
 font-size: 10px;
}
a:link       { color: #003366; TEXT-DECORATION: none;}
a:visited    { color: #003366; TEXT-DECORATION: none;}
a:hover      { color: #003366; TEXT-DECORATION: underline;}

-->
</style>
</HEAD><BODY text="#000000" bgcolor="#FFFFFF" leftMargin=0 topMargin=0 MarginHeight=0 MarginWidth=0
onload="status='Intellidata :: Concluido!';self.focus();return true;">
<title>Diagnóstico de Servidores</title>
<!--Menu Superior-->
<table align= "center" border=0 cellspacing=0 cellpadding=0 width=100% >
<tr><td class=blue nowrap>
<center><a class=blue href=http://www.intellidata.com.br>Excelente ferramenta para diagnosticar a capacidade ASP do seu ISP e "debugar" suas aplicações ASP.</a></center></td></tr>
<tr height=4 ><td><spacer type=block height=1 width=1></td></tr>
<tr><td><table align= "center" cellspacing=0 cellpadding=4 border=0 width=100%>
<tr width=100%><td class=topmenu nowrap width=100%>
<center><a class=topmenu onmouseover="status='Home';return true;" onmouseout="status='';return true;"
href="intellidata.asp?pg=0" title="Title Page">Home</a> |
<a class=topmenu onmouseover="status='';return true;" onmouseout="status='';return true;"
href="intellidata.asp?pg=1" title="Componentes comuns">Componentes comuns</a> |
<a class=topmenu onmouseover="status='';return true;" onmouseout="status='';return true;"
href="intellidata.asp?pg=2" title="Componentes mais conhecidos">Componentes mais conhecidos</a> |
<a class=topmenu onmouseover="status='';return true;" onmouseout="status='';return true;"
href="intellidata.asp?pg=3" title="Componentes definidos pelo usuário">Componentes definidos pelo usuário</a> |
<a class=topmenu onmouseover="status='';return true;" onmouseout="status='';return true;"
href="intellidata.asp?pg=4" title="Arquivos de sistema">Arquivos de sistema</a> |
<a class=topmenu onmouseover="status='';return true;" onmouseout="status='';return true;"
href="intellidata.asp?pg=5" title="Variáveis">Variáveis</a></center>
</td>
<td class=topmenu nowrap width=100%></td>
</tr></table>
<tr height=4 ><td><spacer type=block height=1 width=1></td></tr>
</td></tr></table>
<!--Final do Menu-->
<table align= center width=60% height=85% cellpadding=8 cellspacing=0 border=0 align=center><tr valign=middle><td>
<font face="Verdana" style="font-size: 15px" font color="#c0c0c0"><i><b>Diagnóstico de Servidores&nbsp;</b><sup><%=ver%></sup>

<% ' Copyright (c) Joel Scatolin Junior, 2002. http://www.intellidata.com.br
response.expires = -1 
response.addHeader "pragma","no-cache"
response.addHeader "cache-control","private"
on error resume next
pg=0
pg = cint(Request.QueryString("pg"))
'Response.Write "DBG PG="  & pg & "<br>"
select case pg
case 0: s0
case 1: sc
case 2: sa
case 3: sa2
case 4: sf
case 5: sv
case 6: sv2
case else Response.Write "page else: "  & pg
end select
if pg>4 then pg=-1
Response.Write("<hr size=1 noshade><div align=right><a href=intellidata.asp?pg=" & pg+1 & ">Próxima</a></div>")%>

</td></tr></table>
<table align= center cellspacing=0 cellpadding=4 border=0 width=100%>
<tr><td class=footer nowrap width="100%">
<CENTER>2001-2002&nbsp;<a class=footer href="http://www.intellidata.com.br" onmouseover="status='Intellidata - Web Design & Projetos';return true;" onmouseout="status='';return true;" 
title="Intellidata - Web Design & Projetos"><font face="Verdana" style="font-size: 10px">Intellidata</a>.&nbsp;Todos os direitos reservados.</td></tr></table>
</BODY></HTML>
