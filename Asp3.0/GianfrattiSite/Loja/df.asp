<% 
'#########################################################################################
'#----------------------------------------------------------------------------------------
'#########################################################################################
'#
'#  CÓDIGO: VirtuaStore Versão OPEN - Copyright 2001-2004 VirtuaStore
'#  URL: http://comunidade.virtuastore.com.br
'#  E-MAIL: comunidade@virtuastore.com.br
'#  AUTORES: Otávio Dias(Desenvolvedor)
'# 
'#     Este programa é um software livre; você pode redistribuí-lo e/ou 
'#     modificá-lo sob os termos do GNU General Public License como 
'#     publicado pela Free Software Foundation.
'#     É importante lembrar que qualquer alteração feita no programa 
'#     deve ser informada e enviada para os criadores, através de e-mail 
'#     ou da página de onde foi baixado o código.
'#
'#  //-------------------------------------------------------------------------------------
'#  // LEIA COM ATENÇÃO: O software VirtuaStore OPEN deve conter as frases
'#  // "Powered by VirtuaStore OPEN" ou "Software derivado de VirtuaStore 1.2" e 
'#  // o link para o site http://comunidade.virtuastore.com.br no créditos da 
'#  // sua loja virtual para ser utilizado gratuitamente. Se o link e/ou uma das 
'#  // frases não estiver presentes ou visiveis este software deixará de ser
'#  // considerado Open-source(gratuito) e o uso sem autorização terá 
'#  // penalidades judiciais de acordo com as leis de pirataria de software.
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
'#     Para enviar suas dúvidas, sugestões e/ou contratar a VirtuaWorks 
'#     Internet Design entre em contato através do e-mail 
'#     contato@virtuaworks.com.br ou pelo endereço abaixo: 
'#     Rua Venâncio Aires, 1001 - Niterói - Canoas - RS - Brasil. Cep 92110-000.
'#
'#     Para ajuda e suporte acesse um dos sites abaixo:
'#     http://comunidade.virtuastore.com.br
'#     http://br.groups.yahoo.com/group/virtuastore
'#
'#     BOM PROVEITO!          
'#     Equipe VirtuaStore
'#     []'s
'#
'#########################################################################################
'#----------------------------------------------------------------------------------------
'#########################################################################################

'INÍCIO DO CÓDIGO

'Este código está otimizado e roda tanto em Windows 2000/NT/XP/ME/98 quanto em servidores UNIX-LINUX com chilli!ASP

'Declaração das variaveis comuns
Dim razaoloja
Dim bancopag
Dim contapag
Dim pagpara
Dim agpag
Dim bancopag2
Dim contapag2
Dim pagpara2
Dim agpag2
Dim varimg
Dim pesquisa
Dim strTextoHtml 
Dim conexao 
DIm abredb
Dim dados 

Dim nomeloja 
Dim slogan 
Dim emailloja 
Dim urlloja 
Dim tituloloja 
Dim endereco11 
Dim bairro11 
Dim cidade11 
Dim estado11 
Dim pais11 
Dim fone11 
Dim razao 
Dim Mes 
Dim meszz 
Dim diazz 
Dim dataz 
Dim i 
Dim dia 
Dim mez 
Dim strLink 
Dim strAcao 
Dim contacompra 
Dim contacli 
Dim estadoz 
Dim rs 
Dim r2 
Dim finalera 
Dim pag 
Dim pesss 
Dim pagdxx 
Dim pesqsa 
Dim catege 
Dim fDia 
Dim mezito 
Dim anito 
Dim data 
Dim Ano 
Dim j 
Dim ndiasmes 
Dim anozinho 
Dim palavra 
Dim inicial 
Dim final 
Dim restinho 
Dim totalreg 
Dim pagina2 
Dim pagina3 
Dim rs2 
Dim nSem 
Dim aDiasMes 
Dim strString 
Dim UploadRequest 
Dim objFSO 
Dim ObjFile 
Dim ObjStream 
Dim arquivodat 
Dim separador 
Dim senhaok 
Dim VersaoDb
Dim StringdeConexao

'Seta as datas para: dd/mm/aaaa e moedas para: R$ 0.00*
Session.LCID = 1046

'Comando para ativar o uso do response.redirect 
response.buffer = true

'Comando faz pular a linha em caso de erro
on error resume next

'Chama o config.asp
%><!--#include file="config.asp"--><%

'Chama o criptografia.asp
%><!--#include file="criptografia.asp"--><%

