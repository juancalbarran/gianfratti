<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/> 

	<xsl:template name="pages_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Website Pages</xsl:with-param>
			<xsl:with-param name="version">1.3</xsl:with-param>
			<xsl:with-param name="moddate">09.04.2004</xsl:with-param>
			<xsl:with-param name="author">John Roland, Mig100 (Miguel Figueira) and JeS (Jens Schreiber)</xsl:with-param>
			<xsl:with-param name="url">http://www.fxmods.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="webpage_manager">
		<!-- global title -->
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M2"><img src="admin/media/webpages.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[50]"/></font></td></tr>
		</table>
						
		<xsl:choose>		
			<xsl:when test="string-length($id)=0 and string-length($cat)&gt;0">
				<xsl:call-template name="category_filter"/>
				<xsl:call-template name="page_list_by_category"/>							
			</xsl:when>
			<xsl:when test="string-length($id)=0">
				<xsl:call-template name="category_filter"/>
				<xsl:call-template name="page_list"/>							
			</xsl:when>
			<xsl:when test="$id='new'">
				<xsl:call-template name="page_add"/>							
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="siteinfo/pages/page[id=$id]"><xsl:call-template name="page_update"/></xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>

	<xsl:template name="category_filter">
		<form name="frmFilter">
		 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$string[337]"/>: </b>
		<select name="filter" onchange="document.location='default.asp?ACT=1&amp;SECT=M2&amp;cat=' + frmFilter.filter.value;;">
			<option value=""><xsl:value-of select="$string[338]"/></option>
			<xsl:for-each select="document($categoryfile)//categories/category"><option value="{id}"><xsl:if test="id=$cat"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="name"/></option></xsl:for-each>
		</select>
		</form>
	</xsl:template>


	<!-- all pages list template -->
	<xsl:template name="page_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr>
				<td class="header" width="16"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td class="header" width="100">Id</td>
				<td class="header"><xsl:value-of select="$string[51]"/></td>
				<td class="header"><xsl:value-of select="$string[66]"/></td>
				<td class="header" width="30"><xsl:value-of select="$string[68]"/></td>
			</tr>		
			<xsl:for-each select="siteinfo/pages/page">			
				<xsl:variable name="idpage" select="id"/>
				<xsl:variable name="category" select="category"/>
				<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M2&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td><a href="default.asp?id={id}&amp;mnu={id}"><img src="admin/media/{visible}.gif" width="16" height="15" border="0"/></a></td>
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M2&amp;id={id}"><xsl:value-of select="name"/></a></td>
					<td class="data2"><xsl:value-of select="document($categoryfile)//categories/category[id=$category]/name"/></td>
					<td class="data2"><xsl:value-of select="count"/></td>
				</tr>
			</xsl:for-each>			
			<tr>
				<td colspan="5" align="right">
					<input type="button" value="{$string[15]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M2&amp;id=new';" />
				</td>
			</tr>
		</table>		
	</xsl:template>
	
	<!-- pages filtered by category list template -->
	<xsl:template name="page_list_by_category">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr>
				<td class="header" width="16"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td class="header" width="100">Id</td>
				<td class="header"><xsl:value-of select="$string[51]"/></td>
				<td class="header"><xsl:value-of select="$string[66]"/></td>
				<td class="header" width="30"><xsl:value-of select="$string[68]"/></td>
			</tr>		
			<xsl:for-each select="siteinfo/pages/page[category=$cat]">			
				<xsl:variable name="idpage" select="id"/>
				<xsl:variable name="category" select="category"/>
				<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M2&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td><img src="admin/media/{visible}.gif" width="16" height="15"/></td>
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M2&amp;id={id}"><xsl:value-of select="name"/></a></td>
					<td class="data2"><xsl:value-of select="document($categoryfile)//categories/category[id=$category]/name"/></td>
					<td class="data2"><xsl:value-of select="count"/></td>
				</tr>
			</xsl:for-each>			
			<tr>
				<td colspan="5" align="right">
					<input type="button" value="{$string[15]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M2&amp;id=new&amp;cat={$cat}';" />
				</td>
			</tr>
		</table>		
	</xsl:template>
	
	
	<!-- add page form  -->
	<xsl:template name="page_add">
   
	    <table bgcolor="white"><form action="default.asp?ACT=1&amp;SECT=M2" method="post" name="frmFullxml"><tr><td>
		    <input type="hidden" name="operation" value="add"/>
		    <input type="hidden" name="bloc" value="siteinfo/pages"/>
		    <input type="hidden" name="node" value="page"/>				
		    <input type="hidden" name="count" value="0"/>
										
				<!-- Categorization -->
				<table class="block">
					<tr>
						<td class="xp_sel"><xsl:value-of select="$string[66]"/>:</td>
						<td><select name="category"><xsl:for-each select="document($categoryfile)//categories/category"><option value="{id}"><xsl:if test="$cat=id"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="name"/></option></xsl:for-each></select></td></tr>
					<tr>
						<td class="xp_sel"><xsl:value-of select="$string[52]"/>:</td>
					    	<td>
					        <select name="idparentpage">
					            <option value="" selected="selected">-------</option>   
					            <xsl:for-each select="/siteinfo/pages/page[string-length(idparentpage)=0]"><xsl:sort select="name" order="ascending"/><option value="{id}"><xsl:value-of select="name"/></option></xsl:for-each>
					        </select></td></tr>
						<tr><td  class="xp_sel"><xsl:value-of select="$string[591]"/>:</td><td><input type="text" name="moderator" value="{moderator}" class="full"/></td></tr>
				 </table><br/>
				
				<!-- Standard Content -->
				<table class="block">
					<tr><td class="xp_sel"><xsl:value-of select="$string[51]"/>:</td><td><input type="text" name="name" class="full"/></td></tr>
					<tr>
						<td class="xp_sel"><xsl:value-of select="$string[54]"/>:</td>
						<td>
							<textarea name="body" class="textarea" title="{$string[438]}"></textarea>
							<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('body');</script></xsl:if>
						</td>
					</tr>				
				</table><br/>
				
				<!-- External link -->		
        			<table class="block">
                				<tr>
                					<td class="xp_sel"><xsl:value-of select="$string[65]"/>:</td>
                					<td>
                						<input type="text" value="" name="externallink" class="medium2" id="externallink"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
                						<select onchange="frmFullxml.externallink.value=frmFullxml.wizard.value" name="wizard">
                							<option value="">Manual</option>
                							<option value="default.asp?id=0&amp;ACT=7"><xsl:value-of select="$string[10]"/></option>
                							<option value="default.asp?id=0&amp;ACT=14"><xsl:value-of select="$string[13]"/></option>
                							<option value="default.asp?id=0&amp;ACT=19"><xsl:value-of select="$string[350]"/></option>
                							<option value="default.asp?id=0&amp;ACT=18"><xsl:value-of select="$string[370]"/></option>
                							<xsl:for-each select="document($directoryfile)//directories/directory">
                								<option value="default.asp?id=0&amp;ACT=24&amp;dir={@id}"><xsl:value-of select="concat($string[530], ': ', @name)"/></option>
                							</xsl:for-each>
															<xsl:for-each select="document($kbfile)/kb/knowbase">
            								    <xsl:variable name = "knowbase" select = "id" />
                								<option value="default.asp?id=0&amp;ACT=90&amp;kbid={$knowbase}&amp;item=0">
                									<xsl:value-of select="concat($string[621], ': ', title)"/>
                								</option>
                							</xsl:for-each>
                							<xsl:for-each select="document($calendarfile)/eventcalendar/calendar">
            								    <xsl:variable name = "calendar" select = "id" />
                								<option value="default.asp?id=0&amp;ACT=91&amp;calendar={$calendar}">
                									<xsl:value-of select="concat($string[744], ': ', calname)"/>
                								</option>
                							</xsl:for-each>
															<option value="default.asp?id=0&amp;ACT=70"><xsl:value-of select="$string[$classbasestring + 0]"/></option>
                						</select>
                					</td>
                				</tr>
                				<tr>
                					<td class="xp_sel"><xsl:value-of select="$string[138]"/>:</td>
                					<td align="left">
                						<input type="radio" value="eframe" name="externaltype"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>eFrame<br/>
                						<input type="radio" value="top" name="externaltype"><xsl:attribute name="checked">checked</xsl:attribute></input><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>target=_top<br/>
                						<input type="radio" value="blank" name="externaltype"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>target=_blank
                					</td>
                				</tr>
                				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
        				
        				<!-- The sort field for the article and the order-->
        				<tr>
        					<td class="xp_sel"><xsl:value-of select="$string[410]"/>:</td>
        					<td>
        						<select name="sortfield">
        							<option value="publicationdate" selected="selected"><xsl:value-of select="$string[413]"/></option>
        							<option value="title"><xsl:value-of select="$string[412]"/></option>
        							<option value="id"><xsl:value-of select="$string[414]"/></option>
        						</select>
        						 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
        						<select name="sortorder">
        							<option value="descending" selected="selected"><xsl:value-of select="$string[416]"/></option>
        							<option value="ascending"><xsl:value-of select="$string[415]"/></option>
        						</select>
        					</td>
        				</tr>
        				
        				<!-- Number of article -->
        				<tr>
        					<td class="xp_sel"><xsl:value-of select="$string[69]"/>:</td>
        					<td>
        						<select name="articlenumber">						
        							<option value="2">1</option>
        							<option value="3">2</option>
        							<option value="4">3</option>
        							<option value="5">4</option>
        							<option value="6" selected="selected">5</option>
        							<option value="7">6</option>
        							<option value="8">7</option>
        							<option value="9">8</option>
        							<option value="10">9</option>
        							<option value="11">10</option>
        							<option value="12">11</option>
        							<option value="13">12</option>
        							<option value="14">13</option>
        							<option value="15">14</option>
        							<option value="16">15</option>
        							<option value="17">16</option>
        							<option value="18">17</option>
        							<option value="19">18</option>
        							<option value="20">19</option>
        							<option value="21">20</option>
        						</select>
        					</td>
        				</tr>
				        <tr><td colspan="2"> </td></tr>
                				
        				<!-- DECORE OPTIONS -->
                				<tr>
                					<td class="xp_sel"><xsl:value-of select="$string[320]"/>:</td>
                					<td>
                						<select name="margintype">
                							<option value="0" selected="selected">
                								<xsl:if test="margintype=0"></xsl:if>
                								<xsl:value-of select="$string[323]"/>
                							</option>
                							<option value="1">
                								<xsl:if test="margintype=1"></xsl:if>
                								<xsl:value-of select="$string[321]"/>
                							</option>
                							<option value="2">
                								<xsl:if test="margintype=2"></xsl:if>
                								<xsl:value-of select="$string[322]"/>
                							</option> 
                						</select>
                					</td>
                				</tr>
                				<tr>
        					       <td class="xp_sel"><xsl:value-of select="$string[35]"/>:</td>
                					<td>
                						<select name="showtitle"><option value="off"> off</option><option value="on" selected="selected"> on</option></select>  <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[417]"/><br/>
                						<select name="showmenu"><option value="off"> off</option><option value="on" selected="selected"> on</option></select>  <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[36]"/><br/>
                						<select name="showtoolbar"><option value="off"> off</option><option value="on" selected="selected"> on</option></select>  <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[33]"/><br/>
                						<select name="showsearch"><option value="off"><xsl:if test="showsearch='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="showsearch='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>  <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[38]"/><br/>
                						<select name="toppages"><option value="off"><xsl:if test="toppages='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="toppages='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>  <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[67]"/><br/>
                						<select name="topdownloads"><option value="off"><xsl:if test="topdownloads='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="topdownloads='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>  <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[362]"/><br/>
                						<select name="lastposts">
																		<option value="off"><xsl:if test="lastposts=off"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option>
																		<option value="1"><xsl:if test="lastposts=1"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>1</option>
																		<option value="2"><xsl:if test="lastposts=2"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>2</option>
																		<option value="3"><xsl:if test="lastposts=3"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>3</option>
																		<option value="4"><xsl:if test="lastposts=4"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>4</option>
																		<option value="5"><xsl:if test="lastposts=5"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>5</option>
																		<option value="6"><xsl:if test="lastposts=6"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>6</option>
																		<option value="7"><xsl:if test="lastposts=7"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>7</option>
																		<option value="8"><xsl:if test="lastposts=8"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>8</option>
																		<option value="9"><xsl:if test="lastposts=9"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>9</option>
																		<option value="10"><xsl:if test="lastposts=10"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>10</option>
														</select>  <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[607]"/><br/>
														<select name="lastarticles">
																		<option value="off"><xsl:if test="lastarticles=off"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option>
																		<option value="1"><xsl:if test="lastarticles=1"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>1</option>
																		<option value="2"><xsl:if test="lastarticles=2"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>2</option>
																		<option value="3"><xsl:if test="lastarticles=3"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>3</option>
																		<option value="4"><xsl:if test="lastarticles=4"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>4</option>
																		<option value="5"><xsl:if test="lastarticles=5"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>5</option>
																		<option value="6"><xsl:if test="lastarticles=6"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>6</option>
																		<option value="7"><xsl:if test="lastarticles=7"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>7</option>
																		<option value="8"><xsl:if test="lastarticles=8"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>8</option>
																		<option value="9"><xsl:if test="lastarticles=9"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>9</option>
																		<option value="10"><xsl:if test="lastarticles=10"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>10</option>
														</select>  <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[608]"/><br/>
                					</td>
                				</tr>
						<!-- XSL Skin -->
						<tr><td class="xp_sel"><xsl:value-of select="$string[29]"/>:</td><td>
						<xsl:variable name="xslskin" select="xslskin"/>
						<select name="xslskin">
						<option value="">off</option>						
							<xsl:for-each select="$skinsnode/xslskins/xslskin"><xsl:sort select="@name" data-type="text" order="ascending"/>
								<option value="{@name}"><xsl:if test="$xslskin=@name"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="@name"/></option>
							</xsl:for-each>													
						</select>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[365]"/>
						</td></tr>  
        				</table>
				<br/>	

				<!-- publication -->
				<table class="block">
					<tr>
						<td class="xp_sel"><xsl:value-of select="$string[59]"/>:</td>
						<td>
							<select name="visible">
								<option value="off" selected="selected"><xsl:value-of select="$string[61]"/></option>
								<option value="on"><xsl:value-of select="$string[60]"/></option>
							</select></td></tr>	
					<tr>
						<td class="xp_sel"><xsl:value-of select="$string[63]"/>:</td>
						<td><input type="text" name="publicationdate" id="publicationdate" value="{substring($actualdate,1,8)}" onClick="cal.select(this, 'publicationdate', 'yyyyMMdd');"  maxlength="8" class="mini"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><small>yyyymmdd</small><!--<input type="button" value="{$string[63]}" style="width: 150px" onClick="getCalendarFor(document.frmadm.publicationdate)"/>--></td>
					</tr>
					<tr>
						<td class="xp_sel"><xsl:value-of select="$string[64]"/>:</td>
						<td><input type="text" name="expirationdate" id="expirationdate" onClick="cal.select(this, 'expirationdate', 'yyyyMMdd');"  maxlength="8" class="mini"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><small>yyyymmdd</small><!--<input type="button" value="{$string[64]}" style="width: 150px" onClick="getCalendarFor(document.frmadm.expirationdate)"/>--></td>
					</tr>									
					<tr>
						<td colspan="2" align="right">
							<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
							<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M2';"/>
						</td>
					</tr>
				</table>
            </td></tr></form></table>		
	</xsl:template>
		
	
	
	<!-- Modifiy page form-->
	<xsl:template name="page_update">
		<xsl:variable name="idparentpage" select="idparentpage"/>
		<xsl:variable name="idcategory" select="category"/>
						
		<table bgcolor="white"><tr><td>		
		<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmFullxml">
			<input type="hidden" name="operation" value="update"/>
			<input type="hidden" name="node" value="siteinfo/pages/page[id={id}]"/>				
			<input type="hidden" name="count" value="{count}"/>
			
			<table class="block">
				<tr><td class="xp_sel"><xsl:value-of select="$string[66]"/>:</td><td><select name="category"><xsl:for-each select="document($categoryfile)//categories/category"><option value="{id}"><xsl:if test="$idcategory=id"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="name"/></option></xsl:for-each></select></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[52]"/>:</td><td><select name="idparentpage"><option value="">None</option><xsl:for-each select="/siteinfo/pages/page[idparentpage='']"><xsl:sort select="name" order="ascending"/><option value="{id}"><xsl:if test="$idparentpage=id"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="name"/></option></xsl:for-each></select></td></tr>
				<tr><td  class="xp_sel"><xsl:value-of select="$string[591]"/>:</td><td><input type="text" name="moderator" value="{moderator}" class="full"/></td></tr>

			</table><br/>
			
			<!-- Standard Content -->
			<table class="block">
				<tr><td class="xp_sel"><xsl:value-of select="$string[51]"/>:</td><td><input type="text" value="{name}" name="name" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[54]"/>:</td>
					<td>
						<textarea name="body" class="textarea" title="{$string[438]}"><xsl:value-of select="body"/></textarea>
						<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('body');</script></xsl:if>
					</td>
				</tr>
			</table><br/>
			
       				
        				<!-- External link -->
        				<table class="block">
        					<tr>
        						<td class="xp_sel"><xsl:value-of select="$string[65]"/>:</td>
        						<td>
        							<input type="text" value="{externallink}" name="externallink" class="medium2"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
        							<select onchange="frmFullxml.externallink.value=frmFullxml.wizard.value" name="wizard">
                							<option value=""><xsl:if test="wizard=''"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Manual</option>
                							<option value="default.asp?id=0&amp;ACT=7"><xsl:if test="wizard='default.asp?id=0&amp;ACT=7'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[10]"/></option>
                							<option value="default.asp?id=0&amp;ACT=14"><xsl:if test="wizard='default.asp?id=0&amp;ACT=14'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[13]"/></option>
                							<option value="default.asp?id=0&amp;ACT=19"><xsl:if test="wizard='default.asp?id=0&amp;ACT=19'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[350]"/></option>
                							<option value="default.asp?id=0&amp;ACT=18"><xsl:if test="wizard='default.asp?id=0&amp;ACT=18'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[370]"/></option>
                							<xsl:for-each select="document($directoryfile)//directories/directory">
                								<option value="default.asp?id=0&amp;mnu={$id}&amp;ACT=24&amp;dir={@id}"><xsl:value-of select="concat($string[530], ': ', @name)"/></option>
                							</xsl:for-each>
                							<xsl:for-each select="document($kbfile)/kb/knowbase">
            								    <xsl:variable name = "knowbase" select = "id" />
                								<option value="default.asp?id=0&amp;ACT=90&amp;kbid={$knowbase}">
                									<xsl:value-of select="concat($string[621], ': ', title)"/>
                								</option>
                							</xsl:for-each>
															<xsl:for-each select="document($calendarfile)/eventcalendar/calendar">
            								    <xsl:variable name = "calendar" select = "id" />
                								<option value="default.asp?id=0&amp;ACT=91&amp;calendar={$calendar}">
                									<xsl:value-of select="concat($string[744], ': ', calname)"/>
                								</option>
                							</xsl:for-each>
															<option value="default.asp?id=0&amp;ACT=70"><xsl:if test="wizard='default.asp?id=0&amp;ACT=70'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[$classbasestring + 0]"/></option>
                						</select>
        						</td>
        					</tr>
        					<tr>
        						<td  class="xp_sel"><xsl:value-of select="$string[138]"/>:</td>
        						<td>
        							<input type="radio" value="eframe" name="externaltype">
												<xsl:if test="externaltype='eframe'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
        							</input><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>eFrame<br/>
        							<input type="radio" value="top" name="externaltype">
												<xsl:if test="externaltype='top' or string-length(externaltype)=0"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
        							</input><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>target=_top<br/>
        							<input type="radio" value="blank" name="externaltype">
												<xsl:if test="externaltype='blank'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
        							</input><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>target=_blank
        						</td>
        					</tr>
        					<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>			
        					<!-- Number of article -->
        					<tr>
        						<td  class="xp_sel"><xsl:value-of select="$string[69]"/>:</td>
        						<td>
        							<!--<input type="text" name="articlenumber" value="{number(articlenumber)}" class="mini" />-->
        							<select name="articlenumber">						
        								<option value="2"><xsl:if test="articlenumber=2"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>1</option>
        								<option value="3"><xsl:if test="articlenumber=3"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>2</option>
        								<option value="4"><xsl:if test="articlenumber=4"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>3</option>
        								<option value="5"><xsl:if test="articlenumber=5"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>4</option>
        								<option value="6"><xsl:if test="articlenumber=6 or string-length(articlenumber)=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>5</option>
        								<option value="7"><xsl:if test="articlenumber=7"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>6</option>
        								<option value="8"><xsl:if test="articlenumber=8"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>7</option>
        								<option value="9"><xsl:if test="articlenumber=9"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>8</option>
        								<option value="10"><xsl:if test="articlenumber=10"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>9</option>
        								<option value="11"><xsl:if test="articlenumber=11"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>10</option>
        								<option value="12"><xsl:if test="articlenumber=12"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>11</option>
        								<option value="13"><xsl:if test="articlenumber=13"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>12</option>
        								<option value="14"><xsl:if test="articlenumber=14"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>13</option>
        								<option value="15"><xsl:if test="articlenumber=15"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>14</option>
        								<option value="16"><xsl:if test="articlenumber=16"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>15</option>
        								<option value="17"><xsl:if test="articlenumber=17"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>16</option>
        								<option value="18"><xsl:if test="articlenumber=18"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>17</option>
        								<option value="19"><xsl:if test="articlenumber=19"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>18</option>
        								<option value="20"><xsl:if test="articlenumber=20"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>19</option>
        								<option value="21"><xsl:if test="articlenumber=21"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>20</option>
        							</select>
        						</td>
        					</tr>
        					<!-- Article paging -->			
    						<tr>
    							<td  class="xp_sel"><xsl:value-of select="$string[598]"/>:</td>
    							<td>
    								<select name="paging">
									<xsl:choose>
										<xsl:when test="paging='on'"><option value="off">off</option><option value="on" selected="selected">on</option></xsl:when>
										<xsl:otherwise><option value="off" selected="selected">off</option><option value="on">on</option></xsl:otherwise>
									</xsl:choose>
								</select>
    							</td>
    						</tr>
    						
        					<!-- The sort field for the article and the order-->
        					<tr>
        						<td  class="xp_sel"><xsl:value-of select="$string[410]"/>:</td>
        						<td>
        							<select name="sortfield">
        								<option value="publicationdate"><xsl:if test="sortfield='publicationdate' or string-length(sortfield)=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[413]"/></option>
        								<option value="title"><xsl:if test="sortfield='title'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[412]"/></option>
        								<option value="id"><xsl:if test="sortfield='id'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[414]"/></option>
        							</select>
        							 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
        							<select name="sortorder">
        								<option value="descending"><xsl:if test="sortorder='descending' or string-length(sortorder)=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[416]"/></option>
        								<option value="ascending"><xsl:if test="sortorder='ascending'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[415]"/></option>
        							</select>
        						</td>
        					</tr>
        					<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
        			
        					<tr>
        						<td  class="xp_sel"><xsl:value-of select="$string[320]"/>:</td>
        						<td>
        							<select name="margintype">
        								<option value="0">
        									<xsl:if test="margintype=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
        									<xsl:value-of select="$string[323]"/>
        								</option>
        								<option value="1">
        									<xsl:if test="margintype=1"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
        									<xsl:value-of select="$string[321]"/>
        								</option>
        								<option value="2">
        									<xsl:if test="margintype=2"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
        									<xsl:value-of select="$string[322]"/>
        								</option> 
        							</select>
        						</td>
        					</tr>
    					
        					<!-- OPTIONS -->
        					<tr>
        						<td  class="xp_sel"><xsl:value-of select="$string[35]"/>:</td>
        						<td>
        							<select name="showtitle"><option value="off"><xsl:if test="showtitle='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="showtitle='on' or string-length(showtitle)=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>  <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[417]"/><br/>
        							<select name="showmenu"><option value="off"><xsl:if test="showmenu='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="showmenu='on' or string-length(showmenu)=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>  <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[36]"/><br/>
        							<select name="showtoolbar"><option value="off"><xsl:if test="showtoolbar='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="showtoolbar='on'  or string-length(showtoolbar)=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>  <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[33]"/><br/>
        							<select name="showsearch"><option value="off"><xsl:if test="showsearch='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="showsearch='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>  <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[38]"/><br/>
        							<select name="toppages"><option value="off"><xsl:if test="toppages='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="toppages='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>  <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[67]"/><br/>
        							<select name="topdownloads"><option value="off"><xsl:if test="topdownloads='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="topdownloads='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>  <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[362]"/><br/>
                						<select name="lastposts">
									<option value="off"><xsl:if test="lastposts=off"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option>
									<option value="1"><xsl:if test="lastposts=1"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>1</option>
									<option value="2"><xsl:if test="lastposts=2"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>2</option>
									<option value="3"><xsl:if test="lastposts=3"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>3</option>
									<option value="4"><xsl:if test="lastposts=4"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>4</option>
									<option value="5"><xsl:if test="lastposts=5"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>5</option>
									<option value="6"><xsl:if test="lastposts=6"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>6</option>
									<option value="7"><xsl:if test="lastposts=7"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>7</option>
									<option value="8"><xsl:if test="lastposts=8"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>8</option>
									<option value="9"><xsl:if test="lastposts=9"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>9</option>
									<option value="10"><xsl:if test="lastposts=10"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>10</option>
								</select>  <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[607]"/><br/>
								<select name="lastarticles">
									<option value="off"><xsl:if test="lastarticles=off"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option>
									<option value="1"><xsl:if test="lastarticles=1"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>1</option>
									<option value="2"><xsl:if test="lastarticles=2"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>2</option>
									<option value="3"><xsl:if test="lastarticles=3"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>3</option>
									<option value="4"><xsl:if test="lastarticles=4"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>4</option>
									<option value="5"><xsl:if test="lastarticles=5"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>5</option>
									<option value="6"><xsl:if test="lastarticles=6"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>6</option>
									<option value="7"><xsl:if test="lastarticles=7"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>7</option>
									<option value="8"><xsl:if test="lastarticles=8"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>8</option>
									<option value="9"><xsl:if test="lastarticles=9"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>9</option>
									<option value="10"><xsl:if test="lastarticles=10"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>10</option>
								</select>  <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[608]"/><br/>
        						</td>
        					</tr>

						<!-- XSL Skin -->
						<tr><td class="xp_sel"><xsl:value-of select="$string[29]"/>:</td><td>
						<xsl:variable name="xslskin" select="xslskin"/>
						<select name="xslskin">
						<option value="">off</option>						
							<xsl:for-each select="$skinsnode/xslskins/xslskin"><xsl:sort select="@name" data-type="text" order="ascending"/>
								<option value="{@name}"><xsl:if test="$xslskin=@name"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="@name"/></option>
							</xsl:for-each>													
						</select>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[365]"/>
						</td></tr>   
        				</table><br/>
    		        
		
			<table class="block">
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>				
				<tr>
					<td  class="xp_sel"><xsl:value-of select="$string[59]"/>:</td>
					<td>
						<select name="visible">
						<option value="off"><xsl:if test="visible='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[61]"/></option>
						<option value="on"><xsl:if test="visible='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[60]"/></option>
						</select>
						<!--<input type="text" name="publicationdate" value="{publicationdate}" /> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="button" value="{$string[63]}" style="width: 150px" onclick="btndate_onclick();"/>-->
					</td>
				</tr>
				<tr>
					<td  class="xp_sel"><xsl:value-of select="$string[63]"/>:</td>
					<td><input type="text" name="publicationdate" id="publicationdate" value="{publicationdate}" maxlength="8" class="mini" onClick="cal.select(this, 'publicationdate', 'yyyyMMdd');" /> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><small>yyyymmdd</small><A NAME="calposition1" ID="calposition1"> </A></td>
				</tr>
				<tr>
					<td  class="xp_sel"><xsl:value-of select="$string[64]"/>:</td>
					<td><input type="text" name="expirationdate" id="expirationdate" value="{expirationdate}"  maxlength="8" class="mini" onClick="cal.select(this, 'expirationdate', 'yyyyMMdd');" /> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><small>yyyymmdd</small><!--<input type="button" value="{$string[64]}" style="width: 150px" onClick="getCalendarFor(document.frmadm.expirationdate)"/>--></td>
				</tr>				
				
				<tr>
					<td align="right" colspan="2">
						<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M2';"/>
						<!--<input class="sbttn" style="WIDTH: 100px" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M5&amp;id={id}';" type="button" value="Add content" onmouseover="over(this);" onmouseout="notover(this);"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>-->
					</td>
				</tr>		
			</table>
		</form>
		
		
		<!-- delete button ans content list -->
		<table class="block">
			<xsl:choose>
				<xsl:when test="@readonly='readonly'">
					<tr>
						<td align="right" colspan="2">
							<font color="red"><xsl:value-of select="$string[57]"/></font>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<tr>
						<td align="right" colspan="2">
							<form action="default.asp?ACT=1&amp;SECT=M2" method="post" onsubmit="return confirm('{$string[58]}');">
								<input type="hidden" name="operation" value="delete"/>
								<input type="hidden" name="node" value="siteinfo/pages/page[id={id}]"/>
								<input type="submit" value="{$string[16]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
							</form>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<tr><td align="center"><a href="default.asp?ACT=1&amp;SECT=M3&amp;page={id}"><xsl:value-of select="$string[418]"/></a></td></tr>
		</table>
		
		</td></tr></table>
	</xsl:template>

</xsl:stylesheet>