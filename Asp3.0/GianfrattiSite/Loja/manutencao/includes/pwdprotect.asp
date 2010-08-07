<!-- #include file="../adm_restrito.asp" -->

<%
Dim usePwdProtect, userUsername, userPassword

'****************************************************************************************
'** Use proteção?															*
'** 1. Sim																				*
'** 2. Não																			*
usePwdProtect = 1															   '*
'****************************************************************************************

'****************************************************************************************
'** Altere o usuário:															*
userUsername = Session("NOME")														   '*	
'****************************************************************************************

'****************************************************************************************
'** Altere a senha:																*
userPassword = Session("SENHA")														   '*
'****************************************************************************************

If Request.Form("submit") = "Entrar" Then
	Session("userUsername") = Request.Form("username") 
	Session("userPassword") = Request.Form("password") 
	Response.Redirect "../index.asp"
End If


If usePwdProtect = 1 And (Session("userUsername") <> userUsername Or Session("userPassword") <> userPassword) Then

%>
	<!-- Powered by EDITOR ASP -->
	<!-- Do Not remove These Headers -->
	<html>
		<head>
			<title>Login - EDITOR ASP</title>
			
			
		<link rel="stylesheet" type="text/css" href="extern/style.css">
		<script src="extern/jscript.js" type="text/javascript"></script>
		
		<script language= "JavaScript">
		<!--Break out of frames
			if (top.frames.length!=0)
			top.location=self.document.location;
			//-->
		</script>
		<style type="text/css">
<!--
.style2 {font-family: Verdana, Arial, Helvetica, sans-serif}
-->
        </style>
		</head>
	
		<body>
		<p><br>
	      <br>
	      <br>
	    </p>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
		<table id="table1" align="center" width="450">
			<tr>
				<td>
					<table id="tdrow2" cellpadding="2" cellspacing="1" border="0" width="100%">
						<tr>
							<td id="tdrow1" >
								<span class="style2"><font size="1">Informe seus dados de acesso:</FONT></span>
							</td>
						</tr>
						<tr id="detail">
							<td align="center" nowrap >
								<p><span class="style2"><font size="1" color="#990000">Confirme seus dados para obter acesso a administração do banco de dados.</FONT></spam></p>
								<form action="includes/pwdprotect.asp" method="post" id="pwd" name="pwd">
								<table width="50%" id="tdrow2" cellpadding="0" cellspacing="1" border="0">
									<tr><td width="10%" height="59" align="left"><span class="style2"><font size="1"><b>Usuário</b></font></spam></td>
									  <td align="center" valign="middle"><input id="textinput" type="text" name="username"></td>
									</tr><tr>
										<td width="10%" align="left">
										<span class="style2"><font size="1"><b>Senha</b></font></spam></td><td align="center" valign="middle"><input type="password" id="textinput" name="password">
										  </td>
									  </tr><tr><tr><td colspan="2" align="center"><input id="button" type="submit" name="submit" value="Entrar">
										</td>
									</tr>
								
</table>
							
						
					</table>
				</td></form>
			</tr>
		</table>
		
		</body>
	</html>
<%
Response.End
End If
%>
