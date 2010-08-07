<?xml version="1.0" encoding="ISO-8859-1"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb" xml:space="preserve">

    
<xsl:output method="html"/> 
	   
   <msxsl:script language="VBScript" implements-prefix="vb"><![CDATA[
		
		'Return a number beetween 1 and iMax value
		Function getRandom(iMax)
			call randomize()
			getRandom = Int(iMax * rnd()) + 1
		End Function
				
		Function transform(sXML, sXSL, msxml4)
			Dim oXML, oXSL, bLoad 
			
			if msxml4 then
				set oXML= createobject("Msxml2.DOMDocument.4.0")
				set oXSL= createobject("Msxml2.DOMDocument.4.0")
			else
				set oXML= createobject("Msxml2.DOMDocument")
				set oXSL= createobject("Msxml2.DOMDocument")
			end if
			
			oXML.async = False
			call oXML.setProperty("ServerHTTPRequest", True)
			
			oXSL.async = False
			call oXSL.setProperty("ServerHTTPRequest", True)
					
			
			'we load the XML
			if mid(sXML,1,1)="<" then
				bLoad = oXML.loadXML(sXML)
			elseif mid(sXML,1,4)="http" then
				bLoad = oXML.load(sXML)
			elseif mid(sXML,2,1)=":" then
				bLoad = oXML.load(sXML)
			else
				bload= false
				'bLoad = oXML.load(WScript.Path  & sXML)
			end if		
			
			if (oXML.parseError.errorCode<>0 or bLoad=false)  then
				transform = "XML parseError on line " &  oXML.parseError.line & ", reason : " & oXML.parseError.reason
				exit function
			end if
			                 
			'we load the XSL
			if mid(sXSL,1,1)="<" then
				bLoad = oXSL.loadXML(sXSL)
			elseif mid(sXSL,1,4)="http" then
				bLoad = oXSL.load(sXSL)
			elseif mid(sXSL,2,1)=":" then
				bLoad = oXSL.load(sXSL)
			else
				bload= false
				'bLoad = oXSL.load(ScriptingContext.Server.MapPath(sXSL))
			end if		
			
			if (oXSL.parseError.errorCode<>0 or bLoad=false) then
				transform =  "XSL parseError on line " & oXSL.parseError.line & ", reason : " & oXSL.parseError.reason         
				exit function
			end if
			
			transform = oXML.transformNode(oXSL)
			
			set oXML = nothing
			set oXSL = nothing
        End Function

  
  	' Mail send object
  	function Mailer(sObject, ToEmail,FromEmail,  Subject, Message, MailerPath, strAttachment, strHTML)
  		Dim FromName : FromName = ""
  		Dim ToName : ToName = ""
  		Dim MailerPort : MailerPort = 25
  		
  		select case sObject
  			case "CDOSYSMail"
  				call CDOSYSMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort, strAttachment, strHTML)
  			case "CDOMail"
  				call CDOMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort, strAttachment, strHTML)
			case "ASPMail"
  				call ASPMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
  			case "ASPQMail"
  				call ASPQMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
  			case "SASmtpMail"
  				call SASmtpMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
  			case "JMail"
  				call JMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort, strAttachment, strHTML)
  			case "ASPEmail"
  				call ASPEmail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort, strAttachment, strHTML)
  		end select
  		Mailer = ""	
  	end function
  	
	Function CDOSYSMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort, strAttachment, strHTML)
		Dim objCDOSYSMail
  
		Set objCDOSYSMail = CreateObject("CDO.Message")

		objCDOSYSMail.To = ToEmail
		objCDOSYSMail.From = FromEmail
		objCDOSYSMail.Subject = Subject

		if strHTML = "on" then
			objCDOSYSMail.HtmlBody = Message
		else
			objCDOSYSMail.TextBody = Message   
		end if

		if len(strAttachment) > 0 then
			objCDOSYSMail.AddAttachment(strAttachment)
		end if
		objCDOSYSMail.Send
	
		Set objCDOSYSMail = Nothing
		Set objCDOSYSCon = Nothing 

	End Function

  	function CDOMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort, strAttachment, strHTML)
		Dim objCDOMail

		Set objCDOMail = CreateObject("CDONTS.NewMail")
		objCDOMail.To = ToEmail
		objCDOMail.From = FromEmail
		objCDOMail.Subject = Subject

		if strHTML = "on" then
			objCDOMail.BodyFormat = 0
			objCDOMail.MailFormat = 0
		else
			objCDOMail.BodyFormat = 1			
			objCDOMail.MailFormat = 1
		end if

		objCDOMail.Body = Message

		if len(strAttachment) > 0 then
			objCDOMail.AttachFile strAttachment
		end if
		objCDOMail.Send

		Set objCDOMail = Nothing
	end function
	
	
	function ASPMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
		Dim Mailer
		Set Mailer = CreateObject("SMTPsvg.Mailer")
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
		Set Mailer = CreateObject("SMTPsvg.Mailer")
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
		Set Mailer = CreateObject("SoftArtisans.SMTPMail")
		Mailer.RemoteHost = MailerPath
		Mailer.AddRecipient ToName, ToEmail
		Mailer.FromName = FromName
		Mailer.FromAddress = FromEmail
		Mailer.Subject = Subject
		Mailer.BodyText = Message
		Mailer.SendMail
		Set Mailer = Nothing
	end function
	
	
	function JMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort, strAttachment, strHTML)
		Dim objJMail

		Set objJMail = CreateObject("JMail.SMTPMail")
		objJMail.ServerAddress = MailerPath & ":" & MailerPort
		objJMail.AddRecipient ToEmail
		objJMail.Sender = FromEmail
		objJMail.Subject = Subject

		if strHTML = "on" then
			objJMail.ContentType = "text/html"
		end if

		objJMail.Body = Message

		if len(strAttachment) > 0 then
			objJMail.AddAttachment strAttachment
		end if

		objJMail.Execute

		Set objJMail = Nothing
		JMail_Mailer = "toto"
	end function
	
	
	function ASPEmail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort, strAttachment, strHTML)
		Dim objASPEMail

		Set objASPEMail = CreateObject("Persits.MailSender")
		objASPEMail.Host = MailerPath
		objASPEMail.Port = MailerPort
		objASPEMail.From = FromEmail
		objASPEMail.FromName = FromName
		objASPEMail.AddAddress ToEmail,ToName
		objASPEMail.Subject = Subject

		if strHTML = "on" then
			objASPEMail.IsHTML = True
		else
			objASPEMail.IsHTML = False
		end if

		objASPEMail.Body = Message

		if len(strAttachment) > 0 then
			objASPEMail.AddAttachment strAttachment
		end if

		objASPEMail.Send
		Set objASPEMail = Nothing
	end function
  
]]></msxsl:script>
   
   
	
</xsl:stylesheet>