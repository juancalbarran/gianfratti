<% response.buffer=false %>
<html>
<!-- #include file="config.asp" -->
<%

Session.Lcid = "1046"

'====== NÃO MEXER DAQUI PRA BAIXO =========

x101 = Request.QueryString("valordocumento")
x81 = Request.QueryString("numerodoc")
x33 = Request.QueryString("datavencimento")
x109 = Request.QueryString("sacador")
x70 = Request.QueryString("endereco")
x79 = Request.QueryString("bairro")
x74 = Request.QueryString("cep")
x67 = Request.QueryString("cidade")
x28 = Request.QueryString("estado")

x136= bol_cedente
x49 = ""
x10 = bol_carteira
x154 = bol_convenio
x83 = bol_agencia
x121 = bol_dagencia
x64 = bol_conta
x89 = x81
x72 = bol_dconta
x12= obs_linha1
x20= obs_linha2
x48= obs_linha3
x21= obs_linha4
x1= obs_linha5
x80= instr_linha1
x171= instr_linha2
x130= instr_linha3
x97= instr_linha4
x73= instr_linha5

x163="" ' Uso do Banco
x98="" ' Quantidade
x34= "R$" ' Especie
x174= "N" ' Aceite
x128 = "237"  ' Banco
x19 = "9" ' Moeda 
x160="R$" ' Especie 2


Function x32(x126, x13)
Dim x51, x27, x122, x150, x151, cnum
x126 = RTrim(LTrim(x126))
For x150 = 1 To Len(x126)
x151 = Mid(x126, x150, 1)
If IsNumeric(x151) Then
cnum = cnum & x151
End If
Next
x126 = cnum
x122 = "0000000000000000000000000000": x51 = CInt(x51)
If Len(x126) < x13 Then 
x51 = Abs(x13) - Abs(Len(x126)): x27 = Mid(x122, 1, x51) & CStr(x126)
x32 = x27
ElseIf Len(x126) > x13 Then
x32 = Right(x126, x13)
Else
x32 = x126
End If
End Function

Function x16(x15, x36, x94)
Dim x87, x69, x45
x45 = x36 + 1
x87 = ""
Do
If IsNumeric(Mid(x15, (x45), 1)) Then
x87 = x87 & Mid(x15, (x45), 1)
x45 = x45 + 1
End If
Loop While IsNumeric(Mid(x15, (x45), 1))
For x69 = 1 To x87
x94 = x94 & (x91(53))
Next
x36 = x36 + 2
x16 = x94
End Function

Function x14(x15)
Dim x36, x78, x60, x94
x94 = ""
For x36 = 1 To Len(x15)
x78 = 0
If Mid(x15, (x36), 1) = "¹" Then
x94 = x16(x15, x36, x94)
x78 = 0
End If
x78 = InStr(1, x135, Mid(x15, (x36), 1), vbBinaryCompare)
If x78 > 0 Then
   If x78 <= 113 Then
  x94 = x94 & (x91(x78 + 1))
   Else
  x94 = x94 & (x91(1))
  End If
End If
Next
x14 = x94 : response.write x14
End Function

Function x23(x15)
For x18 = 1 To Len(x15) Step 3
x78 = 0 : x78 = Mid(x15, (x18), 3) : x94 = x94 & x91(x78)
Next
x23 = x94 
End Function

Function x31(x36)
Dim x59, x30, x173, x68, x82, x120, x113
x68 = 2
For x59 = 1 To 43
x113 = Mid(Right(x36, x59), 1, 1)
If x68 > 9 Then
x68 = 2: x30 = 0
End If
x30 = x113 * x68: x173 = x173 + x30: x68 = x68 + 1
Next
x82 = x173 Mod 11
x120 = 11 - x82
If x120 = 0 Or x120 = 1 Or x120 > 9 Then
x31 = 1
Else
x31 = x120
End If
End Function

Function x102(x124)
Dim x59, x30, x173, x68, x82, x25
If Not IsNumeric(x124) Then
x102 = ""
Exit Function
End If
x68 = 2
For x59 = Len(x124) To 1 Step -1
x30 = CInt(Mid(x124, x59, 1)) * x68
If x30 > 9 Then
x30 = CInt(Left(x30, 1) + CInt(Right(x30, 1)))
End If
x173 = x173 + x30
If x68 = 2 Then
x68 = 1
Else
x68 = 2
End If
Next
x25 = (x173 / 10) * -1: x25 = Int([x25]) * -1: x25 = x25 * 10
x82 = x25 - x173: x102 = x82
End Function

