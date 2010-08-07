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
Dim varimg
Dim pesquisa
Dim strTextoHtml 
Dim conexao 
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

	Const wexPassword = ""
	Const wexRoot = "\"
	Const appName = "Explorer VirtuaStore"
	Const appVersion = "OPEN"
	Const wexCharSet = "ISO-8859-1"
	Const showHiddenItems = true
	Const calculateTotalSize = false
	Const calculateFolderSize = false
	Const editableExtensions = "*htm*|*html*|*asp*|*asa*|*txt*|*inc*|*css*|*aspx*|*js*|*vbs*|*shtm*|*shtml*|*xml*|*xsl*|*log*"
	Const viewableExtensions = "*gif*|*jpg*|*jpeg*|*png*|*bmp*|*jpe*"
	Const iconFolderOpenBig = "<img align=absmiddle border=0 src=""adm_imagens/folder_open_big.gif"">"
	Const iconFolderUp = "<img align=absmiddle border=0 src=""adm_imagens/folder_up.gif"" alt=""""> Diretório acima"
	Const iconFolder = "<img align=absmiddle border=0 src=""adm_imagens/folder.gif"" alt="""">"
	Const iconFile = "<img align=absmiddle border=0 src=""adm_imagens/file.gif"" alt="""">"
	Const iconFileEditable = "<img align=absmiddle border=0 src=""adm_imagens/file_editable.gif"" alt="""">"
	Const iconFileViewable = "<img align=absmiddle border=0 src=""adm_imagens/file_viewable.gif"" alt="""">"
	
	Const iconRefresh = "<img align=absmiddle border=0 width=21 height=20 src=""adm_imagens/refresh.gif"" alt=""Refresh file listing"">"
	Const iconCreateFile = "<img align=absmiddle border=0 width=21 height=20 src=""adm_imagens/create_file.gif"" alt=""Create new file"">"
	Const iconCreateFolder = "<img align=absmiddle border=0 width=21 height=20 src=""adm_imagens/create_folder.gif"" alt=""Create new folder"">"
	Const iconUpload = "<img align=absmiddle border=0 width=21 height=20 src=""adm_imagens/upload.gif"" alt=""Upload to this folder"">"
	Const iconLogout = "<img align=absmiddle border=0 width=21 height=20 src=""adm_imagens/logout.gif"" alt=""Logout WebExplorer"">"
	Const iconDelete = "<img align=absmiddle border=0 src=""adm_imagens/xis.gif"" alt=""Delete"">"
	
	Server.ScriptTimeout = 60

Call Iniciar
%>
<!-- #include file="email.asp" -->
<!-- #include file="criptografia.asp" -->
<%
'-----------------------------------------------------------------------------------
'Inicia a sub pricipal

Sub Iniciar()

on error resume next

Session.LCID = 1046
Response.Buffer = True

'inicia conexao com o banco de dados
%>
<!-- #include file="config.asp" -->
<%
set conexao = Server.CreateObject("ADODB.Connection")
conexao.Open(StringdeConexao)

'Chama variaveis de Aplicação
nomeloja = Application("nomeloja")
razaoloja = Application("razaoloja")
emailloja = Application("emailloja")
slogan = Application("slogan")
urlloja = Application("urlloja")
endereco11 = Application("endereco11")
bairro11 = Application("bairro11")
cidade11 = Application("cidade11")
estado11 = Application("estado11")
pais11 = Application("pais11")
fone11 = Application("fone11")
bancopag = Application("bancopag")
contapag = Application("contapag")
pagpara = Application("pagpara")

If Session("admin") = "" Then
%><!--#include file="adm_acesso.asp"--><%
	Response.Write strTextoHtml
	Response.End
End If
'---------------------------------------------------------------------------
strTextoHtml = "<!--" & vbNewLine
strTextoHtml = strTextoHtml & "O que você está procurando?" & vbNewLine
strTextoHtml = strTextoHtml & "What are you lookin' for?" & vbNewLine
strTextoHtml = strTextoHtml & "" & vbNewLine
strTextoHtml = strTextoHtml & "Copyright(c) VirtuaStore Sistemas de Comércio Eletrônico" & vbNewLine
strTextoHtml = strTextoHtml & "All Rights Reserved." & vbNewLine
strTextoHtml = strTextoHtml & "------------------------------" & vbNewLine
strTextoHtml = strTextoHtml & "http://www.virtuastore.com.br" & vbNewLine
strTextoHtml = strTextoHtml & "-->" & vbNewLine & vbNewLine & "<!--INICIO DO CODIGO-->" & vbNewLine
strTextoHtml = strTextoHtml & "<HTML>"
strTextoHtml = strTextoHtml & "<HEAD><TITLE>" & nomeloja & " - Administração On-line</TITLE>"
strTextoHtml = strTextoHtml & "<style type=""text/css"">"
strTextoHtml = strTextoHtml & "<!--"
strTextoHtml = strTextoHtml & "a:link       { color: #000000; text-decoration:none }"
strTextoHtml = strTextoHtml & "a:visited    { color: #000000; text-decoration:none }"
strTextoHtml = strTextoHtml & "a:hover      { color: #365efc; text-decoration:underline }"
strTextoHtml = strTextoHtml & "-->"
strTextoHtml = strTextoHtml & "</style>" & vbNewLine
strTextoHtml = strTextoHtml & "<script language=JavaScript src='layer.js'></script>" & vbNewLine
strTextoHtml = strTextoHtml & "<script language=JavaScript1.2>" & vbNewLine
strTextoHtml = strTextoHtml & "function mOvr(src,clrOver) {" & vbNewLine
strTextoHtml = strTextoHtml & "if (!src.contains(event.fromElement)) {" & vbNewLine
strTextoHtml = strTextoHtml & "src.style.cursor = 'hand';" & vbNewLine
strTextoHtml = strTextoHtml & "src.bgColor = clrOver;" & vbNewLine
strTextoHtml = strTextoHtml & "}" & vbNewLine
strTextoHtml = strTextoHtml & " }" & vbNewLine
strTextoHtml = strTextoHtml & "function mOut(src,clrIn) {" & vbNewLine
strTextoHtml = strTextoHtml & "if (!src.contains(event.toElement)) {" & vbNewLine
strTextoHtml = strTextoHtml & "src.style.cursor = 'default';" & vbNewLine
strTextoHtml = strTextoHtml & "src.bgColor = clrIn;" & vbNewLine
strTextoHtml = strTextoHtml & "}" & vbNewLine
strTextoHtml = strTextoHtml & "}" & vbNewLine
strTextoHtml = strTextoHtml & "</script>" & vbNewLine
strTextoHtml = strTextoHtml & "</HEAD>"
strTextoHtml = strTextoHtml & "<BODY bgColor=#ffffff leftMargin=0 topMargin=0 marginheight=""0"" marginwidth=""0"">"
strTextoHtml = strTextoHtml & "<table cellspacing=""0"" cellpadding=""0"" width=779 height=100% align=center bgcolor=#ffffff style=""border-right: 1px solid #cccccc;border-left: 1px solid #cccccc;""><tr><td valign=top height=""100%"">"
strTextoHtml = strTextoHtml & "<TABLE cellSpacing=0 cellPadding=0 width=""100%"" bgColor=#ffffff border=0>"
strTextoHtml = strTextoHtml & "<TBODY><TD vAlign=top align=middle  width=""100%"">"
strTextoHtml = strTextoHtml & "<TABLE cellSpacing=0 cellPadding=0 width=""100%"" border=0><TBODY>"
strTextoHtml = strTextoHtml & "<tr><td height=0></td></tr>"
Mes = CStr(Trim(Month(Date)))
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
strTextoHtml = strTextoHtml & "<form name=""registro1"">"
strTextoHtml = strTextoHtml & "<TR><TD width=""1%"" bgColor=#eeeeee></TD><TD vAlign=top align=right width=50 bgColor=#eeeeee><IMG src=""adm_imagens/mao.gif""></TD>"
strTextoHtml = strTextoHtml & "<TD vAlign=middle width=""70%"" bgColor=#eeeeee><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;Usuario: <b>"&Ucase(Session("NOME")) &"&nbsp;-&nbsp;"& nomeloja & " &middot; <a href=http://" & urlloja & " target=_new>" & urlloja & "</a> &middot;</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD><TD align=right vAlign=center width=""30%"" bgColor=#eeeeee><FONT face=tahoma style=font-size:11px><b><a href=""?"">Página inicial</a></b>&nbsp;&nbsp;|&nbsp;&nbsp;<b><a href=""?link=logout"">Logout</a></b>&nbsp;&nbsp;&nbsp;&nbsp;</TD></TR>"
strTextoHtml = strTextoHtml & "</TBODY></TABLE></TD></TR></TABLE>"
strTextoHtml = strTextoHtml & "<TABLE cellSpacing=0 cellPadding=0 width=""100%"" height=91.5% border=0 style=""border-bottom: 1px solid #cccccc;border-top: 1px solid #cccccc;"">"
strTextoHtml = strTextoHtml & "<TBODY><TR><TD vAlign=top align=center width=160>"
strTextoHtml = strTextoHtml & "<TABLE cellSpacing=0 cellPadding=0 width=160  align=left border=0><TBODY>"
strTextoHtml = strTextoHtml & "<TR><TD align=middle width=160 background=""adm_imagens/bk_branco.gif"" height=50 valign=top>"

strTextoHtml = strTextoHtml & "<!--- INICIO DO MENU --->"

strTextoHtml = strTextoHtml & "<TABLE height=""100%"" cellSpacing=2 cellPadding=2 width=""100%"" align=center><TBODY></form><TR>"
strTextoHtml = strTextoHtml & "<TD vAlign=center align=middle><a href=""http://" & urlloja & """ target=_new><img src=""adm_imagens/logo_vso.gif"" width=""144"" border=""0"" alt=""" & nomeloja & " - " & urlloja & """></a></FONT></TD></TR></TBODY></TABLE></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD vAlign=top align=middle><TABLE cellSpacing=0 cellPadding=2 width=100% border=0><TBODY>"

strTextoHtml = strTextoHtml & "<!--- ADMINISTRADOR --->"

strTextoHtml = strTextoHtml & "<TR bgcolor=#eeeeee><TD><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/dep.gif"" border=0></FONT></TD>"
strTextoHtml = strTextoHtml & "<TD><FONT face=tahoma style=font-size:11px><B>ADMINISTRADOR</B></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2 height=2></td></td>"

strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=adm&acao=editar&acaba=sim"">Trocar seu Email / Senha </A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=adm&acao=inserir&acaba=sim"">Inserir administrador</A></FONT></TD></TR>"

strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=adm&acao=excluir&acaba=sim"">Excluir administrador</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2 height=4></td></tr>"

