<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="no" encoding="ISO-8859-1"/>
		
		
	<!-- Design of site title  -->
	<xsl:template name="sitetile_design">
		<xsl:param name="title"/>
		<font face="verdana" size="6" color="#ffffff"><b><i><xsl:copy-of select="$title" /></i></b></font>
	</xsl:template>
	
	
	<!-- Design of site slogan  -->
	<xsl:template name="siteslogan_design">
		<xsl:param name="text"/>		
		<table><tr><td style="width:100%; color:#C0C000; filter:dropshadow(color=#000000, offX=1, offY=1)"><font color="#ffffff"><xsl:copy-of select="$text"/></font></td></tr></table>
		<!--<font color="#ffffff"><xsl:copy-of select="$text"/></font>-->
	</xsl:template>
	
	
	<!-- Design of the page title -->
	<xsl:template name="pagetitle_design">
		<xsl:param name="title"/>
			
			<font color="#000000" size="5"><b>
				<!-- start uneditable zone -->
				.<xsl:choose>
					<xsl:when test="contains($title, '&lt;')"><xsl:value-of select="$title" disable-output-escaping="yes"/></xsl:when>
					<xsl:otherwise><xsl:copy-of select="$title" /></xsl:otherwise>
				</xsl:choose>
				<!-- end uneditable zone -->
			</b></font>
			<br/><img src="skins/microsoft/media/line.gif"/><p/>			
	</xsl:template>
	
	
	<!-- Design of a normal title -->
	<xsl:template name="title_design">
		<xsl:param name="title"/>
		
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
		<tr>
		    <td>
		        <img src="skins/microsoft/media/offupdat.gif" hspace="2"/>
		           <b><span style="font-size: 12px; font-weight: bold">
        			<!-- start uneditable zone -->
        			<xsl:choose>
        				<xsl:when test="contains($title, '&lt;')"><xsl:value-of select="$title" disable-output-escaping="yes"/></xsl:when>
        				<xsl:otherwise><xsl:copy-of select="$title" /></xsl:otherwise>
        			</xsl:choose>
        			<!-- end uneditable zone -->
        		</span></b>
		    </td>
		 </tr>
		 <tr><td bgcolor="#6699CC"><img src="skins/default/media/dot.gif" width="1" height="1"/></td></tr>
		</table>
	</xsl:template>


	<!-- Design of normal text -->
	<xsl:template name="normaltext_design">
		<xsl:param name="text"/>
		<span style="font-size: 10px">
		<!-- start uneditable zone -->
			<xsl:choose>
				<xsl:when test="contains($text, '&lt;')"><xsl:value-of select="$text" disable-output-escaping="yes"/></xsl:when>
				<xsl:otherwise><xsl:copy-of select="$text" /></xsl:otherwise>
			</xsl:choose>
		<!-- end uneditable zone -->
		</span>
	</xsl:template>
	

	<!-- Design of highlighted text -->
	<xsl:template name="hightlightedtext_design">
		<xsl:param name="text"/>			
			<span style="color: #000000; font-size: 10px;">
			       <!-- start uneditable zone -->
        			<xsl:choose>
        				<xsl:when test="contains($text, '&lt;')"><xsl:value-of select="$text" disable-output-escaping="yes"/></xsl:when>
        				<xsl:otherwise><xsl:copy-of select="$text" /></xsl:otherwise>
        			</xsl:choose>
        		        <!-- end uneditable zone -->
	                </span>		     
    </xsl:template>
	
	
	<!-- Design of a left-margin box -->
	<xsl:template name="margin_design">
		<xsl:param name="title"/>
		<xsl:param name="body"/>
		
		<table class="flyoutMenu" width="100%" cellpadding="2" cellspacing="0" border="0" style="border-top-width: 1px; border-right-width: 0px;border-bottom-width: 0px">
		<tr><td>
                <table width="176" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td class="flyoutHeading">
                            <!-- start uneditable zone -->
				<xsl:choose>
					<xsl:when test="contains($title, '&lt;')"><xsl:value-of select="$title" disable-output-escaping="yes"/></xsl:when>
					<xsl:otherwise><xsl:copy-of select="$title" /></xsl:otherwise>
				</xsl:choose>
				<!-- end uneditable zone -->
			</td></tr></table>			
	            	<!-- start uneditable zone -->
			<xsl:choose>
				<xsl:when test="contains($body, '&lt;')"><xsl:value-of select="$body" disable-output-escaping="yes"/></xsl:when>
				<xsl:otherwise><xsl:copy-of select="$body" /></xsl:otherwise>
			</xsl:choose>
			<!-- end uneditable zone -->
	        </td></tr></table>
	</xsl:template>
	
	
	<!-- Design of a right-margin box -->
	<xsl:template name="rightmargin_design">
		<xsl:param name="title"/>
		<xsl:param name="body"/>
			
			
		<xsl:variable name="uid" select="position()"/>
	      
	      <TABLE cellSpacing="5" cellPadding="0" border="0"><TBODY><TR><TD class="DashPartSpacing"></TD></TR></TBODY></TABLE>
            <DIV id="HPFrame{$uid}Holder" style="DISPLAY: none; HEIGHT: 0px"></DIV>
            <DIV class="divMoveClass" id="divPart14{$uid}" valign="top" width="100%">
            <DIV id="HPFrame{$uid}"><table width="140px" border="0" cellpadding="0" cellspacing="0px"><tr><td>
            <table class="HPFrameTab" width="100%" border="0" cellpadding="0" cellspacing="0" style="cursor:hand" onmouseover="setBorder('HPFrame{$uid}',true);" onmouseout="setBorder('HPFrame{$uid}',false);">
            <tr id="HPFrame{$uid}Tab" valign="middle" bgcolor="#CCCCCC">
            <td align="right"><img id="HPFrame{$uid}Tab1" src="skins/microsoft/media/curve.gif" alt="" border="0" /></td>
            <td align="left" width="100%" height="10">
            <font id="HPFrame{$uid}Tab2" face="verdana,arial,helvetica" size="1" color="#336699">
            <B>
                <!-- start uneditable zone -->
			<xsl:choose>
				<xsl:when test="contains($title, '&lt;')"><xsl:value-of select="$title" disable-output-escaping="yes"/></xsl:when>
				<xsl:otherwise><xsl:copy-of select="$title" /></xsl:otherwise>
			</xsl:choose>
			<!-- end uneditable zone -->
            </B>
            </font>
            </td>
            <td align="left"><img id="HPFrame{$uid}Tab3" src="skins/microsoft/media/collapse.gif" alt="" border="0" style="cursor:hand;" onclick="showHideContent('HPFrame{$uid}');" /></td>
            </tr>
            </table>
            <div id="HPFrame{$uid}Content" style="width:100%;border-bottom:#ffffff 1px solid;border-left:#ffffff 1px solid;border-right:#ffffff 1px solid;">
            <table cellspacing="0" cellpadding="0">
            <tr><td colspan="2" height="5" /></tr>
            <tr>
                <td width="3px"></td>
                <td><font face="verdana,arial,helvetica" size="1">
                   <!-- start uneditable zone -->
    			<xsl:choose>
    				<xsl:when test="contains($body, '&lt;')"><xsl:value-of select="$body" disable-output-escaping="yes"/></xsl:when>
    				<xsl:otherwise><xsl:copy-of select="$body" /></xsl:otherwise>
    			</xsl:choose>
    			<!-- end uneditable zone -->
            </font>
            </td></tr></table>
            
            </div>
            </td></tr></table>
            </DIV>
            </DIV>
		<br/>
	</xsl:template>
		
	
	<!-- Design of website gateway -->
	<xsl:template name="gateway_design">
		<table bgcolor="#FFFFFF" width="100%" height="100%">
			<tr>
				<td align="center">
					<!-- start uneditable zone -->
					<xsl:value-of select="/siteinfo/data/gateway" disable-output-escaping="yes"/><br/>
					<a class="gateway" href="default.asp?id=1&amp;mnu=1"><xsl:value-of select="$string[257]"/></a>
					<!-- end uneditable zone -->
				</td>
			</tr>
		</table>		
	</xsl:template>
	
	
	<!-- Design of the TOOLBAR -->
	<xsl:template name="toolbar_global_design">
		<table cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="0099FF">
		    <tr height="20"><td><font color="white" size="1"><b><xsl:call-template name="toolbar_body_macro"/></b></font></td></tr>
		</table>							
	</xsl:template>	
	
	
	<!-- Design of one element of the toolbar -->
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
	
	
	<!-- Design of the last element of the toolbar -->
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
	
	
	<!-- Design of one element of the menu -->
	<xsl:template name="menu_item_design">
		<xsl:param name="content"/>	
		
		       <table width="176" cellpadding="0" cellspacing="0" border="0"><tr><td class="flyoutLink">    
        			<!-- start uneditable zone -->
        			<xsl:choose>
        				<xsl:when test="contains($content, '&lt;')"><xsl:value-of select="$content" disable-output-escaping="yes"/></xsl:when>
        				<xsl:otherwise><xsl:copy-of select="$content" /></xsl:otherwise>
        			</xsl:choose>
        			<!-- end uneditable zone -->
			</td></tr></table>
		</xsl:template>	
	
	
	<!-- Design of a headline -->
	<xsl:template name="headline_design">
		<xsl:param name="title"/>
		<xsl:param name="content"/>
				
		<span style="color: #003399; font-weight: bold; font-size: 10px; text-decoration: underline">
		<!-- start uneditable zone -->
		<xsl:choose>
			<xsl:when test="contains($title, '&lt;')"><xsl:value-of select="$title" disable-output-escaping="yes"/></xsl:when>
			<xsl:otherwise><xsl:copy-of select="$title" /></xsl:otherwise>
		</xsl:choose>
		<!-- end uneditable zone -->
		</span><br/><img src="skins/default/media/dot.gif" width="1" height="4"/><br/>				
		<span style="color: #000000; font-size: 10px;">
		<!-- start uneditable zone -->
		<xsl:choose>
			<xsl:when test="contains($content, '>')"><xsl:value-of select="$content" disable-output-escaping="yes"/></xsl:when>
			<xsl:otherwise><xsl:copy-of select="$content" /></xsl:otherwise>
		</xsl:choose>
		<!-- end uneditable zone -->
		</span>
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
