<?xml version="1.0" encoding="ISO-8859-1"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxml="urn:schemas-microsoft-com:xslt" xmlns:game="urn:schemas-cagle-com:game"    version="1.0" exclude-result-prefixes="msxml game">

	<xsl:output method="xml" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes"/>
			
	<!-- Include : variables et add-on  -->
	<xsl:include href="../common/macros.xsl"/>	
	<xsl:include href="skin.xsl"/>
	
	<!-- Original skin was created to fullxml 2.3 beta, and distributed by J.Roland -->
	<!-- Modified skin version to fullxml 2.4, by Eduardo Azambuja (eazambu) -->
	<!-- fullxml 2.4 (fxmods) settings, (eazambu) -->
	<!-- fullxml 2.4.2 (fxmods) Update Images and size, (Jorge Moises) -->

	<!-- General skin values -->
	<xsl:param name="general_font">Tahoma</xsl:param>
	<xsl:param name="body_background">#FFFFFF</xsl:param>
	<xsl:param name="body_color">#C0C000</xsl:param>

	<!-- Toolbar skin values -->
	<xsl:param name="toolbar_color"><xsl:value-of select="$body_background"/></xsl:param>
	<xsl:param name="toolbar_background">#7C7C29</xsl:param>
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
				
				<!-- Fullxml stylesheet -->
				<style>
					body,td,ul,ol,li,input,select,textarea,div,span,blockquote {
						  font : 8pt Verdana, Arial, Helvetica, sans-serif;
						  scrollbar-3dlight-color : #0E212A;
						  scrollbar-darkshadow-color : #0E212A;
						  scrollbar-highlight-color : #A2CEE3;
						  scrollbar-shadow-color : #3985AB;
						  scrollbar-arrow-color : #0E212A;
						  scrollbar-face-color : #82BCDA;
						}
									
					ul li, li {  list-style-image : url(skins/solardreamstudios/media/li.gif);}
									
					a,a:link,a:visited,a:active {  color : #0D4777;  font-weight : bold;  text-decoration : none;}
					a:hover {  color : #D7ECF5;  text-decoration : underline;}
					
					A.newsgroup,A.newsgroup:link, A.newsgroup:visited, A.newsgroup:active {	FONT-WEIGHT: bold; FONT-SIZE: 12px; COLOR: #7C7C29; TEXT-DECORATION: none}
					A.newsgroup:hover {COLOR: #7C7C29; TEXT-DECORATION: none	}
																			
					A.toolbar{FONT-WEIGHT: normal; COLOR: #ffffff; TEXT-DECORATION: none; font-size: 8px; text-transform: uppercase; }
					A.toolbar:Hover { FONT-WEIGHT: normal; COLOR: #ffffff; TEXT-DECORATION: none; font-size: 8px; text-transform: uppercase;}
					
					<!--a.menu, a.menu:link, a.menu:visited, a.menu:active {color : #000000;  font : normal 7pt Verdana, Arial, Helvetica, sans-serif;  cursor : hand;  width : 90px;  height : 15px;  position : relative;  left : 3px;  text-decoration : none;}
					a.menu:hover {	color : #000000;  font : normal 7pt Verdana, Arial, Helvetica, sans-serif;  cursor : hand;  width : 90px;  height : 15px;  position : relative;  left : 3px;  text-decoration : none;}
					-->
					a.menu, a.menu:link, a.menu:visited, a.menu:active {color : #000000;  font : normal 7pt Verdana,  cursor : hand; text-decoration : none; height : 15px;}
					a.menu:hover {color : #FFFFFF;  font : normal 7pt Verdana,  cursor : hand; text-decoration : none; background: #82BCDA; height : 15px;}

					
					A.gateway {FONT-WEIGHT: bold; COLOR: #000000; TEXT-DECORATION: none}
					A.gateway:hover {FONT-WEIGHT: bold; COLOR: #ff6600; TEXT-DECORATION: none}
					
					A.link:Hover { COLOR:#800000; font-size: 8pt; font-family: Arial; text-decoration:none}
					A.link	{color:black; font-size: 8pt; font-family: Arial; text-decoration:none }	
					
					hr {  color : #0E212A; height : 1px;}	
					
					input {background-color: #E9E988; color: #000000; font-size: 9px; font-weight: normal; font-family: Verdana; border: 1px #4C4C4C solid; filter: alpha(opacity=60);}
					select {background-color: #E9E988; color: #6B6B6B; font-size: 9px; font-weight: normal; font-family: Verdana; border: 1px #4C4C4C solid; filter: alpha(opacity=60);}
					textarea {background-color: #E9E988; color: #000000; font-size: 9px; font-weight: normal; font-family: Verdana; border: 1px #4C4C4C solid; filter: alpha(opacity=60);}
					
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
				<body bgcolor="#429AC6" text="#000000" link="#0D4777" vlink="#0D4777" alink="#0D4777" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
								
					<!-- START OF THE HEADER -->
					<center>
					<table width="720" border="0" cellspacing="0" cellpadding="0" align="center">
					  <tr> 
					    <td><img src="skins/solardreamstudios/media/left.gif" width="10" height="80"/></td>
					    <td bgcolor="#82BCDA"> 
					      <table width="700" border="0" cellspacing="0" cellpadding="0" background="skins/solardreamstudios/media/top_bg.gif">
					        <tr> 
					          <td width="216" height="80" valign="middle"><xsl:call-template name="titlebloc_macro"/></td>
					          <td width="0" valign="middle" align="right"><xsl:call-template name="advertisement_macro"/></td>
					        </tr>
					      </table>
					    </td>
					    <td><img src="skins/solardreamstudios/media/right.gif" width="10" height="80"/></td>
					  </tr>
					  <tr> 
					    <td><img src="skins/solardreamstudios/media/bl.gif" width="10" height="10"/></td>
					    <td><img src="skins/solardreamstudios/media/bottom.gif" width="700" height="10"/></td>
					    <td><img src="skins/solardreamstudios/media/br.gif" width="10" height="10"/></td>
					  </tr>
					</table>
					</center>	
					<!-- END OF THE HEADER -->
					
					<!-- Design for the toolbar-->
					<xsl:call-template name="toolbar_global_design"/>
							
					<!-- Design of the main table -->
					<table width="720" border="0" cellspacing="0" cellpadding="0" align="center">
						<tr valign="top">	<br/>				    	
					    		<xsl:choose>
								
								<!-- LEFT MARGIN --> <!-- ADD-ON  -->
								<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=1 or string-length(/siteinfo/pages/page[id=$id]/margintype)=0">
									<td width="120">
										<img src="Skins/solardreamstudios/media/dot.gif" width="120" height="1"/><br/>
										<xsl:call-template name="fullmargin_macro"/>
									</td>
								    	<td width="4"><img src="Skins/solardreamstudios/media/dot.gif" width="4" height="1"/><br/></td>
								    	<td width="576">
								    		<table width="576" border="0" cellspacing="0" cellpadding="0" align="center">
											<tr> 
											<td width="10"><img src="skins/solardreamstudios/media/tl.gif" width="10" height="10"/></td>
											<td width="596"><img src="skins/solardreamstudios/media/top.gif" width="576" height="10"/></td>
											<td width="10"><img src="skins/solardreamstudios/media/tr.gif" width="10" height="10"/></td>
											</tr>
											<tr> 
											<td background="skins/solardreamstudios/media/left.gif"><img src="skins/solardreamstudios/media/left.gif" width="10" height="5"/></td>
											<td valign="middle" bgcolor="#82BCDA"> 
												<xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/>
											</td>
											<td background="skins/solardreamstudios/media/right.gif"><img src="skins/solardreamstudios/media/right.gif" width="10" height="5"/></td>
											</tr>
											<tr> 
											<td><img src="skins/solardreamstudios/media/bl.gif" width="10" height="10"/></td>
											<td><img src="skins/solardreamstudios/media/bottom.gif" width="576" height="10"/></td>
											<td><img src="skins/solardreamstudios/media/br.gif" width="10" height="10"/></td>
											</tr>
										</table>								    		
								    	</td>			
									
							    </xsl:when>
							    
								<!-- RIGHT MARGIN -->
								<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=2">									
									<td width="100%" bgcolor="#FFFFFF"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
							    		<td width="15"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
							    		<td width="120" bgcolor="#f0f0f0">
							    			<img src="Skins/solardreamstudios/media/dot.gif" width="140" height="1"/><br/>
							    			<xsl:call-template name="fullmargin_macro"/>
							    		</td>
								</xsl:when>
								
								
								<!-- BOTH MARGIN -->
								<xsl:otherwise>									
									<td width="120">
										<img src="Skins/solardreamstudios/media/dot.gif" width="120" height="1"/><br/>
										<xsl:call-template name="leftmargin_macro"/>
									</td>
								    	<td width="4"><img src="Skins/solardreamstudios/media/dot.gif" width="4" height="1"/><br/></td>
								    	<td>
								    		<table width="472" border="0" cellspacing="0" cellpadding="0" align="center">
												<tr> 
													<td width="10"><img src="skins/solardreamstudios/media/tl.gif" width="10" height="10"/></td>
													<td width="452"><img src="skins/solardreamstudios/media/top.gif" width="452" height="10"/></td>
													<td width="10"><img src="skins/solardreamstudios/media/tr.gif" width="10" height="10"/></td>
												</tr>
												<tr> 
													<td background="skins/solardreamstudios/media/left.gif"><img src="skins/solardreamstudios/media/left.gif" width="10" height="5"/></td>
													<td valign="middle" bgcolor="#82BCDA"> 
														<xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/>
													</td>
													<td background="skins/solardreamstudios/media/right.gif"><img src="skins/solardreamstudios/media/right.gif" width="10" height="5"/></td>
												</tr>
												<tr> 
													<td><img src="skins/solardreamstudios/media/bl.gif" width="10" height="10"/></td>
													<td><img src="skins/solardreamstudios/media/bottom.gif" width="452" height="10"/></td>
													<td><img src="skins/solardreamstudios/media/br.gif" width="10" height="10"/></td>
												</tr>
										</table>								    		
								    	</td>
								    	<td width="4"><img src="Skins/solardreamstudios/media/dot.gif" width="4" height="1"/><br/></td>
								    	<td width="120">
								    		<img src="Skins/solardreamstudios/media/dot.gif" width="120" height="1"/><br/>
								    		<xsl:call-template name="rightmargin_macro"/>
								    	</td>
								</xsl:otherwise>
							</xsl:choose>					    		
					    		
					    </tr>
					 </table>	
				<!-- End of the main table -->	
				
				<br/>
				
				<!-- Footer -->	
				<table width="720" border="0" cellspacing="0" cellpadding="0" align="center">
					<tr> 
					<td width="10"><img src="skins/solardreamstudios/media/tl.gif" width="10" height="10"/></td>
					<td width="690"><img src="skins/solardreamstudios/media/top.gif" width="700" height="10"/></td>
					<td width="10"><img src="skins/solardreamstudios/media/tr.gif" width="10" height="10"/></td>
					</tr>
					<tr> 
					<td background="skins/solardreamstudios/media/left.gif"><img src="skins/solardreamstudios/media/left.gif" width="10" height="5"/></td>
					<td valign="middle" bgcolor="#82BCDA"> 
					<table border="0" width="100%">
					<tr> 
					<td width="100%" style="width:100%; color:#FFFFFF; filter:dropshadow(color=#000000, offx=1, offy=1)" align="center">
						<xsl:call-template name="copyright_macro"/></td></tr></table>
					</td>
					<td background="skins/solardreamstudios/media/right.gif"><img src="skins/solardreamstudios/media/right.gif" width="10" height="5"/></td>
					</tr>
					<tr> 
					<td><img src="skins/solardreamstudios/media/bl.gif" width="10" height="10"/></td>
					<td><img src="skins/solardreamstudios/media/bottom.gif" width="700" height="10"/></td>
					<td><img src="skins/solardreamstudios/media/br.gif" width="10" height="10"/></td>
					</tr>
				</table>							
			
				</body>
		
			</xsl:otherwise>
		</xsl:choose>
		
		</HTML>		

	</xsl:template>
</xsl:stylesheet>
