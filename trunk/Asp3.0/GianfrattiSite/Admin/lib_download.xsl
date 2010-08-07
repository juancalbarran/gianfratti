<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve">
<xsl:output method="html"/> 

<!-- Webpages Template : add/update/modify -->
<!-- last modified : 2001/10/26, by J.Roland -->
<!-- version 1.0 -->

	<xsl:template name="download_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Download manager</xsl:with-param>
			<xsl:with-param name="version">1.0</xsl:with-param>
			<xsl:with-param name="moddate">07.11.2003</xsl:with-param>
			<xsl:with-param name="author">John Roland</xsl:with-param>
			<xsl:with-param name="url">http://www.fullxml.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="download_manager">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M20"><img src="admin/media/downloads.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[position()=358]"/></font></td></tr>
		</table>
		
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
			<xsl:when test="$id=''">
				<xsl:call-template name="download_list"/>
			</xsl:when>
			<xsl:when test="$id='new'">
				<xsl:call-template name="download_add"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="document($downloadfile)/downloads/download[id=$id]">
					<xsl:call-template name="download_update"/>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<xsl:template name="download_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr>
				<td class="header" width="50">Id</td>
				<td class="header"><xsl:value-of select="$string[position()=351]"/></td>
				<td class="header"><xsl:value-of select="$string[position()=360]"/></td></tr>			
			
			<xsl:for-each select="document($downloadfile)/downloads/download">								
				<xsl:sort select="publicationdate" order="descending"/>
				<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M20&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td><xsl:value-of select="id"/></td>
					<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M20&amp;id={id}"><xsl:value-of select="name" disable-output-escaping="yes"/></a></td>
					<td class="data2"><xsl:value-of select="count" disable-output-escaping="yes"/></td></tr>
			</xsl:for-each>								
			
			<tr><td colspan="3" align="right"><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M20&amp;id=new';" type="button" value="{$string[position()=15]}"/></td></tr>
		</table>
	</xsl:template>


	<!-- addtip template  -->
	<xsl:template name="download_add">
		<table bgcolor="white"><form action="default.asp?ACT=1&amp;SECT=M20" method="post" name="frmFullxml"><tr><td>
			
			<input type="hidden" name="operation" value="add"/>
			<input type="hidden" name="file" value="download"/>
			<input type="hidden" name="bloc" value="downloads"/>
			<input type="hidden" name="node" value="download"/>
										
			<input type="hidden" name="count" value="0"/>
			
			<table class="block">			
				<tr><td class="xp_sel"><xsl:value-of select="$string[351]"/>:</td><td><input class="full" name="name"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[364]"/>:</td><td><input class="full" name="version"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[352]"/>:</td><td><input class="full" name="path"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.path);"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[353]"/>:</td><td><input class="full" name="url"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[363]"/>:</td><td><input class="full" name="size"/></td></tr>			
				<tr><td class="xp_sel"><xsl:value-of select="$string[356]"/>:</td><td><input class="full" name="price"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[354]"/>:</td>
					<td>
						<textarea  class="textarea" name="description" title="{$string[438]}"></textarea>
						<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('description');</script></xsl:if>
					</td>
				</tr>
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[59]"/>:</td>
					<td>
						<select name="visible">
							<option value="off" selected="selected"><xsl:value-of select="$string[61]"/></option>
							<option value="on"><xsl:value-of select="$string[60]"/></option>
						</select>
						<input type="text" name="publicationdate" id="publicationdate" value="{substring($actualdate,1,8)}" onClick="cal.select(this, 'publicationdate', 'yyyyMMdd');"/>
				</td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[333]"/>:</td><td><select name="member"><option value="off" selected="selected"> Anonymous</option><option value="on"> Members only</option></select></td></tr>			
				<tr>
					<td align="right" colspan="2">
						<input type="submit" value="{$string[position()=18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[position()=19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M20';"/>
					</td>
				</tr>
			</table>
		</td></tr></form></table>
	</xsl:template>
		
		
	<!-- configtip template  -->
	<xsl:template name="download_update">
	
		<table bgcolor="white"><tr><td>
			
			<table class="block">
				<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmFullxml">
				<input type="hidden" name="operation" value="update"/>
				<input type="hidden" name="file" value="download"/>
				<input type="hidden" name="node" value="downloads/download[id={id}]"/>
							
				<tr><td class="xp_sel"><xsl:value-of select="$string[position()=351]"/>:</td><td><input class="full" name="name" value="{name}"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[364]"/>:</td><td><input class="full" name="version" value="{version}"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[position()=352]"/>:</td><td><input class="full" name="path" value="{path}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.path);"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[position()=353]"/>:</td><td><input class="full" name="url" value="{url}"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[363]"/>:</td><td><input class="full" name="size" value="{size}"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[position()=356]"/>:</td><td><input class="full" name="price" value="{price}"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[position()=354]"/>:</td>
					<td>
						<textarea  class="textarea" name="description" title="{$string[438]}"><xsl:value-of select="description" disable-output-escaping="yes"/></textarea>
						<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('description');</script></xsl:if>
					</td>
				</tr>
				
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[59]"/>:</td>
					<td>
						<select name="visible">
						<option value="off"><xsl:if test="visible='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[61]"/></option>
						<option value="on"><xsl:if test="visible='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[60]"/></option>
						</select>
						<input type="text" name="publicationdate" id="publicationdate" value="{publicationdate}" onClick="cal.select(this, 'publicationdate', 'yyyyMMdd');"/>
					</td>
				</tr>		
				<tr><td class="xp_sel"><xsl:value-of select="$string[333]"/>:</td><td><select name="member"><option value="off"><xsl:if test="member='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>anonymous</option><option value="on"><xsl:if test="member='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> Members only</option></select></td></tr>
				<tr>
					<td align="right" colspan="2">
						<input type="submit" value="{$string[position()=18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[position()=19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M20';"/>
					</td>			
				</tr>
				</form></table>
				
			<table class="block">
			<tr>				
			<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" onsubmit="return confirm('{$string[359]}');">
			<td align="right" colspan="2">					
					<input type="hidden" name="operation" value="delete"/>
					<input type="hidden" name="file" value="download"/>
					<input type="hidden" name="node" value="downloads/download[id={id}]"/>
					<input type="submit" value="{$string[position()=16]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>					
			</td></form></tr></table>
			
		</td></tr></table>
	</xsl:template>
	
</xsl:stylesheet>