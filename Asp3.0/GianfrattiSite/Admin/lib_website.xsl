<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb"> 
<xsl:output method="html"/> 

	<xsl:template name="website_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Website Manager</xsl:with-param>
			<xsl:with-param name="version">1.2</xsl:with-param>
			<xsl:with-param name="moddate">14.11.2003</xsl:with-param>
			<xsl:with-param name="author">John Roland, Mig100 (Miguel Figueira) and JeS (Jens Schreiber)</xsl:with-param>
			<xsl:with-param name="url">http://www.fxmods.com</xsl:with-param>
			<xsl:with-param name="action"></xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<!-- configsite template  -->
	<xsl:template name="website_manager">		
		
	<!-- Icon and Title of category -->		
	<!--<table class="category_title">
		<tr><td width="16"><img src="admin/media/website.gif" width="16"/></td>
		<td><xsl:value-of select="$string[20]"/></td></tr>
	</table>-->
	
	<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M1"><img src="admin/media/website.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[20]"/></font></td></tr>
		</table>

		
	<!-- Site Manager form -->	
	<table bgcolor="white">
		<form action="default.asp?ACT=1&amp;SECT=0" method="post" name="frmFullxml">
		<input type="hidden" name="operation" value="update"/>
		<input type="hidden" name="node" value="siteinfo/data"/>
			
			<xsl:for-each select="/siteinfo/data">
				<!--
				<tr><td class="xp_sel"><xsl:value-of select="$string[22]"/>:</td><td><input type="text" value="{login}" name="login" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[23]"/>:</td><td><input type="password" value="{password}" name="password" class="full"/></td></tr>
				<tr><td colspan="2"></td></tr>
				-->
				
				<tr><td class="xp_sel"><xsl:value-of select="$string[26]"/>:</td><td><input type="text" value="{url}" name="url" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[21]"/>:</td><td><input type="text" value="{name}" name="name" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[49]"/>:</td><td><input type="text" value="{slogan}" name="slogan" class="full"/></td></tr>
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				
				<tr><td class="xp_sel"><xsl:value-of select="$string[24]"/>:</td><td><input type="text" value="{title}" name="title" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[27]"/>:</td><td><input type="text" value="{keywords}" name="keywords" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[28]"/>:</td><td><input type="text" value="{description}" name="description" class="full"/></td></tr>
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
					
				<!-- Maintenance -->
