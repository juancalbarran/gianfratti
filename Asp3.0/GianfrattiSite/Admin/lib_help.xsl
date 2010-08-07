<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve">
<xsl:output method="html"/> 

<!-- last modified : 2002/02/20, by J.Roland -->
<!-- version 1.0 -->

	<xsl:template name="help_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Help system</xsl:with-param>
			<xsl:with-param name="version">1.0</xsl:with-param>
			<xsl:with-param name="moddate">20.02.2002</xsl:with-param>
			<xsl:with-param name="author">John Roland</xsl:with-param>
			<xsl:with-param name="url">http://www.fullxml.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="help">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M17"><img src="admin/media/help.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[224]"/></font></td></tr>
		</table>
		
		<iframe style="width: 100%; height: 100%" src="help/{$helpfilename}"></iframe>
	</xsl:template>		
	
</xsl:stylesheet>				