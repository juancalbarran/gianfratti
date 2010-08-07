<% response.buffer=false %>
<%
'#########################################################################################
'#----------------------------------------------------------------------------------------
'#########################################################################################
'#
'#  CÓDIGO: VirtuaStore Versão OPEN - Copyright 2001-2004 VirtuaStore
'#  URL: http://comunidade.virtuastore.com.br
'#  E-MAIL: comunidade@virtuastore.com.br
'#  AUTORES: Otávio Dias(Desenvolvedor)
'#  GRUPO DE DISCUSSÃO: Virtua Developer (http://br.groups.yahoo.com/group/virtuadeveloper)
'#
'#     Este programa é um software livre; você pode redistribuí-lo e/ou 
'#     modificá-lo sob os termos do GNU General Public License como 
'#     publicado pela Free Software Foundation.
'#     É importante lembrar que qualquer alteração feita no programa 
'#     deve ser informada e enviada para os criadores, através de e-mail 
'#     ou da página de onde foi baixado o código.
'#
'#  //-------------------------------------------------------------------------------------
'#  // 
'#  // LEIA COM ATENÇÃO: O software VirtuaStore OPEN deve conter as frases
'#  // "Powered by VirtuaStore OPEN" ou "Software derivado de VirtuaStore 3.0" e 
'#  // o link para o site http://comunidade.virtuastore.com.br no créditos da 
'#  // sua loja virtual para ser utilizado gratuitamente.
'#  // Se o link e/ou uma das frases não estiver presentes ou visiveis este
'#  // software deixará de serconsiderado Open-source(gratuito) e o uso sem autorização 
'#  // terá penalidades judiciais de acordo com as leis de pirataria de software.
'#  // 
'#  // Se você concordar, pedimos que visando divulgar o nosso grupo de discussão, pedimos
'#  // que seja mantido o link para o Grupo Virtua Developer
'#  // (http://br.groups.yahoo.com/group/virtuadeveloper)
'#  // 
'#  //--------------------------------------------------------------------------------------
'#      
'#     Este programa é distribuído com a esperança de que lhe seja útil,
'#     porém SEM NENHUMA GARANTIA. Veja a GNU General Public License
'#     abaixo (GNU Licença Pública Geral) para mais detalhes.
'# 
'#     Você deve receber a cópia da Licença GNU com este programa, 
'#     caso contrário escreva para
'#     Free Software Foundation, Inc., 59 Temple Place, Suite 330, 
'#     Boston, MA  02111-1307  USA
'# 
'#     Para ajuda e suporte acesse um dos sites abaixo:
'#     http://comunidade.virtuastore.com.br
'#     http://br.groups.yahoo.com/group/virtuadeveloper
'#     
'#     ********************************
'#     Créditos do Código Original
'#     ********************************
'#     Os arquivos originais da versão 3.0 foram baixados do Grupo VirtuaStore
'#     (http://br.groups.yahoo.com/group/virtuastore) e revisados e adaptados pela
'#     equipe do Grupo Virtua Developer (http://br.groups.yahoo.com/group/virtuadeveloper)
'#
'#     BOM PROVEITO!          
'#     Equipe VirtuaStore & Grupo Virtua Developer
'#     []'s
'#
'#########################################################################################
'#----------------------------------------------------------------------------------------
'#########################################################################################
%>
<!-- #include file="config.asp" -->
<%
'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
'Atenção: Este arquivo não pode ser distrubuído ou separado desta VirtuaStore OPEN
'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Session.Lcid = "1046"

'=============== DADOS DO CEDENTE (Configurado no Config.asp) =================
cedente = bol_cedente '"SUA EMPRESA LTDA"
cpf_cnpj = "" '"03.213.418/0001-75"
agencia = bol_agencia '"3552"' Numero da Agência
dac_agencia = bol_dagencia '"1" ' Digito da Agência
conta = bol_conta '"6038" ' Numero da Conta
dac_conta = bol_dconta '"0" ' 1 Digito da Conta
carteira = bol_carteira '"18"
convenio = bol_convenio '"298502"  '  Antigo "295292"  


'================ DADOS DO BOLETO ==================

if hoje ="" then
	systime=now()
	dia = cstr(day(systime))
	if dia < 10 then dia = "0" & dia
	
	mes = cstr(month(systime))
	if mes < 10 then mes = "0" & mes
	
	ano = cstr(year(systime))
	
	hoje= dia & "/" & mes & "/" & ano 
end if

