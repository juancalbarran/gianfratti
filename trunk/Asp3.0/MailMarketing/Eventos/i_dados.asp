<%
Id = Request("Id")
If IsNumeric(Id) Then

	sSql = " SELECT * FROM  Eventos Where Evento_CD= " & Id & " Order By Evento_Data, Evento_NM "
	
	Set oRs = RetornaSQL(sSQL)
	
		If Not oRs.Eof Then
		
			Evento_CD			= oRs("Evento_CD")
			Evento_NM			= oRs("Evento_NM")
			Evento_Texto		= oRs("Evento_Texto")
			Remetente_CD		= oRs("Remetente_CD")
			Enviou				= oRs("Enviou")
			
		End If
	
	Set oRs = RetornaSQL("Select Grupo_CD From Eventos_Grupos Where Evento_CD = " & Evento_CD)
	Do Until oRs.Eof
			Grupos = Grupos & oRs.Fields("Grupo_CD") & "," 
		oRs.MoveNext
	Loop
		If Grupos <> "" Then Grupos = Mid(Grupos,1,len(Grupos)-1)

		
	Set oRs = Nothing
	
End If
%>