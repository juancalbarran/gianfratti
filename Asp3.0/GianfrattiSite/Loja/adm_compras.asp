<!--#include file="adm_restrito.asp"-->
<%
fonte = application("fonte")
corfundo = application("corfundo")
cor1 = application("cor1")
cor2 = application("cor2")
cor3 = application("cor3")
cor4= application("cor4")
cor5= application("cor5")
fontebranca = application("fontebranca")
fontepreta = application("fontepreta")
corborda = application("corborda")

'##### COMPRAS

'Sub ComprasASP()
If Request("acaba") = "sim" Then
Session("adm_descprod") = ""
Session("adm_email") = ""
End If
Select Case strAcao


Case "vert"

strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/comp_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Ver todas as Compras</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<br>"
finalera = Request.QueryString("final")
pag = Request.QueryString("itens")
pesss = Trim(Request.QueryString("pesq"))
pagdxx = Request.QueryString("pagina")
pesqsa = Request.QueryString("pesqsa")
catege = Request("cat")
Mes = CStr(Trim(Request("mes")))
If Mes = "1" Or Mes = "01" Then
Mes = "janeiro"
End If
If Mes = "2" Or Mes = "02" Then
Mes = "fevereiro"
End If
If Mes = "3" Or Mes = "03" Then
Mes = "março"
End If
If Mes = "4" Or Mes = "04" Then
Mes = "abril"
End If
If Mes = "5" Or Mes = "05" Then
Mes = "maio"
End If
If Mes = "6" Or Mes = "06" Then
Mes = "junho"
End If
If Mes = "7" Or Mes = "07" Then
Mes = "julho"
End If
If Mes = "8" Or Mes = "08" Then
Mes = "agosto"
End If
If Mes = "9" Or Mes = "09" Then
Mes = "setembro"
End If
If Mes = "10" Then
Mes = "outubro"
End If
If Mes = "11" Then
Mes = "novembro"
End If
If Mes = "12" Then
Mes = "dezembro"
End If
If pesss = "" Then
pesss = "-"
palavra = Split(Trim("asdfghjklçqwertyuiopzxcvbnm"), " ")
Else
pesss = pesss
palavra = Split(Trim(Request.QueryString("pesq")), " ")
End If
If pag = "" Then
inicial = 0
final = 20
Else
inicial = pag
final = 20
End If
If pesqsa = "" Then
restinho = ""
catege = "todos"
Else
If catege = "todos" Or catege = "xxx" Or catege = "" Then
resto = ""
Else
resto = "idsessao = '" & catege & "' and"
End If
palavraz = Split(Trim(pesqsa), " ")
restinho = "WHERE " & resto & " nome LIKE '%" & palavraz(0) & "%'"
End If

If VersaoDb = 1 then
   Set rs = conexao.Execute("select * from compras where status <> 'Compra em Aberto' LIMIT " & inicial & "," & final & ";")
else
   set rs = createobject("adodb.recordset")
   set rs.activeconnection = conexao
   rs.cursortype = 3
   rs.pagesize = final
   rs.open "select * from compras where status <> 'Compra em Aberto'"
end if

If rs.EOF Or rs.bof Then

strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Compra(s) efetuada(s) na loja: <b>0" & totalreg & "</b> <hr size=1 color=#dddddd width=""100%"">"
strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=""100%""><tr><td>"
strTextoHtml = strTextoHtml & "<table width=563 align=center>"
strTextoHtml = strTextoHtml & "<tr><td align=center><br><br><b><font style=font-size:11px><br>Nenhuma compra referente a este dia foi encontrada na base de dados da loja.<br><br></b><br><br></td></tr></table>"
strTextoHtml = strTextoHtml & "<br></table>"
strTextoHtml = strTextoHtml & "<table width=100% cellspacing=""0"" cellpadding=""0""><tr><td colspan=2>"
strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc width=""101%""></td></tr><tr><td></td><td align=right><font face=""tahoma"" style=font-size:11px;color:000000>"
strTextoHtml = strTextoHtml & "&nbsp;<font face=""tahoma"" style=font-size:11px>Página(s): <b><u>1</u></b></a></font></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
strTextoHtml = strTextoHtml & "</tr></table><td></tr></table>"

Else

Set rs2 = conexao.Execute("SELECT count(pedido) AS total FROM compras WHERE status <> 'Compra em Aberto'")

totalreg = rs2("total")
rs2.Close
Set rs2 = Nothing
numiz = Request("pagina") & "0"
numiz = CInt(numiz) * 2
iz = iz + numiz

strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Compra(s) efetuada(s) na loja: <b>" & totalreg & "</b> <hr size=1 color=#dddddd width=""100%"">"
strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=""100%""><tr><td>"

If Request("status") = "sucesso" Then

strTextoHtml = strTextoHtml & "<center><b><font style=font-size:11px;font-family:tahoma;color:#003366>COMPRA EXCLUÍDA COM SUCESSO!<br><br></font></b></center>"

Else
End If

strTextoHtml = strTextoHtml & "<table width=563 align=center>"

If VersaoDb = 1 then

While Not rs.EOF

iz = iz + 1
Select Case rs("estadoentrega")
Case "AC"
estadoz = "Acre"
Case "AL"
estadoz = "Alagoas"
Case "AP"
estadoz = "Amapá"
Case "AM"
estadoz = "Amazonas"
Case "BA"
estadoz = "Bahia"
Case "CE"
estadoz = "Ceará"
Case "DF"
estadoz = "Distrito Federal"
Case "ES"
estadoz = "Espirito Santo"
Case "GO"
estadoz = "Goiás"
Case "MA"
estadoz = "Maranhão"
Case "MT"
estadoz = "Mato Grosso"
Case "MS"
estadoz = "Mato Grosso do Sul"
Case "MG"
estadoz = "Minas Gerais"
Case "PA"
estadoz = "Pará"
Case "PB"
estadoz = "Paraiba"
Case "PR"
estadoz = "Parana"
Case "PE"
estadoz = "Pernambuco"
Case "PI"
estadoz = "Piauí"
Case "RJ"
estadoz = "Rio de Janeiro"
Case "RN"
estadoz = "Rio Grande do Norte"
Case "RS"
estadoz = "Rio Grande do Sul"
Case "RO"
estadoz = "Rondônia"
Case "RR"
estadoz = "Roraima"
Case "SC"
estadoz = "Santa Catarina"
Case "SP"
estadoz = "São Paulo"
Case "SE"
estadoz = "Sergipe"
Case "TO"
estadoz = "Tocantins"
End Select

on error resume next

Set rs3 = conexao.Execute("select * from clientes where email='" & rs("clienteid") & "';")



If rs("status")= "0" Then
estatus_cliente = "Aguardando confirmação de pagamento"
End If
If rs("status") = "1" Then
estatus_cliente = "Pagamento confirmado e Processar Compra"
End If
If rs("status") = "2" Then
estatus_cliente = "Compra enviada, com envio de email informando ao cliente"
End If
If rs("status") = "3" Then
estatus_cliente = "Compra já entregue"
End If
If rs("status") = "4" Then
estatus_cliente = "Pagamento cancelado, com envio de email confirmando ao cliente"
End If
If rs("status") = "5" Then
estatus_cliente = "Pagamento Negada, com envio de email informando ao cliente"
End If
If rs("status") = "6" Then
estatus_cliente = "Pagamento cancelado, com envio de email informando ao cliente para entrar em contato"
End If


strTextoHtml = strTextoHtml & "<tr><td align=left valign=center>" & vbNewLine

strTextoHtml = strTextoHtml & "<script language=""javascript"">" & vbNewLine
strTextoHtml = strTextoHtml & "function compra" & rs("idcompra") & "(){" & vbNewLine
strTextoHtml = strTextoHtml & "if (confirm('Você realmente deseja excluir esta compra?'))" & vbNewLine
strTextoHtml = strTextoHtml & "{" & vbNewLine
strTextoHtml = strTextoHtml & "window.location.href('?link=compras&acao=excluir&compra=" & rs("idcompra") & "&ano=" & Request("ano") & "&data=" & Request("data") & "&mes=" & Request("mes") & "&dia=" & Request("dia") & "');" & vbNewLine
strTextoHtml = strTextoHtml & "}" & vbNewLine
strTextoHtml = strTextoHtml & "else" & vbNewLine
strTextoHtml = strTextoHtml & "{" & vbNewLine
strTextoHtml = strTextoHtml & "}}" & vbNewLine
strTextoHtml = strTextoHtml & "</script>" & vbNewLine

strTextoHtml = strTextoHtml & "<table width=563 bgcolor=#eeeeee style='border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;'><tr><td valign=center><font face=""tahoma"" style=font-size:11px;color:000000>" & iz & ") Compra feita por: <b>" & UCase(Cripto(rs3("nome"),false)) & "</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Frete para: <b>" & estadoz & "</b> &nbsp;&nbsp;&nbsp;Total da compra: <font color=#b23c04><b>R$ " & FormatNumber(-1 + Cripto(rs("totalcompra"),false) + Cripto(rs("frete"),false) + 1, 2) & "</b></font><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Status: <font color=#b23c04><b> " & estatus_cliente & "</b></font></td><td align=right valign=center><font face=""tahoma"" style=font-size:11px;color:000000>Ação: <b><a href=?link=compras&acao=olhar&compra=" & rs("idcompra") & "&ano=" & Request("ano") & "&data=" & Request("data") & "&mes=" & Request("mes") & "&dia=" & Request("dia") & ">Ver</a></b> | <b><a href=""javascript: compra" & rs("idcompra") & "();"">Excluir</a></b>&nbsp;</td></tr></table> <table><tr><td height=4></td></tr></table>"

