<?xml version="1.0" encoding="iso-8859-1"?> 
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
	<xsl:param name="body_color">#C0C000</xsl:param>

	<!-- Toolbar skin values -->
	<xsl:param name="toolbar_color"><xsl:value-of select="$body_background"/></xsl:param>
	<xsl:param name="toolbar_background">#0066cc</xsl:param>
	<xsl:param name="toolbar_border"><xsl:value-of select="$body_color"/></xsl:param>

	<!-- Margins skin values -->
	<xsl:param name="margin_background">#edf6ff</xsl:param>
	<xsl:param name="margin_color">#01518C</xsl:param>

	<!-- Newsgroups skin values -->
	<xsl:param name="forum.header.bgcolor"><xsl:value-of select="$toolbar_background"/></xsl:param>
	<xsl:param name="forum.header.color"><xsl:value-of select="$body_background"/></xsl:param>

	<xsl:param name="forum.normal.row.bgcolor"><xsl:value-of select="$margin_background"/></xsl:param>
	<xsl:param name="forum.highlight.row.bgcolor">#99cdff</xsl:param>

	<xsl:param name="forum.new.thread.bgcolor"><xsl:value-of select="$margin_background"/></xsl:param>
	<xsl:param name="forum.new.thread.color"><xsl:value-of select="$toolbar_background"/></xsl:param>
	<xsl:param name="forum.new.thread.bordercolor"><xsl:value-of select="$toolbar_background"/></xsl:param>

	<!-- Event calendar skin values -->
	<xsl:param name="calendar_tableborder"><xsl:value-of select="$toolbar_background"/></xsl:param>
	<xsl:param name="calendar_background"><xsl:value-of select="$body_background"/></xsl:param>
	<xsl:param name="calendar_weekdaybg"><xsl:value-of select="$forum.highlight.row.bgcolor"/></xsl:param>
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

				<style>
					<!-- ELEMENT DE CSS OBLIGATOIRE  -->
					TD {FONT-SIZE: 10px; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif}					
					.menu {	FONT-WEIGHT: bold; COLOR: #201460; TEXT-DECORATION: none}	
					.input {	FONT-SIZE: 9px	}
					
					<!-- normal link -->
					A {	FONT-WEIGHT: normal; FONT-SIZE: 12px; COLOR: #1d63b8}
					A:hover {COLOR: #ff6600; TEXT-DECORATION: none	}		
					
					<!-- normal link -->
					A.newsgroup {	FONT-WEIGHT: bold; FONT-SIZE: 12px; COLOR: #1d63b8}
					A.newsgroup:hover {FONT-WEIGHT: bold; COLOR: #ff6600; TEXT-DECORATION: none	}				
								
					<!-- toolbar link and text-->		
					toolbar{FONT-WEIGHT: bold; FONT-SIZE: 8pt; COLOR: #ffffff; FONT-FAMILY: Verdana, Arial, Tahoma; TEXT-DECORATION: none }
					A.toolbar{FONT-WEIGHT: bold; FONT-SIZE: 8pt; COLOR: #ffffff; FONT-FAMILY: Verdana, Arial, Tahoma; TEXT-DECORATION: none }
					A.toolbar:Hover {COLOR: #f94b18; TEXT-DECORATION: none}
					
					<!-- menu link -->
					A.menu {FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #0066cc; FONT-FAMILY: Verdana, Arial, Tahoma}
					A.menu:hover {	FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #f94b18; FONT-FAMILY: Verdana, Arial, Tahoma}
						
					<!--  -->				
					A.link:Hover { COLOR:#800000; font-size: 8pt; font-family: Arial; text-decoration:none}
					A.link	{color:black; font-size: 8pt; font-family: Arial; text-decoration:none }
					
					<!-- for the directory add-on-->
					A.cat {font-size: 18px; font-weight: bold; font-family: Tahoma}
					A.subcat {font-size: 12px; font-weight: normal; font-family: Tahoma}	
					A.trail {font-size: 12px; font-weight: normal; font-family: Tahoma}

					
					<!-- Here you can customize the size of the eframe -->
					iframe.external{width: 100%; height: 600px;}

					
					<!-- ELEMENT SPECIFc to this SKIN-->
					.footer_links {FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #ffffff; FONT-FAMILY: Verdana, Arial, Tahoma}
					TD.footer_links {	FONT-WEIGHT: bold; FONT-SIZE: 8pt; COLOR: #ffffff; FONT-FAMILY: Verdana, Arial, Tahoma; TEXT-DECORATION: none}
					.footer_links:hover {	COLOR: #f94b18; TEXT-DECORATION: none}
					TD.blue_navigation  {FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #0066cc; FONT-FAMILY: Verdana, Arial, Tahoma}
					TD.main_navigation {FONT-WEIGHT: bold; FONT-SIZE: 8pt; COLOR: #0066cc; FONT-FAMILY: Verdana, Arial, Tahoma}
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
				<BODY bgColor="#ffffff" leftMargin="0" topMargin="0" marginwidth="0" marginheight="0">
					
					<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" height="100%">
								
					<!-- START OF THE HEADER -->
						<TR height="60">
							<TD bgColor="#99cdff">
								<TABLE cellSpacing="0" cellPadding="0" width="100%"><TR><TD><IMG height="1" src="skins/fuzzysoftware/media/spacer.gif" width="10"/><xsl:call-template name="titlebloc_macro"/></TD>
								<TD align="right"><xsl:call-template name="advertisement_macro"/></TD>
								<TD width="10"></TD></TR></TABLE>
							</TD></TR>
						<TR><TD bgColor="#ffffff" ></TD></TR>					 				
					 <!-- END OF THE HEADER -->
					
					
					<!-- Design for the toolbar-->
					<xsl:call-template name="toolbar_global_design"/>
									
					<!-- Design of the main table -->
					<tr height="100%">
						<td valign="top">
							<table cellpadding="2" cellspacing="2" border="0" height="100%">
								<tr height="100%">
									<xsl:choose>
								
										<!-- LEFT MARGIN --><!-- ADD-On  -->
										<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=1 or string-length(/siteinfo/pages/page[id=$id]/margintype)=0">
											<td width="156" valign="top">
												<img src="skins/fuzzysoftware/media/spacer.gif" width="156" height="1"/><BR/>
												<xsl:call-template name="fullmargin_macro"/>
											</td>
											<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
											<td vAlign="top" width="100%"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
										 </xsl:when>
										
										<!-- RIGHT MARGIN -->
										<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=2">	
											<td vAlign="top" width="100%"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
											<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
											<TD vAlign="top" width="152">		
												<img src="skins/fuzzysoftware/media/spacer.gif" width="152" height="1"/><BR/>
												<xsl:call-template name="fullmargin_macro"/>													
											</TD>
										</xsl:when>
																				
										<!-- BOTH MARGIN-->
										<xsl:otherwise>
											<td width="156" valign="top">
												<img src="skins/fuzzysoftware/media/spacer.gif" width="156" height="1"/><BR/>
												<xsl:call-template name="leftmargin_macro"/>
											</td>
											<td vAlign="top" width="100%"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
											<TD vAlign="top" width="152">		
												<img src="skins/fuzzysoftware/media/spacer.gif" width="152" height="1"/><BR/>
												<xsl:call-template name="rightmargin_macro"/>													
											</TD>
										</xsl:otherwise>
									</xsl:choose>
								</tr>
							</table>	
						</td>
					</tr>
				<!-- End of the main table -->	
				
				<!-- Footer -->	
					<TR>
						<TD bgColor="#99cdff">
							<TABLE cellSpacing="0" cellPadding="0" width="100%"><TR><TD><IMG height="1" src="skins/fuzzysoftware/media/spacer.gif" width="10"/></TD>
							<TD align="right"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></TD>
							<TD width="10"></TD></TR></TABLE>
						</TD></TR>
					<TR><TD bgColor="#ffffff" ></TD></TR>
					<TR>
					    <TD bgColor="#0066cc">
					     <TABLE cellSpacing="0" cellPadding="0" width="100%">					       
					     <TR><TD class="footer_links" align="center"><xsl:call-template name="copyright_macro"/></TD></TR></TABLE></TD></TR>	
				
				 </TABLE>	   
					
				</BODY>
		
			</xsl:otherwise>
		</xsl:choose>
		
		</HTML>		

	</xsl:template>
</xsl:stylesheet>
