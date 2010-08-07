<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb">
   <xsl:output method="html" indent="yes" encoding="iso-8859-1" />

	<xsl:template name="chat_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Chat</xsl:with-param>
			<xsl:with-param name="version">0.6</xsl:with-param>
			<xsl:with-param name="moddate">07.11.2003</xsl:with-param>
			<xsl:with-param name="author">Mig100 (Miguel Figueira) and JeS (Jens Schreiber)</xsl:with-param>
			<xsl:with-param name="url">http://www.fxmods.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="chat_manager">
		<xsl:call-template name = "chat_navigator" />		

		<xsl:choose>
			<xsl:when test="$channel='new'">
				<xsl:call-template name = "channel_add" />
			</xsl:when>
			<xsl:when test="$channel">				
				<xsl:for-each select = "document($chatfile)/chat/channel[id=$channel]">
					<xsl:call-template name = "channel_update" />
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name = "channel_list" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--         navigator at the top         -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="chat_navigator">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr>
				<td align="left" valign="center" width="50">
						<img src="admin/media/chat.gif" border="0"/>						
				</td>
				<td align="left" valign="center">
					<font size="6"><b><xsl:value-of select="$string[$chbasestring + 18]"/></b></font>
				</td>
			</tr>
		</table>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--       show list of all channels      -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->	
	<xsl:template name="channel_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">
			<tr>
				<td class="header" width="16">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td class="header" width="50"><xsl:value-of select="$string[$chbasestring + 19]"/></td>
				<td class="header"><xsl:value-of select="$string[$chbasestring + 6]"/></td>
			</tr>
			<xsl:for-each select="document($chatfile)/chat/channel">
				<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M93&amp;channel={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td><img src="admin/media/{visible}.gif" width="16" height="15" border="0"/></td>
					<td class="data2" width="50"><xsl:value-of select="id"/></td>
					<td class="data2"><a href="default.asp?ACT=1&amp;SECT={$section}&amp;channel={id}"><xsl:value-of select="name"/></a></td>
				</tr>
			</xsl:for-each>
		</table>
		<input type="submit" value="{$string[420]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;channel=new';"/>
	</xsl:template>

	<xsl:template name="channel_add">
		<table bgcolor="white" class="block">
			<form name="frmFullxml" action="default.asp?ACT=1&amp;SECT={$section}" method="post">
				<tr>
					<td>
						<input type="hidden" name="file" value="chat"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="bloc" value="chat"/>
						<input type="hidden" name="node" value="channel"/>
						<input type="hidden" name="members" value="all members of this channel"/>			
						<input type="hidden" name="messages" value="all messages of this channel"/>
						<input type="hidden" name="visible" value="on"/>

						<table width="100%" class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$chbasestring + 6]"/>:
								</td>
								<td>
									<input type="text" name="name" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$chbasestring + 7]"/>:
								</td>
								<td>
									<textarea name="description"/>
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

	<xsl:template name="channel_update">
		<table bgcolor="white" class="block">
			<form name="frmFullxml" action="default.asp?ACT=1&amp;SECT={$section}" method="post">
				<tr>
					<td>
						<input type="hidden" name="file" value="chat"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="chat/channel[id={$channel}]"/>

						<table width="100%" class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$chbasestring + 6]"/>:
								</td>
								<td>
									<input type="text" name="name" class="full" value="{name}"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$chbasestring + 7]"/>:
								</td>
								<td>
									<textarea name="description"><xsl:value-of select="description"/></textarea>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$chbasestring + 16]"/>:
								</td>
								<td>
									<input type="text" class="mini" name="owner" value="{owner}"/>
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
						<form name="frmDrop" action="default.asp?ACT=1&amp;SECT={$section}&amp;type={$type}" method="post" onsubmit="return confirm('{$string[83]}');">
							<table class="block">
								<tr>
									<td bgcolor="white" align="right">
								    	<input type="hidden" name="file" value="chat"/>
										<input type="hidden" name="operation" value="delete"/>
										<input type="hidden" name="node" value="chat/channel[id={$channel}]"/>
										<input type="submit" value="{$string[16]}"/>
									</td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</xsl:if>
			<tr>
				<td>
					<table width="100%" class="block">
						<tr>
							<td>
								<xsl:call-template name = "chatmessage_list">
									<xsl:with-param name="channel"><xsl:value-of select="id" /></xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</xsl:template>
	
	<xsl:template name="chatmessage_list">
		<xsl:param name="channel" />
		<table border="0" cellpadding="0" cellspacing="1" width="100%">
			<tr>
				<td class="header" width="16">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td class="header" width="30"><xsl:value-of select="$string[$chbasestring + 19]"/></td>
				<td class="header" width="20%"><xsl:value-of select="$string[$chbasestring + 16]"/></td>
				<td class="header" width="80%"><xsl:value-of select="$string[$chbasestring + 5]"/></td>
			</tr>
			<xsl:for-each select="document($chatfile)/chat/channel[id=$channel]/messages/message">
				<xsl:sort select="id" data-type="number" order="descending"/>
				<tr bgcolor="white" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
					<td><img src="admin/media/{visible}.gif" width="16" height="15" border="0"/></td>
					<td class="data2" width="30"><xsl:value-of select="id"/></td>
					<td class="data2" width="20%"><a href="default.asp?ACT=1&amp;SECT={$section}&amp;id={id}"><xsl:value-of select="owner"/></a></td>
					<td class="data2" width="80%"><xsl:value-of select="substring(msg,1,50)"/>...</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>

</xsl:stylesheet>