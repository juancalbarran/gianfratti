<%
Id = Request("Id")
If IsNumeric(Id) Then

	sSql = " SELECT * FROM  Usuarios Where Usuario_CD=" & Id & " Order By Usuario_NM,  Usuario_eMail"
	
	Set oRs = RetornaSQL(sSQL)
	
		If Not oRs.Eof Then
		
			Usuario_CD			= oRs("Usuario_CD")
			Usuario_NM			= oRs("Usuario_NM")
			Usuario_eMail		= oRs("Usuario_eMail")
			Usuario_Login		= oRs("Usuario_Login")
			Usuario_Senha		= oRs("Usuario_Senha")
		End If
		
	Set oRs = Nothing
	
End If
%>