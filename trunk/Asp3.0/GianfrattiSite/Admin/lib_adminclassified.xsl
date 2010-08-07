<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html"/> 

<!-- creation: 2003/10/12, by FxMods -->
<!-- last edition: 2004/03/16, by Mguel Figueira (Mig100) -->

	<xsl:template name="classified_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name"><xsl:value-of select="$string[$classbasestring + 0]"/></xsl:with-param>
			<xsl:with-param name="version">1.0</xsl:with-param>
			<xsl:with-param name="moddate">16.03.2004</xsl:with-param>
			<xsl:with-param name="author">Mig100 (Miguel Figueira)</xsl:with-param>
			<xsl:with-param name="url">http://www.fxmods.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--            main procedure            -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:variable name="presentdate" select="number(substring($actualdate,1,8))"/>

	<xsl:template name="classified_manager">
		<style>
			a.cat {font-size: 18px; font-weight: bold; font-family: Tahoma; color: #000000; text-decoration: none}
			a.subcat {font-size: 12px; font-weight: normal; font-family: Tahoma}
		</style>
		<script>
			var fx_imgwin;
			var fx_opener;			
			 			
			function OpenImage(oOpener) 
			{
				fx_opener = oOpener;
				fx_imgwin = window.open('filepicker.asp','selImg','width=450, height=330, scrollbars=yes'); 
				fx_imgwin.focus();
			}
			
			function onImage(u, base_url, iborder, ialign, ialt, num) {
				fx_opener.value = u;
				fx_imgwin.close();
			}
		</script>
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr>			
				<td width="325"><a href="default.asp?ACT=1&amp;SECT=M70"><img src="admin/media/classified.gif" border="0" title="{$string[$classbasestring + 7]}"/></a><font size="6"><xsl:value-of select="$string[$classbasestring + 1]"/>:</font></td>
				<xsl:choose>
					<xsl:when test="$cmd='edit'">
						<xsl:choose>
							<xsl:when test="$set=0">
								<td align="left" valign="bottom"><a class="cat"><xsl:value-of select="$string[3]"/></a></td>
							</xsl:when>
							<xsl:when test="$set=1">
								<td align="left" valign="center"><a class="cat"><xsl:value-of select="$string[$classbasestring + 3]"/></a></td>
							</xsl:when>
							<xsl:when test="$add &gt; 0">
								<td align="left" valign="center"><a class="cat"><xsl:value-of select="$string[$classbasestring + 4]"/></a></td>
							</xsl:when>
							<xsl:when test="$cat &gt; 0">
								<td align="left" valign="center"><a class="cat"><xsl:value-of select="$string[$classbasestring + 5]"/></a></td>
							</xsl:when>
							<xsl:when test="$user='terms'">
								<td align="left" valign="center"><a class="cat"><xsl:value-of select="$string[$classbasestring + 8]"/></a></td>
							</xsl:when>
							<xsl:when test="$user &gt; 0">
								<td align="left" valign="center"><a class="cat"><xsl:value-of select="$string[$classbasestring + 18]"/></a></td>
							</xsl:when>
							<xsl:otherwise>
								<td align="left" valign="center"><a class="cat"><xsl:value-of select="$string[$classbasestring + 6]"/></a></td>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$cmd='view'">
						<xsl:choose>
							<xsl:when test="$add">
								<td align="left" valign="center">
									<xsl:if test="$cat &gt;0">
										<a class="cat" href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;cat={$cat}"><xsl:value-of select="document($classifiedfile)//cat[id=$cat]/name"/>:</a><xsl:value-of select="$nbsp" disable-output-escaping="yes" />
									</xsl:if>
									<a class="cat"><xsl:value-of select="$string[$classbasestring + 11]"/></a>
								</td>
							</xsl:when>
							<xsl:when test="$cat=0">
								<td align="left" valign="center"><a class="cat"><xsl:value-of select="$string[$classbasestring + 12]"/></a></td>
							</xsl:when>
							<xsl:when test="$cat &gt; 0">
								<td align="left" valign="center"><a class="cat"><xsl:value-of select="$string[$classbasestring + 12]"/></a></td>
							</xsl:when>
							<xsl:when test="$user = 0">
								<td align="left" valign="center"><a class="cat"><xsl:value-of select="$string[$classbasestring + 20]"/></a></td>
							</xsl:when>
							<xsl:otherwise>
								<td align="left" valign="center"><a class="cat"><xsl:value-of select="$string[$classbasestring + 6]"/></a></td>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$cmd='useradds' and $user">
						<td align="left" valign="center"><a class="cat"><xsl:value-of select="$user"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[$classbasestring + 11]"/></a></td>					
					</xsl:when>
					<xsl:when test="$cmd='new'">
						<xsl:choose>
							<xsl:when test="$add='new'">
								<td align="left" valign="center"><a class="cat"><xsl:value-of select="$string[$classbasestring + 9]"/></a></td>
							</xsl:when>
							<xsl:when test="$cat">
								<td align="left" valign="center"><a class="cat"><xsl:value-of select="$string[$classbasestring + 22]"/></a></td>
							</xsl:when>
							<xsl:when test="$user ='new'">
								<td align="left" valign="center"><a class="cat"><xsl:value-of select="$string[$classbasestring + 17]"/></a></td>
							</xsl:when>
							<xsl:otherwise>
								<td align="left" valign="center"><a class="cat"><xsl:value-of select="$string[$classbasestring + 6]"/></a></td>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
								<td align="left" valign="center"><a class="cat"><xsl:value-of select="$string[$classbasestring + 6]"/></a></td>
					</xsl:otherwise>
				</xsl:choose>
			</tr>
		</table>
		<xsl:choose>
			<xsl:when test="$cmd='edit'">
				<xsl:choose>
					<xsl:when test="$set=0">
						<xsl:call-template name="classifiedsettings"/>
					</xsl:when>
					<xsl:when test="$set=1">
						<xsl:call-template name="classifiedTerms"/>
					</xsl:when>
					<xsl:when test="$add &gt; 0">
						<xsl:for-each select="document($classifiedfile)/classified/adds/add[id=$add]">
							<xsl:call-template name="classifiedadd_update"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="$user='terms'">
						<xsl:call-template name="classifiedUserTerms"/>
					</xsl:when>
					<xsl:when test="$cat &gt; 0">
						<xsl:for-each select="document($classifiedfile)/classified/categories//cat[id=$cat]">
							<xsl:call-template name="classifiedcat_update"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="$user &gt; 0">
						<xsl:call-template name="classified_UserEdit"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="classifiedentrance"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$cmd='useradds' and $user">
					<xsl:call-template name="classified_UserAddsList"/>
			</xsl:when>
			<xsl:when test="$cmd='view'">
				<xsl:choose>
					<xsl:when test="$add">
						<xsl:call-template name="classifiedadd_manager"/>
					</xsl:when>
					<xsl:when test="$cat=0">
						<xsl:call-template name="classifiedcat_entrance"/>
					</xsl:when>
					<xsl:when test="$cat &gt; 0">
						<xsl:call-template name="classifiedcat_view"/>
					</xsl:when>
					<xsl:when test="$user = 0">
						<xsl:call-template name="classifieduser_list"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="classifiedentrance"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$cmd='new'">
				<xsl:choose>
					<xsl:when test="$add='new'">
						<xsl:call-template name="classifiedadd_add"/>
					</xsl:when>
					<xsl:when test="$cat">
						<xsl:call-template name="classifiedcat_add"/>
					</xsl:when>
					<xsl:when test="$user ='new'">
						<xsl:call-template name="classified_NewUser"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="classifiedentrance"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="classifiedentrance"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--          Entrance Screen             -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

	<xsl:template name="classifiedentrance">
		<table bgcolor="white" class="block" cellpadding="10" cellspacing="10">
			<tr>
				<td colspan="2"><p/><xsl:value-of select="$string[$classbasestring + 10]"/></td>
			</tr>
			<tr><td colspan="2" height="35"/>
			</tr>
			<xsl:choose>
			    <xsl:when test="document($classifiedfile)/classified/settings/autorization='off'">
			        <tr>
				        <td align="center"><a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=edit&amp;set=0" class="cat"><img src="admin/media/classset.gif" border="0"/><xsl:value-of select="$nbsp" disable-output-escaping="yes" /><xsl:value-of select="$string[3]"/></a></td>
				        <td align="center"><a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=edit&amp;set=1" class="cat"><img src="admin/media/classagree.gif" border="0"/><xsl:value-of select="$nbsp" disable-output-escaping="yes" /><xsl:value-of select="$string[$classbasestring + 3]"/></a></td>
			        </tr>
			    </xsl:when>
					<xsl:otherwise>
			        <tr>
				        <td align="center" colspan="2"><a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=edit&amp;set=0" class="cat"><img src="admin/media/classset.gif" border="0"/><xsl:value-of select="$nbsp" disable-output-escaping="yes" /><xsl:value-of select="$string[3]"/></a></td>
			        </tr>
					</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="document($classifiedfile)/classified/settings/autorization='on'">
					<tr>
						<td align="center"><a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=edit&amp;user=terms" class="cat"><img src="admin/media/classagree.gif" border="0"/><xsl:value-of select="$nbsp" disable-output-escaping="yes" /><xsl:value-of select="$string[$classbasestring + 8]"/></a></td>					
						<td align="center"><a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;user=0" class="cat"><img src="admin/media/classusers.gif" border="0"/><xsl:value-of select="$nbsp" disable-output-escaping="yes" /><xsl:value-of select="$string[$classbasestring + 20]"/></a></td>
					</tr>
			</xsl:if>
			<tr>
				<td align="center"><a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;cat=0" class="cat"><img src="admin/media/classcat.gif" border="0"/><xsl:value-of select="$nbsp" disable-output-escaping="yes" /><xsl:value-of select="$string[$classbasestring + 12]"/></a></td>
				<td align="center"><a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0" class="cat"><img src="admin/media/classadd.gif" border="0"/><xsl:value-of select="$nbsp" disable-output-escaping="yes" /><xsl:value-of select="$string[$classbasestring + 11]"/></a></td>
			</tr>
			<tr>
				<td align="center" colspan="2">
						 <table class="block" cellpadding="2" cellspacing="2">
						 				<tr height="20"/>
										<tr>
												<td colspan="2" class="xp_sel"><a class="cat"><xsl:value-of select="$string[$classbasestring + 13]"/></a></td>
										</tr>
										<tr>
												<td align="right" width="30%"><xsl:value-of select="$string[$classbasestring + 14]"/>:</td>
												<td><a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0&amp;cat=0&amp;type=0"><xsl:value-of select="count(document($classifiedfile)/classified/adds/add)"/></a></td>
										</tr>
										<tr>
												<td align="right" width="30%"><xsl:value-of select="$string[$classbasestring + 15]"/>:</td>
												<td><a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0&amp;cat=0&amp;type=2"><xsl:value-of select="count(document($classifiedfile)/classified/adds/add[visible='off'and enddate &gt;= $presentdate])"/></a></td>
										</tr>
										<tr>
												<td align="right" width="30%"><xsl:value-of select="$string[$classbasestring + 16]"/>:</td>
												<td><a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0&amp;cat=0&amp;type=1"><xsl:value-of select="count(document($classifiedfile)/classified/adds/add[enddate &lt; $presentdate])"/></a></td>
										</tr>
						 </table>
				</td>
			</tr>
		</table>
	</xsl:template>


	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--               Setting                -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

	<xsl:template name="classifiedsettings">
		<table bgcolor="white" class="block">
			<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="classified"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="classified/settings"/>

						<xsl:for-each select="document($classifiedfile)/classified/settings">
						
						<table class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[192]"/>:
								</td>
								<td>
									<textarea name="intro" title="Intro"><xsl:value-of select="intro"/></textarea><script language="javascript1.2">editor_generate('intro');</script>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 23]"/>:</td>
								<td>
									<select name="welcomedisplay">
										<option value="on"><xsl:if test="welcomedisplay='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option>
										<option value="off"><xsl:if test="welcomedisplay='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 24]"/>:</td>
								<td>
								<select name="viewaccess">
									<xsl:variable name="actualviewaccess" select="viewaccess"/>
									<xsl:for-each select="document($listfile)//lists/list[name='Member']/entries/entry">
									<xsl:sort select="id" data-type="text" order="ascending"/>	
									<option value="{value}"><xsl:if test="value=$actualviewaccess"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
										<xsl:value-of select="caption"/>
									</option>
									</xsl:for-each>
								</select>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 26]"/>:</td>
								<td>
									<select name="autorization" onchange="if (this.value=='on') document.all.noexplicitautorization.style.display= 'none'; else 			document.all.noexplicitautorization.style.display= 'block';">
										<option value="off"><xsl:if test="autorization='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option>
										<option value="on"><xsl:if test="autorization='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option>
									</select>
								</td>
							</tr>
							<tr><td colspan="2">	 
						<div id="noexplicitautorization" style="display: none;">
							<table><tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 25]"/>:</td>
								<td>
								<select name="postaccess">
									<xsl:variable name="actualpostaccess" select="postaccess"/>
									<xsl:for-each select="document($listfile)//lists/list[name='Member']/entries/entry">
									<xsl:sort select="id" data-type="text" order="ascending"/>	
									<option value="{value}"><xsl:if test="value=$actualpostaccess"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
										<xsl:value-of select="caption"/>
									</option>
									</xsl:for-each>
								</select>
								</td>
							</tr></table>
						</div>
						</td></tr>
						<script>if (document.frmFullxml.autorization.value=='on') document.all.noexplicitautorization.style.display= 'none'; else document.all.noexplicitautorization.style.display= 'block';</script>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 27]"/>:</td>
								<td>
								<select name="postenable">
									<option value="on"><xsl:if test="postenable='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[$classbasestring + 28]"/></option>
									<option value="off"><xsl:if test="postenable='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[$classbasestring + 29]"/></option>
								</select>
								</td>
							</tr>
						</table>
						<br/>
						<table class="block">
							<tr>
								<td align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}';"/>
								</td>
							</tr>
						</table>
						</xsl:for-each>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>

	<!-- Terms of use. This will is display before someone post one add --> 
	<xsl:template name="classifiedTerms">
		<table bgcolor="white" class="block">
			<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="classified"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="classified/settings"/>

						<xsl:for-each select="document($classifiedfile)/classified/settings">
						
						<table class="block">
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 3]"/>:</td>
								<td>
									<textarea name="terms" title="{$string[$classbasestring + 3]}"><xsl:value-of select="terms"/></textarea><script language="javascript1.2">editor_generate('terms');</script>
								</td>
							</tr>
						</table>
						<br/>
						<table class="block">
							<tr  align="right">
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}';"/>
								</td>
							</tr>
						</table>
						</xsl:for-each>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>


	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--               Categories             -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

	<!-- Classified Adds Entrance grid -->
	<xsl:template name="classifiedcat_entrance">
		<table bgcolor="white" class="block" cellpadding="5" cellspacing="5">
			<xsl:choose>
				<xsl:when test="count(document($classifiedfile)//classified/categories/cat)=0">
					<tr><td colspan="2" height="35"/></tr>
					<tr><td colspan="2"><p/><xsl:value-of select="$string[$classbasestring + 30]"/></td></tr>
				</xsl:when>
				<xsl:otherwise>
					<tr><td colspan="2" style="background: #F7F7F7;"><p/><xsl:value-of select="$string[$classbasestring + 58]"/></td></tr>
					<tr><td colspan="2" height="35"/></tr>
					<tr>
						<xsl:for-each select="document($classifiedfile)/classified/categories/cat">
							<td align="center">
								<xsl:call-template name="classifiedcat_listdesign">
									<xsl:with-param name="catId">
										<xsl:value-of select="id"/>
									</xsl:with-param>
								</xsl:call-template>
							</td>
							<xsl:if test="position() mod 2 = 0">
								<xsl:value-of select="'&lt;/tr&gt;&lt;tr&gt;'" disable-output-escaping="yes"/>
							</xsl:if>
						</xsl:for-each>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<tr><td colspan="2" height="35"/></tr>
			<tr><td colspan="2">
			<table class="block"><tr><td align="right" style="background: #F7F7F7;"><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M70&amp;cmd=new&amp;cat=new';" type="button" value="{$string[$classbasestring + 22]}"/></td></tr></table>
			</td></tr>
		</table>
	</xsl:template>

	<!-- Classified Adds categories grid -->
	<xsl:template name="classifiedcat_view">
		<table bgcolor="white" class="block" cellpadding="5" cellspacing="5">
			<tr><td colspan="2">
						<table class="block">
									 <tr>
									 		 <td style="background: #F7F7F7;" colspan="2">
									 				 <a class="cat"><xsl:value-of select="$string[$classbasestring + 34]"/></a>
													 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
													 <a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=edit&amp;cat={$cat}">
													 		<img src="admin/media/edit.gif" border="0" width="6" height="6"/>
													 </a>
									 		 </td>
									 </tr>
									 <tr>
									 		 <td class="xp_sel"><xsl:value-of select="$string[311]"/>:</td>
											 <td><b><xsl:value-of select="document($classifiedfile)//cat[id=$cat]/name"/></b></td>
									 </tr>
									 <tr>
									 		 <td class="xp_sel"><xsl:value-of select="$string[192]"/>:</td>
											 <td><p/><xsl:value-of select="document($classifiedfile)//cat[id=$cat]/intro" disable-output-escaping="yes"/></td>
									 </tr>
						 </table>			
			</td></tr>
			<tr><td colspan="2">
						<table class="block">
									 <tr>
									 		 <td style="background: #F7F7F7;" colspan="2">
									 				 <a class="cat"><xsl:value-of select="$string[$classbasestring + 36]"/></a>
									 		 </td>
									 </tr>
						 </table>
			</td></tr>
			<tr><td colspan="2" height="35"/></tr>
			<xsl:choose>
					<xsl:when test="count(document($classifiedfile)//cat[id=$cat]/cat)=0">
										<tr><td colspan="2" align="center"><font color="red"><xsl:value-of select="$string[$classbasestring + 30]"/></font></td></tr>
				  </xsl:when>
					<xsl:otherwise>
											 <tr>
											 		 <xsl:for-each select="document($classifiedfile)//cat[id=$cat]/cat">
													 							 <td align="center">
																				 		 <xsl:call-template name="classifiedcat_listdesign">
																						 										<xsl:with-param name="catId">
																																								<xsl:value-of select="id"/>
																																</xsl:with-param>
																						 </xsl:call-template>
																					</td>
																					<xsl:if test="position() mod 2 = 0">
																					<xsl:value-of select="'&lt;/tr&gt;&lt;tr&gt;'" disable-output-escaping="yes"/>
																					</xsl:if> 
														</xsl:for-each>
												</tr>																							
					</xsl:otherwise>
			</xsl:choose>
			<tr><td colspan="2" height="35"/></tr>
			<tr>
				<td align="right" colspan="2">
						<table class="block">
									 <tr><td style="background: #F7F7F7;" colspan="2">
									 				 <a class="cat"><xsl:value-of select="$string[$classbasestring + 35]"/></a>
									 </td></tr>
										<tr>
												<td align="right" width="30%"><xsl:value-of select="$string[$classbasestring + 14]"/>:</td>
												<td><a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0&amp;cat={$cat}&amp;type=0"><xsl:value-of select="count(document($classifiedfile)/classified/adds/add[catid=$cat])"/></a></td>
										</tr>
										<tr>
												<td align="right" width="30%"><xsl:value-of select="$string[$classbasestring + 15]"/>:</td>
												<td><a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0&amp;cat={$cat}&amp;type=2"><xsl:value-of select="count(document($classifiedfile)/classified/adds/add[catid=$cat and visible='off' and enddate &gt;= $presentdate])"/></a></td>
										</tr>
										<tr>
												<td align="right" width="30%"><xsl:value-of select="$string[$classbasestring + 16]"/>:</td>
												<td><a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0&amp;cat={$cat}&amp;type=1"><xsl:value-of select="count(document($classifiedfile)/classified/adds/add[catid=$cat and enddate &lt; $presentdate])"/></a></td>
										</tr>
									 <tr><td colspan="2" align="right" style="background: #F7F7F7;">
									 <input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M70&amp;cmd=new&amp;cat={$cat}';" type="button" value="{$string[$classbasestring + 22]}"/>
									 <xsl:for-each select="document($classifiedfile)//cat[id=$cat]">
													<xsl:if test="parent::cat">
																		<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
																		<input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;cat={parent::cat/id}';" type="button" value="{concat($string[$classbasestring + 31], ' ', parent::cat/name)}"/>
													</xsl:if>
													<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
													<input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;cat=0';" type="button" value="{concat($string[$classbasestring + 31], ' ', $string[$classbasestring + 6])}"/>
					  			 </xsl:for-each>
									 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									 <input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M70&amp;cmd=new&amp;add=new';" type="button" value="{$string[$classbasestring + 9]}"/>
									 </td></tr>
						 </table>
				</td> 
			</tr>
		</table>
	</xsl:template>

	<!-- This is where you can define the way each category is shown -->
	<xsl:template name="classifiedcat_listdesign">
	<xsl:param name="catId"/>
	<xsl:for-each select="document($classifiedfile)/classified//cat[id=$catId]">
		<table cellpadding="5">
			<tr>
				<td align="center">
					<a class="cat" href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;cat={id}">
						<xsl:choose>
							<xsl:when test="string-length(image) &gt; 0">
								<img src="{image}" border="0" width="32" height="32"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="admin/media/classcat.gif" border="0" width="32" height="32"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="name"/>
					</a>
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					<a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=edit&amp;cat={id}">
						<img src="admin/media/edit.gif" border="0" width="6" height="6"/>
					</a>
				</td>
			</tr>
			<tr>
				<td align="center">
					<xsl:value-of select="$string[$classbasestring + 36]"/>: <xsl:value-of select="count(document($classifiedfile)//cat[id=$catId]//cat)"/>
					<br/>
					<xsl:value-of select="$string[$classbasestring + 37]"/>: <a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0&amp;cat={id}&amp;type=0"><xsl:value-of select="count(document($classifiedfile)//add[catid=$catId])"/></a>
					<br/>
					(
					<a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0&amp;cat={id}&amp;type=2">
						<xsl:value-of select="count(document($classifiedfile)//add[catid=$catId and visible='off'and enddate &gt;= $presentdate])"/>
					</a>
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[$classbasestring + 38]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					- <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					<a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0&amp;cat={id}&amp;type=1">
					<xsl:value-of select="count(document($classifiedfile)//add[catid=$catId and enddate &lt; $presentdate])"/>
					</a>
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[$classbasestring + 39]"/>
					)
				</td>
			</tr>
		</table>
	</xsl:for-each>
	</xsl:template>

	<!-- Create new category -->	
	<xsl:template name="classifiedcat_add">
		<table bgcolor="white" class="block">
			<form action="default.asp?ACT=1&amp;SECT={$section}&amp;cmd=view&amp;cat={$cat}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="classified"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="node" value="cat"/>
						<xsl:choose>
							<xsl:when test="$cat='new'">					
								<input type="hidden" name="bloc" value="classified/categories"/>
							</xsl:when>
							<xsl:otherwise>
								<input type="hidden" name="bloc" value="classified/categories//cat[id='{$cat}']"/>
							</xsl:otherwise>
						</xsl:choose>				

						<table class="block">

							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[311]"/>:
								</td>
								<td>
									<input type="text" name="name" class="full"/>
								</td>
							</tr>
							<tr>
								<td  class="xp_sel">
									<xsl:value-of select="$string[126]"/>:
								</td>
								<td>
									<input type="text" name="image" class="full"/>
									<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.image);"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[192]"/>:
								</td>
								<td>
									<textarea name="intro" title="Intro"></textarea><script language="javascript1.2">editor_generate('intro');</script>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[139]"/>:</td><td>
							<select name="visible">
								<xsl:for-each select="document($listfile)//lists/list[name='Visibility']/entries/entry">
								<xsl:sort select="value" data-type="text" order="ascending"/>
								<option value="{value}"><xsl:value-of select="caption"/></option>	
								</xsl:for-each>
							</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;cmd=view&amp;cat={$cat}';"/>
								</td>
							</tr>
						</table>
						<br/>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>

	<!-- Update existing category -->	
	<xsl:template name="classifiedcat_update">
		<table bgcolor="white" class="block">
			<form action="default.asp?ACT=1&amp;SECT={$section}&amp;cmd=view&amp;cat={$cat}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="classified"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="classified/categories//cat[id={id}]"/>
						
						<table class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[311]"/>:
								</td>
								<td>
									<input type="text" name="name" class="full" value ="{name}"/>
								</td>
							</tr>
							<tr>
								<td  class="xp_sel">
									<xsl:value-of select="$string[126]"/>:
								</td>
								<td>
									<input type="text" name="image" value="{image}" class="full"/>
									<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.image);"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[192]"/>:
								</td>
								<td>
									<textarea name="intro" title="Intro"><xsl:value-of select="intro"/></textarea><script language="javascript1.2">editor_generate('intro');</script>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[139]"/>:</td>
								<td>
								<select name="visible">
									<xsl:variable name="actualvisible" select="visible"/>
									<xsl:for-each select="document($listfile)//lists/list[name='Visibility']/entries/entry">
									<xsl:sort select="caption" data-type="text" order="ascending"/>	
									<option value="{value}"><xsl:if test="value=$actualvisible"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
										<xsl:value-of select="caption"/>
									</option>
									</xsl:for-each>
								</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;cmd=view&amp;cat={$cat}';"/>
								</td>
							</tr>
						</table>
						<br/>
					</td>
				</tr>
			</form>
			<tr>
					<td colspan="2" align="right">
					<form action="default.asp?ACT=1&amp;SECT={$section}&amp;cmd=view&amp;cat=0" method="post" onsubmit="return confirm('{$string[$classbasestring + 40]}');">
							<table class="block"><tr><td align="right">						
										 <input type="hidden" name="file" value="classified"/>
										 <input type="hidden" name="operation" value="delete"/>
										 <input type="hidden" name="node" value="classified/categories/cat[id={id}]"/>
										 <input type="submit" value="{$string[16]}"/>
							</td></tr></table>						
					</form>
					</td>
				</tr>
		</table>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--           Announcements              -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

	<!-- Announcements Grid List-->
	<xsl:template name="classifiedadd_manager">
		<xsl:call-template name="classifiedadd_filter"/>
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr align="center">
				<td class="header" width="20"><xsl:value-of select="$string[127]"/></td>
				<td class="header"><xsl:value-of select="$string[142]"/></td>
				<td class="header"><xsl:value-of select="$string[$classbasestring + 41]"/></td>
				<td class="header"><xsl:value-of select="$string[$classbasestring + 43]"/></td>
				<td class="header"><xsl:value-of select="$string[$classbasestring + 42]"/></td>
			</tr>			
			<xsl:call-template name="classifiedadd_selector"/>
			<tr><td colspan="6" align="right"><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M70&amp;cmd=new&amp;add=new';" type="button" value="{$string[15]}"/></td></tr>
		</table>
	</xsl:template>

	<!-- Category/Announcements filter -->
	<xsl:template name="classifiedadd_filter">
		<form name="frmFilter">
		<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$string[$classbasestring + 41]"/>: </b>
			<select name="catfilter" onchange="document.location='default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0&amp;cat=' + frmFilter.catfilter.value + '&amp;type={$type}';">
				<option value="0"><xsl:if test="$type=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[$kb_basestring + 8]"/></option>
				<xsl:for-each select="document($classifiedfile)//cat">
					<xsl:sort select="name" data-type="text" order="ascending"/>
					<option value="{id}">
						<xsl:if test="id=$cat">
							<xsl:attribute name="selected">selected</xsl:attribute>
						</xsl:if>
					<xsl:value-of select="name"/>
					</option>
				</xsl:for-each>
		</select>
		<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$string[$classbasestring + 42]"/>: </b>
			<select name="sttfilter" onchange="document.location='default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0&amp;cat={$cat}&amp;type=' + frmFilter.sttfilter.value;">
				<option value="0"><xsl:if test="$type=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[$kb_basestring + 8]"/></option>
				<option value="1"><xsl:if test="$type=1"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[$classbasestring + 39]"/></option>
				<option value="2"><xsl:if test="$type=2"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[$classbasestring + 38]"/></option>
			</select>
		</form>
	</xsl:template>

	<!-- Category/Announcements selector -->
	<xsl:template name="classifiedadd_selector">
		<xsl:choose>
			<xsl:when test="$cat &gt; 0">
				<xsl:choose>
					<xsl:when test="$type = 1">
						<xsl:for-each select="document($classifiedfile)//add[catid=$cat and enddate &lt;= $presentdate]">
						<xsl:sort select="id" data-type="number" order="ascending"/>
							<xsl:if test="position() &gt; number($page*$classified_pagesize) and position() &lt;= number(($page+1)*$classified_pagesize) ">
								<xsl:call-template name="classifiedadd_list">
									<xsl:with-param name="addId" select="id"/>
								</xsl:call-template>
							</xsl:if>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="$type = 2">
						<xsl:for-each select="document($classifiedfile)//add[catid=$cat and visible='off'and enddate &gt;= $presentdate]">
						<xsl:sort select="id" data-type="number" order="ascending"/>
							<xsl:if test="position() &gt; number($page*$classified_pagesize) and position() &lt;= number(($page+1)*$classified_pagesize) ">
								<xsl:call-template name="classifiedadd_list">
									<xsl:with-param name="addId" select="id"/>
								</xsl:call-template>
							</xsl:if>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="document($classifiedfile)//add[catid=$cat] ">
						<xsl:sort select="id" data-type="number" order="ascending"/>
							<xsl:if test="position() &gt; number($page*$classified_pagesize) and position() &lt;= number(($page+1)*$classified_pagesize) ">
								<xsl:call-template name="classifiedadd_list">
									<xsl:with-param name="addId" select="id"/>
								</xsl:call-template>
							</xsl:if>
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$type = 1">
						<xsl:for-each select="document($classifiedfile)//add[enddate &lt;= $presentdate]">
						<xsl:sort select="id" data-type="number" order="ascending"/>
							<xsl:if test="position() &gt; number($page*$classified_pagesize) and position() &lt;= number(($page+1)*$classified_pagesize) ">
								<xsl:call-template name="classifiedadd_list">
									<xsl:with-param name="addId" select="id"/>
								</xsl:call-template>
							</xsl:if>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="$type = 2">
						<xsl:for-each select="document($classifiedfile)//add[visible='off'and enddate &gt;= $presentdate]">
						<xsl:sort select="id" data-type="number" order="ascending"/>
							<xsl:if test="position() &gt; number($page*$classified_pagesize) and position() &lt;= number(($page+1)*$classified_pagesize) ">
								<xsl:call-template name="classifiedadd_list">
									<xsl:with-param name="addId" select="id"/>
								</xsl:call-template>
							</xsl:if>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="document($classifiedfile)//add">
						<xsl:sort select="id" data-type="number" order="ascending"/>
							<xsl:if test="position() &gt; number($page*$classified_pagesize) and position() &lt;= number(($page+1)*$classified_pagesize) ">
								<xsl:call-template name="classifiedadd_list">
									<xsl:with-param name="addId" select="id"/>
								</xsl:call-template>
							</xsl:if>
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<tr>
			<td colspan="6" align="center">
				<xsl:call-template name="paging_Rail_macro">
					<xsl:with-param name="totalpage" select="count(document($classifiedfile)//classified/adds/add) div $classified_pagesize"/>
					<xsl:with-param name="currentpage" select="number($page)+1"/>
					<xsl:with-param name="url">default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0</xsl:with-param>
				</xsl:call-template>
			</td>
		</tr>
	</xsl:template>

	<!-- Announcements List to be shown inside grids. Params are used to allow differents selections -->
	<xsl:template name="classifiedadd_list">
	<xsl:param name="addId"/>
	<xsl:param name="addOwner"/>
		<xsl:for-each select="document($classifiedfile)//add[id=$addId or owner=$addOwner]">
			<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M70&amp;cmd=edit&amp;add={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
				<td class="data2" width="20"><xsl:value-of select="id"/></td>
				<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=edit&amp;add={id}"><xsl:value-of select="title"/></a></td>
				<td class="data2">
					<xsl:variable name="selectcat" select="catid"/>
					<xsl:value-of select="document($classifiedfile)//cat[id=$selectcat]/name"/></td>
				<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=useradds&amp;user={owner}"><xsl:value-of select="owner"/></a></td>
				<td class="data2">
					<xsl:choose>
						<xsl:when test="enddate &lt; $presentdate"><font color="red" ><xsl:value-of select="$string[$classbasestring + 39]"/></font></xsl:when>
						<xsl:when test="visible='off'and enddate &gt;= $presentdate"><font color="blue"><xsl:value-of select="$string[$classbasestring + 38]"/></font></xsl:when>
						<xsl:when test="visible='off'"><font color="red"><xsl:value-of select="$string[$classbasestring + 44]"/></font></xsl:when>
						<xsl:otherwise><font color="green"><xsl:value-of select="$string[$classbasestring + 45]"/></font></xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</xsl:for-each>		
	</xsl:template>


	<!-- New Announcements -->
	<xsl:template name="classifiedadd_add">
		<table bgcolor="white" class="block">
			<form action="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="classified"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="bloc" value="classified/adds"/>
						<input type="hidden" name="node" value="add"/>
						<input type="hidden" name="count" value="0"/>
						<input type="hidden" name="messages" value=""/>
						
						<table class="block">
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[142]"/>:</td>
								<td>
									<input type="text" name="title" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 41]"/>:</td>
								<td>
							<select name="catid">
								<xsl:for-each select="document($classifiedfile)/classified//cat[visible='on']">
								<xsl:sort select="name" data-type="text" order="ascending"/>
								<option value="{id}"><xsl:value-of select="name"/></option>	
								</xsl:for-each>
							</select>
								</td>
							</tr>
							<tr>
								<td  class="xp_sel"><xsl:value-of select="$string[126]"/>:</td>
								<td>
									<input type="text" name="image" class="full"/>
									<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.image);"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[192]"/>:
								</td>
								<td>
									<textarea name="body" title="Boby"></textarea><script language="javascript1.2">editor_generate('body');</script>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 46]"/>:</td>
								<td>
									<input type="text" name="price" class="mini"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 47]"/>:</td>
								<td>
									<input type="text" name="units" class="mini"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 48]"/>:</td>
								<td>
									<input type="text" name="site" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 49]"/>:</td>
								<td>
									<input type="text" name="startdate" value="{$presentdate}" onClick="cal.select(this, 'startdate', 'yyyyMMdd');" maxlength="8" class="mini"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 50]"/>:</td>
								<td>
									<input type="text" name="enddate" value="{number($presentdate+100)}" onClick="cal.select(this, 'enddate', 'yyyyMMdd');" maxlength="8" class="mini"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[139]"/>:</td>
								<td>
									<select name="visible">
										<xsl:for-each select="document($listfile)//lists/list[name='Visibility']/entries/entry">
										<xsl:sort select="value" data-type="text" order="ascending"/>
										<option value="{value}"><xsl:value-of select="caption"/></option>	
										</xsl:for-each>
									</select>
								</td>
							</tr>
						</table>
						<table align="right">
							<tr  align="right">
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0';"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>

	<!-- Update Announcements -->
	<xsl:template name="classifiedadd_update">
		<table bgcolor="white">
			<form action="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0&amp;cat={catid}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="classified"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="classified/adds/add[id={id}]"/>

						<table class="block">
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[142]"/>:</td>
								<td>
									<input type="text" name="title" value="{title}" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 41]"/>:</td>
								<td>
									<select name="catid">
									<xsl:variable name="actualcatid" select="catid"/>
										<xsl:for-each select="document($classifiedfile)/classified//cat[visible='on']">
										<xsl:sort select="name" data-type="text" order="ascending"/>
											<option value="{id}"><xsl:if test="id=$actualcatid"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="name"/></option>	
								</xsl:for-each>
							</select>
								</td>
							</tr>
							<tr>
								<td  class="xp_sel">
									<xsl:value-of select="$string[126]"/>:
								</td>
								<td>
									<input type="text" name="image" value="{image}" class="full"/>
									<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.image);"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[192]"/>:
								</td>
								<td>
									<textarea name="body" title="Intro"><xsl:value-of select="body"/></textarea><script language="javascript1.2">editor_generate('body');</script>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 46]"/>:</td>
								<td>
									<input type="text" name="price" value="{price}" class="mini"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 47]"/>:</td>
								<td>
									<input type="text" name="units" value="{units}" class="mini"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 48]"/>:</td>
								<td>
									<input type="text" name="site" value="{site}" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 49]"/>:</td>
								<td>
									<input type="text" name="startdate" value="{startdate} " onClick="cal.select(this, 'startdate', 'yyyyMMdd');" maxlength="8" class="mini"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 50]"/>:</td>
								<td>
									<input type="text" name="enddate" value="{enddate}" onClick="cal.select(this, 'enddate', 'yyyyMMdd');" maxlength="8" class="mini"/>
								</td>
							</tr>

							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[139]"/>:</td>
								<td>
								<select name="visible">
									<xsl:variable name="actualvisible" select="visible"/>
									<xsl:for-each select="document($listfile)//lists/list[name='Visibility']/entries/entry">
									<xsl:sort select="caption" data-type="text" order="ascending"/>	
									<option value="{value}"><xsl:if test="value=$actualvisible"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
										<xsl:value-of select="caption"/>
									</option>
									</xsl:for-each>
								</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0&amp;cat={catid}';"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</form>
			<tr>
					<td colspan="2"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					</td>
			</tr>
			<form action="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0&amp;cat={catid}';" method="post" onsubmit="return confirm('{$string[$classbasestring + 51]}');">
			<tr>
					<td colspan="2">
							<table bgcolor="white" width="100%" class="block">
										 <tr>
										 		 <td colspan="2" align="right">						
												 		 <input type="hidden" name="file" value="classified"/>
														 <input type="hidden" name="operation" value="delete"/>
														 <input type="hidden" name="node" value="classified/adds/add[id={$add}]"/>
														 <input type="submit" value="{$string[16]}"/>						
													</td>
											</tr>
							</table>
					</td>
			</tr>		
			</form>
		</table>
	</xsl:template>


	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--             Publishers               -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	
	<!-- Settings for Publishers, only necessary if publishing explicit autorization is on-->
	<xsl:template name="classifiedUserTerms">
		<table bgcolor="white" class="block">
			<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="classified"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="classified/users/settings"/>

						<xsl:for-each select="document($classifiedfile)/classified/users/settings">
						
						<table class="block">
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 52]"/>:</td>
								<td>
									<textarea name="userterms" title="Canditates Message to be shown at register moment"><xsl:value-of select="userterms"/></textarea><script language="javascript1.2">editor_generate('userterms');</script>
								</td>
							</tr>
							<tr>
								<td style="background: #F7F7F7; font: bold" colspan="2"><xsl:value-of select="$string[$classbasestring + 52]"/>:</td>
							</tr>
							<tr  align="right">
								<td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 29]"/>:</td>
								<td align="left">
								<select name="mandatoryname">
									<xsl:variable name="actualmandatoryname" select="mandatoryname"/>
									<xsl:for-each select="document($listfile)//lists/list[name='OnOff']/entries/entry">
									<xsl:sort select="id" data-type="text" order="ascending"/>	
									<option value="{value}"><xsl:if test="value=$actualmandatoryname"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
										<xsl:value-of select="caption"/>
									</option>
									</xsl:for-each>
								</select>
								</td>
							</tr>
							<tr  align="right">
								<td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 15]"/>:</td>
								<td align="left">
								<select name="mandatorysite">
									<xsl:variable name="actualmandatorysite" select="mandatorysite"/>
									<xsl:for-each select="document($listfile)//lists/list[name='OnOff']/entries/entry">
									<xsl:sort select="id" data-type="text" order="ascending"/>	
									<option value="{value}"><xsl:if test="value=$actualmandatorysite"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
										<xsl:value-of select="caption"/>
									</option>
									</xsl:for-each>
								</select>
								</td>
							</tr>		
							<tr  align="right">
								<td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 18]"/>:</td>
								<td align="left">
								<select name="mandatoryadress">
									<xsl:variable name="actualmandatoryadress" select="mandatoryadress"/>
									<xsl:for-each select="document($listfile)//lists/list[name='OnOff']/entries/entry">
									<xsl:sort select="id" data-type="text" order="ascending"/>	
									<option value="{value}"><xsl:if test="value=$actualmandatoryadress"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
										<xsl:value-of select="caption"/>
									</option>
									</xsl:for-each>
								</select>
								</td>
							</tr>
							<tr  align="right">
								<td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 20]"/>:</td>
								<td align="left">
								<select name="mandatoryphone">
									<xsl:variable name="actualmandatoryphone" select="mandatoryphone"/>
									<xsl:for-each select="document($listfile)//lists/list[name='OnOff']/entries/entry">
									<xsl:sort select="id" data-type="text" order="ascending"/>	
									<option value="{value}"><xsl:if test="value=$actualmandatoryphone"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
										<xsl:value-of select="caption"/>
									</option>
									</xsl:for-each>
								</select>
								</td>
							</tr>
						</table>
						</xsl:for-each>
					</td>
				</tr>
				<tr align="right">
						<td colspan="2" align="right">
								<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
								<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}';"/>
						</td>
				</tr>
  		</form>
		</table>
	</xsl:template>

	<!-- list of all autorized or waiting for autorization publishers -->
	<xsl:template name="classifieduser_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr align="center">
				<td class="header" width="16"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td class="header" width="20"><xsl:value-of select="$string[127]"/></td>
				<td class="header"><xsl:value-of select="$string[131]"/></td>
				<td class="header"><xsl:value-of select="$string[$classbasestring + 54]"/></td>
				<td class="header"><xsl:value-of select="$string[$classbasestring + 55]"/></td>
				<td class="header"><xsl:value-of select="$string[$classbasestring + 21]"/></td>
				<xsl:if test="document($classifiedfile)/classified/users/settings/mandatoryname='on'">
										<td class="header"><xsl:value-of select="$string[$mmbasestring + 29]"/></td>
				</xsl:if>
				<xsl:if test="document($classifiedfile)/classified/users/settings/mandatorysite='on'">
										<td class="header"><xsl:value-of select="$string[$mmbasestring + 15]"/></td>
				</xsl:if>
				<xsl:if test="document($classifiedfile)/classified/users/settings/mandatoryadress='on'">
										<td class="header"><xsl:value-of select="$string[$mmbasestring + 18]"/></td>
				</xsl:if>
				<xsl:if test="document($classifiedfile)/classified/users/settings/mandatoryphone='on'">
										<td class="header"><xsl:value-of select="$string[$mmbasestring + 20]"/></td>
				</xsl:if>
			</tr>
			<!-- publishers list -->			
			<xsl:for-each select="document($classifiedfile)//user">
				<xsl:sort select="id" data-type="number" order="ascending"/>
				<xsl:variable name="owner" select="userpseudo"/>

				<xsl:if test="position() &gt; number($page*$classified_pagesize) and position() &lt;=  number(($page+1)*$classified_pagesize) ">
					<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M70&amp;cmd=edit&amp;user={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
						<td><img src="admin/media/{state}.gif" width="16" height="15"/></td>
						<td class="data2" width="20"><xsl:value-of select="id"/></td>
						<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=edit&amp;user={id}"><xsl:value-of select="userpseudo"/></a></td>
						<td class="data2" align="center"><xsl:call-template name="display_date"><xsl:with-param name="p_Date" select="startdate"/></xsl:call-template></td>
						<td class="data2" align="center"><xsl:call-template name="display_date"><xsl:with-param name="p_Date" select="enddate"/></xsl:call-template></td>
						<td class="data2" align="center"><xsl:value-of select="count(document($classifiedfile)//add[owner=$owner])"/></td>
						<xsl:if test="document($classifiedfile)/classified/users/settings/mandatoryname='on'">
										<xsl:choose>
  										<xsl:when test="string-length(document($memberfile)//member[pseudo=$owner]/userfname) = 0 or string-length(document($memberfile)//member[pseudo=$owner]/userlname)=0">
												<td class="data2"><font color="red"><xsl:value-of select="$string[$classbasestring + 75]"/></font></td>
  										</xsl:when>
											<xsl:otherwise>
												<td class="data2"><font color="green"><xsl:value-of select="$string[18]"/></font></td>												
											</xsl:otherwise>
										</xsl:choose>
						</xsl:if>
						<xsl:if test="document($classifiedfile)/classified/users/settings/mandatorysite='on'">
										<xsl:choose>
  										<xsl:when test="string-length(document($memberfile)//member[pseudo=$owner]/userpage)=0">
												<td class="data2"><font color="red"><xsl:value-of select="$string[$classbasestring + 75]"/></font></td>
  										</xsl:when>
											<xsl:otherwise>
												<td class="data2"><font color="green"><xsl:value-of select="$string[18]"/></font></td>												
											</xsl:otherwise>
										</xsl:choose>
						</xsl:if>
						<xsl:if test="document($classifiedfile)/classified/users/settings/mandatoryadress='on'">
										<xsl:choose>
  										<xsl:when test="string-length(document($memberfile)//member[pseudo=$owner]/useradress)=0 or string-length(document($memberfile)//member[pseudo=$owner]/userzip)=0 or string-length(document($memberfile)//member[pseudo=$owner]/ville)=0 or string-length(document($memberfile)//member[pseudo=$owner]/userstate)=0 or string-length(document($memberfile)//member[pseudo=$owner]/usercountry)=0">
												<td class="data2"><font color="red"><xsl:value-of select="$string[$classbasestring + 75]"/></font></td>
  										</xsl:when>
											<xsl:otherwise>
												<td class="data2"><font color="green"><xsl:value-of select="$string[18]"/></font></td>												
											</xsl:otherwise>
										</xsl:choose>
						</xsl:if>
						<xsl:if test="document($classifiedfile)/classified/users/settings/mandatoryphone='on'">
										<xsl:choose>
  										<xsl:when test="string-length(document($memberfile)//member[pseudo=$owner]/userphone)=0">
												<td class="data2"><font color="red"><xsl:value-of select="$string[$classbasestring + 75]"/></font></td>
  										</xsl:when>
											<xsl:otherwise>
												<td class="data2"><font color="green"><xsl:value-of select="$string[18]"/></font></td>												
											</xsl:otherwise>
										</xsl:choose>
						</xsl:if>
					</tr>
				</xsl:if>
			</xsl:for-each>		
			<tr><td colspan="6" align="center">
				<!-- Navigation for the Paging -->
				<xsl:call-template name="paging_Rail_macro">
					<xsl:with-param name="totalpage" select="count(document($classifiedfile)//user) div $classified_pagesize"/>
					<xsl:with-param name="currentpage" select="number($page)+1"/>
					<xsl:with-param name="url">default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;user=0</xsl:with-param>
				</xsl:call-template>
			</td></tr>
		</table>
		<table width="100%">
			<tr><td align="right"><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M70&amp;cmd=new&amp;user=new';" type="button" value="{$string[15]}"/></td></tr>
		</table>
	</xsl:template>

	<!-- insert new publisher -->
	<xsl:template name="classified_NewUser">
		<table bgcolor="white" class="block">
			<form action="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;user=0" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="classified"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="bloc" value="classified/users"/>
						<input type="hidden" name="node" value="user"/>

						<table class="block">
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 42]"/>:</td>
								<td>
										<select name="userpseudo">
														<xsl:for-each select="document($memberfile)//member[visible='on']">
														<xsl:sort select="pseudo" data-type="text" order="ascending"/>
										     		     <option value="{pseudo}"><xsl:value-of select="pseudo"/></option>	
														</xsl:for-each>
										</select>
								</td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 49]"/>:</td>
								<td><input type="text" name="startdate" value="{$presentdate}" onClick="cal.select(this, 'startdate', 'yyyyMMdd');" maxlength="8" class="mini"/></td>
							</tr>
							<tr>
								<td  class="xp_sel"><xsl:value-of select="$string[$classbasestring + 50]"/>:</td>
 								<td><input type="text" name="enddate" value="{enddate}" onClick="cal.select(this, 'enddate', 'yyyyMMdd');" maxlength="8" class="mini"/></td>
							</tr>
							<tr>
								<td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 56]"/>:</td>
 								<td>
										<select name="state">
										<xsl:variable name="actualstate" select="state"/>
										<xsl:for-each select="document($listfile)//lists/list[name='OnOff']/entries/entry">
										<xsl:sort select="id" data-type="text" order="ascending"/>	
												 <option value="{value}"><xsl:if test="value=$actualstate"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
												 				 <xsl:value-of select="caption"/>
												 </option>
										</xsl:for-each>
										</select>
								 </td>
							</tr>
						</table>
						<table align="right">
							<tr  align="right">
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;user=0';"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>

	<!-- Edit one publisher -->
	<xsl:template name="classified_UserEdit">
	<table bgcolor="white" width="100%"><tr><td>
			<xsl:for-each select="document($classifiedfile)//user[id = $user]">
			<xsl:variable name="userpseudo" select="userpseudo"/>
			<form action="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;user=0" method="post">
						<input type="hidden" name="file" value="classified"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="classified/users/user[id={$user}]"/>

							<table width="100%" class="block">
										 <tr>
										 		 <td colspan="2" align="center"><a class="cat"><xsl:value-of select="$string[$classbasestring + 19]"/></a><br/></td>
										 </tr>
										 <tr>
										 		 <td class="xp_sel"><xsl:value-of select="$string[131]"/>:</td>
 										 		 <td><a href="default.asp?ACT=1&amp;SECT=M8&amp;id={document($memberfile)//member[pseudo=$userpseudo]/id}" title="{$string[$classbasestring + 76]}"><xsl:value-of select="document($memberfile)//member[pseudo=$userpseudo]/pseudo"/></a></td>
										 </tr>
										 <tr>
										 		 <td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 13]"/>:</td>
 										 		 <td><xsl:value-of select="document($memberfile)//member[pseudo=$userpseudo]/userfname"/></td>
										 </tr>
										 <tr>
										 		 <td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 14]"/>:</td>
 										 		 <td><xsl:value-of select="document($memberfile)//member[pseudo=$userpseudo]/userlname"/></td>
										 </tr>
										 <tr>
										 		 <td class="xp_sel"><xsl:value-of select="$string[133]"/>:</td>
 										 		 <td><xsl:value-of select="document($memberfile)//member[pseudo=$userpseudo]/email"/></td>
										 </tr>
										 <tr>
										 		 <td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 15]"/>:</td>
 										 		 <td><xsl:value-of select="document($memberfile)//member[pseudo=$userpseudo]/userpage"/></td>
										 </tr>
										 <tr>
										 		 <td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 18]"/>:</td>
 										 		 <td><xsl:value-of select="document($memberfile)//member[pseudo=$userpseudo]/useradress"/></td>
										 </tr>
										 <tr>
										 		 <td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 19]"/>:</td>
 										 		 <td><xsl:value-of select="document($memberfile)//member[pseudo=$userpseudo]/userzip"/></td>
										 </tr>
										 <tr>
										 		 <td class="xp_sel"><xsl:value-of select="$string[134]"/>:</td>
 										 		 <td><xsl:value-of select="document($memberfile)//member[pseudo=$userpseudo]/ville"/></td>
										 </tr>
										 <tr>
										 		 <td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 7]"/>:</td>
 										 		 <td><xsl:value-of select="document($memberfile)//member[pseudo=$userpseudo]/userstate"/></td>
										 </tr>
										 <tr>
										 		 <td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 8]"/>:</td>
 										 		 <td><xsl:value-of select="document($memberfile)//member[pseudo=$userpseudo]/usercountry"/></td>
										 </tr>										 										 										 
										 <tr>
										 		 <td class="xp_sel"><xsl:value-of select="$string[$mmbasestring + 20]"/>:</td>
 										 		 <td><xsl:value-of select="document($memberfile)//member[pseudo=$userpseudo]/userphone"/></td>
										 </tr>
										 <tr>
										 		 <td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 49]"/>:</td>
 										 		 <td><input type="text" name="startdate" value="{startdate}" onClick="cal.select(this, 'startdate', 'yyyyMMdd');" maxlength="8" class="mini"/></td>
										 </tr>
										 <tr>
										 		 <td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 50]"/>:</td>
 										 		 <td><input type="text" name="enddate" value="{enddate}" onClick="cal.select(this, 'enddate', 'yyyyMMdd');" maxlength="8" class="mini"/></td>
										 </tr>
										 <tr>
										 		 <td class="xp_sel"><xsl:value-of select="$string[$classbasestring + 56]"/>:</td>
 										 		 <td>
												 		 <select name="state">
														 <xsl:variable name="actualstate" select="state"/>
														 <xsl:for-each select="document($listfile)//lists/list[name='OnOff']/entries/entry">
														 <xsl:sort select="id" data-type="text" order="ascending"/>	
																	<option value="{value}"><xsl:if test="value=$actualstate"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
																			 <xsl:value-of select="caption"/>
																	</option>
														 </xsl:for-each>
														 </select>
												 </td>
										 </tr>
										 <xsl:if test="count(document($classifiedfile)//add[owner=$userpseudo])&gt; 0">
										 <tr>
										 		 <td colspan="2" align="center">
												 <a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=useradds&amp;user={$userpseudo}"><xsl:value-of select="$string[$classbasestring + 21]"/></a>
												 </td>
										 </tr>
										 </xsl:if>
										 <tr>
										 		 <td colspan="2" align="right">
												 <input type="submit" value="{$string[18]}"/>
												 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
												 <input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;user=0';"/>
												 </td>
										 </tr>								 
							</table>
			</form>
			<form action="default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;user=0" method="post" onsubmit="return confirm('{$string[$classbasestring + 57]}');">
			<table bgcolor="white" width="100%" class="block">
						<tr>
								<td colspan="2" align="right">						
										<input type="hidden" name="file" value="classified"/>
										<input type="hidden" name="operation" value="delete"/>
										<input type="hidden" name="node" value="classified/users/user[id={$user}]"/>
										<input type="submit" value="{$string[16]}"/>						
								</td>
						</tr>
			</table>
			</form>
			</xsl:for-each>
	</td></tr></table>		
	</xsl:template>
	
	<!-- List all Announcements owned by a specific publisher --> 
	<xsl:template name="classified_UserAddsList">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr align="center">
				<td class="header" width="20"><xsl:value-of select="$string[127]"/></td>
				<td class="header"><xsl:value-of select="$string[142]"/></td>
				<td class="header"><xsl:value-of select="$string[$classbasestring + 41]"/></td>
				<td class="header"><xsl:value-of select="$string[$classbasestring + 43]"/></td>
				<td class="header"><xsl:value-of select="$string[$classbasestring + 42]"/></td>
			</tr>			
			<xsl:for-each select="document($classifiedfile)//add[owner = $user]">
					<xsl:sort select="id" data-type="number" order="ascending"/>
							<xsl:if test="position() &gt; number($page*$classified_pagesize) and position() &lt;= number(($page+1)*$classified_pagesize) ">
								<xsl:call-template name="classifiedadd_list">
									<xsl:with-param name="addOwner" select="owner"/>
								</xsl:call-template>
							</xsl:if>
					</xsl:for-each>
			<tr>
			<td colspan="6" align="center">
				<xsl:call-template name="paging_Rail_macro">
					<xsl:with-param name="totalpage" select="count(document($classifiedfile)//add[owner = $user]) div $classified_pagesize"/>
					<xsl:with-param name="currentpage" select="number($page)+1"/>
					<xsl:with-param name="url">default.asp?ACT=1&amp;SECT=M70&amp;cmd={$cmd}&amp;user={$user}</xsl:with-param>
				</xsl:call-template>
			</td>
			</tr>
			<tr><td colspan="6" align="right"><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M70&amp;cmd=view&amp;add=0';" type="button" value="{$string[$classbasestring + 11]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M70&amp;cmd=edit&amp;user={document($classifiedfile)//user[userpseudo=$user]/id}';" type="button" value="{$string[$classbasestring + 18]}"/></td></tr>
		</table>
	</xsl:template>
		
</xsl:stylesheet>				
