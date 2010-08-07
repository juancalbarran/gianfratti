<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="no" encoding="ISO-8859-1"/>
		
		
<!-- TABLEAU CONTENANT LE NOM DU SITE  -->
<xsl:template name="sitetile_design">
<xsl:param name="title"/>
<table><tr><td style="width:100%; color:#C0C000; filter:dropshadow(color=#000000, offX=1, offY=1)">
<font face="verdana" size="6" color="#ffffff"><b><i><xsl:copy-of select="$title" /></i></b></font>
</td></tr></table>
</xsl:template>
	
	
<!-- TABLEAU CONTANANT LE SLOGAN DU SITE  -->
<xsl:template name="siteslogan_design">
<xsl:param name="text"/>		
<table cellSpacing="0" cellPadding="0" border="0" align="center"><tr><td style="width:800; color:#C0C000; filter:dropshadow(color=#000000, offX=1, offY=1)">
<font color="#ffffff" size="2"><xsl:copy-of select="$text"/></font>
</td></tr></table>
</xsl:template>
	
	
<!-- DESIGN DU TITRE DE LA PAGE -->
<xsl:template name="pagetitle_design">
<xsl:param name="title"/>
<table cellSpacing="0" cellPadding="0" width="100%" border="0">
<tr>
<TD width="7"><img src="skins/jeddak/media/b_titre_g.gif"/></TD>
<td height="20" background="skins/jeddak/media/f_toolbar.gif"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
<span class="titrepage">
<!-- start uneditable zone -->
<xsl:choose>
<xsl:when test="contains($title, '&lt;')"><xsl:value-of select="$title" disable-output-escaping="yes"/></xsl:when>
<xsl:otherwise><xsl:copy-of select="$title" /></xsl:otherwise>
</xsl:choose>
<!-- end uneditable zone -->
</span>
</td>
<TD width="7"><img src="skins/jeddak/media/b_titre_d.gif"/></TD>
</tr>
</table>	
</xsl:template>
	
	
<!-- TITRE ARTICLE -->
<xsl:template name="title_design">
<xsl:param name="title"/>
<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
<TR><TD background="skins/jeddak/media/f_titre.gif" height="20" width="100%" class="menu"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
<!-- start uneditable zone -->
<xsl:choose>
<xsl:when test="contains($title, '&lt;')"><xsl:value-of select="$title" disable-output-escaping="yes"/></xsl:when>
<xsl:otherwise><xsl:copy-of select="$title" /></xsl:otherwise>
</xsl:choose>
<!-- end uneditable zone -->
</TD>
</TR>
</TABLE>			
</xsl:template>


<!-- DESIGN TABLEAU ARTICLE -->
<xsl:template name="normaltext_design">
<xsl:param name="text"/>
<TABLE cellSpacing="0" cellPadding="5" width="100%" border="0">
<TR><TD background="skins/jeddak/media/f_boite.gif" height="20" width="100%">
<!-- start uneditable zone -->
<xsl:choose>
<xsl:when test="contains($text, '&lt;')"><xsl:value-of select="$text" disable-output-escaping="yes"/></xsl:when>
<xsl:otherwise><xsl:copy-of select="$text" /></xsl:otherwise>
</xsl:choose>
<!-- end uneditable zone -->
</TD>
</TR>
</TABLE>	
</xsl:template>
	

<!-- EDITO PAGE (sous le titre de page ) -->
<xsl:template name="hightlightedtext_design">
<xsl:param name="text"/>	
<table cellSpacing="0" cellPadding="1" width="100%" border="0" bgcolor="42A6DE">
<tr><td>		
<table cellSpacing="0" cellPadding="0" border="0" width="100%">
<tr><td background="skins/jeddak/media/f_boite.gif">
	<table cellSpacing="0" cellPadding="5" border="0" width="100%">
	<tr><td>
<!-- start uneditable zone -->
<xsl:choose>
<xsl:when test="contains($text, '&lt;')"><xsl:value-of select="$text" disable-output-escaping="yes"/></xsl:when>
<xsl:otherwise><xsl:copy-of select="$text" /></xsl:otherwise>
</xsl:choose>
<!-- end uneditable zone -->
	</td></tr>
	</table>	
</td>
</tr>
</table>
</td>
</tr>
</table>	
</xsl:template>
	
	
<!-- DESIGN BOITES DE GAUCHE -->
<xsl:template name="margin_design">
<xsl:param name="title"/>
<xsl:param name="body"/>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr> 
<td width="100%"  height="20">
	<table width="100%" border="0" cellspacing="0" cellpadding="3">
	<tr><td background="skins/jeddak/media/f_titre.gif">
	<font color="#ffffff"><b>
	<!-- start uneditable zone -->
	<xsl:choose>
	<xsl:when test="contains($title, '&lt;')"><xsl:value-of select="$title" disable-output-escaping="yes"/></xsl:when>
	<xsl:otherwise><xsl:copy-of select="$title" /></xsl:otherwise>
	</xsl:choose>
	<!-- end uneditable zone -->
	</b></font>
	</td></tr></table>
