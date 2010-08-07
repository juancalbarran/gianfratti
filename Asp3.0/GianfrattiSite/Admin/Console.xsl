<?xml version="1.0" encoding="ISO-8859-1" ?> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	
	<xsl:output method="xml"/>
		
	<!-- This variable contains the section du edit -->
	<xsl:param name="SECT"/>
	<xsl:variable name="section" select="$SECT"/>
	

	<!-- Global variables used by the templates -->
	<xsl:param name="usertype"/>
	<xsl:param name="username"/>
	<xsl:param name="actualdate"/>
	<xsl:param name="now"/>
	<xsl:param name="version"/>
	<xsl:param name="mappath"/>
	<xsl:param name="logdata"/>
	<xsl:param name="skinsnode"/>
	<xsl:param name="uploadfilenode"/>
	<xsl:param name="browsername"/>
	
	<!-- Querystrings-->
	<xsl:param name="id"/>
	<xsl:param name="page" select="0"/>
	<xsl:param name="dir"/>
	<xsl:param name="cat"/>
	<xsl:param name="subcat"/>
	<xsl:param name="set"/>
	<xsl:param name="mnu"/>
	<xsl:param name="type"/>
	<xsl:param name="ACT"/>
	<xsl:param name="content"/>
	<xsl:param name="keyword"/>
	<xsl:param name="pic"/>
	<xsl:param name="vp"/>
	<xsl:param name="d"/>
	<xsl:param name="m"/>
	<xsl:param name="y"/>
	<xsl:param name="cmd"/>
	<xsl:param name="kbid"/>
	<xsl:param name="refid"/>
	<xsl:param name="listid"/>
	<xsl:param name="entry"/>
	<xsl:param name="message"/>
	<xsl:param name="subject"/>
	<xsl:param name="channel"/>
	<xsl:param name="sort"/>
	<xsl:param name="calendar"/>
	<xsl:param name="add"/>
	<xsl:param name="user"/>
	
	<!-- paging :-) -->
	<xsl:param name="stat_pagesize" select="400"/>
	<xsl:param name="forum_pagesize" select="100"/>
	<xsl:param name="member_pagesize" select="100"/>
	<xsl:param name="list_pagesize" select="15"/>
	<xsl:param name="classified_pagesize" select="10"/>

	<!--Data files path -->	
	<xsl:param name="languagefile"/>
	<xsl:param name="languagespath"/>
	<xsl:param name="skinsfolder"/>
	<xsl:param name="datafile"/>
	<xsl:param name="discussionfile"/>
	<xsl:param name="pollfile"/>
	<xsl:param name="logfile"/>
	<xsl:param name="memberfile"/>
	<xsl:param name="membergroupfile"/>
	<xsl:param name="reactfile"/>
	<xsl:param name="guestbookfile"/>
	<xsl:param name="taskfile"/>
	<xsl:param name="mediafile"/>
	<xsl:param name="downloadfile"/>
	<xsl:param name="categoryfile"/>
	<xsl:param name="bannerfile"/>
	<xsl:param name="directoryfile"/>
	<xsl:param name="skinstudiofile"/>
	<xsl:param name="kbfile"/>
	<xsl:param name="listfile"/>
	<xsl:param name="newsletterfile"/>
	<xsl:param name="chatfile"/>
	<xsl:param name="calendarfile"/>
	<xsl:param name="classifiedfile"/>

	<xsl:variable name="oldeditor" select="/siteinfo/data/oldeditor"/>

	<!-- Create the language's strings array -->
	<xsl:variable name="language" select="/siteinfo/data/language"/>
	<xsl:variable name="helpfilename"  select="document(concat($languagespath, '\_index.xml'))//languages/language[id=$language]/helpfile"/>
	<xsl:variable name="languagefilename"  select="document(concat($languagespath, '\_index.xml'))//languages/language[id=$language]/filename"/>
	<xsl:variable name="string" select="document(concat($languagespath, '\', $languagefilename))//language/strings/string"/>
	
	<!-- This params serves you as reference for first specific strings of each mentioned feature -->
	<!-- knowbase strings -->
	<xsl:param name="kb_basestring">621</xsl:param>
	<!-- List manager strings -->
	<xsl:param name="lists_basestring">671</xsl:param>
	<!-- Event calendar strings -->
	<xsl:param name="ecbasestring">701</xsl:param>
	<!-- Chat Manager strings -->
	<xsl:param name="chbasestring">761</xsl:param>
	<!-- Member Manager strings -->
	<xsl:param name="mmbasestring">801</xsl:param>
	<!-- Internal Messages strings -->
	<xsl:param name="intmessages_basestring">851</xsl:param>
	<!-- Newsletter Manager strings -->
	<xsl:param name="nmbasestring">891</xsl:param>
	<!-- Version Manager strings -->
	<xsl:param name="vmbasestring">921</xsl:param>
	<!-- Editor Manager strings -->
	<xsl:param name="edbasestring">961</xsl:param>
	<!-- Editor Manager strings -->
	<xsl:param name="classbasestring">971</xsl:param>

	<xsl:variable name="nbsp"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></xsl:variable>
	<xsl:variable name="textdirection" select="document($datafile)/siteinfo/data/textdirection"/>
	
	<!-- includes of the differents templates library -->
	<xsl:include href="admin_macros.xsl"/>
	<xsl:include href="lib_desktop.xsl"/>
	<xsl:include href="lib_website.xsl"/>
	<xsl:include href="lib_addons.xsl"/>
	<xsl:include href="lib_mail.xsl"/>
	<xsl:include href="lib_contentmoderation.xsl"/>
	<xsl:include href="lib_webpages.xsl"/>
	<xsl:include href="lib_categories.xsl"/>
	<xsl:include href="lib_banner.xsl"/>
	<xsl:include href="lib_download.xsl"/>
	<xsl:include href="lib_contents.xsl"/>
