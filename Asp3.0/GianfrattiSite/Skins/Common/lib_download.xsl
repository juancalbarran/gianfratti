<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"> 
<xsl:output method="html" indent="no"/> 

	<xsl:template name="download">
			
		<!-- for each category -->
		<xsl:for-each select="document($downloadfile)//downloads/download[visible='on' and $actualdate>=publicationdate]">
		<xsl:sort select="publicationdate" data-type="number" order="descending"/>
			
			<xsl:if test="(string-length(member)=0) or (member='on' and $usertype!='anonymous') or (member='off')">
			
					
				<xsl:call-template name="title_design">
					<xsl:with-param name="title">
						<xsl:value-of select="name"/> (<xsl:value-of select="count"/>)
						<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M20&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="normaltext_design">
					<xsl:with-param name="text">
						<xsl:value-of select="description" disable-output-escaping="yes"/>
						&lt;ul&gt;
						<!-- version -->
						<xsl:if test="string-length(version)&gt;0">
							&lt;li&gt;&lt;b&gt;<xsl:value-of select="$string[364]"/>&lt;/b&gt;: <xsl:value-of select="version"/>&lt;/li&gt;
						</xsl:if>
						<!-- size -->
						<xsl:if test="string-length(size)&gt;0">
							&lt;li&gt;&lt;b&gt;<xsl:value-of select="$string[363]"/>&lt;/b&gt;: <xsl:value-of select="size"/>&lt;/li&gt;
						</xsl:if>
						<!-- editor -->
						<xsl:if test="string-length(url)&gt;0">
							&lt;li&gt;&lt;b&gt;<xsl:value-of select="$string[353]"/>&lt;/b&gt;: &lt;a href="<xsl:value-of select="url"/>" target="_blank"&gt;<xsl:value-of select="url"/>&lt;/a&gt;&lt;/li&gt;
						</xsl:if>
						<!-- Price -->
						<xsl:if test="string-length(price)&gt;0">
							&lt;li&gt;&lt;b&gt;<xsl:value-of select="$string[356]"/>&lt;/b&gt;: <xsl:value-of select="price"/>&lt;/li&gt;
						</xsl:if>
						
						<!--<li><b><xsl:value-of select="$string[357]"/></b> : <xsl:value-of select="os"/></li>
						<li><b><xsl:value-of select="$string[355]"/></b> : <xsl:value-of select="license"/></li>-->					
						&lt;li&gt;&lt;img src="admin/media/save.gif" alt="{$string[350]}" border="0"&gt;<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>&lt;a href="redirect.asp?id=<xsl:value-of select="id"/>&amp;type=dw" target="_blank"&gt;&lt;b&gt;<xsl:value-of select="$string[361]"/>&lt;/b&gt;&lt;/a&gt;&lt;/li&gt;
						&lt;/ul&gt;
					</xsl:with-param>
				</xsl:call-template>			
			<p/>
			</xsl:if>
		</xsl:for-each>				
	</xsl:template>		
	
	<!-- TOP DOWNLOADS -->
	<xsl:template name="topdownloads">
		<xsl:call-template name="rightmargin_design">
			<xsl:with-param name="title">
				<xsl:value-of select="$string[350]"/>
			</xsl:with-param>
			
			<xsl:with-param name="body">
				<xsl:for-each select="document($downloadfile)//downloads/download[visible='on' and $actualdate>=publicationdate]">			
				<xsl:sort select="count" data-type="number" order="descending"/>				
					
					<xsl:if test="(string-length(member)=0) or (member='on' and $usertype!='anonymous') or (member='off')">
					<xsl:if test="position()&lt;6">					
						<xsl:call-template name="menu_item_design">
							<xsl:with-param name="content">
								<a href="redirect.asp?id={id}&amp;type=dw" target="_blank"><xsl:value-of select="name"/></a> (<xsl:value-of select="count"/>)
								<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M20&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
							</xsl:with-param>
						</xsl:call-template>						
						
					</xsl:if>
					</xsl:if>
				</xsl:for-each>	
				
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
</xsl:stylesheet>				