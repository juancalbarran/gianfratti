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
</script>
<script>
var todos = true
</script>
<form  onSubmit="return fnMarcaRequeridos(this);" name='frm' method='post' action='../Eventos/p_Eventos.asp?opcao=<% =opcao %>&acao=<%=acao%>'>
<input type='hidden' name='Evento_CD' value='<%=Evento_CD%>'>

<table cellpadding='0' cellspacing='0' width='98%' border='0'>
	<tr>
		<td valign='top' align='center'>
			<!-- TABELA CADASTRO -->
			<fieldset>
			
        <table align='center' cellpadding='0' cellspacing='2' width='100%' border='0'>
          <tr> 
            <td height='20' class='Font10Vermelho' style="padding-left:20px;">Campos sinalizados com (*) tem seu preenchimento obrigatório.</td>
          </tr>
          <tr> 
            <td  style="padding-left:20px;">Nome do Evento (Assunto):<br><input type='text' name='Evento_NM' value="<%=Server.HTMLEncode(Evento_NM)%>" maxlength='50' class='input' style='width:350px' required='yes' Error='Preencha corretamente o campo "Assunto do Evento"!'></td>
          </tr>
		  <tr> 
            <td  style="padding-left:20px;">Selecione o Remetente:<br><%=fnCarregaCombo("Remetente_CD", "Remetente_CD", "Remetente_NM", "Remetentes", "", "", Remetente_CD, 350, "yes", "Selecione um Remetente", "")%></td>
          </tr>

		  <tr> 
            <td height='10'>&nbsp;</td>
          </tr>
			<tr>
				<td align='center' valign='top' colspan="2" style="padding: 0px 20px 0px 20px">
				
					<table cellpadding="1" cellspacing="1" border="0" width="100%" style="border: 1px solid #2A7BA7; BackGround-Color:#F9F9FD;">
						<tr>
							<td style="width:4%; text-align:left; padding-left: 8px"><img name='ImgCheckHall' style='Cursor:hand' src='../Shared/img/icones/checado.gif' onClick="checkall(document.frm, frm.Grupo_CD, 'ImgCheckHall');" hspace="1" alt="Selecionar Todos"></td>
							<td style="Color:#2A7BA7; Font-Weight:Bold; text-align:left;">SELECIONE OS GRUPOS:</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align='center' valign='top' colspan="2" style="padding: 0px 20px 0px 20px">
					<div style="overflow:Auto; height:125px; width:100%px;">
					<table cellpadding="1" cellspacing="1" border="0" width="100%">
						<%
						iGrupos = Split(Grupos, ",")
						
						sSQL = "Select Grupo_CD, Grupo_NM from Grupos where deletado=0 Order By Grupo_NM"
						Set oRs = RetornaSQL(sSQL)
						Do Until oRs.Eof
							%>
							<tr onMouseOver="this.style.backgroundColor='#E8E8F7';" onMouseOut="this.style.backgroundColor='#FFFFFF';" height="18">
								<td style="border: 1px solid #CCCCCC; width:4%; text-align:center">
									<input type="checkbox" 
									<%
									For x = 0 to Ubound(iGrupos)				
										If cStr(iGrupos(x)) = cStr(oRs.Fields("Grupo_CD")) Then
											Response.Write " Checked "
										End if											
									Next
									%>
									value="<%=oRs.Fields("Grupo_CD")%>" name="Grupo_CD" id="chk_<%=oRs.Fields("Grupo_CD")%>">
								</td>
								<td style="border: 1px solid #CCCCCC; width:96%; cursor:hand;" onClick="Checar('chk_<%=oRs.Fields("Grupo_CD")%>')">&nbsp;<%=oRs.Fields("Grupo_NM")%></td>
							</tr>
							<%
							oRs.MoveNext
						Loop
						
						Set oRs = Nothing
						%>
					</table>
					</div>
				</td>
			</tr>
			<tr>
				<td height='10'>&nbsp;</td>
			</tr>	

          <tr> 
            <td  style="padding-left:20px; padding-right:20px">E-mail do Evento:<br><textarea name='Evento_Texto' class='input' style='width:90%; height:400px' required='no' Error='Preencha corretamente o campo "E-mail do Contato"!'><%=Evento_Texto%></textarea></td>
          </tr>
          <tr> 
            <td height='10'>&nbsp;</td>
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
<script language="javascript1.2">
	editor_generate('Evento_Texto');
</script>