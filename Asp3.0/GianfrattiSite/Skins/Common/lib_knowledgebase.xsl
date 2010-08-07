<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb">
   <xsl:output method="html" indent="yes" encoding="iso-8859-1" />

<!-- Created by : 2003/06/05, by Miguel Figueira and Jens Schreiber-->
<!-- version 1.0 -->
<!-- To change design look for templates that end with "design" word-->


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--            main procedure            -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
   <xsl:template name="knowledgebase">
      <xsl:choose>
         <xsl:when test="$kbid='9999999999'">
            <font size="3">
               <br />

               <xsl:value-of select="$string[$kb_basestring + 43]" />
            </font>
         </xsl:when>

         <xsl:when test="$kbid &gt; 0">
            <xsl:call-template name="permitions_check" />
         </xsl:when>

         <xsl:when test="$usertype='administrator'">
            <xsl:choose>
               <xsl:when test = "count(document($kbfile)/kb/knowbase[group=* and visible='on'])=0">
                  <font size="3"><br /><xsl:value-of select="$string[$kb_basestring + 44]" /></font>
               </xsl:when>
               <xsl:when test="count(document($kbfile)/kb/knowbase[group=* and visible='on'])=1">
                  <xsl:call-template name="one_base">
                     <xsl:with-param name="url">
                        <xsl:value-of select="document($kbfile)/kb/knowbase[group=* and visible='on']/id" />
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:when>

               <xsl:otherwise>
                  <xsl:call-template name="kb_navigator_choose" />
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>

         <xsl:when test="$usertype='editor'">
            <xsl:choose>
               <xsl:when test = "count(document($kbfile)/kb/knowbase[group!='Administrator' and visible='on'])=0">
                  <font size="3"><br /><xsl:value-of select="$string[$kb_basestring + 44]" /></font>
               </xsl:when>
               <xsl:when test="count(document($kbfile)/kb/knowbase[group!='Administrator' and visible='on'])=1">
                  <xsl:call-template name="one_base">
                     <xsl:with-param name="url">
                        <xsl:value-of select="document($kbfile)/kb/knowbase[group!='Administrator' and visible='on']/id" />
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:when>

               <xsl:otherwise>
                  <xsl:call-template name="kb_navigator_choose" />
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>

         <xsl:when test="$usertype!='anonymous'">
            <xsl:choose>
               <xsl:when test = "count(document($kbfile)/kb/knowbase[visible='on' and (group='Anonymous' or group='Member')])=0">
                  <font size="3"><br /><xsl:value-of select="$string[$kb_basestring + 44]" /></font>
               </xsl:when>
               <xsl:when test="count(document($kbfile)/kb/knowbase[visible='on' and (group='Anonymous' or group='Member')])=1">
                  <xsl:call-template name="one_base">
                     <xsl:with-param name="url">
                        <xsl:value-of select="document($kbfile)/kb/knowbase[visible='on' and (group='Anonymous' or group='Member')]/id" />
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:when>

               <xsl:otherwise>
                  <xsl:call-template name="kb_navigator_choose" />
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>

         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test = "count(document($kbfile)/kb/knowbase[visible='on' and group='Anonymous'])=0">
                  <font size="3"><br /><xsl:value-of select="$string[$kb_basestring + 44]" /></font>
               </xsl:when>
               <xsl:when test="count(document($kbfile)/kb/knowbase[visible='on' and group='Anonymous'])=1">
                  <xsl:call-template name="one_base">
                     <xsl:with-param name="url">
                        <xsl:value-of select="document($kbfile)/kb/knowbase[visible='on' and group='Anonymous']/id" />
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:when>

               <xsl:otherwise>
                  <xsl:call-template name="kb_navigator_choose" />
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--  if only one Kb is available we go direclty to her/also used the direct to error  -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
   <xsl:template name="one_base">
      <xsl:param name="url" />

