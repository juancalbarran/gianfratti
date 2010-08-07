<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb">

<xsl:output method="html" indent="yes" encoding="iso-8859-1"/>



<!-- this variable contains the id of the thread, it can calculated from a child id -->
<xsl:variable name="thread">	
	<xsl:choose>
		<xsl:when test="document($discussionfile)//discussions/discussion[id=$newsgroupID]//message[id=$messageID and count(ancestor::message)=1]">
			<xsl:value-of select="document($discussionfile)//discussions/discussion[id=$newsgroupID]//message[message/id=$messageID]/id"/>
		</xsl:when>
		<xsl:when test="document($discussionfile)//discussions/discussion[id=$newsgroupID]//message[id=$messageID and parent::message]">
			<xsl:value-of select="document($discussionfile)//discussions/discussion[id=$newsgroupID]//message[child::*//message/id=$messageID]/id"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$messageID"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<xsl:variable name="vpValue">	
	<xsl:choose>
		<xsl:when test="string-length($vp) &gt; 0">
			<xsl:value-of select="$vp"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="/siteinfo/data/newsgroupdisplay"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>



<!-- ================= -->
<!-- LIST of Newsgroup available -->
	<xsl:template name="liste_discussions">
		<xsl:variable name="email_object" select="/siteinfo/data/emailCOM"/>
	
		<!-- Display the search box -->
		<xsl:call-template name="forumsearchform"/><br/>		
		
		
		<!-- Forums table -->			
		<table width="100%" cellpadding="2">
			<tr align="center" height="20" bgcolor="{$forum.header.bgcolor}">
				<td><font color="{$forum.header.color}"><b><xsl:value-of select="$string[570]"/></b></font></td>
				<td width="80"><font color="{$forum.header.color}"><b><xsl:value-of select="$string[571]"/></b></font></td>
				<td width="80"><font color="{$forum.header.color}"><b><xsl:value-of select="$string[572]"/></b></font></td>
				<td width="150"><font color="{$forum.header.color}"><b><xsl:value-of select="$string[573]"/></b></font></td>
				<td width="80"><font color="{$forum.header.color}"><b><xsl:value-of select="$string[591]"/></b></font></td>
			</tr>
			<xsl:for-each select="$ForumFilePointer//discussions/discussion[visible='on']">
			<xsl:sort select="order" order="ascending" data-type="number"/>
			<xsl:variable name="nid" select="id"/>
				<tr valign="top">
					<td bgcolor="{$forum.normal.row.bgcolor}">
						<a href="default.asp?ACT=15&amp;grp={id}" class="newsgroup"><xsl:value-of select="title"/></a>
						
						<!-- admin link ? -->
						<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M12&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
						
						<!-- new messages alert ? -->
						<xsl:choose>
							<xsl:when test="count(.//message[substring($actualdate,1,8)=substring(date,1,8)])&gt;0">
								<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><i><font color="#FF0000" size="1">(<xsl:value-of select="$string[421]" />)</font></i>
							</xsl:when>
							<xsl:when test="count(.//message[number(substring($actualdate,1,8))=number(number(substring(date,1,8))+1)])&gt;0">
								<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><i><font color="#990099" size="1">(<xsl:value-of select="$string[421]" />)</font></i>
							</xsl:when>
						</xsl:choose>
						<br/>
						<xsl:value-of select="description" disable-output-escaping="yes"/>
					</td>
					<td bgcolor="{$forum.highlight.row.bgcolor}" align="center"><xsl:value-of select="count($ForumFilePointer//discussions/discussion[id=$nid]/message[visible!='off'])"/></td>
					<td bgcolor="{$forum.highlight.row.bgcolor}" align="center"><xsl:value-of select="count($ForumFilePointer//discussions/discussion[id=$nid]//message[visible!='off' and ancestor::message/visible!='off'])"/></td>
					<td bgcolor="{$forum.highlight.row.bgcolor}" align="center">
