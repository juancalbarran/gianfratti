<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- MACROS FOR PAGING  -->
	
	<!-- Display of a rail of page navigation : next/prev and the list of page number-->
	<xsl:template name="paging_Rail_macro">
		<xsl:param name="totalpage"/>
		<xsl:param name="currentpage"/>
		<xsl:param name="url"/>
		
			<xsl:value-of select="$string[544]"/>: <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
			
			<xsl:if test="$currentpage!=1"><a href="{$url}&amp;page={$currentpage - 2}"><b><xsl:value-of select="$string[545]"/></b></a></xsl:if><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				<xsl:call-template name="paging_numberlink_macro">
					<xsl:with-param name="number" select="1"/>
					<xsl:with-param name="max" select="$totalpage"/>
					<xsl:with-param name="url" select="$url"/>
				</xsl:call-template>
			<xsl:if test="$currentpage &lt; $totalpage"><a href="{$url}&amp;page={$currentpage}"><b><xsl:value-of select="$string[546]"/></b></a></xsl:if>
		
	</xsl:template>		
		
	<!-- Display the list of page number link :: recursive -->
	<xsl:template name="paging_numberlink_macro">
		<xsl:param name="number"/>
		<xsl:param name="max"/>
		<xsl:param name="url"/>
				
		<xsl:choose>
			<xsl:when test="$number - 1 = $page "><xsl:value-of select="$number"/></xsl:when>
			<xsl:otherwise><a href="{$url}&amp;page={$number - 1}"><b><xsl:value-of select="$number"/></b></a></xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
		
		<xsl:if test="$number &lt; $max">
			<xsl:call-template name="paging_numberlink_macro">
				<xsl:with-param name="number" select="$number + 1"/>
				<xsl:with-param name="max" select="$max"/>
				<xsl:with-param name="url" select="$url"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<!-- Display a formated Date :: @todo add local settings for different date format -->
	<xsl:template name="showdate">
		<xsl:param name="p_Date"/>
		<xsl:value-of select="substring($p_Date, 7, 2)"/>.<xsl:value-of select="substring($p_Date, 5, 2)"/>.<xsl:value-of select="substring($p_Date, 1, 4)"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="substring($p_Date, 9, 2)"/>:<xsl:value-of select="substring($p_Date, 11, 2)"/>
	</xsl:template>


	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!-- FxMods - Recently inserted templates -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

	<xsl:template name="version_interface">
		<xsl:param name="name"/>
		<xsl:param name="version"/>
		<xsl:param name="moddate"/>
		<xsl:param name="author"/>
		<xsl:param name="url"/>
		<xsl:call-template name="version_output">
			<xsl:with-param name="name"><xsl:value-of select="$name"/></xsl:with-param>
			<xsl:with-param name="version"><xsl:value-of select="$version"/></xsl:with-param>
			<xsl:with-param name="moddate"><xsl:value-of select="$moddate"/></xsl:with-param>
			<xsl:with-param name="author"><xsl:value-of select="$author"/></xsl:with-param>
			<xsl:with-param name="url"><xsl:value-of select="$url"/></xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Date / Time related functions -->
	
	<xsl:template name="display_datetime">
	       <xsl:param name="p_DateTime"/>
               <xsl:call-template name="display_date"><xsl:with-param name="p_Date"><xsl:value-of select="substring($p_DateTime, 1, 8)"/></xsl:with-param></xsl:call-template>
               <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
               <xsl:call-template name="display_time"><xsl:with-param name="p_Time"><xsl:value-of select="substring($p_DateTime, 9, 4)"/></xsl:with-param></xsl:call-template>
	</xsl:template>

	<xsl:template name="display_date">
               <xsl:param name="p_Date"/>
               <xsl:variable name="DateFormat" select="document($datafile)//siteinfo/data/dateformat"/>
               <xsl:variable name="DateSeparator" select="document($datafile)//siteinfo/data/dateseparator"/>
               <xsl:variable name="monthstring">1049</xsl:variable>
               <xsl:choose>
                           <xsl:when test="$DateFormat='dd.mm.yy'">
                                     <xsl:value-of select="substring($p_Date, 7, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 5, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 3, 2)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='dd.mmm.yy'">
                                     <xsl:value-of select="substring($p_Date, 7, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="$string[number($monthstring+substring($p_Date, 5, 2))]"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 3, 2)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='dd.mm.yyyy'">
                                     <xsl:value-of select="substring($p_Date, 7, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 5, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 1, 4)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='dd.mmm.yyyy'">
                                     <xsl:value-of select="substring($p_Date, 7, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="$string[number($monthstring+substring($p_Date, 5, 2))]"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 1, 4)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='mmm.yy'">
                                     <xsl:value-of select="$string[number($monthstring+substring($p_Date, 5, 2))]"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 3, 2)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='mmm.yyyy'">
                                     <xsl:value-of select="$string[number($monthstring+substring($p_Date, 5, 2))]"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 1, 4)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='mm.dd.yy'">
                                     <xsl:value-of select="substring($p_Date, 5, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 7, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 3, 2)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='mmm.dd.yy'">
                                     <xsl:value-of select="$string[number($monthstring+substring($p_Date, 5, 2))]"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 7, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 3, 2)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='mm.dd.yyyy'">
                                     <xsl:value-of select="substring($p_Date, 5, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 7, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 1, 4)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='mmm.dd.yyyy'">
                                     <xsl:value-of select="$string[number($monthstring+substring($p_Date, 5, 2))]"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 7, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 1, 4)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='yy.mm.dd'">
                                     <xsl:value-of select="substring($p_Date, 3, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 5, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 7, 2)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='yy.mmm.dd'">
                                     <xsl:value-of select="substring($p_Date, 3, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="$string[number($monthstring+substring($p_Date, 5, 2))]"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 7, 2)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='yyyy.mm.dd'">
                                     <xsl:value-of select="substring($p_Date, 1, 4)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 5, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 7, 2)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='yyyy.mmm.dd'">
                                     <xsl:value-of select="substring($p_Date, 1, 4)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="$string[number($monthstring+substring($p_Date, 5, 2))]"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 7, 2)"/>
                           </xsl:when>
                           <xsl:otherwise>
                                     <xsl:value-of select="substring($p_Date, 7, 2)"/>.<xsl:value-of select="substring($p_Date, 5, 2)"/>.<xsl:value-of select="substring($p_Date, 1, 4)"/>
                           </xsl:otherwise>
		</xsl:choose>

	</xsl:template>
	<xsl:template name="display_time">
		<xsl:param name="p_Time"/>
		<xsl:value-of select="substring($p_Time, 1, 2)"/>:<xsl:value-of select="substring($p_Time, 3, 2)"/>
	</xsl:template>
</xsl:stylesheet>
