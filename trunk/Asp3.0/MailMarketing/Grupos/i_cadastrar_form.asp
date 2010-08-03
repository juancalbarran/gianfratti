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
	
	document.frm.Grupo_NM.focus()
</script>
<form  onSubmit="return fnMarcaRequeridos(this);" name='frm' method='post' action='../Grupos/p_Grupos.asp?opcao=<% =opcao %>&acao=<%=acao%>'>
<input type='hidden' name='Grupo_CD' value='<%=Grupo_CD%>'>
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
					<td align='right' valign='top' width='15%'>Nome do Grupo:</td>
					<td><input type='text' size='50' name='Grupo_NM' value="<%=Server.HTMLEncode(Grupo_NM)%>" maxlength='25' class='input' style='width:250px' required='yes' Error='Preencha corretamente o campo "Nome do Grupo"!'></td>
				</tr>
				<tr>
					<td align='right' valign='top' width='15%'>Descrição:</td>
					<td><input type='text' size='50' name='Grupo_Descricao' value="<%=Server.HTMLEncode(Grupo_Descricao)%>" maxlength='100' class='input' style='width:350px' required='yes' Error='Preencha corretamente o campo "Descrição"!'></td>
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
