<!-- #include file="config.asp" -->
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
<%
  
SDIG=""
CDIG=""
LDIG=""
NOSSONUMERO=""
Dim atab(99)


'********************************
' CONSTANTES
'********************************

cons_banco = "409"
cons_dvbanco = "0"
cons_agencia = bol_agencia
cons_conta = bol_conta
cons_carteira = "ESPECIAL"
cons_moeda = "9"
cons_especie = "REAL"
cons_cedente = bol_cedente
cons_dadoscedente= bol_dadoscedente '"Empresa teste s/a<br>Rua sobe desce, 448 CEP: 04124200 <br>Fone: (11)5061-1111 <br>E-Mail: teste@teste.com.br <br>Site: www.teste.com.br <br>"
cons_codigocedente= bol_nr_cedente
cons_CVT = "5"
cons_fixo= "00"

'********************************
' VARIÁVEIS 
'********************************

var_sacado = Request.QueryString("sacador")
var_CPFSacado= Request.QueryString("cpf")
var_endereco = Request.QueryString("endereco")
var_bairro = Request.QueryString("bairro")
var_cidade = Request.QueryString("cidade")
var_estado = Request.QueryString("estado")
var_cep = Request.QueryString("cep")
var_cpfcnpj = CNPJ_da_sua_empresa


'*************************************** 
 Function Converten(pNumeron)
 Converten = Right(String(8,"0") &_
 cstr(pNumeron * 100),8)
 End Function
'****************************************

'************************************
'Preencher com zeros a esquerda
 Function strZeros(strValor,Tamanho)
   while len(strValor) < Tamanho
     strValor = "0" & strValor
   wend
   StrZeros=strValor
 End Function
'**********************************

'Colocar somente numeros da string
Function SoNumeros(str)
 s="" 
 for x=1 to len(str)
   ch=mid(str,x,1)
   if asc(ch)>=48 and asc(ch)<=57 then
     s=s & ch
   end if
 next
 SoNumeros=s
End Function


'var_nossonumero = Converten(ccur(Request.QueryString("nossonumero")))
var_datadocumento = Request.QueryString("datadocumento")
var_datavencimento = Request.QueryString("datavencimento")
var_valordocumento = Request.QueryString("valordocumento")
var_numerodoc = Request.QueryString("numerodoc")
'Nosso Número
var_nossonumero = var_numerodoc & mid(var_datadocumento,1,2) & mid(var_datadocumento,4,2) & mid(var_datadocumento,9,2)
'***linha para instruções, colocar no config.asp
if instr_linha3="" and instr_linha4="" and instr_linha5="" then
  var_instrucoes="<b><br> MORA DIÁRIA: 0,17% - INSTRUÇÕES - 30.<br> MULTA: 0,07 - INSTRUÇÕES - 30<br>OPERAÇÃO SEM DESCONTO<br></b>"
else
  var_instrucoes="<b><br>"&instr_linha3&"<br>"&instr_linha4&"<br>"&instr_linha5&"</b>"
end if
'***Linha da observação
var_intervalo = CDate(Var_datavencimento)-CDate(Var_datadocumento)
if var_intervalo > 5 then
  var_observacoes="<b><br>Pagamento referente a compra efetuada em "&application("nomeloja")&"<br>REIMPRESSÃO DO BOLETO<br></b>"
else
  var_observacoes="<b><br>Pagamento referente a compra efetuada em "&application("nomeloja")&"<br></b>"
end if
var_observacoes = var_observacoes & obs_linha1 & "<br>"
var_observacoes = var_observacoes & obs_linha2 & "<br>"
var_observacoes = var_observacoes & obs_linha3 & "<br>"
var_observacoes = var_observacoes & obs_linha4 & "<br>"
var_observacoes = var_observacoes & obs_linha5 & "<br>"

if var_numerodoc = "" then
  if var_CPFSacado<>"" then
    var_nossonumero = var_CPFSacado
  end if
end if

'********************************
' INICIO DO CÁLCULO
'********************************

dvnossonumero=Modulo11(strZeros(var_nossonumero,14),2)
'dvagconta=calcdig10(cons_agencia&cons_conta)


valordia=date()
var_data=Day(valordia) & "/" & Month(valordia) & "/" & YEAR(valordia)

valorvalor1=var_valordocumento
valorvalor2=replace(valorvalor1,",","")
valorvalor2=replace(valorvalor2,".","")
valorvalor3=len(valorvalor2)
valorvalor4=10-valorvalor3
var_valor= String(""&valorvalor4&"","0") & (""&valorvalor2&"")
if valorvalor1=0 then
   var_valor=""
