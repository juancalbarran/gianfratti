<%Session("gravado")=0%>
<form name='frm' action="../Grupos/p_Grupos.asp?opcao=5&acao=1" method="post">
<table cellpadding='0' cellspacing='0' width='98%' border='0'>
	<tr>
		<td valign='top' align='center'>
			<!-- TABELA CADASTRO -->
			<fieldset>
			<legend class="font10Vinho">&nbsp;SELECIONE UM GRUPO&nbsp;</legend>
			<table align='center' cellpadding='0' cellspacing='2' width='100%' border='0'>
				<tr>
					<td align='right' valign='top' width='15%'>Nome do Grupo:</td>
					<td><%=fnCarregaCombo("GRUPO_CD", "GRUPO_CD", "GRUPO_NM", "GRUPOS", "", "", Request("GRUPO_CD"), 300, "yes", "Selecione um Grupo", "onChange=""document.frm.submit();""")%></td>
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
	
	<%Mensagem = Request("mensagem")%>
	<%If Mensagem <> "" Then%>
	<tr>
		<td class="Font10Vermelho" height="7" align="center"><%=Mensagem%></td>
	</tr>
	<%End If%>
	<%GRUPO_CD = Request("GRUPO_CD")%>
	<%If GRUPO_CD <> "" Then%>
	<tr>
		<td width="100%">
			<!-- #include file="i_lista_de_contatos.asp" -->
		</td>
	</tr>
	<%Else%>
		<tr><td align="center" class="Font10Vermelho">Selecione um Grupo</td></tr>
	<%End If%>

	<tr>
		<td height='10'>&nbsp;</td>
	</tr>	
	<tr>
		<td valign='top' align='right'><input class='buttom' type="button" value="Gravar Dados" onClick="ValidaForm(frm)"></td>
	</tr>
	<tr>
		<td height='10'>&nbsp;</td>
	</tr>	
</table>
<input type="hidden" value='<%=Lista%>' name='Lista'>
</form>
