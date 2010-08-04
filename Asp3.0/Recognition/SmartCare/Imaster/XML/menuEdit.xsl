<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:param name="id"/>
<xsl:output method="html"/>
<xsl:template match="/">
	<table>
	<xsl:apply-templates select="/menu/link[@id=$id]" />
	</table>
</xsl:template>
<xsl:template match="link">
	<tr>
		<td>
			<label><b>Title</b>:</label>
		</td>
		<td>
			<input type="text" size="80" id="title" name="title"><xsl:attribute name="value"><xsl:apply-templates select="@title"/></xsl:attribute></input>
		</td>
	</tr>
	<tr>
		<td>
			<label><b>URL</b>:</label>
		</td>
		<td>
			<input type="text" size="80" id="url" name="url"><xsl:attribute name="value"><xsl:apply-templates select="@url"/></xsl:attribute></input>
		</td>
	</tr>		
	<tr>
		<td>&#160;</td>
		<td>
			<input type="hidden" name="id"><xsl:attribute name="value"><xsl:value-of select="$id"/></xsl:attribute></input>
			<input type="submit" id="btnSubmit" name="btnAction" style="width: 100;" value="Submit"></input>&#160;&#160;
			<input type="submit" id="btnDelete" name="btnAction" style="width: 100;" value="Delete"></input>&#160;&#160;
			<input type="submit" id="btnCancel" name="btnAction" style="width: 100;" value="Cancel"></input>&#160;&#160;
		</td>
	</tr>
</xsl:template>
<xsl:template match="link/@title">
	<xsl:value-of select="."/>
</xsl:template>
<xsl:template match="link/@url">
	<xsl:value-of select="."/>
</xsl:template>
</xsl:stylesheet>