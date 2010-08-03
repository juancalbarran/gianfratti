<%
Evento_CD = Request("Evento_CD")

If Evento_CD <> "" Then

	sSql = " SELECT Top 1 * FROM  Eventos Where Evento_CD = " & Evento_CD
	
	Set oRs = RetornaSQL(sSQL)
	If Not oRs.Eof Then
		Evento_CD			= oRs("Evento_CD")
		Evento_NM			= oRs("Evento_NM")
		Remetente_CD		= oRs("Remetente_CD")
	End If
	
End If
%>
<table cellpadding="0" cellspacing="0" width="98%" border="0">
	<tr>
		<td>
			<form name="frm" action="p_relatorios.asp" method="post">
			<fieldset>
			<legend> &nbsp;PESQUISAR EVENTO&nbsp;</legend>
			<table cellpadding="0" cellspacing="2" border="0" width="100%">
				<tr>
					<td><img src="../Shared/img/spacer.gif" width="1" height="5"></td>
				</tr>
				<tr>
					<td style="padding-left:30px;">Selecione um evento na lista ao abaixo:</td>
				</tr>
				<tr>
					<td style="padding-left:30px;" rowspan=""><%=fnCarregaCombo("Evento_CD", "Evento_CD", "Evento_NM", "Eventos", "", "", Evento_CD, 500, "no", "Selecione um Evento", "onChange=""document.frm.submit();""")%></td>
				</tr>
				<tr>
					<td><img src="../Shared/img/spacer.gif" width="1" height="5"></td>
				</tr>
			</table>
			</fieldset>	
			</form>
		</td>
	</tr>
	
	<tr>
		<td height="10">&nbsp;</td>
	</tr>

	<tr>
		<td valign="top">
			<fieldset>
			<legend> &nbsp;DADOS DO EVENTO&nbsp;</legend>
			<table cellpadding="2" cellspacing="2" width="550" border="0">
				<tr> 
					<td colspan="2"><img src="../Shared/img/spacer.gif" width="1" height="10"></td>
				</tr>
				<tr> 
					<td align="right">Código do Evento:</td>
					<td width="70%"><b><% =Evento_CD %></b></td>
				</tr>
				<tr> 
					<td align="right">Nome do Evento (Assunto):</td>
					<td><b><% =Evento_NM %></b></td>
				</tr>
				<%
				If Evento_CD <> "" Then
					sSQL = "SELECT Count(1) as Email_Enviados FROM eMails_Enviados where Evento_CD= " & cDbl(Evento_CD) 
					Set rs = RetornaSQL(sSQL)
					Email_Enviados = rs("Email_Enviados")
				End If	
				%>
				<tr> 
					<td align="right">Total de Email Enviados:</td>
					<td><b><% =Email_Enviados %></b></td>
				</tr>
				<tr>
					<td height="10">&nbsp;</td>
				</tr>

				<tr> 
					<td align="right" valign="top">Grupos:</td>
					<td>
					<%
					If Evento_CD <> "" Then
						sSQL = "SELECT Grupos.Grupo_NM FROM Grupos INNER JOIN (Eventos INNER JOIN Eventos_Grupos ON Eventos.Evento_CD = Eventos_Grupos.Evento_CD) ON Grupos.Grupo_CD = Eventos_Grupos.Grupo_CD WHERE Eventos.Evento_CD = " & Evento_CD
						Set oRs = RetornaSQL(sSQL)
						Do Until oRs.Eof
						
							Response.Write "<b>" & oRs.Fields("Grupo_NM") & "</b><br>"
							
							oRs.MoveNext
						Loop
					End If
					%>
					</td>
				</tr>

				<tr>
					<td height="10">&nbsp;</td>
				</tr>

			</table>
			</fieldset>
		</td>
	</tr>

	<tr>
		<td height="10">&nbsp;</td>
	</tr>
</table>
<%
If isObject(oRs) Then
	Set oRs = Nothing
End If
%>