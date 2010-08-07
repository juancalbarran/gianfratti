<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html"/> 

	<xsl:template name="photo_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Photo gallery</xsl:with-param>
			<xsl:with-param name="version">0.7</xsl:with-param>
			<xsl:with-param name="moddate">07.11.2003</xsl:with-param>
			<xsl:with-param name="author">John Roland and JeS (Jens Schreiber)</xsl:with-param>
			<xsl:with-param name="url">http://www.fxmods.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="photo_initialupdate">
		<form action="default.asp?ACT={$ACT}&amp;SECT={$section}" method="post" name="frmUpdate">
			<input type="hidden" name="operation" value="add"/>
			<input type="hidden" name="bloc" value="siteinfo"/>
			<input type="hidden" name="node" value="photocategories"/>
		</form>
		<script language="javascript">
			document.frmUpdate.submit();
		</script>
	</xsl:template>

	<xsl:template name="gallery_manager">
		<!-- new navigator on top modified by JeS -->
		<table class="" style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr>
				<td width="50%" align="center">
					<a href="default.asp?ACT=1&amp;SECT=M7">
						<img src="admin/media/pictures.gif" border="0"/>
					</a>
				</td>
				<td width="50%" align="center">
					<a href="default.asp?ACT=1&amp;SECT=M7&amp;id=list">
						<img src="admin/media/pictures.gif" border="0"/>
					</a>
				</td>
			</tr>
			<tr>
				<td align="center">
					<xsl:value-of select="$string[331]" />
				</td>				
				<td align="center">
					<xsl:value-of select="$string[120]" />
				</td>
			</tr>		
		</table>
		
		<script>
			var fx_imgwin;
			 var fx_opener;			
			 			
			function OpenImage(oOpener) 
			{
				fx_opener = oOpener;
				fx_imgwin = window.open('filepicker.asp','selImg','width=450, height=330, scrollbars=yes'); 
				fx_imgwin.focus();
			}
			
			function OpenPath(oOpener) 
			{
				fx_opener = oOpener;
				fx_imgwin = window.open('dirpicker.asp','selImg','width=450, height=330, scrollbars=yes'); 
				fx_imgwin.focus();
			}
			 
			function onImage(u, base_url, iborder, ialign, ialt, num) {
				fx_opener.value = u;
				fx_imgwin.close();
			}
			
			function onDirectory(u, base_url, iborder, ialign, ialt, num) {
				fx_opener.value = base_url;
				fx_imgwin.close();
			}
		</script>		
		<xsl:choose>
			<xsl:when test="name(/siteinfo/photocategories)">
				<!-- is it a operation on picture or category -->
				<xsl:choose>
					<xsl:when test="$cat">
						<xsl:choose>
							<xsl:when test="$cat='new'">
								<xsl:call-template name="gallery_categoryadd"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:for-each select="siteinfo/photocategories/photocategory[id=$cat]">
									<xsl:call-template name="gallery_categoryupdate"/>
								</xsl:for-each>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$id">
						<xsl:choose>
							<xsl:when test="$id='list'">
								<xsl:call-template name="gallery_list"/>
							</xsl:when>
							<xsl:when test="$id='new'">
								<xsl:call-template name="gallery_add"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:for-each select="siteinfo/photos/photo[id=$id]">
									<xsl:call-template name="gallery_update"/>
								</xsl:for-each>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="gallery_categorylist"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="photo_initialupdate"/>
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>
	
	<xsl:template name="gallery_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr>
				<td  class="header" width="50"><xsl:value-of select="$string[127]"/></td>
				<td class="header"><xsl:value-of select="$string[121]"/></td>
				<td class="header"><xsl:value-of select="$string[122]"/></td>
			</tr>			

			<xsl:for-each select="/siteinfo/photos/photo[string-length(category) &gt; 1]">
				<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M7&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td><xsl:value-of select="id"/></td>
					<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M7&amp;id={id}"><xsl:value-of select="title" disable-output-escaping="yes"/></a></td>
					<td class="data2"><xsl:value-of select="image" disable-output-escaping="yes"/></td>
				</tr>
			</xsl:for-each>	
		
			<xsl:for-each select="/siteinfo/photocategories/photocategory">				
				<xsl:sort select="title"/>				
				<xsl:variable name = "catid" select = "id" />
				<xsl:if test="count(/siteinfo/photos/photo[category=$catid]) > 0">
					<tr>
						<td colspan="3" align="center">
							<font color="white"><b>-=<xsl:value-of select="title" />=-</b></font>
						</td>
					</tr>
					<xsl:for-each select="/siteinfo/photos/photo[category=$catid]">
						<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M7&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
							<td><xsl:value-of select="id"/></td>
							<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M7&amp;id={id}"><xsl:value-of select="title" disable-output-escaping="yes"/></a></td>
							<td class="data2"><xsl:value-of select="image" disable-output-escaping="yes"/></td>
						</tr>
					</xsl:for-each>	
				</xsl:if>
			</xsl:for-each>
			<tr><td colspan="3" align="right"><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M7&amp;id=new';" type="button" value="{$string[15]}"/></td></tr>
		</table>
	</xsl:template>

	<xsl:template name="gallery_categoryselect">
		<xsl:param name="category"/>
		<xsl:for-each select = "/siteinfo/photocategories/photocategory[directory='off']">
			<xsl:choose>
				<xsl:when test="id=$category">
					<option selected="selected" value="{id}">
						<xsl:value-of select="title" />
					</option>
				</xsl:when>
				<xsl:otherwise>
					<option value="{id}">
						<xsl:value-of select="title" />
					</option>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>		
	</xsl:template>
	
	<!-- addphoto template  -->
	<xsl:template name="gallery_add">
		<table bgcolor="white"><form action="default.asp?ACT=1&amp;SECT=M7&amp;id=list" method="post" name="frmFullxml"><tr><td>	
			<input type="hidden" name="operation" value="add"/>
			<input type="hidden" name="bloc" value="siteinfo/photos"/>
			<input type="hidden" name="node" value="photo"/>
			
			<table class="block">
				<tr><td  class="xp_sel"><xsl:value-of select="$string[128]"/>:</td><td><select name="category" class="full">
					<xsl:call-template name = "gallery_categoryselect" >
	                </xsl:call-template></select>
	            </td></tr>
				<tr><td  class="xp_sel"><xsl:value-of select="$string[121]"/>:</td><td><input type="text" name="title" class="full"/></td></tr>
				<tr><td  class="xp_sel"><xsl:value-of select="$string[123]"/>:</td>
					<td>
						<textarea  class="textarea" name="text" title="{$string[438]}"></textarea>
						<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('text');</script></xsl:if>
					</td>
				</tr>
				<tr><td  class="xp_sel"><xsl:value-of select="$string[122]"/>:</td><td><input type="text" name="image" class="full"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.image);"/></td></tr>
				<tr><td  class="xp_sel"><xsl:value-of select="$string[126]"/>:</td><td><input type="text" name="thumbnail" class="full"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.thumbnail);"/></td></tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M7';"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					</td>
				</tr>
			</table>
			</td></tr></form>
		</table>
	</xsl:template>

		
	<!-- configphoto template  -->
	<xsl:template name="gallery_update">
	
		<table bgcolor="white"><tr><td>
			<form action="default.asp?ACT=1&amp;SECT={$section}&amp;id=list" method="post" name="frmFullxml">
			<input type="hidden" name="operation" value="update"/>
			<input type="hidden" name="node" value="siteinfo/photos/photo[id={id}]"/>						
			
			<table class="block">
				<tr><td  class="xp_sel"><xsl:value-of select="$string[128]"/>:</td><td><select name="category" class="full">
					<xsl:call-template name = "gallery_categoryselect" >						
						<xsl:with-param name="category"><xsl:value-of select="category"/></xsl:with-param>
	                </xsl:call-template></select>
	            </td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[121]"/>:</td><td><input type="text" value="{title}" name="title" class="full"/></td></tr>				
				<tr><td class="xp_sel"><xsl:value-of select="$string[123]"/>:</td>
					<td>
						<textarea  class="textarea" name="text" title="{$string[438]}"><xsl:value-of select="text"/></textarea>
						<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('text');</script></xsl:if>
					</td>
				</tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[122]"/>:</td><td><input type="text" value="{image}" name="image" class="full"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.image);"/></td></tr>
				<tr><td  class="xp_sel"><xsl:value-of select="$string[126]"/>:</td><td><input type="text" value="{thumbnail}" name="thumbnail" class="full"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.thumbnail);"/></td></tr>
				
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M7';"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					</td>
				</tr>
			</table>
			</form>
			<table class="block">
				<tr><form action="default.asp?ACT=1&amp;SECT={$section}&amp;id=list" method="post" onsubmit="return confirm('{$string[124]}');">
					<td align="right">
							<input type="hidden" name="operation" value="delete"/>
							<input type="hidden" name="node" value="siteinfo/photos/photo[id={id}]"/>
							<input type="submit" value="{$string[16]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					</td></form></tr></table>
		</td></tr></table>
	</xsl:template>

	<xsl:template name="gallery_categorylist">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr>
				<td  class="header" width="16"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td class="header" width="50"><xsl:value-of select="$string[127]"/></td>
				<td class="header"><xsl:value-of select="$string[330]"/></td>
				<td class="header" width="150"><xsl:value-of select="$string[56]"/></td>
			</tr>
			<xsl:for-each select="/siteinfo/photocategories/photocategory">
				<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M7&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td><img src="admin/media/{visible}.gif" width="16" height="15" border="0"/></td>
					<td class="data2"><xsl:value-of select="id"/></td>					
					<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M7&amp;cat={id}"><xsl:value-of select="title" disable-output-escaping="yes"/></a></td>
					<td class="data2"><xsl:value-of select="group" disable-output-escaping="yes"/></td>
				</tr>
			</xsl:for-each>	
			<tr><td colspan="4" align="right"><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M7&amp;cat=new';" type="button" value="{$string[15]}"/></td></tr>
		</table>
	</xsl:template>
	
	<xsl:template name="gallery_categoryadd">
		<table bgcolor="white"><form action="default.asp?ACT=1&amp;SECT=M7" method="post" name="frmFullxml"><tr><td>	
			<input type="hidden" name="operation" value="add"/>
			<input type="hidden" name="bloc" value="siteinfo/photocategories"/>
			<input type="hidden" name="node" value="photocategory"/>
			
			<table class="block">			
				<tr>
					<td  class="xp_sel"><xsl:value-of select="$string[330]"/>:
					</td>
					<td>
						<input type="text" name="title" class="full"/>
					</td>
				</tr>
				<tr>
					<td  class="xp_sel">
						<xsl:value-of select="$string[162]"/>:
					</td>
					<td>
						<input type="text" name="name" class="full"/>
					</td>
				</tr>
				<tr>
					<td  class="xp_sel">
						<xsl:value-of select="$string[56]"/>:
					</td>
					<td>
						<select name="group" class="full">
							<option value="anonymous">anonymous</option>
							<option selected="selected" value="member"><xsl:value-of select="$string[430]"/></option>
							<option value="editor"><xsl:value-of select="$string[429]"/></option>
							<option value="administrator"><xsl:value-of select="$string[428]"/></option>
						</select>
					</td>
				</tr>
				<tr>
					<td  class="xp_sel">
						<xsl:value-of select="$string[194]"/>:
					</td>
					<td>
						<select name="visible" class="full">
							<option value="off"><xsl:value-of select="$string[61]"/></option>
							<option value="on">
								<xsl:attribute name="selected">selected</xsl:attribute>
								<xsl:value-of select="$string[60]"/>
							</option>
						</select>
					</td>
				</tr>				
				<tr>
					<td  class="xp_sel">
						<xsl:value-of select="$string[126]"/>:
					</td>
					<td>
						<input type="text" name="thumbnail" class="full"/>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.thumbnail);"/>
					</td>
				</tr>
				<tr>
					<td  class="xp_sel" colspan="2" height="16">
					</td>					
				</tr>
				<tr>
					<td  class="xp_sel">
						<xsl:value-of select="$string[530]"/>:
					</td>
					<td>
						<select name="directory">
							<option value="off" selected="selected"><xsl:value-of select="$string[61]"/></option>
							<option value="on"> <xsl:value-of select="$string[60]"/></option>
						</select>
					</td>
				</tr>
				<tr>
					<td  class="xp_sel">
						<xsl:value-of select="$string[164]"/>:
					</td>
					<td>
						<input type="text" name="path" class="full"/><xsl:value-of select="path"/>
						<input type="button" value="{$string[125]}" onclick="OpenPath(document.frmFullxml.path);"/>
					</td>
				</tr>				
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="{$string[18]}"/>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M7';"/>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					</td>
				</tr>
			</table>
			</td></tr></form>
		</table>
	</xsl:template>
	
	<xsl:template name="gallery_categoryupdate">
		<table bgcolor="white"><form action="default.asp?ACT=1&amp;SECT=M7" method="post" name="frmFullxml"><tr><td>	
			<input type="hidden" name="operation" value="update"/>
			<input type="hidden" name="node" value="siteinfo/photocategories/photocategory[id={$cat}]"/>
			
			<table class="block">			
				<tr>
					<td  class="xp_sel">
						<xsl:value-of select="$string[330]"/>:
					</td>
					<td>
						<input type="text" name="title" class="full" value="{title}"/>
					</td>
				</tr>
				<tr>
					<td  class="xp_sel">
						<xsl:value-of select="$string[162]"/>:
					</td>
					<td>
						<input type="text" name="name" class="full" value="{name}"/>
					</td>
				</tr>
				<tr>
					<td  class="xp_sel">
						<xsl:value-of select="$string[56]"/>:
					</td>
					<td>
						<select name="group" class="full">
							<xsl:choose>
								<xsl:when test="group='anonymous'">
									<option selected="selected" value="anonymous">anonymous</option>
									<option value="member"><xsl:value-of select="$string[430]"/></option>
									<option value="editor"><xsl:value-of select="$string[429]"/></option>
									<option value="administrator"><xsl:value-of select="$string[428]"/></option>
								</xsl:when>
								<xsl:when test="group='member'">
									<option value="anonymous">anonymous</option>
									<option selected="selected" value="member"><xsl:value-of select="$string[430]"/></option>
									<option value="editor"><xsl:value-of select="$string[429]"/></option>
									<option value="administrator"><xsl:value-of select="$string[428]"/></option>
								</xsl:when>
								<xsl:when test="group='editor'">
									<option value="anonymous">anonymous</option>
									<option value="member"><xsl:value-of select="$string[430]"/></option>
									<option selected="selected" value="editor"><xsl:value-of select="$string[429]"/></option>
									<option value="administrator"><xsl:value-of select="$string[428]"/></option>
								</xsl:when>
								<xsl:when test="group='administrator'">
									<option value="anonymous">anonymous</option>
									<option value="member"><xsl:value-of select="$string[430]"/></option>
									<option value="editor"><xsl:value-of select="$string[429]"/></option>
									<option selected="selected" value="administrator"><xsl:value-of select="$string[428]"/></option>
								</xsl:when>
							</xsl:choose>
						</select>
					</td>
				</tr>
				<tr>
					<td  class="xp_sel">
						<xsl:value-of select="$string[194]"/>:
					</td>
					<td>
						<select name="visible" class="full">							
							<xsl:choose>
								<xsl:when test="visible='on'">
									<option selected="selected" value="on"><xsl:value-of select="$string[60]"/></option>
									<option value="off"><xsl:value-of select="$string[61]"/></option>
								</xsl:when>
								<xsl:otherwise>
									<option value="on"><xsl:value-of select="$string[60]"/></option>
									<option selected="selected" value="off"><xsl:value-of select="$string[61]"/></option>
								</xsl:otherwise>
							</xsl:choose>
						</select>
					</td>
				</tr>
				<tr>
					<td  class="xp_sel">
						<xsl:value-of select="$string[126]"/>:
					</td>
					<td>
						<input type="text" value="{thumbnail}" name="thumbnail" class="full"/>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.thumbnail);"/>
					</td>
				</tr>
				<tr>
					<td  class="xp_sel">
						<xsl:value-of select="$string[530]"/>:
					</td>
					<td>
						<select name="directory">
							<xsl:choose>
								<xsl:when test="directory='off'">
									<option value="off" selected="selected"><xsl:value-of select="$string[61]"/></option>
									<option value="on"> <xsl:value-of select="$string[60]"/></option>
								</xsl:when>
								<xsl:otherwise>
									<option value="off"><xsl:value-of select="$string[61]"/></option>
									<option value="on" selected="selected"> <xsl:value-of select="$string[60]"/></option>
								</xsl:otherwise>
							</xsl:choose>
						</select>
					</td>
				</tr>
				<tr>
					<td  class="xp_sel">
						<xsl:value-of select="$string[164]"/>:
					</td>
					<td>
						<input type="text" value="{path}" name="path" class="full"/>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[125]}" onclick="OpenPath(document.frmFullxml.path);"/>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M7';"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					</td>
				</tr>
			</table>
			</td></tr></form>
			<tr><td>
			<xsl:if test="count(/siteinfo/photos/photo[category=$cat])=0">
				<table class="block">
					<tr><form action="default.asp?ACT=1&amp;SECT={$section}" method="post" onsubmit="return confirm('{$string[124]}');">
						<td align="right">
								<input type="hidden" name="operation" value="delete"/>
								<input type="hidden" name="node" value="siteinfo/photocategories/photocategory[id={$cat}]"/>
								<input type="submit" value="{$string[16]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						</td></form></tr></table>
			</xsl:if>
		</td></tr></table>
	</xsl:template>

</xsl:stylesheet>