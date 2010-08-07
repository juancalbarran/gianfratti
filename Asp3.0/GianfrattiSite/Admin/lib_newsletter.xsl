<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb">
	<xsl:output method="html"/> 
	<xsl:include href="functions.xsl"/>

	<xsl:template name="newsletter_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Newsletter Manager</xsl:with-param>
			<xsl:with-param name="version">0.5</xsl:with-param>
			<xsl:with-param name="moddate">14.11.2003</xsl:with-param>
			<xsl:with-param name="author">JeS (Jens Schreiber)</xsl:with-param>
			<xsl:with-param name="url">http://www.fxmods.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="newsletter_manager">
		<script>
			var fx_imgwin;
			 var fx_opener;			
			 			
			function OpenAttachment(oOpener) {
				fx_opener = oOpener;
				fx_imgwin = window.open('filepicker.asp','selImg','width=450, height=330, scrollbars=yes'); 
				fx_imgwin.focus();
			}
			 
			function onImage(u, base_url, iborder, ialign, ialt, num) {
				fx_opener.value = u;
				fx_imgwin.close();
			}
		</script>
	
	
		<xsl:call-template name = "newsletter_navigator" />		

		<xsl:choose>
			<xsl:when test="$id='new'">
				<xsl:call-template name = "newsletter_add" />
			</xsl:when>
			<xsl:when test="$id and $type='send'">
				<xsl:for-each select = "document($newsletterfile)/newsletters/letter[id=$id]">
					<xsl:call-template name = "newsletter_send">
						<xsl:with-param name="Subject" select="subject"/>
						<xsl:with-param name="Message" select="message"/>
						<xsl:with-param name="HTMLMail" select="HTMLMail"/>
						<xsl:with-param name="Attachment" select="attachment"/>
					</xsl:call-template>
				</xsl:for-each>
				<xsl:call-template name = "newsletter_list" />
			</xsl:when>
			<xsl:when test="$id">
				<xsl:for-each select = "document($newsletterfile)/newsletters/letter[id=$id]">
			    	<xsl:call-template name = "newsletter_update" />
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name = "newsletter_list" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--         navigator at the top         -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="newsletter_navigator">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr>
				<td align="left" valign="center" width="50">
						<img src="admin/media/mailinglist.gif" border="0"/>						
				</td>
				<td align="left" valign="center">
					<font size="6"><b><xsl:value-of select="$string[$nmbasestring + 4]" /></b></font>
				</td>
			</tr>
		</table>
	</xsl:template>
	
	<xsl:template name="newsletter_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">
			<tr>
				<td class="header" width="16">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td class="header" width="50"><xsl:value-of select="$string[$nmbasestring + 5]" /></td>
				<td class="header"><xsl:value-of select="$string[$nmbasestring + 6]" /></td>
				<td class="header"><xsl:value-of select="$string[$nmbasestring + 7]" /></td>
			</tr>
			<xsl:for-each select="document($newsletterfile)/newsletters/letter">
				<tr bgcolor="white" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td><img src="admin/media/{sent}.gif" width="16" height="15" border="0"/></td>
					<td class="data2"><xsl:value-of select="id"/></td>
					<td class="data2"><a href="default.asp?ACT=1&amp;SECT={$section}&amp;id={id}"><xsl:value-of select="subject"/></a></td>
					<form action="default.asp?ACT=1&amp;SECT={$section}&amp;id={id}&amp;type=send" method="post" name="frmFullxml">
					<td class="data2">
						<xsl:choose>
							<xsl:when test="sent='off'">						
									<input type="hidden" name="file" value="newsletter"/>
									<input type="hidden" name="operation" value="update"/>
									<input type="hidden" name="node" value="newsletters/letter[id={id}]"/>
									<input type="hidden" name="sent" value="on"/>
									<input type="hidden" name="date" value="{$actualdate}"/>
								
									<input type="submit" value="{$string[$nmbasestring + 8]}"/>						
							</xsl:when>
							<xsl:otherwise>
                                                                <xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template>
								
									<input type="hidden" name="file" value="newsletter"/>
									<input type="hidden" name="operation" value="update"/>
									<input type="hidden" name="node" value="newsletters/letter[id={id}]"/>
									<input type="hidden" name="sent" value="on"/>
									<input type="hidden" name="date" value="{$actualdate}"/>
									<xsl:value-of disable-output-escaping="yes" select="$nbsp" />
									<input type="submit" value="{$string[$nmbasestring + 9]}"/>								
							</xsl:otherwise>
						</xsl:choose>
					</td>
					</form>
				</tr>
			</xsl:for-each>
		</table>
		<input type="submit" value="{$string[420]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;id=new';"/>
	</xsl:template>

	<xsl:template name="newsletter_add">
		<table bgcolor="white">
			<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="newsletter"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="bloc" value="newsletters"/>
						<input type="hidden" name="node" value="letter"/>
						<input type="hidden" name="sent" value="off"/>
						
						<table class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$nmbasestring + 0]"/>:
								</td>
								<td>
									<input type="text" name="subject" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$nmbasestring + 1]"/>:
								</td>
								<td>
									<textarea rows="20" cols="40" name="message" class="full"/>
									<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('message');</script></xsl:if>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$nmbasestring + 3]"/>:									
								</td>
								<td>
									<input type="text" name="attachment" class="full"/>
									<input type="button" value="{$string[125]}" onclick="OpenAttachment(document.frmFullxml.attachment);"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$nmbasestring + 2]"/>:
								</td>
								<td>
									<select name="HTMLMail">
										<option value="off"><xsl:value-of select="$string[61]"/></option>
										<option value="on" selected="selected"><xsl:value-of select="$string[60]"/></option>
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
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>

	
	<xsl:template name="newsletter_update">
		<table bgcolor="white">
			<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="newsletter"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="newsletters/letter[id={$id}]"/>
						<input type="hidden" name="sent" value="{sent}"/>
						
						<table class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$nmbasestring + 0]"/>:
								</td>
								<td>
									<input type="text" name="subject" value="{subject}" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$nmbasestring + 1]"/>:
								</td>
								<td>
									<textarea rows="20" cols="40" name="message" class="full">
										<xsl:value-of select="message"/>
									</textarea>
									<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('message');</script></xsl:if>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$nmbasestring + 3]"/>:									
								</td>
								<td>
									<input type="text" name="attachment" value="{attachment}" class="full"/>
									<input type="button" value="{$string[125]}" onclick="OpenAttachment(document.frmFullxml.attachment);"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$nmbasestring + 2]"/>:
								</td>
								<td>
									<select name="HTMLMail">
										<option value="off">
											<xsl:if test="HTMLMail='off'">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="$string[61]"/>
										</option>
										<option value="on">
											<xsl:if test="HTMLMail='on'">
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
					</td>
				</tr>
			</form>
			<xsl:if test="$usertype='administrator'">
				<tr>
					<td>
						<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" onsubmit="return confirm('{$string[83]}');">
							<table bgcolor="white" width="100%" class="block">
								<tr>
									<td bgcolor="white" align="right">
								    		<input type="hidden" name="file" value="newsletter"/>
										<input type="hidden" name="operation" value="delete"/>
										<input type="hidden" name="node" value="newsletters/letter[id={$id}]"/>
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
	
	<xsl:template name="newsletter-contreplace">
		<xsl:param name="placeholder"/>
		
		<xsl:choose>
			<xsl:when test="substring($placeholder, 1, 10) = '[%carticle'">
				<xsl:variable name="date">
					<xsl:value-of select="substring($placeholder, 11, 8)"/>0000
				</xsl:variable>
				
				&lt;ul&gt;
					<xsl:for-each select="document($categoryfile)//categories/category[visible='on' and member!='admin']">
						<xsl:variable name="categoryid" select="id"/>
						<xsl:for-each select="document($datafile)//pages/page[category=$categoryid and visible='on']">
							<xsl:variable name="pageid" select="id"/>					
							<xsl:for-each select = "document($datafile)//siteinfo/contents/content[idpage=$pageid and visible = 'on' and date &gt;= number($date)]">
								<xsl:choose>
									<xsl:when test="(document($categoryfile)//categories/category[id=$categoryid]/member='on' and $usertype='anonymous')">
										&lt;li&gt;
											<xsl:value-of select="title"/>
										&lt;/li&gt;
									</xsl:when>
									<xsl:otherwise>
										&lt;li&gt;
											&lt;a href="default.asp?id=<xsl:value-of select="$pageid"/>&amp;mnu=<xsl:value-of select="$pageid"/>&amp;ACT=5&amp;content=<xsl:value-of select="id"/>"&gt;
												<xsl:value-of select="title"/>
											&lt;/a&gt;
							   			&lt;/li&gt;
									</xsl:otherwise>
								</xsl:choose>
					   		</xsl:for-each>
					   	</xsl:for-each>
					</xsl:for-each>
				&lt;/ul&gt;
			</xsl:when>
			<xsl:when test="substring($placeholder, 1, 9) = '[%cthread'">
				<xsl:variable name="date">
					<xsl:value-of select="substring($placeholder, 10, 8)"/>0000
				</xsl:variable>
				
				&lt;ul&gt;
					<xsl:for-each select = "document($discussionfile)//discussions/discussion[visible='on']//message[visible!='off' and date &gt;= number($date)]">
						<xsl:variable name="newsgroupid" select="ancestor::discussion/id"/>
						&lt;li&gt;
							&lt;a href="default.asp?ACT=17&amp;grp=<xsl:value-of select="$newsgroupid"/>&amp;msg=<xsl:value-of select="id"/>" &gt;
								<xsl:value-of select="title"/>
							&lt;/a&gt;
						&lt;/li&gt;
					</xsl:for-each>
				&lt;/ul&gt;
			</xsl:when>			
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="newsletter-stdreplace">
		<xsl:param name="placeholder"/>

		<xsl:choose>
			<xsl:when test="$placeholder='[%sfirstname%]'">
				<xsl:value-of select="userfname"/>
			</xsl:when>
			<xsl:when test="$placeholder='[%slastname%]'">
				<xsl:value-of select="userlname"/>
			</xsl:when>
			<xsl:when test="$placeholder='[%spseudo%]'">
				<xsl:value-of select="pseudo"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="newsletter-replace">
		<xsl:param name="text"/>

		<xsl:choose>
			<xsl:when test="contains($text, '[%s')">
				<xsl:variable name = "text1" select = "substring-before($text, '[%s')" />
				<xsl:variable name = "text2" select = "substring-after($text, '%]')" />
				<xsl:variable name = "placeholder" select = "substring($text, string-length($text1) + 1, string-length($text) - (string-length($text2) + string-length($text1)))" />
				<xsl:value-of select="$text1"/>

				<xsl:call-template name="newsletter-stdreplace">
					<xsl:with-param name="placeholder"><xsl:value-of select="$placeholder"/></xsl:with-param>
				</xsl:call-template>
				
				<xsl:if test="string-length($text2) &gt; 0">
					<xsl:call-template name="newsletter-replace">
						<xsl:with-param name="text"><xsl:value-of select="$text2"/></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:when>
			<xsl:when test="contains($text, '[%c')">
				<xsl:variable name = "text1" select = "substring-before($text, '[%c')" />
				<xsl:variable name = "text2" select = "substring-after($text, '%]')" />
				<xsl:variable name = "placeholder" select = "substring($text, string-length($text1) + 1, string-length($text) - (string-length($text2) + string-length($text1)))" />
				<xsl:value-of select="$text1"/>

				<xsl:call-template name="newsletter-contreplace">
					<xsl:with-param name="placeholder"><xsl:value-of select="$placeholder"/></xsl:with-param>
				</xsl:call-template>

				<xsl:if test="string-length($text2) &gt; 0">
					<xsl:call-template name="newsletter-replace">
						<xsl:with-param name="text"><xsl:value-of select="$text2"/></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="SendMail">
		<xsl:param name="ToEmail"/>
		<xsl:param name="FromEmail"/>
		<xsl:param name="Subject"/>
		<xsl:param name="Message"/>
		<xsl:param name="Attachment"/>
		<xsl:param name="HTMLMail"/>

		<xsl:value-of select="vb:Mailer(string(document($datafile)/siteinfo/data/emailCOM), string($ToEmail), string($FromEmail), string($Subject), string($Message), string(document($datafile)/siteinfo/data/smtpserver), string($Attachment), string($HTMLMail))"/>
	</xsl:template>

	<xsl:template name="newsletter_send">		
		<xsl:param name="Subject"/>
		<xsl:param name="Message"/>
		<xsl:param name="Attachment"/>
		<xsl:param name="HTMLMail"/>

		<!-- Send the email -->
		
		<xsl:for-each select = "document($memberfile)//members/member[visible='on' and newsletter='on']">
			
			<xsl:variable name="ReplacedMsg">
				<xsl:call-template name="newsletter-replace">
					<xsl:with-param name="text"><xsl:value-of select="$Message"/></xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			
			<xsl:call-template name="SendMail">
				<xsl:with-param name="ToEmail" select="string(email)"/>
				<xsl:with-param name="FromEmail" select="string(document($datafile)/siteinfo/data/email)"/>
				<xsl:with-param name="Subject" select="$Subject"/>
				<xsl:with-param name="Message" select="$ReplacedMsg"/>
	
				<xsl:with-param name="HTMLMail" select="$HTMLMail"/>
				<xsl:with-param name="Attachment">
					<xsl:if test="string-length($Attachment)>0">
						<xsl:value-of select="$mappath"/>\<xsl:value-of select="$Attachment" />
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>

		</xsl:for-each>
	</xsl:template>
	
</xsl:stylesheet>