end if

var_fatorvencimento=fatorvencimento(""&var_datavencimento&"")
if var_fatorvencimento="0000" then
   var_datavencimento="Contra Apresentação"
end if


var_codigobarras=codbar(""&cons_banco&"",""&cons_moeda&"",""&var_fatorvencimento&"",""&var_valor&"",""&cons_CVT&"",""&cons_codigocedente&"",""&cons_fixo&"",""&strZeros(var_nossonumero,14)&"",""&dvnossonumero&"")
var_linhadigitavel=linhadigitavel(""&var_codigobarras&"")



'**************************
FUNCTION linhadigitavel(codigobarras)
'**************************
cmplivre=mid(codigobarras,20,25)
campo1=left(codigobarras,4)&mid(cmplivre,1,5)
campo1=campo1&calcdig10(campo1)
campo1=mid(campo1,1,5)&"."&mid(campo1,6,5)

campo2=mid(cmplivre,6,10)
campo2=campo2&calcdig10(campo2)
campo2=mid(campo2,1,5)&"."&mid(campo2,6,6)

campo3=mid(cmplivre,16,10)
campo3=campo3&calcdig10(campo3)
campo3=mid(campo3,1,5)&"."&mid(campo3,6,6)

campo4=mid(codigobarras,5,1)

campo5=int(mid(codigobarras,6,14))

if campo5=0 then
	campo5="000"
end if

linhadigitavel=campo1&"&nbsp;&nbsp;"&campo2&"&nbsp;&nbsp;"&campo3&"&nbsp;&nbsp;"&campo4&"&nbsp;&nbsp;"&campo5
'*************************
END FUNCTION
'*************************

'Calculo do Dv Nosso número
Function Modulo11(strNumero,strTipo)
fator = 2
total = 0
For i = Len(strNumero) To 1 Step -1
   numero = Mid(strNumero, i, 1) * fator
   total = total + numero
   fator=fator+1
   if fator = 10 then fator = 2
Next
Total = Total * 10 
resto = total Mod 11
if resto = 10 or resto=0 then
  if strTipo=2 then
    Modulo11 = "0"
  else
    Modulo11 = "1"
  end if
else
  Modulo11 = cStr(resto)
end if
End Function

'Calculo do Dv geral do codigo de barras
Function calcula_DV_CodBarras(sequencia)
 fator = 2
 total = 0
 For i = 43 To 1 step -1
   numero = Mid(sequencia, i, 1)
   If fator > 9 Then
      fator = 2
   End If
   numero = numero * fator
   total = total + numero
   fator = fator + 1
 Next
 resto = total mod 11
 resultado = 11 - resto
 If resultado = 10 Or resultado = 0 Then
    calcula_DV_CodBarras = 1
 Else
    calcula_DV_CodBarras = resultado
 End If
End Function

'Calculo dos dvs linha digitavel
Function Calculo_DV10(strNumero)
fator = 2
total = 0
For i = Len(strNumero) To 1 Step -1
   numero = Mid(strNumero, i, 1) * fator
   If numero > 9 Then
      numero = Cint(Left(numero, 1)) + Cint(Right(numero, 1))
   End If
   total = total + numero
   if fator = 2 then
      fator = 1
   else
      fator = 2
   end if
Next
resto = total Mod 10
resto = 10 - resto
if resto = 10 then
   Calculo_DV10 = 0
else
   Calculo_DV10 = resto
end if
End Function

'valortal=CALCdig10("11513024791005193100033")
'response.write valortal

'**************************
FUNCTION CALCDIG10(cadeia)
'**************************
	mult=(len(cadeia) mod 2) 
	mult=mult+1
	total=0
	for pos=1 to len(cadeia)
		res= mid(cadeia, pos, 1) * mult
		if res>9 then
			res=int(res/10) + (res mod 10)
		end if
		total=total+res
		if mult=2 then
			mult=1
		else
			mult=2
		end if
	next
	total=((10-(total mod 10)) mod 10 )
	CALCDIG10=total
'*************************
END FUNCTION
'*************************




'valortal1=CALCdig11("0339000000000103581481302647800076960003348",9,0)
'response.write valortal1

'**************************
FUNCTION CALCDIG11(cadeia,limitesup,lflag)
'**************************
mult=1 + (len(cadeia) mod (limitesup-1))
if mult=1 then
	mult=limitesup
end if
total=0
for pos=1 to len(cadeia)
	total=total+(mid(cadeia,pos,1) * mult)
	mult=mult-1
	if mult=1 then
		mult=limitesup
	end if