strTextoHtml = strTextoHtml & "<!--- PRODUTOS NA LOJA --->"

strTextoHtml = strTextoHtml & "<TR bgcolor=#eeeeee><TD><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/prod.gif"" border=0></FONT></TD>"
strTextoHtml = strTextoHtml & "<TD><FONT face=tahoma style=font-size:11px><B>PRODUTOS</B></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2 height=2></td></td>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=produtos&acao=inserir&acaba=sim"">Inserir produto</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=produtos&acao=editar&acaba=sim"">Ver / Editar produtos</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=produtos&acao=excluir&acaba=sim"">Excluir produtos</A></FONT></TD></TR>"
'************************************************************************************'
'*****  Inicio montagem menu esquerdo do Administrador Posição de estoque ***********'
'*****      Criado: Fábio V.Coelho - fabio_v_coelho@zipmail.com.br        ***********'
'************************************************************************************'
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<a href=""?link=produtos&acao=estoque&acaba=sim"">Posição de Estoque/Vendas</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2 height=4></td></td>"

strTextoHtml = strTextoHtml & "<!--- COMPRAS EFETUADAS --->"

strTextoHtml = strTextoHtml & "<TR bgcolor=#eeeeee><TD><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/comp.gif"" border=0></FONT></TD>"
strTextoHtml = strTextoHtml & "<TD><FONT face=tahoma style=font-size:11px><B>COMPRAS</B></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2 height=2></td></td>"
If CStr(Len(Day(Now))) = CStr("1") Then
diazz = "0" & Day(Now)
Else
diazz = Day(Now)
End If
If CStr(Len(Month(Now))) = CStr("1") Then
meszz = "0" & Month(Now)
Else
meszz = Month(Now)
End If
dataz = diazz & "/" & meszz & "/" & Year(Now)
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=compras&acao=ver&acaba=sim&dia=" & Day(Now) & "&mes=" & Month(Now) & "&ano=" & Year(Now) & "&data=" & dataz & """>Compras por data</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=compras&acao=vert&acaba=sim"">Todas as compras</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""http://www.correios.com.br/servicos/rastreamento/r_obj_nac.cfm"" target=""_blank"">Rastreamento de Compras</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2 height=4></td></td>"

strTextoHtml = strTextoHtml & "<!--- DEPARTAMENTOS --->"

strTextoHtml = strTextoHtml & "<TR bgcolor=#eeeeee><TD><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/dep.gif"" border=0></FONT></TD>"
strTextoHtml = strTextoHtml & "<TD><FONT face=tahoma style=font-size:11px><B>DEPARTAMENTOS</B></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2 height=2></td></td>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=dep&acao=inserir&acaba=sim"">Inserir departamento</A><BR>&nbsp; &nbsp; &nbsp; <IMG src=""adm_imagens/flechav.gif"" border=0> <A href=""?link=sdep&acao=inserir&acaba=sim"">Sub-departamentos</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=dep&acao=editar&acaba=sim"">Editar departamentos</A><BR>&nbsp; &nbsp; &nbsp; <IMG src=""adm_imagens/flechav.gif"" border=0> <A href=""?link=sdep&acao=editar&acaba=sim"">Sub-departamentos</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=dep&acao=excluir&acaba=sim"">Excluir departamentos</A><BR>&nbsp; &nbsp; &nbsp; <IMG src=""adm_imagens/flechav.gif"" border=0> <A href=""?link=sdep&acao=excluir&acaba=sim"">Sub-departamentos</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2 height=4></td></tr>"

strTextoHtml = strTextoHtml & "<!--- CLIENTES CADASTRADOS --->"

strTextoHtml = strTextoHtml & "<TR bgcolor=#eeeeee><TD bgcolor=#eeeeee><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/cli.gif"" border=0></FONT></TD>"
strTextoHtml = strTextoHtml & "<TD bgcolor=#eeeeee><FONT face=tahoma style=font-size:11px><B>CLIENTES</B></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2 height=2></td></td>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=clientes&acao=ver&acaba=sim"">Administrar clientes</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2 height=4></td></td>"

strTextoHtml = strTextoHtml & "<!--- EMAILS --->"

strTextoHtml = strTextoHtml & "<TR bgcolor=#eeeeee><TD><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/news.gif"" border=0></FONT></TD>"
strTextoHtml = strTextoHtml & "<TD><FONT face=tahoma style=font-size:11px><B>NEWSLETTER</B></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2 height=2></td></td>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=news&acao=escrever&acaba=sim"">Escrever nova newsletter</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=news&acao=excluir&acaba=sim"">Excluir email newsletter</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2 height=4></td></td>"

strTextoHtml = strTextoHtml & "<!--- UTILITÁRIOS --->"

strTextoHtml = strTextoHtml & "<TR bgcolor=#eeeeee><TD><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/conf.gif"" border=0></FONT></TD>"
strTextoHtml = strTextoHtml & "<TD><FONT face=tahoma style=font-size:11px><B>UTILITÁRIOS</B></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2 height=2></td></td>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=util&acao=atendimentoon&acaba=sim"">Atendimento Online</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""javascript:generico('?link=util&acao=banner&acaba=sim','banners',700,500,0,0,'yes','yes')"">Banners (Sist AdMentor)</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""diagnostico"" target=com_novo_frame_vs>Diagnóstico do servidor</A></FONT></TD></TR>"
'strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""componentes_no_servidor.asp"" target=com_novo_frame_vs>Componentes no servidor</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=util&acao=stats&acaba=sim"">Estatísticas</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=util&acao=ftp&acaba=sim"">Gerenciador de arquivos</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""javascript:generico('?link=util&acao=manut&acaba=sim','manut',500,500,0,0,'yes','no')"">Manutenção da base</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=util&acao=limpar&acaba=sim"">Otimizar banco de bados</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=util&acao=sql&acaba=sim"">SQL Manager</A></FONT></TD></TR>"
'strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""variaveis_no_servidor.asp"" target=var_novo_frame_vs>Variáveis do servidor</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""default.asp"" target=_novo_frame_vs>Ver minha loja</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""tabela_de_cores.asp"" target=cores_novo_frame_vs>Ver tabela de cores</A></FONT></TD></TR>"
strTextoHtml = strTextoHtml & "<TR><TD colSpan=2><FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;<IMG src=""adm_imagens/seta.gif"" border=0> &nbsp;<A href=""?link=util&acao=contador&acaba=sim"">Zerar contador</A></FONT></TD></TR>"


strTextoHtml = strTextoHtml & "<TR><TD colSpan=2 height=10></td></td>"
strTextoHtml = strTextoHtml & "</TBODY></TABLE></TD></TR></TBODY></TABLE></TD>"
strTextoHtml = strTextoHtml & "<!--- FIM DO MENU --->"
strTextoHtml = strTextoHtml & "<!--- INICIO DO CONTEUDO --->"
If Len(Day(Date)) = 1 Then
dia = "0" & Day(Date)
Else
dia = Day(Date)
End If
If Len(Month(Date)) = 1 Then
mez = "0" & Month(Date)
Else
mez = Month(Date)
End If
strTextoHtml = strTextoHtml & "<TD vAlign=top style=""border-left: 1px solid #cccccc;""><TABLE cellSpacing=5 cellPadding=7 width=""100%"" border=0>"
strTextoHtml = strTextoHtml & "<TBODY>"
strTextoHtml = strTextoHtml & "<TR><TD vAlign=center colSpan=2>"
strLink = Request("link")
strAcao = Request("acao")
Select Case strLink
Case "produtos"
%><!--#include file="adm_produtos.asp"--><%
Case "clientes"
%><!--#include file="adm_clientes.asp"--><%
Case "news"
%><!--#include file="adm_email.asp"--><%
Case "util"
%><!--#include file="adm_utilitario.asp"--><%
Case "suporte"
%><!--#include file="adm_suporte.asp"--><%
Case "dep"
%><!--#include file="adm_departamentos.asp"--><%
Case "sdep"
%><!--#include file="adm_subdepartamentos.asp"--><%
Case "compras"
%><!--#include file="adm_compras.asp"--><%
Case "adm"
%><!--#include file="adm_adm.asp"--><%
Case "logout"
Session.contents.remove("admin")
Session.contents.remove("ACESSO")
Session.contents.remove("ULTACESSO")
Session.Abandon()
Response.Redirect "administrador.asp"
Case Else
%><!--#include file="adm_case.asp"--><%
End Select

strTextoHtml = strTextoHtml & "</TD></TR></TBODY></TABLE>"
strTextoHtml = strTextoHtml & "<!--- FIM DO CONTEUDO --->"
strTextoHtml = strTextoHtml & "</TD></TR></TBODY></TABLE>" & vbNewLine
strTextoHtml = strTextoHtml & "<!--- INICIO DO FIM --->"
strTextoHtml = strTextoHtml & "<TABLE cellSpacing=2 cellPadding=2 width=""100%"" align=center bgcolor=#eeeeee border=0>"
strTextoHtml = strTextoHtml & "<TBODY><TR><TD vAlign=top align=right width=""100%"">"
strTextoHtml = strTextoHtml & "<a href=""http://www.virtuastore.com.br"" target=_new style=text-decoration:none;><FONT face=tahoma style=font-size:11px><B>Powered by VirtuaStore OPEN&nbsp;&nbsp</B></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>"&application("link_comunidade")&"</strong></TD></TR></TBODY></TABLE>"
strTextoHtml = strTextoHtml & "</td></tr></table>"
strTextoHtml = strTextoHtml & "</BODY></HTML>"

conexao.Close
Set conexao = Nothing

Response.Write strTextoHtml
End Sub
'-----------------------------------------------------------------------------------
Function MesExtenso(Mes)
Select Case Mes
Case 1
MesExtenso = "Janeiro"
Case 2
MesExtenso = "Fevereiro"
Case 3
MesExtenso = "Março"
Case 4
MesExtenso = "Abril"
Case 5
MesExtenso = "Maio"
Case 6
MesExtenso = "Junho"
Case 7
MesExtenso = "Julho"
Case 8
MesExtenso = "Agosto"
Case 9
MesExtenso = "Setembro"
Case 10
MesExtenso = "Outubro"
Case 11
MesExtenso = "Novembro"
Case 12
MesExtenso = "Dezembro"
End Select
End Function

'-----------------------------------------------------------------------------------
Function DiaSemana(iDia)
Select Case iDia
Case 0
DiaSemana = "Dom"
Case 1
DiaSemana = "Seg"
Case 2
DiaSemana = "Ter"
Case 3
DiaSemana = "Qua"
Case 4
DiaSemana = "Qui"
Case 5
DiaSemana = "Sex"
Case 6
DiaSemana = "Sab"
End Select
End Function