rs.movenext
pagn = inicial + 20
Wend
paga = pagn - 40

If totalreg Mod 20 <> 0 Then
valor = 1
Else
valor = 0
End If
pagina = Fix(totalreg / 20) + valor
pagina = Replace(pagina, ",", "")
pagdxx = pagdxx + 1
pagdxx = Replace(pagdxx, ",", "")
pagdxx2 = pagdxx - 2
pagdxx2 = Replace(pagdxx2, ",", "")
paga = Replace(paga, ",", "")
pagn = Replace(pagn, ",", "")
If pagdxx = "" Then pagdxx = 1
If pagina = "0" Then pagina = "1"

strTextoHtml = strTextoHtml & "</td></tr></table>"
strTextoHtml = strTextoHtml & "<table width=563>"
strTextoHtml = strTextoHtml & "<tr><td colspan=2>"
strTextoHtml = strTextoHtml & "<center>"

If paga < 0 Then
paga = 0
Else

strTextoHtml = strTextoHtml & "<a HREF=""?link=compras&acao=vert&itens=" & paga & "&pagina=" & pagdxx2 & "&pesqsa=" & pesqsa & "&cat=" & catege & """ style=""color:000000""><font face=""tahoma"" style=font-size:11px><b>Página Anterior</b></a></font>&nbsp;&nbsp;"

End If
If totalreg < final Or totalreg = 20 Or pagdxx = pagina Then
totalreg = ""
npc = 1
totalp = 1
Else
variavel1 = CStr(pagdxx + 1)
variavel2 = CStr(pagina)
variavel1 = Replace(variavel1, ",", "")
variavel2 = Replace(variavel2, ",", "")

strTextoHtml = strTextoHtml & "&nbsp;&nbsp;<a HREF=?link=compras&acao=vert&itens=" & pagn & "&pagina=" & pagdxx & "&pesqsa=" & pesqsa & "&cat=" & catege

If variavel1 = variavel2 Then
strTextoHtml = strTextoHtml & "&final=sim"
End If

strTextoHtml = strTextoHtml & " style=color:000000><font face=tahoma style=font-size:11px><b>Próxima página</b></a></font>"

End If

strTextoHtml = strTextoHtml & "</td></tr></table></td></tr></table></td></tr></table>"
strTextoHtml = strTextoHtml & "<table width=""100%"" cellspacing=""0"" cellpadding=""0""><tr><td colspan=2>"
strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc width=""101%""></td></tr><tr><td><font face=""tahoma"" style=font-size:11px;color:000000>Página <B>" & pagdxx & "</B> de <B>" & pagina & "</B></td><td align=right><font face=""tahoma"" style=font-size:11px;color:000000>"

If pagina = 1 Then
finalera = "sim"
End If
If pagina <> 1 Then
For i = 1 To pagina - 1
i = Replace(i, ",", "")
i2 = i - 1
i2 = Replace(i2, ",", "")
fator = 20
totalfator = fator * i - 20
totalfator = Replace(totalfator, ",", "")
paginadem = pagdxx
paginadem = Replace(paginadem, ",", "")

strTextoHtml = strTextoHtml & "&nbsp;<a HREF=?link=compras&acao=vert&itens=" & totalfator & "&pagina=" & i2 & "&pesqsa=" & pesqsa & "&cat=" & catege & " style=color:000000><font face=tahoma style=font-size:11px>"

If paginadem = i Then
strTextoHtml = strTextoHtml & "<b><u>"
End If

strTextoHtml = strTextoHtml & Replace(i, ",", "") & "</u></b></a> &middot;</font>"

Next
End If
pagina2 = pagina * 20 - 20
pagina2 = Replace(pagina2, ",", "")
pagina3 = pagina - 1
pagina3 = Replace(pagina3, ",", "")

strTextoHtml = strTextoHtml & "&nbsp;<a HREF=""?link=compras&acao=vert&itens=" & pagina2 & "&pagina=" & pagina3 & "&pesqsa=" & pesqsa & "&cat=" & catege & "&final=sim"" style=""color:000000""><font face=""tahoma"" style=font-size:11px>"

If finalera = "sim" Then
strTextoHtml = strTextoHtml & "<b><u>"
End If

strTextoHtml = strTextoHtml & pagina & "</u></b></a></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font><br><br></td></tr></table>"

else

pag = request.querystring("pagina")
if pag = "" Then
   pag = 1
end if

contador = 0
rs.absolutepage = pag
while not rs.eof and contador < rs.pagesize
contador = contador +1

iz = iz + 1
Select Case rs("estadoentrega")
Case "AC"
estadoz = "Acre"
Case "AL"
estadoz = "Alagoas"
Case "AP"
estadoz = "Amapá"
Case "AM"
estadoz = "Amazonas"
Case "BA"
estadoz = "Bahia"
Case "CE"
estadoz = "Ceará"
Case "DF"
estadoz = "Distrito Federal"
Case "ES"
estadoz = "Espirito Santo"
Case "GO"
estadoz = "Goiás"
Case "MA"
estadoz = "Maranhão"
Case "MT"
estadoz = "Mato Grosso"
Case "MS"
estadoz = "Mato Grosso do Sul"
Case "MG"
estadoz = "Minas Gerais"
Case "PA"
estadoz = "Pará"
Case "PB"
estadoz = "Paraiba"
Case "PR"
estadoz = "Parana"
Case "PE"
estadoz = "Pernambuco"
Case "PI"
estadoz = "Piauí"
Case "RJ"
estadoz = "Rio de Janeiro"
Case "RN"
estadoz = "Rio Grande do Norte"
Case "RS"
estadoz = "Rio Grande do Sul"
Case "RO"
estadoz = "Rondônia"
Case "RR"
estadoz = "Roraima"
Case "SC"
estadoz = "Santa Catarina"
Case "SP"
estadoz = "São Paulo"
Case "SE"
estadoz = "Sergipe"
Case "TO"
estadoz = "Tocantins"
End Select

on error resume next

Set rs3 = conexao.Execute("select * from clientes where email='" & rs("clienteid") & "';")



If rs("status")= "0" Then
estatus_cliente = "Aguardando confirmação de pagamento"
End If
If rs("status") = "1" Then
estatus_cliente = "Pagamento confirmado e Processar Compra"
End If
If rs("status") = "2" Then
estatus_cliente = "Compra enviada, com envio de email informando ao cliente"
End If
If rs("status") = "3" Then
estatus_cliente = "Compra já entregue"
End If
If rs("status") = "4" Then
estatus_cliente = "Pagamento cancelado, com envio de email confirmando ao cliente"
End If
If rs("status") = "5" Then
estatus_cliente = "Pagamento Negada, com envio de email informando ao cliente"
End If
If rs("status") = "6" Then
estatus_cliente = "Pagamento cancelado, com envio de email informando ao cliente para entrar em contato"
End If


strTextoHtml = strTextoHtml & "<tr><td align=left valign=center>" & vbNewLine
strTextoHtml = strTextoHtml & "<script language=""javascript"">" & vbNewLine
strTextoHtml = strTextoHtml & "function compra" & rs("idcompra") & "(){" & vbNewLine
strTextoHtml = strTextoHtml & "if (confirm('Você realmente deseja excluir esta compra?'))" & vbNewLine
strTextoHtml = strTextoHtml & "{" & vbNewLine
strTextoHtml = strTextoHtml & "window.location.href('?link=compras&acao=excluir&compra=" & rs("idcompra") & "&ano=" & Request("ano") & "&data=" & Request("data") & "&mes=" & Request("mes") & "&dia=" & Request("dia") & "');" & vbNewLine
strTextoHtml = strTextoHtml & "}" & vbNewLine
strTextoHtml = strTextoHtml & "else" & vbNewLine
strTextoHtml = strTextoHtml & "{" & vbNewLine
strTextoHtml = strTextoHtml & "}}" & vbNewLine
strTextoHtml = strTextoHtml & "</script>" & vbNewLine
strTextoHtml = strTextoHtml & "<table width=563 bgcolor=#eeeeee style='border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;'><tr><td valign=center><font face=""tahoma"" style=font-size:11px;color:000000>" & iz & ") Compra feita por: <b>" & UCase(Cripto(rs3("nome"),false)) & "</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Frete para: <b>" & estadoz & "</b> &nbsp;&nbsp;&nbsp;Total da compra: <font color=#b23c04><b>R$ " & FormatNumber(-1 + Cripto(rs("totalcompra"),false) + Cripto(rs("frete"),false) + 1, 2) & "</b></font><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Status: <font color=#b23c04><b> " & estatus_cliente & "</b></font></td><td align=right valign=center><font face=""tahoma"" style=font-size:11px;color:000000>Ação: <b><a href=?link=compras&acao=olhar&compra=" & rs("idcompra") & "&ano=" & Request("ano") & "&data=" & Request("data") & "&mes=" & Request("mes") & "&dia=" & Request("dia") & ">Ver</a></b> | <b><a href=""javascript: compra" & rs("idcompra") & "();"">Excluir</a></b>&nbsp;</td></tr></table> <table><tr><td height=4></td></tr></table>"

rs.movenext
wend

strTextoHtml = strTextoHtml & "<center><br>"

strTextoHtml = strTextoHtml & "<table width=100% cellspacing=""0"" cellpadding=""0""><tr><td colspan=2>"
strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc width=""101%""></td></tr><tr><td colspan=2 align=right><font face=""tahoma"" style=font-size:11px;color:000000>"

strTextoHtml = strTextoHtml & "Página(s):&nbsp;&nbsp;"

for i = 1 to rs.pagecount

if i = cint(pag) then
   strTextoHtml = strTextoHtml & "<u><b>" & i & "</b></u> "
else
   strTextoHtml = strTextoHtml & "<a href='?link=compras&acao=vert&acaba=sim&pagina=" & i & "'>" & i & "</a> "
end if

next

strTextoHtml = strTextoHtml & "</td></tr><tr><td colspan=2><hr size=1 color=cccccc width=""101%""></td></tr></table></table></table></table>"
end if

rs.Close
Set rs = Nothing
End If

')))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
')))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))


Case "ver"

strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/comp_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Administrar compras efetuadas na loja</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<center>"
Call CalendarioASP
strTextoHtml = strTextoHtml & "<br><font face=tahoma style=font-size:11px>>> Datas em <font color=red>VERMELHO</font> indicam compras efetudadas no dia<<</center><table><tr><td height=7></td></tr></table><hr size=1 color=#cccccc>"

finalera = Request.QueryString("final")
pag = Request.QueryString("itens")
pesss = Trim(Request.QueryString("pesq"))
pagdxx = Request.QueryString("pagina")
pesqsa = Request.QueryString("pesqsa")
catege = Request("cat")
Mes = CStr(Trim(Request("mes")))
If Mes = "1" Or Mes = "01" Then
Mes = "janeiro"
End If
If Mes = "2" Or Mes = "02" Then
Mes = "fevereiro"
End If
If Mes = "3" Or Mes = "03" Then
Mes = "março"
End If
If Mes = "4" Or Mes = "04" Then
Mes = "abril"
End If
If Mes = "5" Or Mes = "05" Then
Mes = "maio"
End If
If Mes = "6" Or Mes = "06" Then
Mes = "junho"
End If
If Mes = "7" Or Mes = "07" Then
Mes = "julho"
End If
If Mes = "8" Or Mes = "08" Then
Mes = "agosto"
End If
If Mes = "9" Or Mes = "09" Then
Mes = "setembro"
End If
If Mes = "10" Then
Mes = "outubro"
End If
If Mes = "11" Then
Mes = "novembro"
End If
If Mes = "12" Then
Mes = "dezembro"
End If
If pesss = "" Then
pesss = "-"
palavra = Split(Trim("asdfghjklçqwertyuiopzxcvbnm"), " ")
Else
pesss = pesss
palavra = Split(Trim(Request.QueryString("pesq")), " ")
End If
If pag = "" Then
inicial = 0
final = 20
Else
inicial = pag
final = 20
End If
If pesqsa = "" Then
restinho = ""
catege = "todos"
Else
If catege = "todos" Or catege = "xxx" Or catege = "" Then
resto = ""
Else
resto = "idsessao = '" & catege & "' and"
End If
palavraz = Split(Trim(pesqsa), " ")
restinho = "WHERE " & resto & " nome LIKE '%" & palavraz(0) & "%'"
End If

If VersaoDb = 1 then
   Set rs = conexao.Execute("select * from compras where datacompra='" & Request("data") & "' AND status <> 'Compra em Aberto' LIMIT " & inicial & "," & final & ";")
else
   set rs = createobject("adodb.recordset")
   set rs.activeconnection = conexao
   rs.cursortype = 3
   rs.pagesize = final
   rs.open "select * from compras where datacompra='" & Request("data") & "' AND status <> 'Compra em Aberto'"
end if

If rs.EOF Or rs.bof Then

if Request("data")<>"" then
strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Compra(s) efetuada(s) em " & Request("dia") & " de " & Mes & " de " & Request("ano") & ": <b>0" & totalreg & "</b> <hr size=1 color=#dddddd width=""100%"">"
strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=""100%""><tr><td>"
strTextoHtml = strTextoHtml & "<table width=563 align=center>"
strTextoHtml = strTextoHtml & "<tr><td align=center><br><br><b><font style=font-size:11px><br>Nenhuma compra referente a este dia foi encontrada na base de dados da loja.<br><br></b><br><br></td></tr></table>"
strTextoHtml = strTextoHtml & "<br></table>"
end if

strTextoHtml = strTextoHtml & "<table width=100% cellspacing=""0"" cellpadding=""0""><tr><td colspan=2>"
strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc width=""101%""></td></tr><tr><td></td><td align=right><font face=""tahoma"" style=font-size:11px;color:000000>"
strTextoHtml = strTextoHtml & "&nbsp;<font face=""tahoma"" style=font-size:11px>Página(s): <b><u>1</u></b></a></font></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
strTextoHtml = strTextoHtml & "</tr></table><td></tr></table>"

Else

Set rs2 = conexao.Execute("SELECT count(pedido) AS total FROM compras WHERE datacompra='" & Request("data") & "' AND status <> 'Compra em Aberto'")

totalreg = rs2("total")
rs2.Close
Set rs2 = Nothing
numiz = Request("pagina") & "0"
numiz = CInt(numiz) * 2
iz = iz + numiz

strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Compra(s) efetuada(s) em " & Request("dia") & " de " & Mes & " de " & Request("ano") & ": <b>" & totalreg & "</b> <hr size=1 color=#dddddd width=""100%"">"
strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=""100%""><tr><td>"

If Request("status") = "sucesso" Then

strTextoHtml = strTextoHtml & "<center><b><font style=font-size:11px;font-family:tahoma;color:#003366>COMPRA EXCLUÍDA COM SUCESSO!<br><br></font></b></center>"

Else
End If

strTextoHtml = strTextoHtml & "<table width=563 align=center>"

If VersaoDb = 1 then

While Not rs.EOF

iz = iz + 1
Select Case rs("estadoentrega")
Case "AC"
estadoz = "Acre"
Case "AL"
estadoz = "Alagoas"
Case "AP"
estadoz = "Amapá"
Case "AM"
estadoz = "Amazonas"
Case "BA"
estadoz = "Bahia"
Case "CE"
estadoz = "Ceará"
Case "DF"
estadoz = "Distrito Federal"
Case "ES"
estadoz = "Espirito Santo"
Case "GO"
estadoz = "Goiás"
Case "MA"
estadoz = "Maranhão"
Case "MT"
estadoz = "Mato Grosso"
Case "MS"
estadoz = "Mato Grosso do Sul"
Case "MG"
estadoz = "Minas Gerais"
Case "PA"
estadoz = "Pará"
Case "PB"
estadoz = "Paraiba"
Case "PR"
estadoz = "Parana"
Case "PE"
estadoz = "Pernambuco"
Case "PI"
estadoz = "Piauí"
Case "RJ"
estadoz = "Rio de Janeiro"
Case "RN"
estadoz = "Rio Grande do Norte"
Case "RS"
estadoz = "Rio Grande do Sul"
Case "RO"
estadoz = "Rondônia"
Case "RR"
estadoz = "Roraima"
Case "SC"
estadoz = "Santa Catarina"
Case "SP"
estadoz = "São Paulo"
Case "SE"
estadoz = "Sergipe"
Case "TO"
estadoz = "Tocantins"
End Select

on error resume next

Set rs3 = conexao.Execute("select * from clientes where email='" & rs("clienteid") & "';")

strTextoHtml = strTextoHtml & "<tr><td align=left valign=center>" & vbNewLine

strTextoHtml = strTextoHtml & "<script language=""javascript"">" & vbNewLine
strTextoHtml = strTextoHtml & "function compra" & rs("idcompra") & "(){" & vbNewLine
strTextoHtml = strTextoHtml & "if (confirm('Você realmente deseja excluir esta compra?'))" & vbNewLine
strTextoHtml = strTextoHtml & "{" & vbNewLine
strTextoHtml = strTextoHtml & "window.location.href('?link=compras&acao=excluir&compra=" & rs("idcompra") & "&ano=" & Request("ano") & "&data=" & Request("data") & "&mes=" & Request("mes") & "&dia=" & Request("dia") & "');" & vbNewLine
strTextoHtml = strTextoHtml & "}" & vbNewLine
strTextoHtml = strTextoHtml & "else" & vbNewLine
strTextoHtml = strTextoHtml & "{" & vbNewLine
strTextoHtml = strTextoHtml & "}}" & vbNewLine
strTextoHtml = strTextoHtml & "</script>" & vbNewLine

strTextoHtml = strTextoHtml & "<table width=563 bgcolor=#eeeeee style='border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;'><tr><td valign=center><font face=""tahoma"" style=font-size:11px;color:000000>" & iz & ") Compra #"&rs("idcompra")&" feita por: <b>" & UCase(Cripto(rs3("nome"),false)) & "</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Frete para: <b>" & estadoz & "</b> &nbsp;&nbsp;&nbsp;Total da compra: <font color=#b23c04><b>R$ " & FormatNumber(-1 + Cripto(rs("totalcompra"),false) + Cripto(rs("frete"),false) + 1, 2) & "</b></font></td><td align=right valign=center><font face=""tahoma"" style=font-size:11px;color:000000>Ação: <b><a href=?link=compras&acao=olhar&compra=" & rs("idcompra") & "&ano=" & Request("ano") & "&data=" & Request("data") & "&mes=" & Request("mes") & "&dia=" & Request("dia") & ">Ver</a></b> | <b><a href=""javascript: compra" & rs("idcompra") & "();"">Excluir</a></b>&nbsp;</td></tr></table> <table><tr><td height=4></td></tr></table>"

rs.movenext
pagn = inicial + 20
Wend
paga = pagn - 40

If totalreg Mod 20 <> 0 Then
valor = 1
Else
valor = 0
End If
pagina = Fix(totalreg / 20) + valor
pagina = Replace(pagina, ",", "")
pagdxx = pagdxx + 1
pagdxx = Replace(pagdxx, ",", "")
pagdxx2 = pagdxx - 2
pagdxx2 = Replace(pagdxx2, ",", "")
paga = Replace(paga, ",", "")
pagn = Replace(pagn, ",", "")
If pagdxx = "" Then pagdxx = 1
If pagina = "0" Then pagina = "1"

strTextoHtml = strTextoHtml & "</td></tr></table>"
strTextoHtml = strTextoHtml & "<table width=563>"
strTextoHtml = strTextoHtml & "<tr><td colspan=2>"
strTextoHtml = strTextoHtml & "<center>"

If paga < 0 Then
paga = 0
Else

strTextoHtml = strTextoHtml & "<a HREF=""?link=compras&acao=ver&ano=" & Request("ano") & "&data=" & Request("data") & "&mes=" & Request("mes") & "&dia=" & Request("dia") & "&itens=" & paga & "&pagina=" & pagdxx2 & "&pesqsa=" & pesqsa & "&cat=" & catege & """ style=""color:000000""><font face=""tahoma"" style=font-size:11px><b>Página Anterior</b></a></font>&nbsp;&nbsp;"

