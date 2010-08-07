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


'#########################################################################################
'# Consulta posição de estoque dos produtos da loja										 #
'# produtos que tenham estoque maior ou menor que o informado pelo usuario               #
'# CRIADO/MELHORADO por: Fábio V.Coelho 												 #
'# AJUDA: Rogerio 																		 #
'#########################################################################################

%><!--#include file="adm_restrito.asp"--><%

total_vendido=0
subtotal_vendido=0

set conn = Server.CreateObject("ADODB.Connection")
conn.Open(StringdeConexao)

 strRegistro = " SELECT produtos.nome, produtos.preco, produtos.vendas, estoque.idproduto, estoque.estoque FROM ESTOQUE, PRODUTOS where produtos.idprod=estoque.idproduto order by estoque.estoque desc" 
 set rs= conn.execute(strRegistro) 

   SQL = "pr.nome, es.idproduto, es.estoque "
   SQL = SQL & " produtos pr, estoque es" 
   SQL = SQL & " where es.estoque like '0' pr.idprod=es.idproduto" 

				strTextoHtml = strTextoHtml & "<FONT face=tahoma color=#003366 style=font-size:17px><img src=""adm_imagens/prod_g.gif"" width=""30"" height=""33"" hspace=""1"" vspace=""1"" border=""0"" align=""left""><B>&nbsp;Estoque Atual e Vendas Efetuadas dos produtos na loja</B></FONT><hr size=1 color=#cccccc><br>"

IF NOT RS.EOF THEN 
 strTextoHtml = strTextoHtml & "<br><table width=100% cellspacing=""0"" cellpadding=""0"">"
DO WHILE NOT RS.EOF 
  strTextoHtml = strTextoHtml & "<tr><td colspan=3 align=left><hr size=1 color=#cccccc width=""101%""></td></tr>"
  strTextoHtml = strTextoHtml & "<tr><td colspan=1 align=left><font face=""tahoma"" style=font-size:11px>" & RS("nome") 

 	if RS("ESTOQUE")<4 then
  strTextoHtml = strTextoHtml & "  </font></td><td colspan=1 nowrap><font face=""tahoma"" style=font-size:11px > Vendas: " &  RS("vendas") & " &nbsp;</font>"
  strTextoHtml = strTextoHtml & "  </font></td><td colspan=1 nowrap><font face=""tahoma"" style=font-size:11px color=red><strong> Estoque: " &  RS("ESTOQUE") & " &nbsp;</strong></font>"
  strTextoHtml = strTextoHtml & "  </font></td><td colspan=1 nowrap><font face=""tahoma"" style=font-size:11px > <a href=?link=produtos&acao=edita&prod=" & rs("idproduto") & "><strong>Colocar Estoque</strong></a></font><br></td></tr>"
	else
  strTextoHtml = strTextoHtml & "  </font></td><td colspan=1 nowrap><font face=""tahoma"" style=font-size:11px > Vendas: " &  RS("vendas") & " </font>"
  strTextoHtml = strTextoHtml & "  </font></td><td colspan=1 nowrap><font face=""tahoma"" style=font-size:11px> Estoque: " &  RS("ESTOQUE") & " </font>"
  strTextoHtml = strTextoHtml & "  </font></td><td colspan=1 nowrap><font face=""tahoma"" style=font-size:11px> <a href=?link=produtos&acao=edita&prod=" & rs("idproduto") & "><strong>Alterar Estoque</strong></a></font><br></td></tr>"
	end if

  subtotal_vendido=rs("vendas")*rs("preco") 
  total_vendido=total_vendido+subtotal_vendido

RS.MOVENEXT 
LOOP 
  strTextoHtml = strTextoHtml & "<tr><td colspan=3 align=left><hr size=1 color=#cccccc width=""101%""></td></tr>"
  strTextoHtml = strTextoHtml & "</table>"
  

ELSE 
strTextoHtml = strTextoHtml & "<br><font face=""tahoma"" style=font-size:11px color=red><strong>Não existem produtos na sua loja! </font><br>" 
END IF

Conn.close
set Conn = nothing

strTextoHtml = strTextoHtml & "<br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><img src=""adm_imagens/mao.gif"" width=""26"" height=""28"" hspace=""1"" vspace=""1"" border=""0"" align=""absmiddle"" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>A loja já efetuou "& strLgMoeda & " " & formatnumber(total_vendido,2)&" nas vendas acima</b></center>" 

strTextoHtml = strTextoHtml & "<br><hr size=1 color=dddddd><center><FONT face=tahoma  style=font-size:11px><img align=absmiddle border=0 src=""adm_imagens/xis.gif"" > &nbsp;&nbsp;&nbsp;<b><A onclick=""return confirm('Você quer zerar a contagem de vendas?')"" href=""?link=util&acao=vendas&acaba=sim"">Você quer Zerar a Contagem das Vendas acima?</A></b></center><br>" 

%>

