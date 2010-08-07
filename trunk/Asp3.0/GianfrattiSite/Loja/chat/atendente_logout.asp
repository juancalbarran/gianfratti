<!--#include file="funcoes.asp"-->
<%
atendente = Trim(Request.QueryString("atendente"))

remove_atendente atendente

Set atendente = Nothing
%>
<script language="JavaScript">window.close()</script>