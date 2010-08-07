<?xml version="1.0" encoding="ISO-8859-1"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes"  omit-xml-declaration="yes" encoding="utf-8"/>

	<!-- variables globales utilisées dans les templates -->
	<xsl:param name="usermessage"/>
	<xsl:param name="usertype"/>
	<xsl:param name="username"/>
	<xsl:param name="actualdate"/>
	<xsl:param name="now"/>
	<xsl:param name="mappath"/>
	<xsl:param name="visitors"/>
	<xsl:param name="guid"/>
	
	<!-- les request eventuels doivent etre declaré ici -->
	<xsl:param name="id"/>
	<xsl:param name="mnu"/>
	<xsl:param name="ACT"/>
	<xsl:param name="content"/>
	<xsl:param name="keyword"/>
	<xsl:param name="pic"/>
	<xsl:param name="vp"/>
	<xsl:param name="grp"/>
	<xsl:param name="msg"/>
	<xsl:param name="lgn"/>
	<xsl:param name="pwd"/>
	<xsl:param name="gateway"/>
	
	<!-- for the newsgroups alerts -->
	<xsl:param name="operation"/>
	<xsl:param name="file"/>
	<xsl:param name="comp_title"/>
	<xsl:param name="text_body"/>
	<xsl:param name="comp_body"/>
	<xsl:param name="comp_message"/>
	
		
		 	 
	<!-- Pointeur sur les fichiers de données -->	
	<xsl:param name="languagefile"/>
	<xsl:param name="languagespath"/>
	<xsl:param name="datafile"/>
	<xsl:param name="discussionfile"/>
	<xsl:param name="pollfile"/>
	<xsl:param name="logfile"/>
	<xsl:param name="memberfile"/>
	<xsl:param name="reactfile"/>
	<xsl:param name="guestbookfile"/>
	<xsl:param name="taskfile"/>
	<xsl:param name="mediafile"/>
	<xsl:param name="downloadfile"/>
	<xsl:param name="categoryfile"/>
	<xsl:param name="bannerfile"/>
	
	<!-- variables pour les newsgroup -->
	<xsl:variable name="newsgroupID" select="$grp"/>
	<xsl:variable name="messageID" select="$msg"/>
	
	<!-- On charge les chaines de langue -->
	<!-- Create the language's strings array -->
	<xsl:variable name="language" select="/siteinfo/data/language"/>
	<xsl:variable name="languagefilename"  select="document(concat($languagespath, '\_index.xml'))//languages/language[id=$language]/filename"/>
	<xsl:variable name="string" select="document(concat($languagespath, '\', $languagefilename))//language/strings/string"/>
	
		
	<xsl:template match="/">
		<rss version="0.91">
			<xsl:call-template name="rss_website"/>
		</rss>
	</xsl:template>
	
	<xsl:template name="rss_website">
		
		<channel>	
			<title><xsl:value-of select="/siteinfo/data/title"/></title>
			<link><xsl:value-of select="/siteinfo/data/url"/></link>
			<description><xsl:value-of select="/siteinfo/data/slogan"/></description>
			<language></language>
			<copyright><xsl:value-of select="/siteinfo/data/footer"/></copyright>
		  	<managingEditor><xsl:value-of select="/siteinfo/data/email"/></managingEditor>
		  	<webMaster><xsl:value-of select="/siteinfo/data/email"/></webMaster>
		  			    
		    <!-- IMAGE -->
		   <!--
		    <xsl:element name="image">
		    	<xsl:element name="title">
					<xsl:value-of select="concat('&lt;![CDATA[', /siteinfo/data/title, ']]&gt;')" disable-output-escaping="yes"/>
				</xsl:element>
				<xsl:element name="link">		    
					<xsl:value-of select="concat('&lt;![CDATA[', /siteinfo/data/url, ']]&gt;')" disable-output-escaping="yes"/>
				</xsl:element>
				<xsl:element name="url">
					<xsl:value-of select="concat('&lt;![CDATA[', /siteinfo/data/biglogo, ']]&gt;')" disable-output-escaping="yes"/>
				</xsl:element>
			</xsl:element>-->
			
			<!-- ITEMS -->  
			<!--
			<xsl:for-each select="document($categoryfile)//categories/category[visible!='off' and member!='on']">
				<xsl:variable name="category" select="id"/>			
				<xsl:for-each select="document($datafile)//pages/page[visible='on' and category=$category]">
					<xsl:sort select="publicationdate" data-type="number" order="descending"/>
					<xsl:variable name="page" select="id"/>					
						<xsl:apply-templates select="/siteinfo/contents/content[visible='on' and idpage=$page and $actualdate>=publicationdate ]" mode="item"/>					
				</xsl:for-each>			
			</xsl:for-each>
			-->
			
			<!--
			<xsl:apply-templates select="/siteinfo/contents/content[visible='on' and $actualdate>=publicationdate and 11>position()]" mode="item">
				<xsl:sort select="publicationdate" order="descending"/>
			</xsl:apply-templates>-->
			
			
			<xsl:for-each select="/siteinfo/contents/content[visible='on' and $actualdate>=publicationdate]">
				<xsl:sort select="publicationdate" data-type="number" order="descending"/>
				<xsl:if test="position()&lt;11"><xsl:apply-templates select="." mode="item"/></xsl:if>
			</xsl:for-each>
			
			<xsl:element name="textinput">
				<title><xsl:value-of select="$string[240]"/></title>
				<description><xsl:value-of select="/siteinfo/data/name"/></description>
				<name><xsl:value-of select="keyword"/></name>
				<link><xsl:value-of select="concat(/siteinfo/data/url, '/default.asp?ACT=4')"/></link>
			</xsl:element>
			
		</channel>
	</xsl:template>
	
	
	<xsl:template match="content" mode="item">
		<item>
			<title><xsl:value-of select="title"/></title>
			<link><xsl:value-of select="concat(/siteinfo/data/url, '/default.asp?ACT=5&amp;id=', idpage, '&amp;content=', id)"/></link>
			<description>
				<xsl:if test="string-length(publicationdate)&gt;0">
					[<xsl:value-of select="substring(publicationdate, 7, 2)"/>.<xsl:value-of select="substring(publicationdate, 5, 2)"/>.<xsl:value-of select="substring(publicationdate, 1, 4)"/>]
					&lt;br&gt;
				</xsl:if>				
				<xsl:value-of select="headlines"/>
			</description>
		</item>
			
	</xsl:template>
	
</xsl:stylesheet>