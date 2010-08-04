<%@ Language=VBScript %>
<%
dim xml
dim blankXML
dim xsl
dim proc
dim template
dim isEditMode
dim id
dim N
dim NAtt
dim LinkData_filename
dim LinkSelect_filename
dim LinkEdit_filename
dim appPath
appPath = Server.MapPath(".")
LinkData_filename = appPath & "\menu.xml"
LinkSelect_filename = appPath & "\menuEditSelect.xsl"
LinkEdit_filename = appPath & "\menuEdit.xsl"
isEditMode=False
if isEmpty(Application("LinkData")) or Request("refresh") = "true" then
	Response.Write "Loading from disk<br>"	
	
	' load the XML document
	set xml = Server.CreateObject("MSXML2.FreeThreadedDOMDocument.4.0")
	call loadXMLFile(xml, LinkData_filename)
	call updateAppVariable("LinkData", xml)
	
	' load the list XSL file	
	set xsl = Server.CreateObject("MSXML2.FreeThreadedDOMDocument.4.0")
	call loadXMLFile(xsl, LinkSelect_filename)
	set template = Server.CreateObject("MSXML2.XSLTemplate.4.0")
	set template.stylesheet = xsl
	call updateAppVariable("LinkSelect", template)

	' load the edit XSL file	
	set xsl = Server.CreateObject("MSXML2.FreeThreadedDOMDocument.4.0")
	call loadXMLFile(xsl, LinkEdit_filename)
	set template = Server.CreateObject("MSXML2.XSLTemplate.4.0")
	set template.stylesheet = xsl
	call updateAppVariable("LinkEdit", template)
else
	Response.Write "Loading from cache<br>"
	set xml = Application("LinkData")
end if
select case Request.ServerVariables("REQUEST_METHOD")
case "POST"
	id = Request.Form("id")
	select case Request.Form("btnAction")
	case "Delete"
		set N = xml.selectSingleNode("menu/link[@id='" & Request.QueryString("id") & "']")
		if not N is nothing then
			xml.documentElement.removeChild N
		end if
		call saveXMLFile
		call updateAppVariable("LinkData", xml)
		call showList()
	case "Add"
		' get the next id value from the XML file
		set N = xml.selectSingleNode("menu/nextid")
		Response.Write N.text

		' set the id to that value
		id = "link" & N.text
		
		' update the nextid value in the XML file
		N.text = (cstr(cint(N.Text) + 1))
		
		' create a new link node in an empty menu file
		set blankXML = Server.CreateObject("MSXML2.FreeThreadedDOMDocument.4.0")
		blankXML.loadXML  "<?xml version=""1.0""?><menu><link id='" & id & "'" & "  title='' url=''/></menu>"
		
		' show the blank edit form
		call showEditForm(id, blankXML)
	case "Submit"
		set N = xml.selectSingleNode("menu/link[@id='" & cstr(Request.Form("id")) & "']")
		if not N is nothing then			
			N.setAttribute "title", Request.Form("title")
			N.setAttribute "url", Request.Form("url")
			call saveXMLFile()			
			call updateAppVariable("LinkData", xml)
		else
			' create a new node
			set N = xml.createElement("link")
			N.setAttribute "id", cstr(Request.Form("id"))
			N.setAttribute "title", Request.Form("title")
			N.setAttribute "url", Request.Form("url")
			xml.documentElement.appendChild N
		end if
		call showList()
	case "Cancel"
		call showList()
	end select
case "GET"
	if Request.QueryString("id") = "" then
		call showList()
	else
		call showEditForm(Cstr(Request.QueryString("id")), xml)
	end if
end select
sub showEditForm(id, xmldoc)
	set template = Application("LinkEdit")
	set proc = template.createProcessor
	proc.addParameter "id", id
	proc.input=xmldoc
	isEditMode=true
end sub
sub showList()
	set template = Application("LinkSelect")
	set proc = template.createProcessor	
	proc.input=xml
end sub
sub updateAppVariable(varName, value)
	Application.Lock
	if isObject(value) then
		set Application(varname) = value
	else
		Application(varname) = value
	end if
	Application.UnLock
end sub 
sub loadXMLFile(xmldoc, filename)
	if not xmldoc.load(filename) then
		Response.Write "Error loading the file '" & filename & "'.<br>"
		Response.Write "Description: " & xmldoc.parseError.reason & "<br>"
		Response.Write "Line: " & xmldoc.parseError.line & "<br>"
		Response.Write "Line position: " & xmldoc.parseError.linepos & "<br>"
		Response.End
	end if
end sub

sub saveXMLFile()
	xml.save LinkData_filename
end sub
%>

<HTML>
<HEAD>
</HEAD>
<BODY>
<form name="frmEditMenu" method="post">

<%
proc.transform
if isEditMode then
	Response.Write "Edit the title and url and then click Submit.<br>"
	Response.Write "To delete a link, click Delete.<br>"
end if
Response.write proc.output	
%>

</form>
</BODY>
</HTML>

