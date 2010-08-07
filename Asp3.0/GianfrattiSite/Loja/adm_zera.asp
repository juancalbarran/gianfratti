<!--#include file="adm_restrito.asp"-->
<!--#include file="config.asp"-->
<FONT face=tahoma style=font-size:11px>
<%
Dim SQL_Navegador,RS_Navegador,SQL_Host,RS_Host,SQL_Referencia,RS_Referencia,SQL_Mes,RS_Mes,SQL_Semana,RS_Semana,SQL_Hora,RS_Hora, strSaida

'ATUALIZA A TABELA DE BROWSERS-------------------------
		SQL_Navegador = "UPDATE BROWSERS SET ACESSOS=0 WHERE ACESSOS <> 0"
		Set RS_Navegador = abredb.Execute(SQL_Navegador)
		strSaida = "<li>Tabela Navegador atualizada com sucesso!</li>"
		
'APAGA TUDO DA TABELA DE HOSTS-------------------------
		SQL_Host = "DELETE * FROM HOSTS"
		Set RS_Host = abredb.Execute(SQL_Host)
		strSaida = strSaida & "<li>Tabela Hosts atualizada com sucesso!</li>"
		
'APAGA TUDO DA TABELA DE REFERENCIAS-------------------------
		SQL_Referencia = "DELETE * FROM REFERENCIAS"
		Set RS_Referencia = abredb.Execute(SQL_Referencia)
		strSaida = strSaida & "<li>Tabela Referência atualizada com sucesso!</li>"
		
'ATUALIZA A TABELA DE MESES-------------------------
		SQL_Mes = "UPDATE MESES SET ACESSOS=0 WHERE ACESSOS <> 0"
		Set RS_Mes = abredb.Execute(SQL_Mes)
		strSaida = strSaida & "<li>Tabela Meses atualizada com sucesso!</li>"
		
'ATUALIZA A TABELA DE SEMANA------------------------
		SQL_Semana = "UPDATE SEMANA SET ACESSOS=0 WHERE ACESSOS <> 0"
		Set RS_Semana = abredb.Execute(SQL_Semana)
		strSaida = strSaida & "<li>Tabela Semana atualizada com sucesso!</li>"
		
'ATUALIZA A TABELA DE HORA------------------------
		SQL_Hora = "UPDATE HORAS SET ACESSOS = 0 WHERE ACESSOS <> 0"
		Set RS_Hora = abredb.Execute(SQL_Hora)
		strSaida = strSaida & "<li>Tabela Horas atualizada com sucesso!</li>"
		
'ESCREVE A MENSAGEM DE SAIDA------------------------
		strSaida = strSaida & "<hr size=1 color=#cfcfcf>Os contadores foram resetados com sucesso!"
		strSaida = strSaida & "<P><a href='http://worldbily.cjb.net' target='_blank' style='text-decoration:none'><font face=tahoma size=1 color=#EFEFEF>&copy; Rogério Silva</font></a>"
		response.write strSaida 


set SQL_Navegador  = nothing
set RS_Navegador = nothing
set SQL_Host = nothing
set RS_Host = nothing
set SQL_Referencia = nothing
set RS_Referencia = nothing
set SQL_Mes = nothing
set RS_Mes = nothing
set SQL_Semana = nothing
set RS_Semana = nothing
set SQL_Hora = nothing
set RS_Hora = nothing
set strSaida = nothing
%></font>