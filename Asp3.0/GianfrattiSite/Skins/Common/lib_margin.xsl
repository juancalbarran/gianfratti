<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb">
	
<xsl:output method="html" indent="no"/>
<xsl:include href="functions.xsl"/>
	
	<!-- margin content engine  -->
	<xsl:template name="margin">
		<xsl:param name="position"/>
		
		<xsl:for-each select="/siteinfo/contents/content[visible='on'  and type='margin' and (idpage=$id or idpage='0') and (string-length(publicationdate)=0 or $today>=publicationdate)  and (string-length(expirationdate)=0 or expirationdate>$today) and (position=$position or (string-length(position)=0 and $position='right'))]">
		<xsl:sort select="publicationdate" data-type="number" order="descending"/>
				
			<xsl:call-template name="rightmargin_design">
				<!-- title -->
				<xsl:with-param name="title">
					<xsl:if test="showtitle='on' or string-length(showtitle)=0"><xsl:value-of select="title" disable-output-escaping="yes"/></xsl:if>
					<xsl:if test="$usertype='administrator'">  <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M3&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
				</xsl:with-param>
				<!-- body -->
				<xsl:with-param name="body">
					<xsl:choose>
						<xsl:when test="string-length(headlines)&gt;0">
							<xsl:value-of select="headlines" disable-output-escaping="yes"/>
							<xsl:if test="string-length(body)&gt;0 or (string-length(xmlsource)&gt;0 and string-length(xslsource)&gt;0) ">
								&lt;br&gt;&lt;a href="default.asp?mnu=<xsl:value-of select="$mnu"/>&amp;id=<xsl:value-of select="$id"/>&amp;ACT=5&amp;content=<xsl:value-of select="id"/>"&gt;
									&#62;&#62; <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[253]"/>
								&lt;/a&gt;
							</xsl:if>
						</xsl:when>
						<xsl:when test="string-length(headlines)=0 and (string-length(xmlsource)&gt;0 and string-length(xslsource)&gt;0)">
							<xsl:value-of select="vb:transform(string(xmlsource), string(xslsource), string($msxml4))" disable-output-escaping="yes"/>
						</xsl:when>
						<xsl:when test="string-length(headlines)=0 and string-length(xmlsource)=0 and string-length(xslsource)=0 and string-length(body)&gt;0">
							<xsl:value-of select="body" disable-output-escaping="yes"/>
						</xsl:when>
					</xsl:choose>
					
					<xsl:if test="/siteinfo/data/showdateauthor='on'">
						<br/>[ <xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>- <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="author"/>]
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	
		
	<!-- archive template, affiche les anciens articles dans la marge  -->
	<xsl:template name="smallarchive">
		<xsl:variable name="articlenumber"><xsl:choose><xsl:when test="string-length(/siteinfo/pages/page[id=$id]/articlenumber)=0">6</xsl:when><xsl:otherwise><xsl:value-of select="/siteinfo/pages/page[id=$id]/articlenumber"/></xsl:otherwise></xsl:choose></xsl:variable>
				
		<xsl:if test="count(/siteinfo/contents/content[visible='on' and type='body' and (idpage=$id or idpage='0') and (string-length(publicationdate)=0 or $today>=publicationdate) and (string-length(expirationdate)=0 or expirationdate>$today)]) &gt;= $articlenumber">
			<xsl:call-template name="rightmargin_design">
				<xsl:with-param name="title">
					<xsl:value-of select="$string[87]"/>
				</xsl:with-param>
				<xsl:with-param name="body">
					<xsl:for-each select="/siteinfo/contents/content[visible='on' and type='body' and (idpage=$id or idpage='0') and (string-length(publicationdate)=0 or $today>=publicationdate) and (string-length(expirationdate)=0 or expirationdate>$today)]">
					<xsl:sort select="publicationdate" data-type="number" order="descending"/>
						
						
						<xsl:if test="position()&gt;number(number($articlenumber) - 1) and position()&lt;number(20+number($articlenumber))">
							
							<xsl:call-template name="menu_item_design">
								<xsl:with-param name="content">
									<a href="default.asp?ACT=5&amp;content={id}&amp;id={$id}&amp;mnu={$mnu}" class="menu"><xsl:value-of select="title" disable-output-escaping="yes"/></a> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:if test="$usertype='administrator'"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M3&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
								</xsl:with-param>
							</xsl:call-template>
						
						</xsl:if>
					</xsl:for-each>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>		
	</xsl:template>
	
	<!-- Affiche le liste des autres articles de la page concernée -->
	<xsl:template name="allarchive">
		<xsl:call-template name="rightmargin_design">
			<xsl:with-param name="title">
			<xsl:value-of select="$string[87]"/>
			</xsl:with-param>
			<xsl:with-param name="body">
				<xsl:for-each select="/siteinfo/contents/content[visible='on' and type='body' and (idpage=$id or idpage='0') and (string-length(publicationdate)=0 or $today>=publicationdate) and (string-length(expirationdate)=0 or expirationdate>$today)]">
				<xsl:sort select="id" data-type="number" order="descending"/>
					
					<xsl:call-template name="menu_item_design">
						<xsl:with-param name="content">
							<a href="default.asp?ACT=5&amp;content={id}&amp;id={$id}&amp;mnu={$mnu}" class="menu"><xsl:value-of select="title" disable-output-escaping="yes"/></a> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:if test="$usertype='administrator'"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M3&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					
				</xsl:for-each>
			</xsl:with-param>
		</xsl:call-template>		
	</xsl:template>
	
	
	<!-- tip template  -->
	<xsl:template name="tip">
		<xsl:variable name="nbtips"><xsl:value-of select="count(siteinfo/tips/tip)"/></xsl:variable>
		<xsl:variable name="rnd"><xsl:value-of select="vb:getRandom(number($nbtips))"/><!--<xsl:value-of select="1+round(game:getRandom()*(number($nbtips)-1))"/>--></xsl:variable>
		<xsl:variable name="tipid" select="siteinfo/tips/tip[position()=number($rnd)]/id"/>
		
		<xsl:if test="count(siteinfo/tips/tip)&gt;0">
			<xsl:call-template name="rightmargin_design">
				<xsl:with-param name="title">
					<xsl:value-of select="$string[250]"/>
					<xsl:if test="$usertype='administrator'"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M6&amp;id={$tipid}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
				</xsl:with-param>
				<xsl:with-param name="body">
					<xsl:value-of select="/siteinfo/tips/tip[id=$tipid]/text" disable-output-escaping="yes"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		
	</xsl:template>
	
	
	<!-- advertisement calculation -->
	<xsl:template name="advertisement">
		<xsl:variable name="nbad"><xsl:value-of select="count(document($bannerfile)//banners/banner[visible='on'])"/></xsl:variable>
		<xsl:variable name="rnd"><xsl:value-of select="vb:getRandom(number($nbad))"/></xsl:variable>	
			
		
		<xsl:if test="count(document($bannerfile)//banners/banner[visible='on'])&gt;0 and (/siteinfo/data/banner='on' or string-length(/siteinfo/data/banner)=0) ">			
			<xsl:for-each select="document($bannerfile)//banners/banner[visible='on']">
				<xsl:if test="position()=$rnd">
					<!-- code depends on the file type -->				
					<xsl:choose>
						<!-- Case of a picture -->
						<xsl:when test="contains(gifsrc, '.gif') or contains(gifsrc, '.jpg') or contains(gifsrc, '.jpeg')">
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
						</xsl:when>
	
						<!-- Case of a picture -->
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
					</xsl:choose>
				</xsl:if>
			</xsl:for-each>			
		</xsl:if>
	</xsl:template>
			
	
	<!-- poll template  -->
	<xsl:template name="survey">	
		<xsl:param name="position"/>
		
		<xsl:for-each select="document($pollfile)//polls/poll[(idpage=$id or idpage=0) and (position=$position or (string-length(position)=0 and $position='left')) ]">
			<xsl:variable name="total" select="count1+count2+count3+count4+count5+count6+count7+count8+count9+count10"/>
			<xsl:variable name="idpoll" select="id"/>
			
			
			<xsl:call-template name="rightmargin_design">
				<xsl:with-param name="title">
					<xsl:value-of select="$string[249]"/>
					<xsl:if test="$usertype='administrator'"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M5&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
				</xsl:with-param>
				<xsl:with-param name="body">
				
					<xsl:choose>
						<!-- show survey result -->
						
						<xsl:when test="$ACT=3 and id=$srv">
							<TABLE cellspacing="1" border="0" cellpadding="0">
								<TR><TD align="center"><B><xsl:value-of select="question" disable-output-escaping="yes"/></B></TD></TR>
								<xsl:if test="choice1!=''">
									<TR><TD>
										<xsl:value-of select="choice1" disable-output-escaping="yes"/> - <xsl:value-of select="round(count1*100 div number($total))"/>% (<xsl:value-of select="count1"/>)<br/>
										<img src="admin/media/graf_middle.gif" width="{round(count1*100 div number($total))}" height="14"/><img src="admin/media/graf_end.gif" width="7" height="14"/>
									</TD></TR>
								</xsl:if>
								<xsl:if test="choice2!=''">
									<TR><TD>
										<xsl:value-of select="choice2" disable-output-escaping="yes"/> - <xsl:value-of select="round(count2*100 div number($total))"/>% (<xsl:value-of select="count2"/>)<br/>
										<img src="admin/media/graf_middle.gif" width="{round(count2*100 div number($total))}" height="14"/><img src="admin/media/graf_end.gif" width="7" height="14"/>
									</TD></TR>
								</xsl:if>
								<xsl:if test="choice3!=''">
									<TR><TD>
										<xsl:value-of select="choice3" disable-output-escaping="yes"/> - <xsl:value-of select="round(count3*100 div number($total))"/>% (<xsl:value-of select="count3"/>)<br/>
										<img src="admin/media/graf_middle.gif" width="{round(count3*100 div number($total))}" height="14"/><img src="admin/media/graf_end.gif" width="7" height="14"/>
									</TD></TR>
								</xsl:if>
								<xsl:if test="choice4!=''">
									<TR><TD>
										<xsl:value-of select="choice4" disable-output-escaping="yes"/> - <xsl:value-of select="round(count4*100 div number($total))"/>% (<xsl:value-of select="count4"/>)<br/>
										<img src="admin/media/graf_middle.gif" width="{round(count4*100 div number($total))}" height="14"/><img src="admin/media/graf_end.gif" width="7" height="14"/>
									</TD></TR>
								</xsl:if>
								<xsl:if test="choice5!=''">
									<TR><TD>
										<xsl:value-of select="choice5" disable-output-escaping="yes"/> - <xsl:value-of select="round(count5*100 div number($total))"/>% (<xsl:value-of select="count5"/>)<br/>
										<img src="admin/media/graf_middle.gif" width="{round(count5*100 div number($total))}" height="14"/><img src="admin/media/graf_end.gif" width="7" height="14"/>
									</TD></TR>
								</xsl:if>
								<xsl:if test="choice6!=''">
									<TR><TD>
										<xsl:value-of select="choice6" disable-output-escaping="yes"/> - <xsl:value-of select="round(count6*100 div number($total))"/>% (<xsl:value-of select="count6"/>)<br/>
										<img src="admin/media/graf_middle.gif" width="{round(count6*100 div number($total))}" height="14"/><img src="admin/media/graf_end.gif" width="7" height="14"/>
									</TD></TR>
								</xsl:if>
								<xsl:if test="choice7!=''">
									<TR><TD>
										<xsl:value-of select="choice7" disable-output-escaping="yes"/> - <xsl:value-of select="round(count7*100 div number($total))"/>% (<xsl:value-of select="count7"/>)<br/>
										<img src="admin/media/graf_middle.gif" width="{round(count7*100 div number($total))}" height="14"/><img src="admin/media/graf_end.gif" width="7" height="14"/>
									</TD></TR>
								</xsl:if>
								<xsl:if test="choice8!=''">
									<TR><TD>
										<xsl:value-of select="choice8" disable-output-escaping="yes"/> - <xsl:value-of select="round(count8*100 div number($total))"/>% (<xsl:value-of select="count8"/>)<br/>
										<img src="admin/media/graf_middle.gif" width="{round(count8*100 div number($total))}" height="14"/><img src="admin/media/graf_end.gif" width="7" height="14"/>
									</TD></TR>
								</xsl:if>
								<xsl:if test="choice9!=''">
									<TR><TD>
										<xsl:value-of select="choice9" disable-output-escaping="yes"/> - <xsl:value-of select="round(count9*100 div number($total))"/>% (<xsl:value-of select="count9"/>)<br/>
										<img src="admin/media/graf_middle.gif" width="{round(count9*100 div number($total))}" height="14"/><img src="admin/media/graf_end.gif" width="7" height="14"/>
									</TD></TR>
								</xsl:if>
								<xsl:if test="choice10!=''">
									<TR><TD>
										<xsl:value-of select="choice10" disable-output-escaping="yes"/> - <xsl:value-of select="round(count10*100 div number($total))"/>% (<xsl:value-of select="count10"/>)<br/>
										<img src="admin/media/graf_middle.gif" width="{round(count10*100 div number($total))}" height="14"/><img src="admin/media/graf_end.gif" width="7" height="14"/>
									</TD></TR>
								</xsl:if>
							</TABLE>

						</xsl:when>
						<xsl:otherwise>
							<!-- show survey form -->
							<TABLE cellspacing="1" border="0" cellpadding="0" width="100%">
								<FORM method="post" action="default.asp?ACT=3&amp;srv={id}&amp;id={$id}&amp;mnu={$mnu}">
									<INPUT type="hidden" name="file" value="poll"/>
									<INPUT type="hidden" name="node" value="/polls/poll[id={$idpoll}]"/>							
									<TR>
										<TD colspan="2" align="center"><B><xsl:value-of select="question" disable-output-escaping="yes"/></B></TD>
									</TR>
									<xsl:if test="choice1!=''">
										<TR>
											<TD width="30"><xsl:if test="count1 &gt; 0"><xsl:value-of select="round(count1*100 div number($total))"/>%</xsl:if> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></TD>
											<TD>
												<input type="radio" name="choice" value="count1;{count1+1}"/>
												<xsl:value-of select="choice1" disable-output-escaping="yes"/>
											</TD>
										</TR>
									</xsl:if>
									<xsl:if test="choice2!=''">
										<TR>
											<TD><xsl:if test="count2 &gt; 0"><xsl:value-of select="round(count2*100 div number($total))"/>%</xsl:if> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></TD>
											<TD>
												<input type="radio" name="choice" value="count2;{count2+1}"/>
												<xsl:value-of select="choice2" disable-output-escaping="yes"/>
											</TD>
										</TR>
									</xsl:if>
									<xsl:if test="choice3!=''">
										<TR>
											<TD><xsl:if test="count3 &gt; 0"><xsl:value-of select="round(count3*100 div number($total))"/>%</xsl:if> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></TD>
											<TD>
												<input type="radio" name="choice" value="count3;{count3+1}"/>
												<xsl:value-of select="choice3" disable-output-escaping="yes"/>
											</TD>
										</TR>
									</xsl:if>
									<xsl:if test="choice4!=''">
										<TR>
											<TD><xsl:if test="count4 &gt; 0"><xsl:value-of select="round(count4*100 div number($total))"/>%</xsl:if> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></TD>
											<TD>
												<input type="radio" name="choice" value="count4;{count4+1}"/>
												<xsl:value-of select="choice4" disable-output-escaping="yes"/>
											</TD>
										</TR>
									</xsl:if>
									<xsl:if test="choice5!=''">
										<TR>
											<TD><xsl:if test="count5 &gt; 0"><xsl:value-of select="round(count5*100 div number($total))"/>%</xsl:if> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></TD>
											<TD>
												<input type="radio" name="choice" value="count5;{count5+1}"/>
												<xsl:value-of select="choice5" disable-output-escaping="yes"/>
											</TD>
										</TR>
									</xsl:if>
									<xsl:if test="choice6!=''">
										<TR>
											<TD><xsl:if test="count6 &gt; 0"><xsl:value-of select="round(count6*100 div number($total))"/>%</xsl:if> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></TD>
											<TD>
												<input type="radio" name="choice" value="count6;{count6+1}"/>
												<xsl:value-of select="choice6" disable-output-escaping="yes"/>
											</TD>
										</TR>
									</xsl:if>
									<xsl:if test="choice7!=''">
										<TR>
											<TD><xsl:if test="count7 &gt; 0"><xsl:value-of select="round(count7*100 div number($total))"/>%</xsl:if> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></TD>
											<TD>
												<input type="radio" name="choice" value="count7;{count7+1}"/>
												<xsl:value-of select="choice7" disable-output-escaping="yes"/>
											</TD>
										</TR>
									</xsl:if>
									<xsl:if test="choice8!=''">
										<TR>
											<TD><xsl:if test="count8 &gt; 0"><xsl:value-of select="round(count8*100 div number($total))"/>%</xsl:if> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></TD>
											<TD>
												<input type="radio" name="choice" value="count8;{count8+1}"/>
												<xsl:value-of select="choice8" disable-output-escaping="yes"/>
											</TD>
										</TR>
									</xsl:if>
									<xsl:if test="choice7!=''">
										<TR>
											<TD><xsl:if test="count9 &gt; 0"><xsl:value-of select="round(count9*100 div number($total))"/>%</xsl:if> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></TD>
											<TD>
												<input type="radio" name="choice" value="count9;{count9+1}"/>
												<xsl:value-of select="choice9" disable-output-escaping="yes"/>
											</TD>
										</TR>
									</xsl:if>
									<xsl:if test="choice10!=''">
										<TR>
											<TD><xsl:if test="count10 &gt; 0"><xsl:value-of select="round(count10*100 div number($total))"/>%</xsl:if> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></TD>
											<TD>
												<input type="radio" name="choice" value="count10;{count10+1}"/>
												<xsl:value-of select="choice10" disable-output-escaping="yes"/>
											</TD>
										</TR>
									</xsl:if>
									<TR>
										<TD colspan="2" align="center"><input type="submit" value="{$string[102]}"/></TD>
									</TR>
								</FORM>
							</TABLE>
						</xsl:otherwise>
					</xsl:choose>
					
				</xsl:with-param>
			</xsl:call-template>		
			
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="lastfromforum">
	<xsl:param name="number"/>
	<xsl:if test="count(document($discussionfile)//message[visible='on']) &gt; 0">
		<xsl:call-template name="rightmargin_design">
			<!-- title -->
			<xsl:with-param name="title"><xsl:value-of select="$string[607]"/></xsl:with-param>
			<!--body-->
			<xsl:with-param name="body">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<xsl:for-each select="document($discussionfile)//message[visible='on']">
						<xsl:sort select="date" order="descending"/>
						<xsl:variable name="newsgroupid" select="ancestor::discussion/id"/>
						<xsl:variable name="messageid" select="ancestor-or-self::message/id[1]"/>
						<!-- Next line will set number of shown posts -->
						<xsl:if test="position()&lt;= $number">
							<tr>
								<td style="padding-right:3px;" valign="top">
									<img src="Admin/media/icon_latest.gif"></img><a href="default.asp?ACT=17&amp;grp={$newsgroupid}&amp;msg={$messageid}&amp;vp={$vpValue}"><xsl:value-of select="title"/></a><div align="right"><xsl:call-template name="display_date"><xsl:with-param name="p_Date" select="substring(date, 1, 8)"/></xsl:call-template></div>
								</td>
							</tr>
						</xsl:if>
					</xsl:for-each>
				</table>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	</xsl:template>



	<xsl:template name="lastarticles">
	<xsl:param name="number"/>
	<xsl:variable name="articles_node">
	<xsl:choose>
		<xsl:when test="$usertype='anonymous'">
			<xsl:for-each select="document($categoryfile)//categories/category[visible!='off' and member='off']">
			<xsl:variable name="categoryid" select="id"/>
				<category>
					<id><xsl:value-of select="id"/></id>
					<xsl:for-each select="document($datafile)//page[visible='on' and category=$categoryid]">
					<xsl:variable name="pageid" select="id"/>
				 		<page>
							<id><xsl:value-of select="id"/></id>
							<name><xsl:value-of select="name"/></name>
								<xsl:for-each select="document($datafile)//content[visible='on' and publicationdate &lt;= substring($actualdate,1,8) and type='body' and idpage=$pageid]">
							 	<content>
									<id><xsl:value-of select="id"/></id>
									<title><xsl:value-of select="title"/></title>
									<author><xsl:value-of select="author"/></author>
									<date><xsl:value-of select="date"/></date>
									<publicationdate><xsl:value-of select="publicationdate"/></publicationdate>
								</content>
		 					</xsl:for-each>
						</page>
					 </xsl:for-each>
				</category>
			 </xsl:for-each>
		</xsl:when>
		<xsl:when test="$usertype='member' or $usertype='editor'">
			<xsl:for-each select="document($categoryfile)//categories/category[visible!='off' and (member='off' or member='on')]">
			<xsl:variable name="categoryid" select="id"/>
				<category>
					<id><xsl:value-of select="id"/></id>
					<xsl:for-each select="document($datafile)//page[visible='on' and category=$categoryid]">
					<xsl:variable name="pageid" select="id"/>
				 		<page>
							<id><xsl:value-of select="id"/></id>
							<name><xsl:value-of select="name"/></name>
								<xsl:for-each select="document($datafile)//content[visible='on' and publicationdate &lt;= substring($actualdate,1,8) and type='body' and idpage=$pageid]">
							 	<content>
									<id><xsl:value-of select="id"/></id>
									<title><xsl:value-of select="title"/></title>
									<author><xsl:value-of select="author"/></author>
									<date><xsl:value-of select="date"/></date>
									<publicationdate><xsl:value-of select="publicationdate"/></publicationdate>
								</content>
		 					</xsl:for-each>
						</page>
					 </xsl:for-each>
				</category>
			 </xsl:for-each>
		</xsl:when>
		<xsl:when test="$usertype='administrator'">
			<xsl:for-each select="document($categoryfile)//categories/category[visible!='off']">
			<xsl:variable name="categoryid" select="id"/>
				<category>
					<id><xsl:value-of select="id"/></id>
					<xsl:for-each select="document($datafile)//page[visible='on' and category=$categoryid]">
					<xsl:variable name="pageid" select="id"/>
				 		<page>
							<id><xsl:value-of select="id"/></id>
							<name><xsl:value-of select="name"/></name>
								<xsl:for-each select="document($datafile)//content[visible='on' and publicationdate &lt;= substring($actualdate,1,8) and type='body' and idpage=$pageid]">
							 	<content>
									<id><xsl:value-of select="id"/></id>
									<title><xsl:value-of select="title"/></title>
									<author><xsl:value-of select="author"/></author>
									<date><xsl:value-of select="date"/></date>
									<publicationdate><xsl:value-of select="publicationdate"/></publicationdate>
								</content>
		 					</xsl:for-each>
						</page>
					 </xsl:for-each>
				</category>
			 </xsl:for-each>
		</xsl:when>
	</xsl:choose>
	</xsl:variable>


	<xsl:if test="count(document($datafile)//content[visible='on' and publicationdate &lt;= substring($actualdate,1,8) and type='body']) &gt; 0">
		<xsl:call-template name="rightmargin_design">
			<!-- title -->
			<xsl:with-param name="title"><xsl:value-of select="$string[608]"/></xsl:with-param>
			<!--body-->
			<xsl:with-param name="body">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<xsl:for-each select="msxsl:node-set($articles_node)//content">
						<xsl:sort select="publicationdate" order="descending"/>

						<!-- Next line will set number of shown posts -->
						<xsl:if test="position()&lt;= $number">
							<tr>
								<td style="padding-right:3px;" valign="top">
									<img src="Admin/media/icon_latest.gif"></img>
									<a href="default.asp?id={parent::page/id}&amp;ACT=5&amp;content={id}&amp;mnu={parent::page/id}"><xsl:value-of select="title"/><br/></a>
									<div align="right"><xsl:call-template name="display_date"><xsl:with-param name="p_Date" select="substring(date, 1, 8)"/></xsl:call-template></div>
								</td>
							</tr>
						</xsl:if>
					</xsl:for-each>
				</table>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	</xsl:template>
	
  <xsl:template name="commingevents">
	<xsl:param name="number"/>
	<xsl:call-template name="rightmargin_design">
		<!-- title -->
		<xsl:with-param name="title">Comming Events</xsl:with-param>
		<!--body-->
		<xsl:with-param name="body">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<!-- Next line will set number of shown posts -->
				<xsl:for-each select="event[eventdate &lt;= number(substring($actualdate, 1,8))] ">
					<xsl:sort select="eventdate" data-type="number" order="ascending"/>
					<xsl:if test="position()&lt;= $number">
						<tr>
							<td style="padding-right:3px;" valign="top">
								<xsl:value-of select="position()"/>.
							</td>
							<td>
								<a href="default.asp?id={idpage}&amp;ACT=5&amp;content={id}&amp;mnu={idpage}"><xsl:value-of select="shortdesc"/><br/></a>
									<xsl:value-of select="author"/><br/>
									<!-- notice: date display is "DD.MM.YYYY - HH:MM"  -->
									<!-- for other date format, change the order of appearence -->
									<!-- optional: day, month and year -->
									[<xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template>]<br/>
								</td>
							</tr>
						</xsl:if>

						</xsl:for-each>


				</table>
			</xsl:with-param>
		</xsl:call-template>


     </xsl:template>
</xsl:stylesheet>
