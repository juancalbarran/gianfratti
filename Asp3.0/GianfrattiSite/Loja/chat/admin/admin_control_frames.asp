<%
Dim strDBpathCorrection					'Variable to hold database path correction
strDBpathCorrection = "../"
%>
<!--#include file="../common.asp" -->
<!--#include file="check_admin.asp" -->
<html>
<head>
<title><%=strCompanyName%>&nbsp;- Painel Administrativo de Controle de Atendimento ao Vivo</title>
<script>
opener.close();
</script>
</head>
<%'Set the frames%>
<frameset rows="*,338"> 
<frame src="admin_top_menu.asp?addpass=<%=addpass%>" noresize scrolling="no" frameborder="1" name="top">
<frame src="admin_visitors.asp?addpass=<%=addpass%>" noresize frameborder="1" name="main" scrolling="yes">
</frameset> 
</frameset>
</html>