if Request.QueryString("valordocumento") < 50 then
	valor=2.80
	valor=valor+Request.QueryString("valordocumento")
else
	valor=Request.QueryString("valordocumento")
end if 


if now()>cdate(Request.QueryString("datavencimento")) then
	data_vencimento=now()+5
else
	data_vencimento=Request.QueryString("datavencimento")
end if

data_documento = hoje
numero_documento =  9000000000+cint(Request.QueryString("numerodoc"))
nosso_numero = 9000000000+cint(Request.QueryString("numerodoc")) ' ATENÇÃO Maximo de 5 Digitos 

'=========== DADOS DA SACADO =======================
nome_sacado = Request.QueryString("sacador") 
endereco_sacado =  Request.QueryString("endereco")
endereco_sacado2 = Request.QueryString("bairro") & Request.QueryString("cidade") & Request.QueryString("estado") & Request.QueryString("cep")

'================INSTRUÇÕES DO BOLETO ==============
instrucoes1 = instr_linha1
instrucoes2 = instr_linha2
instrucoes3 = instr_linha3
instrucoes4 = instr_linha4
instrucoes5 = instr_linha5
'=====================================================

especie = "R$"
especie_doc = "RC"
aceite = "N"

fvencimento = Cstr(fvenc(data_vencimento))
valor_str = Cstr(formatar(valor,10,"0","v"))
agencia = Cstr(formatar(agencia,4,"0","e"))

'*** Convenio com 7 digitos
if len(convenio) = 7 then
  convenio = CStr(formatar(convenio, 7, "0", "e"))
  nosso_numero = CStr(formatar(nosso_numero, 10, "0", "e"))
end if


'*** Convenio com 6 digitos
if len(convenio) = 6 then
  convenio = CStr(formatar(convenio, 6, "0", "e"))
  nosso_numero = CStr(formatar(nosso_numero, 5, "0", "e"))
end if


nosso_numero = Cstr(convenio) & Cstr(nosso_numero) ' Conv + NN

'response.Write("nosso_numero="&nosso_numero&"ok")

conta = Cstr(formatar(conta,8,"0","e"))
carteira = Cstr(formatar(carteira,2,"0","e"))

'*** Convenio com 7 digitos
if len(convenio) = 7 then
	'response.Write("6zeros=000000ok<br>")
	'response.Write("convenio="&convenio &"ok<br>")
	'response.Write("nosso_numero="&right(nosso_numero,10)&"ok<br>")
	'response.Write("carteira="&carteira&"ok")
   livre = CStr("000000" & convenio & right(nosso_numero,10) & carteira)
   'response.Write("livre="&livre&"ok<br>")
end if

'*** Convenio com 6 digitos
if len(convenio) = 6 then
  livre = CStr(nosso_numero & agencia & conta & carteira)
end if

codbar = Cstr("0019" & fvencimento  & valor_str & livre)
dac = Cstr(mod11(codbar,9,0))
codbar = Cstr("0019" & dac & fvencimento & valor_str & livre)
linha_digitavel = linhadigitavel(codbar)
nosso_numero = nosso_numero &"-"& mod11(nosso_numero,9,0)
agencia_codigo = agencia &"-"& dac_agencia & " / " & conta &"-"& dac_conta
valor = formatnumber(Ccur(valor),2,-2,-2,-2)


function data_bol(entra)
	data_bol = day(entra) & "/" & month(entra) & "/" & year(entra)
end function
FUNCTION mod11(cadeia,limitesup,lflag)
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
	mod11=nresto
else
	if nresto=0 or nresto=1 or nresto=10 then
		ndig=1
	else
		ndig=11 - nresto	
	end if
	mod11=ndig
end if
END FUNCTION

FUNCTION mod10(cadeia)
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
	mod10=total
END FUNCTION

FUNCTION linhadigitavel(codigobarras)
'**************************
cmplivre=mid(codigobarras,20,25)
campo1=left(codigobarras,4)&mid(cmplivre,1,5)
campo1=campo1&mod10(campo1)
campo1=mid(campo1,1,5)&"."&mid(campo1,6,5)

campo2=mid(cmplivre,6,10)
campo2=campo2&mod10(campo2)
campo2=mid(campo2,1,5)&"."&mid(campo2,6,6)

campo3=mid(cmplivre,16,10)
campo3=campo3&mod10(campo3)
campo3=mid(campo3,1,5)&"."&mid(campo3,6,6)

campo4=mid(codigobarras,5,1)

