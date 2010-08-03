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
			<legend> &nbsp;DADOS DO CONTATO&nbsp;</legend>
			<table cellpadding="2" cellspacing="2" width="550" border="0">
				<tr> 
					<td colspan="2"><img src="../Shared/img/spacer.gif" width="1" height="10"></td>
				</tr>
				<tr> 
					<td align="right">Código do Contato:</td>
					<td width="70%"><b><% =Contato_CD %></b></td>
				</tr>
				<tr> 
					<td align="right">Nome do Contato:</td>
					<td><b><% =Contato_NM %></b></td>
				</tr>
				<tr> 
					<td align="right">E-mail do Contato:</td>
					<td><b><% =Contato_eMail %></b></td>
				</tr>
				<tr>
					<td height="10">&nbsp;</td>
				</tr>

				<tr> 
					<td align="right" valign="top">Grupos:</td>
					<td>
						<%
						sSQL = "Select Grupo_NM from Grupos inner join Grupos_Contatos on(Grupos_Contatos.Grupo_CD = Grupos.Grupo_CD) Where Contato_CD = " & Contato_CD & " Order By Grupo_NM"
						Set oRs = RetornaSQL(sSQL)
						Do Until oRs.Eof
						
							Response.Write "<b>" & oRs.Fields("Grupo_NM") & "</b><br>"
							
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