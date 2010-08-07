<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb">

<!-- Create: 2001/10/26, by J.Roland -->
<!-- Last modified: 2003/09/14, by Jens Schreiber (JeS) and Miguel Figueira (Mig100) -->
<!-- version 2.0 -->

<xsl:output method="html" indent="no"/>
<xsl:include href="functions.xsl"/>

<xsl:template name="LoginPseudoField">
	<xsl:param name="value"/>
	<xsl:choose>
		<xsl:when test="/siteinfo/data/pseudouppercase='on'">
			<script language="JavaScript">
				function setUpperCaseLgn() 
					{ 
						var text = document.login.lgn.value; 
						document.login.lgn.value = text.toUpperCase(); 
					} 
			</script>
			<input class="text" type="text" size="14" name="lgn" value="{$value}" onChange="setUpperCaseLgn()"/>
		</xsl:when>
		<xsl:otherwise>
			<input class="text" type="text" size="14" name="lgn" value="{$value}"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="SignUpPseudoField">
	<xsl:param name="value"/>
	<xsl:choose>
		<xsl:when test="/siteinfo/data/pseudouppercase='on'">
			<script language="JavaScript">
				function setUpperCaseSgn() 
					{ 
						var text = document.frmFullxml.unique_pseudo.value; 
						document.frmFullxml.unique_pseudo.value = text.toUpperCase(); 
					}
			</script>
			<input type="text" name="unique_pseudo" size="20" value="{$value}" onChange="setUpperCaseSgn()"/>
		</xsl:when>
		<xsl:otherwise>
			<input type="text" name="unique_pseudo" size="20" value="{$value}"/>
		</xsl:otherwise>
	</xsl:choose>	
</xsl:template>

