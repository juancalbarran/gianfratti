<br><br>
<TABLE cellSpacing=1 cellPadding=0 width="98%" border=0>
              <TBODY>
              <TR>
                <TD vAlign=top width="47%">
				
                  <TABLE cellSpacing=0 cellPadding=5 width="100%" border=0>
                    <TBODY>
                    <TR>
                      <TD 
                      style="BORDER-RIGHT: #bbbaba 1px solid; BORDER-TOP: #bbbaba 1px solid; BACKGROUND: #ebefef; BORDER-LEFT: #bbbaba 1px solid; BORDER-BOTTOM: #bbbaba 1px solid; HEIGHT: 24px" 
                      noWrap colSpan=3><B>&nbsp; <%= strLg274 %></B></TD></TR>
					  
<%
				if VersaoDb = 1 then
				set rs = abredb.execute("SELECT idprod, nome, impeq, preco FROM produtos ORDER BY contador DESC LIMIT 0,3")
				else
				set rs = abredb.execute("SELECT TOP 3 idprod, nome, impeq, preco FROM produtos ORDER BY contador DESC")
				end if
				cont = 1
				if not rs.eof then
				  for x = 1 to 3%>
				  					  
                    <TR>
                      <TD width="3%" align=right vAlign=center><IMG height=8 
                        src="<%= dirlingua %>/imagens/arrow_5x8.gif" width=5 
                        border=0></TD>
                      <TD width="11%"><b><a href="produtos.asp?produto=<%=rs("idprod")%>"  onmouseout="window.status='';return true;" onmouseover="window.status='+ Detalhes';return true;" style="text-decoration: none;">
                        <input name="image" type="image" onmouseover="window.status='<%=srtLg161%>';return true;" onmouseout="window.status='';return true;" src="produtos/<%=rs("impeq")%>" align="bottom" />
                      </a></b></TD>
                      <TD width="86%"><B><a href="produtos.asp?produto=<%=rs("idprod")%>"  onmouseout="window.status='';return true;" onmouseover="window.status='+ Detalhes';return true;" style="text-decoration: none;"><%=rs("nome")%></a><br />
                      <%= strlgMoeda & " " & formatnumber(rs("preco"),2)%></B></TD>
                    </TR>

							  <%cont = cont + 1%>
				              <%rs.movenext%>
				  <%next%>
				<%end if%>
				</TBODY></TABLE></TD>
               
			    <TD width="5%" align=middle vAlign=top><IMG height=250 
                  src="<%= dirlingua %>/imagens/dot_gray_1x1.gif" width=1 
                  border=0></TD>
               
			    <TD vAlign=top width="48%">
				
				<form method=post action="javascript: cadmail()" name=emailx>
				
                  <TABLE cellSpacing=0 cellPadding=5 width="100%" border=0>
                    <TBODY>
                    <TR>
                      <TD 
                      style="BORDER-RIGHT: #bbbaba 1px solid; BORDER-TOP: #bbbaba 1px solid; BACKGROUND: #ebefef; BORDER-LEFT: #bbbaba 1px solid; BORDER-BOTTOM: #bbbaba 1px solid; HEIGHT: 24px" 
                      noWrap colSpan=2><B>&nbsp; <%= strLg158 %></B></TD></TR>
                    <TR>
                      <TD vAlign=center align=right>&nbsp;</TD>
                      <TD>&nbsp;</TD></TR>
                    <TR>
                      <TD vAlign=center align=right></TD>
                      <TD><%= strLg159 %></TD></TR>
                    <TR>
                      <TD vAlign=center align=right><IMG height=8 
                        src="<%= dirlingua %>/imagens/arrow_5x8.gif" width=5 
                        border=0></TD>
                      <TD><input type=text size=30 value="<%=strLg160%>" style="font-size:11px;font-family:tahoma,verdana,arial,helvetica;color: Blue;" name=email onfocus="limpa();"></TD></TR>
                    <TR>
                      <TD vAlign=top align=right></TD>
                      <TD><select name='tipo' size='1' style="font-size:11px;font-family:tahoma,verdana,arial,helvetica;">
<option value='1' selected ><%=strLg267%></option>
<option value='0' ><%=strLg266%></option>
</select></TD></TR>
                    <TR>
                      <TD vAlign=center align=right>&nbsp;</TD>
                      <TD align=left><input type=image src="<%= dirlingua %>/imagens/cadastro.gif" onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=srtLg161%>';return true;"></TD></TR>
                   </TBODY></TABLE>
			      </form>				   </TD>
                </TR>
              <TR>
                <TD colspan="3" vAlign=top>&nbsp;</TD>
                </TR>
              <TR>
                <TD colspan="3" vAlign=top><div align="center"><img src="<%=dirlingua%>/imagens/compre_televendas.gif" /></div></TD>
              </TR>
              </TBODY></TABLE>
