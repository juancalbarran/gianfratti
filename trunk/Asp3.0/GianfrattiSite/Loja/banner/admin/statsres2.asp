<!--#include file="../include/admentor2.asp"-->
<!--#include file="../include/admentorsecurity.asp"-->
<!--#include file="menu.inc"-->
<%
'''''''''''  (C) Stefan Holmberg 1999  
'''''''''''  Free to use if these sourcecode lines is not deleted 
'''''''''''  Contact me at webmaster@sqlexperts.com
'''''''''''  http://www.sqlexperts.com
'''''''''''  AdMentor homepage at http://www.create-a-webshop.com

If Request.Form("users") = "" Then
	Response.Redirect "showclickslog.asp"
End If

Function MyGetDate( sdate )
	If g_AdMentor_DatabaseType = "SQLServer" Then
		MyGetDate = "'" & sDate & "'"
		Exit Function
	End If
	MyGetDate = "#" & sdate & "#"
End Function


    Set oConn = AdMentor_DBOpenConnection2("0")
    
'Now build the SQL
Dim sSQL, sWhere, sTime   

sTime = Dateadd( "d", -Request.Form("time"), now() )

sWhere = ""

sSQL = "select traceclicks.bannerid as bannerid, page, dt, ip, banner.name as banname, traceclicks.undertext as undertext from traceclicks, banner  "
sWhere = " dt >="& MyGetDate(stime) &" AND banner.bannerid=traceclicks.bannerid"

If Request.Form("zones") = "-1" Then
	' all zones
Else
	'
	sSQL = sSQL & " , banzone " 
	sWhere = sWhere & " AND banzone.bannerid=banner.bannerid AND banzone.zoneid in ( " & Request.Form("zones") & ")"
End If


If Request.Form("users") = "-1" Then
	' all users
Else
	'
	If sWhere <> "" Then
		sWhere = sWhere & " AND "
	End If
	sWhere = sWhere & " advid in ( " & Request.Form("users") & ")"
End If

If Request.Form("farms") = "-1" Then
	' all users
Else
	'
	If sWhere <> "" Then
		sWhere = sWhere & " AND "
	End If
	sWhere = sWhere & " banner.farmid in (" & Request.Form("farms") & ")"
End If

If sWhere <> "" Then
	sSQL = sSQL & " where " & sWhere
End If
 
sSQL = sSQL & " order by dt desc" 
Set oRS = oConn.Execute(sSQL)
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Administrate Farms</title>
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
      <img src="../images/administration.gif" border="0" width="200" height="60">
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
                            <td width="50%" valign="middle" align="left"><font color="#aa3333" face="Arial, Geneva, Helvetica, Verdana" size="4"><b>Checar
                              Estatística</b></font>
                            </td>
                            <td width="50%" valign="middle" align="right">
                            </td>
                          </tr>
                        </table>
                        <hr color="#000066" noShade SIZE="1">
      
                        <table border="0" width="100%">
                          <tr>
                            <td width="120" rowspan="3"><%AdAdminWriteMenu%></td>
                            </tr>
                          <tr>
                            <td>
      
                        <div align="center">
                        <table border="0" bgcolor="#000000" cellpadding="0" cellspacing="0"><tr><td>
                        <center>
                        <table border="0" cellpadding="2" cellspacing="1">
                          <tr>

                            <td bgcolor="#C0C0C0" ><b>Nome do Banner</b></td>
                            <td bgcolor="#C0C0C0" ><b>Data/Hora</b></td>
                            <td bgcolor="#C0C0C0" ><b>IP</b></td>
                            <td bgcolor="#C0C0C0" ><b>Página</b></td>
                            <td bgcolor="#C0C0C0" ><b>Click Texto</b></td>
                          </tr>
<%	
	Dim strEdit
	While Not oRS.EOF
	strEdit = "showdetails.asp?id=" & oRS("bannerid")
	%>

                          <tr>
                            <td bgcolor="#FFFFFF"><a href="<%=strEdit%>"><%=oRS("banname")%></a></td>
                            <td bgcolor="#FFFFFF"><%=oRS("dt")%></td>
                            <td bgcolor="#FFFFFF"><%=oRS("ip")%></td>
                            <td bgcolor="#FFFFFF"><%=oRS("page")%>
                            <td bgcolor="#FFFFFF"><%=oRS("undertext")%>
                          </tr>
<%
	oRS.MoveNext
	Wend
	oRS.Close
	Set oRS = Nothing
	oConn.Close
	Set oConn = Nothing
%>                          
                        </table>
 

                       </td>
                    </tr>
                </table>
            
                              </td>
                            </tr>
                          <tr>
                            <td>
                            <p align="center">
                        <%WriteFakeButton "showclickslog.asp", "Novo Filtro" %>
                            </p>
                              </td>
                            </tr>
                          </table>
            
              </td>
            </tr>
          </tbody>
        </table>
 </td></tr></table>
      </td>
    </tr>
  </tbody>
</table>
</body>





















