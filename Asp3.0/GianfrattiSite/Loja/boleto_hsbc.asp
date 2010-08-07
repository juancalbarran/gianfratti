<% response.buffer=false %>
<!-- #include file="config.asp" -->
<%
response.buffer=true 
response.expires = 0

x174 = "N" ' aceite

function Montar_Data_DDMMYYY(data)

			if Month(data) < 10 then
			iMonth = "0" & Month(data)
			else
			iMonth = Month(data)
			end if
			if Day(data) < 10 then
			iDay = "0" & Day(data)
			else
			iDay = Day(data)
			end if
			iYear = Year(data)
			
			Montar_Data_DDMMYYY = iDay & "/" & iMonth & "/" & iYear
end function

function Montar_Data_MMDDYYY(data)

			if Month(data) < 10 then
			iMonth = "0" & Month(data)
			else
			iMonth = Month(data)
			end if
			if Day(data) < 10 then
			iDay = "0" & Day(data)
			else
			iDay = Day(data)
			end if
			iYear = Year(data)
			
			Montar_Data_MMDDYYY = iMonth & "/" & iDay & "/" & iYear
end function

function money(number)
	
	pDecimalSign=","

	money 		= round(number,2)

	if pDecimalSign="," then

	 money		= replace(money,".",",")
	else

	 money		= replace(money,",",".")
	end if

	indexPoint	= instr(money, pDecimalSign)

	if indexPoint=0 then
	    money	= Cstr(money)+pDecimalSign+"00"
	end if

	moneyLarge	= len(money)
	decPart		= right(money,moneyLarge-indexPoint)

	for g=0 to (1- (moneyLarge-indexPoint))
	    money	= Cstr(money)+"0"    
	next
end function

Dim atab(99)

valorsacado=Request.QueryString("sacador")
valorendereco=Request.QueryString("endereco")
valorbairro=Request.QueryString("bairro")
valorcidade=Request.QueryString("cidade")
valorestado=Request.QueryString("estado")
valorcep=Request.QueryString("cep")
valorvencimento=Request.QueryString("datavencimento")
valornumerodoc=Request.QueryString("numerodoc")

cobra_boleto=false
valor_minimo_para_taxar_boleto = 50 'Valor menor que este será acrescido de taxa de boleto (coloque 0 para não usar esta função
if Request.QueryString("valordocumento") < valor_minimo_para_taxar_boleto then
	valor=2.80 'valor do boleto! pode definir a variavel no config.asp
	valorvalor1=valor+Request.QueryString("valordocumento")
else
	valorvalor1=Request.QueryString("valordocumento")
end if 



hoje=Montar_Data_DDMMYYY(date) 'Request.QueryString("hoje")
valoragencia=bol_agencia
valorced=bol_cedente
valorcedente1=bol_nr_cedente
valorcarteira=bol_carteira

x163="" ' Uso do Banco
x98="" ' Quantidade
x34= "R$" ' Especie
x174= "N" ' Aceite
x128 = "237"  ' Banco
x19 = "9" ' Moeda 
x160="R$" ' Especie 2

instrucoes_boleto=" &nbsp;&nbsp;&nbsp;&nbsp;"&instr_linha1&"<br>&nbsp;&nbsp;&nbsp;&nbsp;"&instr_linha2&"<br>&nbsp;&nbsp;&nbsp;&nbsp;"&instr_linha3&"<br>&nbsp;&nbsp;&nbsp;&nbsp;"&instr_linha4&" "
observacoes_boleto=" &nbsp;&nbsp;&nbsp;&nbsp;"&obs_linha1&"<br>&nbsp;&nbsp;&nbsp;&nbsp;"&obs_linha2&"<br>&nbsp;&nbsp;&nbsp;&nbsp;"&obs_linha3&"<br>&nbsp;&nbsp;&nbsp;&nbsp;"&obs_linha4&" "

valorcodbanco= "399"
cod_cnr="2"
tipo_identificador="4"
valorespecie="R$"
valorcedente=valorcedente1
valorcep=replace(valorcep,"-","")
valornossonumero=valornumerodoc

