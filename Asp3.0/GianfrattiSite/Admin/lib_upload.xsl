<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xml:space="preserve">
<xsl:output method="html"/> 

	<xsl:template name="upload_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Upload Manager</xsl:with-param>
			<xsl:with-param name="version">0.3</xsl:with-param>
			<xsl:with-param name="moddate">27.08.2003</xsl:with-param>
			<xsl:with-param name="author">JeS (Jens Schreiber)</xsl:with-param>
			<xsl:with-param name="url"><a href="http://www.fxmods.com">http://www.fxmods.com</a></xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="upload_manager">
		
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M11"><img src="admin/media/users.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[180]"/></font></td></tr>
		</table>
				
		<Script>
		  var nfiles = 1;
		  function Expand(){
		    nfiles++
		    files.insertAdjacentHTML('BeforeEnd','File '+nfiles+': <input type="file" class="full"  name="YourFileFile'+nfiles+'"/> ');
		    files.insertAdjacentHTML('BeforeEnd','<input type="button" Style="border=0;cursor:hand" value="{$string[941]}" onclick="OpenDirectory(document.frmFullxml.UploadDir' + nfiles +');"/><BR/>');
		    files.insertAdjacentHTML('BeforeEnd','<input type="hidden" name="UploadDir'+nfiles+'"/><BR/>');
		    return false
		  }
		</Script>
		
		<script>
			var fx_imgwin;
			 var fx_opener;			
			 			
			function OpenDirectory(oOpener) {
				fx_opener = oOpener;
				fx_imgwin = window.open('dirpicker.asp','selImg','width=450, height=330, scrollbars=yes'); 
				fx_imgwin.focus();
			}
			 
			function onDirectory(path, base_url) {
				fx_opener.value = path;
				fx_imgwin.close();
			}
		</script>
						
		<xsl:choose>
		
			<!-- NEW FILE FORM -->
			<xsl:when test="$id='new'">
				<table bgcolor="white">
					<form method="post" enctype="multipart/form-data" action="default.asp?ACT=1&amp;SECT=M11" name="frmFullxml">
					<input type="hidden" name="operation" value="upload"/>
					<tr><td>
						<div ID="files">						
						File 1: <input type="file" name="YourFile1" class="full"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="button" Style="border=0;cursor:hand" value="{$string[941]}" onclick="OpenDirectory(document.frmFullxml.UploadDir1);"/><BR/>
						<input type="hidden" name="UploadDir1" value=""/><BR/>						
						<!--File 2:<input type="file" name="YourFile2" class="full"/><BR/>-->
						</div>
					</td></tr>
					<tr><td align="right"><Input Type="Button" Value="{$string[942]}" OnClick="return(Expand());" Style="border=0;background=white;cursor:hand"/></td></tr>
					<tr><td align="right">
						<input type="submit" name="submit" value="{$string[943]}"/>
					</td></tr>
				</form></table>
			</xsl:when>
			
			<!-- the file list -->
			<xsl:otherwise>							
				<table border="0" cellpadding="0" cellspacing="1" width="100%">		
					<tr>
						<td class="header" ><xsl:value-of select="$string[944]"/></td>
						<td class="header" width="100"><xsl:value-of select="$string[945]"/></td>
						<td class="header" width="100"><xsl:value-of select="$string[946]"/></td>
						<td class="header" width="150"><xsl:value-of select="$string[947]"/></td>
						<td class="header" width="100"><xsl:value-of select="$string[948]"/></td></tr>			
					
					<xsl:for-each select="$uploadfilenode//uploadfolder/file">								
						<xsl:sort select="@name" data-type="text" order="ascending"/>
						<tr class="data" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
							<td class="data2"><xsl:value-of select="@name"/></td>
							<td class="data2"><xsl:value-of select="@size"/></td>
							<td class="data2"><xsl:value-of select="@type"/></td>
							<td class="data2"><xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="substring(@date,1,12)"/></xsl:call-template>:<xsl:value-of select="substring(@date,13,2)"/></td>
							<td align="center">
								<xsl:if test="$usertype='administrator'">
									<input type="button" value="{$string[949]}" onclick="location='default.asp?ACT=1&amp;SECT=M11&amp;file={@name}';"/>											
								</xsl:if>								
							</td>
						</tr>
					</xsl:for-each>								
					
					<tr><td colspan="5" align="right"><input onclick="document.location.href='default.asp?ACT=1&amp;SECT=M11&amp;id=new';" type="button" value="{$string[15]}"/></td></tr>
				</table>
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>
	
</xsl:stylesheet>
