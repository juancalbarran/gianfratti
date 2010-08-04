<% @Language="VBScript" %>
<%
On Error Resume Next

Set doc = Session("doc")
If Err <> 0 Then
	Response.Write("<b>WARNING: global.asa failed to create ABCpdf document. ")
	Response.Write("Creating session scope document manually.<br><br></b>")
	Err.Clear
	Set doc = Server.CreateObject("ABCpdf5.Doc")
	If Err <> 0 Then
		Response.Write("<b>Could not create ABCpdf object.<b><br><br>")
		Response.Write("Error: <i>" & Err.Description & "</i><br><br>")
		Response.Write("This error is most likely a result of an installation problem. ")
		Response.Write("Have you run the ABCpdf Installer? Were you logged on as Administrator ")
		Response.Write("when you installed? Check the Application Event Log for any installation errors. ")
		Response.Write("If you need help please mail us at ")
		Response.Write("<a href='mailto:support@websupergoo.com'>support@websupergoo.com</a>")
		Response.End
	End If
	Set Session("doc") = doc
	If Err <> 0 Then
		Response.Write("<b>Could not access session state.<b><br><br>")
		Response.Write("Error: <i>" & Err.Description & "</i><br><br>")
		Response.Write("This error is most likely a result of an IIS configuration problem. ")
		Response.Write("It is specific to the way that the example pages work rather than any ")
		Response.Write("issue with ABCpdf itself. These example pages store an ABCpdf document object in ")
		Response.Write("session state so that you can add items and the state ")
		Response.Write("of your document is preserved as you navigate the site. You need ")
		Response.Write("to have session state enabled for these pages to work. ")
		Response.Write("If you need help please mail us at ")
		Response.Write("<a href='mailto:support@websupergoo.com'>support@websupergoo.com</a>")
		Response.End
	End If
End If

Set doc = Session("doc")
theLicense = doc.License
If Err <> 0 then
	Response.Write("ABCpdf Not Installed.<br><br>")
	Response.End
ElseIf InStr(theLicense, "Trial") Then
	Response.Write("ABCpdf " & theLicense & "<br><br>")
End If
''''''''''''''''''''''''''

%>

<%
Response.Buffer = True
%>

<%
Set theDoc = Session("doc")
theDoc.MediaBox = "A4"
'Left(Esquerdo),Bottom(Rodapé),Width(Largura),Height(Altura)
theDoc.Rect.SetRect 10,1,585,830
theDoc.AddText Request.Form("text")
theURL = "http://fmanes/SmartCare/Modulos/HomeCare/Prontuario/Default.asp?id_Atendimento=127&id_Formulario_Dinamico=1"
If Left(theURL, 4) <> "http" Then theURL = "http://www.google.com/"

theID = theDoc.AddImageUrl(theURL, True, 0, False)
For i = 1 To theDoc.PageCount ' add up to 3 pages
  If theDoc.GetInfo(theID, "Truncated") <> "1" Then Exit For
  theDoc.PageNumber = i
  theDoc.Page = theDoc.AddPage()
  theID = theDoc.AddImageToChain(theID)
Next

'theDoc.Save "c:\mypdfs\pagedhtml.pdf"

'Response.Redirect "default.asp"
%>

