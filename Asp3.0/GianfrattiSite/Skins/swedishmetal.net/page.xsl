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
	<xsl:param name="body_background">#FFFFFF</xsl:param>
	<xsl:param name="body_color">#000000</xsl:param>

	<!-- Toolbar skin values -->
	<xsl:param name="toolbar_color"><xsl:value-of select="$body_background"/></xsl:param>
	<xsl:param name="toolbar_background">#000000</xsl:param>
	<xsl:param name="toolbar_border"><xsl:value-of select="$body_color"/></xsl:param>

	<!-- Margins skin values -->
	<xsl:param name="margin_background">#c0c0c0</xsl:param>
	<xsl:param name="margin_color">#01518C</xsl:param>

	<!-- Newsgroups skin values -->
	<xsl:param name="forum.header.bgcolor"><xsl:value-of select="$toolbar_background"/></xsl:param>
	<xsl:param name="forum.header.color"><xsl:value-of select="$body_background"/></xsl:param>

	<xsl:param name="forum.normal.row.bgcolor"><xsl:value-of select="$margin_background"/></xsl:param>
	<xsl:param name="forum.highlight.row.bgcolor">#CCCCCC</xsl:param>

	<xsl:param name="forum.new.thread.bgcolor"><xsl:value-of select="$margin_background"/></xsl:param>
	<xsl:param name="forum.new.thread.color"><xsl:value-of select="$toolbar_background"/></xsl:param>
	<xsl:param name="forum.new.thread.bordercolor"><xsl:value-of select="$toolbar_background"/></xsl:param>

	<!-- Event calendar skin values -->
	<xsl:param name="calendar_tableborder">#CCCCCC</xsl:param>
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

				<!-- Fullxml stylesheet -->
				<style>
					BODY, TABLE, TD, TR {FONT-SIZE: 10px; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; color: #999999; scrollbar-face-color: #333333; scrollbar-shadow-color: #4C4C4C; scrollbar-highlight-color: #4C4C4C; scrollbar-3dlight-color: #252323; scrollbar-darkshadow-color: #1F1F1F; scrollbar-track-color: #333333; scrollbar-arrow-color: #4C4C4C; font-family: Tahoma, Verdana, Courier;}
					
					A {	FONT-WEIGHT: normal; FONT-SIZE: 10px; COLOR: #c0c0c0}
					A:hover {COLOR: #CE4A08; TEXT-DECORATION: none	}
					
					A.newsgroup {	FONT-WEIGHT: bold; FONT-SIZE: 10px; COLOR: #c0c0c0; TEXT-DECORATION: none}
					A.newsgroup:hover {COLOR: #CE4A08; TEXT-DECORATION: none	}
																			
					A.toolbar{FONT-WEIGHT: bold; COLOR: #5A5A5A; filter:dropshadow(color=#000000, offx=1, offy=1);  TEXT-DECORATION: none; text-transform: uppercase;}
					A.toolbar:Hover { FONT-WEIGHT: bold; COLOR: #CE4A08; TEXT-DECORATION: none; text-transform: uppercase;}
					
					A.menu {FONT-WEIGHT: bold; COLOR: #999999; TEXT-DECORATION: none}
					A.menu:hover {	FONT-WEIGHT: bold; COLOR: #CE4A08; TEXT-DECORATION: none}
					
					A.gateway {FONT-WEIGHT: bold; COLOR: #c0c0c0; TEXT-DECORATION: none}
					A.gateway:hover {FONT-WEIGHT: bold; COLOR: #CE4A08; TEXT-DECORATION: none}
					
					A.link:Hover { COLOR:#c0c0c0; font-size: 8pt; font-family: Arial; text-decoration:none}
					A.link	{color:#CE4A08; font-size: 8pt; font-family: Arial; text-decoration:none }		
					
					<!-- for the directory add-on-->
					A.cat {font-size: 18px; font-weight: bold; font-family: verdana}
					A.subcat {font-size: 12px; font-weight: normal; font-family: verdana}	
					A.trail {font-size: 12px; font-weight: normal; font-family: verdana}
					
					<!-- Here you can customize the size of the eframe -->
					iframe.external{width: 100%; height: 600px;}

					
					input {background-color: #222222; color: #FFFFFF; font-size: 9px; font-weight: bold; font-family: arial; border: 1px #4C4C4C solid; filter: alpha(opacity=60);}
					select {background-color: #222222; color: #6B6B6B; font-size: 9px; font-weight: bold; font-family: arial; border: 1px #4C4C4C solid; filter: alpha(opacity=60);}
					textarea {background-color: #222222; color: #FFFFFF; font-size: 9px; font-weight: bold; font-family: arial; border: 1px #4C4C4C solid; filter: alpha(opacity=60);}
																				
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
				<body  style="margin: 0px" margin="0" background="Skins\swedishmetal.net\media\bg_2.gif">
								
					<!-- START OF THE HEADER -->
					<center>
					<table border="0" width="780" cellspacing="0" cellpadding="0" background="skins/swedishmetal.net/media/top.gif">
						<tr height="78">
							<td>
								<!--<img src="Skins\swedishmetal.net\media\barre.gif" alt="Thundering records"/>-->
								<table cellpadding="4" cellspacing="4" border="0">
									<tr>
										<td width="99%"><xsl:call-template name="titlebloc_macro"/></td>
										<td align="right" width="0"><img src="Skins/swedishmetal.net/media/dot.gif" width="1" height="10"/><br/><xsl:call-template name="advertisement_macro"/></td>
										<td width="0"><img src="Skins/swedishmetal.net/media/dot.gif" width="5" height="1"/></td>
									</tr>
								</table>
							</td>
							
						</tr>
					</table>
					</center>
						
					<!-- END OF THE HEADER -->
					
					<!-- Design for the toolbar-->
					<xsl:call-template name="toolbar_global_design"/>
							
					<!-- Design of the main table -->
					<table border="0" cellpadding="0" cellspacing="1" width="780" align="center" height="500" bgcolor="#424242">
						<tr valign="top" bgcolor="#000000">
							
					    	<xsl:choose>
								
								<!-- LEFT MARGIN --><!-- ADD-on -->
								<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=1 or string-length(/siteinfo/pages/page[id=$id]/margintype)=0">									
									<td width="140">
										<img src="Skins/swedishmetal.net/media/dot.gif" width="140" height="1"/><br/>
										<xsl:call-template name="fullmargin_macro"/>
									</td>
									<td width="4"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	<td width="100%"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
							    </xsl:when>
							    
								<!-- RIGHT MARGIN -->
								<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=2">									
									<td width="100%"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
							    		<td width="4"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    		<td width="140" bgcolor="#f0f0f0">
							    			<img src="Skins/swedishmetal.net/media/dot.gif" width="140" height="1"/><br/>
							    			<xsl:call-template name="fullmargin_macro"/>
							    		</td>
								</xsl:when>		
								
								<!-- BOTH MARGIN -->
								<xsl:otherwise>									
									<td width="140">
										<img src="Skins/swedishmetal.net/media/dot.gif" width="140" height="1"/><br/>
										<xsl:call-template name="leftmargin_macro"/>
									</td>
							    	<td width="4"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	<td><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
							    	<td width="4"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	<td width="140">
							    		<img src="Skins/swedishmetal.net/media/dot.gif" width="140" height="1"/><br/>
							    		<xsl:call-template name="rightmargin_macro"/>
							    	</td>
								</xsl:otherwise>
							</xsl:choose>					    		
					    		
					    </tr>
					 </table>	
				<!-- End of the main table -->	
				
				
				<!-- Footer -->	
				<center>			
				<table border="0" cellpadding="0" cellspacing="1" width="780" background="Skins\swedishmetal.net\media\bottom.gif">
					<tr> 
						<td height="24"> 
						<div align="center"><font color="white"><xsl:call-template name="copyright_macro"/></font></div>
						</td>
					</tr>
				</table></center>	
					
				</body>
		
			</xsl:otherwise>
		</xsl:choose>
		
		</HTML>		

	</xsl:template>
</xsl:stylesheet>
