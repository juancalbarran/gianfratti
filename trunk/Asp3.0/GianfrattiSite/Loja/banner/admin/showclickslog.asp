<!--#include file="../include/admentor2.asp"-->
<!--#include file="../include/admentorsecurity.asp"-->
<!--#include file="menu.inc"-->
<%
'''''''''''  (C) Stefan Holmberg 1999  
'''''''''''  Free to use if these sourcecode lines is not deleted 
'''''''''''  Contact me at webmaster@sqlexperts.com
'''''''''''  http://www.sqlexperts.com
'''''''''''  AdMentor homepage at http://www.create-a-webshop.com

'Check stat filter

	Dim Conn, fAdmin, nAdvId
	Set Conn = AdMentor_DBOpenConnection2("0")
	
	fAdmin = Session("admin")
	nAdvId = GetAdvId()
	
Function GetAdvId()
	Dim oRS
	Set oRS = Conn.Execute( "select fldAuto from users where name = '" & Session("loginname") & "'" )
	GetAdvId = oRS("fldAuto").Value
	oRS.Close
End Function	
	
Function ListFarms
	Dim oRS
	Dim sSQL
	
	sSQL = "select distinct bannerfarm.farmid, bannerfarm.name from bannerfarm "
	If fAdmin = False Then
		'
		sSQL = sSQL & ", banner where bannerfarm.farmid = banner.farmid AND banner.advid = " & nAdvId
	End If
	
	sSQL = sSQL & " order by bannerfarm.farmid"	
	
	Set oRS = Conn.Execute( sSQL )
	While Not oRS.EOF 
		Response.Write "<option value=" & """" & oRS("farmid") & """" & ">" & oRS("name") & "</option>"
		oRS.MoveNext
	Wend
	oRS.Close
	Set oRS = Nothing
End Function

Function ListZones
	Dim oRS
	Dim sSQL
	
	sSQL = "select distinct zone.zoneid, zone.zonename from zone " 
	If fAdmin = False Then
		'
		sSQL = sSQL & ", banner, banzone where zone.zoneid=banzone.zoneid AND banzone.bannerid= banner.bannerid AND banner.advid = " & nAdvId
	End If
	sSQL = sSQL & " order by zone.zoneid"
	

	Set oRS = Conn.Execute( sSQL )
	While Not oRS.EOF 
		Response.Write "<option value="& oRS("zoneid") & ">" & oRS("zonename") & "</option>"
		oRS.MoveNext
	Wend
	oRS.Close
	Set oRS = Nothing
End Function

Function ListUsers
	Dim oRS
	
	Set oRS = Conn.Execute( "select * from users order by name" )
	While Not oRS.EOF 
		Response.Write "<option value=" & """" & oRS("fldauto") & """" & ">" & oRS("name")  & "</option>"
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
<title>AdMentor: Add New Account</title>
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
      <img src="../images/administration.gif" border="0" width="200" height="60"><b><br>
      <a href="http://www.aspcode.net"><font color="#ECECD9" face="verdana,arial,helvetica" size="1">http://www.aspcode.net</font></a></b>
      </td>
      <td vAlign="baseline" width="468" height="60" align="right">
<%=GetAdminPagesBannerCode()%>

      </td>
    </tr>
    <tr>
      <td height="100%" vAlign="top" width="100%" colspan="2">
        <table align="center" bgColor="#ffffff" border="0" cellPadding="0" cellSpacing="0" height="100%" width="100%">
          <tbody>
            <tr>
              <td height="100%" vAlign="top" width="85%">
                <table bgColor="#ffffff" border="0" cellPadding="10" cellSpacing="0" height="100%" width="100%">
                  <tbody>
                    <tr>
                      <td align="left" height="100%" vAlign="top">
                        <table border="0" width="100%">
                          <tr>
                            <td width="50%" valign="middle" align="left"><font color="#aa3333" face="Arial, Geneva, Helvetica, Verdana" size="4"><b>Exibir
                              log de clicks</b></font>
                            </td>
                            <td width="50%" valign="middle" align="right">&nbsp;</td>
                          </tr>
                        </table>
                        <hr color="#000066" noShade SIZE="1">
                        <table border="0" width="100%" cellpadding="0" cellspacing="0">
                          <tr>
                      <td align="left" height="100%" vAlign="top" width="120">
                      <%AdAdminWriteMenu%>
                      </td>
                            <td >
                              <form method="POST" action="statsres2.asp">
									<table border=0 cellspacing=0 width=80% align="center">
									<tr>
									<td bgcolor=#000000 align=center>
                                <table border="0" width="100%" cellpadding="2" cellspacing="0" bgcolor="#ffffff">
                                  <tr>
                                    <td width="29%"><b>Tipos</b>:</td>
                                    <td width="61%"><select size="6" name="farms" multiple>
                                        <option selected value="-1">Todos</option>
                                        <%ListFarms%>
                                      </select>
                                      </td>
                                  </tr>
                                    <%If fAdmin = True Then 
                                    	'
                                    %>
                                  <tr>
                                    <td width="29%"><b>Usuários</b>:</td>
                                    <td width="61%">
                                    <select size="6" name="users" multiple>
                                        <option selected value="-1">Todos</option>
                                      <%ListUsers%>
                                      </select>
                                     </td>
                                  </tr>
                                     <%Else
                                     '%>
                                     <tr><td>
                                     <input type="hidden" name="users" value="<%=nAdvId%>">
                                     </td></tr>
                                     <%End If%>
                                  <tr>
                                    <td width="29%"><b>Categoria:</b></td>
                                    <td width="61%"><select size="6" name="zones" multiple>
                                        <option selected value="-1">Todos</option>
                                        <%ListZones%>
                                      </select></td>
                                  </tr>
                                  <tr>
                                    <td width="29%">&nbsp;</td>
                                    <td width="61%">&nbsp;
                                    </td>
                                  </tr>
                                  <tr>
                                    <td width="29%"><b>Tempo:</b></td>
                                    <td width="61%">Ultimas: <select size="1" name="time">
                                        <option selected value="1">24 horas</option>
                                        <option value="7">7 dias</option>
                                        <option value="30">30 dias</option>
                                        <option value="180">180 dias</option>
                                      </select>
                                    </td>
                                  </tr>
                                </table>
									</td></tr></table>
                               <p><input type="submit" value="Submit" name="B1"><input type="reset" value="Reset" name="B2"></p>
                              </form>
                              <p>

</td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                </table>
              </td>
            </tr>
          </tbody>
        </table>
      </td>
    </tr>
  </tbody>
</table>
<%Conn.Close
Set Conn = Nothing
%>
</body>

