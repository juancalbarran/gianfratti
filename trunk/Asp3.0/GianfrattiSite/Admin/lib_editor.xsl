<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb">
	<xsl:output method="html"/> 	

	<xsl:template name="editor_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Editor Manager</xsl:with-param>
			<xsl:with-param name="version">0.2</xsl:with-param>
			<xsl:with-param name="moddate">07.11.2003</xsl:with-param>
			<xsl:with-param name="author">JeS (Jens Schreiber)</xsl:with-param>
			<xsl:with-param name="url"><a href="http://www.fxmods.com">http://www.fxmods.com</a></xsl:with-param>			
		</xsl:call-template>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--         navigator at the top         -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="editor_navigator">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr>
				<td align="left" valign="center" width="50">
						<img src="admin/media/editor.gif" border="0"/>						
				</td>
				<td align="left" valign="center">
					<font size="6"><b><xsl:value-of select="$string[$edbasestring + 0]" /></b></font>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="editor_settinglist">		
		<xsl:choose>
			<xsl:when test="$oldeditor='on'">
			</xsl:when>
			<xsl:otherwise>
				<table border="0" cellpadding="0" cellspacing="1" width="100%">
					<tr>
						<td class="header" width="16">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						</td>
						<td class="header" width="50"><xsl:value-of select="$string[$edbasestring + 1]"/></td>
						<td class="header"><xsl:value-of select="$string[$edbasestring + 2]"/></td>
						<td class="header"><xsl:value-of select="$string[$edbasestring + 5]"/></td>
					</tr>
					<xsl:for-each select="/siteinfo/editorsettings/setting">
						<tr bgcolor="white" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
							<td><img src="admin/media/{active}.gif" width="16" height="15" border="0"/></td>
							<td class="data2"><xsl:value-of select="id"/></td>
							<td class="data2">
								<a href="default.asp?ACT={$ACT}&amp;SECT={$SECT}&amp;id={id}"><xsl:value-of select="name"/></a>
							</td>
							<td class="data2"><xsl:value-of select="group"/></td>
						</tr>
					</xsl:for-each>
				</table>
				<input type="submit" value="{$string[420]}" onclick="document.location.href='default.asp?ACT={$ACT}&amp;SECT={$SECT}&amp;id=new';"/>		
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	<xsl:template name="editor_settingadd">
		<table bgcolor="white">
			<form action="default.asp?ACT={$ACT}&amp;SECT={$section}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="editor"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="bloc" value="siteinfo/editorsettings"/>
						<input type="hidden" name="node" value="setting"/>

						<table class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$edbasestring + 2]"/>:
								</td>
								<td>
									<input type="text" name="name" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$edbasestring + 3]"/>:
								</td>
								<td>
									<textarea  class="textarea" name="config" title="setting"></textarea>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$edbasestring + 5]"/>:
								</td>
								<td>
									<select name="group">
										<option value="anonymous"><xsl:value-of select="$string[$kb_basestring + 32]"/></option>
										<option value="member"><xsl:attribute name="selected">selected</xsl:attribute><xsl:value-of select="$string[430]"/></option>
										<option value="editor"><xsl:value-of select="$string[429]"/></option>
									</select>  
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$edbasestring + 4]"/>:
								</td>
								<td>
									<select name="active">
										<option value="off"><xsl:value-of select="$string[61]"/></option>
										<option value="on"><xsl:attribute name="selected">selected</xsl:attribute><xsl:value-of select="$string[60]"/></option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT={$ACT}&amp;SECT={$SECT}';"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>
	
	<xsl:template name="editor_settingupdate">
		<table bgcolor="white">
			<form action="default.asp?ACT={$ACT}&amp;SECT={$section}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="editor"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="siteinfo/editorsettings/setting[id={$id}]"/>

						<table class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$edbasestring + 2]"/>:
								</td>
								<td>
									<input type="text" name="name" value="{name}" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$edbasestring + 3]"/>:
								</td>
								<td>
									<textarea  class="textarea" name="config" title="setting"><xsl:value-of select="config"/></textarea>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$edbasestring + 5]"/>:
								</td>
								<td>
									<select name="group">
										<option value="anonymous">
											<xsl:if test="group='anonymous'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
											<xsl:value-of select="$string[$kb_basestring + 32]"/>
										</option>
										<option value="member">
												<xsl:if test="group='member'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
												<xsl:value-of select="$string[430]"/>
										</option>
										<option value="editor">
											<xsl:if test="group='editor'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
											<xsl:value-of select="$string[429]"/>
										</option>
									</select>  
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$edbasestring + 4]"/>:
								</td>
								<td>
									<select name="active">
										<option value="off">
											<xsl:if test="active='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
											<xsl:value-of select="$string[61]"/>
										</option>
										<option value="on">
											<xsl:if test="active='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
											<xsl:value-of select="$string[60]"/>
										</option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT={$ACT}&amp;SECT={$SECT}';"/>
								</td>
							</tr>
						</table>						
					</td>
				</tr>
			</form>
			<xsl:if test="$usertype='administrator'">
				<tr>
					<td><br/></td>
				</tr>
				<tr>
					<td>
						<form action="default.asp?ACT={$ACT}&amp;SECT={$SECT}" method="post" onsubmit="return confirm('{$string[83]}');">
							<table class="block">
								<tr>
									<td bgcolor="white" align="right">
								    	<input type="hidden" name="file" value="editor"/>
										<input type="hidden" name="operation" value="delete"/>
										<input type="hidden" name="node" value="siteinfo/editorsettings/setting[id={$id}]"/>
										<input type="submit" value="{$string[16]}"/>
									</td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>
	
	<xsl:template name="editor_initialupdate">
		<xsl:if test="not(name(/siteinfo/editorsettings))">
			<form action="default.asp?ACT={$ACT}&amp;SECT={$section}" method="post" name="frmUpdate1">
				<input type="hidden" name="file" value="editor"/>
				<input type="hidden" name="operation" value="add"/>
				<input type="hidden" name="bloc" value="siteinfo"/>
				<input type="hidden" name="node" value="editorsettings"/>
			</form>
			<script language="javascript">
				document.frmUpdate1.submit();
			</script>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="editor_manager">
		<xsl:call-template name = "editor_navigator" />
		
		<xsl:choose>
			<xsl:when test="name(/siteinfo/editorsettings)">
				<xsl:choose>
					<xsl:when test="$id='new'">
						<xsl:call-template name = "editor_settingadd" />
					</xsl:when>
					<xsl:when test="$id">				
						<xsl:for-each select = "/siteinfo/editorsettings/setting[id=$id]">
							<xsl:call-template name = "editor_settingupdate" />
						</xsl:for-each>				
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name = "editor_settinglist" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name = "editor_initialupdate" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>	
	
</xsl:stylesheet>