<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb" xml:space="preserve">
	<xsl:output method="html" indent="no"/>
	<xsl:include href="functions.xsl"/>
	<xsl:template name="directory">
		<xsl:choose>
			<xsl:when test="$cat">
				<xsl:apply-templates select="document($directoryfile)//directories/directory[@id=$dir]//category[@id=$cat]/@description" mode="directory_description"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- Disppay the directory description-->
				<xsl:apply-templates select="document($directoryfile)//directories/directory[@id=$dir]/@description" mode="directory_description"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="$cat and $item='new'">
				<xsl:call-template name="submitItem"/>
			</xsl:when>
			<xsl:when test="$cat and $item='post'">
				<xsl:call-template name="thanksItem"/>
			</xsl:when>
			<xsl:when test="$cat and string-length($item)&gt;0">
				<xsl:apply-templates select="document($directoryfile)//directories/directory[@id=$dir]//item[@id=$item]" mode="detail"/>
			</xsl:when>
			<xsl:when test="$cat">
				<xsl:apply-templates select="document($directoryfile)//directories/directory[@id=$dir]//category[@id=$cat]" mode="Psubcat"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="document($directoryfile)//directories/directory[@id=$dir]" mode="HPdir"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- Display a description -->
	<xsl:template match="attribute::description" mode="directory_description">
<!--		<xsl:call-template name="hightlightedtext_design">
			<xsl:with-param name="text"> -->
				<xsl:value-of select="." disable-output-escaping="yes"/>
