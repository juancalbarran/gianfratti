<?xml version="1.0" encoding="ISO-8859-1"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxml="urn:schemas-microsoft-com:xslt" xmlns:game="urn:schemas-cagle-com:game"    version="1.0" exclude-result-prefixes="msxml game">

	<xsl:output method="html" indent="no" encoding="ISO-8859-1"/>
			
	<!-- Include : variables et add-on  -->
	<xsl:include href="../common/macros.xsl"/>	
	<xsl:include href="skin.xsl"/>
	
	<!--	
		THIS IS THE BASE TEMPLATE 
		========================
		ALL XSL:TEMPLATE WITH "_design" extension can be changed in the skin.xsl file wich can be found in the same directory
	-->
	
	<!-- General skin values -->	
	<xsl:param name="general_font">Verdana</xsl:param>
	<xsl:param name="body_background">#ffffff</xsl:param>
	<xsl:param name="body_color">#000000</xsl:param>

	<!-- Toolbar skin values -->
	<xsl:param name="toolbar_color">#ffffff</xsl:param>
	<xsl:param name="toolbar_background">#264B99</xsl:param>
	<xsl:param name="toolbar_border">#000000</xsl:param>
	
	<!-- Margins skin values -->
	<xsl:param name="margin_background">#dddddd</xsl:param>
	<xsl:param name="margin_color">#01518C</xsl:param>
	
	<!-- Newsgroups skin values -->
	<xsl:param name="forum.header.bgcolor">#264B99</xsl:param>
	<xsl:param name="forum.header.color">#ffffff</xsl:param>

	<xsl:param name="forum.normal.row.bgcolor">#f0f0f0</xsl:param>
	<xsl:param name="forum.highlight.row.bgcolor">#DDDDDD</xsl:param>

	<xsl:param name="forum.new.thread.bgcolor">#DDDDDD</xsl:param>
	<xsl:param name="forum.new.thread.color">#264B99</xsl:param>
	<xsl:param name="forum.new.thread.bordercolor">#264B99</xsl:param>

	<!-- Event calendar skin values -->
   	<xsl:param name="calendar_tableborder">#DDDDDD</xsl:param>
   	<xsl:param name="calendar_background">#ffffff</xsl:param>
   	<xsl:param name="calendar_weekdaybg">#DDDDDD</xsl:param>
   	<xsl:param name="calendar_currentdaybg">#DDDDDD</xsl:param>
		
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
				
				<!-- if user is in a chatroom  -->
				<xsl:if test="$channel and $ACT=93 and ($chatview='msg' or $chatview='user')">
					<META http-equiv="refresh" content="15"/>
				</xsl:if>

				<!-- Fullxml stylesheet -->
				<style>
					BODY, TABLE, TD, TR {CURSOR: url(Skins/blue/media/hp.cur); FONT-SIZE: x-small; FONT-FAMILY: Helvetica, sans-serif}
					
					A {	FONT-WEIGHT: normal; FONT-SIZE: 11px; COLOR: #0850A0}
					A:hover {COLOR: #ff6600; TEXT-DECORATION: none	}
					
					A.newsgroup {	FONT-WEIGHT: bold; FONT-SIZE: 11px; COLOR: #0850A0; TEXT-DECORATION: none}
					A.newsgroup:hover {COLOR: #ff6600; TEXT-DECORATION: none	}
																			
					A.toolbar{FONT-WEIGHT: bold; FONT-SIZE: 12px; COLOR: #ffffff; TEXT-DECORATION: none }
					A.toolbar:Hover { FONT-WEIGHT: bold; FONT-SIZE: 12px; COLOR: #ff6600; TEXT-DECORATION: none}
					
					A.menu {FONT-WEIGHT: bold; COLOR: #201460; TEXT-DECORATION: none}
					A.menu:hover {	FONT-WEIGHT: bold; COLOR: #ff6600; TEXT-DECORATION: none}
					
					A.gateway {FONT-WEIGHT: bold; COLOR: #000000; TEXT-DECORATION: none}
					A.gateway:hover {FONT-WEIGHT: bold; COLOR: #ff6600; TEXT-DECORATION: none}
					
					A.link:Hover { COLOR:#800000; font-size: 11px; font-family: Arial; text-decoration:none}
					A.link	{color:black; font-size: 11px; font-family: Arial; text-decoration:none }		
					<!-- for the directory add-on-->
					A.cat {font-size: 18px; font-weight: bold; font-family: Tahoma}
					A.subcat {font-size: 11px; font-weight: normal; font-family: Tahoma}	
					A.trail {font-size: 11px; font-weight: normal; font-family: Tahoma}

					input.mini {font-size: 11px; font-family: <xsl:value-of select="$general_font"/>; vspace:5; hspace:5 }
					
					blockquote {BORDER-RIGHT: #264B99 3px double; PADDING-RIGHT: 3px; BORDER-TOP: #264B99 3px double; PADDING-LEFT: 3px; BACKGROUND: #ddddd2; PADDING-BOTTOM: 3px; BORDER-LEFT: #264B99 3px double; PADDING-TOP: 3px; BORDER-BOTTOM: #264B99 3px double; }
					
					blockquote p {BORDER-RIGHT: #658b98 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #658b98 1px solid; PADDING-LEFT: 2px; BACKGROUND: #000080; PADDING-BOTTOM: 2px; MARGIN: 0px; BORDER-LEFT: #658b98 1px solid; COLOR: #fff; PADDING-TOP: 2px; BORDER-BOTTOM: #658b98 1px solid; TEXT-ALIGN: center; }
					
					pre {BORDER-RIGHT: #264B99 3px double; PADDING-RIGHT: 3px; BORDER-TOP: #264B99 3px double; PADDING-LEFT: 3px; BACKGROUND: #ddddd2; PADDING-BOTTOM: 3px; BORDER-LEFT: #264B99 3px double; PADDING-TOP: 3px; BORDER-BOTTOM: #264B99 3px double; }
					
					pre p {BORDER-RIGHT: #658b98 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #658b98 1px solid; PADDING-LEFT: 2px; BACKGROUND: #000080; PADDING-BOTTOM: 2px; MARGIN: 0px; BORDER-LEFT: #658b98 1px solid; COLOR: #fff; PADDING-TOP: 2px; BORDER-BOTTOM: #658b98 1px solid; TEXT-ALIGN: left; }
					
					FIELDSET {BORDER-RIGHT: #bbb 1px solid; PADDING-RIGHT: 5px; BORDER-TOP: #bbb 1px solid; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; MARGIN: 0px; BORDER-LEFT: #bbb 1px solid; PADDING-TOP: 5px; BORDER-BOTTOM: #bbb 1px solid; }
					
					FIELDSET P {MARGIN: 5px; TEXT-ALIGN: justify; }
					
					LEGEND {BORDER-RIGHT: #aaa 1px solid; FONT-WEIGHT: bold; PADDING-RIGHT: 5px; BORDER-TOP: #aaa 1px solid; PADDING-LEFT: 5px; FONT-SIZE: 13px; BACKGROUND: #eee; PADDING-BOTTOM: 5px; MARGIN: 0px 0px 5px; BORDER-LEFT: #aaa 1px solid; COLOR: #444; PADDING-TOP: 5px; BORDER-BOTTOM: #aaa 1px solid; LETTER-SPACING: 1px; }

					#airlock {BORDER-RIGHT: #bbb 3px double; BORDER-TOP: #bbb 3px double; BACKGROUND: #eeeeee; MARGIN: 10px 0px; BORDER-LEFT: #bbb 3px double; WIDTH: 100%; COLOR: #000; BORDER-BOTTOM: #bbb 3px double; TEXT-ALIGN: left}

					input.text {border:1px inset;width:120px}
					
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
				<body margin="10px" bgcolor="#555555">
								
					<!-- START OF THE HEADER -->
					
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="80px">
  <tr>
							
    <td style="BORDER-TOP: #4e89b7 3px double; BORDER-LEFT: #4e89b7 3px double; BORDER-RIGHT: #4e89b7 3px double; BACKGROUND: #477ba5; MARGIN: 0px; COLOR: #dddddd; BORDER-BOTTOM: #3e6d92 1px solid"><xsl:call-template name="titlebloc_macro"/></td>
							
    <td align="right" bgcolor="#000080"><xsl:call-template name="advertisement_macro"/></td>
						</tr>
					</table>
					
						
					<!-- END OF THE HEADER -->
					
					<!-- Design for the toolbar-->
					<xsl:call-template name="toolbar_global_design"/>
							
					<!-- Design of the main table -->
					<div id="airlock"><table border="0" bordercolor="#ffffff" cellpadding="1" cellspacing="0" width="99%" align="center" height="100%" bgcolor="#ffffff" style="BORDER-RIGHT: #aaa 3px double; margin: 0px 0px 5px 0px; BORDER-TOP: #aaa 3px double; BORDER-LEFT: #aaa 3px double; BORDER-BOTTOM: #aaa 3px double;">
						
  <tr valign="top"> <br/>
					    	
					    	<xsl:choose>
								
								<!-- LEFT MARGIN --><!-- ADD-ON  -->
								<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=1 or string-length(/siteinfo/pages/page[id=$id]/margintype)=0">									
									
    <td width="150"> <img src="admin/media/dot.gif" width="150" height="1"/><br/>
      <xsl:call-template name="fullmargin_macro"/> </td>
									
    <td width="0" bgcolor="#ffffff"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	<td width="100%" bgcolor="#ffffff"><xsl:call-template name="pagetitle_macro"/><br/><xsl:call-template name="pagebody_macro"/></td>
							    </xsl:when>
							    
								<!-- RIGHT MARGIN -->
								<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=2">									
									<td width="100%" bgcolor="#ffffff"><xsl:call-template name="pagetitle_macro"/><br/><xsl:call-template name="pagebody_macro"/></td>
							    		
    <td width="0" bgcolor="#ffffff"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    		<td width="150" bgcolor="#f0f0f0">
							    			<img src="admin/media/dot.gif" width="150" height="1"/><br/>
							    			<xsl:call-template name="fullmargin_macro"/>
							    		</td>
								</xsl:when>								
								
								<!-- BOTH MARGIN -->
								<xsl:otherwise>									
									
    <td width="150" bgcolor="#ffffff"> <img src="admin/media/dot.gif" width="150" height="1"/><br/>
      <xsl:call-template name="leftmargin_macro"/> </td>
							    	
    <td width="0" bgcolor="#ffffff"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	
    <td bgcolor="#ffffff"><xsl:call-template name="pagetitle_macro"/><br/>
      <xsl:call-template name="pagebody_macro"/></td>
							    	
    <td width="0" bgcolor="#ffffff"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    	
    <td width="150" bgcolor="#ffffff"> <img src="admin/media/dot.gif" width="150" height="1"/><br/>
      <xsl:call-template name="rightmargin_macro"/> </td>
								</xsl:otherwise>
							</xsl:choose>					    		
					    		
					    </tr>
					 </table></div>	
				<!-- End of the main table -->	
				
				
				<!-- Footer -->				
				<table border="0" cellpadding="0" cellspacing="1" width="100%" align="center">
					<tr><td background="skins/blue/media/center.jpg" height="30"> 
      <div align="center"><font color="white"><xsl:call-template name="copyright_macro"/></font></div>
						</td>
					</tr>
				</table>	
				<table style="border:3px double #f9f9f2; border-top:0" cellpadding="0" cellspacing="0" width="90%" align="center">
					<tr><td bgcolor="#dddddd" height="40" width="100%" valign="middle"> 
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
