<!--#include file="adm_restrito.asp"-->
<%
'##### SUPORTE

'Sub SuporteASP()
If Request("acaba") = "sim" Then
Session("adm_descprod") = ""
Session("adm_email") = ""
End If
Select Case strAcao
Case "email"
strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/supor_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Pedido de suporte via e-mail</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<form action=""administrador.asp?link=suporte&acao=envia"" method=post><font style=font-size:11px;font-family:tahoma><br>Preencha seu pedido de suporte para Equipe VirtuaStore:<br>"
If Request("sucesso") = "sim" Then
strTextoHtml = strTextoHtml & "<br><center><b><font style=font-size:11px;font-family:tahoma;color:#003366><br>SEU PEDIDO DE SUPORTE ENVIADO COM SUCESSO! <br>EM BREVE A EQUIPE VIRTUASTORE  ESTARÁ RESPONDENDO SEU CHAMADO.<br><br><br></font></b></center>"
Else
strTextoHtml = strTextoHtml & "<br><br>"
End If
varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"
strTextoHtml = strTextoHtml & "<table width=""90%"" align=center><tr><td width=""50%""><font style=font-size:11px;font-family:tahoma><b>Data:</b></td><td width=""50%""><font style=font-size:11px;font-family:tahoma>" & Date & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td><font style=font-size:11px;font-family:tahoma><b>Seu nome:</b></td><td><input name=""nome"" type=""text"" size=""50"" value=""" & Request("nome") & """ style=font-size:11px;font-family:tahoma>"
If Request("erro1") = "sim" Then
strTextoHtml = strTextoHtml & varimg
End If
strTextoHtml = strTextoHtml & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td valign=center><font style=font-size:11px;font-family:tahoma><b>Sua dúvida:</b></td><td><textarea name=""duvida"" cols=""70"" rows=""12""  style=font-size:11px;font-family:tahoma>" & Request("msg") & "</textarea>"
If Request("erro2") = "sim" Then
strTextoHtml = strTextoHtml & varimg
End If
strTextoHtml = strTextoHtml & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td valign=top><font style=font-size:11px;font-family:tahoma><b>Urgente?</b></td><td><select name=urgente style=font-size:11px;font-family:tahoma><option style=""color:red"" value=1>Sim<option value=2 selected>Não</select></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td valign=top></td><td align=center><input type=""submit"" value= "" Enviar Pedido "" style=font-size:11px;font-family:tahoma>&nbsp;<input type=""reset"" value="" Limpar Pedido "" style=font-size:11px;font-family:tahoma></td></tr></form>"
strTextoHtml = strTextoHtml & "</table>"
strTextoHtml = strTextoHtml & "<br><center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><a HREF=""?"">Voltar para Página Inicial</a></b></font>"