<SCRIPT type="text/javascript">
<!-- Don't change next line. It must be all in one line or error will be generated!-->
document.location.href=("default.asp?ACT=90&amp;kbid=<xsl:value-of select='$url' />&amp;item=0")
<!-- Don't change previous line. It must be all in one line or error will be generated!-->
</SCRIPT>
   </xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--  if more then one Kb is available we let User choose  -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
   <xsl:template name="kb_navigator_choose">
      <table border="0" width="100%" cellspacing="4" cellpadding="2">

		<xsl:call-template name="multikb_choice_tabletitle_design" />

         <xsl:choose>
            <xsl:when test="$usertype='administrator'">
               <xsl:if test="count(document($kbfile)/kb/knowbase[group='Administrator' and visible='on']) &gt; 0">

                  <xsl:call-template name = "multikb_choice_title_design" >
                  	<xsl:with-param name="title">
                           <xsl:value-of select="$string[$kb_basestring + 38]" />
                    </xsl:with-param>
                  </xsl:call-template>

                  <xsl:for-each select="document($kbfile)/kb/knowbase[group='Administrator' and visible='on']">
                                 <xsl:call-template name="multikB_choice_design" />
                  </xsl:for-each>

                  <tr>
                     <td>
                     </td>
                  </tr>
               </xsl:if>

               <xsl:if test="count(document($kbfile)/kb/knowbase[group='Editor' and visible='on']) &gt; 0">

                  <xsl:call-template name = "multikb_choice_title_design" >
                  	<xsl:with-param name="title">
                           <xsl:value-of select="$string[$kb_basestring + 39]" />
                    </xsl:with-param>
                  </xsl:call-template>

                  <xsl:for-each select="document($kbfile)/kb/knowbase[group='Editor' and visible='on']">
                                 <xsl:call-template name="multikB_choice_design" />
                  </xsl:for-each>

                  <tr>
                     <td>
                     </td>
                  </tr>
               </xsl:if>

               <xsl:if test="count(document($kbfile)/kb/knowbase[group='Member' and visible='on']) &gt; 0">

                  <xsl:call-template name = "multikb_choice_title_design" >
                  	<xsl:with-param name="title">
                           <xsl:value-of select="$string[$kb_basestring + 40]" />
                    </xsl:with-param>
                  </xsl:call-template>

                  <xsl:for-each select="document($kbfile)/kb/knowbase[group='Member' and visible='on']">
                                 <xsl:call-template name="multikB_choice_design" />
                  </xsl:for-each>

                  <tr>
                     <td>
                     </td>
                  </tr>
               </xsl:if>

               <xsl:if test="count(document($kbfile)/kb/knowbase[group='Anonymous' and visible='on']) &gt; 0">

                  <xsl:call-template name = "multikb_choice_title_design" >
                  	<xsl:with-param name="title">
                           <xsl:value-of select="$string[$kb_basestring + 41]" />
                    </xsl:with-param>
                  </xsl:call-template>

                  <xsl:for-each select="document($kbfile)/kb/knowbase[group='Anonymous' and visible='on']">
                                 <xsl:call-template name="multikB_choice_design" />
                  </xsl:for-each>

                  <tr>
                     <td>
                     </td>
                  </tr>
               </xsl:if>
            </xsl:when>

            <xsl:when test="$usertype='editor'">
               <xsl:if test="count(document($kbfile)/kb/knowbase[group='Editor' and visible='on']) &gt; 0">
                  
                  <xsl:call-template name = "multikb_choice_title_design" >
                  	<xsl:with-param name="title">
                           <xsl:value-of select="$string[$kb_basestring + 39]" />
                    </xsl:with-param>
                  </xsl:call-template>
                  
                  <xsl:for-each select="document($kbfile)/kb/knowbase[group='Editor' and visible='on']">
                                 <xsl:call-template name="multikB_choice_design" />
                  </xsl:for-each>

                  <tr>
                     <td>
                     </td>
                  </tr>
               </xsl:if>

               <xsl:if test="count(document($kbfile)/kb/knowbase[group='Member' and visible='on']) &gt; 0">
                  
                  <xsl:call-template name = "multikb_choice_title_design" >
                  	<xsl:with-param name="title">
                           <xsl:value-of select="$string[$kb_basestring + 40]" />
                    </xsl:with-param>
                  </xsl:call-template>
                  
                  <xsl:for-each select="document($kbfile)/kb/knowbase[group='Member' and visible='on']">
                                 <xsl:call-template name="multikB_choice_design" />
                  </xsl:for-each>

                  <tr>
                     <td>
                     </td>
                  </tr>
               </xsl:if>

               <xsl:if test="count(document($kbfile)/kb/knowbase[group='Anonymous' and visible='on']) &gt; 0">
                  
                  <xsl:call-template name = "multikb_choice_title_design" >
                  	<xsl:with-param name="title">
                           <xsl:value-of select="$string[$kb_basestring + 41]" />
                    </xsl:with-param>
                  </xsl:call-template>

                  <xsl:for-each select="document($kbfile)/kb/knowbase[group='Anonymous' and visible='on']">
                                 <xsl:call-template name="multikB_choice_design" />
                  </xsl:for-each>

                  <tr>
                     <td>
                     </td>
                  </tr>
               </xsl:if>
            </xsl:when>

            <xsl:when test="$usertype!='anonymous'">
               <xsl:if test="count(document($kbfile)/kb/knowbase[group='Member' and visible='on']) &gt; 0">
                  
                  <xsl:call-template name = "multikb_choice_title_design" >
                  	<xsl:with-param name="title">
                           <xsl:value-of select="$string[$kb_basestring + 40]" />
                    </xsl:with-param>
                  </xsl:call-template>

                  <xsl:for-each select="document($kbfile)/kb/knowbase[group='Member' and visible='on']">
                                 <xsl:call-template name="multikB_choice_design" />
                  </xsl:for-each>

                  <tr>
                     <td>
                     </td>
                  </tr>
               </xsl:if>


               <xsl:if test="count(document($kbfile)/kb/knowbase[group='Anonymous' and visible='on']) &gt; 0">
                  <xsl:call-template name = "multikb_choice_title_design" >
                  	<xsl:with-param name="title">
                           <xsl:value-of select="$string[$kb_basestring + 41]" />
                    </xsl:with-param>
                  </xsl:call-template>

                  <xsl:for-each select="document($kbfile)/kb/knowbase[group='Anonymous' and visible='on']">
                                 <xsl:call-template name="multikB_choice_design" />
                  </xsl:for-each>

                  <tr>
                     <td>
                     </td>
                  </tr>
               </xsl:if>
            </xsl:when>

            <xsl:otherwise>
               <xsl:if test="count(document($kbfile)/kb/knowbase[group='Anonymous' and visible='on']) &gt; 0">
                  
                  <xsl:call-template name = "multikb_choice_title_design" >
                  	<xsl:with-param name="title">
                           <xsl:value-of select="$string[$kb_basestring + 41]" />
                    </xsl:with-param>
                  </xsl:call-template>

                  <xsl:for-each select="document($kbfile)/kb/knowbase[group='Anonymous' and visible='on']">
                                 <xsl:call-template name="multikB_choice_design" />
                  </xsl:for-each>

                  <tr>
                     <td>
                     </td>
                  </tr>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </table>
   </xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--  Multiple-kb choice optin designs    -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->


