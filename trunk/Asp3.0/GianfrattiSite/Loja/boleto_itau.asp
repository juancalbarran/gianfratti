<!-- #include file="config.asp" -->
<%

Session.Lcid = "1046"


cobra_boleto=false
valor_minimo_para_taxar_boleto = 50 'Valor menor que este será acrescido de taxa de boleto (coloque 0 para não usar esta função
if Request.QueryString("valordocumento") < valor_minimo_para_taxar_boleto then
	valor=2.80 'valor do boleto! pode definir a variavel no config.asp
	x101=valor+Request.QueryString("valordocumento")
else
	x101=Request.QueryString("valordocumento")
end if 


'====== NÃO MEXER DAQUI PRA BAIXO ===========

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
x128 = "341"  ' Banco
x19 = "9" ' Moeda 
x160="R$" ' Especie 2


valor_doc = x101
dt_venc = x33
banco = "341"
moeda = "9"
agencia = x83
conta = x64
dv_conta = x72
carteira = x10

Select Case Len(x81)
Case 1
num_doc = "0000000" & x81
nossonumero = "0000000" & x81
Case 2
num_doc = "000000" & x81
nossonumero = "000000" & x81
Case 3
num_doc = "00000" & x81
nossonumero = "00000" & x81
Case 4
num_doc = "0000" & x81
nossonumero = "0000" & x81
Case 5
num_doc = "000" & x81
nossonumero = "000" & x81
Case 6
num_doc = "00" & x81
nossonumero = "00" & x81
Case 7
num_doc = "0" & x81
nossonumero = "0" & x81
Case 8
num_doc = x81
nossonumero = x81
End Select

dv_nossonumero = Calculo_DV10(agencia & conta & carteira & nossonumero)

Database = CDate("7/10/1997")
fator = DateDiff("d", Database, dt_venc)
valor = Int(valor_doc * 100)
While Len(valor) < 10
valor = "0" & valor
Wend
codigo_sequencia = "3419" & fator & valor & carteira & nossonumero & dv_nossonumero & agencia & conta & dv_conta & "000"
dvcb = calcula_DV_CodBarras(codigo_sequencia)
Select Case dvcb
Case "1"
dvcb = "1"
Case "0"
dvcb = "1"
Case "10"
dvcb = "1"
Case "11"
dvcb = "1"
Case Else
dvcb = dvcb
End Select
Monta_CodBarras = Left(codigo_sequencia, 4) & dvcb & Right(codigo_sequencia, 39)

cod_barra = Monta_CodBarras
linha_dig = Linha_Digitavel_itau(cod_barra)
nossonumero = carteira & "/" & nossonumero & "-" & dv_nossonumero
'Conversão de valores
x57 = linha_dig
x104 = nossonumero
x127 = agencia & "/" & conta & "-" & dv_conta
x123 = cod_barra

Function Formata_Data(strData)
dia = Day(strData)
Mes = Month(strData)
ano = Year(strData)
If dia < 9 Then dia = "0" & dia
If Mes < 9 Then Mes = "0" & Mes
Formata_Data = dia & "/" & Mes & "/" & ano
End Function

Function Calculo_DV10(strNumero)
fator = 2
total = 0
For I = Len(strNumero) To 1 Step -1
    numero = Mid(strNumero, I, 1) * fator
    If numero > 9 Then
        numero = CInt(Left(numero, 1)) + CInt(Right(numero, 1))
    End If
    total = total + numero
    If fator = 2 Then
        fator = 1
    Else
        fator = 2
    End If
Next
resto = total Mod 10
resto = 10 - resto
If resto = 10 Then
    Calculo_DV10 = 0
Else
    Calculo_DV10 = resto
End If
End Function

Function calcula_DV_CodBarras(sequencia)
fator = 2
total = 0
For I = 43 To 1 Step -1
    numero = Mid(sequencia, I, 1)
    If fator > 9 Then
        fator = 2
    End If
    numero = numero * fator
    total = total + numero
    fator = fator + 1
Next
resto = total Mod 11
resultado = 11 - resto
If resultado = 10 Or resultado = 0 Then
    calcula_DV_CodBarras = 1
Else
    calcula_DV_CodBarras = resultado
End If
End Function

