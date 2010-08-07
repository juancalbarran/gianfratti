<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" >	
<xsl:output method="html" indent="no" encoding="iso-8859-1"/>	

	<!-- Design of site title  -->
	<xsl:template name="sitetile_design">
		<xsl:param name="title"/>
		<table>
			<tr>
				<td style="width:100%; filter:dropshadow(color={$headertext_shadow}, offX=1, offY=2)">
					<font face="{$general_font}" size="5" color="{$headertext_color}">
						<b>
							<i>
								<xsl:copy-of select="$title"/>
							</i>
						</b>
					</font>
				</td>
			</tr>
		</table>
	</xsl:template>
	<!-- Design of site slogan  -->
	<xsl:template name="siteslogan_design">
		<xsl:param name="text"/>
		<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td style="width:100%; filter:dropshadow(color={$headerslogan_shadow}, offX=1, offY=2)">
					<font face="{$general_font}" size="2" color="{$headerslogan_color}">
						<xsl:choose>
							<xsl:when test="contains($text, '&lt;')">
								<xsl:value-of select="$text" disable-output-escaping="yes"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:copy-of select="$text"/>
							</xsl:otherwise>
						</xsl:choose>
					</font>
				</td>
			</tr>
		</table>
	</xsl:template>
	<!-- Design of the page title -->
	<xsl:template name="pagetitle_design">
		<xsl:param name="title"/>
		<span style="font-family: {$general_font}; font-size: 22px; font-weight: bold">
			<xsl:choose>
				<xsl:when test="contains($title, '&lt;')">
					<xsl:value-of select="$title" disable-output-escaping="yes"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="$title"/>
				</xsl:otherwise>
			</xsl:choose>
		</span>
	</xsl:template>
	<!-- Design of a normal title -->
	<xsl:template name="title_design">
		<xsl:param name="title"/>
		<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td width="0">
						<IMG><xsl:attribute name="src">skins/common/curves/Curve.asp?curve=TopLeft<xsl:value-of select="string('&amp;')"/>color2=<xsl:value-of select="substring($title_background, 2)"/><xsl:value-of select="string('&amp;')"/>color1=<xsl:value-of select="substring($main_background, 2)"/></xsl:attribute></IMG>	
				</td>
				<td bgcolor="{$title_background}" width="100%">
					<b>
						<font color="{$title_color}">
							<xsl:choose>
								<xsl:when test="contains($title, '&lt;')">
									<xsl:value-of select="$title" disable-output-escaping="yes"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="$title"/>
								</xsl:otherwise>
							</xsl:choose>
						</font>
					</b>
				</td>
			</tr>
		</table>
	</xsl:template>
	<!-- Design of normal text -->
	<xsl:template name="normaltext_design">
		<xsl:param name="text"/>
		<!-- start uneditable zone -->
		<xsl:choose>
			<xsl:when test="contains($text, '&lt;')">
				<xsl:value-of select="$text" disable-output-escaping="yes"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
		<!-- end uneditable zone -->
	</xsl:template>
	<!-- Design of highlighted text -->
	<xsl:template name="hightlightedtext_design">
		<xsl:param name="text"/>
		<table bgcolor="{$highlight_background}" style="border: 1px {$highlight_border} solid">
			<tr>
				<td>
					<!-- start uneditable zone -->
					<xsl:choose>
						<xsl:when test="contains($text, '&lt;')">
							<xsl:value-of select="$text" disable-output-escaping="yes"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:copy-of select="$text"/>
						</xsl:otherwise>
					</xsl:choose>
					<!-- end uneditable zone -->
				</td>
			</tr>
		</table>
	</xsl:template>
	<!-- Design of a left-margin box -->
	<xsl:template name="margin_design">
		<xsl:param name="title"/>
		<xsl:param name="body"/>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td width="0">
				<IMG><xsl:attribute name="src">skins/common/curves/Curve.asp?curve=TopLeft<xsl:value-of select="string('&amp;')"/>color2=<xsl:value-of select="substring($menuheadleft_background, 2)"/><xsl:value-of select="string('&amp;')"/>color1=<xsl:value-of select="substring($main_background, 2)"/></xsl:attribute></IMG>					
				</td>
				<td width="100%" bgcolor="{$menuheadleft_background}">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					<font color="{$menuheadright_color}">
						<b>
							<!-- start uneditable zone -->
							<xsl:choose>
								<xsl:when test="contains($title, '&lt;')">
									<xsl:value-of select="$title" disable-output-escaping="yes"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="$title"/>
								</xsl:otherwise>
							</xsl:choose>
							<!-- end uneditable zone -->
						</b>
					</font>
				</td>
				<td width="0">
					<IMG><xsl:attribute name="src">skins/common/curves/Curve.asp?curve=TopRight<xsl:value-of select="string('&amp;')"/>color2=<xsl:value-of select="substring($menuheadleft_background, 2)"/><xsl:value-of select="string('&amp;')"/>color1=<xsl:value-of select="substring($main_background, 2)"/></xsl:attribute></IMG>	
				</td>
			</tr>
			<tr>
				<td width="100%" colspan="3" bgcolor="{$menuleft_background}">
					<!-- start uneditable zone -->
					<xsl:choose>
						<xsl:when test="contains($body, '&lt;')">
							<xsl:value-of select="$body" disable-output-escaping="yes"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:copy-of select="$body"/>
						</xsl:otherwise>
					</xsl:choose>
					<!-- end uneditable zone -->
				</td>
			</tr>
			<tr>
				<td>
				<IMG><xsl:attribute name="src">skins/common/curves/Curve.asp?curve=BottomLeft<xsl:value-of select="string('&amp;')"/>color2=<xsl:value-of select="substring($menuleft_background, 2)"/><xsl:value-of select="string('&amp;')"/>color1=<xsl:value-of select="substring($main_background, 2)"/></xsl:attribute></IMG>	
				</td>
				<td width="100%" bgcolor="{$menuleft_background}">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td>
				<IMG><xsl:attribute name="src">skins/common/curves/Curve.asp?curve=BottomRight<xsl:value-of select="string('&amp;')"/>color2=<xsl:value-of select="substring($menuleft_background, 2)"/><xsl:value-of select="string('&amp;')"/>color1=<xsl:value-of select="substring($main_background, 2)"/></xsl:attribute></IMG>	
				</td>
			</tr>
		</table>
		<br/>
	</xsl:template>
	
	<!-- Design of a right-margin box -->
	<xsl:template name="rightmargin_design">
		<xsl:param name="title"/>
		<xsl:param name="body"/>
		<table bgcolor="{$menuheadright_background}" border="0" cellpadding="0" cellspacing="0" width="100%">
			<xsl:choose>
				<xsl:when test="string-length(showtitle)=0 or showtitle='on'">
					<tr>
						<td width="0">
				<IMG><xsl:attribute name="src">skins/common/curves/Curve.asp?curve=TopLeft<xsl:value-of select="string('&amp;')"/>color2=<xsl:value-of select="substring($menuheadright_background, 2)"/><xsl:value-of select="string('&amp;')"/>color1=<xsl:value-of select="substring($main_background, 2)"/></xsl:attribute></IMG>					
						</td>
						<td width="100%">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
							<font color="{$menuheadright_color}">
								<b>
									<!-- start uneditable zone -->
									<xsl:choose>
										<xsl:when test="contains($title, '&lt;')">
											<xsl:value-of select="$title" disable-output-escaping="yes"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:copy-of select="$title"/>
										</xsl:otherwise>
									</xsl:choose>
									<!-- end uneditable zone -->
								</b>
							</font>
						</td>
						<td width="0">
				<IMG><xsl:attribute name="src">skins/common/curves/Curve.asp?curve=TopRight<xsl:value-of select="string('&amp;')"/>color2=<xsl:value-of select="substring($menuheadright_background, 2)"/><xsl:value-of select="string('&amp;')"/>color1=<xsl:value-of select="substring($main_background, 2)"/></xsl:attribute></IMG>					
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<tr>
						<td colspan="3">
							<img src="/skins/default/media/dot.gif" width="150" height="1"/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<tr>
				<td width="100%" colspan="3" bgcolor="{$menuright_background}" style="border-left: 1px {$menuheadright_background} solid; border-right:1px {$menuheadright_background} solid;">
					<table cellpadding="2" cellspacing="2">
						<tr>
							<td>
								<!-- start uneditable zone -->
								<xsl:choose>
									<xsl:when test="contains($body, '&lt;')">
										<xsl:value-of select="$body" disable-output-escaping="yes"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:copy-of select="$body"/>
									</xsl:otherwise>
								</xsl:choose>
								<!-- end uneditable zone -->
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<xsl:choose>
				<xsl:when test="string-length(showtitle)=0 or showtitle='on'">
					<tr>
						<td>
				<IMG><xsl:attribute name="src">skins/common/curves/Curve.asp?curve=BottomLeft<xsl:value-of select="string('&amp;')"/>color2=<xsl:value-of select="substring($menuheadright_background, 2)"/><xsl:value-of select="string('&amp;')"/>color1=<xsl:value-of select="substring($main_background, 2)"/></xsl:attribute></IMG>					
						</td>
						<td width="100%">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						</td>
						<td>
				<IMG><xsl:attribute name="src">skins/common/curves/Curve.asp?curve=BottomRight<xsl:value-of select="string('&amp;')"/>color2=<xsl:value-of select="substring($menuheadright_background, 2)"/><xsl:value-of select="string('&amp;')"/>color1=<xsl:value-of select="substring($main_background, 2)"/></xsl:attribute></IMG>					
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<tr>
						<td colspan="3">
							<img src="/skins/default/media/dot.gif" width="150" height="1"/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
		</table>
		<br/>
	</xsl:template>
	
	<!-- Design of website gateway -->
	<xsl:template name="gateway_design">
		<table bgcolor="{$body_background}" width="100%" height="100%">
			<tr>
				<td align="center" color="{$body_color}">
					<!-- start uneditable zone -->
					<xsl:value-of select="/siteinfo/data/gateway" disable-output-escaping="yes"/>
					<br/>
					<a class="gateway" href="default.asp?id=1&amp;mnu=1">
						<xsl:value-of select="$string[257]"/>
					</a>
					<!-- end uneditable zone -->
				</td>
			</tr>
		</table>
	</xsl:template>
	<!-- ======================================== -->
	<!-- ======================================== -->
	<!-- ======================================== -->
	<!-- Design of the TOOLBAR -->
	<xsl:template name="toolbar_global_design">
		<table border="0" width="100%" cellpadding="0" cellspacing="0" >
			<tr>
				<td height="18" align="{$toolbar_align}" style="FILTER: progid:DXImageTransform.Microsoft.Gradient(endColorstr='{$toolbar_background2}', startColorstr='{$toolbar_background1}', gradientType='1')">
					<font color="{$toolbar_color}">
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<xsl:call-template name="toolbar_body_macro"/>
					</font>
				</td>
			</tr>
		</table>
	</xsl:template>
	<!-- Design of one element of the toolbar -->
	<xsl:template name="toolbar_item_design">
		<xsl:param name="content"/>
		<!-- start uneditable zone -->
		<xsl:choose>
			<xsl:when test="contains($content, '&lt;')">
				<xsl:value-of select="$content" disable-output-escaping="yes"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$content"/>
			</xsl:otherwise>
		</xsl:choose>
		<!-- end uneditable zone -->
		 | 
	</xsl:template>
	<!-- Design of the last element of the toolbar -->
	<xsl:template name="toolbar_lastitem_design">
		<xsl:param name="content"/>
		<!-- start uneditable zone -->
		<xsl:choose>
			<xsl:when test="contains($content, '&lt;')">
				<xsl:value-of select="$content" disable-output-escaping="yes"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$content"/>
			</xsl:otherwise>
		</xsl:choose>
		<!-- end uneditable zone -->
		<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
	</xsl:template>
	<!-- Design of one element of the menu -->
	<xsl:template name="menu_item_design">
		<xsl:param name="content"/>
		<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
		<b>::</b>
		<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
		<!-- start uneditable zone -->
		<xsl:choose>
			<xsl:when test="contains($content, '&lt;')">
				<xsl:value-of select="$content" disable-output-escaping="yes"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$content"/>
			</xsl:otherwise>
		</xsl:choose>
		<!-- end uneditable zone -->
		<br/>
	</xsl:template>
	<!-- Design of a headline test -->
	<xsl:template name="headline_design">
		<xsl:param name="title"/>
		<xsl:param name="content"/>
		<b>
			<!-- start uneditable zone -->
			<xsl:choose>
				<xsl:when test="contains($title, '&lt;')">
					<xsl:value-of select="$title" disable-output-escaping="yes"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="$title"/>
				</xsl:otherwise>
			</xsl:choose>
			<!-- end uneditable zone -->
		</b>
		<br/>
		<img src="skins/default/media/dot.gif" width="1" height="4" style="FILTER: progid:DXImageTransform.Microsoft.Gradient(endColorstr=''{$toolbar_background2}', startColorstr='{$toolbar_background}', gradientType='1'"/>
		<br/>
		<!-- start uneditable zone -->
		<xsl:choose>
			<xsl:when test="contains($content, '>')">
				<xsl:value-of select="$content" disable-output-escaping="yes"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$content"/>
			</xsl:otherwise>
		</xsl:choose>
		<!-- end uneditable zone -->
	</xsl:template>
	<!-- Design of the menubar -->
	<xsl:template name="menubar_design">
		<!-- this block of javascript can be edited to change the display --><![CDATA[
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
			,					// Reserved for future use]]></xsl:template>
</xsl:stylesheet>
