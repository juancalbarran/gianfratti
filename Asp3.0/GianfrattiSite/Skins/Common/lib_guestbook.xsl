<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb">
    
	<xsl:output method="html" indent="no"/>
	<!-- GuestBook template-->
	<xsl:template name="guestbook">
				
		
		<!-- messages -->
		<xsl:apply-templates select="document($guestbookfile)//guests/guest[visible='on']" mode="guestbook">
			<xsl:sort select="date" data-type="number"  order="descending"/>
		</xsl:apply-templates>
		
		<!-- Navigation for the Paging -->
		<center>
		<xsl:call-template name="paging_Rail_macro">
			<xsl:with-param name="totalpage" select="count(document($guestbookfile)//guests/guest[visible='on']) div $guestbook_pagesize"/>
			<xsl:with-param name="currentpage" select="number($page)+1"/>
			<xsl:with-param name="url">default.asp?id=0&amp;ACT=7</xsl:with-param>
		</xsl:call-template>
		</center>
		<p/>
		
		<!-- le formulaire -->
		<table cellpadding="0" cellspacing="0" border="0">
			<form action="default.asp?ACT=13" method="post">
				<input type="hidden" name="operation" value="add"/>
				<input type="hidden" name="file" value="guestbook"/>
				<input type="hidden" name="bloc" value="guests"/>
				<input type="hidden" name="node" value="guest"/>
				<!--<input type="hidden" name="visible" value="off"/>-->
				<input type="hidden" name="visible" value="{/siteinfo/data/guestbookstate}"/>
				<tr>
					<td colspan="2" align="center">
						<!-- Sign the guestbook tile -->
						<xsl:call-template name="title_design">
							<xsl:with-param name="title">
								<xsl:value-of select="$string[148]"/>
							</xsl:with-param>
						</xsl:call-template>						
					</td>
				</tr>
				<tr>
					<td>
						<img src="media/dot.gif" width="60" height="1"/>
					</td>
					<td width="100%"/>
				</tr>
				<tr>
					<td width="60"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[141]"/>:</td>
					<td><input type="text" name="comp_from" class="input"/></td>
				</tr>
				<tr>
					<td><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[145]"/>:</td>
					<td><input type="text" name="email" class="input"/></td>
				</tr>
				<tr>
					<td><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[142]"/> :</td>
					<td><input type="text" name="comp_title" class="input"/></td>
				</tr>
				<tr>
					<td colspan="2"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[143]"/> :</td>
				</tr>
				<tr>
					<td colspan="2"><xsl:choose>
						<xsl:when test="$usertype='administrator'">
							<textarea name="comp_body" cols="40" rows="5" class="input"/>
							<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('comp_body');</script></xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<textarea name="comp_body" cols="40" rows="5" class="input"/>
							<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('comp_body', config);</script></xsl:if>
						</xsl:otherwise>
					</xsl:choose></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="{$string[454]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="reset" value="{$string[455]}"/>
					</td>
				</tr>
			</form>
		</table>							
	</xsl:template>
	
	<!-- template of an entry -->
	<xsl:template match="guest" mode="guestbook">
		<xsl:if test="position() &gt; number($page*$guestbook_pagesize) and position() &lt;=  number(($page+1)*$guestbook_pagesize) ">
			<!-- Article title -->
			<xsl:call-template name="title_design">
				<xsl:with-param name="title">
					<xsl:value-of select="position()"/>. <xsl:value-of select="title" disable-output-escaping="yes"/>
					<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M9&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			
			<!-- Date and author -->
			<xsl:call-template name="hightlightedtext_design">
				<xsl:with-param name="text">
					[<small><xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>-<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="mailto:{email}"><xsl:value-of select="from" disable-output-escaping="yes"/></a></small>]
					<!--<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>(<a href="mailto:{email}"><xsl:value-of select="from"/></a> - <xsl:value-of select="date" disable-output-escaping="yes"/>)<br/>-->
				</xsl:with-param>
			</xsl:call-template>
		
			<!-- Message body -->
			<xsl:call-template name="normaltext_design">
				<xsl:with-param name="text">
					<xsl:value-of select="body" disable-output-escaping="yes"/>
				</xsl:with-param>
			</xsl:call-template>		
			<p/>
		</xsl:if>
			
	</xsl:template>
		
</xsl:stylesheet>