if hoje ="" then
	systime=now()
	dia = cstr(day(systime))
	if dia < 10 then dia = "0" & dia
	
	mes = cstr(month(systime))
	if mes < 10 then mes = "0" & mes
	
	ano = cstr(year(systime))
	
	hoje= dia & "/" & mes & "/" & ano 
end if

valordata=hoje

if valorvencimento="" or valorvencimento="//" or valornumerodoc="" or valorvalor1="" or valorsacado="" or valordata="" then
Response.Write "<br><br><font color='red'> Está faltando dados ou sua sessão encerrou.<br> Retorne e verifique seus dados no formulário.<br><br></font> "
end if

valorcedente2=replace(valorcedente,",","")
valorcedente2=replace(valorcedente2,".","")
valorcedente3=len(valorcedente2)
valorcedente4=7-valorcedente3
valorcedente= String(""&valorcedente4&"","0") & (""&valorcedente2&"")

valornossonumero2=replace(valornossonumero,",","")
valornossonumero2=replace(valornossonumero2,".","")
valornossonumero3=len(valornossonumero2)
valornossonumero4=13-valornossonumero3
valornossonumero= String(""&valornossonumero4&"","0") & (""&valornossonumero2&"")

valorvalor2=replace(valorvalor1,",","")
valorvalor2=replace(valorvalor2,".","")
valorvalor3=len(valorvalor2)
valorvalor4=10-valorvalor3
valorvalor= String(""&valorvalor4&"","0") & (""&valorvalor2&"")

if valorvalor1=0 then
valorvalor1=""
response.end
end if

data1=datevalue("04/07/2000")
data2=datevalue(valorvencimento)
fator_venc=data2-data1+1001

Anovalorvencimento=DatePart("yyyy",valorvencimento)
InicioAnovalorvencimento="01/01/" & Anovalorvencimento
data1=datevalue(InicioAnovalorvencimento)
data2=datevalue(valorvencimento)+1
data_juliano1=data2-data1
data_juliano2=len(data_juliano1)
data_juliano3=3-data_juliano2
data_juliano= String(""&data_juliano3&"","0") & (""&data_juliano1&"") & right(Anovalorvencimento,1)

FUNCTION Calc_dv_codbarra(CNOSSO)
atab(1)=4
atab(2)=3
ATAB(3)=2
ATAB(4)=9
ATAB(5)=8
ATAB(6)=7
ATAB(7)=6
ATAB(8)=5
ATAB(9)=4
ATAB(10)=3
ATAB(11)=2
atab(12)=9
ATAB(13)=8
ATAB(14)=7
ATAB(15)=6
ATAB(16)=5
ATAB(17)=4
ATAB(18)=3
ATAB(19)=2
ATAB(20)=9
ATAB(21)=8
atab(22)=7
ATAB(23)=6
ATAB(24)=5
ATAB(25)=4
ATAB(26)=3
ATAB(27)=2
ATAB(28)=9
ATAB(29)=8
ATAB(30)=7
ATAB(31)=6
atab(32)=5
ATAB(33)=4
ATAB(34)=3
ATAB(35)=2
ATAB(36)=9
ATAB(37)=8
ATAB(38)=7
ATAB(39)=6
ATAB(40)=5
ATAB(41)=4
atab(42)=3
ATAB(43)=2
NSOMA=0
NUNIDADE=0
NDIGITO=0

FOR NCONTA=1 TO 43
	NUNIDADE=MID(CNOSSO,NCONTA,1)
	NUNIDADE=MID(CNOSSO,NCONTA,1)*ATAB(NCONTA)
	NSOMA=NSOMA+NUNIDADE
NEXT

nsoma2=(NSOMA mod 11)
nsoma3=11-nsoma2

if nsoma2 = 0 or nsoma2 = 1 or nsoma2 = 10 then
ndigito=1
else
ndigito=nsoma3
end if

Calc_dv_codbarra=ndigito

END FUNCTION

cod_barra_1a4e6a44=valorcodbanco&"9"&fator_venc&valorvalor&valorcedente&valornossonumero&data_juliano&cod_cnr