<!-- Signup calculation -->
<xsl:template name="signup">				
	<style type="text/css">
		input{font-size: 12px; font-weight: normal; font-family: arial;}
		input.medium{ width: 100px; background-color: #D6EBFF; color: #000000;font-weight: normal; border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid;}
		input.medium2{ width: 200px; background-color: #D6EBFF; color: #000000;font-weight: normal; border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid;}
		input.medium3{ width: 300px; background-color: #D6EBFF; color: #000000;font-weight: normal; border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid;}
		input.full{ width: 450px; background-color: #D6EBFF; color: #000000; font-weight: normal; border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid;}

		select {width: 200px; background-color: #D6EBFF; color: #000000; font-size: 12px; font-weight: normal; font-family: arial; border: 1px #4C4C4C solid; filter: alpha(opacity=100);}
		select.full {width: 300px; background-color: #D6EBFF; color: #000000; font-size: 12px; font-weight: normal; font-family: arial; border: 1px #4C4C4C solid; filter: alpha(opacity=100);}		

	</style>

	<table border="0" width="100%" cellpadding="1" cellspacing="0">
		<form action="default.asp?ACT=10" method="post" name="frmFullxml">
			<input type="hidden" name="file" value="member"/>
			<input type="hidden" name="operation" value="add"/>
			<input type="hidden" name="bloc" value="members"/>
			<input type="hidden" name="node" value="member"/>
			<input type="hidden" name="visible" value="{/siteinfo/data/inscriptionstate}"/>
			
			<input type="hidden" name="type" value="member"/>
			<input type="hidden" name="sign_guid" value="{$guid}"/>
			<input type="hidden" name="friends" value="friends"/>
			
			<tr>
				<td colspan="2">
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[301]"/>
						</xsl:with-param>
					</xsl:call-template>					
				</td>
			</tr>
<!-- Pseudo -->
			<tr>
				<td width="100">
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[302]"/> (*)
						</xsl:with-param>
					</xsl:call-template>
				</td>
				<td><xsl:call-template name="SignUpPseudoField"/></td>
			</tr>
<!-- Password -->
			<tr>
				<td>
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[303]"/> (*)
						</xsl:with-param>
					</xsl:call-template>					
				</td>
				<td><input type="password" class="medium" name="comp_password"/></td>
			</tr>
<!-- First Name -->
			<tr>
				<td>
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[$mmbasestring + 13]"/>:
						</xsl:with-param>
					</xsl:call-template>					
				</td>
				<td><input type="text" class="medium2" name="userfname"/></td>
			</tr>
<!-- Last Name -->
			<tr>
				<td>
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[$mmbasestring + 14]"/>:
						</xsl:with-param>
					</xsl:call-template>					
				</td>
				<td><input type="text" class="medium2" name="userlname"/></td>
			</tr>
<!-- Webpage -->
			<tr>
				<td>
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[$mmbasestring + 15]"/>:
						</xsl:with-param>
					</xsl:call-template>					
				</td>
				<td><input type="text" class="medium3" name="userpage"/></td>
			</tr>
<!-- Mail -->
			<tr>
				<td>
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[304]"/> (*)
						</xsl:with-param>
					</xsl:call-template>					
				</td>
				<td><input type="text" class="medium3" name="comp_email"/></td></tr>
<!-- Photo (path): -->
			<tr>
				<td>
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[$mmbasestring + 16]"/>:
						</xsl:with-param>
					</xsl:call-template>
				</td>
				<td><input type="text" class="medium3" name="userphoto"/></td>
			</tr>
<!-- Sex -->
			<tr>
				<td>
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[$mmbasestring + 3]"/>:
						</xsl:with-param>
					</xsl:call-template>
				</td>
				<td><select name="usersex"><option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
					<xsl:for-each select="document($listfile)//lists/list[name='Sex']/entries/entry">
						<xsl:sort select="caption" data-type="text" order="ascending"/>
						<option value="{value}"><xsl:value-of select="caption"/></option>
					</xsl:for-each>
				</select></td>
			</tr>
<!-- Age -->
			<tr>
				<td>
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[$mmbasestring + 4]"/>:
						</xsl:with-param>
					</xsl:call-template>
				</td>
				<td><select name="userage"><option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
					<xsl:for-each select="document($listfile)//lists/list[name='Age']/entries/entry">
						<xsl:sort select="id" data-type="number" order="ascending"/>
						<option value="{value}"><xsl:value-of select="caption"/></option>
					</xsl:for-each>
				</select></td>
			</tr>
<!-- Ocupation -->
			<tr>
				<td>
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[$mmbasestring + 5]"/>:
						</xsl:with-param>
					</xsl:call-template>
				</td>
				<td><select name="userocupation"><option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
					<xsl:for-each select="document($listfile)//lists/list[name='Ocupation']/entries/entry">
						<xsl:sort select="caption" data-type="text" order="ascending"/>
						<option value="{value}"><xsl:value-of select="caption"/></option>
					</xsl:for-each>
				</select></td>
			</tr>
<!-- Adress -->
			<tr>
				<td>
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[$mmbasestring + 18]"/>:
						</xsl:with-param>
					</xsl:call-template>
				</td>
				<td><input type="text" class="full" name="useradress"/></td>
			</tr>
<!-- Zip -->
			<tr>
				<td>
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[$mmbasestring + 19]"/>:
						</xsl:with-param>
					</xsl:call-template>
				</td>
				<td><input type="text" class="medium" name="userzip"/></td>
			</tr>
<!-- Ville -->
			<tr>
				<td>
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[305]"/>: (*)
						</xsl:with-param>
					</xsl:call-template>					
				</td>
				<td><input type="text" class="medium3" name="comp_ville"/></td>
			</tr>
<!-- State -->
			<tr>
				<td>
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[$mmbasestring + 7]"/>:
						</xsl:with-param>
					</xsl:call-template>					
				</td>
				<td><input type="text" class="medium3" name="userstate"/></td>
			</tr>
<!-- Country -->
			<tr>
				<td>
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[$mmbasestring + 8]"/>: (*)
						</xsl:with-param>
					</xsl:call-template>
				</td>
				<td><select name="comp_usercountry" class="full" ><option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
					<xsl:for-each select="document($listfile)//lists/list[name='Countries']/entries/entry">
						<xsl:sort select="caption" data-type="text" order="ascending"/>
						<option value="{value}"><xsl:value-of select="caption"/></option>
					</xsl:for-each>
				</select></td>
			</tr>
<!-- Phone -->
			<tr>
				<td>
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[$mmbasestring + 20]"/>:
						</xsl:with-param>
					</xsl:call-template>					
				</td>
				<td><input type="text" class="medium" name="userphone"/></td>
			</tr>

<!-- Newsletter -->
			<tr><table width="100%"><tr>
				<td  align="center">
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[431]"/>
						</xsl:with-param>
					</xsl:call-template>					
				<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="checkbox" checked="checked" name="newsletter"/>
				</td>
				<td  align="center">
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[$mmbasestring + 21]"/>:
						</xsl:with-param>
					</xsl:call-template>					
				<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="checkbox" checked="checked" name="comp_userpublic"/>
				</td>
			</tr>
<!-- submit -->
			<tr>
				<td colspan="2" align="right"><input type="submit" value="{$string[306]}"/></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<xsl:call-template name="normaltext_design">
						<xsl:with-param name="text">
							<xsl:value-of select="$string[307]"/>
						</xsl:with-param>
					</xsl:call-template>					
				</td></tr></table>
			</tr>
		</form>
	</table>
</xsl:template>
			
<!-- SIGNUP Validation -->		
<xsl:template name="signupthx">
	<xsl:variable name="vbcrlf">
		<xsl:text>
</xsl:text>
		</xsl:variable>
	
	<!-- if webmaster want it, send an alert -->
	<xsl:if test="/siteinfo/data/wsignup='on' and string-length($goback)=0">
		<xsl:call-template name="Mailer">
			<xsl:with-param name="ToEmail" select="string(/siteinfo/data/email)"/>
			<xsl:with-param name="FromEmail" select="string($comp_email)"/>
			<xsl:with-param name="Subject" select="string($string[385])"/>
			<xsl:with-param name="Message" select="concat($string[302], ': ', $unique_pseudo, $vbcrlf, $string[304], ': ', $comp_email, $vbcrlf, $string[305], ': ', $comp_ville )"/>
		</xsl:call-template>
	</xsl:if>
	
	
	<!-- if signup mode is a email confirmation -->
	<xsl:if test="/siteinfo/data/inscriptionstate='email' and string-length($goback)=0">
		<xsl:call-template name="Mailer">
			<xsl:with-param name="ToEmail" select="$comp_email"/>
			<xsl:with-param name="FromEmail" select="string(/siteinfo/data/email)"/>
			<xsl:with-param name="Subject" select="string($string[423])"/>
			<xsl:with-param name="Message" select="concat($string[424], /siteinfo/data/url, $vbcrlf, $string[425], $vbcrlf, /siteinfo/data/url, '/default.asp?guid=', $sign_guid, $vbcrlf, $vbcrlf, $string[426],$vbcrlf, $string[302], ': ', $unique_pseudo, $vbcrlf, $string[303], ': ', $comp_password)"/>					
		</xsl:call-template>
	</xsl:if>
	
	<!-- Dislpay the thx message -->
	<xsl:call-template name="hightlightedtext_design">
		<xsl:with-param name="text">
			<xsl:choose>
				<xsl:when test="/siteinfo/data/inscriptionstate='off'"><xsl:value-of select="$string[309]"/></xsl:when>
				<xsl:when test="/siteinfo/data/inscriptionstate='email'"><xsl:value-of select="$string[427]"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$string[308]"/></xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>
			
			
<!-- Affichage de la boite de login -->			
<xsl:template name="loginform">	
	<xsl:call-template name="margin_design">
		<xsl:with-param name="title">
			<xsl:value-of select="$string[248]"/>
		</xsl:with-param>
		<xsl:with-param name="body">
			<TABLE cellspacing="1" cellpadding="0" border="0">
				<xsl:variable name="cleanACT">
					<xsl:choose>
						<xsl:when test="$ACT=11">0</xsl:when>
						<xsl:otherwise><xsl:value-of select="$ACT"/></xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				
				<form name="login" action="default.asp?id={$id}&amp;mnu={$mnu}&amp;ACT={$cleanACT}" method="post">
				<tr>
					<td>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<xsl:call-template name="LoginPseudoField">
							<xsl:with-param name="value"><xsl:value-of select="$lgn"/></xsl:with-param>
						</xsl:call-template>
						<br/>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input class="text" type="password" size="10" name="pwd"/>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<input type="submit" value='ok' class="sbttn"/>
					</td>
				</tr>
				<tr><td align="center"><input type="checkbox" name="rememberme"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[606]"/></td></tr>
				</form>
				<!-- register -->
				<tr>
				    <td align="center">				
        			        <xsl:if test="$usertype='anonymous' and /siteinfo/data/signup='on'">
        				    <xsl:call-template name="normaltext_design"><xsl:with-param name="text"><a href="default.asp?id=0&amp;ACT=9"><xsl:value-of select="$string[241]"/></a></xsl:with-param></xsl:call-template><br/>
        			        </xsl:if>
        			        <xsl:if test="$usertype='anonymous' and /siteinfo/data/emailCOM!='off' ">
        				    <xsl:call-template name="normaltext_design"><xsl:with-param name="text"><a href="default.asp?id=0&amp;ACT=20"><xsl:value-of select="$string[460]"/></a></xsl:with-param></xsl:call-template>
        			        </xsl:if>
				    </td>
				  </tr>
				  
			</TABLE>		
		</xsl:with-param>
	</xsl:call-template>	
</xsl:template>

<!-- Design of wellcome form -->
<xsl:template name="wellcome_design">
     <xsl:call-template name="margin_design">
          <xsl:with-param name="title"><xsl:value-of select="$string[506]"/></xsl:with-param>
          <xsl:with-param name="body">
               <table width="100%">
                    <tr>
                         <td align="center">
                         	<xsl:choose>
								<xsl:when test="document($datafile)/siteinfo/data/textdirection = 'RTL'">
									<a class="user"><xsl:value-of select="$username"/></a><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[$mmbasestring + 25]"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$string[$mmbasestring + 25]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a class="user"><xsl:value-of select="$username"/></a>
								</xsl:otherwise>								
							</xsl:choose>
                         </td>
                    </tr>
                    <tr>
                         <td align="center">
				<a href="default.asp?id=0&amp;ACT=81&amp;member={document($memberfile)//members/member[pseudo=$username]/id}"><img height="32" width="32" style="border: 0px;" src="Skins/{siteinfo/data/xslskin}/media/user.gif" alt="{$string[$mmbasestring + 11]}" /></a>
				<xsl:if test="/siteinfo/data/useinternalmessages != 'off'">
					<xsl:choose>
						<xsl:when test="count(document($internalmessagefile)//imessage[to=$username and state='new']) &gt; 0">
							<a href="default.asp?id=0&amp;ACT=83"><img height="32" width="32" style="border: 0px;" src="Skins/{siteinfo/data/xslskin}/media/messagebox2.gif" alt="{$string[$intmessages_basestring + 4]}" /></a>
						</xsl:when>
						<xsl:otherwise>
					<a href="default.asp?id=0&amp;ACT=83"><img height="32" width="32" style="border: 0px;" src="Skins/{siteinfo/data/xslskin}/media/messagebox.gif" alt="{$string[$intmessages_basestring + 3]}" /></a>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:if test="/siteinfo/data/membermanager!='off'">
					<a href="default.asp?id=0&amp;ACT=82"><img height="32" width="32" style="border: 0px;" src="Skins/{siteinfo/data/xslskin}/media/friends.gif" alt="{$string[$mmbasestring + 35]}" /></a>
				</xsl:if>
				<a href="default.asp?id=1&amp;mnu=1&amp;ACT=11"><img height="32" width="32" style="border: 0px;" src="Skins/{siteinfo/data/xslskin}/media/logout.gif" alt="{$string[246]}" /></a>
                         </td>
                    </tr>
		    <xsl:if test="$usertype='administrator' or $usertype='editor'">
  	                 <tr>
                              <td align="center">
				    <a class="menu" href="default.asp?ACT=1&amp;SECT=M0"><xsl:value-of select="$string[245]"/></a>
                              </td>
                         </tr>
                    </xsl:if>
               </table>
          </xsl:with-param>
     </xsl:call-template>
</xsl:template>

<xsl:template name="forgotpassword">
	<xsl:call-template name="hightlightedtext_design">
		<xsl:with-param name="text">
			<xsl:value-of select="$string[462]"/>
		</xsl:with-param>
	</xsl:call-template>
	<table width="300">
		<form action="default.asp?ACT=21" method="post">
		<tr><td><xsl:value-of select="$string[463]"/></td><td><input type="text" name="pseudo"/></td></tr>
		<tr><td><xsl:value-of select="$string[464]"/></td><td><input type="text" name="email"/></td></tr>
		<tr><td colspan="2" align="right"><input type="submit" value="{$string[465]}"/></td></tr>
		</form>
	</table>	
</xsl:template>


<xsl:template name="forgotpasswordsend">
	
	<xsl:variable name="vbcrlf">
		<xsl:text>
</xsl:text>
		</xsl:variable>
	<xsl:variable name="rmbpwd"><xsl:value-of select="document($memberfile)//members/member[pseudo=$pseudo and email=$email]/password"/></xsl:variable>


	<xsl:choose>
		<xsl:when test="string-length($rmbpwd)=0">
			<xsl:call-template name="hightlightedtext_design">
				<xsl:with-param name="text">
					<xsl:value-of select="$string[470]"/><br/>
					<a href="default.asp?ACT=20"><xsl:value-of select="$string[472]"/></a><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=9"><xsl:value-of select="$string[473]"/></a>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<!-- Envoi du mail -->
			<xsl:call-template name="Mailer">
				<xsl:with-param name="ToEmail" select="string($email)"/>
				<xsl:with-param name="FromEmail" select="string(/siteinfo/data/email)"/>
				<xsl:with-param name="Subject" select="string($string[466])"/>
				<xsl:with-param name="Message" select="concat($string[467], $vbcrlf, $vbcrlf, $string[463], ': ', $pseudo, $vbcrlf, $string[468] , ': ', $rmbpwd, $vbcrlf,$vbcrlf, string(/siteinfo/data/url), $vbcrlf, $string[469])"/>
			</xsl:call-template>
			
		
			<xsl:call-template name="hightlightedtext_design">
				<xsl:with-param name="text">
					<xsl:value-of select="$pseudo"/>, <xsl:value-of select="$string[471]"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>

	<!--we send the email -->		
</xsl:template>

<!-- My account form -->
<xsl:template name="myaccountform">
		<script language="JavaScript" SRC="admin/js/AnchorPosition.js"></script>
		<script language="JavaScript" SRC="admin/js/PopupWindow.js"></script>
		<script language="JavaScript" SRC="admin/js/CalendarPopup.js"></script>
		<script language="JavaScript" SRC="admin/js/date.js"></script>
		<script language="JavaScript" SRC="admin/js/ColorPicker2.js"></script>
	<script>
	function ValidateForm()
		{
			if (window.document.forms["frmFullxml"].password.value==0 || window.document.forms["frmFullxml"].email.value==0 || window.document.forms["frmFullxml"].ville.value==0)
				{
					alert('<xsl:value-of select="$string[475]"/>');
					return false
				}
			else
			{
				if (window.document.forms["frmFullxml"].cbnewsletter.checked)
					window.document.forms["frmFullxml"].newsletter.value = 'on';
				if (window.document.forms["frmFullxml"].cbnewsletter.unchecked)
					window.document.forms["frmFullxml"].newsletter.value = 'off';
				if (window.document.forms["frmFullxml"].cbuserpublic.checked)
					window.document.forms["frmFullxml"].userpublic.value = 'on';
				else
					window.document.forms["frmFullxml"].userpublic.value = 'off';
				return true;
			}	
		}
	</script>

	<style type="text/css">

		input{font-size: 12px; font-weight: normal; font-family: arial;}
		input.medium{ width: 100px; background-color: #D6EBFF; color: #000000;font-weight: normal; border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid;}
		input.medium2{ width: 200px; background-color: #D6EBFF; color: #000000;font-weight: normal; border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid;}
		input.medium3{ width: 300px; background-color: #D6EBFF; color: #000000;font-weight: normal; border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid;}
		input.full{ width: 450px; background-color: #D6EBFF; color: #000000; font-weight: normal; border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid;}

		select {width: 200px; background-color: #D6EBFF; color: #000000; font-size: 12px; font-weight: normal; font-family: arial; border: 1px #4C4C4C solid; filter: alpha(opacity=100);}
		select.full {width: 300px; background-color: #D6EBFF; color: #000000; font-size: 12px; font-weight: normal; font-family: arial; border: 1px #4C4C4C solid; filter: alpha(opacity=100);}		

		<xsl:choose>								
					<xsl:when test="$oldeditor='on'">
						textarea{height: 150px; width: 450px; background-color: #D6EBFF; color: #000000; font-size: 12px; font-weight: normal; font-family: arial;  border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid; filter: alpha(opacity=100);BEHAVIOR: url(admin/js/textarea.htc)}
					</xsl:when>
					<xsl:otherwise>
						textarea{height: 150px; width: 450px; background-color: #D6EBFF; color: #000000; font-size: 12px; font-weight: normal; font-family: arial;  border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid; filter: alpha(opacity=100);}
					</xsl:otherwise>
				</xsl:choose>
	</style>
			
	<xsl:for-each select="document($memberfile)//members/member[pseudo=$username]">
		<xsl:variable name="userid" select="id"/>
		<table border="0" width="100%" cellpadding="1" cellspacing="0">
			<form action="default.asp?ACT=23" method="post" name="frmFullxml" onSubmit="return ValidateForm()">
				<input type="hidden" name="file" value="member"/>
				<input type="hidden" name="operation" value="update"/>
				<input type="hidden" name="node" value="members/member[id={$userid}]"/>
				<input type="hidden" name="newsletter" value=""/>
				<input type="hidden" name="userpublic" value=""/>
				

<!-- User -->
				<tr>
					<td width="100">
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[302]"/> (*)
							</xsl:with-param>
						</xsl:call-template>
					</td>
					<td><font color="#ff0000"><xsl:value-of select="$username"/></font></td>
				</tr>
<!-- Password -->
				<tr>
					<td>
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[303]"/> (*)
							</xsl:with-param>
						</xsl:call-template>					
					</td>
					<td><input type="password" class="medium" name="password" value="{password}"/></td>
				</tr>
<!-- First name -->
				<tr>
					<td>
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[$mmbasestring + 13]"/>:
							</xsl:with-param>
						</xsl:call-template>	
					</td>
					<td><input type="text" class="medium2" value="{userfname}" name="userfname" /></td>
				</tr>
<!-- Last name -->
				<tr>
					<td>
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[$mmbasestring + 14]"/>:
							</xsl:with-param>
						</xsl:call-template>	
					</td>
					<td><input type="text" class="medium2" value="{userlname}" name="userlname" /></td>
				</tr>
<!-- Webpage -->
				<tr>
					<td>
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[$mmbasestring + 15]"/>:
							</xsl:with-param>
						</xsl:call-template>	
					</td>
					<td><input type="text" class="medium3" value="{userpage}" name="userpage" /></td>
				</tr>
<!-- Mail -->
				<tr>
					<td>
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[304]"/> (*)
							</xsl:with-param>
						</xsl:call-template>					
					</td>
					<td><input type="text" class="medium3" name="email" value="{email}"/></td>
				</tr>
<!-- Photo -->
				<tr>
					<td>
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[$mmbasestring + 16]"/>:
							</xsl:with-param>
						</xsl:call-template>	
					</td>
					<td><input type="text" class="medium3" value="{userphoto}" name="userphoto" /></td>
				</tr>
<!-- Sex -->
				<tr>
					<td>
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[$mmbasestring + 3]"/>:
							</xsl:with-param>
						</xsl:call-template></td>
					<td>
						<select name="usersex">
						<xsl:variable name="actualsex" select="usersex"/>
							<xsl:if test = "$actualsex=''">
								<option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
							</xsl:if>
							<xsl:if test="not($actualsex)">
								<option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
							</xsl:if>
							<xsl:for-each select="document($listfile)//lists/list[name='Sex']/entries/entry">
							<xsl:sort select="caption" data-type="text" order="ascending"/>
								<option value="{value}"><xsl:if test="value=$actualsex"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
									<xsl:value-of select="caption"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>
<!-- Age -->
				<tr>
					<td>
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[$mmbasestring + 4]"/>:
							</xsl:with-param>
						</xsl:call-template></td>
					<td>
						<select name="userage">
						<xsl:variable name="actualage" select="userage"/>
							<xsl:if test = "$actualage=''">
								<option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
							</xsl:if>
							<xsl:if test="not($actualage)">
								<option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
							</xsl:if>

							<xsl:for-each select="document($listfile)//lists/list[name='Age']/entries/entry">
							<xsl:sort select="id" data-type="number" order="ascending"/>
								<option value="{value}"><xsl:if test="value=$actualage"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
									<xsl:value-of select="caption"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>
<!-- Ocupation -->
				<tr>
					<td>
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[$mmbasestring + 5]"/>:
							</xsl:with-param>
						</xsl:call-template></td>
					<td>
						<select name="userocupation">
						<xsl:variable name="actualocupation" select="userocupation"/>
							<xsl:if test = "$actualocupation=''">
								<option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
							</xsl:if>
							<xsl:if test="not($actualocupation)">
								<option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
							</xsl:if>

							<xsl:for-each select="document($listfile)//lists/list[name='Ocupation']/entries /entry">
								<xsl:sort select="caption" data-type="text" order="ascending"/>
								<option value="{value}"><xsl:if test="value=$actualocupation"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
									<xsl:value-of select="caption"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>
<!-- Adress -->
				<tr>
					<td>
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[$mmbasestring + 18]"/>:
							</xsl:with-param>
						</xsl:call-template>	
					</td>
					<td><input type="text" class="full" value="{useradress}" name="useradress" size="60"/></td>
				</tr>
<!-- Zip -->
				<tr>
					<td>
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[$mmbasestring + 19]"/>:
							</xsl:with-param>
						</xsl:call-template>	
					</td>
					<td><input type="text" class="medium" value="{userzip}" name="userzip" /></td>
				</tr>
<!-- Ville -->
				<tr>
					<td>
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
							<xsl:value-of select="$string[305]"/>: (*)
							</xsl:with-param>
						</xsl:call-template>					
					</td>
					<td><input type="text" class="medium3" name="ville" value="{ville}"/></td>
				</tr>
<!-- State -->
				<tr>
					<td>
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[$mmbasestring + 7]"/>:
							</xsl:with-param>
						</xsl:call-template>					
					</td>
					<td><input type="text" class="medium3" name="userstate" value="{userstate}"/></td>
				</tr>
<!-- Country -->
				<tr>
					<td>
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[$mmbasestring + 8]"/>: (*)
							</xsl:with-param>
						</xsl:call-template></td>
					<td>
						<select name="usercountry" class="full" >
						<xsl:variable name="actualcountry" select="usercountry"/>
							<xsl:if test = "$actualcountry=''">
								<option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
							</xsl:if>
							<xsl:if test="not($actualcountry)">
								<option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
							</xsl:if>

							<xsl:for-each select="document($listfile)//lists/list[name='Countries']/entries/entry">
							<xsl:sort select="caption" data-type="text" order="ascending"/>
								<option value="{value}"><xsl:if test="value=$actualcountry"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
									<xsl:value-of select="caption"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>
<!-- Phone -->
				<tr>
					<td>
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[$mmbasestring + 20]"/>:
							</xsl:with-param>
						</xsl:call-template>	
					</td>
					<td><input type="text" class="medium" value="{userphone}" name="userphone" /></td>
				</tr>
<!-- Wellcome message -->
				<tr>
					<td>
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[$mmbasestring + 22]"/>:
							</xsl:with-param>
						</xsl:call-template>	

					</td>
					<td>
						<xsl:choose>
							<xsl:when test="$usertype='administrator'">
								<textarea class="textarea" name="userwellcome" title="{$string[$mmbasestring + 22]}"><xsl:value-of select="userwellcome" disable-output-escaping="no"/></textarea>
								<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('userwellcome');</script></xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<textarea class="textarea" name="userwellcome" title="{$string[$mmbasestring + 22]}"><xsl:value-of select="userwellcome" disable-output-escaping="no"/></textarea>
								<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('userwellcome', config);</script></xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
<!-- Newsletter -->
				<tr><td colspan="2">
					<table width="100%"><tr>
					<td align="center">
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[431]"/>
							</xsl:with-param>
						</xsl:call-template>					
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					<input type="checkbox" name="cbnewsletter">
						<xsl:if test="newsletter='on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
					</input>
					</td>
					<td align="center">
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[$mmbasestring + 21]"/>
							</xsl:with-param>
						</xsl:call-template>					
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					<input type="checkbox" name="cbuserpublic">
						<xsl:if test="userpublic='on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
					</input>
					</td>
					</tr></table>
					</td></tr>
<!-- Submit -->
				<tr>
					<td colspan="2" align="right"><input type="submit" value="{$string[306]}" /></td>

				</tr>
				<tr>
					<td colspan="2" align="center">
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$string[307]"/>
							</xsl:with-param>
						</xsl:call-template>					
					</td>
				</tr>
			</form>
		</table>
	</xsl:for-each>
</xsl:template>

	<xsl:template name="myaccountthx">
		<xsl:call-template name="normaltext_design">
			<xsl:with-param name="text">
				<xsl:value-of select="$string[476]"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


	<!-- online member box -->
	<xsl:template name="online_members_macro">
		<xsl:variable name="email_object" select="/siteinfo/data/emailCOM"/> 
		<xsl:variable name="user" select="document($sessionfile)//sessions/session/@username"/>
		<xsl:variable name="userid" select="document($sessionfile)//sessions/session/@userid"/>

		 <xsl:call-template name="margin_design">
		    <xsl:with-param name="title">
				<xsl:value-of select="concat(count(document($sessionfile)//sessions/session[string-length(@username)>0 and @groupname!='administrator']), ' ', $string[547])"/>
			</xsl:with-param>
			
			<xsl:with-param name="body">
				<xsl:for-each select="document($sessionfile)//sessions/session[string-length(@username)>0 and @groupname!='administrator']">
					<xsl:variable name="memberid" select="@userid"/>
					<xsl:call-template name="menu_item_design">
						<xsl:with-param name="content">
							<xsl:choose>
								<xsl:when test="document($memberfile)//members/member[id=$memberid and userpublic='on']">
									<a href="default.asp?ACT=81&amp;member={@userid}&amp;id=0">
										<xsl:value-of select="@username"/>
									</a>
								</xsl:when>
								<xsl:when test="document($memberfile)//members/member[id=$memberid and userpublic!='on'] and $email_object!='off'">
									<xsl:value-of select="@userpublic"/>
									<a href="default.asp?ACT=25&amp;member={@userid}&amp;id=0">
										<xsl:value-of select="@username"/>
									</a>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="@username"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:with-param>
		</xsl:call-template>		
	</xsl:template>

	
	<!-- Form to send an email beetween members -->
	<xsl:template name="sendmailForm">
		
		<xsl:choose>
			<xsl:when test="$usertype='anonymous'">
				<!-- user is not logged -->
				<xsl:call-template name="hightlightedtext_design">
					<xsl:with-param name="text" select="$string[561]"/>
				</xsl:call-template>				
			</xsl:when>
			<xsl:when test="$subject and $message">
				<!-- Send the email -->
				<xsl:call-template name="Mailer">
					<xsl:with-param name="ToEmail" select="string(document($memberfile)//members/member[id=$member]/email)"/>
					<xsl:with-param name="FromEmail" select="string(document($memberfile)//members/member[pseudo=$username]/email)"/>
					<xsl:with-param name="Subject" select="$subject"/>
					<xsl:with-param name="Message" select="$message"/>					
				</xsl:call-template>
				<xsl:call-template name="hightlightedtext_design">
					<xsl:with-param name="text" select="$string[562]"/>
				</xsl:call-template>			
			</xsl:when>
			<xsl:otherwise>
				<!-- Display the form -->
				<table>
				<form action="default.asp?ACT=25" method="post">
					<input type="hidden" name="member" value="{$member}"/>
					<tr><td><b><xsl:value-of select="$string[556]"/></b></td><td><xsl:value-of select="document($memberfile)//members/member[pseudo=$username]/email"/></td></tr>
					<tr><td><b><xsl:value-of select="$string[557]"/></b></td><td><xsl:value-of select="$username"/></td></tr>
		
					<tr><td><b><xsl:value-of select="$string[558]"/></b></td><td><input type="text" name="subject" size="50"/></td></tr>
					<tr><td colspan="2"><b><xsl:value-of select="$string[559]"/></b></td></tr>
					<tr><td colspan="2"><textarea rows="20" cols="70" name="message"/></td></tr>
					<tr><td colspan="2" align="right"><input type="submit" value="{$string[560]}"/></td></tr>
				</form>
				</table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
						
</xsl:stylesheet>