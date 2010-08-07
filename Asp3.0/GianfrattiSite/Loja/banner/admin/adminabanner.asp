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

Dim nId
	nId = Request.QueryString("id")
    Set oConn = AdMentor_DBOpenConnection2("0")
    
    Set oRS = oConn.Execute("select bannerid, name, redirurl, gifurl, weight, alttext, showcount, clickcount, farmid, undertext, underurl, underclickcount, xsize, ysize, validtodate, maxclicks, maximpressions, validfromdate, ishtml, advid, htmlcode from banner where bannerid = " & nId)
    
    
Function ListFarms(farmid)
	Dim oRS
	
	Set oRS = oConn.Execute( "select * from bannerfarm order by farmid" )
	While Not oRS.EOF 
		Response.Write "<option "
		If farmid = oRS("farmid") Then
			Response.Write "selected=" & """" & "yes" & """" & " "
		End If
		Response.Write "value=" & """" & oRS("farmid") & """" & ">" & oRS("name") & "</option>"
		oRS.MoveNext
	Wend
	oRS.Close
	Set oRS = Nothing
End Function

Function ListUsers(userid)
	Dim oRS, strUsername, uPwd, uName
	Set oRS = oConn.Execute( "select fldAuto, fullname from users order by fldAuto" )
	While Not oRS.EOF 
		Response.Write "<option "
			If userid = oRS("fldAuto") Then
				Response.Write "selected=" & """" & "yes" & """" & " "
'				strUsername = oRS("name").Value
'				uPwd = oRS("pwd").Value
'				uName = oRS("fullname").Value
			End If
		Response.Write "value=" & """" & oRS("fldAuto").Value & """" & ">" & oRS("fullname").Value & "</option>"
		oRS.MoveNext
	Wend
	Response.Write "</select></td>"
	Response.Write "</tr>"
	oRS.Close
	Set oRS = Nothing
End Function

Function ArrContains( sArr, nVal )
	Dim n
	For n = LBound(sArr) To UBound(sArr )
		If CInt(nVal) = CInt(sArr(n)) Then
			ArrContains = True
			Exit Function
		End If
	Next
	ArrContains = False
End Function

Function GetZoneString( nBannerId )
	Dim oRS
	Dim sRet
	Set oRS = oConn.Execute("select zoneid from banzone where bannerid = " & nBannerId )
	While Not oRS.EOF
		If sRet <> "" Then
			sRet = sRet & ","
		End If
		sRet = sRet & oRS("zoneid")
		oRS.MoveNext
	Wend
	oRS.Close
	Set oRS = Nothing
	GetZoneString = sRet
End Function

Function ListZones( sZones )
	Dim oRS
	Dim sArr
	sArr = Split( sZones,",")
	
	Set oRS = oConn.Execute( "select * from zone order by zoneid" )
	While Not oRS.EOF 
		Response.Write "<option "
	
		If ArrContains( sArr, oRS("zoneid") )  Then
			Response.Write "selected=" & """" & "yes" & """" & " "
		End If
		
	 	Response.Write "value=" 	& """" & oRS("zoneid") & """" & ">" & oRS("zonename") & "</option>"
		oRS.MoveNext
	Wend
	oRS.Close
	Set oRS = Nothing
End Function




    
    
    
Function MaxIntToNull( Value )
	If Value = g_MaxLongInt Then
		MaxIntToNull = ""		
	Else
		MaxIntToNull = Value
	End if		
End Function    


Dim sZoneString
sZoneString = GetZoneString(nId)

    
%>
<html>
<head>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>AdMentor: Edit Account</title>
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
      <%%>
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
                            <td width="50%" valign="middle" align="left"><font color="#aa3333" face="Arial, Geneva, Helvetica, Verdana" size="4"><b>Editar
                              Conta: <% Response.Write oRS("name")%></b></font>
                            </td>
                            <td width="50%" valign="middle" align="right"><%=GetAdminPagesBannerCode()%>
