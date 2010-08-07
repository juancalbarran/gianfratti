<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve">
<xsl:output method="html"/> 

<!-- last modified : 2004/03/16, by Mig100 (Miguel Figueira) -->
<!-- version 1.0 -->

	<xsl:template name="langedit_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Language Editor</xsl:with-param>
			<xsl:with-param name="version">2.0</xsl:with-param>
			<xsl:with-param name="moddate">16.03.2004</xsl:with-param>
			<xsl:with-param name="author">John Roland and Eazambu (Eduardo Azambuja)</xsl:with-param>
			<xsl:with-param name="url">http://www.fullxml.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="langedit">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M104"><img src="admin/media/langedit.gif" border="0"/></a></td>
			<td><font size="6">Language editor</font></td></tr>
		</table>
		
		<iframe style="width: 100%; height: 90%" src="admin/langedit/default.asp"></iframe>
	</xsl:template>		
	
</xsl:stylesheet>				