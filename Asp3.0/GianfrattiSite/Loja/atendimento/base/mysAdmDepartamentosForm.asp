<%
'MYSUPPORT - ALGUNS DIREITOS RESERVADOS
'http://www.mysupport.com.br
'
'TERMOS DE LICENÇA DESTE SISTEMA
'
'Você pode:
'
'- Copiar, distribuir, exibir e executar a obra;
'- Criar obras derivadas.
'
'Sob as seguintes condições:
'
'- Atribuição. Você deve dar crédito ao autor original.
'- Uso Não-Comercial. Você não pode utilizar esta obra com finalidades comerciais.
'- Compartilhamento pela mesma Licença. Se você alterar, transformar, ou criar outra obra com base nesta, você somente poderá distribuir a obra resultante sob uma licença idêntica a esta.
'
'Para cada novo uso ou distribuição, você deve deixar claro para outros os termos da licença desta obra.
'Qualquer uma destas condições podem ser renunciadas, desde que você obtenha permissão do autor.
'Qualquer direito de uso legítimo (ou "fair use") concedido por lei, ou qualquer outro direito protegido pela legislação local, não são em hipótese alguma afetados pelo disposto acima.
'
'Este é um sumário para leigos da Licença Jurídica (na íntegra).
'
'LICENSE
'
'You are free:
'
'to copy, distribute, display, and perform the work;
'to make derivative works.
'
'Under the following conditions:
'
'- Attribution. You must give the original author credit.
'- Noncommercial. You may not use this work for commercial purposes.
'- Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under a license identical to this one. 
'
'For any reuse or distribution, you must make clear to others the license terms of this work.
'Any of these conditions can be waived if you get permission from the copyright holder.
'Your fair use and other rights are in no way affected by the above.
'
'This is a human-readable summary of the Legal Code (the full license).
%>
<%
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	Session.lCid = 1033
	
	If NOT Session("mysAdmin") Then Response.Redirect "mysAdmSair.asp"
%>
<!--#include file="db.asp"-->
<%
Dim strAcao, intComando, strSQL

strAcao 			= OK(Request.QueryString("acao"))
intDepartamento 	= OK(Request.QueryString("ID"))

Call AbreDB

If Request.ServerVariables("HTTP_METHOD") = "POST" Then
	intDepartamento 	= OK(Request.Form("ID"))
	strNome				= Server.HTMLEncode(OK(Request.Form("nome")))
	
	If intDepartamento = "" Then
		strSQL = "INSERT INTO departamentos(nome) VALUES('" & strNome & "')"
		Conexao.Execute(strSQL)
		Response.Redirect "mysAdmDepartamentos.asp?msg_ok=Departamento incluído com sucesso"
	Else
		strSQL = "UPDATE departamentos SET nome = '" & strNome & "' WHERE id = " & intDepartamento
		Conexao.Execute(strSQL)
		Response.Redirect "mysAdmDepartamentos.asp?msg_ok=Departamento alterado com sucesso"
	End If
Else
	Select Case strAcao
		Case "Editar":
					strBotao = "Alterar"
					strSQL = "SELECT nome FROM departamentos WHERE id = " & intDepartamento
					Set rs = Conexao.Execute(strSQL)
					If rs.BOF AND rs.EOF Then
						Response.Redirect "mysAdmDepartamentos.asp?msg_erro=Departamento inexistente"
					Else
						strNome	= rs("nome")
					End If
					rs.Close
		
		Case "Deletar":
					strSQL = "DELETE FROM departamentos WHERE id = " & intDepartamento
					Conexao.Execute(strSQL)
					
					Response.Redirect "mysAdmDepartamentos.asp?msg_ok=Departamento excluido com sucesso"
		
		Case Else:
					strBotao = "Incluir"
	End Select
End If

Call FechaDB
%>
<html>
<head>
<title> &#9658;&#9658;&#9658; MySupport - Atendimento Online</title>
<style>
a:link	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:visited	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:hover	{font-size:8pt; font-family: Tahoma, Verdana; color:F4B511; TEXT-DECORATION: none;}
body	{ font-family: Tahoma, Verdana; font-size: 8pt; }

body 			{ scrollbar-face-color: #E2E5EA;}
body 			{ scrollbar-shadow-color: #687888;}
body 			{ scrollbar-highlight-color: #ffffff;}
body 			{ scrollbar-3dlight-color: #687888;}
body 			{ scrollbar-darkshadow-color: #E2E5EA;}
body 			{ scrollbar-track-color: #bcbfc0;}
body 			{ scrollbar-arrow-color: #6e7e88;}

td		{ font-family: Tahoma, Verdana; font-size: 8pt; }
.campo{				
		font-family: Arial, Verdana; 
		font-size: 11px; 
		background-color: #FFFFFF;	
		border-left: 1 solid #68A4C8; 
		border-right: 1 solid #B8D0D8; 
		border-top: 1 solid #68A4C8; 
		border-bottom: 1 solid #B8D0D8;
		}
				
.botao 	{
			background-color: #E8E8E8; 
			color: black; 
			border-color: #FFFFFF; 
			border-width: 1px; 
			font-family: Tahoma, Verdana; 
			font-size: 8pt;
		}
</style>
</head>
<script language="JavaScript">
function validarForm(){
	if(form.nome.value == '') {
		alert('Você deve preencher o campo nome!');
		form.nome.focus();
		return false;
	}
return true;
}
</script>
<body topmargin="0" leftmargin="0" bottommargin="0">
<table width="95%" cellpadding="1" align="center">
	<tr><td colspan="2" height="15"></td></tr>
	<td valign="top"><img src="img/t_departamentos.gif" alt="" border="0">
	</td><td align="right"></td></tr>
	<tr><td colspan="2" height="1" bgcolor="DDDDDD"></td></tr>
	<tr><td colspan="2" height="15"></td></tr>
</table>
<table width="35%" cellpadding="1" align="center">
			<form name="form" action="mysAdmDepartamentosForm.asp" method="post" onSubmit="return validarForm();">
			<table width="35%" align="center">
				<tr>
					<td colspan="2" align="center"><b>Dados Departamento</b></td>
				</tr>
				<tr>
					<td colspan="2" height="15"></td>
				</tr>	
				<tr>
					<td width="50%">Nome:</td>
					<td><input type="hidden" name="id" value="<%=intDepartamento%>"><input type="text" name="nome" value="<%=strNome%>" size="30" maxlength="60" class="campo"></td>
					</tr>
				<tr>
					<td></td>
					<td>
					<br><input type="submit" value="    <%=strBotao%>    " class="botao">
			</td></tr></table>
			</form>
</td></tr></table>
</body>
</html>