End If
If totalreg < final Or totalreg = 20 Or pagdxx = pagina Then
totalreg = ""
npc = 1
totalp = 1
Else
variavel1 = CStr(pagdxx + 1)
variavel2 = CStr(pagina)
variavel1 = Replace(variavel1, ",", "")
variavel2 = Replace(variavel2, ",", "")

strTextoHtml = strTextoHtml & "&nbsp;&nbsp;<a HREF=?link=compras&acao=ver&ano=" & Request("ano") & "&data=" & Request("data") & "&mes=" & Request("mes") & "&dia=" & Request("dia") & "&itens=" & pagn & "&pagina=" & pagdxx & "&pesqsa=" & pesqsa & "&cat=" & catege

If variavel1 = variavel2 Then
strTextoHtml = strTextoHtml & "&final=sim"
End If

strTextoHtml = strTextoHtml & " style=color:000000><font face=tahoma style=font-size:11px><b>Próxima página</b></a></font>"

End If

strTextoHtml = strTextoHtml & "</td></tr></table></td></tr></table></td></tr></table>"
strTextoHtml = strTextoHtml & "<table width=""100%"" cellspacing=""0"" cellpadding=""0""><tr><td colspan=2>"
strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc width=""101%""></td></tr><tr><td><font face=""tahoma"" style=font-size:11px;color:000000>Página <B>" & pagdxx & "</B> de <B>" & pagina & "</B></td><td align=right><font face=""tahoma"" style=font-size:11px;color:000000>"

