<%
Id = Request("Id")
If IsNumeric(Id) Then

	sSql = " SELECT * FROM  Contatos Where Contato_CD=" & Id & " Order By Contato_NM,  Contato_eMail"
	
	Set oRs = RetornaSQL(sSQL)
	
		If Not oRs.Eof Then
		
			Contato_CD			= oRs("Contato_CD")
			Contato_NM			= oRs("Contato_NM")
			Contato_eMail		= oRs("Contato_eMail")
		End If
	
	Set oRs = RetornaSQL("Select Grupo_CD From Grupos_Contatos Where Contato_CD = " & Contato_CD)
	Do Until oRs.Eof
			Grupos = Grupos & oRs.Fields("Grupo_CD") & "," 
		oRs.MoveNext
	Loop
		If Grupos <> "" Then Grupos = Mid(Grupos,1,len(Grupos)-1)

		
	Set oRs = Nothing
	
End If
%>