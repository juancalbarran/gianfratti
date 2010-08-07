<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="text" omit-xml-declaration="yes" indent="yes"/>

<xsl:template match="members">
name, email, city, newsletter, date &#13;&#10;
<xsl:for-each select="member">
<xsl:value-of select="pseudo"/>, <xsl:value-of select="email"/>, <xsl:value-of select="ville"/>, <xsl:value-of select="newsletter"/>, <xsl:value-of select="date"/><xsl:text>
</xsl:text>
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