Function x134(x124)
Dim x59, x30, x173, x68, x82, x170
If Not IsNumeric(x124) Then
x134 = ""
Exit Function
End If
x68 = 2
For x59 = Len(x124) To 1 Step -1
x30 = Mid(x124, x59, 1) * x68: x173 = x173 + x30
If x68 > 7 Then
x68 = 2
Else
x68 = x68 + 1
End If
If x68 = 8 Then x68 = 2
Next
x82 = x173 Mod 11
x134 = 11 - x82
If x82 = 1 Then
x134 = "P"
ElseIf x82 = 0 Then
x134 = "0"
End If
End Function

Function x77(x36, x66, x92, x142)
Dim x112, x55, x42, x65, x105, x87, x69, x45
x112 = Left(x36, 9): x55 = Mid(x36, 10, 10): x42 = Right(x36, 10)
x105 = CCur(x142): x65 = x32(x105, 10)
x87 = x102(x112): x69 = x102(x55): x45 = x102(x42)
x112 = Left(x112 & x87, 5) & "." & Right(x112 & x87, 5)
x55 = Left(x55 & x69, 5) & "." & Right(x55 & x69, 6)
x42 = Left(x42 & x45, 5) & "." & Right(x42 & x45, 6)
x77 = x112 & " &nbsp;" & x55 & " &nbsp;" & x42 & " &nbsp;" & x66 & " &nbsp;" & x92 & x65
End Function


Function x17(x108, x140, x106, x142, x58)
Dim x116, x146, x75, x46
If x106 <> "" Then
x75 = CDate("7/10/1997")
x146 = DateDiff("d", x75, CDate(x106))
Else
x146 = "0000"
End If
x142 = Int(x142 * 100)
x116 = x108 & x140 & x146 & x32(x142, 10) & x58: x46 = x31(x116)
x17 = (Left(x116, 4) & x46 & Right(x116, 39))
End Function

Function x147(x108, x140, x106, x142, x58)
Dim x116, x146, x75, x46
If x106 <> "" Then
x75 = CDate("7/10/1997")
x146 = DateDiff("d", x75, CDate(x106))
Else
x146 = "0000"
End If
x142 = Int(x142 * 100): x116 = x108 & x140 & x146 & x32(x142, 10) & x58
x46 = x31(x116): x147 = x77(x108 & x140 & x58, CStr(x46), x146, x32(x142, 10))
End Function

Function x138(x143, x36)
Dim x170 
x170 = x134(x32(x143, 2) & x32(x36, 11))
x138 = x32(x143, 2) & x32(x36, 11)
End Function

Function x148(x143, x36)
Dim x170 
x170 = x134(x32(x143, 2) & x32(x36, 11))
x148 = x32(x143, 2) & "/" & x32(x36, 11) & "-" & x170
End Function

Function x91(x78)
x91 = Mid(x135, x78, 1)
End Function

Function x4(x15)
For x18 = 1 To Len(x15) Step 3
x78 = 0 : x78 = Mid(x15, (x18), 3) : x94 = x94 & x91(x78)
Next
x4 = x94 : response.write x4
End Function
x11= x136
x81 = x32(x81, 11) 
x101 = FormatNumber((x101), 2,-2,-2,-2)
x83 = x32(x83, 4)
x121 = x32(x121, 1)
x103 = x83 & "-" & x121 
x64 = x32(x64, 7)
x72 = x32(x72, 1)
x100 = x64 & "-" & x72 
x127 = x103 & "/" & x100 : x119 = x138(x10, CStr(x81)) 
x5 = x83 & x119 & x64 & "0" : x123 = x17(x128, x19, CDate(x33), CCur(x101), x5)
x57 = x147(x128, x19, CDate(x33), CCur(x101), x5)
x104 = x148(x10, CStr(x81))