Next
nresto=(total mod 11)
if lflag = 1 then
	calcdig11=nresto
else
	if nresto=0 or nresto=1 or nresto=10 then
		ndig=1
	else
		ndig=11 - nresto	
	end if
	calcdig11=ndig
end if

'*************************
END FUNCTION
'*************************



'**************************
FUNCTION fatorvencimento(vencimento)
'**************************

if len(vencimento)<8 then
   fatorvencimento="0000"
else
   fatorvencimento=datevalue(""&vencimento&"")-datevalue("1997/10/07")
end if

'*************************
END FUNCTION
'*************************




'**************************
FUNCTION codbar(banco,moeda,vencimento,valor,CVT,codCedente,Fixo,nossonumero,dvnossonumero)
'**************************

strcodbar=banco&moeda&vencimento&valor&CVT&codCedente&Fixo&nossonumero&dvnossonumero
dv3=calcdig11(strcodbar,9,0)
codbar=banco&moeda&dv3&vencimento&valor&CVT&codCedente&Fixo&nossonumero&dvnossonumero
'*************************
END FUNCTION
'*************************



%>
<SCRIPT language=JavaScript>
var da = (document.all) ? 1 : 0;
var pr = (window.print) ? 1 : 0;
var mac = (navigator.userAgent.indexOf("Mac") != -1); 

function x86(){
if (pr) // NS4, IE5
window.print()
else if (da && !mac) // IE4 (Windows)
vbx86()
else // outros browsers
alert("Desculpe seu browser não suporta esta função. Por favor utilize a barra de trabalho para imprimir a página.");
return false;}
if (da && !pr && !mac) with (document) {
writeln('<OBJECT ID="WB" width="0" height="0" CLASSID="clsid:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>');
writeln('<' + 'SCRIPT LANGUAGE="VBScript">');
writeln('Sub window_onunload');
writeln('  On Error Resume Next');
writeln('  Set WB = nothing');
writeln('End Sub');
writeln('Sub vbx86');
writeln('  OLECMDID_PRINT = 6');
writeln('  OLECMDEXECOPT_DONTPROMPTUSER = 2');
writeln('  OLECMDEXECOPT_PROMPTUSER = 1');
writeln('  On Error Resume Next');
writeln('  WB.ExecWB OLECMDID_PRINT, OLECMDEXECOPT_DONTPROMPTUSER');
writeln('End Sub');
writeln('<' + '/SCRIPT>');}
</script>
<table border=1 cellpadding=5 cellspacing=0 width=666 bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFFF">
  <tr>
    <td colspan="2">
      <center>
        <font size="-1" face="Arial, Helvetica, sans-serif"><img src="/linguagens/portuguesbr/imagens/logo.gif" border="0"></font>
    </center></td>
  </tr>
  <tr>
    <td width="373" rowspan="2" class=ti>
      <div align="center">Instru&ccedil;&otilde;es de Impress&atilde;o<br>
        Imprimir em impressora jato de tinta (ink jet) ou laser em qualidade normal. (N&atilde;o use modo econ&ocirc;mico). <br>
        Utilize folha A4 (210 x 297 mm) ou Carta (216 x 279 mm) - <br>
        Corte na linha indicada <br>
        Caso n&atilde;o apare&ccedil;a os C&oacute;digos de Barra no fim do boleto, <br>
        clique em F5 do seu teclado.<br>
    </div></td>
    <td>
      <div align="center"><font size="-1" face="Arial, Helvetica, sans-serif"> <strong>Imprimir Boleto <br>
              <img src="/linguagens/portuguesbr/imagens/printbutton.gif" border="0" onClick="x86()"> </strong></font></div></td>
  </tr>
  <tr><td><form method="get" action=" https://ibpf.unibanco.com.br/index.asp" target="_blank">
          
        <div align="center"><font class=ct>SEM DIGITA&Ccedil;&Atilde;O: Os dados do Boleto ser&atilde;o <br>
          enviados ao site do Unibanco.</font>
          <INPUT TYPE="hidden" name="grupo" value="PAGAMENTOS">
          <INPUT TYPE="hidden" name="modulo" value="ZFCN">
          <input type="hidden" name="INPARM" value="<%="ZFCN"&SoNumeros(var_linhadigitavel)%>">
          <input name="Submit" type="Submit" value="Cliente UNIBANCO: clique aqui e pague este Boleto">
        </div>
  </form></td>
  </tr>
  <tbody>
  </tbody>
