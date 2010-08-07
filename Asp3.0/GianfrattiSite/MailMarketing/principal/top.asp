<html>
<head>
	<title>MailMarketing</title>
	<Meta http-equiv='Pragma' content='no-cache'>
	<Meta http-equiv=expires content='Thu, 01 Jan 1970 00:00:00 GMT'>
	<Meta http-equiv='Cache-Control' content='no-store'>
	<Meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>
	
	<link type="text/css" rel="stylesheet" href="/mailMarketing/shared/css/style.css">

</head>
<body topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0">
<table cellpadding="0" cellspacing="0" width="100%" height="100%" border="0" bgcolor="#FFFFFF">
	<tr>
		<td style="border-bottom:1px solid #000000;" height="100%">
			<table cellpadding="0" cellspacing="0" width="100%" border="0">
				<tr>
					<td valign="middle" width="100%">
						<table cellpadding="3" cellspacing="3" border="0" height="55" class="font12Preto" width="100%">
							<tr>
								<td width="10"></td>
								<td width="80" align="center" valign="middle"><img alt="Gerenciador de Grupos de Contato" src="../shared/img/menu/Grupos.gif" border="0" name="imgGrupos" onMouseOver="document.images['imgGrupos'].src='../shared/img/menu/Grupos_over.gif'" onMouseOut="document.images['imgGrupos'].src='../shared/img/menu/Grupos.gif'" style="Cursor:Pointer" onClick="window.parent.FrsPrincipal.location.href='/MailMarketing/grupos/p_grupos.asp?opcao=1&acao=1'"></td>
								<td width="80" align="center" valign="middle"><img alt="Gerenciador de Contatos" src="../shared/img/menu/Contatos.gif" border="0" name="imgContatos" onMouseOver="document.images['imgContatos'].src='../shared/img/menu/Contatos_over.gif'" onMouseOut="document.images['imgContatos'].src='../shared/img/menu/Contatos.gif'" style="Cursor:Pointer" onClick="window.parent.FrsPrincipal.location.href='/MailMarketing/contatos/p_contatos.asp?opcao=1&acao=1'"></td>
								<td width="80" align="center" valign="middle"><img alt="Gerenciador de Eventos" src="../shared/img/menu/Eventos.gif" border="0" name="imgEventos" onMouseOver="document.images['imgEventos'].src='../shared/img/menu/Eventos_over.gif'" onMouseOut="document.images['imgEventos'].src='../shared/img/menu/Eventos.gif'" style="Cursor:Pointer" onClick="window.parent.FrsPrincipal.location.href='/MailMarketing/Eventos/p_eventos.asp?opcao=1&acao=1'"></td>
								<td width="80" align="center" valign="middle"><img alt="Gerenciador de Remetentes" src="../shared/img/menu/Remetentes.gif" border="0" name="imgRemetentes" onMouseOver="document.images['imgRemetentes'].src='../shared/img/menu/Remetentes_over.gif'" onMouseOut="document.images['imgRemetentes'].src='../shared/img/menu/Remetentes.gif'" style="Cursor:Pointer" onClick="window.parent.FrsPrincipal.location.href='/MailMarketing/Remetentes/p_remetentes.asp?opcao=1&acao=1'"></td>
								<td width="100" align="center" valign="middle"><img alt="Gerenciador de Duplicidades" src="../shared/img/menu/duplicidades.gif" border="0" name="imgDuplicidades" onMouseOver="document.images['imgDuplicidades'].src='../shared/img/menu/Duplicidades_over.gif'" onMouseOut="document.images['imgDuplicidades'].src='../shared/img/menu/Duplicidades.gif'" style="Cursor:Pointer" onClick="window.parent.FrsPrincipal.location.href='/MailMarketing/Duplicidades/p_Duplicidades.asp?opcao=1&acao=1'"></td>
								<td width="80" align="center" valign="middle"><img alt="Relatórios de E-mail´s Enviados" src="../shared/img/menu/Relatorios.gif" border="0" name="imgRelatorios" onMouseOver="document.images['imgRelatorios'].src='../shared/img/menu/Relatorios_over.gif'" onMouseOut="document.images['imgRelatorios'].src='../shared/img/menu/Relatorios.gif'" style="Cursor:Pointer" onClick="window.parent.FrsPrincipal.location.href='/MailMarketing/Relatorios/p_relatorios.asp'"></td>
								<td width="80" align="center" valign="middle"><img alt="Gerenciador de Usuários" src="../shared/img/menu/Usuarios.gif" border="0" name="imgUsuarios" onMouseOver="document.images['imgUsuarios'].src='../shared/img/menu/Usuarios_over.gif'" onMouseOut="document.images['imgUsuarios'].src='../shared/img/menu/Usuarios.gif'" style="Cursor:Pointer" onClick="window.parent.FrsPrincipal.location.href='/MailMarketing/Usuarios/p_usuarios.asp?opcao=1&acao=1'"></td>

								<td width="" align="right"><a href="/MailMarketing/login/p_login.asp?Erro=4" class="MenuTop" target="_parent"><img alt="Sair do Sistema" src="../shared/img/menu/Sair.gif" border="0" name="imgSair" onMouseOver="document.images['imgSair'].src='../shared/img/menu/Sair_over.gif'" onMouseOut="document.images['imgSair'].src='../shared/img/menu/Sair.gif'" style="Cursor:Pointer"></a></td>
								
								<td width="10"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td style="border-bottom:1px solid #000000;" valign="top">
			<table cellpadding="0" cellspacing="0" width="100%" height="19" border="0" bgcolor="#2A7BA7">
				<tr>
					<td width="2%">&nbsp;</td>
					<td width="72%" class="Font10Branco" style="text-transform:uppercase">Ben Vindo: <b><%=Ucase(Session("Usuario_NM"))%></b></td>
					<td width="26%" nowrap class="Font10Branco" align="right" style="text-transform:uppercase; padding-right:5px;"><%=WeekDayName(Weekday(date()))%>, <%=day(date())%> DE <%=MonthName(Month(date()))%> DE <%=Year(date())%></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>