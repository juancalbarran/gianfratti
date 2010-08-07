<%
response.buffer  = true
'Primeiramente vamos salvar as características
browser = Request.ServerVariables("HTTP_USER_AGENT") 
historico = Request.ServerVariables("HTTP_REFERER")
ip = Request.ServerVariables("REMOTE_ADDR") 
hora = Hour(Now)
semana = Weekday(Now)
mes = Month(Now)

'Vamos tranformar o nome do Browser como temos no BD
IF Instr(browser,"MSIE") <> 0 Then
  browser = "MS Internet Explorer"
ELSE
  browser = "Netscape"
END IF

SQL_Browser = "update browsers set acessos = acessos + 1 where browser = '"&browser&"' "
Set RS_Browser = abredb.Execute(SQL_Browser)

SQL_Historico = "insert into referencias(referencia) values('"&historico&"')"
Set RS_Historico = abredb.Execute(SQL_Historico)

SQL_IP = "insert into hosts(host) values('"&ip&"')"
Set RS_IP = abredb.Execute(SQL_IP)

SQL_Hora = "update horas set acessos = acessos + 1 where hora = '"&hora&"' "
Set RS_Hora = abredb.Execute(SQL_Hora)

SQL_Semana = "update semana set acessos = acessos + 1 where dia_semana = '"&semana&"' "
Set RS_Semana = abredb.Execute(SQL_Semana)

SQL_Mes = "update meses set acessos = acessos + 1 where mes = '"&mes&"' "
Set RS_Mes = abredb.Execute(SQL_Mes)
%>