<!-- CHANGED NEXT LINE - MIG100 -->
						<xsl:for-each select="../discussion[id=$nid]//message[visible!='off']">
							<xsl:sort select="date" order="descending"/>
							<xsl:if test="position()=1">
								<xsl:variable name="pseudo" select="l"/>
								<!--<xsl:value-of select="title"/>-->
								<xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template><br/>
								<xsl:value-of select="$string[316]"/> 
								<!-- User plus mod -->
								<xsl:call-template name="call_user"><xsl:with-param name="RefPseudo" select="$pseudo"/></xsl:call-template>
							</xsl:if>							
						</xsl:for-each>
					</td>
					<td bgcolor="{$forum.highlight.row.bgcolor}" align="center"><xsl:value-of select="$ForumFilePointer//discussions/discussion[id=$nid]/moderator"/></td>
				</tr>				
			</xsl:for-each>
		</table>		
	</xsl:template>
			
			
	<!-- Rail template for the path -->
	<xsl:template name="NavigationRail">
		<p>
			<a href="default.asp?ACT=14"><font size="2"><xsl:value-of select="$DataFilePointer//siteinfo/data/title"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[580]"/></font></a>
			<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><font size="2">></font><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
			<a href="default.asp?ACT=15&amp;grp={$newsgroupID}"><font size="2"><xsl:value-of select="$ForumFilePointer/discussions/discussion[id=$newsgroupID]/title"/></font></a>
					
			<!-- we add the message link if it's present-->
			<xsl:if test="$messageID">
				<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><font size="2">></font><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				<a href="default.asp?ACT=17&amp;grp={$newsgroupID}&amp;msg={$messageID}"><font size="2"><xsl:value-of select="$ForumFilePointer/discussions/discussion[id=$newsgroupID]//message[id=$messageID]/title"/></font></a>
			</xsl:if>
		</p>
	</xsl:template>
	
	
			
	<!-- Newsgroup detail :: display a list thread, with paging of 20 -->
	<xsl:template name="Thread.List">
		<xsl:variable name="vbcrlf">
		<xsl:text>
		</xsl:text>
		</xsl:variable>
				
		<!-- if the webmaster want it, we send an mail alert -->
		
		<xsl:if test="$operation='add' and $file='discussion'">			
			<xsl:if test="/siteinfo/data/wsignup='on'">
				<xsl:call-template name="Mailer">
					<xsl:with-param name="ToEmail" select="string(/siteinfo/data/email)"/>
					<xsl:with-param name="FromEmail" select="string(/siteinfo/data/email)"/>
					<xsl:with-param name="Subject" select="concat($string[383], ': ', $comp_title)"/>
					<xsl:with-param name="Message" select="concat($comp_title, $vbcrlf, $body, $vbcrlf, /siteinfo/data/url, '?ACT=17&amp;grp=', $newsgroupID, '&amp;msg=', $messageID)"/>					
				</xsl:call-template>
			</xsl:if>
			
			<xsl:variable name="pseudo" select="$ForumFilePointer//discussions/discussion[id=$newsgroupID]//message[id=$messageID]/l"/>
			
			<!-- send an alert to the one that we are replying -->
			<xsl:call-template name="Mailer">
				<xsl:with-param name="ToEmail" select="string($MemberFilePointer//members/member[pseudo=$pseudo]/email)"/>
				<xsl:with-param name="FromEmail" select="string($MemberFilePointer//members/member[pseudo=$pseudo]/email)"/>
				<xsl:with-param name="Subject" select="concat($DataFilePointer//siteinfo/data/title, ' ', $string[580])"/>
				<xsl:with-param name="Message" select="concat($string[590], $vbcrlf, /siteinfo/data/url, '?ACT=17&amp;grp=', $newsgroupID, '&amp;msg=', $messageID)"/>								
			</xsl:call-template>
			
		</xsl:if>				
			
		<!-- the navigation bar -->
		<xsl:call-template name="NavigationRail"/>
		
		<!--<xsl:value-of select="concat($string[590], $vbcrlf, /siteinfo/data/url, '?ACT=15&amp;grp=', $newsgroupID)"/>-->
		
		<!-- Newsgroup detail -->
		<xsl:for-each select="$ForumFilePointer//discussions/discussion[id=$newsgroupID]">
						
			<!-- Link to new message, anyway, member must be identified -->
			<xsl:choose>
				<xsl:when test="$usertype!='anonymous'"> <!-- (member!='admin' and $usertype!='anonymous') or (member='admin' and  $usertype!='administrator') -->
					<xsl:choose>
						<xsl:when test="$vp='1'">
							<a href="default.asp?ACT=16&amp;grp={$newsgroupID}"><xsl:value-of select="$string[269]"/></a> | <a href="default.asp?ACT=15&amp;grp={$newsgroupID}"><xsl:value-of select="$string[278]"/></a>
						</xsl:when>
						<xsl:otherwise>
							<a href="default.asp?ACT=16&amp;grp={$newsgroupID}"><font style="color: {$forum.new.thread.color}; text-transform: uppercase; font-size: 14px; font-weight: bold; background: {$forum.new.thread.bgcolor}; border: 1px {forum.new.thread.bordercolor} solid; padding-left: 2px; padding-right: 2px; text-decoration: none;"><xsl:value-of select="$string[589]"/></font></a>
							<!-- | <a href="default.asp?ACT=15&amp;grp={$newsgroupID}&amp;vp=1"><xsl:value-of select="$string[277]"/></a>-->
						</xsl:otherwise>
					</xsl:choose>				
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<center><xsl:value-of select="$string[271]" disable-output-escaping="yes"/></center>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
			
			<!-- We display the list of message, recursively -->
			<xsl:choose>
				<xsl:when test="$vp='1'"><xsl:apply-templates select="message[visible!='off']" mode="vp"/></xsl:when>
				
				<!-- normal view -->
				<xsl:otherwise>
					<table width="100%">
						<tr height="20">
							<td bgcolor="{$forum.header.bgcolor}"><font color="{$forum.header.color}"><b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[571]"/></b></font></td>
							<td width="80" bgcolor="{$forum.header.bgcolor}" align="center"><font color="{$forum.header.color}"><b><xsl:value-of select="$string[575]"/></b></font></td>
							<td width="80" bgcolor="{$forum.header.bgcolor}" align="center"><font color="{$forum.header.color}"><b><xsl:value-of select="$string[576]"/></b></font></td>
							<td width="150" bgcolor="{$forum.header.bgcolor}" align="center"><font color="{$forum.header.color}"><b><xsl:value-of select="$string[573]"/></b></font></td>
						</tr>
