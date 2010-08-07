<%
Session.LCID = 1033

calD = Request("dia")
If calD = "" Then calD = Day(Now)
calM = Request("mes")
If calM = "" Then calM = Month(Now)
calA = Request("ano")
If calA = "" Then calA = Year(Now)

calRequestData = calD & "/" & calM & "/" & calA

If Month(calRequestData) < 12 Then
	calMes = Month(calRequestData) + 1
	If calMes < 10 Then calMes = "0" & calMes
	calData = "01/" & calMes & "/" & Year(calRequestData)
Else
	calData = "01/01/" & Year(calRequestData) + 1
End If

calPrimeiroDia = "01/" & Month(calRequestData) & "/" & Year(calRequestData)
calUltimoDia = DateAdd("d", -1, calData)

With Response
	.Write "<table width='150' cellpadding='2' cellspacing='2' style='border: 1 solid #F2F2F2'><tr bgcolor='#F5F5F5'>"
	.Write "<td><b><a href='"
	If calM = 1 Then
		.Write Request.ServerVariables("script_name") &"?dia="& calD &"&mes="& 12 &"&ano="& calA - 1
	Else
		.Write Request.ServerVariables("script_name") &"?dia="& calD &"&mes="& calM - 1 &"&ano="& calA
	End If
	.Write "'>&laquo;</a></b></td>"
	.Write "<td align='center' colspan='5'>"
	.Write "<b>&nbsp;"& uCase(Mid(MonthName(calM),1,1)) & Mid(MonthName(calM),2) & "&nbsp;-&nbsp;" & calA &"&nbsp;</b>"
	.Write "</td>"
	.Write "<td align='right'><b><a href='"
	If calM = 12 Then
		.Write Request.ServerVariables("script_name") &"?dia="& calD &"&mes="& 1 &"&ano="& calA + 1
	Else
		.Write Request.ServerVariables("script_name") &"?dia="& calD &"&mes="& calM + 1 &"&ano="& calA
	End If
	.Write "'>&raquo;</a></b></td></tr>"
	.Write "<tr bgcolor='#F5F5F5'>"
	For i = 1 to 7
		.Write "<td align='center'><b>"&uCase(Mid(WeekDayName(i),1,1))&"</b></td>"
	Next
	.Write "<tr>"
	For i = 1 To DatePart("w", calPrimeiroDia) - 1
		.Write "<td></td>"
	Next
	
	diaSemana = DatePart("w", calPrimeiroDia)
	
	For i = Day(calPrimeiroDia) To Day(calUltimoDia)
		If diaSemana = 8 Then
			diaSemana = 1
			.Write "</tr>"
		ElseIf diaSemana = 1 Then
			.Write "<tr>"
		End If
		diaSemana = diaSemana + 1
		If i <> cInt(calD) Then
			.Write "<td align='center'><a href='"& Request.ServerVariables("script_name") &"?dia="& i &"&mes="& calM &"&ano="& calA &"'>" & i & "</a></td>"
		Else
			.Write "<td align='center'><b>" & i & "</b></td>"
		End If
	Next
	.Write "</table>"
End With
%>
