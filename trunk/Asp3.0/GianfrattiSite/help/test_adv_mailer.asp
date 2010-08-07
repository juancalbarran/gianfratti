<%@Language="VBScript"%>
<%
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Advanced Mailer Component Test
' © 2001 James Harris
' For more information, please visit http://www.pensaworks.com
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
On Error Resume Next
Response.Buffer = True
Server.ScriptTimeout = 60
lastUpdate = "12/28/2001"

function CDOMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
	Dim Mailer
	Set Mailer = Server.CreateObject("CDONTS.NewMail") 
	Mailer.To = ToEmail
	Mailer.From = FromEmail
	Mailer.Subject = Subject
	Mailer.Body = Message
	Mailer.Send
	Set Mailer = Nothing
end function


function ASPMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
	Dim Mailer
	Set Mailer = Server.CreateObject("SMTPsvg.Mailer")
	Mailer.RemoteHost = MailerPath
	Mailer.ContentType = Format
	Mailer.FromName = FromName
	Mailer.FromAddress = FromEmail
	Mailer.AddRecipient ToName, ToEmail
	Mailer.Subject = Subject
	Mailer.BodyText = Message
	Mailer.SendMail
	Set Mailer = Nothing
end function


function ASPQMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
	Dim Mailer
	Set Mailer = Server.CreateObject("SMTPsvg.Mailer")
	Mailer.RemoteHost = MailerPath
	Mailer.ContentType = Format
	Mailer.FromName = FromName
	Mailer.FromAddress = FromEmail
	Mailer.AddRecipient ToName, ToEmail
	Mailer.Subject = Subject
	Mailer.BodyText = Message
	Mailer.QMessage = true
	Mailer.SendMail
	Set Mailer = Nothing
end function


function SASmtpMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
	Dim Mailer
	Set Mailer = Server.CreateObject("SoftArtisans.SMTPMail")
	Mailer.RemoteHost = MailerPath
	Mailer.AddRecipient ToName, ToEmail
	Mailer.FromName = FromName
	Mailer.FromAddress = FromEmail
	Mailer.Subject = Subject
	Mailer.BodyText = Message
	Mailer.SendMail
	Set Mailer = Nothing
end function


function JMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
	Dim Mailer
	Set Mailer = Server.CreateObject("JMail.SMTPMail") 
	Mailer.ServerAddress = MailerPath & ":" & MailerPort
	Mailer.AddRecipient ToEmail
	Mailer.Sender = FromEmail
	Mailer.Subject = Subject
	Mailer.Body = Message
	Mailer.Execute
	Set Mailer = Nothing
end function


function ASPEmail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
	Dim Mailer
	Set Mailer = Server.CreateObject("Persits.MailSender")  
	Mailer.Host = MailerPath
	Mailer.Port = MailerPort
	Mailer.From = FromEmail
	Mailer.FromName = FromName
	Mailer.AddAddress ToName, ToEmail
	Mailer.Subject = Subject
	Mailer.Body = Message
	Mailer.Send
	Set Mailer = Nothing
end function

Dim theComponent(5)
' the components
theComponent(0) = "SMTPsvg.Mailer"
theComponent(1) = "SMTPsvg.Mailer"
theComponent(2) = "Persits.MailSender"
theComponent(3) = "CDONTS.NewMail"
theComponent(4) = "Jmail.smtpmail"
theComponent(5) = "SoftArtisans.SMTPMail"

Function IsObjInstalled(strClassString)
 IsObjInstalled = False
 Err = 0
 Dim xTestObj
 Set xTestObj = Server.CreateObject(strClassString)
 If 0 = Err Then IsObjInstalled = True
 Set xTestObj = Nothing
 Err = 0
End Function

ToEmail = Request.Form("ToEmail")
ToName = Request.Form("ToName")
FromEmail = Request.Form("FromEmail")
FromName = Request.Form("FromName")
MailerPath = Request.Form("MailerPath")
MailerPort = "25"
If (Request("MailerPort") <> "") Then MailerPort = Request("MailerPort")
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Advanced Mailer Component Test - http://www.pensaworks.com</title>
</head>
<body topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0" bgcolor="#FFFFFF">
<table border="0" width="100%" cellspacing="0" cellpadding="3">
  <tr> 
    <td width="100%" bgcolor="#000080"> 
      <div align="center"><font size="2" color="mintcream"><b><font face="Arial, Helvetica, sans-serif" size="4">Advanced 
        Mailer Component Test</font></b></font></div>
    </td>
  </tr>