<!-- CHANGED NEXT LINE - MIG100 -->
						<xsl:apply-templates select="message[visible!='off']" mode="THREAD"><xsl:sort select="descendant::date[last()]" order="descending"/></xsl:apply-templates>
					</table>					
				</xsl:otherwise>
			</xsl:choose>
			
			<!-- Navigation for the Paging -->
			<center>
			<xsl:call-template name="paging_Rail_macro">
				<xsl:with-param name="totalpage" select="count(message[visible!='off']) div $forum_pagesize"/>
				<xsl:with-param name="currentpage" select="number($page)+1"/>
				<xsl:with-param name="url">default.asp?id=0&amp;ACT=15&amp;grp=<xsl:value-of select="$newsgroupID"/></xsl:with-param>
			</xsl:call-template>
			</center><br/>
						
		</xsl:for-each>		
		
	</xsl:template>
			
			
	<!-- Display the first message of a thread, use by the thread list -->
	<xsl:template match="message" mode="THREAD">
		<xsl:variable name="nid" select="ancestor::discussion/id"/>
		<xsl:variable name="email_object" select="$DataFilePointer//siteinfo/data/emailCOM"/>
		
		<xsl:if test="position() &gt; number($page*$forum_pagesize) and position() &lt;=  number(($page+1)*$forum_pagesize) ">
			<xsl:variable name="pseudo"><xsl:value-of select="pseudo"/><xsl:value-of select="l"/></xsl:variable>
			<tr>
				<!-- title -->
				<td bgcolor="{$forum.normal.row.bgcolor}">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><font color="{$forum.header.color}"><a href="default.asp?ACT=17&amp;grp={$newsgroupID}&amp;msg={id}&amp;vp={$vpValue}"><b><xsl:value-of select="title"/></b></a></font>
					<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M16&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
					<!-- if there is new messages in this thread, we display a 'new message' alert -->
					<xsl:choose>
						<xsl:when test="substring($actualdate,1,8)=substring(date,1,8)">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><i><font color="#FF0000" size="1">(<xsl:value-of select="$string[589]" />)</font></i>
						</xsl:when>
						<xsl:when test="substring($actualdate,1,8)=number(number(substring(date,1,8))+1)">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><i><font color="#990099" size="1">(<xsl:value-of select="$string[589]" />)</font></i>
						</xsl:when>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="count(.//message[substring($actualdate,1,8)=substring(date,1,8)])&gt;0">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><i><font color="#FF0000" size="1">(<xsl:value-of select="$string[421]" />)</font></i>
						</xsl:when>
						<xsl:when test="count(.//message[number(substring($actualdate,1,8))=number(number(substring(date,1,8))+1)])&gt;0">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><i><font color="#990099" size="1">(<xsl:value-of select="$string[421]" />)</font></i>
						</xsl:when>
					</xsl:choose>
				</td>
				
				<!-- By -->
				<td width="80" bgcolor="{$forum.highlight.row.bgcolor}" align="center">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					<!-- lien vers messagerie si possible -->
					<!-- User plus mod -->
					<xsl:call-template name="call_user"><xsl:with-param name="RefPseudo" select="$pseudo"/></xsl:call-template>
				</td>
				
				<!-- Count de reply -->
				<td width="80" bgcolor="{$forum.highlight.row.bgcolor}" align="center">
					<xsl:value-of select="count(.//message[visible!='off' and ancestor::message/visible!='off'])"/>
				</td>
				
				<!-- Last post -->
				<td width="150" bgcolor="{$forum.highlight.row.bgcolor}" align="center">					
					<xsl:choose>
						<xsl:when test="count(message[visible!='off'])>0">
							<xsl:for-each select=".//message[visible!='off']">
								<xsl:sort select="date" order="descending"/>
								<xsl:if test="position()=1">													<xsl:variable name="lpseudo" select="l"/>

									<!--<xsl:value-of select="title"/>-->
									<xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template><br/>
									<xsl:value-of select="$string[316]"/> 
									
									<!-- lien vers messagerie si possible -->
									<!-- User plus mod -->
									<xsl:call-template name="call_user"><xsl:with-param name="RefPseudo" select="l"/></xsl:call-template>
								</xsl:if>							
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
                                                        <xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template><br/>
							<xsl:value-of select="$string[316]"/>
							<!-- lien vers messagerie si possible -->
								<!-- User plus mod -->
									<xsl:call-template name="call_user"><xsl:with-param name="RefPseudo" select="l"/></xsl:call-template>
