<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve">
<xsl:output method="html"/> 

<!-- Reactions Template : add/update/modify -->
<!-- last modified : 2001/10/26, by J.Roland -->
<!-- version 1.0 -->

	<xsl:template name="reaction_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Reaction</xsl:with-param>
			<xsl:with-param name="version">1.0</xsl:with-param>
			<xsl:with-param name="moddate">26.10.2001</xsl:with-param>
			<xsl:with-param name="author">John Roland</xsl:with-param>
			<xsl:with-param name="url">http://www.fullxml.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="reactions_manager">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M10"><img src="admin/media/content.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[150]"/></font></td></tr>
		</table>					
		<xsl:choose>
			<xsl:when test="$id=''">
				<xsl:call-template name="reactions_list"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="document($reactfile)//reacts/react[id=$id]">
					<xsl:call-template name="reactions_update"/>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<xsl:template name="reactions_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr>
				<td class="header" width="16"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td class="header" width="16">Id</td>
				<td class="header"><xsl:value-of select="$string[151]"/></td>
				<td class="header"><xsl:value-of select="$string[152]"/></td>
				<td class="header"><xsl:value-of select="$string[153]"/></td>
			</tr>			
			<xsl:for-each select="document($reactfile)//reacts/react">								
				<xsl:variable name="myidcontent" select="idcontent"/>
				<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M10&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td><img src="admin/media/{visible}.gif" width="16" height="15"/></td>
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M10&amp;id={id}"><xsl:value-of select="pseudo"/></a></td>
					<td class="data2"><xsl:value-of select="title"/></td>
					<td class="data2"><xsl:value-of select="idcontent"/></td>
					<!--<td><xsl:value-of select="siteinfo/contents/content[id=$myidcontent]/title"/></td>-->
				</tr>
			</xsl:for-each>			
		</table>
	</xsl:template>
	
	
	<!-- configreaction template  -->
	<xsl:template name="reactions_update">		
		<table bgcolor="white"><tr><td>
			
		<table class="block">
			<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmFullxml">
			<input type="hidden" name="operation" value="update"/>
			<input type="hidden" name="file" value="reactions"/>
			<input type="hidden" name="node" value="reacts/react[id={id}]"/>
									
			<tr><td class="xp_sel"><xsl:value-of select="$string[152]"/>:</td><td><input type="text" value="{title}" name="title" class="full"/></td></tr>
			<tr><td class="xp_sel"><xsl:value-of select="$string[151]"/>:</td><td><input type="text" value="{pseudo}" name="pseudo" class="full"/></td></tr>
			<tr><td class="xp_sel"><xsl:value-of select="$string[155]"/>:</td><td><input type="text" value="{date}" name="date" class="full"/></td></tr>
			<tr><td class="xp_sel"><xsl:value-of select="$string[154]"/>:</td>
				<td>
					<textarea class="textarea" name="message" title="{$string[438]}"><xsl:value-of select="message" disable-output-escaping="yes"/></textarea>
					<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('message');</script></xsl:if>
				</td>
			</tr>
			<tr><td class="xp_sel"><xsl:value-of select="$string[156]"/>:</td><td><select name="visible"><option value="off"><xsl:if test="visible='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>not visible</option><option value="on"><xsl:if test="visible='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> visible</option></select></td></tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M10';"/>
				</td>
			</tr>
			</form>	
		</table>
		
		<table class="block">				
			<tr><form action="default.asp?ACT=1&amp;SECT={$section}" method="post" onsubmit="return confirm('{$string[157]}');">
				<td colspan="2" align="right">					
						<input type="hidden" name="operation" value="delete"/>
						<input type="hidden" name="file" value="reactions"/>
						<input type="hidden" name="node" value="reacts/react[id={id}]"/>
						<input type="submit" value="{$string[16]}"/>					
				</td></form>
			</tr>
		</table>
		
		</td></tr></table>
	</xsl:template>
	
</xsl:stylesheet>