'-----------------------------------------------------------------------------------
Function nSemanas(Mes, Ano)
DtInicial = DateSerial(Ano, Mes, fDia)
If Weekday(DtInicial) = 1 Then
nSem = 0
Else
nSem = 1
End If
ndiasmes = aDiasMes(Mes)
For i = 1 To ndiasmes
If Weekday(DtInicial) = 1 Then
nSem = nSem + 1
End If
DtInicial = DateAdd("d", 1, DtInicial)
Next
nSemanas = nSem
End Function

'-----------------------------------------------------------------------------------
Sub SetBissexto()
mezito = Request("mes")
anito = Request("ano")
If mezito = "" Then
mezito = Month(Now)
End If
If anito = "" Then
anito = Year(Now)
End If
data = "1/" & mezito & "/" & anito
If Trim(data) = "" Then
data = Date
Else
data = CDate(data)
End If
Ano = Year(data)
If (Ano Mod 4 = 0) Or (Ano Mod 100 = 0) And (Ano Mod 400 = 0) Then
aDiasMes(2) = 29
Else
aDiasMes(2) = 28
End If
End Sub

'-----------------------------------------------------------------------------------
Sub CalendarioASP()
strTextoHtml = strTextoHtml & "<Font Face=tahoma style=font-size:11px><B>Selecione pela data as compras que você deseja visualizar:</B></Font>"
strTextoHtml = strTextoHtml & "<table><tr><td height=6></td></tr></table>"
fDia = 1
ReDim aDiasMes(12)
aDiasMes(1) = 31
aDiasMes(2) = 28
aDiasMes(3) = 31
aDiasMes(4) = 30
aDiasMes(5) = 31
aDiasMes(6) = 30
aDiasMes(7) = 31
aDiasMes(8) = 31
aDiasMes(9) = 30
aDiasMes(10) = 31
aDiasMes(11) = 30
aDiasMes(12) = 31
Call SetBissexto
Call MontaCalendario
End Sub

'-----------------------------------------------------------------------------------
Sub MontaCalendario()
mezito = Request("mes")
anito = Request("ano")
If mezito = "" Then
mezito = Month(Now)
End If
If anito = "" Then
anito = Year(Now)
End If
data = "1/" & mezito & "/" & anito
If Trim(data) = "" Then
data = Date
Else
data = CDate(data)
End If

Ano = Year(data)
Mes = Month(data)
DiaInicial = Weekday(DateSerial(Ano, Mes, fDia))
DtInicial = DateSerial(Ano, Mes, fDia)

strTextoHtml = strTextoHtml & "<table border=""0"" cellpading=""0"" cellspacing=""0"">" & vbCrLf
strTextoHtml = strTextoHtml & "<tr>"
For j = 0 To 6
If j = 0 Then
strTextoHtml = strTextoHtml & "<td align=""center"" width=""28"" height=22 style='border-bottom: 1px solid #cccccc;border-left: 1px solid #cccccc;border-top: 1px solid #cccccc;' bgcolor=""#003366""><font style=font-size:10px;font-family:tahoma;color:ffffff><b>" & DiaSemana(j) & "</b></div></td>" & vbCrLf
Else
strTextoHtml = strTextoHtml & "<td align=""center"" width=""28"" height=22 style='border-bottom: 1px solid #cccccc;border-top: 1px solid #cccccc;' bgcolor=""#003366""><font style=font-size:10px;font-family:tahoma;color:ffffff><b>" & DiaSemana(j) & "</b></td>" & vbCrLf
End If
Next
strTextoHtml = strTextoHtml & "</tr>"

For i = 0 To (nSemanas(Month(DtInicial), Year(DtInicial)) - 1)
strTextoHtml = strTextoHtml & "<tr>" & vbCrLf
For j = 0 To 6
If (DiaInicial - 1) > j And i = 0 Then
If j = 0 And i = 0 Then
strTextoHtml = strTextoHtml & "<td height=20 style='border-right: 1px solid #cccccc;border-bottom: 1px solid #cccccc;border-left: 1px solid #cccccc;'>&nbsp;</div></td>" & vbCrLf
Else
strTextoHtml = strTextoHtml & "<td height=20 style='border-right: 1px solid #cccccc;border-bottom: 1px solid #cccccc;'>&nbsp;</td>" & vbCrLf
End If
Else
If Month(DtInicial) > Mes Or Year(DtInicial) > Ano Then
strTextoHtml = strTextoHtml & "<td height=20 style='border-right: 1px solid #cccccc;border-bottom: 1px solid #cccccc;'>&nbsp;</td>" & vbCrLf
Else
If Weekday(DtInicial) = 1 Then
If CStr(Len(Day(DtInicial))) = CStr("1") Then
diazz = "0" & Day(DtInicial)
Else
diazz = Day(DtInicial)
End If
If CStr(Len(Month(DtInicial))) = CStr("1") Then
meszz = "0" & Month(DtInicial)
Else
meszz = Month(DtInicial)
End If
dataz = diazz & "/" & meszz & "/" & Year(DtInicial)
set rs = conexao.execute("select * from compras where datacompra='" & dataz & "' AND status <> 'Compra em Aberto';")
if rs.eof then
varvialvelcompra = "#000000"
else
varvialvelcompra = "red"
end if
rs.close
set rs = nothing
strTextoHtml = strTextoHtml & "<a href=""?link=compras&acao=ver&dia=" & Day(DtInicial) & "&data=" & dataz & "&ano=" & Year(DtInicial) & "&mes=" & Month(DtInicial) & """><td height=20  style=""border-left: 1px solid #ccccc;border-right: 1px solid #cccccc;border-bottom: 1px solid #cccccc;"" align=center onMouseOver=""mOvr(this,'eeeeee');"" onMouseOut=""mOut(this,'ffffff');""><font style=font-size:10px;font-family:tahoma;color:" & varvialvelcompra & ">"

If CStr(Request("dia")) = CStr(Day(DtInicial)) Then
strTextoHtml = strTextoHtml & "<B>" & Day(DtInicial) & "</b>"
Else
strTextoHtml = strTextoHtml & Day(DtInicial)
End If

strTextoHtml = strTextoHtml & "</td></a>"
Else

If DtInicial = Date Then
If CStr(Len(Day(DtInicial))) = CStr("1") Then
diazz = "0" & Day(DtInicial)
Else
diazz = Day(DtInicial)
End If
If CStr(Len(Month(DtInicial))) = CStr("1") Then
meszz = "0" & Month(DtInicial)
Else
meszz = Month(DtInicial)
End If
dataz = diazz & "/" & meszz & "/" & Year(DtInicial)
set rs = conexao.execute("select * from compras where datacompra='" & dataz & "' AND status <> 'Compra em Aberto';")
if rs.eof then
varvialvelcompra = "#000000"
else
varvialvelcompra = "red"
end if
rs.close
set rs = nothing
strTextoHtml = strTextoHtml & "<a href=""?link=compras&acao=ver&dia=" & Day(DtInicial) & "&data=" & dataz & "&ano=" & Year(DtInicial) & "&mes=" & Month(DtInicial) & """><td height=20  style=""border-left: 1px solid #ccccc;border-right: 1px solid #cccccc;border-bottom: 1px solid #cccccc;"" align=center onMouseOver=""mOvr(this,'eeeeee');"" onMouseOut=""mOut(this,'ffffff');""><font style=font-size:10px;font-family:tahoma;color:" & varvialvelcompra & ">"

If CStr(Request("dia")) = CStr(Day(DtInicial)) Then
strTextoHtml = strTextoHtml & "<B>" & Day(DtInicial) & "</b>"
Else
strTextoHtml = strTextoHtml & Day(DtInicial)
End If

strTextoHtml = strTextoHtml & "</td></a>"
Else
If CStr(Len(Day(DtInicial))) = CStr("1") Then
diazz = "0" & Day(DtInicial)
Else
diazz = Day(DtInicial)
End If
If CStr(Len(Month(DtInicial))) = CStr("1") Then
meszz = "0" & Month(DtInicial)
Else
meszz = Month(DtInicial)
End If
dataz = diazz & "/" & meszz & "/" & Year(DtInicial)
set rs = conexao.execute("select * from compras where datacompra='" & dataz & "' AND status <> 'Compra em Aberto';")
if rs.eof then
varvialvelcompra = "#000000"
else
varvialvelcompra = "red"
end if
rs.close
set rs = nothing

