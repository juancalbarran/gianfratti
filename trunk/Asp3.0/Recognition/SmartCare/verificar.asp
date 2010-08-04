<%@ LANGUAGE = VBScript %>
<% 'Copyright 2000 RG3 Internet do Brasil, www.rg3.com.br %>
<B>
<p align="center"><font face="Arial" 6"" size="4" color="#000080"> Sistema de
Reconhecimento de Servidores Web</font>
<FONT SIZE=""6"">
<p>RG3 Internet do Brasil</FONT></B><font face="Arial"><BR>
</font>
<font face="Arial"><FONT SIZE="2"><B>Versão 1.5</B><BR></font></font><font face="Arial" size="1"><b>Disponível
Somente para Servidores Web Windows</b></font></p>
<FONT SIZE="2"><HR>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="980"><TR><TD VALIGN="TOP" width="606" bgcolor="#CCCCCC"><font face="Arial"><B><small>Nome
      do Servidor: </small></B><small><font color="#0000FF"><% = Request.ServerVariables("SERVER_NAME") %></font><BR>
      </small><b><small>Nome do Script: </small></b><small><font color="#0000FF"><% = Request.ServerVariables("SCRIPT_NAME") %></font><BR>
      </small><B><small>Protocolo do Servidor: </small></B><small><font color="#0000FF"><% = Request.ServerVariables("SERVER_PROTOCOL") %></font><BR>
      </small><B><small>Pasta Local: </small></B><small><font color="#0000FF"><% = Request.ServerVariables("PATH_INFO") %></font><BR>
      </small><B><small>Endereço do Físico: </small></B><small><font color="#0000FF"><% = Request.ServerVariables("PATH_TRANSLATED") %></font><BR>
      </small><B><small>Referencia HTTP:// : </small></B><small><font color="#0000FF"><% = Request.ServerVariables("HTTP_REFERER") %>
      </font>
      </small>
      </font></font><font color="#0000FF" face="Arial" size="3"><a href="http://<% = Request.ServerVariables("SERVER_NAME") %>" target="_blank"><% = Request.ServerVariables("SERVER_NAME") %>
    </a>
    <br>
    </font><B><font face="Arial" size="2">Seu IP :</font><small><font face="Arial" SIZE="2">
    </font></small></B><font color="#0000FF" face="Arial" size="3"><%= request.servervariables("REMOTE_ADDR") %>    </font><small><font color="#0000FF"></font>
      </small>
<FONT SIZE="2"><font face="Arial"><small><BR>
      </small></font></font></TD><TD VALIGN="TOP" width="370" bgcolor="#CCCCCC">
<font size 4"" face="Arial"><b>Informações do Sistema</b></font>
<FONT SIZE="2"><font face="Arial"><BR>
<B><small>Sistema</small><small>: </B><font color="#0000FF"><% = ScriptEngine %></font><BR>
<B>Versão: </B><font color="#0000FF"><%  =ScriptEngineMajorVersion() %></font>.<font color="#0000FF"><% =ScriptEngineMinorVersion() %></font><BR>
</small><b><small>Atualizado:

</small> </b><small><font color="#0000FF"><% =ScriptEngineBuildVersion() %></font><BR><b>Tempo
de Respota do Servidor Web:</b><br>
</small><font color="#0000FF"><b><small><%
inicio = Timer
'... uma seqüência de comandos para medir a velocidade
response.write "Processado em " & FormatNumber( Timer - inicio, 2 ) & " segundos"
%>

</small></b></font></font>
  </font>
</TD></TR></TABLE>
<HR>
<font face="Arial"><B>
<FONT SIZE=""4"">CDONTS Object</FONT></B></font><font face="Arial"><B><font size 4"">:&nbsp;</font></B></font><FONT SIZE=""2""><font face="Arial">
<font color="#800000"><% Err.Clear
   On Error Resume Next
   Set objCDONTS = Server.CreateObject("CDONTS.Session")
   If Err.Number <> 0 Then
      Response.Write("<B>NÃO INSTALADO</B>&nbsp;&nbsp;")
   Else
      Response.Write("<B>Versão: </B>" & objCDONTS.Version & " INSTALADO&nbsp;&nbsp;")
   End If
%></font>
<BR>
</font>
<HR>
<font face="Arial">
<FONT SIZE=""4""><B>ADO DB Object:&nbsp;</B></FONT> <font color="#800000"><% Err.Clear
   On Error Resume Next
   Set objConn = Server.CreateObject("ADODB.Connection")
   If Err.Number <> 0 Then
      Response.Write("ADODB.Connection object <B>NÃO INSTALADO</B>")
   Else
      Response.Write("<B>Versão: </B>" & objConn.Version & "<BR>")
   End If
