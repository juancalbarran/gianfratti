<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- edited with XMLSPY v2004 rel. 2 U (http://www.xmlspy.com) by Flemming Aunel (Ama'r Web) -->
<!-- edited by Flemming Aunel (Ama'r Web) -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve">
	<xsl:output method="html"/>
	<!-- Webpages Template : add/update/modify -->
	<!-- last modified : 2002/05/22, by J.Roland -->
	<!-- modified : 2003/10/10, by F.Aunel-->
	<!-- version 1.2-->

	<xsl:template name="skin_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Skin Studio</xsl:with-param>
			<xsl:with-param name="version">1.2</xsl:with-param>
			<xsl:with-param name="moddate">10.10.2003</xsl:with-param>
			<xsl:with-param name="author">F. Aunel</xsl:with-param>
			<xsl:with-param name="url">http://www.fullxml.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:variable name="current_skin_name" select=" /siteinfo/data/xslskin"/>
	<xsl:variable name="current_skinstudio_path" select="$skinsnode/xslskins/xslskin[@name=$current_skin_name]/@path"/>
	<xsl:variable name="current_skin_id" select="document($skinstudiofile)//skinstudio/skin_settings[skin=$current_skin_name]/id"/>

	<xsl:template name="skinstudio_manager">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr>
				<td width="60">
					<a href="default.asp?ACT=1&amp;SECT=M23">
						<img src="admin/media/skinstudio.gif" border="0"/>
					</a>
				</td>
				<td>
					<font size="6">
						<xsl:value-of select="$string[601]"/>
					</font>
				</td>
			</tr>
		</table>
		<xsl:choose>
			<xsl:when test="document($skinstudiofile)//skinstudio/skin_settings[skin=$current_skin_name]">
				<xsl:for-each select="document($skinstudiofile)//skinstudio/skin_settings[skin=$current_skin_name]">
					<xsl:call-template name="skinstudio_update"/>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="skinstudio_add"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- List of skin settings -->
	<xsl:template name="skinstudio_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">
			<tr>
				<td class="header" width="16">Id</td>
				<td class="header">
					<xsl:value-of select="$string[603]"/>
				</td>
				<td class="header">
					<xsl:value-of select="$string[604]"/>
				</td>
				<td class="header">
					<xsl:value-of select="$string[605]"/>
				</td>
			</tr>
			<xsl:for-each select="document($skinstudiofile)//skinstudio/skin_settings[skin = $current_skin_name]">
				<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M23&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td class="data2">
						<xsl:value-of select="id"/>
					</td>
					<td class="data2">
						<a href="default.asp?ACT=1&amp;SECT=M23&amp;id={id}">
							<xsl:value-of select="name"/>
						</a>
					</td>
					<td class="data2">
						<xsl:value-of select="skin"/>
					</td>
					<td class="data2">
						<xsl:value-of select="author"/>
					</td>
				</tr>
			</xsl:for-each>
			<tr>
				<td colspan="4" align="right">
					<input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M23&amp;id=new';" type="button" value="{$string[15]}"/>
				</td>
			</tr>
		</table>
	</xsl:template>

	<!-- Form to insert a new skin settings -->
	<xsl:template name="skinstudio_add">
		<SCRIPT LANGUAGE="JavaScript">
			var cp = new ColorPicker('window');
			
			// Runs when a color is clicked
			function pickColor(color) {
				field.value = color;
				field.style.background = color;
				}
			var field;
			
			function pickcolor(anchorname, elementname) {
				field = document.forms["frmFullxml"].elements[elementname];
				cp.show(anchorname);
				}		
		</SCRIPT>
		<SCRIPT LANGUAGE="JavaScript">	
			var fp = new FontPicker('window');
			// Runs when a font is clicked
			function pickFont(font) {
				field.value = font;
				field.style.font.style = font;
				}
			var field;
			
			function pickfont(anchorname, elementname) {
				field = document.forms["frmFullxml"].elements[elementname];
				fp.show(anchorname);
				}			
		</SCRIPT>
		<table bgcolor="white">
			<form action="default.asp?ACT=1&amp;SECT=M23" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="skin"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="bloc" value="skinstudio"/>
						<input type="hidden" name="node" value="skin_settings"/>
						<input type="hidden" name="skin" value="{$current_skin_name}"/>
						<table class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[603]"/>:</td>
								<td>
									<input type="text" name="name" value=""/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[605]"/>:</td>
								<td>
									<input type="text" name="author" value=""/>
								</td>
							</tr>
						</table>
						<xsl:apply-templates select="document($current_skinstudio_path)//tab" mode="insert"/>
						<table class="block">
							<tr>
								<td align="right" colspan="2">
									<input type="submit" value="{$string[18]}"/>
									<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M23';"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>

	<xsl:template match="tab" mode="insert">
		<font size="3" color="red">
			<b>
				<xsl:value-of select="@name"/>
			</b>
		</font>
		<table class="block">
			<xsl:apply-templates select="param" mode="skinstudio_add"/>
		</table>
		<p/>
	</xsl:template>

	<xsl:template match="param[@type = 'font']" mode="skinstudio_add">
		<tr>
			<td class="xp_sel">
				<xsl:value-of select="@description"/>:</td>
			<td>
				<input type="text" name="{@name}" value="{@default}"/>
				<img src="Admin/media/font_sel.gif" id="font1" name="font1" alt="Pick font" onclick="pickfont('font1', '{@name}');return false;" onmouseover="this.style.cursor='hand'" onmouseout=""/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="param[@type = 'number']" mode="skinstudio_add">
		<tr>
			<td class="xp_sel">
				<xsl:value-of select="@description"/>:</td>
			<td>
				<input type="text" name="{@name}" value="{@default}"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="param[@type = 'valign']" mode="skinstudio_add">
		<xsl:variable name="param_name" select="@name"/>
		<xsl:variable name="select_name" select="@default"/>
		<tr>
			<td class="xp_sel">
				<xsl:value-of select="@description"/>
				:</td>
			<td>
				<select name="{@name}" style="width: 150px;">
					<option value="left">	<xsl:if test="$select_name = 'left'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="'left'"/></option>
					<option value="center"><xsl:if test="$select_name = 'center'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="'center'"/></option>
					<option value="right"><xsl:if test="$select_name = 'right'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="'right'"/></option>
			<!--		<option value="justify"><xsl:if test="$select_name = 'justify'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="'justify'"/></option> -->
				</select>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="param[@type = 'align']" mode="skinstudio_add">
		<xsl:variable name="param_name" select="@name"/>
		<xsl:variable name="select_name" select="@default"/>
		<tr>
			<td class="xp_sel">
				<xsl:value-of select="@description"/>
				:</td>
			<td>
				<select name="{@name}" style="width: 150px;">
					<option value="top">	<xsl:if test="$select_name = 'top'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="'top'"/></option>
					<option value="middle"><xsl:if test="$select_name = 'middle'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="'middle'"/></option>
					<option value="bottom"><xsl:if test="$select_name = 'bottom'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="'bottom'"/></option>
				</select>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="param[@type = 'color']" mode="skinstudio_add">
		<tr>
			<td class="xp_sel">
				<xsl:value-of select="@description"/>
			</td>
			<td>
				<input type="text" name="{@name}" value="{@default}" id="{@name}"/>
				<img src="admin/media/bgcolor.gif" id="pick1" name="pick1" alt="Pick color" onclick="pickcolor('pick1', '{@name}');return false;" onmouseover="this.style.cursor='hand'" onmouseout=""/>
			</td>
		</tr>
	</xsl:template>

	<!-- Form to update a skin settings -->
	<xsl:template name="skinstudio_update">
		<SCRIPT LANGUAGE="JavaScript">
			var cp = new ColorPicker('window');
			
			// Runs when a color is clicked
			function pickColor(color) {
				field.value = color;
				field.style.background = color;
				}
			var field;
			
			function pickcolor(anchorname, elementname) {
				field = document.forms["frmFullxml"].elements[elementname];
				cp.show(anchorname);
				}
		</SCRIPT>
		<SCRIPT LANGUAGE="JavaScript">	

			var fp = new FontPicker('window');
			// Runs when a font is clicked
			function pickFont(font) {
				field.value = font;
				field.style.font.style = font;
				}
			var field;
			
			function pickfont(anchorname, elementname) {
				field = document.forms["frmFullxml"].elements[elementname];
				fp.show(anchorname);
				}			
		</SCRIPT>
		<table bgcolor="white">
			<form action="default.asp?ACT=1&amp;SECT=M23&amp;id={id}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="skin"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="skinstudio/skin_settings[id={id}]"/>
						<input type="hidden" name="skin" value="{$current_skin_name}"/>
						<table class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[603]"/>:</td>
								<td>
									<input type="text" name="name" value="{name}"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[605]"/>:</td>
								<td>
									<input type="text" name="author" value="{author}"/>
								</td>
							</tr>
						</table>
						<xsl:apply-templates select="document($current_skinstudio_path)//tab" mode="update"/>
						<table class="block">
							<tr>
								<td align="right" colspan="2">
									<input type="submit" value="{$string[18]}"/>
									<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M23';"/>
								</td>
							</tr>
							<a target="_blank"><xsl:attribute name="href">default.asp?preview=1&amp;<xsl:for-each select="document($skinstudiofile)//skinstudio/skin_settings[id=$current_skin_id]/child::*[name()!='id']"><xsl:value-of select="name()"/>=<xsl:value-of select="."/>&amp;</xsl:for-each></xsl:attribute>
					preview
				</a>
						</table>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>

	<xsl:template match="tab" mode="update">
		<font size="3" color="red">
			<b>
				<xsl:value-of select="@name"/>
			</b>
		</font>
		<table class="block">
			<xsl:apply-templates select="param" mode="skinstudio_update"/>
		</table>
		<p/>
	</xsl:template>

	<xsl:template match="param[@type = 'font']" mode="skinstudio_update">
		<xsl:variable name="param_name" select="@name"/>
		<tr>
			<td class="xp_sel">
				<xsl:value-of select="@description"/>:</td>
			<td>
				<input type="text" name="{@name}" value="{document($skinstudiofile)//skinstudio/skin_settings[id=$current_skin_id]/child::*[name() = $param_name]}"/>
				<img src="Admin/media/font_sel.gif" id="font1" name="font1" alt="Pick font" onclick="pickfont('font1', '{@name}');return false;" onmouseover="this.style.cursor='hand'" onmouseout=""/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="param[@type = 'number']" mode="skinstudio_update">
		<xsl:variable name="param_name" select="@name"/>
		<tr>
			<td class="xp_sel">
				<xsl:value-of select="@description"/>:</td>
			<td>
				<input type="text" name="{@name}" value="{document($skinstudiofile)//skinstudio/skin_settings[id=$current_skin_id]/child::*[name() = $param_name]}"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="param[@type = 'valign']" mode="skinstudio_update">
		<xsl:variable name="param_name" select="@name"/>
		<xsl:variable name="select_name" select="document($skinstudiofile)//skinstudio/skin_settings[id=$current_skin_id]/child::*[name() = $param_name]"/>
		<tr>
			<td class="xp_sel">
				<xsl:value-of select="@description"/>
				:</td>
			<td>
				<select name="{@name}" style="width: 150px;">
					<option value="left">	<xsl:if test="$select_name = 'left'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="'left'"/></option>
					<option value="center"><xsl:if test="$select_name = 'center'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="'center'"/></option>
					<option value="right"><xsl:if test="$select_name = 'right'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="'right'"/></option>
				<!--	<option value="justify"><xsl:if test="$select_name = 'justify'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="'justify'"/></option> -->
				</select>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="param[@type = 'align']" mode="skinstudio_update">
		<xsl:variable name="param_name" select="@name"/>
		<xsl:variable name="select_name" select="document($skinstudiofile)//skinstudio/skin_settings[id=$current_skin_id]/child::*[name() = $param_name]"/>
		<tr>
			<td class="xp_sel">
				<xsl:value-of select="@description"/>
				:</td>
			<td>
				<select name="{@name}" style="width: 150px;">
					<option value="top">	<xsl:if test="$select_name = 'top'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="'top'"/></option>
					<option value="middle"><xsl:if test="$select_name = 'middle'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="'middle'"/></option>
					<option value="bottom"><xsl:if test="$select_name = 'bottom'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="'bottom'"/></option>
					<option value="topbottom"><xsl:if test="$select_name = 'topbottom'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="'top and bottom'"/></option>
				</select>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="param[@type = 'color']" mode="skinstudio_update">
		<xsl:variable name="param_name" select="@name"/>
		<tr>
			<td class="xp_sel">
				<xsl:value-of select="@description"/>
			</td>
			<td>
				<input type="text" name="{@name}" value="{document($skinstudiofile)//skinstudio/skin_settings[id=$current_skin_id]/child::*[name() = $param_name]}" id="{@name}" style="background: {document($skinstudiofile)//skinstudio/skin_settings[id=$current_skin_id]/child::*[name() = $param_name]}"/>
				<img src="Admin/media/bgcolor.gif" id="pick1" name="pick1" alt="Pick color" onclick="pickcolor('pick1', '{@name}');return false;" onmouseover="this.style.cursor='hand'" onmouseout=""/>
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