If pagina = 1 Then
finalera = "sim"
End If
If pagina <> 1 Then
For i = 1 To pagina - 1
i = Replace(i, ",", "")
i2 = i - 1
i2 = Replace(i2, ",", "")
fator = 20
totalfator = fator * i - 20
totalfator = Replace(totalfator, ",", "")
paginadem = pagdxx
paginadem = Replace(paginadem, ",", "")

strTextoHtml = strTextoHtml & "&nbsp;<a HREF=?link=compras&acao=ver&ano=" & Request("ano") & "&data=" & Request("data") & "&mes=" & Request("mes") & "&dia=" & Request("dia") & "&itens=" & totalfator & "&pagina=" & i2 & "&pesqsa=" & pesqsa & "&cat=" & catege & " style=color:000000><font face=tahoma style=font-size:11px>"

If paginadem = i Then
strTextoHtml = strTextoHtml & "<b><u>"
End If

strTextoHtml = strTextoHtml & Replace(i, ",", "") & "</u></b></a> &middot;</font>"

Next
End If
pagina2 = pagina * 20 - 20
pagina2 = Replace(pagina2, ",", "")
pagina3 = pagina - 1
pagina3 = Replace(pagina3, ",", "")

strTextoHtml = strTextoHtml & "&nbsp;<a HREF=""?link=compras&acao=ver&ano=" & Request("ano") & "&data=" & Request("data") & "&mes=" & Request("mes") & "&dia=" & Request("dia") & "&itens=" & pagina2 & "&pagina=" & pagina3 & "&pesqsa=" & pesqsa & "&cat=" & catege & "&final=sim"" style=""color:000000""><font face=""tahoma"" style=font-size:11px>"

If finalera = "sim" Then
strTextoHtml = strTextoHtml & "<b><u>"
End If

strTextoHtml = strTextoHtml & pagina & "</u></b></a></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font><br><br></td></tr></table>"

else

pag = request.querystring("pagina")
if pag = "" Then
   pag = 1
end if

contador = 0
rs.absolutepage = pag
while not rs.eof and contador < rs.pagesize
contador = contador +1

iz = iz + 1
Select Case rs("estadoentrega")
Case "AC"
estadoz = "Acre"
Case "AL"
estadoz = "Alagoas"
Case "AP"
estadoz = "Amapá"
Case "AM"
estadoz = "Amazonas"
Case "BA"
estadoz = "Bahia"
Case "CE"
estadoz = "Ceará"
Case "DF"
estadoz = "Distrito Federal"
Case "ES"
estadoz = "Espirito Santo"
Case "GO"
estadoz = "Goiás"
Case "MA"
estadoz = "Maranhão"
Case "MT"
estadoz = "Mato Grosso"
Case "MS"
estadoz = "Mato Grosso do Sul"
Case "MG"
estadoz = "Minas Gerais"
Case "PA"
estadoz = "Pará"
Case "PB"
estadoz = "Paraiba"
Case "PR"
estadoz = "Parana"
Case "PE"
estadoz = "Pernambuco"
Case "PI"
estadoz = "Piauí"
Case "RJ"
estadoz = "Rio de Janeiro"
Case "RN"
estadoz = "Rio Grande do Norte"
Case "RS"
estadoz = "Rio Grande do Sul"
Case "RO"
estadoz = "Rondônia"
Case "RR"
estadoz = "Roraima"
Case "SC"
estadoz = "Santa Catarina"
Case "SP"
estadoz = "São Paulo"
Case "SE"
estadoz = "Sergipe"
Case "TO"
estadoz = "Tocantins"
End Select

on error resume next

Set rs3 = conexao.Execute("select * from clientes where email='" & rs("clienteid") & "';")


If rs("status")= "0" Then
estatus_cliente = "Aguardando confirmação de pagamento"
End If
If rs("status") = "1" Then
estatus_cliente = "Pagamento confirmado e Processar Compra"
End If
If rs("status") = "2" Then
estatus_cliente = "Compra enviada, com envio de email informando ao cliente"
End If
If rs("status") = "3" Then
estatus_cliente = "Compra já entregue"
End If
If rs("status") = "4" Then
estatus_cliente = "Pagamento cancelado, com envio de email confirmando ao cliente"
End If
If rs("status") = "5" Then
estatus_cliente = "Pagamento Negada, com envio de email informando ao cliente"
End If
If rs("status") = "6" Then
estatus_cliente = "Pagamento cancelado, com envio de email informando ao cliente para entrar em contato"
End If

strTextoHtml = strTextoHtml & "<tr><td align=left valign=center>" & vbNewLine
strTextoHtml = strTextoHtml & "<script language=""javascript"">" & vbNewLine
strTextoHtml = strTextoHtml & "function compra" & rs("idcompra") & "(){" & vbNewLine
strTextoHtml = strTextoHtml & "if (confirm('Você realmente deseja excluir esta compra?'))" & vbNewLine
strTextoHtml = strTextoHtml & "{" & vbNewLine
strTextoHtml = strTextoHtml & "window.location.href('?link=compras&acao=excluir&compra=" & rs("idcompra") & "&ano=" & Request("ano") & "&data=" & Request("data") & "&mes=" & Request("mes") & "&dia=" & Request("dia") & "');" & vbNewLine
strTextoHtml = strTextoHtml & "}" & vbNewLine
strTextoHtml = strTextoHtml & "else" & vbNewLine
strTextoHtml = strTextoHtml & "{" & vbNewLine
strTextoHtml = strTextoHtml & "}}" & vbNewLine
strTextoHtml = strTextoHtml & "</script>" & vbNewLine
strTextoHtml = strTextoHtml & "<table width=563 bgcolor=#eeeeee style='border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;'><tr><td valign=center><font face=""tahoma"" style=font-size:11px;color:000000>" & iz & ") Compra #"&rs("pedido")&" feita por: <b>" & UCase(Cripto(rs3("nome"),false)) & "</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Frete para: <b>" & estadoz & "</b> &nbsp;&nbsp;&nbsp;Total da compra: <font color=#b23c04><b>R$ " & FormatNumber(-1 + Cripto(rs("totalcompra"),false) + Cripto(rs("frete"),false) + 1, 2) & "</b></font><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Status: <font color=#b23c04><b> " & estatus_cliente & "</b></font></td><td align=right valign=center><font face=""tahoma"" style=font-size:11px;color:000000>Ação: <b><a href=?link=compras&acao=olhar&compra=" & rs("idcompra") & "&ano=" & Request("ano") & "&data=" & Request("data") & "&mes=" & Request("mes") & "&dia=" & Request("dia") & ">Ver</a></b> | <b><a href=""javascript: compra" & rs("idcompra") & "();"">Excluir</a></b>&nbsp;</td></tr></table> <table><tr><td height=4></td></tr></table>"

