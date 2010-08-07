<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb">
<xsl:output method="html"/> 

<!-- Webpages Template : add/update/modify -->
<!-- last modified : 2003/08/10, by J.Roland -->
<!-- version 1.0 -->

	<xsl:template name="category_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Website Categories</xsl:with-param>
			<xsl:with-param name="version">1.1</xsl:with-param>
			<xsl:with-param name="moddate">10.08.2003</xsl:with-param>
			<xsl:with-param name="author">Mig100 (Miguel Figueira) and John Roland</xsl:with-param>
			<xsl:with-param name="url">http://www.fxmods.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="category_manager">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M18"><img src="admin/media/category.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[331]"/></font></td></tr>
		</table>			
				
		<xsl:choose>
			<xsl:when test="$id=''">
				<xsl:call-template name="category_list"/>							
			</xsl:when>
			<xsl:when test="$id='new'">
				<xsl:call-template name="category_add"/>							
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="document($categoryfile)//categories/category[id=$id]"><xsl:call-template name="category_update"/></xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>

	<!-- page grid template -->
	<xsl:template name="category_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr>
				<td class="header" width="16"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td class="header" width="20">Id</td>
				<td class="header"><xsl:value-of select="$string[332]"/></td>
				<td class="header"><xsl:value-of select="$string[333]"/></td>
				<td class="header" width="5%"><xsl:value-of select="$string[566]"/></td>
			</tr>
			<xsl:if test="count(document($categoryfile)//categories/category[position='left']) &gt; 0">
				<!-- Left side -->
				<tr><td colspan="5" align="center"><font color="white" size="4"><b>-= Left side categories =-</b></font></td></tr>
				<xsl:if test="count(document($categoryfile)//categories/category[position='left' and member='off']) &gt; 0">
					<tr><td colspan="5" align="center"><font color="white"><b>- Anounymous access -</b></font></td></tr>
					<xsl:call-template name="display_category"><xsl:with-param name="group">off</xsl:with-param><xsl:with-param name="position">left</xsl:with-param></xsl:call-template>
				</xsl:if>
				<xsl:if test="count(document($categoryfile)//categories/category[position='left' and member='on']) &gt; 0">
					<tr><td colspan="5" align="center"><font color="white"><b>- Members only access -</b></font></td></tr>
					<xsl:call-template name="display_category"><xsl:with-param name="group">on</xsl:with-param><xsl:with-param name="position">left</xsl:with-param></xsl:call-template>
				</xsl:if>
				<xsl:if test="count(document($categoryfile)//categories/category[position='left' and member='admin']) &gt; 0">
					<tr><td colspan="5" align="center"><font color="white"><b>- Administrator access -</b></font></td></tr>
					<xsl:call-template name="display_category"><xsl:with-param name="group">admin</xsl:with-param><xsl:with-param name="position">left</xsl:with-param></xsl:call-template>
				</xsl:if>
			</xsl:if>
			<tr>
				<td colspan="5" height="15"/>
			</tr>
			<xsl:if test="count(document($categoryfile)//categories/category[position='right']) &gt; 0">
				<!-- right side -->
				<tr><td colspan="5" align="center"><font color="white" size="4"><b>-= Right side categories =-</b></font></td></tr>
				<xsl:if test="count(document($categoryfile)//categories/category[position='right' and member='off']) &gt; 0">
					<tr><td colspan="5" align="center"><font color="white"><b>- Anounymous access -</b></font></td></tr>
					<xsl:call-template name="display_category"><xsl:with-param name="group">off</xsl:with-param><xsl:with-param name="position">right</xsl:with-param></xsl:call-template>
				</xsl:if>
				<xsl:if test="count(document($categoryfile)//categories/category[position='right' and member='on']) &gt; 0">
					<tr><td colspan="5" align="center"><font color="white"><b>- Members only access -</b></font></td></tr>
					<xsl:call-template name="display_category"><xsl:with-param name="group">on</xsl:with-param><xsl:with-param name="position">right</xsl:with-param></xsl:call-template>
				</xsl:if>
				<xsl:if test="count(document($categoryfile)//categories/category[position='right' and member='admin']) &gt; 0">
					<tr><td colspan="5" align="center"><font color="white"><b>- Administrator access -</b></font></td></tr>
					<xsl:call-template name="display_category"><xsl:with-param name="group">admin</xsl:with-param><xsl:with-param name="position">right</xsl:with-param></xsl:call-template>
				</xsl:if>
			</xsl:if>
			<tr>
				<td colspan="5" align="right">
					<input type="button" value="{$string[15]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M18&amp;id=new';" />
				</td>
			</tr>
		</table>
	</xsl:template>

	 <!-- Menu calculation, the owner typer is passed as param -->
        <xsl:template name="display_category">
		<xsl:param name="group" />
		<xsl:param name="position" />
		
		<!-- on recopie dans une variable, pour avoir le context trier, tres util pour following et preceding -->
		<xsl:variable name="cat_node">			
			<xsl:for-each select="document($categoryfile)//categories/category[member=$group and (position=$position or (string-length(position)=0 and $position='left'))]">
			 	<xsl:sort select="order" data-type="number" order="ascending"/>
			 	<category><id><xsl:value-of select="id"/></id><visible><xsl:value-of select="visible"/></visible><name><xsl:value-of select="name"/></name><member><xsl:value-of select="member"/></member><sortfield><xsl:value-of select="sortfield"/></sortfield><sortorder><xsl:value-of select="sortorder"/></sortorder><order><xsl:value-of select="order"/></order></category>
			 </xsl:for-each>
		</xsl:variable>
			
		<xsl:apply-templates select="msxsl:node-set($cat_node)/category" mode="order">
		 	<xsl:sort select="order" data-type="number" order="ascending"/>
		 </xsl:apply-templates>
	</xsl:template>	   

	<xsl:template match="category" mode="order">	    
		<xsl:call-template name="order_design">
		    	<xsl:with-param name="myid" select="id"/>
		    	<xsl:with-param name="beforeid" select="preceding-sibling::*[1]/id"/>
		    	<xsl:with-param name="nextid" select="following-sibling::*[1]/id"/>
		    			    	
		</xsl:call-template>
	</xsl:template>

	<!-- Design of order boxes -->
	<xsl:template name="order_design">
		<xsl:param name="myid"/>
		<xsl:param name="beforeid"/>
		<xsl:param name="nextid"/>
				
				<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M18&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td><img src="admin/media/{visible}.gif" width="16" height="15"/></td>
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M18&amp;id={id}"><xsl:value-of select="name"/></a></td>
					<td class="data2">
						<xsl:choose>
							<xsl:when test="member='off'">Anonymous</xsl:when>
							<xsl:when test="member='on'">Member only</xsl:when>
							<xsl:otherwise>Administrator Only</xsl:otherwise>
						</xsl:choose>
					</td>
					<td  class="data2"><!-- <xsl:value-of select="order"/> -->
					<table cellspacing="0" align="right"><tr>
		          	<xsl:if test="$nextid">
						<td>
		          			<form action="default.asp?ACT=1&amp;SECT=M18" method="post">
			          			<input type="hidden" name="operation" value="swap"/>
							<input type="hidden" name="file" value="category"/>
							<input type="hidden" name="node_a" value="categories/category[id={$myid}]/order"/>
							<input type="hidden" name="node_b" value="categories/category[id={$nextid}]/order"/>
							<input type="image" src="admin/media/arrow_down.gif" align="absmiddle" border="0" alt="{$string[569]}"/>
			          		</form>
					</td>						
		          		</xsl:if>
		          		<xsl:if test="$beforeid">
					<td>						
		          			<form action="default.asp?ACT=1&amp;SECT=M18" method="post">
			          			<input type="hidden" name="operation" value="swap"/>
							<input type="hidden" name="file" value="category"/>
							<input type="hidden" name="node_a" value="categories/category[id={$myid}]/order"/>
							<input type="hidden" name="node_b" value="categories/category[id={$beforeid}]/order"/>
							<input type="image" src="admin/media/arrow_up.gif" align="absmiddle" border="0" alt="{$string[568]}"/>
			          		</form>
					</td>						
		          		</xsl:if></tr>
