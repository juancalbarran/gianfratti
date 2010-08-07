<%
	'ERRORS
	CONST ERR001 = "ERR001: The webconfig file need read permission."
	CONST ERR002 = "ERR002: The webconfig file is missing."
	
	'+----------------------------------------------------------------------------------------------+
	'|																								|
	'+----------------------------------------------------------------------------------------------+
	' Todo :: loader en 
	Class CWebConfig
		private m_appSettings()
		private m_modules()
		private m_oXML
		
		'Private Subs
		Private Sub Class_Initialize
			Dim i, nbModules
		
			set m_oXML = server.CreateObject("Msxml2.DOMDocument.4.0")
				m_oXML.async = false
				m_oXML.setProperty "NewParser", true
				
				'Load the WebConfig.xml file, with error handling
				if m_oXML.load(ROOT_PATH & "\webconfig.xml.asp") then
					if err.number=-2147024891 and Err.Source="msxml4.dll" then
						Response.Write err.Description
						Response.Write ERR001		
						Err.Clear
						Response.end
					end if
				else
					Response.Write ERR002
					Response.End
				end if
				
				'-- Load the appsettings
				redim m_appSettings(m_oXML.selectNodes("/configuration/appSettings").length)
				
				'-- Load of the modules
				nbModules = m_oXML.selectNodes("/configuration/modules").length
				redim m_modules(nbModules)
				
				For i=0 to nbModules-1
					set m_modules(i) = new CModule
					Call m_modules(i).Init(m_oXML.selectNodes("/configuration/modules").item(i))
				Next
		End Sub
		
		
		Private Sub Class_Terminate
			Dim i
			For i=LBound(m_modules) to UBound(m_modules)
				set m_modules(1) = nothing					
			Next
			redim m_modules(0)
			set m_oXML = nothing
		End Sub
		
		
		Public property Get Module(index)
			set Module = m_modules(index)
		End property
		
		
		'+--------------------------------------+
		'| Retrieve the value of an appSettings |
		'+--------------------------------------+
		Public Function AppSettings(sKeyName)
			if m_oXML.selectNodes("/configuration/appSettings/add[@key='" & sKeyName & "']/@value").length = 0 then
				AppSettings = ""
			else
				AppSettings = m_oXML.selectSingleNode("/configuration/appSettings/add[@key='" & sKeyName & "']/@value").text
			end if
		End Function
		
		'+--------------------------------------+
		'| Retrieve the value of an table |
		'+--------------------------------------+
		Public Function Table(sTableName)
			if m_oXML.selectNodes("/configuration/modules/module/xml/add[@key='" & sTableName & "']/@value").length = 0 then
				Table = ""
			else
				Table = m_oXML.selectSingleNode("/configuration/modules/module/xml/add[@key='" & sTableName & "']/@value").text
			end if
		End Function

		
	End Class
	
	
	'
	'
	Class CModule
		private m_oNode
		
		Public Sub Init(p_oNode)
			set m_oNode = p_oNode
		End sub
		
		Private sub class_terminate
			set m_oNode = nothing
		end sub
		
	End Class
%>
