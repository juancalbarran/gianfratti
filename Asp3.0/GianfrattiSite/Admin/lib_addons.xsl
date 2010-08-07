<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb"> 
<xsl:output method="html"/> 

	<xsl:template name="addons_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Addons Manager</xsl:with-param>
			<xsl:with-param name="version">1.0</xsl:with-param>
			<xsl:with-param name="moddate">17.03.2004</xsl:with-param>
			<xsl:with-param name="author">John Roland, Mig100 (Miguel Figueira) and JeS (Jens Schreiber)</xsl:with-param>
			<xsl:with-param name="url">http://www.fxmods.com</xsl:with-param>
			<xsl:with-param name="action"></xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Addons settings template  -->
	<xsl:template name="addons_manager">		
		

	<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M101"><img src="admin/media/addons.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[612]"/></font></td></tr>
		</table>

		
	<!-- Site Manager form -->	
	<table bgcolor="white">
	<tr><td>
		<form action="default.asp?ACT=1&amp;SECT=0" method="post" name="frmFullxml">
		<input type="hidden" name="operation" value="update"/>
		<input type="hidden" name="node" value="siteinfo/data"/>
			
			<xsl:for-each select="/siteinfo/data">
			<table class="block">
				<tr>
					<td colspan="2" class="xp_sel"><xsl:value-of select="$string[39]"/>:</td>
				</tr>	
				<!-- Banners -->
				<tr>
					<td class="xp_sel">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[340]"/>:
					</td>
					<td>
							<select name="banner"><option value="off"><xsl:if test="banner='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="banner='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>
					</td>
				</tr>
				<!-- Signup -->
				<tr>
					<td class="xp_sel">
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[9]"/>:
					</td>
					<td>
						<select name="signup" onchange="if (this.value=='off') document.all.inscriptiondefault.style.display= 'none'; else document.all.inscriptiondefault.style.display= 'block';"><option value="off"><xsl:if test="signup='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="signup='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>
						<div id="inscriptiondefault" style="display: none;">							
						<select name="inscriptionstate">
							<xsl:choose>
								<xsl:when test="inscriptionstate='off'"><option value="off" selected="selected">off</option><option value="email"><xsl:value-of select="$string[422]"/></option><option value="on">on</option></xsl:when>
								<xsl:when test="inscriptionstate='email'"><option value="off">off</option><option value="email" selected="selected"><xsl:value-of select="$string[422]"/></option><option value="on">on</option></xsl:when>
								<xsl:otherwise><option value="off">off</option><option value="email"><xsl:value-of select="$string[422]"/></option><option value="on" selected="selected">on</option></xsl:otherwise>
							</xsl:choose>
						</select>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[46]"/><br/>
						
						<xsl:variable name="auth_list">
							<authentifications>
								<auth value="STANDARD" name="{$string[913]}"/>
								<auth value="HTTP" name="{$string[914]}"/>
							</authentifications>
						</xsl:variable>
						
						<xsl:variable name="selectedauth" select="auth"/>
						<select name="auth">
							<xsl:for-each select="msxsl:node-set($auth_list)//authentifications/auth">
								<option value="{@value}">
									<xsl:if test="$selectedauth=@value"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
									<xsl:value-of select="@name"/>
								</option>
							</xsl:for-each>		
						</select>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[912]"/><br/>
						<!-- behavior of field pseudo -->
						<select name="pseudouppercase">
							<xsl:choose>
								<xsl:when test="pseudouppercase='on'">
									<option value="off">off</option>
									<option value="on" selected="selected">on</option>
								</xsl:when>
								<xsl:otherwise>
									<option value="off" selected="selected">off</option>
									<option value="on">on</option>
								</xsl:otherwise>
							</xsl:choose>
						</select>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[911]"/><br/>
						<script>if (document.frmFullxml.signup.value=='off') document.all.inscriptiondefault.style.display= 'none'; else document.all.inscriptiondefault.style.display= 'block';</script>
						</div>
					</td>
				</tr>
				<!-- Tips -->
				<tr>
					<td class="xp_sel">
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[41]"/>:
					</td>
					<td>
						<select name="tip"><option value="off"><xsl:if test="tip='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="tip='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>
					</td>
				</tr>
				<!-- Photo galery -->
				<tr>
					<td class="xp_sel">
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[42]"/>:
					</td>
					<td>
						<select name="photo" onchange="if (this.value=='off') document.all.photodefault.style.display= 'none'; else document.all.photodefault.style.display= 'block';"><option value="off"><xsl:if test="photo='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="photo='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>
						<div id="photodefault" style="display: none;">							
							<input type="radio" name="phototoolbar" value="on">
								<xsl:if test="phototoolbar='on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
							</input>
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[613]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
							<input type="radio" name="phototoolbar" value="off">
								<xsl:if test="phototoolbar='off'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
							</input>
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[614]"/><br/>
						</div>
						<script>if (document.frmFullxml.photo.value=='off') document.all.photodefault.style.display= 'none'; else document.all.photodefault.style.display= 'block';</script>
					</td>
				</tr>
				<!-- Guestbook -->
				<tr>
					<td class="xp_sel">
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[43]"/>:
					</td>
					<td>
						<select name="showguestbook" onchange="if (this.value=='off') document.all.guestbookdefault.style.display= 'none'; else document.all.guestbookdefault.style.display= 'block';"><option value="off"><xsl:if test="showguestbook='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="showguestbook='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>
						<div id="guestbookdefault" style="display: none;">							
							<select name="guestbookstate">
								<xsl:choose>
									<xsl:when test="guestbookstate='on'"><option value="off">off</option><option value="on" selected="selected">on</option></xsl:when>
									<xsl:otherwise><option value="off" selected="selected">off</option><option value="on">on</option></xsl:otherwise>
								</xsl:choose>
							</select>
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[48]"/><br/>
							<input type="radio" name="guestbooktoolbar" value="on">
								<xsl:if test="guestbooktoolbar='on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
							</input>
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[613]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
							<input type="radio" name="guestbooktoolbar" value="off">
								<xsl:if test="guestbooktoolbar='off'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
							</input>
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[614]"/><br/>
						</div>
						<script>if (document.frmFullxml.showguestbook.value=='off') document.all.guestbookdefault.style.display= 'none'; else document.all.guestbookdefault.style.display= 'block';</script>
					</td>
				</tr>
				<!-- Forums -->
				<tr>
					<td class="xp_sel">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[44]"/>:
					</td>
					<td>
						<select name="discussion" onchange="if (this.value=='off') document.all.newsgroupdefault.style.display= 'none'; else document.all.newsgroupdefault.style.display= 'block';"><option value="off"><xsl:if test="discussion='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="discussion='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>
						<div id="newsgroupdefault" style="display: none;">							
							<select name="newsgroupdisplay">
									<option value="0"><xsl:if test="newsgroupdisplay = 0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[278]"/></option>
									<option value="1"><xsl:if test="newsgroupdisplay = 1"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[277]"/></option>
							</select>
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[119]"/><br/>
							<select name="newsgroupstate">
								<xsl:choose>
									<xsl:when test="newsgroupstate='off'"><option value="off" selected="selected">off</option><option value="on">on</option></xsl:when>
									<xsl:otherwise><option value="off">off</option><option value="on" selected="selected">on</option></xsl:otherwise>
								</xsl:choose>									
							</select>
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[47]"/><br/>
							<input type="radio" name="discussiontoolbar" value="on">
								<xsl:if test="discussiontoolbar='on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
							</input>
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[613]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
							<input type="radio" name="discussiontoolbar" value="off">
								<xsl:if test="discussiontoolbar='off'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
							</input>
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[614]"/><br/>
						</div>
						<script>if (document.frmFullxml.discussion.value=='off') document.all.newsgroupdefault.style.display= 'none'; else document.all.newsgroupdefault.style.display= 'block';</script>
					</td>
				</tr>
				<!-- Site Map -->
				<tr>
					<td class="xp_sel">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[370]"/>:
					</td>
					<td>
							<select name="sitemap" onchange="if (this.value=='off') document.all.sitemapdefault.style.display= 'none'; else document.all.sitemapdefault.style.display= 'block';"><option value="off"><xsl:if test="sitemap='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="sitemap='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>
							<div id="sitemapdefault" style="display: none;">							
									 <input type="radio" name="sitemaptoolbar" value="on">
									 				<xsl:if test="sitemaptoolbar='on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
									 </input>
									 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[613]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									 <input type="radio" name="sitemaptoolbar" value="off">
									 				<xsl:if test="sitemaptoolbar='off'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
									 </input>
									 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[614]"/><br/>
							</div>
						<script>if (document.frmFullxml.sitemap.value=='off') document.all.sitemapdefault.style.display= 'none'; else document.all.sitemapdefault.style.display= 'block';</script>
					</td>
				</tr>
				<!-- Downloads -->
				<tr>
					<td class="xp_sel">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[350]"/>:
					</td>
					<td>
							<select name="download" onchange="if (this.value=='off') document.all.downloaddefault.style.display= 'none'; else document.all.downloaddefault.style.display= 'block';"><option value="off"><xsl:if test="download='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Off</option><option value="on"><xsl:if test="download='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> Anonymous</option><option value="member"><xsl:if test="download='member'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> Member</option></select>
							<div id="downloaddefault" style="display: none;">							
									 <input type="radio" name="downloadtoolbar" value="on">
									 				<xsl:if test="downloadtoolbar='on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
									 </input>
									 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[613]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									 <input type="radio" name="downloadtoolbar" value="off">
									 				<xsl:if test="downloadtoolbar='off'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
									 </input>
									 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[614]"/><br/>
							</div>
						<script>if (document.frmFullxml.download.value=='off') document.all.downloaddefault.style.display= 'none'; else document.all.downloaddefault.style.display= 'block';</script>
					</td>
				</tr>
				<!-- knowbase -->
				<tr>
					<td class="xp_sel">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[621]"/>:
					</td>
					<td>
							<select name="knowbase" onchange="if (this.value=='off') document.all.knowbasedefault.style.display= 'none'; else document.all.knowbasedefault.style.display= 'block';"><option value="off"><xsl:if test="knowbase='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="knowbase='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>
							<div id="knowbasedefault" style="display: none;">							
									 <input type="radio" name="knowbasetoolbar" value="on">
									 				<xsl:if test="knowbasetoolbar='on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
									 </input>
									 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[613]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									 <input type="radio" name="knowbasetoolbar" value="off">
									 				<xsl:if test="knowbasetoolbar='off'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
									 </input>
									 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[614]"/><br/>
							</div>
						<script>if (document.frmFullxml.knowbase.value=='off') document.all.knowbasedefault.style.display= 'none'; else document.all.knowbasedefault.style.display= 'block';</script>
					</td>
				</tr>
				<!-- Classified -->
				<tr>
					<td class="xp_sel">
  						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select='$string[$classbasestring + 0]'/>:
					</td>
					<td>
							<select name="classified" onchange="if (this.value=='off') document.all.classifieddefault.style.display= 'none'; else document.all.classifieddefault.style.display= 'block';"><option value="off"><xsl:if test="classified='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="classified='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>
							<div id="classifieddefault" style="display: none;">							
									 <input type="radio" name="classifiedtoolbar" value="on">
									 				<xsl:if test="classifiedtoolbar='on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
									 </input>
									 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[613]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									 <input type="radio" name="classifiedtoolbar" value="off">
									 				<xsl:if test="classifiedtoolbar='off'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
									 </input>
									 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[614]"/><br/>
							</div>
						<script>if (document.frmFullxml.classified.value=='off') document.all.classifieddefault.style.display= 'none'; else document.all.classifieddefault.style.display= 'block';</script>
					</td>
				</tr>
				<!-- Chat -->
				<tr>
					<td class="xp_sel">
  						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[$chbasestring + 0]"/>:
					</td>
					<td>
						<select name="chat" onchange="if (this.value=='off') document.all.chatusers.style.display= 'none'; else document.all.chatusers.style.display= 'block';">
							<option value="off"><xsl:if test="chat='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option>
							<option value="on"><xsl:if test="chat='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option>
						</select>
						<div id="chatusers" style="display: none;">							
							<input type="text" value="{chatcleanup}" name="chatcleanup" class="medium"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[$chbasestring + 33]"/><br/>
							<select name="maxchatusers">
								<option value="5"><xsl:if test="maxchatusers='5'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>5</option>
								<option value="10"><xsl:if test="maxchatusers='10'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>10</option>
								<option value="15"><xsl:if test="maxchatusers='15'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>15</option>
								<option value="20"><xsl:if test="maxchatusers='20'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>20</option>
								<option value="25"><xsl:if test="maxchatusers='25'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>25</option>
								<option value="30"><xsl:if test="maxchatusers='30'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>30</option>
								<option value="40"><xsl:if test="maxchatusers='40'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>40</option>
								<option value="50"><xsl:if test="maxchatusers='50'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>50</option>
							</select>
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[$chbasestring + 31]"/><br/>
							<input type="radio" name="chattoolbar" value="on">
									 				<xsl:if test="chattoolbar='on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
							</input>
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[613]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
							<input type="radio" name="chattoolbar" value="off">
									 				<xsl:if test="chattoolbar='off'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
							</input>
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[614]"/><br/>
						</div>
						<script>if (document.frmFullxml.chat.value=='off') document.all.chatusers.style.display= 'none'; else document.all.chatusers.style.display= 'block';</script>
					</td>
				</tr>
				<!-- Calendar -->
				<tr>
					<td class="xp_sel">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[734]"/>:
					</td>
					<td>
						<select name="eventcalendar" onchange="if (this.value=='off') document.all.calendardefault.style.display= 'none'; else document.all.calendardefault.style.display= 'block';">
							<option value="off"><xsl:if test="eventcalendar='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Off</option>
							<option value="on"><xsl:if test="eventcalendar='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> Anonymous</option>
							<option value="member"><xsl:if test="eventcalendar='member'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> Member</option>
						</select>
						<div id="calendardefault" style="display: none;">							
								 <select name="calendarstate">
								 				 <xsl:choose>
												 						 <xsl:when test="calendarstate='on'"><option value="off">off</option><option value="on" selected="selected">on</option></xsl:when>
																		 <xsl:otherwise><option value="off" selected="selected">off</option><option value="on">on</option></xsl:otherwise>
												 </xsl:choose>
								 </select>
								 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[741]"/><br/>
								 <input type="radio" name="eventcalendartoolbar" value="on">
									 				<xsl:if test="eventcalendartoolbar='on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
								 </input>
								 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[613]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
								 <input type="radio" name="eventcalendartoolbar" value="off">
									 				<xsl:if test="eventcalendartoolbar='off'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
								 </input>
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[614]"/><br/>
						</div>
						<script>if (document.frmFullxml.eventcalendar.value=='off') document.all.calendardefault.style.display= 'none'; else document.all.calendardefault.style.display= 'block';</script>
					</td>
				</tr>
				<!-- Member manager -->
				<tr>
					<td class="xp_sel">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[$mmbasestring + 0]"/>:
					</td>
					<td>
						<select name="membermanager"  onchange="if (this.value=='off') document.all.membermanagerdefault.style.display= 'none'; else document.all.membermanagerdefault.style.display= 'block';"><option value="off"><xsl:if test="membermanager='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="anonymous"><xsl:if test="membermanager='anonymous'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Anonymous</option><option value="member"><xsl:if test="membermanager='member'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>Member</option></select>
							<div id="membermanagerdefault" style="display: none;">							
									 <input type="radio" name="membermanagertoolbar" value="on">
									 				<xsl:if test="membermanagertoolbar='on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
									 </input>
									 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[613]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									 <input type="radio" name="membermanagertoolbar" value="off">
									 				<xsl:if test="membermanagertoolbar='off'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
									 </input>
									 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[614]"/><br/>
							</div>
						<script>if (document.frmFullxml.membermanager.value=='off') document.all.membermanagerdefault.style.display= 'none'; else document.all.membermanagerdefault.style.display= 'block';</script>
					</td>
				</tr>
				<!-- Internal Messages -->
				<tr>
					<td class="xp_sel">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[$intmessages_basestring + 0]"/>:
					</td>
					<td>
						<select name="useinternalmessages" onchange="if (this.value=='off') document.all.internalmessages.style.display= 'none'; else document.all.internalmessages.style.display= 'block';"><option value="off"><xsl:if test="useinternalmessages='off'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>off</option><option value="on"><xsl:if test="useinternalmessages='on'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if> on</option></select>
						<div id="internalmessages" style="display: none;">
							<select name="maxmessages">
								<option value="5"><xsl:if test="maxmessages='5'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>5</option>
								<option value="10"><xsl:if test="maxmessages='10'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>10</option>
								<option value="15"><xsl:if test="maxmessages='15'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>15</option>
								<option value="20"><xsl:if test="maxmessages='20'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>20</option>
								<option value="25"><xsl:if test="maxmessages='25'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>25</option>
								<option value="30"><xsl:if test="maxmessages='30'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>30</option>
								<option value="40"><xsl:if test="maxmessages='40'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>40</option>
								<option value="50"><xsl:if test="maxmessages='50'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>50</option>
								<option value="75"><xsl:if test="maxmessages='75'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>75</option>
								<option value="100"><xsl:if test="maxmessages='100'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>100</option>
								<option value="200"><xsl:if test="maxmessages='200'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>200</option>
								<option value="300"><xsl:if test="maxmessages='300'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>300</option>
								<option value="400"><xsl:if test="maxmessages='400'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>400</option>
								<option value="500"><xsl:if test="maxmessages='500'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>500</option>
							</select>
							 <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[$intmessages_basestring + 1]"/><br/>
						</div>
						<script>if (document.frmFullxml.useinternalmessages.value=='off') document.all.internalmessages.style.display= 'none'; else document.all.internalmessages.style.display= 'block';</script>

					</td>
				</tr>		
				<tr><td colspan="2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
			</table>					
			</xsl:for-each>
			<br/>
			<tr>
				<td align="right">
					<input type="submit" value="{$string[18]}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1';" />
				</td>
			</tr>
			</form>
		</td></tr>	
		</table>
	</xsl:template>	

</xsl:stylesheet>