</td>
                          </tr>
                        </table>
                        <hr color="#000066" noShade SIZE="1">
                        <table border="0" width="100%">
                          <tr>
                            <td width="160" valign="top"><%AdAdminWriteMenu%></td>
                            <td>
                        <table border="0" width="100%">
                          <tr>
                            <td width="50%">&nbsp;
                              <form method="POST" action="savebanner.asp?id=<%=nId%>&HTML=<%=oRS("ishtml").Value%>">
                                <table border=0 cellspacing=0 width=80% align="center">
									<tr>
									<td bgcolor=#000000 align=center>
                                <table border="0" width="100%" cellpadding="2" cellspacing="0" bgcolor="#ffffff">
                                  <tr>
                                    <td width="39%"><b>Nome</b>:</td>
                                    <td width="61%"><input type="text" name="name" size="20" value="<%=oRS("name")%>"></td>
                                  </tr>
										<%If oRS("ishtml").Value = False Then%>	                                  
                                  <tr>
                                    <td width="39%"><b>Endereço Redir </b>:</td>
                                    <td width="61%"><input type="text" name="redirurl" size="30" value="<%=oRS("redirurl")%>"></td>
                                  </tr>
                                  <tr>
                                    <td width="39%"><b>Endereço imagem:</b></td>
                                    <td width="61%"><input type="text" name="gifurl" size="30" value="<%=oRS("gifurl")%>"></td>
                                  </tr>
                                  <tr>
                                    <td width="39%"><b>Texto alternativo:</b></td>
                                    <td width="61%"><input type="text" name="alttext" size="30" value="<%=oRS("alttext")%>"></td>
                                  </tr>
                                  <%End If%>
                                  <tr>
                                    <td width="39%"><b>Peso de Visualização:</b></td>
                                    <td width="61%"><input type="text" name="weight" size="7" value="<%=oRS("weight")%>"></td>
                                  </tr>
                                  <tr>
                                    <td width="39%"><b>Iniciar Contador:</b></td>
                                    <td width="61%"><input type="text" name="showcount" size="7" value="<%=oRS("showcount")%>"></td>
                                  </tr>
                                  <tr>
                                    <td width="39%"><b>Iniciar contador click:</b></td>
                                    <td width="61%"><input type="text" name="clickcount" size="7" value="<%=oRS("clickcount")%>"></td>
                                  </tr>
                                  <tr>
                                    <td width="39%"><b>Tipo:</b></td>
                                    <td width="61%"><select size="1" name="farmid">
                                    	<%ListFarms(oRS("farmid"))%>
                                      </select></td>
                                  </tr>
                                  <tr>
                                    <td width="29%"><b>Usuário:</b></td>
                                    <td width="61%"><select size="1" name="userid">
										   	<%ListUsers(oRS("advid"))%>
                                 
                                  <%If oRS("ishtml").Value = False Then%>
                                  <tr>
                                    <td width="39%"><b>Texto abaixo do banner:</b></td>
                                    <td width="61%"><input type="text" name="undertext" size="30" value="<%=oRS("undertext")%>"></td>
                                  </tr>
                                  <tr>
                                    <td width="39%"><b>URL abaixo do baner:</b></td>
                                    <td width="61%"><input type="text" name="underurl" size="30" value="<%=oRS("underurl")%>"></td>
                                  </tr>
                                  <tr>
                                    <td width="39%"><b>Contador abaixo da banner:</b></td>
                                    <td width="61%"><input type="text" name="underclickcount" size="7" value="<%=oRS("underclickcount")%>"></td>
                                  </tr>
                                  <tr>
                                    <td width="39%"><b>Largura:&nbsp;</b></td>
                                    <td width="61%"><input type="text" name="xsize" size="7" value="<%=oRS("xsize")%>"></td>
                                  </tr>
                                  <tr>
                                    <td width="39%"><b>Altura:</b></td>
                                    <td width="61%"><input type="text" name="ysize" size="7" value="<%=oRS("ysize")%>"></td>
                                  </tr>
                                  <%End If%>
                                  <tr>
                                    <td width="90%" colspan="2"><b>Informação
                                      sobre expiração da campanha:</b></td>
                                  </tr>
                                  <tr>
                                    <td width="90%" colspan="2"><font size="2">Se
                                      você nao especificar nenhuma limitação
                                      todas serão válidas. Se voê especificar
                                      mais de uma a primeira condição que for
                                      atingida será considerada.</font></td>
                                  </tr>
                                  <tr>
                                    <td width="29%"><b>Valido entre datas:</b></td>
                                    <td width="61%">Início:<input type="text" name="validfromdate" size="14" value="<%=oRS("validfromdate")%>">
                                      Fim: <input type="text" name="validtodate" size="13" value="<%=oRS("validtodate")%>"></td>
                                  </tr>
                                  <tr>
                                    <td width="29%"><b>Número máximo de
                                      exibições:</b></td>
                                    <td width="61%"><input type="text" name="maximpressions" size="6" value="<%=MaxIntToNull(oRS("maximpressions"))%>">
                                    </td>
                                  </tr>
                                  <%If oRS("ishtml") = False Then %>
                                  <tr>
                                    <td width="29%"><b>Número máximo de
                                      cliques:</b></td>
                                    <td width="61%"><input type="text" name="maxclicks" size="6" value="<%=MaxIntToNull(oRS("maxclicks"))%>">
                                    </td>
                                  </tr>
                                  <%End If %>
                                  <tr>
                                    <td width="39%"><b>TARGETING</b></td>
                                    <td width="61%">
                                    </td>
                                  </tr>
                                  <tr>
                                    <td width="39%"><font size="2">Select which
                                      so called zones you want the banner in.
                                      This makes it possible to show the banner
                                      only on certain pages etc </font></td>
                                    <td width="61%">
                                    </td>
                                  </tr>
                                  <tr>
                                    <td width="39%"><b>Categorias</b></td>
                                    <td width="61%"><select size="4" name="zones" multiple>
                                    	<%ListZones sZoneString%>
                                      </select>
                                    </td>
                                  </tr>
                                  <%If oRS("ishtml").Value = True Then%>
                                  <tr>
                                    <td width="39%"><b>HTMLCódigo<br>
                                      </b>
                                      <p><font size="2">There are some special
                                      tabs you can use whereever in your HTML
                                      code that will be switched: </font>
                                      <p><font size="2">&lt;ADM_RANDOM-XXX-YYY&gt;
                                      <br>
                                      This will be changed to a random number
                                      between XXX and YYY</font></p>
                                      <p><font size="2">&lt;ADM_RANDOM-LAST&gt; <br>
                                      Same number as last time <br>
                                      </font></p>
                                    </td>
                                    <td width="61%">
                                    <textarea rows="10" name="htmlcode" cols="40"><%=oRS("htmlcode")%></textarea>
                                    </td>
                                  </tr>
                                  <%End If%>
                              <tr>
                              <td colspan="2" align="center">
                              <p><input type="submit" value="Submit" name="B1"><input type="reset" value="Reset" name="B2"></p>
                              </form>
                              </td></tr>
									</table>
								   </td></tr></table>                        
	    						<p><br>
	<%		If g_AdMentor_Demo = True Then
				Response.Write "This is a demo. No changes will be made..."
			End If
	%>

                              </p>
                              <p>
								
								</td>
                          </tr>
                        </table>
                          <p>&nbsp;</td>
                            </tr>
                          </table>
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

</body>

<%
	oRS.Close
	Set oRS = Nothing
	oConn.Close
	Set oConn = Nothing
%>









