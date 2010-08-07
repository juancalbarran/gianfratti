<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve">
<xsl:output method="html"/> 

<!-- Webpages Template : add/update/modify -->
<!-- last modified : 2001/10/26, by J.Roland -->
<!-- version 1.0 -->

	<xsl:template name="tip_manager">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M6"><img src="admin/media/tips.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[110]"/></font></td></tr>
		</table>
		
		<xsl:choose>
			<xsl:when test="$id=''">
				<xsl:call-template name="tip_list"/>
			</xsl:when>
			<xsl:when test="$id='new'">
				<xsl:call-template name="tip_add"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="siteinfo/tips/tip[id=$id]">
					<xsl:call-template name="tip_update"/>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<xsl:template name="tip_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr>
				<td class="header" width="50">Id</td>
				<td class="header"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[111]"/></td></tr>			
			
			<xsl:for-each select="/siteinfo/tips/tip">								
				<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M6&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="id"/></td>
					<td><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="text" disable-output-escaping="yes"/></td></tr>
			</xsl:for-each>								
			
			<tr><td colspan="2" align="right"><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M6&amp;id=new';" type="button" value="{$string[15]}"/></td></tr>
		</table>
	</xsl:template>


	<!-- addtip template  -->
	<xsl:template name="tip_add">
		<table style="width: 100%; background: buttonface; border: 4px solid appworkspace;" cellpadding="0" cellspacing="0" border="0">
			<form action="default.asp?ACT=1&amp;SECT=M6" method="post">
			<input type="hidden" name="operation" value="add"/>
			<input type="hidden" name="bloc" value="siteinfo/tips"/>
			<input type="hidden" name="node" value="tip"/>
										
			<tr><td ><b>Text :</b><br/>
				<textarea  class="textarea" name="text"></textarea>
				<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('text');</script></xsl:if>
			</td></tr>
			
			<tr>
				<td align="right">
					<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M6';"/>
				</td>
			</tr>
			</form>
		</table>
	</xsl:template>
		
		
	<!-- configtip template  -->
	<xsl:template name="tip_update">
		<table style="width: 100%; background: buttonface; border: 4px solid appworkspace;" cellpadding="0" cellspacing="0" border="0">
			<form action="default.asp?ACT=1&amp;SECT={$section}" method="post">
			<input type="hidden" name="operation" value="update"/>
			<input type="hidden" name="node" value="siteinfo/tips/tip[id={id}]"/>
						
			<tr><td><b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[111]"/> :</b><br/>
				<textarea  class="textarea" name="text"><xsl:value-of select="text" disable-output-escaping="yes"/></textarea>
				<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('text');</script></xsl:if>
			</td></tr>
			<tr>
				<td align="right">
					<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M6';"/>
				</td>
			</tr>
			</form>
			<tr>
				<td align="right">
					<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" onsubmit="return confirm('{$string[112]}');">
						<input type="hidden" name="operation" value="delete"/>
						<input type="hidden" name="node" value="siteinfo/tips/tip[id={id}]"/>
						<input type="submit" value="{$string[16]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					</form>
				</td>
			</tr>
		</table>
	</xsl:template>
	
</xsl:stylesheet>