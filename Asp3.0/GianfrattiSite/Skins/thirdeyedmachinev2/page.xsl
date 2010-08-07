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
	<xsl:param name="general_font">Arial</xsl:param>
	<xsl:param name="body_background">#FFFFFF</xsl:param>
	<xsl:param name="body_color">#000000</xsl:param>

	<!-- Toolbar skin values -->
	<xsl:param name="toolbar_color"><xsl:value-of select="$body_background"/></xsl:param>
	<xsl:param name="toolbar_background">#000000</xsl:param>
	<xsl:param name="toolbar_border"><xsl:value-of select="$body_color"/></xsl:param>

	<!-- Margins skin values -->
	<xsl:param name="margin_background">#FFFFFF</xsl:param>
	<xsl:param name="margin_color">#01518C</xsl:param>

	<!-- Newsgroups skin values -->
	<xsl:param name="forum.header.bgcolor"><xsl:value-of select="$toolbar_background"/></xsl:param>
	<xsl:param name="forum.header.color"><xsl:value-of select="$body_background"/></xsl:param>

	<xsl:param name="forum.normal.row.bgcolor"><xsl:value-of select="$margin_background"/></xsl:param>
	<xsl:param name="forum.highlight.row.bgcolor">#f0f0f0</xsl:param>

	<xsl:param name="forum.new.thread.bgcolor"><xsl:value-of select="$margin_background"/></xsl:param>
	<xsl:param name="forum.new.thread.color"><xsl:value-of select="$toolbar_background"/></xsl:param>
	<xsl:param name="forum.new.thread.bordercolor"><xsl:value-of select="$toolbar_background"/></xsl:param>

	<!-- Event calendar skin values -->
	<xsl:param name="calendar_tableborder">#CCCCCC</xsl:param>
	<xsl:param name="calendar_background"><xsl:value-of select="$body_background"/></xsl:param>
	<xsl:param name="calendar_weekdaybg"><xsl:value-of select="$forum.highlight.row.bgcolor"/></xsl:param>
	<xsl:param name="calendar_currentdaybg">#f0f0f0</xsl:param>

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
					BODY, TABLE, TR, TD {	FONT-SIZE: 11px; FONT-FAMILY: Arial, Helvetica, sans-serif}
					
					A {	FONT-WEIGHT: normal; FONT-SIZE: 10px; COLOR: #0850A0}
					A:hover {COLOR: #ff6600; TEXT-DECORATION: none	}				
					
					A.newsgroup {	FONT-WEIGHT: bold; FONT-SIZE: 10px; COLOR: #ff6600; TEXT-DECORATION: none}
					A.newsgroup:hover {COLOR: #0850A0; TEXT-DECORATION: none	}				
										
					A.toolbar{font-size: 12px; FONT-WEIGHT: bold; COLOR: #FFFFFF; TEXT-DECORATION: none }
					A.toolbar:Hover { FONT-WEIGHT: bold; COLOR: #FF0000; TEXT-DECORATION: none}
					
					A.menu {FONT-WEIGHT: bold; COLOR: #000000; TEXT-DECORATION: none}
					A.menu:hover {	FONT-WEIGHT: bold; COLOR: #ff0000; TEXT-DECORATION: none}
					
					A.gateway {FONT-WEIGHT: bold; COLOR: #FFFFFF; TEXT-DECORATION: none}
					A.gateway:hover {FONT-WEIGHT: bold; COLOR: #ff6600; TEXT-DECORATION: none}
					
					A.link:Hover { COLOR:#800000; font-size: 8pt; font-family: Arial; text-decoration:none}
					A.link	{color:black; font-size: 8pt; font-family: Arial; text-decoration:none }	
					
					<!-- for the directory add-on-->
					A.cat {font-size: 18px; font-weight: bold; font-family: arial}
					A.subcat {font-size: 12px; font-weight: normal; font-family: arial}	
					A.trail {font-size: 12px; font-weight: normal; font-family: arial}
					
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
				<body  style="margin: 0px" margin="0" bgcolor="#ffffff">
					<div align="center">						
								
					<!-- START OF THE HEADER -->
					<!--
					<table border="0" width="800" cellspacing="0" cellpadding="0">
						<tr>
							<td><img src="skins/thirdeyedmachinev2/media/strike.gif" width="150" height="168" /></td>
							<td align="right">TEM</td>
						</tr>
					</table>-->
					<!-- END OF THE HEADER -->
					
					<img src="skins/thirdeyedmachinev2/media/banner.gif"/><br/>
					
					<!-- Design for the toolbar-->
					<xsl:call-template name="toolbar_global_design"/>
					
					<!--MENU bar-->
					<xsl:call-template name="menubar_macro"/>
					</div>
							
					<!-- Design of the main table -->
					<table border="0" cellpadding="0" cellspacing="1" width="800" bgcolor="#FFFFFF" align="center">
						<tr valign="top">
						  	<xsl:choose>
					    	
					    		 <!-- LEFT MARGIN --><!-- ADD-On  -->
								<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=1 or string-length(/siteinfo/pages/page[id=$id]/margintype)=0">									
									<td width="150">
										<img src="skins/thirdeyedmachine/media/dot.gif" width="150" height="1"/><br/>
										<xsl:call-template name="fullmargin_macro"/>
									</td>
									<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    		<td colspan="3"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
							    </xsl:when>
							   
							    <!-- RIGHT MARGIN -->
								<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=2">
									<td colspan="3"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
								    	<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
								    	<td width="150">
								    		<img src="skins/thirdeyedmachine/media/dot.gif" width="150" height="1"/><br/>
								    		<xsl:call-template name="fullmargin_macro"/>
								    	</td>
								</xsl:when>
																
								<!-- BOTH MARGIN -->
								<xsl:otherwise>									
									<td width="150">
										<img src="skins/thirdeyedmachine/media/dot.gif" width="150" height="1"/><br/>
										<xsl:call-template name="leftmargin_macro"/>
									</td>
								    	<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
								    	<td><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
								    	<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
								    	<td width="150">
								    		<img src="skins/thirdeyedmachinev2/media/dot.gif" width="150" height="1"/><br/>
								    		<xsl:call-template name="rightmargin_macro"/>
								    		<center><img src="skins/thirdeyedmachinev2/media/circle.gif"/></center>
								    	</td>
								</xsl:otherwise>
							</xsl:choose>	
							
					    	</tr>
					 </table>	
				<!-- End of the main table -->	
					
				<div align="center">			
				<!-- Design for the toolbar-->
				<xsl:call-template name="toolbar_global_design"/>
								
				<!-- Footer -->				
				<table border="0" cellpadding="0" cellspacing="1" width="800" align="center">
					<tr><td align="right"><font color="#ff0000"><xsl:call-template name="copyright_macro"/></font></td></tr>
				</table>
					
				</div>
				</body>
		
			</xsl:otherwise>
		</xsl:choose>
		
		</HTML>		

	</xsl:template>
</xsl:stylesheet>
