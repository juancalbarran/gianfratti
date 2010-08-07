<%@Language="VBScript"%>
<head>
	<title>Email components</title>
	<style>
		body {font: 12px arial; border: 0px jingle; background: white}
	</style>
</head>
<b>The checked boxes are the installed components:</b>
<%
	'Response.Buffer = True
	Server.ScriptTimeout = 60
	lastUpdate = "24/04/2002"

	Dim nbObject : nbObject = 7
	Dim ProgID : ProgID = array("SMTPsvg.Mailer", "SMTPsvg.Mailer", "Persits.MailSender", "CDONTS.NewMail", "CDO.Message", "Jmail.smtpmail", "SoftArtisans.SMTPMail")
	Dim Label  : Label = array("ASPMail", "ASPQMail", "ASPEmail", "CDOMail", "CDOSYS", "JMail", "SASmtpMail")
	
	Sub AutoDetect()
		Dim i
		
		For i=0 to nbObject-1
			if IsObjInstalled(ProgID(i)) then
				Response.Write "<script>window.opener.frmFullxml.emailCOM.value='" & Label(i) & "';self.close()</script>"
			end if
		Next
	End Sub 
	
	Sub Sniffer()
		Dim i
		
		For i=0 to nbObject-1
			if IsObjInstalled(ProgID(i)) then
				Response.Write "<input type=checkbox checked disabled>&nbsp;<font color=green>" &Label(i) & "</font><br>"
				'exit sub
			else
				Response.Write "<input type=checkbox disabled>&nbsp;<font color=red>"& Label(i) & "</font><br>" 
			end if
		Next
	End Sub 

	Function IsObjInstalled(strClassString)
		On Error Resume Next
		IsObjInstalled = False
		Err = 0
		Dim xTestObj
		Set xTestObj = Server.CreateObject(strClassString)
		If 0 = Err Then IsObjInstalled = True
		Set xTestObj = Nothing
		Err = 0
	End Function
	
	'----------
	if lenb(request("o"))=0 then 
		Sniffer()
	else
		AutoDetect()
	end if
%>
