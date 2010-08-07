<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb">
		
<xsl:output method="html" indent="no"/>
	
	<!-- VARIABLE DECALRATIONS - CHARS AND COLORS   -->
		<!-- website parameters -->
		<xsl:param name="cgwidth" select="document($skinstudiofile)//skinstudio/cgwidth"/><!-- largeur du site -->
		<xsl:param name="cglmw" select="document($skinstudiofile)//skinstudio/cglmw"/><!-- largeur de la marge gauche -->
		<xsl:param name="cgrmw" select="document($skinstudiofile)//skinstudio/cgrmw"/><!-- largeur de la marge droite -->
		<xsl:param name="cgalign" select="document($skinstudiofile)//skinstudio/cgalign"/><!-- alignement du site -->		
		<!-- font -->
		<xsl:param name="cgfont1" select="document($skinstudiofile)//skinstudio/cgfont1"/><!-- font 1 :: le nom du site-->
		<xsl:param name="cgfont2" select="document($skinstudiofile)//skinstudio/cgfont2"/><!-- font 3 :: le text normal-->
		<!-- main table conf -->
		<xsl:param name="cgcp" select="document($skinstudiofile)//skinstudio/cgcp"/><!-- CellPadding -->
		<xsl:param name="cgcs" select="document($skinstudiofile)//skinstudio/cgcs"/><!-- CellSpacing -->
		<!-- colors -->
		<xsl:param name="cgbody" select="document($skinstudiofile)//skinstudio/cgbody"/><!-- font -->
		<xsl:param name="cgbgbody" select="document($skinstudiofile)//skinstudio/cgbgbody"/><!-- bg body -->	
		<xsl:param name="cgmargin" select="document($skinstudiofile)//skinstudio/cgmargin"/><!--bg margin   -->
		<xsl:param name="cgborder" select="document($skinstudiofile)//skinstudio/cgborder"/><!-- bg border-->			
		<xsl:param name="cg1main" select="document($skinstudiofile)//skinstudio/cg1main"/><!-- bg main content  -->		 
		<xsl:param name="cgsitetile" select="document($skinstudiofile)//skinstudio/cgsitetile"/><!-- site tile  -->		
		
		<xsl:param name="cgtoolbar" select="document($skinstudiofile)//skinstudio/cgtoolbar"/><!-- font de la toolbar -->	
		<xsl:param name="cgbgtoolbar" select="document($skinstudiofile)//skinstudio/cgbgtoolbar"/><!-- bacground de la toolbar  -->	
		
		<!-- MARGIN -->
		<xsl:param name="cgmargintop" select="document($skinstudiofile)//skinstudio/cgmargintop"/>	
		<xsl:param name="cgmarginbody" select="document($skinstudiofile)//skinstudio/cgmarginbody"/>
		<xsl:param name="cgmargintext" select="document($skinstudiofile)//skinstudio/cgmargintext"/>	
		<xsl:param name="cgmarginline" select="document($skinstudiofile)//skinstudio/cgmarginline"/>
		
		<xsl:param name="cgcopyright" select="document($skinstudiofile)//skinstudio/cgcopyright"/>
		<xsl:param name="cgbgcopyright" select="document($skinstudiofile)//skinstudio/cgbgcopyright"/>
	<!-- END OF CHARS AND COLORS-->

	
	<!-- variables globales used dans les templates -->
	<xsl:param name="usermessage"/>
	<xsl:param name="msxml4"/>
	<xsl:param name="browsername"/>
	<xsl:param name="goback"/>
	<xsl:param name="usertype"/>
	<xsl:param name="username"/>
	<xsl:param name="actualdate"/>
	<xsl:param name="actdecdate"/>
	<xsl:param name="now"/>
	<xsl:param name="mappath"/>
	<xsl:param name="visitors"/>
	<xsl:param name="guid"/>
	<xsl:param name="sessionexpire"/>
	
	<!-- les request eventuels doivent etre declaré ici -->
	<xsl:param name="id"/>
	<xsl:param name="mnu"/>
	<xsl:param name="ACT"/>
	<xsl:param name="content"/>
	<xsl:param name="keyword"/>
	<xsl:param name="pic"/>
	<xsl:param name="vp"/>
	<xsl:param name="grp"/>
	<xsl:param name="msg"/>
	<xsl:param name="kind"/>
	<xsl:param name="lgn"/>
	<xsl:param name="pwd"/>
	<xsl:param name="gateway"/>
	<xsl:param name="kbid"/>
	<xsl:param name="layout"/>
	<xsl:param name="add"/>
	<xsl:param name="cmd"/>
	<xsl:param name="srv"/>

	<!-- member manager -->
	<xsl:param name="search"/>
	<xsl:param name="search_pseudo"/>
	<xsl:param name="search_sex"/>
	<xsl:param name="search_age"/>
	<xsl:param name="search_ocup"/>
	<xsl:param name="search_ville"/>
	<xsl:param name="search_state"/>
	<xsl:param name="search_country"/>
		
	<!-- directory -->
	<xsl:param name="dir"/>
	<xsl:param name="cat"/>
	<xsl:param name="item"/>
	<xsl:param name="name"/>
	<!-- paging :-) -->
	<xsl:param name="page" select="0"/> 
	<xsl:param name="guestbook_pagesize" select="10"/>
	<xsl:param name="forum_pagesize" select="20"/>
	<xsl:param name="member_pagesize" select="20"/>
	<xsl:param name="imessage_pagesize" select="20"/>
	<xsl:param name="friends_pagesize" select="20"/>

	<!-- message -->
	<xsl:param name="member"/>
	<xsl:param name="subject"/>
	<xsl:param name="message"/>

	<!-- for the newsgroups alerts -->
	<xsl:param name="operation"/>
	<xsl:param name="file"/>
	<xsl:param name="comp_title"/>
	<xsl:param name="text_body"/>
	<xsl:param name="body"/>
	<xsl:param name="comp_body"/>
	<xsl:param name="comp_message"/>
	
	<xsl:param name="unique_pseudo"/>
	<xsl:param name="comp_email"/>
	<xsl:param name="comp_ville"/>
	<xsl:param name="comp_usercountry"/>
	<xsl:param name="comp_password"/>
	<xsl:param name="sign_guid"/>
	
	<!-- forgot password -->
	<xsl:param name="email"/>
	<xsl:param name="pseudo"/>

	<!-- chat -->
	<xsl:param name="channel"/>
	<xsl:param name="chatview"/>
	<xsl:param name="action"/>
	<xsl:param name="user"/>

	<!-- event calendar -->
	<xsl:param name="calendar"/>
	<xsl:param name="eventid"/>
	<xsl:param name="eventdate"/>
	<xsl:param name="eventpage"/>
	<xsl:param name="previewpage"/>
		 	 
	<!-- Pointer to the data files -->	
	<xsl:param name="languagespath"/>
	<xsl:param name="datafile"/>
	<xsl:param name="discussionfile"/>
	<xsl:param name="pollfile"/>
	<xsl:param name="logfile"/>
	<xsl:param name="memberfile"/>
	<xsl:param name="reactfile"/>
	<xsl:param name="guestbookfile"/>
	<xsl:param name="taskfile"/>
	<xsl:param name="mediafile"/>
	<xsl:param name="downloadfile"/>
	<xsl:param name="categoryfile"/>
	<xsl:param name="bannerfile"/>
	<xsl:param name="directoryfile"/>
	<xsl:param name="sessionfile"/>
	<xsl:param name="skinstudiofile"/>
	<xsl:param name="kbfile"/>
	<xsl:param name="listfile"/>
	<xsl:param name="chatfile"/>
	<xsl:param name="calendarfile"/>
	<xsl:param name="friendsfile"/>
	<xsl:param name="internalmessagefile"/>
	<xsl:param name="classifiedfile"/>
	
	<xsl:variable name="DataFilePointer" select="document($datafile)"/>
	<xsl:variable name="MemberFilePointer" select="document($memberfile)"/>
	<xsl:variable name="ForumFilePointer" select="document($discussionfile)"/>
	
	<!-- FORUMS variables -->
	<xsl:variable name="newsgroupID" select="$grp"/>
	<xsl:variable name="messageID" select="$msg"/>
	
	<!-- Global variables-->
	<xsl:variable name="today" select="substring($actualdate,1,8)"/>
	
	<xsl:variable name="oldeditor" select="$DataFilePointer/siteinfo/data/oldeditor"/>
		
	<!-- We load the languages strings array -->
	<xsl:variable name="language" select="/siteinfo/data/language"/>
	<xsl:variable name="languagefilename"  select="document(concat($languagespath, '\_index.xml'))//languages/language[id=$language]/filename"/>
	<xsl:variable name="string" select="document(concat($languagespath, '\', $languagefilename))//language/strings/string"/>
	
	<!-- This params serves you as reference for first specific strings of each mentioned feature -->
	<!-- knowbase strings -->
	<xsl:param name="kb_basestring">621</xsl:param>
	<!-- List manager strings -->
	<xsl:param name="ecbasestring">701</xsl:param>
	<!-- Chat Manager strings -->
	<xsl:param name="chbasestring">761</xsl:param>
	<!-- Member Manager strings -->
	<xsl:param name="mmbasestring">801</xsl:param>
	<!-- Internal Messages strings -->
	<xsl:param name="intmessages_basestring">851</xsl:param>
	<!-- Classified strings -->
	<xsl:param name="classbasestring">971</xsl:param>
	
	<xsl:variable name="nbsp">&amp;nbsp;</xsl:variable>
	<xsl:variable name="textdirection" select="document($datafile)/siteinfo/data/textdirection"/>
	
	
	<xsl:include href="lib_photo.xsl"/>
	<xsl:include href="lib_guestbook.xsl"/>
	<xsl:include href="lib_newsgroup.xsl"/>
	<xsl:include href="lib_banner.xsl"/>
	<xsl:include href="lib_sitemap.xsl"/>
	<xsl:include href="lib_download.xsl"/>
	<xsl:include href="lib_directory.xsl"/>
	
	<xsl:include href="lib_menu.xsl"/>
	<xsl:include href="lib_margin.xsl"/>
	<xsl:include href="lib_content.xsl"/>
	<xsl:include href="lib_search.xsl"/>
	<xsl:include href="lib_chat.xsl"/>
	<xsl:include href="lib_signuplogin.xsl"/>
	<xsl:include href="lib_membermanager.xsl"/>
	<xsl:include href="lib_knowledgebase.xsl"/>
	<xsl:include href="lib_calendar.xsl"/>
	<xsl:include href="lib_imessages.xsl"/>
	<xsl:include href="lib_classified.xsl"/>
	
	<!-- 
		-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
																					SOME MACROS 
		-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	-->
		
	
	
	<!-- Macro for the left margin -->
	<xsl:template name="leftmargin_macro">
		
		<!-- Login form -->
	     <xsl:choose>
        	  <xsl:when test="$usertype='anonymous'"><xsl:call-template name="loginform"/></xsl:when>
	          <xsl:otherwise>
        	  <xsl:call-template name="wellcome_design"/>
	       	  </xsl:otherwise>
	     </xsl:choose>

		<!-- Show the categories boxes -->	
		<xsl:choose>
			<xsl:when test="siteinfo/data/menubar='on'">				
				<xsl:if test="document($datafile)//pages/page[id=$id]/category!=1">
					<xsl:call-template name="display_category_menubar"><xsl:with-param name="group">off</xsl:with-param><xsl:with-param name="position">left</xsl:with-param></xsl:call-template>
				</xsl:if>				
			</xsl:when>
			<xsl:otherwise>	
				<xsl:if test="(/siteinfo/pages/page[id=$id]/showmenu='on') or ($id='0' or string-length($id)=0) ">
					<xsl:call-template name="display_category"><xsl:with-param name="group">off</xsl:with-param><xsl:with-param name="position">left</xsl:with-param></xsl:call-template>
					<xsl:if test="$usertype!='anonymous'"><xsl:call-template name="display_category"><xsl:with-param name="group">on</xsl:with-param><xsl:with-param name="position">left</xsl:with-param></xsl:call-template></xsl:if>
					<xsl:if test="$usertype='administrator'"><xsl:call-template name="display_category"><xsl:with-param name="group">admin</xsl:with-param><xsl:with-param name="position">left</xsl:with-param></xsl:call-template></xsl:if>		
				</xsl:if>	
			</xsl:otherwise>
		</xsl:choose>	
				
		<!-- Survey -->
		<xsl:call-template name="survey"><xsl:with-param name="position">left</xsl:with-param></xsl:call-template>		
		
		<!-- Searchform -->
		<xsl:if test="/siteinfo/pages/page[id=$id]/showsearch='on'"><xsl:call-template name="searchformmargin_macro"/></xsl:if>
		
		<!-- Members list -->
		<xsl:if test="count(document($sessionfile)//sessions/session[string-length(@username)>0 and  @groupname!='administrator'])&gt;0"><xsl:call-template name="online_members_macro"/></xsl:if>
				
		<!-- Margin -->
		<xsl:call-template name="margin"><xsl:with-param name="position">left</xsl:with-param></xsl:call-template>
		
		<!-- Advertise -->
		<xsl:call-template name="advertisement_left_macro"/>		
	</xsl:template>
	
	
	
	<!-- Macro for the right margin -->
	<xsl:template name="rightmargin_macro">
                
            <!-- Show the categories boxes -->
		<xsl:choose>
			<!-- Case of the menu bar : we show only the menu of the current category-->
			<xsl:when test="siteinfo/data/menubar='on'">
				<xsl:if test="document($datafile)//pages/page[id=$id]/category!=1">				
					<xsl:call-template name="display_category_menubar"><xsl:with-param name="group">off</xsl:with-param><xsl:with-param name="position">right</xsl:with-param></xsl:call-template>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="(/siteinfo/pages/page[id=$id]/showmenu='on') or ($id='0' or string-length($id)=0) ">
					<xsl:call-template name="display_category"><xsl:with-param name="group">off</xsl:with-param><xsl:with-param name="position">right</xsl:with-param></xsl:call-template>
					<xsl:if test="$usertype!='anonymous'"><xsl:call-template name="display_category"><xsl:with-param name="group">on</xsl:with-param><xsl:with-param name="position">right</xsl:with-param></xsl:call-template></xsl:if>
					<xsl:if test="$usertype='administrator'"><xsl:call-template name="display_category"><xsl:with-param name="group">admin</xsl:with-param><xsl:with-param name="position">right</xsl:with-param></xsl:call-template></xsl:if>		
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>	
           
		<!-- Margin -->
		<xsl:call-template name="margin"><xsl:with-param name="position">right</xsl:with-param></xsl:call-template>		
		<!-- Last from forums -->
		<xsl:if test="/siteinfo/pages/page[id=$id]/lastposts!='off'">
			<xsl:call-template name="lastfromforum">
				<xsl:with-param name="number"><xsl:value-of select="/siteinfo/pages/page[id=$id]/lastposts"/></xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<!-- Last articles -->
		<xsl:if test="/siteinfo/pages/page[id=$id]/lastarticles!='off'">
			<xsl:call-template name="lastarticles">
				<xsl:with-param name="number"><xsl:value-of select="/siteinfo/pages/page[id=$id]/lastarticles"/></xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		
		<!-- Comming Events -->
