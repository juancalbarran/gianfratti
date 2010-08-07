<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve">
<xsl:output method="html"/> 

<!-- Reactions Template : add/update/modify -->
<!-- last modified : 2001/10/26, by J.Roland -->
<!-- version 1.0 -->

	<xsl:template name="website_overview">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M10"><img src="admin/media/content.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[position()=150]"/></font></td></tr>
		</table>
		
		<xsl:for-each select="/siteinfo/pages/pages">
			<img src="" width="50" height="50" title="{name}"/>
		</xsl:for-each>
	</xsl:template>		
	
</xsl:stylesheet>				