strTextoHtml = strTextoHtml & "<a href=""?link=compras&acao=ver&dia=" & Day(DtInicial) & "&data=" & dataz & "&ano=" & Year(DtInicial) & "&mes=" & Month(DtInicial) & """><td height=20  style=""border-left: 1px solid #ccccc;border-right: 1px solid #cccccc;border-bottom: 1px solid #cccccc;"" align=center onMouseOver=""mOvr(this,'eeeeee');"" onMouseOut=""mOut(this,'ffffff');""><font style=font-size:10px;font-family:tahoma;color:" & varvialvelcompra & ">"

If CStr(Request("dia")) = CStr(Day(DtInicial)) Then
strTextoHtml = strTextoHtml & "<B>" & Day(DtInicial) & "</b>"
Else
strTextoHtml = strTextoHtml & Day(DtInicial)
End If

strTextoHtml = strTextoHtml & "</td></a>"

End If
End If
End If
DtInicial = DateAdd("d", DtInicial, 1)
End If
Next
strTextoHtml = strTextoHtml & "</tr>" & vbCrLf
Next
strTextoHtml = strTextoHtml & "<TR><TD align=center valign=center height=35 colspan=7 style='border-bottom: 1px solid #cccccc;border-left: 1px solid #cccccc;border-right: 1px solid #cccccc'>"
Call DisplaySelectDate
strTextoHtml = strTextoHtml & "</TD></TR></Form>"
strTextoHtml = strTextoHtml & "</table>" & vbCrLf
End Sub

'-----------------------------------------------------------------------------------
Sub DisplaySelectDate()
strTextoHtml = strTextoHtml & "<Form method=get><input name=link type=hidden value=compras><input name=acao type=hidden value=ver><font style=font-size:10px;font-family:tahoma> "
Call MonthCombo
Call YearCombo
strTextoHtml = strTextoHtml & " <input type=submit value=' Ver ' style=font-size:10px;font-family:tahoma>"
End Sub

Sub MonthCombo()
mezito = Request("mes")
If mezito = "" Then
mezito = Month(Now)
Else
mezito = mezito
End If
strTextoHtml = strTextoHtml & "<input name=dia type=hidden value=1><select name='mes' style=font-size:10px;font-family:tahoma><Option value=1"
If mezito = "1" Then
strTextoHtml = strTextoHtml & " selected"
End If
strTextoHtml = strTextoHtml & ">Janeiro</Option><Option value=2"

If mezito = "2" Then
strTextoHtml = strTextoHtml & " selected"
End If
strTextoHtml = strTextoHtml & ">Fevereiro</Option><Option value=3"

If mezito = "3" Then
strTextoHtml = strTextoHtml & " selected"
End If
strTextoHtml = strTextoHtml & ">Março</Option><Option value=4"

If mezito = "4" Then
strTextoHtml = strTextoHtml & " selected"
End If
strTextoHtml = strTextoHtml & ">Abril</Option><Option value=5"

If mezito = "5" Then
strTextoHtml = strTextoHtml & " selected"
End If
strTextoHtml = strTextoHtml & ">Maio</Option><Option value=6"

If mezito = "6" Then
strTextoHtml = strTextoHtml & " selected"
End If
strTextoHtml = strTextoHtml & ">Junho</Option><Option value=7"

If mezito = "7" Then
strTextoHtml = strTextoHtml & " selected"
End If
strTextoHtml = strTextoHtml & ">Julho</Option><Option value=8"

If mezito = "8" Then
strTextoHtml = strTextoHtml & " selected"
End If
strTextoHtml = strTextoHtml & ">Agosto</Option><Option value=9"

If mezito = "9" Then
strTextoHtml = strTextoHtml & " selected"
End If
strTextoHtml = strTextoHtml & ">Setembro</Option><Option value=10"

If mezito = "10" Then
strTextoHtml = strTextoHtml & " selected"
End If
strTextoHtml = strTextoHtml & ">Outubro</Option><Option value=11"

If mezito = "11" Then
strTextoHtml = strTextoHtml & " selected"
End If
strTextoHtml = strTextoHtml & ">Novembro</Option><Option value=12"

If mezito = "12" Then
strTextoHtml = strTextoHtml & " selected"
End If
strTextoHtml = strTextoHtml & ">Dezembro</Option></select>"
End Sub

Sub YearCombo()
anozinho = Request("ano")
If anozinho = "" Then
anozinho = Year(Now)
Else
anozinho = anozinho
End If
strTextoHtml = strTextoHtml & " de <select name=ano style=font-size:10px;font-family:tahoma>"
For i = 2002 To 2015
strTextoHtml = strTextoHtml & "<Option value=" & i
If CStr(i) = CStr(anozinho) Then
strTextoHtml = strTextoHtml & " selected"
End If
strTextoHtml = strTextoHtml & ">" & i & "</Option>"
 Next
 strTextoHtml = strTextoHtml & "</select>"
End Sub

Sub DepartamentosASP()
If Request("acaba") = "sim" Then
Session("adm_descprod") = ""
Session("adm_email") = ""
End If
Select Case strAcao
Case "inserir"


strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Incluir novo departamento na loja</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<form method=post action=""administrador.asp?link=dep&acao=gravanovo"">"
strTextoHtml = strTextoHtml & "<table align=center width=""90%"">"

varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"

strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dia & "/" & mez & "/" & Year(Date) & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Departamento:</b></td><td><input name=""nomedep"" type=""text"" value="""

If Request.QueryString("erro1") <> "sim" Then
strTextoHtml = strTextoHtml & Request.QueryString("erro1")
End If