</table>
<div align="center"></div>
<p align="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> Sometimes a server may accept the CreateObject variable showing 
  that a mailer component is installed. This does not necesesarily mean it is setup 
  and functioning properly. To ensure which mailer programs are functioning and configured properly, please 
  fill out the form below, choose the mailer programs to test, and hit &quot;Run The Test&quot;.  If the email is never received, then the mailer component may 
  not be configured properly. Contact your host in that case.  Please submit  any feedback, bugs, or requests to <a href="mailto:JHarris@pensaworks.com">James Harris</a>.</font> 
  <font face="Verdana, Arial, Helvetica, sans-serif">
  </font><font size="2" face="Verdana, Arial, Helvetica, sans-serif">This script was last updated <%=lastUpdate%>.</font><font face="Verdana, Arial, Helvetica, sans-serif">
  <script Language="JavaScript"><!--
function MailerTest_Validator(theForm)
{

  if (theForm.ToEmail.value == "")
  {
    alert("Please enter a value for the \"To Email Address\" field.");
    theForm.ToEmail.focus();
    return (false);
  }

  if (theForm.ToName.value == "")
  {
    alert("Please enter a value for the \"To Name\" field.");
    theForm.ToName.focus();
    return (false);
  }

  if (theForm.FromEmail.value == "")
  {
    alert("Please enter a value for the \"From Email\" field.");
    theForm.FromEmail.focus();
    return (false);
  }

  if (theForm.FromName.value == "")
  {
    alert("Please enter a value for the \"From Name\" field.");
    theForm.FromName.focus();
    return (false);
  }

  if (theForm.MailerPath.value == "")
  {
    alert("Please enter a value for the \"Mailer Path\" field.");
    theForm.MailerPath.focus();
    return (false);
  }

  if (theForm.MailerPort.value == "")
  {
    alert("Please enter a value for the \"Mailer Port\" field.");
    theForm.MailerPort.focus();
    return (false);
  }
  return (true);
}
//--></script>
  </font>
<p align="center">&nbsp;
<table border="0" align="center" width="75%" cellpadding="4">
  <form name="Subscribe" method="post" action="http://www.pensaworks.com/mailinglist.asp">
    <tr>
      <td bgcolor="#CCCCCC">
        <div align="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b>Mailer Component Test Mailinglist</b></font><br>
      <font size="1" face="Verdana, Arial, Helvetica, sans-serif">We are constantly making changes and updating the component tests to add new features and more components to the list. Join the mailinglist and be the first to know when we release an update! View our <a href="http://www.pensaworks.com/privacy.asp" target="_blank">Privacy Policy</a>.</font></div>
        <div align="center"><b><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Name:</font></b>
		  <input type="text" name="Name" size="10">
          &nbsp;&nbsp;&nbsp;
          <b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Email Address:</font></b>
          <input type="text" name="Email" size="25">
          <input type="hidden" name="L" value="5">
          <input type="hidden" name="Action" value="Subscribe">
          <input type="hidden" name="a" value="s">
          <input type="submit" name="Subscribe" value="Subscribe">
		  </div>
      </td>
    </tr>
  </form>
