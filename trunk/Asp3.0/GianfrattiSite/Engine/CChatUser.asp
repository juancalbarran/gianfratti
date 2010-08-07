<%
	Class CChatUser
		private m_sessionFullXML
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
			m_bDebugMode	= false
		end sub
		
		
		'Destructor
		private sub Class_terminate
			Set m_sessionFullXML = Nothing
		end sub 
		
		
		'+-------------------------------------------------------------------------------------+
		'|
		'|
		'+-------------------------------------------------------------------------------------+
		
		' The user name
		property get UserName
			UserName= m_sessionFullXML.UserName
		end property
		
		' The User's group name
		property get GroupName
			GroupName= m_sessionFullXML.GroupName
		end property
		
		' The number of active sessions
		property get Count
			Count = m_sessionFullXML.SessionCount
		end property
		
		
		' the number of identified sessions
		property get CountMembers
			CountMembers = m_sessionFullXML.NamedSessionCount
		end property
		
		'+-------------------------------------------------------------------------------------+
		'|
		'| Public Methodes
		'+-------------------------------------------------------------------------------------+
		
		
		public function Init(byref oFO, byref oXML, byRef sessionFullXML, strAuthType)
			Dim l_sFrmLogin
			Dim l_sFrmPassword
			Dim oRc4
			
			Init = ERR_NONE
						
			set m_oFO	= oFO
			set m_oXML	= oXML		
			set m_sessionFullXML = sessionFullXML
			Set oRc4 = New CRc4

			'A email subscribtion is currently activated
			if lenb(Request.QueryString("guid"))>0 then
				Init = Valid()
			end if

			m_sUserName = URLDecode(m_oFO.Form("lgn"))
			If LenB(m_sUserName) > 0 Then
				m_sPassword = URLDecode(m_oFO.Form("pwd"))

				If LCase(m_sUsername)="full" and LCase(m_sPassword)="xml" Then
					Init = ERR_FULL_XML					
				End If

				If lenB(m_oFO.Form("rememberme"))>0 then
					m_sessionFullXML.SetRememberCookie oRc4(m_sUsername, CRYPT_RC4_KEY), oRc4(m_sPassword, CRYPT_RC4_KEY)
				End If
			Else
				If m_sessionFullXML.IsNewSession Then
					m_sUsername = oRc4(m_sessionFullXML.GetRememberCookie("user"), CRYPT_RC4_KEY)
					m_sPassword = oRc4(m_sessionFullXML.GetRememberCookie("login"), CRYPT_RC4_KEY)
				Else
					m_sUsername = m_sessionFullXML.Username
					m_sPassword = m_sessionFullXML.Password
				End If

				If strAuthType = "HTTP" then
					m_sUsername = GetHTTPUserName()
					m_sPassword = ""
				End If
			End If

			If Not(m_sessionFullXML.IsNewSession) and (LenB(m_sUsername)) > 0 and Not(m_sessionFullXML.TimeCritical) Then
				If Not(CheckUser(m_sUsername, m_sPassword)) Then
					Init = ERR_LOGIN_PWD				
				End If
			End If
			
			Set oRc4 = Nothing
		end function
		
		
		'''------------------------------------------------
		''' Log off the user, so it returns to a anonymous state 
		'''------------------------------------------------
		public sub LogOff()
			m_sessionFullXML.EndSession
		end sub
				
		
		'+-------------------------------------------------------------------------------------+
		'|
		'|Private methodes
		'+-------------------------------------------------------------------------------------+
		
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

			m_sessionFullXML.Username 	= m_sUsername
			m_sessionFullXML.Password	= m_sPassword
			m_sessionFullXML.GroupName 	= m_sGroupName
			m_sessionFullXML.UserID 	= m_iUSerID
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
		
		
		
	End Class
%>