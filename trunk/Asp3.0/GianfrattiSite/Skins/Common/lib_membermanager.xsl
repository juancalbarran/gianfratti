<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Webpages Template : add/update/modify -->
<!-- last changes: 2003/10/04, by Miguel Figueira (Mig100) -->
<!-- version 0.9 -->

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--     Generic members templates        -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

	<!-- Main procedure -->
	<xsl:template name="member_manager">
	<xsl:choose>
		<!-- if member manager is off -->
		<xsl:when test="/siteinfo/data/membermanager='member' and $usertype='anonymous'">
			<br/>
			<xsl:call-template name="hightlightedtext_design">
				<xsl:with-param name="text" select="$string[$intmessages_basestring + 12]"/>
			</xsl:call-template>	
	  	</xsl:when>
		<!-- display all members with public profiles -->
		<xsl:when test="$kind='all'">
			<xsl:call-template name = "all_members" />
	  	</xsl:when>
		<!-- Search for members -->
		<xsl:when test="$kind='search'">
			<xsl:call-template name = "search_results" />
	  	</xsl:when>
		<!-- display members with public profiles within a country -->
		<xsl:when test="$kind='country'">
			<xsl:call-template name = "country_members" >
				<xsl:with-param name="country"><xsl:value-of select="$name" /></xsl:with-param>
			</xsl:call-template>
	  	</xsl:when>
		<!-- display members with public profiles within a state -->
		<xsl:when test="$kind='state'">
			<xsl:call-template name = "state_members" >
				<xsl:with-param name="state"><xsl:value-of select="$name" /></xsl:with-param>
			</xsl:call-template>
	  	</xsl:when>
		<!-- display members with public profiles within a ville -->		 
		<xsl:when test="$kind='ville'">
			<xsl:call-template name = "ville_members" >
				<xsl:with-param name="ville"><xsl:value-of select="$name" /></xsl:with-param>
			</xsl:call-template>
	  	</xsl:when>
		<!-- if something goes wrong user will be sent into search form -->
		<xsl:otherwise>
			<xsl:call-template name = "search_members" />
		</xsl:otherwise>
	</xsl:choose>	
	</xsl:template>
	

	<!-- Form Member search  -->
	<xsl:template name="search_members">
		<xsl:value-of select="$string[$mmbasestring + 1]"/>

		<form name="frmgrpchKB" action="default.asp?ACT=80&amp;id=0&amp;kind=search" method="post">
			<table widht="100%">
				<tr>
					<td><xsl:value-of select="$string[$mmbasestring + 2]"/>: </td><td><input type="text" size="20" name="search_pseudo" /></td>
				</tr>
				<tr>
					<td><xsl:value-of select="$string[$mmbasestring + 3]"/>: </td><td><select name="search_sex" ><option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
					<xsl:for-each select="document($listfile)//lists/list[name='Sex']/entries/entry">
						<xsl:sort select="caption" data-type="text" order="ascending"/>
							<xsl:variable name="sex" select="value"/>
							<xsl:if test="count(document($memberfile)//member[usersex=$sex and userpublic='on']) &gt; 0">
								<option value="{value}"><xsl:value-of select="caption"/></option>
							</xsl:if>
					</xsl:for-each>
				</select></td>
				</tr>
				<tr>
					<td><xsl:value-of select="$string[$mmbasestring + 4]"/>: </td><td><select name="search_age" ><option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
					<xsl:for-each select="document($listfile)//lists/list[name='Age']/entries/entry">
						<xsl:sort select="caption" data-type="text" order="ascending"/>
							<xsl:variable name="age" select="value"/>
							<xsl:if test="count(document($memberfile)//member[userage=$age and userpublic='on']) &gt; 0">
								<option value="{value}"><xsl:value-of select="caption"/></option>
							</xsl:if>
					</xsl:for-each>
				</select></td>
				</tr>
				<tr>
					<td><xsl:value-of select="$string[$mmbasestring + 5]"/>: </td><td><select name="search_ocup" ><option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
					<xsl:for-each select="document($listfile)//lists/list[name='Ocupation']/entries/entry">
						<xsl:sort select="caption" data-type="text" order="ascending"/>
							<xsl:variable name="ocupation" select="value"/>
							<xsl:if test="count(document($memberfile)//member[userocupation=$ocupation and userpublic='on']) &gt; 0">
								<option value="{value}"><xsl:value-of select="caption"/></option>
							</xsl:if>
					</xsl:for-each>
				</select></td>
				</tr>
				<tr>
					<td><xsl:value-of select="$string[$mmbasestring + 6]"/>: </td><td><input type="text" size="30" name="search_ville"/></td>
				</tr>
				<tr>
					<td><xsl:value-of select="$string[$mmbasestring + 7]"/>: </td><td><input type="text" size="30" name="search_state"/></td>
				</tr>
				<tr>
					<td><xsl:value-of select="$string[$mmbasestring + 8]"/>: </td><td><select name="search_country" ><option value="" selected="selected"><xsl:value-of select="$string[$mmbasestring + 17]"/></option>
					<xsl:for-each select="document($listfile)//lists/list[name='Countries']/entries/entry">
						<xsl:sort select="caption" data-type="text" order="ascending"/>
							<xsl:variable name="country" select="value"/>
							<xsl:if test="count(document($memberfile)//member[usercountry=$country and userpublic='on']) &gt; 0">
								<option value="{value}"><xsl:value-of select="caption"/></option>
							</xsl:if>
					</xsl:for-each>
				</select></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="{$string[306]}"/></td>
				</tr>

			</table>
		</form>
	<a href="default.asp?ACT=80&amp;id=0&amp;kind=all"> <xsl:value-of select="$string[$mmbasestring + 10]"/> </a>
	</xsl:template>



	<!-- Base table for results display  -->
	<!-- if a value is inserted at "user pseudo" it call profile for that user otherwise it search all of them -->
	<xsl:template name="search_results">
	<xsl:variable name="up" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÜÄÖéèà'" />
	<xsl:variable name="low" select="'abcdefghijklmnopqrstuvwxyzüäöeea'" />
	<xsl:variable name="lowsearch_ville" select="translate($search_ville,$up,$low)" />
	<xsl:variable name="lowsearch_state" select="translate($search_state,$up,$low)" />
	<xsl:variable name="lowsearch_pseudo" select="translate($search_pseudo,$up,$low)" />
	<xsl:choose>
		<xsl:when test="string-length($search_pseudo) &gt; 0">
			<xsl:choose>
       				<xsl:when test="count(document($memberfile)//members/member[userpublic='on'and visible='on' and contains(translate(pseudo,$up,$low),$lowsearch_pseudo)]) &gt; 1">
 					<table width="100%" cellpadding="2">
						<tr align="center" height="20" bgcolor="{$toolbar_background}">
				    			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 2]"/></a></td>
     							<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 9]"/></a></td>
							<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 8]"/></a></td>
							<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 7]"/></a></td>
							<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 6]"/></a></td>
						</tr>
						<xsl:for-each select="document($memberfile)//members/member[userpublic='on'and visible='on' and contains(translate(pseudo,$up,$low),$lowsearch_pseudo)]">
							<xsl:call-template name = "memb_results">
								<xsl:with-param name="memb_id"><xsl:value-of select="id"/></xsl:with-param>
							</xsl:call-template>
			    			</xsl:for-each>
					</table>
				</xsl:when>
				<xsl:when test="count(document($memberfile)//members/member[userpublic='on'and visible='on' and contains(translate(pseudo,$up,$low),$lowsearch_pseudo)]) = 1">
			       		<xsl:call-template name = "redirect">
						<xsl:with-param name="url">default.asp?ACT=81&amp;member=<xsl:value-of select="document($memberfile)//members/member[userpublic='on'and visible='on' and contains(translate(pseudo,$up,$low),$lowsearch_pseudo)]/id" />&amp;id=0</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name = "redirect">
						<xsl:with-param name="url">default.asp?ACT=81&amp;member=error&amp;id=0</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<table width="100%" cellpadding="2">
				<tr align="center" height="20" bgcolor="{$toolbar_background}">
					<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 2]"/></a></td>
					<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 9]"/></a></td>
					<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 8]"/></a></td>
					<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 7]"/></a></td>
					<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 6]"/></a></td>
				</tr>
				<xsl:for-each select="document($memberfile)//members/member[userpublic='on'and visible='on']">
    				<xsl:sort select="pseudo" data-type="text" order="ascending"/>
					<xsl:call-template name = "memb_search" >
						<xsl:with-param name="round">1</xsl:with-param>
						<xsl:with-param name="memb_id"><xsl:value-of select="id" /></xsl:with-param>
						<xsl:with-param name="memb_sex"><xsl:value-of select="usersex" /></xsl:with-param>
						<xsl:with-param name="memb_age"><xsl:value-of select="userage" /></xsl:with-param>
						<xsl:with-param name="memb_ocup"><xsl:value-of select="userocupation" /></xsl:with-param>
						<xsl:with-param name="memb_ville"><xsl:value-of select="translate(ville,$up,$low)" /></xsl:with-param>
						<xsl:with-param name="memb_state"><xsl:value-of select="translate(userstate,$up,$low)" /></xsl:with-param>
						<xsl:with-param name="memb_country"><xsl:value-of select="usercountry" /></xsl:with-param>
						<xsl:with-param name="lowsearch_ville"><xsl:value-of select="$lowsearch_ville"/></xsl:with-param>
						<xsl:with-param name="lowsearch_state"><xsl:value-of select="$lowsearch_state"/></xsl:with-param>
 					</xsl:call-template>
				</xsl:for-each>
			</table>
		</xsl:otherwise>
	</xsl:choose>
	</xsl:template>
	
	<!-- Search template  -->
 	<xsl:template name="memb_search">
	<xsl:param name="round"/>
	<xsl:param name="memb_id"/>
	<xsl:param name="memb_sex"/>
	<xsl:param name="memb_age"/>
	<xsl:param name="memb_ocup"/>
	<xsl:param name="memb_ville"/>
	<xsl:param name="memb_state"/>
	<xsl:param name="memb_country"/>
	<xsl:param name="lowsearch_ville"/>
	<xsl:param name="lowsearch_state"/>	
	<xsl:choose>
			<xsl:when test="$round='1'">
				<xsl:if test="string-length($search_sex) = 0 or (string-length($search_sex) &gt; 0 and contains($memb_sex, $search_sex))">
					<xsl:call-template name = "memb_search">
						<xsl:with-param name="round">2</xsl:with-param>
						<xsl:with-param name="memb_id"><xsl:value-of select="$memb_id" /></xsl:with-param>
						<xsl:with-param name="memb_age"><xsl:value-of select="$memb_age" /></xsl:with-param>
						<xsl:with-param name="memb_ocup"><xsl:value-of select="$memb_ocup" /></xsl:with-param>
						<xsl:with-param name="memb_ville"><xsl:value-of select="$memb_ville" /></xsl:with-param>
						<xsl:with-param name="memb_state"><xsl:value-of select="$memb_state" /></xsl:with-param>
						<xsl:with-param name="memb_country"><xsl:value-of select="$memb_country" /></xsl:with-param>
						<xsl:with-param name="lowsearch_ville"><xsl:value-of select="$lowsearch_ville"/></xsl:with-param>
						<xsl:with-param name="lowsearch_state"><xsl:value-of select="$lowsearch_state"/></xsl:with-param>
 					</xsl:call-template>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$round='2'">
				<xsl:if test="string-length($search_age) = 0 or (string-length($search_age) &gt; 0 and contains($memb_age, $search_age))">
					<xsl:call-template name = "memb_search">
						<xsl:with-param name="round">3</xsl:with-param>
						<xsl:with-param name="memb_id"><xsl:value-of select="$memb_id" /></xsl:with-param>
						<xsl:with-param name="memb_ocup"><xsl:value-of select="$memb_ocup" /></xsl:with-param>
						<xsl:with-param name="memb_ville"><xsl:value-of select="$memb_ville" /></xsl:with-param>
						<xsl:with-param name="memb_state"><xsl:value-of select="$memb_state" /></xsl:with-param>
						<xsl:with-param name="memb_country"><xsl:value-of select="$memb_country" /></xsl:with-param>
						<xsl:with-param name="lowsearch_ville"><xsl:value-of select="$lowsearch_ville"/></xsl:with-param>
						<xsl:with-param name="lowsearch_state"><xsl:value-of select="$lowsearch_state"/></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$round='3'">
				<xsl:if test="string-length($search_ocup) = 0 or (string-length($search_ocup) &gt; 0 and contains($memb_ocup, $search_ocup))">
					<xsl:call-template name = "memb_search">
						<xsl:with-param name="round">4</xsl:with-param>
						<xsl:with-param name="memb_id"><xsl:value-of select="$memb_id" /></xsl:with-param>
						<xsl:with-param name="memb_ville"><xsl:value-of select="$memb_ville" /></xsl:with-param>
						<xsl:with-param name="memb_state"><xsl:value-of select="$memb_state" /></xsl:with-param>
						<xsl:with-param name="memb_country"><xsl:value-of select="$memb_country" /></xsl:with-param>
						<xsl:with-param name="lowsearch_ville"><xsl:value-of select="$lowsearch_ville"/></xsl:with-param>
						<xsl:with-param name="lowsearch_state"><xsl:value-of select="$lowsearch_state"/></xsl:with-param>
 					</xsl:call-template>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$round='4'">
				<xsl:if test="string-length($search_ville) = 0 or (string-length($search_ville) &gt; 0 and contains($memb_ville, $lowsearch_ville))">
					<xsl:call-template name = "memb_search">
						<xsl:with-param name="round">5</xsl:with-param>
						<xsl:with-param name="memb_id"><xsl:value-of select="$memb_id" /></xsl:with-param>
						<xsl:with-param name="memb_state"><xsl:value-of select="$memb_state" /></xsl:with-param>
						<xsl:with-param name="memb_country"><xsl:value-of select="$memb_country" /></xsl:with-param>
						<xsl:with-param name="lowsearch_state"><xsl:value-of select="$lowsearch_state"/></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$round='5'">
				<xsl:if test="string-length($search_state) = 0 or (string-length($search_state) &gt; 0 and contains($memb_state, $lowsearch_state))">
					<xsl:call-template name = "memb_search">
						<xsl:with-param name="round">6</xsl:with-param>
						<xsl:with-param name="memb_id"><xsl:value-of select="$memb_id" /></xsl:with-param>
						<xsl:with-param name="memb_country"><xsl:value-of select="$memb_country" /></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$round='6'">
				<xsl:if test="string-length($search_country) = 0 or (string-length($search_country) &gt; 0 and contains($memb_country, $search_country))">
					<xsl:call-template name = "memb_results">
						<xsl:with-param name="memb_id"><xsl:value-of select="$memb_id"/></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
  	</xsl:template>


	<!-- results display  -->
	<xsl:template name="memb_results">
	<xsl:param name="memb_id" />
	<xsl:variable name="email_object" select="$DataFilePointer//siteinfo/data/emailCOM"/>	

	<xsl:for-each select="document($memberfile)//members/member[userpublic='on' and id=$memb_id]">
		<tr>
			<td>
			<xsl:choose>
				<xsl:when test="userpublic='on'"><a href="default.asp?ACT=81&amp;member={id}&amp;id=0"><xsl:value-of select="pseudo"/></a></xsl:when>
				<xsl:when test="userpublic='off' and $email_object!='off'"><a href="default.asp?ACT=25&amp;member={id}&amp;id=0"><xsl:value-of select="pseudo"/></a></xsl:when>
				<xsl:otherwise><xsl:value-of select="pseudo"/></xsl:otherwise>
			</xsl:choose>

			</td>
			<td align="center"><xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime"><xsl:value-of select="date" /></xsl:with-param></xsl:call-template></td>
			<td><a href="default.asp?ACT=80&amp;id=0&amp;kind=country&amp;name={usercountry}"><xsl:value-of select="usercountry" /></a></td>
			<td><a href="default.asp?ACT=80&amp;id=0&amp;kind=state&amp;name={userstate}"><xsl:value-of select="userstate" /></a></td>
			<td><a href="default.asp?ACT=80&amp;id=0&amp;kind=ville&amp;name={ville}"><xsl:value-of select="ville" /></a></td>
		</tr>
		</xsl:for-each>
	</xsl:template>

	<!-- List of all members with public available profiles -->
	<xsl:template name="all_members">
	<xsl:variable name="email_object" select="$DataFilePointer//siteinfo/data/emailCOM"/>
	
	<table width="100%" cellpadding="2">
		<tr align="center" height="20" bgcolor="{$toolbar_background}">
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 2]"/></a></td>
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 9]"/></a></td>
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 8]"/></a></td>
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 7]"/></a></td>
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 6]"/></a></td>
		</tr>
		<xsl:for-each select="document($memberfile)//members/member[userpublic='on' and visible='on']">
		<xsl:sort select="pseudo"/>
		<xsl:if test="position() &gt; number($page*$member_pagesize) and position() &lt;=  number(($page+1)*$member_pagesize) ">
		<tr>
			<td>
				<xsl:call-template name="call_user">					
					<xsl:with-param name="RefPseudo" select="pseudo" />
					<xsl:with-param name="RefId" select="id" />
				</xsl:call-template>

			</td>
			<td align="center"><xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime"><xsl:value-of select="date" /></xsl:with-param></xsl:call-template></td>
			<td><a href="default.asp?ACT=80&amp;id=0&amp;kind=country&amp;name={usercountry}"><xsl:value-of select="usercountry" /></a></td>
			<td><a href="default.asp?ACT=80&amp;id=0&amp;kind=state&amp;name={userstate}"><xsl:value-of select="userstate" /></a></td>
			<td><a href="default.asp?ACT=80&amp;id=0&amp;kind=ville&amp;name={ville}"><xsl:value-of select="ville" /></a></td>
		</tr>
		</xsl:if>
		</xsl:for-each>
	<tr><td colspan="5" align="center"><br /><xsl:call-template name="paging_Rail_macro">
		<xsl:with-param name="totalpage" select="count(document($memberfile)//members/member[userpublic='on']) div $member_pagesize"/>
			<xsl:with-param name="currentpage" select="number($page)+1"/>
			<xsl:with-param name="url">default.asp?ACT=80&amp;id=0&amp;kind=all</xsl:with-param>
	</xsl:call-template>
	</td></tr>
	</table>	
	</xsl:template>
	
	<!-- List of all members with public available profiles in a specific country -->
	<xsl:template name="country_members">
	<xsl:param name="country" />
	<xsl:variable name="email_object" select="$DataFilePointer//siteinfo/data/emailCOM"/>
	
	<table width="100%" cellpadding="2">
		<tr align="center" height="20" bgcolor="{$toolbar_background}">
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 2]"/></a></td>
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 9]"/></a></td>
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 8]"/></a></td>
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 7]"/></a></td>
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 6]"/></a></td>
		</tr>
		<xsl:for-each select="document($memberfile)//members/member[userpublic='on' and visible='on' and usercountry=$country]">
		<xsl:sort select="pseudo"/>
		<xsl:if test="position() &gt; number($page*$member_pagesize) and position() &lt;=  number(($page+1)*$member_pagesize) ">
		<tr>
			<td>
			<xsl:choose>
				<xsl:when test="userpublic='on'"><a href="default.asp?ACT=81&amp;member={id}&amp;id=0"><xsl:value-of select="pseudo"/></a></xsl:when>
				<xsl:when test="userpublic='off' and $email_object!='off'"><a href="default.asp?ACT=25&amp;member={id}&amp;id=0"><xsl:value-of select="pseudo"/></a></xsl:when>
				<xsl:otherwise><xsl:value-of select="pseudo"/></xsl:otherwise>
			</xsl:choose>

			</td>
			<td align="center"><xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime"><xsl:value-of select="date" /></xsl:with-param></xsl:call-template></td>
			<td><a href="default.asp?ACT=80&amp;id=0&amp;kind=country&amp;name={usercountry}"><xsl:value-of select="usercountry" /></a></td>
			<td><a href="default.asp?ACT=80&amp;id=0&amp;kind=state&amp;name={userstate}"><xsl:value-of select="userstate" /></a></td>
			<td><a href="default.asp?ACT=80&amp;id=0&amp;kind=ville&amp;name={ville}"><xsl:value-of select="ville" /></a></td>
		</tr>
		</xsl:if>
		</xsl:for-each>
	<tr><td colspan="5" align="center"><br /><xsl:call-template name="paging_Rail_macro">
		<xsl:with-param name="totalpage" select="count(document($memberfile)//members/member[userpublic='on' and usercountry=$country]) div $member_pagesize"/>
			<xsl:with-param name="currentpage" select="number($page)+1"/>
			<xsl:with-param name="url">default.asp?ACT=80&amp;id=0&amp;kind=country&amp;name=<xsl:value-of select="$country"/></xsl:with-param>
	</xsl:call-template>
	</td></tr>
	</table>	
	</xsl:template>	


	<!-- List of all members with public available profiles in a specific city -->	
	<xsl:template name="ville_members">
	<xsl:param name="ville" />
	<xsl:variable name="email_object" select="$DataFilePointer//siteinfo/data/emailCOM"/>
	
	<table width="100%" cellpadding="2">
		<tr align="center" height="20" bgcolor="{$toolbar_background}">
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 2]"/></a></td>
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 9]"/></a></td>
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 8]"/></a></td>
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 7]"/></a></td>
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 6]"/></a></td>
		</tr>
		<xsl:for-each select="document($memberfile)//members/member[userpublic='on' and visible='on' and ville=$ville]">
		<xsl:sort select="pseudo"/>
		<xsl:if test="position() &gt; number($page*$member_pagesize) and position() &lt;=  number(($page+1)*$member_pagesize) ">
		<tr>
			<td>
			<xsl:choose>
				<xsl:when test="userpublic='on'"><a href="default.asp?ACT=81&amp;member={id}&amp;id=0"><xsl:value-of select="pseudo"/></a></xsl:when>
				<xsl:when test="userpublic='off' and $email_object!='off'"><a href="default.asp?ACT=25&amp;member={id}&amp;id=0"><xsl:value-of select="pseudo"/></a></xsl:when>
				<xsl:otherwise><xsl:value-of select="pseudo"/></xsl:otherwise>
			</xsl:choose>

			</td>
			<td align="center"><xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime"><xsl:value-of select="date" /></xsl:with-param></xsl:call-template></td>
			<td><a href="default.asp?ACT=80&amp;id=0&amp;kind=country&amp;name={usercountry}"><xsl:value-of select="usercountry" /></a></td>
			<td><a href="default.asp?ACT=80&amp;id=0&amp;kind=state&amp;name={userstate}"><xsl:value-of select="userstate" /></a></td>
			<td><a href="default.asp?ACT=80&amp;id=0&amp;kind=ville&amp;name={ville}"><xsl:value-of select="ville" /></a></td>
		</tr>
		</xsl:if>
		</xsl:for-each>
	<tr><td colspan="5" align="center"><br /><xsl:call-template name="paging_Rail_macro">
		<xsl:with-param name="totalpage" select="count(document($memberfile)//members/member[userpublic='on' and ville=$ville]) div $member_pagesize"/>
			<xsl:with-param name="currentpage" select="number($page)+1"/>
			<xsl:with-param name="url">default.asp?ACT=80&amp;id=0&amp;kind=ville&amp;name=<xsl:value-of select="$ville"/></xsl:with-param>
	</xsl:call-template>
	</td></tr>
	</table>
	</xsl:template>

	<!-- List of all members with public available profiles in a specific state -->
	<xsl:template name="state_members">
	<xsl:param name="state" />
	<xsl:variable name="email_object" select="$DataFilePointer//siteinfo/data/emailCOM"/>
	
	<table width="100%" cellpadding="2">
		<tr align="center" height="20" bgcolor="{$toolbar_background}">
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 2]"/></a></td>
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 9]"/></a></td>
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 8]"/></a></td>
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 7]"/></a></td>
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 6]"/></a></td>
		</tr>
		<xsl:for-each select="document($memberfile)//members/member[userpublic='on' and visible='on' and userstate=$state]">
		<xsl:sort select="pseudo"/>
		<xsl:if test="position() &gt; number($page*$member_pagesize) and position() &lt;=  number(($page+1)*$member_pagesize) ">
		<tr>
			<td>
			<xsl:choose>
				<xsl:when test="userpublic='on'"><a href="default.asp?ACT=81&amp;member={id}&amp;id=0"><xsl:value-of select="pseudo"/></a></xsl:when>
				<xsl:when test="userpublic='off' and $email_object!='off'"><a href="default.asp?ACT=25&amp;member={id}&amp;id=0"><xsl:value-of select="pseudo"/></a></xsl:when>
				<xsl:otherwise><xsl:value-of select="pseudo"/></xsl:otherwise>
			</xsl:choose>

			</td>
			<td align="center"><xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime"><xsl:value-of select="date" /></xsl:with-param></xsl:call-template></td>
			<td><a href="default.asp?ACT=80&amp;id=0&amp;kind=country&amp;name={usercountry}"><xsl:value-of select="usercountry" /></a></td>
			<td><a href="default.asp?ACT=80&amp;id=0&amp;kind=state&amp;name={userstate}"><xsl:value-of select="userstate" /></a></td>
			<td><a href="default.asp?ACT=80&amp;id=0&amp;kind=ville&amp;name={ville}"><xsl:value-of select="ville" /></a></td>
		</tr>
		</xsl:if>
		</xsl:for-each>
	<tr><td colspan="5" align="center"><br /><xsl:call-template name="paging_Rail_macro">
		<xsl:with-param name="totalpage" select="count(document($memberfile)//members/member[userpublic='on' and state=$state]) div $member_pagesize"/>
			<xsl:with-param name="currentpage" select="number($page)+1"/>
			<xsl:with-param name="url">default.asp?ACT=80&amp;id=0&amp;kind=state&amp;name=<xsl:value-of select="$state"/></xsl:with-param>
	</xsl:call-template>
	</td></tr>
	</table>
	</xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--     specific member templates        -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

	<!-- Main procedure -->
	<xsl:template name="member_profile_acess">
	<xsl:choose>
		
		<xsl:when test="$usertype='anonymous'">
			<br />
			<xsl:value-of select="$string[$mmbasestring + 27]"/>
		</xsl:when>
		<xsl:when test="document($memberfile)//members/member[id=$member and pseudo=$username]">
			<xsl:call-template name="member_profile" />
		</xsl:when>
		<xsl:when test="document($memberfile)//members/member[id=$member and (userpublic='off' or visible!='on')]">
			<br />
			<xsl:value-of select="$string[$mmbasestring + 28]"/>
		</xsl:when>
		<xsl:when test="not(document($memberfile)//members/member[id=$member])">
			<br />
			<xsl:value-of select="$string[$mmbasestring + 28]"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="member_profile" />
		</xsl:otherwise>
	</xsl:choose>
	</xsl:template>


	<!-- Each member profile -->
	<xsl:template name="member_profile">
		<xsl:choose>
			<!-- if there is no one with that pseudo -->
			<xsl:when test="$member='error'">
				<font size="3">
	        	       <br />
	               		<xsl:value-of select="$string[$mmbasestring + 26]"/>
				</font>
			</xsl:when>
			<!-- Specific member profile -->
			<xsl:otherwise>
				<xsl:for-each select="document($memberfile)//members/member[id=$member]">
				<table width="100%" cellpadding="2">
					<tr>
						<xsl:if test="string-length(userphoto) &gt; 0">
							<td rowspan="13" width="150px" align="center" valign="top"><img src="{userphoto}" alt="{pseudo}" width="100" height="150"/></td>
						</xsl:if>		
						<td>
							<font size="3"><b><xsl:value-of select="$string[302]"/>:</b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="pseudo"/></font><hr />
						</td>
					</tr>
					<tr>
						<td>
							<xsl:value-of select="userwellcome" disable-output-escaping="yes"/><hr /><p/>
						</td>
					</tr>
					<tr>
						<td>
							<b><xsl:value-of select="$string[$mmbasestring + 29]"/>:</b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="concat(userfname, ' ' , userlname)"/><p/>
						</td>
					</tr>
					<tr>
						<td>
							<b><xsl:value-of select="$string[$mmbasestring + 15]"/>:</b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><a target="new" href="{userpage}"><xsl:value-of select="userpage"/></a><p/>
						</td>
					</tr>
					<tr>
						<td>
						<b><xsl:value-of select="$string[$mmbasestring + 3]"/>:</b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="usersex"/>
						</td>
					</tr>
					<tr>
						<td>
							<b><xsl:value-of select="$string[$mmbasestring + 4]"/>:</b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="userage"/>
						</td>
					</tr>
					<tr>
						<td>
							<b><xsl:value-of select="$string[$mmbasestring + 5]"/>:</b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="userocupation"/><p/>
						</td>
					</tr>
					<tr>
						<td>
							<b><xsl:value-of select="$string[$mmbasestring + 20]"/>:</b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="userphone"/>
						</td>
					</tr>
					<tr>
						<td>
							<b><xsl:value-of select="$string[$mmbasestring + 18]"/>:</b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="useradress"/>
						</td>
					</tr>
					<tr>
						<td>
							<b><xsl:value-of select="$string[$mmbasestring + 19]"/>:</b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="userzip"/>
						</td>
					</tr>
					<tr>
						<td>
							<b><xsl:value-of select="$string[305]"/>:</b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="ville"/>
						</td>
					</tr>
					<tr>
						<td>
							<b><xsl:value-of select="$string[$mmbasestring + 7]"/>:</b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="userstate"/>
						</td>
					</tr>
					<tr>
						<td>
							<b><xsl:value-of select="$string[$mmbasestring + 8]"/>:</b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="usercountry"/>
						</td>
					</tr>
					<tr>
						<xsl:if test="string-length(userphoto) &gt; 0 and $username!=pseudo">
							<td colspan="2" align="right">
								<xsl:call-template name="friend_actions">
									<xsl:with-param name="memberID">
										<xsl:value-of select="$member"/>
									</xsl:with-param>
									<xsl:with-param name="action">add</xsl:with-param>
								</xsl:call-template>
							</td>
						</xsl:if>
						<xsl:if test="string-length(userphoto) &gt; 0 and $username=pseudo">
							<td colspan="2" align="right">
								<form>
									<input type="button" value="{$string[474]}" onclick="document.location.href='default.asp?id=0&amp;mnu=1&amp;ACT=22'"/>
								</form>
							</td>
						</xsl:if>
						<xsl:if test="string-length(userphoto) = 0 and $username!=pseudo">		
							<td align="right">
								<xsl:call-template name="friend_actions">
									<xsl:with-param name="memberID">
										<xsl:value-of select="$member"/>
									</xsl:with-param>
									<xsl:with-param name="action">add</xsl:with-param>
								</xsl:call-template>
							</td>
						</xsl:if>
						<xsl:if test="string-length(userphoto) = 0 and $username=pseudo">
							<td align="right">
								<form>
									<input type="button" value="{$string[474]}" onclick="document.location.href='default.asp?id=0&amp;mnu=1&amp;ACT=22'"/>
								</form>
							</td>
						</xsl:if>
					</tr>
				</table>
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>
	</xsl:template>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--          friends templates           -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

	<!-- Main procedure -->
	<xsl:template name="friends_manager">
		<xsl:choose>
			<xsl:when test="$kind='add'">
				<br />
				<b><xsl:value-of select="document($memberfile)//members/member[id=$member]/pseudo"/></b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[$mmbasestring + 31]"/>
			</xsl:when>
			<xsl:when test="$kind='del'">
				<br />
				<b><xsl:value-of select="document($memberfile)//members/member[id=$member]/pseudo"/></b><xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[$mmbasestring + 32]"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="friends_list_design"/>
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>



	<!-- Actions you can perform with friends -->
	<xsl:template name="friend_actions">
	<xsl:param name="email_object" select="$DataFilePointer//siteinfo/data/emailCOM"/>
	<xsl:param name="int_messages" select="$DataFilePointer//siteinfo/data/useinternalmessages"/>
	<xsl:param name="member_manager" select="$DataFilePointer//siteinfo/data/membermanager"/>
	<xsl:param name="myid" select="document($memberfile)//members/member[pseudo=$username]/id"/>
	<xsl:param name="memberID" />
	<xsl:param name="action" />

		<table cellpadding="0" cellspacing="1">
			<tr>
				<xsl:if test="$action='add' and count(document($friendsfile)//friends/friend[user=$myid and userfriend=$memberID])=0 and $member_manager!='off'">
				<td>
					<form method="post" Action="default.asp?ACT=82&amp;id=1&amp;kind=add&amp;member={$memberID}">
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="file" value="friends"/>
						<input type="hidden" name="bloc" value="friends"/>
						<input type="hidden" name="node" value="friend"/>
						<input type="hidden" name="user" value="{document($memberfile)//members/member[pseudo=$username]/id}"/>
						<input type="hidden" name="userfriend" value="{$memberID}"/>
						<input type="submit" class="mini" value="{$string[$mmbasestring + 30]}" />
					</form>
				</td>
				</xsl:if>
				<xsl:if test="$action='delete'">
				<td>
					<form method="post" action="default.asp?ACT=82&amp;id=1&amp;kind=del&amp;member={$memberID}">
						<input type="hidden" name="operation" value="delete"/>
						<input type="hidden" name="file" value="friends"/>
						<input type="hidden" name="bloc" value="friends"/>
						<input type="hidden" name="node" value="friends/friend[userfriend={$memberID}]"/>
						<input type="submit" class="mini" value="{$string[$mmbasestring + 37]}" />
					</form>
				</td>
				</xsl:if>
				<xsl:if test="$int_messages='on'">
				<td align="right">
					<form>
						<input type="button" class="mini" Value="{$string[$mmbasestring + 38]}" Onclick="document.location.href='default.asp?ACT=83&amp;member={$memberID}&amp;item=new'"/>
					</form>
				</td>
				</xsl:if>
				<xsl:if test="$email_object!='off'">
				<td align="right">
					<form>
						<input type="button" class="mini" value="{$string[$mmbasestring + 39]}" onclick="document.location.href='default.asp?ACT=25&amp;member={$memberID}'"/>
					</form>
				</td>
				</xsl:if>
			</tr>
		</table>
	</xsl:template>

	<!-- Friends lists -->
	<xsl:template name="friends_list_design">
		<xsl:param name="myid" select="document($memberfile)//members/member[pseudo=$username]/id"/>
		<br/>
		<table width="100%" cellpadding="0" cellspacing="0" align="center">
			<tr align="center" height="15" bgcolor="{$toolbar_background}">
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 2]"/></a></td>
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 9]"/></a></td>
			<td><a class="toolbar"><xsl:value-of select="$string[$mmbasestring + 36]"/></a></td>
			</tr>
			<tr/>
			<xsl:for-each select="document($friendsfile)//friends/friend[user=$myid]">
				<xsl:sort select="friend" data-type="text" order="ascending"/>
				<xsl:if test="position() &gt; number($page*$friends_pagesize) and position() &lt;=  number(($page+1)*$friends_pagesize)">
					<tr>
						<td><xsl:call-template name="call_user"><xsl:with-param name="RefId" select="userfriend"/></xsl:call-template></td>
						<td align="center"><xsl:call-template name="display_datetime"><xsl:with-param name="p_DateTime"><xsl:value-of select="date"/></xsl:with-param></xsl:call-template></td>
						<td align="right"><xsl:call-template name="friend_actions"><xsl:with-param name="memberID"><xsl:value-of select="userfriend"/></xsl:with-param><xsl:with-param name="action">delete</xsl:with-param>	</xsl:call-template></td>
					</tr>
				</xsl:if>
			</xsl:for-each>
			<xsl:if test="count(document($friendsfile)//friends/friend[user=$myid]) &gt; $friends_pagesize">
				<tr><td colspan="3" align="center">
					<!-- Navigation for the messages Paging -->
					<xsl:call-template name="paging_Rail_macro">
						<xsl:with-param name="totalpage" select="count(document($friendsfile)//friends/friend[user=$myid]) div $friends_pagesize"/>
						<xsl:with-param name="currentpage" select="number($page)+1"/>
						<xsl:with-param name="url">default.asp?id=0&amp;ACT=82</xsl:with-param>
					</xsl:call-template>
				</td></tr>
			</xsl:if>
		</table>
	</xsl:template>



</xsl:stylesheet>