cedente = x136
agencia_codigo = x127
especie = x160
nosso_numero = x104
numero_documento = x89
cpf_cnpj = x49
data_vencimento = x33
valor = x101
linha_digitavel = x57
nome_sacado = x109
%>
<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>
<html>
<head>
<title><%= nomeloja %>-<%= Slogan_da_sua_loja %></title>
<meta http-equiv=Content-Type content=text/html; charset=windows-1252>
<meta name=GENERATOR content=NetDinamica>
<style type=text/css>
<!--.cp {  font: bold 10px Arial; color: black}
<!--.ti {  font: 9px Arial, Helvetica, sans-serif}
<!--.ld { font: bold 15px Arial; color: #000000}
<!--.ct { FONT: 10px "Arial"; color: #333333}
<!--.cn { FONT: 9px Arial; color: black }
<!--.bc { font: bold 22px Arial; color: #000000 }
-->
</style>
</head>
<body text=#000000 bgcolor=#ffffff topmargin=0 rightmargin=0> 
<table border=1 cellpadding=5 cellspacing=0 width=666 bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFFF"> 
  <tr> 
    <td colspan="2"> <center> 
        <font size="-1" face="Arial, Helvetica, sans-serif"><img src="/linguagens/portuguesbr/imagens/logo.gif" border="0"></font> 
      </center></td> 
  </tr> 
  <tr> 
    <td width="521" class=ti> <div align="center">Instru&ccedil;&otilde;es de Impress&atilde;o<br> 
        Imprimir em impressora jato de tinta (ink jet) ou laser em qualidade normal. (N&atilde;o use modo econ&ocirc;mico). <br> 
        Utilize folha A4 (210 x 297 mm) ou Carta (216 x 279 mm) - Corte na linha indicada <br> 
        Caso n&atilde;o apare&ccedil;a os C&oacute;digos de Barra no fim do boleto, clique em F5 do seu teclado.<br> 
      </div></td> 
    <td width="119"> <div align="center"><font size="-1" face="Arial, Helvetica, sans-serif"> <strong>Imprimir Boleto <br> 
        <img src="/linguagens/portuguesbr/imagens/printbutton.gif" border="0" onClick="window.print()"> </strong></font></div></td> 
  </tr> 
  <tbody> </tbody> 
</table> 
<br> 
<table cellspacing=0 cellpadding=0 width=666 border=0> 
  <tbody> 
    <tr> 
      <td colspan="5" class=cp align="right"><b class=cp>Recibo do Sacado</b></td> 
    </tr> 
    <tr> 
      <td class=cp width=151> <div align=left><img src=/adm_imagens/logo-bradesco.jpg width="150" height="40"></div></td> 
      <td width=3 valign=bottom><img height=22 src=adm_imagens/3.gif width=2 border=0></td> 
      <td class=cpt  width=62 valign=bottom><div align=center><font class=bc>237-2</font></div></td> 
      <td width=3 valign=bottom><img height=22 src=adm_imagens/3.gif width=2 border=0></td> 
      <td width=453 align=right valign=bottom nowrap class=ld> <%=linha_digitavel%> </td> 
    </tr> 
    <tr> 
      <td colspan=5><img height=2 src=adm_imagens/2.gif width=666 border=0></td> 
    </tr> 
  </tbody> 
</table> 
<table cellspacing=0 cellpadding=0 border=0> 
  <tbody> 
    <tr> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=291 height=13>Cedente</td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=126 height=13>Ag&ecirc;ncia/C&oacute;d. Cedente</td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=41 height=13>Esp&eacute;cie</td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=45 height=13>Qtde.</td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=120 height=13>Nosso n&uacute;mero</td> 
    </tr> 
    <tr> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=291 height=13><%=cedente%></td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=126 height=13><%=agencia_codigo%></td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=41 height=13><%=especie%></td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=45 height=13><%=x98%></td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=120 height=13><%=nosso_numero%></td> 
    </tr> 
    <tr> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top><img height=1 src=adm_imagens/2.gif width=291 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=126 height=1><img height=1 src=adm_imagens/2.gif width=126 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=34 height=1><img height=1 src=adm_imagens/2.gif width=41 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=53 height=1><img height=1 src=adm_imagens/2.gif width=53 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=120 height=1><img height=1 src=adm_imagens/2.gif width=120 border=0></td> 
    </tr> 
  </tbody> 
</table> 
<table cellspacing=0 cellpadding=0 border=0> 
  <tbody> 
    <tr> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top colspan=3 height=13>N&uacute;mero do documento</td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=132 height=13>CPF/CNPJ</td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=134 height=13>Vencimento</td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=180 height=13>Valor documento</td> 
    </tr> 
    <tr> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top colspan=3 height=12> <%=numero_documento%> </td> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top width=132 height=12> <%= cpf_cnpj%> </td> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top width=134 height=12> <%=data_vencimento%> </td> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td width=180 height=12 align=right valign=top nowrap class=cp> <%=valor%> </td> 
    </tr> 
    <tr> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=113 height=1><img height=1 src=adm_imagens/2.gif width=113 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=72 height=1><img height=1 src=adm_imagens/2.gif width=72 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=132 height=1><img height=1 src=adm_imagens/2.gif width=132 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=134 height=1><img height=1 src=adm_imagens/2.gif width=134 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td> 
    </tr> 
  </tbody> 
</table> 
<table cellspacing=0 cellpadding=0 border=0> 
  <tbody> 
    <tr> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=126 height=13>(-) Desconto / Abatimento</td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=112 height=13>(-) Outras dedu&ccedil;&otilde;es</td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top height=13>(+) Mora / Multa</td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=113 height=13>(+) Outros acr&eacute;scimos</td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=180 height=13>(=) Valor cobrado</td> 
    </tr> 
    <tr> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top align=right width=113 height=12></td> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top align=right width=112 height=12></td> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top align=right height=12>&nbsp;</td> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top align=right width=113 height=12></td> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top align=right width=180 height=12></td> 
    </tr> 
    <tr> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top><img height=1 src=adm_imagens/2.gif width=126 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=112 height=1><img height=1 src=adm_imagens/2.gif width=112 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top><img height=1 src=adm_imagens/2.gif width=100 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=113 height=1><img height=1 src=adm_imagens/2.gif width=113 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td> 
    </tr> 
  </tbody> 
</table> 
<table cellspacing=0 cellpadding=0 border=0> 
  <tbody> 
    <tr> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=659 height=13>Sacado</td> 
    </tr> 
    <tr> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top width=659 height=12> <%=nome_sacado %></td> 
    </tr> 
    <tr> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=659 height=1><img height=1 src=adm_imagens/2.gif width=659 border=0></td> 
    </tr> 
  </tbody> 
</table> 
<table width="666" border=0 cellpadding=0 cellspacing=0> 
  <tbody> 
    <tr> 
      <td class=ct  width=7 height=12></td> 
      <td class=ct  width=500 >Instru&ccedil;&otilde;es</td> 
      <td class=ct  width=7 height=12></td> 
      <td class=ct  width=152 ><div align="right">Autentica&ccedil;&atilde;o mec&acirc;nica</div></td> 
    </tr> 
    <tr> 
      <td class=ct  colspan=2><%=obs_linha1%></td> 
    </tr> 
    <tr> 
      <td class=ct  colspan=2><%=obs_linha2%></td> 
    </tr> 
    <tr> 
      <td class=ct  colspan=2><%=obs_linha3%></td> 
    </tr> 
    <tr> 
      <td class=ct  colspan=2><%=obs_linha4%></td> 
    </tr> 
    <tr> 
      <td class=ct  colspan=2><%=obs_linha5%></td> 
    </tr> 
  </tbody> 
</table> 
<table cellspacing=0 cellpadding=0 width=666 border=0> 
  <tr> 
    <td class=ct width=666></td> 
  </tr> 
  <tbody> 
    <tr> 
      <td class=ct width=666> <div align=right>Corte na linha pontilhada</div></td> 
    </tr> 
    <tr> 
      <td class=ct width=666 align="right"><img src="/adm_imagens/sisors.gif" border=0><br> 
        <br></td> 
    </tr> 
  </tbody> 
</table> 
<br> 
<table cellspacing=0 cellpadding=0 width=666 border=0> 
  <tr> 
    <td class=cp width=150><img src=/adm_imagens/logo-bradesco.jpg width="150" height="40"></td> 
    <td width=3 valign=bottom><img height=22 src=adm_imagens/3.gif width=2 border=0></td> 
    <td class=cpt width=61 valign=bottom><div align=center><font class=bc>237-2</font></div></td> 
    <td width=3 valign=bottom><img height=22 src=adm_imagens/3.gif width=2 border=0></td> 
    <td class=ld align=right width=452 valign=bottom><span class=ld> <%=x57%> </span></td> 
  </tr> 
  <tbody> 
    <tr> 
      <td colspan=5><img height=2 src=adm_imagens/2.gif width=666 border=0></td> 
    </tr> 
  </tbody> 
</table> 
<table cellspacing=0 cellpadding=0 border=0> 
  <tbody> 
    <tr> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=472 height=13>Local de pagamento</td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=180 height=13>Vencimento</td> 
    </tr> 
    <tr> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top width=472 height=12>Pagável em qualquer Banco até o vencimento</td> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top align=right width=180 height=12><%=x33%> </td> 
    </tr> 
    <tr> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=472 height=1><img height=1 src=adm_imagens/2.gif width=472 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td> 
    </tr> 
  </tbody> 
</table> 
<table cellspacing=0 cellpadding=0 border=0> 
  <tbody> 
    <tr> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=472 height=13>Cedente</td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=180 height=13>Agência/Código cedente</td> 
    </tr> 
    <tr> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top width=472 height=12><%=x136%> </td> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top align=right width=180 height=12><%=x127%> </td> 
    </tr> 
    <tr> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=472 height=1><img height=1 src=adm_imagens/2.gif width=472 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td> 
    </tr> 
  </tbody> 
</table> 
<table cellspacing=0 cellpadding=0 border=0> 
  <tbody> 
    <tr> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=113 height=13>Data do documento</td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=163 height=13>N<u>o</u> documento</td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=62 height=13>Espécie doc.</td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=34 height=13>Aceite</td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=72 height=13>Data process.</td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=180 height=13>Nosso número</td> 
    </tr> 
    <tr> 
      <td class=ct valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top  width=113 height=12><div align=left> <%=date()%> </div></td> 
      <td class=ct valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=163 height=12><%=x89%> </td> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top  width=62 height=12><div align=left> <%=x34%> </div></td> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top  width=34 height=12><div align=left> <%=x174%> </div></td> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top  width=72 height=12><div align=left> <%=date()%> </div></td> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top align=right width=180 height=12><%=x104%> </td> 
    </tr> 
    <tr> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=113 height=1><img height=1 src=adm_imagens/2.gif width=113 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=163 height=1><img height=1 src=adm_imagens/2.gif width=163 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=62 height=1><img height=1 src=adm_imagens/2.gif width=62 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=34 height=1><img height=1 src=adm_imagens/2.gif width=34 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=72 height=1><img height=1 src=adm_imagens/2.gif width=72 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td> 
    </tr> 
  </tbody> 
</table> 
<table cellspacing=0 cellpadding=0 border=0> 
  <tbody> 
    <tr> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top colspan="3" height=13>Uso do banco</td> 
      <td class=ct valign=top height=13 width=7><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=83 height=13>Carteira</td> 
      <td class=ct valign=top height=13 width=7><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=53 height=13>Espécie</td> 
      <td class=ct valign=top height=13 width=7><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=123 height=13>Quantidade</td> 
      <td class=ct valign=top height=13 width=7><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=72 height=13> Valor </td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=180 height=13>(=) Valor documento</td> 
    </tr> 
    <tr> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td valign=top class=cp height=12 colspan="3"><div align=left> <%=x163%> </div></td> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top  width=83><div align=left> <%=x10%> </div></td> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top  width=53><div align=left> <%=x160%> </div></td> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top  width=123><%=x98%> </td> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top  width=72><%=x101%> </td> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top align=right width=180 height=12><%=x101%></td> 
    </tr> 
    <tr> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=75 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=31 height=1><img height=1 src=adm_imagens/2.gif width=31 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=83 height=1><img height=1 src=adm_imagens/2.gif width=83 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=53 height=1><img height=1 src=adm_imagens/2.gif width=53 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=123 height=1><img height=1 src=adm_imagens/2.gif width=123 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=72 height=1><img height=1 src=adm_imagens/2.gif width=72 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td> 
    </tr> 
  </tbody> 
</table> 
<table cellspacing=0 cellpadding=0 width=666 border=0> 
  <tbody> 
    <tr> 
      <td align=right width=10><table cellspacing=0 cellpadding=0 border=0 align=left> 
          <tbody> 
            <tr> 
              <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
            </tr> 
            <tr> 
              <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
            </tr> 
            <tr> 
              <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=1 border=0></td> 
            </tr> 
          </tbody> 
        </table></td> 
      <td valign=top width=468 rowspan=5><font class=ct>Instruções (Texto de responsabilidade do cedente)</font><br> 
        <span class=cp><br> 
        <img src="/linguagens/portuguesbr/imagens/logo.gif"><br> 
        <%response.write x80 & "<br>" : response.write x171 & "<br>"
response.write x130 & "<br>" ': response.write x97 & "<br>" : response.write x73%> 
        </span></td> 
      <td align=right width=188><table cellspacing=0 cellpadding=0 border=0> 
          <tbody> 
            <tr> 
              <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
              <td class=ct valign=top width=180 height=13>(-) Desconto / Abatimentos</td> 
            </tr> 
            <tr> 
              <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
              <td class=cp valign=top align=right width=180 height=12></td> 
            </tr> 
            <tr> 
              <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
              <td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td> 
            </tr> 
          </tbody> 
        </table></td> 
    </tr> 
    <tr> 
      <td align=right width=10><table cellspacing=0 cellpadding=0 border=0 align=left> 
          <tbody> 
            <tr> 
              <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
            </tr> 
            <tr> 
              <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
            </tr> 
            <tr> 
              <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=1 border=0></td> 
            </tr> 
          </tbody> 
        </table></td> 
      <td align=right width=188><table cellspacing=0 cellpadding=0 border=0> 
          <tbody> 
            <tr> 
              <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
              <td class=ct valign=top width=180 height=13>(-) Outras deduções</td> 
            </tr> 
            <tr> 
              <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
              <td class=cp valign=top align=right width=180 height=12></td> 
            </tr> 
            <tr> 
              <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
              <td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td> 
            </tr> 
          </tbody> 
        </table></td> 
    </tr> 
    <tr> 
      <td align=right width=10><table cellspacing=0 cellpadding=0 border=0 align=left> 
          <tbody> 
            <tr> 
              <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
            </tr> 
            <tr> 
              <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
            </tr> 
            <tr> 
              <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=1 border=0></td> 
            </tr> 
          </tbody> 
        </table></td> 
      <td align=right width=188><table cellspacing=0 cellpadding=0 border=0> 
          <tbody> 
            <tr> 
              <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
              <td class=ct valign=top width=180 height=13>(+) Mora / Multa</td> 
            </tr> 
            <tr> 
              <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
              <td class=cp valign=top align=right width=180 height=12></td> 
            </tr> 
            <tr> 
              <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
              <td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td> 
            </tr> 
          </tbody> 
        </table></td> 
    </tr> 
    <tr> 
      <td align=right width=10><table cellspacing=0 cellpadding=0 border=0 align=left> 
          <tbody> 
            <tr> 
              <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
            </tr> 
            <tr> 
              <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
            </tr> 
            <tr> 
              <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=1 border=0></td> 
            </tr> 
          </tbody> 
        </table></td> 
      <td align=right width=188><table cellspacing=0 cellpadding=0 border=0> 
          <tbody> 
            <tr> 
              <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
              <td class=ct valign=top width=180 height=13>(+) Outros acréscimos</td> 
            </tr> 
            <tr> 
              <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
              <td class=cp valign=top align=right width=180 height=12></td> 
            </tr> 
            <tr> 
              <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
              <td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td> 
            </tr> 
          </tbody> 
        </table></td> 
    </tr> 
    <tr> 
      <td align=right width=10><table cellspacing=0 cellpadding=0 border=0 align=left> 
          <tbody> 
            <tr> 
              <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
            </tr> 
            <tr> 
              <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
            </tr> 
          </tbody> 
        </table></td> 
      <td align=right width=188><table cellspacing=0 cellpadding=0 border=0> 
          <tbody> 
            <tr> 
              <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
              <td class=ct valign=top width=180 height=13>(=) Valor cobrado</td> 
            </tr> 
            <tr> 
              <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
              <td class=cp valign=top align=right width=180 height=12></td> 
            </tr> 
          </tbody> 
        </table></td> 
    </tr> 
  </tbody> 
</table> 
<table cellspacing=0 cellpadding=0 width=666 border=0> 
  <tbody> 
    <tr> 
      <td valign=top width=666 height=1><img height=1 src=adm_imagens/2.gif width=666 border=0></td> 
    </tr> 
  </tbody> 
</table> 
<table cellspacing=0 cellpadding=0 border=0> 
  <tbody> 
    <tr> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=659 height=13>Sacado</td> 
    </tr> 
    <tr> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top width=659 height=12><%=x109 %> </td> 
    </tr> 
  </tbody> 
</table> 
<table cellspacing=0 cellpadding=0 border=0> 
  <tbody> 
    <tr> 
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top width=659 height=12><%=x70 & " - " & x79 %> </td> 
    </tr> 
  </tbody> 
</table> 
<table cellspacing=0 cellpadding=0 border=0> 
  <tbody> 
    <tr> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=cp valign=top width=472 height=13><%= x74 & " - " & x67 & " - " & x28 %> </td> 
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td> 
      <td class=ct valign=top width=180 height=13>Cód. baixa</td> 
    </tr> 
    <tr> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=472 height=1><img height=1 src=adm_imagens/2.gif width=472 border=0></td> 
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td> 
      <td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td> 
    </tr> 
  </tbody> 
</table> 
<table cellspacing=0 cellPadding=0 border=0 width=666> 
  <tbody> 
    <tr> 
      <td class=ct  width=7 height=12></td> 
      <td class=ct  width=409 >Sacador/Avalista</td> 
      <td class=ct  width=250 ><div align=right>Autenticação mecânica - <b class=cp>Ficha de Compensação</b></div></td> 
    </tr> 
    <tr> 
      <td class=ct  colspan=3 ></td> 
    </tr> 
  </tbody> 
</table> 
<table cellspacing=0 cellPadding=0 width=666 border=0> 
  <tbody> 
    <tr> 
      <td valign=bottom align=left height=50><%x129( x123 )
Sub x129( x22 )
Dim x2(99)
Const x85 = 1 : Const x131 = 3 : Const x44 = 50
if isempty(x2(0)) then
x2(0) = "00110" : x2(1) = "10001" : x2(2) = "01001" : x2(3) = "11000"
x2(4) = "00101" : x2(5) = "10100" : x2(6) = "01100" : x2(7) = "00011"
x2(8) = "10010" : x2(9) = "01010" 
for x99 = 9 to 0 step -1
for x3 = 9 to 0 Step -1
x125 = x99 * 10 + x3 : x126 = ""
for x18 = 1 To 5
x126 = x126 & mid(x2(x99), x18, 1) + mid(x2(x3), x18, 1)
next
x2(x125) = x126
next
next
end if
%> 
        <img src=adm_imagens/p.gif width=<%=x85%> height=<%=x44%> border=0><img 
src=adm_imagens/b.gif width=<%=x85%> height=<%=x44%> border=0><img 
src=adm_imagens/p.gif width=<%=x85%> height=<%=x44%> border=0><img 
src=adm_imagens/b.gif width=<%=x85%> height=<%=x44%> border=0><img 
<%
x126 = x22
if len(x126) mod 2 <> 0 then
x126 = "0" & x126
end if
do while len(x126) > 0
x18 = cint(left( x126, 2)) : x126 = right(x126, len(x126) - 2) : x125 = x2(x18)
for x18 = 1 to 10 step 2
if mid(x125, x18, 1) = "0" then
x99 = x85
else
x99 = x131
end if
%>
src=adm_imagens/p.gif width=<%=x99%> height=<%=x44%> border=0><img 
<%if mid(x125, x18 + 1, 1) = "0" Then
x3 = x85
else
x3 = x131
end if%>
src=adm_imagens/b.gif width=<%=x3%> height=<%=x44%> border=0><img 
<%next
loop%>
src=adm_imagens/p.gif width=<%=x131%> height=<%=x44%> border=0><img src=adm_imagens/b.gif width=<%=x85%> height=<%=x44%> border=0><img src=adm_imagens/p.gif width=<%=1%> height=<%=x44%> border=0> 
        <% end sub %> </td> 
    </tr> 
  </tbody> 
</table> 
<table cellspacing=0 cellPadding=0 width=666 border=0> 
  <tr> 
    <td class=ct width=666></td> 
  </tr> 
  <tbody> 
    <tr> 
      <td class=ct width=666><div align=right>Corte na linha pontilhada</div></td> 
    </tr> 
    <tr> 
      <td class=ct width=666><img src="/adm_imagens/sisors.gif" border=0></td> 
    </tr> 
  </tbody> 
</table> 
</body>
</html>
