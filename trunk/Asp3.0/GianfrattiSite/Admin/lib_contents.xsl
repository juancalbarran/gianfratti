<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve">
<xsl:output method="html"/> 

<!-- Contents Template : add/update/modify -->
<!-- last modified : 2001/10/26, by J.Roland -->
<!-- version 1.0 -->

	<xsl:template name="content_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Website Content</xsl:with-param>
			<xsl:with-param name="version">1.0</xsl:with-param>
			<xsl:with-param name="moddate">07.11.2003</xsl:with-param>
			<xsl:with-param name="author">John Roland, JeS</xsl:with-param>
			<xsl:with-param name="url">http://www.fullxml.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Content manager -->
	<xsl:template name="content_manager">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M3"><img src="admin/media/content.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[70]"/></font></td></tr>
		</table>		
					
		<xsl:choose>
			<xsl:when test="$page!=0 and string-length($id)=0">
				<xsl:call-template name="page_filter"/>
				<xsl:call-template name="content_listpage"/>
			</xsl:when>
			<xsl:when test="string-length($id)=0">
				<xsl:call-template name="page_filter"/>
				<xsl:call-template name="content_list"/>
			</xsl:when>
			<xsl:when test="$id='new'">
				<xsl:call-template name="content_add"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="siteinfo/contents/content[id=$id]"><xsl:call-template name="content_update"/></xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- Select box to filter  -->
	<xsl:template name="page_filter">
		<form name="frmFilter">
		<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$string[418]"/>: </b>
		
		<xsl:choose>
			<xsl:when test="$usertype='administrator'">
				<select name="filter" onchange="document.location='default.asp?ACT=1&amp;SECT=M3&amp;page=' + frmFilter.filter.value;;">
					<option value=""><xsl:value-of select="$string[88]"/></option>
					<xsl:for-each select="siteinfo/pages/page"><option value="{id}"><xsl:if test="id=$page"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="name"/></option></xsl:for-each>
				</select>
			</xsl:when>
			<xsl:when test="$usertype='editor'">
				<select name="filter" onchange="document.location='default.asp?ACT=1&amp;SECT=M3&amp;page=' + frmFilter.filter.value;;">
					<xsl:for-each select="siteinfo/pages/page[moderator=$username]"><option value="{id}"><xsl:if test="id=$page"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="name"/></option></xsl:for-each>
				</select>
			</xsl:when>
		</xsl:choose>
		
		
		</form>
	</xsl:template>
	
	<!-- Content list -->
	<xsl:template name="content_list">
		
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr>
				<td class="header" width="16"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td class="header" width="50">Id</td>
				<td class="header"><xsl:value-of select="$string[71]"/></td>
				<td class="header"><xsl:value-of select="$string[72]"/></td>
				<td class="header"><xsl:value-of select="$string[73]"/></td>
				<td class="header"><xsl:value-of select="$string[74]"/></td>
			</tr>
			<xsl:choose>
				<xsl:when test="$usertype='editor'">
					<tr class="data"><td colspan="6"><b>-=<xsl:value-of select="$string[451]"/>=-</b></td></tr>
					<xsl:apply-templates select="/siteinfo/contents/content[type='headline' and owner=$username]" mode="list"><xsl:sort select="id" data-type="number" order="descending"/></xsl:apply-templates>
					<tr><td colspan="6" align="right"><input type="button" value="{$string[15]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M3&amp;id=new&amp;type=headline';"/></td></tr>
					
					<!-- Margin -->
					<tr class="data"><td colspan="6"><b>-=<xsl:value-of select="$string[452]"/>=-</b></td></tr>
					<xsl:apply-templates select="/siteinfo/contents/content[type='margin' and owner=$username]" mode="list"><xsl:sort select="id" data-type="number" order="descending"/></xsl:apply-templates>
					<tr><td colspan="6" align="right"><input type="button" value="{$string[15]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M3&amp;id=new&amp;type=margin';"/></td></tr>
					
					<!-- Body -->
					<tr class="data"><td colspan="6"><b>-=<xsl:value-of select="$string[453]"/>=-</b></td></tr>
					<xsl:apply-templates select="/siteinfo/contents/content[type='body' and owner=$username]" mode="list"><xsl:sort select="id" data-type="number" order="descending"/></xsl:apply-templates>
					<tr><td colspan="6" align="right"><input type="button" value="{$string[15]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M3&amp;id=new&amp;type=body';"/></td></tr>
				</xsl:when>
				<xsl:otherwise>
					<!-- Headlines -->
					<tr class="data"><td colspan="6"><b>-=<xsl:value-of select="$string[451]"/>=-</b></td></tr>
					<xsl:apply-templates select="/siteinfo/contents/content[type='headline']" mode="list"><xsl:sort select="id" data-type="number" order="descending"/></xsl:apply-templates>
					<tr><td colspan="6" align="right"><input type="button" value="{$string[15]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M3&amp;id=new&amp;type=headline';"/></td></tr>
					
					<!-- Margin -->
					<tr class="data"><td colspan="6"><b>-=<xsl:value-of select="$string[452]"/>=-</b></td></tr>
					<xsl:apply-templates select="/siteinfo/contents/content[type='margin']" mode="list"><xsl:sort select="id" data-type="number" order="descending"/></xsl:apply-templates>
					<tr><td colspan="6" align="right"><input type="button" value="{$string[15]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M3&amp;id=new&amp;type=margin';"/></td></tr>
					
					<!-- Body -->
					<tr class="data"><td colspan="6"><b>-=<xsl:value-of select="$string[453]"/>=-</b></td></tr>
					<xsl:apply-templates select="/siteinfo/contents/content[type='body']" mode="list"><xsl:sort select="id" data-type="number" order="descending"/></xsl:apply-templates>
					<tr><td colspan="6" align="right"><input type="button" value="{$string[15]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M3&amp;id=new&amp;type=body';"/></td></tr>

				</xsl:otherwise>
			</xsl:choose>
			
		</table>
		
	</xsl:template>
	
	
	<!-- template of one row of article table -->
	<xsl:template match="content" mode="list">
		<xsl:variable name="myidpage" select="idpage"/>
		<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M3&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
			<td><a href="default.asp?id={$myidpage}&amp;mnu={$myidpage}"><img src="admin/media/{visible}.gif" width="16" height="15" border="0"/></a></td>
			<td class="data2"><xsl:value-of select="id"/></td>
			<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M3&amp;id={id}"><xsl:value-of select="title" disable-output-escaping="yes"/></a></td>
			<td class="data2"><xsl:value-of select="type"/></td>
			<td class="data2"><xsl:value-of select="/siteinfo/pages/page[id=$myidpage]/name"/></td>
			<td class="data2"><xsl:value-of select="concat(author, ' (', owner, ')')"/></td>
		</tr>
	</xsl:template>


	<!-- Content list filtered by page -->
	<xsl:template name="content_listpage">		
		
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr>
				<td class="header" width="16"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td class="header" width="50">Id</td>
				<td class="header"><xsl:value-of select="$string[71]"/></td>
				<td class="header"><xsl:value-of select="$string[72]"/></td>
				<td class="header"><xsl:value-of select="$string[73]"/></td>
				<td class="header"><xsl:value-of select="$string[74]"/></td>
			</tr>
			<xsl:choose>
				<xsl:when test="$usertype='editor'">
					<tr class="data"><td colspan="6"><b>-=<xsl:value-of select="$string[451]"/>=-</b></td></tr>
					<xsl:apply-templates select="/siteinfo/contents/content[type='headline' and owner=$username and idpage=$page]" mode="list"><xsl:sort select="id" data-type="number" order="descending"/></xsl:apply-templates>
					<tr><td colspan="6" align="right"><input type="button" value="{$string[15]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M3&amp;id=new&amp;type=headline&amp;page={$page}';"/></td></tr>
					
					<!-- Margin -->
					<tr class="data"><td colspan="6"><b>-=<xsl:value-of select="$string[452]"/>=-</b></td></tr>
					<xsl:apply-templates select="/siteinfo/contents/content[type='margin' and owner=$username and idpage=$page]" mode="list"><xsl:sort select="id" data-type="number" order="descending"/></xsl:apply-templates>
					<tr><td colspan="6" align="right"><input type="button" value="{$string[15]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M3&amp;id=new&amp;type=margin&amp;page={$page}';"/></td></tr>
					
					<!-- Body -->
					<tr class="data"><td colspan="6"><b>-=<xsl:value-of select="$string[453]"/>=-</b></td></tr>
					<xsl:apply-templates select="/siteinfo/contents/content[type='body' and owner=$username and idpage=$page]" mode="list"><xsl:sort select="id" data-type="number" order="descending"/></xsl:apply-templates>
					<tr><td colspan="6" align="right"><input type="button" value="{$string[15]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M3&amp;id=new&amp;type=body&amp;page={$page}';"/></td></tr>
				</xsl:when>
				<xsl:otherwise>
					<!-- Headlines -->
					<tr class="data"><td colspan="6"><b>-=<xsl:value-of select="$string[451]"/>=-</b></td></tr>
					<xsl:apply-templates select="/siteinfo/contents/content[type='headline' and idpage=$page]" mode="list"><xsl:sort select="id" data-type="number" order="descending"/></xsl:apply-templates>
					<tr><td colspan="6" align="right"><input type="button" value="{$string[15]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M3&amp;id=new&amp;type=headline&amp;page={$page}';"/></td></tr>
					
					<!-- Margin -->
					<tr class="data"><td colspan="6"><b>-=<xsl:value-of select="$string[452]"/>=-</b></td></tr>
					<xsl:apply-templates select="/siteinfo/contents/content[type='margin' and idpage=$page]" mode="list"><xsl:sort select="id" data-type="number" order="descending"/></xsl:apply-templates>
					<tr><td colspan="6" align="right"><input type="button" value="{$string[15]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M3&amp;id=new&amp;type=margin&amp;page={$page}';"/></td></tr>
					
					<!-- Body -->
					<tr class="data"><td colspan="6"><b>-=<xsl:value-of select="$string[453]"/>=-</b></td></tr>
					<xsl:apply-templates select="/siteinfo/contents/content[type='body' and idpage=$page]" mode="list"><xsl:sort select="id" data-type="number" order="descending"/></xsl:apply-templates>
					<tr><td colspan="6" align="right"><input type="button" value="{$string[15]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M3&amp;id=new&amp;type=body&amp;page={$page}';"/></td></tr>

				</xsl:otherwise>
			</xsl:choose>			
		</table>		
	</xsl:template>
	
	
	<!-- Add Content -->
	<xsl:template name="content_add">
		
		<table bgcolor="white"><form action="default.asp?ACT=1&amp;SECT=M3" method="post" name="frmFullxml"><tr><td>		
			<input type="hidden" name="file" value="content"/>
			<input type="hidden" name="operation" value="add"/>
			<input type="hidden" name="bloc" value="siteinfo/contents"/>
			<input type="hidden" name="node" value="content"/>
			<input type="hidden" name="count" value="0"/>
							
			<table class="block">
				<tr>
					<td  class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[73]"/>:</td>
					<td>
						<xsl:choose>
							<xsl:when test="$usertype='administrator'">
								<select name="idpage"><xsl:for-each select="siteinfo/pages/page"><xsl:sort select="name" order="ascending"/><option value="{id}"><xsl:if test="id=$page"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="name"/></option></xsl:for-each><option value="0"><xsl:value-of select="$string[88]"/></option></select>
							</xsl:when>
							<xsl:when test="$usertype='editor'">
								<select name="idpage"><xsl:for-each select="siteinfo/pages/page[moderator=$username]"><xsl:sort select="name" order="ascending"/><option value="{id}"><xsl:if test="id=$page"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="name"/></option></xsl:for-each></select>
							</xsl:when>
						</xsl:choose>
					</td></tr>
				<tr>
					<td  class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[72]"/>:</td>
					<td><select name="type">						
						<option value="headline"><xsl:if test="$type='headline'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[451]"/></option>
						<option value="margin"><xsl:if test="$type='margin'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[452]"/></option>
						<option value="body"><xsl:if test="$type='body'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> <xsl:value-of select="$string[453]"/></option></select>						
					</td>
				</tr>
			</table><br/>
			
			<table class="block">
				<tr><td  class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[71]"/>:</td><td><input type="text" value="" name="title" class="full"/></td></tr>								
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[78]"/>:</td>
					<td><textarea class="textarea" name="headlines" title="Headlines" />
						<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('headlines');</script></xsl:if>
					</td>
				</tr>
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[79]"/>:</td>
					<td>
						<textarea class="textarea" name="body" />
						<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('body');</script></xsl:if>
					</td>
				</tr>						
				<tr><td class="xp_sel"><xsl:value-of select="$string[74]"/>:</td><td><input type="text" name="author" class="mini" value="{$username}"/></td></tr>						
			</table><br/>
						
			<!-- Button to show/hide advanced fields -->
			<div style="cursor: hand;" onclick="SwapMode();" id="swaper">
			    <img  src="admin/media/expand.gif" hspace="4" align="middle"/><xsl:value-of select="$string[439]"/>
			</div>
        			
    		       <!-- Start of the part that is hidden by default -->
    		        <div id="advancedfields" style="display: none; margin-left: 10px; ">			
				<table class="block">
				    <tr>
        				<td class="xp_sel"><xsl:value-of select="$string[433]"/>:</td>
        				<td>
        					<select name="position">
        						<option value="left"><xsl:value-of select="$string[436]"/></option>
        						<option value="right"><xsl:value-of select="$string[437]"/></option>						
        					</select>
        				</td>
        			    </tr>
        			    <tr><td colspan="2"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>

        				<tr><td class="xp_sel"><xsl:value-of select="$string[76]"/>:</td><td><input type="text" name="xmlsource" class="full"/></td></tr>
        				<tr><td class="xp_sel"><xsl:value-of select="$string[77]"/>:</td><td><input type="text" name="xslsource" class="full"/></td></tr>
        				<tr><td colspan="2"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
        			    	
					<tr>
						<td class="xp_sel"><xsl:value-of select="$string[35]"/>:</td>
						<td>
							<select name="showtitle"><option value="off"> off</option><option value="on" selected="selected"> on</option></select> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[417]"/><br/>
							<select name="showtoolbar"><option value="off">off</option><option value="on">on</option></select> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[37]"/><br/>
							<select name="showdateauthor"><option value="off">off</option><option value="on">on</option></select> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[45]"/><br/>
						</td>
					</tr>
				</table>
			</div><br/>
					
			<table class="block">
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[59]"/>:</td>
					<td>
						<select name="visible">
							<xsl:choose>
								<xsl:when test="/siteinfo/data/articlestate='on'"><option value="off"><xsl:value-of select="$string[61]"/></option><option value="on" selected="selected"><xsl:value-of select="$string[60]"/></option></xsl:when>
								<xsl:otherwise><option value="off" selected="selected"><xsl:value-of select="$string[61]"/></option><option value="on"><xsl:value-of select="$string[60]"/></option></xsl:otherwise>
							</xsl:choose>
						</select></td></tr>	
				<tr><td class="xp_sel"><xsl:value-of select="$string[63]"/>:</td><td><input type="text" name="publicationdate" id="publicationdate" value="{substring($actualdate,1,8)}" onClick="cal.select(this, 'publicationdate', 'yyyyMMdd');"  maxlength="8" class="mini"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><small>yyyymmdd</small></td></tr>
				<tr><td  class="xp_sel"><xsl:value-of select="$string[64]"/>:</td><td><input type="text" name="expirationdate" id="expirationdate" onClick="cal.select(this, 'expirationdate', 'yyyyMMdd');"  maxlength="8" class="mini"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><small>yyyymmdd</small></td></tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M3';"/>
					</td>
				</tr>
			</table>
			
		</td></tr></form></table>
	</xsl:template>
		
		
	<!-- CONTENT UPDATE FORM-->
	<xsl:template name="content_update">
		<xsl:variable name="idpage"><xsl:value-of select="idpage"/></xsl:variable>
			
		<table bgcolor="white"><tr><td>
		    <form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmFullxml">
		    	<input type="hidden" name="file" value="content"/>
			<input type="hidden" name="operation" value="update"/>
			<input type="hidden" name="node" value="siteinfo/contents/content[id={id}]"/>							
			<input type="hidden" name="count" value="{count}"/>
				
			<table class="block">
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[73]"/>:</td>
					<td>
						<xsl:choose>
							<xsl:when test="$usertype='administrator'"><select name="idpage"><xsl:for-each select="/siteinfo/pages/page"><xsl:sort select="name" order="ascending"/><option value="{id}"><xsl:if test="$idpage=id"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="name"/></option></xsl:for-each><option value="0"><xsl:if test="$idpage=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[88]"/></option></select></xsl:when>
							<xsl:when test="$usertype='editor'"><select name="idpage"><xsl:for-each select="/siteinfo/pages/page[moderator=$username]"><xsl:sort select="name" order="ascending"/><option value="{id}"><xsl:if test="$idpage=id"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="name"/></option></xsl:for-each></select></xsl:when>
						</xsl:choose>
					</td>
				</tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[72]"/>:</td>
					<td><select name="type">						
						<option value="headline"><xsl:if test="type='headline'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[451]"/></option>
						<option value="margin"><xsl:if test="type='margin'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[452]"/></option>
						<option value="body"><xsl:if test="type='body'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[453]"/></option></select>
					</td>
				</tr>
			</table><br/>				
			
			<table class="block">
				<tr><td class="xp_sel"><xsl:value-of select="$string[71]"/>:</td><td><input type="text" value="{title}" name="title" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[78]"/>:</td>
					<td><textarea  class="textarea" name="headlines" title="{$string[438]}"><xsl:value-of select="headlines" disable-output-escaping="no"/></textarea>
					<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('headlines');</script></xsl:if>
				</td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[79]"/>:</td>
					<td><textarea class="textarea" name="body" title="{$string[438]}"><xsl:value-of select="body" disable-output-escaping="no"/></textarea>
					<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('body');</script></xsl:if>
				</td></tr>	
				<tr><td class="xp_sel"><xsl:value-of select="$string[74]"/>:</td><td><input type="text" value="{author}" name="author" class="full"/></td></tr>				
			</table><br/>
			
			<!-- Button to show/hide advanced fields -->
			<div style="cursor: hand;" onclick="SwapMode();" id="swaper">
			    <img  src="admin/media/expand.gif" hspace="4" align="middle"/><xsl:value-of select="$string[439]"/>
			</div>
        			
    		       <!-- Start of the part that is hidden by default -->
    		        <div id="advancedfields" style="display: none; margin-left: 10px; ">			
		            <table class="block">			
			        <tr>
            				<td class="xp_sel"><xsl:value-of select="$string[433]"/>:</td>
            				<td>
            					<select name="position">
            						<option value="left"><xsl:if test="position='left'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[436]"/></option>
            						<option value="right"><xsl:if test="position='right' or string-length(position)=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[437]"/></option>						
            					</select>
            				</td>
            			</tr>
			        <tr><td colspan="2"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
			    
				<tr><td class="xp_sel"><xsl:value-of select="$string[76]"/>:</td><td><input type="text" value="{xmlsource}" name="xmlsource" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[77]"/>:</td><td><input type="text" value="{xslsource}" name="xslsource" class="full"/></td></tr>
				<tr><td colspan="2"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[35]"/>:</td>
					<td>
						<select name="showtitle"><option value="off"><xsl:if test="showtitle='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="showtitle='on' or string-length(showtitle)=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[417]"/><br/>
						<select name="showtoolbar"><option value="off"><xsl:if test="showtoolbar='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="showtoolbar='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[37]"/><br/>
						<select name="showdateauthor"><option value="off"><xsl:if test="showdateauthor='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="showdateauthor='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[45]"/><br/>
					</td>
				</tr>
			</table></div><br/>
	
								
			<table class="block">
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[59]"/>:</td>
					<td>
						<select name="visible">
						<option value="off"><xsl:if test="visible='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[61]"/></option>
						<option value="on"><xsl:if test="visible='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[60]"/></option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[63]"/>:</td><td ><input type="text" name="publicationdate" id="publicationdate" value="{publicationdate}" onClick="cal.select(this, 'publicationdate', 'yyyyMMdd');"  maxlength="8" class="mini"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><small>yyyymmdd</small><!--<input type="button" value="{$string[63]}" style="width: 150px" onClick="getCalendarFor(document.frmadm.publicationdate)"/>--></td>
				</tr>
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[64]"/>:</td><td><input type="text" name="expirationdate" id="expirationdate" value="{expirationdate}" onClick="cal.select(this, 'expirationdate', 'yyyyMMdd');"  maxlength="8" class="mini"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><small>yyyymmdd</small><!--<input type="button" value="{$string[64]}" style="width: 150px" onClick="getCalendarFor(document.frmadm.expirationdate)"/>--></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M3';"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					</td>
				</tr>
			</table>
			</form>					
		
			<table class="block">		
				<xsl:choose>
					<xsl:when test="@readonly='readonly'">
						<tr><td colspan="2" align="right"><font color="red"><xsl:value-of select="$string[82]"/></font></td></tr>
					</xsl:when>
					<xsl:otherwise>
						<tr><form action="default.asp?ACT=1&amp;SECT={$section}" method="post" onsubmit="return confirm('{$string[83]}');">
						<td colspan="2" align="right">						
									<input type="hidden" name="operation" value="delete"/>
									<input type="hidden" name="node" value="siteinfo/contents/content[id={id}]"/>
									<input type="submit" value="{$string[16]}"/>								
							</td></form></tr>
					</xsl:otherwise>
				</xsl:choose>
			</table>
		</td></tr></table>

	</xsl:template>
			
			
			
		
	
</xsl:stylesheet>