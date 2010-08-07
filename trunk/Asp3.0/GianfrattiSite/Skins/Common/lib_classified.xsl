<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
version="1.0">
<!-- creation: 2003/12/04, by Mig100 (Miguel Figueira), FxMods -->
<!-- last edition: 2004/03/15, by Mig100 (Miguel Figueira), FxMods -->
  <xsl:variable name="presentdate" select="number(substring($actualdate,1,8))" />
	<xsl:variable name="explicitautorization" select="document($classifiedfile)/classified/settings/autorization" />


<xsl:template name="classified_manager">
	<script language="JavaScript" SRC="admin/js/AnchorPosition.js"></script>
	<script language="JavaScript" SRC="admin/js/PopupWindow.js"></script>
	<script language="JavaScript" SRC="admin/js/CalendarPopup.js"></script>
	<script language="JavaScript" SRC="admin/js/date.js"></script>
	<script language="JavaScript" SRC="admin/js/ColorPicker2.js"></script>
	<script language="JavaScript">
			// Create CalendarPopup object
			var cal = new CalendarPopup();				
			document.write(cal.getStyles());
	</script>
	<style type="text/css">
		input{font-size: 12px; font-weight: normal; font-family: arial;}
		input.medium{ width: 100px; background-color: #D6EBFF; color: #000000;font-weight: normal; border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid;}
		input.medium2{ width: 200px; background-color: #D6EBFF; color: #000000;font-weight: normal; border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid;}
		input.medium3{ width: 300px; background-color: #D6EBFF; color: #000000;font-weight: normal; border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid;}
		input.full{ width: 450px; background-color: #D6EBFF; color: #000000; font-weight: normal; border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid;}

		select {width: 200px; background-color: #D6EBFF; color: #000000; font-size: 12px; font-weight: normal; font-family: arial; border: 1px #4C4C4C solid; filter: alpha(opacity=100);}
		select.full {width: 300px; background-color: #D6EBFF; color: #000000; font-size: 12px; font-weight: normal; font-family: arial; border: 1px #4C4C4C solid; filter: alpha(opacity=100);}		
	</style>
	<script>
		var fx_imgwin;
		var fx_opener;
			 			
		function OpenImage(oOpener)
		{
			fx_opener = oOpener;
			fx_imgwin = window.open('filepicker.asp','selImg','width=450, height=330, scrollbars=yes');
			fx_imgwin.focus();
		}
			
		function onImage(u, base_url, iborder, ialign, ialt, num)
                {
			fx_opener.value = u;
			fx_imgwin.close();
		}
	</script>
	<table summary="" cellspacing="5" width="100%">
		<tr>
        		<td valign="top">
				<xsl:choose>
					<xsl:when test="document($datafile)/siteinfo/data/classified!='on'">
						<p />
	      					<xsl:value-of select="$string[$classbasestring + 60]"/>
            				</xsl:when>
            				<xsl:when test="$cmd='search'">
              					<xsl:call-template name="classified_searchtabledisplay" />
            				</xsl:when>
            				<xsl:when test="$cmd='mylist'">
						<xsl:call-template name="classified_myaddlist" />
            				</xsl:when>
					<xsl:when test="$cmd='edit' and $add &gt; 0">
						<xsl:call-template name="classifiedadd_update" />
            				</xsl:when>
					<xsl:when test="$cmd='react' and $add &gt; 0">
						<xsl:call-template name="classifiedadd_react" />
            				</xsl:when>
					<xsl:when test="$cmd='terms'">
						<xsl:call-template name="classified_terms" />
					</xsl:when>
					<xsl:when test="$cmd='userOK'">
						<xsl:call-template name="classified_usersubmited" />
					</xsl:when>
					<xsl:when test="$add = 'new'">
						<xsl:call-template name="classifiedadd_accesscontrol" />
					</xsl:when>
					<xsl:when test="$add &gt; 0">
						<xsl:call-template name="classifiedadd_view" />
					</xsl:when>
					<xsl:when test="$cat=0">
						<xsl:call-template name="classifiedcat_entrance" />
					</xsl:when>
					<xsl:when test="$explicitautorization='on' and $user=0">
						<xsl:call-template name="classified_newuser" />
					</xsl:when>
					<xsl:when test="$cat &gt; 0">
						<xsl:call-template name="classifiedcat_view" />
						<xsl:if test="count(document($classifiedfile)//add[catid=$cat and visible='on']) &gt; 0">
							<xsl:call-template name="classifiedaddlist" />
						</xsl:if>
            				</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="document($classifiedfile)/classified/settings/welcomedisplay!='on'">
              							<xsl:call-template name="classifiedcat_entrance" />
							</xsl:when>
							<xsl:otherwise>
								<p />
              					 		<xsl:value-of select="document($classifiedfile)/classified/settings/intro" disable-output-escaping="yes" />
              					 		<p align="center">
                				 		<input type="button" onclick="document.location.href='default.asp?ACT=70&amp;id=0&amp;cat=0';" value="{$string[$classbasestring + 62]}" />
								</p>
							</xsl:otherwise>
						</xsl:choose>
            				</xsl:otherwise>
				</xsl:choose>
        		</td>
        		<xsl:if test="$layout!='printer' and ($cat or $add or $user or $cmd='search'or $cmd='mylist' or (document($classifiedfile)/classified/settings/welcomedisplay!='on' and not($cat))) ">
          			<td width="15"></td>
          			<td width="140" valign="top">
            				<xsl:call-template name="classified_margin_options" />
            				<xsl:call-template name="classified_margin_search" />
						<xsl:if test="count(document($classifiedfile)//add[visible='on' and startdate &lt;= $presentdate and enddate &gt;= $presentdate]) &gt; 0">						
							<xsl:call-template name="classified_margin_most" />
							<xsl:call-template name="classified_margin_justin" />
						</xsl:if>
          			</td>
        		</xsl:if>
      		</tr>
    	</table>
</xsl:template>

<!-- Categories grid list-->
<xsl:template name="classifiedcat_entrance">
	<table Width="100%" align="center" cellpadding="2" cellspacing="2">
		<xsl:choose>
			<xsl:when test="count(document($classifiedfile)//cat)=0">
				<tr>
					<td colspan="2"><br /><xsl:value-of select="$string[$classbasestring + 30]"/></td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td colspan="2"><br /><xsl:value-of select="$string[$classbasestring + 59]"/></td>
				</tr>
				<tr>
					<xsl:for-each select="document($classifiedfile)/classified/categories/cat[visible='on']">
						<td align="center">
							<br/>
							<xsl:call-template name="classifiedcat_listdesign">
        	          					<xsl:with-param name="catId">
                	    						<xsl:value-of select="id" />
								</xsl:with-param>
							</xsl:call-template>
						</td>
						<xsl:if test="position() mod 2 = 0">
							<xsl:value-of select="'&lt;/tr&gt;&lt;tr&gt;'" disable-output-escaping="yes" />
						</xsl:if>
					</xsl:for-each>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</table>
</xsl:template>

<!-- Categories view -->
<xsl:template name="classifiedcat_view">
	<xsl:variable name="parentId">
		<xsl:choose>
			<xsl:when test="document($classifiedfile)//cat[cat/id=$cat]">
				<xsl:value-of select="document($classifiedfile)//cat[cat/id=$cat]/id" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="number(0)" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<table Width="100%" align="center" cellpadding="2" cellspacing="2">
		<tr>
			<td colspan="2">
				<xsl:value-of select="document($classifiedfile)//cat[id=$cat]/intro" disable-output-escaping="yes" />
			</td>
		</tr>
		<xsl:if test="count(document($classifiedfile)//cat[id=$cat]/cat[visible='on']) &gt; 0">
			<tr>
				<td colspan="2">
					<xsl:call-template name="title_design">
						<xsl:with-param name="title">
							<xsl:value-of select="$string[$classbasestring + 12]"/>
						</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<xsl:for-each select="document($classifiedfile)//cat[id=$cat]/cat[visible='on']">
					<td align="center">
						<xsl:call-template name="classifiedcat_listdesign">
							<xsl:with-param name="catId">
								<xsl:value-of select="id" />
							</xsl:with-param>
						</xsl:call-template>
					</td>
					<xsl:if test="position() mod 2 = 0">
						<xsl:value-of select="'&lt;/tr&gt;&lt;tr&gt;'" disable-output-escaping="yes" />
					</xsl:if>
				</xsl:for-each>
			</tr>
		</xsl:if>
	</table>
</xsl:template>

<!-- Sub-categories for specific Categories. it uses margins box desgin template -->
<xsl:template name="classifiedcat_listdesign">
	<xsl:param name="catId" />

	<xsl:for-each select="document($classifiedfile)/classified//cat[id=$catId]">
		<xsl:call-template name="margin_design">
			<xsl:with-param name="title">
				<a class="toolbar" href="default.asp?ACT=70&amp;id=0&amp;cat={id}">
					<xsl:choose>
						<xsl:when test="string-length(image) &gt; 0">
							<img src="{image}" border="0" width="12" height="12" />
						</xsl:when>
						<xsl:otherwise>
							<img src="admin/media/classcat.gif" border="0" width="16" height="16" />
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="$nbsp" disable-output-escaping="yes" /><xsl:value-of select="name" />
				</a>
				<xsl:if test="$usertype='administrator'">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes" />
					<a href="default.asp?ACT=1&amp;SECT=M70&amp;cmd=edit&amp;cat={id}">
						<img src="admin/media/edit.gif" border="0" width="6" height="6" />
					</a>
				</xsl:if>
			</xsl:with-param>
			<xsl:with-param name="body">
				<table>
					<tr>
						<td>
							<xsl:value-of select="$string[$classbasestring + 36]"/>:<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
              						<xsl:value-of select="count(document($classifiedfile)//cat[id=$catId]//cat)" />
                         					<br />
								<xsl:value-of select="$string[$classbasestring + 37]"/>:<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
								<a href="default.asp?ACT=70&amp;id=0&amp;cat={id}&amp;add=0">
									<xsl:value-of select="count(document($classifiedfile)//add[catid=$catId and visible='on' and startdate &lt;= $presentdate and enddate &gt;= $presentdate])" />
								</a>
						</td>
					</tr>
				</table>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:for-each>
</xsl:template>

<xsl:template name="classifiedaddlist">
	<table border="0" cellpadding="2" cellspacing="2" width="100%">
		<tr align="center">
			<td colspam="4">
				<xsl:call-template name="title_design">
					<xsl:with-param name="title"><xsl:value-of select="$string[$classbasestring + 11]"/></xsl:with-param>
				</xsl:call-template>
			</td>
		</tr>
		<tr align="center">
			<td>
				<table width="100%">
					<tr bgcolor="{$toolbar_background}">
						<td align="center">
							<a class="toolbar"><xsl:value-of select="$string[127]"/></a>
						</td>
						<td align="center">
							<a class="toolbar"><xsl:value-of select="$string[142]"/></a>
						</td>
						<td align="center">
							<a class="toolbar"><xsl:value-of select="$string[$classbasestring + 43]"/></a>
						</td>
						<td align="center">
							<a class="toolbar"><xsl:value-of select="$string[$classbasestring + 63]"/></a>
						</td>
					</tr>
					<xsl:for-each select="document($classifiedfile)//add[catid=$cat and visible='on' and startdate &lt;= $presentdate and enddate &gt;= $presentdate]">
						<xsl:call-template name="classifiedadd_list">
							<xsl:with-param name="addId" select="id" />
						</xsl:call-template>
					</xsl:for-each>
				</table>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="classified_myaddlist">
	<table border="0" cellpadding="2" cellspacing="2" width="100%">
		<tr align="center">
			<td colspam="4">
				<xsl:call-template name="title_design">
					<xsl:with-param name="title"><xsl:value-of select="$string[$classbasestring + 11]"/></xsl:with-param>
				</xsl:call-template>
			</td>
		</tr>
		<tr align="center">
			<td>
				<table width="100%">
					<tr bgcolor="{$toolbar_background}">
						<td align="center">
							<a class="toolbar"><xsl:value-of select="$string[127]"/></a>
						</td>
						<td align="center">
							<a class="toolbar"><xsl:value-of select="$string[142]"/></a>
						</td>
						<td align="center">
							<a class="toolbar"><xsl:value-of select="$string[$classbasestring + 43]"/></a>
						</td>
						<td align="center">
							<a class="toolbar"><xsl:value-of select="$string[$classbasestring + 63]"/></a>
						</td>
						<td align="center">
							<a class="toolbar"><xsl:value-of select="$string[$classbasestring + 42]"/></a>
						</td>
					</tr>
					<xsl:for-each select="document($classifiedfile)//add[owner = $username]">
						<xsl:call-template name="classifiedadd_list">
							<xsl:with-param name="addId" select="id" />
						</xsl:call-template>
					</xsl:for-each>
				</table>
			</td>
		</tr>
	</table>
</xsl:template>


<xsl:template name="classifiedadd_list">
	<xsl:param name="addId" />

	<xsl:for-each select="document($classifiedfile)//add[id=$addId]">
		<tr>
			<td align="center">
				<xsl:value-of select="id" />
			</td>
			<td align="left">
				<a href="default.asp?ACT=70&amp;id=0&amp;cat={catid}&amp;add={id}">
					<xsl:value-of select="title" />
				</a>
			</td>
			<td align="center">
				<xsl:value-of select="owner" />
			</td>
			<td align="center">
				<xsl:if test="string-length(image)&gt;0">
					<img src="admin/media/pictures.gif" border="0" width="16" height="16" />
				</xsl:if>
			</td>
			<xsl:if test="$cmd='mylist'">
				<td align="center">
					<xsl:choose>
						<xsl:when test="enddate &lt; $presentdate"><font color="red" ><xsl:value-of select="$string[$classbasestring + 39]"/></font></xsl:when>
						<xsl:when test="visible='off'and enddate &gt;= $presentdate"><font color="blue"><xsl:value-of select="$string[$classbasestring + 38]"/></font></xsl:when>
						<xsl:when test="visible='off'"><font color="red"><xsl:value-of select="$string[$classbasestring + 44]"/></font></xsl:when>
						<xsl:otherwise><font color="green"><xsl:value-of select="$string[$classbasestring + 45]"/></font></xsl:otherwise>
					</xsl:choose>
				</td>
			</xsl:if>
		</tr>
	</xsl:for-each>
</xsl:template>

<xsl:template name="classifiedadd_view">
	<xsl:for-each select="document($classifiedfile)//add[id=$add]">
		<xsl:if test="visible='on' and startdate &lt;= $presentdate and enddate &gt;= $presentdate">
			<table width="100%" cellspacing="2" cellpadding="2">
				<tr>
					<td>
						<xsl:call-template name="title_design">
							<xsl:with-param name="title">
								<xsl:value-of select="title" />
							</xsl:with-param>
						</xsl:call-template>
						<p />
					</td>
				</tr>
				<tr>
					<td>
						<xsl:if test="string-length(image) &gt; 0">
							<img src="{image}" align="left" hspace="10" vspace="5" />
						</xsl:if>
						<xsl:value-of select="body" disable-output-escaping="yes" />
						<p/>
					</td>
				</tr>
				<xsl:if test="string-length(site) &gt; 0">
					<tr>
						<td><b><xsl:value-of select="$string[$classbasestring + 48]"/>:<xsl:value-of select="$nbsp" disable-output-escaping="yes"/></b><a href="{site}" target="new"><xsl:value-of select="site" /></a><br/></td>
					</tr>
				</xsl:if>
				<xsl:if test="string-length(price) &gt; 0">
					<tr>
						<td>
							<b><xsl:value-of select="$string[$classbasestring + 46]"/>:<xsl:value-of select="$nbsp" disable-output-escaping="yes"/></b><xsl:value-of select="price" /><br/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="string-length(units) &gt; 0">
					<tr>
						<td>
							<b><xsl:value-of select="$string[$classbasestring + 47]"/>:<xsl:value-of select="$nbsp" disable-output-escaping="yes"/></b><xsl:value-of select="units" /><br/>
                                                </td>
					</tr>
				</xsl:if>		
			</table>
		</xsl:if>

		<!-- We show the article toolbar -->
		<xsl:if test="$layout!='printer'">
			<script language="javascript">
  				function PrintArticle() 
					{
						fx_printwin = window.open('?id=<xsl:value-of select="$id"/>&amp;ACT=<xsl:value-of select="$ACT"/>&amp;content=<xsl:value-of select="$content"/>&amp;add=<xsl:value-of select="$add"/>&amp;layout=printer','printWin','width=480, height=400, scrollbars=yes'); 
						fx_printwin.focus();
						fx_printwin.print();
					}
			</script>
					
			<p/>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#000000">
				<tr>
					<td width="100%">
						<img src="media/dot.gif" height="1" width="1"/>
					</td>
				</tr>
			</table>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" width="33%" align="center">
						<a href="#" onclick="PrintArticle()"><img BORDER="0" SRC="admin/media/bt2_print.gif" align="absmiddle"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><small><xsl:value-of select="$string[84]"/></small></a>
					</td>
					<td valign="top" width="33%" align="center">
						<a><xsl:attribute name="href">mailto:%20?subject=<xsl:value-of select="document($classifiedfile)//add[id=$add]/title"/>&amp;body=<xsl:value-of select="document($datafile)//siteinfo/data/url"/>/default.asp?id=<xsl:value-of select="$id"/>%26ACT=<xsl:value-of select="$ACT"/>%26add=<xsl:value-of select="$add"/></xsl:attribute><img border="0" src="admin/media/bt2_email.gif" align="absmiddle"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><small><xsl:value-of select="$string[85]"/></small></a>
					</td>
					<td valign="top" width="33%" align="center">
						<a href="default.asp?ACT=70&amp;id=0&amp;cmd=react&amp;add={id}"><img src="admin/media/bt2_popular.gif" border="0" align="absmiddle"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><small><xsl:value-of select="$string[86]"/></small></a>
					</td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#000000">
				<tr>
					<td width="100%">
						<img src="admin/media/dot.gif" height="1" width="1"/>
					</td>
				</tr>
			</table>
			<br/>
			<!-- reactions -->
			<xsl:if test="count(document($classifiedfile)//add[id=$add]/messages/message) &gt; 0">
     				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title"><xsl:value-of select="$string[$classbasestring + 64]"/></xsl:with-param>
				</xsl:call-template>

				<xsl:for-each select="document($classifiedfile)//add[id=$add]/messages/message">
					<xsl:sort select="date" data-type="number" order="descending"/>
					<!-- Title of the reaction -->
					<xsl:call-template name="title_design">
						<xsl:with-param name="title">
							<xsl:value-of select="title"/>
						</xsl:with-param>
					</xsl:call-template>

					<!-- Body of the reaction -->
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[316]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>[<xsl:value-of select="substring(date, 7, 2)"/>.<xsl:value-of select="substring(date, 5, 2)"/>.<xsl:value-of select="substring(date, 1, 4)"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="substring(date, 9, 2)"/>:<xsl:value-of select="substring(date, 11, 2)"/> - <xsl:if test="user"><xsl:value-of select="user"/></xsl:if><xsl:if test="name"><xsl:value-of select="name"/></xsl:if>]
							<br/><xsl:value-of select="body" disable-output-escaping="yes"/>
						</xsl:with-param>
					</xsl:call-template>
					<br/>
				</xsl:for-each>
			</xsl:if>
		</xsl:if>
	</xsl:for-each>
</xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--               Margin                 -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<xsl:template name="classified_margin_most">
	<xsl:call-template name="margin_design">
		<xsl:with-param name="title">
			<xsl:value-of select="$string[536]"/>
		</xsl:with-param>
		<xsl:with-param name="body">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<xsl:for-each select="document($classifiedfile)//add[visible='on' and startdate &lt;= $presentdate and enddate &gt;= $presentdate and count &gt;0]">
					<xsl:sort select="count" data-type="number" order="descending"/>
					<!-- Next line will set number of shown posts -->
					<xsl:if test="position()&lt;= 5">
						<tr>
							<td style="padding-right:3px;" valign="top">
								<img src="Admin/media/icon_latest.gif"></img><a href="default.asp?ACT=70&amp;id=0&amp;add={id}"><xsl:value-of select="title"/></a><div align="right"><xsl:value-of select="count"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[$classbasestring + 65]"/></div>
							</td>
						</tr>
					</xsl:if>
				</xsl:for-each>
			</table>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="classified_margin_justin">
	<xsl:call-template name="margin_design">
		<xsl:with-param name="title">
			<xsl:value-of select="$string[$classbasestring + 66]"/>
		</xsl:with-param>
		<xsl:with-param name="body">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<xsl:for-each select="document($classifiedfile)//add[visible='on' and startdate &lt;= $presentdate and enddate &gt;= $presentdate]">
					<xsl:sort select="date" order="descending"/>
					<!-- Next line will set number of shown posts -->
					<xsl:if test="position()&lt;= 5">
						<tr>
							<td style="padding-right:3px;" valign="top">
								<img src="Admin/media/icon_latest.gif"></img><a href="default.asp?ACT=70&amp;id=0&amp;add={id}"><xsl:value-of select="title"/></a><div align="right"><xsl:call-template name="display_date"><xsl:with-param name="p_Date" select="substring(date, 1, 8)"/></xsl:call-template></div>
							</td>
						</tr>
					</xsl:if>
				</xsl:for-each>
			</table>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>
	
<xsl:template name="classified_margin_search">
	<xsl:call-template name="margin_design">
		<xsl:with-param name="title">
			<xsl:value-of select="$string[$classbasestring + 67]"/>
		</xsl:with-param>
		<xsl:with-param name="body">
			<table cellspacing="1" cellpadding="0" border="0" align="center">
				<form action="default.asp?ACT=70&amp;id=0&amp;cmd=search" method="post">
					<tr>
						<td>
							<input class="text" size="10" type="text" name="search"/>
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
							<input type="submit" value='ok' class="sbttn"/>
						</td>
					</tr>
				</form>
			</table>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>
	
<xsl:template name="classified_margin_options">
	<xsl:variable name="catid" select="document($classifiedfile)//add[id=$add]/catid"/>
	<xsl:call-template name="margin_design">
		<xsl:with-param name="title">
			<xsl:value-of select="$string[$classbasestring + 11]"/>
		</xsl:with-param>
		<xsl:with-param name="body">
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td>
						<xsl:call-template name="menu_item_design">
							<xsl:with-param name="content">
								<a class= "menu" href="default.asp?ACT=70&amp;id=0&amp;cat=0" title="{$string[$classbasestring + 7]}"><xsl:value-of select="$string[480]"/></a>
							</xsl:with-param>
						</xsl:call-template>
					</td>
				</tr>
				<xsl:if test="$cat &gt; 0">
					<xsl:for-each select="document($classifiedfile)//cat[id=$cat]">
						<xsl:if test="parent::cat">
							<tr>
								<td>
									<xsl:call-template name="menu_item_design">
										<xsl:with-param name="content">
											<a class= "menu" href="default.asp?ACT=70&amp;id=0&amp;cat={parent::cat/id}" title="{concat($string[$classbasestring + 31], ' ', parent::cat/name, ' ', $string[$classbasestring + 41])}"><xsl:value-of select="concat(parent::cat/name, ' ', $string[$classbasestring + 41])"/></a>
										</xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
						</xsl:if>
					  </xsl:for-each>
				</xsl:if>
				<xsl:if test="$add &gt; 0">
					<tr>
						<td>
							<xsl:call-template name="menu_item_design">
								<xsl:with-param name="content">
									<a class= "menu" href="default.asp?ACT=70&amp;id=0&amp;cat={document($classifiedfile)//add[id=$add]/catid}" title="{concat($string[$classbasestring + 31], ' ', document($classifiedfile)//cat[id=$catid]/name, ' ', $string[$classbasestring + 41])}"><xsl:value-of select="concat(document($classifiedfile)//cat[id=$catid]/name, ' ', $string[$classbasestring + 41])"/></a>
								</xsl:with-param>
							</xsl:call-template>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="$explicitautorization='on' and count(document($classifiedfile)//user[userpseudo=$username])=0 and $usertype != 'administrator' and $username">
					<tr>
						<td>
							<xsl:call-template name="menu_item_design">
								<xsl:with-param name="content">
									<a class= "menu" href="default.asp?ACT=70&amp;id=0&amp;user=0" title="{$string[$classbasestring + 69]}"><xsl:value-of select="$string[$classbasestring + 68]"/></a>
								</xsl:with-param>
							</xsl:call-template>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="count(document($classifiedfile)//add[owner = $username and visible = 'on']) &gt; 0 ">
					<tr>
						<td>
							<xsl:call-template name="menu_item_design">
								<xsl:with-param name="content">
									<a class= "menu" href="default.asp?ACT=70&amp;id=0&amp;cmd=mylist"><xsl:value-of select="$string[$classbasestring + 70]"/></a>
								</xsl:with-param>
							</xsl:call-template>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="$add &gt; 0 and (document($classifiedfile)//add[id = $add]/owner=$username or $usertype='administrator')">
					<tr>
						<td>
							<xsl:call-template name="menu_item_design">
								<xsl:with-param name="content">
									<a class= "menu" href="default.asp?ACT=70&amp;id=0&amp;cmd=edit&amp;add={$add}"><xsl:value-of select="$string[$classbasestring + 4]"/></a>
								</xsl:with-param>
							</xsl:call-template>
						</td>
					</tr>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="$explicitautorization='on' and count(document($classifiedfile)//user[state='on' and userpseudo=$username and startdate &lt;= $presentdate and enddate &gt;= $presentdate])&gt;0 or $usertype = 'administrator'">
						<tr>
							<td>
								<xsl:call-template name="menu_item_design">
									<xsl:with-param name="content">
										<a class="menu" href="default.asp?ACT=70&amp;id=0&amp;add=new" title="{$string[$classbasestring + 61]}"><xsl:value-of select="$string[$classbasestring + 9]"/></a>
									</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
					</xsl:when>
					<xsl:when test="$explicitautorization='off' and document($classifiedfile)//settings/postaccess='administrator' and $usertype = 'administrator'">
						<tr>
							<td>
								<xsl:call-template name="menu_item_design">
									<xsl:with-param name="content">
										<a class="menu" href="default.asp?ACT=70&amp;id=0&amp;add=new" title="{$string[$classbasestring + 61]}"><xsl:value-of select="$string[$classbasestring + 9]"/></a>
									</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
					</xsl:when>
					<xsl:when test="$explicitautorization='off' and document($classifiedfile)//settings/postaccess='editor' and ($usertype = 'administrator' or $usertype = 'editor')">
						<tr>
							<td>
								<xsl:call-template name="menu_item_design">
									<xsl:with-param name="content">
										<a class="menu" href="default.asp?ACT=70&amp;id=0&amp;cmd=terms" title="{$string[$classbasestring + 61]}"><xsl:value-of select="$string[$classbasestring + 9]"/></a>
									</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
					</xsl:when>
					<xsl:when test="$explicitautorization='off' and document($classifiedfile)//settings/postaccess='member' and ($usertype = 'administrator' or $usertype = 'editor' or $usertype = 'member')">
						<tr>
							<td>
								<xsl:call-template name="menu_item_design">
									<xsl:with-param name="content">
										<a class="menu" href="default.asp?ACT=70&amp;id=0&amp;cmd=terms" title="{$string[$classbasestring + 61]}"><xsl:value-of select="$string[$classbasestring + 9]"/></a>
									</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
					</xsl:when>
					<xsl:when test="$explicitautorization='off' and document($classifiedfile)//settings/postaccess='anonymous' and ($usertype = 'administrator' or $usertype = 'editor' or $usertype = 'member' or $usertype = 'anonymous')">
						<tr>
							<td>
								<xsl:call-template name="menu_item_design">
									<xsl:with-param name="content">
										<a class="menu" href="default.asp?ACT=70&amp;id=0&amp;cmd=terms" title="{$string[$classbasestring + 61]}"><xsl:value-of select="$string[$classbasestring + 9]"/></a>
									</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
					</xsl:when>
				</xsl:choose>
			</table>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>
	
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--               Search                 -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<xsl:template name="classified_searchtabledisplay">
	<xsl:variable name="up" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÜÄÖéèà'" />
	<xsl:variable name="low" select="'abcdefghijklmnopqrstuvwxyzüäöeea'" />
	<xsl:variable name="lowsearch" select="translate($search,$up,$low)" />
	
	<table width="100%">
		<tr>
			<td colspan="4">
				<xsl:call-template name="title_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[371]"/>
              				</xsl:with-param>
				</xsl:call-template>
			</td>
			 <br/>
		</tr>
		<tr bgcolor="{$toolbar_background}">
			<td align="center">
				<a class="toolbar"><xsl:value-of select="$string[127]"/></a>
			</td>
			<td align="center">
				<a class="toolbar"><xsl:value-of select="$string[142]"/></a>
			</td>
			<td align="center">
				<a class="toolbar"><xsl:value-of select="$string[$classbasestring + 43]"/></a>
			</td>
			<td align="center">
				<a class="toolbar"><xsl:value-of select="$string[$classbasestring + 63]"/></a>
			</td>
		</tr>
		<xsl:for-each select="document($classifiedfile)//add[visible='on' and startdate &lt;= $presentdate and enddate &gt;= $presentdate]">
			<xsl:call-template name="classified_search">
				<xsl:with-param name="addId" select="id"/>
				<xsl:with-param name="addTitle" select="translate(title, $up, $low)"/>
				<xsl:with-param name="addContent" select="translate(body, $up, $low)"/>
				<xsl:with-param name="searchstring" select="$lowsearch"/>
			</xsl:call-template>
		</xsl:for-each>
	</table>
</xsl:template>
	
<xsl:template name="classified_search">
	<xsl:param name="searchstring"/>
	<xsl:param name="addId"/>
	<xsl:param name="addTitle"/>
	<xsl:param name="addContent"/>
	<xsl:variable name="substring">
		<xsl:choose>
			<xsl:when test="contains($searchstring, ' ')">
				<xsl:value-of select="substring($searchstring, ' ')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$searchstring"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:if test="contains($addTitle, $substring) or contains($addContent, $substring)">
        	<xsl:choose>
			<xsl:when test="string-length($searchstring)&gt; 0">
				<xsl:call-template name="classified_search">
					<xsl:with-param name="searchstring">
						<xsl:value-of select="substring-after($searchstring, ' ')" />
					</xsl:with-param>
					<xsl:with-param name="addTitle">
						<xsl:value-of select="$addTitle" />
					</xsl:with-param>
					<xsl:with-param name="addContent">
						<xsl:value-of select="$addContent" />
					</xsl:with-param>
					<xsl:with-param name="addId">
						<xsl:value-of select="$addId" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="classifiedadd_list">
					<xsl:with-param name="addId">
						<xsl:value-of select="$addId" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
</xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--            Announcements             -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	
<xsl:template name="classifiedadd_accesscontrol">
	<xsl:choose>
		<xsl:when test="$explicitautorization='on' and count(document($classifiedfile)//user[state='on' and userpseudo=$username and startdate &lt;= $presentdate and enddate &gt;= $presentdate])&gt;0 or $usertype = 'administrator'">
			 <xsl:call-template name="classifiedadd_add"/>
		</xsl:when>
		<xsl:when test="$explicitautorization='off' and document($classifiedfile)//settings/postaccess='administrator' and $usertype = 'administrator'">
			 <xsl:call-template name="classifiedadd_add"/>
		</xsl:when>
		<xsl:when test="$explicitautorization='off' and document($classifiedfile)//settings/postaccess='editor' and ($usertype = 'administrator' or $usertype = 'editor')">
			 <xsl:call-template name="classifiedadd_add"/>
		</xsl:when>
		<xsl:when test="$explicitautorization='off' and document($classifiedfile)//settings/postaccess='member' and ($usertype = 'administrator' or $usertype = 'editor' or $usertype = 'member')">
			 <xsl:call-template name="classifiedadd_add"/>
		</xsl:when>
		<xsl:when test="$explicitautorization='off' and document($classifiedfile)//settings/postaccess='anonymous' and ($usertype = 'administrator' or $usertype = 'editor' or $usertype = 'member' or $usertype = 'anonymous')">
			 <xsl:call-template name="classifiedadd_add"/>
		</xsl:when>
		<xsl:otherwise>
			 <br />
			 <xsl:value-of select="$string[$classbasestring + 78]"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
			 
<xsl:template name="classifiedadd_add">
	<table bgcolor="white" class="block">
		<form action="default.asp?ACT=70&amp;id=0&amp;cmd=addOK" method="post" name="frmFullxml">
			<tr>
				<td align="center">
					<xsl:call-template name="title_design">
						<xsl:with-param name="title">
							<xsl:value-of select="$string[$classbasestring + 9]"/>
						</xsl:with-param>
					</xsl:call-template>
					<br/>
				</td>
			</tr>
			<tr>
				<td>
					<input type="hidden" name="file" value="classified"/>
					<input type="hidden" name="operation" value="add"/>
					<input type="hidden" name="bloc" value="classified/adds"/>
					<input type="hidden" name="node" value="add"/>
					<input type="hidden" name="count" value="0"/>
					<input type="hidden" name="messages" value=""/>
					<xsl:choose>
						<xsl:when test="document($classifiedfile)/classified/settings/postenable='off'and $usertype != 'administrator'">
							<input type="hidden" name="visible" value="off"/>
						</xsl:when>
						<xsl:otherwise>
							<input type="hidden" name="visible" value="on"/>
						</xsl:otherwise>
					</xsl:choose>
					<table>
						<tr>
							<td>
								<xsl:value-of select="$string[142]"/>:
							</td>
							<td>
								<input type="text" name="title" class="full"/>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:value-of select="$string[$classbasestring + 41]"/>:
							</td>
							<td>
								<select name="catid" class="full">
									<xsl:for-each select="document($classifiedfile)/classified//cat[visible='on']">
										<xsl:sort select="name" data-type="text" order="ascending"/>
										<option value="{id}"><xsl:value-of select="name"/></option>
									</xsl:for-each>
								</select>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:value-of select="$string[126]"/>:
							</td>
							<td>
								<input type="text" name="image" class="full"/>
								<xsl:if test="$usertype = 'administrator' or $usertype = 'editor'">
									<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.image);"/>
								</xsl:if>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:value-of select="$string[192]"/>:
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="$usertype='administrator'">
										<textarea class="textarea" name="body"></textarea>
										<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('body');</script></xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<textarea class="textarea" name="body"></textarea>
										<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('body', config);</script></xsl:if>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:value-of select="$string[$classbasestring + 46]"/>:
							</td>
							<td>
								<input type="text" name="price" class="medium"/>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:value-of select="$string[$classbasestring + 47]"/>:
							</td>
							<td>
								<input type="text" name="units" class="medium"/>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:value-of select="$string[$classbasestring + 48]"/>:
							</td>
							<td>
								<input type="text" name="site" class="medium3"/>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:value-of select="$string[$classbasestring + 49]"/>:
							</td>
							<td>
								<input type="text" name="startdate" value="{$presentdate}" onClick="cal.select(this, 'startdate', 'yyyyMMdd');" maxlength="8" class="medium"/>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:value-of select="$string[$classbasestring + 50]"/>:
							</td>
							<td>
								<input type="text" name="enddate" value="{number($presentdate+100)}" onClick="cal.select(this, 'enddate', 'yyyyMMdd');" maxlength="8" class="medium"/>
							</td>
						</tr>
					</table>
					<table align="right">
						<tr>
							<td colspan="2" align="right">
								<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
								<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=70&amp;id=0&amp;cat=0';"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</form>
	</table>
</xsl:template>

	<xsl:template name="classifiedadd_update">
	<xsl:for-each select="document($classifiedfile)//add[id=$add]">
  <xsl:choose>
    <xsl:when test="owner=$username or $usertype = 'administrator'">
		<table>
			<form action="default.asp?ACT=70&amp;id=0&amp;cmd=editOK" method="post" name="frmFullxml">
				<tr>
						<td align="center">
								<xsl:call-template name="title_design">
										<xsl:with-param name="title">
												<xsl:value-of select="$string[$classbasestring + 4]"/>
              			</xsl:with-param>
								</xsl:call-template>
								<br/>								
						</td>
				</tr>
				<tr>
					<td>
						<input type="hidden" name="file" value="classified"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="classified/adds/add[id={id}]"/>

						<table>
							<tr>
								<td><xsl:value-of select="$string[142]"/>:</td>
								<td>
									<input type="text" name="title" value="{title}" class="full"/>
								</td>
							</tr>
							<tr>
								<td><xsl:value-of select="$string[$classbasestring + 41]"/>:</td>
								<td>
									<select name="catid" class="full">
									<xsl:variable name="actualcatid" select="catid"/>
										<xsl:for-each select="document($classifiedfile)/classified//cat[visible='on']">
										<xsl:sort select="name" data-type="text" order="ascending"/>
											<option value="{id}"><xsl:if test="id=$actualcatid"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="name"/></option>	
								</xsl:for-each>
							</select>
								</td>
							</tr>
							<tr>
								<td>
									<xsl:value-of select="$string[126]"/>:
								</td>
								<td>
									<input type="text" name="image" value="{image}" class="full"/>
									<xsl:if test="$usertype = 'administrator' or $usertype = 'editor'">
													<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
													<input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.image);"/>
									</xsl:if>
								</td>
							</tr>
							<tr>
								<td>
									<xsl:value-of select="$string[192]"/>:
								</td>
								<td>
								  <xsl:choose>
									  <xsl:when test="$usertype='administrator'">
											<textarea class="textarea" name="body"><xsl:value-of select="body"/></textarea>
																<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('body');</script></xsl:if>
										</xsl:when>
										<xsl:otherwise>
											<textarea class="textarea" name="body"><xsl:value-of select="body"/></textarea>
																<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('body', config);</script></xsl:if>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
							<tr>
								<td><xsl:value-of select="$string[$classbasestring + 46]"/>:</td>
								<td>
									<input type="text" name="price" value="{price}" class="medium"/>
								</td>
							</tr>
							<tr>
								<td><xsl:value-of select="$string[$classbasestring + 47]"/>:</td>
								<td>
									<input type="text" name="units" value="{units}" class="medium"/>
								</td>
							</tr>
							<tr>
								<td><xsl:value-of select="$string[$classbasestring + 48]"/>:</td>
								<td>
									<input type="text" name="site" value="{site}" class="medium3"/>
								</td>
							</tr>
							<tr>
								<td><xsl:value-of select="$string[$classbasestring + 49]"/>:</td>
								<td>
									<input type="text" name="startdate" value="{startdate} " onClick="cal.select(this, 'startdate', 'yyyyMMdd');" maxlength="8" class="medium"/>
								</td>
							</tr>
							<tr>
								<td><xsl:value-of select="$string[$classbasestring + 50]"/>:</td>
								<td>
									<input type="text" name="enddate" value="{enddate}" onClick="cal.select(this, 'enddate', 'yyyyMMdd');" maxlength="8" class="medium"/>
								</td>
							</tr>
						</table>
						<table align="right">
							<tr  align="right">
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=70&amp;id=0&amp;add=0';"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</form>
		</table>
		</xsl:when>
		<xsl:otherwise>
  					<br />
						<xsl:value-of select="$string[$classbasestring + 77]"/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
	</xsl:template>
	
	<!-- React template-->
	<xsl:template name="classifiedadd_react">
		<!--<xsl:variable name="id" select="/siteinfo/aspcontext/request/id"/>-->
		
		<table width="100%" cellpadding="0" cellspacing="0">
			<form action="default.asp?ACT=70&amp;id=0&amp;cmd=reactOK&amp;add={$add}" method="post">
						<input type="hidden" name="file" value="classified"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="bloc" value="classified/adds/add[id={$add}]/messages"/>
						<input type="hidden" name="node" value="message"/>
				
				<tr>
				  <td><b><xsl:value-of select="$string[310]"/>:</b></td>
					<td><xsl:value-of select="document($classifiedfile)//add[id=$add]/title" disable-output-escaping="yes"/></td>
				</tr>
				<xsl:choose>
					<xsl:when test="string-length($username) &gt; 0">
										<tr>
												<td>
														<b><xsl:value-of select="$string[506]"/>:</b></td>
												<td>
														<input type="hidden" name="user" class="input" value="{$username}"/>
														<xsl:value-of select="$username"/>
												</td>
										</tr>
					</xsl:when>
					<xsl:otherwise>
										<tr>
												<td>
														<b><xsl:value-of select="$string[311]"/>:</b></td>
												<td>
														<input type="text" name="comp_name" class="input"/>
												</td>
										</tr>
										<tr>
												<td>
														<b><xsl:value-of select="$string[133]"/>:</b></td>
												<td>
														<input type="text" name="comp_mail" class="input"/>
												</td>
										</tr>
					</xsl:otherwise>
				</xsl:choose>				
				<tr>
					<td><b><xsl:value-of select="$string[312]"/> :</b></td>
					<td>
						<input type="text" name="comp_title" class="full" value="{concat('RE: ', document($classifiedfile)//add[id=$add]/title)}"/>
					</td>
				</tr>
				<tr>	<td colspan="2"><b><xsl:value-of select="$string[313]"/> :</b></td></tr>
				<tr>	<td colspan="2">
								  <xsl:choose>
									  <xsl:when test="$usertype='administrator'">
											<textarea class="textarea" name="body"></textarea>
																<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('body');</script></xsl:if>
										</xsl:when>
										<xsl:otherwise>
											<textarea class="textarea" name="body"></textarea>
																<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('body', config);</script></xsl:if>
										</xsl:otherwise>
									</xsl:choose>
				</td></tr>
				<tr>	<td colspan="2" align="center"><input type="submit" value="{$string[314]}"/></td></tr>
			</form>
		</table>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--                Users                 -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

	<xsl:template name="classified_terms">
    <table Width="100%" align="center" cellpadding="2" cellspacing="2">
         <tr>
            <td align="center">
                <xsl:call-template name="title_design">
                    <xsl:with-param name="title">
            	 											<xsl:value-of select="$string[$classbasestring + 3]"/>
                    </xsl:with-param>
                </xsl:call-template>
								<br/>
						</td>
         </tr>
         <tr>
            <td>
                 <xsl:value-of select="document($classifiedfile)/classified/settings/terms" disable-output-escaping="yes"/>
            </td>
         </tr>
  			 <tr>
						<td align="center">
									<input type="button" value="{$string[$classbasestring + 71]}" onclick="document.location.href='default.asp?ACT=70&amp;id=0&amp;add=new';"/>
									<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[$classbasestring + 72]}" onclick="document.location.href='default.asp?ACT=70&amp;id=0&amp;cat=0';"/>
						</td>
					</tr>
    </table>
  </xsl:template>
 
	<xsl:template name="classified_newuser">
	    <table Width="100%" align="center" cellpadding="2" cellspacing="2">
         <tr>
            <td align="center">
                <xsl:call-template name="title_design">
                    <xsl:with-param name="title">
												<xsl:value-of select="$string[$classbasestring + 51]"/>
                    </xsl:with-param>
                </xsl:call-template>
						</td>
         </tr>
         <tr>
            <td>
								<br/>
                <xsl:value-of select="document($classifiedfile)/classified/users/settings/userterms" disable-output-escaping="yes"/>
								<br/>
            </td>
         </tr>
				 <!-- mandatory fields, if set up -->
				 <xsl:if test="$explicitautorization and (document($classifiedfile)/classified/users/settings/mandatoryname='on' or document($classifiedfile)/classified/users/settings/mandatorysite='on' or document($classifiedfile)/classified/users/settings/mandatoryadress='on' or document($classifiedfile)/classified/users/settings/mandatoryphone='on')">
         				 <tr>
            		 		 <td align="center">
										     <xsl:call-template name="title_design">
                    		   <xsl:with-param name="title">
										 		 	     <xsl:value-of select="$string[$classbasestring + 73]"/>
                    			 </xsl:with-param>
                				 </xsl:call-template>
												 <br/>
										 </td>
         				 </tr>
				 </xsl:if>
				 <!-- Name -->
				 <xsl:if test="document($classifiedfile)/classified/users/settings/mandatoryname='on'">
       				  <tr>
            		 		 <td>
										 		 <table>
												 				<tr>
            		 		 								<td>
																				<b><xsl:value-of select="$string[$mmbasestring + 13]"/>: </b>
																		</td>
																		<td>
																				<xsl:choose>
																										<xsl:when test="string-length(document($memberfile)//member[pseudo=$username]/userfname)=0">
																															<font color="red"><xsl:value-of select="$string[$classbasestring + 75]"/></font>  
																										</xsl:when>
																										<xsl:otherwise>
																																	 <xsl:value-of select="document($memberfile)//member[pseudo=$username]/userfname"/>
																										</xsl:otherwise>
																				</xsl:choose>
																		</td>
         				 								</tr>
												 				<tr>
            		 		 								<td>
																				<b><xsl:value-of select="$string[$mmbasestring + 14]"/>: </b>
																		</td>
																		<td>
																				<xsl:choose>
																										<xsl:when test="string-length(document($memberfile)//member[pseudo=$username]/userlname)=0">
																															<font color="red"><xsl:value-of select="$string[$classbasestring + 75]"/></font>  
																										</xsl:when>
																										<xsl:otherwise>
																																	 <xsl:value-of select="document($memberfile)//member[pseudo=$username]/userlname"/>
																										</xsl:otherwise>
																				</xsl:choose>
																				<br/>
																		</td>
         				 								</tr>
												 </table>
										 </td>
         				 </tr>
 				 </xsl:if>
				 <!-- Website -->
				 <xsl:if test="document($classifiedfile)/classified/users/settings/mandatorysite='on'">
       				  <tr>
            		 		 <td>
										 		 <table>
												 				<tr>
            		 		 								<td>
																				<b><xsl:value-of select="$string[$mmbasestring + 15]"/></b>
																		</td>
																		<td>
																				<xsl:choose>
																										<xsl:when test="string-length(document($memberfile)//member[pseudo=$username]/userpage)=0">
																															<font color="red"><xsl:value-of select="$string[$classbasestring + 75]"/></font>  
																										</xsl:when>
																										<xsl:otherwise>
																																	 <xsl:value-of select="document($memberfile)//member[pseudo=$username]/userpage"/>
																										</xsl:otherwise>
																				</xsl:choose>
																				<br/>
																		</td>
         				 								</tr>
												 </table>
										 </td>
         				 </tr>
 				 </xsl:if>
				 <!-- Adress -->
				 <xsl:if test="document($classifiedfile)/classified/users/settings/mandatoryadress='on'">
       				  <tr>
            		 		 <td>
										 		 <table>
												 				<tr>
            		 		 								<td>
																				<b><xsl:value-of select="$string[$mmbasestring + 18]"/>: </b>
																		</td>
																		<td>
																				<xsl:choose>
																										<xsl:when test="string-length(document($memberfile)//member[pseudo=$username]/useradress)=0">
																															<font color="red"><xsl:value-of select="$string[$classbasestring + 75]"/></font>  
																										</xsl:when>
																										<xsl:otherwise>
																																	 <xsl:value-of select="document($memberfile)//member[pseudo=$username]/useradress"/>
																										</xsl:otherwise>
																				</xsl:choose>
																		</td>
         				 								</tr>
												 				<tr>
            		 		 								<td>
																				<b><xsl:value-of select="$string[$mmbasestring + 19]"/>: </b>
																		</td>
																		<td>
																				<xsl:choose>
																										<xsl:when test="string-length(document($memberfile)//member[pseudo=$username]/userzip)=0">
																															<font color="red"><xsl:value-of select="$string[$classbasestring + 75]"/></font>  
																										</xsl:when>
																										<xsl:otherwise>
																																	 <xsl:value-of select="document($memberfile)//member[pseudo=$username]/userzip"/>
																										</xsl:otherwise>
																				</xsl:choose>
																		</td>
         				 								</tr>
												 				<tr>
            		 		 								<td>
																				<b><xsl:value-of select="$string[$mmbasestring + 6]"/>: </b>
																		</td>
																		<td>
																				<xsl:choose>
																										<xsl:when test="string-length(document($memberfile)//member[pseudo=$username]/ville)=0">
																															<font color="red"><xsl:value-of select="$string[$classbasestring + 75]"/></font>  
																										</xsl:when>
																										<xsl:otherwise>
																																	 <xsl:value-of select="document($memberfile)//member[pseudo=$username]/ville"/>
																										</xsl:otherwise>
																				</xsl:choose>
																		</td>
         				 								</tr>
												 				<tr>
            		 		 								<td>
																				<b><xsl:value-of select="$string[$mmbasestring + 7]"/>: </b>
																		</td>
																		<td>
																				<xsl:choose>
																										<xsl:when test="string-length(document($memberfile)//member[pseudo=$username]/userstate)=0">
																															<font color="red"><xsl:value-of select="$string[$classbasestring + 75]"/></font>  
																										</xsl:when>
																										<xsl:otherwise>
																																	 <xsl:value-of select="document($memberfile)//member[pseudo=$username]/userstate"/>
																										</xsl:otherwise>
																				</xsl:choose>
																				<br/>
																		</td>
         				 								</tr>
												 				<tr>
            		 		 								<td>
																				<b><xsl:value-of select="$string[$mmbasestring + 8]"/>: </b>
																		</td>
																		<td>
																				<xsl:choose>
																										<xsl:when test="string-length(document($memberfile)//member[pseudo=$username]/usercountry)=0">
																															<font color="red"><xsl:value-of select="$string[$classbasestring + 75]"/></font>  
																										</xsl:when>
																										<xsl:otherwise>
																																	 <xsl:value-of select="document($memberfile)//member[pseudo=$username]/usercountry"/>
																										</xsl:otherwise>
																				</xsl:choose>
																				<br/>
																		</td>
         				 								</tr>
												 </table>
										 </td>
         				 </tr>
 				 </xsl:if>					
				 <!-- Phone -->
				 <xsl:if test="document($classifiedfile)/classified/users/settings/mandatoryphone='on'">
       				  <tr>
            		 		 <td>
										 		 <table>
												 				<tr>
            		 		 								<td>
																				<b><xsl:value-of select="$string[$mmbasestring + 20]"/>: </b>
																		</td>
																		<td>
																				<xsl:choose>
																										<xsl:when test="string-length(document($memberfile)//member[pseudo=$username]/userphone)=0">
																															<font color="red"><xsl:value-of select="$string[$classbasestring + 75]"/></font>  
																										</xsl:when>
																										<xsl:otherwise>
																																	 <xsl:value-of select="document($memberfile)//member[pseudo=$username]/userphone"/>
																										</xsl:otherwise>
																				</xsl:choose>
																				<br/>
																		</td>
         				 								</tr>
												 </table>
										 </td>
         				 </tr>
 				 </xsl:if>
				 <tr>
						<td align="center">
									<br/>
									<xsl:choose>
															<xsl:when test="(document($classifiedfile)/classified/users/settings/mandatoryname='on' and (string-length(document($memberfile)//member[pseudo=$username]/userfname)=0 or string-length(document($memberfile)//member[pseudo=$username]/userlname)=0)) or (document($classifiedfile)/classified/users/settings/mandatorysite='on' and string-length(document($memberfile)//member[pseudo=$username]/userpage)=0) or (document($classifiedfile)/classified/users/settings/mandatoryadress='on' and (string-length(document($memberfile)//member[pseudo=$username]/useradress)=0 or string-length(document($memberfile)//member[pseudo=$username]/userzip)=0 or string-length(document($memberfile)//member[pseudo=$username]/ville)=0 or string-length(document($memberfile)//member[pseudo=$username]/userstate)=0 or string-length(document($memberfile)//member[pseudo=$username]/usercountry)=0)) or (document($classifiedfile)/classified/users/settings/mandatoryphone='on' and string-length(document($memberfile)//member[pseudo=$username]/userphone)=0)">
																				<input type="button" value="{$string[$mmbasestring + 11]}" onclick="document.location.href='default.asp?ACT=22&amp;id=0&amp;mnu=1';"/>
																				<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
																				<input type="button" value="{$string[$classbasestring + 72]}" onclick="document.location.href='default.asp?ACT=70&amp;id=0&amp;cat=0';"/>
															</xsl:when>
															<xsl:otherwise>
																		<form action="default.asp?ACT=70&amp;id=0&amp;cmd=userOK" method="post" name="frmFullxml">
																					<input type="hidden" name="file" value="classified"/>
																					<input type="hidden" name="operation" value="add"/>
																					<input type="hidden" name="bloc" value="classified/users"/>
																					<input type="hidden" name="node" value="user"/>
																					<input type="hidden" name="state" value="off"/>
																					<input type="hidden" name="userpseudo" value="{$username}"/>
																					<input type="hidden" name="startdate" value="{$presentdate}"/>
																					<input type="hidden" name="enddate" value=""/>
																					<input type="submit" value="Submit"/>
																					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
																					<input type="button" value="{$string[$classbasestring + 71]}" onclick="document.location.href='default.asp?ACT=70&amp;id=0&amp;cat=0';"/>																					
																		</form>
															</xsl:otherwise>
									</xsl:choose>
						</td>
					</tr>
    </table>
  </xsl:template>

	<xsl:template name="classified_usersubmited">
       <p />
			 <xsl:value-of select="$string[$classbasestring + 74]"/>
  </xsl:template>
	
</xsl:stylesheet>
