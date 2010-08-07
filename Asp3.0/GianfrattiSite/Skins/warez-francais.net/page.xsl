<?xml version="1.0" encoding="ISO-8859-1"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxml="urn:schemas-microsoft-com:xslt" xmlns:game="urn:schemas-cagle-com:game"    version="1.0" exclude-result-prefixes="msxml game">

	<xsl:output method="xml" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes"/>
			
	<!-- Include : variables et add-on  -->
	<xsl:include href="../common/macros.xsl"/>	
	<xsl:include href="skin.xsl"/>
	
	<!-- General skin values -->
	<xsl:param name="general_font">Verdana</xsl:param>
	<xsl:param name="body_background">#FFFFFF</xsl:param>
	<xsl:param name="body_color">#000000</xsl:param>

	<!-- Toolbar skin values -->
	<xsl:param name="toolbar_color"><xsl:value-of select="$body_background"/></xsl:param>
	<xsl:param name="toolbar_background">#845A9E</xsl:param>
	<xsl:param name="toolbar_border"><xsl:value-of select="$body_color"/></xsl:param>

	<!-- Margins skin values -->
	<xsl:param name="margin_background">#f0f0f0</xsl:param>
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

				<style>
				        Body {background-image: url(Skins/warez-francais.net/media/fond_image_tiscali.gif); FONT-SIZE: 10px; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;}
					 TABLE, TR, TD {FONT-SIZE: 10px; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;}
					
					A {	FONT-WEIGHT: normal; FONT-SIZE: 10px; COLOR: #1d63b8}
					A:hover {COLOR: #ff6600; TEXT-DECORATION: none	}
				
					A.newsgroup {	FONT-WEIGHT: bold; FONT-SIZE: 10px; COLOR: #662e86; TEXT-DECORATION: none}
					A.newsgroup:hover {COLOR: #ff6600; 	}
										
					A.toolbar{FONT-WEIGHT: bold; COLOR: #201460; TEXT-DECORATION: none }
					A.toolbar:Hover { FONT-WEIGHT: bold; COLOR: #ff6600; TEXT-DECORATION: none}
					
					A.menu {FONT-WEIGHT: bold; COLOR: #201460; TEXT-DECORATION: none}
					A.menu:hover {	FONT-WEIGHT: bold; COLOR: #ff6600; TEXT-DECORATION: none}
					
					
					A.link:Hover { COLOR:#800000; font-size: 8pt; font-family: Arial; text-decoration:none}
					A.link	{color:black; font-size: 8pt; font-family: Arial; text-decoration:none }
					
					<!-- for the directory add-on-->
					A.cat {font-size: 18px; font-weight: bold; font-family: verdana}
					A.subcat {font-size: 12px; font-weight: normal; font-family: verdana}	
					A.trail {font-size: 12px; font-weight: normal; font-family: verdana}
					
					<!-- Here you can customize the size of the eframe -->
					iframe.external{width: 100%; height: 600px;}
					
					.back {  background-attachment: fixed; background-image:  url(../img/fond.gif); background-repeat: no-repeat; background-position: center center}
					.rubflech2 {font-size: 9px; color: white; background-color: #662E86; font-weight: bold;text-transform: uppercase;}
					.rubflech3 {font-size: 9px; color: #662E86; font-weight: bold;text-transform: uppercase;}
					.rubflech4 {font-size: 9px; color: #662E86; background-color: #F8C555; font-weight: bold;text-transform: uppercase;}
					TD {FONT-SIZE: 10px; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif}
					.rub {	FONT-WEIGHT: bold; FONT-SIZE: 9px; COLOR: #ffffff;text-transform: uppercase;}					
					.menu {	FONT-WEIGHT: bold; COLOR: #201460; TEXT-DECORATION: none	}		
					//.input {FONT-SIZE: 9px	}					
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
				<body topmargin="3">
								
					<!-- START OF THE HEADER -->
					<div align="center"><center>
						<table border="0" width="100%" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%"><xsl:call-template name="titlebloc_macro"/></td>
								<td align="right"><xsl:call-template name="advertisement_macro"/></td>
							</tr>
						</table>
						<img src="Skins/warez-francais.net/media/dot.gif" width="1" height="6"/>
						</center></div>
					<!-- END OF THE HEADER -->
					
					<!-- Design for the toolbar-->
					<xsl:call-template name="toolbar_global_design"/>						
					
					<br/>
					
					<!-- Design of the main table -->
					<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
						<tr valign="top">
				    		
				    		<xsl:choose>
				    		
				    			 <!--LEFT MARGIN --><!-- ADD-On  -->
								<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=1 or string-length(/siteinfo/pages/page[id=$id]/margintype)=0">									
									<td width="140" background="skins/warez-francais.net/media/tram_services.gif">
										<img src="Skins/warez-francais.net/media/dot.gif" width="140" height="1"/><br/>
										<xsl:call-template name="fullmargin_macro"/>
									</td>
									<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	<td width="100%"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
							    </xsl:when>
								
								<!-- MARGE A DROITE -->
								<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=2">									
									<td width="100%" bgcolor="#FFFFFF"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
						    		<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
						    		<td width="140" bgcolor="#f0f0f0">
						    			<img src="Skins/warez-francais.net/media/dot.gif" width="140" height="1"/><br/>
						    			<xsl:call-template name="fullmargin_macro"/>
						    		</td>
								</xsl:when>								
								
								<!-- BOTH MARGINS -->
								<xsl:otherwise>
									<td width="140" background="skins/warez-francais.net/media/tram_services.gif">
										<img src="Skins/warez-francais.net/media/dot.gif" width="140" height="1"/><br/>
										<xsl:call-template name="leftmargin_macro"/>
									</td>
						    		<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
						    		<td width="100%"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
						    		<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
						    		<td width="140" bgcolor="#f0f0f0">
						    			<img src="Skins/warez-francais.net/media/dot.gif" width="140" height="1"/><br/>
						    			<xsl:call-template name="rightmargin_macro"/>
						    		</td>
								</xsl:otherwise>
							</xsl:choose>					    		
					    		
					    	</tr>
					 </table>
				<!-- End of the main table -->	
				
				<!-- Footer -->
				<table border="0" cellpadding="0" cellspacing="1" width="100%" align="center" bgcolor="#FFFFFF">
					<tr> 
						<td class="rubflech2" colspan="2" bgcolor="#662e86"> 
						<div align="right" class="rub"><xsl:call-template name="copyright_macro"/> </div>
						</td>
					</tr>
				</table>	
					
				</body>
		
			</xsl:otherwise>
		</xsl:choose>
		
		</HTML>		

	</xsl:template>
</xsl:stylesheet>
