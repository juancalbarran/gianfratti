<%
	Class CUser
		private m_oXMLSession
		private m_oXML
		private m_oFO
		
		private m_sSessionID	' The session ID
		private m_sUserName
		private m_sPassword
		Private m_sGroupName
		private m_iUserID
		private m_iGroupID
		private m_sDate
		private m_sLocalIP
		private m_sRemoteIP
				
		private m_bDebugMode
		private m_tStart
		
		
		'Constructor
		private sub Class_initialize
			m_tStart = Timer()
			
			Dim objFSO : Set objFSO	= server.CreateObject("scripting.Filesystemobject")
			Dim objFile					
			
			m_bDebugMode	= false
						
			' we load the session file (to be stored in memory)
			set m_oXMLSession = server.CreateObject(MSXML_PROGID)
			m_oXMLSession.async = false
						
			'Check existence of the file, and avoid to kill it if it exists			
			If objFSO.FileExists(SESSIONS_PATH) Then 
				'the file exists so we load it
				if not m_oXMLSession.load(SESSIONS_PATH) then	
					debug "Session file exists but fails to load." 
					Exit sub	
				end if		
			Else			
				'the file is missing so we create an empty log file
				m_oXMLSession.loadxml("<sessions/>")
			end if
			
			'get sesion id from the cookie
			m_sSessionID	= Request.Cookies(COOKIE_NAME)(COOKIE_VALUE_SESSION)
			m_sUserName		= ""
			m_sPassword		= ""
			m_sGroupName	= "anonymous"
			m_iUserID		= 0
			m_iGroupID		= 0	
			m_sLocalIP		= Request.ServerVariables("LOCAL_ADDR")
			m_sRemoteIP		= Request.ServerVariables("REMOTE_ADDR")
			m_sDate			= Year(Now) & Right("0" & Month(Now), 2) & Right("0" & Day(Now), 2) & right("0" & datepart("h",Now),2) & right("0" & datepart("n",Now),2)
			debug "Session ID: " & m_sSessionID
		end sub
		
		
		'Destructor
		private sub Class_terminate			
			
			'-- Session cookie
			Response.Cookies(COOKIE_NAME)(COOKIE_VALUE_SESSION) = m_sSessionID			
			
			'-- extend Remember me cookie to one more month
			Response.Cookies(COOKIE_NAME).Expires = DateAdd("n", SESSION_EXPIRE, Now)
			
			
			debug "CUser:Terminate " & (Timer()-m_tStart)*1000
			set m_oXMLSession = nothing
		end sub 
		
		
		'+-------------------------------------------------------------------------------------+
		'|
		'|
		'+-------------------------------------------------------------------------------------+
		
		' The user name
		property get UserName : UserName= m_sUserName : end property
		
		
		' The User's group name
		property get GroupName: GroupName= m_sGroupName : end property
		
		
		' The number of active sessions
		property get Count
			dim oNodeList
			dim theDate
			thedate = dateadd("n", -20, Now)
			thedate = Year(thedate) & Right("0" & Month(thedate), 2) & Right("0" & Day(thedate), 2) & right("0" & datepart("h",thedate),2) & right("0" & datepart("n",thedate),2)
			
			set oNodeList = m_oXMLSession.selectNodes("/sessions/session[@date >= number(" & thedate & ")]")
			debug "count: " & oNodeList.length
			Count = oNodeList.length
			set oNodelist = nothing
		end property
		
		
		' the number of identified sessions
		property get CountMembers
			dim oNodeList
			dim theDate
			thedate = dateadd("n", -20, Now)
			thedate = Year(thedate) & Right("0" & Month(thedate), 2) & Right("0" & Day(thedate), 2) & right("0" & datepart("h",thedate),2) & right("0" & datepart("n",thedate),2)
			
			set oNodeList = m_oXMLSession.selectNodes("/sessions/session[@date >= number(" & thedate & ") and string-length(@username)>0 ]")
			debug "count of members: " & oNodeList.length
			CountMembers = oNodeList.length
			set oNodelist = nothing
		end property
		
		
		'The members list, as an XMLNode object
		'public property Get Members
		'	Dim oXMLMember
		'	dim oNodeList
		'	dim theDate
		'	Dim Item
		'	
		'	set oXMLMember = server.CreateObject(MSXML_PROGID)
		'	oXMLMember.async = false
		''	'call oXMLMember.setProperty("SelectionLanguage", "XPath")
		'	if MSXML4 then call oXMLMember.setProperty("NewParser", True )
		'	oXMLMember.loadXML("<members/>")
		'	
		'	thedate = dateadd("n", -20, Now)
		'	thedate = Year(thedate) & Right("0" & Month(thedate), 2) & Right("0" & Day(thedate), 2) & right("0" & datepart("h",thedate),2) & right("0" & datepart("n",thedate),2)
		'	
		'	'msxml3 is a deep shit :-O
		'	if MSXML4 then
		'		set oNodeList = m_oXMLSession.selectNodes("/sessions/session[@date >= number(" & thedate & ") and string-length(@username)>0 ]")
		'	else
		'		set oNodeList = m_oXMLSession.selectNodes("/sessions/session[@date >= number(" & thedate & ")]")
		'	end if
		'	
		'	for each item in oNodeList
		'		oXMLMember.documentElement.appendChild(item.clonenode(true))				
		'	next
		'	set oNodelist = nothing
		'	
		'	set Members = oXMLMember
		'	
		'end property
		
		'+-------------------------------------------------------------------------------------+
		'|
		'| Public Methodes
		'+-------------------------------------------------------------------------------------+
		
		
		public function Init(byref oFO, byref oXML, strAuthType)
			Dim l_sFrmLogin
			Dim l_sFrmPassword
			
				
			
			Init = ERR_NONE
						
			set m_oFO	= oFO
			set m_oXML	= oXML		
			
			'Load if the a session
			if len(m_sSessionID)=20 then
				debug "Load existing session"
				Call Load(strAuthType)
				
			'or create a new session
			else
				debug "We create an new session iD"
				Call Create(strAuthType)
			end if	
			
			
			'A email subscribtion is currently activated
			if lenb(Request.QueryString("guid"))>0 then
				Init = Valid()
			end if
			
			' Authentication from the form
			l_sFrmLogin		= URLDecode(m_oFO.Form("lgn"))
			l_sFrmPassword	= URLDecode(m_oFO.Form("pwd"))
					
			
			Dim oRc4
			set oRc4 = New CRc4						
			
			'or from the cookie "remember me"
			if (lenB(l_sFrmLogin)=0 and lenB(l_sFrmPassword)=0) and (lenB(Request.Cookies(COOKIE_NAME)(COOKIE_VALUE_USR))>0 and lenB(Request.Cookies(COOKIE_NAME)(COOKIE_VALUE_PWD))>0) Then
				Debug "Load infos form remember cookie"
				l_sFrmLogin		= oRc4(Request.Cookies(COOKIE_RMB_NAME)(COOKIE_VALUE_USR), CRYPT_RC4_KEY)
				l_sFrmPassword	= oRc4(Request.Cookies(COOKIE_RMB_NAME)(COOKIE_VALUE_PWD), CRYPT_RC4_KEY)
			end if
						
			
			'get the datas from post or from cookie
			if lenb(l_sFrmLogin)>0 and lenb(l_sFrmPassword)>0 then				
				
				if CheckUser(l_sFrmLogin, l_sFrmPassword) then
					
					'-- Save a cookie if "remember me is checked"
					If lenB(m_oFO.Form("rememberme"))>0 then
						debug "Remeber Cookie created"
						Response.Cookies(COOKIE_RMB_NAME)(COOKIE_VALUE_USR)	= oRc4(l_sFrmLogin, CRYPT_RC4_KEY)
						Response.Cookies(COOKIE_RMB_NAME)(COOKIE_VALUE_PWD)	= oRc4(l_sFrmPassword, CRYPT_RC4_KEY)
						Response.Cookies(COOKIE_NAME).Expires = DateAdd("d", COOKIE_RMB_EXPIRE, Date)
					End If
										
					
					
					'Display a warning message ?
					if lcase(l_sFrmLogin)="full" and lcase(l_sFrmPassword)="xml" then
						Init = ERR_FULL_XML					
					end if
					
					'-Save the session file
					call Save()
						
				'	Response.End
					'redirect
				'	If lenb(request.ServerVariables("HTTP_REFERER"))>0 and instr(request.ServerVariables("HTTP_REFERER"), "ACT=11")=0 and instr(request.ServerVariables("HTTP_REFERER"), "ACT=10")=0 and init=ERR_NONE then
				'		Response.Redirect request.ServerVariables("HTTP_REFERER")
				'	End If
					
					
				
				else
					Init = ERR_LOGIN_PWD				
				end if
			
			end if
						
			'we update the session file
			call purge()
			call Save()
			
			Set oRc4 = Nothing
			
			debug "CUser:Init  " & (Timer()-m_tStart)*1000
		end function
		
		
		'''------------------------------------------------
		''' Log off the user, so it returns to a anonymous state 
		'''------------------------------------------------
		public sub LogOff()
			m_sUserName		= ""
			m_sGroupName	= "anonymous"
			m_iUserID		= 0
			m_iGroupID		= 0
			' we keep the session ID !!!!
			m_sDate			= ""
			
			'empty the "remember me cookie"
			Response.Cookies(COOKIE_RMB_NAME)(COOKIE_VALUE_USR)	= ""
			Response.Cookies(COOKIE_RMB_NAME)(COOKIE_VALUE_PWD)	= ""			
			call Save()
		end sub
				
		
		'+-------------------------------------------------------------------------------------+
		'|
		'|Private methodes
		'+-------------------------------------------------------------------------------------+
		
		
		'''------------------------------------------------
		''' Load the session corresponding to the sessionID
		'''------------------------------------------------
		private sub Load(strAuthType)
			Dim oNodeList
				
			set oNodeList	= m_oXMLSession.selectNodes("/sessions/session[@id='" & m_sSessionID & "']")
			if oNodeList.length>0 then
				m_sUserName		= oNodeList.item(0).attributes.getnameditem("username").text
				if len(m_sUserName)=0 and strAuthType = "HTTP" then
					m_sUserName = GetHTTPUserName()
				end if
				m_sGroupName	= oNodeList.item(0).attributes.getnameditem("groupname").text
				m_sPassword		= oNodeList.item(0).attributes.getnameditem("password").text
				m_iUserID		= oNodeList.item(0).attributes.getnameditem("userid").text
				m_iGroupID		= oNodeList.item(0).attributes.getnameditem("groupid").text
				m_sDate			= Year(Now) & Right("0" & Month(Now), 2) & Right("0" & Day(Now), 2) & right("0" & datepart("h",Now),2) & right("0" & datepart("n",Now),2)
			
				'hey hey Mr HackBR
				Call CheckUser(m_sUserName, m_sPassword)
				
			end if
		end sub

		'''------------------------------------------------
		''' get username from HTTP_AUTH
		'''------------------------------------------------
		private function GetHTTPUsername()
			Dim strAuthString
			Dim lngPosition

			strAuthString = Request.ServerVariables("AUTH_USER")
			if Len(strAuthString) > 0 then
				'ignore name of domain
				lngPosition = InStr(1, strAuthString, "\")
				strAuthString = UCase(Right(strAuthString, Len(strAuthString) - lngPosition))
			else
				strAuthString = "-"
			end if
			GetHTTPUsername = strAuthString
		end function
		
		
		'''------------------------------------------------
		''' Create an anonymous new session
		'''------------------------------------------------
		private sub Create(strAuthType)
			select case strAuthType
				case "HTTP":
					if not(CheckUser(GetHTTPUsername(), "")) then
						strAuthType = "STANDARD"
					end if
					m_sSessionID = GetGuid(6) & "-" & GetGuid(6) & "-" & GetGuid(6)
				case else:
					m_sSessionID = GetGuid(6) & "-" & GetGuid(6) & "-" & GetGuid(6)
			end select
		end sub
				
		
		'''-----------------------------------------
		''' This function check login/password
		'''-----------------------------------------
		Function CheckUser(p_sLogin, p_sPassword)
			Dim oMemberNode
						
			p_sLogin = replace(p_sLogin, "'", "")
			p_sPassword = replace(p_sPassword, "'", "")
						
			debug p_sLogin
			debug p_sPassword
			
			debug "/members/member[(pseudo='" & p_sLogin & "' or email='" & p_sLogin & "') and password='" & p_sPassword & "' and visible='on']"
			
			'''Now we check if user has a admin account				
			if m_oXML.load(MEMBER_PATH) then							
				Set oMemberNode	= m_oXML.SelectNodes("/members/member[(pseudo='" & p_sLogin & "' or email='" & p_sLogin & "') and password='" & p_sPassword & "' and visible='on']")
			
				'User is found
				If oMemberNode.length>0 then
					debug "info ok"
					'm_sUserName		= p_sLogin
					m_sPassword		= p_sPassword
					m_sGroupName	= "member"
					
					call GetXPathValue(m_sUserName, "/members/member[(pseudo='" & p_sLogin & "' or email='" & p_sLogin & "') and password='" & p_sPassword & "' and visible='on']/pseudo")
					call GetXPathValue(m_sGroupName, "/members/member[(pseudo='" & p_sLogin & "' or email='" & p_sLogin & "') and password='" & p_sPassword & "' and visible='on']/type")
					call GetXPathValue(m_iUserID,	"/members/member[(pseudo='" & p_sLogin & "' or email='" & p_sLogin & "') and password='" & p_sPassword & "' and visible='on']/id")
										
					CheckUser = true
				else
					debug "Bad infos"
					
					m_sUserName		= ""
					m_sGroupName	= "anonymous"
					m_iGroupID		= 0
					m_iUserID		= 0
					CheckUser = false
				End if
				
				Set oMemberNode = nothing
			else
				debug "Failed to load member file"
				m_sUserName		= ""
				m_sGroupName	= "anonymous"
				m_iGroupID		= 0
				m_iUserID		= 0
				CheckUser = false
			end if
		End Function
				
		
		' check if the user/group stored is right
		Function CheckUserGroup(p_sLogin, p_sGroup)
			Dim oMemberNode
						
			'''Now we check if user has a admin account				
			if m_oXML.load(MEMBER_PATH) then							
				Set oMemberNode	= m_oXML.SelectNodes("/members/member[(pseudo='" & p_sLogin & "' or email='" & p_sLogin & "') and type='" & p_sGroup & "' and visible='on']")
			
				'User is found
				If oMemberNode.length>0 then
					'm_sUserName		= p_sLogin
					m_sGroupName	= "member"
					
					call GetXPathValue(m_sUserName, "/members/member[(pseudo='" & p_sLogin & "' or email='" & p_sLogin & "') and password='" & p_sPassword & "' and visible='on']/pseudo")
					call GetXPathValue(m_sGroupName, "/members/member[(pseudo='" & p_sLogin & "' or email='" & p_sLogin & "') and password='" & p_sPassword & "' and visible='on']/type")
					call GetXPathValue(m_iUserID,	"/members/member[(pseudo='" & p_sLogin & "' or email='" & p_sLogin & "') and password='" & p_sPassword & "' and visible='on']/id")
					
					CheckUserGroup = true
				else
					m_sUserName		= ""
					m_sGroupName	= "anonymous"
					m_iGroupID		= 0
					m_iUserID		= 0
					CheckUserGroup = false
				End if
				
				Set oMemberNode = nothing
			else
				debug "Failed to load member file"
				m_sUserName		= ""
				m_sGroupName	= "anonymous"
				m_iGroupID		= 0
				m_iUserID		= 0
				CheckUserGroup = false
			end if
			
		End Function
		
		
		'''-----------------------------------------
		''' This function validate a signup
		'''-----------------------------------------
		private Function Valid()
			Dim Onode, oNodeList
			Dim login	'password
			Dim sGUID : sGUID = request("guid")
			
			'load datas	
			Call m_oXML.load(MEMBER_PATH)
			
			'get the member, by guid
			set oNodeList = m_oXML.SelectNodes("/members/member[sign_guid='" & sGUID & "']")
	
			if oNodeList.length=0 then 
				Response.Write "This ressource doesn't exists, be sure to copy the entire url into your browser."
				Exit function
			else
				'update his visibility to 'on'
				set oNode = m_oXML.SelectSingleNode("/members/member[sign_guid='" & sGUID & "']/visible")
				set oNode = oNode.FirstChild						
					oNode.text = "on"	
				set oNode = nothing	
				
				'get his name and his group
				m_sGroupName = m_oXML.SelectSingleNode("/members/member[sign_guid='" & sGUID & "']/type").text
				m_sUserName = m_oXML.SelectSingleNode("/members/member[sign_guid='" & sGUID & "']/pseudo").text
				'password = m_oXML.SelectSingleNode("/members/member[sign_guid='" & sGUID & "']/password").text
								
				'save dats
				call SaveXMLFile(MEMBER_PATH, m_oXML.xml)
				
				Valid = ERR_WELCOME				
			end if
		End Function
		
		
		'save the session file
		private sub Save
			Dim newAtt, oNewNode, oNodeList, Item
							
			'A check is done to kill all the other sessions of the same user  
			if len(m_sUserName)>0 then
				set oNodeList = m_oXMLSession.SelectNodes("/sessions/session[@username='" & m_sUserName & "' and @id!='" & m_sSessionID & "']")
				if oNodeList.length>0 then
					debug "We kill the other sessions of this user"
					for each Item in oNodeList
						Item.parentNode.removeChild(Item)
					next
				end if
			end if
			
			'We search for a session with the same Session ID			
			set oNodeList = m_oXMLSession.SelectNodes("/sessions/session[@id='" & m_sSessionID & "']")
			if oNodeList.length=0 then
				'No session for this ID				
				debug "create the session node" 
				'--------------------------------------------------
				if m_oXMLSession.childNodes.length=0 then
				   m_oXMLSession.loadxml("<sessions/>")
				end if
				'--------------------------------------------------

				set oNewNode = m_oXMLSession.documentelement.appendChild(m_oXMLSession.createElement("session"))

				call addAttribute("id", m_sSessionID, oNewNode)
				call addAttribute("username", m_sUserName, oNewNode)
				call addAttribute("password", m_sPassword, oNewNode)
				call addAttribute("groupname", m_sGroupName, oNewNode)
				call addAttribute("userid", m_iUserID, oNewNode)
				call addAttribute("groupid", m_iGroupID, oNewNode)
				call addAttribute("date", m_sDate, oNewNode)
				call addAttribute("localip", m_sLocalIP, oNewNode)
				call addAttribute("remoteip", m_sRemoteIP, oNewNode)			
			else
				debug "update the session " & m_sGroupName
				m_oXMLSession.SelectSingleNode("/sessions/session[@id='" & m_sSessionID & "']/@username").value = cstr(m_sUserName)
				m_oXMLSession.SelectSingleNode("/sessions/session[@id='" & m_sSessionID & "']/@password").value = cstr(m_sPassword)
				m_oXMLSession.SelectSingleNode("/sessions/session[@id='" & m_sSessionID & "']/@groupname").value = cstr(m_sGroupName)
				m_oXMLSession.SelectSingleNode("/sessions/session[@id='" & m_sSessionID & "']/@userid").value = cstr(m_iUserID)
				m_oXMLSession.SelectSingleNode("/sessions/session[@id='" & m_sSessionID & "']/@groupid").value = cstr(m_iGroupID)
				m_oXMLSession.SelectSingleNode("/sessions/session[@id='" & m_sSessionID & "']/@date").value = cstr(m_sDate)
			end if
			
			'Save the file
			call SaveXMLFile(SESSIONS_PATH, m_oXMLSession.xml)
		end sub
				
		
		private sub addAttribute(sName, sValue, byref oNode)
			dim newAtt
			Set newAtt = m_oXML.createAttribute(sName)
			newAtt.value = cstr(sValue)
			oNode.Attributes.setNamedItem newAtt			
		end sub
		
		'''' don't work
		'private sub updateAttribute(sName, sValue, byref oNode)
		'	Dim oNodeList
		'	set oNodeList = oNode.SelectNodes("@username")
		'	if oNodeList.length=0 then
		'		call addAttribute(sName, sValue, oNode)
		'	else
		'		oNodeList.item(1).value = cstr(sValue)
		'	end if
		'end sub
		
		
		'''supprime les sessions de plus d'une heure
		private sub purge
			dim oNodeList
			dim theDate
			dim item
			thedate = dateadd("n", -20, Now)
			thedate = Year(thedate) & Right("0" & Month(thedate), 2) & Right("0" & Day(thedate), 2) & right("0" & datepart("h",thedate),2) & right("0" & datepart("n",thedate),2)
			set oNodeList = m_oXMLSession.selectNodes("/sessions/session[@date < number(" & thedate & ")]")
			debug "number of expired session: " & oNodeList.length
			for each item in oNodeList
				item.parentNode.removeChild(item)
			next
			set oNodelist = nothing
		end sub
		
		'''-------------------------------------------
		''' Print some text if debug mode is activated
		'''-------------------------------------------
		private Function Debug(sValue)
			if m_bDebugMode then Response.Write sValue & "<br>"
		End Function
		
		'------------------------------------------
		'Get Node Value from the xpath if it exists
		'otherwise, we let the variable unchanged
		'------------------------------------------
		Private Sub GetXPathValue(byref sVariable, sXPath)
			Dim oNodeList
			set oNodeList = m_oXML.selectNodes(sXPath)
			if oNodeList.length>0 then
				sVariable = oNodeList.item(0).text
			end if			
		end Sub
		
	End Class
%>