<%
Const adExecuteStream = 1024
Dim Conn

Private Sub Conecta()
	Set Conn = CreateObject ("ADODB.connection")
	Conn.open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & server.mappath ("../Shared/mdb/MailMarketing.mdb") & ";Persist Security Info=False"
End Sub

Private Sub DesConecta()

	If IsObject(Conn) Then
		If Conn.State = 1 then
			Conn.Close
			Set Conn = Nothing
		End If	
	End If
	
End Sub

Private Sub ExecuteSQL(p_strSQL)
	Call Conecta()

	Conn.Execute p_strSQL
	
	Call DesConecta()
End Sub


Private Function RetornaSQL(p_strSQL)
	Call Conecta()
	
	Dim objRS
	Set objRS = server.CreateObject("ADODB.Recordset")
	objRS.CursorLocation = 3
	objRS.CursorType = 3

	'Response.Write(p_strSQL) : Response.End()
	objRS.Open p_strSQL, Conn
	objRS.ActiveConnection = nothing
	
	Call DesConecta()
	
	Set RetornaSQL = objRS
	
End Function

Private Function fnString(p_strSQL)
    If IsNull(p_strSQL) Or IsEmpty(p_strSQL) Or Trim(p_strSQL) = "" Then
        fnString = "NULL"
        Exit Function
    End If
    fnString = "'" & Replace(p_strSQL, "'", "''") & "'"
End Function

Private Function fnBoolean(p_bitSQL)
    If Trim(CStr(p_bitSQL)) = "" Or Trim(CStr(p_bitSQL)) = "0" Or Trim(UCase(CStr(p_bitSQL))) = "FALSE" Then
        fnBoolean = 0
        Exit Function
    End If

    fnBoolean = 1
End Function

Private Function fnInteger(p_intSQL)
    If IsNull(p_intSQL) Or IsEmpty(p_intSQL) Or Trim(p_intSQL) = "" Then
        fnInteger = "NULL"
        Exit Function
    End If

    fnInteger = cDbl(Replace(p_intSQL, ",", "."))
End Function

Private Sub VerifyError()
	If err.number <> 0 Then
		VerifyError = "Erro: " & err.Description
	End If
End Sub

%>