rs.movenext
wend

strTextoHtml = strTextoHtml & "<center><br>"

strTextoHtml = strTextoHtml & "<table width=100% cellspacing=""0"" cellpadding=""0""><tr><td colspan=2>"
strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc width=""101%""></td></tr><tr><td colspan=2 align=right><font face=""tahoma"" style=font-size:11px;color:000000>"

strTextoHtml = strTextoHtml & "Página(s):&nbsp;&nbsp;"

for i = 1 to rs.pagecount

if i = cint(pag) then
   strTextoHtml = strTextoHtml & "<u><b>" & i & "</b></u> "
else
   strTextoHtml = strTextoHtml & "<a href='?link=compras&acao=ver&ano=" & Request("ano") & "&data=" & Request("data") & "&mes=" & Request("mes") & "&dia=" & Request("dia") & "&acaba=sim&pagina=" & i & "'>" & i & "</a> "
end if

next

strTextoHtml = strTextoHtml & "</td></tr><tr><td colspan=2><hr size=1 color=cccccc width=""101%""></td></tr></table></table></table></table>"
end if

rs.Close
Set rs = Nothing
End If
Case "excluir"
notz = Request.QueryString("compra")

Set exc_compras = conexao.Execute("delete * from compras where idcompra=" & notz & ";")

'Sem esta rotina, aparece "carrinhos-fantasmas" ...
Set exc_pedidos = conexao.Execute("delete * from pedidos where idcompra='" & notz & "';")

Response.Redirect "?link=compras&acao=ver&ano=" & Request("ano") & "&data=" & Request("data") & "&mes=" & Request("mes") & "&dia=" & Request("dia") & "&status=sucesso"
Case "olhar"
If VersaoDb = 1 then
   Set rs = conexao.Execute("select * from compras where idcompra='" & Request("compra") & "';")
   Set rs3 = conexao.Execute("select clienteid, nome, email from clientes where email='" & rs("clienteid") & "';")
else
   Set rs = conexao.Execute("select * from compras where idcompra=" & Request("compra"))
   Set rs3 = conexao.Execute("select * from clientes where email='" & rs("clienteid") & "'")
end if

strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/comp_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Ver detalhes da compra efetuada na loja</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=compras&acao=ver&acaba=sim&dia=" & Request("dia") & "&mes=" & Request("mes") & "&ano=" & Request("ano") & "&data=" & Request("data") & """>Voltar e ver mais compras</a></b></center>"
strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc>"
strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#000000 style=font-size:11px>Compra efetuada pelo cliente: <b><a href=""?link=clientes&acao=olhar&cli=" & rs3("clienteid") & """><u>" & Cripto(rs3("nome"),False) & "</u></a></b><br>"
strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#000000 style=font-size:11px>Pedido n<sup>o</sup> : <b>#" & rs("pedido") & "</b><br><br>"

Select Case rs("estadoentrega")
Case "AC"
estadoz = "Acre"
Case "AL"
estadoz = "Alagoas"
Case "AP"
estadoz = "Amapá"
Case "AM"
estadoz = "Amazonas"
Case "BA"
estadoz = "Bahia"
Case "CE"
estadoz = "Ceará"
Case "DF"
estadoz = "Distrito Federal"
Case "ES"
estadoz = "Espirito Santo"
Case "GO"
estadoz = "Goiás"
Case "MA"
estadoz = "Maranhão"
Case "MT"
estadoz = "Mato Grosso"
Case "MS"
estadoz = "Mato Grosso do Sul"
Case "MG"
estadoz = "Minas Gerais"
Case "PA"
estadoz = "Pará"
Case "PB"
estadoz = "Paraiba"
Case "PR"
estadoz = "Parana"
Case "PE"
estadoz = "Pernambuco"
Case "PI"
estadoz = "Piauí"
Case "RJ"
estadoz = "Rio de Janeiro"
Case "RN"
estadoz = "Rio Grande do Norte"
Case "RS"
estadoz = "Rio Grande do Sul"
Case "RO"
estadoz = "Rondônia"
Case "RR"
estadoz = "Roraima"
Case "SC"
estadoz = "Santa Catarina"
Case "SP"
estadoz = "São Paulo"
Case "SE"
estadoz = "Sergipe"
Case "TO"
estadoz = "Tocantins"
End Select

strTextoHtml = strTextoHtml & "<b>STATUS DA COMPRA EFETUADA:</b><hr size=1 color=000000>"
strTextoHtml = strTextoHtml & "<table width=""100%"" ><tr><td><font face=tahoma style=font-size:11px;color:000000>Status da compra:</td><td align=right><font face=tahoma style=font-size:11px;color:000000><form action=""?"" method=get><input name=""link"" type=""hidden"" value=""compras""><input name=""acao"" type=""hidden"" value=""modificar""><input name=""compra"" type=""hidden"" value=""" & Request("compra") & """><input name=""dia"" type=""hidden"" value=""" & Request("dia") & """><input name=""data"" type=""hidden"" value=""" & Request("data") & """><input name=""mes"" type=""hidden"" value=""" & Request("mes") & """><input name=""ano"" type=""hidden"" value=""" & Request("ano") & """><select name=""status"" style=font-size:11px;color:000000;font-family:tahoma;font-weight:bold>"

strTextoHtml = strTextoHtml & "<option value=""0"" "
If CStr(rs("status")) = CStr("0") Then
strTextoHtml = strTextoHtml & "style='color:b23c04' SELECTED"
End If
strTextoHtml = strTextoHtml & ">Aguardando confirmação de pagamento"

strTextoHtml = strTextoHtml & "<option value=""1"" "
If CStr(rs("status")) = CStr("1") Then
strTextoHtml = strTextoHtml & "style='color:b23c04' SELECTED"
End If
strTextoHtml = strTextoHtml & ">Pagamento confirmado e Processar Compra"

strTextoHtml = strTextoHtml & "<option value=""2"" "
If CStr(rs("status")) = CStr("2") Then
strTextoHtml = strTextoHtml & "style='color:b23c04' SELECTED"
End If
strTextoHtml = strTextoHtml & ">Compra já enviada ao cliente"

strTextoHtml = strTextoHtml & "<option value=""3"" "
If CStr(rs("status")) = CStr("3") Then
strTextoHtml = strTextoHtml & "style='color:b23c04' SELECTED"
End If
strTextoHtml = strTextoHtml & ">Compra Já Entregue"

strTextoHtml = strTextoHtml & "<option value=""4"" "
If CStr(rs("status")) = CStr("4") Then
strTextoHtml = strTextoHtml & "style='color:b23c04' SELECTED"
End If
strTextoHtml = strTextoHtml & ">Compra Cancelada"

strTextoHtml = strTextoHtml & "<option value=""5"" "
If CStr(rs("status")) = CStr("5") Then
strTextoHtml = strTextoHtml & "style='color:b23c04' SELECTED"
End If
strTextoHtml = strTextoHtml & ">Compra Negada"
 
 strTextoHtml = strTextoHtml & "<option value=""6"" "
If CStr(rs("status")) = CStr("6") Then
strTextoHtml = strTextoHtml & "style='color:b23c04' SELECTED"
End If
strTextoHtml = strTextoHtml & ">Outras - Contate o Atendimento"
 
strTextoHtml = strTextoHtml & "</select> <input type=""submit"" style=font-size:11px;color:000000;font-family:tahoma value=""Modificar""></td></tr></table>"
strTextoHtml = strTextoHtml & "<br><b>DADOS PARA ENTREGA DO PEDIDO:</b><hr size=1 color=000000><table width=""100%"">"
strTextoHtml = strTextoHtml & "<tr><td bgcolor=#eeeeee><FONT face=tahoma color=#000000 style=font-size:11px>Data da compra: </b></td><td  bgcolor=#eeeeee> <FONT face=tahoma color=#b23c04 style=font-size:11px><b>" & rs("datacompra") & "</b></td></tr>"

estimativa = CDate(rs("datacompra")) + 10
If Mid(estimativa, 2, 1) = "/" Then
estimativa = "0" & estimativa
Else
estimativa = estimativa
End If
If Mid(estimativa, 5, 1) = "/" Then
estimativa = Mid(estimativa, 1, 3) & "0" & Mid(estimativa, 4, 99)
Else
estimativa = estimativa
End If

strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma color=#000000 style=font-size:11px>Estimativa para entrega: </b></td><td> <FONT face=tahoma color=#b23c04 style=font-size:11px><b>" & estimativa & "</b></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td bgcolor=#eeeeee><FONT face=tahoma color=#000000 style=font-size:11px>Endereço:</b></td><td bgcolor=#eeeeee> <FONT face=tahoma color=#b23c04 style=font-size:11px><b>" & Cripto(rs("endentrega"),false) & "</b></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma color=#000000 style=font-size:11px>Bairro:</b></td><td> <FONT face=tahoma color=#b23c04 style=font-size:11px><b>" & Cripto(rs("bairroentrega"),false) & "</b></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td bgcolor=#eeeeee><FONT face=tahoma color=#000000 style=font-size:11px>Cidade:</b></td><td bgcolor=#eeeeee> <FONT face=tahoma color=#b23c04 style=font-size:11px><b>" & Cripto(rs("cidadeentrega"),false) & "</b></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma color=#000000 style=font-size:11px>Estado: </b></td><td> <FONT face=tahoma color=#b23c04 style=font-size:11px><b>" & estadoz & "</b></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td bgcolor=#eeeeee><FONT face=tahoma color=#000000 style=font-size:11px>País: </b></td><td bgcolor=#eeeeee> <FONT face=tahoma color=#b23c04 style=font-size:11px><b>Brasil</b></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma color=#000000 style=font-size:11px>CEP: </b></td><td> <FONT face=tahoma color=#b23c04 style=font-size:11px><b>" & Cripto(rs("cepentrega"),false) & "</b></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td bgcolor=#eeeeee><FONT face=tahoma color=#000000 style=font-size:11px>Telefone: </b></td><td bgcolor=#eeeeee> <FONT face=tahoma color=#b23c04 style=font-size:11px><b>" & Cripto(rs("telentrega"),false) & "</b></td></tr>"
strTextoHtml = strTextoHtml & "</table>"

if Cstr(rs("presente")) = Cstr("Sim") then
strTextoHtml = strTextoHtml & "<br>"
strTextoHtml = strTextoHtml & "<b>MENSAGEM NO CARTÃO PRESENTE:</b><hr size=1 color=000000>"
strTextoHtml = strTextoHtml & "<table width=""100%""><tr><td width=15><font face=tahoma style=font-size:11px;color:000000>Mensagem:</td><td><font face=tahoma style=font-size:11px;color:#003366><b>" & rs("msgpresente") & "</b></td></tr></table>"
end if

strTextoHtml = strTextoHtml & "<br><b>DADOS DA COMPRA E PAGAMENTO:</b><hr size=1 color=000000>"
strTextoHtml = strTextoHtml & "<table width=""100%"">"
strTextoHtml = strTextoHtml & "</form><tr><td bgcolor=003366><font face=tahoma style=font-size:11px;color:ffffff>&nbsp;Cód.</b></td>"
strTextoHtml = strTextoHtml & "<td bgcolor=003366><font face=tahoma style=font-size:11px;color:ffffff>&nbsp;Produto</b></td>"
strTextoHtml = strTextoHtml & "<td bgcolor=003366><font face=tahoma style=font-size:11px;color:ffffff>&nbsp;Quant.</b></td>"
strTextoHtml = strTextoHtml & "<td bgcolor=003366><font face=tahoma style=font-size:11px;color:ffffff>&nbsp;Valor Unit.</b></td>"
strTextoHtml = strTextoHtml & "<td bgcolor=003366><font face=tahoma style=font-size:11px;color:ffffff>&nbsp;Valor Total</b></td>"
strTextoHtml = strTextoHtml & "</tr>"


Set rs10 = conexao.execute("SELECT * FROM pedidos WHERE idcompra = '" & Request("compra") & "';")
If rs10.EOF Then
Else
While Not rs10.EOF

Set prod = conexao.Execute("select * from produtos where idprod = " & rs10("idprod") & ";")
If prod.bof Or prod.EOF Then
strTextoHtml = strTextoHtml & "<tr><td align=center><font face=tahoma style=font-size:11px;color:000000>#</td><td colspan=4><font face=tahoma style=font-size:11px;color:000000>O produto comprado não estão mais presente na loja</b></center>"
Else
codigo = prod("idprod")
prodnome = prod("nome")
preconormal = prod("preco")
quantidade = rs10("quantidade")
subpreco = FormatNumber(preconormal, 2)
totpreco = FormatNumber((quantidade * preconormal), 2)

strTextoHtml = strTextoHtml & "<tr><td align=center><font face=tahoma style=font-size:11px;color:000000>" & codigo & "</td>"
strTextoHtml = strTextoHtml & "<td><a href=""produtos.asp?produto="&codigo&""" target=""_blank""><font face=tahoma style=font-size:11px;color:000000><u>" & prodnome & "</u></a></td>"
strTextoHtml = strTextoHtml & "<td align=center><font face=tahoma style=font-size:11px;color:000000>" & quantidade & "</td>"
strTextoHtml = strTextoHtml & "<td align=right><font face=tahoma style=font-size:11px;color:000000>R$ " & subpreco & "</td>"
strTextoHtml = strTextoHtml & "<td align=right><font face=tahoma style=font-size:11px;color:000000>R$ " & totpreco & "</td></tr>"
End if
rs10.movenext
Wend
rs10.Close
End If

