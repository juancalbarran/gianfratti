<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:output method="html" indent="yes" encoding="iso-8859-1" />

<!-- Created : 2003/06/15, by Miguel Figueira (Mig100)-->
<!-- Last modified : 2003/09/12, by Miguel Figueira -->

	<xsl:template name="list_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">List Manager</xsl:with-param>
			<xsl:with-param name="version">0.3</xsl:with-param>
			<xsl:with-param name="moddate">20.09.2003</xsl:with-param>
			<xsl:with-param name="author">Mig100 (Miguel Figueira), JeS</xsl:with-param>
			<xsl:with-param name="url">http://www.fxmods.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="list_manager">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M80"><img src="admin/media/lists.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[$lists_basestring + 0]"/></font></td></tr>
		</table>
		<xsl:choose>
			<xsl:when test="$listid">
				<xsl:choose>
					<xsl:when test="$entry">
						<xsl:choose>
							<xsl:when test="$entry='new'">
								<xsl:call-template name="entry_add"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:for-each select="document($listfile)/lists/list[id=$listid]/entries/entry[id=$entry]">
							<xsl:call-template name="entry_update"/>
								</xsl:for-each>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$listid='new'">
						<xsl:call-template name="list_add"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="document($listfile)/lists/list[id=$listid]">
							<xsl:call-template name="list_update"/>
						</xsl:for-each>
					</xsl:otherwise>				
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
					<xsl:call-template name="lists_list"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<!-- list grid -->
	<xsl:template name="lists_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr align="center">
				<td class="header" width="10%"><xsl:value-of select="$string[127]"/></td>
				<td class="header" width="90%"><xsl:value-of select="$string[332]"/></td>
			</tr>			
			
			<xsl:for-each select="document($listfile)//lists/list">
				<xsl:sort select="id" data-type="number" order="ascending"/>
				<xsl:if test="position() &gt; number($page*$list_pagesize) and position() &lt;=  number(($page+1)*$list_pagesize) ">
					<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M80&amp;listid={$listid}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
						<td class="data2"><xsl:value-of select="id"/></td>
						<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M80&amp;listid={id}"><xsl:value-of select="name"/></a></td>
					</tr>
				</xsl:if>
			</xsl:for-each>		
			<tr><td colspan="2" align="center">
				<!-- Navigation for the Paging -->
				<xsl:call-template name="paging_Rail_macro">
					<xsl:with-param name="totalpage" select="count(document($listfile)//lists/list) div $list_pagesize"/>
					<xsl:with-param name="currentpage" select="number($page)+1"/>
					<xsl:with-param name="url">default.asp?ACT=1&amp;SECT=M80</xsl:with-param>
				</xsl:call-template>
			</td></tr>						
			<tr><td colspan="9" align="right"><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M80&amp;listid=new';" type="button" value="{$string[15]}"/></td></tr>
			
			
		</table>
	</xsl:template>

	<!-- Create new list -->	
	<xsl:template name="list_add">
		<table bgcolor="white" class="block">
			<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="list"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="bloc" value="lists"/>
						<input type="hidden" name="node" value="list"/>
						<input type="hidden" name="entries" value=""/>

						<table class="block">

							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[332]"/>:
								</td>
								<td>
									<input type="text" name="name" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[192]"/>:
								</td>
								<td>
									<textarea name="intro" title="Intro"></textarea><script language="javascript1.2">editor_generate('intro');</script>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$lists_basestring + 13]"/>:
								</td>
								<td>
		        						<select name="sortfield">
        									<option value="caption" selected="selected"><xsl:value-of select="$string[$lists_basestring + 7]"/></option>
        									<option value="value"><xsl:value-of select="$string[$lists_basestring + 8]"/></option>
        									<option value="id"><xsl:value-of select="$string[127]"/></option>
		        						</select>
        								<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
		        						<select name="sortorder">
        									<option value="ascending" selected="selected"><xsl:value-of select="$string[415]"/></option>
        									<option value="descending"><xsl:value-of select="$string[416]"/></option>
	       								</select>
    									<xsl:call-template name = "buildlist">
											<xsl:with-param name="list">List Datatype</xsl:with-param>
											<xsl:with-param name="name">datatype</xsl:with-param>
										</xsl:call-template>
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

	<!-- Update existing list -->
	<xsl:template name="list_update">
		<table bgcolor="white" class="block">
			<form name="frmFullxml" action="default.asp?ACT=1&amp;SECT={$section}" method="post">
				<tr>
					<td>
						<input type="hidden" name="file" value="list"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="lists/list[id={$listid}]"/>

						<table class="block">

							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[332]"/>:
								</td>
								<td>
								<xsl:choose>
								<!-- if list is considered a system one -->
									<xsl:when test="@readonly='readonly'">
										<b><xsl:value-of select="name"/></b>
									</xsl:when>
								<!-- if not -->
									<xsl:otherwise>
										<input type="text" value="{name}" name="name" class="full"/>
									</xsl:otherwise>
								</xsl:choose>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[192]"/>:
								</td>
								<td>
									<textarea name="intro" title="{$string[192]}"><xsl:value-of select="intro"/></textarea><script language="javascript1.2">editor_generate('intro');</script>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$lists_basestring + 11]"/>:
								</td>
								<td>
									<xsl:call-template name = "buildlist">
										<xsl:with-param name="list"><xsl:value-of select="document($listfile)//lists/list[id=$listid]/name"/></xsl:with-param>
										<xsl:with-param name="name">initialvalue</xsl:with-param>
										<xsl:with-param name="selectvalue"><xsl:value-of select="initialvalue"/></xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$lists_basestring + 13]"/>:
								</td>
								<td>
		        						<select name="sortfield">
        									<option value="caption"><xsl:if test="sortfield='caption' or string-length(sortfield)=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[$lists_basestring + 7]"/></option>
        									<option value="value"><xsl:if test="sortfield='value'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[$lists_basestring + 8]"/></option>
        									<option value="id"><xsl:if test="sortfield='id'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[127]"/></option>
		        						</select>
        								<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
		        						<select name="sortorder">
        									<option value="ascending"><xsl:if test="sortfield='ascending' or string-length(sortfield)=0"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[415]"/></option>
        									<option value="descending"><xsl:if test="sortfield='descending'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:value-of select="$string[416]"/></option>
        								</select>
    									<xsl:call-template name = "buildlist">
										<xsl:with-param name="list">List Datatype</xsl:with-param>
										<xsl:with-param name="name">datatype</xsl:with-param>
									</xsl:call-template>
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
				<tr>
					<td>
						<form action="default.asp?ACT=1&amp;SECT={$section}" method="post" onsubmit="return confirm('{$string[$lists_basestring + 5]}');">
							<table class="block">
								<tr>
								<xsl:choose>
								<!-- if list is considered a system one we prevent it to be deleted -->
									<xsl:when test="@readonly='readonly'">
									<td bgcolor="white" align="center">
									<font color="red"><xsl:value-of select="$string[$lists_basestring + 6]"/></font>
									</td>
									</xsl:when>
								<!-- if not -->
									<xsl:otherwise>
									<td bgcolor="white" align="right">
								    	<input type="hidden" name="file" value="list"/>
									<input type="hidden" name="operation" value="delete"/>
									<input type="hidden" name="node" value="lists/list[id={$listid}]"/>
									<input type="submit" value="{$string[16]}"/>
									</td>
									</xsl:otherwise>
								</xsl:choose>
								</tr>
							</table>
						</form>
					</td>
				</tr>
		</table>
		<xsl:call-template name="entries_list"/>
	</xsl:template>


	<!-- Entries grid for each list -->
	<xsl:template name="entries_list">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr align="center">
				<td class="header" width="10%"><xsl:value-of select="$string[127]"/></td>
				<td class="header" width="45%"><xsl:value-of select="$string[$lists_basestring + 7]"/></td>
				<td class="header" width="45%"><xsl:value-of select="$string[$lists_basestring + 8]"/></td>
			</tr>			
			
			<xsl:for-each select="document($listfile)//lists/list[id=$listid]/entries/entry">
				<xsl:sort select="id" data-type="number" order="ascending"/>
				<xsl:if test="position() &gt; number($page*$list_pagesize) and position() &lt;=  number(($page+1)*$list_pagesize) ">
					<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M80&amp;listid={$listid}&amp;entry={id}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
						<td class="data2"><xsl:value-of select="id"/></td>
						<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M80&amp;listid={$listid}&amp;entry={id}"><xsl:value-of select="caption"/></a></td>
						<td class="data2"><xsl:value-of select="value"/></td>
					</tr>
				</xsl:if>
			</xsl:for-each>		
			<tr><td colspan="3" align="center">
				<!-- Navigation for the Paging -->
				<xsl:call-template name="paging_Rail_macro">
					<xsl:with-param name="totalpage" select="count(document($listfile)//lists/list[id=$listid]/entries/entry) div $list_pagesize"/>
					<xsl:with-param name="currentpage" select="number($page)+1"/>
					<xsl:with-param name="url">default.asp?ACT=1&amp;SECT=M80&amp;listid=<xsl:value-of select="$listid" /></xsl:with-param>
				</xsl:call-template>
			</td></tr>						
			<tr><td colspan="9" align="right"><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M80&amp;listid={$listid}&amp;entry=new';" type="button" value="{$string[15]}"/></td></tr>
		</table>
	</xsl:template>

	<!-- Create new entry -->
	<xsl:template name="entry_add">
		<table bgcolor="white">
			<form action="default.asp?ACT=1&amp;SECT={$section}&amp;listid={$listid}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="list"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="bloc" value="lists/list[id={$listid}]/entries"/>
						<input type="hidden" name="node" value="entry"/>

						<table class="block">

							<tr>
								<td class="xp_sel">
								<xsl:value-of select="$string[$lists_basestring + 7]"/>:
								</td>
								<td>
									<input type="text" name="caption" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
								<xsl:value-of select="$string[$lists_basestring + 8]"/>:
								</td>
								<td>
									<input type="text" name="value" class="full"/>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;listid={$listid}';"/>
								</td>
							</tr>

						</table>
						<br/>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>

	<!-- Update existing entry -->
	<xsl:template name="entry_update">
		<table bgcolor="white">
			<form name="frmFullxml" action="default.asp?ACT=1&amp;SECT={$section}&amp;listid={$listid}" method="post">
				<tr>
					<td>
						<input type="hidden" name="file" value="list"/>
						<input type="hidden" name="operation" value="update"/>
						<input type="hidden" name="node" value="lists/list[id={$listid}]/entries/entry[id={$entry}]"/>

						<table class="block">

							<tr>
								<td class="xp_sel">
								<xsl:value-of select="$string[$lists_basestring + 7]"/>:
								</td>
								<td>
									<input type="text" value="{caption}" name="caption" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
								<xsl:value-of select="$string[$lists_basestring + 8]"/>:
								</td>
								<td>
									<xsl:choose>
										<xsl:when test="document($listfile)//lists/list[id=$listid and @readonly='readonly']">
											<xsl:value-of select="value"/>
										</xsl:when>
										<xsl:otherwise>
											<input type="text" value="{value}" name="value" class="full"/>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT={$section}&amp;listid={$listid}';"/>
								</td>
							</tr>
						</table>
						<br/>
					</td>
				</tr>
			</form>			
			<tr>
				<td>
					<form action="default.asp?ACT=1&amp;SECT={$section}&amp;listid={$listid}" method="post" onsubmit="return confirm('{$string[$lists_basestring + 9]}');">
						<xsl:choose>
							<!-- if list is considered a system one -->
							<xsl:when test="document($listfile)//lists/list[id=$listid and @readonly='readonly']">
								<p align="center">
									<font color="red">
										<xsl:value-of select="$string[$lists_basestring + 10]"/>
									</font>
								</p>
							</xsl:when>
							<xsl:otherwise>
								<table class="block">
									<tr>
										<td bgcolor="white" align="right">
								    		<input type="hidden" name="file" value="list"/>
											<input type="hidden" name="operation" value="delete"/>
											<input type="hidden" name="node" value="lists/list[id={$listid}]/entries/entry[id={$entry}]"/>
											<input type="submit" value="{$string[16]}"/>
										</td>
									</tr>
								</table>
							</xsl:otherwise>
						</xsl:choose>
					</form>
				</td>
			</tr>
		</table>
	</xsl:template>

	<!-- For use in forms -->
	<xsl:template name="buildlist">
		<xsl:param name="name"/>
		<xsl:param name="list"/>
		<xsl:param name="selectvalue"/>

		<xsl:if test="string-length('name') &gt; 0 and string-length('list') &gt; 0">
			<xsl:variable name="initval" select="document($listfile)//lists/list[name=$list]/initialvalue"/>
			<xsl:variable name="sortfield" select="document($listfile)//lists/list[name=$list]/sortfield"/>
			<xsl:variable name="sortorder" select="document($listfile)//lists/list[name=$list]/sortorder"/>
			<xsl:variable name="datatype"  select="document($listfile)//lists/list[name=$list]/datatype"/>

			<select name="{$name}">
				<xsl:if test="string-length($selectvalue) &gt; 0 or string-length($initval) = 0">
					<option value="">
						<xsl:if test="string-length($initval) = 0">
							<xsl:attribute name="selected">selected</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="$string[$mmbasestring + 17]"/>
					</option>
				</xsl:if>

				<xsl:for-each select="document($listfile)//lists/list[name=$list]/entries/entry">
					<xsl:sort select="*[name()=$sortfield]" data-type="{$datatype}" order="{$sortorder}"/>
					<option value="{value}">
						<xsl:if test="$initval = value">
							<xsl:attribute name="selected">selected</xsl:attribute>								
						</xsl:if>
						<xsl:value-of select="caption"/>
					</option>						
				</xsl:for-each>
			</select>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>				