<!--#include file="../include/admentor2.asp"-->
<!--#include file="../include/admentorsecurity.asp"-->
<!--#include file="menu.inc"-->
<%
'''''''''''  (C) Stefan Holmberg 1999  
'''''''''''  Free to use if these sourcecode lines is not deleted 
'''''''''''  Contact me at webmaster@sqlexperts.com
'''''''''''  http://www.sqlexperts.com
'''''''''''  AdMentor homepage at http://www.create-a-webshop.com

If Session("admin") <> True Then
	Session.Abandon
	Response.Redirect "login.asp?reason=noauth"
End If

    Set oConn = AdMentor_DBOpenConnection2("0")
    Set oRS = oConn.Execute("select  farmid, name, description from bannerfarm")
    
    If Request.Form("pagetype") <> "" Then
    	Dim sPageType, sZones, nFarm, sBannerOnPage, nBannerId
    	
    	nBannerId = Request.Form("bannerid")
    	sPageType = Request.Form("pagetype")
    	sZones = Request.Form("zones")
    	If sZones = "" Then
    		sZones = "0"
    	Else
    		sZones = Replace( sZones, " ", "" )
    	End If
    	nFarm = Request.Form("farmid")
    	If nFarm = "" Then
    		nFarm = "0"
    	End If
    	sBannerOnPage = Request.Form("BannerOnPage")
    	If sBannerOnPage = "" Then
    		sBannerOnPage = "1"
    	End If
    End If
    

Sub GenHTML
	Dim sHTML
	Dim sParams
	
	If nBannerId <> "" Then
		sParams="B=" & nBannerId
	Else
		sParams = "F=" & nFarm & "&Z=" & sZones & "&N=" & sBannerOnPage
	End If
	
	If sPageType = "ASP" Then
		'
		Response.Write Server.HTMLENcode("<" & "%=AdMentor_GetAdASP(" & """" & sParams & """" & ")%" & ">")
	Else
		' Plain HTML
		Dim sOldParams	, sSrc, sClick, sScriptInject
		sOldParams = sParams
		sParams = sParams & "&nocache=' + nIndex + '"
		sSrc = g_AdMentor_PathToAdServe & "adserve.asp?" & sOldParams
		sClick = g_AdMentor_PathToAdServe & "adclick.asp?" & sOldParams
		sScriptInject = g_AdMentor_PathToAdServe & "scriptinject.asp?" & sParams

		Response.Write Server.HTMLENcode("<!------- AdMentor Ad code ------------->")
		response.write chr(13)
		Response.Write Server.HTMLENcode("<script language=" & """" & "JavaScript" & """" & "> var code = '';")
		response.write chr(13)
		Response.Write Server.HTMLENcode("var now = new Date();" )
		response.write chr(13)
		Response.Write Server.HTMLENcode("var nIndex = now.getTime();" )
		response.write chr(13)
   		Response.Write Server.HTMLENcode("document.write('<s' + 'cript src=" & """" & sScriptInject & """" & ">');")
		response.write chr(13)
   		Response.Write Server.HTMLENcode("document.write('</' + 's' + 'cript>');")
		response.write chr(13)
   		Response.Write Server.HTMLENcode("</script>" )
		response.write chr(13)
   		Response.Write Server.HTMLENcode("<script language=" & """" & "JavaScript" & """" & ">document.write(code);</script>")
		response.write chr(13)
   		Response.Write Server.HTMLENcode("<noscript><a href=" & """" & sClick & """" & ">")
		response.write chr(13)
   		Response.Write Server.HTMLENcode("<img border=" & """" & "0" & """" & " src=" & """" & sSrc & """" & "></a></noscript>")
		response.write chr(13)
		Response.Write Server.HTMLENcode("<!--------- End AdMentor Ad code --------------->")
		response.write chr(13)
 	End If
	
	If sPageType = "ASP" Then
		Response.Write "<br><br>Remember to include admentor2.asp also"
		Response.Write "<br>Something like:<br>"
		Response.Write Server.HTMLEncode("<" & "!--#include virtual=" & """" & "/admentor/include/admentor2.asp" & """" & "--" & ">")
	End If
End Sub

Function ListFarms
	Dim oRS

	Response.Write "<option value=" & """" & "0" & """" & ">Todos os tipos"  & "</option>"
	
	Set oRS = oConn.Execute( "select * from bannerfarm order by farmid" )
	While Not oRS.EOF 
		Response.Write "<option value=" & """" & oRS("farmid") & """" & ">" & oRS("name") & "</option>"
		oRS.MoveNext
	Wend
	oRS.Close
	Set oRS = Nothing
End Function

Function ListBanners
	Dim oRS

	Set oRS = oConn.Execute( "select name, bannerid from banner" )
	While Not oRS.EOF 
		Response.Write "<option value=" & """" & oRS("bannerid") & """" & ">" & oRS("name") & "</option>"
		oRS.MoveNext
	Wend
	oRS.Close
	Set oRS = Nothing
End Function


Function ListZones
	Dim oRS
	
	Response.Write "<option value=" & """" & "0" & """" & ">" & "Todas as Categorias" & "</option>"
	Set oRS = oConn.Execute( "select * from zone order by zoneid" )
	While Not oRS.EOF 
		Response.Write "<option value=" & """" & oRS("zoneid") & """" & ">" & oRS("zonename") & "</option>"
		oRS.MoveNext
	Wend
	oRS.Close
	Set oRS = Nothing
End Function

    
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Generate HTML</title>
<style type="text/css">
<!--
     body {  font-family: Arial, Geneva, Helvetica, Verdana; font-size: smaller; color: #000000}
     td {  font-family: Arial, Geneva, Helvetica, Verdana; font-size: smaller; color: #000000}
     th {  font-family: Arial, Geneva, Helvetica, Verdana; font-size: smaller; color: #000000}
     A:link {text-decoration: none;}
     A:visited {text-decoration: none;}
     A:hover {text-decoration: underline;}
-->
</style>
</head>

<body bgcolor="#DDDDDD">

<table bgColor="#003399" border="0" cellPadding="3" cellSpacing="0" height="100%" width="100%">
  <tbody>
    <tr>
      <td vAlign="middle" width="50%" height="60">
      <img src="../images/administration.gif" border="0">
      </td>
      <td vAlign="baseline" width="468" height="60" align="right">
		<%=GetAdminPagesBannerCode()%>
       </td></tr>
    <tr>
      <td height="100%" vAlign="top" width="100%" colspan="2">
        <table align="center" bgColor="#ffffff" border="0" cellPadding="0" cellSpacing="0" height="100%" width="100%">
          <tbody>
            <tr>
              <td height="100%" vAlign="top" width="85%">
                <table bgColor="#ffffff" border="0" cellPadding="10" cellSpacing="0" height="100%" width="100%">
                  <tbody>
                    <tr>
                      <td align="left" height="100%" vAlign="top" width="65%">
                        <table border="0" width="100%">
                          <tr>
                            <td width="50%" valign="middle" align="left"><font color="#aa3333" face="Arial, Geneva, Helvetica, Verdana" size="4"><b>Gerar
                              Código HTML</b></font>
                            </td>
                            <td width="50%" valign="middle" align="right">&nbsp;&nbsp;</td>
                          </tr>
                        </table>
                        <hr color="#000066" noShade SIZE="1">
                        <table border="0" width="100%">
                          <tr>
                            <td width="160" valign="top"><%AdAdminWriteMenu%></td>
                            <td>
                        <div align="center">
<%If Request.Form("pagetype") <> "" Then %>
<table border="0" bgcolor="#000000" cellspacing="0" width="50%"><tr><td>
<center>
	<table border="0" cellpadding="2" cellspacing="0" width="100%">
	<tr>
	<td bgcolor="#C0C0C0">
	<b>Código gerado</b> (Copie as linhas abaixo para sua página.)<br>
	</td>
	</tr>
	<tr>
	<td bgcolor="#ffffff">
    <textarea rows="9" name="S1" cols="51"><%GenHTML%></textarea>
   
   </td   </td>
   </tr></table>
</center>
</td>
</tr>
</table
<p>
<%End If%>                          


                        <form method="POST" action="genhtml.asp">
                        <table border="0" bgcolor="#000000" cellpadding="1" cellspacing="0" width="80%"><tr><td>
                        <center>
                        <table bgcolor="#ffffff"  border="0" cellpadding="0" cellspacing="2" width="100%">
                           <tr>
                              <td valign="top" width="482"><b>Tipo de página:</b></td>
                              <td valign="middle" width="191">
                          <p align="left">
                          <input type="radio" checked name="pagetype" value="HTML">Versão HTML<br>                          
                          <font size="1">( banner está em outro servidor )</font></p>
                          <input type="radio" value="ASP" name="pagetype">Versão ASP <br>
                              </td>
                            </tr>
                            <tr>
                              <td valign="top" width="482"><b>Nº de Banner na página:<br>
                                </b><font size="1" face="Arial">(Se você for 
                                usar mais de um banner na mesma página, use diferentes números para formar cada banner
                                Escolha a opção HTML e seu navegador precisa suportar JavaScript.</font></td>
                              <td valign="middle" width="191">
                          <p align="left"><select size="1" name="BannerOnPage">
                            <option selected>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                            <option>5</option>
                            <option>6</option>
                            <option>7</option>
                            <option>8</option>
                          </select></p>
                              </td>
                            </tr>
                            <tr>
                              <td width="482"><b>Tipo de Banner ( Relação ao tamanho ):</b></td>
                              <td width="191">&nbsp;
                                <p><select size="1" name="farmid">
                          <%ListFarms%>
                          </select></p>
                                <p>&nbsp;</td>
                            </tr>
                            <tr>
                              <td valign="top" width="482"><b>
                          Categorias:(pode selecionar mais de uma com CTRL)</b></td>
                              <td width="191"><select size="5" name="zones" multiple>
                          <%ListZones%>
                          </select>
                                <p>&nbsp;</td>
                            </tr>
                            <tr>
                              <td valign="top" width="482"><b>Caso não escolha um banner específico eles serão aleatórios ):</b></td>
                              <td width="191"><select size="5" name="bannerid">
                          &nbsp;
                          <%ListBanners%>
                          </select>
                                <p>&nbsp;</td>
                            </tr>
                            <tr>
                              <td width="482"><input type="submit" value="Submit" name="B1"><input type="reset" value="Reset" name="B2"></td>
                              <td width="191"></td>
                            </tr>
                          </table>
                        </center>
                         </td></tr></table> 
                        </form>
<p>&nbsp;</td>
                            </tr>
                          </table>
                          <p>&nbsp;
                      </td>
                    </tr>
                  </tbody>
                </table>
              </td>
            </tr>
          </tbody>
        </table>
      </td>
    </tr>
  </tbody>
</table>


</html>




































