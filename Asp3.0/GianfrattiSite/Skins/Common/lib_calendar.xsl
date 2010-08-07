<?xml version="1.0" encoding="ISO-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:output method="html" indent="yes" />

<!-- last modified : 2003/09/14, by Jens Schreiber -->
<!-- version 0.7 -->


   	<xsl:param name="calendar_eventlistitems"><xsl:value-of select="document($calendarfile)/eventcalendar/calendar[id=$calendar]/evtcount" /></xsl:param>
   	<xsl:param name="calendar_previewlistitems"><xsl:value-of select="document($calendarfile)/eventcalendar/calendar[id=$calendar]/prevevtcount" /></xsl:param>

	<xsl:variable name="evtdate">
		<xsl:choose>
			<xsl:when test="string-length($eventdate) &gt; 0">
				<xsl:value-of select="$eventdate" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="substring($actualdate, 1, 8)" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
   
   <xsl:template name="monthoffset">
      <xsl:param name="month" />

      <xsl:choose>
         <xsl:when test="$month= 1">0</xsl:when>

         <xsl:when test="$month= 2">3</xsl:when>

         <xsl:when test="$month= 3">3</xsl:when>

         <xsl:when test="$month= 4">6</xsl:when>

         <xsl:when test="$month= 5">1</xsl:when>

         <xsl:when test="$month= 6">4</xsl:when>

         <xsl:when test="$month= 7">6</xsl:when>

         <xsl:when test="$month= 8">2</xsl:when>

         <xsl:when test="$month= 9">5</xsl:when>

         <xsl:when test="$month=10">0</xsl:when>

         <xsl:when test="$month=11">3</xsl:when>

         <xsl:when test="$month=12">5</xsl:when>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="monthlength">
      <xsl:param name="month" />

      <xsl:param name="leap" select="false()" />

      <xsl:choose>
         <xsl:when test="$month= 2 and $leap">29</xsl:when>

         <xsl:when test="$month= 2 and not($leap)">28</xsl:when>

         <xsl:when test="$month= 4">30</xsl:when>

         <xsl:when test="$month= 6">30</xsl:when>

         <xsl:when test="$month= 9">30</xsl:when>

         <xsl:when test="$month=11">30</xsl:when>

         <xsl:otherwise>31</xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   	<xsl:template name="isleap">
      	<xsl:param name="year" />
      	<xsl:value-of select="(1 + $year + (floor($year div 4)) - (floor($year div 100)) + (floor($year div 400))) mod 7" />
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--              show event              -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="showeventdetail">
		<table>
			<tr>
				<td>
					<font size="3"><xsl:value-of select="shortdesc" /></font>
					<xsl:if test="$usertype='administrator'">
               			<xsl:value-of select="$nbsp" disable-output-escaping="yes" />
						<a href="default.asp?ACT=1&amp;SECT=M91&amp;calendar={$calendar}&amp;id={id}&amp;type=event">
                  			<img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit" />
               			</a>
            		</xsl:if>
				</td>
			</tr>
			<tr>
				<td>
					<xsl:value-of select="description" disable-output-escaping="yes"/>					
            	</td>
			</tr>
			<xsl:if test="string-length(link) &gt; 0">
				<tr>
					<td>
						<xsl:value-of select="$string[$ecbasestring + 23]"/>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
						<a href="{link}" target="_blank"><xsl:value-of select="link" /></a>
					</td>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--         show event list of day       -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="showevent">
		<xsl:param name="date">0</xsl:param>
		<xsl:param name="eventid">0</xsl:param>
	
		<xsl:choose>
			<xsl:when test="$date!=0">
				<xsl:for-each select = "document($calendarfile)/eventcalendar/calendar[id=$calendar]/event[visible='on' and eventdate = $date]">
					<xsl:call-template name = "showeventdetail" />
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$eventid!=0">
				<xsl:for-each select = "document($calendarfile)/eventcalendar/calendar[id=$calendar]/event[visible='on' and id = $eventid]">
					<xsl:call-template name = "showeventdetail" />
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--     show short event list of day   -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="dayeventlist">
		<xsl:param name="date" />
				
		<xsl:for-each select = "document($calendarfile)/eventcalendar/calendar[id=$calendar]/event[visible='on' and eventdate = $date]">
			<xsl:value-of select="shortdesc" />
		</xsl:for-each>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--     show short event list of month   -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="montheventlist">
		<xsl:param name="month" />
		<xsl:param name="page">1</xsl:param>
		
		<xsl:variable name="startpos"><xsl:value-of select="($page - 1) * $calendar_eventlistitems"/></xsl:variable>
		<xsl:variable name="endpos"><xsl:value-of select="$page * $calendar_eventlistitems + 1"/></xsl:variable>
		
		<xsl:variable name="global">
			<xsl:value-of select="count(document($calendarfile)/eventcalendar/calendar[id=$calendar]/event[visible='on' and substring(eventdate, 1, 6) = $month])"/>
		</xsl:variable>		
		
		<tr>
			<td width="50%" align="left">
				<xsl:if test="$startpos &gt; 0">
					<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={$calendar}&amp;eventdate={$evtdate}&amp;eventpage={$page - 1}&amp;previewpage={$previewpage}"><xsl:value-of select="$string[$ecbasestring + 35]" /></a>
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</xsl:if>
			</td>
			<td width="50%" align="right">
				<xsl:if test="$endpos &lt;= $global">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={$calendar}&amp;eventdate={$evtdate}&amp;eventpage={$page + 1}&amp;previewpage={$previewpage}"><xsl:value-of select="$string[$ecbasestring + 36]" /></a>
				</xsl:if>
			</td>
		</tr>
		<xsl:for-each select = "document($calendarfile)/eventcalendar/calendar[id=$calendar]/event[visible='on' and substring(eventdate, 1, 6) = $month]">
			<xsl:sort select="eventdate"/>
			<xsl:if test="position() &gt; $startpos and position() &lt; $endpos">
				<tr>
					<td colspan="2">
						<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={$calendar}&amp;eventdate={$month}&amp;eventid={id}">
                                                        <xsl:call-template name="display_date"><xsl:with-param name="p_Date" select="eventdate"/></xsl:call-template>
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
							<xsl:value-of select="shortdesc" />
						</a>
					</td>
				</tr>
			</xsl:if>			
		</xsl:for-each>		
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--     show preview list of events      -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="previeweventlist">
		<xsl:param name="date" />
		<xsl:param name="page">1</xsl:param>

		<xsl:variable name="startpos"><xsl:value-of select="($page - 1) * $calendar_previewlistitems"/></xsl:variable>
		<xsl:variable name="endpos"><xsl:value-of select="$page * $calendar_previewlistitems + 1"/></xsl:variable>
		
		<xsl:variable name="global">
			<xsl:value-of select="count(document($calendarfile)/eventcalendar/calendar[id=$calendar]/event[visible='on' and previewdate &lt;= $date and eventdate &gt; $date and eventdate])"/>
		</xsl:variable>
		
		<tr>
			<td width="50%" align="left">
				<xsl:if test="$startpos &gt; 0">
					<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={$calendar}&amp;eventdate={$evtdate}&amp;previewpage={$page - 1}&amp;eventpage={$eventpage}"><xsl:value-of select="$string[$ecbasestring + 35]" /></a>
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</xsl:if>
			</td>
			<td width="50%" align="right">
				<xsl:if test="$endpos &lt;= $global">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
					<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={$calendar}&amp;eventdate={$evtdate}&amp;previewpage={$page + 1}&amp;eventpage={$eventpage}"><xsl:value-of select="$string[$ecbasestring + 36]" /></a>
				</xsl:if>
			</td>
		</tr>
		<xsl:for-each select = "document($calendarfile)/eventcalendar/calendar[id=$calendar]/event[visible='on' and previewdate &lt;= $date and eventdate &gt; $date]">
			<xsl:sort select="eventdate"/>
			<xsl:if test="position() &gt; $startpos and position() &lt; $endpos">
				<tr>
					<td colspan="2">
						<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={$calendar}&amp;eventid={id}">
                                                        <xsl:call-template name="display_date"><xsl:with-param name="p_Date" select="eventdate"/></xsl:call-template>
							<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
							<xsl:value-of select="shortdesc" />
						</a>
					</td>
				</tr>
			</xsl:if>			
		</xsl:for-each>		
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--     exists an event on given day     -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="iseventday">
		<xsl:param name="date" />		
		<xsl:value-of select="document($calendarfile)/eventcalendar/calendar[id=$calendar]/event[visible='on' and eventdate = $date]/eventdate" />
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--            presents a day            -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="day">
		<xsl:param name="val" />
		<xsl:param name="end" select="31" />
		<xsl:param name="month" />
		<xsl:param name="year" />
	
		<xsl:variable name="date">
			<xsl:value-of select="$year" /><xsl:value-of select="$month" /><xsl:value-of select="format-number($val,'00')" />
		</xsl:variable>
		<xsl:variable name="bgcolor">
			<xsl:choose>
				<xsl:when test="$date = substring($actualdate, 1, 8)">
					<xsl:value-of select="$calendar_currentdaybg"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$calendar_background"/>					
				</xsl:otherwise>
			</xsl:choose>	
		</xsl:variable>
		
		<td align="center" bgcolor="{$bgcolor}" style="border: 1px {$calendar_tableborder} solid;">
			<xsl:choose>			
				<xsl:when test="$val &gt; 0 and $end &gt;= $val">					
					
					<xsl:variable name = "eventday">
						<xsl:call-template name = "iseventday" >
							<xsl:with-param name="date">
								<xsl:value-of select="$date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="string-length($eventday)>0">					
							<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={$calendar}&amp;eventdate={$eventday}&amp;eventid=showevents"><xsl:value-of select="$val" /></a>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$val" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</xsl:otherwise>
			</xsl:choose>
		</td>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--           presents a week            -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="week">
		<xsl:param name="start" />
		<xsl:param name="end" select="31" />
		<xsl:param name="month" />
		<xsl:param name="year" />

		<tr>
		    <xsl:call-template name="day">
         		<xsl:with-param name="val" select="$start" />
         		<xsl:with-param name="end" select="$end" />
         		<xsl:with-param name="month" select="$month" />
				<xsl:with-param name="year" select="$year" />
      		</xsl:call-template>
      		
      		<xsl:call-template name="day">
         		<xsl:with-param name="val" select="1 + $start" />
         		<xsl:with-param name="end" select="$end" />
         		<xsl:with-param name="month" select="$month" />
				<xsl:with-param name="year" select="$year" />
      		</xsl:call-template>
      
      		<xsl:call-template name="day">
         		<xsl:with-param name="val" select="2 + $start" />
         		<xsl:with-param name="end" select="$end" />
         		<xsl:with-param name="month" select="$month" />
				<xsl:with-param name="year" select="$year" />
      		</xsl:call-template>
      		
      		<xsl:call-template name="day">
         		<xsl:with-param name="val" select="3 + $start" />
         		<xsl:with-param name="end" select="$end" />
         		<xsl:with-param name="month" select="$month" />
				<xsl:with-param name="year" select="$year" />
      		</xsl:call-template>
      
      		<xsl:call-template name="day">
         		<xsl:with-param name="val" select="4 + $start" />
		        <xsl:with-param name="end" select="$end" />
		        <xsl:with-param name="month" select="$month" />
				<xsl:with-param name="year" select="$year" />
      		</xsl:call-template>
      
      		<xsl:call-template name="day">
         		<xsl:with-param name="val" select="5 + $start" />
				<xsl:with-param name="end" select="$end" />
		        <xsl:with-param name="month" select="$month" />
				<xsl:with-param name="year" select="$year" />
      		</xsl:call-template>
      		
      		<xsl:call-template name="day">
         		<xsl:with-param name="val" select="6 + $start" />
         		<xsl:with-param name="end" select="$end" />
         		<xsl:with-param name="month" select="$month" />
				<xsl:with-param name="year" select="$year" />
      		</xsl:call-template>
		</tr>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--          get name of month           -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
   	<xsl:template name="monthname">
   		<xsl:param name="month"/>
   		<xsl:value-of select="$string[$ecbasestring + 9 + number($month)]"/>
   	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--          presents a month            -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
   	<xsl:template name="showmonth">
      	<xsl:param name="month" />
		<xsl:param name="year" />

		<xsl:variable name="leapyearbefore">
			<xsl:call-template name="isleap">
				<xsl:with-param name="year" select="$year - 1" />
         	</xsl:call-template>
      	</xsl:variable>

      	<xsl:variable name="leapyear">
         	<xsl:call-template name="isleap">
            	<xsl:with-param name="year" select="$year " />
         	</xsl:call-template>
      	</xsl:variable>

      	<xsl:variable name="end">
         	<xsl:call-template name="monthlength">
            	<xsl:with-param name="month" select="$month" />
	            <xsl:with-param name="leap" select="$leapyear = (($leapyearbefore + 2 ) mod 7)" />
			</xsl:call-template>
		</xsl:variable>

      	<xsl:variable name="moff">
         	<xsl:call-template name="monthoffset">
            	<xsl:with-param name="month" select="$month" />
         	</xsl:call-template>
      	</xsl:variable>

      	<xsl:variable name="start">
         	<xsl:choose>
            	<xsl:when test="($leapyear = (($leapyearbefore + 2 ) mod 7)) and ($month &gt; 2)">
               		<xsl:value-of select="($leapyearbefore + $moff + 1) mod 7" />
            	</xsl:when>
            	<xsl:otherwise>
               		<xsl:value-of select="($leapyearbefore + $moff) mod 7" />
            	</xsl:otherwise>
         	</xsl:choose>
      	</xsl:variable>

		<xsl:variable name = "next" >
			<xsl:choose>
				<xsl:when test="($month + 1) &gt; 12">
					<xsl:value-of select="$year + 1" />01
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$year" />
					<xsl:value-of select="format-number($month + 1,'00')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name = "back" >
			<xsl:choose>
				<xsl:when test="($month - 1) &lt; 1">
					<xsl:value-of select="$year - 1" />12
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$year" />
					<xsl:value-of select="format-number($month - 1,'00')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<table width="100%" cellpadding="0" cellspacing="0" style="border: 1px {$calendar_tableborder} solid;">
			<tr height="16" bgcolor="{$toolbar_background}">
				<td>
					<a class="toolbar" href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={$calendar}&amp;eventdate={$back}">&lt;&lt;</a>
				</td>
				<td colspan="5" align="center">
					<font color="{$toolbar_color}"><b>
						<xsl:call-template name="monthname">
							<xsl:with-param name="month">
								<xsl:value-of select="$month" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:value-of select="$nbsp" disable-output-escaping="yes" />
						<xsl:value-of select="$year" />
   					</b></font>
				</td>
				<td align="right">
					<a class="toolbar" href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={$calendar}&amp;eventdate={$next}">&gt;&gt;</a>
				</td>
			</tr>
      		<tr>
				<td align="center" bgcolor="{$calendar_weekdaybg}" style="border: 1px {$calendar_tableborder} solid;"><xsl:value-of select="$string[$ecbasestring + 0]"/></td>
		        <td align="center" bgcolor="{$calendar_weekdaybg}" style="border: 1px {$calendar_tableborder} solid;"><xsl:value-of select="$string[$ecbasestring + 1]"/></td>
				<td align="center" bgcolor="{$calendar_weekdaybg}" style="border: 1px {$calendar_tableborder} solid;"><xsl:value-of select="$string[$ecbasestring + 2]"/></td>
				<td align="center" bgcolor="{$calendar_weekdaybg}" style="border: 1px {$calendar_tableborder} solid;"><xsl:value-of select="$string[$ecbasestring + 3]"/></td>
				<td align="center" bgcolor="{$calendar_weekdaybg}" style="border: 1px {$calendar_tableborder} solid;"><xsl:value-of select="$string[$ecbasestring + 4]"/></td>
				<td align="center" bgcolor="{$calendar_weekdaybg}" style="border: 1px {$calendar_tableborder} solid;"><xsl:value-of select="$string[$ecbasestring + 5]"/></td>
				<td align="center" bgcolor="{$calendar_weekdaybg}" style="border: 1px {$calendar_tableborder} solid;"><xsl:value-of select="$string[$ecbasestring + 6]"/></td>
			</tr>
			
			<xsl:call-template name="week">
				<xsl:with-param name="start" select="1 - $start" />
				<xsl:with-param name="month" select="format-number($month,'00')" />
				<xsl:with-param name="year" select="$year" />
			</xsl:call-template>
		
		      <xsl:call-template name="week">
		         <xsl:with-param name="start" select="8 - $start" />
		         <xsl:with-param name="month" select="format-number($month,'00')" />
				<xsl:with-param name="year" select="$year" />
		      </xsl:call-template>
		
		      <xsl:call-template name="week">
		         <xsl:with-param name="start" select="15 - $start" />
		         <xsl:with-param name="month" select="format-number($month,'00')" />
				<xsl:with-param name="year" select="$year" />
		      </xsl:call-template>
		
		      <xsl:call-template name="week">
		         <xsl:with-param name="start" select="22 - $start" />
		         <xsl:with-param name="month" select="format-number($month,'00')" />
				<xsl:with-param name="year" select="$year" />
		      </xsl:call-template>
		
		      <xsl:call-template name="week">
		         <xsl:with-param name="start" select="29 - $start" />
		         <xsl:with-param name="end" select="$end" />
		         <xsl:with-param name="month" select="format-number($month,'00')" />
				<xsl:with-param name="year" select="$year" />
		      </xsl:call-template>
		
		      <xsl:call-template name="week">
		         	<xsl:with-param name="start" select="36 - $start" />		
		         	<xsl:with-param name="end" select="$end" />
		         	<xsl:with-param name="month" select="format-number($month,'00')" />
					<xsl:with-param name="year" select="$year" />
		      </xsl:call-template>
		</table>
	</xsl:template>
	
	<xsl:template name="buildcalendar">
		<xsl:param name="date"/>
		
		<xsl:choose>
			<xsl:when test="string-length($date) &gt; 0">
				<xsl:call-template name="showmonth">
            		<xsl:with-param name="month" select="number(substring($date,5,2))" />
            		<xsl:with-param name="year" select="number(substring($date,1,4))" />
         		</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="showmonth">
	            	<xsl:with-param name="month" select="1" />
	            	<xsl:with-param name="year" select="year" />
	         	</xsl:call-template>
	
				<xsl:call-template name="showmonth">
					<xsl:with-param name="month" select="2" />		
	            	<xsl:with-param name="year" select="year" />
				</xsl:call-template>
		
	         	<xsl:call-template name="showmonth">
	            	<xsl:with-param name="month" select="3" />		
	            	<xsl:with-param name="year" select="year" />
	         	</xsl:call-template>
	
	         	<xsl:call-template name="showmonth">
	            	<xsl:with-param name="month" select="4" />		
	            	<xsl:with-param name="year" select="year" />
	         	</xsl:call-template>
	
	         	<xsl:call-template name="showmonth">
	            	<xsl:with-param name="month" select="5" />		
	            	<xsl:with-param name="year" select="year" />
	         	</xsl:call-template>
	
	         	<xsl:call-template name="showmonth">
	            	<xsl:with-param name="month" select="6" />		
	            	<xsl:with-param name="year" select="year" />
	         	</xsl:call-template>
	
	         	<xsl:call-template name="showmonth">
	         		<xsl:with-param name="month" select="7" />		
	            	<xsl:with-param name="year" select="year - 1" />
	         	</xsl:call-template>
	
	         	<xsl:call-template name="showmonth">
	            	<xsl:with-param name="month" select="8" />
		            <xsl:with-param name="year" select="year" />
				</xsl:call-template>
	
	         	<xsl:call-template name="showmonth">
	            	<xsl:with-param name="month" select="9" />		
	            	<xsl:with-param name="year" select="year" />
	         	</xsl:call-template>
	
	         	<xsl:call-template name="showmonth">
	            	<xsl:with-param name="month" select="10" />
					<xsl:with-param name="year" select="year" />
	         	</xsl:call-template>
	
	         	<xsl:call-template name="showmonth">
	            	<xsl:with-param name="month" select="11" />
			  		<xsl:with-param name="year" select="year" />
	         	</xsl:call-template>
	
	         	<xsl:call-template name="showmonth">
	            	<xsl:with-param name="month" select="12" />
	            	<xsl:with-param name="year" select="year" />
	         	</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>      
   </xsl:template>
   
	<xsl:template name="calendarsearchform">
		<table cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<form action="default.asp?ACT=4" method="post">
					<input type="hidden" name="kind" value="calendar"/>
					<td align="right">
						<xsl:call-template name="normaltext_design">
							<xsl:with-param name="text">
								<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
								<xsl:value-of select="$string[$ecbasestring + 51]"/>
								<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
								<input type="text" name="keyword" size="8" value="{$keyword}"/>
								<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
								<input type="submit" value="{$string[$ecbasestring + 52]}"/>
							</xsl:with-param>
						</xsl:call-template>
					</td>
				</form>
			</tr>
		</table>
	</xsl:template>
   
   	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--     first line of calendar grid      -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="calendarline">
		<td width="50%">
			<xsl:call-template name="buildcalendar">
				<xsl:with-param name="date" select="$evtdate" />
			</xsl:call-template>
		</td>
		<td valign="top" width="50%">
			<xsl:variable name="month" select="number(substring($evtdate,5,2))" />
			<xsl:variable name="year" select="number(substring($evtdate,1,4))" />
			
			<table width="100%" border="0">
				<tr height="16" bgcolor="{$toolbar_background}">
					<td colspan="2" width="100%">
						<font color="{$toolbar_color}"><b>
							<xsl:value-of select="$string[$ecbasestring + 22]"/>
							<xsl:if test="$usertype='administrator'">
		               			<xsl:value-of select="$nbsp" disable-output-escaping="yes" />
								<a href="default.asp?ACT=1&amp;SECT=M91">
		                  			<img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit" />
		               			</a>
		            		</xsl:if>
						</b></font>
					</td>
				</tr>
				<xsl:call-template name="montheventlist">			
					<xsl:with-param name="month">
						<xsl:value-of select="$year"/>
						<xsl:value-of  select="format-number($month,'00')" />
					</xsl:with-param>
					<xsl:with-param name="page">
						<xsl:choose>
							<xsl:when test="$eventpage">
								<xsl:value-of select="$eventpage"/>
							</xsl:when>
							<xsl:otherwise>1</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</table>
		</td>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--      second line of calendar grid    -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="eventline">
		<xsl:param name="etype">date</xsl:param>
		
		<td valign="top" width="50%">
			<xsl:choose>
				<xsl:when test="$etype='date'">
					<xsl:call-template name="showevent">
						<xsl:with-param name="date" select="$evtdate" />
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="$etype='id'">
					<xsl:call-template name="showevent">
						<xsl:with-param name="eventid" select="$eventid" />
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</td>
		<td valign="top" width="50%">						
			<table width="100%" border="0">
				<tr height="16" bgcolor="{$toolbar_background}">
					<td colspan="2" width="100%">
						<font color="{$toolbar_color}"><b>
							<xsl:value-of select="$string[$ecbasestring + 38]"/>
							<xsl:if test="$usertype='administrator'">
		               			<xsl:value-of select="$nbsp" disable-output-escaping="yes" />
								<a href="default.asp?ACT=1&amp;SECT=M91">
		                  			<img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit" />
		               			</a>
		            		</xsl:if>
						</b></font>
					</td>
				</tr>
				<xsl:call-template name="previeweventlist">
					<xsl:with-param name="date">
						<xsl:value-of select="substring($actualdate,1,8)"/>
					</xsl:with-param>
					<xsl:with-param name="page">
						<xsl:choose>
							<xsl:when test="$previewpage">
								<xsl:value-of select="$previewpage"/>
							</xsl:when>
							<xsl:otherwise>1</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				<tr>
					<td>
						<xsl:call-template name="calendarsearchform"/>					
					</td>
				</tr>
			</table>
		</td>
	</xsl:template>
	
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--             add new event            -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="ec_event_add">
		<table bgcolor="white">
			<form action="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={$calendar}" method="post" name="frmFullxml">
				<tr>
					<td>
						<input type="hidden" name="file" value="calendar"/>
						<input type="hidden" name="operation" value="add"/>
						<input type="hidden" name="bloc" value="eventcalendar/calendar[id={$calendar}]"/>
						<input type="hidden" name="node" value="event"/>
						<input type="hidden" name="visible" value="{/siteinfo/data/calendarstate}"/>

						<table width="100%" class="block">
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 27]"/>:
								</td>
								<td>
									<input type="text" name="shortdesc" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel" valign="top">
									<xsl:value-of select="$string[$ecbasestring + 28]"/>:
								</td>
								<td><xsl:choose>
									<xsl:when test="$usertype='administrator'">
										<textarea  class="textarea" name="description" title="Description"></textarea>
										<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('description');</script></xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<textarea  class="textarea" name="description" title="Description"></textarea>
										<xsl:if test="$oldeditor!='on'"><script language="javascript1.2">editor_generate('description', config);</script></xsl:if>
									</xsl:otherwise>
								</xsl:choose></td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 29]"/>:
								</td>
								<td>
									<input type="text" name="link" class="full"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 31]"/>:
								</td>
								<td>
									<input type="text" name="eventdate" onClick="cal.select(this, 'eventdate', 'yyyyMMdd');" maxlength="8" class="mini"/>
								</td>
							</tr>
							<tr>
								<td class="xp_sel">
									<xsl:value-of select="$string[$ecbasestring + 37]"/>:
								</td>
								<td>
									<input type="text" name="previewdate" onClick="cal.select(this, 'previewdate', 'yyyyMMdd');" maxlength="8" class="mini"/>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="submit" value="{$string[18]}"/><xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
									<input type="button" value="{$string[19]}" onclick="document.location.href='default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={$calendar}';"/>
								</td>
							</tr>
						</table>
						<br/>
					</td>
				</tr>
			</form>
		</table>
	</xsl:template>
	
	<xsl:template name="calendargrid">
		<table width="100%">
			<tr>
				<xsl:call-template name="calendarline"/>
			</tr>
			<tr>
				<xsl:choose>
					<xsl:when test="$eventid='showevents'">
						<xsl:call-template name="eventline">
							<xsl:with-param name="etype">date</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$eventid">
						<xsl:call-template name="eventline">
							<xsl:with-param name="etype">id</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="eventline">
							<xsl:with-param name="etype">no</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<xsl:choose>
						<xsl:when test="$usertype='administrator'">
							<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={$calendar}&amp;eventid=new">
								<xsl:value-of select="$string[$ecbasestring + 39]"/>
							</a>								
						</xsl:when>
						<xsl:when test="$usertype='member'">
							<xsl:if test="document($calendarfile)/eventcalendar/calendar[id=$calendar]/editor!='off' and document($calendarfile)/eventcalendar/calendar[id=$calendar]/editor!='editor'">
								<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={$calendar}&amp;eventid=new">
									<xsl:value-of select="$string[$ecbasestring + 39]"/>
								</a>
							</xsl:if>
						</xsl:when>
						<xsl:when test="$usertype='editor'">
							<xsl:if test="document($calendarfile)/eventcalendar/calendar[id=$calendar]/editor!='off'">
								<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={$calendar}&amp;eventid=new">
									<xsl:value-of select="$string[$ecbasestring + 39]"/>
								</a>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="document($calendarfile)/eventcalendar/calendar[id=$calendar]/editor='anonymous'">
								<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={$calendar}&amp;eventid=new">
									<xsl:value-of select="$string[$ecbasestring + 39]"/>
								</a>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</table>
	</xsl:template>

	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!--      entry point for this module     -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<xsl:template name="eventcalendar">
		<script language="JavaScript" SRC="admin/js/AnchorPosition.js"></script>
		<script language="JavaScript" SRC="admin/js/PopupWindow.js"></script>
		<script language="JavaScript" SRC="admin/js/CalendarPopup.js"></script>
		<script language="JavaScript" SRC="admin/js/date.js"></script>
		<script language="JavaScript" SRC="admin/js/ColorPicker2.js"></script>
		
		<script language="JavaScript">
			// Create CalendarPopup object
			var cal = new CalendarPopup();				
			document.write(cal.getStyles());
		</script>
		
		<style type="text/css">
				table.block {width: 100%; background: white; border: 1px #DDDDDD solid;}
				.category_title {background-image: url(admin/media/bg_top.gif);background-repeat: repeat-x; color: white; height: 30px; width: 100%; font-size: 14px; font-weight: bold;}
				.xp_sel{background: #F7F7F7; font-weight: bold; width: 150; padding-left: 5px;}
								
				input{font-size: 12px; font-weight: normal; font-family: arial;}
				input.full{ width: 450px; background-color: #D6EBFF; color: #000000; font-weight: normal; border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid;}
				input.mini{ width: 80px; background-color: #D6EBFF; color: #000000;font-weight: normal; border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid;}
				<xsl:choose>								
					<xsl:when test="$oldeditor='on'">
						textarea{height: 150px; width: 450px; background-color: #D6EBFF; color: #000000; font-size: 12px; font-weight: normal; font-family: arial;  border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid; filter: alpha(opacity=100);BEHAVIOR: url(admin/js/textarea.htc)}
					</xsl:when>
					<xsl:otherwise>
						textarea{height: 150px; width: 450px; background-color: #D6EBFF; color: #000000; font-size: 12px; font-weight: normal; font-family: arial;  border-top: 1px #c0c0c0 solid; border-left: 1px #c0c0c0 solid;border-right: 1px #f0f0f0 solid; border-bottom: 1px #f0f0f0 solid; filter: alpha(opacity=100);}
					</xsl:otherwise>
				</xsl:choose>
				select {width: 200px; background-color: #D6EBFF; color: #000000; font-size: 12px; font-weight: normal; font-family: arial; border: 1px #4C4C4C solid; filter: alpha(opacity=100);}
		</style>
	
		<xsl:choose>
			<xsl:when test="$eventid='new'">
				<xsl:call-template name="ec_event_add"/>
			</xsl:when>
			<xsl:when test="$calendar and document($calendarfile)/eventcalendar/calendar[id=$calendar]/visible='on'">
				<xsl:choose>
					<xsl:when test="$usertype='administrator'">
						<xsl:call-template name="calendargrid"/>
					</xsl:when>
					<xsl:when test="$usertype='editor'">
						<xsl:if test="document($calendarfile)/eventcalendar/calendar[id=$calendar]/group!='administrator'">
							<xsl:call-template name="calendargrid"/>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$usertype='member'">
						<xsl:if test="document($calendarfile)/eventcalendar/calendar[id=$calendar]/group='member' or document($calendarfile)/eventcalendar/calendar[id=$calendar]/group='anonymous'">
							<xsl:call-template name="calendargrid"/>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="document($calendarfile)/eventcalendar/calendar[id=$calendar]/group='anonymous'">
							<xsl:call-template name="calendargrid"/>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<table>
					<xsl:for-each select="document($calendarfile)/eventcalendar/calendar">
						<xsl:sort select="calname"/>
						<xsl:if test="visible='on'">
							<xsl:choose>
								<xsl:when test="$usertype='administrator'">
									<tr>
										<td>
											<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={id}">
												<xsl:if test="string-length(image)&gt;0">
													<img src="{image}" height="50" width="50" border="0"/>
												</xsl:if>
											</a>
										</td>
										<td>
											<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={id}">
												<font size="3">
													<xsl:value-of select="calname"/>
												</font>
											</a>
										</td>
									</tr>
								</xsl:when>
								<xsl:when test="$usertype='editor' and group!='administrator'">
									<tr>
										<td>
											<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={id}">
												<xsl:if test="string-length(image)&gt;0">
													<img src="{image}" height="50" width="50" border="0"/>
												</xsl:if>
											</a>
										</td>
										<td>
											<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={id}">
												<font size="3">
													<xsl:value-of select="calname"/>
												</font>
											</a>
										</td>
									</tr>
								</xsl:when>
								<xsl:when test="$usertype='member' and (group='member' or group='anonymous')">
									<tr>
										<td>
											<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={id}">
												<xsl:if test="string-length(image)&gt;0">
													<img src="{image}" height="50" width="50" border="0"/>
												</xsl:if>
											</a>
										</td>
										<td>
											<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={id}">
												<font size="3">
													<xsl:value-of select="calname"/>
												</font>
											</a>
										</td>
									</tr>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="group='anonymous'">
										<tr>
											<td>
												<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={id}">
													<xsl:if test="string-length(image)&gt;0">												
														<img src="{image}" height="50" width="50" border="0"/>
													</xsl:if>
												</a>
											</td>
											<td>
												<a href="default.asp?id={$id}&amp;ACT={$ACT}&amp;calendar={id}">
													<font size="3">
														<xsl:value-of select="calname"/>
													</font>
												</a>
											</td>
										</tr>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>						
						</xsl:if>
					</xsl:for-each>
				</table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>

