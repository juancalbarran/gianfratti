<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve">
<xsl:output method="html"/> 

<!-- Content Template : add/update/modify -->
<!-- last modified : 2001/10/26, by J.Roland -->
<!-- version 1.0 -->

	<xsl:template name="message_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Forum messages</xsl:with-param>
			<xsl:with-param name="version">1.0</xsl:with-param>
			<xsl:with-param name="moddate">26.10.2001</xsl:with-param>
			<xsl:with-param name="author">John Roland</xsl:with-param>
			<xsl:with-param name="url">http://www.fullxml.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="message_manager">		
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M16"><img src="admin/media/content.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[260]"/></font></td></tr>
		</table><br/>					
		
		<xsl:choose>
			<xsl:when test="$id=''">
				<!--<xsl:apply-templates select="document($xmldb)//recordset[@name='message']" mode="list"/>-->
				<xsl:call-template name="message_list"/>
			</xsl:when>			
			<xsl:otherwise>
				<xsl:for-each select="document($discussionfile)//discussions//message[id=$id]">
					<xsl:call-template name="message_update"/>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="message_list">			
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr>
				<td class="header" width="16"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td class="header" width="16">Id</td>
				<td class="header"><xsl:value-of select="$string[261]"/></td>
				<td class="header"><xsl:value-of select="$string[262]"/></td>
				<!--<td class="header"><xsl:value-of select="$string[273]"/></td>-->
			</tr>		
			<xsl:choose>
				<xsl:when test="$usertype='administrator'">				
					<xsl:for-each select="document($discussionfile)//discussions//message">								
						<xsl:sort select="id" data-type="number" order="descending"/>
						<xsl:if test="position() &gt; number($page*$forum_pagesize) and position() &lt;=  number(($page+1)*$forum_pagesize) ">
							<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M16&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
								<td><img src="admin/media/{visible}.gif" width="16" height="15"/></td>
								<td class="data2"><xsl:value-of select="id"/></td>
								<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M16&amp;id={id}"><xsl:value-of select="title" disable-output-escaping="yes"/></a></td>
								<td class="data2"><xsl:value-of select="concat(pseudo,l)"/></td>
							</tr>
						</xsl:if>
					</xsl:for-each>		
				</xsl:when>
				<!-- for an editor, only the messages from forums moderated by the user appear -->
				<xsl:when test="$usertype='editor'">
					<xsl:for-each select="document($discussionfile)//discussions/discussion[moderator=$username]//message">								
						<xsl:sort select="id" data-type="number" order="descending"/>
						<xsl:if test="position() &gt; number($page*$forum_pagesize) and position() &lt;=  number(($page+1)*$forum_pagesize) ">
							<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M16&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
								<td class="data2"><img src="admin/media/{visible}.gif" width="16" height="15"/></td>
								<td class="data2"><xsl:value-of select="id"/></td>
								<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M16&amp;id={id}"><xsl:value-of select="title" disable-output-escaping="yes"/></a></td>
								<td><xsl:value-of select="concat(pseudo,l)"/></td>
							</tr>
						</xsl:if>
					</xsl:for-each>
				</xsl:when>
			</xsl:choose>
			<!--<tr><td colspan="5" align="right"><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M16&amp;id=new';" type="button" value="{$string[15]}"/></td></tr>-->
		</table>
		
		<!-- Navigation for the Paging -->
		<center>
		<xsl:call-template name="paging_Rail_macro">
			<xsl:with-param name="totalpage" select="count(document($discussionfile)//discussions//message) div $forum_pagesize"/>
			<xsl:with-param name="currentpage" select="number($page)+1"/>
			<xsl:with-param name="url">default.asp?ACT=1&amp;SECT=M16</xsl:with-param>
		</xsl:call-template>
		</center>
		<p/>

		
	</xsl:template>


	<!-- Message template  -->
	<xsl:template name="message_update">
		<table bgcolor="white"><tr><td>
				
			<table class="block">
				<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmFullxml">
				<input type="hidden" name="file" value="discussion"/>
				<input type="hidden" name="operation" value="update"/>
				<input type="hidden" name="node" value="discussions//message[id={id}]"/>
				
				<tr><td class="xp_sel"><xsl:value-of select="$string[261]"/>:</td><td><input type="text" name="title" value="{title}" class="full"/></td></tr>	
				<tr><td class="xp_sel"><xsl:value-of select="$string[262]"/>:</td><td><input type="text" name="l" value="{l}" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[593]"/>:</td><td><select name="format"><option value="text"><xsl:if test="format='text'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[594]"/></option><option value="html"><xsl:if test="format='html'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[595]"/></option></select></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[273]"/>:</td>
					<td>
						<textarea class="textarea" name="body" title="{$string[438]}"><xsl:value-of select="body"/></textarea>
						<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('body');</script></xsl:if>
					</td>
				</tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[263]"/>:</td><td><select name="visible"><option value="off"><xsl:if test="visible='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[195]"/></option><option value="on"><xsl:if test="visible='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> <xsl:value-of select="$string[194]"/></option></select></td></tr>
				
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=0';"/>
					</td>
				</tr>
			</form>
			</table>
			<xsl:if test="$usertype='administrator'">		
			<table class="block">
				<tr>
					<form action="default.asp?ACT=1&amp;SECT=M16" method="post" onsubmit="return confirm('{$string[266]}');">
					<td colspan="2" align="right">
						<input type="hidden" name="file" value="discussion"/>
						<input type="hidden" name="operation" value="delete"/>
						<input type="hidden" name="node" value="discussions//message[id={id}]"/>
						<input type="submit" value="{$string[16]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>						
					</td></form>
				</tr>
			</table>
			</xsl:if>
		</td></tr></table>
	</xsl:template>

</xsl:stylesheet>