</table>
</td>
				</tr>
	</xsl:template>


	
	
	<!-- add page form  -->
	<xsl:template name="category_add">
		<xsl:param name="neworder" select="document($categoryfile)//categories/category[order=last()]/order + 1"/>
		<table bgcolor="white"><form action="default.asp?ACT=1&amp;SECT=M18" method="post" name="frmadm"><tr><td>
			<input type="hidden" name="operation" value="add"/>
			<input type="hidden" name="file" value="category"/>
			<input type="hidden" name="bloc" value="categories"/>
			<input type="hidden" name="node" value="category"/>
			<input type="hidden" name="order" value="{$neworder}"/>
				<table class="block">
					<tr>
						<td class="xp_sel"><xsl:value-of select="$string[332]"/>:</td>
						<td><input type="text" name="name" class="full"/></td>
					</tr>
					<tr>	<td colspan="2"  class="data2"> </td></tr>
					<tr>
	        				<td  class="xp_sel"><xsl:value-of select="$string[433]"/>:</td>
	        				<td>
	        					<select name="position">
	        						<option value="left"><xsl:value-of select="$string[436]"/></option>
	        						<option value="right"><xsl:value-of select="$string[437]"/></option>						
	        					</select>
	        				</td>
	        			</tr>			
<!--	        			<tr>	<td class="xp_sel"><xsl:value-of select="$string[566]"/>:</td><td><input type="text" value="{$neworder}" name="order" class="mini"/></td></tr>			-->
	    				<tr><td colspan="2"> </td></tr>
    			
    				<!-- ACESS RESTRICTION -->   	
					<tr><td  class="xp_sel"><xsl:value-of select="$string[333]"/>:</td><td><select name="member"><option value="off" selected="selected"> Anonymous</option><option value="on"> Members only</option><option value="admin"> Administrators only</option></select></td></tr>
					<!-- The sort field for the article and the order-->
					<tr>
						<td class="xp_sel"><xsl:value-of select="$string[411]"/>:</td>
						<td>
							<select name="sortfield">
								<option value="publicationdate" selected="selected"><xsl:value-of select="$string[413]"/></option>
								<option value="name"><xsl:value-of select="$string[51]"/></option>
								<option value="id"><xsl:value-of select="$string[414]"/></option>
							</select>
							 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
							<select name="sortorder">
								<option value="descending" selected="selected"><xsl:value-of select="$string[416]"/></option>
								<option value="ascending"><xsl:value-of select="$string[415]"/></option>
							</select>
						</td>
					</tr>
					<tr><td colspan="2"> </td></tr>
												
					<tr><td class="xp_sel"><xsl:value-of select="$string[486]"/>:</td><td><select name="visible"><option value="on" selected="selected"><xsl:value-of select="$string[60]"/></option><option value="off"><xsl:value-of select="$string[61]"/></option></select></td></tr>
					<tr>
						<td colspan="2" align="right">
							<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
							<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M18';"/>
						</td>
					</tr>
				</table>
				
			</td></tr></form>
		</table>
	</xsl:template>
	
	
	<!-- Modifiy page form-->
	<xsl:template name="category_update">				
		<xsl:variable name="idparentpage" select="idparentpage"/>
	
		<table bgcolor="white"><tr><td>
		
		<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmadm">
			<input type="hidden" name="operation" value="update"/>
			<input type="hidden" name="file" value="category"/>
			<input type="hidden" name="node" value="categories/category[id={id}]"/>
			
			<table class="block">		
			<tr><td class="xp_sel"><xsl:value-of select="$string[332]"/>:</td><td><input type="text" value="{name}" name="name" class="full"/></td></tr>
			<tr><td colspan="2"> </td></tr>
			
			<tr>
    				<td class="xp_sel"><xsl:value-of select="$string[433]"/>:</td>
    				<td>
    					<select name="position">
    						<option value="left"><xsl:if test="position='left' or string-length(position)=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[436]"/></option>
    						<option value="right"><xsl:if test="position='right'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[437]"/></option>						
    					</select>
    				</td>
    			</tr>
