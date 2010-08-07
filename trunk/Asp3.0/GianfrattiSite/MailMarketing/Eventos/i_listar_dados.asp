<%
Session("Gravado") = 0
If opcao=1 then
	opcao=1
	acao=2
Elseif opcao=2 Then
	opcao=2
	acao=3
End if
%>
<script language="JavaScript">
	function Disparar_eMail(){
		if (confirm('Deseja realmente disparar o evento <%=Evento_NM%>?')){
			
			document.getElementById('01').style.display='none'
			
			document.getElementById('02').style.display='block'
			
			document.getElementById('Alerta').style.display='block'

			document.getElementById('table1').height = (document.getElementById('table1').scrollHeight - 20)

			window.open('i_enviar_eMail_PassoA.asp?Evento_CD=<%=Evento_CD%>','i_Enviar_eMail')
			
		}
	}
</script>
<%
sSQL = "Exec vTotal_Email_A_Enviar " & cDbl(Evento_CD) 
Set rs = RetornaSQL(sSQL)
Email_A_Enviar = rs("Email_A_Enviar")

Set rs = Nothing
%>
<iframe frameborder="0" name="i_Enviar_eMail" width="0" height="0" scrolling="no"></iframe>
<div id="01">
<table cellpadding="0" cellspacing="0" width="98%" border="0">
	<tr>
		<td valign="top">
			<fieldset>
			<legend> &nbsp;DADOS DO EVENTO&nbsp;</legend>
			<table cellpadding="2" cellspacing="2" width="550" border="0">
				<tr>
					<td align="right" colspan="2">
						<input type="button" value="<%If Enviou = 0 Then %>Disparar E-mail<%Else%>Reenviar E-mail<%End If%>" onClick="Disparar_eMail()" class="buttom" <%If Email_A_Enviar = "0" Then%> disabled <%End If%>>
					</td>
				</tr>
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
				sSQL = "Select Remetente_NM, Remetente_eMail From Remetentes Where Remetente_CD = " & Remetente_CD 
				Set rs = RetornaSQL(sSQL)
				If not rs.Eof Then Remetente_NM = rs("Remetente_NM") : Remetente_eMail = rs("Remetente_eMail")
				%>
				<tr> 
					<td align="right">Remetente/E-mail do Evento:</td>
					<td><b><% =Remetente_NM %>&nbsp;-&nbsp;<% =Remetente_eMail %></b></td>
				</tr>
				
				<tr> 
					<td align="right">E-mails a serem enviados:</td>
					<td><b><% =Email_A_Enviar %></b></td>
				</tr>
				<tr>
					<td height="10">&nbsp;</td>
				</tr>

				<tr> 
					<td align="right" valign="top">Grupos:</td>
					<td>
						<%
						sSQL = "SELECT Grupos.Grupo_NM FROM Grupos INNER JOIN (Eventos INNER JOIN Eventos_Grupos ON Eventos.Evento_CD = Eventos_Grupos.Evento_CD) ON Grupos.Grupo_CD = Eventos_Grupos.Grupo_CD WHERE Eventos.Evento_CD = " & Evento_CD
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
					<td height="10">&nbsp;</td>
				</tr>

				<tr>
					<td style="padding: 0px 20px 0px 20px;" colspan="2"><%=Evento_Texto%></td>
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
</div>

<div id="02" style="display:none">
<table width="100%" height="100%" border="0">
	<tr>
		<td align="center" valign="middle">
			AGUARDE ENVIANDO E-MAIL ...<br><br>
			<img src="../shared/img/loading.gif">
			<BR><BR>ENVIADOS: <span id="04">0</span> de <% =Email_A_Enviar %>
		</td>
	</tr>
</table>
</div>

<div id="03" style="display:none">
<table width="100%" height="100%" border="0">
	<tr>
		<td align="center" valign="middle">
			EVENTO DISPARADO COM SUCESSO
			<BR><BR>EMAILS ENVIADOS: <span id="05">0</span> de <% =Email_A_Enviar %>
		</td>
	</tr>
</table>
</div>