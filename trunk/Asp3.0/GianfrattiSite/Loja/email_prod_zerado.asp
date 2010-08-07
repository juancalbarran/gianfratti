<% 
strAssunto2  = "Aviso de Produto com Estoque Zerado!"

StrMsg2 = "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>"
StrMsg2 = StrMsg2 & "<HTML><HEAD>"
StrMsg2 = StrMsg2 & "<META content='text/html; charset=iso-8859-1' http-equiv=Content-Type>"
StrMsg2 = StrMsg2 & "<META content='MSHTML 5.00.2614.3500' name=GENERATOR></HEAD>"
StrMsg2 = StrMsg2 & "<BODY>"
StrMsg2 = StrMsg2 & "<DIV align=justify>"
StrMsg2 = StrMsg2 & "<TABLE border=0 cellSpacing=0 width='98%'>"
StrMsg2 = StrMsg2 & "  <TBODY>"
StrMsg2 = StrMsg2 & "  <TR>"
StrMsg2 = StrMsg2 & "    <TD colSpan=4 height=42>"
StrMsg2 = StrMsg2 & "      <DIV align=center><font face="&fonte&"><B><FONT style=font-size:17px color=000000>"&tituloloja&"</FONT></B><BR><FONT style=font-size:11px>"&endereco11&" - "&bairro11&"<BR>"&cidade11&"/"&estado11&" - "&pais11&" - <a href='mailto:"&emailloja&"'>"&emailloja&"<BR></FONT></DIV></FONT></TD></TR>"
StrMsg2 = StrMsg2 & "  <TR>"
StrMsg2 = StrMsg2 & "    <TD colSpan=4><FONT face="&fonte&">"
StrMsg2 = StrMsg2 & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
StrMsg2 = StrMsg2 & "     </FONT></TD></TR>"
StrMsg2 = StrMsg2 & "  <TR>"
StrMsg2 = StrMsg2 & "    <TD align=left colSpan=2><FONT face="&fonte&"><FONT color=#000000" 
StrMsg2 = StrMsg2 & "      style='FONT-SIZE: 11px'><B>Aviso de Produto com Estoque Zerado!</B></FONT>" 
StrMsg2 = StrMsg2 & "      </FONT>"
StrMsg2 = StrMsg2 & "    <TD align=right colSpan=2><B><FONT face="&fonte&"><FONT color=#000000" 
StrMsg2 = StrMsg2 & "      style='FONT-SIZE: 11px'>Data: </B>"&day(now)&"/"&month(now)&"/"&year(date)&" </FONT>"
StrMsg2 = StrMsg2 & "      <DIV></DIV></FONT></TD></TR>"
StrMsg2 = StrMsg2 & "  <TR>"
StrMsg2 = StrMsg2 & "    <TD colSpan=4>"
StrMsg2 = StrMsg2 & "      <DIV><FONT face="&fonte&">"
StrMsg2 = StrMsg2 & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
StrMsg2 = StrMsg2 & "      </FONT></DIV>"
StrMsg2 = StrMsg2 & "      <DIV><FONT face="&fonte&" style='FONT-SIZE: 11px'>Um cliente comprou o último produto abaixo e seu estoque está ZERADO. <br>"
if prod_nao_visivel="Sim" then
StrMsg2 = StrMsg2 & " Conforme a sua configuração no site, este produto está como ""Não visível"" ao público, até que você ative como ""Visível"" e inclua mais estoque deste produto através da área administrativa</FONT></DIV>"
else
StrMsg2 = StrMsg2 & " Conforme a sua configuração no site, este produto aparecerá como ""Esgotado"" ao público, até que você inclua mais estoque deste produto, ou coloque-o como ""Não visível"" , através da área administrativa</FONT></DIV>"
end if


StrMsg2 = StrMsg2 & "      <DIV><FONT face=Arial style='FONT-SIZE: 11px'><FONT face="&fonte&"" 
StrMsg2 = StrMsg2 & "      style='FONT-SIZE: 11px'>&nbsp; "
StrMsg2 = StrMsg2 & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
StrMsg2 = StrMsg2 & "      </FONT></FONT></DIV>"
StrMsg2 = StrMsg2 & "<tr><td><br></td></tr>"
StrMsg2 = StrMsg2 & "      <DIV align=left><FONT face="&fonte&"><FONT style='FONT-SIZE: 11px'>" 
StrMsg2 = StrMsg2 & "      </DIV>"
StrMsg2 = StrMsg2 & "      <DIV align=left><FONT face="&fonte&"><FONT style='FONT-SIZE: 11px'>" 
StrMsg2 = StrMsg2 & "    <TD colSpan=4><FONT face="&fonte&"><FONT face="&fonte&"><FONT color=#000000 style='COLOR: #000000; FONT-SIZE: 11px'><B>Nome do produto:" 
StrMsg2 = StrMsg2 & "      </B>"&strProdNome&"<BR><B>Fabricante: </B>"&strFab&" "
StrMsg2 = StrMsg2 & "      <BR><B>Código do Produto:</B> "&intProdID&" "
if prod_nao_visivel<>"Sim" then
StrMsg2 = StrMsg2 & "      <BR><B>Link do Produto na loja:</B> <A "
StrMsg2 = StrMsg2 & "      href='http://"&urlloja&"/produtos.asp?produto="&intProdID&"'>http://"&urlloja&"/produtos.asp?produto="&intProdID&"</A> "
end if
StrMsg2 = StrMsg2 & "      <BR><br><B>Área administrativa da loja:</B> <A "
StrMsg2 = StrMsg2 & "      href='http://"&urlloja&"/admin'>http://"&urlloja&"/admin</A> </FONT></FONT></B><BR><br></FONT></TD></TR></TBODY></TABLE></DIV></BODY></HTML>"
StrMsg2 = StrMsg2 & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"

'Envia o e-mail

EnviaEmail Application("HostLoja"), Application("ComponenteLoja"), emailloja, "", emailloja, strAssunto2, StrMsg2%>