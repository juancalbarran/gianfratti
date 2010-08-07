<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb">
	<xsl:output method="html"/> 	


	<xsl:template name="version_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Version Manager</xsl:with-param>
			<xsl:with-param name="version">0.1</xsl:with-param>
			<xsl:with-param name="moddate">16.08.2003</xsl:with-param>
			<xsl:with-param name="author">JeS (Jens Schreiber)</xsl:with-param>
			<xsl:with-param name="url">http://www.fxmods.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--         navigator at the top         -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="version_navigator">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr>
				<td align="left" valign="center" width="50">
						<img src="admin/media/info.gif" border="0"/>						
				</td>
				<td align="left" valign="center">
					<font size="6"><b><xsl:value-of select="$string[$vmbasestring + 0]" /></b></font>
				</td>
			</tr>
		</table>
	</xsl:template>
	
	<xsl:template name="version_output">
		<xsl:param name="name"/>
		<xsl:param name="version"/>
		<xsl:param name="moddate"/>
		<xsl:param name="author"/>
		<xsl:param name="url"/>
		
		<tr bgcolor="white" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
			<td class="data2">
				<xsl:value-of select="$name"/>
			</td>
			<td class="data2">
				<xsl:value-of select="$version"/>
			</td>
			<td class="data2">
				<xsl:value-of select="$moddate"/>
			</td>
			<td class="data2">
				<xsl:value-of select="$author"/>
			</td>
			<td class="data2">
				<xsl:if test="string-length($url) &gt; 0">
					<a href="{$url}"><xsl:value-of select="$url"/></a>
				</xsl:if>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template name="version_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">
			<tr>
				<td class="header">
					<xsl:value-of select="$string[$vmbasestring + 1]"/>
				</td>
				<td class="header">
					<xsl:value-of select="$string[$vmbasestring + 2]"/>
				</td>
				<td class="header">
					<xsl:value-of select="$string[$vmbasestring + 3]"/>
				</td>
				<td class="header">
					<xsl:value-of select="$string[$vmbasestring + 4]"/>
				</td>
				<td class="header">
					<xsl:value-of select="$string[$vmbasestring + 5]"/>
				</td>
			</tr>
			<xsl:call-template name="version_callmodules"/>
		</table>
	</xsl:template>

	<xsl:template name="version_callmodules">
		<xsl:call-template name="banner_modulinfo"/>
		<xsl:call-template name="category_modulinfo"/>
		<xsl:call-template name="calendar_modulinfo"/>
		<xsl:call-template name="chat_modulinfo"/>		
		<xsl:call-template name="content_modulinfo"/>
		<xsl:call-template name="desktop_modulinfo"/>
		<xsl:call-template name="directory_modulinfo"/>
		<xsl:call-template name="download_modulinfo"/>
		<xsl:call-template name="editor_modulinfo"/>
		<xsl:call-template name="photo_modulinfo"/>
		<xsl:call-template name="guestbook_modulinfo"/>
		<xsl:call-template name="help_modulinfo"/>
		<xsl:call-template name="knowbase_modulinfo"/>		
		<xsl:call-template name="list_modulinfo"/>
		<!--<xsl:call-template name="media_modulinfo"/>-->
		<xsl:call-template name="message_modulinfo"/>
		<xsl:call-template name="newsgroup_modulinfo"/>
		<xsl:call-template name="newsletter_modulinfo"/>		
		<xsl:call-template name="poll_modulinfo"/>
		<xsl:call-template name="reaction_modulinfo"/>
		<xsl:call-template name="skin_modulinfo"/>
		<xsl:call-template name="statistic_modulinfo"/>
		<xsl:call-template name="tip_modulinfo"/>
		<xsl:call-template name="upload_modulinfo"/>
		<xsl:call-template name="user_modulinfo"/>		
		<xsl:call-template name="version_modulinfo"/>
		<xsl:call-template name="pages_modulinfo"/>
		<xsl:call-template name="website_modulinfo"/>
		<xsl:call-template name="classified_modulinfo"/>
		<xsl:call-template name="langedit_modulinfo"/>
	</xsl:template>

	<xsl:template name="version_manager">
		<xsl:call-template name = "version_navigator" />
		<xsl:call-template name = "version_list" />
	</xsl:template>
	
</xsl:stylesheet>