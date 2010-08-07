<!--#include file="adm_restrito.asp"-->
<%
strTextoHtml = strTextoHtml & "<BR><FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/acs.gif"" hspace=""1"" vspace=""1"" border=""0"" align=""left""> <B>Bem-vindo "&Session("NOME")&", a administração da "& nomeloja &"</B> <hr size=1 width=100% color=#cccccc align=left></FONT>"
strTextoHtml = strTextoHtml & "<br><table width=""100%""><tr><td colspan=2><b><FONT face=tahoma style=font-size:11px>Estatísticas da loja virtual " & nomeloja & " <BR> Esté o seu acesso nº "&Session("Acesso")&" , último acesso em "
 if Session("UltAcesso") = "" then 
 Response.Write date() 
 else 
 strTextoHtml = strTextoHtml &  Session("UltAcesso") &" hs"
 end if 
strTextoHtml = strTextoHtml & "</b></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><br>"
strTextoHtml = strTextoHtml & "<table align=center cellSpacing=4 cellPadding=4 style=""border-bottom: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-right: 1px solid #cccccc;"" width=450><tr><td align=left vAlign=center><img src=""adm_imagens/adm.gif"" width=""41"" height=""44"" border=""0""></td><td align=center vAlign=center>"
Set contacompra = conexao.Execute("SELECT count(pedido) AS totalcomp FROM compras WHERE status <> 'Compra em Aberto';")
Set contacli = conexao.Execute("SELECT count(nome) AS totalcli FROM clientes;")
Set ultimocli = conexao.Execute("SELECT last(datacad) AS totalcli FROM clientes;")
Set ultimacompra = conexao.Execute("SELECT last(datacompra) AS totalcomp FROM compras WHERE status <> 'Compra em Aberto';")
Set contapro = conexao.Execute("SELECT count(nome) AS totalpro FROM produtos;")

strTextoHtml = strTextoHtml & "<FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;Foram feitas <b>" & contacompra("totalcomp") & "</b> compras.<br>"
strTextoHtml = strTextoHtml & "<FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;A loja possui <b>" & contacli("totalcli") & "</b> clientes cadastrados.<br> Média de <b>" & FormatNumber((contacompra("totalcomp")/contacli("totalcli")), 2) & "</b> compra(s) por cliente<br>"
strTextoHtml = strTextoHtml & "<FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;O último cliente se cadastrou em <b>" & ultimocli("totalcli") & "</b>.<br>"
strTextoHtml = strTextoHtml & "<FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;A última compra foi efetuada em <b>" & ultimacompra("totalcomp") & "</b><br>"
strTextoHtml = strTextoHtml & "<FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;A loja possui <b>" & contapro("totalpro") & "</b> produtos à venda.<br>"

'strTextoHtml = strTextoHtml & "<FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;Produtos disponiveis: <b>" & contaprodi("totaldi") & "</b><br> &nbsp;&nbsp;Produtos esgotados: <b>" & contaproes("totales") & "</b><br> Atenção: <b>" & contaprope("totalpe") & "</b> produto(s) com menos de 3 unidades em estoque<br></td></tr></table>"

Set contaproes = conexao.Execute("SELECT count(nome) AS totales FROM produtos WHERE estoque = 'n';")
Set contaprodi = conexao.Execute("SELECT count(nome) AS totaldi FROM produtos WHERE estoque = 's';")
Set contaprope = conexao.Execute("SELECT count(idestoque) AS totalpe FROM estoque WHERE estoque <= 3;")

strTextoHtml = strTextoHtml & "<FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;Produtos disponiveis: <b>" & contaprodi("totaldi") & "</b><br> &nbsp;&nbsp;Produtos não disponíveis: <b>" & contaproes("totales") & "</b><br> "
if contaprope("totalpe") >0 then 
strTextoHtml = strTextoHtml & "<br><font color=""#FF0000""><strong>Atenção:</strong></font> <b>&nbsp;&nbsp;" & contaprope("totalpe") & "</b> produto(s) com menos de 3 unidades em estoque<br>"
end if

strTextoHtml = strTextoHtml & "</td></tr></table>"
'strTextoHtml = strTextoHtml & "</td></tr></table><br><table><tr><td height=6></td></tr></table>"


strTextoHtml = strTextoHtml & "<br><table align=center cellSpacing=4 cellPadding=4 style=""border-bottom: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-right: 1px solid #cccccc;"" width=450><tr><td align=left vAlign=center><img src=""adm_imagens/status_atendimento.gif"" width=""34"" height=""34"" border=""0""></td><td align=center vAlign=center>"


Set Conn= Server.CreateObject("adodb.connection")
Conn.open  "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="& Server.MapPath("chat/LiveSupport.mdb")

SQl = "select * from tblSettings where Online = '0'"
set Rs = Conn.execute(SQL)
	if Rs.eof then

		'*** Para aparecer a imagem de Atendimento "Online"

strTextoHtml = strTextoHtml & "<FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;O seu Status de Atendimento Online via Chat está <br> <font color=""#008000"">Online</font>&nbsp;&nbsp;&nbsp;<br><br>"
strTextoHtml = strTextoHtml & "<font color=""#FF0000""><strong>Atenção:</strong></font>&nbsp; Caso não haja ninguém logado no Sistema de Atendimento Online<br> para atender 'online' os clientes do site, altere o seu Status para <font color=""#ff0000"">Offline</font><br></td></tr></table><br>"
	else

		'*** Atendimento "Offline"  >>> Ative se vc quiser que avise que nao em ninguem "Online"
