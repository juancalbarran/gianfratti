<!--#include file="../include/admentor2.asp"-->
<!--#include file="../include/admentorsecurity.asp"-->
<!--#include file="menu.inc"-->
<%
'''''''''''  (C) Stefan Holmberg 1999  
'''''''''''  Free to use if these sourcecode lines is not deleted 
'''''''''''  Contact me at webmaster@sqlexperts.com
'''''''''''  http://www.sqlexperts.com
'''''''''''  AdMentor homepage at http://www.create-a-webshop.com

Function GetFarmName( oConn, nFarmId )
	Dim oRS
    Set oRS = oConn.Execute("select  name from bannerfarm where farmid = " & nFarmId )
    If oRS.EOF Then
    	GetFarmName = "Nenhum Tipo selecionado! Este banner não alternará!"
    Else
    	GetFarmName = oRS("name").Value
    End If
    oRS.Close
	Set oRS = Nothing
End Function

Function GetZoneNames( oConn, nBannerId )
	Dim oRS
    Set oRS = oConn.Execute("select  zonename from zone, banzone where banzone.zoneid=zone.zoneid AND banzone.bannerid= " & nBannerId)
    If oRS.EOF Then
    	GetZoneNames = "Sem Categoria"
    Else
    	GetZoneNames = oRS("zonename").Value
    End If
    oRS.Close
    Set oRS = Nothing
End Function

Sub WriteSorter( sName, sFieldName )
	Response.Write sName 
End Sub


    Set oConn = AdMentor_DBOpenConnection2("0")
    
	Dim strSQL 
    If Session("admin") = True Then
    strSQL = "select * from banner order by name ASC"
    	If Request.QueryString("sort") <> "" Then
    		strSQL = strSQL & " order by " & "name " & "ASC"
	    End If
    Else
    strSQL = "select * from banner where ADVid=" & Session("userfldAuto")
    End If
    
	 Set oRS = Server.CreateObject("ADODB.Recordset")
	 oRS.CursorLocation = adUseClient
	 oRS.Open strSQL, oConn, adOpenStatic, adLockReadOnly
	 	 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Administrate Banners</title>
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
                            <td width="50%" valign="middle" align="left"><font color="#aa3333" face="Arial, Geneva, Helvetica, Verdana" size="4"><b>Banners</b></font>
                            </td>
                            <td width="50%" valign="middle" align="right">
                            </td>
                          </tr>
                        </table>
                        <hr color="#000066" noShade SIZE="1">
                        <table border="0" width="100%">
                          <tr>
                            <td width="160"><%AdAdminWriteMenu%></td>
                            <td>
                        <div align="center">
								<%If Session("admin") = True Then 
                           		 WriteFakeButton "addabanner.asp", "Adicionar banner com imagem    " 
                           		 WriteFakeButton "addabanner.asp?html=True", "Adicionar banner em HTML" 
									Response.Write "<br><br>"
                            End If%>  
                           </div>
                        <div align="left">
                        <table border="0" bgcolor="#000000" cellpadding="0" cellspacing="0"><tr><td>
                        <center>
                        <table border="0" cellpadding="2" cellspacing="1">
                          <tr>
                            <td valign="bottom" nowrap bgcolor="#C0C0C0" width="120"><b><%WriteSorter "Banner", "name"%></b></td>
                            <td valign="bottom" nowrap bgcolor="#C0C0C0" width="65"><b><%WriteSorter "Peso", "weight"%></td>
                            <td valign="bottom" nowrap bgcolor="#C0C0C0" width="100"><b><%WriteSorter "Qtde Exibições", "showcount"%></b></td>
                            <td valign="bottom" nowrap bgcolor="#C0C0C0" width="95"><b><%WriteSorter "Click Banner", "clickcount"%></b></td>
                            <td valign="bottom" nowrap bgcolor="#C0C0C0" width="80"><b><%WriteSorter "Click Texto", "underclickcount"%></b></td>
                            <td valign="bottom" nowrap bgcolor="#C0C0C0"><b><%WriteSorter "Tipo", "farmid"%></b></td>
                            <td valign="bottom" nowrap bgcolor="#C0C0C0"><b>Categoria</b></td>
                          </tr>
<%	While Not oRS.EOF
%>

                          <tr>
                            <td bgcolor="#ffffff" width="120"><a href="showdetails.asp?id=<%=oRS("bannerid")%>"><%=oRS("name")%></a></td>
                            <td bgcolor="#ffffff" width="65" align="center"><%=oRS("weight")%></td>
                            <td bgcolor="#ffffff" width="100" align="center"><%=oRS("showcount")%></td>
                            <td bgcolor="#ffffff" width="95" align="center"><%=oRS("clickcount")%></td>
                            <td bgcolor="#ffffff" width="80" align="center"><%=oRS("underclickcount")%></td>
                            <td bgcolor="#ffffff"><%=GetFarmName(oConn, oRS("farmid"))%></td>
                            <td bgcolor="#ffffff"><%=GetZoneNames(oConn, oRS("bannerid"))%></td>
                          </tr>
<%
	oRS.MoveNext
	Wend
%>                          

                           </table>
                          </center>
                        </table>
</td>
<%
	oRS.Close
	Set oRS = Nothing
	oConn.Close
	Set oConn = Nothing
%>
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
</html>
























































































































