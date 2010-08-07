<SCRIPT LANGUAGE="VBScript" RUNAT="Server">
	

	'URL decode Function
	'2001 Antonin Foller, PSTRUH Software, http://www.pstruh.cz
	Function URLDecode(ByVal What)
		Dim Pos, pPos

		'replace + To Space
		What = Replace(What, "+", " ")

		on error resume Next
		Dim Stream: Set Stream = CreateObject("ADODB.Stream")
		If err = 0 Then 'URLDecode using ADODB.Stream, If possible
			on error goto 0
			Stream.Type = 2 'String
			Stream.Open

			'replace all %XX To character
			Pos = InStr(1, What, "%")
			pPos = 1
			Do While Pos > 0
			Stream.WriteText Mid(What, pPos, Pos - pPos) + _
				Chr(CLng("&H" & Mid(What, Pos + 1, 2)))
			pPos = Pos + 3
			Pos = InStr(pPos, What, "%")
			Loop
			Stream.WriteText Mid(What, pPos)

			'Read the text stream
			Stream.Position = 0
			URLDecode = Stream.ReadText

			'Free resources
			Stream.Close
		Else 'URL decode using string concentation
			on error goto 0
			'UfUf, this is a little slow method. 
			'Do Not use it For data length over 100k
			Pos = InStr(1, What, "%")
			Do While Pos>0 
			What = Left(What, Pos-1) + _
				Chr(Clng("&H" & Mid(What, Pos+1, 2))) + _
				Mid(What, Pos+3)
			Pos = InStr(Pos+1, What, "%")
			Loop
			URLDecode = What
		End If
	End Function
	

	'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	' Return a random string
	'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	Private Function GetGuid(intLen)
		Dim strTemp
		Dim strChar
		Dim i
		i = 0
		randomize
		do While i < intLen  
			strChar = int(rnd * 74) + 48
			if 	(strChar >= 48 and strChar <= 57) or _
				(strChar >= 65 and strChar <= 90) or _
				(strChar >= 97 and strChar <= 122) Then
				i = i + 1
				strTemp = strTemp + chr(strChar)
			End if
		Loop
		GetGuid = strTemp
	End Function		


	'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	' Return 2nd Param if the first is empty 
	'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	Public Function NZ(strValue, strDefault)
		if lenb(strValue)=0 or isnull(strValue) or strValue=0 then
			NZ = strDefault
		else
			NZ = strValue
		End If
	End Function 
	
	
	'Sub SaveXMLFile(sFileName, byref sContent)
	'	Dim objFSO, objFile		
	'	
	'	Set objFSO	= server.CreateObject("scripting.Filesystemobject")
	'		Set objFile = objFSO.CreateTextFile(sFileName, True, True)
	'			objFile.Write(sContent)
	'			objFile.Close()
	'		Set objFile = nothing
	'	Set objFSO	= nothing
	'End Sub
	
	'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	' Add a xml node into an xmldomdocument
	'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	Public Function Append(sXml, byref oXMLDoc)
   	
		Dim oXMLDocTemp
		Dim iIndex
		Dim ndTemp
		Dim xmlNode
		Dim sXmlFile
		Dim sError
		
		Set oXMLDocTemp = Server.CreateObject(MSXML_PROGID2)   'MSXML_PROGID)
		oXMLDocTemp.async = false
		
		oXMLDocTemp.loadXml(sXml)
		
		call oXMLDoc.documentElement.appendChild(oXMLDocTemp.documentElement.cloneNode(true))
				
		set Append = oXMLDoc
				
		Set ndTemp = Nothing
		Set oXmldocTemp = Nothing
		set xmlNode = Nothing
	End Function
	
	
	'========================================
	'----  Checks if the xml files exist ----
	'========================================
	'    if not copy from the default one
	'========================================
	'transform that as jscript
	Sub CheckAllFiles()		
		Dim sText
		Dim objFSO : Set objFSO	= server.CreateObject("scripting.Filesystemobject")
		Dim objFile					
		Dim arrFolders
		Dim arrFiles
		Dim i
			
		'We create missing folders
		arrFolders = array(DB_DIRECTORY, LOGS_FOLDER, UPLOAD_PATH, ARTICLES_FOLDER)	
		for i=0 to uBound(arrFolders)
			If not objFSO.FolderExists(arrFolders(i)) Then	
				objFSO.CreateFolder(arrFolders(i)) 
			End if
		next
						
		'We create missing files
		If NOT objFSO.FileExists(DOWNLOAD_PATH) Then 
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\downloads.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(DOWNLOAD_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End If
				
		If NOT objFSO.FileExists(MEMBER_PATH) Then 
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\member.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(MEMBER_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End If
				
		If NOT objFSO.FileExists(REACTION_PATH)	Then 
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\reaction.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(REACTION_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End If
				
		If NOT objFSO.FileExists(GUESTBOOK_PATH) Then 
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\guestbook.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(GUESTBOOK_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End If
				
		If NOT objFSO.FileExists(DISCUSSION_PATH) Then 
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\discussion.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(DISCUSSION_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End If
				
		If NOT objFSO.FileExists(POLL_PATH)	Then 
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\poll.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(POLL_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End If
				
		If NOT objFSO.FileExists(MEDIA_PATH)	Then 
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\media.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(MEDIA_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End If
			
		If NOT objFSO.FileExists(TASK_PATH)	Then 
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\task.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(TASK_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End If
						
				
		If NOT objFSO.FileExists(DATA_PATH)	Then 					
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\data.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(DATA_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End if
			
		If NOT objFSO.FileExists(CATEGORY_PATH)	Then 					
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\category.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(CATEGORY_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End if
			
		If NOT objFSO.FileExists(BANNER_PATH)	Then 					
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\banner.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(BANNER_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End if
			
		If NOT objFSO.FileExists(DIRECTORY_PATH)	Then 					
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\directories2.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(DIRECTORY_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End if
		
		If NOT objFSO.FileExists(SKIN_PATH)	Then 					
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\skinstudio.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(SKIN_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End if

		If NOT objFSO.FileExists(LIST_PATH)	Then 					
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\list.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(LIST_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End if		

		If NOT objFSO.FileExists(KB_PATH)	Then 					
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\knowbase.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(KB_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End if				

		If NOT objFSO.FileExists(NEWSLETTER_PATH)	Then 					
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\newsletter.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(NEWSLETTER_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End if

		If NOT objFSO.FileExists(CALENDAR_PATH) Then
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\calendar.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(CALENDAR_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End if

		If NOT objFSO.FileExists(CHAT_PATH)	Then 					
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\chat.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(CHAT_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End if

		If NOT objFSO.FileExists(FRIENDS_PATH)	Then 					
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\friends.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(FRIENDS_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End if

		If NOT objFSO.FileExists(INTERNALMESSAGE_PATH)	Then 					
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\imessages.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(INTERNALMESSAGE_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End if

		If NOT objFSO.FileExists(CLASSIFIED_PATH)	Then 					
			Set objFile = objFSO.OpenTextFile(ROOT_PATH & "\engine\samplesite\classified.xml", 1)
				sText = objFile.ReadAll
			Set objFile = nothing
				
			Set objFile = objFSO.CreateTextFile(CLASSIFIED_PATH, True)
				Call objFile.Write(sText)
			Set objFile = nothing
		End if		
				
		Set objFSO	= nothing
			
		if err<>0 then
			err.Clear
			Response.Write "<font face=arial><b>Warning :</b> To complete installation, you must give write permission to the database and media directories (under IIS console, and explorer if you use NTFS).</font>" 
			Response.End
		end if
			
	End Sub
	
	'clean an xml parameter by replacing the Entity
	Public Function CleanParameter(sText)
		CleanParameter = replace(replace(replace(replace(replace(sText, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"), chr(34), "&quot;"), "'", "&apos;")
	End Function
		
	Public Function IsInArray(FindValue, arrSearch)
		IsInArray = false
	    If Not IsArray(arrSearch) Then Exit Function
	    IsInArray = InStr(1, vbNullChar & Join(arrSearch, vbNullChar) & vbNullChar, vbNullChar & FindValue & vbNullChar) > 0
	End Function
	
</SCRIPT>



<SCRIPT LANGUAGE="JScript" RUNAT="Server">
	
	//==================================================
	// call the vbscrip function with an error trapping
	//==================================================
	function JSCheckAllFiles()
	{
		try
		{
			CheckAllFiles();
		}
		catch(e) {
			 Response.Write("<font face=arial><b>Warning :</b> To complete installation, you must give write permission to the database and media directories (under IIS console, and explorer if you use NTFS).</font><br>");
			 return false;
		}
	}
	
	//==================================================
	// Save an xml file with FSO
	//==================================================
	function SaveXMLFile(sFileName, sContent)
	{
		var objFSO, objFile;
		
		try
		{
			objFSO	= new ActiveXObject("Scripting.FileSystemObject"); 
			objFile = objFSO.CreateTextFile(sFileName, true, true);
			
		}
		catch(e) {
			 Response.AppendToLog("SaveXMLFile " + e);
			 Response.Write("<font face=arial><b>Warning :</b> To complete installation, you must install VBScript runtime version 5.6.</font><br>");
			 return false;
		}
		
		
		try
		{			
			objFile.Write(sContent);
			objFile.close();			
		}
		catch(e) {
			Response.AppendToLog("SaveXMLFile " + e);
			Response.Write("<font face=arial><b>Warning :</b> Can't save xml file. Check the write permission.</font><br>");
			 //objFile = objFSO.CreateTextFile(sFileName + "." + GetGuid(6), true, true);
			//objFile.Write(sContent);
			//objFile.close();
			return false;
		}
		
		//Response.Write(sFileName + " is updated.<br/>");
	}
	
</SCRIPT>