</table>
<br>      
<table cellspacing=0 cellpadding=0 width=666 border=0>
  <tbody>
    <tr>
      <td colspan="5" class=cp align="right"><b class=cp>Recibo do Sacado</b></td>
    </tr>
  <tr>
    <td class=cp width=150><img src=/adm_imagens/logoUnibanco.gif width="150" height="40"></td>
    <td width=3 valign=bottom><img height=22 src=adm_imagens/3.gif width=2 border=0></td>
    <td class=cpt width=61 valign=bottom><div align=center><font class=bc><%=cons_banco%>-<%=cons_dvbanco%></font></div></td>
    <td width=3 valign=bottom><img height=22 src=adm_imagens/3.gif width=2 border=0></td>
    <td class=ld align=right width=452 valign=bottom><span class=ld> <%=var_linhadigitavel%> </span></td>
  </tr>
    <tr>
      <td colspan=5><img height=2 src=adm_imagens/2.gif width=666 border=0></td>
    </tr>
  </tbody>
</table>
<table width="672" border=0 cellpadding=0 cellspacing=0>
  <tbody>
    <tr>
      <td width=7 height=13 valign=top class=ct><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td height=13 valign=top class=ct>Cedente</td>
      <td width=7 height=13 valign=top class=ct><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td height=13 valign=top class=ct>Ag&ecirc;ncia/C&oacute;d. Cedente</td>
      <td width=7 height=13 valign=top class=ct><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td height=13 valign=top class=ct>Esp&eacute;cie</td>
      <td width=7 height=13 valign=top class=ct><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td height=13 valign=top class=ct>Qtde.</td>
      <td width=7 height=13 valign=top class=ct><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td height=13 valign=top class=ct>Nosso n&uacute;mero</td>
    </tr>
	<tr>
      <td class=ct valign=top height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top height=13><font face="Arial, Helvetica" size="-1"><%=cons_cedente%></font></td>
      <td class=ct valign=top height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top height=13><%=cons_agencia%>/<%=cons_conta%></td>
      <td class=ct valign=top height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top height=13><%=valorespecie%></td>
      <td class=ct valign=top height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top height=13><%=x98%></td>
      <td class=ct valign=top height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top height=13><%=var_nossonumero%>-<%=dvnossonumero%></td>
    </tr>
    <tr>
      <td valign=top height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td>
      <td valign=top><img height=1 src=adm_imagens/2.gif width=291 border=0></td>
      <td valign=top height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td>
      <td valign=top height=1><img height=1 src=adm_imagens/2.gif width=126 border=0></td>
      <td valign=top height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td>
      <td valign=top height=1><img height=1 src=adm_imagens/2.gif width=41 border=0></td>
      <td valign=top height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td>
      <td valign=top height=1><img height=1 src=adm_imagens/2.gif width=53 border=0></td>
      <td valign=top height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td>
      <td valign=top height=1><img height=1 src=adm_imagens/2.gif width=120 border=0></td>
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
      <td class=cp valign=top colspan=3 height=12><%=var_numerodoc%></td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top width=132 height=12><%=var_cpfcnpj%></td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top width=134 height=12><%=var_datavencimento%> </td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td width=180 height=12 align=right valign=top nowrap class=cp> <%=var_valordocumento%></td>
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
<table width="666" border=0 cellpadding=0 cellspacing=0>
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
      <td class=cp valign=top width=659 height=12> <%=var_sacado%> - CPF: <%=var_cpfSacado%></td>
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
      <td class=ct width=666>
        <div align=right>Corte na linha pontilhada</div></td>
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
    <td class=cp width=150><img src=/adm_imagens/logoUnibanco.gif width="150" height="40"></td>
    <td width=3 valign=bottom><img height=22 src=adm_imagens/3.gif width=2 border=0></td>
    <td class=cpt width=61 valign=bottom><div align=center><font class=bc><%=cons_banco%>-<%=cons_dvbanco%></font></div></td>
    <td width=3 valign=bottom><img height=22 src=adm_imagens/3.gif width=2 border=0></td>
    <td class=ld align=right width=452 valign=bottom><span class=ld> <%=var_linhadigitavel%> </span></td>
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
      <td class=cp valign=top align=right width=180 height=12><%=var_datavencimento%> </td>
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
      <td class=cp valign=top width=472 height=12><%=cons_cedente%> </td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top align=right width=180 height=12><%=cons_agencia%>/<%=cons_conta%> </td>
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
      <td class=ct valign=top  width=113 height=12><div align=left> <%=var_datadocumento%> </div></td>
      <td class=ct valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=163 height=12><%=var_numerodoc%> </td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top  width=62 height=12><div align=left>D.M.</div></td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top  width=34 height=12><div align=left> <%=x174%> </div></td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top  width=72 height=12><div align=left> <%=var_data%> </div></td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top align=right width=180 height=12><%=var_nossonumero%>-<%=dvnossonumero%> </td>
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
      <td class=cp valign=top  width=83><div align=left> <%=cons_carteira%> </div></td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top  width=53><div align=left><%=cons_especie%></div></td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top  width=123><%=x98%> </td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top  width=72><%=x101%> </td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top align=right width=180 height=12><%=var_valordocumento%></td>
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
		<img src="/linguagens/portuguesbr/imagens/logo.gif"><br>
        <%=obs_linha1%><br>
		<%=obs_linha2%><br>
		<%=obs_linha3%><br>
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
        </table>
	  </td>
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
        </table>
	  </td>
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
        </table>
	  </td>
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
      <td class=cp valign=top width=659 height=12><%=var_sacado%>-<%=var_cpfsacado%></td>
    </tr>
  </tbody>