strTextoHtml = strTextoHtml & "<FONT face=tahoma style=font-size:11px>&nbsp;&nbsp;O seu Status de Atendimento Online via Chat está <br> <font color=""#ff0000"">Offline</font><br></td></tr></table><br>"
	end if
	
set rs = nothing
set atend = nothing



strTextoHtml = strTextoHtml & "<tr><td colspan=2><b><FONT face=tahoma style=font-size:11px>Dados da sua loja virtual ...</b><br><br><table><tr><td height=3></td></tr></table></td></tr>"
strTextoHtml = strTextoHtml & "<tr bgcolor=#eeeeee><td width=""35%""><FONT face=tahoma style=font-size:11px><b>Nome Fantasia:</b></td><td width=""75%""><FONT face=tahoma style=font-size:11px>" & nomeloja & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma style=font-size:11px><b>Razão social:</b></td><td><FONT face=tahoma style=font-size:11px>" & Application("razaoloja") & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr bgcolor=#eeeeee><td><FONT face=tahoma style=font-size:11px><b>Endereço:</b></td><td><FONT face=tahoma style=font-size:11px>" & endereco11 & " - " & bairro11 & " - " & cidade11 & "/" & estado11 & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma style=font-size:11px><b>Telefone:</b></td><td><FONT face=tahoma style=font-size:11px>" & fone11 & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr bgcolor=#eeeeee><td><FONT face=tahoma style=font-size:11px><b>URL:</b></td><td><FONT face=tahoma style=font-size:11px>http://" & urlloja & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma style=font-size:11px><b>E-mail:</b></td><td><FONT face=tahoma style=font-size:11px>" & emailloja & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr bgcolor=#eeeeee><td><FONT face=tahoma style=font-size:11px><b>Versão VirtuaStore:</b></td><td><FONT face=tahoma style=font-size:11px>" & Application("vsversao") & "</td></tr>"
strTextoHtml = strTextoHtml & "<tr><td><FONT face=tahoma style=font-size:11px><b>Última atualização:</b></td><td><FONT face=tahoma style=font-size:11px>" & Application("ultimaatualizacao") & "</td></tr>"

if VersaoDb = "2" then
strTextoHtml = strTextoHtml & "<tr bgcolor=#eeeeee><td><FONT face=tahoma style=font-size:11px><b>Banco de Dados:</b></td><td><FONT face=tahoma style=font-size:11px>Access [.mdb] &nbsp;&nbsp;(Conexão Estável) </td></tr>"
elseif VersaoDb = "3" then
strTextoHtml = strTextoHtml & "<tr bgcolor=#eeeeee><td><FONT face=tahoma style=font-size:11px><b>Banco de Dados:</b></td><td><FONT face=tahoma style=font-size:11px>SQLServer Datadase [.mdf] &nbsp;&nbsp;(Conexão Estável)</td></tr>"
else
strTextoHtml = strTextoHtml & "<tr bgcolor=#eeeeee><td><FONT face=tahoma style=font-size:11px><b>Banco de Dados:</b></td><td><FONT face=tahoma style=font-size:11px>MySQL Database [.frm] &nbsp;&nbsp;(Conexão Estável)</td></tr>"
end if

if instr(StringdeConexao,"database\")<>0 then
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set fileObject = fso.GetFile(Server.MapPath("database/virtuastore.mdb") )
else
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set fileObject = fso.GetFile(pasta_dados_protegido)
end if

if fileObject.size > 1048576 then
strTextoHtml = strTextoHtml & "<tr ><td><FONT face=tahoma style=font-size:11px><b>Tamanho da Base de Dados:</b></td><td><FONT face=tahoma style=font-size:11px>" & FormatNumber(fileObject.size/1048576,2) & "&nbsp;MB" & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Otimize o banco de dados pelo menos a cada 15 dias)</td></tr>"
else
strTextoHtml = strTextoHtml & "<tr ><td><FONT face=tahoma style=font-size:11px><b>Tamanho da Base de Dados:</b></td><td><FONT face=tahoma style=font-size:11px>" & FormatNumber(fileObject.size/1024, 0) & "&nbsp;KB" & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Otimize o banco de dados pelo menos a cada 15 dias)</td></tr>"
end if

strTextoHtml = strTextoHtml & "<tr><td colspan=2><br><table><tr><td height=1></td></tr></table><b><FONT face=tahoma style=font-size:11px>Notificações de atualização da sua loja ...</b><br></td></tr>"
strTextoHtml = strTextoHtml & "<tr><td colspan=2 align=center><table><tr><td height=10></td></tr></table>"
strTextoHtml = strTextoHtml & "<table align=center cellSpacing=0 width=90% height=30 cellPadding=0 style=""border-bottom: 1px solid #cccccc;border-top: 1px solid #cccccc;border-left: 1px solid #cccccc;border-right: 1px solid #cccccc;"">"
strTextoHtml = strTextoHtml & "<tr><td align=center vAlign=center>"

strTextoHtml = strTextoHtml & "<iframe src=""http://freehost23.websamba.com/worldbily_group/atualizacoes.htm"" width=""100%"" height=""90"" scrolling=""yes"" frameborder=""0"" marginheight=""0"" marginwidth=""0"">&nbsp;</iframe>"

strTextoHtml = strTextoHtml & "</td></tr></table><table><tr><td height=5></td></tr></table></td></tr></table>"
%>