campo5=int(mid(codigobarras,6,14))

if campo5=0 then
	campo5="000"
end if

linhadigitavel=campo1&"  "&campo2&"  "&campo3&"  "&campo4&"  "&campo5

END FUNCTION

function fvenc(entra)
 fvenc = DateDiff("d", CDate("7/10/1997"), CDate(entra))
end function

function formatar(valor, comp, ench, tipo)
dim str
str = valor
	if tipo = "v" then
		str = Ccur(str)
		str = formatnumber(str,2,-2,-2,-2)
		tipo = "e" : str = cstr(str)
		str = replace(str,",","")
		str = replace(str,".","")
	end if
	for a=len(str) to (comp - 1)
		if tipo = "e" then
			str = ench & str 
		else
			str = str & ench
		end if
	next
	formatar = str
end function

function d1d2(entra)
	d1 = mod10(entra)
	Do
		d2 = mod11(entra & d1,7,1)
		if d2 = 1 then
			if d2 = 9 then
				d1 = 0
			elseif d1 < 9 then
				d1 = d1 + 1
			else
				d1 = 0
			end if		
		end if
	Loop while d2 = 1
	if d2 > 0 then
		d2 = 11 - d2
	end if
	d1d2 = Cstr(Cstr(entra) & Cstr(d1) & Cstr(d2))
end function


