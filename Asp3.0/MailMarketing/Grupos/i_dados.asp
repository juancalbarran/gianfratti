<%
Id = Request("Id")
If IsNumeric(Id) Then

	sSql = " SELECT * FROM  Grupos Where Grupo_CD=" & Id & " Order By Grupo_NM,  Grupo_Descricao"
	
	Set oRs = RetornaSQL(sSQL)
	
		If Not oRs.Eof Then
		
			Grupo_CD			= oRs("Grupo_CD")
			Grupo_NM			= oRs("Grupo_NM")
			Grupo_Descricao			= oRs("Grupo_Descricao")
			
		End If
		
	Set oRs = Nothing
	
End If
%>