<xsl:template name="multikb_choice_tabletitle_design">
         <tr>
            <td>
               <font size="3">
                  <xsl:value-of select="$string[$kb_basestring + 37]" />
               </font>

               <p />
            </td>
         </tr>
</xsl:template>


<xsl:template name="multikb_choice_title_design">
<xsl:param name="title" />
                  <tr><td>
                        <b><xsl:value-of select="$title" /></b>
                  </td></tr>
</xsl:template>



<xsl:template name="multikB_choice_design">
	<tr><td>
		<img src="media/knowbase.gif" hspace="4" align="absmiddle" width="14" height="14" alt="{$string[$kb_basestring + 0]}" />
			<xsl:value-of select="$nbsp" disable-output-escaping="yes" />
			<a href="default.asp?ACT=90&amp;id=0&amp;kbid={id}&amp;item=0">
			<xsl:value-of select="title" disable-output-escaping="yes" />
			</a>
	</td></tr>
</xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--    If user have permitions we let him go further or send him to error      -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
   <xsl:template name="permitions_check">
      <xsl:choose>
         <xsl:when test="$usertype='administrator' and document($kbfile)/kb/knowbase[id=$kbid and group=*]/visible='on'">
            <xsl:call-template name="choose_display_mode" />
         </xsl:when>

         <xsl:when test="$usertype='editor' and document($kbfile)/kb/knowbase[id=$kbid and group!='Administrator']/visible='on'">
            <xsl:call-template name="choose_display_mode" />
         </xsl:when>

         <xsl:when test="$usertype!='anonymous' and document($kbfile)/kb/knowbase[id=$kbid and (group='Anonymous' or group='Member')]/visible='on'">
            <xsl:call-template name="choose_display_mode" />
         </xsl:when>

         <xsl:when test="$usertype='anonymous' and document($kbfile)/kb/knowbase[id=$kbid and group='Anonymous']/visible='on'">
            <xsl:call-template name="choose_display_mode" />
         </xsl:when>

         <xsl:otherwise>
            <xsl:call-template name="one_base">
               <xsl:with-param name="url">9999999999</xsl:with-param>
            </xsl:call-template>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--        Chosse display mode          -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
   <xsl:template name="choose_display_mode">
      <xsl:choose>
         <xsl:when test="document($kbfile)/kb/knowbase[id=$kbid]/display='Linear'">
            <xsl:call-template name="kb_linearview_header_design" />

            <xsl:call-template name="kb_linearview_body_design" />
         </xsl:when>

         <xsl:otherwise>
            <xsl:call-template name="Sctrutured_vieW" />
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--            Linear view macros        -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--            Linear Head           -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
   <xsl:template name="kb_linearview_header_design">
      <a name="home" />

      <xsl:value-of select="document($kbfile)/kb/knowbase[id=$kbid]/intro" disable-output-escaping="yes" />

