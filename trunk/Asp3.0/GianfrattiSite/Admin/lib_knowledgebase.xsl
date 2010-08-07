<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb">
   <xsl:output method="html" indent="yes" encoding="iso-8859-1" />

	<xsl:template name="knowbase_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Knowledgebase</xsl:with-param>
			<xsl:with-param name="version">1.1</xsl:with-param>
			<xsl:with-param name="moddate">07.11.2003</xsl:with-param>
			<xsl:with-param name="author">Mig100 (Miguel Figueira) and JeS (Jens Schreiber)</xsl:with-param>
			<xsl:with-param name="url">http://www.fxmods.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--            main procedure            -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="help_kbeditor">
		<xsl:call-template name="kbnavigator"/>
		<xsl:choose>
			<xsl:when test="$usertype='administrator'">
				<xsl:choose>
					<xsl:when test="$type='sector'">
						<xsl:choose>
							<xsl:when test="$id">
								<xsl:choose>
									<xsl:when test="$id='new'">
										<xsl:call-template name="kb_sectoradd"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbsectors/sector[id=$id]">
											<xsl:call-template name="kb_sectorupdate"/>
										</xsl:for-each>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="kb_kbselect"/>
								<xsl:call-template name="kb_sectorlist"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$type='reference'">
						<xsl:choose>
							<xsl:when test="$id and $page">
								<xsl:choose>
									<xsl:when test="$id='new'">
										<xsl:call-template name="kb_referenceadd"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbreferences/reference[id=$id]">
											<xsl:call-template name="kb_referenceupdate"/>
										</xsl:for-each>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								Not implemented
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$type='post'">
						<xsl:choose>
							<xsl:when test="$id">
								<xsl:choose>
									<xsl:when test="$id='new'">
										<xsl:call-template name="kb_postadd"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post[id=$id]">
											<xsl:call-template name="kb_postupdate"/>
										</xsl:for-each>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="kb_kbselect"/>
								<xsl:call-template name="kb_postlist"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$type='knowbase'">
						<xsl:choose>
							<xsl:when test="$id">
								<xsl:choose>
									<xsl:when test="$id='new'">
										<xsl:call-template name="kb_knowbaseadd"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:for-each select="document($kbfile)/kb/knowbase[id=$id]">
											<xsl:call-template name="kb_knowbaseupdate"/>
										</xsl:for-each>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="kb_knowbaselist"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="kb_knowbaselist"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
			<!-- usertype editor is able to add/update posts only -->
				<xsl:choose>
					<xsl:when test="$type='reference'">
						<xsl:choose>
							<xsl:when test="$id and $page">
								<xsl:choose>
									<xsl:when test="$id='new'">
										<xsl:call-template name="kb_referenceadd"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbreferences/reference[id=$id]">
											<xsl:call-template name="kb_referenceupdate"/>
										</xsl:for-each>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								Not possible
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$type='post'">
						<xsl:choose>
							<xsl:when test="$id">
								<xsl:choose>
									<xsl:when test="$id='new'">
										<xsl:call-template name="kb_postadd"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post[id=$id]">
											<xsl:call-template name="kb_postupdate"/>
										</xsl:for-each>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="kb_kbselect"/>
								<xsl:call-template name="kb_postlist"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="kb_postlist"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--         navigator at the top         -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="kbnavigator">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr>
				<xsl:if test="$usertype='administrator'">
					<td align="center">
						<a href="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type=option">
							<img src="admin/media/kboption.gif" border="0"/>
						</a>
					</td>
					<td align="center">
						<a href="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type=sector">
							<img src="admin/media/kbsector.gif" border="0"/>
						</a>
					</td>
				</xsl:if>
				<td align="center">
					<a href="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type=post">
						<img src="admin/media/kbpost.gif" border="0"/>
					</a>
				</td>
			</tr>
			<tr>
				<xsl:if test="$usertype='administrator'">
					<td align="center"><xsl:value-of select="$string[$kb_basestring + 13]"/></td>
					<td align="center"><xsl:value-of select="$string[$kb_basestring + 14]"/></td>
				</xsl:if>
				<td align="center"><xsl:value-of select="$string[$kb_basestring + 15]"/></td>
			</tr>
		</table>
	</xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--                Lists                 -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--     selectbox for all knowbases      -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="kb_kbselect">
		<table bgcolor="white" border="0" cellpadding="0" cellspacing="1" width="100%">
			<form name="frmKB" action="default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}" method="post">
				<tr><td width="40%"><font size="3"><xsl:value-of select="$string[$kb_basestring + 13]"/>: </font>
				<select name="kbid" onchange="document.frmKB.submit();return;">
					<xsl:for-each select="document($kbfile)/kb/knowbase">
						<xsl:sort select="title" order="ascending"/>
						<xsl:choose>
							<xsl:when test="$usertype='member'">
								<xsl:if test="group='Anonymous' or group='Member'">
									<xsl:call-template name="kb_selectentry"/>
								</xsl:if>
							</xsl:when>
							<xsl:when test="$usertype='editor'">
								<xsl:if test="group='Anonymous' or group='Member' or group='Editor'">
									<xsl:call-template name="kb_selectentry"/>
								</xsl:if>
							</xsl:when>
							<xsl:when test="$usertype='administrator'">
								<xsl:call-template name="kb_selectentry"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="group='Anonymous'">
									<xsl:call-template name="kb_selectentry"/>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</select>
				</td>
				<td width="60%" align="left">
					<input type="submit" value="{$string[$kb_basestring + 36]}"/>
				</td>
				</tr>
			</form>
		</table>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--   entry for selectbox for knowbases  -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="kb_selectentry">
		<xsl:variable name="knowbaseid"><xsl:value-of select="id"/></xsl:variable>
		<xsl:choose>
			<xsl:when test="$kbid=$knowbaseid">
				<option value="{$knowbaseid}"><xsl:attribute name="selected">selected</xsl:attribute><xsl:value-of select="title"/></option>
			</xsl:when>
			<xsl:otherwise>
				<option value="{$knowbaseid}"><xsl:value-of select="title"/></option>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--        list of all knowbases         -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="kb_knowbaselist">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">
			<tr>
				<td class="header" width="16">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td class="header" width="50"><xsl:value-of select="$string[$kb_basestring + 20]"/></td>
				<td class="header"><xsl:value-of select="$string[$kb_basestring + 21]"/></td>
			</tr>
			<xsl:for-each select="document($kbfile)/kb/knowbase">
				<tr bgcolor="white" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td><a href="default.asp?ACT=90&amp;kbid={id}&amp;item=0"><img src="admin/media/{visible}.gif" width="16" height="15" border="0"/></a></td>
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2">
						<a href="default.asp?ACT=1&amp;SECT={$section}&amp;type=knowbase&amp;id={id}"><xsl:value-of select="title"/></a>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<input type="submit" value="{$string[420]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;type=knowbase&amp;id=new';"/>
	</xsl:template>


	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--         list of all sectors          -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="kb_sectorlist">
		<xsl:if test="$kbid">
			<table border="0" cellpadding="0" cellspacing="1" width="100%">		
				<tr>
					<td class="header" width="16">
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					</td>
					<td class="header" width="50"><xsl:value-of select="$string[$kb_basestring + 20]"/></td>
					<td class="header"><xsl:value-of select="$string[$kb_basestring + 21]"/></td>
				</tr>
				<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbsectors/sector">
					<tr bgcolor="white" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
						<td><a href="default.asp?ACT=90&amp;kbid={$kbid}&amp;grp={id}"><img src="admin/media/{visible}.gif" width="16" height="15" border="0"/></a></td>
						<td class="data2"><xsl:value-of select="id"/></td>
						<td class="data2">
							<a href="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type={$type}&amp;id={id}"><xsl:value-of select="name"/></a>
						</td>
					</tr>
				</xsl:for-each>
			</table>
			<input type="submit" value="{$string[420]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type={$type}&amp;id=new';"/>
		</xsl:if>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--   show subheader for list of posts   -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="kb_postlist_sector">
		<xsl:variable name="sectorid" select="id"/>
		<xsl:choose>
			<xsl:when test="$usertype='administrator'">
				<xsl:if test="count(document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post[sectorid=$sectorid])>0">
					<tr><td colspan="6" align="center"><font color="white"><b>-=<xsl:value-of select="name"/>=-</b></font></td></tr>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="count(document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post[sectorid=$sectorid and author=$username])>0">
					<tr><td colspan="6" align="center"><font color="white"><b>-=<xsl:value-of select="name"/>=-</b></font></td></tr>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--          list of all posts           -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="kb_postlist">
		<xsl:if test="$kbid">
			<table border="0" cellpadding="0" cellspacing="1" width="100%">		
				<tr>
					<td class="header" width="16">
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					</td>
					<td class="header" width="50"><xsl:value-of select="$string[$kb_basestring + 20]"/></td>
					<td class="header"><xsl:value-of select="$string[$kb_basestring + 16]"/></td>
					<td class="header" width="100"><xsl:value-of select="$string[74]"/></td>

					<xsl:choose>
						<xsl:when test="$usertype='administrator'">
							<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbsectors/sector">
								<xsl:call-template name="kb_postlist_sector"/>
								<xsl:variable name="sectorid" select="id"/>
								<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post[sectorid=$sectorid]">
									<tr bgcolor="white" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
										<td><a href="default.asp?ACT=90&amp;kbid={$kbid}&amp;item={id}"><img src="admin/media/{visible}.gif" width="16" height="15" border="0"/></a></td>
										<td class="data2"><xsl:value-of select="id"/></td>
										<td class="data2"><a href="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type=post&amp;id={id}"><xsl:value-of select="title"/></a></td>
										<td class="data2"><xsl:value-of select="author"/></td>
									</tr>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbsectors/sector">
								<xsl:call-template name="kb_postlist_sector"/>
								<xsl:variable name="sectorid" select="id"/>
								<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post[sectorid=$sectorid and author=$username]">
									<tr bgcolor="white" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
										<td><a href="default.asp?ACT=90&amp;kbid={$kbid}&amp;item={id}"><img src="admin/media/{visible}.gif" width="16" height="15" border="0"/></a></td>
										<td class="data2"><xsl:value-of select="id"/></td>
										<td class="data2"><a href="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type=post&amp;id={id}"><xsl:value-of select="title"/></a></td>
										<td class="data2"><xsl:value-of select="author"/></td>
									</tr>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:otherwise>
					</xsl:choose>
				</tr>

			</table>
			<input type="submit" value="{$string[420]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;id=new&amp;type=post';"/>
		</xsl:if>
	</xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--               Editors                -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--        show title of knowbase        -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="kb_knowbasetitle">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr>
				<td>
					<font size="3"><xsl:value-of select="$string[$kb_basestring + 0]"/>: <xsl:value-of select="document($kbfile)/kb/knowbase[id=$kbid]/title"/></font>
				</td>
			</tr>
		</table>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--      editor for knowbase (new)       -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="kb_knowbaseadd">
		<table bgcolor="white">
			<form action="default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="knowbase"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="bloc" value="kb"/>
						<input type="hidden" name="node" value="knowbase"/>
						<input type="hidden" name="kbsectors" value="all related sectors"/>
						<input type="hidden" name="kbposts" value="all related posts"/>
						<input type="hidden" name="kbreferences" value="all related references"/>

						<table class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 16]"/>:
								</td>
								<td>
									<input type="text" name="title" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 17]"/>:
								</td>
								<td>
									<input type="text" name="version" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 18]"/>:
								</td>
								<td>
									<textarea  class="textarea" name="intro" title="Intro"></textarea>
									<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('intro');</script></xsl:if>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[56]"/>:
								</td>
								<td>
									<select name="group">
										<option value="Anonymous"><xsl:value-of select="$string[$kb_basestring + 32]"/></option>
										<option value="Member"><xsl:attribute name="selected">selected</xsl:attribute><xsl:value-of select="$string[430]"/></option>
										<option value="Editor"><xsl:value-of select="$string[429]"/></option>
										<option value="Administrator"><xsl:value-of select="$string[428]"/></option>
									</select>  
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 23]"/>:
								</td>
								<td>
									<select name="visible">
										<option value="off"><xsl:value-of select="$string[61]"/></option>
										<option value="on"><xsl:attribute name="selected">selected</xsl:attribute><xsl:value-of select="$string[60]"/></option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 19]"/>:
								</td>
								<td>
									<select name="display">
										<option value="Linear"><xsl:attribute name="selected">selected</xsl:attribute><xsl:value-of select="$string[$kb_basestring + 1]"/></option>
										<option value="Structure"><xsl:value-of select="$string[$kb_basestring + 2]"/></option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}';"/>
								</td>
							</tr>
						</table>
						<br/>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--    editor for knowbase (update)      -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="kb_knowbaseupdate">
		<table bgcolor="white">
			<form action="default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}" method="post" name="frmFullxml">
				<tr>
					<td>
					    	<input type="hidden" name="file" value="knowbase"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="kb/knowbase[id={$id}]"/>
						<input type="hidden" name="kbsectors" value="all related sectors"/>
						<input type="hidden" name="kbposts" value="all related posts"/>
						<input type="hidden" name="kbreferences" value="all related references"/>

						<table class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 16]"/>:
								</td>
								<td>
									<input type="text" value="{title}" name="title" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 17]"/>:
								</td>
								<td>
									<input type="text" value="{version}" name="version" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 18]"/>:
								</td>
								<td>
									<textarea  class="textarea" name="intro" title="Intro"><xsl:value-of select="intro" disable-output-escaping="no"/></textarea>
									<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('intro');</script></xsl:if>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[56]"/>:
								</td>
								<td>
									<select name="group">
										<option value="Anonymous"><xsl:if test="group='Anonymous'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[$kb_basestring + 32]"/></option>
										<option value="Member"><xsl:if test="group='Member'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[430]"/></option>
										<option value="Editor"><xsl:if test="group='Editor'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[429]"/></option>
										<option value="Administrator"><xsl:if test="group='Administrator'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[428]"/></option>
									</select>  
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 23]"/>:
								</td>
								<td>
									<select name="visible">
										<option value="off"><xsl:if test="visible='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[61]"/></option>
										<option value="on"><xsl:if test="visible='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[60]"/></option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 19]"/>:
								</td>
								<td>
									<select name="display">
										<option value="Linear"><xsl:if test="display='Linear'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[$kb_basestring + 1]"/></option>
										<option value="Structure"><xsl:if test="display='Structure'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[$kb_basestring + 2]"/></option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}';"/>
								</td>
							</tr>
						</table>
						<br/>
					</td>
				</tr>
			</form>
			<xsl:if test="$usertype='administrator'">
				<tr>
					<td>
						<form action="default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}" method="post" onsubmit="return confirm('{$string[83]}');">
							<table class="block">
								<tr>
									<td bgcolor="white" align="right">
								    	<input type="hidden" name="file" value="knowbase"/>
										<input type="hidden" name="operation" value="delete"/>
										<input type="hidden" name="node" value="kb/knowbase[id={$id}]"/>
										<input type="submit" value="{$string[16]}"/>
									</td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--        editor for sector (new)       -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

	<xsl:template name="kb_sectoradd">
		<xsl:call-template name="kb_knowbasetitle"/>
		<table bgcolor="white">
			<form action="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type={$type}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="knowbase"/>
						<input type="hidden" name="node" value="sector"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="bloc" value="kb/knowbase[id={$kbid}]/kbsectors"/>

						<table class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 21]"/>:
								</td>
								<td>
									<input type="text" name="name" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 22]"/>:
								</td>
								<td>
									<textarea  class="textarea" name="remark" title="Remark"></textarea>
									<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('remark');</script></xsl:if>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 23]"/>:
								</td>
								<td>
									<select name="visible">
										<option value="off"><xsl:value-of select="$string[61]"/></option>
										<option value="on"><xsl:attribute name="selected">selected</xsl:attribute><xsl:value-of select="$string[60]"/></option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}';"/>
								</td>
							</tr>
						</table>
						<br/>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--       editor for sector (update)     -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

	<xsl:template name="kb_sectorupdate">
		<xsl:call-template name="kb_knowbasetitle"/>
		<table bgcolor="white">
			<tr>
				<td>
					<form action="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type={$type}" method="post" name="frmFullxml">
				    		<input type="hidden" name="file" value="knowbase"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="kb/knowbase[id={$kbid}]/kbsectors/sector[id={$id}]"/>

						<table class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 21]"/>:
								</td>
								<td>
									<input type="text" value="{name}" name="name" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 22]"/>:
								</td>
								<td>
									<textarea  class="textarea" name="remark" title="Remark"><xsl:value-of select="remark" disable-output-escaping="no"/></textarea>
									<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('remark');</script></xsl:if>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 23]"/>:
								</td>
								<td>
									<select name="visible">
										<option value="off"><xsl:if test="visible='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[61]"/></option>
										<option value="on"><xsl:if test="visible='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[60]"/></option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}';"/>
								</td>
							</tr>
						</table>
					</form>
				</td>
			</tr>
			<xsl:if test="$usertype='administrator' and count(document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post[sectorid=$id])=0">
				<tr>
					<td>
						<form action="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type={$type}" method="post" onsubmit="return confirm('{$string[83]}');">
							<table class="block">
								<tr>
									<td bgcolor="white" align="right">
										<xsl:value-of select="$string[$kb_basestring + 34]"/>
									    	<input type="hidden" name="file" value="knowbase"/>
										<input type="hidden" name="operation" value="delete"/>
										<input type="hidden" name="node" value="kb/knowbase[id={$kbid}]/kbsectors/sector[id={$id}]"/>
										<input type="submit" value="{$string[16]}"/>
									</td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>


	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--         editor for post (new)        -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="kb_postadd">
		<xsl:call-template name="kb_knowbasetitle"/>
		<table bgcolor="white">
			<form action="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type={$type}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="file" value="knowbase"/>
						<input type="hidden" name="bloc" value="kb/knowbase[id={$kbid}]/kbposts"/>
						<input type="hidden" name="node" value="post"/>

						<table class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 24]"/>:
								</td>
								<td>
									<select name="sectorid" class="full">
										<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbsectors/sector">
											<xsl:sort select="name"/>
											<xsl:variable name="sectorid" select="id"/>
											<option value="{$sectorid}">
												<xsl:value-of select="name"/>
											</option>
										</xsl:for-each>
									</select>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 16]"/>:
								</td>
								<td>
									<input type="text" name="title" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 25]"/>:
								</td>
								<td>
									<textarea  class="textarea" name="body" title="Body"></textarea>
									<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('body');</script></xsl:if>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[74]"/>:
								</td>
								<td>
									<input type="text" name="author" class="mini" value="{$username}"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 23]"/>:
								</td>
								<td>
									<select name="visible">
										<option value="off"><xsl:value-of select="$string[61]"/></option>
										<option value="on" selected="selected"><xsl:value-of select="$string[60]"/></option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}';"/>
								</td>
							</tr>

						</table>
						<br/>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--        editor for post (update)      -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="kb_postupdate">
		<xsl:call-template name="kb_knowbasetitle"/>
		<table bgcolor="white">
			<tr>
				<td>
					<form action="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type={$type}" method="post" name="frmFullxml">
					    	<input type="hidden" name="file" value="knowbase"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="kb/knowbase[id={$kbid}]/kbposts/post[id={$id}]"/>
						<table class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 24]"/>:
								</td>
								<td>
									<xsl:variable name="psectorid" select="sectorid"/>
									<select name="sectorid" class="full">
										<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbsectors/sector">
											<xsl:sort select="name"/>
											<xsl:variable name="ssectorid" select="id"/>
											<xsl:choose>
												<xsl:when test="id=$psectorid">
													<option selected="selected" value="{id}"><xsl:value-of select="name"/></option>
												</xsl:when>
												<xsl:otherwise>
													<option value="{id}"><xsl:value-of select="name"/></option>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:for-each>
									</select>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 16]"/>:
								</td>
								<td>
									<input type="text" value="{title}" name="title" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 25]"/>:
								</td>
								<td>
									<textarea  class="textarea" name="body" title="Body"><xsl:value-of select="body" disable-output-escaping="no"/></textarea>
									<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('body');</script></xsl:if>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[74]"/>:
								</td>
								<td>
									<input type="text" value="{author}" name="author" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$kb_basestring + 23]"/>:
								</td>
								<td>
									<select name="visible">
										<option value="off"><xsl:if test="visible='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[61]"/></option>
										<option value="on"><xsl:if test="visible='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[60]"/></option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}';"/>
								</td>
							</tr>
						</table>
					</form>
				</td>
			</tr>
			<xsl:if test="$usertype='administrator'">
				<tr>
					<td>
						<xsl:choose>
							<xsl:when test="count(document($kbfile)/kb/knowbase[id=$kbid]/kbreferences/reference[postid=$id or refid=$id])>0">
								<form action="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type={$type}&amp;id={$id}" method="post" onsubmit="return confirm('{$string[83]}');">
									<table class="block">
										<tr>
											<td bgcolor="white" align="right">
											    	<input type="hidden" name="file" value="knowbase"/>
												<input type="hidden" name="operation" value="delete"/>
												<input type="hidden" name="node" value="kb/knowbase[id={$kbid}]/kbreferences/reference[postid={$id} or refid={$id}]"/>
												<input type="submit" value="{$string[$kb_basestring + 35]}"/>
											</td>
										</tr>
									</table>
								</form>
							</xsl:when>
							<xsl:otherwise>
								<form action="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type={$type}" method="post" onsubmit="return confirm('{$string[83]}');">
									<table class="block">
										<tr>
											<td bgcolor="white" align="right">
												<input type="hidden" name="file" value="knowbase"/>
												<input type="hidden" name="operation" value="delete"/>
												<input type="hidden" name="node" value="kb/knowbase[id={$kbid}]/kbposts/post[id={$id}]"/>
												<input type="submit" value="{$string[16]}"/>
											</td>
										</tr>
									</table>
								</form>
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
			</xsl:if>
			<tr>
				<td>
					<table class="block">
						<tr>
							<td class="xp_sel"><xsl:value-of select="$string[$kb_basestring + 5]"/></td>
						</tr>
						<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbreferences/reference[postid=$id]">
							<xsl:variable name="postid" select="refid"/>
							<xsl:variable name="refid" select="id"/>
							<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post[id=$postid]">
								<tr>
									<td>				
										<a href="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type=reference&amp;page={$id}&amp;id={$refid}"><xsl:value-of select="title"/></a>
									</td>
								</tr>
							</xsl:for-each>
						</xsl:for-each>
						<tr>
							<td>				
								<a href="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type=reference&amp;page={$id}&amp;id=new"><xsl:value-of select="$string[$kb_basestring + 26]"/></a>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table class="block">
						<tr>
							<td class="xp_sel"><xsl:value-of select="$string[$kb_basestring + 29]"/></td>
						</tr>
						<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbreferences/reference[refid=$id]">
							<xsl:variable name="postid" select="postid"/>
							<xsl:variable name="refid" select="id"/>
							<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post[id=$postid]">
								<tr>
									<td>				
										<a href="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type={$type}&amp;id={$postid}"><xsl:value-of select="title"/></a>
									</td>
								</tr>
							</xsl:for-each>
						</xsl:for-each>
					</table>
				</td>
			</tr>
		</table>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--        Editor for References         -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--  search module for reference editor  -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="kb_referencesearch">
		<xsl:param name="searchstring">-</xsl:param>
		<xsl:param name="posttitle">+</xsl:param>
		<xsl:param name="postbody">+</xsl:param>
		<xsl:variable name="searchsub">
			<xsl:choose>
				<xsl:when test="contains($searchstring, ' ')">
					<xsl:value-of select="substring-before($searchstring,' ')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$searchstring"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="contains($posttitle, $searchsub) or contains($postbody, $searchsub)">
			<xsl:choose>
				<xsl:when test="string-length($searchstring)>0">
					<xsl:call-template name="kb_referencesearch">
						<xsl:with-param name="searchstring"><xsl:value-of select="substring-after($searchstring, ' ')"/></xsl:with-param>
						<xsl:with-param name="posttitle"><xsl:value-of select="$posttitle"/></xsl:with-param>
						<xsl:with-param name="postbody"><xsl:value-of select="$postbody"/></xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="postid"><xsl:value-of select="id"/></xsl:variable>
					<tr bgcolor="white" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
						<td class="data2"><xsl:value-of select="$postid"/></td>
						<td class="data2"><a href="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type={$type}&amp;page={$page}&amp;id={$id}&amp;refid={$postid}"><xsl:value-of select="title"/></a></td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--   search form for reference editor   -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="kb_referencesearchform">
		<!-- turn to lower case -->
		<xsl:variable name="up" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÜÄÖéèà'" />
		<xsl:variable name="low" select="'abcdefghijklmnopqrstuvwxyzüäöeea'" />
		<xsl:variable name="lowkeyword" select="translate($keyword,$up,$low)" />

		<table bgcolor="white" width="100%"><tr><td>
			<form action="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type={$type}&amp;page={$page}&amp;id={$id}" method="post" name="frmKBSearch">
				<table class="block" width="100%">
					<tr>
						<td class="xp_sel" width="20%">							
							<xsl:value-of select="$string[$kb_basestring + 6]"/>:
						</td>
						<td width="50%">
							<input type="text" class="full" style="width=100%" name="keyword"></input>
						
						</td>
						<td width="30%" align="right">
							<input type="submit" value="{$string[$kb_basestring + 6]}"/>
						</td>
					</tr>
				</table>
			</form>
			<xsl:if test="$keyword">
				<table bgcolor="gray" border="0" cellpadding="0" cellspacing="1" width="100%">
					<tr>
						<td class="header" width="50"><xsl:value-of select="$string[$kb_basestring + 20]"/></td>
						<td class="header"><xsl:value-of select="$string[$kb_basestring + 16]"/></td>
					</tr>
					<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post[visible='on']">
						<xsl:variable name="posttitle" select="translate(title,$up,$low)" />
						<xsl:variable name="postbody" select="translate(body,$up,$low)" />
						<xsl:call-template name="kb_referencesearch">
							<xsl:with-param name="searchstring"><xsl:value-of select="$lowkeyword"/></xsl:with-param>
							<xsl:with-param name="posttitle"><xsl:value-of select="$posttitle"/></xsl:with-param>
							<xsl:with-param name="postbody"><xsl:value-of select="$postbody"/></xsl:with-param>
						</xsl:call-template>
					</xsl:for-each>
				</table>
			</xsl:if>
		</td></tr></table>
	</xsl:template>
 

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--      editor for reference (new)      -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="kb_referenceadd">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr>
				<td>
					<font size="3"><xsl:value-of select="$string[$kb_basestring + 28]"/> "<xsl:value-of select="document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post[id=$page]/title"/>" <xsl:value-of select="$string[$kb_basestring + 44]"/>: "<xsl:value-of select="document($kbfile)/kb/knowbase[id=$kbid]/title"/>"</font>
				</td>
			</tr>
		</table>
		<table bgcolor="white" width="100%">
			<tr>
				<td>
					<form action="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type=post&amp;id={$page}" method="post" name="frmFullxml">
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="file" value="knowbase"/>
						<input type="hidden" name="bloc" value="kb/knowbase[id={$kbid}]/kbreferences"/>
						<input type="hidden" name="node" value="reference"/>
						<input type="hidden" name="postid" value="{$page}"/>

						<table class="block" width="100%">
							<tr>
								<td class="xp_sel" width="20%">
									<xsl:value-of select="$string[$kb_basestring + 27]"/>:
								</td>
								<td width="80%">
									<select name="refid" class="full" style="width: 100%">
										<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post">
											<xsl:choose>
												<xsl:when test="id=$refid">
													<option selected="selected" value="{id}"><xsl:value-of select="title"/></option>
												</xsl:when>
												<xsl:otherwise>
													<option value="{id}"><xsl:value-of select="title"/></option>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:for-each>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;type=post&amp;id={$page}';"/>
								</td>
							</tr>
						</table>
					</form>
				</td>
			</tr>
		</table>
		<xsl:call-template name="kb_referencesearchform"/>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--     editor for reference (update)    -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="kb_referenceupdate">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr>
				<td>
					<font size="3"><xsl:value-of select="$string[$kb_basestring + 28]"/> "<xsl:value-of select="document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post[id=$page]/title"/>" <xsl:value-of select="$string[$kb_basestring + 44]"/>: "<xsl:value-of select="document($kbfile)/kb/knowbase[id=$kbid]/title"/>"</font>
				</td>
			</tr>
		</table>
		<table bgcolor="white" width="100%">
			<tr>
				<td>
					<form action="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type=post&amp;id={$page}" method="post" name="frmFullxml">
					    	<input type="hidden" name="file" value="knowbase"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="kb/knowbase[id={$kbid}]/kbreferences/reference[id={$id}]"/>

						<table class="block" width="100%">
							<tr>
								<td class="xp_sel" width="20%">
									<xsl:value-of select="$string[$kb_basestring + 27]"/>::
								</td>
								<td width="80%">

									<select name="refid" class="full" style="width: 100%">
										<xsl:choose>
											<xsl:when test="$refid">
												<xsl:for-each select="document($kbfile)/kb/kbposts/post">
													<xsl:choose>
														<xsl:when test="id=$refid">
															<option selected="selected" value="{id}"><xsl:value-of select="title"/></option>
														</xsl:when>
														<xsl:otherwise>
															<option value="{id}"><xsl:value-of select="title"/></option>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:for-each>
											</xsl:when>
											<xsl:otherwise>
												<xsl:variable name="reference" select="refid"/>
												<xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post">
													<xsl:choose>
														<xsl:when test="id=$reference">
															<option selected="selected" value="{id}"><xsl:value-of select="title"/></option>
														</xsl:when>
														<xsl:otherwise>
															<option value="{id}"><xsl:value-of select="title"/></option>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:for-each>
											</xsl:otherwise>
										</xsl:choose>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;type=post&amp;id={$page}';"/>
								</td>
							</tr>
						</table>
					</form>
				</td>
			</tr>
			<xsl:if test="$usertype='administrator'">
				<tr>
					<td>
						<form action="default.asp?ACT=1&amp;SECT={$section}&amp;kbid={$kbid}&amp;type=post&amp;id={$page}" method="post" onsubmit="return confirm('{$string[83]}');">
							<table bgcolor="white" width="100%" class="block">
								<tr>
									<td bgcolor="white" align="right">
								    		<input type="hidden" name="file" value="knowbase"/>
										<input type="hidden" name="operation" value="delete"/>
										<input type="hidden" name="node" value="kb/knowbase[id={$kbid}]/kbreferences/reference[id={$id}]"/>
										<input type="submit" value="{$string[16]}"/>
									</td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</xsl:if>
		</table>
		<xsl:call-template name="kb_referencesearchform"/>
	</xsl:template>
	
</xsl:stylesheet>