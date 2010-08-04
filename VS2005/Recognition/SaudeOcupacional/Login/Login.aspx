<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login_Login" %>
<html>
<head runat="server">
	<style type="text/css">
		input	{border: 1px solid #2906A2; font-family: Tahoma, Verdana, Arial; font-size: 11px; color: #000000;}
		td		{font-family: Tahoma, Verdana, Arial; font-size: 10px; color: #000000; text-decoration: none;}
		.fundo {filter: progid:DXImageTransform.Microsoft.Gradient(startColorStr= '#E8E8E8' ,endColorStr= '#ffffff' ,gradientType= '1' )}
		.erro  {font-family: Tahoma, Verdana, Arial; font-size: 11px;color: #ff0000;}
	</style>
	<script language="javascript" src="../JS/Funcoes.js"></script>	
	<title>SmartCare - Saude Ocupacional</title>
</head>
<body style="margin:0px;" onload="document.FrmLogin.txtLogin.focus()">
<table  cellpadding="0" cellspacing="0" width="100%" height="100%" border="0" class="fundo">
	<tr>
		<td align="center" valign="middle">
			<table bgcolor="#FFFFFF" cellpadding="0" cellspacing="0" width="400" height="240" border="0"  style="border:1px solid #2906A2">
				<tr>
					<td align="center" height="75"><img src="../Template/Img/SmartCare-Suite.gif" border="0" ></td>
				</tr>
				<tr>
					<td align="center" height="100%">
						<form ID="FrmLogin" name="FrmLogin" runat="server">
						<table cellpadding="0" cellspacing="0" width="100%" height="100%" border="0">
							<tr>
								<td valign="middle">
									<table align="center" cellpadding="0" cellspacing="0" width="80%" border="0">
										<tr>
											<td width="20%" align="center"><img src="../Template/Img/login.gif" align="absmiddle"></td>
											<td width="80%">
												Área de acesso exclusivo aos usuários autorizados.<br>
												Por favor, informe o Login e a Senha de acesso:</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr><td align=center><div id="MsgErro" runat="server" class="erro">&nbsp;</div></td></tr>
							<tr>
								<td align="center">
									<table cellpadding="2" cellspacing="2" border="0">
										<tr>
											<td align="right" style="height: 23px">LOGIN:&nbsp;</td>
											<td><asp:TextBox ID="txtLogin" runat="server" EnableViewState="False" onfocus="this.style.backgroundColor='#E8E8E8'; document.images['imgLogin'].src='../Template/Img/cadeado.gif'" onblur="this.style.backgroundColor='#FFFFFF'; document.images['imgLogin'].src='../Template/Img/blank.gif'" MaxLength="20" Width="170px"></asp:TextBox></td>
											<td><img src="../Template/Img/blank.gif" align="absmiddle" hspace="2" id="imgLogin"></td>
										</tr>
										<tr>
											<td align="right">SENHA:&nbsp;</td>
											<td><asp:TextBox ID="txtSenha" runat="server" EnableViewState="False" TextMode="Password" onfocus="this.style.backgroundColor='#E8E8E8'; document.images['imgSenha'].src='../Template/Img/cadeado.gif'" onblur="this.style.backgroundColor='#FFFFFF'; document.images['imgSenha'].src='../Template/Img/blank.gif'" MaxLength="20" Width="170px"></asp:TextBox></td>
											<td><img src="../Template/Img/blank.gif" align="absmiddle" hspace="2" id="imgSenha"></td>
										</tr>										
										<tr>
											<td colspan="3" align="center"><asp:ImageButton ID="BtnLogar" runat="server" ImageUrl="~/Template/Img/btnAcessar.gif" OnClick="BtnLogar_Click" /></td>
										</tr>
									</table>
                                </td>
							</tr>
						</table>
						</form>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>