<!--    			<tr><td class="xp_sel"><xsl:value-of select="$string[566]"/>:</td><td><input type="text" value="{order}" name="order" class="mini"/></td></tr>			-->
    			<tr><td colspan="2"> </td></tr>
    			
    			<!-- ACESS RESTRICTION -->
    			<tr><td class="xp_sel"> <xsl:value-of select="$string[333]"/>:</td><td><select name="member"><option value="off"><xsl:if test="member='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>anonymous</option><option value="on"><xsl:if test="member='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> Members only</option><option value="admin"><xsl:if test="member='admin'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> Administrators only</option></select></td></tr>
			<!-- The sort field for the article and the order-->
			<tr>
				<td class="xp_sel"> <xsl:value-of select="$string[411]"/>:</td>
				<td> 
					<select name="sortfield">
						<option value="publicationdate"><xsl:if test="sortfield='publicationdate' or string-length(sortfield)=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[413]"/></option>
						<option value="name"><xsl:if test="sortfield='name'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[51]"/></option>
						<option value="id"><xsl:if test="sortfield='id'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[414]"/></option>
					</select>
					 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					<select name="sortorder">
						<option value="descending"><xsl:if test="sortorder='descending' or string-length(sortorder)=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[416]"/></option>
						<option value="ascending"><xsl:if test="sortorder='ascending'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[415]"/></option>
					</select>
				</td>
			</tr>
    			<tr><td colspan="2"> </td></tr>    									
			<tr><td class="xp_sel"><xsl:value-of select="$string[486]"/>:</td><td><select name="visible"><option value="on"><xsl:if test="visible='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[60]"/></option><option value="off"><xsl:if test="visible='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[61]"/></option></select></td></tr>
			
			
			<tr><td align="right" colspan="2">
				<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M18';"/>
				<!--<input class="sbttn" style="WIDTH: 100px" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M5&amp;id={id}';" type="button" value="Add content" onmouseover="over(this);" onmouseout="notover(this);"/>-->
			</td></tr>
		</table>
		</form>
		
		<table class="block">
			<xsl:choose>
				<xsl:when test="@readonly='readonly'">
					<tr>
						<td align="right" colspan="2">
							<font color="red"><xsl:value-of select="$string[335]"/><!--This category cannot be deleted.--></font>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<tr>
						<td align="right" colspan="2">
							<form action="default.asp?ACT=1&amp;SECT=M18" method="post" onsubmit="return confirm('{$string[336]}');">
								<input type="hidden" name="operation" value="delete"/>
								<input type="hidden" name="file" value="category"/>
								<input type="hidden" name="node" value="categories/category[id={id}]"/>
								<input type="submit" value="{$string[16]}"/>
							</form>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>					
		</table>
		<p align="center"><a href="default.asp?ACT=1&amp;SECT=M2&amp;cat={id}"><xsl:value-of select="$string[337]"/></a></p>
		</td></tr></table>
	</xsl:template>

</xsl:stylesheet>