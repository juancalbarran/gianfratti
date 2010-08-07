<%
sub setAppVariable(varName, value)
	Application.Lock
	if isObject(value) then
		set Application(varname) = value
	else
		Application(varname) = value
	end if
	Application.Unlock
end sub


function loadXML(filename)
	dim xml
	set xml = Server.CreateObject(MSXML_PROGID2)
	xml.async = False
	xml.validateOnParse=false
	xml.resolveExternals=false
	xml.preserveWhiteSpace=True
	
	'if msxml4 then we can use the new parser
	if MSXML4 then 
		call xml.setProperty("NewParser", True )
		xml.validateOnParse=false
		xml.resolveExternals=false
		xml.preserveWhiteSpace=True
	end if


	if not xml.load(filename) then
		'handle this error
		call xmlError(xml, "Unable to load the data file.")
	else
		set loadXML = xml
	end if
end function


function loadXMLText(xmlText)
	dim xml
	set xml = Server.CreateObject(MSXML_PROGID2)
	if MSXML4 then call xml.setProperty("NewParser", True )
	if not xml.loadXML(xmlText) then
		call xmlError(xml, "Unable to load the XML string '" & left(xmlText, 300) & "...'")
	else
		set loadXMLText = xml
	end if
end function		

function cacheXSLTemplate(filename, templateName)
	dim xslTemplate
	dim xsl
	set xsl = loadXML(filename)
	set xslTemplate = server.CreateObject(MSXML_PROGID3)
	set xslTemplate.stylesheet = xsl
	call setAppVariable(templateName, xslTemplate)
	set cacheXSLTemplate = xslTemplate
end function

function HTMLTransform(xmlDoc, xslTemplate)
	dim proc 
	set proc = xslTemplate.createProcessor()
	proc.input = xmlDoc
	proc.transform
	HTMLTransform = proc.output
	set proc = nothing
end function

sub xmlError(xml, errmsg)
	Response.Write errmsg & "<br>"
	Response.Write "Reason: " & xml.parseerror.reason & "<br>"
	Response.Write "Line: " & xml.parseerror.line & "<br>"
	Response.Write "Line Pos: " & xml.parseerror.linePos & "<br>"
	Response.end
end sub

%>
