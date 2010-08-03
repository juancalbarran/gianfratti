<%
If opcao=1 then
	opcao=1
	acao=2
Elseif opcao=2 Then
	opcao=2
	acao=3
End if
%>
<table id="Cliente" cellpadding="0" cellspacing="0" width="98%" border="0">
	<tr>
		<td valign="top">

			<fieldset>
			<legend> &nbsp;DADOS DO GRUPO&nbsp;</legend>
			<table cellpadding="2" cellspacing="2" width="550" border="0">
				<tr>
					<td colspan="2"><img src="../Shared/img/spacer.gif" width="1" height="10"></td>
				</tr>
				<tr>
					<td align="right">Código do Grupo:</td>
					<td width="70%"><b><% =GRUPO_CD %></b></td>
				</tr>
				<tr>
					<td align="right">Nome do Grupo:</td>
					<td><b><% =Grupo_NM %></b></td>
				</tr>
				<tr>
					<td align="right">Descrição do Grupo:</td>
					<td><b><% =Grupo_Descricao %></b></td>
				</tr>
				<tr>
					<td colspan="2" height="10">&nbsp;</td>
				</tr>
				
				<tr> 
					<td align="right" valign="top">Contatos:</td>
					<td>
						<%
						sSQL = "Select Contato_eMail from Contatos inner join Grupos_Contatos on(Grupos_Contatos.Contato_CD = Contatos.Contato_CD) Where Contatos.deletado = 0 And Grupo_CD = " & Grupo_CD & " Order By Contato_eMail"
						Set oRs = RetornaSQL(sSQL)
						Do Until oRs.Eof
						
							Response.Write "<b>" & oRs.Fields("Contato_eMail") & "</b><br>"
							
							oRs.MoveNext
						Loop
						
						Set oRs = Nothing
						%>
					</td>
				</tr>
				<tr>
					<td colspan="2" height="10">&nbsp;</td>
				</tr>
			</table>
			</fieldset>

		</td>
	</tr>
	<tr>
		<td height="10">&nbsp;</td>
	</tr>
</table>