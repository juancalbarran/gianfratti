<?xml version="1.0" encoding="utf-8"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxml="urn:schemas-microsoft-com:xslt" xmlns:game="urn:schemas-cagle-com:game"    version="1.0" exclude-result-prefixes="msxml game">

	<xsl:output method="html" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="no" encoding="ISO-8859-1"/>
			
	<!-- Include : variables et add-on  -->
	<xsl:include href="../common/macros.xsl"/>	
	<xsl:include href="skin.xsl"/>
	
	<!-- General skin values -->	
	<xsl:param name="general_font">Verdana</xsl:param>
	<xsl:param name="page_background">#e2e2d4</xsl:param>			 
	<xsl:param name="pagetitle_color">#6a7c52</xsl:param>			  

	<xsl:param name="title_background">#6a7c52</xsl:param>			
	<xsl:param name="title_color">#EEEEE2</xsl:param>			

	<xsl:param name="body_background">#EEEEE2</xsl:param>			
	<xsl:param name="body_color">#000000</xsl:param>
	<xsl:param name="bodytext_color">#000000</xsl:param>
	
	<xsl:param name="toolbar_color">#b2bfa0</xsl:param>
	<xsl:param name="toolbar_background">#6a7c52</xsl:param>
	<xsl:param name="toolbar_border">#666633</xsl:param>
	<xsl:param name="toolbar_highlight">#e2e2d4</xsl:param>
	
	<xsl:param name="margin_background">#EEEEE2</xsl:param>
	<xsl:param name="margin_color">#666633</xsl:param>
	
	<xsl:param name="header_background">#EEEEE2</xsl:param>
	<xsl:param name="headertext_color">#6a7c52</xsl:param>
	<xsl:param name="headerslogan_color">#666633</xsl:param>

	<xsl:param name="highlight_background">#EEEEE2</xsl:param>
	<xsl:param name="highlight_border">#b2bfa0</xsl:param>
	
	<xsl:param name="menutext_color">#6a7c52</xsl:param>
	<xsl:param name="menutext_highlight">#6a7c52</xsl:param>
	
	<xsl:param name="menuheadleft_background">#6a7c52</xsl:param>	
	<xsl:param name="menuheadleft_color">#e2e2d4</xsl:param>
	<xsl:param name="menuleft_background">#EEEEE2</xsl:param>
	<xsl:param name="main_background">#e2e2d4</xsl:param>
	<xsl:param name="main_border">#EEEEE2</xsl:param>

	<xsl:param name="menuheadright_background">#6a7c52</xsl:param>
	<xsl:param name="menuheadright_color">#e2e2d4</xsl:param>
	<xsl:param name="menuright_background">#EEEEE2</xsl:param>

	<xsl:param name="link_color">#999966</xsl:param>
	<xsl:param name="link_highlight">#999900</xsl:param>

	<xsl:param name="footer_background">#6a7c52</xsl:param>
	<xsl:param name="footer_color">#b2bfa0</xsl:param>

	<xsl:param name="border_main">#0</xsl:param>

	<xsl:param name="leftmargin_size">140</xsl:param>
	<xsl:param name="rightmargin_size">140</xsl:param>
			
	
	<!-- Newsgroups skin values -->
	<xsl:param name="forum.header.bgcolor">#6a7c52</xsl:param>
	<xsl:param name="forum.header.color">#EEEEE2</xsl:param>
	<xsl:param name="forum.normal.row.bgcolor">#f0f0f0</xsl:param>
	<xsl:param name="forum.highlight.row.bgcolor">#CCCCCC</xsl:param>
	<xsl:param name="forum.new.thread.bgcolor">#EEEEE2</xsl:param>
	<xsl:param name="forum.new.thread.color">#6a7c52</xsl:param>
	<xsl:param name="forum.new.thread.bordercolor">#6a7c52</xsl:param>

	<!-- Event calendar skin values -->
   	<xsl:param name="calendar_tableborder">#6a7c52</xsl:param>
   	<xsl:param name="calendar_background">#EEEEE2</xsl:param>
   	<xsl:param name="calendar_weekdaybg">#b2bfa0</xsl:param>
   	<xsl:param name="calendar_currentdaybg">#b2bfa0</xsl:param>


	<!--	
		THIS IS THE BASE TEMPLATE 
		========================
		ALL XSL:TEMPLATE WITH "_design" extension can be changed in the skin.xsl file wich can be found in the same directory
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
				
				<!-- if user is in a chatroom  -->
				<xsl:if test="$channel and $ACT=93 and ($chatview='msg' or $chatview='user')">
					<META http-equiv="refresh" content="15"/>
				</xsl:if>

				<!-- Fullxml stylesheet -->
				<style>
					BODY, TABLE, TD, TR {CURSOR: url(Skins/salco/media/hp.cur); FONT-SIZE: 10px; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif}
					
					A {	FONT-WEIGHT: normal; FONT-SIZE: 10px; COLOR: #6a7c52}
					A:hover {COLOR: #ff6600; TEXT-DECORATION: none	}
					
					A.newsgroup {	FONT-WEIGHT: bold; FONT-SIZE: 10px; COLOR: #6a7c52; TEXT-DECORATION: none}
					A.newsgroup:hover {COLOR: #ff6600; TEXT-DECORATION: none	}
																			
					A.toolbar{FONT-WEIGHT: bold; COLOR: #EEEEE2; TEXT-DECORATION: none; text-transform: uppercase; }
					A.toolbar:Hover { FONT-WEIGHT: bold; COLOR: #EEEEE2; TEXT-DECORATION: none; text-transform: uppercase;}
															
					A.menu {FONT-WEIGHT: bold; COLOR: #e2e2d4; TEXT-DECORATION: none}
					A.menu:hover {	FONT-WEIGHT: bold; COLOR: #6a7c52; TEXT-DECORATION: none}
					
					A.gateway {FONT-WEIGHT: bold; COLOR: #000000; TEXT-DECORATION: none}
					A.gateway:hover {FONT-WEIGHT: bold; COLOR: #ff6600; TEXT-DECORATION: none}
					
					A.link:Hover { COLOR:#800000; font-size: 10pt; font-family: Arial; text-decoration:none}
					A.link	{color:black; font-size: 10pt; font-family: Arial; text-decoration:none }
					
					<!-- for the directory add-on-->
					A.cat {font-size: 18px; font-weight: bold; font-family: Tahoma}
					A.subcat {font-size: 12px; font-weight: normal; font-family: Tahoma}	
					A.trail {font-size: 12px; font-weight: normal; font-family: Tahoma}
					
					input.mini {font-size: 10px; font-family: <xsl:value-of select="$general_font"/>; vspace:5; hspace:5 }
					
					blockquote {BORDER-RIGHT: #a0bfbf 3px double; PADDING-RIGHT: 3px; BORDER-TOP: #a0bfbf 3px double; PADDING-LEFT: 3px; BACKGROUND: #eeeee2; PADDING-BOTTOM: 3px; BORDER-LEFT: #a0bfbf 3px double; PADDING-TOP: 3px; BORDER-BOTTOM: #a0bfbf 3px double; }
					
					blockquote p {BORDER-RIGHT: #658b98 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #658b98 1px solid; PADDING-LEFT: 2px; BACKGROUND: #b2bfa0; PADDING-BOTTOM: 2px; MARGIN: 0px; BORDER-LEFT: #658b98 1px solid; COLOR: #fff; PADDING-TOP: 2px; BORDER-BOTTOM: #658b98 1px solid; TEXT-ALIGN: center; }
					
					pre {BORDER-RIGHT: #a0bfbf 3px double; PADDING-RIGHT: 3px; BORDER-TOP: #a0bfbf 3px double; PADDING-LEFT: 3px; BACKGROUND: #eeeee2; PADDING-BOTTOM: 3px; BORDER-LEFT: #a0bfbf 3px double; PADDING-TOP: 3px; BORDER-BOTTOM: #a0bfbf 3px double; }
					
					pre p {BORDER-RIGHT: #658b98 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #658b98 1px solid; PADDING-LEFT: 2px; BACKGROUND: #b2bfa0; PADDING-BOTTOM: 2px; MARGIN: 0px; BORDER-LEFT: #658b98 1px solid; COLOR: #fff; PADDING-TOP: 2px; BORDER-BOTTOM: #658b98 1px solid; TEXT-ALIGN: left; }
					
					<!-- Here you can customize the size of the eframe -->
					iframe.external{width: 100%; height: 600px;}
				</style>
			</HEAD>
		
		<xsl:choose>
			<xsl:when test="string-length(/siteinfo/data/gateway)&gt;0 and $gateway=1 and $ACT=0">
				<xsl:call-template name="gateway_design"></xsl:call-template>
			</xsl:when>
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
				<body  style="margin: 0px" margin="0" bgcolor="{$page_background}">
														
					<!-- START OF THE HEADER -->
					<table border="0" width="100%" cellspacing="0" cellpadding="0">
						<tr>
							<td><xsl:call-template name="titlebloc_macro"/></td>
							<td align="right"><xsl:call-template name="advertisement_macro"/></td>
						</tr>
					</table>
					<!-- END OF THE HEADER -->
					
					<!-- Design for the toolbar-->
					<xsl:call-template name="toolbar_global_design"/>
					
					<!--MENU bar-->
					<xsl:call-template name="menubar_macro"/>
							
					<!-- Design of the main table -->
					<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center" height="500" bgcolor="{$main_background}">
						<tr valign="top">
							<br/>
					    	
					    	<xsl:choose>
								
								<!-- LEFT MARGIN --><!-- ADD-ON  -->
								<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=1 or string-length(/siteinfo/pages/page[id=$id]/margintype)=0">									
									<td width="140">
										<img src="skins/default/media/dot.gif" width="140" height="1"/><br/>
										<xsl:call-template name="fullmargin_macro"/>
									</td>
									<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	<td width="100%"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
							    </xsl:when>
							    
								<!-- RIGHT MARGIN -->
								<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=2">									
									<td width="100%"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
							    		<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    		<td width="140" bgcolor="#f0f0f0">
							    			<img src="skins/default/media/dot.gif" width="140" height="1"/><br/>
							    			<xsl:call-template name="fullmargin_macro"/>
							    		</td>
								</xsl:when>								
								
								<!-- BOTH MARGIN -->
								<xsl:otherwise>									
									<td width="140">
										<img src="skins/default/media/dot.gif" width="140" height="1"/><br/>
										<xsl:call-template name="leftmargin_macro"/>
									</td>
							    	<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	<td><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
							    	<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	<td width="140">
							    		<img src="skins/default/media/dot.gif" width="140" height="1"/><br/>
							    		<xsl:call-template name="rightmargin_macro"/>
							    	</td>
								</xsl:otherwise>
							</xsl:choose>					    		
					    		
					    </tr>
					 </table>	
				<!-- End of the main table -->	
				
				
				<!-- Footer -->				
				<table border="0" cellpadding="0" cellspacing="1" width="100%" align="center">
					<tr> 
						<td bgcolor="#6a7c52" height="25"><div align="center"><font color="#b2bfa0"><b><xsl:call-template name="copyright_macro"/></b></font></div></td>
					</tr>
				</table>	
				<table cellpadding="0" cellspacing="0" width="100%" align="center">
					<tr><td height="40" width="100%" valign="middle"> 
      <div align="center"><font color="#555555"><a href="http://www.fullxml.com/" target="_blank"><b>FullXML</b></a> Powered Website. Skins Designed by <a href="http://www.salim.co.nr/" target="_blank"><b>Salim's Corner</b></a> - 2003.<br/>
      All logos and trademarks in this site are property of their respective owners. Opinions expressed in articles within this site are those of their owners and may not reflect site opinion. 
</font></div>
						</td>
					</tr>
				</table>	
				</body>
		
			</xsl:otherwise>
		</xsl:choose>
		
		</HTML>		

	</xsl:template>
</xsl:stylesheet>