</table>
<table cellspacing=0 cellpadding=0 border=0>
  <tbody>
    <tr>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top width=659 height=12><%=var_endereco%> - <%=var_bairro%> </td>
    </tr>
  </tbody>
</table>
<table cellspacing=0 cellpadding=0 border=0>
  <tbody>
    <tr>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top width=472 height=13><%=var_cep%>&nbsp;-&nbsp;<%=var_cidade%>&nbsp;-&nbsp;<%=var_estado%> </td>
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
      <td class=ct  width=250 ><div align=right>Autenticação mecânica - <b class=cp>Ficha de Compensação</b></div>
	  <font class=cn>Cód.Transação CVT: <b>7744-5</b></font></td>
    </tr>
    <tr>
      <td class=ct  colspan=3 ></td>
    </tr>
  </tbody>
</table>
<table cellspacing=0 cellPadding=0 width=666 border=0>
  <tbody>
    <tr>
      <td valign=bottom align=left height=50><%
Valor = var_codigobarras

Dim f, f1, f2, i
Dim texto
Const fino = 1
Const largo = 3
Const altura = 50
Dim BarCodes(99)

if isempty(BarCodes(0)) then
  BarCodes(0) = "00110"
  BarCodes(1) = "10001"
  BarCodes(2) = "01001"
  BarCodes(3) = "11000"
  BarCodes(4) = "00101"
  BarCodes(5) = "10100"
  BarCodes(6) = "01100"
  BarCodes(7) = "00011"
  BarCodes(8) = "10010"
  BarCodes(9) = "01010"
  for f1 = 9 to 0 step -1
    for f2 = 9 to 0 Step -1
      f = f1 * 10 + f2
      texto = ""
      for i = 1 To 5
        texto = texto & mid(BarCodes(f1), i, 1) + mid(BarCodes(f2), i, 1)
      next
      BarCodes(f) = texto
    next
  next
end if

%><img src=/adm_imagens/p.gif width=<%=fino%> height=<%=altura%> border=0><img 
src=/adm_imagens/b.gif width=<%=fino%> height=<%=altura%> border=0><img 
src=/adm_imagens/p.gif width=<%=fino%> height=<%=altura%> border=0><img 
src=/adm_imagens/b.gif width=<%=fino%> height=<%=altura%> border=0><img 

<%
texto = valor
if len( texto ) mod 2 <> 0 then
  texto = "0" & texto
end if


' Draw dos dados
do while len(texto) > 0
  i = cint( left( texto, 2) )
  texto = right( texto, len( texto ) - 2)
  f = BarCodes(i)
  for i = 1 to 10 step 2
    if mid(f, i, 1) = "0" then
      f1 = fino
    else
      f1 = largo
    end if
    %>


    src=/adm_imagens/p.gif width=<%=f1%> height=<%=altura%> border=0><img 
    <%
    if mid(f, i + 1, 1) = "0" Then
      f2 = fino
    else
      f2 = largo
    end if
    %>
    src=/adm_imagens/b.gif width=<%=f2%> height=<%=altura%> border=0><img 
    <%
  next
loop

' Draw guarda final
%>
src=/adm_imagens/p.gif width=<%=largo%> height=<%=altura%> border=0><img 
src=/adm_imagens/b.gif width=<%=fino%> height=<%=altura%> border=0><img 
src=/adm_imagens/p.gif width=<%=1%> height=<%=altura%> border=0>
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
      <td class=ct width=666><img src="/adm_imagens/sisors.gif" border=0></td>
    </tr>
  </tbody>
</table>
</html>