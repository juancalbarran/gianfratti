<?xml version="1.0" encoding="UTF-8"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve"> 
<xsl:output method="html"/> 

	<xsl:template name="desktop_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Desktop</xsl:with-param>
			<xsl:with-param name="version">1.0</xsl:with-param>
			<xsl:with-param name="moddate">08.03.2004</xsl:with-param>
			<xsl:with-param name="author">John Roland, JeS (Jens Schreiber) and Mig100 (Miguel Figueira)</xsl:with-param>
			<xsl:with-param name="url">http://www.fxmods.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="desktop_unused">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1"><img src="admin/media/desktop.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[280]"/></font></td></tr>
		</table>
		<table width="400" cellpadding="0" cellspacing="0">			
			<xsl:choose>
				<xsl:when test="document($datafile)/siteinfo/data/textdirection = 'RTL'">
					<tr>	<td><xsl:value-of select="$username"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$string[286]"/></b></td></tr>
					<tr>	<td><font color="#808080">n</font><xsl:value-of select="count(document($memberfile)//members/member)"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>:<xsl:value-of select="$string[281]"/></td></tr>
					<tr>	<td><font color="#808080">n</font><xsl:value-of select="count(document($guestbookfile)//guests/guest[visible!='on'])"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>:<xsl:value-of select="$string[282]"/></td></tr>
					<tr>	<td><font color="#808080">n</font><xsl:value-of select="count(document($reactfile)//reacts/react[visible!='on'])"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>:<xsl:value-of select="$string[283]"/></td></tr>
					<tr>	<td><font color="#808080">n</font><xsl:value-of select="count(document($calendarfile)//eventcalendar/calendar/event[visible!='on'])"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>:<xsl:value-of select="$string[$ecbasestring + 53]"/></td></tr>
					<tr>	<td><font color="#808080">n</font><xsl:value-of select="count(document($discussionfile)//discussions/discussion//message)"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>:<xsl:value-of select="$string[284]"/></td></tr>
					<tr>	<td><font color="#808080">n</font><xsl:value-of select="count(document($directoryfile)//item[@published='off'])"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>:<xsl:value-of select="$string[540]"/></td></tr>
					<tr>	<td><font color="#808080">n</font><xsl:value-of select="count(document($logdata//logs/log[@date=substring($actualdate,1,8)]/@name)//visitors//p)"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>:<xsl:value-of select="$string[285]"/></td></tr>
					<tr>	<td><font color="#808080">n</font><xsl:value-of select="concat(substring($version,1,1), '.', substring($version,2,1), '.', substring($version,3,3))"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>:<xsl:value-of select="$string[287]"/></td></tr>
				</xsl:when>
				<xsl:otherwise>	
					<tr>	<td><b><xsl:value-of select="$string[286]"/></b> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$username"/></td></tr>
					<tr>	<td><xsl:value-of select="$string[281]"/>: <xsl:value-of select="count(document($memberfile)//members/member)"/></td></tr>
					<tr>	<td><xsl:value-of select="$string[282]"/>: <xsl:value-of select="count(document($guestbookfile)//guests/guest[visible!='on'])"/></td></tr>
					<tr>	<td><xsl:value-of select="$string[283]"/>: <xsl:value-of select="count(document($reactfile)//reacts/react[visible!='on'])"/></td></tr>
					<tr>	<td><xsl:value-of select="$string[$ecbasestring + 53]"/>: <xsl:value-of select="count(document($reactfile)//reacts/react[visible!='on'])"/></td></tr>
					<tr>	<td><xsl:value-of select="$string[284]"/>: <xsl:value-of select="count(document($discussionfile)//discussions/discussion//message)"/></td></tr>
					<tr>	<td><xsl:value-of select="$string[540]"/>: <xsl:value-of select="count(document($directoryfile)//item[@published='off'])"/></td></tr>			
					<tr>	<td><xsl:value-of select="$string[285]"/>: <xsl:value-of select="count(document($logdata//logs/log[@date=substring($actualdate,1,8)]/@name)//visitors//p)"/></td></tr>
					<tr>	<td><xsl:value-of select="$string[287]"/> <xsl:value-of select="concat(substring($version,1,1), '.', substring($version,2,1), '.', substring($version,3,3))"/></td></tr>
				</xsl:otherwise>
			</xsl:choose>
		</table>	

	</xsl:template>

	<xsl:template name="desktop">
		<table width="400" cellpadding="0" cellspacing="0">
			<xsl:choose>
				<xsl:when test="document($datafile)/siteinfo/data/textdirection = 'RTL'">
					<tr>	<td><xsl:value-of select="$username"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$string[286]"/></b></td></tr>
					<tr>	<td><font color="#808080">n</font><xsl:value-of select="count(document($memberfile)//members/member)"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>:<xsl:value-of select="$string[281]"/></td></tr>
					<tr>	<td><font color="#808080">n</font><xsl:value-of select="count(document($guestbookfile)//guests/guest[visible!='on'])"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>:<xsl:value-of select="$string[282]"/></td></tr>
					<tr>	<td><font color="#808080">n</font><xsl:value-of select="count(document($reactfile)//reacts/react[visible!='on'])"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>:<xsl:value-of select="$string[283]"/></td></tr>
					<tr>	<td><font color="#808080">n</font><xsl:value-of select="count(document($calendarfile)//eventcalendar/calendar/event[visible!='on'])"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>:<xsl:value-of select="$string[$ecbasestring + 53]"/></td></tr>
					<tr>	<td><font color="#808080">n</font><xsl:value-of select="count(document($discussionfile)//discussions/discussion//message)"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>:<xsl:value-of select="$string[284]"/></td></tr>
					<tr>	<td><font color="#808080">n</font><xsl:value-of select="count(document($directoryfile)//item[@published='off'])"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>:<xsl:value-of select="$string[540]"/></td></tr>
					<tr>	<td><font color="#808080">n</font><xsl:value-of select="count(document($classifiedfile)/classified/adds/add[visible='off'and enddate &gt;= $presentdate])"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>:<xsl:value-of select="$string[$classbasestring + 32]"/></td></tr>
					<tr>	<td><font color="#808080">n</font><xsl:value-of select="count(document($classifiedfile)/classified/users/user[visible='off'])"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>:<xsl:value-of select="$string[$classbasestring + 33]"/></td></tr>
					<tr>	<td><font color="#808080">n</font><xsl:value-of select="count(document($logdata//logs/log[@date=substring($actualdate,1,8)]/@name)//visitors//p)"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>:<xsl:value-of select="$string[285]"/></td></tr>
					<tr>	<td><font color="#808080">n</font><xsl:value-of select="concat(substring($version,1,1), '.', substring($version,2,1), '.', substring($version,3,3))"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>:<xsl:value-of select="$string[287]"/></td></tr>
				</xsl:when>
				<xsl:otherwise>	
					<tr>	<td><b><xsl:value-of select="$string[286]"/></b> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$username"/></td></tr>
					<tr>	<td><xsl:value-of select="$string[281]"/>: <xsl:value-of select="count(document($memberfile)//members/member)"/></td></tr>
					<tr>	<td><xsl:value-of select="$string[282]"/>: <xsl:value-of select="count(document($guestbookfile)//guests/guest[visible!='on'])"/></td></tr>
					<tr>	<td><xsl:value-of select="$string[283]"/>: <xsl:value-of select="count(document($reactfile)//reacts/react[visible!='on'])"/></td></tr>
					<tr>	<td><xsl:value-of select="$string[$ecbasestring + 53]"/>: <xsl:value-of select="count(document($calendarfile)//eventcalendar/calendar/event[visible!='on'])"/></td></tr>
					<tr>	<td><xsl:value-of select="$string[284]"/>: <xsl:value-of select="count(document($discussionfile)//discussions/discussion//message)"/></td></tr>
					<tr>	<td><xsl:value-of select="$string[540]"/>: <xsl:value-of select="count(document($directoryfile)//item[@published='off'])"/></td></tr>
					<tr>	<td><xsl:value-of select="$string[$classbasestring + 32]"/>: <xsl:value-of select="count(document($classifiedfile)/classified/adds/add[visible='off' and enddate &gt;= $presentdate])"/></td></tr>
					<tr>	<td><xsl:value-of select="$string[$classbasestring + 33]"/>: <xsl:value-of select="count(document($classifiedfile)/classified/users/user[visible='off'])"/></td></tr>					
					<tr>	<td><xsl:value-of select="$string[285]"/>: <xsl:value-of select="count(document($logdata//logs/log[@date=substring($actualdate,1,8)]/@name)//visitors//p)"/></td></tr>
					<tr>	<td><xsl:value-of select="$string[287]"/>: <xsl:value-of select="concat(substring($version,1,1), '.', substring($version,2,1), '.', substring($version,3,3))"/></td></tr>	
				</xsl:otherwise>
			</xsl:choose>
		</table>
		
	
		<!-- <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>Last version available : <xsl:value-of select="document('http://www.fullxml.com/fullxml.xml')//fullxml/@number"/>-->

		<br/>
		<table style="width:100%; background: #ECE9D8; border-color: #ACA899; border: 1px"><tr><td> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[290]"/></td></tr></table>
		
		
		<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#ECE9D8">		
			<tr>
				<td class="header" width="16"> ! </td>
				<td class="header" width="16"><img src="admin/media/dot.gif" width="16" height="1"/></td>
				<td class="header" width="16"><img src="admin/media/dot.gif" width="16" height="1"/></td>
				<td class="header" width="40"><xsl:value-of select="$string[297]"/></td>
				<td class="header" width="99%"> <xsl:value-of select="$string[294]"/></td>
				<td class="header" width="80"> <xsl:value-of select="$string[295]"/></td>
			</tr>
			<!-- Debut add-->
			<tr class="data">
				<form  name="frmaddtask" action="default.asp?ACT=1&amp;SECT=0" method="post">
				<input type="hidden" name="file" value="task"/>
				<input type="hidden" name="operation" value="add"/>
				<input type="hidden" name="bloc" value="tasks"/>
				<input type="hidden" name="node" value="task"/>
				<input type="hidden" name="status" value="0"/>
				<td><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>				
				<td><xsl:value-of select="/siteinfo/now"/></td>
				<td><input type="text" name="comp_description" class="inactive" value="{$string[291]}" onclick="if (this.style.color!='blue') this.value='';this.style.color='blue';" /></td>
				<td><select name="level"><option value="3">High</option><option value="2" selected="selected">normal</option><option value="1">Low</option></select></td>
				</form>
			</tr>		
			<!-- fin  add -->
			<!-- Debut liste -->		
			<xsl:for-each select="document($taskfile)//tasks/task">			
				<xsl:sort select="status" data-type="number" order="ascending"/>				
				<xsl:sort select="level" data-type="number" order="descending"/>
				
				<tr class="data">
					<xsl:choose>
						<xsl:when test="status='0'"><xsl:attribute name="class">data</xsl:attribute></xsl:when>
						<xsl:otherwise><xsl:attribute name="class">inactive</xsl:attribute></xsl:otherwise>
					</xsl:choose>
				
					<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmadm{position()}">
					<input type="hidden" name="file" value="task"/>
					<input type="hidden" name="operation" value="update"/>
					<input type="hidden" name="node" value="tasks/task[id={id}]"/>
					<xsl:choose>
						<xsl:when test="status='1'"><input type="hidden" name="status" value="0"/></xsl:when>
						<xsl:otherwise><input type="hidden"  name="status" value="1"/></xsl:otherwise>
					</xsl:choose>
					<td> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><img src="admin/media/tasklevel_{level}.gif" width="13" height="17"/></td>
					<td> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><img src="admin/media/taskstatus_{status}.gif" width="16" height="16"/></td>
					<td>
						<input type="checkbox" style="margin:0px; border: 0px; width:17px; " onclick="frmadm{position()}.submit();">
							<xsl:if test="status='1'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
						</input>
					</td>
					<td> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:call-template name="display_date"><xsl:with-param name="p_Date" select="date"/></xsl:call-template></td>
					
					<!-- Strike the description if task is completed -->
					<td>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<xsl:choose>
							<xsl:when test="status='1'"><strike><xsl:value-of select="description" disable-output-escaping="yes"/></strike></xsl:when>
							<xsl:otherwise><xsl:value-of select="description" disable-output-escaping="yes"/></xsl:otherwise>
						</xsl:choose>
					</td>
					
					
					<td align="center"><a href="#" onclick="window.document.forms['frmadm{position()}'].elements['operation'].value = 'delete'; window.document.forms['frmadm{position()}'].submit();"><xsl:value-of select="$string[16]"/></a></td>
					</form>
				</tr>
			</xsl:for-each>			
			<!-- Fin liste -->					
			</table>

	</xsl:template>		
	
</xsl:stylesheet>				
