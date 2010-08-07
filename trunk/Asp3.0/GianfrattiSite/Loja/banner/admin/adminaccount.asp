<!--#include file="../include/admentorsecurity.asp"-->
<!--#include file="../include/admentor2.asp"-->
<!--#include file="menu.inc"-->
<html>
<%
'''''''''''  (C) Stefan Holmberg 1999  
'''''''''''  Free to use if these sourcecode lines is not deleted 
'''''''''''  Contact me at webmaster@sqlexperts.com
'''''''''''  http://www.sqlexperts.com
'''''''''''  AdMentor homepage at http://www.create-a-webshop.com



'''Globals
Dim sUID, sEmailAddress, sFullName, sError, fAdmin, nAdvId

Call Main()

'Tries to save ( update/addnew ). Returns error string
Function TrySave( oConn )
	'
	' Now 
	Dim oRS
	
   sUID = Request.Form("loginname")
   If sUID = "" Then
   		sUID = Session("loginname")
   End If
   
   
   	Set oRS = Server.CreateObject("ADODB.Recordset")
   	Set oRS.ActiveConnection = oConn

	'Try to open it...
	nAdvId = Request.QueryString("id")
	If Session("admin") = True Then 'It might be any account...
		nAdvId = Request.QueryString("id")
	Else
		nAdvId = Session("userfldauto")
	End If
	
	oRS.Open "select * from users where fldAuto = " &  nAdvId, ,adOpenKeyset,adLockOptimistic
	
	If g_AdMentor_Demo = False Then
		If Request.QueryString("action") = "new" Then
			'
    		If oRS.EOF Then
    			oRS.AddNew
    		Else
    			TrySave = "NameTaken"
			oRS.Close
			Set oRS = Nothing
    			Exit Function
    		End If
    	Else
	    	'Now, noone can have the same userid...
   		 	oRS.MoveLast
   	 		oRS.MoveFirst
	    	If oRS.RecordCount > 1 Then
   		 		TrySave = "NameTaken"
    			oRS.Close
			Set oRS = Nothing
    			Exit Function
	    	End If
	    End If
    	

		'Now, make sure new passwords are correct
		If Request.Form("pwdnew") <>  Request.Form("pwdnew2") Then
			TrySave = "PasswordError"
			oRS.Close
			Set oRS = Nothing
			Exit Function
		End If
    	
		oRS("name") = sUID		
		If Request.Form("pwdnew") <> "" Then
			oRS("pwd") = Request.Form("pwdnew")
		End If
		If Session("admin") = True Then
			'On the form?
			If Request.Form("admin") = "" Then
				oRS("admin").Value = False
			Else
				oRS("admin").Value = True
			End If
		End If
		
		oRS("emailaddress") = Request.Form("emailaddress")
		oRS("fullname") = Request.Form("fullname")
		
		'Now is it myself?
		If Request.Form("name") = Session("loginname") Then
			Session("admin") = oRS("admin").Value
			Session("loginname") = oRS("name").Value
			Session("password") = oRS("pwd").Value
			Session("fullname") = oRS("fullname").Value
		End If

		fAdmin = oRS("admin").Value
		sEmailAddress = oRS("emailaddress").Value
		sFullName = oRS("fullname").Value
		If g_AdMentor_Demo = False Then
			oRS.Update
		End if
		oRS.Close
	End If
	Set oRS = Nothing
End Function


Sub Main()
	Dim oMyConn, oMyRS
	Set oMyConn = AdMentor_DBOpenConnection2("0")


	If Request.QueryString("save")= "yes" Then 'Yes we are saving...
		sError = TrySave( oMyConn )
		If sError <> "" Then
		' Some error - then restore values
			If Request.Form("admin") = "Checked" Or Request.Form("admin") = "" Then
				fAdmin = True
			Else
				fAdmin = False
			End If
		
			sEmailAddress = Request.Form("emailaddress")
			sFullName = Request.Form("fullname")
		End If
	ElseIf Request.QueryString("action") = "new" Then
		' Do nothing cause it should be empty then...
		nAdvId = 0
	Else 
		'
		nAdvId = Request.QueryString("id")
		If Session("admin") = True Then 'It might be any account...
			nAdvId = Request.QueryString("id")
		Else
			nAdvId = Session("userfldauto")
		End If
		Set oMyRS = oMyConn.Execute( "select * from users where fldAuto = " & nAdvId )
		sUID = oMyRS("name").Value
		fAdmin = oMyRS("admin").Value
		sEmailAddress = oMyRS("EmailAddress").Value
		sFullName = oMyRS("FullName").Value
		oMyRS.Close
		Set oMyRS = Nothing
	End If
	oMyConn.Close
	Set oMyConn = Nothing
