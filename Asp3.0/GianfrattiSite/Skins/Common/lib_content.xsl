<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb" exclude-result-prefixes="msxsl vb">

	<xsl:output method="html" indent="no"/>
	<xsl:include href="functions.xsl"/>
						
	<!-- Page title template -->
	<xsl:template name="content_title">
		<!-- Show the title if the option is set for the pages -->
		<xsl:if test="/siteinfo/pages/page[id=$mnu]/showtitle='on' or string-length(/siteinfo/pages/page[id=$mnu]/showtitle)=0">
			<xsl:call-template name="pagetitle_design">
				<xsl:with-param name="title">
					<xsl:value-of select="/siteinfo/pages/page[id=$mnu]/name" disable-output-escaping="yes"/>
					<xsl:if test="count(/siteinfo/pages/page[id=$id and $id!=$mnu])=1">
						 > <xsl:value-of select="/siteinfo/pages/page[id=$id]/name" disable-output-escaping="yes"/>
					</xsl:if>
					<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M2&amp;id={$id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="/siteinfo/pages/page[id=$mnu]/showtitle='off'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></xsl:if>
	</xsl:template>
		
	
	<!-- Content template, liste des accroches -->
	<xsl:template name="content_body">
		<xsl:variable name="pageCategoryID" select="/siteinfo/pages/page[id=$id]/category"/>
	<xsl:variable name="pageCategoryMembers" select="document($categoryfile)//categories/category[id=$pageCategoryID]/member"/>
		
		<xsl:choose>
			<xsl:when test="($pageCategoryMembers='on' and $usertype='anonymous') or ($pageCategoryMembers='admin' and $usertype!='administrator')">
				<xsl:call-template name="normaltext_design">
					<xsl:with-param name="text">
						<center><xsl:value-of select="$string[271]" disable-output-escaping="yes"/></center>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!-- l'edito de la page -->
				<xsl:if test="string-length(/siteinfo/pages/page[id=$id]/body)&gt;0">
				    <xsl:call-template name="hightlightedtext_design">
						<xsl:with-param name="text">
							<xsl:copy-of select="/siteinfo/pages/page[id=$id]/body"/>
						</xsl:with-param>
					</xsl:call-template>
					<br/>
				</xsl:if>
				
				<!-- la zone de headline -->
				<xsl:call-template name="headline_block"/>
				
				<xsl:if test="string-length(/siteinfo/pages/page[id=$id]/externallink)&gt;0">
					<iframe name="if1"  id="if1" class="external" frameborder="0" src="{/siteinfo/pages/page[id=$id]/externallink}"></iframe><!-- src="{/siteinfo/pages/page[id=$id]/externallink}" -->
					<!--<script language="javascript">
						onload = function() {
							 oIframe = document.getElementById('if1');
							 oIframe.attachEvent('onload', fnFrameLoadHandler );
							 oIframe.contentWindow.document.location = '<xsl:value-of select="/siteinfo/pages/page[id=$id]/externallink"/>';
							};
							
							function fnFrameLoadHandler() {
							// do something here using the this-keyword to refer to the iframe 
							//document.all.if1.style.height = oIframe.contentWindow.document.body.scrollHeight;
							}

					</script>-->
				</xsl:if>
						
				<!-- Call content template but with the good sorting -->
				<xsl:choose>
					<xsl:when test="/siteinfo/pages/page[id=$id]/sortfield='title' and string-length(/siteinfo/pages/page[id=$id]/sortorder)&gt;0">
						<xsl:apply-templates select="/siteinfo/contents/content[visible='on' and type='body' and (idpage=$id or idpage='0') and (string-length(publicationdate)=0 or $today>=publicationdate) and (string-length(expirationdate)=0 or expirationdate>$today) ]" mode="body">
							<xsl:sort select="title" order="{/siteinfo/pages/page[id=$id]/sortorder}"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:when test="/siteinfo/pages/page[id=$id]/sortfield='publicationdate' and string-length(/siteinfo/pages/page[id=$id]/sortorder)&gt;0">
						<xsl:apply-templates select="/siteinfo/contents/content[visible='on' and type='body' and (idpage=$id or idpage='0') and (string-length(publicationdate)=0 or $today>=publicationdate) and (string-length(expirationdate)=0 or expirationdate>$today) ]" mode="body">
							<xsl:sort select="publicationdate" order="{/siteinfo/pages/page[id=$id]/sortorder}" data-type="number"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:when test="/siteinfo/pages/page[id=$id]/sortfield='id' and string-length(/siteinfo/pages/page[id=$id]/sortorder)&gt;0">
						<xsl:apply-templates select="/siteinfo/contents/content[visible='on' and type='body' and (idpage=$id or idpage='0') and (string-length(publicationdate)=0 or $today>=publicationdate) and (string-length(expirationdate)=0 or expirationdate>$today) ]" mode="body">
							<xsl:sort select="id" order="{/siteinfo/pages/page[id=$id]/sortorder}" data-type="number"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
					   	<xsl:apply-templates select="/siteinfo/contents/content[visible='on' and type='body' and (idpage=$id or idpage='0') and (string-length(publicationdate)=0 or $today>=publicationdate) and (string-length(expirationdate)=0 or expirationdate>$today) ]" mode="body">
							<xsl:sort select="id" order="descending" data-type="number"/>
						</xsl:apply-templates>
					</xsl:otherwise>					
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		
		<!-- Paging Navigation is displayed if needed -->
		<!-- updated on 25 Nov 2002 - by seagoing  -->
		<xsl:if test="/siteinfo/pages/page[id=$id]/paging = 'on'">
			<xsl:call-template name="paging_Rail_macro">
				<xsl:with-param name="totalpage" select="ceiling(count(/siteinfo/contents/content[visible='on' and type='body' and (idpage=$id or idpage='0') and (string-length(publicationdate)=0 or $today>=publicationdate) and (string-length(expirationdate)=0 or expirationdate>$today) ]) div (number(/siteinfo/pages/page[id=$id]/articlenumber)-1))"/>
				<xsl:with-param name="currentpage" select="number($page)+1"/>
				<xsl:with-param name="url">default.asp?id=<xsl:value-of select="$id"/>&amp;mnu=<xsl:value-of select="$mnu"/></xsl:with-param>
			</xsl:call-template>
			<br/>
		</xsl:if>
		
		<!-- Add an article if administrator-->
		<xsl:if test="$usertype='administrator' or $usertype='editor'"><p><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M3&amp;id=new&amp;type=body&amp;page={$id}"><xsl:value-of select="$string[255]"/></a></p></xsl:if>							
							
	</xsl:template>	
	
	
	<!-- template pour un article -->
	<xsl:template match="content" mode="body">
		<xsl:variable name="articlenumber">
			<xsl:choose>
				<xsl:when test="string-length(/siteinfo/pages/page[id=$id]/articlenumber)=0">6</xsl:when>
				<xsl:otherwise><xsl:value-of select="/siteinfo/pages/page[id=$id]/articlenumber"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="floor">
			<xsl:choose>
				<xsl:when test="/siteinfo/pages/page[id=$id]/paging = 'on'">
					<xsl:value-of select="(number(/siteinfo/pages/page[id=$id]/articlenumber) - 1) * number($page)"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<!-- Updated by seagoing - 25/11/2002 -->
		<xsl:variable name="ceil">
			<xsl:choose>
				<xsl:when test="/siteinfo/pages/page[id=$id]/paging = 'on'">
					<xsl:value-of select="number($articlenumber) + number($floor)"/>
				</xsl:when>
				<xsl:otherwise><xsl:value-of select="number(/siteinfo/pages/page[id=$id]/articlenumber)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
					
		<xsl:choose>
			<xsl:when test="position() &gt; number($floor) and position() &lt; number($ceil) ">
				<!-- Article title if option is set-->
				<xsl:if test="showtitle='on' or string-length(showtitle)=0">
					<xsl:call-template name="title_design">
						<xsl:with-param name="title">
							<xsl:value-of select="title" disable-output-escaping="yes"/>
							<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M3&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				
				<!-- Article body -->
				<xsl:call-template name="normaltext_design">
					<xsl:with-param name="text">
						<xsl:choose>
							<xsl:when test="headlines!=''">
								<xsl:value-of select="headlines" disable-output-escaping="yes"/>
								<xsl:if test="(body!='') or (xmlsource!='' and xslsource!='') ">
									&lt;br/&gt;&lt;a class="normal" href="default.asp?id=<xsl:value-of select="$id"/>&amp;ACT=5&amp;content=<xsl:value-of select="id"/>&amp;mnu=<xsl:value-of select="$mnu"/>"&gt;&#62;&#62;<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[253]"/>&lt;/a&gt;
								</xsl:if>
							</xsl:when>
							<xsl:when test="string-length(headlines)=0 and (string-length(xmlsource)&gt;0 and string-length(xslsource)&gt;0)">
								<xsl:value-of select="vb:transform(string(xmlsource), string(xslsource), string($msxml4))" disable-output-escaping="yes"/>
							</xsl:when>
							<xsl:when test="headlines='' and xmlsource='' and xslsource='' and body!=''">
								<xsl:value-of select="body" disable-output-escaping="yes"/>
							</xsl:when>
						</xsl:choose>
						
						<xsl:if test="showdateauthor='on'">
						        [<xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template> - <xsl:value-of select="author"/>]
						</xsl:if>
						<br/>
					</xsl:with-param>
				</xsl:call-template>			
				
				<p/>					
					
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	
	<!-- Affiche le block de headlines -->
	<xsl:template name="headline_block">
				
		<table width="100%" cellpadding="2" cellspacing="4" border="0">
			<!-- Call content template but with the good sorting -->
			<xsl:choose>
				<xsl:when test="/siteinfo/pages/page[id=$id]/sortfield='title' and string-length(/siteinfo/pages/page[id=$id]/sortorder)&gt;0">
					<xsl:apply-templates select="/siteinfo/contents/content[visible='on' and type='headline' and (idpage=$id or idpage='0') and (string-length(publicationdate)=0 or $today>=publicationdate)  and (string-length(expirationdate)=0 or expirationdate>$today)]" mode="headline">
						<xsl:sort select="title" order="{/siteinfo/pages/page[id=$id]/sortorder}" data-type="text"/>
					</xsl:apply-templates>
				</xsl:when>
				<xsl:when test="/siteinfo/pages/page[id=$id]/sortfield='publicationdate' and string-length(/siteinfo/pages/page[id=$id]/sortorder)&gt;0">
					
					<xsl:apply-templates select="/siteinfo/contents/content[visible='on' and type='headline' and (idpage=$id or idpage='0') and (string-length(publicationdate)=0 or $today>=publicationdate)  and (string-length(expirationdate)=0 or expirationdate>$today)]" mode="headline">
						<xsl:sort select="publicationdate" order="{/siteinfo/pages/page[id=$id]/sortorder}" data-type="number"/>
					</xsl:apply-templates>
				</xsl:when>
				<xsl:when test="/siteinfo/pages/page[id=$id]/sortfield='id' and string-length(/siteinfo/pages/page[id=$id]/sortorder)&gt;0">
					<xsl:apply-templates select="/siteinfo/contents/content[visible='on' and type='headline' and (idpage=$id or idpage='0') and (string-length(publicationdate)=0 or $today>=publicationdate)  and (string-length(expirationdate)=0 or expirationdate>$today)]" mode="headline">
						<xsl:sort select="id" order="{/siteinfo/pages/page[id=$id]/sortorder}" data-type="number"/>
					</xsl:apply-templates>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="/siteinfo/contents/content[visible='on' and type='headline' and (idpage=$id or idpage='0') and (string-length(publicationdate)=0 or $today>=publicationdate)  and (string-length(expirationdate)=0 or expirationdate>$today)]" mode="headline">
						<xsl:sort select="id" order="descending" data-type="number"/>
					</xsl:apply-templates>
				</xsl:otherwise>
			</xsl:choose>					
		</table><br/>
	</xsl:template>
	
	
	<xsl:template match="content" mode="headline">
		<xsl:if test="(position() mod 2)=1">
			<xsl:element name="tr"/>
		</xsl:if>
		<td valign="top" width="50%">						
			<xsl:call-template name="headline_design">
				
				<!-- title -->
				<xsl:with-param name="title">
					<xsl:if test="showtitle='on' or string-length(showtitle)=0"><xsl:value-of select="title" disable-output-escaping="yes"/></xsl:if>
					<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M3&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
				</xsl:with-param>
				
				<!-- body -->
				<xsl:with-param name="content">
					<xsl:choose>
						<xsl:when test="headlines!=''">
							<xsl:copy-of select="headlines"/>
							<xsl:if test="(body!='') or (xmlsource!='' and xslsource!='') ">
								&lt;br/&gt;&lt;a class="normal" href="default.asp?id=<xsl:value-of select="$id"/>&amp;ACT=5&amp;content=<xsl:value-of select="id"/>&amp;mnu=<xsl:value-of select="$mnu"/>"&gt;&#62;&#62;<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[253]"/>	&lt;/a&gt;
							</xsl:if>
						</xsl:when>
						<xsl:when test="headlines='' and (xmlsource!='' and xslsource!='')">
							<xsl:value-of select="vb:transform(string(xmlsource), string(xslsource), string($msxml4))" disable-output-escaping="yes"/>
						</xsl:when>
						<xsl:when test="headlines='' and xmlsource='' and xslsource='' and body!=''">
							<xsl:copy-of select="body"/>
						</xsl:when>
					</xsl:choose>
				</xsl:with-param>															
			</xsl:call-template>
		</td>
	</xsl:template>

	
	
	<!-- Engin for the detail of an article -->
	<xsl:template name="article">
		
		<xsl:for-each select="/siteinfo/contents/content[id=$content]">			
			
					<!-- Article title -->
					<xsl:call-template name="title_design">
						<xsl:with-param name="title">
							<xsl:value-of select="title" disable-output-escaping="yes"/>
							<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M3&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
						</xsl:with-param>
					</xsl:call-template>					
					
					<!-- Article headlines -->
					<xsl:call-template name="hightlightedtext_design">
						<xsl:with-param name="text">
							<xsl:copy-of select="headlines"/><p/>
						</xsl:with-param>
					</xsl:call-template>					
					
					<!-- Article body -->
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="body" disable-output-escaping="yes"/>
							<xsl:if test="string-length(xmlsource)&gt;0 and string-length(xslsource)&gt;0">
								<xsl:value-of select="vb:transform(string(xmlsource), string(xslsource), string($msxml4))" disable-output-escaping="yes"/>								
							</xsl:if>
							<xsl:if test="showdateauthor='on'">
								<br/>
								   [<xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template> - <xsl:value-of select="author"/>]							</xsl:if>
						</xsl:with-param>
					</xsl:call-template>					
					
					
					
					<!-- Do we show the article toolbar -->
					<xsl:if test="/siteinfo/contents/content[id=$content]/showtoolbar='on' and $layout!='printer'">
						<script language="javascript">
							function PrintArticle() 
							{
								fx_printwin = window.open('?id=<xsl:value-of select="$id"/>&amp;ACT=<xsl:value-of select="$ACT"/>&amp;content=<xsl:value-of select="$content"/>&amp;mnu=<xsl:value-of select="$mnu"/>&amp;layout=printer','printWin','width=480, height=400, scrollbars=yes'); 
								fx_printwin.focus();
								fx_printwin.print();
							}
						</script>
					
						<p/>
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#000000">
							<TR>
								<TD width="100%">
									<img src="media/dot.gif" height="1" width="1"/>
								</TD>
							</TR>
						</TABLE>
						<TABLE width="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
							<TR>
								<td valign="top" width="33%" align="center">
									<a href="#" onclick="PrintArticle()">
										<img BORDER="0" SRC="admin/media/bt2_print.gif" align="absmiddle"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><small>
											<xsl:value-of select="$string[84]"/>
										</small>
									</a>
								</td>
								<td valign="top" width="33%" align="center">
									<a><xsl:attribute name="href">mailto:%20?subject=<xsl:value-of select="/siteinfo/contents/content[id=$content]/title"/>&amp;body=<xsl:value-of select="/siteinfo/data/url"/>/default.asp?id=<xsl:value-of select="$id"/>%26ACT=5%26content=<xsl:value-of select="id"/>%26mnu=<xsl:value-of select="$mnu"/></xsl:attribute>								
		<img BORDER="0" SRC="admin/media/bt2_email.gif" align="absmiddle"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><small>
								
			<xsl:value-of select="$string[85]"/>
								
		</small>
								
	</a>

								</td>
								<td valign="top" width="33%" align="center">
									<a href="default.asp?ACT=12&amp;id={id}">
										<img src="admin/media/bt2_popular.gif" border="0" align="absmiddle"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><small>
											<xsl:value-of select="$string[86]"/>
										</small>
									</a>
								</td>
							</TR>
						</TABLE>
						<TABLE width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#000000">
							<TR><TD width="100%"><img src="admin/media/dot.gif" height="1" width="1"/></TD></TR>
						</TABLE>
					</xsl:if>
					<br/>
					
					
					<!-- les reactions -->
					<xsl:if test="count(document($reactfile)//reacts/react[idcontent=$content and visible='on'])>0">
						
						<xsl:call-template name="pagetitle_design">
							<xsl:with-param name="title"><xsl:value-of select="$string[315]"/></xsl:with-param>
						</xsl:call-template>						
						
						<xsl:for-each select="document($reactfile)//reacts/react[idcontent=$content and visible='on']">
							<xsl:sort select="date" data-type="number" order="descending"/>							
												
							<!-- Title of the reaction -->		
							<xsl:call-template name="title_design">
								<xsl:with-param name="title">
									<xsl:value-of select="title"/><xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M10&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
								</xsl:with-param>
							</xsl:call-template>
									
							<!-- Body of the reaction -->
							<xsl:call-template name="normaltext_design">
								<xsl:with-param name="text">
									<xsl:value-of select="$string[316]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>[<xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template> - <xsl:value-of select="pseudo"/>]
									<br/><xsl:value-of select="message"/>
								</xsl:with-param>
							</xsl:call-template>
							<br/>
						</xsl:for-each>
					</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	
	
	
	<!-- React template-->
	<xsl:template name="react">
		<!--<xsl:variable name="id" select="/siteinfo/aspcontext/request/id"/>-->
		
			<xsl:call-template name="pagetitle_design">
				<xsl:with-param name="title"><xsl:value-of select="$string[315]"/></xsl:with-param>
			</xsl:call-template>
		
		<table cellpadding="0" cellspacing="0">
			<form action="default.asp?ACT=13" method="post">
				<input type="hidden" name="idcontent" value="{$id}"/>
				<input type="hidden" name="operation" value="add"/>
				<input type="hidden" name="file" value="reactions"/>
				<input type="hidden" name="bloc" value="reacts"/>
				<input type="hidden" name="node" value="react"/>
				
				<xsl:choose>
					<xsl:when test="/siteinfo/data/reactionstate='on'"><input type="hidden" name="visible" value="on"/></xsl:when>
					<xsl:otherwise><input type="hidden" name="visible" value="off"/></xsl:otherwise>
				</xsl:choose>				
				
				<tr><td colspan="2"><b><xsl:value-of select="$string[310]"/> : </b><xsl:value-of select="/siteinfo/contents/content[id=$id]/title" disable-output-escaping="yes"/></td></tr>				
				<tr>
					<td><b><xsl:value-of select="$string[311]"/> :</b></td>
					<td>
						<input type="text" name="comp_pseudo" class="input"/>
					</td>
				</tr>
				<tr>
					<td><b><xsl:value-of select="$string[312]"/> :</b></td>
					<td>
						<input type="text" name="comp_title" class="input"/>
					</td>
				</tr>
				<tr>	<td colspan="2"><b><xsl:value-of select="$string[313]"/> :</b></td></tr>
				<tr>	<td colspan="2"><textarea name="comp_message" cols="50" rows="10" class="input"/></td></tr>
				<tr>	<td colspan="2" align="center"><input type="submit" value="{$string[314]}"/></td></tr>
			</form>
		</table>
	</xsl:template>
	
	
	<!-- React and guestbook template -->
	<xsl:template name="reactthx">
		<xsl:variable name="vbcrlf">
		<xsl:text>
</xsl:text>
		</xsl:variable>
		
		
		<!-- if user want it, send an mail alert -->
			<xsl:if test="$operation='add' and $file='guestbook' and /siteinfo/data/wguestbook='on'">
				<xsl:call-template name="Mailer">
					<xsl:with-param name="ToEmail" select="string(/siteinfo/data/email)"/>
					<xsl:with-param name="FromEmail" select="string($email)"/>
					<xsl:with-param name="Subject" select="concat($string[382], ' : ', $comp_title)"/>
					<xsl:with-param name="Message" select=" concat($comp_title, $vbcrlf, $comp_body,$vbcrlf, /siteinfo/data/url)"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="$operation='add' and $file='reactions'">
				<xsl:if test="/siteinfo/data/wreaction='on'">
					<xsl:call-template name="Mailer">
						<xsl:with-param name="ToEmail" select="string(/siteinfo/data/email)"/>
						<xsl:with-param name="FromEmail" select="string(/siteinfo/data/email)"/>
						<xsl:with-param name="Subject" select="concat($string[384], ' : ', $comp_title)"/>
						<xsl:with-param name="Message" select=" concat($comp_title, $vbcrlf, $comp_message,$vbcrlf, /siteinfo/data/url)"/>
					</xsl:call-template>					
				</xsl:if>
		</xsl:if>	
		
		<!-- show a message-->
		<xsl:call-template name="normaltext_design">
			<xsl:with-param name="text">
				<xsl:choose>
					<xsl:when test="$file='guestbook'"><xsl:value-of select="$string[149]" disable-output-escaping="yes"/></xsl:when>
					<xsl:when test="$file='reactions'"><xsl:value-of select="$string[456]" disable-output-escaping="yes"/></xsl:when>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