<!-- Defining navigation table -->
      <table width="80%" border="1" align="center">
         <tr>
            <xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbsectors/sector[visible='on']">
               <td align="center">
                  <a class="link" href="#{name}">
                     <xsl:value-of select="name" />
                  </a>
               </td>
            </xsl:for-each>
         </tr>
      </table>
   </xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--              Linear body             -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
   <xsl:template name="kb_linearview_body_design">
      <xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbsectors/sector[visible='on']">
         <p>
            <a name="{name}" class="cat">
               <xsl:value-of select="$string[$kb_basestring + 3]" />

               <xsl:value-of select="$nbsp" disable-output-escaping="yes" />

               <xsl:value-of select="name" />
            </a>

            <xsl:if test="$usertype='administrator'">
               <xsl:value-of select="$nbsp" disable-output-escaping="yes" />

               <a href="default.asp?ACT=1&amp;SECT=M90&amp;kbid={$kbid}&amp;type=sector&amp;id={id}">
                  <img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit" />
               </a>
            </xsl:if>

            <br />

            <xsl:value-of select="remark" disable-output-escaping="yes" />

            <br />
         </p>

         <xsl:call-template name="kb_linearview_article_design">
            <xsl:with-param name="sector">
               <xsl:value-of select="id" />
            </xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
   </xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--         Display articles             -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
   <xsl:template name="kb_linearview_article_design">
      <xsl:param name="sector" />

      <xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post[sectorid=$sector and visible='on']">
         <p>
            <img src="media/kbarticle.gif" hspace="4" align="absmiddle" width="14" height="14" alt="{$string[$kb_basestring + 15]}" />

            <font size="3">
               <b>
                  <xsl:value-of disable-output-escaping="yes" select="title" />
               </b>

               <xsl:choose>
                  <xsl:when test="$usertype='administrator'">
                     <xsl:value-of select="$nbsp" disable-output-escaping="yes" />

                     <a href="default.asp?ACT=1&amp;SECT=M90&amp;kbid={$kbid}&amp;type=post&amp;id={id}">
                        <img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit" />
                     </a>
                  </xsl:when>

                  <xsl:when test="$username=owner">
                     <xsl:value-of select="$nbsp" disable-output-escaping="yes" />

                     <a href="default.asp?ACT=1&amp;SECT=M90&amp;kbid={$kbid}&amp;type=post&amp;id={id}">
                        <img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit" />
                     </a>
                  </xsl:when>
               </xsl:choose>
            </font>
         </p>

         <p>
            <xsl:value-of disable-output-escaping="yes" select="body" />
         </p>

         <p>
            <b>
               <xsl:value-of select="$string[605]" />

               <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
            </b>

            <a>
            <xsl:value-of select="author" />

            <xsl:value-of select="$nbsp" disable-output-escaping="yes" />

            ( 
            <xsl:call-template name="display_datetime">
               <xsl:with-param name="p_DateTime">
                  <xsl:value-of select="date" />
               </xsl:with-param>
            </xsl:call-template>

            )</a>
         </p>

         <p align="right">
            <a class="link" href="#home">
               <xsl:value-of select="$string[$kb_basestring + 4]" />
            </a>
         </p>
      </xsl:for-each>
   </xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--        Structured view macros        -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--        Structured main procedure     -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
   <xsl:template name="Sctrutured_vieW">
      <xsl:call-template name="navigation_kbarticle" />

      <xsl:choose>
         <xsl:when test="$item=0">
            <xsl:call-template name="kbentry" />
         </xsl:when>

         <xsl:when test="$item&gt;0">
            <xsl:call-template name="kb_structview_article_design">
               <xsl:with-param name="postid">
                  <xsl:value-of select="$item" />
               </xsl:with-param>
            </xsl:call-template>
         </xsl:when>

         <xsl:when test="$grp=-2">
            <xsl:call-template name="kbentry" />
         </xsl:when>

         <xsl:otherwise>
            <xsl:if test="$grp">
               <xsl:call-template name="kb_searchresult" />
            </xsl:if>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--          Structured head             -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
   <xsl:template name="navigation_kbarticle">
      <table>
         <tr>
