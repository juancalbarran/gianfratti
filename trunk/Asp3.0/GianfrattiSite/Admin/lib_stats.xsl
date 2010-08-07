<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:vb="http://msgxml.com/vb"	>

<xsl:output method="html"/> 

	<xsl:template name="statistic_modulinfo">
		<xsl:call-template name="version_interface">
			<xsl:with-param name="name">Statistic</xsl:with-param>
			<xsl:with-param name="version">1.0</xsl:with-param>
			<xsl:with-param name="moddate">26.10.2001</xsl:with-param>
			<xsl:with-param name="author">John Roland</xsl:with-param>
			<xsl:with-param name="url">http://www.fullxml.com</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


<!-- liste des jours et des stats associées -->
<xsl:template name="stat_grid">			
	<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
		<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M13"><img src="admin/media/stats.gif" border="0"/></a></td>
		<td><font size="6"><xsl:value-of select="$string[200]"/></font></td></tr>
	</table>
	<table border="0" cellpadding="0" cellspacing="1" width="100%">		
		<tr><td colspan="5" class="header"><xsl:value-of select="$string[200]"/></td></tr>
		<tr>
			<td class="header" width="16"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
			<td class="header"><xsl:value-of select="$string[211]"/></td>
			<td class="header"><xsl:value-of select="$string[205]"/></td>
			<td class="header"><xsl:value-of select="$string[206]"/></td>
		</tr>		
				
		<xsl:for-each select="$logdata//logs/log">
			<xsl:sort select="@date" data-type="number" order="descending"/>
			<tr class="data" ondblclick="goto('default.asp?ACT=1&amp;SECT=M15&amp;d={@date}');" onmouseover="overtr(this);" onmouseout="notovertr(this);" onclick="selected(this);">
				<td class="header" width="16"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
				<td class="data2"><a href="default.asp?ACT=1&amp;SECT=M15&amp;d={@date}"><xsl:call-template name="display_date"><xsl:with-param name="p_Date" select="@date"/></xsl:call-template></a></td>
				<td class="data2"><xsl:value-of select="count(document(@name)//p)"/></td>
				<td class="data2"><xsl:value-of select="count(document(@name)//v)"/></td>
			</tr>
		</xsl:for-each>		
	</table>
		
</xsl:template>


<!-- la meme chose sous form de graph -->
<xsl:template name="stat_graphic">	
	<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
		<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M13"><img src="admin/media/stats.gif" border="0"/></a></td>
		<td><font size="6"><xsl:value-of select="$string[200]"/></font></td></tr>
	</table>
	
	
	<SCRIPT LANGUAGE="JavaScript1.2" SRC="admin/graph/graph.js"></SCRIPT>
	<SCRIPT LANGUAGE="JavaScript1.2">
		var g = new Graph(500,400);
		
		g.addRow(<xsl:for-each select="$logdata//logs/log"><xsl:sort select="@date" data-type="number" order="ascending"/><xsl:value-of select="count(document(@name)//p)"/>,</xsl:for-each>0);
		g.addRow(<xsl:for-each select="$logdata//logs/log"><xsl:sort select="@date" data-type="number" order="ascending"/><xsl:value-of select="count(document(@name)//v)"/>,</xsl:for-each>0);
		
		
		<!-- on definit l'echelle comme etant le max de visites divisée par 3 -->
		<xsl:for-each select="document($logdata//logs/log/@name)//visitors">
			<xsl:sort select="count(v/p)" order="descending" data-type="number"/>			
			<xsl:if test="position()=1">
				g.scale = Math.round(<xsl:value-of select="count(v/p)"/>/3);
			</xsl:if>
		</xsl:for-each>

		//g.scale = 100;
		
		<!-- on defini la permeiere date -->
		<xsl:for-each select="$logdata//logs/log"><xsl:sort select="@date" data-type="number" order="ascending"/>
			<xsl:if test="position()=1">g.setDate(<xsl:value-of select="concat(substring(@date,5,2), ', ', substring(@date,7,2), ', ', substring(@date,1,4))"/>);</xsl:if>
		</xsl:for-each>
						
		//g.addRow(124,138,216,143,256,302); //g.setDate(8,10,1998);
		//g.addRow(201,234,340,210,314,320);
		
		
		g.title = "<xsl:value-of select="/siteinfo/data/name"/>";
		g.xLabel = "<xsl:value-of select="$string[211]"/>";
		g.yLabel = "<xsl:value-of select="$string[212]"/>";
		g.setLegend("<xsl:value-of select="$string[205]"/>","<xsl:value-of select="$string[206]"/>");
		g.build();
	</SCRIPT>
