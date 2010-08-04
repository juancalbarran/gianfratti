<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ConfirmarSenha.ascx.cs" Inherits="UserControls_ConfirmarSenha_ConfirmarSenha" %>

	<style type="text/css">
		.TextoLogin		{font-family: Tahoma, Verdana, Arial; font-size: 10px; color: #000000; text-decoration: none;}
		.erro  {font-family: Tahoma, Verdana, Arial; font-size: 11px;color: #ff0000;}
	</style>
	
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
			<table bgcolor="#FFFFFF" cellpadding="0" cellspacing="0" width="400" height="240" border="1"  style="border:1px solid #676767">
				<tr>
					<td align="center" height="75"><img src="../Template/Img/SmartCare-Suite.gif" border="0" ></td>
				</tr>
				<tr>
					<td align="center" style="height: 100%">
						
						<table cellpadding="0" cellspacing="0" width="100%" height="80%" border="0">
							<tr>
								<td valign="middle">
									<table align="center" cellpadding="0" cellspacing="0" width="80%" border="0">
										<tr>
											<td  width="20%" align="center"><img src="../Template/Img/login.gif" align="absmiddle"></td>
											<td class="TextoLogin" width="80%">
												Área de acesso exclusivo aos usuários autorizados.<br>
												Por favor, informe a sua assinatura digital:</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr><td align=center style="height: 16px"><div id="MsgErro" runat="server" class="erro">&nbsp;</div></td></tr>
							<tr>
								<td align="center">
									<table cellpadding="2" cellspacing="2" border="0">
										<tr>
											<td class="TextoLogin" align="right">SENHA:&nbsp;</td>
											<td><asp:TextBox ID="txtSenha" runat="server" EnableViewState="False" TextMode="Password" onfocus="this.style.backgroundColor='#E8E8E8'; document.images['imgSenha'].src='../Template/Img/cadeado.gif'" onblur="this.style.backgroundColor='#FFFFFF'; document.images['imgSenha'].src='../Template/Img/blank.gif'" MaxLength="20" Width="170px"></asp:TextBox></td>
											<td><img src="../Template/Img/blank.gif" align="absmiddle" hspace="2" id="imgSenha"></td>
										</tr>										
										<tr>
											<td colspan="3" align="center"><asp:ImageButton ID="BtnLogar" runat="server" ImageUrl="~/Template/Img/btnAcessar.gif" /></td>
										</tr>
										
									</table>
                                </td>
							</tr>
						</table>
						
					</td>
				</tr>
				<tr>
					<td align="right" class="TextoLogin"><a href="#" onclick="OcultarDivFundo('DivMostraFundo')" >Voltar</a></td>
				</tr>
			</table>

