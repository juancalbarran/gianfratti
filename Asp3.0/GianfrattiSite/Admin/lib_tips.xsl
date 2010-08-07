<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve">
<xsl:output method="html"/> 

<!-- Webpages Template : add/update/modify -->
<!-- last modified : 2002/05/22, by J.Roland -->
<!-- version 1.0 -->

	<xsl:template name="tip_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Tips</xsl:with-param>
			<xsl:with-param name="version">1.0</xsl:with-param>
			<xsl:with-param name="moddate">22.05.2002</xsl:with-param>
			<xsl:with-param name="author">John Roland</xsl:with-param>
			<xsl:with-param name="url">http://www.fullxml.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

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
				<td class="header"><xsl:value-of select="$string[111]"/></td></tr>			
			
			<xsl:for-each select="/siteinfo/tips/tip">								
				<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M6&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M6&amp;id={id}"><xsl:value-of select="text" disable-output-escaping="yes"/></a></td></tr>
			</xsl:for-each>								
			
			<tr><td colspan="2" align="right"><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M6&amp;id=new';" type="button" value="{$string[15]}"/></td></tr>
		</table>
	</xsl:template>


	<!-- addtip template  -->
	<xsl:template name="tip_add">
		<table bgcolor="white"><form action="default.asp?ACT=1&amp;SECT=M6" method="post" name="frmFullxml"><tr><td>
			<input type="hidden" name="operation" value="add"/>
			<input type="hidden" name="bloc" value="siteinfo/tips"/>
			<input type="hidden" name="node" value="tip"/>
					
			<table class="block">					
				<tr><td class="xp_sel"><xsl:value-of select="$string[111]"/>:</td>
					<td>
						<textarea  class="textarea" name="text"></textarea>
						<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('text');</script></xsl:if>
					</td>
				</tr>
				<tr>
					<td align="right" colspan="2">
						<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M6';"/>
					</td>
				</tr>
			</table>			
		</td></tr></form>
		</table>
	</xsl:template>
		
		
	<!-- configtip template  -->
	<xsl:template name="tip_update">
	
		<table bgcolor="white"><tr><td>
			<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmFullxml">
			<input type="hidden" name="operation" value="update"/>
			<input type="hidden" name="node" value="siteinfo/tips/tip[id={id}]"/>
				
			<table class="block">		
				<tr><td class="xp_sel"><xsl:value-of select="$string[111]"/>:</td>
					<td>
						<textarea  class="textarea" name="text"><xsl:value-of select="text"/></textarea>
						<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('text');</script></xsl:if>
					</td>
				</tr>
				<tr>
					<td align="right" colspan="2">
						<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M6';"/>
					</td>
				</tr>
			</table>
			</form>
			<table class="block">
				<tr>
					<td align="right">
						<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" onsubmit="return confirm('{$string[112]}');">
							<input type="hidden" name="operation" value="delete"/>
							<input type="hidden" name="node" value="siteinfo/tips/tip[id={id}]"/>
							<input type="submit" value="{$string[16]}"/>
						</form>
					</td>
				</tr>
			</table>
		</td></tr></table>
		
	</xsl:template>
	
</xsl:stylesheet>