<%@ LANGUAGE="VBSCRIPT"%>

'Deletar Histórico das conversas do MYsupport:
'
'- Criado por Ricardo Pires
'- rjpires@gmail.com

<%Session.LCID=1046%>

'Aqui abrimos a conexão com o banco e colocamos o caminho físico para o banco

<%
Set banco = Server.CreateObject("ADODB.Connection")
banco.open = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=C:\Inetpub\wwwroot\suporte\MySupport.mdb"
%>

<%
acao = request.querystring("id")
sql_delete = "delete * from conversas where id=" & acao
set deletecateg = banco.execute(sql_delete)
%>

<% Response.Redirect "mysAdmHistorico.asp"%>