</table>
<p align="center">&nbsp;
<!--webbot BOT="GeneratedScript" PREVIEW=" " startspan --><script Language="JavaScript"><!--
function FrontPage_Form2_Validator(theForm)
{

  if (theForm.ToEmail.value == "")
  {
    alert("Please enter a value for the \"To Email Address\" field.");
    theForm.ToEmail.focus();
    return (false);
  }

  if (theForm.ToName.value == "")
  {
    alert("Please enter a value for the \"To Name\" field.");
    theForm.ToName.focus();
    return (false);
  }

  if (theForm.FromEmail.value == "")
  {
    alert("Please enter a value for the \"From Email\" field.");
    theForm.FromEmail.focus();
    return (false);
  }

  if (theForm.FromName.value == "")
  {
    alert("Please enter a value for the \"From Name\" field.");
    theForm.FromName.focus();
    return (false);
  }

  if (theForm.MailerPath.value == "")
  {
    alert("Please enter a value for the \"Mailer Path\" field.");
    theForm.MailerPath.focus();
    return (false);
  }

  if (theForm.MailerPort.value == "")
  {
    alert("Please enter a value for the \"Mailer Port\" field.");
    theForm.MailerPort.focus();
    return (false);
  }
  return (true);
}
//--></script><!--webbot BOT="GeneratedScript" endspan --><form name="FrontPage_Form2" method="post" action="test_adv_mailer.asp" onsubmit="return FrontPage_Form2_Validator(this)">
  <table border="0" align="center" width="75%">
    <tr> 
      <td colspan="2"> 
        <div align="center"> 
          <table border="0">
            <tr> 
              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                <input type="checkbox" name="CDONTS" value="Y" checked>
                </font></td>
              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif">CDONTS</font></td>
              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                <% If Not IsObjInstalled(theComponent(3)) Then %>
                <b><font color="#FF0000">Not 
                Installed</font></b> 
                <% Else %>
                <strong><font color="#00CC00">Installed</font></strong> 
                <% End if %>
                </font></td>
            </tr>
            <tr> 
              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                <input type="checkbox" name="ASPMail" value="Y" checked>
                </font></td>
              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif">ASPMail</font></td>
              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif">  
                <% If Not IsObjInstalled(theComponent(0)) Then %>
                <b><font color="#FF0000">Not 
                Installed</font></b> 
                <% Else %>
                <strong><font color="#00CC00">Installed</font></strong> 
                <% End if %>
                 </font></td>
            </tr>
            <tr> 
              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                <input type="checkbox" name="ASPQMail" value="Y" checked>
                </font></td>
              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif">ASPQMail</font></td>
              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                <% If Not IsObjInstalled(theComponent(1)) Then %>
                <b><font color="#FF0000">Not 
                Installed</font></b> 
                <% Else %>
                <strong><font color="#00CC00">Installed</font></strong> 
                <% End if %>
                </font></td>
            </tr>
            <tr> 
              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                <input type="checkbox" name="JMail" value="Y" checked>
                </font></td>
              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif">JMail</font></td>
              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                <% If Not IsObjInstalled(theComponent(4)) Then %>
                <b><font color="#FF0000">Not 
                Installed</font></b> 
                <% Else %>
                <strong><font color="#00CC00">Installed</font></strong> 
                <% End if %>
                </font></td>
            </tr>
            <tr> 
              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                <input type="checkbox" name="SASmtpmail" value="Y" checked>
                </font></td>
              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif">SA-SmtpMail</font></td>
              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                <% If Not IsObjInstalled(theComponent(5)) Then %>
                <b><font color="#FF0000">Not 
                Installed</font></b> 
                <% Else %>
                <strong><font color="#00CC00">Installed</font></strong> 
                <% End if %>
                </font></td>
            </tr>
            <tr> 
              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                <input type="checkbox" name="ASPEmail" value="Y" checked>
                </font></td>
              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif">ASPEmail 
                </font></td>
              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                <% If Not IsObjInstalled(theComponent(2)) Then %>
                <b><font color="#FF0000">Not 
                Installed</font></b> 
                <% Else %>
                <strong><font color="#00CC00">Installed</font></strong> 
                <% End if %>
                </font></td>
            </tr>
          </table>
          <p><font size="2" color="#0000FF" face="Verdana, Arial, Helvetica, sans-serif">Make 
            sure you use a valid To Email Address or you will never receive any 
            emails from this portion of the test. All fields are required.</font></p>
        </div>
      </td>
    </tr>
    <tr> 
      <td><font face="Verdana, Arial, Helvetica, sans-serif"><b><font size="2">To Email Address: 
        </font></b><font size="2"><font size="1">(ex: John@domain.com)</font> </font></font></td>
      <td> 
        <font face="Verdana, Arial, Helvetica, sans-serif">
        <!--webbot bot="Validation" S-Display-Name="To Email Address"
              B-Value-Required="TRUE" -->
        <input type="text" name="ToEmail" size="30" value="<%=ToEmail%>">
      </font></td>
    </tr>
    <tr> 
      <td><font face="Verdana, Arial, Helvetica, sans-serif"><b><font size="2">To Name: </font></b><font size="2"><font size="1">(ex: 
        John Doe)</font></font></font></td>
      <td> 
        <font face="Verdana, Arial, Helvetica, sans-serif">
        <!--webbot bot="Validation" S-Display-Name="To Name"
              B-Value-Required="TRUE" -->
        <input type="text" name="ToName" size="30" value="<%=ToName%>">
      </font></td>
    </tr>
    <tr> 
      <td><font face="Verdana, Arial, Helvetica, sans-serif"><b><font size="2">From Email Address: 
        </font></b><font size="2"><font size="1">(ex: John@domain.com)</font></font></font></td>
      <td> 
        <font face="Verdana, Arial, Helvetica, sans-serif">
        <!--webbot bot="Validation" S-Display-Name="From Email"
              B-Value-Required="TRUE" -->
        <input type="text" name="FromEmail" size="30" value="<%=FromEmail%>">
      </font></td>
    </tr>
    <tr> 
      <td><font face="Verdana, Arial, Helvetica, sans-serif"><b><font size="2">From Name: </font></b><font size="2"><font size="1">(ex: 
        John Doe)</font></font></font></td>
      <td> 
        <font face="Verdana, Arial, Helvetica, sans-serif">
        <!--webbot bot="Validation" S-Display-Name="From Name"
              B-Value-Required="TRUE" -->
        <input type="text" name="FromName" size="30" value="<%=FromName%>">
      </font></td>
    </tr>
    <tr> 
      <td><font face="Verdana, Arial, Helvetica, sans-serif"><b><font size="2">Mailer Path: </font></b><font size="2"><font size="1">(ex: 
        mail.yourdomain.com)</font></font></font></td>
      <td> 
        <font face="Verdana, Arial, Helvetica, sans-serif">
        <!--webbot bot="Validation" S-Display-Name="Mailer Path"
              B-Value-Required="TRUE" -->
        <input type="text" name="MailerPath" size="30" value="<%=Mailerpath%>">
      </font></td>
    </tr>
    <tr> 
      <td><font face="Verdana, Arial, Helvetica, sans-serif"><b><font size="2">Mailer Port: </font></b><font size="1">(25 
        by default, for JMail &amp; ASPEmail)</font><b></b></font></td>
      <td> 
        <font face="Verdana, Arial, Helvetica, sans-serif">
        <!--webbot bot="Validation" S-Display-Name="Mailer Port"
              B-Value-Required="TRUE" -->
        <input type="text" name="MailerPort" size="30" value="<%=MailerPort%>">
      </font></td>
    </tr>
    <tr> 
      <td colspan="2"> 
        <div align="center"> 
          <font face="Verdana, Arial, Helvetica, sans-serif">
          <input type="hidden" name="action" value="mailer_test">
          <input type="submit" name="Submit" value="Run the Test">
          <input type="reset" name="Submit" value="Reset Form">
        </font></div>
      </td>
    </tr>
  </table>
  <p align="center">
    <% If Request.Form("action") = "mailer_test" Then %>
  </p>
  <div align="center"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#FF0000">The 
  Email Test has been completed. Please check your email box for new emails. Please allow up to 15 minutes or more for email messages to arrive. Below you will find any error messages received during the test.</font></b>