<!--				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[542]"/>:</td>
					<td>
						<select name="maintenance">
							<option value="off"><xsl:if test="maintenance='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[61]"/></option>
							<option value="on"><xsl:if test="maintenance='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> <xsl:value-of select="$string[60]"/></option>
						</select>
					</td>
				</tr> -->
	
				
				<!-- Menu Bar -->
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[479]"/>:</td>
					<td>
						<select name="menubar">
							<option value="off"><xsl:if test="menubar='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[61]"/></option>
							<option value="on"><xsl:if test="menubar='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> <xsl:value-of select="$string[60]"/></option>
						</select>
					</td>
				</tr>
				
				<!-- XSL Skin -->
				<tr><td class="xp_sel"><xsl:value-of select="$string[29]"/>:</td><td>
				<xsl:variable name="xslskin" select="xslskin"/>
				<select name="xslskin">
					<xsl:for-each select="$skinsnode/xslskins/xslskin"><xsl:sort select="@name" data-type="text" order="ascending"/>
						<option value="{@name}">
							<xsl:if test="$xslskin=@name"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
							<xsl:value-of select="@name"/><xsl:if test="@studio"> (<xsl:value-of select="$string[602]"/>)</xsl:if>
						</option>
					</xsl:for-each>						
				</select></td></tr>
				
				<!-- Language -->
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[30]"/>:</td>
					<td>
						<select name="language">
							<xsl:variable name="selectedid" select="language"/>
							<xsl:for-each select="document(concat($languagespath, '\_index.xml'))//languages/language">
							<xsl:sort select="name" data-type="text" order="ascending"/>
								<option value="{id}">
									<xsl:if test="$selectedid=id"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
									<xsl:value-of select="name"/> (<xsl:value-of select="encoding"/>)
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>
				
				<!-- ENCODING -->
					<xsl:variable name="encoding_list">					
						<encodings>
							<encoding value="iso-8859-1"/>
							<encoding value="iso-8859-2"/>
							<encoding value="iso-8859-3"/>
							<encoding value="iso-8859-4"/>
							<encoding value="iso-8859-5"/>
							<encoding value="iso-8859-6"/>
							<encoding value="iso-8859-6-E"/>
							<encoding value="iso-8859-6-I"/>
							<encoding value="iso-8859-7"/>
							<encoding value="iso-8859-8"/>
							<encoding value="iso-8859-8-E"/>
							<encoding value="iso-8859-8-I"/>
							<encoding value="iso-8859-9"/>
							<encoding value="iso-8859-10"/>
							<encoding value="iso-8859-11"/>
							<encoding value="iso-8859-13"/>
							<encoding value="iso-8859-14"/>
							<encoding value="iso-8859-15"/>
							<encoding value="iso-8859-16"/>
							<encoding value="euc-jp"/>
							<encoding value="euc-kr"/>
							<encoding value="windows-874"/>
							<encoding value="windows-1250"/>
							<encoding value="windows-1251"/>
							<encoding value="windows-1252"/>
							<encoding value="windows-1253"/>
							<encoding value="windows-1254"/>
							<encoding value="windows-1255"/>
							<encoding value="windows-1256"/>
							<encoding value="windows-1257"/>
							<encoding value="windows-1258"/>
							<encoding value="hz-gb-2312"/>
							<encoding value="big5"/>
							<encoding value="gb2312"/>
							<encoding value="Shift_JIS"/>
							<encoding value="ISO-2022-JP"/>
							<encoding value="ISO-2022-KR"/>
							<encoding value="KOI8-R"/>
							<encoding value="utf-8"/>
							<encoding value="utf-16"/>						
						</encodings>
					</xsl:variable>				
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[450]"/>:</td>
					<td>
						<xsl:variable name="selectedencoding" select="encoding"/>
						<select name="encoding">
							<xsl:for-each select="msxsl:node-set($encoding_list)//encodings/encoding">
								<option value="{@value}">
									<xsl:if test="$selectedencoding=@value"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
									<xsl:value-of select="@value"/>
								</option>
							</xsl:for-each>		
						</select>
					</td>
				</tr>

				<!-- DATE FORMATS -->
					<xsl:variable name="dateformat_list">					
						<dateformats>
							<dateformat value="dd.mm.yy"/>
							<dateformat value="dd.mmm.yy"/>
							<dateformat value="dd.mm.yyyy"/>
							<dateformat value="dd.mmm.yyyy"/>
							<dateformat value="mmm.yy"/>
							<dateformat value="mmm.yyyy"/>
							<dateformat value="mm.dd.yy"/>
							<dateformat value="mmm.dd.yy"/>
							<dateformat value="mm.dd.yyyy"/>
							<dateformat value="mmm.dd.yyyy"/>
							<dateformat value="yy.mm.dd"/>
							<dateformat value="yy.mmm.dd"/>
							<dateformat value="yyyy.mm.dd"/>
							<dateformat value="yyyy.mmm.dd"/>
						</dateformats>
					</xsl:variable>				
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[230]"/>:</td>
					<td>
						<xsl:variable name="selecteddateformat" select="dateformat"/>
						<select name="dateformat">
							<xsl:for-each select="msxsl:node-set($dateformat_list)//dateformats/dateformat">
								<option value="{@value}">
									<xsl:if test="$selecteddateformat=@value"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
									<xsl:value-of select="@value"/>
								</option>
							</xsl:for-each>		
						</select>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<xsl:value-of select="$string[231]"/>:
						<select name="dateseparator" style="width: 45px">
							<option value="."><xsl:if test="dateseparator='.'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>.</option>
							<option value="-"><xsl:if test="dateseparator='-'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>-</option>
							<option value="/"><xsl:if test="dateseparator='/'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>/</option>
						</select>

					</td>
				</tr>

				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				
				<tr><td class="xp_sel"><xsl:value-of select="$string[31]"/>:</td>
					<td>
						<textarea name="gateway" class="textarea" title="{$string[438]}"><xsl:value-of select="gateway" disable-output-escaping="no"/></textarea>
						
						<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('gateway');</script></xsl:if>
					</td>
				</tr>
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
															
				<tr><td class="xp_sel"><xsl:value-of select="$string[32]"/>:</td><td><input type="text" value="{biglogo}" name="biglogo" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[34]"/>:</td><td><input type="text" name="footer" class="full" value="{footer}"/></td></tr>		
				
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
									
			</xsl:for-each>
			<tr>
				<td align="right" colspan="2">
					<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1';" />
				</td>
			</tr>
			</form>
		</table>
	</xsl:template>	

</xsl:stylesheet>