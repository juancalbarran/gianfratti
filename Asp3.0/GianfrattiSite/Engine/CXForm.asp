<%
	'This class allow the manipulation of a node, produced by an XForm
	Class CXForm
		private m_sFilePath
		private m_sXPath
		private m_sNode
		private m_oXMLFile
		private m_oXMLNode
		private m_bDebugMode
		
		'Constructor
		Private Sub Class_Initialize()
			'm_bDebugMode = true
			Set m_oXMLFile = server.CreateObject(MSXML_PROGID) : m_oXMLFile.async = False
			Set m_oXMLNode = server.CreateObject(MSXML_PROGID) : m_oXMLNode.async = False
		End Sub
		
		'Destructor
		Private Sub Class_Terminate()
			Set m_oXMLFile = nothing
			Set m_oXMLNode = nothing
		End Sub
		
		
		'
		' PROPERTIES
		'
		
		property let File(sValue) : m_sFilePath = sValue : end property
		property let XPath(sValue) : m_sXPath = sValue : end property
		property let Node(sValue) : m_sNode = sValue : end property
		
		
		'
		' PUBLIC METHODS
		'
		
		
		' add node in the file, depending of the xpath
		Public function Add()
			Dim oListNode, oNewNode, newAtt
			Add = false
			
			if LoadXMLFile() and loadXMLNode() then			
				'Check that the xPath provided exists
				Set oListNode = m_oXMLFile.selectNodes(m_sXPath)
				If oListNode.length=0 Then
					debug ("Error : The node " & m_sXPath & " has not been found in the file " & m_sFilePath) & ", you can add it manually to correct this error."
					Exit function
				End if
				set oListNode = nothing
				
				'we append some metadata to the new node
				'Set newAtt = m_oXMLNode.createAttribute("date")
				'newAtt.value = cstr(Year(Now) & Right("0" & Month(Now), 2) & Right("0" & Day(Now), 2) & Right("0" & Hour(Now), 2) & Right("0" & Minute(Now), 2))
				'm_oXMLNode.documentElement.Attributes.setNamedItem newAtt
				
				'Set newAtt = m_oXMLNode.createAttribute("owner")
				'newAtt.value = cstr(sOwner)
				'm_oXMLNode.documentElement.Attributes.setNamedItem newAtt

				
				' We append the new node in the right place and save the file
				Set oNewNode = m_oXMLFile.SelectSingleNode(m_sXPath)			
				call oNewNode.appendChild(m_oXMLNode.documentElement.cloneNode(true))							
				
				call Save()
				Add = true
			end if			
		End function
		
		
		'+--------------------------------------------------------------------+
		'| Delete the selected node
		'+--------------------------------------------------------------------+
		Public function Delete()
			Dim oNode, oNodeParent, oListNode, oNewNode 
			Delete = False
					
			if LoadXMLFile() then			
				'Check that the xPath provided exists
				Set oListNode = m_oXMLFile.selectNodes(m_sXPath)
					If oListNode.length=0 Then
						debug ("Error : The node " & m_sXPath & " has not been found in the file " & m_sFilePath) & ", you can add it manually to correct this error."
						Exit function
					End if
				set oListNode = nothing
			
				'delete the node
				set oNode = m_oXMLFile.SelectSingleNode(m_sXPath)
					set oNodeParent = oNode.parentNode
						oNodeParent.removeChild(oNode)
					set oNodeParent = nothing
				set oNode = nothing
							
				call Save()
				Delete = true
			end if
		end function
		
		
		' update file with node
		public function Update()
			Dim oNode, oNodeParent, oListNode, oUpdateNodeNode, oNewNode
			Dim Child, Parameter, XpathParam, newAtt, oCdata
			
			Update = false
			
			if LoadXMLFile() and loadXMLNode() then					
				'Check that the xPath exists
				Set oListNode = m_oXMLFile.selectNodes(m_sXPath)
				If oListNode.length=0 Then
					debug ("Error : The node " & m_sXPath & " has not been found in the file " & m_sFilePath) & ", you can add it manually to correct this error."
					Exit function
				End if
				set oListNode = nothing
				
				'Response.Write m_oXMLNode.xml
				'Response.End
				
				'Attributes update or add
				for each Parameter in m_oXMLNode.documentelement.attributes
					debug Parameter.name & " : " & Parameter.value & "<br>"					
					Set oListNode = m_oXMLFile.selectNodes(m_sXPath & "/@" & Parameter.name)
					If oListNode.length=0 Then
						'we add it cause the param is missing
						Set oNode = m_oXMLFile.selectSingleNode(m_sXPath)
						Set newAtt = m_oXMLFile.createAttribute(Parameter.name)
						newAtt.value = cstr(CleanParameter(Parameter.value))
						oNode.Attributes.setNamedItem newAtt
						debug "parameter " & Parameter.name & " added."
					Else
						'we update it cause the param is present
						oListNode.item(0).value = CleanParameter(Parameter.value)
					End if
				next
				
				'child update or add
				for each Child in m_oXMLNode.documentelement.childNodes
					debug Child.nodename & " : " & Child.text & "<br>"
					Set oListNode = m_oXMLFile.selectNodes(m_sXPath & "/" & Child.nodename)
					If oListNode.length=0 Then
						'we add it cause the param is missing
						Set oNode = m_oXMLFile.selectSingleNode(m_sXPath)
						set oNewNode = m_oXMLFile.createElement(Child.nodename)
						Set oCdata = m_oXMLFile.createCDATASection(cstr(Child.text))
						oNewNode.appendChild(oCdata)
						oNode.appendChild(oNewNode)
											
						debug "Node " & Child.nodename & " added."
					Else
						'we update it cause the param is present
						oListNode.item(0).FirstChild.text = cstr(Child.text)
					End if
				next
				
				call Save()
				Update = true
				set oListNode = nothing
			end if							
		end function
		
		
		
		public function Save()
			call SaveXMLFile(m_sFilePath, m_oXMLFile.xml)
		end function
		
		'
		' PRIVATE
		'
		
		
		
		private function LoadXMLFile()
			'load xml file	
			debug "Loading XML file: " & m_oXMLFile.load(m_sFilePath)			
			if (m_oXMLFile.parseError.errorCode <> 0)  then
				debug "-------------------------------------------"
				debug "XML parseError"
				debug "line " & m_oXMLFile.parseError.line
				debug "reason " & m_oXMLFile.parseError.reason
				debug "-------------------------------------------"
				LoadXMLFile = false
				Exit function
			Else
				LoadXMLFile = true
			End If
		end function
		
		
		private function loadXMLNode()
			debug "Loading XML Node: " & m_oXMLNode.loadXML(m_sNode)			
			if (m_oXMLNode.parseError.errorCode <> 0)  then
				debug "-------------------------------------------"
				debug "XML parseError"
				debug "line " & m_oXMLNode.parseError.line
				debug "reason " & m_oXMLNode.parseError.reason
				debug "-------------------------------------------"
				loadXMLNode = false
				Exit function
			else
				loadXMLNode = true
			End If
		end function
		
		
		'''-------------------------------------------
		''' Print some text if debug mode is activated
		'''-------------------------------------------
		private Function Debug(sValue)
			if m_bDebugMode then Response.Write sValue & "<br>"
		End Function		
	End CLass
%>