</div>
  <div align="center"><br>
  <font face="Verdana, Arial, Helvetica, sans-serif" size="2"><br>
<%
Dim Subject : Subject = "Advanced Mailer Component Test"

Dim Message2 : Message2 = VbCrLf & VbCrLf & "This email has been sent as a Mailer Program test for the above named component. "
Message2 = Message2 & "If you have received this email, then the mailer component is functioning properly. "
Message2 = Message2 & "If you beleive you have reached this email in error, then please just disregard. "
Message2 = Message2 & VbCrLf & VbCrLf & "Sent from the Advanced Mailer Component Test on " & Now & "."

' Send with CDONTS/Chili!Mail
If Request("CDONTS") = "Y" Then
Format = "1"
Message =  "Mailer Component = CDONTS/Chili!Mail" & Message2
Results = CDOMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
End If
	If err.number <> 0 then
		IsErr = True
		Response.Write "<b>CDONTS/Chilli!Mail Error:</b><br>Error Number: " & err.number & "<br>Error Source: " & err.source& "<br>Error Description: " & err.description & "<br><br>"
		err.clear
	Else
		Response.Write "<b>No errors received while testing CDONTS/Chilli!Mail<br><br></b>"
	End If
err.clear

' Send with ASPMail
If Request("ASPMail") = "Y" Then
Format = "text"
Message = "Mailer Component = ASPMail" & Message2
Results = ASPMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
End If
	If err.number <> 0 then
		IsErr = True
		Response.Write "<b>ASPMail Error:</b><br>Error Number: " & err.number & "<br>Error Source: " & err.source& "<br>Error Description: " & err.description & "<br><br>"
		err.clear
	Else
		Response.Write "<b>No errors received while testing ASPMail<br><br></b>"
	End If
