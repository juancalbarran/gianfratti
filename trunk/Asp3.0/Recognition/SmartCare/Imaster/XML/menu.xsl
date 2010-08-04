<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl=
   "http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html"/>
<xsl:template match="/">
	<xsl:apply-templates select="menu"/>
</xsl:template>
<xsl:template match="menu">
	<table align="left" width="150">
	<xsl:apply-templates select="link"/>
	</table>
</xsl:template>
<xsl:template match="link">
	<tr><td><a href="{@url}"><xsl:value-of select="@title"/></a></td></tr>
</xsl:template>
</xsl:stylesheet>