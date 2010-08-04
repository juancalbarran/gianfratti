<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Atestados.aspx.vb" Inherits="SmartCare.Atestados"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Receituario</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../../../../Bibliotecas/Css/default.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="../../../../Bibliotecas/Funcoes/funcoesNet.js"></script>
	</HEAD>
	<body>
		<form id="Form" method="post" runat="server">
			<FIELDSET><LEGEND id="LEGEND1" align="center" runat="server">&nbsp;Atestato 
					Médico&nbsp;</LEGEND>
				<table width="100%">
					<tr class="zebra_orange1">
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="12%">Nº 
							Atendimento:</td>
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="53%">Paciente:</td>
						<TD class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="5%">Idade:</TD>
						<TD class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="15%">Sexo:</TD>
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="15%">Convênio:</td>
					</tr>
					<tr class="zebra_orange1">
						<td class="texto"><asp:textbox id="Txt_id_Atendimento" runat="server" Width="48px"></asp:textbox><asp:button id="Btn_Buscar" runat="server" ToolTip="Clique para carregar os dados do paciente"
								CausesValidation="False" Text="Buscar" Height="18px" Font-Size="Smaller"></asp:button></td>
						<td class="texto"><asp:label id="Lbl_Paciente" runat="server"></asp:label></td>
						<TD class="texto" align="center"><asp:label id="Lbl_Idade" runat="server"></asp:label></TD>
						<TD class="texto"><asp:checkbox id="Chk_Masculino" runat="server" Text="Masc."></asp:checkbox><asp:checkbox id="Chk_Feminino" runat="server" Text="Fem."></asp:checkbox></TD>
						<td class="texto"><asp:label id="Lbl_Convenio" runat="server"></asp:label>&nbsp;</td>
					</tr>
				</table>
				<table width="100%">
					<tr class="zebra_orange1">
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" colSpan="6">&nbsp;Atestado:</td>
					</tr>
					<tr class="zebra_orange1">
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" colSpan="6"><asp:textbox id="Txt_Texto" runat="server" Width="944px" Height="360px" Font-Bold="True" TextMode="MultiLine"
								BackColor="#E0E0E0"></asp:textbox></td>
					</tr>
				</table>
				<table width="100%">
					<tr class="zebra_orange1">
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="15%">Data Emissão:</td>
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="75%">Médico:</td>
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="10%">CRM:</td>
					</tr>
					<tr class="zebra_orange1">
						<td class="texto" align="left"><asp:label id="Lbl_DtEmissao" runat="server"></asp:label></td>
						<td class="texto"><asp:label id="Lbl_Medico" runat="server"></asp:label></td>
						<td class="texto" align="left"><asp:label id="Lbl_Crm" runat="server"></asp:label></td>
					</tr>
				</table>
				<table width="100%">
					<tr class="zebra_orange1">
						<td class="texto" align="center"><asp:button id="Btn_Gravar" runat="server" Text="Gravar Atestado"></asp:button></td>
					</tr>
				</table>
			</FIELDSET>
			<asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ErrorMessage="Entre com o texto do atestado"
				ControlToValidate="Txt_Texto" Display="None"></asp:RequiredFieldValidator>
			<asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" ErrorMessage="Entre com o numero do atendimento do paciente"
				ControlToValidate="Txt_id_Atendimento" Display="None"></asp:RequiredFieldValidator>
			<asp:ValidationSummary id="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False"></asp:ValidationSummary>
		</form>
	</body>
</HTML>
