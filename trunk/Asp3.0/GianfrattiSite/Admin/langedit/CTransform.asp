<%
	'==============================
	'Shortcut and example function
	'==============================
	Function Transform(pXMLSource, pXSLSource)
		Dim oTrans 
		set oTrans = new CTransform
		
		oTrans.DebugMode = false
		Call oTrans.Sources(pXMLSource, pXSLSource)		
		Call oTrans.Process()
		Transform = oTrans.Content
		set oTrans = nothing
	End Function
	
	
	Function TransformDebug(pXMLSource, pXSLSource)
		Dim oTrans 
		set oTrans = new CTransform
		
		oTrans.DebugMode = true
		Call oTrans.Sources(pXMLSource, pXSLSource)		
		Call oTrans.Process()
		TransformDebug = oTrans.Content & oTrans.Message
		set oTrans = nothing
	End Function
	
	'============================================================
	' This function takes a string and converts to Proper Case.
	' Prototyped by: Brian Shamblen on 3/18/99
	' Added here by: Eduardo Azambuja on November,2003
	'============================================================
	Function PCase(strInput)
		Dim iPosition  ' Our current position in the string (First character = 1)
		Dim iSpace     ' The position of the next space after our iPosition
		Dim strOutput  ' Our temporary string used to build the function's output

		' Set our position variable to the start of the string.
		iPosition = 1
	
		' We loop through the string checking for spaces.
		' If there are unhandled spaces left, we handle them...
		Do While InStr(iPosition, strInput, " ", 1) <> 0
			' To begin with, we find the position of the offending space.
			iSpace = InStr(iPosition, strInput, " ", 1)
		
			' We uppercase (and append to our output) the first character after
			' the space which was handled by the previous run through the loop.
			strOutput = strOutput & UCase(Mid(strInput, iPosition, 1))
		
			' We lowercase (and append to our output) the rest of the string
			' up to and including the current space.
			strOutput = strOutput & LCase(Mid(strInput, iPosition + 1, iSpace - iPosition))

			' Note:
			' The above line is something you may wish to change to not convert
			' everything to lowercase.  Currently things like "McCarthy" end up
			' as "Mccarthy", but if you do change it, it won't fix things like
			' ALL CAPS.  I don't see an easy compromise so I simply did it the
			' way I'd expect it to work and the way the VB command
			' StrConv(string, vbProperCase) works.  Any other functionality is
			' left "as an exercise for the reader!"
		
			' Set our location to start looking for spaces to the
			' position immediately after the last space.
			iPosition = iSpace + 1
		Loop

		' Because we loop until there are no more spaces, it leaves us
		' with the last word uncapitalized so we handle that here.
		' This also takes care of capitalizing single word strings.
		' It's the same as the two lines inside the loop except the
		' second line LCase's to the end and not to the next space.
		strOutput = strOutput & UCase(Mid(strInput, iPosition, 1))
		strOutput = strOutput & LCase(Mid(strInput, iPosition + 1))

		' That's it - Set our return value and exit
		PCase = strOutput
	End Function