<!-- ~~~~~~~ -->
<!-- sectors -->
<!-- ~~~~~~~ -->
            <form name="frmgrpchKB" action="default.asp?ACT=90&amp;kbid={$kbid}" method="post">
               <td>
                  <b>
                     <xsl:value-of select="$string[$kb_basestring + 11]" />
                  </b>

                  <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
               </td>

               <td>
                  <select name="grp">
                     <option value="-2">
                        <xsl:value-of select="$string[$kb_basestring + 10]" />
                     </option>

                     <xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbsectors/sector[visible='on']">
                        <xsl:variable name="sectorid" select="id" />

                        <option value="{$sectorid}">
                           <xsl:value-of select="name" />
                        </option>
                     </xsl:for-each>
                  </select>
               </td>

               <td>
                  <input type="submit" value="{$string[18]}" />
               </td>
            </form>

            <td>
               <xsl:value-of select="$nbsp" disable-output-escaping="yes" />

               <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
            </td>

<!-- ~~~~~~~ -->
<!-- search  -->
<!-- ~~~~~~~ -->
            <form name="frmSearchKB" action="default.asp?ACT=90&amp;kbid={$kbid}" method="post">
               <td>
                  <b>
                     <xsl:value-of select="$string[$kb_basestring + 6]" />
                  </b>

                  <xsl:value-of select="$nbsp" disable-output-escaping="yes" />

                  <input type="text" name="keyword" value="{$keyword}" />
               </td>

               <td>
                  <b>
                     <xsl:value-of select="$string[$kb_basestring + 9]" />
                  </b>

                  <xsl:value-of select="$nbsp" disable-output-escaping="yes" />

                  <select name="grp">
                     <option value="-1">
                        <xsl:value-of select="$string[$kb_basestring + 8]" />
                     </option>

                     <xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbsectors/sector[visible='on']">
                        <xsl:variable name="sectorid" select="id" />

                        <option value="{$sectorid}">
                           <xsl:value-of select="name" />
                        </option>
                     </xsl:for-each>
                  </select>
               </td>

               <td>
                  <input type="submit" value="{$string[18]}" />
               </td>

               <td>
                  <xsl:if test="$usertype='editor'or $usertype='administrator'">
                     <input type="button" value="{$string[$kb_basestring + 7]}" onclick="document.location.href='default.asp?ACT=1&amp;SECT=M90&amp;kbid={$kbid}&amp;id=new&amp;type=post';" />
                  </xsl:if>
               </td>
            </form>
         </tr>

         <tr>
            <td>
               <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
            </td>
         </tr>
      </table>
   </xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--            Home                -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
   <xsl:template name="kbentry">
      <xsl:value-of select="document($kbfile)/kb/knowbase[id=$kbid]/intro" disable-output-escaping="yes" />
   </xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--                 Results              -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
   <xsl:template name="kb_resultentry">
      <xsl:param name="postid">-1</xsl:param>

      <tr>
         <td>
            <img src="media/kbarticle.gif" hspace="4" align="absmiddle" width="14" height="14" alt="{$string[$kb_basestring + 15]}" />
         </td>

         <td>
            <a href="default.asp?item={$postid}&amp;ACT=90&amp;kbid={$kbid}">
               <xsl:value-of select="title" disable-output-escaping="yes" />
            </a>

            <xsl:variable name="sectorid">
               <xsl:value-of select="document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post[id=$postid]/sectorid" />
            </xsl:variable>

            <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
         </td>
      </tr>

      <tr>
         <td>
         </td>

         <td>
         <xsl:value-of select="substring(body,1,200)" disable-output-escaping="yes" />

         <xsl:value-of select="$nbsp" disable-output-escaping="yes" />

         ...</td>
      </tr>
   </xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--               Search             -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
   <xsl:template name="kb_searchresult">
