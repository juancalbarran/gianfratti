<%

Sub WriteFakeButton( sRef, sText )
	Response.Write " <b><a href=""" & sRef & """" & "><font color=#000066 size=""2"" face=""Arial,Helvetica"">" & "  " & sText &  "</font></a></b>"
End Sub


Sub WriteMenuItem( sRef, sText )
	Response.Write "• <a href=""" & sRef & """" & "><font color=#000066 size=""1"" face=""Arial,Helvetica"">" & "  " & sText &  "</font></a><br>"
End Sub

Sub AdAdminWriteMenu
	Response.Write "<b>Menu AdMentor</b><br>"
	WriteMenuItem 	"adminaccount.asp?id=" & Session("userfldauto"), "Minha Conta"
	If Session("admin") = True Then
		WriteMenuItem 	"adminadvs.asp", "Administração de Anunciantes"
	End If
	WriteMenuItem 	"adminbanners.asp", "Banners"
	If Session("admin") = True Then
		WriteMenuItem 	"adminfarms.asp", "Tipo"
		WriteMenuItem 	"adminzones.asp", "Categoria"
		WriteMenuItem 	"genhtml.asp", "Gerar código HTML"
	End If
	WriteMenuItem 	"checkstats.asp", "Estatísticas da Conta"
	WriteMenuItem 	"showclickslog.asp", "Exibir log de cliques"
	WriteMenuItem 	"logout.asp", "Efetuar Logoff"
	If Session("admin") = True Then
		WriteMenuItem 	"http://www.aspcode.net", "Suporte AdMentor"
	End If
End Sub

Sub AdAdminWriteMenu2
	Response.Write "<option value=""password.asp"">Gerenciar conta</option>"
	If Session("admin") = True Then
		Response.Write "<option value=""adminadvs.asp"">Administrar Anunciantes</option>"
		Response.Write "<option value=""adminbanners.asp"">Administrar banners</option>"
		Response.Write "<option value=""adminfarms.asp"">Administrar tipos</option>"
		Response.Write "<option value=""adminzones.asp"">Administrar Categoria</option>"
		Response.Write "<option value=""genhtml.asp"">Gerar HTML</option>"
	End If
	Response.Write "<option value=""checkstats.asp"">Estatísticas</option>"
	Response.Write "<option value=""logout.asp"">Logout</option>"
End Sub

%>