dv5_codbarra=Calc_dv_codbarra(""&cod_barra_1a4e6a44&"")

cod_barra_completa=valorcodbanco&"9"&dv5_codbarra&fator_venc&valorvalor&valorcedente&valornossonumero&data_juliano&cod_cnr

digitavel_1a9=valorcodbanco&"9"&Left(valorcedente,5)
digitavel_11a20=right(valorcedente,2)&Left(valornossonumero,8)
digitavel_22a31=right(valornossonumero,5)&data_juliano&cod_cnr
digitavel_33a43=dv5_codbarra&fator_venc&valorvalor

FUNCTION Calc_dv10_digitavel(CNOSSO2)

atab(1)=2
atab(2)=1
ATAB(3)=2
ATAB(4)=1
ATAB(5)=2
ATAB(6)=1
ATAB(7)=2
ATAB(8)=1
ATAB(9)=2
NSOMA=0
NUNIDADE=0
NDIGITO=0

FOR NCONTA=1 TO 9
	NUNIDADE=MID(CNOSSO2,NCONTA,1)
	NUNIDADE=MID(CNOSSO2,NCONTA,1)*ATAB(NCONTA)
	if NUNIDADE=>10 then
	NUNIDADE=cint(left(NUNIDADE,1))+cint(right(NUNIDADE,1))
	end if

	NSOMA=NSOMA+NUNIDADE
NEXT

nsoma2=10-(NSOMA mod 10)

if nsoma2 = 10 then
ndigito=0
else
ndigito=nsoma2
end if

Calc_dv10_digitavel=ndigito

END FUNCTION

dv10_digitavel=Calc_dv10_digitavel(""&digitavel_1a9&"")

FUNCTION Calc_dv21_32_digitavel(CNOSSO2)

atab(1)=1
atab(2)=2
ATAB(3)=1
ATAB(4)=2
ATAB(5)=1
ATAB(6)=2
ATAB(7)=1
ATAB(8)=2
ATAB(9)=1
ATAB(10)=2
NSOMA=0
NUNIDADE=0
NDIGITO=0

FOR NCONTA=1 TO 10
	NUNIDADE=MID(CNOSSO2,NCONTA,1)
	NUNIDADE=MID(CNOSSO2,NCONTA,1)*ATAB(NCONTA)
	if NUNIDADE=>10 then
	NUNIDADE=cint(left(NUNIDADE,1))+cint(right(NUNIDADE,1))
	end if

	NSOMA=NSOMA+NUNIDADE
NEXT

nsoma2=10-(NSOMA mod 10)

if nsoma2 = 10 then
ndigito=0
else
ndigito=nsoma2
end if

Calc_dv21_32_digitavel=ndigito

END FUNCTION

dv21_digitavel=Calc_dv21_32_digitavel(""&digitavel_11a20&"")
dv32_digitavel=Calc_dv21_32_digitavel(""&digitavel_22a31&"")

linha_digitavel_continua=digitavel_1a9&dv10_digitavel&digitavel_11a20&dv21_digitavel&digitavel_22a31&dv32_digitavel&digitavel_33a43
linha_digitavel_completa=mid(digitavel_1a9,1,5)&"."&mid(digitavel_1a9,6,4)&dv10_digitavel&" "
linha_digitavel_completa=linha_digitavel_completa&mid(digitavel_11a20,1,5)&"."&mid(digitavel_11a20,6,5)&dv21_digitavel&" "
linha_digitavel_completa=linha_digitavel_completa&mid(digitavel_22a31,1,5)&"."&mid(digitavel_22a31,6,5)&dv32_digitavel&" "
linha_digitavel_completa=linha_digitavel_completa&mid(digitavel_33a43,1,1)&" "&mid(digitavel_33a43,2,15)

atab(13)=9
atab(12)=8
ATAB(11)=7
ATAB(10)=6
ATAB(9)=5
ATAB(8)=4
ATAB(7)=3
ATAB(6)=2
ATAB(5)=9
ATAB(4)=8
ATAB(3)=7
ATAB(2)=6
ATAB(1)=5