Function Linha_Digitavel_itau(sequencia_codigo_barra)
seq1 = Left(sequencia_codigo_barra, 4) & Mid(sequencia_codigo_barra, 20, 5)
seq2 = Mid(sequencia_codigo_barra, 25, 10)
seq3 = Mid(sequencia_codigo_barra, 35, 10)
seq4 = Mid(sequencia_codigo_barra, 6, 14)
dvcb = Mid(sequencia_codigo_barra, 5, 1)

dv1 = Calculo_DV10(seq1)
dv2 = Calculo_DV10(seq2)
dv3 = Calculo_DV10(seq3)

seq1 = Left(seq1 & dv1, 5) & "." & Mid(seq1 & dv1, 6, 5)

seq2 = Left(seq2 & dv2, 5) & "." & Mid(seq2 & dv2, 6, 6)
seq3 = Left(seq3 & dv3, 5) & "." & Mid(seq3 & dv3, 6, 6)


Linha_Digitavel_itau = seq1 & " " & seq2 & " " & seq3 & " " & dvcb & " " & seq4
End Function


%>
<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>
<html>
<head>
<title>Imprima seu Boleto!</TITLE>
<meta http-equiv=Content-Type content=text/html; charset=windows-1252>
<meta name=GENERATOR content="Microsoft FrontPage 5.0">
<style type=text/css>
<!--.cp {  font: bold 10px Arial; color: black}
<!--.ti {  font: 9px Tahoma}
<!--.ld { font: bold 15px Arial; color: #000000}
<!--.ct { FONT: 9px "Tahoma"; color: #000033}
<!--.cn { FONT: 9px Tahoma; color: black }
<!--.bc { font: bold 22px Arial; color: #000000 }
-->
</style>
</head>
<body text=#000000 bgcolor=#ffffff topmargin=1 rightmargin=0 leftmargin="1">
<table border=1 cellpadding=5 cellspacing=0 width=666 bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFFF">
  <tr>
    <td colspan="2">
      <center>
        <font size="-1" face="Arial, Helvetica, sans-serif"><img src="/linguagens/portuguesbr/imagens/logo.gif" border="0"></font>
    </center></td>
  </tr>
  <tr>
    <td width="521" class=ti>
      <div align="center">Instru&ccedil;&otilde;es de Impress&atilde;o<br>
        Imprimir em impressora jato de tinta (ink jet) ou laser em qualidade normal. (N&atilde;o use modo econ&ocirc;mico). <br>
        Utilize folha A4 (210 x 297 mm) ou Carta (216 x 279 mm) - Corte na linha indicada <br>
        Caso n&atilde;o apare&ccedil;a os C&oacute;digos de Barra no fim do boleto, clique em F5 do seu teclado.<br>
    </div></td>
    <td width="119">
      <div align="center"><font size="-1" face="Arial, Helvetica, sans-serif"> <strong>Imprimir Boleto <br>
              <img src="/linguagens/portuguesbr/imagens/printbutton.gif" border="0" onClick="window.print()"> </strong></font></div></td>
  </tr>
  <tbody>
  </tbody>
</table>
<br>
<table cellspacing=0 cellpadding=0 width=666 border=0>
<tr>
      <td colspan="5" class=cp align="right"><b class=cp>Recibo do Sacado</b></td>
    </tr>
  <tr>
    <td class=cp width=150><img src=adm_imagens/logo-itau.jpg border=0></td>
    <td width=3 valign=bottom><img height=22 src=adm_imagens/3.gif width=2 border=0></td>
    <td class=cpt width=61 valign=bottom><div align=center><font class=bc>341-7</font></div></td>
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
      <td class=ct valign=top width=298 height=13>Cedente</td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=126 height=13>Agência/Código do Cedente</td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=34 height=13>Espécie</td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=53 height=13>Quantidade</td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=120 height=13>Nosso número</td>
    </tr>
    <tr>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=298 height=12><%=x136%> </td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=126 height=12><%=x127%> </td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top  width=34 height=12><%=x160%> </td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top  width=53 height=12><%=x98%> </td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top align=right width=120 height=12><%=x104%> </td>
    </tr>
    <tr>
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td>
      <td valign=top width=298 height=1><img height=1 src=adm_imagens/2.gif width=298 border=0></td>
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td>
      <td valign=top width=126 height=1><img height=1 src=adm_imagens/2.gif width=126 border=0></td>
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td>
      <td valign=top width=34 height=1><img height=1 src=adm_imagens/2.gif width=34 border=0></td>
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
      <td class=ct valign=top colspan=3 height=13>Número do documento</td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=132 height=13>CPF/CNPJ</td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=134 height=13>Vencimento</td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=180 height=13>Valor documento</td>
    </tr>
    <tr>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top colspan=3 height=12><%=x89%> </td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top width=132 height=12><%= x49%> </td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top width=134 height=12><%=x33%> </td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top align=right width=180 height=12><%=x101%> </td>
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
      <td class=ct valign=top width=113 height=13>(-) Desconto / Abatimentos</td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=112 height=13>(-) Outras deduções</td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=113 height=13>(+) Mora / Multa</td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=113 height=13>(+) Outros acréscimos</td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=180 height=13>(=) Valor cobrado</td>
    </tr>
    <tr>
      <td class=cp valign=top width=7 height=13><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top align=right width=113 height=12></td>
      <td class=cp valign=top width=7 height=13><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top align=right width=112 height=12></td>
      <td class=cp valign=top width=7 height=13><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top align=right width=113 height=12></td>
      <td class=cp valign=top width=7 height=13><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top align=right width=113 height=12></td>
      <td class=cp valign=top width=7 height=13><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top align=right width=180 height=12></td>
    </tr>
    <tr>
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td>
      <td valign=top width=113 height=1><img height=1 src=adm_imagens/2.gif width=113 border=0></td>
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td>
      <td valign=top width=112 height=1><img height=1 src=adm_imagens/2.gif width=112 border=0></td>
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td>
      <td valign=top width=113 height=1><img height=1 src=adm_imagens/2.gif width=113 border=0></td>
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
      <td class=cp valign=top width=659 height=12><%=x109 %> </td>
    </tr>
    <tr>
      <td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td>
      <td valign=top width=659 height=1><img height=1 src=adm_imagens/2.gif width=659 border=0></td>
    </tr>
  </tbody>
</table>
<table cellspacing=0 cellpadding=0 border=0>
  <tbody>
    <tr>
      <td class=ct  width=7 height=12></td>
      <td class=ct  width=501 >Instruções</td>
      <td class=ct  width=10 height=12></td>
      <td class=ct  width=148 ><div align="right">Autenticação mecânica</div></td>
    </tr>
    <tr>
      <td  width=7 ></td>
      <td  width=501 ></td>
      <td  width=10 ></td>
      <td  width=148 ></td>
    </tr>
  </tbody>
</table>
<table cellspacing=0 cellpadding=0 width=666 border=0>
  <tbody>
    <tr>
      <td width=7></td>
      <td  width=500 class=cp><%response.write x12 & "<br>" : response.write x20 & "<br>"
response.write x48 & "<br>" : response.write x21 & "<br>" : response.write x1%>
      </td>
      <td width=159></td>
    </tr>
  </tbody>
</table>
<table cellspacing=0 cellpadding=0 width=666 border=0>
  <tr>
    <td class=ct width=666></td>
  </tr>
  <tbody>
    <tr>
      <td class=ct width=666><div align=right>Corte na linha pontilhada</div></td>
    </tr>
    <tr>
      <td class=ct width=666><br>
        <center>
          <img src=adm_imagens/sisors.gif border=0>
        </center></td>
    </tr>
  </tbody>
</table>
<br>
<table cellspacing=0 cellpadding=0 width=666 border=0>
  <tr>
    <td class=cp width=150><img src=adm_imagens/logo-itau.jpg border=0></td>
    <td width=3 valign=bottom><img height=22 src=adm_imagens/3.gif width=2 border=0></td>
    <td class=cpt width=61 valign=bottom><div align=center><font class=bc>341-7</font></div></td>
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
      <td class=ct valign=top width=72 height=13> Data proces.</td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=180 height=13>Nosso número</td>
    </tr>
    <tr>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top  width=113 height=12><div align=left> <%=date()%> </div></td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top width=163 height=12><%=x89%> </td>
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
        <span class=cp>
        <%response.write x80 & "<br>" : response.write x171 & "<br>"
response.write x130 & "<br>" : response.write x97 & "<br>" : response.write x73%>
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
&nbsp;&nbsp; <img src=adm_imagens/p.gif width=<%=x85%> height=<%=x44%> border=0><img 
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
        <% end sub %>
      </td>
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
      <td class=ct width=666><img src=adm_imagens/sisors.gif border=0></td>
    </tr>
  </tbody>
</table>
</body>
</html>
