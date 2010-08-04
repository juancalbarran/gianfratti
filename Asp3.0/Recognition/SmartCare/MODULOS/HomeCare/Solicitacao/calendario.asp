<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<%
Session.LCID = 1046


'FUNÇÃO IMPORTANTE.
'Função responsavel por receber uma data do calendario e verificar e a data contem registros no banco de dados
''Esta função é chamada no calendario.asp para verificar se a dara do calendario é igual a data que contem registros no banco de dados, se for igual entao o dia é pintado de outra cor
Function BuscaDataBancoDados(Data)

	'[CONEXÃO COM O BANCO DE DADOS]
	set Conn = Server.CreateObject( "ADODB.Connection" )
	Conn.CursorLocation = 3 'adUserClient
	Conn.Open application("connstring")

	SQL	=	"SELECT  CONVERT(CHAR, Data_Cadastro_Solicitacao, 103) AS Data_Cadastro_Solicitacao " &_
			"FROM dbo.HomeCare_Solicitacao_Atendimento " &_ 
			"WHERE (CONVERT(CHAR, Data_Cadastro_Solicitacao, 103) = '"&Data&"') And id_Solicitacao_Status = 1 " 
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
				
					BuscaDataBancoDados = Rs("Data_Cadastro_Solicitacao")

				End If
				Rs.Close
				Set Rs = Nothing

End Function


Function GetDaysInMonth(iMonth, iYear)
	Dim dTemp
	dTemp = DateAdd("d", -1, DateSerial(iYear, iMonth + 1, 1))
	GetDaysInMonth = Day(dTemp)
End Function

Function GetWeekdayMonthStartsOn(dAnyDayInTheMonth)
	Dim dTemp
	dTemp = DateAdd("d", -(Day(dAnyDayInTheMonth) - 1), dAnyDayInTheMonth)
	GetWeekdayMonthStartsOn = WeekDay(dTemp)
End Function

Function SubtractOneMonth(dDate)
	SubtractOneMonth = DateAdd("m", -1, dDate)
End Function

Function AddOneMonth(dDate)
	AddOneMonth = DateAdd("m", 1, dDate)
End Function

Dim dDate     ' Date we're displaying calendar for
Dim iDIM      ' Days In Month
Dim iDOW      ' Day Of Week that month starts on
Dim iCurrent  ' Variable we use to hold current day of month as we write table
Dim iPosition ' Variable we use to hold current position in table

If IsDate(Request.QueryString("date")) Then
	dDate = CDate(Request.QueryString("date"))
Else
	If IsDate(Request.QueryString("month") & "/" & Request.QueryString("day") & "/" & Request.QueryString("year")) Then
		dDate = CDate(Request.QueryString("month") & "/" & Request.QueryString("day") & "/" & Request.QueryString("year"))
	Else
		dDate = Date()

		If Len(Request.QueryString("month")) <> 0 Or Len(Request.QueryString("day")) <> 0 Or Len(Request.QueryString("year")) <> 0 Or Len(Request.QueryString("date")) <> 0 Then
			Response.Write "The date you picked was not a valid date.  The calendar was set to today's date.<BR><BR>"
		End If

	End If
End If

iDIM = GetDaysInMonth(Month(dDate), Year(dDate))
iDOW = GetWeekdayMonthStartsOn(dDate)

%>
<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 width="100">
  <TR>
<TD>
      <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=1 BGCOLOR=#99CCFF width="100%">
        <TR>
		<TD BGCOLOR=#000099 ALIGN="center" COLSPAN=7>
			<TABLE WIDTH=100% BORDER=0 CELLSPACING=0 CELLPADDING=0>
				<TR>
					<TD ALIGN="right"><A HREF="default.asp?date=<%= ArrumaData(SubtractOneMonth(dDate)) %>"><FONT COLOR=#FFFF00 SIZE="1">&lt;&lt;</FONT></A></TD>
					<TD ALIGN="center"><FONT COLOR=#FFFF00 size="1"><B><%= MonthName(Month(dDate)) & "  " & Year(dDate) %></B></FONT></TD>
					<TD ALIGN="left"><A HREF="default.asp?date=<%= ArrumaData(AddOneMonth(dDate)) %>"><FONT COLOR=#FFFF00 SIZE="1">&gt;&gt;</FONT></A></TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
	<TR>
		<TD ALIGN="center" BGCOLOR=#0000CC><FONT COLOR=#FFFF00 size="1"><B>Do</B></FONT><BR></TD>
		<TD ALIGN="center" BGCOLOR=#0000CC><FONT COLOR=#FFFF00 size="1"><B>Seg</B></FONT><BR></TD>
		<TD ALIGN="center" BGCOLOR=#0000CC><FONT COLOR=#FFFF00 size="1"><B>Ter</B></FONT><BR></TD>
		<TD ALIGN="center" BGCOLOR=#0000CC><FONT COLOR=#FFFF00 size="1"><B>Qua</B></FONT><BR></TD>
		<TD ALIGN="center" BGCOLOR=#0000CC><FONT COLOR=#FFFF00 size="1"><B>Qui</B></FONT><BR></TD>
		<TD ALIGN="center" BGCOLOR=#0000CC><FONT COLOR=#FFFF00 size="1"><B>Sex</B></FONT><BR></TD>
		<TD ALIGN="center" BGCOLOR=#0000CC><FONT COLOR=#FFFF00 size="1"><B>Sag</B></FONT><BR></TD>
	</TR>