<!--									<xsl:choose>
										<xsl:when test="string-length($usertype)!='anonymous' and $username=$pseudo"><a href="default.asp?id=1&amp;mnu=1amp;&amp;ACT=22"><xsl:value-of select="l"/></a></xsl:when>
										<xsl:when test="$email_object != 'off'"><a href="default.asp?ACT=25&amp;member={$MemberFilePointer//members/member[pseudo=$pseudo]/id}&amp;id=0"><xsl:value-of select="l"/></a></xsl:when>
										<xsl:otherwise><xsl:value-of select="l"/></xsl:otherwise>
									</xsl:choose>-->			
									<!--<a href="mailto:{document($memberfile)//members/member[pseudo=$pseudo]/email}"><xsl:value-of select="l"/></a>-->						</xsl:otherwise>
					</xsl:choose>					
				</td>
			</tr>			 		
		  </xsl:if>
	</xsl:template>


	<!-- affiche la liste des messages du Thread en vue plane -->
	<!-- Display a complete thread -->
	<xsl:template match="message" mode="ThreadDetail">
		<table width="100%" border="0">
			<tr height="20">
				<td width="140" bgcolor="{$forum.header.bgcolor}"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><font color="{$forum.header.color}"><b><xsl:value-of select="$string[574]"/></b></font></td>
				<td bgcolor="{$forum.header.bgcolor}"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><font color="{$forum.header.color}"><b><xsl:value-of select="$string[577]"/>: <xsl:value-of select="title"/></b></font></td>
			</tr>
			<xsl:apply-templates select="." mode="ThreadDetailMessage"/>			
		</table>
	</xsl:template>
	
	<!-- Display the single message -->
	<xsl:template match="message" mode="ThreadDetailMessage">
		<xsl:variable name="email_object" select="$DataFilePointer//siteinfo/data/emailCOM"/>
		<xsl:variable name="pseudo" select="l"/>
		
		<tr valign="top">
			<!-- this cell display info on the user whom has posted the message -->
			<td bgcolor="{$forum.normal.row.bgcolor}">
				<a name="{id}"/>
				<!-- Display a star if is a moderator -->
				<xsl:if test="ancestor::discussion/moderator=l"><img src="media/moderator.gif" hspace="4"  align="absmiddle" width="14" height="14" alt="Moderator"/></xsl:if>
				<!-- lien vers messagerie si possible -->
					<!-- User plus mod -->
						<xsl:call-template name="call_user"><xsl:with-param name="RefPseudo" select="l"/></xsl:call-template>
