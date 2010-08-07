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
%>
<!--#include file="config.asp"-->
<!--#include file="adm_restrito.asp"-->
<%
'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
'Atenção: Este arquivo não pode ser distrubuído ou separado desta VirtuaStore OPEN
'Colaboração: Elizeu Alcantara - elizeu@onda.com.br / elizeu@cristaosite.com.br
'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

response.buffer = true
response.expires = 10

if request.form("acao") = "ExecSQL" then
	Dim Conn
	set Conn = Server.CreateObject("ADODB.Connection")
	Conn.Open StringdeConexao 'Ponha aqui sua string de Conexão
	executar_sql=request.form("SQL")
	set qrSQL = Conn.Execute(executar_sql)
	
	strArea_transferencia = Request.form("area_transferencia")
	'grava a area de transferencia em cookies
	if strArea_transferencia<>"" then
	response.cookies("AreaTransferenciaSql")= strArea_transferencia
	response.cookies("AreaTransferenciaSql").Expires= #January 01, 2010#
	end if  
end if
%>
<html>
<head>
<title><%= Nome_da_sua_loja %> - Administração On-line</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<% area_transferencia = Request.Cookies("AreaTransferenciaSql") %>

<body bgcolor="#FFFFFF">

<form name="formSQL" method="post" action="">
  <input type="hidden" name="acao" value="ExecSQL">
  <table width="80%" border="0" cellspacing="0" cellpadding="0">
  
      <tr align="center"> 
      <td > 
        <p><font face=tahoma style=font-size:11px>Execu&ccedil;&atilde;o de Comandos SQL</font></p>
      </td>
      <td > 
        <p><font face=tahoma style=font-size:11px>Área de Transferência</font></p>
      </td>	  
    </tr>
  
    <tr align="center"> 
      <td > 
        <textarea name="SQL" rows="8" cols="70" style="font-family:tahoma; font-size: 11px; color:003366"><%= executar_sql %>
</textarea>
      </td>
      <td > 
        <textarea name="area_transferencia" rows="8" cols="60" style="font-family:tahoma; font-size: 11px; color:003366"><%= area_transferencia %>
</textarea>
      </td>	  
    </tr>
	<tr align="center"> 
      <td > 
        <input type=submit value="      Executar      " style="cursor:hand;font-family:tahoma; font-size: 11px;" onclick="Javascript: document.forms['formSQL'].submit()">
      </td>
      <td > &nbsp;  </td>	  
    </tr>
	

  </table>
  <br><br>
<%if UCase(Mid(request.form("SQL"),1,6)) = "SELECT" then%>
<table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#cccccc" bordercolordark="#cccccc">
  <tr bgcolor="#f5f5f5">
 <%for i = 0 to qrSQL.Fields.Count - 1%> 
    <td><font face=tahoma style="font-size:11px; color:003366"><%=qrSQL.Fields(i).name%>&nbsp;</font></td>
 <%next%>
    </tr>
 <%while not qrSQL.EOF%>
     <tr>
  <%for i = 0 to qrSQL.Fields.Count - 1%> 
     <td><font face=tahoma style=font-size:11px><%=qrSQL.Fields(i)%>&nbsp;</font></td>
  <%next%>
     </tr>
 <%qrSQL.MoveNext%>
 <%wend%>
  </table>
<%
Conn.close
set qrSQL = nothing
set Conn = nothing
%>
<%end if%>

</body>
</html>
