<?xml version="1.0" encoding="utf-8"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxml="urn:schemas-microsoft-com:xslt" xmlns:game="urn:schemas-cagle-com:game" version="1.0" exclude-result-prefixes="msxml game" xml:space="preserve">
	
	<!-- include of personnalized skin -->
	<xsl:import href="../default/skin.xsl"/>
	
	<xsl:output method="html" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="no" encoding="ISO-8859-1"/>
			
	<!-- Include : variables et add-on  :: DO NOT TOUCH-->
	<xsl:include href="../common/macros.xsl"/>	
	<xsl:include href="skin.xsl"/>
	<!-- end include -->
	
	<!-- General skin values -->
	<xsl:param name="general_font">Verdana</xsl:param>
	<xsl:param name="body_background">#000000</xsl:param>
	<xsl:param name="body_color">#000000</xsl:param>

	<!-- Toolbar skin values -->
	<xsl:param name="toolbar_color"><xsl:value-of select="$body_background"/></xsl:param>
	<xsl:param name="toolbar_background">#cc3300</xsl:param>
	<xsl:param name="toolbar_border"><xsl:value-of select="$body_color"/></xsl:param>

	<!-- Margins skin values -->
	<xsl:param name="margin_background">#FFB233</xsl:param>
	<xsl:param name="margin_color">#000000</xsl:param>

	<!-- Newsgroups skin values -->
	<xsl:param name="forum.header.bgcolor"><xsl:value-of select="$toolbar_background"/></xsl:param>
	<xsl:param name="forum.header.color"><xsl:value-of select="$body_background"/></xsl:param>

	<xsl:param name="forum.normal.row.bgcolor"><xsl:value-of select="$margin_background"/></xsl:param>
	<xsl:param name="forum.highlight.row.bgcolor"><xsl:value-of select="$margin_background"/></xsl:param>

	<xsl:param name="forum.new.thread.bgcolor"><xsl:value-of select="$margin_background"/></xsl:param>
	<xsl:param name="forum.new.thread.color"><xsl:value-of select="$toolbar_background"/></xsl:param>
	<xsl:param name="forum.new.thread.bordercolor"><xsl:value-of select="$toolbar_background"/></xsl:param>

	<!-- Event calendar skin values -->
	<xsl:param name="calendar_tableborder"><xsl:value-of select="$toolbar_background"/></xsl:param>
	<xsl:param name="calendar_background">#FFCC66</xsl:param>
	<xsl:param name="calendar_weekdaybg"><xsl:value-of select="$forum.highlight.row.bgcolor"/></xsl:param>
	<xsl:param name="calendar_currentdaybg"><xsl:value-of select="$margin_background"/></xsl:param>

	
	<!--	
		THIS IS THE BASE TEMPLATE 
		========================
		ALL XSL:TEMPLATE WITH "_design" extension in their name can be changed in the skin.xsl file which can be found in the same directory
	-->
			
	<xsl:template match="/">
	
		<HTML dir="{$textdirection}" xmlns="http://www.w3.org/1999/xhtml">
			<HEAD>
				<META http-equiv="Content-Type" content="text/html; charset={/siteinfo/data/encoding}"/>
				<META name="Copyright" 	content="{/siteinfo/data/copyright}"/>
				<META name="Keywords" 	content="{/siteinfo/data/keywords}"/>
				<META name="Description" 	content="{/siteinfo/data/description}"/>
				<META name="GENERATOR" content="Fullxml 2.4 - http://www.fxmods.com"/>
				<TITLE><xsl:value-of select="/siteinfo/data/title" disable-output-escaping="yes"/></TITLE>
				<LINK rel="SHORTCUT ICON" href="media/favicon.ico"/>
				
				<!-- fullxml 2.4 (fxmods) settings, (eazambu) -->
				<!-- if user is in a chatroom  -->
				<xsl:if test="$channel and $ACT=93 and $chatview='ctrl'">
					<META http-equiv="refresh" content="15"/>
				</xsl:if>

				<!-- Fullxml stylesheet -->
				<style>
					BODY {FONT-SIZE: 11px; FONT-FAMILY: verdana; margin: 0px; color: #000000}

					TD {FONT-SIZE: 11px; FONT-FAMILY: <xsl:value-of select="$general_font"/>;}
					
					A {	FONT-WEIGHT: bold; FONT-SIZE: 11px; COLOR: #000000; font-family: verdana; }
					A:hover {TEXT-DECORATION: none	}
					
					A.newsgroup {	FONT-WEIGHT: bold; FONT-SIZE: 11px; COLOR: #0850A0; TEXT-DECORATION: none}
					A.newsgroup:hover {COLOR: #ff6600; TEXT-DECORATION: none	}
																			
					A.toolbar{ COLOR:#000000; FONT-WEIGHT: bold; TEXT-DECORATION: none; FONT-FAMILY: veradana,arial }
					A.toolbar:Hover { COLOR:#FFcc66; TEXT-DECORATION: none}
															
					A.menu { COLOR: <xsl:value-of select="$margin_color"/>; FONT-FAMILY; TEXT-DECORATION: none; font-size: 10px; text-transform: capitalize;}
					A.menu:hover { TEXT-DECORATION: none; font-weight:bold; color:#cc3300}
					
					A.gateway {FONT-WEIGHT: bold; COLOR: <xsl:value-of select="$toolbar_background"/>; TEXT-DECORATION: none}
					A.gateway:hover {}
					
					A.link:Hover { COLOR: <xsl:value-of select="$toolbar_background"/>; font-size: 8pt; text-decoration:none}
					A.link	{color:black; font-size: 8pt; text-decoration:none }
					
					<!-- for the directory add-on-->
					A.cat {font-size: 18px; font-weight: bold; font-family: Tahoma}
					A.subcat {font-size: 12px; font-weight: normal; font-family: Tahoma}	
					A.trail {font-size: 12px; font-weight: normal; font-family: Tahoma}
					input {background-color: #FFB233; color: #000000; font-size: 12px; font-weight: bold; font-family: arial; border: 1px #CCCCCC solid; vspace:5; hspace:5 }
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
				<body  margin="0" topmargin="0" leftmargin="0" bgcolor="#FFCC66">
														
					<!-- START OF THE HEADER -->
					<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td width="202" height="21" bgcolor="#cc3300"><!--<xsl:call-template name="titlebloc_macro"/>--></td><td rowspan="2" valign="bottom" bgcolor="#cc3300"><img src="skins/red_tech/media/002_r1_c2.gif" width="81" height="37" border="0" /></td><td rowspan="2" valign="bottom" bgcolor="#cc3300" width="100%"><img src="skins/red_tech/media/002_r1_c3.gif" width="100%" height="37" border="0" /></td><td><img src="skins/red_tech/media/dot.gif" width="1" height="21" border="0" /></td></tr>
<tr><td><img src="skins/red_tech/media/002_r2_c1.gif" width="202" height="16" border="0" /></td><td><img src="skins/red_tech/media/dot.gif" width="1" height="16" border="0" /></td></tr>
<tr><td colspan="2"><img src="skins/red_tech/media/002_r3_c1.gif" width="283" height="67" border="0" /></td><td bgcolor="#cc3300"><img src="skins/red_tech/media/002_r3_c3.gif" width="32" height="67" border="0" /><xsl:call-template name="advertisement_macro"/></td><td><img src="skins/red_tech/media/dot.gif" width="1" height="67" border="0" /></td></tr>
<tr><td colspan="2" valign="top"><img src="skins/red_tech/media/002_r4_c1.gif" width="283" height="32" border="0" /></td><td background="skins/red_tech/media/002_r4_c3.gif" align="right"><xsl:call-template name="toolbar_global_design"/></td><td><img src="skins/red_tech/media/dot.gif" width="1" height="32" border="0" /></td></tr>
</table>
					<!-- END OF THE HEADER -->
					
					
					
					<!--MENU bar -->
					<xsl:call-template name="menubar_macro"/>
							
					<!-- Design of the main table -->
					<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center" height="500" bgcolor="{$body_background}">
						<tr valign="top">
							
					    	
					    	<xsl:choose>
								
								<!-- LEFT MARGIN --><!-- ADD-ON  -->
								<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=1 or string-length(/siteinfo/pages/page[id=$id]/margintype)=0">									
									<td width="140" bgcolor="#FFB233">	<map name="home">
    <area shape="rect" coords="39,26,100,42" href="default.asp?id=1&amp;mnu=1" />
  </map> <img src="skins/red_tech/media/left-margin-top.gif" usemap="#home" border="0"/> <br/>
										<img src="skins/default/media/dot.gif" width="140" height="1"/><br/>
										<xsl:call-template name="fullmargin_macro"/>
									</td>
									<td width="15" bgcolor="#FFCC66"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	<td width="100%" bgcolor="#FFCC66"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
							    </xsl:when>
							    
								<!-- RIGHT MARGIN -->
								<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=2">									
									<td width="100%" bgcolor="#FFCC66"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
							    		<td width="15" bgcolor="#FFCC66"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    		<td width="140" bgcolor="#FFB233">
							    			<img src="skins/default/media/dot.gif" width="140" height="1"/><br/>
							    			<xsl:call-template name="fullmargin_macro"/>
							    		</td>
								</xsl:when>								
								
								<!-- BOTH MARGIN -->
								<xsl:otherwise>									<map name="home">
    <area shape="rect" coords="39,26,100,42" href="default.asp?id=1&amp;mnu=1" />
  </map>
									<td width="140" valign="top" bgcolor="#FFB233">
										 <img src="skins/red_tech/media/left-margin-top.gif" usemap="#home" border="0"/> <br/>    <img src="skins/default/media/dot.gif" width="140" height="1"/><br/>
										<xsl:call-template name="leftmargin_macro"/>
									</td>
							    	<td width="15" bgcolor="#FFCC66"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	<td bgcolor="#FFCC66" width="100%"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
							    	<td width="15" bgcolor="#FFCC66"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	<td width="140" bgcolor="#FFCC66">
							    		<img src="skins/default/media/dot.gif" width="140" height="1"/><br/>
							    		<xsl:call-template name="rightmargin_macro"/>
							    	</td>
								</xsl:otherwise>
							</xsl:choose>					    		
					    		
					    </tr>
					 </table>	
				<!-- End of the main table -->	
				
				
				<!-- Footer -->	
				<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" >
					<TR height="18"><td width="140" background="skins/red_tech/media/footer_left.gif"><img src="skins/red_tech/media/dot.gif" width="140" height="1" /></td><TD width="100%" background="skins/red_tech/media/footer_right.gif" align="center" valign="bottom"><font color="#FFFFFF"><xsl:call-template name="copyright_macro"/></font></TD></TR>
				</TABLE>	
				</body>
		
			</xsl:otherwise>
		</xsl:choose>
		
		</HTML>		

	</xsl:template>
</xsl:stylesheet>
