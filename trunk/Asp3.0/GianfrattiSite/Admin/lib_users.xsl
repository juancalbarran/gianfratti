<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" >
<xsl:output method="html"/> 

<!-- Webpages Template : add/update/modify -->
<!-- Create: 2001/10/26, by J.Roland -->
<!-- Last modified: 2003/08/14, by Jens Schreiber (JeS) -->
<!-- version 2.0 -->

	<xsl:template name="user_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">User Manager</xsl:with-param>
			<xsl:with-param name="version">2.0</xsl:with-param>
			<xsl:with-param name="moddate">14.08.2003</xsl:with-param>
			<xsl:with-param name="author">John Roland, Mig100 (Miguel Figueira) and JeS (Jens Schreiber)</xsl:with-param>
			<xsl:with-param name="url"><a href="http://www.fxmods.com">http://www.fxmods.com</a></xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="PseudoField">
		<xsl:param name="value"/>		
		<xsl:choose>
			<xsl:when test="document($datafile)/siteinfo/data/pseudouppercase='on'">
				<script language="JavaScript">
					function setUpperCaseAdm() 
						{ 
							var text = document.frmFullxml.pseudo.value; 
							document.frmFullxml.pseudo.value = text.toUpperCase(); 
						}
				</script>
				<input type="text" name="pseudo" class="full" value="{$value}" onChange="setUpperCaseAdm()"/>
			</xsl:when>
			<xsl:otherwise>
				<input type="text" name="pseudo" class="full" value="{$value}"/>
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>

	<xsl:template name="member_manager">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M8"><img src="admin/media/users.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[130]"/></font></td></tr>
		</table>
		<xsl:choose>
			<xsl:when test="$id=''">
				<xsl:call-template name="member_list"/>
			</xsl:when>
			<xsl:when test="$id='new'">
				<xsl:call-template name="member_add"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="document($memberfile)//members/member[id=$id]">
					<xsl:call-template name="member_update"/>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<!-- member grid -->
	<xsl:template name="member_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr align="center">
				<td class="header" width="16"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td class="header" width="16"><xsl:value-of select="$string[$mmbasestring+12]"/></td>
				<td class="header" width="50"><xsl:value-of select="$string[131]"/></td>
				<!--<td class="header"><xsl:value-of select="$string[132]"/></td>-->
				<td class="header" width="120"><xsl:value-of select="$string[133]"/></td>
				<td class="header"><xsl:value-of select="$string[134]"/></td>
				<td class="header"><xsl:value-of select="$string[$mmbasestring + 8]"/></td>
				<td class="header"><xsl:value-of select="$string[$mmbasestring + 9]"/></td>
				<td class="header" width="30"><xsl:value-of select="$string[441]"/></td>
				<td class="header" width="50"><xsl:value-of select="$string[432]"/></td>
			</tr>			
			
			<xsl:for-each select="document($memberfile)//members/member">
				<xsl:sort select="date" order="descending"/>
				<xsl:if test="position() &gt; number($page*$member_pagesize) and position() &lt;=  number(($page+1)*$member_pagesize) ">
					<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M8&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
						<td><img src="admin/media/{visible}.gif" width="16" height="15"/></td>
						<td class="data2"><xsl:value-of select="id"/></td>
						<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M8&amp;id={id}"><xsl:value-of select="pseudo"/></a></td>
						<!--<td><xsl:value-of select="password"/></td>-->
						<td class="data2"><xsl:value-of select="email"/></td>
						<td class="data2"><xsl:value-of select="ville"/></td>
						<td class="data2"><xsl:value-of select="usercountry"/></td>
						<td class="data2"><xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template></td>
						<td class="data2"><xsl:value-of select="type"/></td>
						<td class="data2"><xsl:value-of select="newsletter"/></td>
					</tr>
				</xsl:if>
			</xsl:for-each>		
			<tr><td colspan="9">
				<!-- Navigation for the Paging -->
				<xsl:call-template name="paging_Rail_macro">
					<xsl:with-param name="totalpage" select="count(document($memberfile)//members/member) div $member_pagesize"/>
					<xsl:with-param name="currentpage" select="number($page)+1"/>
					<xsl:with-param name="url">default.asp?ACT=1&amp;SECT=M8</xsl:with-param>
				</xsl:call-template>
			</td></tr>						
			<tr><td colspan="9" align="right"><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M8&amp;id=new';" type="button" value="{$string[15]}"/></td></tr>
			
			<tr>
				<td colspan="9">
					<a href="members.asp"><xsl:value-of select="$string[565]"/></a>
				
				<!--<xsl:value-of select="$string[136]"/><br/><textarea name="allusermail">
					<xsl:for-each select="document($memberfile)//members/member"><xsl:value-of select="email"/>; </xsl:for-each>					
				</textarea>-->
			</td></tr>
		</table>
	</xsl:template>
	
	
	<!-- addUser template  -->
	<xsl:template name="member_add">
		<table bgcolor="white"><form name="frmFullxml" action="default.asp?ACT=1&amp;SECT=M8" method="post"><tr><td>		
			
			<input type="hidden" name="operation" value="add"/>
			<input type="hidden" name="file" value="member"/>
			<input type="hidden" name="bloc" value="members"/>
			<input type="hidden" name="node" value="member"/>
					
			<table class="block">
				<tr><td class="xp_sel"><xsl:value-of select="$string[131]"/>:</td><td><xsl:call-template name="PseudoField"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[132]"/>:</td><td><input type="password" value="" name="password" class="full"/></td></tr>				
				<tr><td class="xp_sel"><xsl:value-of select="$string[441]"/>:</td><td>
					<select name="type">
					<xsl:for-each select="document($listfile)//lists/list[name='Member']/entries/entry">
						<xsl:sort select="id" data-type="number" order="ascending"/>
							<option value="{value}"><xsl:value-of select="caption"/></option>
						</xsl:for-each>
					</select>
				</td></tr>	
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 13]"/>:</td><td><input type="text" value="" name="userfname" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 14]"/>:</td><td><input type="text" value="" name="userlname" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 15]"/>:</td><td><input type="text" value="" name="userpage" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[133]"/>:</td><td><input type="text" value="" name="email" class="full"/></td></tr>	
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 16]"/>:</td><td><input type="text" value="" name="userphoto" class="full"/></td></tr>	
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 3]"/>:</td><td>
					<select name="usersex">
					<option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
					<xsl:for-each select="document($listfile)//lists/list[name='Sex']/entries/entry">
						<xsl:sort select="caption" data-type="text" order="ascending"/>
							<option value="{value}"><xsl:value-of select="caption"/></option>
						</xsl:for-each>
					</select>
				</td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 4]"/>:</td><td>
					<select name="userage">
					<option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
					<xsl:for-each select="document($listfile)//lists/list[name='Age']/entries/entry">
						<xsl:sort select="id" data-type="number" order="ascending"/>
							<option value="{value}"><xsl:value-of select="caption"/></option>
						</xsl:for-each>
					</select>
				</td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 5]"/>:</td><td>
					<select name="userocupation">
					<option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
					<xsl:for-each select="document($listfile)//lists/list[name='Ocupation']/entries/entry">
						<xsl:sort select="caption" data-type="text" order="ascending"/>
							<option value="{value}"><xsl:value-of select="caption"/></option>
						</xsl:for-each>
					</select>
				</td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 18]"/>:</td><td><input type="text" value="" name="useradress" class="full"/></td></tr>							
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 19]"/>:</td><td><input type="text" value="" name="userzip" class="mini"/></td></tr>							
				<tr><td class="xp_sel"><xsl:value-of select="$string[134]"/>:</td><td><input type="text" value="" name="ville" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 7]"/>:</td><td><input type="text" value="" name="userstate" class="full"/></td></tr>				
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 8]"/>:</td><td>
					<select name="usercountry">
					<option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
					<xsl:for-each select="document($listfile)//lists/list[name='Countries']/entries/entry">
						<xsl:sort select="caption" data-type="text" order="ascending"/>
							<option value="{value}"><xsl:value-of select="caption"/></option>
						</xsl:for-each>
					</select>		
				</td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 20]"/>:</td><td><input type="text" value="" name="phone" class="medium"/></td></tr>				
				<tr><td class="xp_sel"><xsl:value-of select="$string[139]"/>:</td><td>
					<select name="visible">
					<xsl:for-each select="document($listfile)//lists/list[name='Visibility']/entries/entry">
						<xsl:sort select="value" data-type="text" order="ascending"/>
							<option value="{value}"><xsl:value-of select="caption"/></option>
						</xsl:for-each>
					</select>
				</td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[432]"/>:</td><td>									<select name="newsletter">
					<xsl:for-each select="document($listfile)//lists/list[name='OnOff']/entries/entry">
						<xsl:sort select="value" data-type="text" order="ascending"/>
							<option value="{value}"><xsl:value-of select="caption"/></option>
						</xsl:for-each>
					</select>					
				</td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 21]"/>:</td><td>
					<select name="userpublic">
					<xsl:for-each select="document($listfile)//lists/list[name='OnOff']/entries/entry">
						<xsl:sort select="value" data-type="text" order="ascending"/>
							<option value="{value}"><xsl:value-of select="caption"/></option>
						</xsl:for-each>
					</select>		
				</td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 22]"/>:</td>
						<td>
							<textarea name="userwellcome" class="textarea" title="Welcome Message"></textarea>
							<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('userwellcome');</script></xsl:if>
						</td>
				</tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 23]"/>:</td>
						<td><textarea name="usernotes" class="textarea" title="Admin Notes about this particular user"></textarea></td>	
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="{$string[18]}"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M8'"/>
					</td>
				</tr>

			</table>
		
		</td></tr></form></table>
	</xsl:template>
	
	
	<xsl:template name="member_update">
		<table bgcolor="white"><tr><td>
		
			<table class="block">
				<form name="frmFullxml" action="default.asp?ACT=1&amp;SECT={$section}" method="post">
				<input type="hidden" name="file" value="member"/>
				<input type="hidden" name="operation" value="update"/>
				<input type="hidden" name="node" value="members/member[id={id}]"/>
				
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[131]"/>:</td>
					<td>
						<xsl:call-template name="PseudoField">
							<xsl:with-param name="value"><xsl:value-of select="pseudo"/></xsl:with-param>
						</xsl:call-template>
					</td>
				</tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[132]"/>:</td><td><input type="password" value="{password}" name="password" class="full"/></td></tr>	
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[441]"/>:</td>
					<td>
						<select name="type">
							<xsl:variable name="actualtype" select="type"/>
							<xsl:for-each select="document($listfile)//lists/list[name='Member']/entries/entry">
							<xsl:sort select="id" data-type="number" order="ascending"/>
								<option value="{value}"><xsl:if test="value=$actualtype"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
									<xsl:value-of select="caption"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 13]"/>:</td><td><input type="text" value="{userfname}" name="userfname" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 14]"/>:</td><td><input type="text" value="{userlname}" name="userlname" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 15]"/>:</td><td><input type="text" value="{userpage}" name="userpage" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[133]"/>:</td><td><input type="text" value="{email}" name="email" class="full"/></td></tr>	
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 16]"/>:</td><td><input type="text" value="{userphoto}" name="userphoto" class="full"/></td></tr>
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 3]"/>:</td>
					<td>
						<select name="usersex">
						<xsl:variable name="actualsex" select="usersex"/>
							<xsl:if test = "$actualsex=''">
								<option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
							</xsl:if>
							<xsl:if test="not($actualsex)">
								<option value="" selected="selected">Choose</option>
							</xsl:if>
							<xsl:for-each select="document($listfile)//lists/list[name='Sex']/entries/entry">
							<xsl:sort select="caption" data-type="text" order="ascending"/>
								<option value="{value}"><xsl:if test="value=$actualsex"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
									<xsl:value-of select="caption"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 4]"/>:</td>
					<td>
						<select name="userage">
						<xsl:variable name="actualage" select="userage"/>
							<xsl:if test = "$actualage=''">
								<option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
							</xsl:if>
							<xsl:if test="not($actualage)">
								<option value="" selected="selected">Choose</option>
							</xsl:if>
							<xsl:for-each select="document($listfile)//lists/list[name='Age']/entries/entry">
							<xsl:sort select="id" data-type="number" order="ascending"/>
							<option value="{value}"><xsl:if test="value=$actualage"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
									<xsl:value-of select="caption"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 5]"/>:</td>
					<td>
						<select name="userocupation">
						<xsl:variable name="actualocupation" select="userocupation"/>
							<xsl:if test = "$actualocupation=''">
								<option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
							</xsl:if>
							<xsl:if test="not($actualocupation)">
								<option value="" selected="selected">Choose</option>
							</xsl:if>
							<xsl:for-each select="document($listfile)//lists/list[name='Ocupation']/entries/entry">
							<xsl:sort select="caption" data-type="text" order="ascending"/>
							<option value="{value}"><xsl:if test="value=$actualocupation"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
									<xsl:value-of select="caption"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 18]"/>:</td><td><input type="text" value="{useradress}" name="useradress" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 19]"/>:</td><td><input type="text" value="{userzip}" name="userzip" class="mini"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[134]"/>:</td><td><input type="text" value="{ville}" name="ville" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 7]"/>:</td><td><input type="text" value="{userstate}" name="userstate" class="full"/></td></tr>
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 8]"/>:</td>
					<td>
						<select name="usercountry">
						<xsl:variable name="actualcountry" select="usercountry"/>
							<xsl:if test = "$actualcountry=''">
								<option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
							</xsl:if>
							<xsl:if test="not($actualcountry)">
								<option value="" selected="selected">Choose</option>
							</xsl:if>
							<xsl:for-each select="document($listfile)//lists/list[name='Countries']/entries/entry">
							<xsl:sort select="caption" data-type="text" order="ascending"/>
							<option value="{value}"><xsl:if test="value=$actualcountry"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
									<xsl:value-of select="caption"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>				
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 20]"/>:</td><td><input type="text" value="{userphone}" name="userphone" class="medium"/></td></tr>
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[139]"/>:</td>
					<td><select name="visible">
							<xsl:variable name="actualvisible" select="visible"/>
							<xsl:for-each select="document($listfile)//lists/list[name='Visibility']/entries/entry">
							<xsl:sort select="caption" data-type="text" order="ascending"/>
							<option value="{value}"><xsl:if test="value=$actualvisible"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
									<xsl:value-of select="caption"/>
								</option>
							</xsl:for-each>
						</select>
				</td></tr>
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[432]"/>:</td>
					<td><select name="newsletter">
							<xsl:variable name="actualnewsletter" select="newsletter"/>
							<xsl:for-each select="document($listfile)//lists/list[name='OnOff']/entries/entry">
							<xsl:sort select="caption" data-type="text" order="ascending"/>
							<option value="{value}"><xsl:if test="value=$actualnewsletter"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
									<xsl:value-of select="caption"/>
								</option>
							</xsl:for-each>
						</select>
				</td></tr>
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 21]"/>:</td>
					<td><select name="userpublic">
							<xsl:variable name="actualpublic" select="userpublic"/>
							<xsl:for-each select="document($listfile)//lists/list[name='OnOff']/entries/entry">
							<xsl:sort select="caption" data-type="text" order="ascending"/>
							<option value="{value}"><xsl:if test="value=$actualpublic"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
									<xsl:value-of select="caption"/>
								</option>
							</xsl:for-each>
						</select>
				</td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 22]"/>:</td>
						<td>
							<textarea name="userwellcome" class="textarea" title="Welcome Message"><xsl:value-of select="userwellcome" disable-output-escaping="no"/></textarea>
							<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('userwellcome');</script></xsl:if>
						</td>	
				</tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 23]"/>:</td>
						<td><textarea name="usernotes" class="textarea" title="Admin Notes about this particular user"><xsl:value-of select="usernotes" disable-output-escaping="no"/></textarea></td>	
				</tr>

				
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="{$string[18]}"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M8'"/>
					</td>
				</tr>
			</form></table>
					
			<table class="block">
				<tr><form action="default.asp?ACT=1&amp;SECT={$section}" method="post" onsubmit="return confirm('{$string[137]}');">
					<td colspan="2" align="right">						
							<input type="hidden" name="file" value="member"/>
							<input type="hidden" name="operation" value="delete"/>
							<input type="hidden" name="node" value="members/member[id={id}]"/>
							<input type="submit" value="{$string[16]}"/>						
					</td></form>
				</tr>
			</table>
			
		</td></tr></table>
	</xsl:template>
	
</xsl:stylesheet>
