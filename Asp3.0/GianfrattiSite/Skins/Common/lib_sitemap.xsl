<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve"> 
<xsl:output method="html"/> 

	<xsl:template name="sitemap">
			
		<!-- for each category -->
		<xsl:for-each select="document($categoryfile)//categories/category[visible='on' and member!='admin']">
			<xsl:variable name="idcategory" select="id"/>
				
			<xsl:if test="count(document($datafile)//pages/page[category=$idcategory and visible='on'])&gt;0">
			
				<!-- category -->	
				<xsl:call-template name="title_design">
					<xsl:with-param name="title"><xsl:value-of select="name"/></xsl:with-param>
				</xsl:call-template>
				
				<!-- for each page of the category -->
				<xsl:for-each select="document($datafile)//pages/page[category=$idcategory and visible='on']">
					<xsl:variable name="idpage" select="id"/>
					<ul>
					<li>
						<!-- webpage, handle the external link case -->
						<xsl:choose>
							<xsl:when test="(document($categoryfile)//categories/category[id=$idcategory]/member='on' and $usertype='anonymous')">
								<b><xsl:value-of select="name"/></b>
							</xsl:when>
							 <xsl:otherwise>
							  	     <xsl:choose>
                                                                <xsl:when test="externaltype='top'">
                                                                    <a href="{externallink}" target="_top"><b><xsl:value-of select="name" disable-output-escaping="yes"/></b></a>
                                                                </xsl:when>
                                                                <xsl:when test="externaltype='blank'">
                                                                    <a href="{externallink}" target="_blank"><b><xsl:value-of select="name" disable-output-escaping="yes"/></b></a>
                                                                </xsl:when>
                                                                <xsl:otherwise><a href="default.asp?id={$idpage}&amp;mnu={$idpage}"><b><xsl:value-of select="name" disable-output-escaping="yes"/></b></a></xsl:otherwise>
                                                            </xsl:choose>		

								<!--<a href="default.asp?id={$idpage}&amp;mnu={$idpage}"><b><xsl:value-of select="name"/></b></a>-->
							</xsl:otherwise>
						</xsl:choose>	
						
						<ul>
						<!-- for each article of the page -->
						<xsl:for-each select="document($datafile)//contents/content[idpage=$idpage and visible='on']">
							<xsl:choose>							    
								<xsl:when test="(document($categoryfile)//categories/category[id=$idcategory]/member='on' and $usertype='anonymous')">
									<li><xsl:value-of select="title"/></li>
								</xsl:when>
								<xsl:otherwise>
								   <li><a href="default.asp?id={$idpage}&amp;mnu={$idpage}&amp;ACT=5&amp;content={id}"><xsl:value-of select="title"/></a></li>
								</xsl:otherwise>
							</xsl:choose>						
						</xsl:for-each>
						</ul>
					</li>
					</ul>
				</xsl:for-each>
			</xsl:if>
		</xsl:for-each>
		
		<hr/>
		<div align="center"><xsl:call-template name="searchform_macro"/></div>
		
		
	</xsl:template>		
	
</xsl:stylesheet>				