<%
' Write spacer cells at beginning of first row if month doesn't start on a Sunday.
If iDOW <> 1 Then
	Response.Write vbTab & "<TR>" & vbCrLf
	iPosition = 1
	Do While iPosition < iDOW
		Response.Write vbTab & vbTab & "<TD><Font size='1'>&nbsp;</font></TD>" & vbCrLf
		iPosition = iPosition + 1
	Loop
End If

' Write days of month in proper day slots
iCurrent = 1
iPosition = iDOW
Do While iCurrent <= iDIM
	' If we're at the begginning of a row then write TR
	If iPosition = 1 Then
		Response.Write vbTab & "<TR>" & vbCrLf
	End If

'************* Inicio codigo para comparar datas do calendario com a dos registros no bando de dados para pintar de cores diferentes]
'************  Este trecho de codigo não altera em nada o calendario, caso queira voltar com o calendario original basta apagar

		'Monta a data atual do calendario. Usei a função StrZero porque a data estava vindo no formato 1/7/2005 e eu quero 01/07/2005
		DataCalendario = StrZero(iCurrent,2) & "/" & StrZero(Month(dDate),2) & "/" & Year(dDate)
		'Chama a função que ira bucar a data no banco de dados e comparar com a do calendario para pintar de uma cor diferente
		DataBancoDados = BuscaDataBancoDados(DataCalendario)
		If Trim(DataBancoDados) = Trim(DataCalendario) Then 'Compara se a data do banco de dados é igual a data do calendario
			Cor_Destaque = "BGCOLOR=#FF2626" 'Se for igual entao pinta de vermelho para ficar em destaque
		Else 
			Cor_Destaque = "" 'Senao for igual entao não coloca uma cor
		End If

'************ Fim do codigo de comparação de datas
	
	' If the day we're writing is the selected day then highlight it somehow.
	If iCurrent = Day(dDate) Then
		Response.Write vbTab & vbTab & "<TD ALIGN='center' BGCOLOR=#00FFFF><FONT SIZE=""1""><B>" & "<a href='default.asp?date=" & StrZero(iCurrent,2) & "/" & StrZero(Month(dDate),2) & "/" & Year(dDate) & "'>"&iCurrent&"</a></B></FONT></TD>" & vbCrLf
	Else
		Response.Write vbTab & vbTab & "<TD ALIGN='center' "&Cor_Destaque& "><A HREF=""default.asp?date=" & StrZero(iCurrent,2) & "/" & StrZero(Month(dDate),2) & "/" & Year(dDate) & """><FONT SIZE=""1"">" & iCurrent & "</FONT></A></TD>" & vbCrLf
	End If
	
	' If we're at the endof a row then write /TR
	If iPosition = 7 Then
		Response.Write vbTab & "</TR>" & vbCrLf
		iPosition = 0
	End If
	
	' Increment variables
	iCurrent = iCurrent + 1
	iPosition = iPosition + 1
Loop

' Write spacer cells at end of last row if month doesn't end on a Saturday.
If iPosition <> 1 Then
	Do While iPosition <= 7
		Response.Write vbTab & vbTab & "<TD><Font size='1'>&nbsp;</font></TD>" & vbCrLf
		iPosition = iPosition + 1
	Loop
	Response.Write vbTab & "</TR>" & vbCrLf
End If
%>
</TABLE>
</TD>
</TR>
</TABLE>


