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
	
	document.frm.Contato_NM.focus()
</script>
<script language="JavaScript" type="text/javascript">
	var todos = true
</script>
<form  onSubmit="return fnMarcaRequeridos(this);" name='frm' method='post' action='../Contatos/p_Contatos.asp?opcao=<% =opcao %>&acao=<%=acao%>'>
<input type='hidden' name='Contato_CD' value='<%=Contato_CD%>'>

<table cellpadding='0' cellspacing='0' width='98%' border='0'>
	<tr>
		<td valign='top' align='center'>
			<!-- TABELA CADASTRO -->
			<fieldset>
			
        <table align='center' cellpadding='0' cellspacing='2' width='100%' border='0'>
          <tr> 
            <td height='20' class='Font10Vermelho' colspan='2'>&nbsp;&nbsp;&nbsp;Campos 
              sinalizados com (*) tem seu preenchimento obrigatório.</td>
          </tr>
          <tr> 
            <td align='right' valign='top' width='15%'>Nome do Contato:</td>
            <td><input type='text' name='Contato_NM' value="<%If Contato_NM <> "" Then Response.write Server.HTMLEncode(Contato_NM)%>" maxlength='50' class='input' style='width:350px' required='no' Error='Preencha corretamente o campo "Nome do Contato"!'></td>
          </tr>
          <tr> 
            <td align='right' valign='top' width='15%'>E-mail do Contato:</td>
            <td><input name='Contato_eMail' type='text' class='input' style='width:350px' value="<%=Server.HTMLEncode(Contato_eMail)%>" maxlength='50' tipo="" required='yes' Error='Preencha corretamente o campo "E-mail do Contato"!'></td>
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
		<td height='10' colspan='2'>&nbsp;</td>
	</tr>
	<tr>
		<td align='center' valign='top' colspan="2" style="padding: 0px 0px 0px 0px">
		
			<table cellpadding="1" cellspacing="1" border="0" width="100%" style="border: 1px solid #2A7BA7; BackGround-Color:#F9F9FD;">
				<tr>
					<td style="width:5%; text-align:left; padding-left: 8px"><img name='ImgCheckHall' style='Cursor:hand' src='../Shared/img/icones/checado.gif' onClick="checkall(document.frm, frm.Grupo_CD, 'ImgCheckHall');" hspace="1" alt="Selecionar Todos"></td>
					<td style="Color:#2A7BA7; Font-Weight:Bold; text-align:center;">GRUPOS:</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align='center' valign='top' colspan="2" style="padding: 0px 0px 0px 0px">
			<div style="overflow:Auto; height:150px; width:100%px;">
			<table cellpadding="1" cellspacing="1" border="0" width="100%">
				<%
				iGrupos = Split(Grupos, ",")
				
				sSQL = "Select Grupo_CD, Grupo_NM from Grupos Where Deletado=0 Order By Grupo_NM"
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
		<td valign='top' align='right'><input class='buttom' type="submit" value="Gravar Dados"></td>
	</tr>	
</table>
</form>