</td>
</tr>
<tr>
<td width="100%" colspan="2" height="16">
	<table cellSpacing="0" cellPadding="1" width="100%" border="0" bgcolor="42A6DE">
	<tr><td>	
	<table width="100%" border="0" cellspacing="0" cellpadding="3">
	<tr><td background="skins/jeddak/media/f_boite.gif">
	<!-- start uneditable zone -->
	<xsl:choose>
	<xsl:when test="contains($body, '&lt;')"><xsl:value-of select="$body" disable-output-escaping="yes"/></xsl:when>
	<xsl:otherwise><xsl:copy-of select="$body" /></xsl:otherwise>
	</xsl:choose>
	<!-- end uneditable zone -->
	</td></tr></table>
	</td></tr></table>
</td></tr>
</table>		
<br/>
</xsl:template>
	
	
<!-- DESIGN BOITES DE DROITE -->
<xsl:template name="rightmargin_design">
<xsl:param name="title"/>
<xsl:param name="body"/>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr> 
<td class="rub" width="100%" height="20">
	<table width="100%" border="0" cellspacing="0" cellpadding="3">
	<tr><td background="skins/jeddak/media/f_titre.gif">
	<font color="#ffffff"><b>
	<!-- start uneditable zone -->
	<xsl:choose>
	<xsl:when test="contains($title, '&lt;')"><xsl:value-of select="$title" disable-output-escaping="yes"/></xsl:when>
	<xsl:otherwise><xsl:copy-of select="$title" /></xsl:otherwise>
	</xsl:choose>
	<!-- end uneditable zone -->
	</b></font>
	</td></tr>
	</table>
</td>
</tr>
<tr>
<td width="100%" colspan="2" height="16">
	<table cellSpacing="0" cellPadding="1" width="100%" border="0" bgcolor="42A6DE">
	<tr><td>	
	<table width="100%" border="0" cellspacing="0" cellpadding="3">
	<tr><td background="skins/jeddak/media/f_boite.gif">
	<!-- start uneditable zone -->
	<xsl:choose>
	<xsl:when test="contains($body, '&lt;')"><xsl:value-of select="$body" disable-output-escaping="yes"/></xsl:when>
	<xsl:otherwise><xsl:copy-of select="$body" /></xsl:otherwise>
	</xsl:choose>
	<!-- end uneditable zone -->
	</td></tr></table>
	</td></tr></table>
</td></tr>
</table>
</xsl:template>
		
	
<!-- Design of website gateway -->
<xsl:template name="gateway_design">
<table bgcolor="#FFFFFF" width="100%" height="100%" border="0">
<tr>
<td align="center">
<!-- start uneditable zone -->
<xsl:value-of select="/siteinfo/data/gateway" disable-output-escaping="yes"/><br/>
<a class="gateway" href="default.asp?id=1&amp;mnu=1"><xsl:value-of select="$string[257]"/></a>
<!-- end uneditable zone -->
</td></tr></table>		
</xsl:template>
	
	
<!-- DESIGN DE LA TOOLBAR -->
<xsl:template name="toolbar_global_design">
<TABLE cellSpacing="0" cellPadding="0" width="800" border="0">
<TR>
<TD width="7" height="32"><img src="skins/jeddak/media/b_toolbar_g.gif"/></TD>
<TD background="skins/jeddak/media/f_toolbar2.gif" align="right" width="100%">
<font color="#FFFFFF"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:call-template name="toolbar_body_macro"/></font></TD>
<TD width="7"><img src="skins/jeddak/media/b_toolbar_d.gif"/></TD>
</TR></TABLE>				
</xsl:template>	
	
	
<!-- DESIGN D'UN ELEMENT DE LA TOOLBAR -->
<xsl:template name="toolbar_item_design">
<xsl:param name="content"/>	
		
<!-- start uneditable zone -->
<xsl:choose>
<xsl:when test="contains($content, '&lt;')"><xsl:value-of select="$content" disable-output-escaping="yes"/></xsl:when>
<xsl:otherwise><xsl:copy-of select="$content" /></xsl:otherwise>
</xsl:choose>
<!-- end uneditable zone -->
 | 
</xsl:template>
	
	
<!-- DESIGN DU DERNIER ELEMENT DE LA TOOLBAR -->
<xsl:template name="toolbar_lastitem_design">
<xsl:param name="content"/>		
<!-- start uneditable zone -->
<xsl:choose>
<xsl:when test="contains($content, '&lt;')"><xsl:value-of select="$content" disable-output-escaping="yes"/></xsl:when>
<xsl:otherwise><xsl:copy-of select="$content" /></xsl:otherwise>
</xsl:choose>
<!-- end uneditable zone -->
<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
</xsl:template>
	
	
<!-- DESIGN D'UN ELEMENT DU MENU -->
<xsl:template name="menu_item_design">
<xsl:param name="content"/>	
<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b>::</b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
<!-- start uneditable zone -->
<xsl:choose>
<xsl:when test="contains($content, '&lt;')"><xsl:value-of select="$content" disable-output-escaping="yes"/></xsl:when>
<xsl:otherwise><xsl:copy-of select="$content" /></xsl:otherwise>
</xsl:choose>
<!-- end uneditable zone -->
<br/>
</xsl:template>	
	