%></font></font>
<HR>
<FONT SIZE=""4""><B>File System Object</B></FONT><font face="Arial"> <font color="#800000">
<% Err.Clear
   On Error Resume Next
   Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
   If Err.Number <> 0 Then
      Response.Write("NÃO INSTALADO")
   Else
      Response.Write("INSTALADO")
   End If
%>
</font></font>
<HR>
<FONT SIZE=""4""><B>ASPMail Object</B></FONT><font face="Arial"> <font color="#800000">
<% Err.Clear
   On Error Resume Next
   Set objASPMail = Server.CreateObject("SMTPsvg.Mailer")
   If Err.Number <> 0 Then
      Response.Write("INSTALADA")
   Else
      Response.Write("VERSÃO INSTALADO " & objASPMail.Version )
      Response.Write("<BR><SMALL>EXPIRA EM:" & objASPMail.Expires & "</SMALL>" )
   End If
   Response.Write("<BR><FONT SIZE=""2"">Para Mais Informações <A HREF=""http://www.serverobjects.com"" TARGET=""RESOURCE WINDOW"">www.serverobjects.com</A></FONT>&nbsp;&nbsp;")
%>
</font> &nbsp;<BR>
</font>
<HR>
<FONT SIZE=""4""><B><font face="Arial">ASPImage Object</font></B></FONT><FONT SIZE=""2"">
<font face="Arial"> <font color="#800000">
<% Err.Clear
   On Error Resume Next
   Set objASPImage = Server.CreateObject("AspImage.Image")
   If Err.Number <> 0 Then
      Response.Write("NÃO INSTALADO")
   Else
      Response.Write("VERSÃO INSTALADA " & objASPImage.Version )
      Response.Write("<BR><SMALL>EXPIRA EM:" & objASPImage.Expires & "</SMALL>")      
   End If
   Response.Write("<BR><FONT SIZE=""2"">Para Mais Informações <A HREF=""http://www.serverobjects.com"" TARGET=""RESOURCE WINDOW"">www.serverobjects.com</A></FONT>")
%>
</font></font>
<HR>
<FONT SIZE=""4""><B>ASPUpload Object</B></FONT><font face="Arial"> <font color="#800000">
<% Err.Clear
   On Error Resume Next
   Set objASPUpload = Server.CreateObject("Persits.Upload.1")
   If Err.Number <> 0 Then
      Response.Write("NÃO INSTALADO")
   Else
      Response.Write("INSTALADO ")
   End If
   Response.Write("<BR><FONT SIZE=""2"">Para Mais Informações <A HREF=""http://www.persits.com"" TARGET=""RESOURCE WINDOW"">www.persits.com</A></FONT>")
%>
</font></font>
<HR>
<FONT SIZE=""4""><B>ASPEmail Object</B></FONT><font face="Arial"> <font color="#800000">
<% Err.Clear
   On Error Resume Next
   Set objASPEmail = Server.CreateObject("Persits.MailSender")
   If Err.Number <> 0 Then
      Response.Write("NÃO INSTALADO")
   Else
      Response.Write("INSTALADO ")
      Response.Write("<BR><SMALL>Expires On:" & objASPEmail.Expires & "</SMALL>")      
   End If
   Response.Write("<BR><FONT SIZE=""2"">Para Mais Informações <A HREF=""http://www.persits.com"" TARGET=""RESOURCE WINDOW"">www.persits.com</A></FONT>&nbsp;&nbsp;")
%>
</font> &nbsp;<BR>
</font>
<HR>
<FONT SIZE=""4""><B><font face="Arial">JMail Object</font></B></FONT><FONT SIZE=""2"">
<font face="Arial"> <font color="#800000">
<% Err.Clear
   On Error Resume Next
   Set objJMail = Server.CreateObject("JMail.SMTPMail")
   If Err.Number <> 0 Then
      Response.Write("NÃO INSTALADO")
   Else
      Response.Write("INSTALADO ")
   End If
   Response.Write("<BR><FONT SIZE=""2"">Para Mais Informações <A HREF=""http://www.dimac.net"" TARGET=""RESOURCE WINDOW"">www.dimac.net</A></FONT>&nbsp;&nbsp;")
%>
</font> &nbsp;<BR>
</font>
<HR>
<FONT SIZE=""4""><B><font face="Arial">Bamboo.SMTP Object</font></B></FONT><font face="Arial"><FONT SIZE=""2"">
 <font color="#800000">
