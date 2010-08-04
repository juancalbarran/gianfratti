<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl=
   "http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html"/>
<xsl:template match="/">
	<html><head></head><body>
	<xsl:apply-templates select="menu"/>
	</body></html>
</xsl:template>
<xsl:template match="menu">
	<table align="left" width="150">
		
	<xsl:apply-templates select="link">
		<xsl:sort select="@title"/>
	</xsl:apply-templates>
	<tr><td><input type="submit" id="btnAdd" name="btnAction" style="width: 100;" value="Add"></input></td></tr>
	</table>
</xsl:template>
<xsl:template match="link">
	<tr><td><a href="testMenu3.asp?id={@id}"><xsl:value-of select="@title"/></a></td></tr>
</xsl:template>
</xsl:stylesheet>