'Chama os dados da loja
nomeloja = application("nomeloja")
emailloja = application("emailloja")
slogan = application("slogan")
urlloja = application("urlloja")
endereco11 = application("endereco11")
bairro11 = application("bairro11")
cidade11 = application("cidade11")
estado11 = application("estado11")
pais11 = application("pais11")
fone11 = application("fone11")
bancopag = application("bancopag")
agpag = application("agpag")
contapag = application("contapag")
pagpara = application("pagpara")
bancopag2 = application("bancopag2")
agpag2 = application("agpag2")
contapag2 = application("contapag2")
pagpara2 = application("pagpara2")
tituloloja = nomeloja&" - "&slogan
fonte = application("fonte")
maopropria = application("maopropria")
diasentrega = application("diasentrega")
corfundo = application("corfundo")
cor1 = application("cor1")
cor2 = application("cor2")
cor3 = application("cor3")
cor4= application("cor4")
cor5= application("cor5")
cor6= application("cor6")
fontebranca = application("fontebranca")
fontepreta = application("fontepreta")
corborda = application("corborda")
URLComponentesVisa=application("URLComponentesVisa")
NumeroRegistroVisa=application("NumeroRegistroVisa")
NomeArquivoVisa   =application("NomeArquivoVisa")
ValorAutenticacao =application("ValorAutenticacao") 
URLCodvRedeCard   =application("URLCodvRedeCard")
FiliacaoRedeCard  =application("FiliacaoRedeCard")
URLRetornoRedeCard=application("URLRetornoRedeCard")

'Variaveis para calculo do frete
if session("frete") = "" then
valorfrete = 0.00
else
valorfrete = session("frete") + maopropria
session.timeout = 60
end if
estatus = left(ucase(session("estado")),2)
session.timeout = 60
estaos = session("estado")
session.timeout = 60
if session("peso") = "" then
pesoz = 0
else
pesoz = session("peso")
end if
if session("estado2") = "" then
estado2 = ""
else
estado2 = session("estado2") 
end if

if session("df") = "sim" then 
session("df") = "nao"
response.end
end if

StrTopo = "<!--" & vbNewline
StrTopo = StrTopo & "O que você está procurando?" & vbNewline
StrTopo = StrTopo & "What are you lookin' for?" & vbNewline
StrTopo = StrTopo & "" & vbNewline
StrTopo = StrTopo & "Copyright(c) VirtuaStore Soluções em comércio eletrônico" & vbNewline
StrTopo = StrTopo & "All Rights Reserved." & vbNewline
StrTopo = StrTopo & "------------------------------" & vbNewline
StrTopo = StrTopo & "http://www.virtuastore.com.br" & vbNewline
StrTopo = StrTopo & "-->" & vbNewline

response.write StrTopo






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

'--------------------------------------------------------
'Conjunto de funções para validação de CPF ou CNPJ
'--------------------------------------------------------

'Calcula CPF
'----------------------------
function CalculaCPF(numero_cpf)
 Dim RecebeCPF, Numero(11), soma, resultado1, resultado2, bRepete
 RecebeCPF = numero_cpf
'Retirar todos os caracteres que nao sejam 0-9
 s="" 
 for x=1 to len(RecebeCPF)
  ch=mid(RecebeCPF,x,1)
  if asc(ch)>=48 and asc(ch)<=57 then
    s=s & ch
  end if
 next
 RecebeCPF = s
 bRepete="falso"
 for x=0 to 9
   if RecebeCPF=String(11,Cstr(x)) then bRepete="True"
 next
 if len(RecebeCPF) <> 11 or bRepete = "True" then
    CalculaCPF = "falso" 
 else
  Numero(1) = Cint(Mid(RecebeCPF,1,1))
  Numero(2) = Cint(Mid(RecebeCPF,2,1))
  Numero(3) = Cint(Mid(RecebeCPF,3,1))
  Numero(4) = Cint(Mid(RecebeCPF,4,1))
  Numero(5) = Cint(Mid(RecebeCPF,5,1))
  Numero(6) = CInt(Mid(RecebeCPF,6,1))
  Numero(7) = Cint(Mid(RecebeCPF,7,1))
  Numero(8) = Cint(Mid(RecebeCPF,8,1))
  Numero(9) = Cint(Mid(RecebeCPF,9,1))
  Numero(10) = Cint(Mid(RecebeCPF,10,1))
  Numero(11) = Cint(Mid(RecebeCPF,11,1))

  soma = 10 * Numero(1) + 9 * Numero(2) + 8 * Numero(3) + 7 * Numero(4) + 6 * Numero(5) + 5 * Numero(6) + 4 * Numero(7) + 3 * Numero(8) + 2 * Numero(9)
  soma = soma -(11 * (int(soma / 11)))
  if soma = 0 or soma = 1 then
     resultado1 = 0
  else
     resultado1 = 11 - soma
  end if
  if resultado1 = Numero(10) then
    soma = Numero(1) * 11 + Numero(2) * 10 + Numero(3) * 9 + Numero(4) * 8 + Numero(5) * 7 + Numero(6) * 6 + Numero(7) * 5 + Numero(8) * 4 + Numero(9) * 3 + Numero(10) * 2
    soma = soma -(11 * (int(soma / 11)))
    if soma = 0 or soma = 1 then
      resultado2 = 0
    else
      resultado2 = 11 - soma
    end if
    if resultado2 = Numero(11) then
      CalculaCPF = "verdadeiro"
    else
      CalculaCPF = "falso"
    end if
  else 
    CalculaCPF = "falso"
  end if
 end if
end function