<% Err.Clear
   On Error Resume Next
   Set objBamboo = Server.CreateObject("Bamboo.SMTP")
   If Err.Number <> 0 Then
      Response.Write("NÃO INSTALADO")
   Else
      Response.Write("INSTALADO ")
   End If
   Response.Write("&nbsp;&nbsp;")
%>
</font>
</FONT>
<BR>
</font>
<HR>
<font 4"" face="Arial"><b>Informações desta Transmissão</b></font><font face="Arial"><FONT SIZE=""2"">
<font color="#000080"><%
   On Error Resume Next
   vRunDate = Now
   sRunDate = Request.QueryString("DATE")
   If Len(Trim(sRunDate)) = 0 Then
      sRunDate = Request.Form("DATE")
   End If
   Response.Write("<FONT SIZE=""2"">")
   If IsDate(sRunDate) Then
      vRunDate = CDate(sRunDate)
      Response.Write("<BR><FONT SIZE=""2"">RunDate:" & sRunDate)
   Else
      Response.Write("<BR>RunDate: Now")
   End If
   Response.Write("<BR>RunDate : " & vRunDate )
   Response.Write("<BR>CDate(RunDate) : " & CDate(vRunDate) )
   Response.Write("<BR>CDate("" & RunDate) : " & CDate("" & vRunDate) )
%></font>
</FONT>
<!-- Mostrar os 10 últimos visitantes -->
<%
Application.Lock
IF NOT isArray( Application( "lastTen" ) ) THEN
DIM dummy( 10, 3 )
Application( "lastTen" ) = dummy
END IF
lastTen = Application( "lastTen" )
Application.UnLock

' Mover cada visita abaixo no Array
IF lastTen( 9, 0 ) <> "" THEN
FOR i = 0 TO 9
lastTen( i, 0 ) = lastTen( i + 1, 0 )
lastTen( i, 1 ) = lastTen( i + 1, 1 )
lastTen( i, 2 ) = lastTen( i + 1, 2 )
NEXT
END IF

' Somar uma nova entrada
FOR i = 0 TO 9
IF lastTen( i, 0 ) = "" THEN
lastTen( i, 0 ) = Request.ServerVariables( "REMOTE_ADDR" )
lastTen( i, 1 ) = Request.ServerVariables( "HTTP_USER_AGENT" )
lastTen( i, 2 ) = NOW()
EXIT FOR
END IF
NEXT

Application.Lock
Application( "lastTen" ) = lastTen
Application.UnLock 

%>

<br>
</font>
</font></font></font>
<EM><font face="Arial" 2"" size="2"><b>Transmitido: <font color="#FF0000"> <% = Now %></font></b></font></em>
<FONT SIZE=""2""><p>&nbsp;</font><b><font face="Arial" 2"" size="2">Mostrar os
10 Últimos Acessos a este Script:</font></b>
<center>
</p>
<font face="Arial">
<div align="left">
<table bgcolor="#CCCCC0" cellspacing=0 cellpadding=3 border=1>
<tr bgcolor="lightyellow">
<td><font 2"" size="2" color="#000080"><b>Visitas</b></font></td>
<td><font 2"" size="2" color="#000080"><b>Direção IP</b></font></td>
<td><font 2"" size="2" color="#000080"><b>Browser</b></font></td>
<td><font 2"" size="2" color="#000080"><b>Hora de Visita</b></font></td>
</tr>
<FONT SIZE=""2"">
<FONT SIZE=""2"">
<FONT SIZE=""2"">
<% 
FOR i = 0 TO 9 
IF lastTen( i, 0 ) <> "" THEN
%>
</font></font>
</font>
<tr>
<td><font 2"" size="2"><b><%=i + 1%></b></font></td>
<td><font 2"" size="2"><b><%=lastTen( i, 0 )%></b></font></td>
<td><font 2"" size="2"><b><%=lastTen( i, 1 )%></b></font></td>
<td><font 2"" size="2"><b><%=lastTen( i, 2 )%></b></font></td>
</tr>
<FONT SIZE=""2"">
<FONT SIZE=""2"">
<FONT SIZE=""2"">
<%
END IF
NEXT
%>
</table>
</div>
<BR></font></font>
</font></font>
<EM><font size="1" face="Arial" 2""><BR></font><FONT SIZE=""2""><FONT SIZE=""2"">
<FONT SIZE="2"><CENTER><A HREF="http://www.rg3.com.br">Copyright 2000 RG3 Internet do Brasil ®, Inc. All rights reserved.</A></CENTER></FONT>
</font>