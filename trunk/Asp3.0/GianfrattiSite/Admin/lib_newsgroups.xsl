<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve">
<xsl:output method="html"/> 

<!-- Content Template : add/update/modify -->
<!-- last modified : 2001/10/26, by J.Roland -->
<!-- version 1.0 -->

	<xsl:template name="newsgroup_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Newsgroup</xsl:with-param>
			<xsl:with-param name="version">1.0</xsl:with-param>
			<xsl:with-param name="moddate">26.10.2001</xsl:with-param>
			<xsl:with-param name="author">John Roland</xsl:with-param>
			<xsl:with-param name="url">http://www.fullxml.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="newsgroup_manager">
		
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M12"><img src="admin/media/content.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[190]"/></font></td></tr>
		</table><br/>
		
		<xsl:choose>
			<xsl:when test="$id=''">
				<xsl:call-template name="newsgroup_list"/>
			</xsl:when>
			<xsl:when test="$id='new'">
				<xsl:call-template name="newsgroup_add"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="document($discussionfile)//discussions/discussion[id=$id]">
					<xsl:call-template name="newsgroup_update"/>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	
	
	<xsl:template name="newsgroup_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr>
				<td class="header" width="16"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td class="header" width="16">Id</td>
				<td class="header"><xsl:value-of select="$string[191]"/></td>
				<td class="header"><xsl:value-of select="$string[192]"/></td>
				<td class="header"><xsl:value-of select="$string[566]"/></td>
			</tr>	
			<xsl:for-each select="document($discussionfile)//discussions/discussion">
				<xsl:sort select="order" order="ascending" data-type="number"/>							
				<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M12&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td><img src="admin/media/{visible}.gif" width="16" height="15"/></td>
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M12&amp;id={id}"><xsl:value-of select="title" disable-output-escaping="yes"/></a></td>
					<td class="data2"><xsl:value-of select="description"/></td>
					<td class="data2"><xsl:value-of select="order"/></td>
				</tr>				
			</xsl:for-each>		
			<tr><td colspan="5" align="right"><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M12&amp;id=new';" type="button" value="{$string[15]}"/></td></tr>		
		</table>
	</xsl:template>


	<!-- Ajouter une dicussion template  -->
	<xsl:template name="newsgroup_add">
		
		<table bgcolor="white"><form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmFullxml"><tr><td>			
			<input type="hidden" name="file" value="discussion"/>
			<input type="hidden" name="operation" value="add"/>
			<input type="hidden" name="bloc" value="discussions"/>
			<input type="hidden" name="node" value="discussion"/>
				
			<table class="block">	
				<tr><td  class="xp_sel"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[191]"/>:</td><td><input type="text" name="title" value="" class="full"/></td></tr>
				<tr><td  class="xp_sel"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[566]"/>:</td><td><input type="text" name="order" value="" class="mini"/></td></tr>
				<tr><td  class="xp_sel"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[591]"/>:</td><td><input type="text" name="moderator" value="" class="full"/></td></tr>
				<tr><td  class="xp_sel"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[192]"/>:</td>
					<td>
						<textarea class="textarea" name="description" title="{$string[438]}"></textarea>
						<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('description');</script></xsl:if>
					</td>
				</tr>
				<!-- ACESS RESTRICTION -->   	
				<!--<tr><td  class="xp_sel"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[333]"/>:</td><td><select name="member"><option value="off" selected="selected"> Anonymous</option><option value="on"> Members only</option><option value="admin"> Administrators only</option></select></td></tr>-->
				<tr><td  class="xp_sel"><xsl:value-of select="$string[193]"/>:</td><td><select name="visible"><option value="on"> <xsl:value-of select="$string[194]"/></option><option value="off" selected="selected"> <xsl:value-of select="$string[195]"/></option></select></td></tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=0';"/>
					</td>
				</tr>
			</table>
		</td></tr></form></table>
	</xsl:template>


	<!-- configurer une discussion template  -->
	<xsl:template name="newsgroup_update">
		<table bgcolor="white"><tr><td>
		
				
			<table class="block">
				<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmFullxml">
				<input type="hidden" name="file" value="discussion"/>
				<input type="hidden" name="operation" value="update"/>
				<input type="hidden" name="node" value="discussions/discussion[id={id}]"/>			
			
				<tr><td class="xp_sel"><xsl:value-of select="$string[191]"/>:</td><td><input type="text" name="title" value="{title}" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[566]"/>:</td><td><input type="text" name="order" value="{order}" class="mini"/></td></tr>	
				<tr><td  class="xp_sel"><xsl:value-of select="$string[591]"/>:</td><td><input type="text" name="moderator" value="{moderator}" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[192]"/>:</td>
					<td>
						<textarea class="textarea" name="description" title="{$string[438]}"><xsl:value-of select="description"/></textarea>
						<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('description');</script></xsl:if>
					</td>
				</tr>
				<!-- ACESS RESTRICTION -->
    				<!--<tr><td class="xp_sel"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[333]"/>:</td><td><select name="member"><option value="off"><xsl:if test="member='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>anonymous</option><option value="on"><xsl:if test="member='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> Members only</option><option value="admin"><xsl:if test="member='admin'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> Administrators only</option></select></td></tr>-->
				<tr><td class="xp_sel"><xsl:value-of select="$string[193]"/>:</td><td><select name="visible"><option value="off"><xsl:if test="visible='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[195]"/></option><option value="on"><xsl:if test="visible='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> <xsl:value-of select="$string[194]"/></option></select></td></tr>
				
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=0';"/>
					</td>
				</tr></form></table>
										
			<table class="block">
				<form action="default.asp?ACT=1&amp;SECT=M12" method="post" onsubmit="return confirm('{$string[196]}');">
					<tr><td colspan="2" align="right">						
						<input type="hidden" name="file" value="discussion"/>
						<input type="hidden" name="operation" value="delete"/>
						<input type="hidden" name="node" value="discussions/discussion[id={id}]"/>
						<input type="submit" value="{$string[16]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					</td></tr></form>
			</table>
		</td></tr></table><br/>
		<xsl:call-template name="newsgroup_msglist"/>
	</xsl:template>
	
	<!-- Thread list -->
	<xsl:template name="newsgroup_threadlist">
			
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr>
				<td class="header" width="16"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td class="header" width="16">Id</td>
				<td class="header"><xsl:value-of select="$string[261]"/></td>
				<td class="header"><xsl:value-of select="$string[262]"/></td>
				<!--<td class="header"><xsl:value-of select="$string[273]"/></td>-->
			</tr>			
			
			<xsl:for-each select="document($discussionfile)//discussions/discussion[id=$id]/message">
				<xsl:sort select="id" data-type="number" order="descending"/>								
				<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M16&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td><img src="admin/media/{visible}.gif" width="16" height="15"/></td>
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2"><xsl:value-of select="title" disable-output-escaping="yes"/></td>
					<td class="data2"><xsl:value-of select="concat(pseudo, l)"/></td>
				</tr>
			</xsl:for-each>								
			
			<!--<tr><td colspan="5" align="right"><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M16&amp;id=new';" type="button" value="{$string[15]}"/></td></tr>-->
		</table>
	</xsl:template>
	
	
	<xsl:template name="newsgroup_msglist">			
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr>
				<td class="header" width="16"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td class="header" width="16">Id</td>
				<td class="header"><xsl:value-of select="$string[261]"/></td>
				<td class="header"><xsl:value-of select="$string[262]"/></td>
			</tr>			
			<xsl:for-each select="document($discussionfile)//discussions/discussion[id=$id]//message">
				<xsl:sort select="id" data-type="number" order="descending"/>								
				<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M16&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td><img src="admin/media/{visible}.gif" width="16" height="15"/></td>
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2"><xsl:value-of select="title" disable-output-escaping="yes"/></td>
					<td class="data2"><xsl:value-of select="concat(pseudo, l)"/></td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	

</xsl:stylesheet>