End Sub



%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Account management</title>
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

<body>

<table align="center" bgColor="#003399" border="0" cellPadding="3" cellSpacing="0" height="100%" width="100%">
  <tbody>
    <tr>
      <td vAlign="top" width="50%" height="60">
      <img border="0" src="../images/administration.gif">
      </td>
      <td vAlign="top" width="468" height="60">
      <b><font color="#FFFFFF" face="verdana,arial,helvetica" size="+2">Administração</font></b>
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
                            <td width="50%">
                        <font color="#aa3333" face="verdana,arial,helvetica" size="+2"><b>Manutenção
                        de Conta&nbsp;</b></font>
                            </td>
                            <td width="50%"><%=GetAdminPagesBannerCode()%>
</td>
                          </tr>
                        </table>
                        <hr color="#000066" noShade SIZE="1">
                        <table border="0" width="696">
                          <tr>
                            <td width="160" valign="top"><%AdAdminWriteMenu%></td>
                            <td width="522">                         
                            <form method="POST" action="adminaccount.asp?id=<%=nAdvId%>&amp;Save=yes<%If Request.QueryString("action") = "new" Then Response.Write "&action=new" End If%>">
                                <table border="0" width="110%">
<%If sError = "NameTaken" Then %>                                     
                                  <tr>
                                    <td width="22%"></td>
										<td width="94%"><font color="#FF0000" size="1">User
                                          id is already used by someone else</font></td>
                                  </tr>
<%End If%>                                  
<%If Request.Form("loginname")<> ""  And sError = "" Then %>                                     
                                  <tr>
                                    <td width="22%"></td>
										<td width="94%"><font color="#008000" size="1">Alterações
                                          foram salvas com sucesso</font></td>
                                  </tr>
<%End If%>                                  
                                  <tr>
                                    <td width="22%"><b>Usuário</b>:</td>
<%If Session("admin") = True Then %>
										<td width="94%"><input type="text" name="loginname" size="15" value="<%=sUID%>"></td>
<%Else %>
                                    <td width="62%"><%=sUID%></td>
<%End If%>                                    
                                    <td width="78%"></td>
                                  </tr>
<%If sError = "PasswordError" Then %>                                     
                                  <tr>
                                    <td width="22%"></td>
                                    <td width="94%"><font size="1" color="#FF0000">Senha
                                      e confirmação de senha não conferem</font>&nbsp;</td>
                                  </tr>
<%End If%>                                    
                                  <tr>
                                    <td width="22%"><b>Nova senha</b>:</td>
                                    <td width="94%"><input type="password" name="pwdnew" size="15">
                                      <font size="1">(Deixe vazio para excluir a
                                      senha anterior)</font></td>
                                  </tr>
                                  <tr>
                                    <td width="22%"><b>Confirme nova senha</b>:</td>
                                    <td width="94%"><input type="password" name="pwdnew2" size="15">
                                      <font size="1">(Deixe vazio para excluir a
                                      senha anterior)</font></td>
                                  </tr>
<%If Session("admin") = True Then %>
                                  <tr>
                                    <td width="22%"><b>Direitos de Administrador:</b></td>
                                    <td width="94%"><input type="checkbox" name="admin" value="ON" <%If fAdmin=True Then  Response.Write "Checked"%>></td>
                                  </tr>
<%End If %>
                                  <tr>
                                    <td width="22%"><b>Email :</b></td>
                                    <td width="94%"><input type="text" name="emailaddress" size="40" value="<%=sEmailAddress%>"></td>
                                  </tr>
                                  <tr>
                                    <td width="22%"><b>Nome Completo:</b><b> </b></td>
                                    <td width="94%"><input type="text" name="fullname" size="40" value="<%=sFullName%>"></td>
                                  </tr>
                                </table>
                                <p><input type="submit" value="Enviar" name="B1"><input type="reset" value="Cancela" name="B2"></p>
                              </form>
     </td>
                          </tr>
                        </table>
                        <table border="0" width="100%">
                          <tr>
                            <td width="50%">
                              <p><br>
                              </p>
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
      </td>
    </tr>
  </tbody>
</table>

</body>

</html>
