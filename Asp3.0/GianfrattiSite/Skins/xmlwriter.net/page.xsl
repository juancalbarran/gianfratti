<?xml version="1.0" encoding="ISO-8859-1"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxml="urn:schemas-microsoft-com:xslt" xmlns:game="urn:schemas-cagle-com:game"    version="1.0" exclude-result-prefixes="msxml game">

	<xsl:output method="xml" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes"/>
			
	<!-- Include : variables et add-on  -->
	<xsl:include href="../common/macros.xsl"/>	
	<xsl:include href="skin.xsl"/>
	
	<!-- Original skin was created to fullxml 2.3 beta, and distributed by J.Roland -->
	<!-- Modified skin version to fullxml 2.4, by Eduardo Azambuja (eazambu) -->
	<!-- fullxml 2.4 (fxmods) settings, (eazambu) -->

	<!-- General skin values -->
	<xsl:param name="general_font">Verdana</xsl:param>
	<xsl:param name="body_background">#6284A6</xsl:param>
	<xsl:param name="body_color">#000000</xsl:param>

	<!-- Toolbar skin values -->
	<xsl:param name="toolbar_color"><xsl:value-of select="$body_background"/></xsl:param>
	<xsl:param name="toolbar_background">#C7DAEE</xsl:param>
	<xsl:param name="toolbar_border"><xsl:value-of select="$body_color"/></xsl:param>

	<!-- Margins skin values -->
	<xsl:param name="margin_background">#C7DAEE</xsl:param>
	<xsl:param name="margin_color">#01518C</xsl:param>

	<!-- Newsgroups skin values -->
	<xsl:param name="forum.header.bgcolor"><xsl:value-of select="$toolbar_background"/></xsl:param>
	<xsl:param name="forum.header.color"><xsl:value-of select="$body_background"/></xsl:param>

	<xsl:param name="forum.normal.row.bgcolor"><xsl:value-of select="$margin_background"/></xsl:param>
	<xsl:param name="forum.highlight.row.bgcolor">#FFFFFF</xsl:param>

	<xsl:param name="forum.new.thread.bgcolor"><xsl:value-of select="$margin_background"/></xsl:param>
	<xsl:param name="forum.new.thread.color"><xsl:value-of select="$toolbar_background"/></xsl:param>
	<xsl:param name="forum.new.thread.bordercolor"><xsl:value-of select="$toolbar_background"/></xsl:param>

	<!-- Event calendar skin values -->
	<xsl:param name="calendar_tableborder">#CCCCCC</xsl:param>
	<xsl:param name="calendar_background"><xsl:value-of select="$forum.highlight.row.bgcolor"/></xsl:param>
	<xsl:param name="calendar_weekdaybg"><xsl:value-of select="$margin_background"/></xsl:param>
	<xsl:param name="calendar_currentdaybg"><xsl:value-of select="$margin_background"/></xsl:param>

	<!--	
		THIS IS THE BASE TEMPLATE 
		========================
		ALL XSL:TEMPLATE WITH "_design" extension can be changed in the skin.xsl file wich can be found in the same directory
	-->
	
		
	<xsl:template match="/">
	
		<HTML dir="{$textdirection}" xmlns="http://www.w3.org/1999/xhtml">
			<HEAD>	
				<META http-equiv="Content-Type" content="text/html; charset={/siteinfo/data/encoding}"/>
				<TITLE><xsl:value-of select="/siteinfo/data/title" disable-output-escaping="yes"/></TITLE>
				<LINK rel="SHORTCUT ICON" href="media/favicon.ico"/>
				<META name="Copyright" 	content="{/siteinfo/data/copyright}"/>
				<META name="Keywords" 	content="{/siteinfo/data/keywords}"/>
				<META name="Description" 	content="{/siteinfo/data/description}"/>
				<META name="GENERATOR" content="Fullxml 2.4 - http://www.fxmods.com"/>

				<!-- fullxml 2.4 (fxmods) settings, (eazambu) -->
				<!-- if user is in a chatroom  -->
				<xsl:if test="$channel and $ACT=93 and $chatview='ctrl'">
					<META http-equiv="refresh" content="15"/>
				</xsl:if>
				
				<!-- Fullxml stylesheet -->
				<style>
					BODY, TABLE, TR, TD { FONT-SIZE: 12px; FONT-FAMILY: verdana}
					
					A {	FONT-WEIGHT: normal; FONT-SIZE: 12px; COLOR: #0000ff; TEXT-DECORATION: underline}
					A:hover {COLOR: #0000ff; TEXT-DECORATION: none; TEXT-DECORATION: underline}
					
					A.newsgroup {	FONT-WEIGHT: bold; FONT-SIZE: 12px; COLOR: #000000; TEXT-DECORATION: none}
					A.newsgroup:hover {COLOR: #0000ff;}
														
					A.toolbar{FONT-WEIGHT: bold; COLOR: #6284A6; TEXT-DECORATION: none}
					A.toolbar:Hover { FONT-WEIGHT: bold; COLOR: #000000; TEXT-DECORATION: none}
				
					A.menu {FONT-WEIGHT: normal; COLOR: #000000; TEXT-DECORATION: none}
					A.menu:hover {COLOR: #0000ff; TEXT-DECORATION: none; TEXT-DECORATION: underline}
					
					A.gateway {FONT-WEIGHT: normal; FONT-SIZE: 12px; COLOR: #0000ff; TEXT-DECORATION: underline}
					A.gateway:hover {FONT-WEIGHT: bold; COLOR: #ff6600; TEXT-DECORATION: none}
					
					A.link:Hover { FONT-WEIGHT: normal; FONT-SIZE: 12px; COLOR: #0000ff; TEXT-DECORATION: underline}
					A.link	{FONT-WEIGHT: bold; COLOR: #ff6600; TEXT-DECORATION: none }
					
					<!-- for the directory add-on-->
					A.cat {font-size: 18px; font-weight: bold; font-family: verdana}
					A.subcat {font-size: 12px; font-weight: normal; font-family: verdana}	
					A.trail {font-size: 12px; font-weight: normal; font-family: verdana}
					
					<!-- Here you can customize the size of the eframe -->
					iframe.external{width: 100%; height: 600px;}

				</style>
				
							
			</HEAD>
		
		<xsl:choose>
			<xsl:when test="string-length(/siteinfo/data/gateway)&gt;0 and $gateway=1 and $ACT=0">
				<xsl:call-template name="gateway_design"></xsl:call-template>
			</xsl:when>

			<!-- fullxml 2.4 (fxmods) settings, (eazambu) -->
			<xsl:when test="$channel and $channel!='new' and $ACT=93">
				<xsl:call-template name="pagebody_macro"/>
			</xsl:when>
			<xsl:when test="$ACT=4 and $content='easylink' or $layout='printer'">
				<body  margin="0" bgcolor="{$body_background}">
					<xsl:call-template name="pagebody_macro"/>
				</body>
			</xsl:when>

			<xsl:otherwise>
		
				<!-- Start edit here -->
				<body  style="margin: 0px" margin="0" bgcolor="#FFFFFF">
								
					<!-- START OF THE HEADER -->
					<table border="0" width="100%" cellspacing="0" cellpadding="0" bgcolor="#6384A5">
						<tr>
							<td><xsl:call-template name="titlebloc_macro"/></td>
							<td align="right"><xsl:call-template name="advertisement_macro"/></td>
						</tr>
					</table>
					
						
					<!-- END OF THE HEADER -->
					
					<!-- Design for the toolbar-->
					<xsl:call-template name="toolbar_global_design"/>
							
					<!-- Design of the main table -->
					<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center" height="100%" bgcolor="#ffffff">
						<tr valign="top"  bgcolor="#FFFFFF">						
							<td width="145" bgcolor="#C7DAEE"><xsl:call-template name="leftmargin_macro"/></td>
							<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
					    	<td bgcolor="#FFFFFF">
					    		<xsl:call-template name="pagetitle_macro"/>
					    		<xsl:call-template name="pagebody_macro"/>
					    		<hr/>
					    		<table width="100%">
						    		<tr>
						    			<td align="left" width="50%"><font size="1" color="#999999"><xsl:value-of select="$now"/></font></td>
						    			<td align="right"><xsl:call-template name="email_macro"/></td>
						    		</tr>
						    		<tr><td align="center" colspan="2"><font size="1" color="#999999"><xsl:call-template name="copyright_macro"/></font></td></tr>
					    		</table>
					    	</td>
					    	<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
					    	<td width="150" valign="top"><br/><br/><br/><br/><xsl:call-template name="rightmargin_macro"/></td>	
					    	<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>						    	
					    </tr>
					 </table>	
				<!-- End of the main table -->	
				
				
				<!-- Footer -->				
				<table border="0" cellpadding="0" cellspacing="1" width="100%" align="center">
					<tr> 
						<td bgcolor="#3366CC"> 
						<div align="center" class="rub"></div>
						</td>
					</tr>
				</table>	
					
				</body>
		
			</xsl:otherwise>
		</xsl:choose>
		
		</HTML>		

	</xsl:template>
</xsl:stylesheet>
