<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve">
<xsl:output method="html"/> 

<!-- Webpages Template : add/update/modify -->
<!-- last modified : 2001/10/26, by J.Roland -->
<!-- version 1.0 -->

	<xsl:template name="guestbook_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Guestbook</xsl:with-param>
			<xsl:with-param name="version">1.0</xsl:with-param>
			<xsl:with-param name="moddate">07.11.2001</xsl:with-param>
			<xsl:with-param name="author">John Roland, JeS</xsl:with-param>
			<xsl:with-param name="url">http://www.fullxml.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="guestbook_manager">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M9"><img src="admin/media/posts.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[140]"/></font></td></tr>
		</table>
		<xsl:choose>
			<xsl:when test="$id=''">
				<xsl:call-template name="guestbook_list"/>

			</xsl:when>
			<xsl:when test="$id='new'">
				<xsl:call-template name="guestbook_add"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="document($guestbookfile)//guests/guest[id=$id]">
					<xsl:call-template name="guestbook_update"/>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<!-- liste des messages du guestbook -->
	<xsl:template name="guestbook_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr>
				<td class="header" width="16"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td  class="header" width="16">Id</td>
				<td class="header" width="100"><xsl:value-of select="$string[141]"/></td>
				<td class="header"><xsl:value-of select="$string[142]"/></td>
				<td class="header" width="100"><xsl:value-of select="$string[144]"/></td>
			</tr>			
			
			<xsl:for-each select="document($guestbookfile)//guests/guest">								
				<xsl:sort select="date" order="descending"></xsl:sort>
				<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M9&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td><img src="admin/media/{visible}.gif" width="16" height="15"/></td>
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2"><xsl:value-of select="from"/></td>
					<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M9&amp;id={id}"><xsl:value-of select="title"/></a></td>
					<td class="data2"><xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template></td>
				</tr>
			</xsl:for-each>								
			
			<tr><td colspan="5" align="right">
				<input type="button" value="{$string[15]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M9&amp;id=new';"/>
			</td></tr>
		</table>
	</xsl:template>
	
	
	
	<xsl:template name="guestbook_update">
		
		<table bgcolor="white"><tr><td>			
			<table class="block">
				<form action="default.asp?ACT=1&amp;SECT=M9" method="post" name="frmFullxml">
				<input type="hidden" name="operation" value="update"/>
				<input type="hidden" name="node" value="guests/guest[id={id}]"/>
				<input type="hidden" name="file" value="guestbook"/>
					<tr><td class="xp_sel"><xsl:value-of select="$string[141]"/>:</td><td><input type="text" value="{from}" name="from" class="full"/></td></tr>							
					<tr><td class="xp_sel"><xsl:value-of select="$string[142]"/>:</td><td><input type="text" value="{title}" name="title" class="full"/></td></tr>
					<tr><td class="xp_sel">
						<xsl:value-of select="$string[143]"/>:</td><td><textarea name="body" class="textarea" title="{$string[438]}"><xsl:value-of select="body"/></textarea>
						<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('body');</script></xsl:if>
					</td></tr>
					
					<tr><td class="xp_sel"><xsl:value-of select="$string[145]"/>:</td><td><input type="text" value="{email}" name="email" class="full"/></td></tr>								
					<tr><td class="xp_sel"><xsl:value-of select="$string[146]"/>:</td><td><select name="visible"><option value="off"><xsl:if test="visible='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>not visible</option><option value="on"><xsl:if test="visible='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> visible</option></select></td></tr>
					
					<tr>
						<td colspan="2" align="right">
							<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
							<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M9'"/>
						</td>
					</tr>
				</form>
			</table>
			<table class="block">
				<tr><form action="default.asp?ACT=1&amp;SECT=M9" method="post" onsubmit="return confirm('{$string[147]}');">
					<td colspan="2" align="right">
						<input type="hidden" name="operation" value="delete"/>
						<input type="hidden" name="node" value="guests/guest[id={id}]"/>
						<input type="hidden" name="file" value="guestbook"/>
						<input type="submit" value="{$string[16]}"/>
					</td></form>
				</tr>
			</table>
		</td></tr></table>
	</xsl:template>


	<!-- addPost template  -->
	<xsl:template name="guestbook_add">
		<table bgcolor="white"><tr><td>
			<form action="default.asp?ACT=1&amp;SECT=M9" method="post" name="frmFullxml">
				<input type="hidden" name="file" value="guestbook"/>
				<input type="hidden" name="operation" value="add"/>
				<input type="hidden" name="bloc" value="guests"/>
				<input type="hidden" name="node" value="guest"/>
					
			<table class="block">					
				<tr><td class="xp_sel"><xsl:value-of select="$string[141]"/>:</td><td><input type="text" value="" name="from" class="full"/></td></tr>							
				<tr><td class="xp_sel"><xsl:value-of select="$string[142]"/>:</td><td><input type="text" value="" name="title" class="full"/></td></tr>							
				<tr><td class="xp_sel">
					<xsl:value-of select="$string[143]"/>:</td><td><textarea name="body" class="textarea" title="{$string[438]}"><xsl:value-of select="body"/></textarea>
					<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('body');</script></xsl:if>
				</td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[145]"/>:</td><td><input type="text" value="" name="email" class="full"/></td></tr>							
				<tr><td class="xp_sel"><xsl:value-of select="$string[146]"/>:</td><td><select name="visible"><option value="off" selected="selected">not visible</option><option value="on"> visible</option></select></td></tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M9'"/>
					</td>
				</tr>
			</table>
			</form>
		</td></tr></table>
	</xsl:template>
	
	
</xsl:stylesheet>
