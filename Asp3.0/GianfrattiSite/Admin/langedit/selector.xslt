<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>
	
	<xsl:param name="language"/>
	<xsl:param name="encoding"/>
		
	<xsl:template match="/">
		<table style="width: 100%; background: menu; border: 2px outset;">
			<tr valign="top" align="left">
				<td width="10%"><b>Existing Languages:</b></td>
				<td><b>Create a New Language:</b></td>
			</tr>
			<tr valign="top" align="left">
				<td  height="100%">
					<xsl:call-template name="listlanguages"/>
				</td>
				<td height="100%">
					<xsl:call-template name="newlanguage"/>
				</td>
			</tr>
		</table>
		
	</xsl:template>
	
	<xsl:template match="language" mode="option">
		<option value="{filename}"><xsl:value-of select="name"/></option>
	</xsl:template>
	
	<xsl:template name="newlanguage">
		<form action="default.asp" method="post">
		<input type="hidden" name="action" value="create"/>
		<table style="width: 100%; height=100%; background: menu; border: 2px outset;">
			<tr>
				<td><b>Language name:</b></td>
				<td><input type="text" name="languagename" value="" class="infos"/></td>
			</tr>
			<tr>
				<td><b>Translator name:</b></td>
				<td><input type="text" name="translatorname" value="" class="infos"/></td>
			</tr>
			<tr>
				<td><b>Translator email:</b></td>
				<td><input type="text" name="translatoremail" value="" class="infos"/></td>
			</tr>
			<tr>
				<td><b>Encoding:</b></td>
				<td>
					<select name="encoding" onchange="document.all.description.value=this.value;">
						<xsl:for-each select="document($encoding)//encodings/encoding">
							<option value="{charset}"><xsl:value-of select="charset"/></option>
						</xsl:for-each>
					</select>
					<select name="description" onchange="document.all.encoding.value=this.value;">
						<xsl:for-each select="document($encoding)//encodings/encoding">
							<xsl:sort select="description"/>
							<option value="{charset}"><xsl:value-of select="description"/></option>
						</xsl:for-each>
					</select>
				</td>
				<script>document.all.encoding.value="UTF-8";document.all.description.value="UTF-8";</script>
			</tr>
			<tr>
				<td><b>Text-direction:</b></td>
				<td>
					<select name="textdir" value="ltr">
                			        <option value="ltr" selected="selected">Left to Right</option>
       	        			        <option value="rtl">Right to Left</option>
					</select>
				</td>
			</tr>
			<tr height="100%"><td height="100%" colspan="2" valign="bottom" align="center"><input type="submit" value="CREATE"/></td></tr>
		</table>	
		</form>
	</xsl:template>

	<xsl:template name="listlanguages">
		<form action="default.asp" method="post">
		<input type="hidden" name="action" value="update"/>
		<table style="width: 100%; height=100%; background: menu; border: 2px outset;">
			<tr valign="top" align="left">
				<td>
					<select name="language" size="8">
						<xsl:for-each select="languages/language">
							<xsl:sort select="name"/>
							<option value="{filename}"><xsl:value-of select="name"/></option>
						</xsl:for-each>
					</select>
				</td>
			</tr>
			<tr><td align="center"><input type="submit" value="EDIT"/></td></tr>
		</table>	
		</form>
	</xsl:template>
	
	<xsl:template name="listencoding">
		<select name="encoding">
			<xsl:for-each select="document($encoding)//encoding">
					<option value="{document($encoding)//encoding/charset}" alt="{description}"><xsl:value-of select="document($encoding)//encoding/description"/></option>
			</xsl:for-each>
		</select>
	</xsl:template>

</xsl:stylesheet>