<!--			<xsl:call-template name="commingevents">
				<xsl:with-param name="number"><xsl:value-of select="/siteinfo/pages/page[id=$id]/lastarticles"/></xsl:with-param>
			</xsl:call-template> -->

		<!-- Top Pages -->
		<xsl:if test="/siteinfo/pages/page[id=$id]/toppages='on'"><xsl:call-template name="toppages"/></xsl:if>
		
		<!-- Top downloads -->
		<xsl:if test="/siteinfo/pages/page[id=$id]/topdownloads='on'">
			<xsl:if test="/siteinfo/data/download='on' or (/siteinfo/data/download='member' and $usertype!='anonymous') "><xsl:call-template name="topdownloads"/></xsl:if>
		</xsl:if>		
		
		<!-- Tips of the day -->
		<xsl:if test="/siteinfo/data/tip='on'"><xsl:call-template name="tip"/></xsl:if>	
		
		<!-- Archive bloc -->
		<xsl:choose>
			<xsl:when test="$ACT='5'"><xsl:call-template name="allarchive"/></xsl:when>
			<xsl:otherwise><xsl:call-template name="smallarchive"/></xsl:otherwise>
		</xsl:choose>
		
		<!-- Survey -->
		<xsl:call-template name="survey"><xsl:with-param name="position">right</xsl:with-param></xsl:call-template>
				
		<!-- Advertise -->
		<xsl:call-template name="advertisement_right_macro"/>		
		
	</xsl:template>
	
	
	<!-- MACRO that display all bloc on one margin -->
	<xsl:template name="fullmargin_macro">
		<xsl:call-template name="leftmargin_macro"/>
		<xsl:call-template name="rightmargin_macro"/>
	</xsl:template>
	
	
	<!-- Return a block composed by Logo, title and slogan -->
	<xsl:template name="titlebloc_macro">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr valign="top">
        			<td width="0">
        				<xsl:call-template name="sitelogo_macro"/>
        			</td>
        			<td><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
        			<td width="100%">
        				<xsl:call-template name="sitename_macro"/>
        				<xsl:call-template name="siteslogan_macro"/>
        			</td>        			
			</tr>
		</table>
	</xsl:template>
	
	
	<!-- Return the website logo -->
	<xsl:template name="sitelogo_macro">
		<xsl:if test="string-length(/siteinfo/data/biglogo)&gt;0">
			<a href="default.asp"><img src="{/siteinfo/data/biglogo}" alt="{/siteinfo/data/title}" border="0" align="left"/></a>
		</xsl:if>
	</xsl:template>
	
	
	<!-- Return the website name -->
	<xsl:template name="sitename_macro">
		<xsl:call-template name="sitetile_design">
			<xsl:with-param name="title">
				<xsl:value-of select="/siteinfo/data/name" disable-output-escaping="yes"/>
			</xsl:with-param>
		</xsl:call-template>		
	</xsl:template>
		
	<!-- Return the website slogan -->
	<xsl:template name="siteslogan_macro">
		<xsl:call-template name="siteslogan_design">
			<xsl:with-param name="text">
				<xsl:value-of select="/siteinfo/data/slogan" disable-output-escaping="yes"/>
			</xsl:with-param>
		</xsl:call-template>		
	</xsl:template>
	
	<!-- Display the user name when logged -->
	<xsl:template name="username_macro">
		<xsl:call-template name="siteslogan_design">
			<xsl:with-param name="text">
				.:: <xsl:value-of select="$username"/>
			</xsl:with-param>
		</xsl:call-template>		
	</xsl:template>
	
	
	<!-- Return the advertisement -->
	<xsl:template name="advertisement_macro">		
		<xsl:call-template name="advert"><xsl:with-param name="position">top</xsl:with-param></xsl:call-template>
	</xsl:template>
	
	<xsl:template name="advertisement_bottom_macro">		
		<xsl:call-template name="advert"><xsl:with-param name="position">bottom</xsl:with-param></xsl:call-template>
	</xsl:template>
	
	<xsl:template name="advertisement_left_macro">		
		<xsl:call-template name="advert"><xsl:with-param name="position">left</xsl:with-param></xsl:call-template>
	</xsl:template>
	
	<xsl:template name="advertisement_right_macro">		
		<xsl:call-template name="advert"><xsl:with-param name="position">right</xsl:with-param></xsl:call-template>
	</xsl:template>
	
	
	<!-- Return the copyright -->
	<xsl:template name="copyright_macro">
		<xsl:value-of select="/siteinfo/data/footer" disable-output-escaping="yes"/>
		<!-- Advertise -->
		<br/><xsl:call-template name="advertisement_bottom_macro"/>
	</xsl:template>
	
	
	<!-- Return a link of webmaster e-mail -->
	<xsl:template name="email_macro">
		<a href="mailto:{siteinfo/data/email}"><xsl:value-of select="/siteinfo/data/email"/></a>
	</xsl:template>
	
	<!-- -->
	<xsl:template name="searchform_macro">
		<xsl:call-template name="searchform"/>
	</xsl:template>
	
	
	<xsl:template name="searchformmargin_macro">
		<xsl:call-template name="searchformmargin"/>
	</xsl:template>
	
	<!-- la toolbar : liens vers add-on, boite de recherche, inscription et administration -->
	<xsl:template name="toolbar_body_macro">
		
		<xsl:if test="/siteinfo/pages/page[id=$id]/showtoolbar='on' or string-length(/siteinfo/pages/page[id=$id]/showtoolbar)=0 ">			
			
			<!-- guestbook -->
			<xsl:if test="/siteinfo/data/showguestbook='on' and /siteinfo/data/guestbooktoolbar='on'">
				<xsl:call-template name="toolbar_item_design"><xsl:with-param name="content"><a class="toolbar" href="default.asp?id=0&amp;ACT=7"><xsl:value-of select="$string[242]"/></a></xsl:with-param></xsl:call-template>
			</xsl:if>
			
			<!-- gallery -->
			<xsl:if test="/siteinfo/data/photo='on' and /siteinfo/data/phototoolbar='on'">
				<xsl:call-template name="toolbar_item_design"><xsl:with-param name="content"><a class="toolbar" href="default.asp?id=0&amp;ACT=2&amp;pic=0"><xsl:value-of select="$string[243]"/></a></xsl:with-param></xsl:call-template>
			</xsl:if>
			
			<!-- newsgroup -->
			<xsl:if test="/siteinfo/data/discussion='on' and /siteinfo/data/discussiontoolbar='on'">
				<xsl:call-template name="toolbar_item_design"><xsl:with-param name="content"><a class="toolbar" href="default.asp?id=0&amp;ACT=14"><xsl:value-of select="$string[244]"/></a></xsl:with-param></xsl:call-template>
			</xsl:if>
			
			<!-- download -->
			<xsl:if test="(/siteinfo/data/download='on' and /siteinfo/data/downloadtoolbar='on') or (/siteinfo/data/download='member' and $usertype!='anonymous' and /siteinfo/data/downloadtoolbar='on') ">
				<xsl:call-template name="toolbar_item_design"><xsl:with-param name="content"><a class="toolbar" href="default.asp?id=0&amp;ACT=19"><xsl:value-of select="$string[350]"/></a></xsl:with-param></xsl:call-template>
			</xsl:if>
			
			<!-- event calendar -->			
			<xsl:if test="(/siteinfo/data/eventcalendar='on' and /siteinfo/data/eventcalendartoolbar='on') or (/siteinfo/data/eventcalendar='member' and $usertype!='anonymous' and /siteinfo/data/eventcalendartoolbar='on') ">
				<xsl:call-template name="toolbar_item_design">
					<xsl:with-param name="content">
						<a class="toolbar" href="default.asp?id=0&amp;ACT=91"><xsl:value-of select="$string[734]"/></a>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<!-- knowledge Base -->
			<xsl:if test="/siteinfo/data/knowbase='on' and /siteinfo/data/knowbasetoolbar='on'">
				<xsl:call-template name="toolbar_item_design"><xsl:with-param name="content"><a class="toolbar" href="default.asp?ACT=90&amp;id=0&amp;kbid=0"><xsl:value-of select="$string[621]"/></a></xsl:with-param></xsl:call-template>
			</xsl:if>

			<!-- Member manager -->
			<xsl:if test="(/siteinfo/data/membermanager='anonymous' and /siteinfo/data/membermanagertoolbar='on') or (/siteinfo/data/membermanager='member' and $usertype!='anonymous' and /siteinfo/data/membermanagertoolbar='on') ">
				<xsl:call-template name="toolbar_item_design"><xsl:with-param name="content"><a class="toolbar" href="default.asp?ACT=80&amp;id=0"><xsl:value-of select="$string[$mmbasestring + 33]"/></a></xsl:with-param></xsl:call-template>
			</xsl:if>

			<!-- Classified -->
			<xsl:if test="/siteinfo/data/classified='on' and /siteinfo/data/classifiedtoolbar='on'">
			  <xsl:call-template name="toolbar_item_design"><xsl:with-param name="content"><a class="toolbar" href="default.asp?ACT=70&amp;id=0"><xsl:value-of select="$string[$classbasestring + 0]"/></a></xsl:with-param></xsl:call-template>
			</xsl:if>
			
			<!-- Chat -->
			<xsl:if test="$usertype!='anonymous' and /siteinfo/data/chat='on' and /siteinfo/data/chattoolbar='on'">
				<xsl:call-template name="toolbar_item_design">
					<xsl:with-param name="content">
						<a class="toolbar" href="default.asp?ACT=92"><xsl:value-of select="$string[776]"/></a>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<!-- sitemap -->
			<xsl:if test="/siteinfo/data/sitemap='on' and /siteinfo/data/sitemaptoolbar='on'">
				<xsl:call-template name="toolbar_item_design"><xsl:with-param name="content"><a class="toolbar" href="default.asp?id=0&amp;ACT=18"><xsl:value-of select="$string[370]"/></a></xsl:with-param></xsl:call-template>
			</xsl:if>
					
			<!-- visitors -->
			<xsl:call-template name="toolbar_lastitem_design">
				<xsl:with-param name="content">
					<xsl:value-of select="$visitors"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/> 
					<xsl:choose>
						<xsl:when test="$visitors=1"> <xsl:value-of select="$string[226]"/> </xsl:when> 
						<xsl:otherwise> <xsl:value-of select="$string[227]"/></xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	
	
	<!-- Return the title of the content -->
	<xsl:template name="pagetitle_macro">
		<xsl:choose>
		
			<!-- Page article for article list -->
			<xsl:when test="$ACT='0'">
				<xsl:call-template name="content_title"/>
			</xsl:when>			
			
			<!-- Page article for the gallery -->
			<xsl:when test="$ACT='2'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[243]"/>
						<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M7"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			
			<!-- Recherche -->
			<xsl:when test="$ACT='4'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[371]"/> : <xsl:value-of select="$keyword"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			
			<!-- Detail d'un article -->
			<xsl:when test="$ACT='5'">
				<xsl:call-template name="content_title"/>
			</xsl:when>
			
			<!-- Livre d'or -->
			<xsl:when test="$ACT='7' or $ACT='8'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[242]"/><xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M9"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			
			<!-- Signup form -->
			<xsl:when test="$ACT='9'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[300]"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			
			<!-- Signup validation --> 
			<xsl:when test="$ACT='10'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[300]"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			
			<xsl:when test="$ACT='12'">
				
			</xsl:when>
			
			<xsl:when test="$ACT='13'">
				
			</xsl:when>
			
			<!-- Discussion List -->
			<xsl:when test="$ACT='14'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[244]"/><xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M12&amp;id="><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			
			<!-- détail discussion -->
			<xsl:when test="$ACT='15'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="document($datafile)//siteinfo/data/title"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[244]"/>
						<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M12&amp;id={$id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>					
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			
			<!-- formulaire nouveau message -->
			<xsl:when test="$ACT='16'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<!--<xsl:value-of select="document($discussionfile)//discussions/discussion[id=$newsgroupID]/title"/>-->
						<xsl:value-of select="document($datafile)//siteinfo/data/title"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[244]"/>
						<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M12&amp;id={$id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>	
			
			<!-- Detail d'un message -->
			<xsl:when test="$ACT='17'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<!--<xsl:value-of select="document($discussionfile)//discussions/discussion[id=$newsgroupID]/title"/>-->
						<xsl:value-of select="document($datafile)//siteinfo/data/title"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[244]"/>
						<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M12&amp;id={$id}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>			
			
			
			<!-- site map -->
			<xsl:when test="$ACT='18'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[370]"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			
			<!-- downloads -->
			<xsl:when test="$ACT='19'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[350]"/>
						<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M20"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>		
	
			
			<!-- lost Password form -->
			<xsl:when test="$ACT='20'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[461]"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			
			<!-- lost Password send -->
			<xsl:when test="$ACT='21'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[461]"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			
			<!-- my account -->
			<xsl:when test="$ACT='22'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[474]"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			
			<xsl:when test="$ACT='23'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[474]"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			
			<!-- Directory title-->
			<xsl:when test="$ACT='24'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="document($directoryfile)//directories/directory[@id=$dir]/@name"/>
							<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M22"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
						</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<!-- Send message to -->
			<xsl:when test="$ACT='25'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[555]"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="document($memberfile)//members/member[id=$member]/pseudo"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<!-- Classified Adds -->
			<xsl:when test="$ACT='70'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[$classbasestring + 2]"/>
						<xsl:if test="$usertype='administrator'">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
							<a href="default.asp?ACT=1&amp;SECT=M70">
								<img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/>
							</a>
						</xsl:if>
						<xsl:if test="$cat &gt; 0">
										<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>-<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="document($classifiedfile)//cat[id=$cat]/name"/>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<!-- Member manager -->
			<xsl:when test="$ACT='80'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[$mmbasestring + 0]"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<!-- Member Profile -->
			<xsl:when test="$ACT='81'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						 <xsl:value-of select="$string[$mmbasestring + 24]"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<!-- Friends -->
			<xsl:when test="$ACT='82'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[$mmbasestring + 34]"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<!-- Send internal message to -->
			<xsl:when test="$ACT='83'">
				<xsl:choose>
					<xsl:when test="$item='new'">			
						<xsl:call-template name="pagetitle_design">
							<xsl:with-param name="title">
								            <xsl:value-of select="$string[$intmessages_basestring + 9]" /><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="document($memberfile)//members/member[id=$member]/pseudo"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="pagetitle_design">
							<xsl:with-param name="title">
								            <xsl:value-of select="$string[$intmessages_basestring + 0]" />
							</xsl:with-param>
						</xsl:call-template>

					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
	
			<!-- Knowledge Base -->
			<xsl:when test="$ACT='90'">
				<xsl:choose>
				<xsl:when test="$kbid='0'or $kbid=''">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[$kb_basestring + 0]"/>
							<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M90"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				</xsl:when>
				<xsl:when test="$kbid='9999999999'">
			 	<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[$kb_basestring + 42]"/>
					</xsl:with-param>
				</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="document($kbfile)/kb/knowbase[id=$kbid]/title" />
							<xsl:if test="$usertype='administrator'"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?ACT=1&amp;SECT=M90&amp;type=knowbase&amp;id={$kbid}"><img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/></a></xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				</xsl:otherwise>
				</xsl:choose>
			</xsl:when>

			<!-- Event calendar -->
			<xsl:when test="$ACT='91'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:choose>
							<xsl:when test="$calendar">
								<xsl:value-of select="document($calendarfile)/eventcalendar/calendar[id=$calendar]/calname"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$string[735]"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:if test="$usertype='administrator'">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
							<a href="default.asp?ACT=1&amp;SECT=M91">
								<img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/>
							</a>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<!-- Chat -->
			<xsl:when test="$ACT='92'">
				<xsl:call-template name="pagetitle_design">
					<xsl:with-param name="title">
						<xsl:value-of select="$string[776]"/>
						<xsl:if test="$usertype='administrator'">
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
							<a href="default.asp?ACT=1&amp;SECT=M92">
								<img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit"/>
							</a>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<xsl:otherwise>
				<xsl:call-template name="content_title"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<!-- Return the body of the content -->
	<xsl:template name="pagebody_macro">
	<!-- enables htmlarea into textareas (only available for IE)-->
		<xsl:choose>
			<xsl:when test="$browsername='IE' and $oldeditor!='on'">	
				<script language="JavaScript" src="admin/FXhtmlarea/editor.js"/>
				<script language="javascript1.2">
					var config = new Object();
					config.width = "100%";
					config.height = "200";
					config.bodyStyle = 'background-color: white;font-family:Arial;font-size:x-small;';
					var _editor_url = 'admin/FXhtmlarea/';
					config.toolbar =[
						<xsl:for-each select="siteinfo/editorsettings/setting[group=$usertype]">
							<xsl:value-of select="config"/>
						</xsl:for-each>							
							];
				</script>
			</xsl:when>
			<xsl:otherwise>
				<script language="Javascript1.2">function editor_generate() { return false;}</script>
			</xsl:otherwise>
		</xsl:choose>

	
		<!-- Error message, if needed -->
		<xsl:call-template name="usermessage_macro"/>
	
		<!-- Diplay the body -->
		<xsl:choose>
			<xsl:when test="$ACT='0'">
				<xsl:call-template name="content_body"/>
			</xsl:when>
			<xsl:when test="$ACT='2'">
				<xsl:call-template name="photo"/>
			</xsl:when>
			<xsl:when test="$ACT='4'">
				<xsl:call-template name="search"/>
			</xsl:when>
			<xsl:when test="$ACT='5'">
				<xsl:call-template name="article"/>
			</xsl:when>
			<xsl:when test="$ACT='7' or $ACT='8'">
				<xsl:call-template name="guestbook"/>
			</xsl:when>
			<xsl:when test="$ACT='9'">
				<xsl:call-template name="signup"/>
			</xsl:when>
			<xsl:when test="$ACT='10'">
				<xsl:call-template name="signupthx"/>
			</xsl:when>
			<xsl:when test="$ACT='12'">
				<xsl:call-template name="react"/>
			</xsl:when>
			<xsl:when test="$ACT='13'">
				<xsl:call-template name="reactthx"/>
			</xsl:when>
			<xsl:when test="$ACT='14'">
				<xsl:call-template name="liste_discussions"/>
			</xsl:when>
			<xsl:when test="$ACT='15'">
				<xsl:call-template name="Thread.List"/>
			</xsl:when>
			<xsl:when test="$ACT='16'">
				<xsl:call-template name="new_message"/>
			</xsl:when>	
			<xsl:when test="$ACT='17'">
				<xsl:call-template name="detail_message"/>
			</xsl:when>	
			<xsl:when test="$ACT='18'">
				<xsl:call-template name="sitemap"/>
			</xsl:when>
			<xsl:when test="$ACT='19'">
				<xsl:call-template name="download"/>
			</xsl:when>		
			<xsl:when test="$ACT='20'">
				<xsl:call-template name="forgotpassword"/>
			</xsl:when>
			<xsl:when test="$ACT='21'">
				<xsl:call-template name="forgotpasswordsend"/>
			</xsl:when>
			<xsl:when test="$ACT='22'">
				<xsl:call-template name="myaccountform"/>
			</xsl:when>
			<xsl:when test="$ACT='23'">
				<xsl:call-template name="myaccountthx"/>
			</xsl:when>
			<xsl:when test="$ACT='24'">
				<xsl:call-template name="directory"/>
			</xsl:when>
			<xsl:when test="$ACT='25'">
				<xsl:call-template name="sendmailForm"/>
			</xsl:when>
			<xsl:when test="$ACT='70'">
				<xsl:call-template name="classified_manager"/>
			</xsl:when>
			<xsl:when test="$ACT='80'">
				<xsl:call-template name="member_manager"/>
			</xsl:when>
			<xsl:when test="$ACT='81'">
				<xsl:call-template name="member_profile_acess"/>
			</xsl:when>
			<xsl:when test="$ACT='82'">
				<xsl:call-template name="friends_manager"/>
			</xsl:when>
			<xsl:when test="$ACT='83'">
				<xsl:call-template name="internalmessages_manager"/>
			</xsl:when>
			<xsl:when test="$ACT='90'">
				<xsl:call-template name="knowledgebase"/>
			</xsl:when>
			<xsl:when test="$ACT='91'">
				<xsl:call-template name="eventcalendar"/>
			</xsl:when>
			<xsl:when test="$ACT='92' or $ACT='93'">
				<xsl:call-template name="chat_manager"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="content_body"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="usermessage_macro">
		<xsl:if test="string-length($usermessage)&gt;0"><script>alert('<xsl:value-of select="$string[number(390+number($usermessage))]"/>');</script></xsl:if>
		<xsl:if test="string-length($goback)&gt;0"><script>history.go(-1);</script></xsl:if>
	</xsl:template>
		
			
		
	<!-- 
		Call the msxsl function that send email
		used on : newsgroup, forgot password, guestbook
	-->
	<xsl:template name="Mailer">
		<xsl:param name="ToEmail"/>
		<xsl:param name="FromEmail"/>
		<xsl:param name="Subject"/>
		<xsl:param name="Message"/>
		
		<xsl:value-of select="vb:Mailer(string(/siteinfo/data/emailCOM), $ToEmail, $FromEmail, $Subject, $Message, string(/siteinfo/data/smtpserver))"/>
	</xsl:template>
		

<!-- decode a param to print it as html -->
<xsl:template name="decode">
	<xsl:param name="text"/>	
	<xsl:call-template name="replaceapose"><xsl:with-param name="where"><xsl:call-template name="replacelower"><xsl:with-param name="where"><xsl:call-template name="replacegreater"><xsl:with-param name="where" select="$text"/></xsl:call-template></xsl:with-param></xsl:call-template></xsl:with-param></xsl:call-template>
</xsl:template>


<xsl:template name="replaceapose">
	
	<xsl:param name="where"/>	   
	<xsl:variable name="old"><xsl:text>&amp;apos;</xsl:text></xsl:variable>
	<xsl:variable name="new"><xsl:text>&apos;</xsl:text></xsl:variable>
	    
	    <xsl:choose>
	        <xsl:when test="contains($where,$old) != 0">
	            <xsl:value-of select="substring-before($where, $old)" />
	            <!-- The delimiter will be replaced by the following... -->
	            <xsl:value-of select="$new"/>
	            <xsl:call-template name="replaceapose">
	            <xsl:with-param name="where" select="substring-after($where, $old)" />
	            </xsl:call-template>
	        </xsl:when>
	        <xsl:otherwise>
	            <xsl:value-of select="$where" />
	        </xsl:otherwise>
	    </xsl:choose>	
	    
</xsl:template>


<!-- replace &gt; by >-->		
<xsl:template name="replacegreater">
    <xsl:param name="where"/>
    <xsl:variable name="old"><xsl:text>&amp;gt;</xsl:text></xsl:variable>
    <xsl:variable name="new"><xsl:text>&gt;</xsl:text></xsl:variable>
    
    <xsl:choose>
        <xsl:when test="contains($where,$old) != 0">
            <xsl:value-of select="substring-before($where, $old)" />
            <!-- The delimiter will be replaced by the following... -->
            <xsl:value-of select="$new"/>
            <xsl:call-template name="replacegreater">
            <xsl:with-param name="where" select="substring-after($where, $old)" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$where" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template name="replacelower">
    <xsl:param name="where"/>
    <xsl:variable name="old"><xsl:text>&amp;lt;</xsl:text></xsl:variable>
    <xsl:variable name="new"><xsl:text>&lt;</xsl:text></xsl:variable>
    
    <xsl:choose>
        <xsl:when test="contains($where,$old) != 0">
            <xsl:value-of select="substring-before($where, $old)" />
            <!-- The delimiter will be replaced by the following... -->
            <xsl:value-of select="$new"/>
            <xsl:call-template name="replacelower">
            <xsl:with-param name="where" select="substring-after($where, $old)" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$where" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>



		
<!-- replace <br> by a cr lf-->		
<xsl:template name="insertlinebreaks">
    <xsl:param name="where"/>
    <xsl:variable name="br"><xsl:text>&lt;br&gt;</xsl:text></xsl:variable>
    <!-- The delimiter is a single new-line... -->
    <xsl:variable name="delimiter">
   <xsl:text>   
</xsl:text>
    </xsl:variable>
    
    <xsl:choose>
        <xsl:when test="contains($where,$br) != 0">
            <xsl:value-of select="substring-before($where, $br)" />
            <!-- The delimiter will be replaced by the following... -->
            <xsl:value-of select="$delimiter"/>
            <xsl:call-template name="insertlinebreaks">
            <xsl:with-param name="where" select="substring-after($where, $br)" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$where" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>



<xsl:template name="insertlinebreaks2">
    <xsl:param name="where"/>
    <xsl:variable name="br"><xsl:text>&amp;lt;br&amp;gt;</xsl:text></xsl:variable>
    <!-- The delimiter is a single new-line... -->
    <xsl:variable name="delimiter" >
   <xsl:text>
</xsl:text>
    </xsl:variable>
    
    <xsl:choose>
        <xsl:when test="contains($where,$br) != 0">
            <xsl:value-of select="substring-before($where, $br)" />
            <!-- The delimiter will be replaced by the following... -->
            <xsl:value-of select="$delimiter"/>
            <xsl:call-template name="insertlinebreaks">
            <xsl:with-param name="where" select="substring-after($where, $br)" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$where" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- replace cr lf by a <br> -->
<xsl:template name="insertbr">
  <xsl:param name="where"/>
  <xsl:variable name="delimiter" >
    <!-- The delimiter is a single new-line... -->
    <xsl:text>
</xsl:text>
  </xsl:variable>
  
  <xsl:choose>
  <xsl:when test="contains($where,$delimiter) != 0">
    <xsl:value-of select="substring-before($where, $delimiter)" />
    <!-- The delimiter will be replaced by the following... -->
    <br />
    <xsl:call-template name="insertbr">
      <xsl:with-param name="where" select="substring-after($where, $delimiter)" />
    </xsl:call-template>
  </xsl:when>
  <xsl:otherwise>
    <xsl:value-of select="$where" />
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!-- calcul the menubar -->		
<xsl:template name="menubar_macro">		
		<xsl:if test="siteinfo/data/menubar='on'">
		<SCRIPT language="JavaScript" type="text/javascript">
			<![CDATA[
						
			//The following line is critical for menu operation, and MUST APPEAR ONLY ONCE. If you have more than one menu_array.js file rem out this line in subsequent files
			menunum=0;
			menus=new Array();
			_d=document;
			function addmenu()
			{
				menunum++;
				menus[menunum]=menu;
			}
			
			function dumpmenus()
			{
				mt="<script language=javascript>";
				for(a=1;a<menus.length;a++)
				{
					mt+=" menu"+a+"=menus["+a+"];"
				}
				mt+="<\/script>";
				_d.write(mt)
			}
									
			////////////////////////////////////
			// Editable properties START here //
			////////////////////////////////////
			
			// Special effect string for IE5.5 or above please visit http://www.milonic.co.uk/menu/filters_sample.php for more filters
			if(navigator.appVersion.indexOf("MSIE 6.0")>0)
			{
				effect = "Fade(duration=0.2);Alpha(style=0,opacity=88);Shadow(color='#777777', Direction=135, Strength=5)"
			}
			else
			{
				effect = "Shadow(color='#777777', Direction=135, Strength=5)" // Stop IE5.5 bug when using more than one filter
			}
			
			effect2 = "randomdissolve(duration=0.5);Shadow(color='#999999', Direction=135, Strength=5)";
			
			]]>
			<xsl:call-template name="menubar_design"/> <!-- block of js has been moved to the skin.xsl file -->
			,"<xsl:value-of select="$string[480]"/>","default.asp",,"<xsl:value-of select="$string[481]"/>",1
			<!-- on crée les entrées menus -->
			<xsl:for-each select="document($categoryfile)//categories/category[visible!='off' and id!=0 and member='off']">
				,"<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="name"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>","show-menu=<xsl:value-of select="name"/>",,"",1
			</xsl:for-each>
			
			<xsl:if test="$usertype != 'anonymous'">
				<xsl:for-each select="document($categoryfile)//categories/category[visible!='off' and id!=0 and member='on']">
					,"<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="name"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>","show-menu=<xsl:value-of select="name"/>",,"",1
				</xsl:for-each>
			</xsl:if>
			<xsl:if test="$usertype = 'administrator'">
				<xsl:for-each select="document($categoryfile)//categories/category[visible!='off' and id!=0 and member='admin']">
					,"<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="name"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>","show-menu=<xsl:value-of select="name"/>",,"",1
				</xsl:for-each>
			</xsl:if>			
			])
			
			<!-- on crée les sous menu -->			
			<xsl:for-each select="document($categoryfile)//categories/category[visible!='off' and id!=0 and member!='any']">
				<xsl:variable name="catid" select="id"/>
			addmenu(menu=["<xsl:value-of select="name"/>",
				,,120,1,"",style1,,"left",effect,,,,,,,,,,,,
				<xsl:for-each select="document($datafile)//pages/page[visible!='off' and category=$catid]">
					<xsl:choose>
						<xsl:when test="externaltype='top'  and string-length(externallink)!=0">
							,"<xsl:value-of select="name"/>","<xsl:value-of select="externallink"/>",,"<xsl:value-of select="name"/>",0
						</xsl:when>
						<xsl:when test="externaltype='blank'  and string-length(externallink)!=0">
							,"<xsl:value-of select="name"/>","<xsl:value-of select="externallink"/>","blank","<xsl:value-of select="name"/>",0
						</xsl:when>
						<xsl:otherwise>
							,"<xsl:value-of select="name"/>","default.asp?id=<xsl:value-of select="id"/>&amp;mnu=<xsl:value-of select="id"/>","","<xsl:value-of select="name"/>",0
						</xsl:otherwise>
					</xsl:choose>
				
				</xsl:for-each>
			])
			</xsl:for-each>
			

			<![CDATA[
			dumpmenus();
			]]>
		</SCRIPT>
		<SCRIPT language="JavaScript" src="skins/common/mmenu.js" type="text/javascript"></SCRIPT>
		<table border="0"><tr height="20"><td><xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td></tr></table>
		</xsl:if>
	</xsl:template>
		
		
	<!-- MACROS FOR PAGING  -->
	
	<!-- Display of a rail of page navigation : next/prev and the list of page number-->
	<xsl:template name="paging_Rail_macro">
		<xsl:param name="totalpage"/>
		<xsl:param name="currentpage"/>
		<xsl:param name="url"/>
		
			<xsl:value-of select="$string[544]"/>:<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
			
			<xsl:if test="$currentpage!=1"><a href="{$url}&amp;page={$currentpage - 2}"><b><xsl:value-of select="$string[545]"/></b></a></xsl:if><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				<xsl:call-template name="paging_numberlink_macro">
					<xsl:with-param name="number" select="1"/>
					<xsl:with-param name="max" select="$totalpage"/>
					<xsl:with-param name="url" select="$url"/>
				</xsl:call-template>
			<xsl:if test="$currentpage &lt; $totalpage"><a href="{$url}&amp;page={$currentpage}"><b><xsl:value-of select="$string[546]"/></b></a></xsl:if>
		
	</xsl:template>		
		
		
	<!-- Display the list of page number link :: recursive -->
	<xsl:template name="paging_numberlink_macro">
		<xsl:param name="number"/>
		<xsl:param name="max"/>
		<xsl:param name="url"/>
				
		<xsl:choose>
			<xsl:when test="$number - 1 = $page "><font color="red"><xsl:value-of select="$number"/></font></xsl:when>
			<xsl:otherwise><a href="{$url}&amp;page={$number - 1}"><b><xsl:value-of select="$number"/></b></a></xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
		
		<xsl:if test="$number &lt; $max">
			<xsl:call-template name="paging_numberlink_macro">
				<xsl:with-param name="number" select="$number + 1"/>
				<xsl:with-param name="max" select="$max"/>
				<xsl:with-param name="url" select="$url"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
		
		
	<!-- Display a formated Date :: @todo add local settings for different date format -->
	<!--<xsl:template name="showdate">
		<xsl:param name="p_Date"/>
		<xsl:value-of select="substring($p_Date, 7, 2)"/>.<xsl:value-of select="substring($p_Date, 5, 2)"/>.<xsl:value-of select="substring($p_Date, 1, 4)"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="substring($p_Date, 9, 2)"/>:<xsl:value-of select="substring($p_Date, 11, 2)"/>
	</xsl:template>-->

	<xsl:template name="display_datetime">
	       <xsl:param name="p_DateTime"/>
               <xsl:call-template name="display_date"><xsl:with-param name="p_Date"><xsl:value-of select="substring($p_DateTime, 1, 8)"/></xsl:with-param></xsl:call-template>
               <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
               <xsl:call-template name="display_time"><xsl:with-param name="p_Time"><xsl:value-of select="substring($p_DateTime, 9, 4)"/></xsl:with-param></xsl:call-template>
	</xsl:template>
	
	<xsl:template name="display_date">
               <xsl:param name="p_Date"/>
               <xsl:variable name="DateFormat" select="$DataFilePointer//siteinfo/data/dateformat"/>
               <xsl:variable name="DateSeparator" select="$DataFilePointer//siteinfo/data/dateseparator"/>
               <xsl:variable name="monthstring">1049</xsl:variable>
               <xsl:choose>
                           <xsl:when test="$DateFormat='dd.mm.yy'">
                                     <xsl:value-of select="substring($p_Date, 7, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 5, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 3, 2)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='dd.mmm.yy'">
                                     <xsl:value-of select="substring($p_Date, 7, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="$string[number($monthstring+substring($p_Date, 5, 2))]"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 3, 2)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='dd.mm.yyyy'">
                                     <xsl:value-of select="substring($p_Date, 7, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 5, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 1, 4)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='dd.mmm.yyyy'">
                                     <xsl:value-of select="substring($p_Date, 7, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="$string[number($monthstring+substring($p_Date, 5, 2))]"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 1, 4)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='mmm.yy'">
                                     <xsl:value-of select="$string[number($monthstring+substring($p_Date, 5, 2))]"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 3, 2)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='mmm.yyyy'">
                                     <xsl:value-of select="$string[number($monthstring+substring($p_Date, 5, 2))]"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 1, 4)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='mm.dd.yy'">
                                     <xsl:value-of select="substring($p_Date, 5, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 7, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 3, 2)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='mmm.dd.yy'">
                                     <xsl:value-of select="$string[number($monthstring+substring($p_Date, 5, 2))]"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 7, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 3, 2)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='mm.dd.yyyy'">
                                     <xsl:value-of select="substring($p_Date, 5, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 7, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 1, 4)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='mmm.dd.yyyy'">
                                     <xsl:value-of select="$string[number($monthstring+substring($p_Date, 5, 2))]"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 7, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 1, 4)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='yy.mm.dd'">
                                     <xsl:value-of select="substring($p_Date, 3, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 5, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 7, 2)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='yy.mmm.dd'">
                                     <xsl:value-of select="substring($p_Date, 3, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="$string[number($monthstring+substring($p_Date, 5, 2))]"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 7, 2)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='yyyy.mm.dd'">
                                     <xsl:value-of select="substring($p_Date, 1, 4)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 5, 2)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 7, 2)"/>
                           </xsl:when>
                           <xsl:when test="$DateFormat='yyyy.mmm.dd'">
                                     <xsl:value-of select="substring($p_Date, 1, 4)"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="$string[number($monthstring+substring($p_Date, 5, 2))]"/><xsl:value-of select="$DateSeparator"/><xsl:value-of select="substring($p_Date, 7, 2)"/>
                           </xsl:when>
                           <xsl:otherwise>
                                     <xsl:value-of select="substring($p_Date, 7, 2)"/>.<xsl:value-of select="substring($p_Date, 5, 2)"/>.<xsl:value-of select="substring($p_Date, 1, 4)"/>
                           </xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	<xsl:template name="display_time">
		<xsl:param name="p_Time"/>
		<xsl:value-of select="substring($p_Time, 1, 2)"/>:<xsl:value-of select="substring($p_Time, 3, 2)"/>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!-- FxMods - Recently inserted templates -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->


	<!-- Allow us to redirect to desired URL if something happens -->
	<xsl:template name="redirect">
	<xsl:param name="url" />
		<SCRIPT type="text/javascript">
			<!-- Don't change next line. It must be all in one line or error will be generated!-->
			document.location.href=("<xsl:value-of select='$url' />")
			<!-- Don't change previous line. It must be all in one line or error will be generated!-->
		</SCRIPT>
	</xsl:template>




	<!-- Depending on available features and user settings defines link to users -->
	<xsl:template name="call_user">

	<!-- Next params tell us if features are available -->
	<xsl:param name="email_object" select="$DataFilePointer//siteinfo/data/emailCOM"/>
	<xsl:param name="int_messages" select="$DataFilePointer//siteinfo/data/useinternalmessages"/>
	<!-- Users related params values -->
	<xsl:param name="RefPseudo"/>
	<!-- if one pseudo is passed we get user id -->
	<xsl:param name="RefPseudoId" select="document($memberfile)//members/member[pseudo=$RefPseudo]/id"/>
	<xsl:param name="RefId"/>
	<!-- if one id is passed we get user pseudo -->
	<xsl:param name="RefIdPseudo" select="document($memberfile)//members/member[id=$RefId]/pseudo"/>
	<!-- Users absolute params values-->
	<xsl:param name="id" select="document($memberfile)//members/member[(pseudo=$RefPseudo or pseudo=$RefIdPseudo)]/id" />
	<xsl:param name="pseudo" select="document($memberfile)//members/member[(id=$RefPseudoId or id=$RefId)]/pseudo" />
	
		<xsl:choose>
			<xsl:when test="$email_object!='off' and $int_messages!='off'">
				<xsl:choose>
					<xsl:when test="document($memberfile)//members/member[pseudo=$pseudo and userpublic='on']">
						<a href="default.asp?ACT=81&amp;member={$id}&amp;id=0"><xsl:value-of select="$pseudo"/></a>
					</xsl:when>
					<xsl:when test="document($memberfile)//members/member[pseudo=$pseudo and userpublic='off']">
						<a href="default.asp?ACT=25&amp;member={$id}&amp;id=0"><xsl:value-of select="$pseudo"/></a>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$pseudo"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$email_object='off' and $int_messages!='off'">
				<xsl:choose>
					<xsl:when test="document($memberfile)//members/member[pseudo=$pseudo and userpublic='on']">
						<a href="default.asp?ACT=81&amp;member={$id}&amp;id=0"><xsl:value-of select="$pseudo"/></a>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$pseudo"/>
					</xsl:otherwise>							
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$email_object!='off' and $int_messages='off'">
				<xsl:choose>
					<xsl:when test="document($memberfile)//members/member[pseudo=$pseudo and userpublic='on']">
						<a href="default.asp?ACT=25&amp;member={$id}&amp;id=0"><xsl:value-of select="$pseudo"/></a>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$pseudo"/>
					</xsl:otherwise>							
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$pseudo"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

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
				<xsl:if test="string-length('$selectvalue') &gt; 0">
					<xsl:if test="string-length($initval) = 0">
						<option value="" selected="selected">
							<xsl:value-of select="$string[$mmbasestring + 17]"/>
						</option>
					</xsl:if>
				</xsl:if>

				<xsl:for-each select="document($listfile)//lists/list[name=$list]/entries/entry">
					<xsl:sort select="*[name()=$sortfield]" data-type="{$datatype}" order="{$sortorder}"/>
					<option value="{value}">
						<xsl:choose>
							<xsl:when test="string-length('selectvalue') &gt; 0">
								<xsl:if test="$selectvalue = value">
									<xsl:attribute name="selected">selected</xsl:attribute>								
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="$initval = value">
									<xsl:attribute name="selected">selected</xsl:attribute>								
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:value-of select="caption"/>
					</option>						
				</xsl:for-each>
			</select>
		</xsl:if>
	</xsl:template>
	
</xsl:stylesheet>

