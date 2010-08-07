<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb"> 
<xsl:output method="html"/> 

	<xsl:template name="mail_moduleinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Mail Manager</xsl:with-param>
			<xsl:with-param name="version">1.0</xsl:with-param>
			<xsl:with-param name="moddate">11.04.2004</xsl:with-param>
			<xsl:with-param name="author">John Roland, Mig100 (Miguel Figueira) and JeS (Jens Schreiber)</xsl:with-param>
			<xsl:with-param name="url">http://www.fxmods.com</xsl:with-param>
			<xsl:with-param name="action"></xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Addons settings template  -->
	<xsl:template name="mail_manager">		
		

	
	<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M102"><img src="admin/media/emailf.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[380]"/></font></td></tr>
		</table>

		
	<!-- Site Manager form -->	
	<table bgcolor="white">
		<form action="default.asp?ACT=1&amp;SECT=0" method="post" name="frmFullxml">
		<input type="hidden" name="operation" value="update"/>
		<input type="hidden" name="node" value="siteinfo/data"/>
			
			<xsl:for-each select="/siteinfo/data">
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr>
					<td class="xp_sel"><xsl:value-of select="$string[380]"/>:</td>
					<td>
						<select name="emailCOM" onchange="if (this.value=='off') document.all.emailfunctions.style.display= 'none'; else document.all.emailfunctions.style.display= 'block';">
							<option value="off"><xsl:if test="emailCOM='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[477]"/></option>
							<option value="ASPMail"><xsl:if test="emailCOM='ASPMail'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> ASPMail</option>
							<option value="ASPQMail"><xsl:if test="emailCOM='ASPQMail'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> ASPQMail</option>
							<option value="ASPEmail"><xsl:if test="emailCOM='ASPEmail'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> ASPEmail</option>
							<option value="CDOMail"><xsl:if test="emailCOM='CDOMail'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> CDONTS</option>
							<option value="CDOSYSMail"><xsl:if test="emailCOM='CDOSYSMail'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> CDOSYS</option>
							<option value="JMail"><xsl:if test="emailCOM='JMail'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> JMail</option>
							<option value="SASmtpMail"><xsl:if test="emailCOM='SASmtpMail'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> SASmtpMail</option>
						</select>
						 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[459]"/> (<a href="#" onclick="window.open('help/email_sniffer.asp', 'email', 'width=200, height=200');"><xsl:value-of select="$string[478]"/></a>)<br/>
						
						<!-- these are hidden until the option is set to on -->
						<div id="emailfunctions" style="display: none;">
							<input type="text" value="{email}" name="email" class="medium"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[25]"/><br/>
							<input type="text" value="{smtpserver}" name="smtpserver" class="medium"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[381]"/><br/>								
							
							<select name="wnewsgroup">
								<option value="off"><xsl:if test="wnewsgroup='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[61]"/></option>
								<option value="on"><xsl:if test="wnewsgroup='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[60]"/></option>
							</select>
							 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[382]"/><br/>
							
							<select name="wguestbook">
								<option value="off"><xsl:if test="wguestbook='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[61]"/></option>
								<option value="on"><xsl:if test="wguestbook='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[60]"/></option>
							</select>
							 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[383]"/><br/>
							
							<select name="wreaction">
								<option value="off"><xsl:if test="wreaction='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[61]"/></option>
								<option value="on"><xsl:if test="wreaction='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> <xsl:value-of select="$string[60]"/></option>
							</select>
							 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[384]"/><br/>
													
							<select name="wsignup">
								<option value="off"><xsl:if test="wsignup='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[61]"/></option>
								<option value="on"><xsl:if test="wsignup='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> <xsl:value-of select="$string[60]"/></option>
							</select>
							 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[385]"/><br/>						
						</div>
						<script>if (document.frmFullxml.emailCOM.value=='off') document.all.emailfunctions.style.display= 'none'; else document.all.emailfunctions.style.display= 'block';</script>
				</td></tr>
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