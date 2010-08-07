<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb">
	<xsl:output method="html" indent="no"/>

	<!-- photo template  -->
	<!-- last modified : 2003/11/10, by Jens Schreiber -->
	<!-- version 1.0 -->

	<xsl:variable name="cat-thumbheight">60</xsl:variable>
	<xsl:variable name="cat-thumbwidth">60</xsl:variable>
	<xsl:variable name="pic-thumbheight">60</xsl:variable>
	<xsl:variable name="pic-thumbwidth">60</xsl:variable>
	<xsl:variable name="cat-ColumnCount">3</xsl:variable>
	<xsl:variable name="cat-IndexCount">20</xsl:variable>
	
	<xsl:variable name="open_TR">&lt;tr&gt;</xsl:variable>
	<xsl:variable name="close_TR">&lt;/tr&gt;</xsl:variable>
	<xsl:variable name="width_TD">number(100/number($cat-ColumnCount))</xsl:variable>

	<xsl:template name="nextid">
		<xsl:param name="direction"/>
		<xsl:param name="currid"/>

		<xsl:if test="$direction='next'">
			<xsl:value-of select="/siteinfo/photos/photo[id &gt; $currid and category = $cat]/id"/>
		</xsl:if>
		<xsl:if test="$direction='back'">
			<xsl:for-each select="/siteinfo/photos/photo[id &lt; $currid and category = $cat]">
				<xsl:sort select="id" order="descending"/>
				<xsl:value-of select="id"/>,
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="index">		
		<xsl:for-each select = "/siteinfo/photos/photo[category = $cat]">			
			<xsl:choose>
				<xsl:when test="$pic=id">
					<xsl:value-of select="position()" />
				</xsl:when>
				<xsl:otherwise>
					<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;cat={$cat}&amp;pic={id}">
						<xsl:value-of select="position()" />
					</a>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
			<xsl:if test="position() mod $cat-IndexCount = 0">
				<BR/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="showcategory">
		<xsl:if test="(position() mod $cat-ColumnCount) = 1">
			<xsl:value-of select="$open_TR" disable-output-escaping="yes"/>
		</xsl:if>
		<td width="{$width_TD}" align="left" valign="center">
			<xsl:choose>
				<xsl:when test="directory='on'">
					<xsl:variable name="link">default.asp?id=<xsl:value-of select="$id"/>&amp;ACT=<xsl:value-of select="$ACT"/>&amp;cat=<xsl:value-of select="id"/>&amp;pic=0</xsl:variable>
					<xsl:choose>
						<xsl:when test = "string-length(thumbnail)&gt;0">										
							<a href="{$link}">
								<img height="{$cat-thumbheight}" width="{$cat-thumbwidth}" style="border: 1px dashed black;" src="{thumbnail}" alt="{title}" />
							</a>								
							<xsl:if test = "string-length(name) &gt; 0">
								<BR/>
								<form action="{$link}" method="post" name="frmCategory{id}">
									<input type="hidden" name="dir" value="{path}" />
									<a href="#" onClick="document.frmCategory{id}.submit();return;">
										<font size="3">
											<xsl:value-of select="name"/>
										</font>
									</a>
								</form>
							</xsl:if>
						</xsl:when>
						<xsl:when test = "string-length(name) &gt; 0">
							<form action="{$link}" method="post" name="frmCategory{id}">
								<input type="hidden" name="dir" value="{path}" />
								<a href="#" onClick="document.frmCategory{id}.submit();return;">
									<font size="3">
										<xsl:value-of select="name"/>
									</font>
								</a>									
							</form>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="link">default.asp?id=<xsl:value-of select="$id"/>&amp;ACT=<xsl:value-of select="$ACT"/>&amp;cat=<xsl:value-of select="id"/>&amp;pic=0</xsl:variable>
					<xsl:choose>
						<xsl:when test = "string-length(thumbnail)&gt;0">										
							<a href="{$link}">
								<img height="{$cat-thumbheight}" width="{$cat-thumbwidth}" style="border: 1px dashed black;" src="{thumbnail}" alt="{title}" />
							</a>								
							<xsl:if test = "string-length(name) &gt; 0">
								<BR/>
								<a href="{$link}">
									<xsl:value-of select="name"/>
								</a>
							</xsl:if>
						</xsl:when>
						<xsl:when test = "string-length(name) &gt; 0">
							<a href="{$link}">
								<font size="3"><xsl:value-of select="name"/></font>
							</a>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</td>
		<xsl:if test="(position() mod $cat-ColumnCount) = 0">
			<xsl:value-of select="$close_TR" disable-output-escaping="yes"/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="photo">

		<xsl:variable name="nbphoto" select="count(siteinfo/photos/photo)"/>
		<xsl:variable name="next">
			<xsl:call-template name="nextid">
				<xsl:with-param name="direction">next</xsl:with-param>
				<xsl:with-param name="category"><xsl:value-of select="$cat"/></xsl:with-param>
				<xsl:with-param name="currid"><xsl:value-of select="$pic"/></xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="back1">
			<xsl:call-template name="nextid">
				<xsl:with-param name="direction">back</xsl:with-param>
				<xsl:with-param name="currid"><xsl:value-of select="$pic"/></xsl:with-param>
			</xsl:call-template>
		</xsl:variable>		
		<xsl:variable name="back" select="substring-before($back1,',')"/>
		
		<xsl:choose>
			<xsl:when test="$cat">
				<xsl:choose>
					<xsl:when test="$dir">
						<xsl:if test="$dir">
							<xsl:call-template name="photodirectory"/>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$pic=0">
						<table align="center" width="100%">
						<xsl:for-each select="/siteinfo/photos/photo[category=$cat]">
							<xsl:sort select="id" data-type="number"/>
								<xsl:if test="position() mod 6 =1">		
									<xsl:value-of select="'&lt;tr&gt;'" disable-output-escaping="yes"/>
								</xsl:if>
								<xsl:choose>
									<xsl:when test="string-length(thumbnail)&gt;0">									
										<td align="center">
											<a href="default.asp?ACT=2&amp;cat={$cat}&amp;pic={id}&amp;id=0">
												<img style="border: 1px dashed black;" src="{thumbnail}" alt="{title}" /><br/>
												<xsl:value-of select="title"/>
											</a>
										</td>									
									</xsl:when>
									<xsl:otherwise>									
										<td align="center">
											<a href="default.asp?ACT=2&amp;cat={$cat}&amp;pic={id}&amp;id=0">
												<img style="border: 1px dashed black;" src="{image}" alt="{title}" width="{$pic-thumbwidth}" height="{$pic-thumbheight}"/><br/>
												<xsl:value-of select="title"/>
											</a>
										</td>
									</xsl:otherwise>
								</xsl:choose>	
							<xsl:if test="position() mod 6 =0 and position()!=last()">
								<xsl:value-of select="'&lt;/tr&gt;&lt;tr&gt;'" disable-output-escaping="yes"/>
							</xsl:if>
							<xsl:if test="position()=last()">
								<xsl:value-of select="'&lt;/tr&gt;'" disable-output-escaping="yes"/>
							</xsl:if>
						</xsl:for-each>
						</table>
					</xsl:when>
					<xsl:otherwise>
						<table cellpadding="0" cellspacing="0" width="100%" border="0">
							<tr>
								<td colspan="2" align="center"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<xsl:call-template name="title_design">
										<xsl:with-param name="title">
											<xsl:value-of select="/siteinfo/photos/photo[id=$pic]/title" disable-output-escaping="yes"/>
											<xsl:if test="$usertype='administrator'">
												<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
												<a href="default.asp?ACT=1&amp;SECT=M7&amp;id={$pic}">
													<img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/>
												</a>
											</xsl:if>
										</xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td align="center" colspan="2">
									<br/><img src="{siteinfo/photos/photo[id=$pic]/image}" alt="{siteinfo/photos/photo[id=$pic]/title}"/>					
								</td>
							</tr>
							<tr class="wppicturestext">
								<td colspan="2"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<xsl:call-template name="normaltext_design">
										<xsl:with-param name="text">
											<xsl:value-of select="/siteinfo/photos/photo[id=$pic]/text" disable-output-escaping="yes"/>
										</xsl:with-param>
									</xsl:call-template>						
								</td>
							</tr>
							<tr align="center">
								<td width="10%">
									<xsl:if test="number($back)>0">
										<a href="default.asp?ACT=2&amp;cat={$cat}&amp;pic={$back}&amp;id=0">
											<xsl:value-of select="$string[251]"/>
										</a>
									</xsl:if>
								</td>
								<td width="80%">
									<xsl:call-template name="index"/>
								</td>
								<td width="10%">
									<xsl:if test="number($next)>1">
										<a href="default.asp?ACT=2&amp;cat={$cat}&amp;pic={$next}&amp;id=0">
											<xsl:value-of select="$string[252]"/>
										</a>
									</xsl:if>
								</td>
							</tr>
						</table>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<table width="100%">
					<xsl:for-each select="/siteinfo/photocategories/photocategory[visible='on']">
						<xsl:sort select="title"/>
						<xsl:variable name="category" select="id"/>
						<xsl:if test="count(/siteinfo/photos/photo[category=$category]) > 0 or directory='on'">
							<xsl:choose>
								<xsl:when test = "$usertype='administrator'">
									<xsl:call-template name="showcategory"/>
									</xsl:when>
									<xsl:when test = "$usertype='editor'">
										<xsl:if test="group!='administrator'">
											<xsl:call-template name="showcategory"/>
										</xsl:if>
									</xsl:when>								
									<xsl:when test = "$usertype='member'">
										<xsl:if test="group!='administrator' and group!='editor'">
											<xsl:call-template name="showcategory"/>
										</xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<xsl:if test="group='anonymous'">
											<xsl:call-template name="showcategory"/>
										</xsl:if>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
					</xsl:for-each>					
				</table>
			</xsl:otherwise>
		</xsl:choose>
		<img src="templates/admin/media/dot.gif" width="1" height="6"/>
	</xsl:template>
	
	
	<xsl:template name="DirectoryOK">
		<xsl:param name="catpath" />
		<xsl:param name="curpath" />
		<xsl:if test="starts-with($curpath, $catpath)">
			OK
		</xsl:if>
	</xsl:template>	
	
	<xsl:template name="showparentdirectory">
		<xsl:if test="string-length($dir)>0">
			<xsl:variable name = "parentname" select="vb:GetFolderName($dir)"/>
			<xsl:variable name = "parentdir" select="vb:GetParentPath($dir)"/>
			<xsl:variable name = "path" select="/siteinfo/photocategories/photocategory[id=$cat]/path"/>
			<xsl:variable name = "pathok" select="vb:GetPath(string($path))"/>
			<xsl:variable name = "dirok" select="vb:GetPath(string($dir))"/>			
	
			<xsl:choose>
				<xsl:when test="$dirok = $pathok">
					<font size="3"><xsl:value-of select="$parentname"/></font>
				</xsl:when>
				<xsl:otherwise>
					<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;pic=0&amp;cat={$cat}&amp;dir={$parentdir}">
						<img src="admin/media/parent.gif" border="0"/>
					</a>
					<font size="3"><xsl:value-of select="$parentname"/></font>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<xsl:template name="showphotodirectory">
		<xsl:param name="directory"></xsl:param>

		<xsl:variable name = "currdir" select="substring-before($directory,'*')" />

		<xsl:if test="string-length($currdir) > 0">
			<tr>
				<td>
					<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;pic=0&amp;cat={$cat}&amp;dir={$currdir}">
						<font size="2"><xsl:value-of select="vb:GetFolderName($currdir)"/></font>
					</a>			
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
			</tr>
			
			<xsl:call-template name = "showphotodirectory" >
				<xsl:with-param name="directory"><xsl:value-of select="substring-after($directory,'*')" /></xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="picthumbnail">
		<xsl:param name="picture"></xsl:param>
		
		<xsl:variable name="picturefile">
			<xsl:value-of select="vb:GetPictureFromThumbNail(string($picture))"/>
		</xsl:variable>
		<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;pic={$picturefile}&amp;cat={$cat}&amp;dir={$dir}">
			<img style="border: 1px dashed black;" src="{/siteinfo/data/url}/{$dir}/{$picture}" width="{$pic-thumbwidth}" height="{$pic-thumbheight}"/>
		</a>		
	</xsl:template>

	<xsl:template name="showdirpictures">
		<xsl:param name="picture"></xsl:param>
		<xsl:param name="counter"></xsl:param>
		
		<xsl:variable name = "currpic" select="substring-before($picture,'*')" />
		<xsl:if test="string-length($currpic)>0">			
			<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>		
			<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
			
			<xsl:call-template name = "picthumbnail" >
				<xsl:with-param name="picture"><xsl:value-of select="$currpic" /></xsl:with-param>
			</xsl:call-template>
			
			<xsl:if test="($counter mod 6) = 0">
				<BR/>
			</xsl:if>
			
			<xsl:call-template name = "showdirpictures" >
				<xsl:with-param name="picture"><xsl:value-of select="substring-after($picture,'*')" /></xsl:with-param>
				<xsl:with-param name="counter"><xsl:value-of select="number($counter) + 1" /></xsl:with-param>
			</xsl:call-template>			
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="showdirpicture">
		<xsl:param name="picture"></xsl:param>
		
		<xsl:if test="string-length=($picture)>0">
			<xsl:variable name="picturefile">
				<xsl:value-of select="vb:GetPictureFromThumbNail(string($picture))"/>
			</xsl:variable>

			<table cellpadding="0" cellspacing="0" width="100%" border="0">
				<tr>
					<td colspan="2">
						<xsl:call-template name="title_design">
										<xsl:with-param name="title">
											<xsl:value-of select="string($picture)" disable-output-escaping="yes"/>
										</xsl:with-param>
									</xsl:call-template>
					</td>
				</tr>				
				<tr>
					<td align="center" colspan="3">
						<br/>
						<img src="{/siteinfo/data/url}/{$dir}/{$picturefile}"/>
					</td>
				</tr>
				<tr align="center">
					<td width="10%">
						<xsl:variable name="prevpic" select="vb:GetPrevPicture($mappath, $dir, string($picturefile))"/>
						<xsl:if test="string-length($prevpic) &gt; 0">
							<a href="default.asp?ACT=2&amp;cat={$cat}&amp;pic={$prevpic}&amp;id=0&amp;dir={$dir}">
								<xsl:value-of select="$string[251]"/>
							</a>							
						</xsl:if>
					</td>
					<td width="10%">
						<xsl:variable name="nextpic" select="vb:GetNextPicture($mappath, $dir, string($picturefile))"/>
						<xsl:if test="string-length($nextpic) &gt; 0">
							<a href="default.asp?ACT=2&amp;cat={$cat}&amp;pic={$nextpic}&amp;id=0&amp;dir={$dir}">
								<xsl:value-of select="$string[252]"/>
							</a>							
						</xsl:if>
					</td>
				</tr>				
			</table>
		</xsl:if>
	</xsl:template>
		
	<xsl:template name="photodirectory">		
		<xsl:variable name = "path" select="/siteinfo/photocategories/photocategory[id=$cat]/path"/>
		<xsl:variable name = "catpath" select="vb:GetPath(string($path))"/>		
		<xsl:variable name = "curpath" select="vb:GetPath(string($dir))"/>

		<xsl:variable name = "dirok">
			<xsl:call-template name = "DirectoryOK" >
				<xsl:with-param name="catpath"><xsl:value-of select="$catpath"/></xsl:with-param>
				<xsl:with-param name="curpath"><xsl:value-of select="$curpath"/></xsl:with-param>
			</xsl:call-template>
		</xsl:variable>

		<xsl:if test="string-length($dirok)">
			<table width="100%">
				<tr>
					<td>
						<xsl:call-template name = "showparentdirectory" />
					</td>
				</tr>
				<tr>
					<td>
						<table>
							<xsl:call-template name = "showphotodirectory" >
								<xsl:with-param name="directory"><xsl:value-of select="vb:GetSubFolders($mappath, $dir)"/></xsl:with-param>
							</xsl:call-template>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:choose>
							<xsl:when test="$pic!=0 and string-length($pic)>0">
								<xsl:call-template name = "showdirpicture" >
									<xsl:with-param name="picture"><xsl:value-of select="$pic"/></xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>					
								<xsl:call-template name = "showdirpictures" >
									<xsl:with-param name="picture"><xsl:value-of select="vb:GetPictures($mappath, $dir)"/></xsl:with-param>
									<xsl:with-param name="counter">1</xsl:with-param>				
								</xsl:call-template>	
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
			</table>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
