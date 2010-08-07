<!-- #include file="ctransform.asp" -->
<html>
<head>
	<style>
		body {font-family: arial; font-size: 12px;}
	</style>
</head>
<body>
<%
	Dim saction    : saction = Request("action")
	Dim sIndexFile : sIndexFile  = Server.MapPath("../../Engine/Languages/_index.xml")
	Dim sFile      : sFile       = Request("language")
	Dim sFilename  : sFilename   = Right(sFile,Len(sFile) - InstrRev(sFile, "\", -1, 1))
	Dim sLanguage  : sLanguage   = PCase(Trim(Replace(Lcase(Request.Form("languagename")),".xml","")))
	Dim sTranslator: sTranslator = Request.Form("translatorname") 
	Dim sEmail     : sEmail      = Request.Form("translatoremail") 
	Dim Encoding   : sEncoding   = Request.Form("encoding")
	Dim sTextDir   : sTextDir    = Request.Form("textdir")


	Dim str, ncounter
	Dim oDom, oNode, oNewNode, oCdata
	set oDom = server.CreateObject("msxml2.domdocument.4.0") : oDom.async = false

	' ensure encoding is not empty
	If sEncoding = "" Then
		sEncoding = "UTF-8"
	End If

	' Begin of _index.xml manipulation.
	Set oNode = server.CreateObject("msxml2.domdocument.4.0") : oNode.async = false

	' Backup the current index_xml
	if oDom.load(sIndexFile) then
		oDom.save(sIndexFile & "." & cstr(Year(Now) & Right("0" & Month(Now), 2) & Right("0" & Day(Now), 2) & Right("0" & Hour(Now), 2) & Right("0" & Minute(Now), 2)) & ".xml")
	end if

	' Evaluate language name availability to ensure data integrity.
	' An user can edit the "Language Name", so prevent duplicated entries into _index.xml.
	' Read the language name previously recorded into _index.xml
	'sLanguageStored   = PCase(oDom.selectNodes("/languages/language[filename='" & sFilename & "']/name").item(0).nodetypedvalue)

	sLanguageStored = sLanguage
	If oDom.selectNodes("/languages/language[filename='" & sFilename & "']").length = 1 then
		sLanguageStored   = PCase(oDom.selectNodes("/languages/language[filename='" & sFilename & "']/name").item(0).nodetypedvalue)
	End if


	' Check if language name passed is unique or not, counting its usage along _index.xml.
	' [name=slanguage].lenght : 1 <= available ; > 1 = duplicated!)
	iLanguageNameCount = oDom.selectNodes("/languages/language[name='" & sLanguage & "']").length 

	Select Case iLanguageNameCount 
		Case 0
			' valid name, exactly as passed by user
			sLanguage = sLanguage
		Case 1 And sLanguage = sLanguageStored 
			' valid name, it was used only for current file
			sLanguage = sLanguage
		Case Else
			' already used or duplicated names.
			' rename to: language name + regressive counter
			sLanguage = sLanguage & " #" & (iLanguageNameCount - (iLanguageNameCount - 1))
	End Select 

	' decide between create or update the registry.
	'If oDom.selectNodes("/languages/language[name='" & slanguage & "']").length = 1 Then
	If oDom.selectNodes("/languages/language[filename='" & sFilename & "']").length = 1 then

		' Existing language: update registry.
		' Read the nodes values through the DOM 
		sLanguageId = oDom.selectNodes("/languages/language[filename='" & sFilename & "']/id").item(0).nodetypedvalue 

		' Backward Compability Issue: the DIR node (linguistic text-direction).
		' Check the DIR node presence, previous files may have not this node.
		If oDom.selectNodes("/languages/language[filename='" & sFilename & "']/dir").length = 0 Then

			' Creates the DIR node with passed text-direction.
			Set oNewDir = oDom.createElement("dir")
			oNewDir.Text = sTextDir

			' Creates the indentation (simple)
			Set oIndent = oDom.CreateTextNode(vbCrLf & vbtab)

			' Start from the root element
			Set oRoot = oDom.documentElement

			' Language ID works as a node tree position for:
			' 1 - insert our new DIR element
			oRoot.childNodes.item(sLanguageID-1).appendchild oNewDir

			' 2 - insert the indentation
			oRoot.childNodes.item(sLanguageID-1).appendchild oIndent

			' release objects used for DIR node creation.
			Set oNewDir = Nothing
			Set oIndent = Nothing
			Set oRoot = Nothing

		End If					

		' Now, update the nodes values through the DOM
		Set oNodes = oDom.DocumentElement

		'sLanguage is user editable
		Set oNode  = oNodes.selectSingleNode("/languages/language[filename='" & sFilename & "']/name")
		oNode.Text = sLanguage

		'sTranslator is user editable
		Set oNode  = oNodes.selectSingleNode("/languages/language[filename='" & sFilename & "']/translator/name")
		oNode.Text = sTranslator

		'sEmail is user editable
		Set oNode  = oNodes.selectSingleNode("/languages/language[filename='" & sFilename & "']/translator/email")
		oNode.Text = sEmail

	        'sEncoding is user editable
		Set oNode  = oNodes.selectSingleNode("/languages/language[filename='" & sFilename & "']/encoding")
		oNode.Text = sEncoding

	        'sTextDir is user editable
		Set oNode  = oNodes.selectSingleNode("/languages/language[filename='" & sFilename & "']/dir")
		oNode.Text = sTextDir

	Else
		' Non-existing language: create registry.
		' Calculates the next language id 
		iCount = oDom.selectNodes("/languages/language").length + 1

		sInfos =	vbCrLf & vbtab & "<language>" & vbCrLf &_
				vbtab & "<id>" & iCount & "</id>" &_
				vbtab & "<name>" & sLanguage & "</name>" & vbCrLf &_
				vbtab & "<filename>" & sFilename & "</filename>" & vbCrLf &_
				vbtab & "<helpfile>FULLXMLDocumentation.htm</helpfile>" & vbCrLf &_
				vbtab & "<translator>" & vbCrLf &_
				vbtab & vbtab & "<name>" & sTranslator & "</name>" & vbCrLf &_
				vbtab & vbtab & "<email>" & sEmail & "</email>" & vbCrLf &_
				vbtab & "</translator>" & vbCrLf &_
				vbtab & "<encoding>" & sEncoding & "</encoding>" & vbCrLf &_
				vbtab & "<dir>" & sTextDir & "</dir>" & vbCrLf &_
				"</language>" & vbCrLf

		' stop in case of errors... otherwise, keep going!
		if not oNode.loadXML(sInfos) then
			Response.Write oNode.parseError.reason
			Response.End
		end if

		' Append the language nodes (sInfos) into the DOM
		oDom.documentElement.appendChild(oNode.documentElement.cloneNode(true))
		'oDom.save Server.MapPath("../../Engine/Languages/_index.xml")
	End if

	' Save the _index.xml
	oDom.save sIndexFile

	' releases the oNode object - will be recreated again later, in file saving.
	Set oNode = Nothing

	' End of _index.xml manipulation.

	' Begin of language.xml manipulation.

	Dim sInfos
	sInfos =	vbtab & "<name>" & sLanguage & "</name>" & vbCrLf &_
			vbtab & "<encoding>" & sEncoding & "</encoding>" & vbCrLf &_
			vbtab & "<dir>" & sTextDir & "</dir>" & vbCrLf &_
			vbtab & "<translator>" & vbCrLf &_
			vbtab & vbtab & "<name>" & sTranslator & "</name>" & vbCrLf &_
			vbtab & vbtab & "<email>" & sEmail & "</email>" & vbCrLf &_
			vbtab & "</translator>" & vbCrLf 
	
	' Backup the current language.xml
	if oDom.load(sFile) then
		oDom.save(sFile & "." & cstr(Year(Now) & Right("0" & Month(Now), 2) & Right("0" & Day(Now), 2) & Right("0" & Hour(Now), 2) & Right("0" & Minute(Now), 2)) & ".xml")
	end if
	
	' Create the DOM using the strings from Editor form 
	if oDom.loadXML("<?xml version=""1.0"" encoding=""" & sEncoding & """ ?><language>" & sInfos & "<strings>" & vbCrLf & vbtab & "</strings>" & vbCrLf & "</language>") then
	
		Set oNode = oDom.SelectSingleNode("/language/strings")	
		ncounter = 0

		' Interact with form elements
		For i = 1 to cint(Request.Form("count"))

			ncounter = ncounter + 1
			Set oNewNode = oDom.createElement("string")

			' comment for @ position, at first line and each 10 lines
			If i=1 or ncounter = 10 Then

				' resets the line counter
				If ncounter = 10 then
					ncounter = 0
				End If

				' comment indentation (double)
				oNode.appendChild oDom.CreateTextNode(vbCrLf & vbtab & vbtab)

				' comment text
				strcomment = " " & i & " "
				oNode.appendChild oDom.CreateComment(strcomment)
			End If
			
			' string indentation (double)
			oNode.appendChild oDom.CreateTextNode(vbCrLf & vbtab & vbtab)
			
			if instr(1, Request.Form(cstr(i)), "<")>0 or instr(1, Request.Form(cstr(i)), ">")>0 then
				Set oCdata = oDom.createCDATASection(cstr(Request.Form(cstr(i))))
				oNewNode.appendChild(oCdata)
			else
				oNewNode.text = cstr(Request.Form(cstr(i)))
			end if
			oNode.appendChild(oNewNode)		
		Next

		' strings node indentation (simple)
		oNode.appendChild oDom.CreateTextNode(vbCrLf & vbtab)
	
		' Save the language.xml
		oDom.save sFile
		
		Response.Write "Language file saved.<br>Please share your translation with other fullxml users."
		Response.Write "<br>Email your <b>" & sFile & "</b> language file <a href=mailto:roland@fullxml.com>here</a>."
	else
		Response.Write "error"
	end if
	
	Set odom = Nothing

	' End of language.xml manipulation.
%>
</body>
</html>