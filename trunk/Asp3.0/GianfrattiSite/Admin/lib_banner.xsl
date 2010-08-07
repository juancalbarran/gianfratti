<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve">
<xsl:output method="html" indent="no"/> 

<!-- Webpages Template : add/update/modify -->
<!-- last modified : 2001/10/26, by J.Roland -->
<!-- version 1.0 -->

	<xsl:template name="banner_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Banner manager</xsl:with-param>
			<xsl:with-param name="version">1.0</xsl:with-param>
			<xsl:with-param name="moddate">26.10.2001</xsl:with-param>
			<xsl:with-param name="author">John Roland</xsl:with-param>
			<xsl:with-param name="url">http://www.fullxml.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="banner_manager">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M19"><img src="admin/media/banners.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[345]"/></font></td></tr>
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
				//document.frmFullxml.image.value = u;
				fx_imgwin.close();
			}
		</script>

		
		<xsl:choose>
			<xsl:when test="$id=''">
				<xsl:call-template name="banner_list"/>
			</xsl:when>
			<xsl:when test="$id='new'">
				<xsl:call-template name="banner_add"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="document($bannerfile)//banners/banner[id=$id]">
					<xsl:call-template name="banner_update"/>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<xsl:template name="banner_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr>
				<td class="header" width="16"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td class="header" width="16">Id</td>
				<td class="header" width="80%"><xsl:value-of select="$string[341]"/></td>
				<td class="header"><xsl:value-of select="$string[342]"/></td></tr>			
			
			<xsl:for-each select="document($bannerfile)//banners/banner">
				<xsl:sort select="count" data-type="number" order="descending"/>						
				<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M19&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td><img src="admin/media/{visible}.gif" width="16" height="15"/></td>
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M19&amp;id={id}"><xsl:value-of select="name" disable-output-escaping="yes"/></a></td>
					<td class="data2"><xsl:value-of select="count" disable-output-escaping="yes"/></td></tr>
			</xsl:for-each>
			
			<tr><td colspan="4" align="right"><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M19&amp;id=new';" type="button" value="{$string[15]}"/></td></tr>
		</table>
	</xsl:template>


	<!-- addtip template  -->
	<xsl:template name="banner_add">
		
		<table bgcolor="white"><form action="default.asp?ACT=1&amp;SECT=M19" method="post" name="frmFullxml"><tr><td>
			
			<input type="hidden" name="operation" value="add"/>
			<input type="hidden" name="file" value="banner"/>
			<input type="hidden" name="bloc" value="banners"/>
			<input type="hidden" name="node" value="banner"/>
								
			<input type="hidden" name="count" value="0"/>
				
			<table class="block">					
				<tr><td class="xp_sel"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[341]"/>:</td><td><input type="input" class="full" name="name"/></td></tr>
				
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[344]"/>:</td><td><input type="input" class="full" name="gifsrc"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.gifsrc);"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[343]"/>:</td><td><input type="input" class="full" name="onclickurl"/></td></tr>
				
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[554]"/>:</td><td><textarea name="richmedia"></textarea></td></tr>
				
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr><td  class="xp_sel"><xsl:value-of select="$string[166]"/>:</td><td><input type="input" class="mini" name="width" value=""/></td></tr>
				<tr><td  class="xp_sel"><xsl:value-of select="$string[167]"/>:</td><td><input type="input" class="mini" name="height" value=""/></td></tr>
				
				<tr>
					<td  class="xp_sel"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[433]"/>:</td>
					<td>
						<select name="position">
							<option value="top"><xsl:value-of select="$string[434]"/></option>
							<option value="bottom"><xsl:value-of select="$string[435]"/></option>
							<option value="left"><xsl:value-of select="$string[436]"/></option>
							<option value="right"><xsl:value-of select="$string[437]"/></option>						
						</select>
					</td>
				</tr>
				
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr><td  class="xp_sel"><xsl:value-of select="$string[334]"/>:</td><td><select name="visible"><option value="off" selected="selected">not visible</option><option value="on"> visible</option></select></td></tr>

