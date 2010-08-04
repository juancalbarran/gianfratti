<% @Language="VBScript" %>
<%
Response.Buffer = True
Response.Expires = -1000
Set theDoc = Session("doc")
theData = theDoc.GetData()
Response.ContentType = "application/pdf"
Response.AddHeader "content-length", UBound(theData) - LBound(theData) + 1
If Request.QueryString("attachment") <> "" Then
	Response.AddHeader "content-disposition", "attachment; filename=MyPDF.PDF"
Else
	Response.Addheader "content-disposition", "inline; filename=MyPDF.PDF"
End If
Response.BinaryWrite theData
%>