</xsl:template>


<!-- detail des Stats sur une date -->
<xsl:template name="stat_detail">
	<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
		<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M14"><img src="admin/media/stats.gif" border="0"/></a></td>
		<td><font size="6"><xsl:value-of select="$string[200]"/></font></td></tr>
	</table>
		
	<center><big><b><xsl:value-of select="$string[204]"/> <xsl:value-of select="concat(substring($d,7,2), '.', substring($d,5,2), '.', substring($d,1,4))"/></b><small> (dd.mm.yyyy)</small></big></center>
	
	<!--<xsl:call-template name="stat_daygraph"/><p/>-->
	
	<table border="0" cellpadding="0" cellspacing="1" width="100%">		
		<tr><td colspan="7" class="header"><xsl:value-of select="$string[205]"/> :: <xsl:value-of select="count(document($logdata//logs/log[@date=$d]/@name)//visitors/v/p)"/></td></tr>
		<tr>
			<td class="header" width="16"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
			<td class="header"><xsl:value-of select="$string[207]"/></td>
			<td class="header"><xsl:value-of select="$string[208]"/></td>
			<td class="header"><xsl:value-of select="$string[209]"/></td>
			<td class="header"><xsl:value-of select="$string[131]"/></td>
			<td class="header"><xsl:value-of select="$string[210]"/></td>
			
		</tr>			
					
		<xsl:for-each select="document($logdata//logs/log[@date=$d]/@name)//p">
			<xsl:sort select="@t" data-type="number" order="descending"/>							
			<xsl:if test="position() &gt; number($page*$stat_pagesize) and position() &lt;=  number(($page+1)*$stat_pagesize) ">
				<tr class="data">
					<td class="header" width="16"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>
					<td class="data2"><xsl:value-of select="concat(substring(@t,1,2), ':', substring(@t,3,2))"/></td>
					<td class="data2"><a target="_blank" href="default.asp?{@u}">default.asp?<xsl:value-of select="@u" disable-output-escaping="yes"/></a></td>
					<td class="data2"><a target="_blank" href="{@f}"><xsl:value-of select="@f"  disable-output-escaping="yes"/></a></td>
					<td class="data2"><xsl:value-of select="@n"/></td>
					<td class="data2"><xsl:value-of select="../@p"/></td>
				</tr>
			</xsl:if>
		</xsl:for-each>						
	</table><br/>
	
	<!-- Navigation for the Paging -->
	<center>
	<xsl:call-template name="paging_Rail_macro">
		<xsl:with-param name="totalpage" select="count(document($logdata//logs/log[@date=$d]/@name)//p) div $stat_pagesize"/>
		<xsl:with-param name="currentpage" select="number($page)+1"/>
		<xsl:with-param name="url">default.asp?ACT=1&amp;SECT=M15&amp;d=<xsl:value-of select="$d"/></xsl:with-param>
	</xsl:call-template>
	</center>
	<p/>

	<!-- We show the user list on the first page only, to speed up :-) -->
	<xsl:if test="$page=0">
		<table border="0" cellpadding="0" cellspacing="1" width="100%">		
			<tr><td colspan="5" class="header"><xsl:value-of select="$string[206]"/> :: <xsl:value-of select="count(document($logdata//logs/log[@date=$d]/@name)//visitors/v)"/></td></tr>
			<tr>
				<td class="header" width="16"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>			
				<td class="header" width="60%"><xsl:value-of select="$string[210]"/></td>
				<td class="header" width="20%"><xsl:value-of select="$string[216]"/></td>
				<td class="header" width="10%"><xsl:value-of select="$string[212]"/></td>
				<td class="header" ><xsl:value-of select="$string[215]"/></td>
			</tr>			
			
			<xsl:for-each select="document($logdata//logs/log[@date=$d]/@name)//v">								
				<tr class="data">
					<td class="header" width="16"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/></td>				
					<td class="data2"><xsl:value-of select="@p"/></td>
					<td class="data2"><xsl:value-of select="@b"/></td>
					<td class="data2"><xsl:value-of select="count(p)"/></td>
					<td class="data2"><xsl:value-of select="@l"/></td>
				</tr>
			</xsl:for-each>								
		</table>	
	</xsl:if>