<!-- Othon Start-->
				<tr><td class="xp_sel"><xsl:value-of select="$string[63]"/>:</td><td><input type="text" name="publicationdate" id="publicationdate" value="{substring($actualdate,1,8)}" onClick="cal.select(this, 'publicationdate', 'yyyyMMdd');"  maxlength="8" class="mini"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><small>yyyymmdd</small></td></tr>
				<tr><td  class="xp_sel"><xsl:value-of select="$string[64]"/>:</td><td><input type="text" name="expirationdate" id="expirationdate" onClick="cal.select(this, 'expirationdate', 'yyyyMMdd');"  maxlength="8" class="mini"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><small>yyyymmdd</small></td></tr>
<!--Othon End -->				
				<tr>
					<td align="right" colspan="2">
						<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M19';"/>
					</td>
				</tr>
			</table>			
		</td></tr>



</form></table>
	</xsl:template>
		
		
	<!-- Banner update template  -->
	<xsl:template name="banner_update">
	
		<table bgcolor="white"><tr><td>			
			<table class="block">
				<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmFullxml">
				<input type="hidden" name="operation" value="update"/>
				<input type="hidden" name="file" value="banner"/>
				<input type="hidden" name="node" value="banners/banner[id={id}]"/>				
				<input type="hidden" name="count" value="{count}"/>
				
				<tr><td class="xp_sel"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[341]"/>:</td><td><input type="input" class="full" name="name" value="{name}"/></td></tr>
				
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[344]"/>:</td><td><input type="input" class="full" name="gifsrc" value="{gifsrc}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.gifsrc);"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[343]"/>:</td><td><input type="input" class="full" name="onclickurl" value="{onclickurl}"/></td></tr>
				
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[554]"/>:</td><td><textarea name="richmedia"><xsl:value-of select="richmedia"/></textarea></td></tr>
				
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[342]"/>:</td><td><xsl:value-of select="count"/></td></tr>
				
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[166]"/>:</td><td><input type="input" class="mini" name="width" value="{width}"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[167]"/>:</td><td><input type="input" class="mini" name="height" value="{height}"/></td></tr>
				<tr>
					<td class="xp_sel"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[433]"/>:</td>
					<td>
						<select name="position">
							<option value="top"><xsl:if test="position='top'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[434]"/></option>
							<option value="bottom"><xsl:if test="position='bottom'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[435]"/></option>
							<option value="left"><xsl:if test="position='left'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[436]"/></option>
							<option value="right"><xsl:if test="position='right'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[437]"/></option>						
						</select>
					</td>
				</tr>
				
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[56]"/>:</td><td><select name="visible"><option value="off"><xsl:if test="visible='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>not visible</option><option value="on"><xsl:if test="visible='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> visible</option></select></td></tr>
<!-- Othon Start -->

<tr>
					<td class="xp_sel"><xsl:value-of select="$string[63]"/>:</td><td ><input type="text" name="publicationdate" id="publicationdate" value="{publicationdate}" onClick="cal.select(this, 'publicationdate', 'yyyyMMdd');"  maxlength="8" class="mini"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><small>yyyymmdd</small><!--<input type="button" value="{$string[63]}" style="width: 150px" onClick="getCalendarFor(document.frmadm.publicationdate)"/>--></td>
				</tr>
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[64]"/>:</td><td><input type="text" name="expirationdate" id="expirationdate" value="{expirationdate}" onClick="cal.select(this, 'expirationdate', 'yyyyMMdd');"  maxlength="8" class="mini"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><small>yyyymmdd</small><!--<input type="button" value="{$string[64]}" style="width: 150px" onClick="getCalendarFor(document.frmadm.expirationdate)"/>--></td>
				</tr>
<!-- Othon End -->				
				<tr>
					<td align="right" colspan="2">
						<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M19';"/>
					</td>
				</tr>
				</form></table>
			
			<table class="block">
				<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" onsubmit="return confirm('{$string[112]}');">
				<tr><td align="right" colspan="2">						
							<input type="hidden" name="operation" value="delete"/>
							<input type="hidden" name="file" value="banner"/>
							<input type="hidden" name="node" value="banners/banner[id={id}]"/>
							<input type="submit" value="{$string[16]}"/>
				</td></tr></form>
			</table>
			
		</td></tr></table>
	</xsl:template>
	
</xsl:stylesheet>