totalcompra = Cripto(rs("totalcompra"),false)
totalfrete = Cripto(rs("frete"),false)
Status = rs("status")
pagamento = rs("pagamentovia")
intcomprasz = totalcompra + 1 + totalfrete - 1
comprasz = intcomprasz
comprasz = Replace(comprasz, "-", "")
data = rs("datacompra")
Select Case pagamento
Case "0"
ver = "Cartão de Crédito - Visa"
Case "1"
ver = "Cartão de Crédito - Mastercard"
Case "2"
ver = "Cartão de Crédito - Dinners"
Case "3"
ver = "Cartão de Crédito - American Express"
Case "4"
ver = "SEDEX à cobrar"
Case "5"
ver = "Depósito Bancário"
Case "6"
ver = "Transferência Eletrônica"
Case "7"
ver = "Boleto Bancário"

End Select
If Status = "0" Then
estatus = "Aguardando confirmação de pagamento"
	If pagamento = "0" or pagamento = "1" or pagamento = "2" or pagamento = "3" or pagamento = "4" Then
	ver2 = "Aguardando confirmação com a operadora do cartão de credito"
	Else
	ver2 = "Aguardando confirmação de pagamento"
	End If
End If
If Status = "1" Then
estatus = "Pagamento confirmado e Compra em processamento"
	If pagamento = "0" or pagamento = "1" or pagamento = "2" or pagamento = "3" or pagamento = "4" Then
	ver2 = "Pagamento confirmado com a operadora do cartão de credito, com envio de email informando ao cliente"
	Else
	ver2 = "Pagamento confirmado, com envio de email informando ao cliente"
	End If
End If
If Status = "2" Then
estatus = "Compra já enviada ao cliente"
ver2 = "Compra enviada, com envio de email informando ao cliente"
End If
If Status = "3" Then
estatus = "Compra já Entregue"
ver2 = "Compra já entregue"
End If
If Status = "4" Then
estatus = "Compra Cancelada"
ver2 = "Pagamento cancelado, com envio de email confirmando ao cliente"
End If
If Status = "5" Then
estatus = "Compra Negada"
ver2 = "Pagamento cancelado, com envio de email informando ao cliente"
End If
If Status = "6" Then
estatus = "Outras - Contate o Atendimento"
ver2 = "Pagamento ou Compra com problemas, com envio de email informando ao cliente para entrar em contato"
End If

comprazw = FormatNumber(comprasz, 2)
totalfretezw = FormatNumber(totalfrete, 2)
totalcomprazw = FormatNumber(totalcompra, 2)

select case pagamento
case 0,1,2,3
   strInf = "<tr><td><font face=tahoma style=font-size:11px;color:000000>Número do Cartão</td><td align=right><font face=tahoma style=font-size:11px;color:000000><b>" & Cripto(rs("numero"),false) & "</b></td>"
   strInf = strInf & "<tr><td><font face=tahoma style=font-size:11px;color:000000>Código de Segurança</td><td align=right><font face=tahoma style=font-size:11px;color:000000><b>" & Cripto(rs("codigo_seguranca"),false) & "</b></td>"
   strInf = strInf & "<tr><td><font face=tahoma style=font-size:11px;color:000000>Vencimento</td><td align=right><font face=tahoma style=font-size:11px;color:000000><b>" & Cripto(rs("vencimento"),false) & "</b></td>"
   strInf = strInf & "<tr><td><font face=tahoma style=font-size:11px;color:000000>Titular do Cartão</td><td align=right><font face=tahoma style=font-size:11px;color:000000><b>" & Cripto(rs("titular"),false) & "</b></td>"   
case else
   strInf = ""
end select

strTextoHtml = strTextoHtml & "</table><hr size=1 color=cccccc width=""100%""><table width=""100%""><tr><td><font face=tahoma style=font-size:11px;color:000000>Sub-total</td><td align=right><font face=tahoma style=font-size:11px;color:000000><b>R$ " & totalcomprazw & "</b></td>"
strTextoHtml = strTextoHtml & "</tr></table><table width=""100%""><tr><td><font face=tahoma style=font-size:11px;color:000000>Frete</td>"
strTextoHtml = strTextoHtml & "<td align=right><font face=tahoma style=font-size:11px;color:000000><b>R$ " & totalfretezw & "</b></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td><font face=tahoma style=font-size:11px;color:000000>Valor total da compra</td><td align=right><font face=tahoma style=font-size:11px;color:000000><b>R$ " & comprazw & "</b></td>"
strTextoHtml = strTextoHtml & "</tr></table><hr size=1 color=cccccc width=""100%""><table width=""100%""><tr><td><font face=tahoma style=font-size:11px;color:000000>Forma de Pagamento</td><td align=right><font face=tahoma style=font-size:11px;color:b23c04><b>" & ver & "</b></td></tr>" & strInf
strTextoHtml = strTextoHtml & "<tr><td><font face=tahoma style=font-size:11px;color:000000>Status Visível p/ o Cliente</td><td align=right><font face=tahoma style=font-size:11px;color:b23c04><b>" & ver2 & "</b></td></tr></table>"
strTextoHtml = strTextoHtml & "<center><br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br>"


Case "modificar"
notz = Request.QueryString("compra")
Status = Request.QueryString("status")


