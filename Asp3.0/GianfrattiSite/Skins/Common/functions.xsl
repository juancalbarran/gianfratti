<?xml version="1.0" encoding="ISO-8859-1"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:vb="http://msgxml.com/vb" xml:space="preserve">

    
<xsl:output method="html" encoding="ISO-8859-1"/> 
	   
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
  	function Mailer(sObject, ToEmail,FromEmail,  Subject, Message, MailerPath)
  		Dim FromName : FromName = ""
  		Dim ToName : ToName = ""
  		Dim MailerPort : MailerPort = 25
  		
  		select case sObject
  			case "CDOSYSMail"
  				call CDOSYSMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
  			case "CDOMail"
  				call CDOMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
			case "ASPMail"
  				call ASPMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
  			case "ASPQMail"
  				call ASPQMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
  			case "SASmtpMail"
  				call SASmtpMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
  			case "JMail"
  				call JMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
  			case "ASPEmail"
  				call ASPEmail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
  		end select
  		Mailer = ""	
  	end function
  	
	function CDOSYSMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
		Dim Mailer
		Set Mailer = CreateObject("CDO.Message")
		Mailer.To = ToEmail
		Mailer.From = FromEmail
		Mailer.Subject = Subject
		Mailer.TextBody = Message
		Mailer.Send
		Set Mailer = Nothing
	end function

  	function CDOMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
		Dim Mailer
		Set Mailer = CreateObject("CDONTS.NewMail")
		Mailer.To = ToEmail
		Mailer.From = FromEmail
		Mailer.Subject = Subject
		Mailer.Body = Message
		Mailer.Send
		Set Mailer = Nothing
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
	
	
	function JMail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
		Dim Mailer
		Set Mailer = CreateObject("JMail.SMTPMail") 'CreateObject("JMail.Message") 
		Mailer.ServerAddress = MailerPath & ":" & MailerPort
		Mailer.AddRecipient ToEmail
		Mailer.Sender = FromEmail
		Mailer.Subject = Subject
		Mailer.Body = Message
		Mailer.Execute
		Set Mailer = Nothing
		JMail_Mailer= "toto"
	end function
	
	
	function ASPEmail_Mailer(Message, FromEmail, ToEmail, FromName, ToName, Subject, MailerPath, MailerPort)
		Dim Mailer
		Set Mailer = CreateObject("Persits.MailSender")
		Mailer.Host = MailerPath
		Mailer.Port = MailerPort
		Mailer.From = FromEmail
		Mailer.FromName = FromName
		Mailer.AddAddress ToEmail,ToName		'Mailer.AddAddress ToName, ToEmail
		Mailer.Subject = Subject
		Mailer.Body = Message
		Mailer.Send
		Set Mailer = Nothing
	end function


	function GetPath(strPath)
		strPath=Trim(strPath)

		strPath=Replace(strPath, "/", "\")
		if left(strPath, 1) <> "\" then
			strPath = "\" & strPath
		end if
		while right(strPath, 1) = "\"
			strPath = Left(strPath, len(strPath) -1)
		wend
		GetPath = strPath		
	end function

	Public function GetFolderInfo(strPath)
		Dim strInfoFile
		Dim objFSO
		Dim objFile
		Dim strInfo

		Const strFileName = "\folder.txt"

		strInfoFile = strPath & strFileName
		strInfo     = ""
		
		Set objFSO = CreateObject("Scripting.FileSystemObject")
		If objFSO.FileExists(strInfoFile) then
			Set objFile= objFSO.OpenTextFile(strInfoFile, 1)
			Do While Not(objFile.AtEndOfStream)
				strInfo = strInfo & objFile.ReadLine
			Loop
		End If

		GetFolderInfo = strInfo

		Set objFile = Nothing
		Set objFSO = Nothing
	End Function
	
	Function GetSubFolders(strBasePath, strPath)
		On Error Resume Next

		Dim objFSO
		Dim objFolder
		Dim objSubFolder
		Dim strParentPath
		Dim lngPathLength
		Dim strReturn

		strReturn = ""

		strPath = Trim(strPath)
		if len(strPath) > 1 then
			strPath = GetPath(strPath)

			strParentPath = strBasePath & strPath

			lngPathLength = len(strBasePath) + 1
			Set objFSO = CreateObject("Scripting.FileSystemObject")
			Set objFolder = objFSO.GetFolder(strParentPath)

			For Each objSubFolder In objFolder.SubFolders
				If Len(strReturn) > 0 Then
					strReturn = strReturn & Mid(objSubFolder.path, lngPathLength) & "*"
'					strReturn = strReturn & GetFolderInfo(objSubFolder.path) & "*"
				Else
					strReturn = Mid(objSubFolder.path, lngPathLength) & "*"
'					strReturn = GetFolderInfo(objSubFolder.path) & "*"
				End If
			Next
		end if

		if Len(strReturn) < 1 Then
			strReturn = ""
		end if

		GetSubFolders = strReturn

		Set objSubFolder = Nothing
		Set objFolder = Nothing
		Set objFSO = Nothing
	End Function

	Public function GetThumbNail(strPath, strFilename)
		Dim strThumbFile
		Dim objFSO
		Const strThumb = "THUMB_"

		if Not(IsThumbNail(strFilename)) and len(trim(strFilename)) > 0 then
			strThumbFile = strThumb & strFileName
		
			Set objFSO = CreateObject("Scripting.FileSystemObject")
			if objFSO.FileExists(strPath & "\" & strThumbFile) then
				GetThumbNail = strThumbFile
			else
				GetThumbNail = strFileName
			end if
			Set objFSO = Nothing
		else
			GetThumbNail = strFileName
		end if

		Set objFSO = Nothing
	End Function

	Public function GetPictureFromThumbNail(strFilename)
		Dim strPictureFile
		Const strThumb = "THUMB_"

		if IsThumbNail(strFilename) then
			strPictureFile = Mid(strFileName, len(strThumb) + 1)
			
			GetPictureFromThumbNail = strPictureFile
		else
			GetPictureFromThumbNail = strFileName
		end if
	End Function

	Public function IsThumbNail(strFilename)
		Dim strFileStart
		Dim strThumb 
		
		strThumb = "THUMB_"

		'** parse for file type extension
		if len(trim(strFilename)) = 0 then
			IsThumbNail = false
			Exit Function
		end if

		strFileStart = ucase(left(strFileName, len(strThumb)))

		select case strFileStart
			case "THUMB_":
				IsThumbNail = true
			case else:
				IsThumbNail = false
		end select
	End Function

	Public Function FileExtensionOK(strFilename)
		Dim strFileExtension, bFileExtensionIsValid, sFileExt

		'** parse for file type extension
		if len(trim(strFilename)) = 0 then
			FileExtensionOK = false
			Exit Function
		end if

		strFileExtension = ucase(right(strFileName, len(strFileName) - instrrev(strFileName, ".")))

		select case strFileExtension
			case "GIF":
				FileExtensionOK = true
			case "JPG":
				FileExtensionOK = true
			case else:
				FileExtensionOK = false
		end select
	End Function

	function GetPictures(strBasePath, strPath)
		On Error Resume Next

		Dim objFSO
		Dim objFolder
		Dim objPicture
		Dim strParentPath
		Dim strReturn
		Dim strFilename
		
		Trim(strPath)
		if len(strPath) > 1 then
			strPath = GetPath(strPath)
			strParentPath = strBasePath & strPath

			Set objFSO = CreateObject("Scripting.FileSystemObject")		
			Set objFolder = objFSO.GetFolder(strParentPath)
		
			For Each objPicture In objFolder.Files
				if Not(IsThumbNail(objPicture.name)) then
					strFilename = GetThumbNail(strParentPath, objPicture.name)
					if FileExtensionOK(strFilename) then
						if Len(strReturn) > 0 Then
							strReturn = strReturn & strFilename & "*"
						else
							strReturn = strFilename & "*"
						end if
					end if
				end if
			Next
		end if

		if Len(strReturn) < 1 Then
			strReturn = "."
		end if
		
		GetPictures = strReturn

		Set objFSO = Nothing
		Set objFolder = Nothing
		Set objPicture = Nothing
	end function

	function ShowPicture(strBasePath, strPath, lngIndex)
		On Error Resume Next

		Dim objFSO
		Dim objFolder
		Dim objPicture
		Dim strParentPath
		Dim strReturn
		Dim lngCounter
		
		strPath = Trim(strPath)
		lngCounter = 0
		if len(strPath) > 1 then
			strPath = GetPath(strPath)
			strParentPath = strBasePath & strPath

			Set objFSO = CreateObject("Scripting.FileSystemObject")		
			Set objFolder = objFSO.GetFolder(strParentPath)
		
			For Each objPicture In objFolder.Files
				if FileExtensionOK(objPicture.name) then
					lngCounter = lngCounter + 1
					if lngCounter = lngIndex then
						strReturn = objPicture.name
					end if
				end if
			Next
		end if

		if Len(strReturn) < 1 Then
			strReturn = ""
		end if
		
		ShowPicture = strReturn

		Set objFSO = Nothing
		Set objFolder = Nothing
		Set objPicture = Nothing
	end function

	function GetPrevPicture(strBasePath, strPath, strCurrPic)
		On Error Resume Next

		Dim objFSO
		Dim objFolder
		Dim objPicture
		Dim strParentPath
		Dim strReturn
		Dim strFile
		
		Trim(strPath)
		if len(strPath) > 1 then
			strPath = GetPath(strPath)
			strParentPath = strBasePath & strPath

			Set objFSO = CreateObject("Scripting.FileSystemObject")		
			Set objFolder = objFSO.GetFolder(strParentPath)
		
			For Each objPicture In objFolder.Files
				if Not(IsThumbNail(objPicture.name)) then
					if FileExtensionOK(objPicture.name) then					
						if strCurrPic = objPicture.name then
							exit for
						else
							strReturn = objPicture.name
						end if
					end if
				end if
			Next
		end if

		if Len(strReturn) < 1 Then
			strReturn = ""
		end if
		
		GetPrevPicture = strReturn

		Set objFSO = Nothing
		Set objFolder = Nothing
		Set objPicture = Nothing
	end function

	function GetNextPicture(strBasePath, strPath, strCurrPic)
		On Error Resume Next

		Dim objFSO
		Dim objFolder
		Dim objPicture
		Dim strParentPath
		Dim strReturn
		Dim boolBreak
		
		Trim(strPath)
		if len(strPath) > 1 then
			strPath = GetPath(strPath)
			strParentPath = strBasePath & strPath

			Set objFSO = CreateObject("Scripting.FileSystemObject")		
			Set objFolder = objFSO.GetFolder(strParentPath)
		
			boolBreak = false
			For Each objPicture In objFolder.Files
				if Not(IsThumbNail(objPicture.name)) then
					if FileExtensionOK(objPicture.name) then
						if boolBreak then
							strReturn = objPicture.name
							exit for
						else
							if strCurrPic = objPicture.name then
								boolBreak = true
							end if
						end if
					end if
				end if
			Next
		end if

		if Len(strReturn) < 1 Then
			strReturn = ""
		end if
		
		GetNextPicture = strReturn

		Set objFSO = Nothing
		Set objFolder = Nothing
		Set objPicture = Nothing
	end function

	function GetFolderName(strPath)
		Dim lngPos
		Dim strReturn

		strPath = GetPath(strPath)
		lngPos = InStrRev(strPath, "\") + 1
		if lngPos > 0 then
			strReturn = Mid(strPath, lngPos)
		else
			strReturn = strPath
		end if

		GetFolderName = strReturn
	end function

	function GetParentPath(strPath)
		Dim lngPos
		Dim strReturn

		strPath = Replace(strPath, "/", "\")
		lngPos = InStrRev(strPath, "\") - 1
		if lngPos > 0 then
			strReturn = Left(strPath, lngPos)
		else
			strReturn = strPath
		end if

		GetParentPath = strReturn
	end function
]]>

</msxsl:script>
	
</xsl:stylesheet>