strTextoHtml = strTextoHtml & """ size=50  style=font-size:11px;font-family:tahoma>"

If Request.QueryString("erro1") = "sim" Then
strTextoHtml = strTextoHtml & varimg
End If

strTextoHtml = strTextoHtml & "</td></tr><tr><td><FONT face=tahoma  style=font-size:11px><b>Descrição (opcional):</b></td><td><textarea name=""descri"" rows=5 cols=55 style=font-size:11px;font-family:tahoma>" & Request.QueryString("erro3") & "</textarea></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Visível:</b></td><td><select name=""ver"" style=font-size:11px;font-family:tahoma><option value=""s"" "

If CStr(Request.QueryString("erro2")) = "s" Then
strTextoHtml = strTextoHtml & "selected"
End If

strTextoHtml = strTextoHtml & ">Sim<option value=""n"" "

If CStr(Request.QueryString("erro2")) = "n" Then
strTextoHtml = strTextoHtml & "selected"
End If

strTextoHtml = strTextoHtml & ">Não</select></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td align=center></td><td align=center>&nbsp;&nbsp;&nbsp;&nbsp;<input type=""submit"" NAME=""Enter"" style=font-size:11px;font-family:tahoma value=""Gravar departamento""> <input type=""reset"" value=""Limpar formulario"" style=font-size:11px;font-family:tahoma id=1 name=1></td></table><br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"

Case "gravanovo"
nome = Trim(Request("nomedep"))
descri = Trim(Request("descri"))
ver = Trim(Request("ver"))
If nome = "" Then
If nome = "" Then erro1 = "sim" Else erro1 = nome
erro3 = descri
If ver = "" Then erro2 = "sim" Else erro2 = ver
Response.Redirect "?link=dep&acao=inserir&erro1=" & erro1 & "&erro2=" & erro2 & "&erro3=" & erro3
End If

If descri = "" Then
descri = "-"
End If

If CStr(Len(Day(Now))) = CStr("1") Then
diazz = "0" & Day(Now)
Else
diazz = Day(Now)
End If
If CStr(Len(Month(Now))) = CStr("1") Then
meszz = "0" & Month(Now)
Else
meszz = Month(Now)
End If
dataz = diazz & "/" & meszz & "/" & Year(Now)

textosql = "INSERT INTO sessoes (data, nome, descr,ver) VALUES ('" & dataz & "', '" & nome & "', '" & descri & "','" & ver & "');"
Set gravadep = conexao.Execute(textosql)

strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Novo departamento incluído na loja com sucesso</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=dep&acao=inserir&acaba=sim"">Inserir um novo departamento na loja</a></b></center>"
strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc><br>"
strTextoHtml = strTextoHtml & "<table align=center width=""90%"">"

varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"

strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dataz & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Departamento:</b></td><td><FONT face=tahoma  style=font-size:11px>" & nome & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Descrição (opcional):</b></td><td><FONT face=tahoma  style=font-size:11px>"

If descri = "" Then
strTextoHtml = strTextoHtml & "-"
Else
strTextoHtml = strTextoHtml & descri
End If

strTextoHtml = strTextoHtml & "</td></tr><tr><td><FONT face=tahoma  style=font-size:11px><b>Visível:</b></td><td><FONT face=tahoma  style=font-size:11px>"

If CStr(ver) = "s" Then
strTextoHtml = strTextoHtml & "Sim"
Else
strTextoHtml = strTextoHtml & "Não"
End If

strTextoHtml = strTextoHtml & "</td></tr><tr><td colspan=2 align=center height=15></td></tr></table><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"

Case "editar"
Set rs = conexao.Execute("SELECT * FROM sessoes ORDER by nome")
If rs.EOF Or rs.bof Then

strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Editar departamentos na loja</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=100><tr><td>"
strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Departamentos(s) encontrado(s): <b>0</b> <hr size=1 color=#dddddd width=""100%"">"
strTextoHtml = strTextoHtml & "<br><br><table width=568 align=center>"
strTextoHtml = strTextoHtml & "<tr><td align=center><br><br><b><font style=font-size:11px>Nenhum departamento foi encontrado na base de dados da loja.<br><br></b><br><br></td></tr></table>"
strTextoHtml = strTextoHtml & "<br></table>"
strTextoHtml = strTextoHtml & "<table width=""100%"" cellspacing=""0"" cellpadding=""0""><tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
strTextoHtml = strTextoHtml & "</tr></table><td></tr></table>"

Else

Set rs2 = conexao.Execute("SELECT count(nome) AS total FROM sessoes;")
totalreg = rs2("total")
rs2.Close
Set rs2 = Nothing
numiz = Request("pagina") & "0"
numiz = CInt(numiz)
iz = iz + numiz

strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Editar departamentos na loja</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=100><tr><td>"
strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Departamentos(s) encontrado(s): <b>" & totalreg & "</b> <hr size=1 color=#dddddd width=""100%"">"
strTextoHtml = strTextoHtml & "<table><tr><td height=3></td></tr></table><table width=568 align=center>"

While Not rs.EOF
iz = iz + 1
If rs("ver") = "s" Then
varestoq = "<font color=#000000>Sim</font>"
Else
varestoq = "<font color=#b23c04>Não</font>"
End If

strTextoHtml = strTextoHtml & "<tr><td align=left valign=center>"
strTextoHtml = strTextoHtml & "<table width=""100%"" bgcolor=#eeeeee style='border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;'><tr><td valign=center><font face=""tahoma"" style=font-size:11px;color:000000>" & iz & ") <b>" & UCase(rs("nome")) & "</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Data: <b>" & rs("data") & "</b> &nbsp;&nbsp;&nbsp;Visível: <b>" & varestoq & "</b></td><td align=right valign=center><font face=""tahoma"" style=font-size:11px;color:000000>Ação: <b><a href=?link=dep&acao=ver&dep=" & rs("id") & ">Ver</a></b> | <b><a href=?link=dep&acao=edita&dep=" & rs("id") & ">Editar</a></b>&nbsp;</td></tr></table> <table><tr><td height=4></td></tr></table>"

rs.movenext
Wend

strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
strTextoHtml = strTextoHtml & "</tr></table></td></tr></table> </td></tr></table>"

rs.Close
Set rs = Nothing
End If

Case "excluir"
Set rs = conexao.Execute("SELECT * FROM sessoes ORDER by nome")
If rs.EOF Or rs.bof Then

strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Excluir departamentos na loja</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=100><tr><td>"
strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Departamentos(s) encontrado(s): <b>0</b> <hr size=1 color=#dddddd width=""100%"">"
strTextoHtml = strTextoHtml & "<br><br><table width=568 align=center>"
strTextoHtml = strTextoHtml & "<tr><td align=center><br><br><b><font style=font-size:11px>Nenhum departamento foi encontrado na base de dados da loja.<br><br></b><br><br></td></tr></table>"
strTextoHtml = strTextoHtml & "<br></table>"
strTextoHtml = strTextoHtml & "<table width=""100%"" cellspacing=""0"" cellpadding=""0""><tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
strTextoHtml = strTextoHtml & "</tr></table><td></tr></table>"

Else

Set rs2 = conexao.Execute("SELECT count(nome) AS total FROM sessoes;")
totalreg = rs2("total")
rs2.Close
Set rs2 = Nothing
numiz = Request("pagina") & "0"
numiz = CInt(numiz)
iz = iz + numiz

strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Excluir departamentos na loja</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<table><tr><td align=""left"" valign=""top""><table border=""0"" cellspacing=""4"" cellpadding=""4"" width=100><tr><td>"
strTextoHtml = strTextoHtml & "<font face=""tahoma"" style=font-size:11px;color:000000>Departamentos(s) encontrado(s): <b>" & totalreg & "</b> <hr size=1 color=#dddddd width=""100%"">"
strTextoHtml = strTextoHtml & "<table><tr><td height=3></td></tr></table><table width=568 align=center>"

If Request("status") = "sucesso" Then

strTextoHtml = strTextoHtml & "<div align=center><b><font style=font-size:11px;font-family:tahoma;color:#003366>DEPARTAMENTO EXCLIUDO COM SUCESSO!<br><br></font></b></center>"

Else
End If

While Not rs.EOF
iz = iz + 1
If rs("ver") = "s" Then
varestoq = "<font color=#000000>Sim</font>"
Else
varestoq = "<font color=#b23c04>Não</font>"
End If

strTextoHtml = strTextoHtml & "<script language=""javascript"">" & vbNewLine
strTextoHtml = strTextoHtml & "function dep" & rs("id") & "(){" & vbNewLine
strTextoHtml = strTextoHtml & "if (confirm('Você realmente deseja excluir este departamento e seus respectivos produtos?'))" & vbNewLine
strTextoHtml = strTextoHtml & "{" & vbNewLine
strTextoHtml = strTextoHtml & "window.location.href('?link=dep&acao=exclui&dep=" & rs("id") & "');" & vbNewLine
strTextoHtml = strTextoHtml & "}" & vbNewLine
strTextoHtml = strTextoHtml & "else" & vbNewLine
strTextoHtml = strTextoHtml & "{" & vbNewLine
strTextoHtml = strTextoHtml & "}}" & vbNewLine
strTextoHtml = strTextoHtml & "</script>" & vbNewLine

strTextoHtml = strTextoHtml & "<tr><td align=left valign=center>" & vbNewLine
strTextoHtml = strTextoHtml & "<table width=""100%"" bgcolor=#eeeeee style='border-right: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-bottom: 1px solid #cccccc;'><tr><td valign=center><font face=""tahoma"" style=font-size:11px;color:000000>" & iz & ") <b>" & UCase(rs("nome")) & "</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Data: <b>" & rs("data") & "</b> &nbsp;&nbsp;&nbsp;Visível: <b>" & varestoq & "</b></td><td align=right valign=center><font face=""tahoma"" style=font-size:11px;color:000000>Ação: <b><a href=?link=dep&acao=ver&dep=" & rs("id") & "&modo=exclui>Ver</a></b> | <b><a href=""javascript: dep" & rs("id") & "();"">Excluir</a></b>&nbsp;</td></tr></table> <table><tr><td height=4></td></tr></table>"

rs.movenext
Wend

strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><hr size=1 color=#cccccc width=""101%""><font face=""tahoma"" style=font-size:11px><b><br><a HREF=""?"">Voltar para Página Inicial</a></b></font></td>"
strTextoHtml = strTextoHtml & "</tr></table></td></tr></table> </td></tr></table>"

rs.Close
Set rs = Nothing
End If

Case "exclui"
notz = Request.QueryString("dep")

	set rs_delete = abredb.execute("SELECT idcategoria from categoria where idsessao=" & notz & ";")
	if not rs_delete.eof then
	delete_idcategoria=rs_delete("idcategoria")
	end if
	rs_delete.close
	set rs_delete = nothing

conexao.Execute("delete from sessoes where id=" & notz & ";")
conexao.Execute("delete from produtos where idsessao='" & delete_idcategoria & "';")
Response.Redirect "?link=dep&acao=excluir&status=sucesso"

Case "ver"

Set setdep = conexao.Execute("SELECT * FROM sessoes WHERE id = " & Request("dep") & ";")

nome = setdep("nome")
data = setdep("data")
descri = setdep("descr")
ver = setdep("ver")

If Request("status") = "sucesso" Then

strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Departamento editado com sucesso</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=dep&acao=edita&dep=" & Request("dep") & "&acaba=sim"">Editar novamente este departamento</a></b> |<b><A href=""?link=dep&acao=editar&acaba=sim""> Ver novamente todos os departamentos</a></b></center>"

Else

strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Ver departamento cadastrado na loja</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"

If Request("modo") = "exclui" Then

strTextoHtml = strTextoHtml & "<script language=""javascript"">" & vbNewLine
strTextoHtml = strTextoHtml & "function dep" & Request("dep") & "(){" & vbNewLine
strTextoHtml = strTextoHtml & "if (confirm('Você realmente deseja excluir este departamento e seus respectivos produtos?'))" & vbNewLine
strTextoHtml = strTextoHtml & "{" & vbNewLine
strTextoHtml = strTextoHtml & "window.location.href('?link=dep&acao=exclui&dep=" & Request("dep") & "');" & vbNewLine
strTextoHtml = strTextoHtml & "}" & vbNewLine
strTextoHtml = strTextoHtml & "else" & vbNewLine
strTextoHtml = strTextoHtml & "{" & vbNewLine
strTextoHtml = strTextoHtml & "}}" & vbNewLine
strTextoHtml = strTextoHtml & "</script>" & vbNewLine

strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><a href=""vbscript: dep" & Request("dep") & "()"">Excluir este departamento</a></b> |<b><A href=""?link=dep&acao=excluir&acaba=sim""> Ver todos os departamentos</a></b></center>"

Else

strTextoHtml = strTextoHtml & "<center><FONT face=tahoma  style=font-size:11px><b><A href=""?link=dep&acao=edita&dep=" & Request("dep") & "&acaba=sim"">Editar este departamento</a></b> |<b><A href=""?link=dep&acao=editar&acaba=sim""> Ver todos os departamentos</a></b></center>"

End If
End If

strTextoHtml = strTextoHtml & "<hr size=1 color=ffffff>"
strTextoHtml = strTextoHtml & "<hr size=1 color=cccccc><br>"
strTextoHtml = strTextoHtml & "<table align=center width=""90%"">"
strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dataz & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Departamento:</b></td><td><FONT face=tahoma  style=font-size:11px>" & nome & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Descrição (opcional):</b></td><td><FONT face=tahoma  style=font-size:11px>"

If setdep("descr") = "" Then
strTextoHtml = strTextoHtml & "-"
Else
strTextoHtml = strTextoHtml & descri
End If

strTextoHtml = strTextoHtml & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Visível:</b></td><td><FONT face=tahoma  style=font-size:11px>"

If CStr(ver) = "s" Then
strTextoHtml = strTextoHtml & "Sim"
Else
strTextoHtml = strTextoHtml & "Não"
End If

strTextoHtml = strTextoHtml & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15></td></tr></table><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"

Case "edita"
Set depz = conexao.Execute("SELECT * FROM sessoes WHERE id = " & Request("dep") & ";")

strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Editar departamento na loja</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<form method=post action=""administrador.asp?link=dep&acao=gravavelho"" id=form1 name=form1>"
strTextoHtml = strTextoHtml & "<input name=""dep"" type=""hidden"" value=""" & Request("dep") & """>"
strTextoHtml = strTextoHtml & "<table align=center width=""90%"">"

varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"

strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & depz("data") & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Departamento:</b></td><td><input name=""nomedep"" type=""text"" value=""" & depz("nome") & """ size=50  style=font-size:11px;font-family:tahoma>"

If Request.QueryString("erro1") = "sim" Then
strTextoHtml = strTextoHtml & varimg
End If

strTextoHtml = strTextoHtml & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Descrição (opcional):</b></td><td><textarea name=""descri"" rows=5 cols=55 style=font-size:11px;font-family:tahoma>"

If depz("descr") = "-" Then
strTextoHtml = strTextoHtml & ""
Else
strTextoHtml = strTextoHtml & depz("descr")
End If

strTextoHtml = strTextoHtml & "</textarea></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Visível:</b></td><td><select name=""ver"" style=font-size:11px;font-family:tahoma><option value=""s"" "

If CStr(depz("ver")) = "s" Then
strTextoHtml = strTextoHtml & "selected"
End If

strTextoHtml = strTextoHtml & ">Sim<option value=""n"" "

If CStr(depz("ver")) = "n" Then
strTextoHtml = strTextoHtml & "selected"
End If

strTextoHtml = strTextoHtml & ">Não</select></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td align=center></td><td align=center>&nbsp;&nbsp;&nbsp;&nbsp;<input type=""submit"" NAME=""Enter"" style=font-size:11px;font-family:tahoma value=""Editar departamento""> <input type=""reset"" value=""Limpar formulario"" style=font-size:11px;font-family:tahoma id=1 name=1></td></table><br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"

Case "gravavelho"
nome = Trim(Request("nomedep"))
descri = Trim(Request("descri"))
ver = Trim(Request("ver"))
If nome = "" Then
If nome = "" Then erro1 = "sim" Else erro1 = nome
erro3 = descri
If ver = "" Then erro2 = "sim" Else erro2 = ver
Response.Redirect "?link=dep&acao=edita2&erro1=" & erro1 & "&erro2=" & erro2 & "&erro3=" & erro3 & "&dep=" & Request("dep")
End If

If descri = "" Then
descri = "-"
End If

textosql = "UPDATE sessoes SET nome = '" & nome & "',  descr = '" & descri & "', ver = '" & ver & "' WHERE id = " & Request("dep") & ";"
Set gravadep = conexao.Execute(textosql)

Response.Redirect "?link=dep&acao=ver&status=sucesso&dep=" & Request("dep")

Case "edita2"

strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/dep_g.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Editar departamento na loja</B></FONT><hr size=1 color=#cccccc>"
strTextoHtml = strTextoHtml & "<form method=post action=""administrador.asp?link=dep&acao=gravavelho"" id=form1 name=form1>"
strTextoHtml = strTextoHtml & "<input name=""dep"" type=""hidden"" value=""" & Request("dep") & """>"
strTextoHtml = strTextoHtml & "<table align=center width=""90%"">"

varimg = "&nbsp;<img src='adm_imagens/xis.gif' width='15' height='16' border='0' align='absmiddle'>"

strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Data:</b></td><td><FONT face=tahoma  style=font-size:11px>" & dia & "/" & mez & "/" & Year(Date) & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td width=""40%""><FONT face=tahoma  style=font-size:11px><b>Departamento:</b></td><td><input name=""nomedep"" type=""text"" value="""

If Request.QueryString("erro1") <> "sim" Then
strTextoHtml = strTextoHtml & Request.QueryString("erro1")
End If

strTextoHtml = strTextoHtml & """ size=50  style=font-size:11px;font-family:tahoma>"

If Request.QueryString("erro1") = "sim" Then
strTextoHtml = strTextoHtml & varimg
End If

strTextoHtml = strTextoHtml & "</td></tr><tr><td><FONT face=tahoma  style=font-size:11px><b>Descrição (opcional):</b></td><td><textarea name=""descri"" rows=5 cols=55 style=font-size:11px;font-family:tahoma>" & Request.QueryString("erro3") & "</textarea></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma  style=font-size:11px><b>Visível:</b></td><td><select name=""ver"" style=font-size:11px;font-family:tahoma><option value=""s"" "

If CStr(Request.QueryString("erro2")) = "s" Then
strTextoHtml = strTextoHtml & "selected"
End If

strTextoHtml = strTextoHtml & ">Sim<option value=""n"""

