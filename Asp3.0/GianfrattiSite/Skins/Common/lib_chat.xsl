<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb">
   <xsl:output method="html" indent="yes" encoding="iso-8859-1" />

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!-- created by fxmods team               -->
	<!-- last update 2003/10/22 by JeS        -->
	<!-- version 0.6                          -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--      entry point for this module     -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->	
	
	<xsl:template name="chat_manager">
		<script>
			function CloseChat() 
			{
				window.close();
			}			 
		</script>
		<xsl:choose>			
			<xsl:when test="not($channel)">
				<xsl:call-template name="channellist"/>				
			</xsl:when>
			<xsl:when test="$chatview='close'">
				<table width="100%">
					<tr height="200" valign="center">
						<td align="center">
							<font size="3"><xsl:value-of select="$string[$chbasestring + 28]"/></font>
						</td>
					</tr>
				</table>
				<script>
					CloseChat();
				</script>
			</xsl:when>
			<xsl:when test="$channel='new'">
				<xsl:call-template name="addchannel"/>
			</xsl:when>
			<xsl:when test="$action='join'">
				<script>
					open("default.asp?ACT=93&amp;channel=<xsl:value-of select="$channel"/>", "ChatWnd")
				</script>
				<xsl:call-template name="channellist"/>				
			</xsl:when>
			<xsl:when test="$chatview = 'hdr'">
				<xsl:call-template name="titlebloc_macro"/>
			</xsl:when>			
			<xsl:when test="$chatview = 'msg'">
				<xsl:call-template name="chatmessagelist"/>
			</xsl:when>
			<xsl:when test="$chatview = 'usr'">
				<xsl:call-template name="chatuserlist"/>
			</xsl:when>
			<xsl:when test="$chatview = 'ctrl'">
				<xsl:call-template name="chatcontrol"/>
			</xsl:when>
			
			<xsl:when test="$chatview = 'add'">
				<xsl:call-template name="addchatmessage"/>
			</xsl:when>			
			<xsl:when test="$chatview = 'addprivate'">
				<xsl:call-template name="addprivatemessage"/>
			</xsl:when>
			<xsl:otherwise>

				<frameset rows="70,*,80" frameborder="0">				
				<frame name="head" src="default.asp?ACT=93&amp;channel={$channel}&amp;chatview=hdr" noresize="yes" scrolling="no"/>
					<frameset cols="*,100,120">
						<frame name="Messages" src="default.asp?ACT=93&amp;channel={$channel}&amp;chatview=msg" scrolling="yes" noresize="yes"/>
						<frame name="Control"  src="default.asp?ACT=93&amp;channel={$channel}&amp;chatview=ctrl" scrolling="no" noresize="yes"/>
						<frame name="Users" src="default.asp?ACT=93&amp;channel={$channel}&amp;chatview=usr" noresize="yes"/>
					</frameset>
				<xsl:choose>
					<xsl:when test="$action = 'addprivate'">
						<frame name="Message" src="default.asp?ACT=93&amp;channel={$channel}&amp;user={$user}&amp;action={$action}&amp;chatview=addprivate" scrolling="no"/>
					</xsl:when>
					<xsl:otherwise>
						<frame name="Message" src="default.asp?ACT=93&amp;channel={$channel}&amp;chatview=add" scrolling="no"/>
					</xsl:otherwise>
				</xsl:choose>
				<noframes>
					<body>
						<xsl:value-of select="$string[$chbasestring + 3]"/>
					</body>
				</noframes>
				</frameset>

			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--                channel               -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--            add new channel           -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="addchannel">
		<xsl:call-template name="title_design">
			<xsl:with-param name="title"><xsl:value-of select="$string[$chbasestring + 2]"/></xsl:with-param>
		</xsl:call-template>
	
		<form name="frmChannel" action="default.asp?ACT={$ACT}" method="post">
			<input type="hidden" name="file" value="chat"/>
			<input type="hidden" name="operation" value="add"/>
			<input type="hidden" name="bloc" value="chat"/>
			<input type="hidden" name="node" value="channel"/>
			<input type="hidden" name="members" value="all members of this channel"/>			
			<input type="hidden" name="messages" value="all messages of this channel"/>
			<input type="hidden" name="visible" value="on"/>

			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td><xsl:value-of select="$string[$chbasestring + 6]"/></td>
					<td>
						<input type="text" size="50" name="comp_name" />
					</td>
				</tr>
				<tr>
					<td valign="top"><xsl:value-of select="$string[$chbasestring + 7]"/></td>
					<td>
						<textarea name="comp_description" cols="50" rows="5"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT={$ACT}';"/>
					</td>
				</tr>
			</table>
		</form>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--         list of all channels         -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="channellist">
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr bgcolor="{$toolbar_background}" height="20">
				<td width="20%">
					<font color="{$toolbar_color}"><strong><xsl:value-of select="$string[$chbasestring + 8]"/></strong></font>
				</td>
				<td width="40%">
					<font color="{$toolbar_color}"><strong><xsl:value-of select="$string[$chbasestring + 9]"/></strong></font>
				</td>
				<td width="20%">
					<font color="{$toolbar_color}"><strong><xsl:value-of select="$string[$chbasestring + 10]"/></strong></font>
				</td>
				<td width="10%">
					<font color="{$toolbar_color}"><strong><xsl:value-of select="$string[$chbasestring + 11]"/></strong></font>
				</td>
				<td width="10%">
				</td>
			</tr>
			<xsl:for-each select = "document($chatfile)/chat/channel[visible='on']">
				<xsl:sort select="name"/>
				<xsl:variable name="usercount">
					<xsl:value-of select="count(members/member[visible='on' and lastactivity &gt; ($actualdate - $sessionexpire)])"/>
				</xsl:variable>
				<tr>
					<td>
						<xsl:value-of select="name" />
					</td>
					<td>
						<xsl:value-of select="description" />
					</td>
					<td>
						<xsl:value-of select="owner" />
					</td>
					<td>
						<xsl:value-of select="$usercount"/>
					</td>
					<form name="frmJoin{id}" action="default.asp?ACT={$ACT}&amp;action=join&amp;channel={id}" method="post">
						<td>							
							<input type="hidden" name="file" value="chat"/>
							<input type="hidden" name="operation" value="chat-join"/>
							<input type="hidden" name="bloc" value="chat/channel[id={id}]/members"/>
							<input type="hidden" name="node" value="member"/>
							<input type="hidden" name="pseudo" value="{$username}"/>
							<input type="hidden" name="mode" value="ok"/>
							<input type="hidden" name="visible" value="on"/>
							<input type="hidden" name="lastactivity" value="{$actdecdate}"/>
							<input type="hidden" name="lastsessionupd" value="{$actualdate}"/>
							<xsl:choose>
								<xsl:when test="document($chatfile)/chat/channel[id = id]/owner = $username or $usertype = 'administrator'">
									<input type="hidden" name="state" value="operator"/>
								</xsl:when>
								<xsl:otherwise>
									<input type="hidden" name="state" value="member"/>
								</xsl:otherwise>						
							</xsl:choose>
							<xsl:if test="$usercount &lt; $DataFilePointer/siteinfo/data/maxchatusers">
								<input type="submit" value="{$string[$chbasestring + 27]}"/>
							</xsl:if>
						</td>
					</form>
					<!-- set actual time to field lastactivity, to avoid log off during next clean up process-->
					<script>
						var lngOffset;
						
						function padout(number) 
						{ 
							return (number &lt; 10) ? '0' + number : number; 
						}

						function CurrentTime<xsl:value-of select="id"/>() 
						{
       						var datCurrent = new Date();
       						var lngCurrent = parseInt("" + datCurrent.getYear() + padout(datCurrent.getMonth() + 1) + padout(datCurrent.getDate()) + padout(datCurrent.getHours()) + padout(datCurrent.getMinutes()/0.6));
       						
       						lngCurrent = lngCurrent + lngOffset;
       						document.frmJoin<xsl:value-of select="id"/>.lastactivity.value = lngCurrent;
       						setTimeout("CurrentTime<xsl:value-of select="id"/>()", 30000);
       					}
       					
       					function StartTimer()
						{	
							var datCurrent = new Date();
							var strLocalTime = "" + datCurrent.getYear() + padout(datCurrent.getMonth() + 1) + padout(datCurrent.getDate()) + padout(datCurrent.getHours()) + padout(datCurrent.getMinutes()/0.6);
							var lngLocalTime = parseInt(strLocalTime);
							var lngServerTime = parseInt(<xsl:value-of select="$actdecdate"/>);
							lngOffset = lngServerTime - lngLocalTime;
							CurrentTime<xsl:value-of select="id"/>();
						}
       					StartTimer();
       				</script>
				</tr>
			</xsl:for-each>			
			<tr>
				<td width="50%" align="left" colspan="3">
					<xsl:if test="$usertype='administrator' or $usertype='editor' ">
						<a href="default.asp?ACT={$ACT}&amp;channel=new">
							<xsl:value-of select="$string[$chbasestring + 2]"/>
						</a>
					</xsl:if>
				</td>
				<form name="frmDrop" action="default.asp?ACT={$ACT}" method="post">
					<input type="hidden" name="file" value="chat"/>
					<input type="hidden" name="operation" value="dropnodes"/>
					<input type="hidden" name="node" value="chat/channel/members/member[pseudo = '{$username}']"/>
					<td width="50%" align="right" colspan="2">
						<a href="" onClick="frmDrop.submit();"><xsl:value-of select="$string[$chbasestring + 32]"/></a>
					</td>
				</form>
			</tr>
		</table>
	</xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--                 chat                 -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--       control window for chat        -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="chatcontrol">
		<xsl:variable name="cleanuptimer" select="$DataFilePointer/siteinfo/data/chatcleanup"/>
		<form name="frmCtrl">
			<input type="hidden" name="lastactivity" value="{document($chatfile)/chat/channel[id=$channel]/members/member[pseudo=$username]/lastactivity}"/>
			<input type="hidden" name="lastmsgaction" value="{document($chatfile)/chat/channel[id=$channel]/messageaction}"/>
			<input type="hidden" name="lastusraction" value="{document($chatfile)/chat/channel[id=$channel]/useraction}"/>
			<input type="hidden" name="lastcleanaction" value="{document($chatfile)/chat/channel[id=$channel]/lastcleanup}"/>
			<input type="hidden" name="lastsessionupd" value="{document($chatfile)/chat/channel[id=$channel]/members/member[pseudo=$username]/lastsessionupd}"/>
		</form>
		<form name="frmCleaner" action="default.asp?ACT={$ACT}&amp;channel={$channel}&amp;chatview=ctrl" method="post">
			<input type="hidden" name="file" value="chat"/>
			<input type="hidden" name="operation" value="chat-cleanup"/>
			<input type="hidden" name="node" value="chat/channel[id={$channel}]"/>
		</form>
		<form name="frmSession" action="default.asp?ACT={$ACT}&amp;channel={$channel}&amp;chatview=ctrl" method="post">
			<input type="hidden" name="file" value="chat"/>
			<input type="hidden" name="operation" value="chat-session"/>
		</form>
		<script>
			if (document.frmCtrl.lastactivity.value.length &lt; 1)
			{
				if (parent.Message.document.frmExit != null)
				{
					parent.Message.frmExit.submit();
				}
			}
			else
			{				
				if (parent.Messages.document.frmCtrl != null)
				{
					if (document.frmCtrl.lastmsgaction.value != parent.Messages.document.frmCtrl.lastaction.value)
					{
						parent.Messages.location.href="default.asp?ACT=<xsl:value-of select="$ACT"/>&amp;channel=<xsl:value-of select="$channel"/>&amp;chatview=msg"
					}				
				}
				if (parent.Users.document.frmCtrl != null)
				{
					if (document.frmCtrl.lastusraction.value != parent.Users.document.frmCtrl.lastaction.value)
					{
						parent.Users.location.href="default.asp?ACT=<xsl:value-of select="$ACT"/>&amp;channel=<xsl:value-of select="$channel"/>&amp;chatview=usr"
					}
				}
				
				if (document.frmCtrl.lastcleanaction.value &lt; <xsl:value-of select="number($actualdate - $cleanuptimer) * 100"/>)
				{
					document.frmCleaner.submit();
				}
				if (document.frmCtrl.lastsessionupd.value &lt;= <xsl:value-of select="number($actualdate - round($sessionexpire * 0.5))"/>)
				{
					document.frmSession.submit();
				}
			}
		</script>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--       displays single message        -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="show-message">
		<xsl:param name="bgcolor"/>
		
		<tr bgcolor="{$bgcolor}">		
			<xsl:choose>
				<xsl:when test="type='chat-join'">
					<td width="5%" valign="top">
						<xsl:call-template name="display_time"><xsl:with-param name="p_Time" select="substring(date, 9, 4)"/></xsl:call-template>
					</td>
					<td width="95%" valign="top" colspan="2">
						<xsl:value-of select="owner"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[$chbasestring + 29]"/>
					</td>
				</xsl:when>
				<xsl:when test="type='chat-leave'">
					<td width="5%" valign="top">
						<xsl:call-template name="display_time"><xsl:with-param name="p_Time" select="substring(date, 9, 4)"/></xsl:call-template>
					</td>
					<td width="95%" valign="top" colspan="2">
						<xsl:value-of select="owner"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[$chbasestring + 30]"/>
					</td>
				</xsl:when>
				<xsl:when test="type='private'">
					<xsl:if test="to=$username or owner=$username">
						<td width="5%" valign="top">
							<xsl:call-template name="display_time"><xsl:with-param name="p_Time" select="substring(date, 9, 4)"/></xsl:call-template>
						</td>
						<td width="15%" valign="top">
							*<xsl:value-of select="owner" />*
						</td>
						<td width="85%" valign="top">
							<xsl:value-of select="msg" />
						</td>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<td width="5%" valign="top">
						<xsl:call-template name="display_time"><xsl:with-param name="p_Time" select="substring(date, 9, 4)"/></xsl:call-template>
					</td>
					<td width="15%" valign="top">
						<xsl:value-of select="owner" />
					</td>
					<td width="85%" valign="top">
						<xsl:value-of select="msg" />
					</td>
				</xsl:otherwise>
			</xsl:choose>
		</tr>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--            list of messages          -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="chatmessagelist">
		<form name="frmCtrl">
			<input type="hidden" name="lastaction" value="{document($chatfile)/chat/channel[id=$channel]/messageaction}"/>
		</form>
		<xsl:choose>
			<xsl:when test="document($chatfile)/chat/channel[id=$channel]/members/member[pseudo = $username]/mode = 'drop'">
				<font size="3"><xsl:value-of select="$string[$chbasestring + 23]"/></font>
			</xsl:when>
			<xsl:otherwise>
				<table width="100%">
					<tr>
						<td colspan="3">
							<xsl:for-each select = "document($chatfile)/chat/channel[id=$channel]">
								<xsl:call-template name="title_design">
									<xsl:with-param name="title"><xsl:value-of select="name" /></xsl:with-param>
								</xsl:call-template>
							</xsl:for-each>
						</td>
					</tr>
					<xsl:for-each select = "document($chatfile)/chat/channel[id=$channel]/messages/message">
						<xsl:sort select="date" data-type="number" order="descending"/>
						<xsl:sort select="id" data-type="number" order="descending"/>
						
						<xsl:if test="position() &lt; 50">
							<xsl:choose>
								<xsl:when test="position() mod 2">
									<xsl:call-template name="show-message">
										<xsl:with-param name="bgcolor">#EFEFEF</xsl:with-param>
									</xsl:call-template>									
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="show-message"/>
								</xsl:otherwise>
							</xsl:choose>						
						</xsl:if>
					</xsl:for-each>			
				</table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--       list of all active users       -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="chatuserlist">
		<form name="frmCtrl">
			<input type="hidden" name="lastaction" value="{document($chatfile)/chat/channel[id=$channel]/useraction}"/>
		</form>
		<table width="100%">
			<tr>
				<td>
					<xsl:call-template name="hightlightedtext_design">
						<xsl:with-param name="text"><xsl:value-of select="$string[$chbasestring + 13]"/></xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<xsl:for-each select = "document($chatfile)/chat/channel[id=$channel]/members/member[$username != pseudo and lastactivity &gt; ($actualdate - $sessionexpire)]">
				<xsl:sort select="pseudo"/>
				<tr>
						<td>
							<a href="default.asp?ACT=93&amp;channel={$channel}&amp;user={pseudo}&amp;action=addprivate&amp;chatview=addprivate" target="Message">
								<xsl:value-of select="pseudo" />
							</a>
						</td>
					</tr>
			</xsl:for-each>
		</table>		
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--    create form with leave button     -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="chat_exitform">
		<form name="frmExit" action="default.asp?ACT=93&amp;channel={$channel}&amp;chatview=close" target="_top" method="post">
			<input type="hidden" name="file" value="chat"/>					
			<input type="hidden" name="operation" value="chat-leave"/>
			<input type="hidden" name="node" value="chat/channel[id={$channel}]/members/member[pseudo='{$username}']"/>
			<td width="20">
				<input type="submit" value="{$string[$chbasestring + 14]}"/>
			</td>
		</form>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--   create form for message writing    -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="chat_messageform">
		<xsl:param name="type">public</xsl:param>
		<xsl:param name="recipient"/>
		
		<form name="frmMessage" action="default.asp?ACT=93&amp;channel={$channel}&amp;chatview={$chatview}&amp;user={$recipient}" method="post" onkeypress="if(window.event.keyCode==13)frmMessage.submit();">
			<input type="hidden" name="file" value="chat"/>
			<input type="hidden" name="operation" value="chat-addmsg"/>
			<input type="hidden" name="bloc" value="chat/channel[id={$channel}]/messages"/>
			<input type="hidden" name="node" value="message"/>
			<input type="hidden" name="to" value="{$recipient}"/>
			<input type="hidden" name="owner" value="{$username}"/>
			<input type="hidden" name="visible" value="on"/>
			<input type="hidden" name="type" value="{$type}"/>

			<td valign="top"><xsl:value-of select="$string[$chbasestring + 5]"/></td>
			<td width="100%" valign="center">
				<textarea name="msg" rows="3" cols="50" taborder="1"/>
				<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				<input type="submit" value="{$string[18]}"/>
			</td>
		</form>
		<script>
			frmMessage.msg.focus();
		</script>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--       add new public message         -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="addchatmessage">		
		<table>
			<tr>
				<xsl:call-template name="chat_messageform">
					<xsl:with-param name="type">public</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="chat_exitform"/>
			</tr>
		</table>		
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--      private msg and administer      -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="addprivatemessage">	
		<table>
			<tr>
				<td width="50%">
					<table>
						<tr>
							<td colspan="2">
								<xsl:value-of select="$string[$chbasestring + 20]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><strong><xsl:value-of select="$user"/></strong>
							</td>
						</tr>
						<tr>
							<xsl:call-template name="chat_messageform">
								<xsl:with-param name="type">private</xsl:with-param>
								<xsl:with-param name="recipient"><xsl:value-of select="$user"/></xsl:with-param>
							</xsl:call-template>
						</tr>
					</table>
				</td>		
				<td width="10%">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					<a href="default.asp?ACT=93&amp;channel={$channel}&amp;chatview=add" target="Message">
						<strong><xsl:value-of select="$string[$chbasestring + 21]"/></strong>
					</a>
				</td>
				<xsl:if test="document($chatfile)/chat/channel[id=$channel]/members/member[pseudo=$username]/state='operator'">
					<td width="40%">
						<table width="100%" style="border: 1px #FF0000 solid">
							<tr>
								<td>
									<xsl:value-of select="$string[$chbasestring + 24]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><strong><xsl:value-of select="$user" /></strong>
								</td>
							</tr>
							<tr>
								<form name="frmDrop" action="default.asp?ACT=93&amp;channel={$channel}&amp;chatview=add" target="Message" method="post">
									<input type="hidden" name="file" value="chat"/>
									<input type="hidden" name="operation" value="dropnodes"/>
									<input type="hidden" name="node" value="chat/channel[id={$channel}]/members/member[pseudo='{$user}']"/>
									<td>
										<input type="submit" value="{$string[$chbasestring + 22]}"/>						
									</td>
								</form>
								<form name="frmOp" action="default.asp?ACT=93&amp;channel={$channel}&amp;chatview={$chatview}&amp;action={$action}&amp;user={$user}" target="Message" method="post">
									<input type="hidden" name="file" value="chat"/>
									<input type="hidden" name="operation" value="update"/>
									<input type="hidden" name="node" value="chat/channel[id={$channel}]/members/member[pseudo='{$user}']"/>
									<xsl:choose>
										<xsl:when test="document($chatfile)/chat/channel[id=$channel]/members/member[pseudo=$user]/state='operator'">
											<input type="hidden" name="state" value="member"/>
											<td>
												<input type="submit" value="{$string[$chbasestring + 26]}"/>
											</td>
										</xsl:when>
										<xsl:otherwise>
											<input type="hidden" name="state" value="operator"/>
											<td>									
												<input type="submit" value="{$string[$chbasestring + 25]}"/>						
											</td>
										</xsl:otherwise>
									</xsl:choose>									
								</form>
							</tr>							
						</table>
					</td>
				</xsl:if>
				<td align="right">
					<xsl:call-template name="chat_exitform"/>
				</td>
			</tr>
		</table>
	</xsl:template>

</xsl:stylesheet>