Case "envia"
nome = Request("nome")
msg = Request("duvida")
urgente = Request("urgente")
If nome = "" Or msg = "" Then
If nome = "" Then
erro1 = "sim"
End If
If msg = "" Then
erro2 = "sim"
End If
Response.Redirect "administrador.asp?link=suporte&acao=email&erro1=" & erro1 & "&erro2=" & erro2 & "&nome=" & nome & "&msg=" & msg
Else
strMensagem = "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//PT/BR'>"
strMensagem = strMensagem & "<HTML><HEAD>"
strMensagem = strMensagem & "<META content='text/html; charset=iso-8859-1' http-equiv=Content-Type>"
strMensagem = strMensagem & "<META content='MSHTML 5.00.2614.3500' name=GENERATOR></HEAD>"
strMensagem = strMensagem & "<BODY>"
strMensagem = strMensagem & "<TABLE border=0 cellSpacing=0 width='98%'>"
strMensagem = strMensagem & "  <TBODY>"
strMensagem = strMensagem & "  <TR>"
strMensagem = strMensagem & "    <TD colSpan=4 height=42>"
strMensagem = strMensagem & "      <DIV align=center><font face=tahoma><B><FONT style=font-size:17px color=000000>Pedido de Suporte via Administrador</DIV></FONT></TD></TR>"
strMensagem = strMensagem & "  <TR>"
strMensagem = strMensagem & "    <TD colSpan=4><FONT face=tahoma>"
strMensagem = strMensagem & "      <HR color=#000000 SIZE=1 width='100%'>"
strMensagem = strMensagem & "      </FONT></TD></TR>"
strMensagem = strMensagem & "  <TR>"
strMensagem = strMensagem & "    <TD colSpan=4><BR><FONT face=tahoma style=font-size:13px><b>Dados do Cliente e do E-mail:</b><FONT face=tahoma style=font-size:11px>"
strMensagem = strMensagem & "      <HR color=#000000 SIZE=1 width='100%'>"
strMensagem = strMensagem & "    <b>Nome: </b>" & nome
strMensagem = strMensagem & "    <br><b>Loja: </b> " & nomeloja & "(<a href=""http://" & urlloja & """>" & url & "</a>)"
strMensagem = strMensagem & "    <br><b>Contato: </b> " & Application("nomecontato") & " - Fone: " & Application("fone11")
strMensagem = strMensagem & "    </font><FONT face=tahoma style=font-size:13px><br><br><b>Mensagem</b></font>"
strMensagem = strMensagem & "      <HR color=#000000 SIZE=1 width='100%'>"
strMensagem = strMensagem & "      " & msg
strMensagem = strMensagem & "    <FONT face=tahoma style=font-size:11px>"
strMensagem = strMensagem & "    </font>"
strMensagem = strMensagem & "      <HR color=#000000 SIZE=1 width='100%'></font>"
strMensagem = strMensagem & "    </FONT></STRONG></FONT></TD></TR>"
strMensagem = strMensagem & "      <hr size=1 color=000000></TBODY></TABLE></BODY></HTML>"

If urgente = "1" Then
nourg = 2
Else
nourg = 1
End If

EnviaEmail Application("HostLoja"), Application("ComponenteLoja"), email, "", "suporte@virtuastore.com.br", "VirtuaWorks - Pedido de Suporte VS 1.0", strMensagem
Response.Redirect "administrador.asp?link=suporte&acao=email&sucesso=sim"
End If

Case "erro"
strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/supor_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Reportar erros no Sistema</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<form action=""administrador.asp?link=suporte&acao=enviaerro"" method=post><font style=font-size:11px;font-family:tahoma><br>Preencha descrevendo o erro para a equipe de suporte VirtuaStore:<br>"
If Request("sucesso") = "sim" Then
strTextoHtml = strTextoHtml & "<br><center><b><font style=font-size:11px;font-family:tahoma;color:#003366><br>SUA NOTIFICAÇÃO DE ERRO FOI ENVIADA COM SUCESSO!<br><br></font></b></center>"
Else
strTextoHtml = strTextoHtml & "<br><br>"
End If
varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"
strTextoHtml = strTextoHtml & "<table width=""90%"" align=center><tr><td width=""50%""><font style=font-size:11px;font-family:tahoma><b>Data:</b></td><td width=""50%""><font style=font-size:11px;font-family:tahoma>" & Date & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td valign=center><font style=font-size:11px;font-family:tahoma><b>Descreva o erro:</b></td><td><textarea name=""erro"" cols=""70"" rows=""12""  style=font-size:11px;font-family:tahoma>" & Request("msg") & "</textarea>"
If Request("erro1") = "sim" Then
strTextoHtml = strTextoHtml & varimg
End If
strTextoHtml = strTextoHtml & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td valign=top><font style=font-size:11px;font-family:tahoma><b>Já ocorreu outra vez? </b></td><td><select name=outra style=font-size:11px;font-family:tahoma><option>Sim<option selected>Não</select></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td valign=top></td><td align=center><input type=""submit"" value= "" Enviar o Erro "" style=font-size:11px;font-family:tahoma>&nbsp;<input type=""reset"" value="" Limpar o Erro "" style=font-size:11px;font-family:tahoma></td></tr></form>"
strTextoHtml = strTextoHtml & "</table>"
strTextoHtml = strTextoHtml & "<br><center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><a HREF=""?"">Voltar para Página Inicial</a></b></font>"

Case "enviaerro"
msg = Request("erro")
outra = Request("outra")

If msg = "" Then
Response.Redirect "administrador.asp?link=suporte&acao=erro&erro1=sim"
Else
strMensagem = "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//PT/BR'>"
strMensagem = strMensagem & "<HTML><HEAD>"
strMensagem = strMensagem & "<META content='text/html; charset=iso-8859-1' http-equiv=Content-Type>"
strMensagem = strMensagem & "<META content='MSHTML 5.00.2614.3500' name=GENERATOR></HEAD>"
strMensagem = strMensagem & "<BODY>"
strMensagem = strMensagem & "<TABLE border=0 cellSpacing=0 width='98%'>"
strMensagem = strMensagem & "  <TBODY>"
strMensagem = strMensagem & "  <TR>"
strMensagem = strMensagem & "    <TD colSpan=4 height=42>"
strMensagem = strMensagem & "      <DIV align=center><font face=tahoma><B><FONT style=font-size:17px color=000000>Reporte de Erro no Sistema VS 1.0</DIV></FONT></TD></TR>"
strMensagem = strMensagem & "  <TR>"
strMensagem = strMensagem & "    <TD colSpan=4><FONT face=tahoma>"
strMensagem = strMensagem & "      <HR color=#000000 SIZE=1 width='100%'>"
strMensagem = strMensagem & "      </FONT></TD></TR>"
strMensagem = strMensagem & "  <TR>"
strMensagem = strMensagem & "    <TD colSpan=4><BR><FONT face=tahoma style=font-size:13px><b>Dados do Cliente e do E-mail:</b><FONT face=tahoma style=font-size:11px>"
strMensagem = strMensagem & "      <HR color=#000000 SIZE=1 width='100%'>"
strMensagem = strMensagem & "    <b>Nome: </b>" & nome
strMensagem = strMensagem & "    <br><b>Loja: </b> " & nomeloja & "(<a href=""http://" & urlloja & """>" & url & "</a>)"
strMensagem = strMensagem & "    <br><b>Contato: </b> " & Application("nomecontato") & " - Fone: " & Application("fone11")
strMensagem = strMensagem & "    </font><FONT face=tahoma style=font-size:13px><br><br><b>Erro:</b></font>"
strMensagem = strMensagem & "      <HR color=#000000 SIZE=1 width='100%'>"
strMensagem = strMensagem & "      " & msg
strMensagem = strMensagem & "    <FONT face=tahoma style=font-size:11px>"
strMensagem = strMensagem & "    </font>"
strMensagem = strMensagem & "      <HR color=#000000 SIZE=1 width='100%'></font>"
strMensagem = strMensagem & "    </FONT></STRONG></FONT></TD></TR>"
strMensagem = strMensagem & "      <hr size=1 color=000000></TBODY></TABLE></BODY></HTML>"

EnviaEmail Application("HostLoja"), Application("ComponenteLoja"), email, "", "suporte@virtuastore.com.br", "VirtuaWorks - Reporte de Erro", strMensagem

Response.Redirect "administrador.asp?link=suporte&acao=erro&sucesso=sim"
End If

End Select
'End Sub
%>