<!--	<xsl:include href="lib_medias.xsl"/> -->
	<xsl:include href="lib_polls.xsl"/>
	<xsl:include href="lib_tips.xsl"/>
	<xsl:include href="lib_gallery.xsl"/>
	<xsl:include href="lib_users.xsl"/>
	<xsl:include href="lib_guestbook.xsl"/>
	<xsl:include href="lib_reactions.xsl"/>
	<xsl:include href="lib_upload.xsl"/>
	<xsl:include href="lib_newsgroups.xsl"/>
	<xsl:include href="lib_messages.xsl"/>
	<xsl:include href="lib_stats.xsl"/>
	<xsl:include href="lib_help.xsl"/>
	<xsl:include href="lib_directories.xsl"/>
	<xsl:include href="lib_skinstudio.xsl"/>
	<xsl:include href="lib_knowledgebase.xsl"/>
	<xsl:include href="lib_list.xsl"/>
	<xsl:include href="lib_newsletter.xsl"/>
	<xsl:include href="lib_chatadmin.xsl"/>
	<xsl:include href="lib_events.xsl"/>
	<xsl:include href="lib_editor.xsl"/>
	<xsl:include href="lib_version.xsl"/>
	<xsl:include href="lib_adminclassified.xsl"/>
	<xsl:include href="lib_langedit.xsl"/>
	
