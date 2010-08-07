<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<% function Montar_Data_DDMMYYY(data)
'*** Usado qdo o BD informa  D/M/YYYY  ou  M/D/YYYY  OU QUALQUER OUTRA FORMA
			if Month(data) < 10 then
			iMonth = "0" & Month(data)
			else
			iMonth = Month(data)
			end if
			if Day(data) < 10 then
			iDay = "0" & Day(data)
			else
			iDay = Day(data)
			end if
			iYear = Year(data)
			
			Montar_Data_DDMMYYY = iDay & "/" & iMonth & "/" & iYear
end function

hoje=Montar_Data_DDMMYYY(date)
response.write hoje %>


</body>
</html>
