<%
Dim Conexao
Sub AbreDB
	Set Conexao = Server.CreateObject("ADODB.connection")
	Conexao.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("dbs/atend.mdb") 
End Sub

Sub FechaDB
	Conexao.close
	Set Conexao = Nothing
End Sub

Function OK(str)
	OK = Replace(str,"'","''")
End Function

Function FormataData(sData,sFormato)
	IF isDate(sData) = False THEN Exit Function
	IF sFormato = "full" THEN sFormato = "dd/mm/yyyy hh:nn"
	sDia		= Day( sData )
	sMes		= Month( sData )
	sHoras		= Hour( sData )
	sMinutos	= Minute( sData )
	sSegundos	= Second( sData )
	If sDia <= 9 Then sDia = "0" & sDia
	If sMes <= 9 Then sMes = "0" & sMes
	If sHoras <= 9 Then sHoras = "0" & sHoras
	If sMinutos <= 9 Then sMinutos = "0" & sMinutos
	If sSegundos <= 9 Then sSegundos = "0" & sSegundos
	FormataData = sFormato
	FormataData = Replace(FormataData,"dd",sDia)
	FormataData = Replace(FormataData,"mm",sMes)
	FormataData = Replace(FormataData,"yyyy",Year(sData))
	FormataData = Replace(FormataData,"yy",Right(Year(sData),2))
	FormataData = Replace(FormataData,"hh",sHoras)
	FormataData = Replace(FormataData,"nn",sMinutos)
	FormataData = Replace(FormataData,"ss",sSegundos)
End Function

Function adZero(sText,sQuant)
	If isNull(sText) Then Exit Function
	If Len(sText) > sQuant Then
		adZero = sText
	Else
		adZero = string(sQuant - len(sText), "0") & sText 
	End If
End Function

Function ReplaceTags(sText)
	sText = Replace(sText, "[nome_cliente]", Session("mysCliente"))
	If Hour(Now) < 12 Then
		sText = Replace(sText, "[saudacao_hora]", "Bom dia")
	ElseIf Hour(Now) < 18 Then
		sText = Replace(sText, "[saudacao_hora]", "Bom tarde")
	Else
		sText = Replace(sText, "[saudacao_hora]", "Bom noite")
	End If
	ReplaceTags = sText
End Function

Function setLink(sText)
Dim vetText, i
	If inStr(lCase(sText), "http://") Then
		vetText = Split(sText, " ")
		For i = lBound(vetText) To uBound(vetText)
			If inStr(lCase(sText), "http://") Then
				setLink = setLink & "<a href="""&vetText(i)&""" target=""_blank"">" & vetText(i) & "</a>"
			Else
				setLink = setLink & vetText(i)
			End If
		Next
	Else
		setLink = sText
	End If
End Function
%>
