<!--#include file="../include/admentor2.asp"-->
<!--#include file="../include/admentorsecurity.asp"-->
<!--#include file="menu.inc"-->
<!--#include file="../include/DanDate.inc"-->
<%
'''''''''''  (C) Stefan Holmberg 1999  
'''''''''''  Free to use if these sourcecode lines is not deleted 
'''''''''''  Contact me at webmaster@sqlexperts.com
'''''''''''  http://www.sqlexperts.com
'''''''''''  AdMentor homepage at http://www.create-a-webshop.com


	Set oConn = AdMentor_DBOpenConnection2("0")
	Dim nBannerId, strSQL
	nBannerId = Request.QueryString("id")
	strSQL = "select * from banner where bannerid=" & nBannerId
	Set oRS = oConn.Execute (strSQL)
	
		
	If Session("admin") = False Then
		If Session("userfldauto") <> oRS("advid") Then
		Response.Redirect "login.asp?reason=noauth"
		End If
	End If
	Dim 	sBannerName
	sBannerName = oRS("name")

Dim DiffADate, ExpDay, Ratio, TotClicks, Percent, Valid

	DiffADate = DateDiff("d", oRS("validfromdate"), Now)
		If DiffADate<>0 Then
		ExpDay = int(oRS("showcount")/DiffADate)
		TotClicks = oRS("clickcount") + oRS("underclickcount")
			If TotClicks<>0 Then
			Percent = round(TotClicks/oRS("showcount")*100,2)
			Ratio = round(oRS("showcount")/TotClicks,0)
			Else
			Ratio = "N/A"
			Percent = "N/A"
			End If
		Else
		ExpDay="1"
		Ratio="N/A"
		Percent="N/A"
		End If

If ExpDay = 0 Then 
	ExpDay = 1
End If

Dim EstDate

If oRS("validtodate") = "1/1/20" and oRS("maximpressions") = 2147483647 Then
Valid = "Non Expiring"

ElseIf oRS("validtodate") = "1/1/20" and oRS("maximpressions") <> 2147483647 Then
Valid = oRS("maximpressions") & " Exp."
EstDate = DanDate(DateAdd("d", (oRS("maximpressions")-oRS("showcount"))/ExpDay, Now()), "%d-%b-%Y")
Valid = Valid & "<br><font size=1><i>~" & EstDate & "</font>"
ElseIf oRS("validtodate") <> "1/1/20" Then
Valid = DanDate(oRS("validtodate"), "%d-%b-%Y")
End If
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Detalhes da Conta</title>
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
      <td vAlign="top" align="left" height="60" width="100%">
      <img src="../images/administration.gif" border="0" width="200" height="60">
      </td>
      <td vAlign="middle" height="60" align="right">
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
                      <td align="left" height="100%" vAlign="top" width="65%">
                        <table border="0" width="100%">
                          <tr>
                            <td width="50%" valign="middle" align="left"><font color="#aa3333" face="Arial, Geneva, Helvetica, Verdana" size="4"><b>Detalhes
                              da Conta: <% Response.Write sBannerName %></b></font>
                            </td>
                            <td width="50%" valign="middle" align="right">
                            <% Dim strEdit, strDel
                            	If Session("admin") = True Then 
                            	strEdit = "adminabanner.asp?id=" & oRS("bannerid")
                            	strDel = "deleteabanner.asp?id=" & oRS("bannerid")
                            	WriteFakeButton strEdit, "Editar Banner"
                            	WriteFakeButton strDel, "Excluir Banner"
                            End If
                            %>
                            </td>
                          </tr>
                        </table>
                        <hr color="#000066" noShade SIZE="1">

                        <table border="0" width="100%">
                          <tr>
                            <td width="160" valign="top"><%AdAdminWriteMenu%></td>
                            <td>
                        <table border="0" cellspacing="0" cellpadding="2" bgcolor="#ffffff" width="100%">
                          <tr>
							   <td bgcolor="#FFFFFF" colspan="3">
                                <div align="center">
                                  <center>
                                  <table border="0" cellpadding="5" cellspacing="0" height="98">
                                    <tr>
                                      <td colspan="7" height="18"></td>
                                    </tr>
                                    <tr>
                                      <td align="center" valign="bottom"><i>Data
                                        Início</i>
                                      </td>
                                      <td align="center" valign="bottom"><i>Data
                                        Final</i>
                                      </td>
                                      <%If Session("admin") = True Then %>
                                      <td align="center" valign="bottom"><i>Peso</i>
                                      </td>
                                      <%End If%>                                   
                                      <td align="center" valign="bottom"><i>Visualizações</i>
                                      </td>
                                      <td align="center" valign="bottom"><i> Clicks
                                        em banner</i>
                                      </td>
                                      <td align="center" valign="bottom"><i> Clicks
                                        em texto</i>
                                      </td>
                                      <td align="center" valign="bottom"><i>Exp./Dia</i>
                                      </td>
                                      <td align="center" valign="bottom"><i>%</i>
                                      </td>
                                      <td align="center" valign="bottom"><i>Taxa</i>
                                      </td>
                                    </tr>

                                    <tr>
                                      <td align="center" valign="top">
                                        <hr>
                                      </td>
                                      <td align="center" valign="top">
                                        <hr>
                                      </td>
                                      <td align="center" valign="top">
                                        <hr>
                                      </td>
                                      <td align="center" valign="top">
                                        <hr>
                                      </td>
                                      <td align="center" valign="top">
                                        <hr>
                                      </td>
                                      <td align="center" valign="top">
                                        <hr>
                                      </td>
                                      <td align="center" valign="top">
                                        <hr>
                                      </td>
                                      <td align="center" valign="top">
                                        <hr>
                                      </td>
                                      <td align="center" valign="top">
                                        <hr>
                                      </td>
                                    </tr>

                                    <tr>
                                      <td align="center" valign="top"><%= DanDate(oRS("validfromdate"), "%d-%b-%Y") %></td>
                                      <td align="center" valign="top"><%Response.Write Valid%></td>
                                      <%If Session("admin") = True Then %>
                                      <td align="center" valign="top"><%=oRS("weight")%></td>
                                      <%End If%>                                   
                                      <td align="center" valign="top"><%=oRS("showcount")%></td>
                                      <td align="center" valign="top"><%=oRS("clickcount")%></td>
                                      <td align="center" valign="top"><%=oRS("underclickcount")%></td>
                                      <td align="center" valign="top"><% Response.Write ExpDay %></td>
                                      <td align="center" valign="top"><% Response.Write Percent %><%If Percent<>"N/A" Then Response.Write ("%") End If%></td>
                                      <td align="center" valign="top"><% Response.Write Ratio%><%If Ratio<>"N/A" Then Response.Write (":1") End If%></td>
                                    </tr>
                                  </table>
                                  </center>
                                </div>
                          
							</td>
							</tr>
                         <tr> 
                          <td colspan="3" valign="middle" align="center" height="90">
								      <%if oRS("ishtml") = False then%>
								      <p align="center"><img border="0" src="<%=oRS("gifurl")%>"></p>
                                      <p align="center">Destino: <a href="<%=oRS("redirurl")%>"><%=oRS("redirurl")%></a></p>
                          			<% End If %> 
                          			<%if oRS("ishtml") = True then
                          			Response.Write oRS("htmlcode")
                          			End If
                          			%>
                          </td>
                          </tr>
                          <tr>
                          <td>
                          	<table width="80%" cellspacing="0" border="0" bgcolor="#000000" align="center">
                          	<tr>
                          	<td>
                          	<table width="100%" cellpadding="2" cellspacing="0" bgcolor="#ffffff">
                          	<tr>
							   <td bgcolor="#C0C0C0" align="left"><font size="1"><b>O
                                banner foi clicado na página</b></font></td>
                            <td bgcolor="#C0C0C0" align="left"><font size="1"><b>Data
                              / Hora</b></font></td>
                            <td bgcolor="#C0C0C0" align="left"><font size="1"><b>IP
                              do Visitante</b></font></td>
                          </tr>
<%
    Set oRS = oConn.Execute("select page, dt, ip from traceclicks, banner where banner.bannerid=traceclicks.bannerid AND traceclicks.bannerid = " & nBannerId )
%>
<%	
	While Not oRS.EOF
%>
         
			                  <tr>
                            <td bgcolor="#DDDDDD"><font size="1"><%=oRS("page")%></font></td>
                            <td bgcolor="#DDDDDD"><font size="1"><%=oRS("dt")%></font></td>
                            <td bgcolor="#DDDDDD"><font size="1"><%=oRS("ip")%></font></td>
                          </tr>
<%
	oRS.MoveNext
	Wend
	oRS.Close
	Set oRS = Nothing
	oConn.Close
	Set oConn = Nothing
%>                      
							</table></td></tr></table>
                        </table>
                        &nbsp;</td>
                          </tr>
                        </table>

                      </td>
                    </tr>
                </table>
              </td>
            </tr>
          </tbody>
        </table>
<table>
    <tr>
      <td vAlign="top" width="100%" colspan="2">
        <table align="center" bgColor="#000099" border="0" cellPadding="3" cellSpacing="0" height="100%" width="100%">
          <tbody></tbody>
        </table>
      </td>
    </tr>

          </table>
    </table>

</body>






































