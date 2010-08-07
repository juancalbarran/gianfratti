<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb">
	<xsl:output method="xml" indent="no"/>
			
	<!-- Menu calculation, the owner typer is passed as param -->
  <xsl:template name="display_category">
		<xsl:param name="group"/>
		<xsl:param name="position"/>
		
		<!-- on recopie dans une variable, pour avoir le context trier, tres util pour following et preceding -->
		<xsl:variable name="cat_node">			
			<xsl:for-each select="document($categoryfile)//categories/category[visible!='off' and member=$group and (position=$position or (string-length(position)=0 and $position='left'))]">
			 	<xsl:sort select="order" data-type="number" order="ascending"/>
			 	<category><id><xsl:value-of select="id"/></id><name><xsl:value-of select="name"/></name><member><xsl:value-of select="member"/></member><sortfield><xsl:value-of select="sortfield"/></sortfield><sortorder><xsl:value-of select="sortorder"/></sortorder></category>
			 </xsl:for-each>
		</xsl:variable>
			
		 <!--<xsl:apply-templates select="document($categoryfile)//categories/category[visible!='off' and member=$group and (position=$position or (string-length(position)=0 and $position='left'))]" mode="menu">
		 	<xsl:sort select="order" data-type="number" order="ascending"/>
		 </xsl:apply-templates>-->
		 
		<xsl:apply-templates select="msxsl:node-set($cat_node)/category" mode="menu">
		 	<xsl:sort select="order" data-type="number" order="ascending"/>
		</xsl:apply-templates>
	</xsl:template>	   
        	
  <!-- menubar -->
  <xsl:template name="display_category_menubar">
		<xsl:param name="position"/>
		<xsl:param name="group"/>
		<xsl:variable name="idcategory" select="document($datafile)//pages/page[id=$id]/category"/>
		<xsl:apply-templates select="document($categoryfile)//categories/category[id=$idcategory and visible!='off' and member=$group and (position=$position or (string-length(position)=0 and $position='left'))]" mode="menu">
				<xsl:sort select="order" data-type="number" order="ascending"/>
		</xsl:apply-templates>
  </xsl:template>
        	
	<!-- Macro for a category-->
	<xsl:template match="category" mode="menu">	    
	<xsl:variable name="category" select="id"/>
	       	       
	        
  <xsl:call-template name="margin_design">
		    	<xsl:with-param name="myid" select="id"/>
		    	<xsl:with-param name="beforeid" select="preceding-sibling::*[1]/id"/>
		    	<xsl:with-param name="nextid" select="following-sibling::*[1]/id"/>
			  	<xsl:with-param name="title">
									<xsl:value-of select="name"/>
									<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M18&amp;id={$category}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
					</xsl:with-param>
			
					<xsl:with-param name="body">
				
					<!-- Call Menu template but with the good sorting for the pages -->
				
				<xsl:choose>
					<xsl:when test="sortfield='name' and string-length(sortorder)&gt;0">
						<xsl:apply-templates select="document($datafile)//pages/page[visible='on'  and idparentpage='' and (category=$category or string-length(category)=0 ) and (string-length(publicationdate)=0 or $today>=publicationdate) and (string-length(expirationdate)=0 or expirationdate>$today)]" mode="menu">
							<xsl:sort select="name" order="{sortorder}" data-type="text"/>
						</xsl:apply-templates>
					</xsl:when>
					
					<xsl:when test="sortfield='publicationdate' and string-length(sortorder)&gt;0">
						<xsl:apply-templates select="document($datafile)//pages/page[visible='on'  and idparentpage='' and (category=$category or string-length(category)=0 ) and (string-length(publicationdate)=0 or $today>=publicationdate) and (string-length(expirationdate)=0 or expirationdate>$today)]" mode="menu">
							<xsl:sort select="publicationdate" order="{sortorder}" data-type="text"/>
						</xsl:apply-templates>
					</xsl:when>
					
					<xsl:when test="sortfield='id' and string-length(sortorder)&gt;0">
						<xsl:apply-templates select="document($datafile)//pages/page[visible='on'  and idparentpage='' and (category=$category or string-length(category)=0 ) and (string-length(publicationdate)=0 or $today>=publicationdate) and (string-length(expirationdate)=0 or expirationdate>$today)]" mode="menu">
							<xsl:sort select="id" order="{sortorder}" data-type="number"/>
						</xsl:apply-templates>
					</xsl:when>
					
					<xsl:otherwise>						
						<xsl:apply-templates select="document($datafile)//pages/page[visible='on'  and idparentpage='' and (category=$category or string-length(category)=0 ) and (string-length(publicationdate)=0 or $today>=publicationdate) and (string-length(expirationdate)=0 or expirationdate>$today)]" mode="menu">
							<xsl:sort select="id" order="ascending" data-type="number"/>
						</xsl:apply-templates>

					</xsl:otherwise>					
					
				</xsl:choose>
				
				<xsl:if test="$usertype='administrator'">
					<xsl:call-template name="menu_item_design">
						<xsl:with-param name="content">
							<a href="default.asp?ACT=1&amp;SECT=M2&amp;id=new&amp;cat={$category}" class="menu"><xsl:value-of select="$string[254]"/></a>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	
	<!-- macro for a page entry in the menu -->
	<xsl:template match="page" mode="menu">
		<xsl:variable name="thispage" select="id"/>
											
			<xsl:call-template name="menu_item_design">
				<xsl:with-param name="content">
					<xsl:choose>
						<xsl:when test="externaltype='top' and string-length(externallink)!=0">
							<a href="{externallink}" class="menu" target="_top"><xsl:value-of select="name" disable-output-escaping="yes"/></a>
						</xsl:when>
						<xsl:when test="externaltype='blank' and string-length(externallink)!=0">
							<a href="{externallink}" class="menu" target="_blank"><xsl:value-of select="name" disable-output-escaping="yes"/></a>
						</xsl:when>
						<xsl:otherwise><a href="default.asp?id={id}&amp;mnu={id}" class="menu"><xsl:value-of select="name" disable-output-escaping="yes"/></a></xsl:otherwise>
					</xsl:choose>
					<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M2&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			
			<!-- Sub page--> 
			<xsl:for-each select="document($datafile)//pages/page[visible='on' and idparentpage=$thispage and ($thispage=$id or $thispage=$mnu )]">			
			<xsl:sort select="id" data-type="number" order="ascending"/>
				<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				<xsl:call-template name="menu_item_design">
					<xsl:with-param name="content">
        					<xsl:choose>
        						<xsl:when test="externaltype='top'  and string-length(externallink)!=0">
        							<a href="{externallink}" class="menu" target="_top"><xsl:value-of select="name" disable-output-escaping="yes"/></a>
        						</xsl:when>
        						<xsl:when test="externaltype='blank'  and string-length(externallink)!=0">
        							<a href="{externallink}" class="menu" target="_blank"><xsl:value-of select="name" disable-output-escaping="yes"/></a>
        						</xsl:when>
        						<xsl:otherwise><a href="default.asp?id={id}&amp;mnu={$mnu}" class="menu"><xsl:value-of select="name" disable-output-escaping="yes"/></a></xsl:otherwise>
        					</xsl:choose>
        					<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M2&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
        				</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>

	</xsl:template>

	
	<!-- TOP PAGES -->
	<xsl:template name="toppages">
		<xsl:call-template name="rightmargin_design">
			<xsl:with-param name="title">
				<xsl:value-of select="$string[67]"/>
			</xsl:with-param>
			
			<xsl:with-param name="body">
				<xsl:for-each select="document($datafile)//pages/page[visible='on' and string-length(idparentpage)=0]">			
				<xsl:sort select="count" data-type="number" order="descending"/>				
					<xsl:variable name="thispage" select="id"/>
					<xsl:variable name="category" select="category"/>
					
					<xsl:if test="position()&lt;6 and document($categoryfile)//categories/category[id=$category]/member='off'">					
						<xsl:call-template name="menu_item_design">
							<xsl:with-param name="content">
								<a href="default.asp?id={id}&amp;mnu={id}" class="menu"><xsl:value-of select="name" disable-output-escaping="yes"/></a><xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M2&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						
						<xsl:for-each select="document($datafile)//pages/page[visible='on' and idparentpage=$thispage and ($thispage=$id or $thispage=$mnu )]">			
						<xsl:sort select="id" data-type="number" order="ascending"/>
							<xsl:call-template name="menu_item_design">
								<xsl:with-param name="content">
									<a href="default.asp?id={id}&amp;mnu={$thispage}" class="menu"><xsl:value-of select="name" disable-output-escaping="yes"/><xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M2&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if></a>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:if>
				</xsl:for-each>	
				
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
			
</xsl:stylesheet>