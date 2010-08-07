<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve">
<xsl:output method="html"/> 

<!-- Webpages Template : add/update/modify -->
<!-- last modified : 2001/10/26, by J.Roland -->
<!-- version 1.0 -->

	<xsl:template name="directory_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Directory</xsl:with-param>
			<xsl:with-param name="version">1.0</xsl:with-param>
			<xsl:with-param name="moddate">09.09.2003</xsl:with-param>
			<xsl:with-param name="author">John Roland and JeS</xsl:with-param>
			<xsl:with-param name="url">http://www.fullxml.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="directories_manager">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M22"><img src="admin/media/category.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[483]"/></font></td></tr>
		</table>			
				
		<style>
			a.treeview, a.treeview:visited, a.treeview:link{color: black; text-decoration: none; font-weight: normal; text-indent: 2px;}
			a.treeview:hover{color: HighlightText ; background: Highlight ; text-indent: 2px;}
			
			a.command, a.command:visited, a.command:link{color: blue; text-decoration: none;font-weight: normal}
			a.command:hover{color: HighlightText ; background: Highlight ;}

			.directory{cursor:pointer;cursor:hand ; font-weight:bold ; list-style-image:url(admin/media/directory.gif); vertical-align: middle; margin-left: 0px}
			.child {display: none; }
			.imgcmd {BEHAVIOR: url(admin/js/imgcmd.htc); cursor:hand ; }
			.category{cursor:pointer;cursor:hand ; font-weight:bold ; list-style-image:url(admin/media/folder_close.gif); vertical-align: middle; BEHAVIOR: url(admin/js/category.htc)}
			.item{cursor:pointer;cursor:hand ; font-weight:bold ; list-style-image:url(admin/media/item.gif); vertical-align: middle;}
			.command{cursor:pointer;cursor:hand ; font-weight:bold ; list-style-image:url(admin/media/folder_close.gif); vertical-align: middle;}
		</style>
					
		<script>
			var fx_imgwin;
			 var fx_opener;			
			 			
			function OpenImage(oOpener) {
				fx_opener = oOpener;
				fx_imgwin = window.open('filepicker.asp','selImg','width=450, height=330, scrollbars=yes'); 
				fx_imgwin.focus();
			}
			 
			function onImage(u, base_url, iborder, ialign, ialt, num) {
				fx_opener.value = u;				
				fx_imgwin.close();
			}
		</script>

				
		<xsl:choose>
			<xsl:when test="$id='new' and $cmd='dir'">
				<xsl:call-template name="directory_add"/>
			</xsl:when>
			<xsl:when test="$id!='new' and $cmd='dir'">
				<xsl:apply-templates select="document($directoryfile)//directories/directory[@id=$id]" mode="update"/>
			</xsl:when>
			<xsl:when test="$id='new' and $cmd='cat'">
				<xsl:call-template name="dircategory_add"/>
			</xsl:when>
			<xsl:when test="$id!='new' and $cmd='cat'">
				<xsl:apply-templates select="document($directoryfile)//directories/directory[@id=$dir]//category[@id=$id]" mode="update"/>
			</xsl:when>
			<xsl:when test="$id='new' and $cmd='item'">
				<xsl:call-template name="item_add"/>
			</xsl:when>
			<xsl:when test="$id!='new' and $cmd='item'">				
				<xsl:apply-templates select="document($directoryfile)//directories/directory[@id=$dir]//category[@id=$cat]/item[@id=$id]" mode="update"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="directories_list"/>
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>


	<!-- Arbre de présentation des directories -->
	<xsl:template name="directories_list">		
		<table width="600">
			<tr height="400">
				<td bgcolor="white">
					<xsl:apply-templates select="document($directoryfile)//directories/directory" mode="list"/>
					<table width="100%" cellpadding="1" cellspacing="2">
						<tr>
							<td width="0" valign="baseline"><img src="admin/media/command.gif"/></td>
							<td width="100%" valign="baseline"><a href="default.asp?ACT=1&amp;SECT=M22&amp;id=new&amp;cmd=dir"><xsl:value-of select="$string[487]"/></a></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</xsl:template>
	
	
	<!-- Directory node -->
	<xsl:template match="directory" mode="list">		
		<table width="100%" cellpadding="1" cellspacing="2">
			<tr>
				<td width="0" valign="baseline"><img src="admin/media/plus.gif" child="directory_{@id}" class="imgcmd" mode="plus"/></td>
				<td width="100%" valign="baseline"><a href="default.asp?ACT=1&amp;SECT=M22&amp;id={@id}&amp;cmd=dir" class="treeview"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:apply-templates select="@name"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></a></td>
			</tr>
			<tr id="directory_{@id}" class="child">
				<td>&#32;</td>
				<td>
					<xsl:apply-templates select="category" mode="list"><xsl:sort select="@name"/></xsl:apply-templates>
					<table width="100%" cellpadding="1" cellspacing="2">
						<tr>
							<td width="0" valign="baseline"><img src="admin/media/command.gif"/></td>
							<td width="100%" valign="baseline"><a href="default.asp?ACT=1&amp;SECT=M22&amp;id=new&amp;cmd=cat&amp;dir={@id}" class="command"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[488]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></a></td>
						</tr>
					</table>					
				</td>
			</tr>			
		</table>
	</xsl:template>
	
	
	<!-- Category nodes -->
	<xsl:template match="category" mode="list">
		<table width="100%" cellpadding="1" cellspacing="2">
			<tr>
				<td width="0" valign="baseline"><img src="admin/media/plus.gif" child="category_{@id}" class="imgcmd" mode="plus"/></td>
				<td width="100%" valign="baseline"><a href="default.asp?ACT=1&amp;SECT=M22&amp;id={@id}&amp;cmd=cat&amp;dir={ancestor::directory/@id}" class="treeview"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="concat(@name, ' ( on: ', count(.//item[@published='on']), ' off: ', count(.//item[@published='off']) , ')')"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></a></td>
			</tr>
			<tr id="category_{@id}" class="child">
				<td>&#32;</td>
				<td>
					<xsl:apply-templates select="category" mode="list"><xsl:sort select="@name"/></xsl:apply-templates>
					<xsl:apply-templates select="item" mode="list"><xsl:sort select="name"/></xsl:apply-templates>
					
					<table width="100%" cellpadding="1" cellspacing="2">
						<tr>
							<td width="0" valign="baseline"><img src="admin/media/command.gif"/></td>
							<td width="100%" valign="baseline"><a href="default.asp?ACT=1&amp;SECT=M22&amp;id=new&amp;cmd=cat&amp;dir={ancestor::directory/@id}&amp;cat={@id}" class="command"><xsl:value-of select="$string[488]"/></a></td>
						</tr>
						<tr>
							<td width="0" valign="baseline"><img src="admin/media/command.gif"/></td>
							<td width="100%" valign="baseline"><a href="default.asp?ACT=1&amp;SECT=M22&amp;id=new&amp;cmd=item&amp;dir={ancestor::directory/@id}&amp;cat={@id}" class="command"><xsl:value-of select="$string[490]"/></a></td>
						</tr>
					</table>
				</td>
			</tr>			
		</table>
	</xsl:template>
	
		
	<xsl:template match="item" mode="list">
		<table width="100%" cellpadding="1" cellspacing="2">
			<tr>
				<td width="0" valign="baseline"><img src="admin/media/item_{@published}.gif"/></td>
				<td width="100%" valign="baseline"><a href="default.asp?ACT=1&amp;SECT=M22&amp;id={@id}&amp;cmd=item&amp;dir={ancestor::directory/@id}&amp;cat={../@id}" class="treeview"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:apply-templates select="@name"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></a></td>
			</tr>
		</table>
	</xsl:template>
	
	
	<!-- ADD DIRECTORY FORM -->
	<xsl:template name="directory_add">
		<font size="4"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[491]"/></font>
		<table bgcolor="white"><form action="default.asp?ACT=1&amp;SECT=M22" method="post" name="frmFullxml"><tr><td>			
			<input type="hidden" name="xform" value="2"/>
			<input type="hidden" name="operation" value="add"/>
			<input type="hidden" name="file" value="directory"/>
			<input type="hidden" name="xpath" value="directories"/>
			<input type="hidden" name="node" value="directory"/>
				
			<table class="block">					
				<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[485]"/>:</td><td><input type="input" class="full" name="P_name"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[500]"/>:</td><td><textarea name="P_description"></textarea></td></tr>
				<tr>
					<td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[505]"/>:</td>
					<td>
						<select name="P_itemtype">
							<option value="user"><xsl:value-of select="$string[506]"/></option>
							<option value="download"><xsl:value-of select="$string[507]"/></option>
							<option value="link" selected="selected"><xsl:value-of select="$string[508]"/></option>
							<option value="cd"><xsl:value-of select="$string[509]"/></option>
							<option value="dvd"><xsl:value-of select="$string[510]"/></option>
							<option value="book"><xsl:value-of select="$string[511]"/></option>
							<option value="mp3"><xsl:value-of select="$string[512]"/></option>
							<option value="employee"><xsl:value-of select="$string[513]"/></option>
							<option value="product"><xsl:value-of select="$string[514]"/></option>
						</select>
					</td>
				</tr>
				<tr><td  class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[504]"/>: </td><td><select name="P_publicsubmit"><option value="on" selected="selected"><xsl:value-of select="$string[60]"/></option><option value="off"><xsl:value-of select="$string[61]"/></option></select></td></tr>
				
				<tr><td colspan="2"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr><td  class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[486]"/>: </td><td><select name="P_published"><option value="on" selected="selected"><xsl:value-of select="$string[60]"/></option><option value="off"><xsl:value-of select="$string[61]"/></option></select></td></tr>
				
				<tr>
					<td align="right" colspan="2">
						<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M22';"/>
					</td>
				</tr>
			</table>			
		</td></tr></form></table>
	</xsl:template>
	
	
	<!-- UPDATE DIRECTORY -->
	<xsl:template match="directory" mode="update">
		<font size="4"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[492]"/></font>
		<table bgcolor="white"><tr><td>			
			<table class="block">
				<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmFullxml">
				<input type="hidden" name="xform" value="2"/>
				<input type="hidden" name="operation" value="update"/>
				<input type="hidden" name="file" value="directory"/>
				<input type="hidden" name="node" value="directory"/>
				<input type="hidden" name="xpath" value="directories/directory[@id='{@id}']"/>
				
				<!--<input type="hidden" name="id" value="{@id}"/>-->
				
				<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[485]"/>:</td><td><input type="input" class="full" name="P_name" value="{@name}"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[500]"/>:</td><td><textarea name="P_description"><xsl:value-of select="@description"/></textarea></td></tr>
				<tr>
					<td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[505]"/>:</td>
					<td>
						<select name="P_itemtype">
							<option value="user">
								<xsl:if test="@itemtype='user'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
								<xsl:value-of select="$string[506]"/>
							</option>
							<option value="download"><xsl:if test="@itemtype='download'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[507]"/></option>
							<option value="link"><xsl:if test="@itemtype='link'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[508]"/></option>
							<option value="cd"><xsl:if test="@itemtype='cd'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[509]"/></option>
							<option value="dvd"><xsl:if test="@itemtype='dvd'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[510]"/></option>
							<option value="book"><xsl:if test="@itemtype='book'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[511]"/></option>
							<option value="mp3"><xsl:if test="@itemtype='mp3'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[512]"/></option>
							<option value="employee"><xsl:if test="@itemtype='employee'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[513]"/></option>
							<option value="product"><xsl:if test="@itemtype='product'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[514]"/></option>
						</select>
					</td>
				</tr>
				<tr><td  class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[504]"/>: </td><td><select name="P_publicsubmit"><option value="on"><xsl:if test="@publicsubmit='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[60]"/></option><option value="off"><xsl:if test="@publicsubmit='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[61]"/></option></select></td></tr>
				
				<tr><td colspan="2"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[486]"/>:</td><td><select name="P_published"><option value="on"><xsl:if test="@published='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> <xsl:value-of select="$string[60]"/></option><option value="off"><xsl:if test="@published='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[61]"/></option></select></td></tr>
				
				<tr>
					<td align="right" colspan="2">
						<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M19';"/>
					</td>
				</tr>
				</form></table>
			
			<table class="block">
				<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" onsubmit="return confirm('{$string[112]}');">
				<tr><td align="right" colspan="2">						
							<input type="hidden" name="xform" value="2"/>
							<input type="hidden" name="operation" value="delete"/>
							<input type="hidden" name="file" value="directory"/>
							<input type="hidden" name="xpath" value="directories/directory[@id='{@id}']"/>
							<input type="submit" value="{$string[16]}"/>
				</td></tr></form>
			</table>
		</td></tr></table>
	</xsl:template>
	
	
	<!-- ADD CATEGORY FORM -->
	<xsl:template name="dircategory_add">
		<font size="4"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[493]"/></font>
		<table bgcolor="white"><form action="default.asp?ACT=1&amp;SECT=M22" method="post"><tr><td>			
			<input type="hidden" name="xform" value="2"/>
			<input type="hidden" name="operation" value="add"/>
			<input type="hidden" name="file" value="directory"/>
			<input type="hidden" name="node" value="category"/>
				
			<xsl:choose>
				<xsl:when test="$cat">					
					<input type="hidden" name="xpath" value="directories/directory[@id='{$dir}']//category[@id='{$cat}']"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="xpath" value="directories/directory[@id='{$dir}']"/>
				</xsl:otherwise>
			</xsl:choose>
				
			<table class="block">					
				<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[485]"/>:</td><td><input type="input" class="full" name="P_name"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[500]"/>:</td><td><textarea name="P_description"></textarea></td></tr>
				
				
				<tr><td colspan="2"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr><td  class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[486]"/>: </td><td><select name="P_published"><option value="on" selected="selected"><xsl:value-of select="$string[60]"/></option><option value="off"><xsl:value-of select="$string[61]"/></option></select></td></tr>
				
				<tr>
					<td align="right" colspan="2">
						<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M22';"/>
					</td>
				</tr>
			</table>			
		</td></tr></form></table>
	</xsl:template>

	
	<!-- UPDATE CATEGORY -->
	<xsl:template match="category" mode="update">
		<font size="4"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[494]"/></font>
		<table bgcolor="white"><tr><td>			
			<table class="block">
				<form action="default.asp?ACT=1&amp;SECT={$section}" method="post">
				<input type="hidden" name="operation" value="update"/>
				<input type="hidden" name="file" value="directory"/>
				<input type="hidden" name="xform" value="2"/>
				<input type="hidden" name="node" value="category"/>
				<input type="hidden" name="xpath" value="directories/directory[@id='{$dir}']//category[@id='{@id}']"/>		
								
				<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[485]"/>:</td><td><input type="input" class="full" name="P_name" value="{@name}"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[500]"/>:</td><td><textarea name="P_description"><xsl:value-of select="@description"/></textarea></td></tr>
				
				<tr><td colspan="2"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[486]"/>:</td><td><select name="P_published"><option value="on"><xsl:if test="@published='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> <xsl:value-of select="$string[60]"/></option><option value="off"><xsl:if test="@published='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[61]"/></option></select></td></tr>
				
				<tr>
					<td align="right" colspan="2">
						<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M19';"/>
					</td>
				</tr>
				</form></table>
			
			<table class="block">
				<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" onsubmit="return confirm('{$string[112]}');">
				<tr><td align="right" colspan="2">
							<input type="hidden" name="xform" value="2"/>					
							<input type="hidden" name="operation" value="delete"/>
							<input type="hidden" name="file" value="directory"/>
							<input type="hidden" name="xpath" value="directories/directory[@id='{$dir}']//category[@id='{@id}']"/>
							<input type="submit" value="{$string[16]}"/>
				</td></tr></form>
			</table>
		</td></tr></table>
	</xsl:template>
		
		
	<!-- ADD ITEM FORM -->
	<xsl:template name="item_add">
		<font size="4"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[497]"/></font>
		<table bgcolor="white"><form action="default.asp?ACT=1&amp;SECT=M22" method="post" name="frmFullxml"><tr><td>			
			<input type="hidden" name="operation" value="add"/>
			<input type="hidden" name="xform" value="2"/>
			<input type="hidden" name="file" value="directory"/>
			<input type="hidden" name="xpath" value="directories/directory[@id='{$dir}']//category[@id='{$cat}']"/>
			<input type="hidden" name="node" value="item"/>
			<input type="hidden" name="P_count" value="0"/>
			<!--<input type="hidden" name="owner" value="$username"/>-->
								
			<table class="block">					
				<!-- LINK case -->
				<xsl:choose>
					<xsl:when test="document($directoryfile)//directories/directory[@id=$dir]/@itemtype='link'">
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[485]"/>:</td><td><input type="input" class="full" name="P_name"/></td></tr>
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[499]"/>:</td><td><textarea name="N_summary"></textarea></td></tr>
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[501]"/>:</td><td><input type="input" class="full" name="P_website"/></td></tr>
					</xsl:when>
					<xsl:when test="document($directoryfile)//directories/directory[@id=$dir]/@itemtype='download'">
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[351]"/>:</td><td><input class="full" name="P_name"/></td></tr>
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[364]"/>:</td><td><input class="full" name="P_version"/></td></tr>
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[352]"/>:</td><td><input class="full" name="P_website"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.P_website);"/></td></tr>
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[353]"/>:</td><td><input class="full" name="P_url"/></td></tr>
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[363]"/>:</td><td><input class="full" name="P_size"/></td></tr>			
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[356]"/>:</td><td><input class="full" name="P_price"/></td></tr>
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[541]"/>:</td><td><input class="full" name="P_shortdescription"/></td></tr>
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[354]"/>:</td><td><textarea  class="textarea" name="N_description" title="{$string[438]}"></textarea></td></tr>
					</xsl:when>
				</xsl:choose>
				
				<tr><td colspan="2"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr><td  class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[486]"/>: </td><td><select name="published"><option value="on" selected="selected"><xsl:value-of select="$string[60]"/></option><option value="off"><xsl:value-of select="$string[61]"/></option></select></td></tr>
				
				<tr>
					<td align="right" colspan="2">
						<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M22';"/>
					</td>
				</tr>
			</table>			
		</td></tr></form></table>
	</xsl:template>
	
	
	<!-- UPDATE ITEM -->
	<xsl:template match="item" mode="update">
		<font size="4"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[498]"/></font>
		<table bgcolor="white"><tr><td>			
			<table class="block">
				<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmFullxml">
				<input type="hidden" name="xform" value="2"/>
				<input type="hidden" name="operation" value="update"/>
				<input type="hidden" name="file" value="directory"/>
				<input type="hidden" name="node" value="directory"/>
				<input type="hidden" name="xpath" value="directories/directory[@id='{$dir}']//category[@id='{$cat}']/item[@id='{@id}']"/>		
				
				<!-- LINK case -->
				<xsl:choose>
					<xsl:when test="document($directoryfile)//directories/directory[@id=$dir]/@itemtype='link'">
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[485]"/>:</td><td><input type="input" class="full" name="P_name" value="{@name}"/></td></tr>
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[499]"/>:</td><td><textarea name="N_summary"><xsl:value-of select="concat(summary,@summary)"/></textarea></td></tr>
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[501]"/>:</td><td><input type="input" class="full" name="P_website" value="{@website}"/></td></tr>
					</xsl:when>
					<xsl:when test="document($directoryfile)//directories/directory[@id=$dir]/@itemtype='download'">
						<tr><td class="xp_sel"><b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[position()=351]"/>:</b></td><td><input class="full" name="P_name" value="{@name}"/></td></tr>
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[364]"/>:</td><td><input class="full" name="P_version" value="{@version}"/></td></tr>
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[352]"/>:</td><td><input class="full" name="P_website" value="{@website}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.P_website);"/></td></tr>
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[353]"/>:</td><td><input class="full" name="P_url" value="{@url}"/></td></tr>
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[363]"/>:</td><td><input class="full" name="P_size" value="{@size}"/></td></tr>
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[356]"/>:</td><td><input class="full" name="P_price" value="{@price}"/></td></tr>
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[541]"/>:</td><td><input class="full" name="P_shortdescription" value="{@shortdescription}"/></td></tr>
						<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[354]"/>:</td><td><textarea  class="textarea" name="N_description" title="{$string[438]}"><xsl:value-of select="description" disable-output-escaping="yes"/></textarea></td></tr>	
					</xsl:when>
					<xsl:otherwise>
						no form available - u cand send me the list of fields you want
					</xsl:otherwise>
				</xsl:choose>
								
				<tr><td colspan="2"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[486]"/>:</td><td><select name="published"><option value="on"><xsl:if test="@published='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> <xsl:value-of select="$string[60]"/></option><option value="off"><xsl:if test="@published='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[61]"/></option></select></td></tr>
					
				<tr>
					<td align="right" colspan="2">
						<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M19';"/>
					</td>
				</tr>
				</form></table>
			
			<table class="block">
				<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" onsubmit="return confirm('{$string[112]}');">
				<tr><td align="right" colspan="2">						
							<input type="hidden" name="xform" value="2"/>
							<input type="hidden" name="operation" value="delete"/>
							<input type="hidden" name="file" value="directory"/>
							<input type="hidden" name="xpath" value="directories/directory[@id='{$dir}']//category[@id='{$cat}']/item[@id='{@id}']"/>
							<input type="submit" value="{$string[16]}"/>
				</td></tr></form>
			</table>
		</td></tr></table>
	</xsl:template>
	
	
</xsl:stylesheet>