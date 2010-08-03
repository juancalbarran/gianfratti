<%
	Dim Lista 		:	Lista 			=  	request("Lista") 

	DIM ORS 		'RECORD SET
	DIM PATUAL 		'PAGINA ATUAL
	DIM TREG 		'QUANTIDADE DE REGISTROS POR PAGINAS
	DIM CONTADOR 	'CONTA A POSIÇÃO DO REGISTRO NO LOOP
	DIM TPAGINAS	'TOTAL DE PÁGINAS
	
	CONTADOR 	= 	0
	PATUAL 		= 	REQUEST("PATUAL")
	TREG		=	50	
	
	IF INT(PATUAL) = 0 THEN PATUAL = 1
	
	sSQL = " Exec vConsulta_Contatos_Grupos " & GRUPO_CD


	Set oRs = RetornaSQL(sSQL)
	ORS.PAGESIZE = TREG
	
	IF NOT oRs.EOF THEN
		ORS.ABSOLUTEPAGE = INT(PATUAL)
		TPAGINAS = ORS.PAGECOUNT
	ELSE
		PATUAL = 0
		TPAGINAS = 0
		TEXTO = "<tr><td align='center' class='BordaCinza' height='20' colspan='3'>NÃO FOI ENCONTRADA NENHUM REGISTRO.</td></tr>"
	END IF
	%>

	
	<input type="hidden" value='<%=PATUAL%>' name="PATUAL">
	<input type="hidden" value='' name='id'>
	
	<div style='display:none; height:15px; width:100%; background:#F5F5F5; text-align:center; font-size: 10px; color: #FF0000;' id='divTd' class='BordaCinza'><%=TipoPagina%> - <%=id%></div>
	
	<table cellspacing='1' cellpadding='0' border='0' width='100%' align='center'>
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
						<td width='1%' align='center' class='BordaCinza1' bgcolor="#A1CCE3"><img name='imgCkecked' style='Cursor:hand' src='/MailMarketing/Shared/img/icones/checado.gif' onClick="checkall(frm, frm.chk, 'imgCkecked');" hspace="1" alt="Selecionar Todos"></td>
						<td height='15' width="15%" valign='middle' align='Left' class='BordaCinza1' bgcolor="#A1CCE3" style='font-family: Verdana;font-size: 10px;font-weight: lighter; text-transform:uppercase'>&nbsp;NOME DO CONTATO&nbsp;</td>
						<td height='15' valign='middle' align='Left' class='BordaCinza1' bgcolor="#A1CCE3" style='font-family: Verdana;font-size: 10px;font-weight: lighter; text-transform:uppercase'>&nbsp;E-MAIL DO CONTATO&nbsp;</td>
					<tr>
					
				</tHead>
				<tBody>
				<%
							
				Do Until oRs.EOF OR CONTADOR >= TREG
					id = oRs.Fields("CONTATO_CD")
					
					%>
						<tr onMouseOver="this.style.backgroundColor='#E8E8F7';" onMouseOut="this.style.backgroundColor='#FFFFFF';" height='18'>
							<td width='1%' align='center' class='BordaCinza' style="padding: 1px">&nbsp;
								<input type="checkbox" name="chk" id="chk_<%=id%>" value="<%=id%>" class="check"
								<%
								iNumero = split(Lista,",")

								For i = 0 To Ubound(iNumero)
									
									If  Trim(iNumero(i)) = "" or iNumero(i) = null Then  iNumero(i) = 0
										
									If int(ORS("CONTATO_CD")) = int(iNumero(i)) Then 
										Response.Write("checked") 
										Exit for
									End if 
									
								Next
								%> >&nbsp;
							</td>
							<td class='BordaCinza' onClick="Checar('chk_<%=id%>')">&nbsp;<%=Trim(oRs.Fields("CONTATO_NM"))%>&nbsp;</td>
							<td class='BordaCinza' onClick="Checar('chk_<%=id%>')">&nbsp;<%=Trim(oRs.Fields("CONTATO_EMAIL"))%>&nbsp;</td>
						</tr>
					<%
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

	</table>
	
	<script language="JavaScript" type="text/javascript">

		var todos = true
		
		function ValidaForm(oFrm){
			
			if (oFrm.GRUPO_CD.value != ''){
				
				var aux = false
				for (var i = 0; i<oFrm.length; i++)	{
					if (oFrm.elements[i].name == 'chk'){
						if (oFrm.elements[i].checked == true){
							aux = true
							break
						}
					}
				}
				
				if (aux != true){
					
					if (oFrm.Lista.value != ''){
					
						document.frm.method='post'
						document.frm.action='../Grupos/p_Grupos.asp?opcao=5&acao=2'
						document.frm.submit()
						//return (true)
						
					
					}else{
						alert('Selecione ao menos um contato para addicionar ao grupo!')
						//return (false)
					}
				}else{
				
					document.frm.method='post'
					document.frm.action='../Grupos/p_Grupos.asp?opcao=5&acao=2'
					document.frm.submit()
					//return (true)

				}
				
			}else{
				alert('Selecione um grupo!')
				oFrm.GRUPO_CD.focus();
				//return (false)
			}
		}
		
		
	
		function comparar(a, b){
			return a - b;
		}
		
		function NavPag(pag){
			
			oBj = document.frm.chk
			xaux = false;
			iaux = document.frm.Lista.value.split(",");
		
			if (iaux != ""){
				for ( i = 0; i < oBj.length; i++ ){
					if (oBj[i].checked ){
						for (y = 0; y < iaux.length; y++){
							if (oBj[i].value == iaux[y]){
								xaux = true;
								break;
							}
						}
						if(xaux == false){
							iaux.push(oBj[i].value);
						}
					}else{
						for (y = 0; y < iaux.length; y++){
							if (oBj[i].value == iaux[y]){
								iaux.splice(y,1)
								break;
							}
						}
					}
				xaux = false;
				}
			}else{
				for ( i = 0; i < oBj.length; i++ ){
					if (oBj[i].checked ){
						iaux.push(oBj[i].value);
					}
				}
			}
			iaux.sort(comparar); 
			document.frm.Lista.value=iaux
			document.frm.PATUAL.value=pag
			
			document.frm.method='post'
			document.frm.action='../Grupos/p_Grupos.asp?opcao=5&acao=1'
			document.frm.submit()
		}

	</script>
