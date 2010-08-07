<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve">
<xsl:output method="html"/> 

<!-- Polls Template : add/update/modify -->
<!-- last modified : 2002/10/26, by J.Roland -->
<!-- version 1.0 -->

	<xsl:template name="poll_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Poll</xsl:with-param>
			<xsl:with-param name="version">1.0</xsl:with-param>
			<xsl:with-param name="moddate">13.04.2004</xsl:with-param>
			<xsl:with-param name="author">John Roland and Mig100 (Miguel Figueira)</xsl:with-param>
			<xsl:with-param name="url">http://www.fullxml.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<!-- Content manager -->
	<xsl:template name="poll_manager">
		<table style="border: 1px black solid; background: white; width: 100%; height: 40px; " cellspacing="2">
						<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M5"><img src="admin/media/polls.gif" border="0"/></a></td>
						<td><font size="6"><xsl:value-of select="$string[90]"/></font></td></tr>
					</table><br/>
					
					<xsl:choose>
						<xsl:when test="$id=''">
							<xsl:call-template name="poll_list"/>
						</xsl:when>
						<xsl:when test="$id='new'">
							<xsl:call-template name="poll_add"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:for-each select="document($pollfile)//polls/poll[id=$id]"><xsl:call-template name="poll_update"/></xsl:for-each>
						</xsl:otherwise>
					</xsl:choose>
	</xsl:template> 
	
	
	<!-- polls list -->
	<xsl:template name="poll_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr>
				<td class="header" width="16"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td class="header" width="50">Id</td>
				<td class="header"><xsl:value-of select="$string[91]"/></td></tr>			
			
			<xsl:for-each select="document($pollfile)//polls/poll">								
				<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M5&amp;id={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td><a href="default.asp?id={idpage}&amp;mnu={idpage}"><img src="admin/media/on.gif" width="16" height="15" border="0"/></a></td>
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M5&amp;id={id}"><xsl:value-of select="name" disable-output-escaping="yes"/></a></td></tr>
			</xsl:for-each>								
			
			<tr>
			<td colspan="3" align="right">
				<input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M5&amp;id=new';" type="button" value="{$string[15]}"/></td></tr>
		</table>
	</xsl:template>
	
	
	<!-- addpoll template  -->
	<xsl:template name="poll_add">
	
		<table bgcolor="white"><form action="default.asp?ACT=1&amp;SECT=M5" method="post"><tr><td>			
			<input type="hidden" name="file" value="poll"/>
			<input type="hidden" name="operation" value="add"/>
			<input type="hidden" name="bloc" value="polls"/>
			<input type="hidden" name="node" value="poll"/>
						
			<table class="block">				
				<tr><td class="xp_sel"><xsl:value-of select="$string[91]"/>:</td><td><input type="text" name="name" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[99]"/>:</td><td><select name="idpage"><option value="none"><xsl:value-of select="$string[100]"/></option><xsl:for-each select="siteinfo/pages/page"><option value="{id}"><xsl:value-of select="name"/></option></xsl:for-each><option value="0"><xsl:value-of select="$string[88]"/></option></select></td></tr>
				<tr>
        				<td class="xp_sel"><xsl:value-of select="$string[433]"/>:</td>
        				<td>
        					<select name="position">
        						<option value="left"><xsl:value-of select="$string[436]"/></option>
        						<option value="right"><xsl:value-of select="$string[437]"/></option>						
        					</select>
        				</td>
        			</tr>
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[92]"/>:</td><td><input type="text" name="question" class="full"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[93]"/>:</td><td><input type="text" value="" name="choice1" class="full"/><input type="hidden" name="count1" value="0"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[94]"/>:</td><td><input type="text" value="" name="choice2" class="full"/><input type="hidden" name="count2" value="0"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[95]"/>:</td><td><input type="text" value="" name="choice3" class="full"/><input type="hidden" name="count3" value="0"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[96]"/>:</td><td><input type="text" value="" name="choice4" class="full"/><input type="hidden" name="count4" value="0"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[97]"/>:</td><td><input type="text" value="" name="choice5" class="full"/><input type="hidden" name="count5" value="0"/></td></tr>				
				<tr><td class="xp_sel"><xsl:value-of select="$string[103]"/>:</td><td><input type="text" value="" name="choice6" class="full"/><input type="hidden" name="count6" value="0"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[104]"/>:</td><td><input type="text" value="" name="choice7" class="full"/><input type="hidden" name="count7" value="0"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[105]"/>:</td><td><input type="text" value="" name="choice8" class="full"/><input type="hidden" name="count8" value="0"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[106]"/>:</td><td><input type="text" value="" name="choice9" class="full"/><input type="hidden" name="count9" value="0"/></td></tr>
				<tr><td class="xp_sel"><xsl:value-of select="$string[107]"/>:</td><td><input type="text" value="" name="choice10" class="full"/><input type="hidden" name="count10" value="0"/></td></tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=0';" />
					</td>
				</tr>
			</table>
				
		</td></tr></form>
		</table>
	</xsl:template>

		
		<!-- configppoll template  -->
		<xsl:template name="poll_update">
			<xsl:variable name="idpage"><xsl:value-of select="document($pollfile)//polls/poll[id=$id]/idpage"/></xsl:variable>
			
			<table bgcolor="white"><tr><td>
				<form action="default.asp?ACT=1&amp;SECT={$section}" method="post">
					<input type="hidden" name="file" value="poll"/>
					<input type="hidden" name="operation" value="update"/>
					<input type="hidden" name="node" value="polls/poll[id={$id}]"/>
						
				<table class="block">	
					<tr><td class="xp_sel"><xsl:value-of select="$string[91]"/>:</td><td><input type="text" value="{name}" name="name" class="full"/></td></tr>
					<tr><td class="xp_sel"><xsl:value-of select="$string[99]"/>:</td><td><select name="idpage"><option value="none"><xsl:if test="$idpage='none'"></xsl:if><xsl:value-of select="$string[100]"/></option><xsl:for-each select="document($datafile)//siteinfo/pages/page"><option value="{id}"><xsl:if test="$idpage=id"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="name"/></option></xsl:for-each><option value="0"><xsl:if test="$idpage=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[88]"/></option></select></td></tr>
				       <tr>
                				<td class="xp_sel"><xsl:value-of select="$string[433]"/>:</td>
                				<td>
                					<select name="position">
                						<option value="left"><xsl:if test="position='left' or string-length(position)=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[436]"/></option>
                						<option value="right"><xsl:if test="position='right'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[437]"/></option>						
                					</select>
                				</td>
                			</tr>
				       <tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>				
				    
					<tr><td class="xp_sel"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[92]"/>:</td><td><input type="text" value="{question}" name="question" class="full"/></td></tr>
					<tr><td class="xp_sel"><xsl:value-of select="$string[93]"/></td><td><input type="text" value="{choice1}" name="choice1" class="full"/><br/>
						 Votes :<input type="text" name="count1" value="{count1}" class="mini"/> </td></tr>
					<tr><td class="xp_sel"><xsl:value-of select="$string[94]"/>:</td><td><input type="text" value="{choice2}" name="choice2" class="full"/><br/>
						 Votes :<input type="text" name="count2" value="{count2}" class="mini"/> </td></tr>
					<tr><td class="xp_sel"><xsl:value-of select="$string[95]"/>:</td><td><input type="text" value="{choice3}" name="choice3" class="full"/><br/>
						 Votes :<input type="text" name="count3" value="{count3}" class="mini"/> </td></tr>
					<tr><td class="xp_sel"><xsl:value-of select="$string[96]"/>:</td><td><input type="text" value="{choice4}" name="choice4" class="full"/><br/>
						 Votes :<input type="text" name="count4" value="{count4}" class="mini"/> </td></tr>
					<tr><td class="xp_sel"><xsl:value-of select="$string[97]"/>:</td><td><input type="text" value="{choice5}" name="choice5" class="full"/><br/>
						 Votes :<input type="text" name="count5" value="{count5}" class="mini"/> </td></tr>
					<tr><td class="xp_sel"><xsl:value-of select="$string[103]"/>:</td><td><input type="text" value="{choice6}" name="choice6" class="full"/><br/>
						 Votes :<input type="text" name="count6" value="{count6}" class="mini"/> </td></tr>
					<tr><td class="xp_sel"><xsl:value-of select="$string[104]"/>:</td><td><input type="text" value="{choice7}" name="choice7" class="full"/><br/>
						 Votes :<input type="text" name="count7" value="{count7}" class="mini"/> </td></tr>
					<tr><td class="xp_sel"><xsl:value-of select="$string[105]"/>:</td><td><input type="text" value="{choice8}" name="choice8" class="full"/><br/>
						 Votes :<input type="text" name="count8" value="{count8}" class="mini"/> </td></tr>
					<tr><td class="xp_sel"><xsl:value-of select="$string[106]"/>:</td><td><input type="text" value="{choice9}" name="choice9" class="full"/><br/>
						 Votes :<input type="text" name="count9" value="{count9}" class="mini"/> </td></tr>
					<tr><td class="xp_sel"><xsl:value-of select="$string[107]"/>:</td><td><input type="text" value="{choice10}" name="choice10" class="full"/><br/>
						 Votes :<input type="text" name="count10" value="{count10}" class="mini"/> </td></tr>
				
					<tr><td colspan="2" align="right">
							<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M5';"/>
					</td></tr></table>					
				</form>
				
				<table class="block">
					<tr>
						<td colspan="5" align="right">
							<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" onsubmit="return confirm('{$string[101]}');">
								<input type="hidden" name="file" value="poll"/>
								<input type="hidden" name="operation" value="delete"/>
								<input type="hidden" name="node" value="polls/poll[id={$id}]"/>
								<input type="submit" value="{$string[16]}"/>
							</form>
						</td>
					</tr>
				</table>
			</td></tr></table>
		</xsl:template>
</xsl:stylesheet>