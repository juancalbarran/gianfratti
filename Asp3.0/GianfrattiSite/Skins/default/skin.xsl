<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" >	
<xsl:output method="html" indent="no" encoding="iso-8859-1"/>
		
	<!-- Design of site title  -->
	<xsl:template name="sitetile_design">
		<xsl:param name="title"/>
		<table width="100%" cellpadding="0" cellspacing="0"><tr><td width="100%" style="color:#C0C000; filter:dropshadow(color=#ffffff, offX=1, offY=1)"><font face="{$general_font}" size="5" color="{$toolbar_background}"><b><i><xsl:copy-of select="$title" /></i></b></font></td></tr></table>
	</xsl:template>
	
	
	<!-- Design of site slogan  -->
	<xsl:template name="siteslogan_design">
		<xsl:param name="text"/>		
		<table width="100%" cellpadding="0" cellspacing="0"><tr><td width="100%" style="color:#C0C000; filter:dropshadow(color=#ffffff, offX=1, offY=1)"><font color="{$body_color}"><xsl:copy-of select="$text"/></font></td></tr></table>
	</xsl:template>
	
	
	<!-- Design of the page title -->
	<xsl:template name="pagetitle_design">
		<xsl:param name="title"/>
			
			<font color="{$toolbar_background}" size="5">
				<!-- start uneditable zone -->
				<xsl:choose>
					<xsl:when test="contains($title, '&lt;')"><xsl:value-of select="$title" disable-output-escaping="yes"/></xsl:when>
					<xsl:otherwise><xsl:copy-of select="$title" /></xsl:otherwise>
				</xsl:choose>
				<!-- end uneditable zone -->
			</font>
			<br/>			
	</xsl:template>
	
	
	<!-- Design of a normal title -->
	<xsl:template name="title_design">
		<xsl:param name="title"/>
		
		<TABLE cellSpacing="0" cellPadding="0" width="100%" >
			<TR bgColor="{$margin_background}"><TD nowrap="nowrap"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><font color="{$margin_color}" size="2">
				<!-- start uneditable zone -->
				<xsl:choose>
					<xsl:when test="contains($title, '&lt;')"><xsl:value-of select="$title" disable-output-escaping="yes"/></xsl:when>
					<xsl:otherwise><xsl:copy-of select="$title" /></xsl:otherwise>
				</xsl:choose>
				<!-- end uneditable zone -->
			</font></b>
			<td style="border-bottom: 1px {$toolbar_background} solid;" width="100%"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
			</TD></TR>
		</TABLE>			
	</xsl:template>


	<!-- Design of normal text -->
	<xsl:template name="normaltext_design">
		<xsl:param name="text"/>
		
		<!-- start uneditable zone -->
			<xsl:choose>
				<xsl:when test="contains($text, '&lt;')"><xsl:value-of select="$text" disable-output-escaping="yes"/></xsl:when>
				<xsl:otherwise><xsl:copy-of select="$text" /></xsl:otherwise>
			</xsl:choose>
		<!-- end uneditable zone -->
	</xsl:template>
	

	<!-- Design of highlighted text -->
	<xsl:template name="hightlightedtext_design">
		<xsl:param name="text"/>			
			<table bgcolor="{$body_background}" border="0"><tr><td>
			       <!-- start uneditable zone -->
        			<xsl:choose>
        				<xsl:when test="contains($text, '&lt;')"><xsl:value-of select="$text" disable-output-escaping="yes"/></xsl:when>
        				<xsl:otherwise><xsl:copy-of select="$text" /></xsl:otherwise>
        			</xsl:choose>
        		        <!-- end uneditable zone -->
			         </td></tr></table>	
	</xsl:template>
	
	
	<!-- Design of a left-margin box -->
	<xsl:template name="margin_design">
		<xsl:param name="title"/>
		<xsl:param name="body"/>
		<xsl:param name="myid"/>
		<xsl:param name="beforeid"/>
		<xsl:param name="nextid"/>
		
		<table cellspacing="0" width="100%" style="border: 1px outset;" id="wp{$myid}">
	        
	        <xsl:if test="string-length(showtitle)=0 or showtitle='on'">
		        <tr> 
		        	<td width="100%" bgcolor="{$toolbar_background}"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/> 
		          	<font color="{$toolbar_color}"><b>
		          		<!-- start uneditable zone -->
					<xsl:choose>
						<xsl:when test="contains($title, '&lt;')"><xsl:value-of select="$title" disable-output-escaping="yes"/></xsl:when>
						<xsl:otherwise><xsl:copy-of select="$title" /></xsl:otherwise>
					</xsl:choose>
					<!-- end uneditable zone -->
					</b></font>
		          	</td>
		          	<xsl:if test="$usertype='administrator'">
		          		<xsl:if test="$nextid">
		          			<form action="default.asp?id={$id}&amp;mnu={$mnu}" method="post">
			          			<td width="0">
			          			<input type="hidden" name="operation" value="swap"/>
							<input type="hidden" name="file" value="category"/>
							<input type="hidden" name="node_a" value="categories/category[id={$myid}]/order"/>
							<input type="hidden" name="node_b" value="categories/category[id={$nextid}]/order"/>
							<input type="image" src="admin/media/arrow_down.gif" align="absmiddle" border="0" alt="{$string[569]}"/>
							</td>
			          		</form>
		          		</xsl:if>
		          		<xsl:if test="$beforeid">
		          			<form action="default.asp" method="post">
			          			<td width="0">
			          			<input type="hidden" name="operation" value="swap"/>
							<input type="hidden" name="file" value="category"/>
							<input type="hidden" name="node_a" value="categories/category[id={$myid}]/order"/>
							<input type="hidden" name="node_b" value="categories/category[id={$beforeid}]/order"/>
							<input type="image" src="admin/media/arrow_up.gif" align="absmiddle" border="0" alt="{$string[568]}"/>
							</td>
			          		</form>
		          		</xsl:if>
		          		<xsl:if test="$myid">
			          		<form action="default.asp" method="post">
			          			<td width="0">
			          			<input type="hidden" name="operation" value="update"/>
							<input type="hidden" name="file" value="category"/>
							<input type="hidden" name="node" value="categories/category[id={$myid}]"/>
							<input type="hidden" name="visible" value="off"/>
							<input type="image" src="admin/media/close.gif" align="absmiddle" border="0" alt="{$string[567]}"/>
							</td>
			          		</form>
			          	</xsl:if>
		          	</xsl:if>
		       </tr>
	        </xsl:if>	        	
	        <tr>
	        <td width="100%" colspan="4" bgcolor="{$margin_background}">
	        	<!-- start uneditable zone -->
				<xsl:choose>
					<xsl:when test="contains($body, '&lt;')"><xsl:value-of select="$body" disable-output-escaping="yes"/></xsl:when>
					<xsl:otherwise><xsl:copy-of select="$body" /></xsl:otherwise>
				</xsl:choose>
				<!-- end uneditable zone -->
	        </td>
	        </tr>
	        </table>		
	        <br/>
	</xsl:template>
	
	
	<!-- Design of a right-margin box -->
	<xsl:template name="rightmargin_design">
		<xsl:param name="title"/>
		<xsl:param name="body"/>
		<xsl:param name="myid"/>
		<xsl:param name="beforeid"/>
		<xsl:param name="nextid"/>

		
		<table cellspacing="0" width="100%" style="border: 1px outset;" id="wp{$myid}">
	        <xsl:if test="string-length(showtitle)=0 or showtitle='on'">
		        <tr> 
		         	<td bgcolor="{$toolbar_background}" width="100%" ><xsl:value-of select="$nbsp" disable-output-escaping="yes"/> 
		          		<font color="{$toolbar_color}"><b><xsl:choose><xsl:when test="contains($title, '&lt;')"><xsl:value-of select="$title" disable-output-escaping="yes"/></xsl:when><xsl:otherwise><xsl:copy-of select="$title" /></xsl:otherwise></xsl:choose></b></font>
		          	</td>
		          	<xsl:if test="$usertype='administrator'">
		          		<xsl:if test="$nextid">
		          			<form action="default.asp?id={$id}&amp;mnu={$mnu}" method="post">
			          			<td width="0">
			          			<input type="hidden" name="operation" value="swap"/>
							<input type="hidden" name="file" value="category"/>
							<input type="hidden" name="node_a" value="categories/category[id={$myid}]/order"/>
							<input type="hidden" name="node_b" value="categories/category[id={$nextid}]/order"/>
							<input type="image" src="admin/media/arrow_down.gif" align="absmiddle" border="0"/>
							</td>
			          		</form>
		          		</xsl:if>
		          		<xsl:if test="$beforeid">
		          			<form action="default.asp" method="post">
			          			<td width="0">
			          			<input type="hidden" name="operation" value="swap"/>
							<input type="hidden" name="file" value="category"/>
							<input type="hidden" name="node_a" value="categories/category[id={$myid}]/order"/>
							<input type="hidden" name="node_b" value="categories/category[id={$beforeid}]/order"/>
							<input type="image" src="admin/media/arrow_up.gif" align="absmiddle" border="0"/>
							</td>
			          		</form>
		          		</xsl:if>
		          	</xsl:if>
		        </tr>
	        </xsl:if>
	        	       
	        <tr>
	        	<td width="100%" colspan="2" bgcolor="{$margin_background}">
	        		<!-- start uneditable zone -->
				<xsl:choose>
					<xsl:when test="contains($body, '&lt;')"><xsl:value-of select="$body" disable-output-escaping="yes"/></xsl:when>
					<xsl:otherwise><xsl:copy-of select="$body" /></xsl:otherwise>
				</xsl:choose>
				<!-- end uneditable zone -->
	        	</td>
	        </tr>
	        </table>		
	        <br/>	
	</xsl:template>
		
	
	<!-- Design of website gateway -->
	<xsl:template name="gateway_design">
		<table bgcolor="{$body_background}" width="100%" height="100%">
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
	
	<!-- ======================================== -->
	<!-- ======================================== -->
	<!-- ======================================== -->
	
	<!-- Design of the TOOLBAR -->
	<xsl:template name="toolbar_global_design">
		<table cellSpacing="0" cellPadding="0" width="100%" border="0" style="border-top: 1px solid {$toolbar_border}; border-bottom: 1px solid {$toolbar_border};">
			<tr height="16">
				<xsl:choose>
					<xsl:when test="document($datafile)/siteinfo/data/textdirection = 'RTL'">
						<td bgColor="{$toolbar_background}" align="right">					
							<font color="{$toolbar_color}">
								<xsl:call-template name="toolbar_body_macro"/>
							</font>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td bgColor="{$toolbar_background}" align="right">					
							<font color="{$toolbar_color}">
								<xsl:call-template name="toolbar_body_macro"/>
							</font>
						</td>
					</xsl:otherwise>
				</xsl:choose>
			</tr>
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
			<!-- end uneditable zone -->		 | 
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
	</xsl:template>	
	
	
	<!-- Design of one element of the menu -->
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
		
	<!-- Design of a headline -->
	<xsl:template name="headline_design">
		<xsl:param name="title"/>
		<xsl:param name="content"/>
				
		<b>
		<!-- start uneditable zone -->
		<xsl:choose>
			<xsl:when test="contains($title, '&lt;')"><xsl:value-of select="$title" disable-output-escaping="yes"/></xsl:when>
			<xsl:otherwise><xsl:copy-of select="$title" /></xsl:otherwise>
		</xsl:choose>
		<!-- end uneditable zone -->
		</b><br/><img src="skins/default/media/dot.gif" width="1" height="4"/><br/>				
		
		<!-- start uneditable zone -->
		<xsl:choose>
			<xsl:when test="contains($content, '>')"><xsl:value-of select="$content" disable-output-escaping="yes"/></xsl:when>
			<xsl:otherwise><xsl:copy-of select="$content" /></xsl:otherwise>
		</xsl:choose>
		<!-- end uneditable zone -->

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
			100,					// Menu Top - The Top position of the menu in pixels
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