%>
<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>
<HTML>
<HEAD>
<TITLE><%= nomeloja %> - <%= Slogan_da_sua_loja %></TITLE><META http-equiv=Content-Type content=text/html; charset=windows-1252><meta name=GENERATOR content=NetDinamica><style type=text/css>
<!--.cp {  font: bold 10px Arial; color: black}
<!--.ti {  font: 9px Arial, Helvetica, sans-serif}
<!--.ld { font: bold 15px Arial; color: #000000}
<!--.ct { FONT: 10px "Arial"; color: #333333}
<!--.cn { FONT: 9px Arial; color: black }
<!--.bc { font: bold 22px Arial; color: #000000 }
--></style>
</HEAD>
<BODY text="#000000" bgcolor="#ffffff" topMargin="0" rightMargin="0" >
<table border=1 cellpadding=5 cellspacing=0 width=666 bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFFF">
  <tr>
    <td colspan="2">
      <center>
        <font size="-1" face="Arial, Helvetica, sans-serif"><img src="/linguagens/portuguesbr/imagens/logo.gif" border="0"></font>
      </center>      </td>
  </tr>
  <tr>
  <td width="521" class=ti> <div align="center">Instru&ccedil;&otilde;es de Impress&atilde;o<br>
        Imprimir em impressora jato de tinta (ink jet) ou laser em qualidade normal. (N&atilde;o use modo econ&ocirc;mico). <br>
  Utilize folha A4 (210 x 297 mm) ou Carta (216 x 279 mm) - Corte na linha indicada <br>
  Caso n&atilde;o apare&ccedil;a os C&oacute;digos de Barra no fim do boleto, clique em F5 do seu teclado.<br>
  </div></td>
  <td width="119"> <div align="center"><font size="-1" face="Arial, Helvetica, sans-serif">   <strong>Imprimir Boleto    <br>
        <img src="/linguagens/portuguesbr/imagens/printbutton.gif" border="0" onClick="window.print()"> </strong></font></div></td>
  </tr>
  <tbody>
  </tbody>
</table><br>
<table cellspacing=0 cellpadding=0 width=666 border=0>
   <tbody>
   <tr><td colspan="5" class=cp align="right"><b class=cp>Recibo do Sacado</b></td></tr>
   <tr><td class=cp width=151>
   <div align=left><img src=adm_imagens/logo_bb.gif WIDTH="150" HEIGHT="40"></div></td><td width=3 valign=bottom><img height=22 src=adm_imagens/3.gif width=2 border=0></td><td class=cpt  width=62 valign=bottom><div align=center><font class=bc>001-9</font></div></td><td width=3 valign=bottom><img height=22 src=adm_imagens/3.gif width=2 border=0></td><td width=453 align=right valign=bottom nowrap class=ld><span class=ld> 
<%=linha_digitavel%> </span></td></tr><tr><td colspan=5><img height=2 src=adm_imagens/2.gif width=666 border=0></td></tr></tbody></table><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=291 height=13>Cedente</td><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=126 height=13>Agência/Cód. Cedente</td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=41 height=13>Espécie</td><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=45 height=13>Qtde.</td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=120 height=13>Nosso 
número</td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top height=12> 
<%=cedente%> </td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top width=126 height=12> 
<%=agencia_codigo%> </td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top height=12> 
<%=especie%> </td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top height=12> 
<%=x98%> </td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td width=120 height=12 align=right valign=top nowrap class=cp> 
<%=nosso_numero%> </td></tr><tr><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top><img height=1 src=adm_imagens/2.gif width=291 border=0></td><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=126 height=1><img height=1 src=adm_imagens/2.gif width=126 border=0></td><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=34 height=1><img height=1 src=adm_imagens/2.gif width=41 border=0></td><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=53 height=1><img height=1 src=adm_imagens/2.gif width=53 border=0></td><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=120 height=1><img height=1 src=adm_imagens/2.gif width=120 border=0></td></tr></tbody></table><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top colspan=3 height=13>Número 
do documento</td><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=132 height=13>CPF/CNPJ</td><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=134 height=13>Vencimento</td><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=180 height=13>Valor 
documento</td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top colspan=3 height=12> 
<%=numero_documento%> </td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top width=132 height=12> 
<%= cpf_cnpj%> </td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top width=134 height=12> 
<%=data_vencimento%> </td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td width=180 height=12 align=right valign=top nowrap class=cp> 
<%=valor%> </td></tr><tr><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=113 height=1><img height=1 src=adm_imagens/2.gif width=113 border=0></td><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=72 height=1><img height=1 src=adm_imagens/2.gif width=72 border=0></td><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=132 height=1><img height=1 src=adm_imagens/2.gif width=132 border=0></td><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=134 height=1><img height=1 src=adm_imagens/2.gif width=134 border=0></td><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td></tr></tbody></table><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=126 height=13>(-) Desconto / Abatimento</td>
      <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=112 height=13>(-) 
Outras deduções</td><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top height=13>(+) 
Mora / Multa</td><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=113 height=13>(+) 
Outros acréscimos</td><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=180 height=13>(=) 
Valor cobrado</td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top align=right width=113 height=12></td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top align=right width=112 height=12></td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top align=right height=12>&nbsp;</td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top align=right width=113 height=12></td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top align=right width=180 height=12></td></tr><tr><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top><img height=1 src=adm_imagens/2.gif width=126 border=0></td><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=112 height=1><img height=1 src=adm_imagens/2.gif width=112 border=0></td><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top><img height=1 src=adm_imagens/2.gif width=100 border=0></td><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=113 height=1><img height=1 src=adm_imagens/2.gif width=113 border=0></td><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td></tr></tbody></table>
	  
	  <table cellspacing=0 cellpadding=0 border=0>
	  <tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=659 height=13>Sacado</td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top width=659 height=12> 
<%=nome_sacado %></td></tr>
<tr>
	<td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td>
        <td valign=top width=659 height=1><img height=1 src=adm_imagens/2.gif width=659 border=0></td>
</tr></tbody></table>
<table width="666" border=0 cellpadding=0 cellspacing=0>
   <tbody>
	<tr>
		<td class=ct  width=7 height=12></td>
		<td class=ct  width=500 >Instruções</td>
	    <td class=ct  width=7 height=12></td><td class=ct  width=152 ><div align="right">Autenticação mecânica</div></td>
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
<table cellspacing=0 cellpadding=0 width=666 border=0><tr><td class=ct width=666></td></tr><tbody><tr><td class=ct width=666> 
<div align=right>Corte na linha pontilhada</div></td></tr><tr><td class=ct width=666 align="right"><img src="adm_imagens/sisors.gif" border=0><br>
  <br></td></tr></tbody></table>
<table cellspacing=0 cellpadding=0 width=662 border=0><tbody><tr><td class=cp width=151><div align=left><img src=adm_imagens/logo_bb.gif WIDTH="150" HEIGHT="40"></div></td><td width=3 valign=bottom><img height=22 src=adm_imagens/3.gif width=2 border=0></td><td class=cpt  width=62 valign=bottom><div align=center><font class=bc>001-9</font></div></td><td width=3 valign=bottom><img height=22 src=adm_imagens/3.gif width=2 border=0></td><td class=ld align=right width=453 valign=bottom><span class=ld> 
<%=linha_digitavel%> </span></td></tr><tr><td colspan=5><img height=2 src=adm_imagens/2.gif width=666 border=0></td></tr></tbody></table><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=472 height=13>Local 
de pagamento</td><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=180 height=13>Vencimento</td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=cp valign=top width=472 height=12>AT&Eacute; O VENCIMENTO, PAG&Aacute;VEL 
        EM QUALQUER AG&Ecirc;NCIA BANC&Aacute;RIA</td>
      <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top align=right width=180 height=12> 
<b><%=data_vencimento%></b></td></tr><tr><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=472 height=1><img height=1 src=adm_imagens/2.gif width=472 border=0></td><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td></tr></tbody></table><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=472 height=13>Cedente</td><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=180 height=13>Agência/Código 
cedente</td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top width=472 height=12> 
<%=cedente%> </td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top align=right width=180 height=12> 
<%=agencia_codigo%> </td></tr><tr><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=472 height=1><img height=1 src=adm_imagens/2.gif width=472 border=0></td><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td></tr></tbody></table><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13> 
<img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=113 height=13>Data 
do documento</td><td class=ct valign=top width=7 height=13> <img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=163 height=13>N<u>o</u> 
documento</td><td class=ct valign=top width=7 height=13> <img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=62 height=13>Espécie 
doc.</td><td class=ct valign=top width=7 height=13> <img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=34 height=13>Aceite</td><td class=ct valign=top width=7 height=13> 
<img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=72 height=13>Data process.</td>
      <td class=ct valign=top width=7 height=13> <img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=180 height=13>Nosso 
número</td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top  width=105 height=12><div align=left> 
<%=date()%> </div></td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top width=163 height=12> 
<%=numero_documento%> </td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top  width=62 height=12><div align=left> 
<%=especie_doc%> </div></td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top  width=34 height=12><div align=left> 
<%=aceite%> </div></td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top  width=72 height=12><div align=left> 
<%=date()%> </div></td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top align=right width=180 height=12> 
<%=nosso_numero%> </td></tr><tr><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=105 height=1><img height=1 src=adm_imagens/2.gif width=113 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=163 height=1><img height=1 src=adm_imagens/2.gif width=163 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=62 height=1><img height=1 src=adm_imagens/2.gif width=62 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=34 height=1><img height=1 src=adm_imagens/2.gif width=34 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=72 height=1><img height=1 src=adm_imagens/2.gif width=72 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=180 height=1> 
<img height=1 src=adm_imagens/2.gif width=180 border=0></td></tr></tbody></table><table cellspacing=0 cellpadding=0 border=0><tbody> 
<tr> <td class=ct valign=top width=7 height=13> <img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top colspan=3 height=13>Uso 
do banco</td><td class=ct valign=top height=13 width=7> <img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=83 height=13>Carteira</td><td class=ct valign=top height=13 width=7> 
<img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=53 height=13>Espécie</td><td class=ct valign=top height=13 width=7> 
<img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=123 height=13>Quantidade</td><td class=ct valign=top height=13 width=7> 
<img height=13 src=adm_imagens/1.gif width=1 border=0></td>
      <td class=ct valign=top width=72 height=13> Valor Doc.</td>
      <td class=ct valign=top width=7 height=13> <img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=180 height=13>(=) 
Valor documento</td></tr><tr> <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td valign=top class=cp height=12 colspan=3> 
<%=x163%> </td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top  width=83> 
<div align=left> <%=carteira%> </div></td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top  width=53><div align=left> 
<%=especie%> </div></td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top  width=123> 
<%=v_quant%> </td><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top  width=72> 
<%=v_vl%> </td><td class=cp valign=top width=7 height=12> <img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top align=right width=180 height=12> 
<%=valor%> </td></tr><tr><td valign=top width=7 height=1> <img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=75 border=0></td><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=31 height=1><img height=1 src=adm_imagens/2.gif width=31 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=83 height=1><img height=1 src=adm_imagens/2.gif width=83 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=53 height=1><img height=1 src=adm_imagens/2.gif width=53 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=123 height=1><img height=1 src=adm_imagens/2.gif width=123 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=72 height=1><img height=1 src=adm_imagens/2.gif width=72 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td></tr></tbody></table><table cellspacing=0 cellpadding=0 width=666 border=0><tbody><tr><td align=right width=10><table cellspacing=0 cellpadding=0 border=0 align=left><tbody> 
<tr> <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td></tr><tr> 
<td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td></tr><tr> 
<td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=1 border=0></td></tr></tbody></table></td><td valign=top width=468 rowspan=5><font class=ct>Instruções 
(Texto de responsabilidade do cedente)</font><br><img src="/linguagens/portuguesbr/imagens/logo.gif"><span class=cp> <%response.write x80 & "<br>" : response.write x171 & "<br>"
response.write instrucoes1 & "<br>" 
response.write instrucoes2 & "<br>" 
 %> 
</span></td><td align=right width=188><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=180 height=13>(-) 
Desconto / Abatimentos</td></tr><tr> <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top align=right width=180 height=12></td></tr><tr> 
<td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td></tr></tbody></table></td></tr><tr><td align=right width=10> 
<table cellspacing=0 cellpadding=0 border=0 align=left><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td></tr><tr><td valign=top width=7 height=1> 
<img height=1 src=adm_imagens/2.gif width=1 border=0></td></tr></tbody></table></td><td align=right width=188><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=180 height=13>(-) 
Outras deduções</td></tr><tr><td class=cp valign=top width=7 height=12> <img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top align=right width=180 height=12></td></tr><tr><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td></tr></tbody></table></td></tr><tr><td align=right width=10> 
<table cellspacing=0 cellpadding=0 border=0 align=left><tbody><tr><td class=ct valign=top width=7 height=13> 
<img height=13 src=adm_imagens/1.gif width=1 border=0></td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td></tr><tr><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=1 border=0></td></tr></tbody></table></td><td align=right width=188> 
<table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=180 height=13>(+) 
Mora / Multa</td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top align=right width=180 height=12></td></tr><tr> 
<td valign=top width=7 height=1> <img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=180 height=1> 
<img height=1 src=adm_imagens/2.gif width=180 border=0></td></tr></tbody></table></td></tr><tr><td align=right width=10><table cellspacing=0 cellpadding=0 border=0 align=left><tbody><tr> 
<td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td></tr><tr><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=1 border=0></td></tr></tbody></table></td><td align=right width=188> 
<table cellspacing=0 cellpadding=0 border=0><tbody><tr> <td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=180 height=13>(+) 
Outros acréscimos</td></tr><tr> <td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top align=right width=180 height=12></td></tr><tr><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td></tr></tbody></table></td></tr><tr><td align=right width=10><table cellspacing=0 cellpadding=0 border=0 align=left><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td></tr></tbody></table></td><td align=right width=188><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=180 height=13>(=) 
Valor cobrado</td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top align=right width=180 height=12></td></tr></tbody> 
</table></td></tr></tbody></table><table cellspacing=0 cellpadding=0 width=666 border=0><tbody><tr><td valign=top width=666 height=1><img height=1 src=adm_imagens/2.gif width=666 border=0></td></tr></tbody></table><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=659 height=13>Sacado</td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top width=659 height=12> 
<%=nome_sacado %> </td></tr></tbody></table><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=cp valign=top width=7 height=12><img height=12 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top width=659 height=12> 
<%=endereco_sacado %> </td></tr></tbody></table><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=cp valign=top width=472 height=13><%=endereco_sacado2 %> 
</td><td class=ct valign=top width=7 height=13><img height=13 src=adm_imagens/1.gif width=1 border=0></td><td class=ct valign=top width=180 height=13>Cód. 
baixa</td></tr><tr><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=472 height=1><img height=1 src=adm_imagens/2.gif width=472 border=0></td><td valign=top width=7 height=1><img height=1 src=adm_imagens/2.gif width=7 border=0></td><td valign=top width=180 height=1><img height=1 src=adm_imagens/2.gif width=180 border=0></td></tr></tbody></table><table cellspacing=0 cellPadding=0 border=0 width=666><tbody><tr><td class=ct  width=7 height=12></td><td class=ct  width=409 >Sacador/Avalista</td><td class=ct  width=250 ><div align=right>Autenticação 
mecânica - <b class=cp>Ficha de Compensação</b></div></td></tr><tr><td class=ct  colspan=3 ></td></tr></tbody></table><table cellspacing=0 cellPadding=0 width=666 border=0><tbody><tr><td valign=bottom align=left height=50> 
<%cod_bar(codbar)
Sub cod_bar( x22 )
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
%> <img src=adm_imagens/p.gif width=<%=x85%> height=<%=x44%> border=0><img 
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
<% end sub %></td></tr></tbody></table><table cellspacing=0 cellPadding=0 width=666 border=0><tr><td class=ct width=666></td></tr><tbody><tr><td class=ct width=666><div align=right>Corte 
na linha pontilhada</div></td></tr><tr><td class=ct width=666 align="right"><img src="adm_imagens/sisors.gif" border=0></td>
</tr></tbody></table>
<br><br>
</BODY></HTML>