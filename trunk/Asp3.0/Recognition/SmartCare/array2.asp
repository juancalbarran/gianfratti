<%
For Each Item In Session.Contents

	Response.Write Session.Contents(item)
 
Next
%>