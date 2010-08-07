<?xml version="1.0" encoding="ISO-8859-1"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb" >
	
<xsl:output method="html" indent="no"/>
<xsl:include href="functions.xsl"/>
	
	<!-- advertisement calculation -->
	<xsl:template name="advert">
		<xsl:param name="position"/>
	
		<xsl:variable name="nbad"><xsl:value-of select="count(document($bannerfile)//banners/banner[visible='on' and position=$position and (string-length(publicationdate)=0 or $today>=publicationdate) and (string-length(expirationdate)=0 or expirationdate>$today)])"/></xsl:variable>
		<xsl:variable name="rnd"><xsl:value-of select="vb:getRandom(number($nbad))"/></xsl:variable>	
			
		
		
		<xsl:if test="count(document($bannerfile)//banners/banner[visible='on' and position=$position and (string-length(publicationdate)=0 or $today>=publicationdate) and (string-length(expirationdate)=0 or expirationdate>$today)])&gt;0 and (/siteinfo/data/banner='on' or string-length(/siteinfo/data/banner)=0) ">			
			<xsl:for-each select="document($bannerfile)//banners/banner[visible='on' and position=$position and (string-length(publicationdate)=0 or $today>=publicationdate) and (string-length(expirationdate)=0 or expirationdate>$today)]">
								
				<xsl:if test="position()=$rnd">
					<!-- code depends on the file type -->				
					<xsl:choose>
						<!-- case of rich media -->
						<xsl:when test="string-length(richmedia)&gt;0">
							<xsl:value-of select="richmedia" disable-output-escaping="yes"/>
						</xsl:when>
						
						<!-- Case of a picture -->
						<xsl:when test="contains(gifsrc, '.gif') or contains(gifsrc, '.jpg') or contains(gifsrc, '.jpeg') or contains(gifsrc, '.asp') or contains(gifsrc, '.php')">
							<xsl:choose>
								<!-- pic is linked -->
								<xsl:when test="string-length(onclickurl)&gt;0">
										<a href="redirect.asp?type=ad&amp;id={id}" target="_blank">
											<img src="{gifsrc}" alt="{name}" border="0">
												<xsl:if test="string-length(width)&gt;0"><xsl:attribute name="width"><xsl:value-of select="width"/></xsl:attribute></xsl:if>
												<xsl:if test="string-length(height)&gt;0"><xsl:attribute name="height"><xsl:value-of select="height"/></xsl:attribute></xsl:if>
											</img>
										</a>
								</xsl:when>
								
								<!-- pic is not linked -->
								<xsl:otherwise>
									<img src="{gifsrc}" alt="{name}" border="0">
										<xsl:if test="string-length(width)&gt;0"><xsl:attribute name="width"><xsl:value-of select="width"/></xsl:attribute></xsl:if>
										<xsl:if test="string-length(height)&gt;0"><xsl:attribute name="height"><xsl:value-of select="height"/></xsl:attribute></xsl:if>
									</img>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
	
						<!-- Case of a flash -->
						<xsl:when test="contains(gifsrc, '.swf')">
							<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000'  codebase=' http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab' width="{width}" height="{height}"> 
								<param name="movie" value="{gifsrc}"/> 
								<param name="quality" value="high"/> 
								<param name="menu" value="false"/> 
								<!--<param name="wmode" value="transparent"/>-->
								<embed src="{gifsrc}" quality="high" swLiveConnect="FALSE" menu="false" pluginspage=' http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash' type='application/x-shockwave-flash' width="{width}" height="{height}"> 
								</embed> 
							</object> 
						</xsl:when>
						
						<xsl:otherwise>
						    <xsl:choose>
								<xsl:when test="string-length(onclickurl)&gt;0">
										<a href="redirect.asp?type=ad&amp;id={id}" target="_blank">
											<img src="{gifsrc}" alt="{name}" border="0">
												<xsl:if test="string-length(width)&gt;0"><xsl:attribute name="width"><xsl:value-of select="width"/></xsl:attribute></xsl:if>
												<xsl:if test="string-length(height)&gt;0"><xsl:attribute name="height"><xsl:value-of select="height"/></xsl:attribute></xsl:if>
											</img>
										</a>
								</xsl:when>
								<xsl:otherwise>
									<img src="{gifsrc}" alt="{name}" border="0">
										<xsl:if test="string-length(width)&gt;0"><xsl:attribute name="width"><xsl:value-of select="width"/></xsl:attribute></xsl:if>
										<xsl:if test="string-length(height)&gt;0"><xsl:attribute name="height"><xsl:value-of select="height"/></xsl:attribute></xsl:if>
									</img>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</xsl:for-each>			
		</xsl:if>
	</xsl:template>	
	
</xsl:stylesheet>
