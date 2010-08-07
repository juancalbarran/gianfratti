<%
Response.Buffer = True
%>
<!-- #include file="ctransform.asp" -->
<%
' Get LTR / RTL support by reading data.xml
Set oGUITextDir = server.CreateObject("msxml2.domdocument.4.0") : oGUITextDir.async = false
sDataPath = Server.MapPath("../../db/data.xml")
If oGUITextDir.Load(sDataPath) Then
	' check textdirection into data.xml
	If oGUITextDir.selectNodes("/siteinfo/data/textdirection").length <> 0 Then
		' it´s a 2.4.x series - get textdirection "as is" into data.xml.
		sGUITextDir = oGUITextDir.selectNodes("/siteinfo/data/textdirection").item(0).nodetypedvalue 
	Else
		' it´s a 2.3.x series - set textdirection to LTR
		sGUITextDir = "LTR"
	End if 
Else
	sGUITextDir = "LTR"
End if
Set oGUITextDir = Nothing
%>
<html dir="<%=sGUITextDir%>">
<head>
	<style>
		body, td, textarea, input, select { font: messagebox; }
		body, form { height:100%; }
		.msg {text-align: center; font-weight: bold;}
		table.strings { width: 100%; background: #f0f0f0; }
		tr.strings { border: 0px; background: buttonface; }
		td.strings { border: 1px; text-align: center; font-weight: bold; }
		td.string { border: 1px black solid; background: white; vertical-align: top }
		td.native { background: buttonface; font-weight: normal; }
		div.native { margin-left:3px; }
		input.infos {border: 1px black solid; width: 288px; }
		textarea.string { margin-left: 1px; border: 0px; width: 100%; overflow: visible; }
		textarea.wrong { margin-left: 1px; border: 0px; width: 100%; overflow: visible; color: navy; font-weight: bold; }
		textarea.similar { margin-left: 1px; border: 0px; width: 100%; overflow: visible; color: green; font-weight: bold; }
		option.invalid { color: gray; font-weight: bold; }
		option.wrong { color: navy; font-weight: bold; }
		option.similar { color: green; font-weight: bold; }
	</style>
</head>
<%
	Dim sLanguage : sLanguage = Request("language")
	Dim sfilter : sfilter = Request("filter")
	Dim sfiledetails : sfiledetails = Request("filedetails")
	Dim saction : saction = Request("action")
%>
<body>
<% 
	' language name was passed, decide between load it or create it.
	if lenb(request("languagename"))>0 then

		' Load the _index.xml into the DOM
		Dim oDom, oNode, oNewNode, oCdata, iCount, sInfos
		Set oDom = server.CreateObject("msxml2.domdocument.4.0") : oDom.async = false
		Set oNode = server.CreateObject("msxml2.domdocument.4.0") : oNode.async = false
		oDom.load(Server.MapPath("../../Engine/Languages/_index.xml"))

		sLanguage = Request.Form("languagename")

		' the uniqueness of names, for both language and file, is very important.
		' that´s what prevent files to be overwritten, accidentally.
		' first, remove any typed spaces and ".xml" extension from sLanguage.
		' second, convert sLanguage to proper case.
		' third, set sFilename to sLanguage plus ".xml" extension, replacing spaces by underlines.
		sLanguage = Trim(Replace(Lcase(sLanguage),".xml",""))
		sLanguage = PCase(slanguage)
		sFilename = Trim(Replace(Lcase(sLanguage)," ","_")) & ".xml"

		' language name already exists: just load that file for updates.
		If oDom.selectNodes("/languages/language[name='" & slanguage & "']").length = 1 Then

			'now, get the file name from _index.xml
			sFilename = oDom.selectNodes("/languages/language[name='" & slanguage & "']/filename").item(0).nodetypedvalue

			Set oDom = Nothing
			Set oNode = Nothing

			sfilter = "all"
			showEditor(sFilename)
		Else
			' file name already exists: just load that file for updates.
			If oDom.selectNodes("/languages/language[filename='" & sFileName & "']").length = 1 Then

				Set oDom = Nothing
				Set oNode = Nothing

				sfilter = "all"
				showEditor(sFilename)
			Else

				' Both language and file name not existing: create the file, register it and load it.
				sInfos =	vbCrLf & vbtab & "<language>" & vbCrLf &_
						vbtab & "<id>" & iCount & "</id>" &_
						vbtab & "<name>" & sLanguage & "</name>" & vbCrLf &_
						vbtab & "<filename>" & sFilename & "</filename>" & vbCrLf &_
						vbtab & "<helpfile>FULLXMLDocumentation.htm</helpfile>" & vbCrLf &_
						vbtab & "<translator>" & vbCrLf &_
						vbtab & vbtab & "<name>" & Request.Form("translatorname") & "</name>" & vbCrLf &_
						vbtab & vbtab & "<email>" & Request.Form("translatoremail") & "</email>" & vbCrLf &_
						vbtab & "</translator>" & vbCrLf &_
						vbtab & "<encoding>" & Request.Form("encoding") & "</encoding>" & vbCrLf &_
						vbtab & "<dir>" & Request.Form("textdir") & "</dir>" & vbCrLf &_
						"</language>" & vbCrLf

				' stop in case of errors... otherwise, keep going!
				if not oNode.loadXML(sInfos) then
					Response.Write oNode.parseError.reason
					Response.End
				end if

				' creates a new xml file with the name of language.
				' file contains just a copy of the infos registered above.
				' the true file contents will be generated later,
				' only if the user decides to save his job.
				oNode.save Server.MapPath("../../Engine/Languages/" & sFilename)

				Set oDom = Nothing
				Set oNode = Nothing

				'saction = "create"
				sfilter = "new"
				showEditor(sFilename)

			End If
		End if

	ElseIf lenb(sLanguage)=0 then
		' no language was passed, display the initial page.
		showSelector
		
	Else
		' a language was passed, load it.
		showEditor(sLanguage)
	End If
%>
<%
	'-- 
	Sub showEditor(sLanguage)
		Dim oTrans 
		set oTrans = new CTransform
		
		oTrans.DebugMode = false
		Call oTrans.Sources("../../engine/languages/english.xml", "langedit.xslt")		
		oTrans.AddParam "language", server.MapPath("../../engine/languages/" & sLanguage)
		oTrans.AddParam "selected_filter", sfilter
		oTrans.AddParam "file_details", sfiledetails
		oTrans.AddParam "encoding", server.MapPath("../../admin/langedit/encoding.xml")
		oTrans.AddParam "file_action", saction
		Call oTrans.Process()
		
		Response.Write oTrans.Content
		set oTrans = nothing
	End Sub
	
	Sub showSelector
		Dim oTrans 
		set oTrans = new CTransform
		
		oTrans.DebugMode = false
		Call oTrans.Sources("../../engine/languages/_index.xml", "selector.xslt")		
		oTrans.AddParam "encoding", server.MapPath("../../admin/langedit/encoding.xml")
		Call oTrans.Process()
		
		Response.Write oTrans.Content
		set oTrans = nothing
	End Sub
%>
</body>
</html>