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
	Response.Redirect "checkstats.asp"
End If

    Set oConn = AdMentor_DBOpenConnection2("0")
    
'Now build the SQL
Dim sSQL, sWhere   

sWhere = ""
sSQL = "select banner.bannerid, banner.name, banner.weight, banner.showcount, banner.clickcount, banner.underclickcount  from banner "


If Request.Form("zones") = "-1" Then
	' all zones
Else
	'
	sSQL = sSQL & " , banzone " 
	sWhere = "banzone.bannerid=banner.bannerid AND banzone.zoneid in ( " & Request.Form("zones") & ")"
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

'Build Banner type
'1. Check if someone is selected?
If Request.Form("HTMLBanner") = "ON" Or Request.Form("RegularBanner") = "ON" Then
	' If both then leave
	If ( Request.Form("HTMLBanner") = "ON" And Request.Form("RegularBanner") = "ON" ) = False Then
		'Only one of them
		If sWhere <> "" Then
			sWhere = sWhere & " AND "
		End If
		If Request.Form("HTMLBanner") = "ON" Then
			sWhere = sWhere & " banner.ishtml = true" 
		Else
			sWhere = sWhere & " banner.ishtml = false" 
		End If
	End If
End If

If sWhere <> "" Then
	sSQL = sSQL & " where " & sWhere
End If
 
Set oRS = oConn.Execute(sSQL)





Function GetClickRatio( nShowCount, nClickCount, nUnderClickCount )
	Dim nTotClicks, dRatio

	nTotClicks = nClickCount + nUnderClickCount
	If nTotClicks<>0 Then
		dRatio = round(nShowCount/nTotClicks,0)
		GetClickRatio = CStr(dRatio) & ":1"
	Else
		GetClickRatio = "N/A"
	End If
	
End Function
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
                              Estatísticas</b></font>
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
                            <td bgcolor="#C0C0C0" ><b>Nome Banner&nbsp;</b></td>
                            <td bgcolor="#C0C0C0" ><b>Peso</b></td>
                            <td bgcolor="#C0C0C0" ><b>Nº Exibições</b></td>
                            <td bgcolor="#C0C0C0" ><b>Click em Banner&nbsp;</b></td>
                            <td bgcolor="#C0C0C0" ><b>Click em texto</b></td>
                            <td bgcolor="#C0C0C0" ><b>Taxa de Click&nbsp;</b></td>
                          </tr>
<%	
	Dim nSumShowCount, nSumClickCount, nSumUnderClickCount, strEdit
	While Not oRS.EOF
	nSumShowCount = nSumShowCount + oRS("showcount")
	nSumClickCount = nSumClickCount + oRS("clickcount")
	nSumUnderClickCount = nSumUnderClickCount + oRS("UnderClickCount")
	strEdit = "showdetails.asp?id=" & oRS("bannerid")
	%>

                          <tr>
                            <td bgcolor="#FFFFFF"><a href="<%=strEdit%>"><%=oRS("name")%></a></td>
                            <td bgcolor="#FFFFFF"><%=oRS("weight")%></td>
                            <td bgcolor="#FFFFFF"><%=oRS("showcount")%></td>
                            <td bgcolor="#FFFFFF"><%=oRS("clickcount")%>
                            <td bgcolor="#FFFFFF"><%=oRS("underclickcount")%>
                            <td bgcolor="#FFFFFF"><%=GetClickRatio(oRS("showcount"),oRS("clickcount"),oRS("underclickcount") )%>
								 &nbsp;</td>
                          </tr>
<%
	oRS.MoveNext
	Wend
	oRS.Close
	Set oRS = Nothing
	oConn.Close
	Set oConn = Nothing
%>                          
                          <tr>
                            <td bgcolor="#DDDDDD" ><b>RESUMO</b></td>
                            <td bgcolor="#DDDDDD" ><b></b></td>
                            <td bgcolor="#DDDDDD" ><b><%=nSumShowCount%></b></td>
                            <td bgcolor="#DDDDDD" ><b><%=nSumClickCount%></b></td>
                            <td bgcolor="#DDDDDD" ><b><%=nSumUnderClickCount%></b></td>
                            <td bgcolor="#DDDDDD" ><b><%=GetClickRatio(nSumShowCount,nSumClickCount,nSumUnderClickCount )%></b></td>
                          </tr>


                        </table>
 

                       </td>
                    </tr>
                </table>
            
                              </td>
                            </tr>
                          <tr>
                            <td>
                            <p align="center">
                        <%WriteFakeButton "checkstats.asp", "Novo Filtro" %>
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