If CStr(Request.QueryString("erro2")) = "n" Then
strTextoHtml = strTextoHtml & "selected"
End If

strTextoHtml = strTextoHtml & ">Não</select></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center height=15></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td align=center></td><td align=center>&nbsp;&nbsp;&nbsp;&nbsp;<input type=""submit"" NAME=""Enter"" style=font-size:11px;font-family:tahoma value=""Editar departamento""> <input type=""reset"" value=""Limpar formulario"" style=font-size:11px;font-family:tahoma id=1 name=1></td></table><br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><b><A href=""?&acaba=sim"">Voltar para página inicial</a></b></center><br></form>"


End Select
End Sub

Function DecodificaTexto(strString)
strString = Replace(strString, Chr(1), "A")
strString = Replace(strString, Chr(2), "a")
strString = Replace(strString, Chr(3), "B")
strString = Replace(strString, Chr(4), "b")
strString = Replace(strString, Chr(5), "C")
strString = Replace(strString, Chr(6), "c")
strString = Replace(strString, Chr(7), "D")
strString = Replace(strString, Chr(8), "d")
strString = Replace(strString, Chr(14), "E")
strString = Replace(strString, Chr(15), "e")
strString = Replace(strString, Chr(16), "F")
strString = Replace(strString, Chr(17), "f")
strString = Replace(strString, Chr(18), "G")
strString = Replace(strString, Chr(19), "g")
strString = Replace(strString, Chr(20), "H")
strString = Replace(strString, Chr(21), "h")
strString = Replace(strString, Chr(22), "I")
strString = Replace(strString, Chr(23), "i")
strString = Replace(strString, Chr(24), "J")
strString = Replace(strString, Chr(25), "j")
strString = Replace(strString, Chr(26), "K")
strString = Replace(strString, Chr(27), "k")
strString = Replace(strString, Chr(28), "L")
strString = Replace(strString, Chr(29), "l")
strString = Replace(strString, Chr(30), "M")
strString = Replace(strString, Chr(31), "m")
strString = Replace(strString, Chr(127), "N")
strString = Replace(strString, Chr(128), "n")
strString = Replace(strString, Chr(129), "O")
strString = Replace(strString, Chr(131), "o")
strString = Replace(strString, Chr(134), "P")
strString = Replace(strString, Chr(135), "p")
strString = Replace(strString, Chr(138), "Q")
strString = Replace(strString, Chr(140), "q")
strString = Replace(strString, Chr(141), "R")
strString = Replace(strString, Chr(142), "r")
strString = Replace(strString, Chr(143), "S")
strString = Replace(strString, Chr(144), "s")
strString = Replace(strString, Chr(153), "T")
strString = Replace(strString, Chr(154), "t")
strString = Replace(strString, Chr(156), "U")
strString = Replace(strString, Chr(157), "u")
strString = Replace(strString, Chr(158), "V")
strString = Replace(strString, Chr(162), "v")
strString = Replace(strString, Chr(163), "X")
strString = Replace(strString, Chr(164), "x")
strString = Replace(strString, Chr(165), "Z")
strString = Replace(strString, Chr(166), "z")
strString = Replace(strString, Chr(167), "Y")
strString = Replace(strString, Chr(169), "y")
strString = Replace(strString, Chr(172), "W")
strString = Replace(strString, Chr(174), "w")
strString = Replace(strString, Chr(177), "1")
strString = Replace(strString, Chr(181), "2")
strString = Replace(strString, Chr(182), "3")
strString = Replace(strString, Chr(188), "4")
strString = Replace(strString, Chr(189), "5")
strString = Replace(strString, Chr(190), "6")
strString = Replace(strString, Chr(191), "7")
strString = Replace(strString, Chr(198), "8")
strString = Replace(strString, Chr(208), "9")
strString = Replace(strString, Chr(216), "0")
strString = Replace(strString, Chr(222), ",")
strString = Replace(strString, Chr(223), "-")
strString = Replace(strString, Chr(221), "_")
strString = Replace(strString, Chr(229), Chr(34))
strString = Replace(strString, Chr(230), "'")
strString = Replace(strString, Chr(240), "@")
strString = Replace(strString, Chr(241), "&")
strString = Replace(strString, Chr(248), "$")
strString = Replace(strString, Chr(253), "#")
strString = Replace(strString, Chr(254), "*")
strString = Replace(strString, Chr(255), "(")
strString = Replace(strString, Chr(197), ")")
strString = Replace(strString, Chr(175), "\")
strString = Replace(strString, Chr(161), "/")
strString = Replace(strString, Chr(149), "|")
DecodificaTexto = strString
End Function

Function Codifica(strString)
strString = Replace(strString, Chr(32) & Chr(32), "&nbsp;&nbsp;")
strString = Replace(strString, Chr(13), "&nbsp;")
strString = Replace(strString, Chr(10) & Chr(10), "</p><p>")
strString = Replace(strString, Chr(10), "<br>")
strString = Replace(strString, "[b]", "<b>")
strString = Replace(strString, "[/b]", "</b>")
strString = Replace(strString, "[i]", "<i>")
strString = Replace(strString, "[/i]", "</i>")
strString = Replace(strString, "[u]", "<u>")
strString = Replace(strString, "[linha]", "<hr size=1 color=cccccc>")
strString = Replace(strString, "[justificar]", "<div align=justify>")
strString = Replace(strString, "[/justificar]", "</div></js>")
strString = Replace(strString, "[/alinhar]", "</div></al>")
strString = Replace(strString, "[alinhar=esquerda]", "<div align=left>")
strString = Replace(strString, "[alinhar=direita]", "<div align=right>")
strString = Replace(strString, "[/u]", "</u>")
strString = Replace(strString, "[centralizar]", "<center>")
strString = Replace(strString, "[/centralizar]", "</center>")
strString = Replace(strString, "[comentario]", "<table align=center width=""80%"" style=""border-right: 1px solid #000000;border-left: 1px solid #000000;border-top: 1px solid #000000;border-bottom: 1px solid #000000""><tr><td><font face=verdana style=font-size:10px>")
strString = Replace(strString, "[/comentario]", "</td></tr></table>")
strString = Replace(strString, "[lista]", "<ul>")
strString = Replace(strString, "[item]", "<li>")
strString = Replace(strString, "[/lista]", "</ul>")
strString = Replace(strString, "[/fonte]", "</font>")
strString = Replace(strString, "[fonte=Andale Mono]", "<font face=""Andale Mono"">")
strString = Replace(strString, "[fonte=Arial]", "<font face=""Arial"">")
strString = Replace(strString, "[fonte=Arial Black]", "<font face=""Arial Black"">")
strString = Replace(strString, "[fonte=Book Antiqua]", "<font face=""Book Antiqua"">")
strString = Replace(strString, "[fonte=Century Gothic]", "<font face=""Century Gothic"">")
strString = Replace(strString, "[fonte=Comic Sans MS]", "<font face=""Comic Sans MS"">")
strString = Replace(strString, "[fonte=Courier New]", "<font face=""Courier New"">")
strString = Replace(strString, "[fonte=Georgia]", "<font face=""Georgia"">")
strString = Replace(strString, "[fonte=Impact]", "<font face=""Impact"">")
strString = Replace(strString, "[fonte=Tahoma]", "<font face=""Tahoma"">")
strString = Replace(strString, "[fonte=Times New Roman]", "<font face=""Times New Roman"">")
strString = Replace(strString, "[fonte=Trebuchet MS]", "<font face=""Trebuchet MS"">")
strString = Replace(strString, "[fonte=Script MT Bold]", "<font face=""Script MT Bold"">")
strString = Replace(strString, "[fonte=Stencil]", "<font face=""Stencil"">")
strString = Replace(strString, "[fonte=Verdana]", "<font face=""Verdana"">")
strString = Replace(strString, "[fonte=Lucida Console]", "<font face=""Lucida Console"">")
strString = Replace(strString, "[/tamanho]", "</font>")
strString = Replace(strString, "[/cor]", "</font>")
strString = Replace(strString, "[tamanho=1]", "<font style=font-size:11px>")
strString = Replace(strString, "[tamanho=2]", "<font style=font-size:13px>")
strString = Replace(strString, "[tamanho=3]", "<font style=font-size:15px>")
strString = Replace(strString, "[tamanho=4]", "<font style=font-size:17px>")
strString = Replace(strString, "[tamanho=5]", "<font style=font-size:19px>")
strString = Replace(strString, "[tamanho=6]", "<font style=font-size:21px>")
strString = Replace(strString, "[cor=preto]", "<font color=#000000>")
strString = Replace(strString, "[cor=vermelho]", "<font color=#ff0000>")
strString = Replace(strString, "[cor=amarelo]", "<font color=#ffff00>")
strString = Replace(strString, "[cor=rosa]", "<font color=#f674dc>")
strString = Replace(strString, "[cor=verde]", "<font color=#00ff00>")
strString = Replace(strString, "[cor=laranja]", "<font color=#ffcc00>")
strString = Replace(strString, "[cor=roxo]", "<font color=#5601d7>")
strString = Replace(strString, "[cor=azul]", "<font color=#0000ff>")
strString = Replace(strString, "[cor=bege]", "<font color=#ece9d8>")
strString = Replace(strString, "[cor=marron]", "<font color=#b22f04>")
strString = ContaLink(strString)
strString = ContaEmail(strString)
Codifica = strString
End Function

Function Decodifica(strString)
strString = Replace(strString, "&nbsp;&nbsp;", Chr(32) & Chr(32))
strString = Replace(strString, "&nbsp;", Chr(13))
strString = Replace(strString, "</p><p>", Chr(10) & Chr(10))
strString = Replace(strString, "<br>", Chr(10))
strString = Replace(strString, "<b>", "[b]")
strString = Replace(strString, "</b>", "[/b]")
strString = Replace(strString, "<i>", "[i]")
strString = Replace(strString, "</i>", "[/i]")
strString = Replace(strString, "<u>", "[u]")
strString = Replace(strString, "</u>", "[/u]")
strString = Replace(strString, "<hr size=1 color=cccccc>", "[linha]")
strString = Replace(strString, "<div align=justify>", "[justificar]")
strString = Replace(strString, "</div></js>", "[/justificar]")
strString = Replace(strString, "</div></al>", "[/alinhar]")
strString = Replace(strString, "<div align=left>", "[alinhar=esquerda]")
strString = Replace(strString, "<div align=right>", "[alinhar=direita]")
strString = Replace(strString, "<center>", "[centralizar]")
strString = Replace(strString, "</center>", "[/centralizar]")
strString = Replace(strString, "<table align=center width=""80%"" style=""border-right: 1px solid #000000;border-left: 1px solid #000000;border-top: 1px solid #000000;border-bottom: 1px solid #000000""><tr><td><font face=verdana style=font-size:10px>", "[comentario]")
strString = Replace(strString, "</td></tr></table>", "[/comentario]")
strString = Replace(strString, "<ul>", "[lista]")
strString = Replace(strString, "<li>", "[item]")
strString = Replace(strString, "</ul>", "[/lista]")
strString = Replace(strString, "</font>", "[/fonte]")
strString = Replace(strString, "<font face=""Andale Mono"">", "[fonte=Andale Mono]")
strString = Replace(strString, "<font face=""Arial"">", "[fonte=Arial]")
strString = Replace(strString, "<font face=""Arial Black"">", "[fonte=Arial Black]")
strString = Replace(strString, "<font face=""Book Antiqua"">", "[fonte=Book Antiqua]")
strString = Replace(strString, "<font face=""Century Gothic"">", "[fonte=Century Gothic]")
strString = Replace(strString, "<font face=""Comic Sans MS"">", "[fonte=Comic Sans MS]")
strString = Replace(strString, "<font face=""Courier New"">", "[fonte=Courier New]")
strString = Replace(strString, "<font face=""Georgia"">", "[fonte=Georgia]")
strString = Replace(strString, "<font face=""Impact"">", "[fonte=Impact]")
strString = Replace(strString, "<font face=""Tahoma"">", "[fonte=Tahoma]")
strString = Replace(strString, "<font face=""Times New Roman"">", "[fonte=Times New Roman]")
strString = Replace(strString, "<font face=""Trebuchet MS"">", "[fonte=Trebuchet MS]")
strString = Replace(strString, "<font face=""Script MT Bold"">", "[fonte=Script MT Bold]")
strString = Replace(strString, "<font face=""Stencil"">", "[fonte=Stencil]")
strString = Replace(strString, "<font face=""Verdana"">", "[fonte=Verdana]")
strString = Replace(strString, "<font face=""Lucida Console"">", "[fonte=Lucida Console]")
strString = Replace(strString, "</font>", "[/tamanho]")
strString = Replace(strString, "</font>", "[/cor]")
strString = Replace(strString, "<font style=font-size:11px>", "[tamanho=1]")
strString = Replace(strString, "<font style=font-size:13px>", "[tamanho=2]")
strString = Replace(strString, "<font style=font-size:15px>", "[tamanho=3]")
strString = Replace(strString, "<font style=font-size:17px>", "[tamanho=4]")
strString = Replace(strString, "<font style=font-size:19px>", "[tamanho=5]")
strString = Replace(strString, "<font style=font-size:21px>", "[tamanho=6]")
strString = Replace(strString, "<font color=#000000>", "[cor=preto]")
strString = Replace(strString, "<font color=#ff0000>", "[cor=vermelho]")
strString = Replace(strString, "<font color=#ffff00>", "[cor=amarelo]")
strString = Replace(strString, "<font color=#f674dc>", "[cor=rosa]")
strString = Replace(strString, "<font color=#00ff00>", "[cor=verde]")
strString = Replace(strString, "<font color=#ffcc00>", "[cor=laranja]")
strString = Replace(strString, "<font color=#5601d7>", "[cor=roxo]")
strString = Replace(strString, "<font color=#0000ff>", "[cor=azul]")
strString = Replace(strString, "<font color=#ece9d8>", "[cor=bege]")
strString = Replace(strString, "<font color=#b22f04>", "[cor=marron]")
strString = Replace(strString, "<font color=#b22f04>", "[cor=marron]")
strString = VerEmail(strString)
strString = VerLink(strString)
strString = Replace(strString, "</a>", "")

Decodifica = strString
End Function

Function VerLink(strString)
oTag = "####"
c1Tag = "####"
oTag2 = "<a href=http://"
roTag = "[link]"
c1Tag2 = " target=_blank style=text-decoration:underline;>"
rc1Tag = "[/link]"
c2Tag = " target=_blank style=text-decoration:underline;>"
rc2Tag = ""
oTagpos = InStr(1, strString, oTag, 1)
c1TagPos = InStr(1, strString, c1Tag, 1)
strTempString = ""
If (oTagpos > 0) And (c1TagPos > 0) Then
strArray = Split(strString, oTag, -1, 1)
For counter2 = 0 To UBound(strArray)
If (InStr(1, strArray(counter2), c2Tag, 1) > 0) Or (InStr(1, strArray(counter2), c1Tag, 1) > 0) Then
strArray2 = Split(strArray(counter2), c1Tag, -1, 1)
If InStr(1, strArray2(1), c2Tag, 1) And Not ((InStr(1, UCase(strArray2(1)), "[link]", 1) > 0) And Not (InStr(1, UCase(strArray2(1)), "[/link]", 1) > 0)) Then
strFirstPart = Left(strArray2(1), InStr(1, strArray2(1), c2Tag, 1) - 1)
strSecondPart = Right(strArray2(1), (Len(strArray2(1)) - InStr(1, strArray2(1), c2Tag, 1) - Len(c2Tag) + 1))
If strFirstPart <> "" Then
If (InStr(strArray2(0), "@") > 0) And UCase(Left(strArray2(0), 7)) <> "MAILTO:" Then
strTempString = strTempString & roTag & strArray2(0) & rc1Tag & strFirstPart & rc2Tag
Else
strTempString = strTempString & roTag & strArray2(0) & rc1Tag & strFirstPart & rc2Tag
End If
Else
If (InStr(strArray2(0), "@") > 0) And UCase(Left(strArray2(0), 7)) <> "MAILTO:" Then
strTempString = strTempString & roTag & strArray2(0) & rc1Tag & rc2Tag
Else
strTempString = strTempString & roTag & strArray2(0) & rc1Tag & rc2Tag
End If
End If
Else
strTempString = strTempString & roTag & strArray2(0) & rc1Tag & rc2Tag
End If
ElseIf (InStr(1, strArray(counter2), c1Tag, 1) > 0) Then
strArray2 = Split(strArray(counter2), c1Tag, -1)
strTempString = strTempString & roTag & strArray2(0) & rc1Tag & rc2Tag
Else
strTempString = strTempString & strArray(counter2)
End If
Next
Else
strTempString = strString
End If
oTagpos2 = InStr(1, strTempString, oTag2, 1)
c1TagPos2 = InStr(1, strTempString, c1Tag2, 1)
If (oTagpos2 > 0) And (c1TagPos2 > 0) Then
strTempString2 = ""
strArray = Split(strTempString, oTag2, -1, 1)
For counter3 = 0 To UBound(strArray)
If (InStr(1, strArray(counter3), c1Tag2, 1) > 0) Then
strArray2 = Split(strArray(counter3), c1Tag2, -1, 1)
vararray = Replace(strArray2(1), strArray2(0), "")
If (InStr(strArray2(0), "@") > 0) And UCase(Left(strArray2(0), 7)) <> "MAILTO:" Then
strTempString2 = strTempString2 & roTag & strArray2(0) & rc1Tag & rc2Tag & vararray
Else
strTempString2 = strTempString2 & roTag & strArray2(0) & rc1Tag & rc2Tag & vararray
End If
Else
strTempString2 = strTempString2 & strArray(counter3)
End If
Next
strTempString = strTempString2
End If
VerLink = strTempString
End Function

Function VerEmail(strString)
oTag = "####"
c1Tag = "####"
oTag2 = "<a href=mailto:"
roTag = "[email]"
c1Tag2 = " target=_email style=text-decoration:underline;>"
rc1Tag = "[/email]"
c2Tag = " target=_email style=text-decoration:underline;>"
rc2Tag = ""
oTagpos = InStr(1, strString, oTag, 1)
c1TagPos = InStr(1, strString, c1Tag, 1)
strTempString = ""
If (oTagpos > 0) And (c1TagPos > 0) Then
strArray = Split(strString, oTag, -1, 1)
For counter2 = 0 To UBound(strArray)
If (InStr(1, strArray(counter2), c2Tag, 1) > 0) Or (InStr(1, strArray(counter2), c1Tag, 1) > 0) Then
strArray2 = Split(strArray(counter2), c1Tag, -1, 1)
If InStr(1, strArray2(1), c2Tag, 1) And Not ((InStr(1, UCase(strArray2(1)), "[email]", 1) > 0) And Not (InStr(1, UCase(strArray2(1)), "[/email]", 1) > 0)) Then
strFirstPart = Left(strArray2(1), InStr(1, strArray2(1), c2Tag, 1) - 1)
strSecondPart = Right(strArray2(1), (Len(strArray2(1)) - InStr(1, strArray2(1), c2Tag, 1) - Len(c2Tag) + 1))
If strFirstPart <> "" Then
If (InStr(strArray2(0), "@") > 0) And UCase(Left(strArray2(0), 7)) <> "MAILTO:" Then
strTempString = strTempString & roTag & strArray2(0) & rc1Tag & strFirstPart & rc2Tag
Else
strTempString = strTempString & roTag & strArray2(0) & rc1Tag & strFirstPart & rc2Tag
End If
Else
If (InStr(strArray2(0), "@") > 0) And UCase(Left(strArray2(0), 7)) <> "MAILTO:" Then
strTempString = strTempString & roTag & strArray2(0) & rc1Tag & rc2Tag
Else
strTempString = strTempString & roTag & strArray2(0) & rc1Tag & rc2Tag
End If
End If
Else
strTempString = strTempString & roTag & strArray2(0) & rc1Tag & rc2Tag
End If
ElseIf (InStr(1, strArray(counter2), c1Tag, 1) > 0) Then
strArray2 = Split(strArray(counter2), c1Tag, -1)
strTempString = strTempString & roTag & strArray2(0) & rc1Tag & rc2Tag
Else
strTempString = strTempString & strArray(counter2)
End If
Next
Else
strTempString = strString
End If
oTagpos2 = InStr(1, strTempString, oTag2, 1)
c1TagPos2 = InStr(1, strTempString, c1Tag2, 1)
If (oTagpos2 > 0) And (c1TagPos2 > 0) Then
strTempString2 = ""
strArray = Split(strTempString, oTag2, -1, 1)
For counter3 = 0 To UBound(strArray)
If (InStr(1, strArray(counter3), c1Tag2, 1) > 0) Then
strArray2 = Split(strArray(counter3), c1Tag2, -1, 1)
vararray = Replace(strArray2(1), strArray2(0), "")
If (InStr(strArray2(0), "@") > 0) And UCase(Left(strArray2(0), 7)) <> "MAILTO:" Then
strTempString2 = strTempString2 & roTag & strArray2(0) & rc1Tag & rc2Tag & vararray
Else
strTempString2 = strTempString2 & roTag & strArray2(0) & rc1Tag & rc2Tag & vararray
End If
Else
strTempString2 = strTempString2 & strArray(counter3)
End If
Next
strTempString = strTempString2
End If
VerEmail = strTempString
End Function

Function ContaLink(strString)
oTag = "[link="""
oTag2 = "[link]"
roTag = "<a href="
c1Tag = """]"
c1Tag2 = "[/link]"
rc1Tag = " target=_blank style=text-decoration:underline;>"
c2Tag = "[/link]"
rc2Tag = "</a>"
oTagpos = InStr(1, strString, oTag, 1)
c1TagPos = InStr(1, strString, c1Tag, 1)
strTempString = ""
If (oTagpos > 0) And (c1TagPos > 0) Then
strArray = Split(strString, oTag, -1, 1)
For counter2 = 0 To UBound(strArray)
If (InStr(1, strArray(counter2), c2Tag, 1) > 0) Or (InStr(1, strArray(counter2), c1Tag, 1) > 0) Then
strArray2 = Split(strArray(counter2), c1Tag, -1, 1)
If InStr(1, strArray2(1), c2Tag, 1) And Not ((InStr(1, UCase(strArray2(1)), "[link]", 1) > 0) And Not (InStr(1, UCase(strArray2(1)), "[/link]", 1) > 0)) Then
strFirstPart = Left(strArray2(1), InStr(1, strArray2(1), c2Tag, 1) - 1)
strSecondPart = Right(strArray2(1), (Len(strArray2(1)) - InStr(1, strArray2(1), c2Tag, 1) - Len(c2Tag) + 1))
If strFirstPart <> "" Then
If (InStr(strArray2(0), "@") > 0) And UCase(Left(strArray2(0), 7)) <> "MAILTO:" Then
strTempString = strTempString & roTag & "http://" & strArray2(0) & rc1Tag & strFirstPart & rc2Tag & strSecondPart
Else
strTempString = strTempString & roTag & "http://" & strArray2(0) & rc1Tag & strFirstPart & rc2Tag & strSecondPart
End If
Else
If (InStr(strArray2(0), "@") > 0) And UCase(Left(strArray2(0), 7)) <> "MAILTO:" Then
strTempString = strTempString & roTag & "http://" & strArray2(0) & rc1Tag & strArray2(0) & rc2Tag & strSecondPart
Else
strTempString = strTempString & roTag & "http://" & strArray2(0) & rc1Tag & strArray2(0) & rc2Tag & strSecondPart
End If
End If
Else
strTempString = strTempString & roTag & strArray2(0) & rc1Tag & strArray2(0) & rc2Tag & strArray2(1)
End If
ElseIf (InStr(1, strArray(counter2), c1Tag, 1) > 0) Then
strArray2 = Split(strArray(counter2), c1Tag, -1)
strTempString = strTempString & roTag & strArray2(0) & rc1Tag & strArray2(0) & rc2Tag & strArray2(1)
Else
strTempString = strTempString & strArray(counter2)
End If
Next
Else
strTempString = strString
End If
oTagpos2 = InStr(1, strTempString, oTag2, 1)
c1TagPos2 = InStr(1, strTempString, c1Tag2, 1)
If (oTagpos2 > 0) And (c1TagPos2 > 0) Then
strTempString2 = ""
strArray = Split(strTempString, oTag2, -1, 1)
For counter3 = 0 To UBound(strArray)
If (InStr(1, strArray(counter3), c1Tag2, 1) > 0) Then
strArray2 = Split(strArray(counter3), c1Tag2, -1, 1)
If (InStr(strArray2(0), "@") > 0) And UCase(Left(strArray2(0), 7)) <> "MAILTO:" Then
strTempString2 = strTempString2 & roTag & "http://" & strArray2(0) & rc1Tag & strArray2(0) & rc2Tag & strArray2(1)
Else
strTempString2 = strTempString2 & roTag & "http://" & strArray2(0) & rc1Tag & strArray2(0) & rc2Tag & strArray2(1)
End If
Else
strTempString2 = strTempString2 & strArray(counter3)
End If
Next
strTempString = strTempString2
End If
ContaLink = strTempString
End Function

Function ContaEmail(strString)
oTag = "[email="""
oTag2 = "[email]"
roTag = "<a href="
c1Tag = """]"
c1Tag2 = "[/email]"
rc1Tag = " target=_email style=text-decoration:underline;>"
c2Tag = "[/email]"
rc2Tag = "</a>"
oTagpos = InStr(1, strString, oTag, 1)
c1TagPos = InStr(1, strString, c1Tag, 1)
strTempString = ""
If (oTagpos > 0) And (c1TagPos > 0) Then
strArray = Split(strString, oTag, -1, 1)
For counter2 = 0 To UBound(strArray)
If (InStr(1, strArray(counter2), c2Tag, 1) > 0) Or (InStr(1, strArray(counter2), c1Tag, 1) > 0) Then
strArray2 = Split(strArray(counter2), c1Tag, -1, 1)
If InStr(1, strArray2(1), c2Tag, 1) And Not ((InStr(1, UCase(strArray2(1)), "[email]", 1) > 0) And Not (InStr(1, UCase(strArray2(1)), "[/email]", 1) > 0)) Then
strFirstPart = Left(strArray2(1), InStr(1, strArray2(1), c2Tag, 1) - 1)
strSecondPart = Right(strArray2(1), (Len(strArray2(1)) - InStr(1, strArray2(1), c2Tag, 1) - Len(c2Tag) + 1))
If strFirstPart <> "" Then
If (InStr(strArray2(0), "@") > 0) And UCase(Left(strArray2(0), 7)) <> "MAILTO:" Then
strTempString = strTempString & roTag & "mailto:" & strArray2(0) & rc1Tag & strFirstPart & rc2Tag & strSecondPart
Else
strTempString = strTempString & roTag & "mailto:" & strArray2(0) & rc1Tag & strFirstPart & rc2Tag & strSecondPart
End If
Else
If (InStr(strArray2(0), "@") > 0) And UCase(Left(strArray2(0), 7)) <> "MAILTO:" Then
strTempString = strTempString & roTag & "mailto:" & strArray2(0) & rc1Tag & strArray2(0) & rc2Tag & strSecondPart
Else
strTempString = strTempString & roTag & "mailto:" & strArray2(0) & rc1Tag & strArray2(0) & rc2Tag & strSecondPart
End If
End If
Else
strTempString = strTempString & roTag & strArray2(0) & rc1Tag & strArray2(0) & rc2Tag & strArray2(1)
End If
ElseIf (InStr(1, strArray(counter2), c1Tag, 1) > 0) Then
strArray2 = Split(strArray(counter2), c1Tag, -1)
strTempString = strTempString & roTag & strArray2(0) & rc1Tag & strArray2(0) & rc2Tag & strArray2(1)
Else
strTempString = strTempString & strArray(counter2)
End If
Next
Else
strTempString = strString
End If
oTagpos2 = InStr(1, strTempString, oTag2, 1)
c1TagPos2 = InStr(1, strTempString, c1Tag2, 1)
If (oTagpos2 > 0) And (c1TagPos2 > 0) Then
strTempString2 = ""
strArray = Split(strTempString, oTag2, -1, 1)
For counter3 = 0 To UBound(strArray)
If (InStr(1, strArray(counter3), c1Tag2, 1) > 0) Then
strArray2 = Split(strArray(counter3), c1Tag2, -1, 1)
If (InStr(strArray2(0), "@") > 0) And UCase(Left(strArray2(0), 7)) <> "MAILTO:" Then
strTempString2 = strTempString2 & roTag & "mailto:" & strArray2(0) & rc1Tag & strArray2(0) & rc2Tag & strArray2(1)
Else
strTempString2 = strTempString2 & roTag & "mailto:" & strArray2(0) & rc1Tag & strArray2(0) & rc2Tag & strArray2(1)
End If
Else
strTempString2 = strTempString2 & strArray(counter3)
End If
Next
strTempString = strTempString2
End If
ContaEmail = strTempString
End Function

Sub BuildUploadRequest(RequestBin)
PosBeg = 1
PosEnd = InStrB(PosBeg, RequestBin, getByteString(Chr(13)))
boundary = MidB(RequestBin, PosBeg, PosEnd - PosBeg)
BoundaryPos = InStrB(1, RequestBin, boundary)
Do Until (BoundaryPos = InStrB(RequestBin, boundary & getByteString("--")))
Dim UploadControl
Set UploadControl = CreateObject("Scripting.Dictionary")
Pos = InStrB(BoundaryPos, RequestBin, getByteString("Content-Disposition"))
Pos = InStrB(Pos, RequestBin, getByteString("name="))
PosBeg = Pos + 6
PosEnd = InStrB(PosBeg, RequestBin, getByteString(Chr(34)))
Name = getString(MidB(RequestBin, PosBeg, PosEnd - PosBeg))
PosFile = InStrB(BoundaryPos, RequestBin, getByteString("filename="))
PosBound = InStrB(PosEnd, RequestBin, boundary)
If PosFile <> 0 And (PosFile < PosBound) Then
PosBeg = PosFile + 10
PosEnd = InStrB(PosBeg, RequestBin, getByteString(Chr(34)))
FileName = getString(MidB(RequestBin, PosBeg, PosEnd - PosBeg))
UploadControl.Add "FileName", FileName
Pos = InStrB(PosEnd, RequestBin, getByteString("Content-Type:"))
PosBeg = Pos + 14
PosEnd = InStrB(PosBeg, RequestBin, getByteString(Chr(13)))
ContentType = getString(MidB(RequestBin, PosBeg, PosEnd - PosBeg))
UploadControl.Add "ContentType", ContentType
PosBeg = PosEnd + 4
PosEnd = InStrB(PosBeg, RequestBin, boundary) - 2
Value = MidB(RequestBin, PosBeg, PosEnd - PosBeg)
Else
Pos = InStrB(Pos, RequestBin, getByteString(Chr(13)))
PosBeg = Pos + 4
PosEnd = InStrB(PosBeg, RequestBin, boundary) - 2
Value = getString(MidB(RequestBin, PosBeg, PosEnd - PosBeg))
End If
UploadControl.Add "Value", Value
UploadRequest.Add Name, UploadControl
BoundaryPos = InStrB(BoundaryPos + LenB(boundary), RequestBin, boundary)
Loop
End Sub

Function getByteString(StringStr)
For i = 1 To Len(StringStr)
Char = Mid(StringStr, i, 1)
getByteString = getByteString & ChrB(AscB(Char))
Next
End Function

Function getString(StringBin)
getString = ""
For intCount = 1 To LenB(StringBin)
getString = getString & Chr(AscB(MidB(StringBin, intCount, 1)))
Next
End Function

%>
