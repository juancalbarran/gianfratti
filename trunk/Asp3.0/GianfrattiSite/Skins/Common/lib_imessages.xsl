<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb">
	

<!-- Webpages Template : add/update/modify -->
<!-- last changes: 2003/08/21, by Miguel Figueira (Mig100) -->
<!-- version 0.9 -->

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--     Generic members templates        -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

	<!-- Main procedure -->
	<xsl:template name="internalmessages_manager">
	<xsl:choose>
		<xsl:when test="/siteinfo/data/useinternalmessages= 'off'">
			<!-- if internal messages are off -->
			<br/>
			<xsl:call-template name="hightlightedtext_design">
				<xsl:with-param name="text" select="$string[$intmessages_basestring + 12]"/>
			</xsl:call-template>				
		</xsl:when>
		<xsl:when test="$usertype='anonymous'">
			<!-- user is not logged -->
			<br/>
			<xsl:call-template name="hightlightedtext_design">
				<xsl:with-param name="text" select="$string[561]"/>
			</xsl:call-template>				
		</xsl:when>
		<xsl:when test="$item='ok'">
			<!-- message sent -->			
			<br/>
			<xsl:call-template name="hightlightedtext_design">
				<xsl:with-param name="text" select="$string[$intmessages_basestring + 2]"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$item='new' or $item='answer'">
			<!-- new messages -->
			<xsl:call-template name = "ckeckmailbox" />
	  	</xsl:when>
		<xsl:when test="$item='view'and $msg">
			<!-- displaying individual messages -->
			<xsl:call-template name = "messagesview_design" />
	  	</xsl:when>
		<xsl:otherwise>
			<!-- displaying all messages for that user -->
			<xsl:call-template name = "messagesgroup_design" />
		</xsl:otherwise>
	</xsl:choose>	
	</xsl:template>

	<!-- here we check if users can receive messages. Number of possible messages is defined at Admin Console  -->
	<!-- Administrators will be able to send and recieve no matter what is defined at Admin Console  -->
	<xsl:template name="ckeckmailbox">
	<xsl:param name="maxmsg" select="/siteinfo/data/maxmessages" />
	<xsl:param name="toID" select="document($memberfile)//members/member[id=$member]/pseudo" />
	<xsl:param name="toAdmin" select="document($memberfile)//members/member[id=$member]/type" />
	<xsl:choose>
		<xsl:when test="count(document($internalmessagefile)//imessage[to=$toID]) &gt;= $maxmsg and $usertype!='administrator' and $toAdmin!='administrator'">
			<br/>
			<xsl:call-template name="hightlightedtext_design">
				<xsl:with-param name="text" select="$string[$intmessages_basestring + 11]"/>
			</xsl:call-template>
	  	</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
				<xsl:when test="$item='answer'">
					<!-- if everything is ok we let user answer message -->
					<xsl:call-template name = "answermessageForm" />
				</xsl:when>
				<xsl:when test="$item='new'">
					<!-- if everything is ok we let user send him a new message -->			
					<xsl:call-template name = "sendmessageForm" />
				</xsl:when>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>	
	</xsl:template>

	<!-- Form to send an internal message beetween members -->
	<xsl:template name="sendmessageForm">
		<style type="text/css">

			<xsl:choose>								
				<xsl:when test="$oldeditor='on'">
					textarea{height: 150px; width: 450px; background-color: #D6EBFF; color: #000000; font-size: 12px; font-weight: normal; font-family: arial;  border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid; filter: alpha(opacity=100);BEHAVIOR: url(admin/js/textarea.htc)}
				</xsl:when>
				<xsl:otherwise>
					textarea{height: 150px; width: 450px; background-color: #D6EBFF; color: #000000; font-size: 12px; font-weight: normal; font-family: arial;  border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid; filter: alpha(opacity=100);}
				</xsl:otherwise>
			</xsl:choose>
		</style>
		
		<!-- Display the form -->
		<table>
			<form action="default.asp?ACT=83&amp;id=0&amp;item=ok" method="post" name="frmFXimessage">
					<input type="hidden" name="operation" value="add"/>
					<input type="hidden" name="file" value="internalmessage"/>
					<input type="hidden" name="bloc" value="internalmessages"/>
					<input type="hidden" name="node" value="imessage"/>
					<input type="hidden" name="state" value="new"/>
					<input type="hidden" name="to" value="{document($memberfile)//members/member[id=$member]/pseudo}"/>
					<input type="hidden" name="from" value="{$username}"/>
					<tr><td><b><xsl:value-of select="$string[557]"/></b></td><td><xsl:value-of select="$username"/></td></tr>
					<tr><td><b><xsl:value-of select="$string[558]"/></b></td><td><input type="text" name="comp_subject" value="{$subject}" size="50"/></td></tr>
					<tr><td colspan="2"><b><xsl:value-of select="$string[559]"/></b></td></tr>
					<tr><td colspan="2">
						<xsl:choose>
							<xsl:when test="$usertype='administrator'">
								<textarea class="textarea" rows="20" cols="70" name="comp_message" value="{$message}"/>
								<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('comp_message');</script></xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<textarea class="textarea" rows="20" cols="70" name="comp_message" value="{$message}"/>
								<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('comp_message', config);</script></xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</td></tr>
					<tr><td colspan="2" align="right"><input type="submit" value="{$string[560]}"/></td></tr>
			</form>
		</table>
	</xsl:template>

	<!-- AnsweringForm to an internal message beetween members -->
	<xsl:template name="answermessageForm">
	<xsl:param name="answeruser" select="document($internalmessagefile)//imessage[id=$msg]/from"/>
		<!-- Display the form -->
		<table>
			<form action="default.asp?ACT=83&amp;id=0&amp;item=ok" method="post" name="frmFXimessage">
					<input type="hidden" name="operation" value="add"/>
					<input type="hidden" name="file" value="internalmessage"/>
					<input type="hidden" name="bloc" value="internalmessages"/>
					<input type="hidden" name="node" value="imessage"/>
					<input type="hidden" name="state" value="new"/>
					<input type="hidden" name="to" value="{$answeruser}"/>
					<input type="hidden" name="from" value="{$username}"/>
					<input type="hidden" name="answering" value="{$msg}"/>

					<tr><td><b><xsl:value-of select="$string[557]"/></b></td><td><xsl:value-of select="$username"/></td></tr>
					<tr><td><b><xsl:value-of select="$string[558]"/></b></td><td><input type="text" name="comp_subject" value="RE: {document($internalmessagefile)//imessage[id=$msg]/subject}" size="50"/></td></tr>
					<tr><td colspan="2"><b><xsl:value-of select="$string[559]"/></b></td></tr>
					<tr><td colspan="2">
						<xsl:choose>
							<xsl:when test="$usertype='administrator'">
								<textarea class="textarea" rows="20" cols="70" name="comp_message" value="{$message}"/>
								<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('comp_message');</script></xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<textarea class="textarea" rows="20" cols="70" name="comp_message" value="{$message}"/>
								<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('comp_message', config);</script></xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</td></tr>
					<tr><td colspan="2" align="right"><input type="submit" value="{$string[560]}"/></td></tr>
			</form>
			<tr>
				<td valign="top">
					<b><xsl:value-of select="$answeruser"/></b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[$intmessages_basestring + 16]" />
				</td>
				<td valign="top">
					<xsl:value-of select="document($internalmessagefile)//imessage[id=$msg]/message" disable-output-escaping="yes"/></td>
			</tr>
		</table>
	</xsl:template>
	

	<!-- display all messages that users received -->
	<xsl:template name="messagesgroup_design">
	<xsl:param name="maxmsg" select="/siteinfo/data/maxmessages" />
	<xsl:param name="actualmsg" select="count(document($internalmessagefile)//imessage[to=$username])" />
	<xsl:variable name="available">
			<xsl:choose>
				<xsl:when test="number($maxmsg - $actualmsg) &lt; number(0)">
					<xsl:value-of select="number(0)" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="number($maxmsg - $actualmsg)" />
				</xsl:otherwise>
			</xsl:choose>
	</xsl:variable>

	        <xsl:value-of select="$string[$intmessages_basestring + 5]" />
		<xsl:if test="$usertype!='administrator'">
			<br />
		        <xsl:value-of select="$string[$intmessages_basestring + 14]" /><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$maxmsg"/></b>
			<br />
			<xsl:value-of select="$string[$intmessages_basestring + 15]" /><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$available"/></b>
 		</xsl:if>
		<p />
		<table width="100%" cellpadding="0" cellspacing="2">
			<tr align="center" height="15" bgcolor="{$toolbar_background}">
				<td width="32px" />
				<td width="150px"><a class="toolbar"><xsl:value-of select="$string[$intmessages_basestring + 6]" /></a></td>
				<td width="150px"><a class="toolbar"><xsl:value-of select="$string[$intmessages_basestring + 7]" /></a></td>
				<td><a class="toolbar"><xsl:value-of select="$string[$intmessages_basestring + 8]" /></a></td>
			</tr>			
			<xsl:for-each select="document($internalmessagefile)//imessage[to=$username]">
			<xsl:sort select="date" data-type="number" order="descending"/>
				<xsl:if test="position() &gt; number($page*$imessage_pagesize) and position() &lt;=  number(($page+1)*$imessage_pagesize) ">
					<tr>
						<td align="center" width="32px"><xsl:if test="state='new'"><img  style="border: 0px;" src="Admin/media/new.gif"/></xsl:if></td>
						<td align="center" width="150px"><xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime"><xsl:value-of select="date"/></xsl:with-param></xsl:call-template></td>
						<td width="150px"><xsl:value-of select="from"/></td>
						<td>
							<xsl:choose>
								<xsl:when test="state='new'">
									<a class="newsgroup" style="cursor: hand;" onclick="window.document.forms['upd{id}'].submit();"><xsl:value-of select="subject"/></a>
										<div id="{id}" style="display: none;">
											<form name="upd{id}" method="post" action="default.asp?ACT=83&amp;id=0&amp;item=view&amp;msg={id}">
												<input type="hidden" name="file" value="internalmessage"/>
												<input type="hidden" name="operation" value="update"/>
												<input type="hidden" name="node" value="internalmessages/imessage[id={id}]"/>
												<input type="hidden" name="state" value="old"/>
											</form>
										</div>		
								</xsl:when>
								<xsl:otherwise>
									<a class="newsgroup" href="default.asp?ACT=83&amp;id=0&amp;item=view&amp;msg={id}"><xsl:value-of select="subject"/></a>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
				</xsl:if>
			</xsl:for-each>		
			<xsl:if test="count(document($internalmessagefile)//imessage[to=$username]) &gt; $imessage_pagesize">
				<tr><td colspan="3" align="center">
					<!-- Navigation for the messages Paging -->
					<xsl:call-template name="paging_Rail_macro">
						<xsl:with-param name="totalpage" select="count(document($internalmessagefile)//imessage[to=$username]) div $imessage_pagesize"/>
						<xsl:with-param name="currentpage" select="number($page)+1"/>
						<xsl:with-param name="url">default.asp?ACT=83&amp;id=0</xsl:with-param>
					</xsl:call-template>
				</td></tr>
			</xsl:if>
		</table>
	</xsl:template>


	<!-- display for each message -->
	<xsl:template name="messagesview_design">
	
		<xsl:choose>
			<xsl:when test="not(document($internalmessagefile)//imessage[id=$msg])">
				<br/>
				<xsl:call-template name="hightlightedtext_design">
					<xsl:with-param name="text" select="$string[$intmessages_basestring + 13]"/>
				</xsl:call-template>
		  	</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="document($internalmessagefile)//imessage[id=$msg]">
					<xsl:choose>
						<xsl:when test="document($internalmessagefile)//imessage[id=$msg]/to!= $username">
							<br/>
							<xsl:call-template name="hightlightedtext_design">
								<xsl:with-param name="text" select="$string[$intmessages_basestring + 13]"/>
							</xsl:call-template>
					  	</xsl:when>
						<xsl:otherwise>
							<table width="100%">
								<tr height="20" valign="top">
									<td  colspan="2">
									<xsl:call-template name="messagesview_actions" />
									<xsl:call-template name="messagesview_navigation" />
								</td>
								</tr>
							</table>
							<table width="100%">
								<tr>
									<td align="right" width="75px"><b><xsl:value-of select="$string[$intmessages_basestring + 7]" />:</b></td><td align="left"><xsl:value-of select="from"/></td>
								</tr>
								<tr>
									<td align="right" width="75px"><b><xsl:value-of select="$string[$intmessages_basestring + 6]"/>:</b></td><td align="left"><xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime"><xsl:value-of select="date"/></xsl:with-param></xsl:call-template></td>
								</tr>
								<tr>
									<td align="right" width="75px"><b><xsl:value-of select="$string[$intmessages_basestring + 8]"/>:</b></td><td align="left"><xsl:value-of select="subject"/></td>
								</tr>
								<tr height="15"/>
								<tr>
									<td align="right" valign="top" width="75px"><b><xsl:value-of select="$string[$intmessages_basestring + 10]" />:</b></td><td><xsl:value-of select="message" disable-output-escaping="yes"/></td>
								</tr>
								<tr>
									<td colspan="2" height="20" ></td>
								</tr>
								<xsl:if test="answering">
									<xsl:variable name="msgid" select="answering"/>
									<tr>
										<td colspan="2"><hr/></td>
									</tr>
									<tr bgColor="{$margin_background}">
										<td colspan="2"><b><font color="{$margin_color}"><xsl:value-of select="$string[$intmessages_basestring + 17]" /></font></b></td>
									</tr>
									<tr>
										<td colspan="2" height="20"/>
									</tr>
									<tr>
										<td align="right" width="75px"><b><xsl:value-of select="$string[$intmessages_basestring + 6]"/>:</b></td><td align="left"><xsl:call-template name="display_date"><xsl:with-param name="p_Date"><xsl:value-of select="document($internalmessagefile)//imessage[id=$msgid]/date" /></xsl:with-param></xsl:call-template></td>
									</tr>
									<tr>
										<td align="right" width="75px"><b><xsl:value-of select="$string[$intmessages_basestring + 8]"/>:</b></td><td align="left"><xsl:value-of select="document($internalmessagefile)//imessage[id=$msgid]/subject"/></td>
									</tr>
									<tr height="15"/>
									<tr>
										<td align="right" valign="top" width="75px"><b><xsl:value-of select="$string[$intmessages_basestring + 10]" />:</b></td><td><xsl:value-of select="document($internalmessagefile)//imessage[id=$msgid]/message" disable-output-escaping="yes"/></td>
									</tr>

								</xsl:if>
							</table>
						</xsl:otherwise>
					</xsl:choose>	
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- actions user can perform when viewing message -->
	<xsl:template name="messagesview_actions">
	<xsl:param name="myid" select="document($memberfile)//members/member[pseudo=$username]/id"/>
		<xsl:for-each select="document($internalmessagefile)//imessage[id=$msg]">
		<xsl:variable name="frompseudo" select="from" />
		<xsl:variable name="fromID" select="document($memberfile)//members/member[pseudo=$frompseudo]/id" />
			<table align="left">
				<tr>
					<td>
						<!-- delete message -->
						<form method="post" action="default.asp?ACT=83&amp;id=0&amp;item=view">
							<input type="hidden" name="operation" value="delete"/>
							<input type="hidden" name="file" value="internalmessage"/>
							<input type="hidden" name="node" value="internalmessages/imessage[id={$msg}]"/>
							<input type="submit" class="mini" value="{$string[$mmbasestring + 37]}" />
						</form>
					</td>
					<td>
						<!-- Answer Message -->
						<form><input type="button" class="mini"  value="{$string[$intmessages_basestring + 18]}" onclick="document.location.href='default.asp?ACT=83&amp;id=0&amp;item=answer&amp;msg={$msg}&amp;member={$fromID}';"/>
						</form>
					</td>
					<xsl:if test="count(document($friendsfile)//friends/friend[user=$myid and userfriend=$fromID])=0">
					<td>
						<!-- Add author to friends list -->
						<form method="post" Action="default.asp?ACT=82&amp;id=1&amp;kind=add&amp;member={$fromID}">
							<input type="hidden" name="operation" value="add"/>
							<input type="hidden" name="file" value="friends"/>
							<input type="hidden" name="bloc" value="friends"/>
							<input type="hidden" name="node" value="friend"/>
							<input type="hidden" name="user" value="{$myid}"/>
							<input type="hidden" name="userfriend" value="{$fromID}"/>
							<input type="submit" class="mini" value="{$string[$mmbasestring + 30]}" />
					</form>
					</td>
					</xsl:if>
				</tr>
			</table>
		</xsl:for-each>
	</xsl:template>

	<!-- Navigation between messages -->
	<xsl:template name="messagesview_navigation">
		<xsl:for-each select="document($internalmessagefile)//imessage[id=$msg]">
			<table width="25%" align="right">
				<tr>
					<td align="right" valign="top">
						<xsl:choose>
							<!-- if previous message is a new one -->
							<xsl:when test="following-sibling::imessage[to=$username][1]/state='new'">
								<a class="newsgroup" style="cursor: hand;" onclick="window.document.forms['previous'].submit();"><xsl:value-of select="$string[251]"/></a>
								<div id="{id}" style="display: none;">
									<form name="previous" method="post" action="default.asp?ACT=83&amp;id=0&amp;item=view&amp;msg={following-sibling::imessage[to=$username][1]/id}">
										<input type="hidden" name="file" value="internalmessage"/>
										<input type="hidden" name="operation" value="update"/>
										<input type="hidden" name="node" value="internalmessages/imessage[id={following-sibling::imessage[to=$username][1]/id}]"/>
										<input type="hidden" name="state" value="old"/>
									</form>
								</div>		
							</xsl:when>
							<!-- if not new -->
							<xsl:otherwise>
								<xsl:if test="following-sibling::imessage[to=$username]"><a class="newsgroup" href="default.asp?ACT=83&amp;id=0&amp;item=view&amp;msg={following-sibling::imessage[to=$username][1]/id}"><xsl:value-of select="$string[251]"/></a></xsl:if>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<xsl:choose>
							<!-- if previous message is a new one -->
							<xsl:when test="preceding-sibling::imessage[to=$username][1]/state='new'">
								<a class="newsgroup" style="cursor: hand;" onclick="window.document.forms['next'].submit();"><xsl:value-of select="$string[252]"/></a>
								<div id="{id}" style="display: none;">
									<form name="next" method="post" action="default.asp?ACT=83&amp;id=0&amp;item=view&amp;msg={preceding-sibling::imessage[to=$username][1]/id}">
										<input type="hidden" name="file" value="internalmessage"/>
										<input type="hidden" name="operation" value="update"/>
										<input type="hidden" name="node" value="internalmessages/imessage[id={preceding-sibling::imessage[to=$username][1]/id}]"/>
										<input type="hidden" name="state" value="old"/>
									</form>
								</div>		
							</xsl:when>
							<!-- if not new -->
							<xsl:otherwise>
									<xsl:if test="preceding-sibling::imessage[to=$username]"><a class="newsgroup" href="default.asp?ACT=83&amp;id=0&amp;item=view&amp;msg={preceding-sibling::imessage[to=$username][1]/id}"><xsl:value-of select="$string[252]"/></a></xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
			</table>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