%>
<%
	'==============================================================================
	' Permet de faire une transformation entre des données XML et un template XSL.
	'	Les fonctions interressantes sont: la possibilité d'ajouter des parametres 
	'	(addParam) et l'ajout automatique du context querystring en tant que parameter 
	'	XSL.
	'	modified: 13/09/2002
	'==============================================================================
	Class CTransform

		'==============================================================================
		' Membres
		'==============================================================================
		Private m_strContent                                              
		Private m_strError                                                
		Private m_intError 
		Private m_sXMLContext   
		
		Private oXML
		Private oXSL   
		Private oXSLTemplate    
		Private oXSLProcessor                                    

		private m_bDebugMode

		' Constructeur
		Private Sub Class_Initialize
			Set oXML = server.CreateObject("Msxml2.DOMDocument.4.0")
				oXML.async = false
				call oXML.setProperty ("ServerHTTPRequest", true)
				'call oXML.setProperty ("NewParser", true)
			
			Set oXSl = server.CreateObject("Msxml2.FreeThreadedDOMDocument.4.0")
				oXSL.async = false
				call oXSL.setProperty ("ServerHTTPRequest", true)	
				'call oXSL.setProperty ("NewParser", true)	
				
			Set oXSLTemplate  = server.createobject("Msxml2.XSLTemplate.4.0")
			
			' m_bDebugMode = true
				
		End Sub
		
		' Destructeur
		Private Sub Class_Terminate
			Set oXML = Nothing
			Set oXSl = Nothing	    
		End Sub

		'==============================================================================
		' Property en Ecriture
		'==============================================================================

		Property Let DebugMode(bValue)
			m_bDebugMode = bValue
		End Property

		'==============================================================================
		' Property en Lecture
		'==============================================================================
		
		' Contains the result of the transformation
		Property Get Content() : Content = m_strContent : End Property	
		' Contains the XML data
		Property Get XML() : XML = oXML.xml : End Property
		' Contains the XSL template
		Property Get XSL() : XSL = oXSL.xml : End Property
		' Contains the error message
		Property Get Message() : Message = m_strError : End Property
		' Contains the debugmode
		Property Get DebugMode() : DebugMode = m_bDebugMode : End Property	

		'==============================================================================
		' Cette méthode permet d'affecter au processeur les sources XML et XSL
		' Elles peuvent être sous forme d'URL, de chemin relatif/absolu ou de Chaine
		'==============================================================================
		Public Sub Sources(sXMLSource, sXSLSource)
			Dim bLoad : bLoad=false
			
			'on charge le XML
			if mid(sXMLSource,1,1)="<" then
				debug "XML string"
				bLoad = oXML.loadXML(sXMLSource)				 
			elseif mid(sXMLSource,1,4)="http" then
				debug "XML http"
				bLoad = oXML.load(sXMLSource)
			elseif mid(sXMLSource,2,1)=":" then
				debug "XML file"
				bLoad = oXML.load(sXMLSource)
			else
				debug "XML relative file"
				bLoad = oXML.load(Server.Mappath(sXMLSource))
			end if
			
			if (oXML.parseError.errorCode <> 0) or bLoad=false  then
				m_strError = m_strError & "XML parseError on line " & oXML.parseError.line & ", descr: " & oXML.parseError & " " & oXML.parseError.reason & "<br>"
				debug m_strError
				Exit Sub
			End If
			
		
			'on charge le XSL
			if mid(sXSLSource,1,1)="<" then
				bLoad = oXSL.loadXML(sXSLSource)
			elseif mid(sXSLSource,1,4)="http" then
				bLoad = oXSL.load(sXSLSource)
			elseif mid(sXSLSource,2,1)=":" then
				bLoad = oXSL.load(sXSLSource)
			else
				bLoad = oXSL.load(Server.Mappath(sXSLSource))
			end if
			
			if (oXSL.parseError.errorCode <> 0) or bLoad=false then
				m_strError = m_strError & "XSL parseError on line " & oXSL.parseError.line & ", descr: " & oXSL.parseError & " " & oXSL.parseError.reason & "<br>"
				debug m_strError
			End If
			
			'tout a reussi, on crée le XSLTemplate, et le XSLProcessor afin de pouvoir ajouter des parameters
			Set oXSLTemplate.stylesheet = oXSL		
			Set oXSLProcessor = oXSLTemplate.createProcessor()
			oXSLProcessor.input = oXML		
			
			'response.Write (m_strError)
			
		End Sub


		'==============================================================================
		' Effectue la transformation et renvoie le resultat dans la propriété content
		'==============================================================================
		Public Sub Process()
			if lenb(m_strError)>0 then exit sub
			Call AddContext()
			oXSLProcessor.Transform
			m_strContent = oXSLProcessor.output		
		End Sub


		'==============================================================================
		' Add a parameter to the XSL
		'==============================================================================	
		Public Function AddParam(sParamName, sParamValue)
			oXSLProcessor.addParameter sParamName, sParamValue		
		End Function
	  
	  
		'==============================================================================
		' Automatically add the Querystring context as parameters into the XSL
		'==============================================================================	
		Private Sub AddContext()
  			Dim Item
		  	
  			For each Item in request.querystring
  				oXSLProcessor.addParameter Cstr(Item), Cstr(request.querystring(Item))
  			Next  	  	
		End Sub
		
		'==============================================================================
		' Print "sText" to screen if DebugMode = True
		'==============================================================================
		private function debug(sText)
			if m_bDebugMode then Response.Write sText & "<br>"
		end function
	  
	End Class
%>
