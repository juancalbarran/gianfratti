<?xml version="1.0" encoding="ISO-8859-1"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxml="urn:schemas-microsoft-com:xslt" xmlns:game="urn:schemas-cagle-com:game"    version="1.0" exclude-result-prefixes="msxml game">

	<!--<xsl:output method="html" indent="no" encoding="ISO-8859-1"/>-->
	<xsl:output method="xml" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes"/>
			
	<!-- Include : variables et add-on  -->
	<xsl:include href="../common/macros.xsl"/>	
	<xsl:include href="skin.xsl"/>

	<!-- Original skin was created to fullxml 2.3 beta, and distributed by J.Roland -->
	<!-- Modified skin version to fullxml 2.4, by Eduardo Azambuja (eazambu) -->
	<!-- fullxml 2.4 (fxmods) settings, (eazambu) -->

	<!-- General skin values -->
	<xsl:param name="general_font">Verdana</xsl:param>
	<xsl:param name="body_background">#000000</xsl:param>
	<xsl:param name="body_color">#FFFFFF</xsl:param>

	<!-- Toolbar skin values -->
	<xsl:param name="toolbar_color"><xsl:value-of select="$body_background"/></xsl:param>
	<xsl:param name="toolbar_background">#42A6DE</xsl:param>
	<xsl:param name="toolbar_border"><xsl:value-of select="$body_color"/></xsl:param>

	<!-- Margins skin values -->
	<xsl:param name="margin_background">#42A6DE</xsl:param>
	<xsl:param name="margin_color">#01518C</xsl:param>

	<!-- Newsgroups skin values -->
	<xsl:param name="forum.header.bgcolor"><xsl:value-of select="$toolbar_background"/></xsl:param>
	<xsl:param name="forum.header.color"><xsl:value-of select="$body_background"/></xsl:param>

	<xsl:param name="forum.normal.row.bgcolor"><xsl:value-of select="$margin_background"/></xsl:param>
	<xsl:param name="forum.highlight.row.bgcolor">#42A6DE</xsl:param>

	<xsl:param name="forum.new.thread.bgcolor"><xsl:value-of select="$margin_background"/></xsl:param>
	<xsl:param name="forum.new.thread.color"><xsl:value-of select="$toolbar_background"/></xsl:param>
	<xsl:param name="forum.new.thread.bordercolor"><xsl:value-of select="$toolbar_background"/></xsl:param>

	<!-- Event calendar skin values -->
	<xsl:param name="calendar_tableborder">#C0C0C0</xsl:param>
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
				BODY, TABLE, TD, TR {FONT-SIZE: 10px; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; COLOR: #FFFFFF;}
									
				A {	FONT-WEIGHT: normal; FONT-SIZE: 10px; COLOR: #57B3F3}
				A:hover {COLOR: #ff9900; TEXT-DECORATION: none	}
									
				A.newsgroup {FONT-WEIGHT: bold; FONT-SIZE: 10px; COLOR: #0850A0; TEXT-DECORATION: none}
				A.newsgroup:hover {COLOR: #ff9900; TEXT-DECORATION: none	}
				
				.titrepage{FONT-SIZE: 13px; FONT-WEIGHT: bold; COLOR: #57B3F3; TEXT-DECORATION: none; text-transform: uppercase; }
																						
				A.toolbar{FONT-WEIGHT: bold; COLOR: #ffffff; TEXT-DECORATION: none }
				A.toolbar:Hover { FONT-WEIGHT: bold; COLOR: #ff9900; TEXT-DECORATION: none}
				
				.menu {FONT-WEIGHT: bold; COLOR: #FFFFFF; TEXT-DECORATION: none}				
				A.menu {FONT-WEIGHT: bold; COLOR: #FFFFFF; TEXT-DECORATION: none}
				A.menu:hover {	FONT-WEIGHT: bold; COLOR: #ff9900; TEXT-DECORATION: none}
									
				A.gateway {FONT-WEIGHT: bold; COLOR: #000000; TEXT-DECORATION: none}
				A.gateway:hover {FONT-WEIGHT: bold; COLOR: #ff9900; TEXT-DECORATION: none}
									
				A.link:Hover { COLOR:#800000; font-size: 8pt; font-family: Arial; text-decoration:none}
				A.link	{color:black; font-size: 8pt; font-family: Arial; text-decoration:none }		
				
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

	
<!-- DEBUT BODY -->
<body  style="margin: 0px" margin="0" bgcolor="#000000"><DIV ALIGN="center">

<!-- TABLEAU TOP -->
<table border="0" width="800" cellspacing="0" cellpadding="0">
<tr>
<td><xsl:call-template name="titlebloc_macro"/></td>
<td align="right"><xsl:call-template name="advertisement_macro"/></td>
</tr>
</table>						
<!-- FIN TABLEAU TOP -->
	
					
<!-- DESIGN DE LA TOOLBAR-->
<xsl:call-template name="toolbar_global_design"/>
		
							
<!-- TABLEAU GENERAL TOOLBAR -->
<table border="0" cellpadding="0" cellspacing="0" width="800" height="500">
<tr valign="top">
<xsl:choose>
								
	<!-- AVEC MARGE A GAUCHE --><!-- ADD-ON  -->
	<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=1 or string-length(/siteinfo/pages/page[id=$id]/margintype)=0">									
	<td width="150">
	<img src="skins/jeddak/media/dot.gif" width="140" height="1"/><br/>
	<xsl:call-template name="fullmargin_macro"/>
	</td>
	<td width="15"><img src="skins/jeddak/media/dot.gif" width="15" height="1"/></td>
	<td width="635"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
	</xsl:when>
					
							    
	<!-- AVEC MARGE A DROITE -->
	<xsl:when test="/siteinfo/pages/page[id=$id]/margintype=2">									
	<td width="635"><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/></td>
	<td width="15"><img src="skins/jeddak/media/dot.gif" width="15" height="1"/></td>
	<td width="150">
	<img src="skins/jeddak/media/dot.gif" width="150" height="1"/><br/>
	<xsl:call-template name="fullmargin_macro"/>
	</td>
	</xsl:when>								
						
							
	<!-- AVEC LES DEUX MARGES -->
	<xsl:otherwise>									
	<td width="150">
	<xsl:call-template name="leftmargin_macro"/>
	</td>
	<td width="15"><img src="skins/jeddak/media/dot.gif" width="15" height="1"/></td>
	<td><xsl:call-template name="pagetitle_macro"/><xsl:call-template name="pagebody_macro"/><br/><br/></td>
	<td width="15"><img src="skins/jeddak/media/dot.gif" width="15" height="1"/></td>
	<td width="150">
	<img src="skins/jeddak/media/dot.gif" width="140" height="1"/><br/>
	<xsl:call-template name="rightmargin_macro"/>
	</td>
	</xsl:otherwise>
	</xsl:choose>					    		
	</tr>
	</table>	
<!-- FIN TABLEAU GANARAL TOOLBAR -->	
				
				
<!-- BOTTOM -->				
<table border="0" cellpadding="0" cellspacing="0" width="800">
<tr>
<TD width="7" height="32"><img src="skins/jeddak/media/b_toolbar_g.gif"/></TD>
<td background="skins/jeddak/media/f_toolbar2.gif" width="100%"> 
<div align="center"><font color="white"><xsl:call-template name="copyright_macro"/></font></div>
</td>
<TD width="7"><img src="skins/jeddak/media/b_toolbar_d.gif"/></TD>
</tr>
</table>
</DIV></body>
		
</xsl:otherwise>
</xsl:choose>
		
</HTML>		

</xsl:template>
</xsl:stylesheet>