<!-- turn to lower case -->
      <xsl:variable name="up" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÜÄÖéèà'" />

      <xsl:variable name="low" select="'abcdefghijklmnopqrstuvwxyzüäöeea'" />

      <xsl:variable name="lowkeyword" select="translate($keyword,$up,$low)" />

      <table>
         <xsl:choose>
            <xsl:when test="$grp&gt;0">
               <tr><td colspan="2">
                  <a class="cat">
                     <xsl:value-of select="$string[$kb_basestring + 3]" />

                     <xsl:value-of select="$nbsp" disable-output-escaping="yes" />

                     <xsl:value-of select="document($kbfile)/kb/knowbase[id=$kbid]/kbsectors/sector[id=$grp]/name" />
                  </a>

                  <xsl:if test="$usertype='administrator'">
                     <xsl:value-of select="$nbsp" disable-output-escaping="yes" />

                     <a href="default.asp?ACT=1&amp;SECT=M90&amp;kbid={$kbid}&amp;type=sector&amp;id={$grp}">
                        <img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit" />
                     </a>
                  </xsl:if>

                  <br />

                  <xsl:value-of select="document($kbfile)/kb/knowbase[id=$kbid]/kbsectors/sector[id=$grp]/remark" disable-output-escaping="yes" />

                  <br />
               </td></tr>

               <xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post[visible='on' and sectorid=$grp]">
                  <xsl:if test="document($kbfile)/kb/knowbase[id=$kbid]/kbsectors/sector[id=$grp]/visible='on'">
                  
	                 <xsl:variable name="postid" select="id" />

                     <xsl:variable name="posttitle" select="translate(title,$up,$low)" />

                     <xsl:variable name="postbody" select="translate(body,$up,$low)" />

                     <xsl:call-template name="kb_search">
                        <xsl:with-param name="searchstring">
                           <xsl:value-of select="$lowkeyword" />
                        </xsl:with-param>

                        <xsl:with-param name="posttitle">
                           <xsl:value-of select="$posttitle" />
                        </xsl:with-param>

                        <xsl:with-param name="postbody">
                           <xsl:value-of select="$postbody" />
                        </xsl:with-param>

                        <xsl:with-param name="postid">
                           <xsl:value-of select="$postid" />
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:if>
               </xsl:for-each>
            </xsl:when>

            <xsl:otherwise>
               <xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post[visible='on']">
                  <xsl:variable name="sid" select="sectorid"/>
                  <xsl:if test="document($kbfile)/kb/knowbase[id=$kbid]/kbsectors/sector[id=$sid]/visible='on'">

                     <xsl:variable name="postid" select="id" />

                     <xsl:variable name="posttitle" select="translate(title,$up,$low)" />

                     <xsl:variable name="postbody" select="translate(body,$up,$low)" />

                     <xsl:call-template name="kb_search">
                        <xsl:with-param name="searchstring">
                           <xsl:value-of select="$lowkeyword" />
                        </xsl:with-param>

                        <xsl:with-param name="posttitle">
                           <xsl:value-of select="$posttitle" />
                        </xsl:with-param>

                        <xsl:with-param name="postbody">
                           <xsl:value-of select="$postbody" />
                        </xsl:with-param>

                        <xsl:with-param name="postid">
                           <xsl:value-of select="$postid" />
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:if>
               </xsl:for-each>
            </xsl:otherwise>
         </xsl:choose>
      </table>
   </xsl:template>

   <xsl:template name="kb_search">
      <xsl:param name="searchstring">-</xsl:param>

      <xsl:param name="posttitle">+</xsl:param>

      <xsl:param name="postbody">+</xsl:param>

      <xsl:param name="postid">+</xsl:param>

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

      <xsl:if test="contains($posttitle, $searchsub) or contains($postbody, $searchsub)">
         <xsl:choose>
            <xsl:when test="string-length($searchstring)&gt;0">
               <xsl:call-template name="kb_search">
                  <xsl:with-param name="searchstring">
                     <xsl:value-of select="substring-after($searchstring, ' ')" />
                  </xsl:with-param>

                  <xsl:with-param name="posttitle">
                     <xsl:value-of select="$posttitle" />
                  </xsl:with-param>

                  <xsl:with-param name="postbody">
                     <xsl:value-of select="$postbody" />
                  </xsl:with-param>

                  <xsl:with-param name="postid">
                     <xsl:value-of select="$postid" />
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:when>

            <xsl:otherwise>
               <xsl:call-template name="kb_resultentry">
                  <xsl:with-param name="postid">
                     <xsl:value-of select="$postid" />
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:if>
   </xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!--        Display article design        -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
   <xsl:template name="kb_structview_article_design">
      <xsl:param name="postid" />

      <xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post[id=$postid]">
         <p>
            <font size="3">
               <b>
                  <img src="media/kbarticle.gif" hspace="4" align="absmiddle" width="14" height="14" alt="{$string[$kb_basestring + 15]}" />

                  <xsl:value-of disable-output-escaping="yes" select="title" />

                  <xsl:choose>
                     <xsl:when test="$usertype='administrator'">
                        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />

                        <a href="default.asp?ACT=1&amp;SECT=M90&amp;kbid={$kbid}&amp;type=post&amp;id={id}">
                           <img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit" />
                        </a>
                     </xsl:when>

                     <xsl:when test="$username=owner">
                        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />

                        <a href="default.asp?ACT=1&amp;SECT=M90&amp;kbid={$kbid}&amp;type=post&amp;id={id}">
                           <img src="admin/media/edit.gif" width="6" height="6" border="0" alt="Edit" />
                        </a>
                     </xsl:when>
                  </xsl:choose>
               </b>
            </font>
         </p>

         <xsl:value-of disable-output-escaping="yes" select="body" />

         <p>
            <b>
               <xsl:value-of select="$string[605]" />

               <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
            </b>

            <a>
            <xsl:value-of select="author" />

            <xsl:value-of select="$nbsp" disable-output-escaping="yes" />

            ( 
            <xsl:call-template name="display_datetime">
               <xsl:with-param name="p_DateTime">
                  <xsl:value-of select="date" />
               </xsl:with-param>
            </xsl:call-template>

            )</a>
         </p>
      </xsl:for-each>

      <table>
         <tr>
            <xsl:if test="count(document($kbfile)/kb/knowbase[id=$kbid]/kbreferences/reference[postid=$postid]) &gt;0">
               <td>
                  <b>
                     <xsl:value-of select="$string[$kb_basestring + 5]" />
                  </b>
               </td>
            </xsl:if>
         </tr>

         <xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbreferences/reference[postid=$postid]">
            <tr>
               <td>
                  <xsl:call-template name="Kb_ref_design">
                     <xsl:with-param name="refid">
                        <xsl:value-of select="refid" />
                     </xsl:with-param>
                  </xsl:call-template>
               </td>
            </tr>
         </xsl:for-each>

         <tr>
            <td>
               <p />

               <xsl:if test="$usertype='administrator'">( 
               <a href="default.asp?ACT=1&amp;SECT=M90&amp;kbid={$kbid}&amp;type=reference&amp;page={$postid}&amp;id=new">
                  <xsl:value-of select="$string[$kb_basestring + 12]" />
               </a>

               )</xsl:if>
            </td>
         </tr>
      </table>
   </xsl:template>

<!-- display related articles title-->
   <xsl:template name="Kb_ref_design">
      <xsl:param name="refid" />

      <xsl:for-each select="document($kbfile)/kb/knowbase[id=$kbid]/kbposts/post[id=$refid]">
         <a href="default.asp?ACT=90&amp;id=0&amp;kbid={$kbid}&amp;item={id}">
            <xsl:value-of disable-output-escaping="yes" select="title" />
         </a>
      </xsl:for-each>
   </xsl:template>
</xsl:stylesheet>