Set dados = conexao.Execute("UPDATE compras SET status = '" & Status & "' WHERE idcompra = " & notz & ";")

'Chama os dados da compra

set compra = conexao.Execute("SELECT compras.*,clientes.nome from compras,clientes WHERE compras.clienteid=clientes.email and compras.idcompra="&notz&"")
If compra.EOF Then
Else
strEndereco = Cripto(compra("endentrega"),false)
strBairro = Cripto(compra("bairroentrega"),false)
strCidade = Cripto(compra("cidadeentrega"),false)
strEstado = compra("estadoentrega")
strCep = Cripto(compra("cepentrega"),false)
strPais = compra("paisentrega")
strFone = Cripto(compra("telentrega"),false)
strNome = Cripto(compra("clienteid"),false)
strDataCompra = compra("datacompra")
strCompra = compra("pedido")
strNomeCompleto = Cripto(compra("nome"),false)

end if
compra.close
set compra = nothing


	select case Status
	
	Case "1"

'*** Inicio da Msg especifica de Pedido em processamento
conteudo_strMensagem = "      <DIV><FONT face="&fonte&" style='FONT-SIZE: 11px'>Obrigado por comprar na" 
conteudo_strMensagem = conteudo_strMensagem & " "&nomeloja&"!<BR>Seu pagamento foi confirmado e o seu pedido de No. <STRONG>#"&strCompra&"" 
conteudo_strMensagem = conteudo_strMensagem & " </STRONG> está sendo processado. Estaremos despachando prontamente todos os itens disponíveis em estoque. Assim que o seu pedido sair para entrega, você receberá um outro email nosso avisando que está sendo enviado o seu pedido.</FONT></DIV>"

titulo_strMensagem = "Confirmação de Pagamento e Processamento de pedido na "&nomeloja&""
'*** Fim da Msg especifica de Pedido em processamento

	Case "2"

'*** Inicio da Msg especifica de Compra já enviada ao cliente
conteudo_strMensagem = "      <DIV><FONT face="&fonte&" style='FONT-SIZE: 11px'>Obrigado por comprar na" 
conteudo_strMensagem = conteudo_strMensagem & " "&nomeloja&"!<BR>Esta é a confirmação de remessa do seu pedido de No. <STRONG>#"&strCompra&"" 
conteudo_strMensagem = conteudo_strMensagem & " </STRONG>.<br><br> É com satisfação que informamos que estarão sendo entregues o(s) produto(s) mencionado(s) abaixo. O(s) mesmo(s) deverá(ão) ser entregue(s) em um  prazo que varia normalmente de 1 a 2 dias  úteis.</FONT></DIV>"

titulo_strMensagem = "Confirmação de Envio do seu pedido na "&nomeloja&""
'*** Fim da Msg especifica de Compra já enviada ao cliente

	Case "4"

'*** Inicio da Msg especifica de Compra Cancelada
conteudo_strMensagem = "      <DIV><FONT face="&fonte&" style='FONT-SIZE: 11px'>A sua Compra foi Cancelada na" 
conteudo_strMensagem = conteudo_strMensagem & " "&nomeloja&"<BR><br>Por motivos administrativos, o seu pedido de No. <STRONG>#"&strCompra&"" 
conteudo_strMensagem = conteudo_strMensagem & " </STRONG> foi cancelado.<br><br> Entre em contato conosco para sanar quaisquer dúvidas referente ao seu pedido.</FONT></DIV>"

titulo_strMensagem = "Referente a sua compra cancelada na "&nomeloja&""
'*** Fim da Msg especifica de Compra Cancelada

	Case "5"

'*** Inicio da Msg especifica de Compra Negada
conteudo_strMensagem = "      <DIV><FONT face="&fonte&" style='FONT-SIZE: 11px'>A sua Compra foi recusada na" 
conteudo_strMensagem = conteudo_strMensagem & " "&nomeloja&"<BR><br>Por motivos administrativos, o seu pedido de No. <STRONG>#"&strCompra&"" 
conteudo_strMensagem = conteudo_strMensagem & " </STRONG> foi recusado.<br><br> Entre em contato conosco para sanar quaisquer dúvidas referente ao seu pedido.</FONT></DIV>"

titulo_strMensagem = "Referente a sua compra na "&nomeloja&""
'*** Fim da Msg especifica de Compra Negada

	Case "6"

'*** Inicio da Msg especifica de Outras - Contate o Atendimento
conteudo_strMensagem = "      <DIV><FONT face="&fonte&" style='FONT-SIZE: 11px'>Referente a sua Compra na " 
conteudo_strMensagem = conteudo_strMensagem & " "&nomeloja&"!<BR><br>Prezado Cliente, por motivos administrativos, solicitamos que entre em contato conosco, referente ao seu pedido de No. <STRONG>#"&strCompra&"" 
conteudo_strMensagem = conteudo_strMensagem & " </STRONG>.<br><br> Aguardamos o seu breve contato.</FONT></DIV>"

titulo_strMensagem = "Referente ao seu pedido na "&nomeloja&""
'*** Fim da Msg especifica de Outras - Contate o Atendimento

	end select


