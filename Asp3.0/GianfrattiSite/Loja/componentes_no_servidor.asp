<%
'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
'Tabela de Componentes disponíveis no seu servidor web
'Parte integrante da VirtuaStore Open 3.0
'Colaboração: Elizeu Alcantara - elizeu@onda.com.br / elizeu@cristaosite.com.br
'Colaboração: Henrique Metasupri - henrique@metasupri.com.br
'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
%>
<!--#include file="config.asp"-->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title><%= Nome_da_sua_loja %> - Verificando componentes instalados no servidor</title>
</head>

<body>

<p align="center"><font face="tahoma" size="2" color="#000080"><strong>Informa&ccedil;&otilde;es 
  do Servidor do site <%= Nome_da_sua_loja %><br><br>Verificando Componentes instalados no seu Servidor...<br><br></strong></font><font face="tahoma" size="1" color="gray"><br><br>
  Disponível Somente para Servidores Web Windows</font> <br><br>
<%
inicio = Timer
%>
<table width="818" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr bgcolor="#FFFFFF"> 
    <td valign="TOP" width="454"><font face="Verdana, Arial, Helvetica, sans-serif" size="1"><small>Nome 
      do Servidor: <font color="#0000FF"> 
      <% = Request.ServerVariables("SERVER_NAME") %>
      </font><br>
      Nome do Script: <font color="#0000FF"> 
      <% = Request.ServerVariables("SCRIPT_NAME") %>
      </font><br>
      Protocolo do Servidor: <font color="#0000FF"> 
      <% = Request.ServerVariables("SERVER_PROTOCOL") %>
      </font><br>
      Pasta Local: <font color="#0000FF"> 
      <% = Request.ServerVariables("PATH_INFO") %>
      </font><br>
      Endereço do Físico: <font color="#0000FF"> 
      <% = Request.ServerVariables("PATH_TRANSLATED") %>
      </font><br>
      Referencia HTTP:// : <font color="#0000FF"> 
      <% = Request.ServerVariables("HTTP_REFERER") %>
      </font> </small> </font><font color="#0000FF" face="Verdana, Arial, Helvetica, sans-serif" size="1"><a href="http://<% = Request.ServerVariables("SERVER_NAME") %>" target="_blank"> 
      <% = Request.ServerVariables("SERVER_NAME") %>
      </a> </font></td>
    <td valign="TOP" width="364"> <font size="1" 4="4" face="Verdana, Arial, Helvetica, sans-serif">Informações 
      do Sistema</font> <font size="1" face="Verdana, Arial, Helvetica, sans-serif"><br>
      <small>Sistema</small>: <font color="#0000FF"> 
      <% = ScriptEngine %>
      </font><br>
      Versão: <font color="#0000FF"> 
      <%  =ScriptEngineMajorVersion() %>
      </font>.<font color="#0000FF"> 
      <% =ScriptEngineMinorVersion() %>
      </font><br>
      <small>Atualizado: </small> <small><font color="#0000FF"> 
      <% =ScriptEngineBuildVersion() %>
      </font><br>
      </small> </font> </td>
  </tr>
</table>
<br>
<br>
<%
'######### começa aki ######### 

Dim arrListaComponentes(48)
arrListaComponentes(0) = Array( "AB Mailer","ABMailer.Mailman" )
arrListaComponentes(1) = Array( "ABC Upload","ABCUpload4.XForm" )
arrListaComponentes(2) = Array( "ActiveFile","ActiveFile.Post" )
arrListaComponentes(3) = Array( "ADODB","ADODB.Connection" )
arrListaComponentes(4) = Array( "Adiscon SimpleMail","ADISCON.SimpleMail.1" )
arrListaComponentes(5) = Array( "ASP DNS", "AspDNS.Lookup" )
arrListaComponentes(6) = Array( "ASP HTTP","AspHTTP.Conn" )
arrListaComponentes(7) = Array( "ASP Image","AspImage.Image" )
arrListaComponentes(8) = Array( "ASP Mail","SMTPsvg.Mailer" )
arrListaComponentes(9) = Array( "ASP NNTP News", "AspNNTP.Conn" )
arrListaComponentes(10) = Array( "ASP POP 3", "POP3svg.Mailer" )
arrListaComponentes(11) = Array( "ASP Simple Upload","ASPSimpleUpload.Upload" )
arrListaComponentes(12) = Array( "ASP Smart Cache","aspSmartCache.SmartCache" )
arrListaComponentes(13) = Array( "ASP Smart Mail","aspSmartMail.SmartMail" )
arrListaComponentes(14) = Array( "ASP SmartUpload","aspSmartUpload.SmartUpload" )
arrListaComponentes(15) = Array( "ASP Tear","SOFTWING.ASPtear" )
arrListaComponentes(16) = Array( "ASP Thumbnailer","ASPThumbnailer.Thumbnail" )
arrListaComponentes(17) = Array( "ASP WhoIs","WhoIs2.WhoIs" )
arrListaComponentes(18) = Array( "ASPSoft NT Object","ASPSoft.NT" )
arrListaComponentes(19) = Array( "ASPSoft Upload","ASPSoft.Upload" )
arrListaComponentes(20) = Array( "CDO NTS","CDONTS.NewMail" )
arrListaComponentes(21) = Array( "Chestysoft Image","csImageFile.Manage" )
arrListaComponentes(22) = Array( "Chestysoft Upload","csASPUpload.Process" )
arrListaComponentes(23) = Array( "JMail Dimac","JMail.Message" )
arrListaComponentes(24) = Array( "DistinctSMTP","DistinctServerSmtp.SmtpCtrl" )
arrListaComponentes(25) = Array( "Dundas Mailer","Dundas.Mailer" )
arrListaComponentes(26) = Array( "Dundas Upload","Dundas.Upload.2" )
arrListaComponentes(27) = Array( "Dundas PieChartServer","Dundas.ChartServer.2")
arrListaComponentes(28) = Array( "Dundas 2D Chart", "Dundas.ChartServer2D.1")
arrListaComponentes(29) = Array( "Dundas 3D Chart", "Dundas.ChartServer")
arrListaComponentes(30) = Array( "Dynu Encrypt","Dynu.Encrypt" )
arrListaComponentes(31) = Array( "Dynu HTTP","Dynu.HTTP" )
arrListaComponentes(32) = Array( "Dynu Mail","Dynu.Email" )
arrListaComponentes(33) = Array( "Dynu Upload","Dynu.Upload" )
arrListaComponentes(34) = Array( "Dynu WhoIs","Dynu.Whois" )
arrListaComponentes(35) = Array( "Easy Mail","EasyMail.SMTP.5" )
arrListaComponentes(36) = Array( "File SystemObject","Scripting.FileSystemObject" )
arrListaComponentes(37) = Array( "Ticluse TeknologiHTTP","InteliSource.Online" )
arrListaComponentes(38) = Array( "Last Mod","LastMod.FileObj" )
arrListaComponentes(39) = Array( "Microsoft XML Engine","Microsoft.XMLDOM" )
arrListaComponentes(40) = Array( "Persits ASP JPEG","Persits.Jpeg" )
arrListaComponentes(41) = Array( "Persits ASPEmail","Persits.MailSender" )
arrListaComponentes(42) = Array( "Persits ASPEncrypt","Persits.CryptoManager" )
arrListaComponentes(43) = Array( "Persits File Upload","Persits.Upload.1" )
arrListaComponentes(44) = Array( "SMTP Mailer","SmtpMail.SmtpMail.1" )
arrListaComponentes(45) = Array( "Soft Artisans FileUpload","SoftArtisans.FileUp" )
arrListaComponentes(46) = Array( "Image Size", "ImgSize.Check" )
arrListaComponentes(47) = Array( "Microsoft XML HTTP", "Microsoft.XMLHTTP" )
arrListaComponentes(48) = Array( "AutoImageSize","UnitedBinary.AutoImageSize" )

