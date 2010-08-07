<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html"/> 

	<xsl:template name="calendar_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Event Calendar</xsl:with-param>
			<xsl:with-param name="version">0.8</xsl:with-param>
			<xsl:with-param name="moddate">07.11.2003</xsl:with-param>
			<xsl:with-param name="author">JeS (Jens Schreiber)</xsl:with-param>
			<xsl:with-param name="url">http://www.fxmods.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--       the entry point of module      -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="events_manager">
		<xsl:call-template name = "ecnavigator" />
		
		<script>
			var fx_imgwin;
			 var fx_opener;			
			 			
			function OpenImage(oOpener) 
			{
				fx_opener = oOpener;
				fx_imgwin = window.open('filepicker.asp','selImg','width=450, height=330, scrollbars=yes'); 
				fx_imgwin.focus();
			}
			
			function onImage(u, base_url, iborder, ialign, ialt, num) {
				fx_opener.value = u;
				fx_imgwin.close();
			}
		</script>
		
		<xsl:choose>
			<xsl:when test="$type='calendar'">
				<xsl:choose>
					<xsl:when test="$id='new'">
						<xsl:call-template name = "ec_calendar_add" />
					</xsl:when>
					<xsl:when test="$id">
						<xsl:for-each select = "document($calendarfile)/eventcalendar/calendar[id=$id]">
					    	<xsl:call-template name = "ec_calendar_update" />
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>					
						<xsl:call-template name = "ec_calendar_list" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$type='event'">
				<xsl:choose>
					<xsl:when test="$id='new'">
						<xsl:call-template name = "ec_event_add" />
					</xsl:when>
					<xsl:when test="$id">
						<xsl:for-each select = "document($calendarfile)/eventcalendar/calendar[id=$calendar]/event[id=$id]">
					    	<xsl:call-template name = "ec_event_update" />
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name = "ec_calendarselect"/>
						<xsl:if test="string-length($calendar) &gt; 0">
							<xsl:call-template name = "ec_event_list" />
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>					
				<xsl:call-template name = "ec_calendar_list" />
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--         navigator at the top         -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="ecnavigator">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr>
				<td align="left" valign="center" width="50">
						<a href="default.asp?ACT=1&amp;SECT={$section}&amp;type=calendar"><img src="admin/media/eccalendar.gif" border="0"/></a>
				</td>
				<td align="left" valign="center">
					<font size="6"><b>
						<xsl:value-of select="$string[$ecbasestring + 33]"/>
					</b></font>
				</td>
				<td align="left" valign="center" width="50">
						<a href="default.asp?ACT=1&amp;SECT={$section}&amp;type=event&amp;calendar={$calendar}"><img src="admin/media/ecevent.gif" border="0"/></a>
				</td>				
				<td align="left" valign="center">
					<font size="6"><b>
						<xsl:value-of select="$string[$ecbasestring + 22]"/>
					</b></font>
				</td>
			</tr>
		</table>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--     selectbox for all calendars      -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="ec_calendarselect">
		<table bgcolor="white" border="0" cellpadding="0" cellspacing="1" width="100%">
			<form name="frmCalendar" action="default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}" method="post">
				<tr><td width="40%"><font size="3"><xsl:value-of select="$string[$ecbasestring + 32]"/>: </font>
				<select name="calendar" onchange="document.frmCalendar.submit();return;">
					<xsl:for-each select="document($calendarfile)/eventcalendar/calendar">
						<xsl:sort select="calname" order="ascending"/>
							<xsl:call-template name="ec_selectentry"/>
						</xsl:for-each>
				</select>
				</td>
				<td width="60%" align="left">
					<input type="submit" value="{$string[$ecbasestring + 44]}"/>
				</td>
				</tr>
			</form>
		</table>
	</xsl:template>
		
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--   entry for selectbox for calendars  -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="ec_selectentry">
		<xsl:variable name="calid"><xsl:value-of select="id"/></xsl:variable>
		<xsl:choose>
			<xsl:when test="$calendar=$calid">
				<option value="{$calid}"><xsl:attribute name="selected">selected</xsl:attribute><xsl:value-of select="calname"/></option>
			</xsl:when>
			<xsl:otherwise>
				<option value="{$calid}"><xsl:value-of select="calname"/></option>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--         list of all calendars        -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="ec_calendar_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">
			<tr>
				<td class="header" width="16">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td class="header" width="50"><xsl:value-of select="$string[$ecbasestring + 24]"/></td>				
				<td class="header"><xsl:value-of select="$string[$ecbasestring + 26]"/></td>
			</tr>
			<xsl:for-each select="document($calendarfile)/eventcalendar/calendar">
				<tr bgcolor="white" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);" ondblclick="goto('default.asp?ACT=1&amp;SECT={$section}&amp;type=calendar&amp;id={id}');">
					<td>
						<a href="default.asp?ACT=91&amp;calendar={id}"><img src="admin/media/{visible}.gif" width="16" height="15" border="0"/></a>
					</td>
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2">
						<a href="default.asp?ACT=1&amp;SECT={$section}&amp;type=calendar&amp;id={id}"><xsl:value-of select="calname"/></a>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<input type="submit" value="{$string[420]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;type=calendar&amp;id=new';"/>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--           add new calendar           -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="ec_calendar_add">
		<table bgcolor="white">
			<form action="default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="calendar"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="bloc" value="eventcalendar"/>
						<input type="hidden" name="node" value="calendar"/>

						<table class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 27]"/>:
								</td>
								<td>
									<input type="text" name="calname" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 48]"/>:
								</td>
								<td>
									<input type="text" name="evtcount" class="mini"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 49]"/>:
								</td>
								<td>
									<input type="text" name="prevevtcount" class="mini"/>
								</td>
							</tr>
							<tr>
								<td  class="xp_sel">
									<xsl:value-of select="$string[126]"/>:
								</td>
								<td>
									<input type="text" name="image" class="full"/>
									<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.image);"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 41]"/>:
								</td>
								<td>
									<select name="editor">
										<option value="off" selected="selected">Off</option>
										<option value="anonymous">Anonymous</option>
										<option value="member">Member</option>
										<option value="editor">Editor</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 45]"/>:
								</td>
								<td>
									<select name="group">
										<option value="anonymous" selected="selected">Anonymous</option>
										<option value="member">Member</option>
										<option value="editor">Editor</option>
										<option value="administrator">Administrator</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 30]"/>:
								</td>								
								<td>
									<select name="visible">
										<option value="off"><xsl:value-of select="$string[61]"/></option>
										<option value="on"><xsl:attribute name="selected">selected</xsl:attribute><xsl:value-of select="$string[60]"/></option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}';"/>
								</td>
							</tr>
						</table>
						<br/>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--           update calendar            -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="ec_calendar_update">
		<table bgcolor="white">
			<form action="default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="calendar"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="eventcalendar/calendar[id={$id}]"/>

						<table class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 27]"/>:
								</td>
								<td>
									<input type="text" value="{calname}" name="calname" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 48]"/>:
								</td>
								<td>
									<input type="text" name="evtcount" class="mini" value="{evtcount}"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 49]"/>:
								</td>
								<td>
									<input type="text" name="prevevtcount" class="mini" value="{prevevtcount}"/>
								</td>
							</tr>
							<tr>
								<td  class="xp_sel">
									<xsl:value-of select="$string[126]"/>:
								</td>
								<td>
									<input type="text" name="image" value="image" class="full"/>
									<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[125]}" onclick="OpenImage(document.frmFullxml.image);"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 41]"/>:
								</td>
								<td>
									<select name="editor">
										<option value="off"><xsl:if test="editor='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Off</option>
										<option value="anonymous"><xsl:if test="editor='anonymous'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Anonymous</option>
										<option value="member"><xsl:if test="editor='member'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Member</option>
										<option value="editor"><xsl:if test="editor='editor'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Editor</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 45]"/>:
								</td>
								<td>
									<select name="group">
										<option value="anonymous"><xsl:if test="group='anonymous'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Anonymous</option>
										<option value="member"><xsl:if test="group='member'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Member</option>
										<option value="editor"><xsl:if test="group='editor'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Editor</option>
										<option value="administrator"><xsl:if test="group='administrator'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Administrator</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 30]"/>:
								</td>
								<td>
									<select name="visible">
										<option value="off">
											<xsl:if test="visible='off'">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="$string[61]"/>
										</option>
										<option value="on">
											<xsl:if test="visible='on'">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="$string[60]"/>
										</option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}';"/>
								</td>
							</tr>
						</table>
						<br/>
					</td>
				</tr>
			</form>
			<xsl:if test="$usertype='administrator'">
				<tr>
					<td>
						<form action="default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}" method="post" onsubmit="return confirm('{$string[83]}');">
							<table class="block">
								<tr>
									<td bgcolor="white" align="right">
								    	<input type="hidden" name="file" value="calendar"/>
										<input type="hidden" name="operation" value="delete"/>
										<input type="hidden" name="node" value="eventcalendar/calendar[id={$id}]"/>
										<input type="submit" value="{$string[16]}"/>
									</td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--           list of all events         -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="ec_dateformat">
		<xsl:param name="date" />
		<xsl:if test="string-length($date) > 0">
			<xsl:call-template name="display_date"><xsl:with-param name="p_Date" select="$date"/></xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--           list of all events         -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="ec_event_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">
			<tr>
				<td class="header" width="16">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td class="header" width="50">
					<xsl:value-of select="$string[$ecbasestring + 24]"/>
				</td>
				<td class="header" width="80">
					<xsl:value-of select="$string[$ecbasestring + 25]"/>
				</td>
				<td class="header" width="80">
					<xsl:value-of select="$string[$ecbasestring + 47]"/>
				</td>
				<td class="header">
					<xsl:value-of select="$string[$ecbasestring + 26]"/>
				</td>
			</tr>
			<xsl:for-each select="document($calendarfile)/eventcalendar/calendar[id=$calendar]/event">
				<tr bgcolor="white" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);" ondblclick="goto('default.asp?ACT={$ACT}&amp;SECT={$section}&amp;type={$type}&amp;calendar={$calendar}&amp;id={id}');">
					<td>
						<a href="default.asp?id=ß&amp;ACT=91&amp;calendar={$calendar}&amp;eventid={id}">
							<img src="admin/media/{visible}.gif" width="16" height="15" border="0"/>
						</a>
					</td>
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2">						
						<xsl:call-template name = "ec_dateformat" >
							<xsl:with-param name="date">	
								<xsl:value-of select="eventdate"/>
							</xsl:with-param>
						</xsl:call-template>
					</td>
					<td class="data2">
						<xsl:call-template name = "ec_dateformat" >
							<xsl:with-param name="date">
								<xsl:value-of select="previewdate"/>
							</xsl:with-param>
						</xsl:call-template>
					</td>
					<td class="data2">
						<a href="default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}&amp;calendar={$calendar}&amp;id={id}"><xsl:value-of select="shortdesc"/></a>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<input type="submit" value="{$string[420]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;calendar={$calendar}&amp;type=event&amp;id=new';"/>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--             add new event            -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="ec_event_add">
		<table bgcolor="white">
			<form action="default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}&amp;calendar={$calendar}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="calendar"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="bloc" value="eventcalendar/calendar[id={$calendar}]"/>
						<input type="hidden" name="node" value="event"/>

						<table class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 27]"/>:
								</td>
								<td>
									<input type="text" name="shortdesc" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 28]"/>:
								</td>
								<td>
									<textarea  class="textarea" name="description" title="Description"></textarea>
									<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('description');</script></xsl:if>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 29]"/>:
								</td>
								<td>
									<input type="text" name="link" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 30]"/>:
								</td>
								<td>
									<select name="visible">
										<option value="off"><xsl:value-of select="$string[61]"/></option>
										<option value="on"><xsl:attribute name="selected">selected</xsl:attribute><xsl:value-of select="$string[60]"/></option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 31]"/>:
								</td>
								<td>
									<input type="text" name="eventdate" onClick="cal.select(this, 'eventdate', 'yyyyMMdd');" maxlength="8" class="mini"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 37]"/>:
								</td>
								<td>
									<input type="text" name="previewdate" onClick="cal.select(this, 'previewdate', 'yyyyMMdd');" maxlength="8" class="mini"/>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}&amp;calendar={$calendar}';"/>
								</td>
							</tr>
						</table>
						<br/>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--              edit events             -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="ec_event_update">
		<table bgcolor="white">
			<form action="default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}&amp;calendar={$calendar}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="calendar"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="eventcalendar/calendar[id={$calendar}]/event[id={$id}]"/>

						<table class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 27]"/>:
								</td>
								<td>
									<input type="text" name="shortdesc" value="{shortdesc}" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 28]"/>:
								</td>
								<td>
									<textarea  class="textarea" name="description" title="Description">
										<xsl:value-of select="description" />
									</textarea>
									<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('description');</script></xsl:if>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 29]"/>:
								</td>
								<td>
									<input type="text" name="link" value="{link}" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 30]"/>:
								</td>
								<td>
									<select name="visible">
										<option value="off">
											<xsl:if test="visible='off'">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="$string[61]"/>
										</option>
										<option value="on">
											<xsl:if test="visible='on'">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="$string[60]"/>
										</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 31]"/>:
								</td>
								<td>
									<input type="text" name="eventdate" value="{eventdate}" onClick="cal.select(this, 'eventdate', 'yyyyMMdd');" maxlength="8" class="mini"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 37]"/>:
								</td>
								<td>
									<input type="text" name="previewdate" value="{previewdate}" onClick="cal.select(this, 'previewdate', 'yyyyMMdd');" maxlength="8" class="mini"/>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}&amp;calendar={$calendar}';"/>
								</td>
							</tr>
						</table>
						<br/>
					</td>
				</tr>
			</form>
			<xsl:if test="$usertype='administrator'">
				<tr>
					<td>
						<form action="default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}&amp;calendar={$calendar}" method="post" onsubmit="return confirm('{$string[83]}');">
							<table class="block">
								<tr>
									<td bgcolor="white" align="right">
								    	<input type="hidden" name="file" value="calendar"/>
										<input type="hidden" name="operation" value="delete"/>
										<input type="hidden" name="node" value="eventcalendar/calendar[id={$calendar}]/event[id={$id}]"/>
										<input type="submit" value="{$string[16]}"/>
									</td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>

</xsl:stylesheet>