<!-- DESIGN DU TITRE ARTICLE HEADLINE-->
<xsl:template name="headline_design">
	<xsl:param name="title"/>
	<xsl:param name="content"/>
					
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr> 
	<td background="skins/jeddak/media/f_toolbar.gif" height="20"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b>
		<!-- start uneditable zone -->
		<xsl:choose>
		<xsl:when test="contains($title, '&lt;')"><xsl:value-of select="$title" disable-output-escaping="yes"/></xsl:when>
		<xsl:otherwise><xsl:copy-of select="$title" /></xsl:otherwise>
		</xsl:choose>
		<!-- end uneditable zone -->
	</b>
	</td></tr></table>
	
	<table cellSpacing="0" cellPadding="1" width="100%" border="0" bgcolor="42A6DE">
	<tr><td>	
	<table border="0" cellpadding="5" cellspacing="0" width="100%">
	<tr> 
	<td bgcolor="1F3936">		
		<!-- start uneditable zone -->
		<xsl:choose>
		<xsl:when test="contains($content, '>')"><xsl:value-of select="$content" disable-output-escaping="yes"/></xsl:when>
		<xsl:otherwise><xsl:copy-of select="$content" /></xsl:otherwise>
		</xsl:choose>
		<!-- end uneditable zone -->
	</td></tr></table>
	</td></tr></table>
</xsl:template>

	<!-- Design of the menubar -->
	<xsl:template name="menubar_design">
		<!-- this block of javascript can be edited to change the display -->
		<![CDATA[
			timegap=500			// The time delay for menus to remain visible
			followspeed=5			// Follow Scrolling speed
			followrate=40			// Follow Scrolling Rate
			suboffset_top=10;		// Sub menu offset Top position 
			suboffset_left=10;		// Sub menu offset Left position
			
			style1=[					// style1 is an array of properties. You can have as many property arrays as you need. This means that menus can have their own style.
			"white",					// Mouse Off Font Color
			"black",					// Mouse Off Background Color
			"ff6600",				// Mouse On Font Color
			"000000",				// Mouse On Background Color
			"ffffff",					// Menu Border Color 
			12,						// Font Size in pixels
			"normal",				// Font Style (italic or normal)
			"bold",					// Font Weight (bold or normal)
			"Verdana, Arial",		// Font Name
			4,						// Menu Item Padding
			"",				        	// Sub Menu Image (Leave this blank if not needed)
			"ffffff",					// 3D Border & Separator bar
			"EFEFEF",				// 3D High Color
			"000099",				// 3D Low Color
			"000000",				// Current Page Item Font Color (leave this blank to disable)
			"EFEFEF",				// Current Page Item Background Color (leave this blank to disable)
			"",						// Top Bar image (Leave this blank to disable)
			"ffffff",					// Menu Header Font Color (Leave blank if headers are not needed)
			"000099",				// Menu Header Background Color (Leave blank if headers are not needed)
			]
						
			addmenu(menu=[	// This is the array that contains your menu properties and details
			"mainmenu",			// Menu Name - This is needed in order for the menu to be called
			85,					// Menu Top - The Top position of the menu in pixels
			2,					// Menu Left - The Left position of the menu in pixels
			,					// Menu Width - Menus width in pixels
			1,					// Menu Border Width 
			,					// Screen Position - here you can use "center;left;right;middle;top;bottom" or a combination of "center:middle"
			style1,				// Properties Array - this is set higher up, as above
			1,					// Always Visible - allows the menu item to be visible at all time (1=on/0=off)
			"left",				// Alignment - sets the menu elements text alignment, values valid here are: left, right or center
			effect2,				// Filter - Text variable for setting transitional effects on menu activation - see above for more info
			,					// Follow Scrolling - Tells the menu item to follow the user down the screen (visible at all times) (1=on/0=off)
			1, 					// Horizontal Menu - Tells the menu to become horizontal instead of top to bottom style (1=on/0=off)
			,					// Keep Alive - Keeps the menu visible until the user moves over another menu or clicks elsewhere on the page (1=on/0=off)
			,					// Position of TOP sub image left:center:right
			,					// Set the Overall Width of Horizontal Menu to 100% and height to the specified amount (Leave blank to disable)
			,					// Right To Left - Used in Hebrew for example. (1=on/0=off)
			,					// Open the Menus OnClick - leave blank for OnMouseover (1=on/0=off)
			,					// ID of the div you want to hide on MouseOver (useful for hiding form elements)
			,					// Reserved for future use
			,					// Reserved for future use
			,					// Reserved for future use ]]>
	</xsl:template>

</xsl:stylesheet>