<!--									<xsl:choose>
										<xsl:when test="string-length($usertype)!='anonymous' and $username=$pseudo"><a href="default.asp?id=1&amp;mnu=1amp;&amp;ACT=22"><xsl:value-of select="l"/></a></xsl:when>
										<xsl:when test="$email_object != 'off'"><a href="default.asp?ACT=25&amp;member={$MemberFilePointer//members/member[pseudo=$pseudo]/id}&amp;id=0"><xsl:value-of select="l"/></a></xsl:when>
										<xsl:otherwise><xsl:value-of select="l"/></xsl:otherwise>
									</xsl:choose>-->			
				<br/>
				<!-- post --><xsl:value-of select="$string[572]"/>: <xsl:value-of select="count(document($discussionfile)//message[l=$pseudo])"/> <br/>
				<!-- since --><xsl:value-of select="$string[599]"/>: <xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="$MemberFilePointer//members/member[pseudo=$pseudo]/date"/></xsl:call-template><br/>
				<!-- from --><xsl:value-of select="$string[600]"/>: <xsl:value-of select="$MemberFilePointer//members/member[pseudo=$pseudo]/ville"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>/<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$MemberFilePointer//members/member[pseudo=$pseudo]/usercountry"/>
			</td>
			<!-- this cell display the message -->
			<td bgcolor="{$forum.normal.row.bgcolor}">
				<table width="100%" cellpadding="2" cellspacing="2" bgcolor="{$forum.highlight.row.bgcolor}" border="0"><!--#D6DBEF">-->
					<tr>
						<td>
							<b><xsl:value-of select="title"/></b><xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M16&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if><br/>
							<xsl:value-of select="$string[578]"/>:<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template>
						</td>
					</tr>
				</table>
				<!-- @@todo :: replace des br -->
				<xsl:value-of select="body" disable-output-escaping="yes"/>
				<p>
					<a href="default.asp?ACT=16&amp;grp={$newsgroupID}&amp;msg={id}"><font style="background: {$forum.header.color};text-transform: uppercase; font-weight: bold; font-size: 14px;"><xsl:value-of select="$string[579]"/></font></a>
				</p>
				
				<xsl:if test="l=$username">
					<!--<form action="default.asp?ACT=15&amp;grp={$newsgroupID}" name="frmNewsgroupModerator" method="post">
						<input type="hidden" name="file" value="discussion"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="discussions/discussion[id={$newsgroupID}]"/>
						<input type="hidden" name="visible" value="off"/>
						<input type="submit" value="Kill my message"/>
					</form>-->
				</xsl:if>

				<xsl:if test="$vp=1">
					<xsl:apply-templates select="message[visible='on']" mode="ThreadDetailMessage"/>
				</xsl:if>				
			</td>
		</tr>		
	</xsl:template>
			
	
	
			
	
	<!-- Display of a message -->
	<xsl:template name="detail_message">
		
		<!-- the navigation bar -->
		<xsl:call-template name="NavigationRail"/>
	
		<xsl:choose>
			<xsl:when test="$usertype!='anonymous'">
				
				<!-- Display the links in order to toglle beetween linear and tree views -->
				<xsl:choose>
					<xsl:when test="$vp=1">
						<a href="default.asp?ACT=17&amp;grp={$newsgroupID}&amp;vp=0&amp;msg={$messageID}"><xsl:value-of select="$string[278]"/></a> | <xsl:value-of select="$string[277]"/>	
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$string[278]"/> | <a href="default.asp?ACT=17&amp;grp={$newsgroupID}&amp;vp=1&amp;msg={$thread}"><xsl:value-of select="$string[277]"/></a>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:apply-templates select="document($discussionfile)//discussions/discussion[id=$newsgroupID]//message[id=$messageID]" mode="ThreadDetail"/>
				<xsl:if test="$vp!=1">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr align="center" height="20" bgcolor="{$forum.header.bgcolor}">
							<td width="120"><font color="{$forum.header.color}"><b><xsl:value-of select="$string[578]"/></b></font></td>
							<td width="500"><font color="{$forum.header.color}"><b><xsl:value-of select="$string[191]"/></b></font></td>
							<td width="120"><font color="{$forum.header.color}"><b><xsl:value-of select="$string[574]"/></b></font></td>
						</tr>
						<xsl:apply-templates select="document($discussionfile)//discussions/discussion[id=$newsgroupID]//message[id=$thread]" mode="treeview"/>
					</table>
				</xsl:if>
			</xsl:when>						
			<xsl:otherwise>
				<xsl:call-template name="normaltext_design">
					<xsl:with-param name="text">
						<center><xsl:value-of select="$string[271]" disable-output-escaping="yes"/></center>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>		
		<!--<center><a href="default.asp?ACT=15&amp;grp={$newsgroupID}&amp;page={$page}"><xsl:value-of select="$string[279]"/></a></center>-->
	</xsl:template>
	
	
	<!-- Display a line of the tree view -->			
	<xsl:template match="message" mode="treeview">	
		<tr>			
			<td><xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template></td>
			<td>
			<xsl:for-each select="ancestor::message">
					<xsl:choose>
						<xsl:when test="following-sibling::node()">
							|
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				<xsl:choose>
					<xsl:when test="parent::node() and ../child::node()">
						<xsl:text>|</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					</xsl:otherwise>
				</xsl:choose>			
				<xsl:choose>
					<xsl:when test="id=$msg">__<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b style="color: red;"><xsl:value-of select="title"/></b></xsl:when>				
					<xsl:otherwise>__<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=17&amp;grp={$newsgroupID}&amp;msg={id}&amp;vp=0"><small><xsl:value-of select="title"/></small></a></xsl:otherwise>
				</xsl:choose>
			</td>
			<td>
				<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><font style="font: 9px"><xsl:value-of select="l"/></font>
			</td>
		</tr>
		<!-- on cherche les sous fils -->
		<xsl:apply-templates select="message" mode="treeview"/>				
	</xsl:template>	
	
				
				
	<!-- Formulaire pour poster un nouveau message dans la discussion -->
	<xsl:template name="new_message">
		<xsl:variable name="email_object" select="$DataFilePointer//siteinfo/data/emailCOM"/>
				
		<!-- the navigation bar -->
		<xsl:call-template name="NavigationRail"/>
	
		<table cellpadding="0" cellspacing="0" width="100%">
		<form action="default.asp?ACT=15&amp;grp={$newsgroupID}" method="post">
			<input type="hidden" name="operation" value="add"/>
			<input type="hidden" name="file" value="discussion"/>
			<input type="hidden" name="node" value="message"/>
			<!--<input type="hidden" name="visible" value="on"/>-->
			<input type="hidden" name="visible" value="{/siteinfo/data/newsgroupstate}"/>
			<input type="hidden" name="l" value="{$username}"/>
		
			<xsl:choose>
				<xsl:when test="string-length($messageID)!=0 and /siteinfo/data/newsgroupdisplay=0">					
					<input type="hidden" name="bloc" value="discussions/discussion[id={$newsgroupID}]//message[id={$messageID}]"/>
				</xsl:when>
				<xsl:when test="string-length($messageID)!=0 and /siteinfo/data/newsgroupdisplay=1">					
					<input type="hidden" name="bloc" value="discussions/discussion[id={$newsgroupID}]//message[id={$thread}]"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" name="bloc" value="discussions/discussion[id={$newsgroupID}]"/>
				</xsl:otherwise>
			</xsl:choose>

			<tr height="20">
				<td bgcolor="{$forum.header.bgcolor}"><font color="{$forum.header.color}"><b><xsl:value-of select="$string[583]"/></b></font></td>
			</tr>
			<tr>
				<td>
					<table width="100%" bgcolor="{$forum.normal.row.bgcolor}">
						
						<!-- the message that we reply -->
						<xsl:for-each select="document($discussionfile)//discussions/discussion[id=$newsgroupID]//message[id=$messageID]">
							<tr>	<td colspan="2"><font size="2"><xsl:value-of select="$string[584]"/>:</font></td></tr>
							<tr>
								<td width="80"><b><xsl:value-of select="$string[585]"/>:</b></td>
								<td>
									<!-- Display the name linked to the messager is possible -->
									<xsl:variable name="pseudo" select="l"/>
									<!-- User plus mod -->
									<xsl:call-template name="call_user"><xsl:with-param name="RefPseudo" select="$pseudo"/></xsl:call-template>
									
								<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[586]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template><br/></td>
							</tr>
							<tr>
								<td><b><xsl:value-of select="$string[587]"/>:</b></td><td><xsl:value-of select="title"/> <xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M16&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if></td>
							</tr>
							<tr valign="top">
								<td><b><xsl:value-of select="$string[588]"/>:</b></td>
								<td><xsl:value-of select="body" disable-output-escaping="yes"/></td>
							</tr>
						</xsl:for-each>
						
							<!-- separator -->
							<tr bgcolor="{$forum.highlight.row.bgcolor}"><td colspan="2"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr>
							
							<!-- the new message -->
							<tr>
								<td width="80"><b><xsl:value-of select="$string[574]"/>:</b></td><td><xsl:value-of select="$username"/></td>
							</tr>
							<tr>
								<td><b><xsl:value-of select="$string[587]"/>:</b></td>
								<td>
									<input type="text" name="comp_title" class="input" size="40" style="width: 100%">
										<xsl:attribute name="value"><xsl:if test="string-length($messageID)!=0">RE: <xsl:value-of select="$ForumFilePointer//discussions/discussion[id=$newsgroupID]//message[id=$messageID]/title"/></xsl:if></xsl:attribute>
									</input>
								</td>
							</tr>
							<tr valign="top">
								<td><b><xsl:value-of select="$string[588]"/>:</b></td>
								<td>
									<xsl:choose>
										<xsl:when test="$usertype='administrator'">
											<textarea name="body" cols="60" style="width: 100%" rows="20" class="textarea" wrap="hard"/>
											<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('body');</script></xsl:if>
										</xsl:when>
										<xsl:otherwise>
											<textarea name="body" cols="60" style="width: 100%" rows="20" class="textarea" wrap="hard"/>
											<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('body', config);</script></xsl:if>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
							<tr><td colspan="2" align="right"><input type="submit" value="{$string[197]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="button" value="{$string[19]}" onclick="history.back();"/></td></tr>
						</table>					
					</td>
				</tr>			
			</form>
			</table>
	</xsl:template>
			
	
	<xsl:template name="forumsearchform">
		<table cellpadding="0" cellspacing="0" width="100%"><tr>
		<form action="default.asp?ACT=4" method="post">
			<input type="hidden" name="kind" value="forum"/>
			<TD align="right">
				<xsl:call-template name="normaltext_design">
					<xsl:with-param name="text">
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[582]"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="text" name="keyword" size="8" value="{$keyword}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="submit" value="ok"/>
					</xsl:with-param>
				</xsl:call-template>
			</TD>
		</form>
		</tr></table>
	</xsl:template>
	
	<!-- ======================================================================================================================================= -->
	<!-- ======================================================================================================================================= -->
	<!-- ======================================================================================================================================= -->
	<!-- ======================================================================================================================================= -->
	<!-- ======================================================================================================================================= -->
	
	
	
	<!-- Answer in the tree -->
	<xsl:template match="message" mode="answer">
		
		<ul>
			 	<li>
			 		<a href="default.asp?ACT=17&amp;grp={$newsgroupID}&amp;msg={id}&amp;page={$page}" ><xsl:value-of select="title"/></a>
				  	<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M16&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
				  	<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>[<xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template> - <xsl:value-of select="pseudo"/><xsl:value-of select="l"/>]
						</xsl:with-param>
					</xsl:call-template>
					<xsl:choose>
						<xsl:when test="substring($actualdate,1,8)=substring(date,1,8)">
							<i><font color="#FF0000">(<xsl:value-of select="$string[420]" />)</font></i>
						</xsl:when>
						<xsl:when test="number(substring($actualdate,1,8))=number(number(substring(date,1,8))+1)">
							<i><font color="#990099">(<xsl:value-of select="$string[420]" />)</font></i>
						</xsl:when>
					</xsl:choose>
					
				</li>
			  	<xsl:apply-templates select="message[visible!='off']" mode="answer"/>
			  </ul>
	</xsl:template>
	
	
	<!-- le meme en vue plane -->
	<xsl:template match="message" mode="vp">
		<xsl:variable name="pseudo"><xsl:value-of select="pseudo"/><xsl:value-of select="l"/></xsl:variable>
		
		<xsl:call-template name="title_design">
			<xsl:with-param name="title">
				<xsl:value-of select="title"/>
				<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M16&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
			</xsl:with-param>
		</xsl:call-template>					
		
		<xsl:call-template name="normaltext_design">
			<xsl:with-param name="text">
				[<xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template> - &lt;a href="mailto:<xsl:value-of select="$MemberFilePointer//members/member[pseudo=$pseudo]/email"/>"&gt;<xsl:value-of select="pseudo"/><xsl:value-of select="l"/>&lt;/a&gt;]
				&lt;br/&gt;&lt;br/&gt;
				<xsl:value-of select="body" disable-output-escaping="yes"/>
				&lt;br/&gt;
				<!-- le lien repondre -->
				<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>>><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				&lt;a href="default.asp?ACT=16&amp;grp=<xsl:value-of select="$newsgroupID"/>&amp;msg=<xsl:value-of select="id"/>"&gt;<xsl:value-of select="$string[268]"/> <xsl:value-of select="pseudo" disable-output-escaping="yes"/>&lt;/a&gt;
				&lt;br/&gt;
			</xsl:with-param>
		</xsl:call-template>		
				
		<xsl:apply-templates select="message" mode="vp"/>		
	</xsl:template>
	
	<!-- affichage d'un message entier, mais slt pour les abonnés -->
	<xsl:template name="detail_message_OLD_used_for_vp">
		<xsl:choose>
			<xsl:when test="$usertype!='anonymous'">
								
				<xsl:for-each select="$ForumFilePointer//discussions/discussion[id=$newsgroupID]//message[id=$messageID]">
					<xsl:variable name="pseudo"><xsl:value-of select="pseudo"/><xsl:value-of select="l"/></xsl:variable>
					
					<!-- le lien vers le message pere -->
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:if test="string-length(parent::*/id)&gt;0 and name(parent::*)='message'">
								<xsl:value-of select="$string[274]"/>
								&lt;a href="default.asp?ACT=17&amp;grp=<xsl:value-of select="$newsgroupID"/>&amp;msg=<xsl:value-of select="parent::*/id"/>"&gt;<xsl:value-of select="parent::*/title"/>&lt;/a&gt;
								&lt;br&gt;&lt;br&gt;
							</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					
					<!-- message title -->
					<xsl:call-template name="title_design">
						<xsl:with-param name="title">
							<xsl:value-of select="title" disable-output-escaping="yes"/> 
							<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M16&amp;id={id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if> 
							[<small><xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>-<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="mailto:{document($memberfile)//members/member[pseudo=$pseudo]/email}"><xsl:value-of select="pseudo"/><xsl:value-of select="l"/></a></small>]
						</xsl:with-param>
					</xsl:call-template>
					
					<!-- corps du message -->
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="body" disable-output-escaping="no"/>
							<!-- le lien repondre -->
							&lt;br&gt;<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>>><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
							&lt;a href="default.asp?ACT=16&amp;grp=<xsl:value-of select="$newsgroupID"/>&amp;msg=<xsl:value-of select="id"/>"&gt;<xsl:value-of select="$string[268]"/> <xsl:value-of select="pseudo"/><xsl:value-of select="l"/>&lt;/a&gt;
							&lt;br&gt;&lt;br&gt;
							
							<!-- le lienvers le message fils -->
							<xsl:if test="string-length(./message/id)&gt;0">
								<xsl:value-of select="$string[275]"/>
								<xsl:for-each select="./message">
									&lt;li&gt;
									&lt;a href="default.asp?ACT=17&amp;grp=<xsl:value-of select="$newsgroupID"/>&amp;msg=<xsl:value-of select="id"/>"><xsl:value-of select="title"/>&lt;/a&gt;
									&lt;/li&gt;
								</xsl:for-each>
							</xsl:if>
						</xsl:with-param>
					</xsl:call-template>					
					
				</xsl:for-each>			
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="normaltext_design">
					<xsl:with-param name="text">
						<center><xsl:value-of select="$string[271]" disable-output-escaping="yes"/></center>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		
		<center><a href="default.asp?ACT=15&amp;grp={$newsgroupID}&amp;page={$page}"><xsl:value-of select="$string[279]"/><!-- <xsl:value-of select="document($discussionfile)//discussions/discussion[id=$newsgroupID]/title"/> --></a></center>
		
	</xsl:template>
			
</xsl:stylesheet>