NSOMA=0
NUNIDADE=0
NDIGITO=0

FOR NCONTA=1 TO 13
	NUNIDADE=MID(valornossonumero,NCONTA,1)
	NUNIDADE=MID(valornossonumero,NCONTA,1)*ATAB(NCONTA)
	NSOMA=NSOMA+NUNIDADE
NEXT

nsoma2=(NSOMA mod 11)

if nsoma2=0 or nsoma2=10 then
ndigito=0
else
ndigito=nsoma2
end if

Calc_dv1_cod_documento=ndigito
Calc_dv2_cod_documento=tipo_identificador

atab(15)=9
atab(14)=8
ATAB(13)=7
ATAB(12)=6
ATAB(11)=5
ATAB(10)=4
ATAB(9)=3
ATAB(8)=2
ATAB(7)=9
ATAB(6)=8
ATAB(5)=7
ATAB(4)=6
ATAB(3)=5
ATAB(2)=4
ATAB(1)=3

NSOMA=0
NUNIDADE=0
NDIGITO=0
Dezena_NUNIDAD6=0

valornumerodoc_ident=valornossonumero&Calc_dv1_cod_documento&Calc_dv2_cod_documento

valorcedente_2=len(valorcedente)
valorcedente_3=15-valorcedente_2
valorcedente_4= String(""&valorcedente_3&"","0") & (""&valorcedente&"")

Anovencimento=MID(valorvencimento,9,2)
Mesvencimento=MID(valorvencimento,4,2)
Diavencimento=MID(valorvencimento,1,2)

Datavencimento=Diavencimento&Mesvencimento&Anovencimento
Datavencimento_2=len(Datavencimento)
Datavencimento_3=15-Datavencimento_2
Datavencimento_4= String(""&Datavencimento_3&"","0") & (""&Datavencimento&"")

FOR NCONTA=15 TO 1 step -1
	NUNIDAD=MID(valornumerodoc_ident,NCONTA,1)
	NUNIDAD2=MID(valorcedente_4,NCONTA,1)
	NUNIDAD3=MID(Datavencimento_4,NCONTA,1)
	NUNIDAD4=cint(NUNIDAD3)+cint(NUNIDAD2)+cint(NUNIDAD)+cint(Dezena_NUNIDAD6)
	
	if NUNIDAD4=>10 then
	NUNIDAD6=cint(right(NUNIDAD4,1))
	Dezena_NUNIDAD6=cint(left(NUNIDAD4,1))
	NUNIDAD4=NUNIDAD6
	else
	Dezena_NUNIDAD6=0
	end if

	NUNIDAD5=NUNIDAD4*ATAB(NCONTA)
	NSOMA=NSOMA+NUNIDAD5

NEXT

nsoma2=(NSOMA mod 11)

if nsoma2=0 or nsoma2=10 then
ndigito=0
else
ndigito=nsoma2
end if

Calc_dv3_cod_documento=ndigito