<xsl:template match="/"> 		
	<HTML dir="{$textdirection}">
		<HEAD>
			<TITLE>
				<xsl:value-of select="/siteinfo/data/title"/>
			</TITLE>
			<META http-equiv="Content-Type" content="text/html; charset={/siteinfo/data/encoding}"/>
			<STYLE type="text/css">
				BODY {color: #000000; font-size: 11px; font-weight: bold; font-family: arial;  border: 1px outset; background: buttonface; }
				
				table.menu {width: 100%; border: 1px outset;}
				
				table.block {width: 100%; background: white; border: 1px #DDDDDD solid;}
				.category_title {background-image: url(admin/media/bg_top.gif);background-repeat: repeat-x; color: white; height: 30px; width: 100%; font-size: 14px; font-weight: bold;}
				.xp_sel{background: #F7F7F7; font-weight: bold; width: 150; padding-left: 5px;}
								
				input{font-size: 12px; font-weight: normal; font-family: arial;}
				input.full{ width: 450px; background-color: #D6EBFF; color: #000000; font-weight: normal; border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid;}
				input.mini{ width: 80px; background-color: #D6EBFF; color: #000000;font-weight: normal; border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid;}
				input.medium{ width: 150px; background-color: #D6EBFF; color: #000000;font-weight: normal; border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid;}
				input.medium2{ width: 300px; background-color: #D6EBFF; color: #000000;font-weight: normal; border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid;}
				input.inactive{  border: 0px; width: 300px; font-weight: normal; background: #FFFFFF; color: #ACA899;}

				<xsl:choose>								
					<xsl:when test="$oldeditor='on'">
						textarea{height: 150px; width: 450px; background-color: #D6EBFF; color: #000000; font-size: 12px; font-weight: normal; font-family: arial;  border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid; filter: alpha(opacity=100);BEHAVIOR: url(admin/js/textarea.htc)}
					</xsl:when>
					<xsl:otherwise>
						textarea{height: 150px; width: 450px; background-color: #D6EBFF; color: #000000; font-size: 12px; font-weight: normal; font-family: arial;  border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid; filter: alpha(opacity=100);}
					</xsl:otherwise>
				</xsl:choose>
				select {width: 200px; background-color: #D6EBFF; color: #000000; font-size: 12px; font-weight: normal; font-family: arial; border: 1px #4C4C4C solid; filter: alpha(opacity=100);}
								
				tr {vertical-align: top;}
				td{font-family: tahoma; font-size: 11px; icon: hand;}
				td.wtitle{font-family: tahoma; font-size: 12px; font-weight: bold; color: #000000; filter: progid:gradient(enabled=true, startColor=#550000, endColor=#55FFFF)}
				td.header{border: 1px outset; background: buttonface; font-weight: normal; text-align: center;}
				td.icon{border: 1px outset; background: buttonface; font-weight: bold; text-align: left;}
				tr.data, td.data{border: 1px inset; background: white; font-weight: normal; text-align: left;}
				td.data2 {padding-left: 4px}
				
				td.inactive{border: 1px inset; background: white; font-weight: normal; text-align: left; color: #D0D0D0; text-decoration: line-through;}
				tr.inactive{border: 1px inset; background: white; font-weight: normal; text-align: left; color: #D0D0D0; text-decoration: line-through;}
				tr.header{border: 1px outset; background: buttonface;}
				td.button{border: 1px inset; background: buttonface;}
																			
				.TopMenuItem{ BORDER-RIGHT: #cecece 1px solid; PADDING-RIGHT: 15px; BORDER-TOP: #cecece 1px solid; PADDING-LEFT: 15px; FONT-WEIGHT: bold; FONT-SIZE: 9pt; BACKGROUND: #cecece; PADDING-BOTTOM: 1px; BEHAVIOR: url(admin/media/hover.htc); BORDER-LEFT: #cecece 1px solid; CURSOR: hand; PADDING-TOP: 1px;  BORDER-BOTTOM: #cecece 1px solid; FONT-FAMILY: Verdana,Arial}
				.TopMenuItemOver{ BORDER-LEFT-COLOR: #808080; BACKGROUND: white; BORDER-BOTTOM-COLOR: #808080; COLOR: #cc6600; BORDER-TOP-COLOR: #808080; BORDER-RIGHT-COLOR: #808080; }
				.TopMenuItemClick{ BORDER-LEFT-COLOR: #808080; BACKGROUND: #808080; BORDER-BOTTOM-COLOR: #808080; COLOR: #cc6600; BORDER-TOP-COLOR: #808080; BORDER-RIGHT-COLOR: #808080; }
				
				#editBar  {position: absolute; display: none; width:399px; border: 1px black solid; background: lightgrey ; text-align: center}
				#editBar INPUT {font-size:10pt; width: 2em; font-weight: bold}
				
				a.menu {color: white;}
								
			</STYLE>
			
			<!-- Color, font pickers and date selector -->
			<SCRIPT LANGUAGE="JavaScript" SRC="admin/js/AnchorPosition.js"></SCRIPT>
			<SCRIPT LANGUAGE="JavaScript" SRC="admin/js/PopupWindow.js"></SCRIPT>
			<SCRIPT LANGUAGE="JavaScript" SRC="admin/js/CalendarPopup.js"></SCRIPT>
			<SCRIPT LANGUAGE="JavaScript" SRC="admin/js/date.js"></SCRIPT>
			<SCRIPT LANGUAGE="JavaScript" SRC="admin/js/ColorPicker2.js"></SCRIPT>
			<SCRIPT LANGUAGE="JavaScript" SRC="admin/js/FontPicker.js"></SCRIPT>

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
			
			<SCRIPT LANGUAGE="JavaScript">
				// Create CalendarPopup object
				var cal = new CalendarPopup();				
				document.write(cal.getStyles());
			</SCRIPT>
			
			
			<SCRIPT language="javascript">						
				function over(objet){ objet.style.background = '#FFFFFF'; objet.style.color = '#FF0000';}
				function notover(objet) {objet.style.background = 'buttonface';objet.style.color = '#000000';}
				
				//Action executer lors du passage sur un tr
				function overtr(objet) {objet.style.background = '#A4C5E6';	objet.style.color = '#FFFFFF';}
				
				function notovertr(objet){objet.style.background = '#FFFFFF';	objet.style.color = '#000000';}

				function goto(url){document.location = url;}
				
				function selected(objet){if (objet.style.background == '#A4C5E6')	objet.style.background = '#FFFFFF';	else objet.style.background = '#A4C5E6';}
				
				function SwapMode()
				{
					if (document.all['advancedfields'])
					{
						if (document.all['advancedfields'].style.display == 'none') 
						{
						    document.all['advancedfields'].style.display = 'block';
							document.all['swaper'].innerHTML = '<img  src="admin/media/collapse.gif" hspace="4" align="middle"/><xsl:value-of select="$string[440]"/>';						    
						}
						else  
						{
							document.all['advancedfields'].style.display = 'none';
							document.all['swaper'].innerHTML = '<img  src="admin/media/expand.gif" hspace="4" align="middle"/><xsl:value-of select="$string[439]"/>';
						}
					}
				}
			</SCRIPT>		
												
		</HEAD>
				
	
	<body  style="margin: 0px;">	
    	  	<xsl:variable name="current_skin" select=" /siteinfo/data/xslskin"/>
    	  	<!--<xsl:value-of select="$skinsnode/xslskins/xslskin[@name=$current_skin]/@studio"/>-->
    	  	
    	  	<table border="0" width="100%" cellpadding="0" cellspacing="2" height="15">
        		<tr><td class="wtitle" height="15" width="100%"><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a href="default.asp?refresh=True"><img align="absmiddle" src="admin/media/gohome.gif" border="0"/></a><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[position()=1]"/></td></tr>
        	</table>		
        	<table border="0" width="100%" cellpadding="0" cellspacing="2" height="600">
		<tr valign="top"> 			
			<td width="110" bgcolor="#c0c0c0" align="center" style="border: 1px inset" onselectstart="return false;">
				<img src="admin/media/dot.gif" width="110" height="1"/><br/>		
				<table cellspacing="0" cellpadding="0" border="0" width="110" bgcolor="#808080">
					<tr><td>
						<xsl:choose>
							<xsl:when test="$browsername='IE'">
								<SCRIPT LANGUAGE="JAVASCRIPT">
									OB_Top=29;								//position from top (px)
									OB_Width=106;							//bar width
									OB_Height=540;							//bar height
									<xsl:choose>
										<xsl:when test="$textdirection = 'RTL'">
											OB_Left= self.innerWidth - OB_Width;	//position from left (px)
										</xsl:when>
										<xsl:otherwise>
											OB_Left=5;						//position from left (px)
										</xsl:otherwise>
									</xsl:choose>
									OB_Margin=10;							//top and bottom margins between icons and borders									
									OB_SlideSpeed=1.75;						//speed during slide movement
									OB_BackgroundColor="BUTTONFACE";		//background color of the bar BACKGROUND
									OB_ItemsSpacing=20;						//space between two items (icons and text)
									OB_BorderWidth=1;						//border width
									OB_BorderStyle="jungle";				//border style
									OB_BorderColor="#DDDDDD";				//border color
									OB_IconsWidth=32;						//icons width
									OB_IconsHeight=32;						//icons height
									OB_ButtonFontFamily="tahoma";			//font family of button characters
									OB_ButtonFontSize=8;					//font size    "         "       "  
									OB_ButtonFontColor="black";				//font color   "         "       "     
									OB_ButtonHeight=20;						//button height
									OB_LabelFontFamily="tahoma";			//font family of text labels
									OB_LabelFontSize=8;						//font size    "   "   "   "
									OB_LabelFontColor="black";				//font color   "   "   "   "
									OB_LabelMargin=3;						//margin between labels and icons
									OB_UpArrow="admin/media/arrow_up.gif";	//arrow for slide up	
									OB_DownArrow="admin/media/arrow_down.gif";	//arrow for slide up	
									OB_ArrowWidth=16;						//arrow width
									OB_ArrowHeight=16;						//arrow height
									OB_ArrowSlideSpeed=8;					//speed for items scrolling
								</SCRIPT>
								
								<xsl:choose>
									<xsl:when test=" $usertype='administrator'">
										<SCRIPT>					
											OutBarFolder1=new Array(
											"<xsl:value-of select='$string[220]'/>",
											"admin/media/desktop.gif", "<xsl:value-of select='$string[280]'/>", "default.asp?ACT=1", "top",
											"admin/media/website.gif","<xsl:value-of select='$string[3]'/>","default.asp?ACT=1&amp;SECT=M1","top",
											"admin/media/addons.gif","<xsl:value-of select='$string[221]'/>","default.asp?ACT=1&amp;SECT=M101","top",
											"admin/media/emailf.gif","<xsl:value-of select='$string[380]'/>","default.asp?ACT=1&amp;SECT=M102","top",
											<xsl:if test="$skinsnode/xslskins/xslskin[@name=$current_skin]/@studio">"admin/media/skinstudio.gif","<xsl:value-of select='$string[601]'/>","default.asp?ACT=1&amp;SECT=M23","top",</xsl:if>
											"admin/media/info.gif","<xsl:value-of select='$string[$vmbasestring + 0]'/>","default.asp?ACT=1&amp;SECT=M99","top"
											);
											
											OutBarFolder2=new Array(
											"<xsl:value-of select='$string[5]'/>",
											"admin/media/contentset.gif","<xsl:value-of select='$string[611]'/>","default.asp?ACT=1&amp;SECT=M103","top",
											"admin/media/category.gif","<xsl:value-of select='$string[330]'/>","default.asp?ACT=1&amp;SECT=M18","top",
											"admin/media/webpages.gif","<xsl:value-of select='$string[4]'/>","default.asp?ACT=1&amp;SECT=M2","top",
											"admin/media/content.gif","<xsl:value-of select='$string[5]'/>","default.asp?ACT=1&amp;SECT=M3","top");

											
											OutBarFolder3=new Array(
											"<xsl:value-of select='$string[221]'/>",
											"admin/media/polls.gif","<xsl:value-of select='$string[6]'/>","default.asp?ACT=1&amp;SECT=M5","top",
											"admin/media/directories.gif","<xsl:value-of select='$string[482]'/>","default.asp?ACT=1&amp;SECT=M22","top"
											<xsl:if test="/siteinfo/data/tip!='off'">,"admin/media/tips.gif","<xsl:value-of select='$string[7]'/>","default.asp?ACT=1&amp;SECT=M6","top"</xsl:if>											
											<xsl:if test="/siteinfo/data/photo!='off'">,"admin/media/pictures.gif","<xsl:value-of select='$string[8]'/>","default.asp?ACT=1&amp;SECT=M7","top"</xsl:if>
											<xsl:if test="/siteinfo/data/discussion!='off'">,"admin/media/newsgroup.gif","<xsl:value-of select='$string[13]'/>","default.asp?ACT=1&amp;SECT=M12","top"</xsl:if>
											<xsl:if test="/siteinfo/data/banner!='off'">,"admin/media/banners.gif","<xsl:value-of select='$string[340]'/>","default.asp?ACT=1&amp;SECT=M19","top"</xsl:if>
											<xsl:if test="/siteinfo/data/download!='off'">,"admin/media/downloads.gif","<xsl:value-of select='$string[350]'/>","default.asp?ACT=1&amp;SECT=M20","top"</xsl:if>
											<xsl:if test="/siteinfo/data/knowbase!='off'">,"admin/media/knowbase.gif","<xsl:value-of select='$string[651]'/>","default.asp?ACT=1&amp;SECT=M90","top"</xsl:if>
											<xsl:if test="/siteinfo/data/eventcalendar!='off'">,"admin/media/eccalendar.gif","<xsl:value-of select='$string[733]'/>","default.asp?ACT=1&amp;SECT=M91","top"</xsl:if>
											<xsl:if test="/siteinfo/data/chat!='off'">,"admin/media/chat.gif","<xsl:value-of select='$string[779]'/>","default.asp?ACT=1&amp;SECT=M93","top"</xsl:if>
											<xsl:if test="/siteinfo/data/classified!='off'">,"admin/media/classified.gif","<xsl:value-of select='$string[$classbasestring+0]'/>","default.asp?ACT=1&amp;SECT=M70","top"</xsl:if>
											);
											
											OutBarFolder4=new Array(
											"<xsl:value-of select='$string[222]'/>",
											"admin/media/users.gif","<xsl:value-of select='$string[9]'/>","default.asp?ACT=1&amp;SECT=M8","top",
											"admin/media/reaction.gif","<xsl:value-of select='$string[12]'/>","default.asp?ACT=1&amp;SECT=M10","top"
											<xsl:if test="/siteinfo/data/showguestbook!='off'">,"admin/media/posts.gif","<xsl:value-of select='$string[10]'/>","default.asp?ACT=1&amp;SECT=M9","top"</xsl:if>
											<xsl:if test="/siteinfo/data/discussion!='off'">,"admin/media/newsgroup.gif","<xsl:value-of select='$string[272]'/>","default.asp?ACT=1&amp;SECT=M16","top"</xsl:if>
											);
											
											OutBarFolder5=new Array(
											"<xsl:value-of select='$string[223]'/>",
											"admin/media/stats.gif","<xsl:value-of select='$string[213]'/>","default.asp?ACT=1&amp;SECT=M13","top",
											"admin/media/stock_img.gif","<xsl:value-of select='$string[214]'/>","default.asp?ACT=1&amp;SECT=M14","top",
											"admin/media/browsers.gif","<xsl:value-of select='$string[216]'/>","default.asp?ACT=1&amp;SECT=M21","top");
											
											OutBarFolder6=new Array(
											"<xsl:value-of select='$string[610]'/>",
											"admin/media/upload.gif","<xsl:value-of select='$string[14]'/>","default.asp?ACT=1&amp;SECT=M11","top",
											"admin/media/lists.gif","<xsl:value-of select='$string[$lists_basestring + 0]'/>","default.asp?ACT=1&amp;SECT=M80","top",
											"admin/media/mailinglist.gif","<xsl:value-of select='$string[432]'/>","default.asp?ACT=1&amp;SECT=M100","top",
											"admin/media/langedit.gif","<xsl:value-of select='$string[609]'/>","default.asp?ACT=1&amp;SECT=M104","top"
											<xsl:if test="/siteinfo/data/oldeditor!='on'">,"admin/media/editor.gif","<xsl:value-of select='$string[$edbasestring + 0]'/>","default.asp?ACT=1&amp;SECT=M94","top"</xsl:if>
											);
											
											OutBarFolder7=new Array(
											"<xsl:value-of select='$string[224]'/>",
											"admin/media/help.gif","<xsl:value-of select='$string[225]'/>","default.asp?ACT=1&amp;SECT=M17","top");

										</SCRIPT>
									</xsl:when>
									<xsl:when test="$usertype='editor'">
										<SCRIPT>
											OutBarFolder1=new Array(
											"<xsl:value-of select='$string[220]'/>",
											"admin/media/desktop.gif", "<xsl:value-of select='$string[280]'/>", "default.asp?ACT=1", "top",
											"admin/media/content.gif","<xsl:value-of select='$string[5]'/>","default.asp?ACT=1&amp;SECT=M3","top",
											"admin/media/upload.gif","<xsl:value-of select='$string[14]'/>","default.asp?ACT=1&amp;SECT=M11","top"
											<xsl:if test="/siteinfo/data/discussion!='off'">,"admin/media/newsgroup.gif","<xsl:value-of select='$string[272]'/>","default.asp?ACT=1&amp;SECT=M16","top"</xsl:if>
											<xsl:if test="/siteinfo/data/knowbase!='off'">,"admin/media/knowbase.gif","<xsl:value-of select='$string[651]'/>","default.asp?ACT=1&amp;SECT=M90","top"</xsl:if>
											<xsl:if test="/siteinfo/data/eventcalendar!='off'">,"admin/media/events.gif","<xsl:value-of select='$string[733]'/>","default.asp?ACT=1&amp;SECT=M91","top"</xsl:if>
											<xsl:if test="/siteinfo/data/chat!='off'">,"admin/media/chat.gif","<xsl:value-of select='$string[779]'/>","default.asp?ACT=1&amp;SECT=M93","top"</xsl:if>
											);
											
										</SCRIPT>
									</xsl:when>
								</xsl:choose>
								<SCRIPT src="admin/js/outbar.js"></SCRIPT>
							</xsl:when>    	  	
							<!-- si pas IE, menu static -->
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test=" $usertype='administrator'">
										<table class="menu">
											<tr><td align="center"><b><xsl:value-of select='$string[220]'/></b></td></tr>													
											<tr><td><a href="default.asp?ACT=1" class="menu"><xsl:value-of select='$string[280]'/></a></td></tr>
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M1" class="menu"><xsl:value-of select='$string[3]'/></a></td></tr>
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M101" class="menu"><xsl:value-of select='$string[221]'/></a></td></tr>
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M102" class="menu"><xsl:value-of select='$string[380]'/></a></td></tr>
											<xsl:if test="$skinsnode/xslskins/xslskin[@name=$current_skin]/@studio">
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M23" class="menu"><xsl:value-of select='$string[601]'/></a></td></tr>
											</xsl:if>
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M99" class="menu"><xsl:value-of select='$string[$vmbasestring + 0]'/></a></td></tr>								
										</table>
										
										<table class="menu">
											<tr><td align="center"><b><xsl:value-of select='$string[5]'/></b></td></tr>													
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M103" class="menu"><xsl:value-of select='$string[611]'/></a></td></tr>
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M18" class="menu"><xsl:value-of select='$string[330]'/></a></td></tr>
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M2" class="menu"><xsl:value-of select='$string[4]'/></a></td></tr>
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M3" class="menu"><xsl:value-of select='$string[5]'/></a></td></tr>
										</table>

										<table class="menu">
											<tr><td align="center"><b><xsl:value-of select='$string[221]'/></b></td></tr>													
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M5" class="menu"><xsl:value-of select='$string[6]'/></a></td></tr>
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M22" class="menu"><xsl:value-of select='$string[482]'/></a></td></tr>
											<xsl:if test="/siteinfo/data/tip!='off'"><tr><td><a href="default.asp?ACT=1&amp;SECT=M6" class="menu"><xsl:value-of select='$string[7]'/></a></td></tr></xsl:if>											
											<xsl:if test="/siteinfo/data/photo!='off'"><tr><td><a href="default.asp?ACT=1&amp;SECT=M7" class="menu"><xsl:value-of select='$string[8]'/></a></td></tr></xsl:if>
											<xsl:if test="/siteinfo/data/discussion!='off'"><tr><td><a href="default.asp?ACT=1&amp;SECT=M12" class="menu"><xsl:value-of select='$string[13]'/></a></td></tr></xsl:if>
											<xsl:if test="/siteinfo/data/banner!='off'"><tr><td><a href="default.asp?ACT=1&amp;SECT=M19" class="menu"><xsl:value-of select='$string[340]'/></a></td></tr></xsl:if>
											<xsl:if test="/siteinfo/data/download!='off'"><tr><td><a href="default.asp?ACT=1&amp;SECT=M20" class="menu"><xsl:value-of select='$string[350]'/></a></td></tr></xsl:if>
											<xsl:if test="/siteinfo/data/knowbase!='off'"><tr><td><a href="default.asp?ACT=1&amp;SECT=M90" class="menu"><xsl:value-of select='$string[651]'/></a></td></tr></xsl:if>
											<xsl:if test="/siteinfo/data/eventcalendar!='off'"><tr><td><a href="default.asp?ACT=1&amp;SECT=M91" class="menu"><xsl:value-of select='$string[733]'/></a></td></tr></xsl:if>
											<xsl:if test="/siteinfo/data/chat!='off'"><tr><td><a href="default.asp?ACT=1&amp;SECT=M93" class="menu"><xsl:value-of select='$string[779]'/></a></td></tr></xsl:if>
											<xsl:if test="/siteinfo/data/classified!='off'"><tr><td><a href="default.asp?ACT=1&amp;SECT=M70" class="menu"><xsl:value-of select='$string[$classbasestring + 0]'/></a></td></tr></xsl:if>
										</table>
										
										<table class="menu">
											<tr><td align="center"><b><xsl:value-of select='$string[222]'/></b></td></tr>													
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M8" class="menu"><xsl:value-of select='$string[9]'/></a></td></tr>
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M10" class="menu"><xsl:value-of select='$string[12]'/></a></td></tr>
											<xsl:if test="/siteinfo/data/showguestbook!='off'"><tr><td><a href="default.asp?ACT=1&amp;SECT=M9" class="menu"><xsl:value-of select='$string[10]'/></a></td></tr></xsl:if>
											<xsl:if test="/siteinfo/data/discussion!='off'"><tr><td><a href="default.asp?ACT=1&amp;SECT=M16" class="menu"><xsl:value-of select='$string[272]'/></a></td></tr></xsl:if>
										</table>
										
										<table class="menu">
											<tr><td align="center"><b><xsl:value-of select='$string[223]'/></b></td></tr>													
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M13" class="menu"><xsl:value-of select='$string[213]'/></a></td></tr>
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M14" class="menu"><xsl:value-of select='$string[214]'/></a></td></tr>
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M21" class="menu"><xsl:value-of select='$string[216]'/></a></td></tr>
										</table>
										
										<table class="menu">
											<tr><td align="center"><b><xsl:value-of select='$string[610]'/></b></td></tr>
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M11" class="menu"><xsl:value-of select='$string[14]'/></a></td></tr>													
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M80" class="menu"><xsl:value-of select='$string[$lists_basestring + 0]'/></a></td></tr>
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M100" class="menu"><xsl:value-of select='$string[432]'/></a></td></tr>
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M104" class="menu"><xsl:value-of select='$string[432]'/></a></td></tr>
											<xsl:if test="/siteinfo/data/oldeditor!='on'"><tr><td><a href="default.asp?ACT=1&amp;SECT=M94" class="menu"><xsl:value-of select='$string[951]'/></a></td></tr></xsl:if>											
										</table>

										<table class="menu">
											<tr><td align="center"><b><xsl:value-of select='$string[224]'/></b></td></tr>													
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M17" class="menu"><xsl:value-of select='$string[225]'/></a></td></tr>
										</table>
										
									</xsl:when>
									<xsl:when test="$usertype='editor'">
										<table class="menu">
											<tr><td align="center"><b><xsl:value-of select='$string[220]'/></b></td></tr>													
											<tr><td><a href="default.asp?ACT=1" class="menu"><xsl:value-of select='$string[280]'/></a></td></tr>
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M3" class="menu"><xsl:value-of select='$string[5]'/></a></td></tr>
											<tr><td><a href="default.asp?ACT=1&amp;SECT=M11" class="menu"><xsl:value-of select='$string[14]'/></a></td></tr>
											<xsl:if test="/siteinfo/data/discussion!='off'"><tr><td><a href="default.asp?ACT=1&amp;SECT=M16" class="menu"><xsl:value-of select='$string[272]'/></a></td></tr></xsl:if>
											<xsl:if test="/siteinfo/data/knowbase!='off'"><tr><td><a href="default.asp?ACT=1&amp;SECT=M90" class="menu"><xsl:value-of select='$string[651]'/></a></td></tr></xsl:if>
											<xsl:if test="/siteinfo/data/eventcalendar!='off'"><tr><td><a href="default.asp?ACT=1&amp;SECT=M80" class="menu"><xsl:value-of select='$string[672]'/></a></td></tr></xsl:if>
											<xsl:if test="/siteinfo/data/chat!='off'"><tr><td><a href="default.asp?ACT=1&amp;SECT=M93" class="menu"><xsl:value-of select='$string[779]'/></a></td></tr></xsl:if>
										</table>
									</xsl:when>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>				
						
				</td></tr>				
			</table>	
			</td>
			
			<!-- Cellule principale -->
			<td bgcolor="#cccccc">
						
				<!-- on affiche en fonction des querystrings -->
				<xsl:choose>
					<xsl:when test="$SECT='M1'">
						<script>OutlookLikeBar.FolderClicked(1);</script>
						<xsl:call-template name="website_manager"/>
					</xsl:when>
					
					<xsl:when test="$SECT='M2'">
						<script>OutlookLikeBar.FolderClicked(2);</script>
						<xsl:call-template name="webpage_manager"/>
					</xsl:when>
					
					<xsl:when test="$SECT='M3'">
						<xsl:choose>
							<xsl:when test="$usertype='administrator'">
								<script>OutlookLikeBar.FolderClicked(2);</script>
							</xsl:when>
							<xsl:otherwise>
								<script>OutlookLikeBar.FolderClicked(1);</script>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:call-template name="content_manager"/>
					</xsl:when>
					
					<!--<xsl:when test="$SECT='M4'">
						<xsl:call-template name="media_manager"/>
						<xsl:call-template name="website_manager"/>
					</xsl:when>-->
					
					<xsl:when test="$SECT='M5'">
						<script>OutlookLikeBar.FolderClicked(3);</script>
						<xsl:call-template name="poll_manager"/>						
					</xsl:when>
					
					<xsl:when test="$SECT='M6'">
						<script>OutlookLikeBar.FolderClicked(3);</script>
						<xsl:call-template name="tip_manager"/>
					</xsl:when>
					
					<xsl:when test="$SECT='M7'">
						<script>OutlookLikeBar.FolderClicked(3);</script>
						<xsl:call-template name="gallery_manager"/>
					</xsl:when>
					
					<xsl:when test="$SECT='M8'">
						<script>OutlookLikeBar.FolderClicked(4);</script>
						<xsl:call-template name="member_manager"/>
					</xsl:when>
					
					<xsl:when test="$SECT='M9'">
						<script>OutlookLikeBar.FolderClicked(4);</script>
						<xsl:call-template name="guestbook_manager"/>
					</xsl:when>
					
					<xsl:when test="$SECT='M10'">
						<script>OutlookLikeBar.FolderClicked(4);</script>
						<xsl:call-template name="reactions_manager"/>
					</xsl:when>
					
					<xsl:when test="$SECT='M11'">
						<xsl:choose>
							<xsl:when test="$usertype='administrator'">
								<script>OutlookLikeBar.FolderClicked(6);</script>
							</xsl:when>
							<xsl:otherwise>
								<script>OutlookLikeBar.FolderClicked(1);</script>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:call-template name="upload_manager"/>
					</xsl:when>
					
					<xsl:when test="$SECT='M12'">
						<script>OutlookLikeBar.FolderClicked(3);</script>
						<xsl:call-template name="newsgroup_manager"/>
					</xsl:when>
					
					<xsl:when test="$SECT='M13'">
						<script>OutlookLikeBar.FolderClicked(5);</script>
						<xsl:call-template name="stat_grid"/>
					</xsl:when>
					
					<xsl:when test="$SECT='M14'">
						<script>OutlookLikeBar.FolderClicked(5);</script>
						<xsl:call-template name="stat_graphic"/>
					</xsl:when>
					
					<xsl:when test="$SECT='M15'">
						<script>OutlookLikeBar.FolderClicked(4);</script>
						<xsl:call-template name="stat_detail"/>
					</xsl:when>
					
					<xsl:when test="$SECT='M16'">
						<xsl:choose>
							<xsl:when test="$usertype='administrator'">
								<script>OutlookLikeBar.FolderClicked(4);</script>
							</xsl:when>
							<xsl:otherwise>
								<script>OutlookLikeBar.FolderClicked(1);</script>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:call-template name="message_manager"/>
					</xsl:when>
			
					<xsl:when test="$SECT='M17'">
						<script>OutlookLikeBar.FolderClicked(7);</script>
						<xsl:call-template name="help"/>
					</xsl:when>
					
					<xsl:when test="$SECT='M18'">
						<script>OutlookLikeBar.FolderClicked(2);</script>
						<xsl:call-template name="category_manager"/>
					</xsl:when>
					
					<xsl:when test="$SECT='M19'">
						<script>OutlookLikeBar.FolderClicked(3);</script>
						<xsl:call-template name="banner_manager"/>
					</xsl:when>
					
					<xsl:when test="$SECT='M20'">
						<script>OutlookLikeBar.FolderClicked(3);</script>
						<xsl:call-template name="download_manager"/>
					</xsl:when>
					
					<xsl:when test="$SECT='M21'">
						<script>OutlookLikeBar.FolderClicked(5);</script>
						<xsl:call-template name="browser_detail"/>
					</xsl:when>
					
					<!-- Directories -->
					<xsl:when test="$SECT='M22'">
						<script>OutlookLikeBar.FolderClicked(3);</script>
						<xsl:call-template name="directories_manager"/>
					</xsl:when>
					
					<!-- Skin studio -->
					<xsl:when test="$SECT='M23'">
						<script>OutlookLikeBar.FolderClicked(1);</script>
						<xsl:call-template name="skinstudio_manager"/>
					</xsl:when>

					<!-- Classified Adds Manager -->
					<xsl:when test="$SECT='M70'">
						<script>OutlookLikeBar.FolderClicked(3);</script>
						<xsl:call-template name="classified_manager"/>
					</xsl:when>

					<!-- List Manager -->
					<xsl:when test="$SECT='M80'">
						<script>OutlookLikeBar.FolderClicked(6);</script>
						<xsl:call-template name="list_manager"/>
					</xsl:when>

					<!-- KnowledgeBase Editor -->
					<xsl:when test="$SECT='M90'">
						<xsl:choose>
							<xsl:when test="$usertype='administrator'">
								<script>OutlookLikeBar.FolderClicked(3);</script>
							</xsl:when>
							<xsl:otherwise>
								<script>OutlookLikeBar.FolderClicked(1);</script>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:call-template name="help_kbeditor"/>
					</xsl:when>

					<!-- Event Calendar -->
					<xsl:when test="$SECT='M91'">
						<xsl:choose>
							<xsl:when test="$usertype='administrator'">
								<script>OutlookLikeBar.FolderClicked(3);</script>
							</xsl:when>
							<xsl:otherwise>
								<script>OutlookLikeBar.FolderClicked(1);</script>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:call-template name="events_manager"/>
					</xsl:when>

					<!-- Event Calendar -->
					<xsl:when test="$SECT='M93'">
						<xsl:choose>
							<xsl:when test="$usertype='administrator'">
								<script>OutlookLikeBar.FolderClicked(3);</script>
							</xsl:when>
							<xsl:otherwise>
								<script>OutlookLikeBar.FolderClicked(1);</script>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:call-template name="chat_manager"/>
					</xsl:when>

					<xsl:when test="$SECT='M94'">
						<script>OutlookLikeBar.FolderClicked(6);</script>
						<xsl:call-template name="editor_manager"/>
					</xsl:when>
					
					<xsl:when test="$SECT='M99'">
						<script>OutlookLikeBar.FolderClicked(1);</script>
						<xsl:call-template name="version_manager"/>
					</xsl:when>
					
					<!-- Newsletter manager -->
					<xsl:when test="$SECT='M100'">
						<script>OutlookLikeBar.FolderClicked(6);</script>
						<xsl:call-template name="newsletter_manager"/>
					</xsl:when>
					
					<!-- Addons manager -->
					<xsl:when test="$SECT='M101'">
						<script>OutlookLikeBar.FolderClicked(1);</script>
						<xsl:call-template name="addons_manager"/>
					</xsl:when>
					
					<!-- Email functionnalities -->
					<xsl:when test="$SECT='M102'">
						<script>OutlookLikeBar.FolderClicked(1);</script>
						<xsl:call-template name="mail_manager"/>
					</xsl:when>

					<!-- Content Moderation -->
					<xsl:when test="$SECT='M103'">
						<script>OutlookLikeBar.FolderClicked(2);</script>
						<xsl:call-template name="contentmoderation_manager"/>
					</xsl:when>
					
					<!-- Content Moderation -->
					<xsl:when test="$SECT='M104'">
						<script>OutlookLikeBar.FolderClicked(6);</script>
						<xsl:call-template name="langedit"/>
					</xsl:when>
				
					<xsl:otherwise>						
						<xsl:call-template name="desktop"/>
					</xsl:otherwise>
				</xsl:choose>
						
		</td></tr>		
	</table>	
	</body>	
	</HTML>	
</xsl:template> 

</xsl:stylesheet>
		