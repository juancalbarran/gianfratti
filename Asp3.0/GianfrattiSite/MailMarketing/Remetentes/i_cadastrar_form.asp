<%
Session("gravado")=0
If opcao=1 then
	opcao=1
	acao=2
Elseif opcao=2 Then
	opcao=2
	acao=3
End if
%>
<script	language='javascript' for='window' event='onLoad'>
	ConfigurarCampos(frm)
	 
	fnMarcaRequeridosOnLoad(frm)
	
	document.frm.Remetente_NM.focus()
</script>
<form  onSubmit="return fnMarcaRequeridos(this);" name='frm' method='post' action='../Remetentes/p_remetentes.asp?opcao=<% =opcao %>&acao=<%=acao%>'>
<input type='hidden' name='Remetente_CD' value='<%=Remetente_CD%>'>
<table cellpadding='0' cellspacing='0' width='98%' border='0'>
	<tr>
		<td valign='top' align='center'>
			<!-- TABELA CADASTRO -->
			<fieldset>
			<table align='center' cellpadding='0' cellspacing='2' width='100%' border='0'>
				<tr>
					<td height='20' class='Font10Vermelho' colspan='2'>&nbsp;&nbsp;&nbsp;Campos sinalizados com (*) tem seu preenchimento obrigatório.</td>
				</tr>
				<tr>
					<td align='right' valign='top' width='15%'>Nome do Remetente:</td>
					<td><input type='text' size='50' name='Remetente_NM' value="<%=Server.HTMLEncode(Remetente_NM)%>" maxlength='50' class='input' style='width:250px' required='yes' Error='Preencha corretamente o campo "Nome do Remetente"!'></td>
				</tr>
				<tr>
					<td align='right' valign='top' width='15%'>E-mail do Remetente:</td>
					<td><input type='text' size='50' name='Remetente_eMail' value="<%=Server.HTMLEncode(Remetente_eMail)%>" maxlength='50' class='input' style='width:250px' required='yes' Error='Preencha corretamente o campo "E-mail do Remetente"!'></td>
				</tr>
				<tr>
					<td align='right' valign='top' width='15%'>SMTP do Remetente:</td>
					<td><input type='text' size='50' name='Remetente_SMTP' value="<%=Server.HTMLEncode(Remetente_SMTP)%>" maxlength='50' class='input' style='width:250px' required='yes' Error='Preencha corretamente o campo "SMTP do Remetente"!'></td>
				</tr>
				<tr>
					<td height='10' colspan='2'>&nbsp;</td>
				</tr>
			</table>
			</fieldset>
			<!-- FIM DA TABELA -->
		</td>
	</tr>
	<tr>
		<td height='10'>&nbsp;</td>
	</tr>	
	<tr>
		<td valign='top' align='right'><input class='buttom' type="submit" value="Gravar Dados"></td>
	</tr>	
</table>
</form>
