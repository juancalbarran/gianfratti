<!--#include file="db.asp"-->
<!--#include file="mysConfiguracoes.asp"-->
<%
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	Session.LCID = 1033
%>
<%
Call AbreDB
Dim strImagem

'Verifica se existe algum online
strSQL = "SELECT count(id) AS Total FROM operadores WHERE  DateDiff(""s"", ping, now()) < 10"

Set rs = Conexao.execute(strSQL)

If rs("Total") = "0" OR isNull(rs("Total")) OR rs("Total") = 0 Then
	strImagem = strConfigOffline
Else
	strImagem = strConfigOnline
End If

rs.Close

Call FechaDB
%>
</head>
<script language="JavaScript">
function abrirChat(){
	var width = 450;
	var height = 350;
	var esquerda = (screen.width/2) - (width/2);
	var topo = (screen.height/2) - (height/2);
	window.open("<%=strConfigEndereco%>/mysAtendimento.asp","MySupport","top="+topo+",left="+esquerda+",width="+width+",height="+height+",scrollbars=yes, menu=0,status=yes");
}</script><style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<a href="javascript:abrirChat();" title="Atendimento"><img border=0 src=<%=strImagem%> /></a>
