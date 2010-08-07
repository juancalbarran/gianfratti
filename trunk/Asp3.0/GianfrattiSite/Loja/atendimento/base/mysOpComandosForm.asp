<%
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	Session.lCid = 1033
	
	If NOT Session("mysOP") Then Response.Redirect "mysOpSair.asp"
%>
<!--#include file="db.asp"-->
<%
Dim strAcao, intComando, strSQL

strAcao 	= OK(Request.QueryString("acao"))
intComando 	= OK(Request.QueryString("ID"))

Call AbreDB

If Request.ServerVariables("HTTP_METHOD") = "POST" Then
	intComando 	= OK(Request.Form("ID"))
	strDescricao= Server.HTMLEncode(OK(Request.Form("descricao")))
	strConteudo	= Server.HTMLEncode(OK(Request.Form("conteudo")))
	
	If intComando = "" Then
		strSQL = "INSERT INTO comandos(descricao, conteudo, operador) VALUES('" & strDescricao & "','" & strConteudo & "'," & Session("mysOperadorID") & ")"
		Conexao.Execute(strSQL)
		Response.Redirect "mysOpComandos.asp?msg_ok=Comando incluído com sucesso"
	Else
		strSQL = "UPDATE comandos SET descricao = '" & strDescricao & "', conteudo = '" & strConteudo & "' WHERE id = "& intComando &" AND operador = " & Session("mysOperadorID")
		Conexao.Execute(strSQL)
		Response.Redirect "mysOpComandos.asp?msg_ok=Comando alterado com sucesso"
	End If
Else
	Select Case strAcao
		Case "Editar":
					strBotao = "Alterar"
					strSQL = "SELECT descricao, conteudo FROM comandos WHERE id = " & intComando & " AND operador = " & Session("mysOperadorID")
					Set rs = Conexao.Execute(strSQL)
					If rs.BOF AND rs.EOF Then
						Response.Redirect "mysOpComandos.asp?msg_erro=Comando inexistente"
					Else
						strDescricao	= rs("descricao")
						strConteudo		= rs("conteudo")
					End If
					rs.Close
		
		Case "Deletar":
					strSQL = "DELETE FROM comandos WHERE id = " & intComando & " AND operador = " & Session("mysOperadorID")
					Conexao.Execute(strSQL)
					
					Response.Redirect "mysOpComandos.asp?msg_ok=Comando excluido com sucesso"
		
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
	if(form.descricao.value == '') {
		alert('Você deve preencher o campo descrição!');
		form.descricao.focus();
		return false;
	}
	if(form.conteudo.value == '') {
		alert('Você deve preencher o campo conteúdo!');
		form.conteudo.focus();
		return false;
	}
return true;
}
</script>
<body topmargin="0" leftmargin="0" bottommargin="0">
<table width="95%" cellpadding="1" align="center">
	<tr><td colspan="2" height="15"></td></tr>
	<td valign="top"><img src="img/t_comandos.gif" alt="" border="0">
	</td><td align="right"></td></tr>
	<tr><td colspan="2" height="1" bgcolor="DDDDDD"></td></tr>
	<tr><td colspan="2" height="15"></td></tr>
</table>
<table width="35%" cellpadding="1" align="center">
<tr><td>
			<form name="form" action="mysOpComandosForm.asp" method="post" onSubmit="return validarForm();">
			<table width="35%" align="center">
				<tr>
					<td colspan="2" align="center"><b>Dados Comando</b></td>
				</tr>

				<tr>
					<td colspan="2" height="15"></td>
				</tr>	
				<tr>
					<td width="50%">Descrição:</td>
					<td><input type="hidden" name="id" value="<%=intComando%>"><input type="text" name="descricao" value="<%=strDescricao%>" size="30" maxlength="30" class="campo"></td></tr>
				<tr>
					<td width="50%">Conteúdo:</td>
					<td><input type="text" name="conteudo" value="<%=strConteudo%>" size="30" maxlength="255" class="campo"></td></tr>
				<tr>
					<td></td>
					<td><br>
			<input type="submit" value="    <%=strBotao%>    " class="botao">
			</td></tr>
			</table>
			</form>	
</td></tr>
</table>
	<table width="95%" align="center" style="border: 1 solid #F2F2F2">
		<tr bgcolor="F5F5F5">
			<td height="20" colspan="3" align="center">
				<b>Tags Especiais</b>
			</td>
		</tr>
		<tr bgcolor="#FAFAFA">
			<td height="20"><b>Tag</b>
			</td>
			<td><b>Como usar</b>
			</td>
			<td><b>Resultado</b>
			</td>
		</tr>
		<tr>
			<td>[nome_cliente]
			</td>
			<td>Olá [nome_cliente], em que posso ajudar?
			</td>
			<td>Olá Maria, em que posso ajudar?
			</td>
		</tr>
		<tr>
			<td>[saudacao_hora]
			</td>
			<td>[saudacao_hora], em que posso ajudá-lo?
			</td>
			<td>Boa Tarde, em que posso ajudá-lo?
			</td>
		</tr>
	</table>
</body>
</html>
