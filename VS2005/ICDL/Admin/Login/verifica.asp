<%
'Verifica se o usuario esta logado
IF Session("Logado") <> True Then

	Response.Write "Usuario ou Senha Invalidos"
	Response.end

End IF
%>