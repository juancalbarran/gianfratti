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

	Dim Conn
	Set Conn = AdMentor_DBOpenConnection2("0")
	
	
	Dim fIsHTML
	
	If Request.QueryString("html") = "True" Then
		fIsHTML = True
	Else
		fIsHTML = False
	End If



Function ListFarms
	Dim oRS
	
	Set oRS = Conn.Execute( "select * from bannerfarm order by farmid" )
	While Not oRS.EOF 
		Response.Write "<option value=" & """" & oRS("farmid") & """" & ">" & oRS("name") & "</option>"
		oRS.MoveNext
	Wend
	oRS.Close
	Set oRS = Nothing
End Function

Function ListZones
	Dim oRS
	
	Set oRS = Conn.Execute( "select * from zone order by zoneid" )
	While Not oRS.EOF 
		Response.Write "<option value=" & """" & oRS("zoneid") & """" & ">" & oRS("zonename") & "</option>"
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
Dim nFarmId
nFarmId = Request.QueryString("FarmId")
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
      </b>
      </td>
      <td vAlign="baseline" width="468" height="60" align="right">
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
                            <td width="50%" valign="middle" align="left"><font color="#aa3333" face="Arial, Geneva, Helvetica, Verdana" size="4"><b>Adicionar
                              Novo Banner</b></font>
                            </td>
                            <td width="50%" valign="middle" align="right"><%=GetAdminPagesBannerCode()%>
</td>
                          </tr>
                        </table>
                        <hr color="#000066" noShade SIZE="1">
                        <table border="0" width="100%" cellpadding="0" cellspacing="0">
                          <tr>
                      <td align="left" height="100%" vAlign="top" width="120">
                      <%AdAdminWriteMenu%>
                      </td>
                            <td >
                              <form method="POST" action="<%=g_AdMentor_PathToAdServe%>admin/savebanner.asp?id=0&farmid=<%=nFarmId%>&HTML=<%=fIsHTML%>">
									<table border=0 cellspacing=0 width=80% align="center">
									<tr>
									<td bgcolor=#000000 align=center>
                                <table border="0" width="100%" cellpadding="2" cellspacing="0" bgcolor="#ffffff">
                                  <tr>
                                    <td width="29%"><b>Nome</b>:</td>
                                    <td width="61%"><input type="text" name="name" size="20"></td>
                                  </tr>
                                  <%If fIsHTML = False Then %>
                                  <tr>
                                    <td width="29%"><b>Endereço de redir.</b>:</td>
                                    <td width="61%"><input type="text" name="redirurl" size="30"></td>
                                  </tr>
                                  <tr>
                                    <td width="29%"><b>Endereço da Imagem:</b></td>
                                    <td width="61%"><input type="text" name="gifurl" size="30"></td>
                                  </tr>
                                  <tr>
                                    <td width="29%"><b>Texto Alternativo:</b></td>
                                    <td width="61%"><input type="text" name="alttext" size="30"></td>
                                  </tr>
                                  <%End If %>
                                  <tr>
                                    <td width="29%"><b>Peso de Visualização:</b></td>
                                    <td width="61%"><input type="text" name="weight" size="7"></td>
                                  </tr>
                                  <tr>
                                    <td width="29%"><b>Iniciar contador em:</b></td>
                                    <td width="61%"><input type="text" name="showcount" size="7"></td>
                                  </tr>
                                  <%If fIsHTML = False Then %>
                                  <tr>
                                    <td width="29%"><b>Iniciar contagem de cliks:</b></td>
                                    <td width="61%"><input type="text" name="clickcount" size="7"></td>
                                  </tr>
                                  <%End if%>
                                  <tr>
                                    <td width="29%"><b>Tipo de Banner:</b></td>
                                    <td width="61%"><select size="1" name="farmid">
                                    	<%ListFarms%>
                                      </select></td>
                                  </tr>
                                  <tr>
                                    <td width="29%"><b>Usuário:</b></td>
                                    <td width="61%"><select size="1" name="userid"><%ListUsers%>
                                      </select></td>
                                  </tr>
                                  
                                  <%If fIsHTML = False Then %>
                                  <tr>
                                    <td width="29%"><b>Endereço abaixo banner:</b></td>
                                    <td width="61%"><input type="text" name="underurl" size="30"></td>
                                  </tr>
                                  <tr>
                                    <td width="29%"><b>Texto abaixo baner:</b></td>
                                    <td width="61%"><input type="text" name="undertext" size="30"></td>
                                  </tr>
                                  <tr>
                                    <td width="29%"><b>Contador abaixo banner:</b></td>
                                    <td width="61%"><input type="text" name="underclickcount" size="7"></td>
                                  </tr>
                                  <tr>
                                    <td width="29%"><b>Largura:&nbsp;</b></td>
                                    <td width="61%"><input type="text" name="xsize" size="7"></td>
                                  </tr>
                                  <tr>
                                    <td width="29%"><b>Altura:</b></td>
                                    <td width="61%"><input type="text" name="ysize" size="7"></td>
                                  </tr>
                                  <%End If%>
                                  <tr>
                                    <td width="90%" colspan="2"><b>Informação
                                      sobre expiração do banner:</b></td>
                                  </tr>
                                  <tr>
                                    <td width="90%" colspan="2"><font size="2">Se
                                      você nao especificar nenhuma limitação
                                      o banner não expirará. Se voê especificar
                                      mais de uma a primeira condição que for
                                      atingida será considerada.</font></td>
                                  </tr>
                                  <tr>
                                    <td width="29%"><b>Valido entre datas:</b></td>
                                    <td width="61%">Início:<input type="text" name="validfromdate" size="14">
                                      Fim: <input type="text" name="validtodate" size="13"></td>
                                  </tr>
                                  <tr>
                                    <td width="29%"><b>Número máximo de
                                      exibições:</b></td>
                                    <td width="61%"><input type="text" name="maximpressions" size="20">
                                    </td>
                                  </tr>
                                  <%If fIsHTML = False Then %>
                                  <tr>
                                    <td width="29%"><b>Número máximo de
                                      cliques:</b></td>
                                    <td width="61%"><input type="text" name="maxclicks" size="20">
                                    </td>
                                  </tr>
                                  <%End If%>
                                  <tr>
                                    <td width="90%" colspan="2"><b>PÚBLICO ALVO</b></td>
                                  </tr>
                                  <tr>
                                    <td width="90%" colspan="2"><font size="2">Selecione
                                      a categoria que o banner se enquadra. É
                                      possível exibir seu banner somente em
                                      certas páginas, etc </font></td>
                                  </tr>
                                  <tr>
                                    <td width="29%"><b>Categoria:</b></td>
                                    <td width="61%"><select size="4" name="zones" multiple>
                                    	<%ListZones%>
                                      </select>
                                    </td>
                                  </tr>
                                  <%If fIsHTML = True Then %>
                                  <tr>
                                    <td width="29%"><b>Código HTML&nbsp;<br>
                                      </b><font size="2">There are some special
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
                                    <td width="61%"><textarea rows="10" name="htmlcode" cols="40"></textarea>
                                    </td>
                                  </tr>
                                  <%End If%>
                                </table>
									</td></tr></table>
                               <p><input type="submit" value="Submit" name="B1"><input type="reset" value="Reset" name="B2"></p>
                              </form>
                              <p><%If g_AdMentor_Demo = True Then 
                              	Response.Write "This is a demo. No changes will actually saved..."
                              	End If
                              %><br>
                              </p>
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

</body>

<%
	Conn.Close
	Set Conn = Nothing
%>