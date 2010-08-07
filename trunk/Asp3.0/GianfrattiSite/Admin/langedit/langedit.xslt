<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>
	
	<xsl:param name="language"/>
	<xsl:param name="selected_filter" select="'all'"/>
	<xsl:param name="file_details" select="'off'"/>
	<xsl:param name="encoding"/>
	<xsl:param name="file_action"/>
	<xsl:variable name="nbsp">&amp;nbsp;</xsl:variable>
		
	<xsl:template match="/">		
		<xsl:apply-templates select="language"/>
	</xsl:template>
	
	<xsl:template match="language">
		
		<xsl:apply-templates select="strings"/>
	</xsl:template>
	
	<xsl:template match="strings">
		<xsl:variable name="upper_character" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
            	<xsl:variable name="lower_character" select="'abcdefghijklmnopqrstuvwxyz'"/>            

		<script language="Javascript">
		// edition sheet heights varies depending on how Editor was opened (Console or URL).
		// The functions Max_Height() and Min_Height() handles sheet heights.

		function Max_Height()
		{
			if (window == top)
				return '80%';
			else
				return '50%';
		}
 		
		function Min_Height()
		{
			if (window == top)
				return '50%';
			else
				return '25%';
		}

		// Enables the "Save" button
		function ButtonSave()
		{
			document.all.btnsaveimg.src='media/save.gif'; 
			document.all.btnsave.disabled='';
		}

		// Edition sheet display and resize.
		function Display_Details()
		{
			if (document.all.filedetails.value=='off') 
				{
					document.all.langheader.style.display= 'none'; 
					document.all.allstrings.style.height= Max_Height(); 
					document.all.newstrings.style.height= Max_Height(); 
					document.all.similarstrings.style.height= Max_Height(); 
				}
			else 
				{
					document.all.langheader.style.display= 'block';
					document.all.allstrings.style.height= Min_Height(); 
					document.all.newstrings.style.height= Min_Height(); 
					document.all.similarstrings.style.height= Min_Height(); 
				}
		}
		// Edition sheet starting settings.
		function Setup_Display()
		{
			Display_Details();

			if (document.all.filedetails.value=='off') 
				{
					document.all.langheader.style.display= 'none'; 
				}
			else 
				{
					document.all.langheader.style.display= 'block';
				}
			if (document.all.filter.value=='all') 
				{
					document.all.allstrings.style.display= 'block'; 
				}
			else 
				{
					document.all.allstrings.style.display= 'none';
				}
			if (document.all.filter.value=='new') 
				{
					document.all.newstrings.style.display= 'block'; 
				}
			else 
				{
					document.all.newstrings.style.display= 'none';
				}
			if (document.all.filter.value=='similar') 
				{
					document.all.similarstrings.style.display= 'block'; 
				}
			else 
				{
					document.all.similarstrings.style.display= 'none';
				}
			document.all.dataload.style.display= 'none'
		}
		// User input validation
		function Basic_Validation()
		{
			if (document.all.languagename.value==0) 
				{
					alert('Language name is invalid!\nPlease correct this.');
					return false
				}
			else 
				{
					return true;
				}
		}
		</script>
		<form name="f1" action="save.asp" method="post" onSubmit="return Basic_Validation();">
		<input type="hidden" name="language" value="{$language}"/>
		<input type="hidden" name="count" value="{count(string)}"/>
		<input type="hidden" name="action" value="{$file_action}"/>
			<table style="width: 100%; background: menu; border: 2px outset;">
				<tr>
					<td><h3><xsl:value-of select="document($language)//language/name"/>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<select name="filedetails" onchange="Display_Details();">
	                			        <option value="on"><xsl:if test="$file_details='on'"><xsl:attribute name="selected">Selected</xsl:attribute></xsl:if>details on</option>
		        	                	<option value="off"><xsl:if test="$file_details='off'"><xsl:attribute name="selected">Selected</xsl:attribute></xsl:if>details off</option>
						</select>
					</h3></td>
				</tr>
			</table>
			<div id="langheader" style="display: none;">							
				<table style="width: 100%; background: menu; border: 2px outset;" cellspacing="0" cellpadding="0">
					<tr>
						<td width="150"><b>File (physical path):</b></td>
						<td><b><xsl:value-of select="$language"/></b></td>
					</tr>
					<tr>
						<td width="150"><b>Language name:</b></td>
						<td><input type="text" name="languagename" value="{document($language)//language/name}" class="infos" onchange="ButtonSave();"/></td>
					</tr>
					<tr>
						<td><b>Translator name:</b></td>
						<td><input type="text" name="translatorname" value="{document($language)//language/translator/name}" class="infos" onchange="ButtonSave();"/></td>
					</tr>
					<tr>
						<td><b>Translator email:</b></td>
						<td><input type="text" name="translatoremail" value="{document($language)//language/translator/email}" class="infos" onchange="ButtonSave();"/></td>
					</tr>
					<tr>
						<td><b>Encoding:</b></td>
						<td>
							<select name="encoding" value="document($language)//language/encoding" onchange="document.all.description.value=this.value;ButtonSave();">
								<xsl:for-each select="document($encoding)//encodings/encoding">
									<option value="{charset}">
										<xsl:if test="translate(document($language)//language/encoding,$lower_character,$upper_character)=translate(charset,$lower_character,$upper_character)">
											<xsl:attribute name="selected">Selected</xsl:attribute>
										</xsl:if>
										<xsl:value-of select="charset"/>
									</option>
								</xsl:for-each>
							</select>
							<select name="description" value="document($language)//language/encoding" onchange="document.all.encoding.value=this.value;ButtonSave();">
								<xsl:for-each select="document($encoding)//encodings/encoding">
									<xsl:sort select="description"/>
									<option value="{charset}">
										<xsl:if test="translate(document($language)//language/encoding,$lower_character,$upper_character)=translate(charset,$lower_character,$upper_character)">
											<xsl:attribute name="selected">Selected</xsl:attribute>
										</xsl:if>
										<xsl:value-of select="description"/>
									</option>
								</xsl:for-each>
							</select>
						</td>
					</tr>
					<tr>
						<td><b>Text-direction:</b></td>
						<td>
							<select name="textdir" value="document($language)//language/dir" onchange="ButtonSave();">
		                			        <option value="ltr"><xsl:if test="translate(document($language)//language/dir,$upper_character,$lower_character)='ltr'"><xsl:attribute name="selected">Selected</xsl:attribute></xsl:if>Left to Right</option>
	        	        			        <option value="rtl"><xsl:if test="translate(document($language)//language/dir,$upper_character,$lower_character)='rtl'"><xsl:attribute name="selected">Selected</xsl:attribute></xsl:if>Right to Left</option>
							</select>
						</td>
					</tr>
				</table>
			</div>
			<table style="width: 100%; background: menu; border: 2px outset;">
				<tr>
					<td width="49%" class="strings">English</td>
					<td width="49%" class="strings"><xsl:value-of select="document($language)//language/name"/>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<select name="filter" value="{$selected_filter}" onchange="if (this.value=='all') document.all.allstrings.style.display= 'block'; else document.all.allstrings.style.display= 'none'; if (this.value=='new') document.all.newstrings.style.display= 'block'; else document.all.newstrings.style.display= 'none'; if (this.value=='similar') document.all.similarstrings.style.display= 'block'; else document.all.similarstrings.style.display= 'none';">
				                        <option value="all"><xsl:if test="$selected_filter='all'"><xsl:attribute name="selected">Selected</xsl:attribute></xsl:if>translated</option>
                				        <option class="wrong" value="new"><xsl:if test="$selected_filter='new'"><xsl:attribute name="selected">Selected</xsl:attribute></xsl:if>new strings</option>
                				        <option class="similar" value="similar"><xsl:if test="$selected_filter='similar'"><xsl:attribute name="selected">Selected</xsl:attribute></xsl:if>similar</option>
		                		    </select>
					<button width="14" height="14" type="submit" name="btnsave" disabled="DISABLED">
						<img name="btnsaveimg" src="media/saveoff.gif" alt="Save" border="0"/>
					</button>
					</td>
				</tr>		
			</table>
			<div id="dataload" align="center" valign="middle" class="msg"><p>Loading Data <img src="media/loading.gif" alig="center" valign="middle"/></p></div>
			<div id="allstrings" style="background-color:#ffffff; overflow:auto; display: none;">
				<p id="msgallstrings" class="msg">
					<br>No translated strings available, currently.</br>
					<br/>Please, check new strings and/or similar.
				</p>
				<table width="100%" class="strings" cellpadding="0">				
					<xsl:apply-templates select="string" mode="all"/>
				</table>
			</div>
			<div id="newstrings" style="background-color:#ffffff; overflow:auto; display: none;">
				<p id="msgnewstrings" class="msg">
					<br>No new strings available, currently.</br>
					<br/>Please, check translated and/or similar strings.
				</p>
				<table width="100%" class="strings" cellpadding="0">
					<xsl:apply-templates select="string" mode="new"/>
				</table>
			</div>
			<div id="similarstrings" style="background-color:#ffffff; overflow:auto; display: none;">
				<p id="msgsimilarstrings" class="msg">
					<br>No similar strings available, currently.</br>
					<br/>Please, check translated and/or new strings.
				</p>
				<table width="100%" class="strings" cellpadding="0">				
					<xsl:apply-templates select="string" mode="similar"/>
				</table>
			</div>
			<script>window.Setup_Display()</script>
		</form>
	</xsl:template>
	
	<xsl:template match="string" mode="all">
	<xsl:variable name="pos" select="position()"/>
	<xsl:choose>
		<xsl:when test="(string-length(.) != 0 and string-length(document($language)//strings/string[$pos]) != 0 and .!=document($language)//strings/string[$pos])">
			<script>document.all.msgallstrings.style.display = 'none';</script>
			<tr class="string">
				<td width="4%" align="right"><xsl:value-of select="$pos"/></td>
				<td width="43%" class="native"><div class="native"><xsl:value-of select="."/></div></td>
				<td width="43%" class="string">				
					<textarea class="string" name="{$pos}" onchange="ButtonSave();"><xsl:value-of select="document($language)//strings/string[$pos]"/></textarea>
				</td>
			</tr>
		</xsl:when>
	</xsl:choose>
	</xsl:template>

	<xsl:template match="string" mode="new">
	<xsl:variable name="pos" select="position()"/>
	<xsl:choose>
		<xsl:when test="(string-length(.) != 0 and string-length(document($language)//strings/string[$pos]) = 0)">
			<script>document.all.msgnewstrings.style.display = 'none';</script>
			<tr class="string">
				<td width="4%" align="right"><xsl:value-of select="$pos"/></td>
				<td width="43%" class="native"><div class="native"><xsl:value-of select="."/></div></td>
				<td width="43%" class="string">				
					<textarea class="wrong" name="{$pos}" onchange="ButtonSave();"></textarea>
				</td>
			</tr>
		</xsl:when>
	</xsl:choose>
	</xsl:template>

	<xsl:template match="string" mode="similar">
	<xsl:variable name="pos" select="position()"/>
	<xsl:choose>
		<xsl:when test="(string-length(.) != 0 and .=document($language)//strings/string[$pos])">
			<script>document.all.msgsimilarstrings.style.display = 'none';</script>
			<tr class="string">
				<td width="4%" align="right"><xsl:value-of select="$pos"/></td>
				<td width="43%" class="native"><div class="native"><xsl:value-of select="."/></div></td>
				<td width="43%" class="string">				
					<textarea class="similar" name="{$pos}" onchange="ButtonSave();"><xsl:value-of select="."/></textarea>
				</td>
			</tr>
		</xsl:when>
	</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
