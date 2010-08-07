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

Function GetZoneNames( oConn, nBannerId )
	Dim oRS
    Set oRS = oConn.Execute("select  zonename from zone, banzone where banzone.zoneid=zone.zoneid AND banzone.bannerid= " & nBannerId)
    If oRS.EOF Then
    	GetZoneNames = "Sem categorias"
    Else
    	GetZoneNames = oRS("zonename").Value
    End If
    oRS.Close
	Set oRS = Nothing
End Function

    Set oConn = AdMentor_DBOpenConnection2("0")
    
    Set oRS = oConn.Execute("select  farmid, name, description from bannerfarm where farmid = " & Request.QueryString("id"))
    nFarmId = oRS("farmid").Value
    sFarmName = oRS("name").Value
    sFarmDesc = oRS("description").Value
    oRS.Close
    Set oRS = Nothing
    Set oRS = oConn.Execute ("select * from banner where farmid = " & nFarmId  & " order by name ASC" )
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Administrate Farm: <%=sFarmName%></title>
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
                            <td width="50%" valign="middle" align="left"><font color="#aa3333" face="Arial, Geneva, Helvetica, Verdana" size="4"><b>Detalhes
                              dos tipos: <%=sFarmName%></b></font><font color="#aa3333" face="Arial, Geneva, Helvetica, Verdana" size="2"><b> 
                              (<%=sFarmDesc%>)</b></font>
                            </td>
                            <td width="50%" valign="middle" align="right">
                            <%WriteFakeButton "addafarm.asp", "Adicionar novo tipo" %>&nbsp;&nbsp;
                            <%WriteFakeButton "addabanner.asp", "Novo banner com imagem" %>&nbsp;&nbsp;
                            <%WriteFakeButton "addabanner.asp?html=True", "Novo banner HTML" %>
                            </td>
                          </tr>
                        </table>
                        <hr color="#000066" noShade SIZE="1">
                        <table border="0" width="100%">
                          <tr>
                            <td width="160" valign="top"><%AdAdminWriteMenu%></td>
                            <td>
                        <div align="center">
							<table border="0" bgcolor="#000000" cellpadding="0" cellspacing="0"><tr><td>
                        <center>
                        <table border="0" cellpadding="2" cellspacing="1">
                          <tr>
                            <td bgcolor="#C0C0C0" ><b>Banner</b></td>
                            <td bgcolor="#C0C0C0" ><b>Peso</b></td>
                            <td bgcolor="#C0C0C0" ><b>Nº exibições</b></td>
                            <td bgcolor="#C0C0C0" ><b>Click Banner</b></td>
                            <td bgcolor="#C0C0C0" ><b>Click Texto</b></td>
                            <td bgcolor="#C0C0C0" ><b>Categoria</b></td>
                          </tr>
<%	While Not oRS.EOF
	strEdit = "adminabanner.asp?id=" & oRS("bannerid") & "&farmid=" & nFarmId
	strDel = "deleteabanner.asp?id=" & oRS("bannerid") & "&farmid=" & nFarmId
	%>

                          <tr>
                            <td bgcolor="#ffffff"><a href="showdetails.asp?id=<%=oRS("bannerid")%>"><%=oRS("name")%></a></td>
                            <td bgcolor="#ffffff"><%=oRS("weight")%></td>
                            <td bgcolor="#ffffff"><%=oRS("showcount")%></td>
                            <td bgcolor="#ffffff"><%=oRS("clickcount")%></td>
                            <td bgcolor="#ffffff"><%=oRS("underclickcount")%></td>
                            <td bgcolor="#ffffff"><%=GetZoneNames(oConn, oRS("bannerid"))%></td>
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
                        </td></tr></table>
                       
                                         
                            <p>&nbsp;</td>
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
      </td>
    </tr>
  </tbody>
</table>

</body>













