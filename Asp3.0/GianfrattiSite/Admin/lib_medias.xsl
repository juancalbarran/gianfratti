<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve">
<xsl:output method="html"/> 

<!-- Content Template : add/update/modify -->
<!-- last modified : 2001/10/26, by J.Roland -->
<!-- version 1.0 -->

	<xsl:template name="media_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Media Manager</xsl:with-param>
			<xsl:with-param name="version">1.0</xsl:with-param>
			<xsl:with-param name="moddate">26.10.2001</xsl:with-param>
			<xsl:with-param name="author">John Roland</xsl:with-param>
			<xsl:with-param name="url">http://www.fullxml.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="media_manager">
		<!-- global title -->
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M6"><img src="admin/media/media.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[position()=161]"/></font></td></tr>
		</table>
				
		<xsl:choose>
			<xsl:when test="$id=''">
				<xsl:call-template name="media_list"/>							
			</xsl:when>
			<xsl:when test="$id='new'">
				<xsl:call-template name="media_add"/>							
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="siteinfo/medias/media[id=$id]"><xsl:call-template name="media_update"/></xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>
	
	
	<!-- media library list -->
	<xsl:template name="media_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr>
				<td class="header" width="50">Id</td>
				<td class="header"><xsl:value-of select="$string[position()=162]"/></td>
				<td class="header"><xsl:value-of select="$string[position()=163]"/></td>
				<td class="header"><xsl:value-of select="$string[position()=164]"/></td>
			</tr>			
			
			<xsl:for-each select="document($mediafile)//media/media">								
				<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M4&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2"><xsl:value-of select="pseudo"/></td>
					<td class="data2"><xsl:value-of select="password"/></td>
					<td class="data2"><xsl:value-of select="email"/></td>					
				</tr>
			</xsl:for-each>								
			
			<tr><td colspan="6" align="right"><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M4&amp;id=new';" type="button" value="{$string[position()=15]}"/></td></tr>
		</table>
	</xsl:template>
	
	
	<!-- add media form -->
	<xsl:template name="media_add">
		<table style="width: 100%; background: buttonface; border: 4px solid appworkspace;" cellpadding="0" cellspacing="0" border="0">
		
			<form action="default.asp?ACT=1&amp;SECT=M8" method="post">
				<input type="hidden" name="operation" value="add"/>
				<input type="hidden" name="file" value="media"/>
				<input type="hidden" name="bloc" value="medias"/>
				<input type="hidden" name="node" value="media"/>
										
					<tr><td width="150"><b><xsl:value-of select="$string[position()=162]"/> :</b></td><td><input type="text" value="" name="titre" class="full"/></td></tr>							
					<tr>
						<td><xsl:value-of select="$string[position()=163]"/>:</td>
						<td>
							<select name="type">
								<option value="{$string[position()=168]}"><xsl:value-of select="$string[position()=168]"/></option>
								<option value="{$string[position()=169]}"><xsl:value-of select="$string[position()=169]"/></option>
								<option value="{$string[position()=170]}"><xsl:value-of select="$string[position()=170]"/></option>
								<option value="{$string[position()=171]}"><xsl:value-of select="$string[position()=171]"/></option>
								<option value="{$string[position()=172]}"><xsl:value-of select="$string[position()=172]"/></option>
								<option value="{$string[position()=173]}"><xsl:value-of select="$string[position()=173]"/></option>
								<option value="{$string[position()=174]}"><xsl:value-of select="$string[position()=174]"/></option>
								<option value="{$string[position()=175]}"><xsl:value-of select="$string[position()=175]"/></option>
								<option value="{$string[position()=176]}"><xsl:value-of select="$string[position()=176]"/></option>
							</select></td></tr>							
					<tr><td><b><xsl:value-of select="$string[position()=166]"/> :</b></td><td><input type="text" value="" name="width" class="full"/></td></tr>							
					<tr><td><b><xsl:value-of select="$string[position()=167]"/> :</b></td><td><input type="text" value="" name="height" class="full"/></td></tr>							
					<tr><td><b><xsl:value-of select="$string[position()=164]"/> :</b></td><td><input type="file" value="" name="path" class="full"/></td></tr>							
					<tr><td><b><xsl:value-of select="$string[position()=165]"/> :</b></td>
						<td>
							<textarea name="commentaire" class="textarea"></textarea>
							<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('commentaire');</script></xsl:if>
						</td>
					</tr>
					
					<tr>
						<td colspan="2" align="right">
							<input type="submit" value="{$string[position()=18]}"/>
							<input type="button" value="{$string[position()=19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M8'"/>
						</td>
					</tr>
			</form>
		</table>
	</xsl:template>
	
	<xsl:template name="media_update">
	</xsl:template>
	
	
</xsl:stylesheet>