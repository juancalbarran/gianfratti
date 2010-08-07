<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="no"/>
	
<!-- Edited by : 2003/09/05, by Jens Schreiber-->
<!-- version 1.0 -->



	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--       search results processor       -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="search">
		<script language="javascript">
			//external
			function insertLink(sLink) {
				eval(parent).opener.onLink(sLink);
				val = close();
			}
		</script>
	
		<br/>
		<xsl:if test="$keyword">
			<xsl:choose>
				<xsl:when test="$kind='forum'">
					<xsl:call-template name="ForumResults"/>
				</xsl:when>
				<xsl:when test="$kind='article'">
					<xsl:call-template name="ArticleResults"/>
				</xsl:when>
				<xsl:when test="$kind='calendar'">
					<xsl:call-template name="CalendarResults"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="ArticleResults"/>
					<xsl:call-template name="ForumResults"/>
					<xsl:call-template name="CalendarResults"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>		
		<center><xsl:call-template name="searchform"/></center>		
	</xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--    functions belonging to articles   -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--            search in pages           -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="PageSearch">
	    <xsl:param name="searchstring"/>
	    <xsl:param name="categoryid"/>
	    <xsl:param name="pageid"/>
	    <xsl:param name="pagename"/>
	    <xsl:param name="pagebody"/>
	      
	    <xsl:variable name="searchsub">
			<xsl:choose>
				<xsl:when test="contains($searchstring, ' ')">
					<xsl:value-of select="substring-before($searchstring,' ')" />
				</xsl:when>
		        <xsl:otherwise>
					<xsl:value-of select="$searchstring" />
		        </xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="contains($pagename, $searchsub) or contains($pagebody, $searchsub)">
			<xsl:choose>
				<xsl:when test="string-length($searchstring)&gt;0">
					<xsl:call-template name="PageSearch">
						<xsl:with-param name="searchstring">
							<xsl:value-of select="substring-after($searchstring, ' ')" />
						</xsl:with-param>
						<xsl:with-param name="pagename">
							<xsl:value-of select="$pagename" />
						</xsl:with-param>
						<xsl:with-param name="pagebody">
							<xsl:value-of select="$pagebody" />
						</xsl:with-param>
						<xsl:with-param name="pageid">
							<xsl:value-of select="$pageid" />
						</xsl:with-param>
						<xsl:with-param name="categoryid">
							<xsl:value-of select="$categoryid" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="PageResultEntry">
						<xsl:with-param name="categoryid">
							<xsl:value-of select="$categoryid" />
						</xsl:with-param>
						<xsl:with-param name="pageid">
							<xsl:value-of select="$pageid" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--          search in articles          -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="ArticleSearch">
	    <xsl:param name="searchstring"/>
	    <xsl:param name="categoryid"/>
	    <xsl:param name="pageid"/>
	    <xsl:param name="articleid"/>
	    <xsl:param name="title"/>
	    <xsl:param name="headlines"/>
	    <xsl:param name="body"/>

	    <xsl:variable name="searchsub">
			<xsl:choose>
				<xsl:when test="contains($searchstring, ' ')">
					<xsl:value-of select="substring-before($searchstring,' ')" />
				</xsl:when>
		        <xsl:otherwise>
					<xsl:value-of select="$searchstring" />
		        </xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="contains($title, $searchsub) or contains($headlines, $searchsub) or contains($body, $searchsub)">
			<xsl:choose>
				<xsl:when test="string-length($searchstring)&gt;0">
					<xsl:call-template name="ArticleSearch">
						<xsl:with-param name="searchstring">
							<xsl:value-of select="substring-after($searchstring, ' ')" />
						</xsl:with-param>
						<xsl:with-param name="title">
							<xsl:value-of select="$title" />
						</xsl:with-param>
						<xsl:with-param name="headlines">
							<xsl:value-of select="$headlines" />
						</xsl:with-param>
						<xsl:with-param name="body">
							<xsl:value-of select="$body" />
						</xsl:with-param>
						<xsl:with-param name="articleid">
							<xsl:value-of select="$articleid" />
						</xsl:with-param>
						<xsl:with-param name="pageid">
							<xsl:value-of select="$pageid" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="ArticleResultEntry">
						<xsl:with-param name="categoryid">
							<xsl:value-of select="$categoryid" />
						</xsl:with-param>
						<xsl:with-param name="pageid">
							<xsl:value-of select="$pageid" />
						</xsl:with-param>
						<xsl:with-param name="articleid">
							<xsl:value-of select="$articleid" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--              Show page               -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="PageResultEntry">
		<xsl:param name="categoryid"/>
		<xsl:param name="pageid"/>
		
		<xsl:for-each select="document($datafile)//pages/page[id=$pageid]">			
			<xsl:variable name="extLink" select="externallink"/>
			<xsl:variable name="extLinkTarget" select="externaltype"/>
		
			<xsl:choose>
				<xsl:when test="(document($categoryfile)//categories/category[id=$categoryid]/member='on' and $usertype='anonymous')">
					<li><xsl:value-of select="name"/></li>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="string-length($extLink)=0">
							<!-- NO External Link so don't worry -->
							<li>
								<a href="default.asp?id={$pageid}&amp;mnu={$pageid}">									
									<xsl:if test="$content='easylink'">
										<xsl:attribute name="onClick">insertLink('default.asp?id=<xsl:value-of select="$pageid"/>&amp;mnu=<xsl:value-of select="$pageid"/>')
										</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="name"/>
								</a>
							</li>
						</xsl:when>					
						<xsl:otherwise>
							<!-- Got an external page so determine frame or otherwise -->
							<xsl:choose>
								<xsl:when test="$extLinkTarget='eframe'">
									<li>
										<a href="default.asp?id={$pageid}&amp;mnu={$pageid}">
											<xsl:if test="$content='easylink'">
													<xsl:attribute name="onClick">insertLink('default.asp?id=<xsl:value-of select="$pageid"/>&amp;mnu=<xsl:value-of select="$pageid"/>')
													</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="name"/>
										</a>
									</li>
								</xsl:when>
								<xsl:otherwise>
									<li>
										<a href="{$extLink}" target="_{$extLinkTarget}">
											<xsl:if test="$content='easylink'">
													<xsl:attribute name="onClick">insertLink('<xsl:value-of select="$extLink"/>')
													</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="name"/>
										</a>
									</li>
								</xsl:otherwise>
							</xsl:choose>	
						</xsl:otherwise>
					</xsl:choose>				
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>	
	</xsl:template>	
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--            Show article              -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="ArticleResultEntry">
		<xsl:param name="categoryid"/>
		<xsl:param name="pageid"/>
		<xsl:param name="articleid"/>
		
		<xsl:for-each select="document($datafile)//contents/content[id=$articleid and visible='on']">			
			<xsl:choose>							    
				<xsl:when test="(document($categoryfile)//categories/category[id=$categoryid]/member='on' and $usertype='anonymous')">
					<li><xsl:value-of select="title"/></li>
				</xsl:when>
				<xsl:otherwise>
					<li>
						<a href="default.asp?id={$pageid}&amp;mnu={$pageid}&amp;ACT=5&amp;content={id}"> 
							<xsl:if test="$content='easylink'">
								<xsl:attribute name="onClick">insertLink('default.asp?id=<xsl:value-of select="$pageid"/>&amp;mnu=<xsl:value-of select="$pageid"/>&amp;ACT=5&amp;content=<xsl:value-of select="id"/>')
								</xsl:attribute>								
							</xsl:if>
							<xsl:value-of select="title"/>
						</a>
				   	</li>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>	
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--       Start search of articles       -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="StartPageSearch">
		<xsl:param name="categoryid"/>
		
		<xsl:variable name="up" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZéèà'"/>
		<xsl:variable name="low" select="'abcdefghijklmnopqrstuvwxyzeea'"/>            
		<xsl:variable name="lowkeyword" select="translate($keyword,$up,$low)"/>
		
		<xsl:for-each select="document($datafile)//pages/page[category=$categoryid and visible='on']">
			<xsl:sort select="pagename" order="descending"/>
			<xsl:variable name="pageid" select="id"/>
			<xsl:call-template name = "PageSearch" >
				<xsl:with-param name="searchstring"><xsl:value-of select="$lowkeyword"/></xsl:with-param>
				<xsl:with-param name="categoryid"><xsl:value-of select="$categoryid"/></xsl:with-param>
				<xsl:with-param name="pageid"><xsl:value-of select="$pageid"/></xsl:with-param>
				<xsl:with-param name="pagename"><xsl:value-of select="translate(name,$up,$low)"/></xsl:with-param>
				<xsl:with-param name="pagebody"><xsl:value-of select="translate(body,$up,$low)"/></xsl:with-param>
			</xsl:call-template>
			
			<xsl:for-each select="document($datafile)//contents/content[idpage=$pageid and visible='on']">
				<xsl:sort select="title" order="descending"/>
				<xsl:call-template name="ArticleSearch">
					<xsl:with-param name="searchstring"><xsl:value-of select="$lowkeyword"/></xsl:with-param>
					<xsl:with-param name="categoryid"><xsl:value-of select="$categoryid"/></xsl:with-param>
					<xsl:with-param name="pageid" select="idpage"/>
					<xsl:with-param name="articleid"><xsl:value-of select="id"/></xsl:with-param>
					<xsl:with-param name="title"><xsl:value-of select="translate(title,$up,$low)"/></xsl:with-param>
					<xsl:with-param name="headlines"><xsl:value-of select="translate(headlines,$up,$low)"/></xsl:with-param>
					<xsl:with-param name="body"><xsl:value-of select="translate(body,$up,$low)"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:for-each>		
	</xsl:template>
   	
	<xsl:template name="ArticleResults">
		<xsl:call-template name="title_design">
			<xsl:with-param name="title" select="$string[563]"/>
		</xsl:call-template>

		<!-- for each category -->
		<xsl:for-each select="document($categoryfile)//categories/category[visible='on' and member!='admin']">
			<xsl:variable name="categoryid" select="id"/>
			
			<xsl:if test="count(document($datafile)//pages/page[category=$categoryid and visible='on'])&gt;0">
				<xsl:call-template name="StartPageSearch">
					<xsl:with-param name="categoryid" select="$categoryid"/>
				</xsl:call-template>
			</xsl:if>			
		</xsl:for-each>
   	</xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--    functions belonging to forums     -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--           search in forum            -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="ForumSearch">
	    <xsl:param name="searchstring"/>
	    <xsl:param name="newsgroupid"/>
	    <xsl:param name="messageid"/>
	    <xsl:param name="title"/>
	    <xsl:param name="body"/>
	      
	    <xsl:variable name="searchsub">
			<xsl:choose>
				<xsl:when test="contains($searchstring, ' ')">
					<xsl:value-of select="substring-before($searchstring,' ')" />
				</xsl:when>
		        <xsl:otherwise>
					<xsl:value-of select="$searchstring" />
		        </xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="contains($title, $searchsub) or contains($body, $searchsub)">
			<xsl:choose>
				<xsl:when test="string-length($searchstring)&gt;0">
					<xsl:call-template name="ForumSearch">
						<xsl:with-param name="searchstring">
							<xsl:value-of select="substring-after($searchstring, ' ')" />
						</xsl:with-param>
						<xsl:with-param name="title">
							<xsl:value-of select="$title" />
						</xsl:with-param>
						<xsl:with-param name="body">
							<xsl:value-of select="$body" />
						</xsl:with-param>
						<xsl:with-param name="newsgroupid">
							<xsl:value-of select="$newsgroupid" />
						</xsl:with-param>
						<xsl:with-param name="messageid">
							<xsl:value-of select="$messageid" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="ForumResultEntry">
						<xsl:with-param name="newsgroupid">
							<xsl:value-of select="$newsgroupid" />
						</xsl:with-param>
						<xsl:with-param name="messageid">
							<xsl:value-of select="$messageid" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
   
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--         Show single message          -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="ForumResultEntry">
		<xsl:param name="newsgroupid"/>
		<xsl:param name="messageid"/>
		<xsl:variable name="threadid">	
			<xsl:choose>
				<xsl:when test="document($discussionfile)//discussions/discussion[id=$newsgroupid]//message[id=$messageid and count(ancestor::message)=1]">
					<xsl:value-of select="document($discussionfile)//discussions/discussion[id=$newsgroupid]//message[message/id=$messageid]/id"/>
				</xsl:when>
				<xsl:when test="document($discussionfile)//discussions/discussion[id=$newsgroupid]//message[id=$messageid and parent::message]">
					<xsl:value-of select="document($discussionfile)//discussions/discussion[id=$newsgroupid]//message[child::*//message/id=$messageid]/id"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$messageid"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:choose>
			<xsl:when test="$vpValue=1">
				<xsl:for-each select = "document($discussionfile)//discussions/discussion//message[id=$messageid]">
					<li>
						<a href="default.asp?ACT=17&amp;grp={$newsgroupid}&amp;msg={$threadid}&amp;vp={$vpValue}#{$messageid}" >
							<xsl:if test="$content='easylink'">
								<xsl:attribute name="onClick">insertLink('default.asp?ACT=17&amp;grp=<xsl:value-of select="$newsgroupid"/>&amp;msg=<xsl:value-of select="$threadid"/>&amp;vp={$vpValue}#{$messageid}')</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="title"/>
						</a>
						[<xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template> - <xsl:value-of select="l"/>]
					</li>
				</xsl:for-each>
			</xsl:when>	
			<xsl:otherwise>
				<xsl:for-each select = "document($discussionfile)//discussions/discussion//message[id=$messageid]">
					<li>
						<a href="default.asp?ACT=17&amp;grp={$newsgroupid}&amp;msg={$messageid}&amp;vp={$vpValue}" >
							<xsl:if test="$content='easylink'">
								<xsl:attribute name="onClick">insertLink('default.asp?ACT=17&amp;grp=<xsl:value-of select="$newsgroupid"/>&amp;msg=<xsl:value-of select="$threadid"/>&amp;vp={$vpValue}')</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="title"/>
						</a>
						[<xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime" select="date"/></xsl:call-template> - <xsl:value-of select="l"/>]
					</li>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
		
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--        Start search of forum         -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="ForumResults">
		<xsl:variable name="up" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZéèà'"/>
		<xsl:variable name="low" select="'abcdefghijklmnopqrstuvwxyzeea'"/>            
		<xsl:variable name="lowkeyword" select="translate($keyword,$up,$low)"/>
		
		<xsl:call-template name="title_design">
			<xsl:with-param name="title" select="$string[564]"/>
		</xsl:call-template>
		
		<xsl:for-each select="document($discussionfile)//discussions/discussion[visible='on']//message[visible!='off']">
			<xsl:sort select="date" order="descending"/>
			<xsl:variable name="newsgroupid" select="ancestor::discussion/id"/>
			
			<xsl:call-template name = "ForumSearch" >
				<xsl:with-param name="searchstring"><xsl:value-of select="$lowkeyword"/></xsl:with-param>
				<xsl:with-param name="newsgroupid"><xsl:value-of select="$newsgroupid"/></xsl:with-param>
				<xsl:with-param name="messageid"><xsl:value-of select="id"/></xsl:with-param>
				<xsl:with-param name="title"><xsl:value-of select="translate(title,$up,$low)"/></xsl:with-param>
				<xsl:with-param name="body"><xsl:value-of select="translate(body,$up,$low)"/></xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
   	</xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!-- functions which belongs to calendar  -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--          search in calendar          -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="CalendarSearch">
	    <xsl:param name="searchstring"/>
	    <xsl:param name="eventid"/>
	    <xsl:param name="shortdesc"/>
	    <xsl:param name="description"/>
	      
	    <xsl:variable name="searchsub">
			<xsl:choose>
				<xsl:when test="contains($searchstring, ' ')">
					<xsl:value-of select="substring-before($searchstring,' ')" />
				</xsl:when>
		        <xsl:otherwise>
					<xsl:value-of select="$searchstring" />
		        </xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="contains($description, $searchsub) or contains($shortdesc, $searchsub)">
			<xsl:choose>
				<xsl:when test="string-length($searchstring)&gt;0">
					<xsl:call-template name="CalendarSearch">
						<xsl:with-param name="searchstring">
							<xsl:value-of select="substring-after($searchstring, ' ')" />
						</xsl:with-param>
						<xsl:with-param name="shortdesc">
							<xsl:value-of select="$shortdesc" />
						</xsl:with-param>
						<xsl:with-param name="description">
							<xsl:value-of select="$description" />
						</xsl:with-param>
						<xsl:with-param name="eventid">
							<xsl:value-of select="$eventid" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="CalendarResultEntry">
						<xsl:with-param name="eventid">
							<xsl:value-of select="$eventid" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
   
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--           Show single event          -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="CalendarResultEntry">
		<xsl:param name="eventid"/>
		
		<xsl:for-each select = "document($calendarfile)/eventcalendar/calendar/event[id=$eventid]">			
			<li>
				<xsl:variable name="calendarid" select="ancestor::calendar/id"/>	
				<a href="default.asp?ACT=91&amp;calendar={$calendarid}&amp;eventid={id}">
					<xsl:if test="$content='easylink'">
						<xsl:attribute name="onClick">insertLink('default.asp?ACT=91&amp;calendar=<xsl:value-of select="$calendarid"/>&amp;eventid=<xsl:value-of select="id"/>')</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="shortdesc"/>
				</a>  
				[<xsl:value-of select="substring(eventdate, 7, 2)"/>.<xsl:value-of select="substring(eventdate, 5, 2)"/>.<xsl:value-of select="substring(eventdate, 1, 4)"/>]
			</li>
		</xsl:for-each>		
	</xsl:template>
		
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--        Start search of events        -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="CalendarStartSearch">
		<xsl:param name="calendarid"/>
		
		<xsl:variable name="up" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZéèà'"/>
		<xsl:variable name="low" select="'abcdefghijklmnopqrstuvwxyzeea'"/>            
		<xsl:variable name="lowkeyword" select="translate($keyword,$up,$low)"/>
		
		<xsl:for-each select="document($calendarfile)/eventcalendar/calendar[id=$calendarid]/event[visible='on']">
			<xsl:sort select="eventdate" order="descending"/>			
			<xsl:call-template name = "CalendarSearch" >
				<xsl:with-param name="searchstring"><xsl:value-of select="$lowkeyword"/></xsl:with-param>
				<xsl:with-param name="eventid"><xsl:value-of select="id"/></xsl:with-param>
				<xsl:with-param name="shortdesc"><xsl:value-of select="translate(shortdesc,$up,$low)"/></xsl:with-param>
				<xsl:with-param name="description"><xsl:value-of select="translate(description,$up,$low)"/></xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
   	
	<xsl:template name="CalendarResults">
		<xsl:call-template name="title_design">
			<xsl:with-param name="title" select="$string[751]"/>
		</xsl:call-template>
		
		<xsl:for-each select="document($calendarfile)/eventcalendar/calendar[visible='on']">
			<xsl:choose>
				<xsl:when test="$usertype='administrator'">
					<xsl:call-template name="CalendarStartSearch">
						<xsl:with-param name="calendarid"><xsl:value-of select="id"/></xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="$usertype='editor'">
					<xsl:if test="group!='administrator'">
						<xsl:call-template name="CalendarStartSearch">
							<xsl:with-param name="calendarid"><xsl:value-of select="id"/></xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:when test="$usertype='member'">
					<xsl:if test="group='member' or group='anonymous'">
						<xsl:call-template name="CalendarStartSearch">
							<xsl:with-param name="calendarid"><xsl:value-of select="id"/></xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="group='anonymous'">
						<xsl:call-template name="CalendarStartSearch">
							<xsl:with-param name="calendarid"><xsl:value-of select="id"/></xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
   	</xsl:template>
	
	<!-- Affichage de la boite de recherche -->
	<xsl:template name="searchform">
		<table cellpadding="0" cellspacing="0"><tr>
		<form action="default.asp?ACT=4&amp;kind={$kind}&amp;content={$content}" method="post">
			<TD>
				<xsl:call-template name="normaltext_design">
					<xsl:with-param name="text">
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[240]"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="text" name="keyword" size="8" value="{$keyword}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="submit" value="ok"/>
					</xsl:with-param>
				</xsl:call-template>
			</TD>
		</form>
		</tr></table>
	</xsl:template>
	
	<xsl:template name="searchformmargin">		
		<xsl:call-template name="margin_design">
			<xsl:with-param name="title">
				<xsl:value-of select="$string[240]"/>
			</xsl:with-param>
			<xsl:with-param name="body">
				<table cellpadding="0" cellspacing="0"><tr>
				<form action="default.asp?ACT=4" method="post">
					<TD>
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="text" name="keyword" size="8" value="{$keyword}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><input type="submit" value="ok"/>
							</xsl:with-param>
						</xsl:call-template>
					</TD>
				</form>
				</tr></table>
			</xsl:with-param>
		</xsl:call-template>		
	</xsl:template>

</xsl:stylesheet>