err.clear

' Send with ASPQMail
If Request("ASPQMail") = "Y" Then
Format = "text"
Message  = "Mailer Component = ASPQMail" & Message2
Results = ASPQ_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
End If
	If err.number <> 0 then
		IsErr = True
		Response.Write "<b>ASPQMail Error:</b><br>Error Number: " & err.number & "<br>Error Source: " & err.source& "<br>Error Description: " & err.description & "<br><br>"
		err.clear
	Else
		Response.Write "<b>No errors received while testing ASPQMail<br><br></b>"
	End If
err.clear

' Send with JMail
If Request("JMail") = "Y" Then
Format = "text"
Message = "Mailer Component = JMail"  & Message2
Results = JMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
End If
	If err.number <> 0 then
		IsErr = True
		Response.Write "<b>JMail Error:</b><br>Error Number: " & err.number & "<br>Error Source: " & err.source& "<br>Error Description: " & err.description & "<br><br>"
		err.clear
	Else
		Response.Write "<b>No errors received while testing JMail<br><br></b>"
	End If
err.clear

' Send with SA-Smtp Mail
If Request("SASmtpMail") = "Y" Then
Format = "text"
Message = "Mailer Component = SA-SmtpMail" & Message2
Results = SASmtpMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
End If
	If err.number <> 0 then
		IsErr = True
		Response.Write "<b>SA-SMTP mail Error:</b><br>Error Number: " & err.number & "<br>Error Source: " & err.source& "<br>Error Description: " & err.description & "<br><br>"
	Else
		Response.Write "<b>No errors received while testing SA-SMTP Mail<br><br></b>"
	End If
err.clear

' Send with ASPEmail
If Request("ASPEmail") = "Y" Then
Format = False
Message = "Mailer Component = ASPEMail" & Message2
Results = ASPEMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
End If
	If err.number <> 0 then
		IsErr = True
		Response.Write "<b>ASPEmail Error:</b><br>Error Number: " & err.number & "<br>Error Source: " & err.source& "<br>Error Description: " & err.description & "<br><br>"
		err.clear
	Else
		Response.Write "<b>No errors received while testing ASPEMail<br><br></b>"
	End If
err.clear
%>
  </font> <br>
<% If IsErr Then %>
  <font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>Not sure what the above errors mean or how to fix them? Feel free to contact me at <a href="mailto:JHarris@pensaworks.com">JHarris@pensaworks.com</a> 
</b></font>
<% End If %>
    <% End If %>
  </div>
  <p align="center">&nbsp;</p>
  <p align="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><a href="test_asp_components.asp">Click 
    here for the ASP Component test (if it exists on the server)</a></font> </p>
  <p align="center"><font face="Verdana, Arial, Helvetica, sans-serif"><a href=# onClick="self.close();"><font size=2><b>Close 
    Window</b></font></a> </font></p>
  <table border="0" width="98%" cellpadding="2" align="center">
       
    <tr> 
      <td width="200%">
        <hr width="90%">
    </td>
    </tr>
    <tr>        
      <td width="25%" valign="bottom">
        <p align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>© 2001, <a href="http://www.pensaworks.com" target="_blank">James Harris.</a> All Rights Reserved.</b></font>
      </td>
    </tr>
  </table>
  <p align="center">&nbsp;</p>
  <p align="center">&nbsp;</p>
</form>
    
</body>

</html>