</xsl:template>

	<xsl:template name="stat_daygraph">
		<xsl:variable name="ViewedPages" select="document($logdata//logs/log[@date=$d]/@name)//p"/>
		<xsl:variable name="hours"><hours><h>1</h><h>2</h><h>3</h></hours></xsl:variable>
		<div align="center">
			<table cellpadding="0" cellspacing="1" bgcolor="#CFB4D0">
				<tr height="100" valign="bottom">
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=0])}" alt="{count($ViewedPages[number(substring(@t,1,2))=0])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=1])}" alt="{count($ViewedPages[number(substring(@t,1,2))=1])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=2])}" alt="{count($ViewedPages[number(substring(@t,1,2))=2])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=3])}" alt="{count($ViewedPages[number(substring(@t,1,2))=3])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=4])}" alt="{count($ViewedPages[number(substring(@t,1,2))=4])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=5])}" alt="{count($ViewedPages[number(substring(@t,1,2))=5])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=6])}" alt="{count($ViewedPages[number(substring(@t,1,2))=6])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=7])}" alt="{count($ViewedPages[number(substring(@t,1,2))=7])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=8])}" alt="{count($ViewedPages[number(substring(@t,1,2))=8 and  number(substring(@t,1,2))&lt;=9])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=9])}" alt="{count($ViewedPages[number(substring(@t,1,2))=9 and  number(substring(@t,1,2))&lt;=10])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=10])}" alt="{count($ViewedPages[number(substring(@t,1,2))=10 and  number(substring(@t,1,2))&lt;=11])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=11])}" alt="{count($ViewedPages[number(substring(@t,1,2))&gt;=11 and  number(substring(@t,1,2))&lt;=12])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=12])}" alt="{count($ViewedPages[number(substring(@t,1,2))&gt;=12 and  number(substring(@t,1,2))&lt;=13])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=13])}" alt="{count($ViewedPages[number(substring(@t,1,2))&gt;=13 and  number(substring(@t,1,2))&lt;=14])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=14])}" alt="{count($ViewedPages[number(substring(@t,1,2))&gt;=14 and  number(substring(@t,1,2))&lt;=15])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=15])}" alt="{count($ViewedPages[number(substring(@t,1,2))&gt;=15 and  number(substring(@t,1,2))&lt;=16])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=16])}" alt="{count($ViewedPages[number(substring(@t,1,2))&gt;=16 and  number(substring(@t,1,2))&lt;=17])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=17])}" alt="{count($ViewedPages[number(substring(@t,1,2))&gt;=17 and  number(substring(@t,1,2))&lt;=18])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=18])}" alt="{count($ViewedPages[number(substring(@t,1,2))&gt;=18 and  number(substring(@t,1,2))&lt;=19])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=19])}" alt="{count($ViewedPages[number(substring(@t,1,2))&gt;=19 and  number(substring(@t,1,2))&lt;=20])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=20])}" alt="{count($ViewedPages[number(substring(@t,1,2))&gt;=20 and  number(substring(@t,1,2))&lt;=21])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=21])}" alt="{count($ViewedPages[number(substring(@t,1,2))&gt;=21 and  number(substring(@t,1,2))&lt;=22])}" width="20"/></td>
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=22])}" alt="{count($ViewedPages[number(substring(@t,1,2))&gt;=22 and  number(substring(@t,1,2))&lt;=23])}" width="20"/></td>			
					<td bgcolor="#ffffff" valign="bottom"><img src="admin/media/dot_top.gif" width="20" height="1"/><br/><img src="admin/media/dot_stat.gif" height="{count($ViewedPages[number(substring(@t,1,2))=23])}" alt="{count($ViewedPages[number(substring(@t,1,2))&gt;=23])}" width="20"/></td>
				</tr>
				<tr align="center">
					<td>00</td>
					<td>01</td>
					<td>02</td>
					<td>03</td>
					<td>04</td>
					<td>05</td>
					<td>06</td>
					<td>07</td>
					<td>08</td>
					<td>09</td>
					<td>10</td>
					<td>11</td>
					<td>12</td>
					<td>13</td>
					<td>14</td>
					<td>15</td>
					<td>16</td>
					<td>17</td>
					<td>18</td>
					<td>19</td>
					<td>20</td>
					<td>21</td>
					<td>22</td>
					<td>23</td>
				</tr>
			</table>
			</div>		
	</xsl:template>


	<!-- Browsers stat -->
	<xsl:template name="browser_detail">
		<table style="border: 1px black solid; background: white; width: 100%" cellspacing="2">
			<tr><td width="60"><a href="default.asp?ACT=1&amp;SECT=M21"><img src="admin/media/stats.gif" border="0"/></a></td>
			<td><font size="6"><xsl:value-of select="$string[200]"/></font></td></tr>
		</table>	
		
		<!-- We construct a variable containing all the logs!!!! -->
		<xsl:variable name="allstat">
			<visitors>
				<xsl:for-each select="$logdata//logs/log">
					<xsl:copy-of select="document($logdata//logs/log/@name)"/>
				</xsl:for-each>
			</visitors>
		</xsl:variable>
		<xsl:variable name="allstatnode" select="msxsl:node-set($allstat)"/>
		
	
	    <xsl:variable name="total" select="count($allstatnode//visitors/v)"/>
	    
	    
	    <!-- Main family -->
	    <xsl:variable name="iexplorer" select="round(count($allstatnode//visitors/v[contains(@b, 'IE')]) * 100  div number($total))"/>
           <xsl:variable name="netscape" select="round(count($allstatnode//visitors/v[contains(@b, 'NS')]) * 100  div number($total))"/>
           <xsl:variable name="opera" select="round(count($allstatnode//visitors/v[contains(@b, 'OP')]) * 100  div number($total))"/>
           		
           <!-- Detailed version statistic -->
           <xsl:variable name="ie4xx" select="round(count($allstatnode//visitors/v[contains(@b, 'IE') and contains(@b, '4.')]) * 100  div number($total))"/>
           <xsl:variable name="ie50x" select="round(count($allstatnode//visitors/v[contains(@b, 'IE') and contains(@b, '5.0') ]) * 100  div number($total))"/>
           <xsl:variable name="ie55" select="round(count($allstatnode//visitors/v[contains(@b, 'IE') and contains(@b, '5.5')]) * 100  div number($total))"/>
           <xsl:variable name="ie6" select="round(count($allstatnode//visitors/v[contains(@b, 'IE') and contains(@b, '6.0')]) * 100  div number($total))"/>
           
           <xsl:variable name="ns3" select="round(count($allstatnode//visitors/v[contains(@b, 'NS3')]) * 100  div number($total))"/>
           <xsl:variable name="ns4" select="round(count($allstatnode//visitors/v[contains(@b, 'NS4')]) * 100  div number($total))"/>
           <xsl:variable name="ns6" select="round(count($allstatnode//visitors/v[contains(@b, 'NS6')]) * 100  div number($total))"/>
           
           <xsl:variable name="op4" select="round(count($allstatnode//visitors/v[contains(@b, 'OP') and contains(@b, '4.')]) * 100  div number($total))"/>
           <xsl:variable name="op5" select="round(count($allstatnode//visitors/v[contains(@b, 'OP') and contains(@b, '5.')]) * 100  div number($total))"/>
           <xsl:variable name="op6" select="round(count($allstatnode//visitors/v[contains(@b, 'OP') and contains(@b, '6.')]) * 100  div number($total))"/>
           		
           	<!-- Main browsers family -->
       <table border="0" cellpadding="0" cellspacing="1" width="100%">		
		<tr><td colspan="7" class="header"><xsl:value-of select="$string[442]"/></td></tr>
		<tr>
			<td class="header"><xsl:value-of select="$string[444]"/></td>
			<td class="header"><xsl:value-of select="$string[446]"/></td>	
		</tr>
		<tr class="data"><td width="200" class="data2">Internet Explorer</td><td class="data2"><img src="admin/media/statgrad.gif" height="11" width="{$iexplorer}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$iexplorer"/></b>%</td></tr>
		 <tr class="data"><td class="data2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>Netscape</td><td> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><img src="admin/media/statgrad.gif" height="11" width="{$netscape}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/> <b><xsl:value-of select="$netscape"/></b>%</td></tr>
		 <tr class="data"><td class="data2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>Opera</td><td> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><img src="admin/media/statgrad.gif" height="11" width="{$opera}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$opera"/></b>%</td></tr>
		 <tr class="data"><td class="data2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><xsl:value-of select="$string[447]"/></td><td> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><img src="admin/media/statgrad.gif" height="11" width="{100 - ($opera + $netscape + $iexplorer)}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="100 - ($opera + $netscape + $iexplorer)"/></b>%</td></tr>
	</table>	
       <p/>
       
        <table border="0" cellpadding="0" cellspacing="1" width="100%">		
		<tr><td colspan="7" class="header"><xsl:value-of select="$string[443]"/></td></tr>
		<tr>
			<td class="header"><xsl:value-of select="$string[444]"/> - <xsl:value-of select="$string[445]"/></td>
			<td class="header"><xsl:value-of select="$string[446]"/></td>	
		</tr>
		<tr class="data"><td width="200" class="data2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>Internet Explorer 6.0</td><td> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><img src="admin/media/statgrad.gif" height="11" width="{$ie6}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$ie6"/></b>%</td></tr>
	       <tr class="data"><td class="data2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>Internet Explorer 5.5</td><td> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><img src="admin/media/statgrad.gif" height="11" width="{$ie55}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$ie55"/></b>%</td></tr>
	       <tr class="data"><td class="data2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>Internet Explorer 5.0x</td><td> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><img src="admin/media/statgrad.gif" height="11" width="{$ie50x}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$ie50x"/></b>%</td></tr>
	       <tr class="data"><td class="data2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>Internet Explorer 4.xx</td><td> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><img src="admin/media/statgrad.gif" height="11" width="{$ie4xx}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$ie4xx"/></b>%</td></tr>
	       <tr class="data"><td class="data2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>Netscape 6</td><td> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><img src="admin/media/statgrad.gif" height="11" width="{$ns6}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$ns6"/></b>%</td></tr>
	       <tr class="data"><td class="data2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>Netscape 4</td><td> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><img src="admin/media/statgrad.gif" height="11" width="{$ns4}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$ns4"/></b>%</td></tr>
	       <tr class="data"><td class="data2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>Netscape 3</td><td> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><img src="admin/media/statgrad.gif" height="11" width="{$ns3}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$ns3"/></b>%</td></tr>
	       <tr class="data"><td class="data2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>Opera 6.x</td><td> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><img src="admin/media/statgrad.gif" height="11" width="{$op6}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$op6"/></b>%</td></tr>
	       <tr class="data"><td class="data2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>Opera 5.x</td><td> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><img src="admin/media/statgrad.gif" height="11" width="{$op5}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$op5"/></b>%</td></tr>
	       <tr class="data"><td class="data2"> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/>Opera 4.x</td><td> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><img src="admin/media/statgrad.gif" height="11" width="{$op4}"/> <xsl:value-of select="$nbsp" disable-output-escaping="yes"/><b><xsl:value-of select="$op4"/></b>%</td></tr>
	</table>           
	</xsl:template>
			
</xsl:stylesheet>