if Status = "1" or Status = "2" or Status = "4" or Status = "5" or Status = "6" then
	
	'*** Cabeçalho do Email para avisar o cliente da mudança de Status
	
	cabecalho_strMensagem = "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>"
	cabecalho_strMensagem = cabecalho_strMensagem & "<HTML><HEAD>"
	cabecalho_strMensagem = cabecalho_strMensagem & "<META content='text/html; charset=iso-8859-1' http-equiv=Content-Type>"
	cabecalho_strMensagem = cabecalho_strMensagem & "<META content='MSHTML 5.00.2614.3500' name=GENERATOR></HEAD>"
	cabecalho_strMensagem = cabecalho_strMensagem & "<BODY>"
	cabecalho_strMensagem = cabecalho_strMensagem & "<DIV align=justify>"
	cabecalho_strMensagem = cabecalho_strMensagem & "<TABLE border=0 cellSpacing=0 width='98%'>"
	cabecalho_strMensagem = cabecalho_strMensagem & "  <TBODY>"
	cabecalho_strMensagem = cabecalho_strMensagem & "  <TR>"
	cabecalho_strMensagem = cabecalho_strMensagem & "    <TD colSpan=4 height=42>"
	cabecalho_strMensagem = cabecalho_strMensagem & "      <DIV align=center><font face="&fonte&"><B><FONT style=font-size:17px color=000000>"&nomeloja&"</FONT></B><BR><FONT style=font-size:11px>"&endereco11&" - "&bairro11&"<BR>"&cidade11&"/"&estado11&" - "&pais11&" - <a href='mailto:"&emailloja&"'>"&emailloja&"<BR></FONT></DIV></FONT></TD></TR>"
	cabecalho_strMensagem = cabecalho_strMensagem & "  <TR>"
	cabecalho_strMensagem = cabecalho_strMensagem & "    <TD colSpan=4><FONT face="&fonte&">"
	cabecalho_strMensagem = cabecalho_strMensagem & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
	cabecalho_strMensagem = cabecalho_strMensagem & "     </FONT></TD></TR>"
	cabecalho_strMensagem = cabecalho_strMensagem & "  <TR>"
	cabecalho_strMensagem = cabecalho_strMensagem & "    <TD align=left colSpan=2><FONT face="&fonte&"><FONT color=#000000" 
	cabecalho_strMensagem = cabecalho_strMensagem & "      style='FONT-SIZE: 11px'><B>Compra de "&strNomeCompleto&"</B></FONT>" 
	cabecalho_strMensagem = cabecalho_strMensagem & "      </FONT>"
	cabecalho_strMensagem = cabecalho_strMensagem & "    <TD align=right colSpan=2><B><FONT face="&fonte&"><FONT color=#000000" 
	cabecalho_strMensagem = cabecalho_strMensagem & "      style='FONT-SIZE: 11px'>Data: </B>"&strDataCompra&" </FONT>"
	cabecalho_strMensagem = cabecalho_strMensagem & "      <DIV></DIV></FONT></TD></TR>"
	cabecalho_strMensagem = cabecalho_strMensagem & "  <TR>"
	cabecalho_strMensagem = cabecalho_strMensagem & "    <TD colSpan=4>"
	cabecalho_strMensagem = cabecalho_strMensagem & "      <DIV><FONT face="&fonte&">"
	cabecalho_strMensagem = cabecalho_strMensagem & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
	cabecalho_strMensagem = cabecalho_strMensagem & "      </FONT></DIV>"
	
	
	'*** Rodape do Email para avisar o cliente da mudança de Status
	
	rodape_strMensagem = "      <DIV><FONT face="&fonte&">"
	rodape_strMensagem = rodape_strMensagem & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
	rodape_strMensagem = rodape_strMensagem & "      </FONT><FONT face="&fonte&"><FONT color=#000000" 
	rodape_strMensagem = rodape_strMensagem & "      style='FONT-SIZE: 11px'>&nbsp; </DIV>"
	rodape_strMensagem = rodape_strMensagem & "      <DIV align=left><FONT face="&fonte&" style='FONT-SIZE: 11px'><FONT" 
	rodape_strMensagem = rodape_strMensagem & "      face="&fonte&" size=2>&nbsp;</FONT></FONT></DIV>"
	rodape_strMensagem = rodape_strMensagem & "      <DIV align=left><FONT face="&fonte&" style='FONT-SIZE: 11px'><STRONG>Seu" 
	rodape_strMensagem = rodape_strMensagem & "      Pedido</STRONG></FONT></FONT></FONT><FONT face="&fonte&" "
	rodape_strMensagem = rodape_strMensagem & "      style='FONT-SIZE: 11px'><BR><BR></DIV></DIV></FONT></TD></TR>"
	rodape_strMensagem = rodape_strMensagem & "  <TR>"
	rodape_strMensagem = rodape_strMensagem & "    <TD colSpan=2><FONT face="&fonte&"><FONT color=#000000 style='COLOR: #000000; FONT-SIZE: 11px'><B>Endereço:" 
	rodape_strMensagem = rodape_strMensagem & "      </B>"&strEndereco&"<BR><B>Bairro: </B>"&strBairro&" "
	rodape_strMensagem = rodape_strMensagem & "      <BR><B>Local:</B> "&strCidade&"-"&strEstado&" </FONT></FONT></TD>"
	rodape_strMensagem = rodape_strMensagem & "    <TD colSpan=2><FONT face="&fonte&"><FONT color=#000000 style='COLOR: #000000; FONT-SIZE: 11px'><B>CEP:</B>" 
	rodape_strMensagem = rodape_strMensagem & "      "&strCep&" <BR><B>País:</B> "&strPais&" <BR><B>Telefone:</B> "&strFone&" "
	rodape_strMensagem = rodape_strMensagem & "      </FONT></FONT></TD></TR>"
	rodape_strMensagem = rodape_strMensagem & "<tr><td><br></td></tr>"
	
	rodape_strMensagem = rodape_strMensagem & "  <TR bgColor="&cor3&">"
	rodape_strMensagem = rodape_strMensagem & "    <TD align=left noWrap vAlign=center width='15%'><FONT color=#000000" 
	rodape_strMensagem = rodape_strMensagem & "      face="&fonte&" style='COLOR: #000000; FONT-SIZE: 11px' "
	rodape_strMensagem = rodape_strMensagem & "      style='BACKGROUND-COLOR: "&cor3&"'><STRONG>Quantidade<STRONG></FONT></STRONG></STRONG></TD>"
	rodape_strMensagem = rodape_strMensagem & "    <TD align=left noWrap vAlign=center width='44%'><FONT color=#000000 "
	rodape_strMensagem = rodape_strMensagem & "      face="&fonte&" style='COLOR: #000000; FONT-SIZE: 11px' "
	rodape_strMensagem = rodape_strMensagem & "      style='BACKGROUND-COLOR: "&cor3&"'><STRONG>Produto<STRONG></FONT></STRONG></STRONG></TD>"
	rodape_strMensagem = rodape_strMensagem & "    <TD align=left vAlign=center width='16%'><FONT color=#000000 face="&fonte&" "
	rodape_strMensagem = rodape_strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px' style='BACKGROUND-COLOR: "&cor3&"'><STRONG>Preço "
	rodape_strMensagem = rodape_strMensagem & "      Unitário<STRONG></FONT></STRONG></STRONG></TD>"
	rodape_strMensagem = rodape_strMensagem & "    <TD align=right noWrap vAlign=center width='25%'><FONT color=#000000" 
	rodape_strMensagem = rodape_strMensagem & "      face="&fonte&" style='COLOR: #000000; FONT-SIZE: 11px' style='BACKGROUND-COLOR: "&cor3&"'><STRONG>Preço" 
	rodape_strMensagem = rodape_strMensagem & "      Total<STRONG></FONT></STRONG></STRONG></TD></TR>"
	
	'Chama os produtos comprados
	
	set pedidos = conexao.Execute("SELECT idprod, quantidade FROM pedidos WHERE idcompra='"&notz&"'")
	while not pedidos.EOF
	idprod = pedidos("idprod")
	quantidade = pedidos("quantidade")
	
	set produtos = conexao.Execute("SELECT preco, nome, peso FROM produtos WHERE idprod="&idprod&"")
	preco = produtos("preco")
	peso = produtos("peso")
	nome = produtos("nome")
	
	intProdID = idprod
	strProdNome = nome
	pesoz = peso
	intProdPric = preco
	intQuant = quantidade
	prodvalor = formatNumber(intProdPric,2)
	prodvalort = formatNumber((intQuant * intProdPric),2)
	
	rodape_strMensagem = rodape_strMensagem & "  <TR>"
	rodape_strMensagem = rodape_strMensagem & "    <TD align=left vAlign=center width='15%'><FONT face="&fonte&" size=2><FONT" 
	rodape_strMensagem = rodape_strMensagem & "      face="&fonte&" style='COLOR: #000000; FONT-SIZE: 11px'>"&intQuant&" </FONT></FONT></TD>"
	rodape_strMensagem = rodape_strMensagem & "   <TD align=left width='44%'><FONT face="&fonte&" "
	rodape_strMensagem = rodape_strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'>&nbsp;"&strProdNome&" </FONT></TD>"
	rodape_strMensagem = rodape_strMensagem & "    <TD align=right width='16%'><FONT face="&fonte&" "
	rodape_strMensagem = rodape_strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'>" & strLgMoeda & " " & prodvalor&" </FONT></TD>"
	rodape_strMensagem = rodape_strMensagem & "    <TD align=right width='25%'><FONT face="&fonte&" "
	rodape_strMensagem = rodape_strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'>" & strLgMoeda & " " &prodvalort&" </FONT></TD></TR>"
	
	pedidos.MoveNext
	wend
	pedidos.Close
	set pedidos = Nothing
	produtos.Close
	set produtos = Nothing
	
	rodape_strMensagem = rodape_strMensagem & "  <TR bgColor="&cor3&">"
	rodape_strMensagem = rodape_strMensagem & "    <TD colSpan=4 heigth='5'></TD>"
	
	'rodape_strMensagem = rodape_strMensagem & "  <TR>"
	'rodape_strMensagem = rodape_strMensagem & "    <TD colSpan=4></TD></TR>"
	rodape_strMensagem = rodape_strMensagem & "  <TR bgColor=#ffffff>"
	rodape_strMensagem = rodape_strMensagem & "    <TD colSpan=4><FONT color=#000000 style='FONT-SIZE: 11px'>"
	'rodape_strMensagem = rodape_strMensagem & "      <DIV align=left>&nbsp;</DIV>"
	rodape_strMensagem = rodape_strMensagem & "      <DIV align=left><FONT face=Arial size=2>"
	'rodape_strMensagem = rodape_strMensagem & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
	rodape_strMensagem = rodape_strMensagem & "      &nbsp;</FONT></DIV>"
	'rodape_strMensagem = rodape_strMensagem & "      <DIV>&nbsp;</DIV>"
	rodape_strMensagem = rodape_strMensagem & "      <DIV align=left><FONT face="&fonte&"><FONT" 
	rodape_strMensagem = rodape_strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'>Atenciosamente,<BR>Atendimento ao" 
	rodape_strMensagem = rodape_strMensagem & "      Cliente</FONT><BR></FONT></DIV></FONT></TD>"
	rodape_strMensagem = rodape_strMensagem & "  <TR>"
	rodape_strMensagem = rodape_strMensagem & "    <TD colSpan=4 vAlign=top>"
	rodape_strMensagem = rodape_strMensagem & "      <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor="&cor3&"></td></tr><tr><td height=5></td></tr></table>"
	rodape_strMensagem = rodape_strMensagem & "    </TD></TD>"
	rodape_strMensagem = rodape_strMensagem & "  <TR>"
	rodape_strMensagem = rodape_strMensagem & "    <TD colSpan=4><FONT face="&fonte&"><B><FONT style=font-size:13px>Equipe" 
	rodape_strMensagem = rodape_strMensagem & "      "&nomeloja&"</FONT></B><BR><FONT face="&fonte&" "
	rodape_strMensagem = rodape_strMensagem & "      style='COLOR: #000000; FONT-SIZE: 11px'><A "
	rodape_strMensagem = rodape_strMensagem & "      href='http://"&urlloja&"'>"&urlloja&"</A><BR><FONT" 
	rodape_strMensagem = rodape_strMensagem & "      face="&fonte&" style='COLOR: #000000; FONT-SIZE: 11px'><A "
	rodape_strMensagem = rodape_strMensagem & "      href='mailto:"&emailloja&"'>"&emailloja&"</A><BR></FONT></FONT></FONT></TD></TR></TBODY></TABLE></DIV></BODY></HTML>"
	
	
	'Monta e envia o e-mail
	
	strMensagem=cabecalho_strMensagem & conteudo_strMensagem & rodape_strMensagem
	
	'*** Em caso de testes para visualizar a msg enviado ao cliente (desabilite o comando EnviaEmail )
	'response.write "<br>HostLoja :"&Application("HostLoja")
	'response.write "<br>ComponenteLoja :"&Application("ComponenteLoja")
	'response.write "<br>emailloja :"&emailloja
	'response.write "<br>strNome :"&strNome
	'response.write "<br>titulo_strMensagem :"&titulo_strMensagem
	'response.write "<br>strMensagem :"&strMensagem
	'response.end
	
	EnviaEmail Application("HostLoja"), Application("ComponenteLoja"), emailloja, "", strNome, titulo_strMensagem , strMensagem
	
	'*** Fim do Envio de Email para avisar o cliente da mudança de Status

end if


Response.Redirect "?link=compras&acao=olhar&compra=" & notz & "&data=" & Request("data") & "&ano=" & Request("ano") & "&dia=" & Request("dia") & "&mes=" & Request("mes")


Case Else
Response.Redirect "?acaba=sim"
End Select

'End Sub
%>