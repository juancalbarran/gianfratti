<!-- #include file="CONST.asp" -->
<!-- #include file="Functions.asp" -->
<!-- #include file="CRc4.asp" -->
<!-- #INCLUDE FILE="xmlfunctions.asp" -->
<!-- #INCLUDE FILE="CBrowser.asp" -->
<!-- #INCLUDE FILE="FileUpload.asp" -->
<!-- #INCLUDE FILE="CXForm.asp" -->
<!-- #INCLUDE FILE="CUser.asp" -->
<!-- #INCLUDE FILE="CChatSession.asp" -->
<!-- #INCLUDE FILE="CChatUser.asp" -->
<%			
	'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	' This class handle the display of a webpage of FULLXML
	' Created on 3/09/2001
	' Last modified on 17/05/2002
	' developped by John Roland, toolsheddown@wanadoo.fr
	'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	
	Class CFullXMLEngine
		Private m_sAction
		Private	m_sSkin
		Private m_sSkinName
		Private	m_sEmail
		Private m_iUserMessage
 		Private m_sGoBack		
 		
		' COM object
		Private oFO
 		Private objXML
 		Private fullxml
 		private m_oUser
 		 		
		' For debuging purpose
		Private m_bDebugMode
		Private m_tStart
		 	
		 		
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		' Class constructor :
		'--------------------------------------------------------------------------------------------
		' Create the COM instance (MSXML)
		' Create XML file if needed (can be supress for optimisation)
		' Identify the user
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Private Sub Class_Initialize()
			Dim objNode
			Dim strAuthType
			Dim sessionFullXML
			Dim boolTimeCritical
				
			'Set some global variable			
			m_tStart = Timer()
						
			'no error by default :-p
			m_iUserMessage = ERR_NONE
			m_sGoBack = ""
			
			'Grab the ACTION id
			If request.QueryString("ACT")="" Then 
				m_sAction = ACTION_PAGE
			Else
				m_sAction = request.QueryString("ACT")
			End If
			boolTimeCritical = IsTimeCritical()
			
			'Set the debugmode to false, except if dbg querystring is present
			if lenb(request.QueryString("dbg"))>0 then : m_bDebugMode = True : else : m_bDebugMode = False : end if
						
			
			If Not(boolTimeCritical) Then
				'Check if xml files exists, unless create them  
				Call JSCheckAllFiles()
			End If
			
			
			'We put the xml in the cache, or retrieve from the cache
			if USE_CACHE then				
				if isEmpty(Application("FULLXML")) or lenb(request.QueryString("refresh"))>0 or m_sAction=ACTION_ADMIN then	
					
					if not isEmpty(Application("FULLXML")) then
						set fullxml = Application("FULLXML")
						set fullxml = nothing
					end if
					
					set fullxml = loadXML(DATA_PATH)
					call setAppVariable("FULLXML", fullxml)
				else
					set fullxml = Application("FULLXML")
				end if
			else
				set fullxml = loadXML(DATA_PATH)
			end if						
			
			'Instantiate a msxml dom, for general use :: optimization
			Set objXML = server.CreateObject(MSXML_PROGID) 
			objXML.async = False
			if MSXML4 then 
				call objXML.setProperty("NewParser", True )
				objXML.validateOnParse=false
				objXML.resolveExternals=false
				objXML.preserveWhiteSpace=True 
			end if
			
			'Init the upload file			
			Call InitUpload()			
			
			'We create or load the user session
			If Not(boolTimeCritical) Then
					set m_oUser = new CUser
					m_iUserMessage = m_oUser.Init(oFO, objXML, strAuthType)
			Else
					set m_oUser = new CChatUser
					Set sessionFullXML = New CChatSession			
					sessionFullXML.Init objXML, boolTimeCritical
					m_iUserMessage = m_oUser.Init(oFO, objXML, sessionFullXML, strAuthType)			
			End If
			
			'We create or load the user session

			Set objNode = fullxml.documentElement.selectNodes("/siteinfo/data/auth")
			if objNode.Length>0 then
				strAuthType = objNode.Item(0).text
			else
				strAuthType = "STANDARD"
			end if			
			set objNode = nothing




			
			'Load user skin
			Call LoadSkin("")
		End Sub
		
				
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		' Class Destructor
		' Dynamically kill COM object
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Private Sub Class_Terminate()			
			Set objXML = Nothing
			set m_oUser = nothing
			Debug (Timer()-m_tStart)*1000 & "ms"
		End Sub
						
		
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		' The debug property
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Property Let DebugMode(bValue)	: m_bDebugMode = bValue : End Property
 		Property Get DebugMode			: DebugMode = m_bDebugMode : End Property
		Property Get Group				: Group = m_oUser.GroupName : End Property
		Property Get User				: User = m_oUser.UserName : End Property
		

		Private Function IsTimeCritical()
			If m_sAction = ACTION_CHAT Then
				IsTimeCritical = True
			Else
				IsTimeCritical = False
			End If
		End Function

		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		' This function show the site by an XSL transformation depending on the ACTION
		' It also call the function that update data
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Public Function Show()
			Dim CodeFile : CodeFile		= lcase(oFO.Form("file"))
			Dim Operation : Operation	= lcase(oFO.Form("operation"))
			Dim ID : ID = Request.Querystring("ID")
								
			select case m_sAction
		
				' normal case : show data with no update
				case ACTION_PAGE, ACTION_REACT, ACTION_SIGNUP, ACTION_PHOTO, ACTION_SEARCH, ACTION_ARTICLE, ACTION_GUESTBOOK, ACTION_CHOOSEDISCUSS, ACTION_DISCUSS_MSG, ACTION_DISCUSS_DETAIL, ACTION_SITEMAP, ACTION_DOWNLOAD, ACTION_PASSWORD, ACTION_PASSWORDSEND, ACTION_MESSAGE, ACTION_MEMBERMANAGER, ACTION_MEMBERPROFILE, ACTION_KNOWLEDGE
					'initialize skin
					Call InitSkin(ID)
					if m_oUser.GroupName = "administrator" then Call ManageForm()
					Show = Transform(DATA_PATH, m_sSkin, "SKIN_XSL", true)
					if COUNTER then Call CountPage()
					Call LogUser()
				
				'same but for non anonymous user (selfcare, lost password)
				case ACTION_ACCOUNT
					if m_oUser.GroupName="anonymous" then m_sAction = ACTION_PAGE
					Show = Transform(DATA_PATH, m_sSkin, "SKIN_XSL", true)
					Call LogUser()
				
				
				' Show with Form processing to update data								
				case ACTION_POSTREACT
					if Operation="add" and (CodeFile="reactions" or CodeFile="guestbook" )  then
						Call ManageForm()						
					end if
					Show = Transform(DATA_PATH, m_sSkin, "SKIN_XSL", true)					
					Call LogUser()
				
				case ACTION_ADDMEMBER
					if Operation="add" and CodeFile="member" then
						Call ManageForm()	
					end if				
					Show = Transform(DATA_PATH, m_sSkin, "SKIN_XSL", true)					
					Call LogUser()

				case ACTION_CHAT, ACTION_CHATMAN
					if lenb(m_oUser.Username) > 0 Then
						Call ManageForm()
					end if
					Show = Transform(DATA_PATH, m_sSkin, "SKIN_XSL", true)

				case ACTION_CALENDAR
					if Operation="add" and CodeFile="calendar" then
						Call ManageForm()		
					End if						
					Show = Transform(DATA_PATH, m_sSkin, "SKIN_XSL", true)					
					Call LogUser()

				case ACTION_FRIENDS
					if lenb(m_oUser.Username)>0 and (Operation="add" or Operation="delete") and CodeFile="friends" then
						Call ManageForm()	
					end if		
					Show = Transform(DATA_PATH, m_sSkin, "SKIN_XSL", true)					
					call LogUser()

				case ACTION_CLASSIFIED
				  Call CountClassifiedAdds()
					if CodeFile="classified" and (Operation="add" or Operation="update" or Operation="delete") then
						Call ManageForm()		
					End if						
					Show = Transform(DATA_PATH, m_sSkin, "SKIN_XSL", true)
					Call LogUser()

				case ACTION_INTERNALMESSAGE
					if lenb(m_oUser.Username)>0 and (Operation="add" or Operation="update" or Operation="delete") and CodeFile="internalmessage" then
						Call ManageForm()	
					end if		
					Show = Transform(DATA_PATH, m_sSkin, "SKIN_XSL", true)
					call LogUser()
				
				case ACTION_DISCUSS
					if lenb(m_oUser.Username)>0 and Operation="add" and CodeFile="discussion" then
						Call ManageForm()	
					end if		
					Show = Transform(DATA_PATH, m_sSkin, "SKIN_XSL", true)					
					call LogUser()
					
					
				case ACTION_ACCOUNTSEND
					if lenb(m_oUser.Username)>0 and Operation="update" and CodeFile="member" then
						Call ManageForm()
					end if
					Show = Transform(DATA_PATH, m_sSkin, "SKIN_XSL", true)					
					Call LogUser()		
					
				case ACTION_DIRECTORY
					if Operation="add" and CodeFile="directory" then
						Call ManageForm()		
					End if						
					Show = Transform(DATA_PATH, m_sSkin, "SKIN_XSL", true)					
					Call LogUser()					
					
				' vote case
				case ACTION_VOTE
					Call Vote()
					Show = Transform(DATA_PATH, m_sSkin, "SKIN_XSL", true)					
					Call LogUser()
					
				' console adminstration case			
				case ACTION_ADMIN
					if m_oUser.GroupName="administrator" or (m_oUser.GroupName="editor" and (Operation<>"delete" and (CodeFile="content" or CodeFile="discussion" or CodeFile="knowbase")) or Operation="upload" ) then
						Call ManageForm()	
						'Now recaching xml in the cache
						set fullxml = loadXML(DATA_PATH)
						call setAppVariable("FULLXML", fullxml)
						Show = Transform(DATA_PATH, ADMIN_SKIN_PATH, "ADMIN_XSL", false)
																	
					elseif m_oUser.GroupName="administrator" or m_oUser.GroupName="editor" then
						Show = Transform(DATA_PATH, ADMIN_SKIN_PATH, "ADMIN_XSL", false)
					else
						Response.Redirect "default.asp"
					end if	
					Call LogUser()
				
				case ACTION_LOGOFF
					m_oUser.LogOff()
					Show = Transform(DATA_PATH, m_sSkin, "SKIN_XSL", true)	
					Call LogUser()
			end select
		End Function
			
		
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		' Export the memeber list to a csv file
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Public sub ExportMember()
			Dim oNodeList, Item			
			objXML.load(MEMBER_PATH)
				
			Response.Write """Name""; ""email""; ""City/Country""; ""newsletter""; date" & vbCrLf		
			set oNodeList = objXML.selectNodes("members/member")
			for each item in oNodeList
				Response.Write chr(34) & item.selectsinglenode("pseudo").text & chr(34) & "; "
				Response.Write chr(34) & item.selectsinglenode("email").text & chr(34) & "; "
				Response.Write  chr(34) & item.selectsinglenode("ville").text & chr(34) & "; "
				if item.selectnodes("newsletter").length>0 then	
					Response.Write  chr(34) & item.selectsinglenode("newsletter").text & chr(34) 
				end if
				Response.Write "; "
				Response.Write item.selectsinglenode("date").text & vbcrlf
			next			
		End sub
		
		
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		' Return the path name corresponding to XML source Alias
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Private Function GetTargetFile(sCode)
			select case sCode
				case "content"		: GetTargetFile = DATA_PATH	
				case "download"		: GetTargetFile = DOWNLOAD_PATH			
				case "banner"		: GetTargetFile = BANNER_PATH					
				case "category"		: GetTargetFile = CATEGORY_PATH
				case "poll"		: GetTargetFile = POLL_PATH				
				case "media"		: GetTargetFile = MEDIA_PATH	
				case "member"		: GetTargetFile = MEMBER_PATH
				case "reactions"	: GetTargetFile = REACTION_PATH
				case "guestbook"	: GetTargetFile = GUESTBOOK_PATH
				case "discussion"	: GetTargetFile = DISCUSSION_PATH
				case "task"		: GetTargetFile = TASK_PATH
				case "directory"	: GetTargetFile = DIRECTORY_PATH
				case "skin"		: GetTargetFile = SKIN_PATH
				case "knowbase"		: GetTargetFile = KB_PATH
				case "list"		: GetTargetFile = LIST_PATH
				case "newsletter"	: GetTargetFile = NEWSLETTER_PATH
				case "chat"		: GetTargetFile = CHAT_PATH
				case "calendar"		: GetTargetFile = CALENDAR_PATH
				case "internalmessage"	: GetTargetFile = INTERNALMESSAGE_PATH
				case "friends"		: GetTargetFile = FRIENDS_PATH
				case "classified"	: GetTargetFile = CLASSIFIED_PATH
				case else		: GetTargetFile = DATA_PATH
			end select			
		End Function
		
						
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		' This function handle a form posting by determing tha operation to be done
		'	The form must respond to some criteria, wich are compulsory hidden fiel:
		'		- "file" : an xml file alias
		'		- "operation" : "update" | "add" | "delete"
		'		- "bloc" : the Xpath corresponding to the node where a child has to be append
		'		- "node" : the Xpath corresponding to the node to be modify or just the name of the child to be added
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Private Sub ManageForm()
			Dim Item
			Dim Operation
			Dim CodeFile
			Dim QSTXForm
			Dim oXForm
			Dim intChannel

			QSTXForm	= lcase(oFO.Form("xform"))	'Version of XForm
			CodeFile	= lcase(oFO.Form("file"))
			Operation	= lcase(oFO.Form("operation"))
			intChannel	= Request.QueryString("channel")

			if lenb(operation)=0 then exit sub
			
			'if instr(1, Request.ServerVariables("HTTP_REFERER"), Request.ServerVariables("SERVER_NAME"))=0 then
				'Response.Write Request.ServerVariables("HTTP_REFERER") & "<br>"
				'Response.Write Request.ServerVariables("SERVER_NAME") & "<br>"
				'Response.Write "<h3>Are you trying to hack this site ?</h3><br/>"
				'Response.Write "WHy do not help the open source community instead of deserving it ?"
				'Response.End
				'exit sub
			'end if

			'New Class to treat the xml form
			if lenb(QSTXForm)>0 then
				
				Select Case Operation
					case "add":
						set oXForm = new CXForm
							oXForm.File = GetTargetFile(CodeFile)
							oXForm.Node = XForm(true)
							oXForm.XPath = URLDecode(oFO.Form("xpath"))
							Call oXForm.Add()
						set oXForm = nothing
					case "update":
						set oXForm = new CXForm
							oXForm.File = GetTargetFile(CodeFile)
							oXForm.Node = XForm(false)
							oXForm.XPath = URLDecode(oFO.Form("xpath"))
							oXForm.Update()
						set oXForm = nothing
					case "delete":
						set oXForm = new CXForm
							oXForm.File = GetTargetFile(CodeFile)
							oXForm.XPath = URLDecode(oFO.Form("xpath"))
							Call oXForm.Delete()
						set oXForm = nothing					
				end select
				
			Else																						
				'---- do the right operation on the right file					
				Select Case Operation
					case "update"
						Call UpDate(GetTargetFile(CodeFile))
					
					case "add"
						Call Add(GetTargetFile(CodeFile))	
						
					case "delete"
						Call Delete(GetTargetFile(CodeFile))

					case "dropnodes"
						Call DropNodes(GetTargetFile(CodeFile))

					case "export"
						Call ExportData(CodeFile)

					case "import"
						Call ImportData(GetTargetFile(CodeFile))
					
					case "upload"
						Call Upload()
						
					case "swap"
						Call Swap(GetTargetFile(CodeFile))

					'for chat only
					case "chat-join"
						Call Add(GetTargetFile(CodeFile))
						call chat_connect(intChannel, Operation)
					case "chat-leave"
						Call DropNodes(GetTargetFile(CodeFile))
						call chat_connect(intChannel, Operation)
					case "chat-addmsg"
						Call Add(GetTargetFile(CodeFile))
						call chat_UpdateChannel(intChannel, "messageaction")
						call chat_UpdateUser(intChannel, "")
					case "chat-cleanup"
						call chat_Cleanup(intChannel)
						call chat_UpdateUser(intChannel, "")
					case "chat-session"
						call chat_Session(intChannel)
				End Select		
			End if
		End Sub
			
		
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		' XML Update function
		' file = the path to the xml file
 		' node = xpath  node
 		' xxxx = all the children of the new node
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Private sub UpDate(sFile)
			Dim oNode, oNodeList, NewNode, newCData
			Dim oRoot
			Dim strError
			Dim Node		: Node = URLDecode(oFO.Form("node"))
			Dim Item
			Dim sXSLPattern
			Dim sItemValue
			Dim CodeFile		: CodeFile = lcase(oFO.Form("file"))
														
			'load the XML file to be update		
			objXML.load(sFile)
						
			
			if (objXML.parseError.errorCode <> 0)  then
			    strError = strError & "XML parseError on line " & objXML.parseError.line & "<br>"
			    Exit sub
			End If
			
			
			' for each form element we select the node to modify and change the value
			For each Item in oFO.Inputs				
				If Item<>"x" and Item<>"y" and Item<>"node" and Item<>"section" and Item<>"operation" and Item<>"file" and Item<>"pwd" and Item<>"lgn" Then

					sItemValue = URLDecode(oFO.Form(Item))

					if CodeFile = "member" and Item = "type" then
						if m_oUser.GroupName <> "administrator" then
							sItemValue = m_oUser.GroupName
						end if
					end if
					
					'does node exists
					sXSLPattern = "/" & Node & "/" & Item	
					set oNodeList = objXML.documentElement.SelectNodes(sXSLPattern)
										
					if cint(oNodeList.length)>0 then
						oNodeList.item(0).FirstChild.text = sItemValue
					else
						
						'if it's not exist, create it !!!
						set oNodeList = objXML.documentElement.SelectNodes("/" & Node)
						
						if cint(oNodeList.length)>0 then
							Set newNode = objXML.createNode(1, Item, "")
							Set newCData = objXML.createNode(4, "", "")
							newCData.text = sItemValue
							
							NewNode.appendChild newCData							
							oNodeList.item(0).appendChild NewNode
						else
							Response.Write "path : " & sXSLPattern & "<br/>"
							Response.Write "Error on node " & Item & "<br/>"
						end if
						
					end if																	
										
				End If
			next	
			
			' saving the file
			Call SaveXMLFile(sFile, objXML.xml)
			
			set oNode = nothing
			
		end sub	


		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		' XML INSERT Function
 		' file = the path to the xml file
 		' bloc = the parent node of new data
 		' node = the new node
 		' xxxx = all the children of the new node
 		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Private Sub Add(sFile)
			Dim objXMLv
			Dim oNode
			Dim oNewNode
			Dim oTestNode
			Dim oRoot
			Dim Section
			Dim Node		: Node = URLDecode(oFO.Form("node"))
			Dim Bloc		: Bloc = URLDecode(oFO.Form("bloc"))
			Dim Item
			Dim oCdata
			Dim iCount	: iCount	= 0
			Dim iID		: iID		= 1
			Dim bLoop	: bLoop	= true
			Dim oNodeList
			Dim sItemName, sItemValue
			Dim bCmdEmail : bCmdEmail = False
			Dim CodeFile		: CodeFile = lcase(oFO.Form("file"))

			'load xml file	
			objXML.load(sFile)
			
			if (objXML.parseError.errorCode <> 0)  then
			    Response.Write sFile & " :: XML parseError on line " & objXML.parseError.line & "<br>"
				Exit sub
			End If
						
			iID	= objXML.SelectNodes("//" & node).Length + 1
							
			'Search for a free id
			do while bLoop
				Set oTestNode = objXML.SelectNodes("//" & node & "[id=" & iID & "]")
				If oTestNode.length>0 Then
					iId = iId + 1	'node already exist, check the next one
				Else
					bLoop = False	'node available
				End If
			loop
									
			' We create a new node in the xml, wich will handle the new datas
			Dim oListNode
			Set oListNode = objXML.selectNodes(Bloc)
			If oListNode.length=0 Then
				Response.Write("Error : The node " & Bloc & " has not been found in the file " & sFile) & ", you can add it manually to correct this error."
				Exit sub
			End if
			Set oNewNode = objXML.SelectSingleNode(Bloc)
			set oNewNode = oNewNode.appendChild(objXML.createElement(Node))
												
			'add the ID node			
			oNewNode.appendChild(objXML.createElement("id"))
			Set oCdata = objXml.createCDATASection("")
			oCdata.text = iId
			oNewNode.childNodes(iCount).appendChild(oCdata)
			iCount = iCount + 1
			
			'for each form element :
			'create a new node with name and insert a cdata section with the value						
			For each Item in oFO.Inputs				
				
				'the name and the value for satandard field
				sItemName  = Item
				sItemValue = URLDecode(oFO.Form(Item))

				if CodeFile = "member" and Item = "type" then
					if m_oUser.GroupName <> "administrator" then
						sItemValue = "member"
					end if
				end if

				
				'Here we deal with special fields : compulsory(comp_), uniques, text and cookie 
				if mid(sItemName,1,5)="comp_" then
					'mandatory fields are missing
					if lenb(sItemValue)=0 then
						m_iUserMessage = ERR_FILL_FORM	
						m_sGoBack = "1"
						exit sub
					end if
					
					sItemName  = mid(sItemName,6) 
					
				elseif mid(sItemName,1,7)="unique_" then
					'mandatory fields are missing
					if lenb(sItemValue)=0 then
						m_iUserMessage = ERR_FILL_FORM	
						m_sGoBack = "1"
						exit sub
					'unique field is not free
					else
						sItemName  = mid(sItemName,8) 
						set oNodeList = objXML.documentElement.SelectNodes("/" & Bloc & "/" & node & "[" & sItemName & "='" & sItemValue & "']")
						IF oNodeList.length>0 then
							m_iUserMessage = ERR_USERNAME							
							m_sGoBack = "1"
							exit sub
						end if
					end if
				
				elseif mid(sItemName,1,5)="text_" then					
					sItemName = mid(sItemName,6)
					sItemValue = replace(sItemValue, vbcrlf, "<br>")
				end if
								
				
				If Item<>"x" and Item<>"y" and Item<>"lgn" and Item<>"pwd" and Item<>"date" and Item<>"file" and Item<>"bloc" and Item<>"node" and Item<>"section" and Item<>"operation" and Item<>"id" Then
					oNewNode.appendChild(objXML.createElement(sItemName))
					Set oCdata = objXml.createCDATASection(sItemValue)
					oNewNode.childNodes(iCount).appendChild(oCdata)
					iCount = iCount + 1
				End If
			next	
						
			
			'We add a creation date value automatically 
			oNewNode.appendChild(objXML.createElement("date"))
			Set oCdata = objXml.createCDATASection(cstr(Year(Now) & Right("0" & Month(Now), 2) & Right("0" & Day(Now), 2) & Right("0" & Hour(Now), 2) & Right("0" & Minute(Now), 2)))
			oNewNode.childNodes(iCount).appendChild(oCdata)
			
			'We add a Owner value automatically 
			oNewNode.appendChild(objXML.createElement("owner"))
			Set oCdata = objXml.createCDATASection(m_oUser.UserName)
			oNewNode.childNodes(iCount+1).appendChild(oCdata)
								
			'Save the file
			call SaveXMLFile(sFile, objXML.xml)
			
			set oTestNode	= nothing
			set oCdata		= nothing
			set oNode		= nothing			
		End Sub	


		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		' XML Delete function
		' file = the path to the xml file
 		' node = xpath to the node
 		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Private Sub Delete(sFile)
			Dim oNode
			Dim oNodeParent
			Dim oNodeList
			Dim sNode	: sNode = URLDecode(oFO.Form("node"))
	
			' load the xml file
			Call objXML.load(sFile)
						
			Set oNodelist = objXML.SelectNodes(sNode)
			
			'if not doesn't exist
			if oNodelist.length=0 then 
				set oNodelist = nothing
				exit sub
			end if
			
			set oNodelist = nothing
			
			'Delete this node
			set oNode = objXML.SelectSingleNode(sNode)
				set oNodeParent = oNode.parentNode
					oNodeParent.removeChild(oNode)
				set oNodeParent = nothing		
			set oNode = nothing
			
			'save datas
			call SaveXMLFile(sFile, objXML.xml)
								
		End Sub
		

		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		' XML extended delete function
		' file = the path to the xml file
 		' node = xpath to the node
 		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Private Sub DropNodes(sFile)
			Dim oNode
			Dim sNode	: sNode = URLDecode(oFO.Form("node"))
			Dim bLoop
	
			' load the xml file
			Call objXML.load(sFile)

			Set oNode = objXML.SelectNodes(sNode)
			If oNode.length > 0 Then
				'Delete this node
				oNode.removeAll
			End If
			set oNode = nothing

			'save datas
			call SaveXMLFile(sFile, objXML.xml)								
		End Sub

		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		' Swap 2 values of 2 nodes in the same xml file
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Private sub Swap(sFile)
			Dim sNodeA : sNodeA = URLDecode(oFO.Form("node_a"))
			Dim sNodeB : sNodeB = URLDecode(oFO.Form("node_b"))
			Dim sValueA
			Dim sValueB
			Dim oNodeListA
			Dim oNodeListB
			
			' load the xml file
			Call objXML.load(sFile)
			
			'Load the Node A value ---
			Set oNodeListA = objXML.SelectNodes(sNodeA)			
			if oNodeListA.length=0 then 
				Response.Write "swap error" : set oNodeListA = nothing : exit sub
			else
				sValueA = oNodeListA.item(0).text
			end if
			
			'Load the Node B value ---
			Set oNodeListB = objXML.SelectNodes(sNodeB)			
			if oNodeListB.length=0 then 
				Response.Write "swap error" : set oNodeListB = nothing : exit sub
			else
				sValueB = oNodeListB.item(0).text
			end if
			
			'---swap the value
			oNodeListA.item(0).text = sValueB
			oNodeListB.item(0).text = sValueA
			
			'Response.Write sValueA & " " & sValueB
			'Response.End
			'save datas
			call SaveXMLFile(sFile, objXML.xml)
			
		End sub

		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		' XML export function
 		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Private Sub ExportData(CodeFile)
			Dim lstNode
			Dim nodRoot
			Dim nodParent
			Dim nodItem
			Dim nodList
			Dim cdtEntry
			Dim strFile		: strFile = GetTargetFile(CodeFile)
			Dim strNode		: strNode = URLDecode(oFO.Form("selection"))
			Dim strExportfile	: strExportfile  = URLDecode(oFO.Form("exportfile"))
			Dim xmlExport
			Dim sItemName
			Dim sItemValue
			Dim Item
	
			' load the xml file
			Call objXML.load(strFile)

			Set nodList = objXML.SelectNodes(strNode)
			
			'if not doesn't exist
			if nodList.length = 0 then
				set nodList = nothing
				exit sub
			end if

			Set xmlExport = Server.CreateObject(MSXML_PROGID) 
			xmlExport.async = False
			Set nodRoot = xmlExport.CreateElement("interface")
			xmlExport.AppendChild nodRoot
			Set nodParent = nodRoot.AppendChild(xmlExport.createElement("info"))

			For each Item in oFO.Inputs
				sItemName  = Item
				sItemValue = URLDecode(oFO.Form(Item))

				Set nodItem 	= nodParent.AppendChild(xmlExport.CreateElement(sItemName))
				Set cdtEntry	= xmlExport.CreateCDATASection(sItemValue)
				nodItem.AppendChild(cdtEntry)
			Next

			Set nodParent 	= nodRoot.AppendChild(xmlExport.createElement("exportdata"))
			For Each nodItem in nodList
				Set nodItem = nodParent.AppendChild(nodItem)
			Next

			if len(strExportfile) > 0 then
				xmlExport.save strExportfile
			end if

			Set lstNode	= Nothing
			Set nodRoot	= Nothing
			Set nodParent	= Nothing
			Set nodItem	= Nothing
			Set nodList	= Nothing
			Set cdtEntry	= Nothing
		End Sub

		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		' XML import function
 		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Private Sub ImportData(CodeFile)
			Dim lstNode
			Dim nodRoot
			Dim nodParent
			Dim nodItem
			Dim nodList
			Dim cdtEntry
			Dim strFile		: strFile = GetTargetFile(CodeFile)
			Dim strNode		: strNode = URLDecode(oFO.Form("node"))
			Dim strExportfile	: strExportfile  = URLDecode(oFO.Form("exportfile"))
			Dim xmlExport
			Dim sItemName
			Dim sItemValue
			Dim Item
	
			' load the xml file
			Call objXML.load(strFile)

			Set nodList = objXML.SelectNodes(strNode)
			
			'if not doesn't exist
			if nodList.length = 0 then
				set nodList = nothing
				exit sub
			end if

			Set xmlExport = Server.CreateObject(MSXML_PROGID) 
			xmlExport.async = False
			Set nodRoot = xmlExport.CreateElement("interface")
			xmlExport.AppendChild nodRoot
			Set nodParent = nodRoot.AppendChild(xmlExport.createElement("info"))

			For each Item in oFO.Inputs
				sItemName  = Item
				sItemValue = URLDecode(oFO.Form(Item))

				Set nodItem 	= nodParent.AppendChild(xmlExport.CreateElement(sItemName))
				Set cdtEntry	= xmlExport.CreateCDATASection(sItemValue)
				nodItem.AppendChild(cdtEntry)
			Next

			Set nodParent 	= nodRoot.AppendChild(xmlExport.createElement("exportdata"))
			For Each nodItem in nodList
				Set nodItem = nodParent.AppendChild(nodItem)
			Next

			if len(strExportfile) > 0 then
				xmlExport.save strExportfile
			end if

			Set lstNode	= Nothing
			Set nodRoot	= Nothing
			Set nodParent	= Nothing
			Set nodItem	= Nothing
			Set nodList	= Nothing
			Set cdtEntry	= Nothing
		End Sub

		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		' Take care of a user vote
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Private Function Vote()
			Dim Choice	: Choice = URLDecode(oFO.Form("choice"))
			Dim arrVote
			Dim oNode
			Dim oRoot
			Dim strError			
			Dim Node	: Node = URLDecode(oFO.Form("node"))
									
			if lenb(Choice)=0 or lenb(Node)=0 then exit function
			arrVote = split(Choice, ";")
						
			'Check if user as already voted
			'DR 5-3-02 - Changed cookie name constant
			' and the index to allow for multiple vote tracking in 
			' the same cookie. 
			' Also added a expirateion date ( 1 quarter from today)
			' to prevent users from closing browser and voting again.
			' Changed the cookie value to Y to shorten cookie size, and 
			' makes cookie "node"="Y" instead of "node"="node" 

			If Request.Cookies(VOTE_COOKIE_NAME)(Node) = "Y" Then
				m_iUserMessage = ERR_VOTE_SPAM		
				exit function
			Else
				Response.Cookies(VOTE_COOKIE_NAME)(Node) = "Y"
				Response.Cookies(VOTE_COOKIE_NAME).expires = DateAdd("q",1,Now)
			End If
						
			'on charge le XML de data		
			Call objXML.load(POLL_PATH)
			
			'on pointe vers la reponse
			set oNode = objXML.SelectSingleNode(Node & "/" & arrVote(0))
											
			'on pointe alors sur le child de ce noeud (pour acceder au CDATA)
			set oNode = oNode.FirstChild						
						
			'On met a jour le content du node
			oNode.text = arrVote(1)			
			
			'on sauve les modifs
			call SaveXMLFile(POLL_PATH, objXML.xml)
			
			set oNode = nothing
		End Function

		
		''' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		''' this function increment the count param of the current webpage
		''' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Private Sub CountPage()
			Dim sID		: sID = Request.QueryString("id")
			Dim oNodeList
			
			if lenb(sID)=0 then exit sub
			
			'Point to the webpage node
			set oNodeList = fullxml.SelectNodes("siteinfo/pages/page[id='" & sID & "']/count")
			
			'check if the count node of the page exists, we could add some code to add it if it fails...	
			if oNodeList.length=0 then 				
				exit sub
			else
				'select the page node and his child "count" to increment it
				Dim oNode : set oNode = fullxml.SelectSingleNode("siteinfo/pages/page[id='" & sID & "']/count")
				Set oNode = oNode.FirstChild						
				If lenb(oNode.text)=0 then
					oNode.text = "1"
				Else
					oNode.text = cstr(cLng(oNode.text) + 1)	
				End if
								
				'Save the update
				call SaveXMLFile(DATA_PATH, fullxml.xml)
			end if
		End Sub
		
		''' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		''' this function increment the count param of the current Classified Add
		''' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Private Sub CountClassifiedAdds()
		Dim sID		: sID = Request.QueryString("add")
		Dim oNode
		Dim oNodeList
			
				 if lenb(sID)=0 or Request.QueryString("cmd")="edit" or Request.QueryString("cmd")="react" then
				 exit sub
				 
				 Else
				 		 Call objXML.load(CLASSIFIED_PATH)			

				 		 'Point to the webpage node
				 		 Set oNodeList = objXML.SelectNodes("classified/adds/add[id='" & sID & "']/count")
			
				 		 'check if the count node of the page exists, we could add some code to add it if it fails...	
				 		 If oNodeList.length=0 Then 
			 	 		 		exit sub
			
				 		 Else			
				 		 'select the add node and his child "count" to increment it
				 		 set oNode = objXML.SelectSingleNode("/classified/adds/add[id='" & sID & "']/count")
				 		 set oNode = oNode.FirstChild
				 		 oNode.text = cstr(cLng(oNode.text) + 1)						
				 		 End if
						 
				 		 'Save the update
				 		 call SaveXMLFile(CLASSIFIED_PATH, objXML.xml)
				End if 		 
		End Sub

		
		''' ----------------------------------------------
		''' Create a redirection to an url
		''' depending on querystring passed as parameters
		''' ----------------------------------------------
		Public Function Redirect(sType, sID)
			Dim URL, oNode, oNodeList			
			
			If LenB(sType)=0 or LenB(sID)=0 Then
				Response.Write "This ressource doesn't exists."
			Else
				'check the type of redirection (banner or download)
				select case sType
					case "ad" :
						'load XML BANNER		
						Call objXML.load(BANNER_PATH)
						
						'get the good banner node
						set oNodeList = objXML.SelectNodes("/banners/banner[id='" & sID & "']")
				
						if oNodeList.length=0 then 
							Response.Write "This ressource doesn't exists."
							exit function
						else
							'update the count
							set oNode = objXML.SelectSingleNode("/banners/banner[id='" & sID & "']/count")
							set oNode = oNode.FirstChild
							oNode.text = cstr(cint(oNode.text) + 1)	
							
							'then we get the URL value to do the redirection
							set oNode = objXML.SelectSingleNode("/banners/banner[id=" & sID & "]/onclickurl")
							set oNode = oNode.FirstChild						
								URL = oNode.text
							set oNode = nothing	
							
							'save the file
							call SaveXMLFile(BANNER_PATH, objXML.xml)
							Response.Redirect URL
						end if
						
					case "dw" :
						'load the DOWNLOAD XML		
						Call objXML.load(DOWNLOAD_PATH)
						
						'point to the good download
						set oNodeList = objXML.SelectNodes("/downloads/download[id='" & sID & "']")
				
						if oNodeList.length=0 then 
							Response.Write "This ressource doesn't exists."
							exit function
						else
							'imcrement counter
							set oNode = objXML.SelectSingleNode("/downloads/download[id='" & sID & "']/count")
							set oNode = oNode.FirstChild						
							oNode.text = cstr(cint(oNode.text) + 1)	
							
							'get the URL for redirection
							set oNode = objXML.SelectSingleNode("/downloads/download[id=" & sID & "]/path")
							set oNode = oNode.FirstChild						
								URL = oNode.text			
							set oNode = nothing	
							
							'save the file
							call SaveXMLFile(DOWNLOAD_PATH, objXML.xml)
							Response.Redirect URL
						end if
					
					
					case "dir" :
						'increment the nb of click, and redirect to the website
						'load the DIRECTORY XML		
						Call objXML.load(DIRECTORY_PATH)
						
						'point to the good download
						set oNodeList = objXML.SelectNodes("//item[@id='" & sID & "']")
				
						if oNodeList.length=0 then 
							Response.Write "This ressource doesn't exists."
							exit function
						else
							'imcrement counter
							set oNode = objXML.SelectSingleNode("//item[@id='" & sID & "']/@count")
							oNode.value = cstr(cint(oNode.text) + 1)	
							
							'get the URL for redirection
							set oNode = objXML.SelectSingleNode("//item[@id='" & sID & "']/@website")
							URL = oNode.value			
							set oNode = nothing	
							
							'save the file
							call SaveXMLFile(DIRECTORY_PATH, objXML.xml)
							Response.Redirect URL
						end if

						
				end select		
			End If
			
		End Function
		
		
		'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		' Do the transform with a cache handler for xml and xsl (singleThread)
		'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Public Function Transform(XMLPath, XSLPath, XSLCacheName, bCache)
			Dim proc
			Dim xsl
			Dim xslTemplate
			Dim Item
			Dim oXMLMember
											
			'We put the xsl in cache if necessary, otherwise we just grab a pointer
			if bCache AND USE_CACHE then
				if isEmpty(Application(XSLCacheName)) or lenb(oFO.Form("Refresh"))>0 then	
					if not isEmpty(Application(XSLCacheName)) then
						debug "Empty the xsl cache " & XSLCacheName
						set xslTemplate = Application(XSLCacheName)
						set xslTemplate = nothing
					end if
					set xslTemplate =  cacheXSLTemplate(XSLPath, XSLCacheName)
				else
					set xslTemplate = Application(XSLCacheName)
				end if
			else
				set xsl = loadXML(XSLPath)
				set xslTemplate = server.CreateObject(MSXML_PROGID3)
				set xslTemplate.stylesheet = xsl				
			end if			
									
			'We create a processor
			set proc = xslTemplate.createProcessor()				
			proc.input = fullxml
					
			'We add some querystring as parameters (id, mnu, ACT, msg,...)
			for each item in oFO.Inputs
				If Item<>"id" and Item<>"mnu" and Item<>"ACT" Then proc.addParameter Item, cstr(URLDecode(oFO.Form(Item)))
			Next
		
			For Each Item In Request.QueryString
				If Item<>"id" and Item<>"mnu" and Item<>"ACT" and (not IsNumeric(mid(Item,1,1))) Then proc.addParameter Item, cstr(URLDecode(Request.QueryString(Item)))
			Next
				
			'Add some particuliar querystring even if they are missing	
			If Lenb(Request.QueryString("id"))=0 and lenb(Request.QueryString("ACT"))= 0 Then
				proc.addParameter "id", cstr("1")
				proc.addParameter "mnu", cstr("1")
				proc.addParameter "gateway", cstr("1")
			Else
				proc.addParameter "id", cstr(Request.QueryString("id"))
				proc.addParameter "mnu", cstr(Request.QueryString("mnu"))
			End If
			
			'Action		
			proc.addParameter "ACT", cstr(m_sAction)		
											
			'Parameters for xml files
			proc.addParameter "datafile", cstr(DATA_PATH)
			proc.addParameter "taskfile", cstr(TASK_PATH)			
			proc.addParameter "memberfile", cstr(MEMBER_PATH)
			proc.addParameter "reactfile", cstr(REACTION_PATH)
			proc.addParameter "guestbookfile", cstr(GUESTBOOK_PATH)
			proc.addParameter "discussionfile", cstr(DISCUSSION_PATH)
			proc.addParameter "pollfile", cstr(POLL_PATH)
			proc.addParameter "mediafile", cstr(MEDIA_PATH)
			proc.addParameter "downloadfile", cstr(DOWNLOAD_PATH)
			proc.addParameter "languagespath", cstr(LANGS_PATH)
			proc.addParameter "bannerfile", cstr(BANNER_PATH)
			proc.addParameter "categoryfile", cstr(CATEGORY_PATH)	
			proc.addParameter "directoryfile", cstr(DIRECTORY_PATH)		
			proc.addParameter "skinstudiofile", cstr(SKIN_PATH)
			proc.addParameter "sessionfile", cstr(SESSIONS_PATH)
			proc.addParameter "skinsfolder", cstr(SKINS_FOLDER)
			proc.addParameter "kbfile", cstr(KB_PATH)
			proc.addParameter "listfile", cstr(LIST_PATH)
			proc.addParameter "newsletterfile", cstr(NEWSLETTER_PATH)
			proc.addParameter "chatfile", cstr(CHAT_PATH)
			proc.addParameter "calendarfile", cstr(CALENDAR_PATH)
			proc.addParameter "friendsfile", cstr(FRIENDS_PATH)
			proc.addParameter "internalmessagefile", cstr(INTERNALMESSAGE_PATH)
			proc.addParameter "classifiedfile", cstr(CLASSIFIED_PATH)
					
			'Some others variables			
			proc.addParameter "msxml4", cstr(MSXML4)
			proc.addParameter "visitors", cstr(NZ(m_oUser.Count, 1))
			proc.addParameter "version", cstr(VERSION_NUMBER)
			proc.addParameter "usertype", cstr(m_oUser.GroupName)
			proc.addParameter "username", cstr(m_oUser.UserName)
			proc.addParameter "actualdate", cstr(Year(Now) & Right("0" & Month(Now), 2) & Right("0" & Day(Now), 2) & Right("0" & Hour(Now), 2) & Right("0" & Minute(Now), 2))
			proc.addParameter "actdecdate", CStr(Year(Now) & Right("0" & Month(Now), 2) & Right("0" & Day(Now), 2) & Right("0" & Hour(Now), 2) & Right("0" & CLng(Minute(Now)/0.6), 2))
			proc.addParameter "now", cstr(Year(Now) & "-" & Right("0" & Month(Now), 2) & "-" & Right("0" & Day(Now), 2))
			proc.addParameter "mappath", cstr(ROOT_PATH)
			proc.addParameter "usermessage", cstr(m_iUserMessage)
			proc.addParameter "goback", cstr(m_sGoBack)			
			proc.addParameter "guid", cstr(GetGuid(20))
			proc.addParameter "sessionexpire", cstr(SESSION_EXPIRE)				
			
			if request.QueryString("preview")<>"1" then
				'Add the personnalized skin
				Dim oXMLSkins : set oXMLSkins = server.CreateObject(MSXML_PROGID) : oXMLSkins.async = false : oXMLSkins.load(SKIN_PATH)
				Dim oNodeList, ItemC
				set oNodeList = oXMLSkins.documentelement.selectnodes("skin_settings[skin='" & m_sSkinName & "']")
				
				if oNodeList.length > 0 then
					debug "Skin custumization loaded"
					For each ItemC in oNodeList.Item(0).childNodes
						if ItemC.nodeName<>"id" then				
							proc.addParameter ItemC.nodeName, cstr(ItemC.Text) : 'Response.Write ItemC.nodeName & " " & cstr(ItemC.Text) & "<br>"
						end if
					next 
				end if
				set oXMLSkins = nothing
				'end of custom settings add
			end if
				
			'add the browser name
			Dim oBrw : set oBrw = new CBrowser
				proc.addParameter "browsername", cstr(oBrw.Browser)	'cstr("mozilla")
			set oBrw = nothing	
					
				
			'add some admin only parameters
			if XSLCacheName="ADMIN_XSL" then
				
				'We add the log list
				Dim oXML1 : set oXML1 = server.CreateObject(MSXML_PROGID) : oXML1.async = false
				oXML1.loadXML(LogList)
				proc.addParameter "logdata", oXML1
				
				'We add the skins list if needed
				'if Request.QueryString("SECT")="M1" then
					Dim oXML2 : set oXML2 = server.CreateObject(MSXML_PROGID) : oXML2.async = false
					oXML2.loadXML(SkinList)
					proc.addParameter "skinsnode", oXML2
				'end if
				
				'we add the upload file list if needed
				if Request.QueryString("SECT")="M11" then
					Dim oXML3
					set oXML3 = UploadFileList
					proc.addParameter "uploadfilenode", oXML3
				end if
			end if
												
			'Do the transform
			on error resume next
			proc.transform
			Transform = proc.output
			
			if Err<>0 then
				Response.Write Err.number & ": " & Err.Description
			end if
			
			on error goto 0
			
			' in order to solve the nbsp pb on msxml3
			if not MSXML4 then
				Transform = Replace(Transform, "&amp;nbsp;" ,"&nbsp;") 
			end if
						
			set proc = nothing
			set oXML1 = nothing
			set oXML2 = nothing
			set oXML3 = nothing
			set oXMLMember = nothing						
		End Function
		
		
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		' This function log the user
		' Create a new file for each day
		'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		Private Sub LogUser()
			Dim oNodeList
			Dim oXMLv
			Dim oPointerNode
												
			'-----Calculate date
			Dim myDate		: myDate	= Year(Now) & Right("0" & Month(Now), 2) & Right("0" & Day(Now), 2)
			'-----Calculate Hour
			Dim myTime : myTime =  right("0" & datepart("h",Now),2) & right("0" & datepart("n",Now),2)
			'-----Calculate Filename
			Dim sFilename	: sFilename = LOGS_FOLDER & "\" & myDate & ".xml"
			'----------------------------------
			
			
			Dim objFSO : Set objFSO	= server.CreateObject("scripting.Filesystemobject")
			Dim objFile					
						
			'Check existence of the file, and avoid to kill it if it exists			
			If objFSO.FileExists(sFilename) Then 
				'the file exists so we load it
				if not objXML.load(sFilename) then	
					debug "Log file exist but fails to load." 
					Exit sub	
				end if		
			Else			
				'the file is missing so we create an empty log file
				objXML.loadxml("<visitors/>")
			end if
			
							
				
		    '-----Calculate URL
		    Dim myUrl, item
		    myUrl = "" 'Request.ServerVariables("SCRIPT_NAME") & "?"
		        
		    For Each item In Request.QueryString
		    	myUrl = myUrl & item & "=" & Request.QueryString(Item) & "&"
		    Next
		    
		    myUrl = replace(myUrl, "&", "&amp;")
		    
		    '-----Calculate browser
		    Dim oBrw, strBr
			set oBrw = new CBrowser
				strBr = oBrw.Browser & " - " & oBrw.Version		
			set oBrw = nothing		
		        
		    'referer
		    dim Ref : Ref = ""
		    if instr(1, Request.ServerVariables("HTTP_REFERER"), Request.ServerVariables("SERVER_NAME"))=0 then
				Ref = replace(Request.ServerVariables("HTTP_REFERER"), "&", "&amp;")
			else 
				Ref = ""
			end if
		        
		    '-----We append the new node
		    ' p: ip address
		    ' b: brower
		    ' l: language
		    ' t: time
		    ' n: username
		    ' u: current url
		    ' f: referer
		    
		    '-----Search for the Visitor node (v)
		    Set oNodeList = objXML.selectNodes("/visitors/v[@p='" & Request.ServerVariables("REMOTE_ADDR") & "']")
			'
			
			If oNodeList.length=0 Then
				Set oXMLv = objXML.createElement("v")
					call oXMLv.setAttribute("p",  Request.ServerVariables("REMOTE_ADDR"))
					call oXMLv.setAttribute("b", strBr)
					call oXMLv.setAttribute("l", Request.ServerVariables("HTTP_ACCEPT_LANGUAGE"))
					call objXML.documentElement.appendChild(oXMLv)
				Set oXMLv = Nothing
			End If
				
 			Set oPointerNode = objXML.selectSingleNode("/visitors/v[@p='" & Request.ServerVariables("REMOTE_ADDR") & "']")

			' at the end we add the node of a single 'page viewed' (p)
			Set oXMLv = objXML.createElement("p")
				call oXMLv.setAttribute("t",  myTime)
				call oXMLv.setAttribute("n", m_oUser.UserName)					
				call oXMLv.setAttribute("u", replace(myUrl,"&amp;", "&"))
				
				call oXMLv.setAttribute("f", Ref)				
				call oPointerNode.appendChild(oXMLv)
			Set oXMLv = Nothing
				
			Call SaveXMLFile(sFilename, objXML.xml)
 			
		end sub
							
		
		'''-----------------------------------------
		''' Create a RSS channel from Fullxml data
		'''-----------------------------------------
		Public Function Rss()	
			Rss = Transform(DATA_PATH, XSLEXPORT_RSS_PATH, "RSSXSL", true)
			call LogUser()
		End Function
		
				
		'''-------------------------------------------
		''' Print some text if debug mode is activated
		'''-------------------------------------------
		Public Function Debug(sValue)
			if m_bDebugMode then Response.Write sValue & "<br>"
		End Function
		
		
		'+----------------------------------------------------------------------+
		'|	GrantAccess(sType)													|
		'|	This function check the userType									|
		'|	If it does not match, it redirects to home							|
		'+----------------------------------------------------------------------+
		Public Function GrantAccess(sType)
			if (m_oUser.GroupName<>sType and m_oUser.GroupName<>"administrator") then Response.Redirect "default.asp"
		End Function	
		
		Public Function GrantAccessEx(sType)
			if (m_oUser.GroupName<>sType and m_oUser.GroupName<>"administrator") then 
				GrantAccessEx = False
			else
				GrantAccessEx = True
			end if
		End Function
		
		'+----------------------------------------------------------------------+
		'|	Upload()															|
		'|	This function uploads files if some are posted						|
		'|																		|
		'+----------------------------------------------------------------------+
		Private Function Upload()
			Dim oFile, i
			Dim strUpload
						
			If oFO.TotalFormCount > 0 Then
				If oFO.FileCount > 0 Then
					For i = 1 To oFO.FileCount
						Set oFile = oFO.File(i)
						If oFile.ErrorMessage = "" Then
							strUpload = Trim(oFO.Form("UploadDir" & i))
							If len(strUpload) < 1 Then
								strUpload = UPLOAD_PATH
							End If
							Call oFile.SaveAsFile(strUpload)
						'Else
						'	Response.Write "Alert: "& oFile.ErrorMessage
						End If							
						Set oFile = Nothing
					Next
				End If
			End If
			
		End Function
		
		
		private sub InitUpload()
			'Get the posted form element - This component handle form as binary data
			Set oFO = New FileUpload
			Dim oProps
			Set oProps = oFO.GetUploadSettings
				with oProps
					.Extensions = Array("txt", "jpg", "zip", "rar", "arj", "gif", "pdf", "doc", "ico", "bmp", "doc", "xml", "jpeg", "exe", "mp3", "png", "htm", "html", "xsl")
					.UploadDirectory = UPLOAD_PATH
					'only administrator can overwrite
					.AllowOverWrite = true
					.MaximumFileSize = 1024000  ' give or take 135k for each file
					.MininumFileSize = 0 ' 0k
					'mettre a yes si pas autorisé
					.UploadDisabled = false
				End with
			set oProps = nothing
			Call oFO.ProcessUpload()
		end sub
		
		
		'+----------------------------------------------------------------------+
		'|	LogList()															|
		'|	Create a piece of XML for the log files								|
		'|																		|
		'+----------------------------------------------------------------------+
		Private function LogList()
			Dim objFSO, objFolder, objItem
			
			' Create our FSO
			Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
			
			LogList = "<logs>"
						
			' Get a handle on our folder
			Set objFolder = objFSO.GetFolder(LOGS_FOLDER)				
				For Each objItem In objFolder.Files
					If right(objItem.name,3)="xml" then
						LogList = LogList & "<log date=""" & left(objItem.Name, len(objItem.Name)-4) & """ name=""" & LOGS_FOLDER & "\" & objItem.Name & """/>"
					end if
				Next			
			LogList = LogList & "</logs>"
			
			Set objFolder = Nothing					
			Set objFSO = Nothing
		End function
		
		
		'+----------------------------------------------------------------------+
		'|	SkinList()															|
		'|	Create an XML node for the skins folders							|
		'|																		|
		'+----------------------------------------------------------------------+
		Private Function SkinList()
			Dim objFSO, objFolder, objItem
			
			' Create our FSO
			Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
			
			SkinList = "<xslskins>"
						
			' Get a handle on our folder
			Set objFolder = objFSO.GetFolder(ROOT_PATH & "\skins")				
				For Each objItem In objFolder.SubFolders
					If lcase(objItem.Name)<>"common" and lcase(objItem.Name)<>"cvs" then
						SkinList = SkinList & "<xslskin name='" & objItem.Name & "'" 
						if objFSO.Fileexists(objItem.Path & "/studio.xml") then
							SkinList = SkinList & " studio=""true"" path=""" & objItem.Path & "/studio.xml" & """"
						end if
						SkinList = SkinList & "></xslskin>"
					end if
				Next			
			SkinList = SkinList & "</xslskins>"
			
			Set objFolder = Nothing
			Set objFSO = Nothing
		End Function


		'+----------------------------------------------------------------------+
		'|	UploadFile()													 	'|
		'|	Return a msxml dom of the files in the current folder		|
		'|																'|
		'+----------------------------------------------------------------------+
		private function UploadFile(oUFLXML, objFolder, strPath)
			Dim objItem
			Dim oNewNode
			Dim newAtt
			Dim strName	

			For Each objItem In objFolder.Files
				strName = cstr(strPath) & cstr(objItem.Name)

				if request.QueryString("file")=strName then
					objItem.delete
				else
					set oNewNode = oUFLXML.createElement("file")				

					'the name of the file
					Set newAtt = oUFLXML.createAttribute("name")
					newAtt.value = strName
					oNewNode.Attributes.setNamedItem newAtt
					
					'the size of the file
					Set newAtt = oUFLXML.createAttribute("size")
					newAtt.value = cstr(int(objItem.Size/1024)) & " kb"
					oNewNode.Attributes.setNamedItem newAtt
					
					'the type of the file
					Set newAtt = oUFLXML.createAttribute("type")
					newAtt.value = cstr(objItem.Type)
					oNewNode.Attributes.setNamedItem newAtt
				
					'the type of the file
					Set newAtt = oUFLXML.createAttribute("date")
			                newAtt.value = cstr(Year(objItem.DateLastModified) & Right("0" & Month(objItem.DateLastModified), 2) & Right("0" & Day(objItem.DateLastModified), 2) & Right("0" & Hour(objItem.DateLastModified), 2) & Right("0" & Minute(objItem.DateLastModified), 2)& Right("0" & Second(objItem.DateLastModified), 2))
					'newAtt.value = cstr(objItem.DateLastModified)
					oNewNode.Attributes.setNamedItem newAtt	

					oUFLXML.documentElement.appendChild(oNewNode.clonenode(true))
				end if
			Next

			Set objItem = Nothing
			Set oNewNode = Nothing
			Set newAtt = Nothing
		end function

		'+----------------------------------------------------------------------+
		'|	UploadSubDir()												
		'|	Checks subdirectories of media folder for files			|
		'|														
		'+----------------------------------------------------------------------+
		private function UploadSubDir(oUFLXML, objFolder, strParentPath, strPath)
			Dim objSubFolder 'Folder variable
			Dim intPathLen

			intPathLen = len(strParentPath)

			UploadFile oUFLXML, objFolder, strPath
			For Each objSubFolder In objFolder.SubFolders
				strPath = Mid(objSubFolder.path, intPathlen) & "/"
				strPath = Replace(strPath, "\", "/")
				UploadSubDir oUFLXML, objSubFolder, strParentPath, strPath
			Next
			Set objSubFolder = Nothing
		end function

		'+----------------------------------------------------------------------+
		'|	UploadFileList()													|
		'|	Return a msxml dom of the files in the upload folders		|
		'|																		|
		'+----------------------------------------------------------------------+
		public function UploadFileList
			Dim oUFLXML
			Dim objFSO    'FileSystemObject variable
			Dim objFolder 'Folder variable
			Dim newAtt
			Dim sPath	: sPath = UPLOAD_PATH
			
			Set objFSO = Server.CreateObject("Scripting.FileSystemObject")			
			Set objFolder = objFSO.GetFolder(sPath)			
			set oUFLXML = server.CreateObject(MSXML_PROGID)
			oUFLXML.async = false
			
			' we create a root node with a param containing the path
			oUFLXML.loadXML("<uploadfolder/>")				
			Set newAtt = oUFLXML.createAttribute("folder")
			newAtt.value = cstr(UPLOAD_PATH)
			oUFLXML.documentElement.Attributes.setNamedItem newAtt

			' we build the list of the file
			UploadSubDir oUFLXML, objFolder, UPLOAD_PATH, ""
			

			set objFolder = nothing
			Set objFSO = nothing
			set UploadFileList = oUFLXML
		end function

		'+----------------------------------------------------------------------+
		'|	InitSkin()												
		'|	Load the XSL skin name ON PAGE LEVEL from the XML configuration file
		'|											
		'+----------------------------------------------------------------------+
		Private Sub InitSkin(sID)
			Dim oNodeList
			Dim iSkin
			
			if lenb(sID)=0 then exit sub
						
			'Point to the webpage node
			set oNodeList = fullxml.SelectNodes("siteinfo/pages/page[id='" & sID & "']/xslskin")
			
			'check if the count node of the page exists - if not, exit sub and default skin is used
			if oNodeList.length=0 then 				
				exit Sub
			else
				'select the page node
				Dim oNode : set oNode = fullxml.SelectSingleNode("siteinfo/pages/page[id='" & sID & "']/xslskin")
				Set oNode = oNode.FirstChild
				If Not oNode.text= "" then	
					'load skin from node "page"
					iSkin = oNode.text
					Call LoadSkin(iSkin)
				Else
					'load default skin from node "siteinfo" defined in general settings
					Call LoadSkin("")
				End if								
			end if								
		End Sub		
		
		
		'+----------------------------------------------------------------------+
		'|	LoadSkin()															|
		'|	Load the XSL skin name from the XML configuration file				|
		'|																		|
		'+----------------------------------------------------------------------+
		Private Function LoadSkin(sSkin)
			Dim objNode					
			Dim l_sUserAgent			
			
			l_sUserAgent = lcase(Request.ServerVariables("HTTP_USER_AGENT"))
		
			'detection de la plateforme
			if instr(1,l_sUserAgent,"winwap")>0 or instr(1,l_sUserAgent,"m3gate")>0 or instr(1,l_sUserAgent,"nokia")>0 or lenb(Request.QueryString("wap"))>0 then
				'if lenb(request("wap"))=0 then 
				Response.ContentType = "text/vnd.wap.wml"
				Response.Write "<?xml version=""1.0""?>"
				Response.Write "<!DOCTYPE wml PUBLIC ""-//WAPFORUM//DTD WML 1.1//EN"" ""http://www.wapforum.org/DTD/wml_1.1.xml"">"
				m_sSkin = ROOT_PATH & "\skins\wap\page.xsl"	
				m_sSkinName = "wap"
				
			'affectation des skins web
			else
				if sSkin = "" then
					Set objNode = fullxml.documentElement.selectNodes("/siteinfo/data/xslskin")						
						if objNode.Length>0 then						
							m_sSkin	= ROOT_PATH & "\skins\" & objNode.Item(0).text & "\page.xsl"
							m_sSkinName = objNode.Item(0).text
						else
							m_sSkin = ROOT_PATH & "\skins\default\page.xsl"		
							m_sSkinName = "default"
						end if			
					set objNode = nothing
				else
					'use skin defined on page level
					m_sSkin	= ROOT_PATH & "\skins\" & sSkin & "\page.xsl"
					m_sSkinName = sSkin				
				end if					
			end if					
		End Function
		
		
		'+----------------------------------------------------------------------+
		'|	XForm()																|
		'|	generate an XForm node , to v2 format								|
		'|																		|
		'+----------------------------------------------------------------------+
		private function XForm(bNewID)
			Dim NodeName	: NodeName = trim(URLDecode(oFO.Form("node")))
			Dim Item
			Dim sItemType	: sItemType = "P_"
			Dim sItemName
			Dim sItemValue
			Dim arrForbidden : arrForbidden = array("xpath", "xform", "lgn", "pwd", "date", "file", "bloc", "node", "section", "operation", "id", "owner")
			Dim oXForm
			Dim newAtt
			Dim oCdata
			Dim oNewNode
			
			
			set oXForm = server.CreateObject(MSXML_PROGID) : oXForm.async = false
				oXForm.loadxml("<" & NodeName & "/>")
				
				if bNewID then
					Set newAtt = oXForm.createAttribute("id")
					newAtt.value = cstr(GetGuid(12))
					oXForm.documentElement.Attributes.setNamedItem newAtt
				end if
				
				'we append some metadata to the new node
				Set newAtt = oXForm.createAttribute("date")
				newAtt.value = cstr(Year(Now) & Right("0" & Month(Now), 2) & Right("0" & Day(Now), 2) & Right("0" & Hour(Now), 2) & Right("0" & Minute(Now), 2))
				oXForm.documentElement.Attributes.setNamedItem newAtt
				
				Set newAtt = oXForm.createAttribute("owner")
				newAtt.value = cstr(m_oUser.UserName)
				oXForm.documentElement.Attributes.setNamedItem newAtt
				
				'Add each field neither as Attribute or as Child
				For each Item in oFO.Inputs	
					if not IsInArray(Item, arrForbidden) then		'on test si ce n'est pas un champs interdit
						sItemType	= mid(Item,1,2)
						sItemName	= replace(replace(Item, "N_", ""), "P_", "")
						sItemValue	= URLDecode(oFO.Form(Item))
						
						select case sItemType
							case "N_" :
								'on ajoute en tant que node
								set oNewNode = objXML.createElement(sItemName)
								Set oCdata = objXml.createCDATASection(sItemValue)
								oNewNode.appendChild(oCdata)
								oXForm.documentElement.appendChild(oNewNode)
								
							Case "P_" :
								'on ajoute en tant que parametre
								Set newAtt = oXForm.createAttribute(sItemName)
								newAtt.value = cstr(CleanParameter(sItemValue))
								oXForm.documentElement.Attributes.setNamedItem newAtt

							Case else:
								'on ajoute en tant que parametre
								Set newAtt = oXForm.createAttribute(sItemName)
								newAtt.value = cstr(CleanParameter(sItemValue))
								oXForm.documentElement.Attributes.setNamedItem newAtt
						end select		
					End if
				Next
				
				XForm = oXForm.xml
			set oXForm = nothing			
		end function

		'+----------------------------------------------------------------------+
		'| functions for chat							|
		'+----------------------------------------------------------------------+
		'| Modified: 28.09.2003 by JeS						|
		'+----------------------------------------------------------------------+
		private function chat_getID(byRef xmlChat, strNode)
			Dim intID
			Dim boolLoop
			Dim nodTest

			intID = xmlChat.SelectNodes(strNode).Length + 1
							
			'Search for a free id
			Do While boolLoop
				Set nodTest = xmlChat.SelectNodes(strNode & "[id=" & intID & "]")
				If nodTest.Length > 0 Then
					intId = intId + 1
				Else
					boolLoop = False
				End If
			Loop

			Set nodTest = Nothing

			chat_getID = intID
		End function

		private sub chat_addnode(byRef nodParent, strName, strValue)
			Dim nodNew
			Dim cdatNode

			Set nodNew = objXML.createNode(1, strName, "")
			Set cdatNode = objXML.createNode(4, "", "")
			cdatNode.text = strValue
			nodNew.AppendChild cdatNode
			nodParent.appendChild nodNew

			Set cdatNode = Nothing
			Set nodNew = Nothing
		end sub

		private sub chat_UpdateChannel(intChannel, strNode)
			Dim strDate
			Dim strParent
			Dim lstNode
			Dim nodParent
			Dim cdatNode

			strDate = Now()
			strDate = Year(strDate) & Right("0" & Month(strDate), 2) & Right("0" & Day(strDate), 2) & right("0" & datepart("h",strDate),2) & right("0" & datepart("n",strDate),2) & right("0" & datepart("s",strDate),2)
			strParent = "chat/channel[id = " & intChannel & "]"

			objXML.load(CHAT_PATH)
			Set lstNode = objXML.documentElement.SelectNodes("/" & strParent & "/" & strNode)
			If CInt(lstNode.Length) > 0 Then
				lstNode.item(0).FirstChild.text = strDate
			Else
				Set nodParent = objXML.SelectSingleNode(strParent)
				chat_addnode nodParent, strNode, strDate				
			End If
			
			' saving the file
			Call SaveXMLFile(CHAT_PATH, objXML.xml)

			Set nodParent = Nothing
			Set lstNode = Nothing
		end sub

		private sub chat_UpdateUser(intChannel, strNode)
			Dim strDate
			Dim strParent
			Dim lstNode
			Dim nodParent
			Dim cdatNode

			strDate = Now()
			strDate = Year(strDate) & Right("0" & Month(strDate), 2) & Right("0" & Day(strDate), 2) & right("0" & datepart("h",strDate),2) & right("0" & datepart("n",strDate),2)
			strParent = "chat/channel[id = " & intChannel & "]/members/member[pseudo = '" & m_oUser.Username & "']"

			If LenB(strNode) < 1 Then
				strNode = "lastactivity"
			End If

			If strNode = "lastactivity" Then
				strDate = Year(Now) & Right("0" & Month(Now), 2) & Right("0" & Day(Now), 2) & Right("0" & Hour(Now), 2) & Right("0" & CLng(Minute(Now)/0.6), 2)
			End If
		
			objXML.load(CHAT_PATH)
			Set lstNode = objXML.documentElement.SelectNodes("/" & strParent & "/" & strNode)
			If CInt(lstNode.Length) > 0 Then
				lstNode.item(0).FirstChild.text = strDate
			Else
				Set lstNode = objXML.documentElement.SelectNodes("/" & strParent)
				If CInt(lstNode.Length) > 0 Then
					lstNode.item(0).FirstChild.text = strDate
					Set nodParent = objXML.SelectSingleNode(strParent)
					chat_addnode nodParent, strNode, strDate				
				End If
			End If
			
			' saving the file
			Call SaveXMLFile(CHAT_PATH, objXML.xml)

			Set nodParent = Nothing
			Set lstNode = Nothing
		end sub

		private sub chat_connect(intChannel, strOperation)
			call chat_UpdateChannel(intChannel, "useraction")
			call chat_InsertMessage(intChannel, strOperation)
			call chat_Cleanup(intChannel)
		end sub

		private sub chat_Session(intChannel)
			Dim sessionFullXML

			Set sessionFullXML = New CSession
			sessionFullXML.Init objXML, False
			Set sessionFullXML = Nothing
			
			call chat_UpdateUser(intChannel, "lastsessionupd")
		end sub

		private sub chat_Cleanup(intChannel)
			Dim lstNode
			Dim nodInfo
			Dim strDate
			Dim strNode
			Dim lngMsgCleanUpTimer

			lngMsgCleanUpTimer = 10			

			Set lstNode = fullxml.SelectNodes("siteinfo/data/chatcleanup")			
			If lstNode.length > 0 Then
				Set nodInfo = fullxml.SelectSingleNode("siteinfo/data/chatcleanup")
				Set nodInfo = nodInfo.FirstChild
				lngMsgCleanUpTimer = CLng(nodInfo.text)
			End If
			Set nodInfo = Nothing

			strDate = Now()
			strDate = Year(strDate) & Right("0" & Month(strDate), 2) & Right("0" & Day(strDate), 2) & right("0" & datepart("h",strDate),2) & right("0" & datepart("n",strDate),2)

			objXML.load(CHAT_PATH)

			strNode = "//chat/channel[id = " & intChannel & "]/messages/message[date < number(" & strDate - lngMsgCleanUpTimer & ")]"
			Set lstNode = objXML.SelectNodes(strNode)
			If lstNode.Length > 0 Then
				lstNode.removeAll
			End If

			strNode = "//chat/channel[id = " & intChannel & "]/members/member[lastactivity < number(" & strDate - SESSION_EXPIRE & ")]"
			Set lstNode = objXML.SelectNodes(strNode)
			If lstNode.Length > 0 Then
				lstNode.removeAll
			End If

			call SaveXMLFile(CHAT_PATH, objXML.xml)
			call chat_UpdateChannel(intChannel, "lastcleanup")

			Set lstNode = Nothing
		end sub

		private sub chat_InsertMessage(intChannel, strMessage)
			Dim strNode
			Dim strParent
			Dim nodParent
			Dim nodNew
			Dim strDate
	
			objXML.load(CHAT_PATH)
			strNode ="message"
			strParent = "chat/channel[id = " & intChannel & "]/messages"
			strDate = Now()
			strDate = Year(strDate) & Right("0" & Month(strDate), 2) & Right("0" & Day(strDate), 2) & right("0" & datepart("h",strDate),2) & right("0" & datepart("n",strDate),2)
						
			Set nodParent = objXML.SelectSingleNode(strParent)
			Set nodNew = objXML.CreateNode(1, strNode, "")
												
			chat_addnode nodNew, "id", chat_getID(objXML, "//" & strNode)
			chat_addnode nodNew, "to", ""
			chat_addnode nodNew, "owner", m_oUser.UserName
			chat_addnode nodNew, "msg", ""
			chat_addnode nodNew, "visible", "on"
			chat_addnode nodNew, "type", strMessage
			chat_addnode nodNew, "date", strDate

			nodParent.AppendChild nodNew

			call SaveXMLFile(CHAT_PATH, objXML.xml)
			call chat_UpdateChannel(intChannel, "messageaction")

			Set nodParent = Nothing
		end sub
		
	End Class
%>