'CalculaCNPJ
'----------------------------
function CalculaCNPJ(numero_cnpj)
 Dim RecebeCNPJ, Numero(14), soma, resultado1, resultado2
 RecebeCNPJ = numero_cnpj
 s="" 
 for x=1 to len(RecebeCNPJ)
   ch=mid(RecebeCNPJ,x,1)
   if asc(ch)>=48 and asc(ch)<=57 then
     s=s & ch
   end if
 next
 RecebeCNPJ = s
 if len(RecebeCNPJ) <> 14 then
   CalculaCNPJ = "falso"
 elseif RecebeCNPJ = "00000000000000" then
   CalculaCNPJ = "falso"
 else
   Numero(1) = Cint(Mid(RecebeCNPJ,1,1))
   Numero(2) = Cint(Mid(RecebeCNPJ,2,1))
   Numero(3) = Cint(Mid(RecebeCNPJ,3,1))
   Numero(4) = Cint(Mid(RecebeCNPJ,4,1))
   Numero(5) = Cint(Mid(RecebeCNPJ,5,1))
   Numero(6) = CInt(Mid(RecebeCNPJ,6,1))
   Numero(7) = Cint(Mid(RecebeCNPJ,7,1))
   Numero(8) = Cint(Mid(RecebeCNPJ,8,1))
   Numero(9) = Cint(Mid(RecebeCNPJ,9,1))
   Numero(10) = Cint(Mid(RecebeCNPJ,10,1))
   Numero(11) = Cint(Mid(RecebeCNPJ,11,1))
   Numero(12) = Cint(Mid(RecebeCNPJ,12,1))
   Numero(13) = Cint(Mid(RecebeCNPJ,13,1))
   Numero(14) = Cint(Mid(RecebeCNPJ,14,1))
   soma = Numero(1) * 5 + Numero(2) * 4 + Numero(3) * 3 + Numero(4) * 2 + Numero(5) * 9 + Numero(6) * 8 + Numero(7) * 7 + Numero(8) * 6 + Numero(9) * 5 + Numero(10) * 4 + Numero(11) * 3 + Numero(12) * 2
   soma = soma -(11 * (int(soma / 11)))
   if soma = 0 or soma = 1 then
      resultado1 = 0
   else
      resultado1 = 11 - soma
   end if
   if resultado1 = Numero(13) then
      soma = Numero(1) * 6 + Numero(2) * 5 + Numero(3) * 4 + Numero(4) * 3 + Numero(5) * 2 + Numero(6) * 9 + Numero(7) * 8 + Numero(8) * 7 + Numero(9) * 6 + Numero(10) * 5 + Numero(11) * 4 + Numero(12) * 3 + Numero(13) * 2
      soma = soma - (11 * (int(soma/11)))
      if soma = 0 or soma = 1 then
        resultado2 = 0
      else
        resultado2 = 11 - soma
      end if
      if resultado2 = Numero(14) then
        CalculaCNPJ = "verdadeiro"
      else
        CalculaCNPJ = "falso"
      end if
   else
     CalculaCNPJ = "falso"
   end if
 end if
end function

'Calculo GERAL CPF CNPJ
'----------------------------
Function ValidaCPF_CNPJ(numero, Tamanho)
 if Tamanho = 11 then
    ValidaCPF_CNPJ = CalculaCPF(numero)
 else
    ValidaCPF_CNPJ = CalculaCNPJ(numero)
 end if
end Function
'----------------------------
'fim Calculo GERAL CPF CNPJ
'----------------------------



Function limpa_descricao_html_e_abrevia(descricao)
   descricao=left(descricao,110)
   descricao=replace(replace(descricao,"<STRONG>",""),"</STRONG>","")
   descricao=replace(replace(descricao,"<U>",""),"</U>","")
   descricao=replace(replace(descricao,"<I>",""),"</I>","")
   response.write descricao&"..."
End Function


Function Calcular_MaiorID(nome_campo,nome_tabela,mbd)
'*** Funcao usada para nao usar campo do tipo Auto-Incremento e Calcular o maior registro existente
'*** Usar Application qdo for site com muita inclusao de registros devido a incrementacao constante

		nome_campo_pk="Max_"& nome_campo
		
		sql_max="SELECT max("
		sql_max=sql_max & nome_campo
		sql_max=sql_max & ") AS "
		sql_max=sql_max & nome_campo_pk
		sql_max=sql_max & " FROM "
		sql_max=sql_max & nome_tabela
		'response.write sql_max

		if mbd="db" then
		set rs_maxregistro=db.execute(sql_max)
		elseif mbd="db2" then
		set rs_maxregistro=db2.execute(sql_max)
		end if

		if rs_maxregistro.eof then
		session("MaiorID")=1
		'response.write "1"
		else
		session("MaiorID")=rs_maxregistro(nome_campo_pk)
		'response.write rs_maxregistro(nome_campo_pk)
		end if
		
		rs_maxregistro.close
		set rs_maxregistro=nothing

		'*** Como usar esta funcao :  ***
		
		'Calcular_MaiorID "orderid","orders","db"
		'response.write "MaiorID:  "&session("MaiorID")
		'proximo_id=session("MaiorID")+1		

end Function


%>