<!--			</xsl:with-param> 
		</xsl:call-template>-->
		<br/>
	</xsl:template>
	
	
	<!-- The Home Grid -->
	<xsl:template match="directory" mode="HPdir">
		<table>
			<tr valign="top">
				<td width="100%">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<!-- the category grid -->
						<xsl:apply-templates select="category" mode="premiers">
							<xsl:sort select="@name" order="ascending"/>			
						</xsl:apply-templates>
						<tr>
							<td colspan="2" align="center">
								<!-- The number of item -->
								<xsl:variable name="itemtype" select="document($directoryfile)//directories/directory[@id=$dir]/@itemtype"/>
								<xsl:choose>
									<xsl:when test="$itemtype='link'">
										<xsl:value-of select="concat($string[532], ' ', count(.//item[@published='on']), '.')"/>
									</xsl:when>
									<xsl:when test="$itemtype='download'">
										<xsl:value-of select="concat($string[543], ' ', count(.//item[@published='on']), '.')"/>
									</xsl:when>
									<xsl:otherwise>Not yet implemented</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</table>
				</td>
				<!-- the Top and last webparts -->
				<td width="200"><img src="dot.gif" width="200" height="1"/><br/><xsl:call-template name="top_ressource_macro"/><br/><xsl:call-template name="last_ressource_macro"/></td>
			</tr>
		</table>
	</xsl:template>
	
	
	<!-- Dislpay a line of 2 categories -->
	<xsl:template match="category" mode="premiers">
		<xsl:variable name="open_TR">&lt;tr height="60"&gt;</xsl:variable>
		<xsl:variable name="close_TR">&lt;/tr&gt;</xsl:variable>
		
		<xsl:if test="(position() mod 2) = 1"><xsl:value-of select="$open_TR" disable-output-escaping="yes"/></xsl:if>
			<xsl:apply-templates select="."/>
		<xsl:if test="(position() mod 2) = 0"><xsl:value-of select="$close_TR" disable-output-escaping="yes"/></xsl:if>
	</xsl:template>
	
	
	<xsl:template match="category">
		<td>
			<a href="default.asp?ACT=24&amp;id=0&amp;dir={$dir}&amp;cat={@id}" class="cat">
				<xsl:value-of select="@name"/>
			</a> (<xsl:value-of select="count(.//item[@published='on'])"/>)<br/>
			<xsl:if test="count(category)&gt;2">
				<a href="default.asp?ACT=24&amp;id=0&amp;dir={$dir}&amp;cat={category[1]/@id}" class="subcat">
					<xsl:value-of select="category[1]/@name"/>
				</a>, <a class="subcat" href="default.asp?ACT=24&amp;id=0&amp;dir={$dir}&amp;cat={category[2]/@id}">
					<xsl:value-of select="category[2]/@name"/>
				</a>, <a class="subcat" href="default.asp?ACT=24&amp;id=0&amp;dir={$dir}&amp;cat={category[3]/@id}">
					<xsl:value-of select="category[3]/@name"/>...</a>
				<br/>
			</xsl:if>
		</td>
	</xsl:template>
	
	
	<!-- TOP RESSOURCE -->
	<xsl:template name="top_ressource_macro">		
		<xsl:for-each select="document($directoryfile)//directories/directory[@id=$dir]">
			<xsl:call-template name="margin_design">
			    	<xsl:with-param name="title" select="$string[536]"/>
				
				<xsl:with-param name="body">
					<xsl:apply-templates select="document($directoryfile)//directories/directory[@id=$dir]//item[@published='on']" mode="PopularItem">
						<xsl:sort select="@count" data-type="number" order="descending"/>
					</xsl:apply-templates>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	
	
	<!-- LAST IN RESSOURCES -->
	<xsl:template name="last_ressource_macro">
		<xsl:for-each select="document($directoryfile)//directories/directory[@id=$dir]">
			<xsl:call-template name="margin_design">
			    	<xsl:with-param name="title" select="$string[538]"/>
				
				<xsl:with-param name="body">
					<xsl:apply-templates select="document($directoryfile)//directories/directory[@id=$dir]//item[@published='on']" mode="NewItem">
						<xsl:sort select="@date" data-type="number" order="descending"/>
					</xsl:apply-templates>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
		
	<!-- Popular Item -->
	<xsl:template match="item" mode="PopularItem">
		<xsl:if test="position()&lt;11">
			<xsl:value-of select="position()"/>. <a href="default.asp?id=0&amp;ACT=24&amp;dir={$dir}&amp;cat={../@id}&amp;item={@id}">
				<xsl:value-of select="@name"/>
			</a>
			<br/>
 			<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><font size="1">
				<xsl:value-of select="concat(@count, ' ', $string[537])"/>
			</font>
			<br/>
		</xsl:if>
	</xsl:template>
	
	<!-- New item -->
	<xsl:template match="item" mode="NewItem">
		<xsl:if test="position()&lt;11">
			<xsl:value-of select="position()"/>. <a href="default.asp?id=0&amp;ACT=24&amp;dir={$dir}&amp;cat={../@id}&amp;item={@id}">
				<xsl:value-of select="@name"/>
			</a>
			<br/>
 			<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><font size="1"> [<xsl:call-template name="display_date"><xsl:with-param name="p_Date" select="substring(@date, 1, 8)"/></xsl:call-template>]</font>
			<br/>
		</xsl:if>
	</xsl:template>
	
	
	<!-- Page of a CATEGORY : list of child category + list of items -->
	<xsl:template match="category" mode="Psubcat">
		<xsl:variable name="nbcat" select="round(count(category) div 3)+1"/>
		<!-- the category trail -->
		<a href="default.asp?id=0&amp;ACT=24&amp;dir={$dir}" class="trail">
			<xsl:value-of select="$string[531]"/>
		</a> / 
		<xsl:apply-templates select="parent::category" mode="trail"/>
		<span style="font-face: Tahoma; font-size: 12px; font-weight: bold;">
			<xsl:value-of select="@name"/>
		</span>
		<p/>
		<!-- Categories -->
		<xsl:if test="count(category)&gt;0">
			<xsl:call-template name="title_design">
				<xsl:with-param name="title">
					<xsl:value-of select="$string[489]"/>
				</xsl:with-param>
			</xsl:call-template>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr valign="top">
					<td width="33%">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<xsl:for-each select="category[position() &lt;= $nbcat]">
								<tr align="left" valign="top">
									<xsl:apply-templates mode="sPsubcat" select="."/>
								</tr>
							</xsl:for-each>
						</table>
					</td>
					<td width="33%">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<xsl:for-each select="category[position() &gt; $nbcat and position()&lt;=($nbcat*2)]">
								<tr align="left" valign="top">
									<xsl:apply-templates mode="sPsubcat" select="."/>
								</tr>
							</xsl:for-each>
						</table>
					</td>
					<td width="33%">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<xsl:for-each select="category[position() &gt; $nbcat*2]">
								<tr align="left" valign="top">
									<xsl:apply-templates mode="sPsubcat" select="."/>
								</tr>
							</xsl:for-each>
						</table>
					</td>
				</tr>
			</table>
			<br/>
		</xsl:if>
		<!-- Items -->
		<xsl:if test="count(item)&gt;0">
			<xsl:variable name="itemtype" select="document($directoryfile)//directories/directory[@id=$dir]/@itemtype"/>
			
			<!-- title of the items -->
			<xsl:call-template name="title_design">
				<xsl:with-param name="title">
					<xsl:choose>
						<xsl:when test="$itemtype='link'">
							<xsl:value-of select="$string[522]"/>
						</xsl:when>
						<xsl:when test="$itemtype='download'">
							<xsl:value-of select="$string[521]"/>
						</xsl:when>
						<xsl:otherwise>Not yet implemented</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			
			<!-- Show the list of item, as summary -->
			<xsl:apply-templates select="item[@published='on']" mode="summary">
				<xsl:sort select="@name" order="ascending"/>
			</xsl:apply-templates>
			<br/>
		</xsl:if>
		<!-- Submit link -->
		<xsl:if test="document($directoryfile)//directories/directory[@id=$dir]/@publicsubmit='on'">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center">
						<a href="default.asp?id=0&amp;ACT=24&amp;dir={$dir}&amp;cat={$cat}&amp;item=new">
							<xsl:value-of select="$string[533]"/>
						</a>
					</td>
				</tr>
			</table>
			<br/>
		</xsl:if>
	</xsl:template>
	
	
	<!-- Show the sub category -->
	<xsl:template match="category" mode="sPsubcat">
		<td height="15">
			<a class="subcat" href="default.asp?ACT=24&amp;id=0&amp;dir={$dir}&amp;cat={@id}">
				<xsl:value-of select="@name"/>
			</a> (<xsl:value-of select="count(.//item[@published='on'])"/>)<br/>
		</td>
	</xsl:template>
	
	
	<!-- diplay the path in the trail -->
	<xsl:template match="category" mode="trail">
		<xsl:apply-templates select="parent::category" mode="trail"/>
		<a class="trail" href="default.asp?ACT=24&amp;id=0&amp;dir={$dir}&amp;cat={@id}">
			<xsl:value-of select="@name"/>
		</a> / 
	</xsl:template>
	
	
	<!-- THOSES TEMPLATES COULD DEPENDS OF ITEM TYPE STORED IN THE DIRECTORY -->
	<!-- ITEM as summary-->
	<xsl:template match="item" mode="summary">
		<xsl:variable name="itemtype" select="document($directoryfile)//directories/directory[@id=$dir]/@itemtype"/>
		<!-- depending of the type -->
		<xsl:choose>
			<xsl:when test="$itemtype='link'">
				<a class="subcat" href="redirect.asp?id={@id}&amp;type=dir" target="_blank">
					<xsl:value-of select="@name"/>
				</a> - <font color="#aaaaaa">
					<xsl:value-of select="@website"/> - <xsl:value-of select="concat($string[534], ': ', @count)"/>
				</font>
				<br/>
				<xsl:value-of select="concat(summary, @summary)" disable-output-escaping="yes"/>
				<br/><br/>
			</xsl:when>
			<xsl:when test="$itemtype='download'">
				<a href="default.asp?ACT=24&amp;id=0&amp;dir={$dir}&amp;cat={$cat}&amp;item={@id}">
					<xsl:value-of select="@name"/>
				</a> - <font color="#aaaaaa"> [<xsl:call-template name="display_date"><xsl:with-param name="p_Date" select="substring(@date, 1, 8)"/></xsl:call-template>] - <xsl:value-of select="concat($string[534], ': ', @count)"/>
				</font>
				<br/>
				<xsl:if test="string-length(@shortdescription)&gt;0">
					<xsl:value-of select="@shortdescription"/>
					<br/>
				</xsl:if>
				<br/>
			</xsl:when>
			<xsl:otherwise>Not yet implemented</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<!-- ITEM as detail-->
	<xsl:template match="item" mode="detail">
		<xsl:variable name="itemtype" select="document($directoryfile)//directories/directory[@id=$dir]/@itemtype"/>
		<a href="default.asp?id=0&amp;ACT=24&amp;dir={$dir}" class="trail">
			<xsl:value-of select="$string[531]"/>
		</a> / 
		<xsl:apply-templates select="parent::category" mode="trail"/>
		<span style="font-face: Tahoma; font-size: 12px; font-weight: bold;">
			<xsl:value-of select="name"/>
		</span>
		<p/>
		<!-- depending of the type -->
		<xsl:choose>
			<!-- WEBSITE DETAIL-->
			<xsl:when test="$itemtype='link'">
				<a class="subcat" href="redirect.asp?id={@id}&amp;type=dir" target="_blank">
					<xsl:value-of select="@name"/>
				</a>
				<br/>
				[<font color="#aaaaaa">
					<xsl:value-of select="@website"/>
				</font>]<br/>
				<xsl:value-of select="concat(summary, @summary)" disable-output-escaping="yes"/>
				<br/>
			</xsl:when>
			<!-- DOWNLOAD DETAIL -->
			<xsl:when test="$itemtype='download'">
				<xsl:call-template name="title_design">
					<xsl:with-param name="title">
						<xsl:value-of select="@name"/> (<xsl:value-of select="@count"/>)
						<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M22&amp;id={@id}&amp;cmd=item&amp;dir={$dir}&amp;cat={$cat}">
								<img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/>
							</a>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="normaltext_design">
					<xsl:with-param name="text">
						<xsl:value-of select="description" disable-output-escaping="yes"/>
										
						&lt;ul&gt;
						<!-- version -->
						<xsl:if test="string-length(@version)&gt;0">
							&lt;li&gt;&lt;b&gt;<xsl:value-of select="$string[364]"/>&lt;/b&gt;: <xsl:value-of select="@version"/>&lt;/li&gt;
						</xsl:if>
						<!-- size -->
						<xsl:if test="string-length(@size)&gt;0">
							&lt;li&gt;&lt;b&gt;<xsl:value-of select="$string[363]"/>&lt;/b&gt;: <xsl:value-of select="@size"/>&lt;/li&gt;
						</xsl:if>
						<!-- editor -->
						<xsl:if test="string-length(@url)&gt;0">
							&lt;li&gt;&lt;b&gt;<xsl:value-of select="$string[353]"/>&lt;/b&gt;: &lt;a href="<xsl:value-of select="@url"/>" target="_blank"&gt;<xsl:value-of select="@url"/>&lt;/a&gt;&lt;/li&gt;
						</xsl:if>
						<!-- Price -->
						<xsl:if test="string-length(@price)&gt;0">
							&lt;li&gt;&lt;b&gt;<xsl:value-of select="$string[356]"/>&lt;/b&gt;: <xsl:value-of select="@price"/>&lt;/li&gt;
						</xsl:if>
						
						&lt;li&gt;&lt;img src="admin/media/save.gif" alt="{$string[350]}" border="0"&gt;<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>&lt;a href="redirect.asp?id=<xsl:value-of select="@id"/>&amp;type=dir" target="_blank"&gt;&lt;b&gt;<xsl:value-of select="$string[361]"/>&lt;/b&gt;&lt;/a&gt;&lt;/li&gt;
						&lt;/ul&gt;
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>Not yet implemented</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<!-- Template called when the "submit item" form is posted -->
	<xsl:template name="thanksItem">
		<xsl:value-of select="$string[535]"/>
		<p align="center">
			<a href="default.asp?id=0&amp;ACT=24&amp;dir={$dir}" class="trail">
				<xsl:value-of select="$string[531]"/>
			</a>
		</p>
		<xsl:variable name="vbcrlf">
			<xsl:text/>
		</xsl:variable>
		<!-- if the webmaster want it, we send an mail alert -->
		<xsl:call-template name="Mailer">
			<xsl:with-param name="ToEmail" select="string(/siteinfo/data/email)"/>
			<xsl:with-param name="FromEmail" select="string(/siteinfo/data/email)"/>
			<xsl:with-param name="Subject" select="concat($string[539], ': ', $name)"/>
			<xsl:with-param name="Message" select="concat($name, $vbcrlf,  /siteinfo/data/url, '?id=0&amp;ACT=24&amp;dir=', $dir, '&amp;cat=', $cat)"/>
		</xsl:call-template>
	</xsl:template>
	
	
	<!-- NEW IETM FORM -->
	<xsl:template name="submitItem">
		<xsl:variable name="itemtype" select="document($directoryfile)//directories/directory[@id=$dir]/@itemtype"/>
		<!-- title of the form -->
		<xsl:call-template name="title_design">
			<xsl:with-param name="title">
				<xsl:choose>
					<xsl:when test="$itemtype='link'">
						<xsl:value-of select="$string[533]"/>
					</xsl:when>
					<xsl:otherwise>Not yet implemented</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<table>
			<form action="default.asp?id=0&amp;ACT=24&amp;dir={$dir}&amp;cat={$cat}&amp;item=post" method="post" name="frmFullxml">
				<input type="hidden" name="operation" value="add"/>
				<input type="hidden" name="xform" value="2"/>
				<input type="hidden" name="file" value="directory"/>
				<input type="hidden" name="xpath" value="directories/directory[@id='{$dir}']//category[@id='{$cat}']"/>
				<input type="hidden" name="node" value="item"/>
				<input type="hidden" name="count" value="0"/>
				<input type="hidden" name="published" value="off"/>
				<xsl:choose>
					<xsl:when test="$itemtype='link'">
						<tr>
							<td><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[485]"/>:</td>
							<td>
								<input type="input" class="inpText" name="P_name" size="45"/>
							</td>
						</tr>
						<tr>
							<td><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[501]"/>:</td>
							<td>
								<input type="input" class="inpText" name="P_website" size="45"/>
							</td>
						</tr>
						<tr valign="top">
							<td><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[499]"/>:</td>
							<td>
								<textarea name="N_summary" class="inpTextarea" cols="45" rows="10"/>
							</td>
						</tr>
					</xsl:when>
					<xsl:otherwise>Not yet implemented</xsl:otherwise>
				</xsl:choose>
				<tr>
					<td align="right" colspan="2">
						<input type="submit" value="{$string[18]}" class="inpButton"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=24&amp;dir={$dir}&amp;id=0';"/>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>
</xsl:stylesheet>
