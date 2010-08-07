<?xml version="1.0" encoding="UTF-8"?> 
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
	<xsl:param name="body_background">#FFFFFF</xsl:param>
	<xsl:param name="body_color">#000000</xsl:param>

	<!-- Toolbar skin values -->
	<xsl:param name="toolbar_color"><xsl:value-of select="$body_background"/></xsl:param>
	<xsl:param name="toolbar_background">#0055D3</xsl:param>
	<xsl:param name="toolbar_border"><xsl:value-of select="$body_color"/></xsl:param>

	<!-- Margins skin values -->
	<xsl:param name="margin_background">#D3E5FA</xsl:param>
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
	<xsl:param name="calendar_tableborder">#0055D3</xsl:param>
	<xsl:param name="calendar_background"><xsl:value-of select="$body_background"/></xsl:param>
	<xsl:param name="calendar_weekdaybg"><xsl:value-of select="$forum.highlight.row.bgcolor"/></xsl:param>
	<xsl:param name="calendar_currentdaybg"><xsl:value-of select="$margin_background"/></xsl:param>

	<!--	
		THIS IS THE BASE TEMPLATE 
		========================
		ALL XSL:TEMPLATE WITH "_design" extension can be changed in the skin.xsl file wich can be found in the same directory
	-->
	
		
	<xsl:template match="/">
	
		<HTML>
			<HEAD dir="{$textdirection}">	
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

				<style>
					BODY {FONT-SIZE: 12px; FONT-FAMILY: verdana}
					TD {FONT-SIZE: 12px; FONT-FAMILY: verdana}
					
					A {	FONT-WEIGHT: normal; FONT-SIZE: 12px; COLOR: #519D50}
					A:hover {COLOR: #000000; TEXT-DECORATION: none	}
					
					A.newsgroup {	FONT-WEIGHT: bold; FONT-SIZE: 16px; COLOR: #000000; TEXT-DECORATION: none}
					A.newsgroup:hover {COLOR: #FF843B; TEXT-DECORATION: none}							
					A.toolbar{FONT-WEIGHT: bold; COLOR: #FFFFFF; TEXT-DECORATION: none ; FONT-SIZE: 10px; FONT-FAMILY: verdana; TEXT-TRANSFORM: uppercase;}
					A.toolbar:Hover { FONT-WEIGHT: bold; COLOR: #FFBD21; TEXT-DECORATION: none; TEXT-TRANSFORM: uppercase;}
					
					A.menu {COLOR: #000000; TEXT-DECORATION: none}
					A.menu:hover {COLOR: #FF843B; TEXT-DECORATION: none}
					
					A.gateway {FONT-WEIGHT: bold; COLOR: #000000; TEXT-DECORATION: none}
					A.gateway:hover {FONT-WEIGHT: bold; COLOR: #FF843B; TEXT-DECORATION: none}
					
					
					A.link	{color: #000000; font-size: 8pt; font-family: verdana; text-decoration:none}
					A.link:Hover { COLOR: #FF843B; font-size: 8pt; font-family: verdana; text-decoration:none}
					
					
					<!-- for the directory add-on-->
					A.cat {font-size: 18px; font-weight: bold; font-family: verdana}
					A.subcat {font-size: 12px; font-weight: normal; font-family: verdana}	
					A.trail {font-size: 12px; font-weight: normal; font-family: verdana}
					
					<!-- Here you can customize the size of the eframe -->
					iframe.external{width: 100%; height: 600px;}
				</style>
				
							
			</HEAD>
		
		<xsl:choose>
			<xsl:when test="string-length(/siteinfo/data/gateway)&gt;0 and $gateway=1 and $ACT=''">
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
				<!--<IMG height="6" src="skins/BlueXP/media/top.gif" width="4"/>-->
				<body  bgcolor="#FFFFFF" leftmargin="2" topmargin="0" marginwidth="2" marginheight="0"><!-- link="#0055D3" alink="#0055D3" vlink="#0055D3" text="#FFFFFF"-->
								
					<!-- START OF THE HEADER -->
					<table border="0" width="100%" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
						<tr>
							<td><xsl:call-template name="titlebloc_macro"/></td>
							<td align="right"><xsl:call-template name="advertisement_macro"/></td>
						</tr>
					</table>
					
						
					<!-- END OF THE HEADER -->
					
					<!-- Design for the toolbar-->
					<xsl:call-template name="toolbar_global_design"/>
							
					<!-- Design of the main table -->
					<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center" height="100%" bgcolor="#FFFFFF">
						<tr valign="top"  bgcolor="#FFFFFF">
							<br/>
					    	<xsl:choose>
								
								<!-- LEFT MARGIN --><!-- ADD-ON  -->
								<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=1 or string-length(/siteinfo/pages/page[id=$id]/margintype)=0">									 
									<td width="171">
										<img src="skins/BlueXP/media/dot.gif" width="171" height="1"/><br/>
										<xsl:call-template name="fullmargin_macro"/>
									</td>
									<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    		<td width="100%" bgcolor="#FFFFFF"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
							    </xsl:when>
								
								<!-- RIGHT MARGIN -->
								<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=2">									
									<td width="100%" bgcolor="#FFFFFF"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
							    	<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	<td width="140">
							    		<img src="skins/BlueXP/media/dot.gif" width="140" height="1"/><br/>
							    		<xsl:call-template name="fullmargin_macro"/>
							    	</td>
								</xsl:when>								
								
								<!-- BOTH MARGIN-->
								<xsl:otherwise>
									<td width="171">
										<img src="skins/BlueXP/media/dot.gif" width="171" height="1"/><br/>
										<xsl:call-template name="leftmargin_macro"/>
									</td>
							    	<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	<td><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
							    	<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	<td width="140">
							    		<img src="skins/BlueXP/media/dot.gif" width="140" height="1"/><br/>
							    		<xsl:call-template name="rightmargin_macro"/>
							    	</td>
								</xsl:otherwise>
							</xsl:choose>					    		
					    		
					    	</tr>
					 </table>	
				<!-- End of the main table -->	
				
				
				<!-- Footer -->				
				<table border="1" bordercolor="#000000" cellpadding="0" cellspacing="0" width="100%" align="center">
					<tr> 
						<td bgcolor="#0055D3" bordercolor="#95BDEE"> 
						<div align="center"><font color="#FFFFFF"><b><xsl:call-template name="copyright_macro"/></b></font></div>
						</td>
					</tr>
				</table>	
					
				</body>
		
			</xsl:otherwise>
		</xsl:choose>
		
		</HTML>		

	</xsl:template>
</xsl:stylesheet>