valornumerodoc_completa1=valornumerodoc&Calc_dv1_cod_documento&Calc_dv2_cod_documento&Calc_dv3_cod_documento
valornumerodoc_completa2=len(valornumerodoc_completa1)
valornumerodoc_completa3=16-valornumerodoc_completa2
valornumerodoc_completa= String(""&valornumerodoc_completa3&"","0") & (""&valornumerodoc_completa1&"")

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
  <tbody>
    <tr>
      <td colspan="5" class=cp align="right"><b class=cp>Recibo do Sacado</b></td>
    </tr>
    <tr>
      <td class=cp width=151>
        <div align=left><img src=/adm_imagens/logohsbc.gif width="150" height="40"></div></td>
      <td width=3 valign=bottom><img height=22 src=adm_imagens/3.gif width=2 border=0></td>
      <td class=cpt  width=62 valign=bottom><div align=center><font class=bc>399-9</font></div></td>
      <td width=3 valign=bottom><img height=22 src=adm_imagens/3.gif width=2 border=0></td>
      <td width=453 align=right valign=bottom nowrap class=ld><%= linha_digitavel_completa %></td>
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
      <td class=ct valign=top width=291 height=13><font face="Arial, Helvetica" size="-1"><%=valorced%></font></td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=126 height=13><%response.write valoragencia & " " & valorcedente1%></td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=41 height=13><%=valorespecie%></td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=45 height=13><%=x98%></td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=120 height=13><%=valornumerodoc_completa%></td>
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
      <td class=cp valign=top colspan=3 height=12> <%=valornumerodoc%> </td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top width=132 height=12> <%= cpf_cnpj%> </td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top width=134 height=12><%=valorvencimento%> </td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td width=180 height=12 align=right valign=top nowrap class=cp> <%=valorsacado%></td>
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
      <td class=cp valign=top width=659 height=12> <%=valorsacado%></td>
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
    <td class=cp width=150><img src=/adm_imagens/logohsbc.gif width="150" height="40"></td>
    <td width=3 valign=bottom><img height=22 src=adm_imagens/3.gif width=2 border=0></td>
    <td class=cpt width=61 valign=bottom><div align=center><font class=bc>399-9</font></div></td>
    <td width=3 valign=bottom><img height=22 src=adm_imagens/3.gif width=2 border=0></td>
    <td class=ld align=right width=452 valign=bottom><span class=ld> <%= linha_digitavel_completa %> </span></td>
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
      <td class=cp valign=top align=right width=180 height=12><%=valorvencimento%> </td>
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
      <td class=cp valign=top width=472 height=12><%=valorced%> </td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top align=right width=180 height=12><%response.write valoragencia & " " & valorcedente1%> </td>
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
      <td class=ct valign=top  width=113 height=12><div align=left> <%=valordata%>  </div></td>
      <td class=ct valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=163 height=12><%=valornumerodoc%></td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top  width=62 height=12><div align=left> <%=x34%> </div></td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top  width=34 height=12><div align=left> <%=x174%> </div></td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top  width=72 height=12><div align=left> <%=valordata%>  </div></td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top align=right width=180 height=12><%=valornumerodoc_completa%>  </td>
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
      <td class=cp valign=top  width=83><div align=left> <%=valorcarteira%> </div></td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top  width=53><div align=left> <%= valorespecie %> </div></td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top  width=123><%=x98%> </td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top  width=72><%=x101%> </td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top align=right width=180 height=12><%= valorvalor1 %></td>
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
      <td class=cp valign=top width=659 height=12><%=valorsacado%></td>
    </tr>
  </tbody>
</table>
<table cellspacing=0 cellpadding=0 border=0>
  <tbody>
    <tr>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top width=659 height=12><%=valorendereco%> - <%=valorbairro%> </td>
    </tr>
  </tbody>
</table>
<table cellspacing=0 cellpadding=0 border=0>
  <tbody>
    <tr>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top width=472 height=13><%=valorcep%> - <%=valorcidade%> - <%=valorestado%> </td>
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
      <td valign=bottom align=left height=50><%
Valor = cod_barra_completa
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

%>
<img src=adm_imagens/p.gif width=<%=fino%> height=<%=altura%> border=0><img src=adm_imagens/b.gif width=<%=fino%> height=<%=altura%> border=0><img src=adm_imagens/p.gif width=<%=fino%> height=<%=altura%> border=0><img src=adm_imagens/b.gif width=<%=fino%> height=<%=altura%> border=0><img 

<%
texto = valor
if len( texto ) mod 2 <> 0 then
  texto = "0" & texto
end if

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
    src=adm_imagens/p.gif width=<%=f1%> height=<%=altura%> border=0><img 
    <%
    if mid(f, i + 1, 1) = "0" Then
      f2 = fino
    else
      f2 = largo
    end if
    %>
    src=adm_imagens/b.gif width=<%=f2%> height=<%=altura%> border=0><img 
    <%
  next
loop

%>
src=adm_imagens/p.gif width=<%=largo%> height=<%=altura%> border=0><img 
src=adm_imagens/b.gif width=<%=fino%> height=<%=altura%> border=0><img 
src=adm_imagens/p.gif width=<%=1%> height=<%=altura%> border=0>
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
</body>
</html>