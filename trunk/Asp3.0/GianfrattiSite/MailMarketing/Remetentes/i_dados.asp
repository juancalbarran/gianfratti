<%
Id = Request("Id")
If IsNumeric(Id) Then

	sSql = " SELECT * FROM  Remetentes Where Remetente_CD=" & Id & " Order By Remetente_NM"
	
	Set oRs = RetornaSQL(sSQL)
	
		If Not oRs.Eof Then
		
			Remetente_CD			= oRs("Remetente_CD")
			Remetente_NM			= oRs("Remetente_NM")
			Remetente_eMail			= oRs("Remetente_eMail")
			Remetente_SMTP			= oRs("Remetente_SMTP")
			
		End If
		
	Set oRs = Nothing
	
End If
%>