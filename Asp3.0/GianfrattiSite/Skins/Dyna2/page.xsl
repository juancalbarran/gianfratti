<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxml="urn:schemas-microsoft-com:xslt" xmlns:game="urn:schemas-cagle-com:game" version="1.0" exclude-result-prefixes="msxml game" xml:space="preserve">
	<!-- include of personnalized skin -->
	<xsl:import href="../default/skin.xsl"/>
	<xsl:output method="html" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="no" encoding="ISO-8859-1"/>
	<!-- Include : variables et add-on  :: DO NOT TOUCH-->
	<xsl:include href="../common/macros.xsl"/>
	<xsl:include href="skin.xsl"/>
	<!-- end include -->
	<!-- General variables default -->
	<xsl:param name="general_font">verdana</xsl:param>
	<xsl:param name="body_width">100%</xsl:param>
	<xsl:param name="leftmargin_size">170</xsl:param>
	<xsl:param name="rightmargin_size">180</xsl:param>
	<xsl:param name="body_align">center</xsl:param>
	<!-- Header variables default -->
	<xsl:param name="header_background">#FFFFFF</xsl:param>
	<xsl:param name="headertext_color">#666666</xsl:param>
	<xsl:param name="headertext_shadow">#FFFFFF</xsl:param>
	<xsl:param name="headerslogan_color">#333333</xsl:param>
	<xsl:param name="headerslogan_shadow">#EEEEEE</xsl:param>
	<!-- Header highlighted variables default -->
	<xsl:param name="highlight_background">#e0ebf7</xsl:param>
	<xsl:param name="highlight_border">#9fbfda</xsl:param>
	<!-- Page variables default -->
	<xsl:param name="page_background">#EEEEEE</xsl:param>
	<xsl:param name="pagetitle_color">#000099</xsl:param>
	<!-- Title variables default -->
	<xsl:param name="title_background">#000099</xsl:param>
	<xsl:param name="title_color">#FFFFFF</xsl:param>
	<!-- Body variables default -->
	<xsl:param name="body_background">#CCCCFF</xsl:param>
	<xsl:param name="body_color">#000000</xsl:param>
	<xsl:param name="bodytext_color">#000000</xsl:param>
	<xsl:param name="main_background">#FFFFFF</xsl:param>
	<xsl:param name="main_border">0</xsl:param>
	<!-- Toolbar variables default -->
	<xsl:param name="toolbar_color">#FFFFFF</xsl:param>
	<xsl:param name="toolbar_background">#999999</xsl:param>
	<xsl:param name="toolbar_background1">#F0F0F0</xsl:param>
	<xsl:param name="toolbar_background2">#333333</xsl:param>
	<xsl:param name="toolbar_highlight">#FF0000</xsl:param>
	<xsl:param name="toolbar_border">0</xsl:param>
	<xsl:param name="toolbar_align">right</xsl:param>
	<xsl:param name="toolbar_disp">top</xsl:param>
	<!-- Margin variables default -->
	<xsl:param name="margin_background">#CCCCCC</xsl:param>
	<xsl:param name="margin_color">#330066</xsl:param>
	<!-- Menu variables default -->
	<xsl:param name="menutext_color">#000000</xsl:param>
	<xsl:param name="menutext_highlight">#FF0000</xsl:param>
	<!-- Left menu variables default -->
	<xsl:param name="menuheadleft_background">#000099</xsl:param>
	<xsl:param name="menuheadleft_color">#FFFFFF</xsl:param>
	<xsl:param name="menuleft_background">#BBBBBB</xsl:param>
	<!-- Right menu variables default -->
	<xsl:param name="menuheadright_background">#000099</xsl:param>
	<xsl:param name="menuheadright_color">#FFFFFF</xsl:param>
	<xsl:param name="menuright_background">#BBBBBB</xsl:param>
	<!-- Link variables default -->
	<xsl:param name="link_color">#000099</xsl:param>
	<xsl:param name="link_highlight">#000000</xsl:param>
	<!-- Footer variables default -->
	<xsl:param name="footer_background">#F0F0F0</xsl:param>
	<xsl:param name="footer_background2">#333333</xsl:param>
	<xsl:param name="footer_color">#FFFFFF</xsl:param>
	<!-- Newsgroups skin values -->
	<xsl:param name="forum.header.bgcolor">#01518C</xsl:param>
	<xsl:param name="forum.header.color">#FFFFFF</xsl:param>
	<xsl:param name="forum.normal.row.bgcolor">#f0f0f0</xsl:param>
	<xsl:param name="forum.highlight.row.bgcolor">#CCCCCC</xsl:param>
	<xsl:param name="forum.new.thread.bgcolor">#f0f0f0</xsl:param>
	<xsl:param name="forum.new.thread.color">#01518C</xsl:param>
	<xsl:param name="forum.new.thread.bordercolor">#01518C</xsl:param>
	<!-- Event calendar skin values -->
	<xsl:param name="calendar_tableborder">#CCCCCC</xsl:param>
	<xsl:param name="calendar_background">#FFFFFF</xsl:param>
	<xsl:param name="calendar_weekdaybg">#CCCCCC</xsl:param>
	<xsl:param name="calendar_currentdaybg">#f0f0f0</xsl:param>
	<!--	
		THIS IS THE BASE TEMPLATE 
		========================
		ALL XSL:TEMPLATE WITH "_design" extension in their name can be changed in the skin.xsl file which can be found in the same directory
	-->
	<xsl:template match="/">
		<HTML dir="{$textdirection}" xmlns="http://www.w3.org/1999/xhtml">
			<HEAD>
				<META http-equiv="Content-Type" content="text/html; charset={/siteinfo/data/encoding}"/>
				<META name="Copyright" content="{/siteinfo/data/copyright}"/>
				<META name="Keywords" content="{/siteinfo/data/keywords}"/>
				<META name="Description" content="{/siteinfo/data/description}"/>
				<META name="GENERATOR" content="Aunel webdesign"/>
				<TITLE>
					<xsl:value-of select="/siteinfo/data/title" disable-output-escaping="yes"/>
				</TITLE>
				<LINK rel="SHORTCUT ICON" href="media/favicon.ico"/>
				<!-- if user is in a chatroom  -->
				<xsl:if test="$channel and $ACT=93 and ($chatview='msg' or $chatview='user')">
					<META http-equiv="refresh" content="15"/>
				</xsl:if>
				<!-- Fullxml stylesheet -->
				<style>
					BODY, TABLE, TD, TR, INPUT {FONT-SIZE: 10px; FONT-FAMILY: <xsl:value-of select="$general_font"/>}
					
					A {	FONT-WEIGHT: normal; FONT-SIZE: 10px; COLOR: <xsl:value-of select="$link_color"/>; font-family: <xsl:value-of select="$general_font"/>}
					A:hover {COLOR: <xsl:value-of select="$link_highlight"/>; TEXT-DECORATION: none	}
					
					A.newsgroup {	FONT-WEIGHT: bold; FONT-SIZE: 10px; COLOR: <xsl:value-of select="$toolbar_background"/>; TEXT-DECORATION: none}
					A.newsgroup:hover {TEXT-DECORATION: underline }
																			
					A.toolbar{ FONT-WEIGHT: bold; COLOR: <xsl:value-of select="$toolbar_color"/>; TEXT-DECORATION: none; FONT-FAMILY: <xsl:value-of select="$general_font"/> }
					A.toolbar:Hover {FONT-WEIGHT: bold; COLOR: <xsl:value-of select="$toolbar_highlight"/>; TEXT-DECORATION: none}

					A.menu {FONT-WEIGHT: bold; COLOR: <xsl:value-of select="$menutext_color"/>; FONT-FAMILY; TEXT-DECORATION: none;}
					A.menu:hover {FONT-WEIGHT: bold; COLOR: <xsl:value-of select="$menutext_highlight"/>; TEXT-DECORATION: underline;}
					
					A.gateway {FONT-WEIGHT: bold; COLOR: <xsl:value-of select="$toolbar_background"/>; TEXT-DECORATION: none}
					A.gateway:hover {}
					
					A.link:      { COLOR: <xsl:value-of select="$link_color"/>; font-size: 8pt; FONT-FAMILY: <xsl:value-of select="$general_font"/>; text-decoration:none}
					A.link:Hover { COLOR <xsl:value-of select="$link_highlight"/>; font-size: 8pt; FONT-FAMILY: <xsl:value-of select="$general_font"/>; text-decoration:none}

  	<!-- v.241 start -->
					input.mini {font-size: 9px; font-family: <xsl:value-of select="$general_font"/>; vspace:5; hspace:5 }
  	<!-- v.241 slut -->
					button.inpButton {width: 100px;}
					input.inpText {width: 300px;}
					textarea.inpTextarea{width: 300px; height: 100px}
					
					<!-- for the directory add-on-->
					A.cat {font-size: 18px; font-weight: bold; font-family: <xsl:value-of select="$general_font"/>;}
					A.subcat {font-size: 12px; font-weight: normal; font-family: <xsl:value-of select="$general_font"/>;}	
					A.trail {font-size: 12px; font-weight: normal; font-family: <xsl:value-of select="$general_font"/>;}	
					
					<!-- Here you can customize the size of the eframe -->
					iframe.external{width: 100%; height: 580px;}																			
				</style>
			</HEAD>
			<xsl:choose>
				<xsl:when test="string-length(/siteinfo/data/gateway)&gt;0 and $gateway=1 and $ACT=0">
					<xsl:call-template name="gateway_design"/>
				</xsl:when>
				<xsl:when test="$channel and $channel!='new' and $ACT=93">
					<xsl:call-template name="pagebody_macro"/>
				</xsl:when>
				<xsl:when test="$ACT=4 and $content='easylink' or $layout='printer'">
					<body margin="0" bgcolor="{$body_background}">
						<xsl:call-template name="pagebody_macro"/>
					</body>
				</xsl:when>
				<xsl:otherwise>
					<!-- Start edit here -->
					<body style="margin: 0px" margin="0" bgcolor="{$body_background}">
				
					<!-- Body tabele start -->
							<table border="0" align="{$body_align}" width="{$body_width} " cellspacing="0" cellpadding="0" bgcolor="{$main_background}">
							<tr>
								<td>
									<!-- Toolbar if "top" in placement parameter-->
									<xsl:if test="$toolbar_disp='top'"><xsl:call-template name="toolbar_global_design"/></xsl:if>
									<xsl:if test="$toolbar_disp='topbottom'"><xsl:call-template name="toolbar_global_design"/></xsl:if>
									<!-- START OF THE HEADER -->
									<table border="0" width="100% " cellspacing="0" cellpadding="0" background="skins/default/media/bgtop.gif">
										<tr height="50" valign="top">
											<td align="left" width="400">
												<xsl:call-template name="titlebloc_macro"/>
											</td>
											<td align="right" valign="baseline" width="0">
												<xsl:call-template name="advertisement_macro"/>
											</td>
										</tr>
									</table>
									<!-- END OF THE HEADER -->
									<!-- Toolbar if "middel" in placement parameter-->
									<xsl:if test="$toolbar_disp='middel'"><xsl:call-template name="toolbar_global_design"/></xsl:if>

									<!--MENU bar-->
									<xsl:call-template name="menubar_macro"/>
									<!-- Design of the main table -->
									<table border="0" cellpadding="0" cellspacing="0" width="100% " height="500" bgcolor="{$main_background}">
										<tr valign="top" bgcolor="{$main_background}">
											
											<xsl:choose>
												<!-- LEFT MARGIN -->
												<!-- ADD-ON  -->
												<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=1 or string-length(/siteinfo/pages/page[id=$id]/margintype)=0">
													<td width="{$leftmargin_size}">
														<img src="skins/default/media/dot.gif" width="{$leftmargin_size}" height="1"/>
														<xsl:call-template name="fullmargin_macro"/>
													</td>
													<td width="15">
														<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
													</td>
													<td width="100%" bgcolor="{$main_background}">
														<xsl:call-template name="pagetitle_macro"/>
														<xsl:call-template name="pagebody_macro"/>
													</td>
												</xsl:when>
												<!-- RIGHT MARGIN -->
												<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=2">
													<td width="100%" bgcolor="{$main_background}">
														<xsl:call-template name="pagetitle_macro"/>
														<xsl:call-template name="pagebody_macro"/>
													</td>
													<td width="15">
														<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
													</td>
													<td width="{$rightmargin_size}" bgcolor="{$margin_background}">
														<img src="skins/default/media/dot.gif" width="{$rightmargin_size}" height="1"/>
														<br/>
														<xsl:call-template name="fullmargin_macro"/>
													</td>
												</xsl:when>
												<!-- BOTH MARGIN -->
												<xsl:otherwise>
													<td width="{$leftmargin_size}">
														<img src="skins/default/media/dot.gif" width="{$leftmargin_size}" height="1"/>
														
														<xsl:call-template name="leftmargin_macro"/>
													</td>
													<td width="15">
														<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
													</td>
													<td>
														<xsl:call-template name="pagetitle_macro"/>
														<xsl:call-template name="pagebody_macro"/>
													</td>
													<td width="15">
														<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
													</td>
													<td width="{$rightmargin_size}">
														<img src="skins/default/media/dot.gif" width="{$rightmargin_size}" height="1"/>
														
														<xsl:call-template name="rightmargin_macro"/>
													</td>
												</xsl:otherwise>
											</xsl:choose>
										</tr>
									</table>
									<!-- End of the main table -->
									<!-- Toolbar if "bottom" in placement parameter-->
									<xsl:if test="$toolbar_disp='bottom'"><xsl:call-template name="toolbar_global_design"/></xsl:if>
									<xsl:if test="$toolbar_disp='topbottom'"><xsl:call-template name="toolbar_global_design"/></xsl:if>
									<!-- Footer -->
									<table border="0" cellpadding="0" cellspacing="0" width="100%" >
										<tr>
											<td style="FILTER: progid:DXImageTransform.Microsoft.Gradient(endColorstr='{$footer_background2}', startColorstr='{$footer_background}', gradientType='1'" height="20">
												<div align="center">
													<font color="{$footer_color}">
														<xsl:call-template name="copyright_macro"/>
													</font>
												</div>
											</td>
										</tr>
									</table>
					<!-- Body tabele end -->			
							</td>
							</tr>
						</table>
					
					</body>
				</xsl:otherwise>
			</xsl:choose>
		</HTML>
	</xsl:template>
</xsl:stylesheet>
