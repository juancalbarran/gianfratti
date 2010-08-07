<%
	'--------------------------------------------------------------------
	' CSession.asp
	'
	' This class handles everything belonging to session managment.
	'--------------------------------------------------------------------
	'
	' Project     :	FullXML v2.4
	' Fileversion :	0.2
	' Created     :	26.09.2003 by JeS
	' Modified    :	08.10.2003 by JeS
	'--------------------------------------------------------------------

	Class CChatSession
		private m_xmlSession
		private m_xmlFullXML

		private m_boolTimeCritical
		private m_boolPrepareTimeCritical
		private m_boolNewSession
		private m_boolNewSessionFile

		private m_boolDebugMode
		private m_strSessionID
		private m_strUserName
		private m_strPassword
		Private m_strGroupName
		private m_intUserID
		private m_intGroupID
		private m_strDate
		private m_strLocalIP
		private m_strRemoteIP

		'+----------------------------------------------------------------------+
		'| Initilization of class						|
		'+----------------------------------------------------------------------+
		'| Modified: 26.09.2003 by JeS						|
		'+----------------------------------------------------------------------+
		Private Sub Class_Initialize
			set m_xmlSession = server.CreateObject(MSXML_PROGID)
			m_xmlSession.async = false

			m_boolDebugMode	= True
			m_boolNewSessionFile = False
		End Sub

		'+----------------------------------------------------------------------+
		'| Termination of class							|
		'+----------------------------------------------------------------------+
		'| Modified: 26.09.2003 by JeS						|
		'+----------------------------------------------------------------------+
		Private Sub Class_Terminate()
			SetCookieSessionID

			DropOldSessions
			SaveSession

			Set m_xmlSession = Nothing
		End Sub

		'+----------------------------------------------------------------------+
		'| Public properties of class						|
		'+----------------------------------------------------------------------+
		'| Modified: 26.09.2003 by JeS						|
		'+----------------------------------------------------------------------+
		Public Property Let DebugMode(boolDebugMode)
			m_boolDebugMode = boolDebugMode
		End Property

		Public Property Get IsNewSession
			IsNewSession = m_boolNewSession
		End Property

		Public Property Get Groupname
			Groupname = m_strGroupname
		End Property

		Public Property Let Groupname(strGroupname)
			m_strGroupname = strGroupname
		End Property

		Public Property Get Password
			Password = m_strPassword
		End Property

		Public Property Let Password(strPassword)
			m_strPassword = strPassword
		End Property

		Public Property Get SessionCount
			Dim lstNode
			Dim strDate
			
			strDate = DateAdd("n", SESSION_EXPIRE * (-1), Now)
			strDate = Year(strDate) & Right("0" & Month(strDate), 2) & Right("0" & Day(strDate), 2) & right("0" & datepart("h",strDate),2) & right("0" & datepart("n",strDate),2)
			
			Set lstNode = m_xmlSession.selectNodes("/sessions/session[@date >= number(" & strDate & ")]")

			SessionCount = lstNode.Length
			Set lstNode = Nothing
		End Property

		Public Property Get NamedSessionCount
			Dim lstNode
			Dim strDate
			
			strDate = DateAdd("n", SESSION_EXPIRE * (-1), Now)
			strDate = Year(strDate) & Right("0" & Month(strDate), 2) & Right("0" & Day(strDate), 2) & right("0" & datepart("h",strDate),2) & right("0" & datepart("n",strDate),2)
			
			Set lstNode = m_xmlSession.selectNodes("/sessions/session[@date >= number(" & strDate & ")  and string-length(@username) > 0]")

			NamedSessionCount = lstNode.Length

			Set lstNode = Nothing
		End Property

		Public Property Get TimeCritical
			TimeCritical = m_boolTimeCritical
		End Property

		Public Property Get Username
			Username = m_strUsername
		End Property

		Public Property Let Username(strUsername)
			m_strUsername = strUsername
		End Property

		Public Property Get UserID
			UserID = m_intUserID
		End Property

		Public Property Let UserID(intUserID)
			m_intUserID = intUserID
		End Property

		'+----------------------------------------------------------------------+
		'| Initilization of class						|
		'+----------------------------------------------------------------------+
		'| Modified: 26.09.2003 by JeS						|
		'+----------------------------------------------------------------------+
		Public Function Init(byRef objXML, boolTimeCritical)
			set m_xmlFullXML = objXML

			m_strUserName	= ""
			m_strPassword	= ""
			m_strGroupName	= "anonymous"
			m_intUserID	= 0
			m_intGroupID	= 0	
			m_strLocalIP	= Request.ServerVariables("LOCAL_ADDR")
			m_strRemoteIP	= Request.ServerVariables("REMOTE_ADDR")
			m_strDate	= Year(Now) & Right("0" & Month(Now), 2) & Right("0" & Day(Now), 2) & right("0" & datepart("h",Now),2) & right("0" & datepart("n",Now),2)
			Session.Timeout	= SESSION_EXPIRE

			If boolTimeCritical Then
				If LenB(Session("username")) > 0 Then
					m_strUserName	= Session("username")
					m_strGroupName	= Session("groupname")					
					m_boolPrepareTimeCritical = False
				Else
					m_boolPrepareTimeCritical = True
				End If
			End If

			m_boolTimeCritical = boolTimeCritical

			OpenSessionFile
			m_strSessionID = GetCookieSessionID()
			GetSession
		End Function

		'+----------------------------------------------------------------------+
		'| End of session (log off)						|
		'+----------------------------------------------------------------------+
		'| Modified: 02.10.2003 by JeS						|
		'+----------------------------------------------------------------------+
		Public Sub EndSession()
			m_strUserName	     = ""
			m_strPassword	     = ""
			m_strGroupName	     = "anonymous"
			m_intUserID	     = 0
			m_intGroupID	     = 0	
			m_strLocalIP	     = Request.ServerVariables("LOCAL_ADDR")
			m_strRemoteIP	     = Request.ServerVariables("REMOTE_ADDR")
			m_strDate	     = ""
			Session("username")  = m_strUsername
			Session("groupname") = m_strGroupname
		End Sub

		'+----------------------------------------------------------------------+
		'| Open current session file 						|
		'+----------------------------------------------------------------------+
		'| Modified: 26.09.2003 by JeS						|
		'+----------------------------------------------------------------------+
		Private Sub OpenSessionFile()
			Dim objFSO 
			Dim objFile

			If Not(m_boolTimeCritical) or m_boolPrepareTimeCritical Then
				Set objFSO = server.CreateObject("scripting.Filesystemobject")
				'Check existence of the file, and avoid to kill it if it exists
				If objFSO.FileExists(SESSIONS_PATH) Then
					m_boolNewSessionFile = False
					'the file exists so we load it
					if not m_xmlSession.load(SESSIONS_PATH) then	
						Exit Sub
					end if		
				Else
					'the file is missing so we create an empty log file
					m_xmlSession.loadxml("<sessions/>")
					m_boolNewSessionFile = True
				End If
				Set objFile = Nothing
				Set objFSO = Nothing				
			End If
		End Sub

		'+----------------------------------------------------------------------+
		'| drop all old sessions from session file				|
		'+----------------------------------------------------------------------+
		'| Modified: 28.09.2003 by JeS						|
		'+----------------------------------------------------------------------+
		Private Sub DropOldSessions()
			Dim lstNode
			Dim strDate
			Dim nodItem

			If Not(m_boolTimeCritical) Then
				strDate = DateAdd("n", SESSION_EXPIRE * (-1), Now)
				strDate = Year(strDate) & Right("0" & Month(strDate), 2) & Right("0" & Day(strDate), 2) & right("0" & datepart("h", strDate),2) & right("0" & datepart("n", strDate),2)

				Set lstNode = m_xmlSession.selectNodes("/sessions/session[@date < number(" & strDate & ")]")

				For Each nodItem in lstNode
					nodItem.parentNode.removeChild(nodItem)
				Next
			End If

			Set nodItem = Nothing
			Set lstNode = Nothing
		End Sub

		'+----------------------------------------------------------------------+
		'| add attribute to a node						|
		'+----------------------------------------------------------------------+
		'| Modified: 28.09.2003 by JeS						|
		'+----------------------------------------------------------------------+
		Private Sub addAttribute(strAttributeName, strValue, byref nodItem)
			Dim attribNew

			Set attribNew = m_xmlSession.createAttribute(strAttributeName)
			attribNew.value = cstr(strValue)

			nodItem.Attributes.setNamedItem attribNew
		end sub

		'+----------------------------------------------------------------------+
		'| save nodes to session file						|
		'+----------------------------------------------------------------------+
		'| Modified: 28.09.2003 by JeS						|
		'+----------------------------------------------------------------------+
		Private Sub SaveSession()
			Dim attribNew
			Dim nodNew
			Dim lstNode
			Dim nodItem

			If Not(m_boolTimeCritical) Then
				'A check is done to kill all the other sessions of the same user  
				If Len(m_strUserName) > 0 Then
					Set lstNode = m_xmlSession.selectNodes("/sessions/session[@username='" & m_strUserName & "' and @id!='" & m_strSessionID & "']")
					If lstNode.Length > 0 Then
						For Each nodItem in lstNode
							nodItem.parentNode.removeChild(nodItem)
						Next
					End If
				End If

				'We search for a session with the same Session ID			
				Set lstNode = m_xmlSession.selectNodes("/sessions/session[@id='" & m_strSessionID & "']")
				If lstNode.Length = 0 Then
					'No session for this ID				
					set nodNew = m_xmlSession.documentElement.appendChild(m_xmlSession.createElement("session"))
					addAttribute "id", m_strSessionID, nodNew
					addAttribute "username", m_strUserName, nodNew
					addAttribute "password", m_strPassword, nodNew
					addAttribute "groupname", m_strGroupName, nodNew
					addAttribute "userid", m_intUserID, nodNew
					addAttribute "groupid", m_intGroupID, nodNew
					addAttribute "date", m_strDate, nodNew
					addAttribute "localip", m_strLocalIP, nodNew
					addAttribute "remoteip", m_strRemoteIP, nodNew
				Else
					m_xmlSession.SelectSingleNode("/sessions/session[@id='" & m_strSessionID & "']/@username").value = cstr(m_strUserName)
					m_xmlSession.SelectSingleNode("/sessions/session[@id='" & m_strSessionID & "']/@password").value = cstr(m_strPassword)
					m_xmlSession.SelectSingleNode("/sessions/session[@id='" & m_strSessionID & "']/@groupname").value = cstr(m_strGroupName)
					m_xmlSession.SelectSingleNode("/sessions/session[@id='" & m_strSessionID & "']/@userid").value = cstr(m_intUserID)
					m_xmlSession.SelectSingleNode("/sessions/session[@id='" & m_strSessionID & "']/@groupid").value = cstr(m_intGroupID)
					m_xmlSession.SelectSingleNode("/sessions/session[@id='" & m_strSessionID & "']/@date").value = cstr(m_strDate)
				End If
			
				'Save the file
				call SaveXMLFile(SESSIONS_PATH, m_xmlSession.xml)
			End If
		End Sub

		'+----------------------------------------------------------------------+
		'| read session nodes for current user					|
		'+----------------------------------------------------------------------+
		'| Modified: 08.10.2003 by JeS						|
		'+----------------------------------------------------------------------+
		Private Sub GetSession()
			Dim lstNode

			If Not(m_boolTimeCritical) or m_boolPrepareTimeCritical Then
				If (Len(m_strSessionID) = 20 and Not(m_boolNewSessionFile)) then
					Set lstNode = m_xmlSession.selectNodes("/sessions/session[@id='" & m_strSessionID & "']")
					If lstNode.Length > 0 Then
						m_strUserName = lstNode.item(0).attributes.getnameditem("username").text
						m_strGroupName	= lstNode.item(0).attributes.getnameditem("groupname").text
						m_strPassword	= lstNode.item(0).attributes.getnameditem("password").text
						m_intUserID	= lstNode.item(0).attributes.getnameditem("userid").text
						m_intGroupID	= lstNode.item(0).attributes.getnameditem("groupid").text
						m_boolNewSession = False						
					Else
						m_strUserName = ""
						m_strSessionID = GetGuid(6) & "-" & GetGuid(6) & "-" & GetGuid(6)
						m_boolNewSession = True
					End If
				Else
					m_strUserName = ""
					m_strSessionID = GetGuid(6) & "-" & GetGuid(6) & "-" & GetGuid(6)
					m_boolNewSession = True
				End If
				If LenB(Session("username")) > 0 and Session("username") <> m_strUsername Then
					Session("username") = m_strUserName
				End If
				If m_boolPrepareTimeCritical Then
					Session("username") 	= m_strUserName
					Session("groupname")	=  m_strGroupName
				End If
			End If
		End Sub

		'+----------------------------------------------------------------------+
		'| reads session id from cookie						|
		'+----------------------------------------------------------------------+
		'| Modified: 26.09.2003 by JeS						|
		'+----------------------------------------------------------------------+
		Private Function GetCookieSessionID()
			GetCookieSessionID = Request.Cookies(COOKIE_NAME)(COOKIE_VALUE_SESSION)
		End Function

		'+----------------------------------------------------------------------+
		'| writes session id to cookie						|
		'+----------------------------------------------------------------------+
		'| Modified: 26.09.2003 by JeS						|
		'+----------------------------------------------------------------------+
		Private Sub SetCookieSessionID()
			Response.Cookies(COOKIE_NAME)(COOKIE_VALUE_SESSION) = m_strSessionID
			Response.Cookies(COOKIE_NAME).Expires = DateAdd("n", SESSION_EXPIRE, Now)
		End Sub

		'+----------------------------------------------------------------------+
		'| create cookie for automatic log on					|
		'+----------------------------------------------------------------------+
		'| Modified: 26.09.2003 by JeS						|
		'+----------------------------------------------------------------------+
		Public Sub SetRememberCookie(strUser, strPassword)
			Response.Cookies(COOKIE_RMB_NAME)(COOKIE_VALUE_USR) = strUser
			Response.Cookies(COOKIE_RMB_NAME)(COOKIE_VALUE_PWD) = strPassword
			Response.Cookies(COOKIE_NAME).Expires = DateAdd("d", COOKIE_RMB_EXPIRE, Date)
		End Sub

		'+----------------------------------------------------------------------+
		'| reads information from "remember me" cookie				|
		'+----------------------------------------------------------------------+
		'| Modified: 26.09.2003 by JeS						|
		'+----------------------------------------------------------------------+
		Public Function GetRememberCookie(strType)
			Dim strValue

			Select Case LCase(strType)
				case "user":
					strValue = Request.Cookies(COOKIE_RMB_NAME)(COOKIE_VALUE_USR)
					If LenB(strValue) > 0 Then
						GetRememberCookie = strValue
					Else
						GetRememberCookie = ""
					End If
				case "login":
					strValue = Request.Cookies(COOKIE_RMB_NAME)(COOKIE_VALUE_PWD)
					If LenB(strValue) > 0 Then
						GetRememberCookie = strValue
					Else
						GetRememberCookie = ""
					End If			
			End Select
		End Function

		'+----------------------------------------------------------------------+
		'| Write debug information						|
		'+----------------------------------------------------------------------+
		'| Modified: 28.09.2003 by JeS						|
		'+----------------------------------------------------------------------+
		Private Function Debug(strValue)
			If m_boolDebugMode Then 
				Response.Write strValue & "<BR/>"
			End If
		End Function
	End Class
%>