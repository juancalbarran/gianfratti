<%
Public Sub RetonaLista(sSQL, QtdeReg, NomePagina, TipoPagina, EnviarPara)

	DIM ORS 		'RECORD SET
	DIM PATUAL 		'PAGINA ATUAL
	DIM TREG 		'QUANTIDADE DE REGISTROS POR PAGINAS
	DIM CONTADOR 	'CONTA A POSIÇÃO DO REGISTRO NO LOOP
	DIM TPAGINAS	'TOTAL DE PÁGINAS
	
	sStatus = False
	sClass = "Black"
	
	CONTADOR 	= 	0
	PATUAL 		= 	REQUEST("PATUAL")
	TREG		=	int(QtdeReg)	
	
	IF INT(PATUAL) = 0 THEN PATUAL = 1
	
	Set oRs = RetornaSQL(sSQL)
	ORS.PAGESIZE = TREG
	
	If TipoPagina = "Excluir" Then
		ColSpan = oRs.Fields.Count + 3
	Else
		ColSpan = oRs.Fields.Count + 2
	End If

	
	IF NOT oRs.EOF THEN
		ORS.ABSOLUTEPAGE = INT(PATUAL)
		TPAGINAS = ORS.PAGECOUNT
	ELSE
		PATUAL = 0
		TPAGINAS = 0
		TEXTO = "<tr><td align='center' class='BordaCinza' height='20' colspan='" & ColSpan & "'>NÃO FOI ENCONTRADA NENHUM REGISTRO.</td></tr>"
	END IF
	%>
	<form name='frm' action='<%=NomePagina%>' method='post'>
	<input type="hidden" value='<%=PATUAL%>' name="PATUAL">
	<input type="hidden" value='' name='id'>
	
	<div style='display:none; height:15px; width:100%; background:#F5F5F5; text-align:center; font-size: 10px; color: #FF0000;' id='divTd' class='BordaCinza'><%=TipoPagina%> - <%=id%></div>
	
	<table cellspacing='1' cellpadding='0' border='0' width='98%' align='center'>
		<tr>
			<td>
				<table cellspacing='1' cellpadding='0' border='0' width='100%' align='center'>
					<tr>
						<td height='20' width='100%'>
							<table width="100%" border="0" cellpadding="2" cellspacing="0" bgcolor='#F5F5F5' class='BordaCinza'>
								<tr>
									<td width="50%" >&nbsp;Total: <b><% =ORS.RecordCount %></b> - Mostrando página <%=PATUAL%> de <%=TPAGINAS%></td>
									<td width="30%" height="18" align="center" >Ir para página:&nbsp;
									<Select name="NumPagina" class="select" style="height: 14px; font-family: Tahoma; font-size: 9px;" onChange='JavaScript:NavPag(this.value);'>
										<% For i=1 to TPAGINAS %>
										<option value="<% =i %>" <% If i=int(PATUAL) Then %>Selected<% End if %>><% =i %></option>
										<% Next %>
									</select>
									 (<% =PATUAL %> / <% =TPAGINAS %>)
									</td>
									<td width="20%" height="18" align="center" >
										<% if INT(PATUAL) <= 1 then %><img src="/MailMarketing/Shared/img/lista/seta_inicio2.gif" border="0" align="absmiddle"><% else %><img src="/MailMarketing/Shared/img/lista/seta_inicio.gif" srcDown="/MailMarketing/Shared/img/lista/seta_inicio3.gif" border="0" alt="Primeira Página" align="absmiddle" style="cursor:hand;" onClick='JavaScript:NavPag(1);'><% end if %>&nbsp;&nbsp;
										<% if INT(PATUAL) <= 1 then %><img src="/MailMarketing/Shared/img/lista/seta_anterior2.gif" border="0" align="absmiddle"><% else %><img src="/MailMarketing/Shared/img/lista/seta_anterior.gif" srcDown="/MailMarketing/Shared/img/lista/seta_anterior3.gif" border="0" alt="Página Anterior" align="absmiddle" style="cursor:hand;" onClick='JavaScript:NavPag(<%=INT(PATUAL)-1%>);'><% end if %>&nbsp;&nbsp;
										<% if INT(PATUAL) = INT(TPAGINAS) then %><img src="/MailMarketing/Shared/img/lista/seta_proximo2.gif" border="0" align="absmiddle"><% else %><img src="/MailMarketing/Shared/img/lista/seta_proximo.gif" srcDown="/MailMarketing/Shared/img/lista/seta_proximo3.gif" border="0" alt="Próxima Página" align="absmiddle" style="cursor:hand;" onClick='JavaScript:NavPag(<%=INT(PATUAL)+1%>);'><% end if %>&nbsp;&nbsp;
										<% if INT(PATUAL) = INT(TPAGINAS) then %><img src="/MailMarketing/Shared/img/lista/seta_final2.gif" border="0" align="absmiddle"><% else %><img src="/MailMarketing/Shared/img/lista/seta_final.gif" srcDown="/MailMarketing/Shared/img/lista/seta_final3.gif" border="0" alt="Último Registro" align="absmiddle" style="cursor:hand;" onClick='JavaScript:NavPag(<%=TPAGINAS%>);'><% end if %>&nbsp;&nbsp;
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr>
			<td>
				<table cellspacing='1' cellpadding='0' border='0' width='100%' align='center'>	
				<tHead>	
					<tr>
					<%
					If TipoPagina = "Excluir" Then
						%>
						<td width='1%' align='center' class='BordaCinza1' bgcolor="#A1CCE3"><img name='imgCkecked' style='Cursor:hand' src='/MailMarketing/Shared/img/icones/checado.gif' onClick="checkall(frm, frm.chk, 'imgCkecked');" hspace="1" alt="Selecionar Todos"></td>
						<%
					End If
					
					For i = 1 To oRs.Fields.Count - 1
						If (lCase(oRs.Fields(i).name) = "status") Then
							sStatus = True
							Exit For
						End If
					Next
					
					For i = 1 To oRs.Fields.Count - 1
						%>
						<td height='15' valign='middle' align='Left' class='BordaCinza1' bgcolor="#A1CCE3" style='font-family: Verdana;font-size: 10px;font-weight: lighter;'>&nbsp;<%=Ucase(oRs.Fields(i).Name)%>&nbsp;</td>
						<%
					Next
					%>
						<td width='10%' align='center' class='BordaCinza1' bgcolor="#A1CCE3">Opção</td>
					<tr>
					
				</tHead>
				<tBody>
				<%
							
				Do Until oRs.EOF OR CONTADOR >= TREG
					id = oRs.Fields(0).Value
					
					%><!-- #F9F9FD -->
						<tr onMouseOver="this.style.backgroundColor='#E8E8F7';" onMouseOut="this.style.backgroundColor='#FFFFFF';" height='18'>
					<%
						If TipoPagina = "Excluir" Then
						%>
							<td width='1%' align='center' class='BordaCinza' style="padding: 1px">&nbsp;<input type="checkbox" name="chk" id="chk_<%=id%>" value="<%=id%>" class="check">&nbsp;</td>
						<%
						End If
						
						If (sStatus = True) Then
							For i = 1 To oRs.Fields.Count - 1
								If (lCase(oRs.Fields(i).name) = "status") Then
									sClass = CorStatus(oRs.Fields(i).Value)
									Exit For
								End If
							Next
						End If

						For i = 1 To oRs.Fields.Count - 1
							%>
							<td align='Left' nowrap <%If cStr(oRs(0)) = cStr(Request("id")) Then%>bgcolor="#E8E8F7"<%End If%> class='BordaCinza <%=sClass%>' <%If TipoPagina = "Excluir" Then%>onClick="Checar('chk_<%=id%>')"<%End If%>>&nbsp;<%=Trim(oRs.Fields(i).Value)%>&nbsp;</td>
							<%
						Next
							%>
							<td align='center' <%If cStr(oRs(0)) = cStr(Request("id")) Then%>bgcolor="#E8E8F7"<%End If%> class='BordaCinza' style='cursor: hand;' onClick="<%If TipoPagina = "Excluir" Then%>if(confirm('Deseja Realmente excluir este item!'))<%End If%>ManutPag(<%=PATUAL%>,<%=id%>)"><img src="../Shared/img/icones/<%=TipoPagina%>.gif" align="absmiddle" hspace="3" width='12' height='12'><%=TipoPagina%></td>
						</tr>
					<%
					sClass = "BordaCinza"
					CONTADOR = CONTADOR + 1
					oRs.MoveNext
					
				Loop
			
			If isObject(oRs) Then
				oRs.Close
				Set oRs = Nothing
			End If
				
				Response.Write(Texto)
			%>
				</tBody>
				</table>
			</td>
		</tr>
		<%If TipoPagina = "Excluir" Then%>
		<tr><td><input type="button" value="Excluir Selecionados" name="ExcluirSelecionados" class="buttom" onClick="delSelecionados(frm)"></td></tr>
		<%End If%>
	</table>
	</form>
	<script language="JavaScript" type="text/javascript">
		function NavPag(pag){
			document.frm.PATUAL.value=pag;
			document.frm.submit();
		}
		
		function ManutPag(pag,Id){
			document.frm.PATUAL.value=pag;
			document.frm.id.value=Id;
			document.frm.action='<%=EnviarPara%>'+'&Id='+Id;
			document.frm.submit();
		}
		
		<%If TipoPagina = "Excluir" Then %>
			
			var todos = true
			
			function delSelecionados(oFrm){
				var aux = false
				for (var i = 0; i<oFrm.length; i++)	{
					if (oFrm.elements[i].name == 'chk'){
						if (oFrm.elements[i].checked == true){
							aux = true
							break
						}
					}
				}
				
				if (aux == true){
					if(confirm('Deseja Realmente excluir o(s) iten(s) selecionado(s)?')){
						ManutPag(<%=PATUAL%>,'')
					}
				}else{alert('Selecione ao menos um para excluir!')}
			}
		<%End If%>
	</script>
<%	
End Sub
%>