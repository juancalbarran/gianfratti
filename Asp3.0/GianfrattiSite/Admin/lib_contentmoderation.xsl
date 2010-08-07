<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb"> 
<xsl:output method="html"/> 

	<xsl:template name="contentmoderation_moduleinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Addons Manager</xsl:with-param>
			<xsl:with-param name="version">1.0</xsl:with-param>
			<xsl:with-param name="moddate">11.04.2004</xsl:with-param>
			<xsl:with-param name="author">John Roland, Mig100 (Miguel Figueira) and JeS (Jens Schreiber)</xsl:with-param>
			<xsl:with-param name="url">http://www.fxmods.com</xsl:with-param>
			<xsl:with-param name="action"></xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Addons settings template  -->
	<xsl:template name="contentmoderation_manager">		
			
	<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M103"><img src="admin/media/contentset.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[611]"/></font></td></tr>
		</table>

		
	<!-- Site Manager form -->	
	<table bgcolor="white">
		<tr><td>
		<form action="default.asp?ACT=1&amp;SECT=0" method="post" name="frmFullxml">
		<input type="hidden" name="operation" value="update"/>
		<input type="hidden" name="node" value="siteinfo/data"/>
			<xsl:for-each select="/siteinfo/data">
			<table class="block">				
				<tr>
					<td class="xp_sel" colspan="2"><xsl:value-of select="$string[35]"/>:</td>
				</tr>
				<!-- Editor choice -->
				<tr>
					<td class="xp_sel">
						<xsl:value-of select="$string[$edbasestring + 7]"/>:
					</td>
					<td>
						<select name="oldeditor">
							<option value="off"><xsl:if test="oldeditor='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>HtmlArea</option>
							<option value="on"><xsl:if test="oldeditor='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>FullXML Editor</option>
						</select>
					</td>
				</tr>

				<!-- text direction -->
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[915]"/>:</td>
					<td>
						<select name="textdirection">
								<xsl:choose>
								<xsl:when test="textdirection='RTL'">
									<option value="LTR"><xsl:value-of select="$string[916]"/></option>
									<option value="RTL" selected="selected"><xsl:value-of select="$string[917]"/></option>
								</xsl:when>
								<xsl:otherwise>
									<option value="LTR" selected="selected"><xsl:value-of select="$string[916]"/></option>
									<option value="RTL"><xsl:value-of select="$string[917]"/></option>
								</xsl:otherwise>
							</xsl:choose>
						</select>
					</td>
				</tr>				
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<!-- Statut de modération par défaut -->
				<tr>
					<td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[597]"/>:</td>
					<td>
						<select name="articlestate">
							<xsl:choose>
								<xsl:when test="articlestate='on'"><option value="off">off</option><option value="on" selected="selected">on</option></xsl:when>
								<xsl:otherwise><option value="off" selected="selected">off</option><option value="on">on</option></xsl:otherwise>
							</xsl:choose>
						</select> 
					</td>
				</tr>
				<tr>
					<td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[596]"/>:</td>
					<td>
						<select name="reactionstate">
							<xsl:choose>
								<xsl:when test="reactionstate='on'"><option value="off">off</option><option value="on" selected="selected">on</option></xsl:when>
								<xsl:otherwise><option value="off" selected="selected">off</option><option value="on">on</option></xsl:otherwise>
							</xsl:choose>
						</select>
 					</td>
				</tr>
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>	
			</table>
			</xsl:for-each>
			<tr>
				<td align="right">
					<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1';" />
				</td>
			</tr>
			</form>
		</td></tr>
		</table>
	</xsl:template>	

</xsl:stylesheet>