' Rotina que verifica o componente do array é um objeto.
Function VerificaObjeto(pComponente)
Dim objComponente
On Error Resume Next
VerificaObjeto = False
Err.Clear
Set objComponente = Server.CreateObject(pComponente)
If Err = 0 Then VerificaObjeto = True
Set objComponente = Nothing
Err.Clear
End Function


'*** Verifica os instalados

Public Function VerificaComponentesInstalados()
Dim intCont, strTxt
Dim intIndex, strProv

intCont = 0
strTxt = "<table border='0' bgcolor='#eeeeee' bordercolor='#0066cc'  align='center' width='85%'>"
For intIndex = LBound(arrListaComponentes) To UBound(arrListaComponentes)
strProv = intIndex

If VerificaObjeto(arrListaComponentes(intIndex)(1)) Then
strTxt = strTxt & "<tr><td width='200' bgcolor=#ffffff><font face='verdana'size='1'>" & arrListaComponentes(intIndex)(0) & "</font></td>"
strTxt = strTxt & "<td width='200' bgcolor=#ffffff><font face='verdana'size='1'>" & arrListaComponentes(intIndex)(1) & "</font></td>"
strTxt = strTxt & "<td align=center bgcolor=#ffffff><b><font color='green' face='verdana' size='1'>OK</font></b></td>"
intCont = intCont + 1
End If
strTxt = strTxt & "</tr>"
Next
strTxt = strTxt & "</table><br><br><p align='center'><font face='tahoma' size='2' color=""#000080""><strong>" & intCont & " componentes instalados de "
strTxt = strTxt & "" & UBound(arrListaComponentes) & " verificados no provedor.</strong></font> </p><br>"
VerificaComponentesInstalados = strTxt
End Function



'*** Verifica os nao instalados

Public Function VerificaComponentesNaoInstalados()
Dim intCont, strTxtno
Dim intIndex, strProv

intCont = 0
strTxtno = "<table border='0' bgcolor='#eeeeee' bordercolor='#0066cc'  align='center' width='85%'>"
For intIndex = LBound(arrListaComponentes) To UBound(arrListaComponentes)
strProv = intIndex

If Not VerificaObjeto(arrListaComponentes(intIndex)(1)) Then
strTxtno = strTxtno & "<tr><td width='200' bgcolor=#ffffff><font face='verdana' size='1'>" & arrListaComponentes(intIndex)(0) & "</font></td>"
strTxtno = strTxtno & "<td width='200' bgcolor=#ffffff><font face='verdana' size='1'>" & arrListaComponentes(intIndex)(1) & "</font></td>"
strTxtno = strTxtno & "<td align=center bgcolor=#ffffff><font color='red' face='verdana' size='1'>Não Instalado</font></td>"
intCont = intCont + 1
End If
strTxtno = strTxtno & "</tr>"
Next
strTxtno = strTxtno & "</table>"
VerificaComponentesNaoInstalados = strTxtno
End Function

Response.Write VerificaComponentesInstalados
Response.Write VerificaComponentesNaoInstalados

%>
<br><br><center>
<font face="Arial"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><small>Tempo 
de Respota do Servidor Web:&nbsp;&nbsp;&nbsp;
</small><font color="#0000FF"><small> 
<%
'... uma seqüência de comandos para medir a velocidade
response.write "Processado em " & FormatNumber( Timer - inicio, 2 ) & " segundos"
%>
</small></font></font></font><br><br>