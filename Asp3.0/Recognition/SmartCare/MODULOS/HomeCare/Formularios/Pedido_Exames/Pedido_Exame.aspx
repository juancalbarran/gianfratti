<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Pedido_Exame.aspx.vb" Inherits="SmartCare.Pedido_Exame" uiCulture="pt-BR"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Pedido_Exame</title>
		<meta content="False" name="vs_showGrid">
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../../../../Bibliotecas/Css/default.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="../../../../Bibliotecas/Funcoes/funcoesNet.js"></script>
	</HEAD>
	<body bottomMargin="0" leftMargin="0" topMargin="0" rightMargin="0" MS_POSITIONING="GridLayout">
		<form id="Form" method="post" runat="server">
			<FIELDSET><LEGEND id="LEGEND1" align="center" runat="server">&nbsp;Pedido de 
					Exames&nbsp;</LEGEND>
				<table width="100%">
					<tr class="zebra_orange1">
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="12%">Nº 
							Atendimento:</td>
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="43%">Paciente:</td>
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="45%">Convênio:</td>
					</tr>
					<tr class="zebra_orange1">
						<td class="texto"><asp:textbox id="Txt_id_Atendimento" runat="server" Width="48px"></asp:textbox><asp:button id="Btn_Buscar" runat="server" ToolTip="Clique para carregar os dados do paciente"
								CausesValidation="False" Text="Buscar" Height="18px" Font-Size="Smaller"></asp:button></td>
						<td class="texto"><asp:label id="Lbl_Paciente" runat="server"></asp:label></td>
						<td class="texto"><asp:label id="Lbl_Convenio" runat="server"></asp:label>&nbsp;</td>
					</tr>
				</table>
				<table width="100%">
					<tr class="zebra_orange1">
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="15%">Sexo:</td>
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="5%">Idade:</td>
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="50%">Material:
						</td>
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="30%">Coleta:</td>
					</tr>
					<tr class="zebra_orange1">
						<td class="texto" style="HEIGHT: 22px"><asp:checkbox id="Chk_Masculino" runat="server" Text="Masc."></asp:checkbox><asp:checkbox id="Chk_Feminino" runat="server" Text="Fem."></asp:checkbox></td>
						<td class="texto" style="HEIGHT: 22px" align="center"><asp:label id="Lbl_Idade" runat="server"></asp:label></td>
						<td class="texto" style="HEIGHT: 22px"><asp:textbox id="Txt_Material" runat="server" Width="464px"></asp:textbox></td>
						<td class="texto" style="HEIGHT: 22px"><asp:radiobuttonlist id="RBL_Tipo_Coleta" runat="server" RepeatDirection="Horizontal" CssClass="texto">
								<asp:ListItem Value="Urg&#234;ncia">Urg&#234;ncia</asp:ListItem>
								<asp:ListItem Value="Hoje">Hoje</asp:ListItem>
								<asp:ListItem Value="Amanh&#227;">Amanh&#227;</asp:ListItem>
								<asp:ListItem Value="Marcar">Marcar</asp:ListItem>
							</asp:radiobuttonlist></td>
					</tr>
					<tr class="zebra_orange1">
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" colSpan="6">&nbsp;Informações 
							Clínicas:</td>
					</tr>
					<tr class="zebra_orange1">
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" colSpan="6"><asp:textbox id="Txt_Info_Clinicas" runat="server" Width="944px" Height="88px" Font-Bold="True"
								TextMode="MultiLine" BackColor="#E0E0E0"></asp:textbox></td>
					</tr>
				</table>
				<table id="TABLE1" width="100%">
					<tr class="zebra_orange1">
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="50%" colSpan="2">EXAMES:</td>
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="50%" colSpan="2">EXAMES:</td>
					</tr>
					<tr class="zebra_orange1">
						<td class="texto" align="center" width="3%">01-</td>
						<td class="texto" style="WIDTH: 310px"><asp:textbox id="Exame_1" runat="server" Width="440px"></asp:textbox></td>
						<td align="center" width="3%">11-</td>
						<td class="texto"><asp:textbox id="Exame_11" runat="server" Width="440px"></asp:textbox></td>
					</tr>
					<tr class="zebra_orange1">
						<td class="texto" align="center">02-</td>
						<td class="texto" style="WIDTH: 310px"><asp:textbox id="Exame_2" runat="server" Width="440px"></asp:textbox></td>
						<td class="texto" align="center">12-</td>
						<td class="texto"><asp:textbox id="Exame_12" runat="server" Width="440px"></asp:textbox></td>
					</tr>
					<tr class="zebra_orange1">
						<td class="texto" align="center">03-</td>
						<td class="texto" style="WIDTH: 310px"><asp:textbox id="Exame_3" runat="server" Width="440px"></asp:textbox></td>
						<td class="texto" align="center">13-</td>
						<td class="texto"><asp:textbox id="Exame_13" runat="server" Width="440px"></asp:textbox></td>
					</tr>
					<tr class="zebra_orange1">
						<td class="texto" align="center">04-</td>
						<td class="texto" style="WIDTH: 310px"><asp:textbox id="Exame_4" runat="server" Width="440px"></asp:textbox></td>
						<td class="texto" align="center">14-</td>
						<td class="texto"><asp:textbox id="Exame_14" runat="server" Width="440px"></asp:textbox></td>
					</tr>
					<tr class="zebra_orange1">
						<td class="texto" align="center">05-</td>
						<td class="texto" style="WIDTH: 310px"><asp:textbox id="Exame_5" runat="server" Width="440px"></asp:textbox></td>
						<td class="texto" align="center">15-</td>
						<td class="texto"><asp:textbox id="Exame_15" runat="server" Width="440px"></asp:textbox></td>
					</tr>
					<tr class="zebra_orange1">
						<td class="texto" align="center">06-</td>
						<td class="texto" style="WIDTH: 310px"><asp:textbox id="Exame_6" runat="server" Width="440px"></asp:textbox></td>
						<td class="texto" align="center">16-</td>
						<td class="texto"><asp:textbox id="Exame_16" runat="server" Width="440px"></asp:textbox></td>
					</tr>
					<tr class="zebra_orange1">
						<td class="texto" style="HEIGHT: 23px" align="center">07-</td>
						<td class="texto" style="WIDTH: 310px; HEIGHT: 23px"><asp:textbox id="Exame_7" runat="server" Width="440px"></asp:textbox></td>
						<td class="texto" style="HEIGHT: 23px" align="center">17-</td>
						<td class="texto" style="HEIGHT: 23px"><asp:textbox id="Exame_17" runat="server" Width="440px"></asp:textbox></td>
					</tr>
					<tr class="zebra_orange1">
						<td class="texto" align="center">08-</td>
						<td class="texto" style="WIDTH: 310px"><asp:textbox id="Exame_8" runat="server" Width="440px"></asp:textbox></td>
						<td align="center">18-</td>
						<td class="texto"><asp:textbox id="Exame_18" runat="server" Width="440px"></asp:textbox></td>
					</tr>
					<tr class="zebra_orange1">
						<td class="texto" align="center">09-</td>
						<td class="texto" style="WIDTH: 310px"><asp:textbox id="Exame_9" runat="server" Width="440px"></asp:textbox></td>
						<td align="center">19-</td>
						<td class="texto"><asp:textbox id="Exame_19" runat="server" Width="440px"></asp:textbox></td>
					</tr>
					<tr class="zebra_orange1">
						<td class="texto" align="center">10-</td>
						<td class="texto" style="WIDTH: 311px"><asp:textbox id="Exame_10" runat="server" Width="440px"></asp:textbox></td>
						<td class="texto" align="center">20-</td>
						<td class="texto"><asp:textbox id="Exame_20" runat="server" Width="440px"></asp:textbox></td>
					</tr>
				</table>
				<table width="100%">
					<tr class="zebra_orange1">
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="10%">Data Emissão:</td>
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="30%">Médico 
							Solicitante:</td>
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="10%">CRM:</td>
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="30%">Nome Coletor:</td>
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px" width="10%">Coleta Data:</td>
						<td class="texto" style="FONT-WEIGHT: bold; HEIGHT: 14px">Hora:</td>
					</tr>
					<tr class="zebra_orange1">
						<td class="texto" align="center"><asp:label id="Lbl_DtEmissao" runat="server"></asp:label></td>
						<td class="texto"><asp:label id="Lbl_Medico" runat="server"></asp:label></td>
						<td class="texto" align="center"><asp:label id="Lbl_Crm" runat="server"></asp:label></td>
						<td class="texto"><asp:textbox id="Txt_Coletor" runat="server" Width="277px"></asp:textbox></td>
						<td class="texto"><asp:textbox id="Txt_ColetaData" runat="server" Width="78px" MaxLength="10"></asp:textbox></td>
						<td class="texto"><asp:textbox id="Txt_Hora" runat="server" Width="40px" MaxLength="5"></asp:textbox></td>
					</tr>
				</table>
				<table width="100%">
					<tr class="zebra_orange1">
						<td class="texto" align="center"><asp:button id="Btn_Gravar" runat="server" Text="Gravar Pedido"></asp:button></td>
					</tr>
				</table>
			</FIELDSET>
			<asp:requiredfieldvalidator id="Valida_ID" style="Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 608px" tabIndex="1"
				runat="server" Display="None" ControlToValidate="Txt_id_Atendimento" ErrorMessage="Entre com o numero do atendimento."></asp:requiredfieldvalidator><asp:validationsummary id="Sumario" style="Z-INDEX: 102; LEFT: 16px; POSITION: absolute; TOP: 632px" runat="server"
				Width="144px" Height="24px" ShowMessageBox="True"></asp:validationsummary><asp:requiredfieldvalidator id="Valida_Material" style="Z-INDEX: 103; LEFT: 88px; POSITION: absolute; TOP: 608px"
				tabIndex="2" runat="server" Display="None" ControlToValidate="Txt_Material" ErrorMessage="Entre com o material."></asp:requiredfieldvalidator><asp:requiredfieldvalidator id="Valida_Coletor" style="Z-INDEX: 104; LEFT: 312px; POSITION: absolute; TOP: 608px"
				tabIndex="4" runat="server" Display="None" ControlToValidate="Txt_Coletor" ErrorMessage="Entre com o nome do coletor."></asp:requiredfieldvalidator><asp:requiredfieldvalidator id="Valida_Data" style="Z-INDEX: 105; LEFT: 424px; POSITION: absolute; TOP: 608px"
				tabIndex="5" runat="server" Display="None" ControlToValidate="Txt_ColetaData" ErrorMessage="Entre com a data da coleta."></asp:requiredfieldvalidator><asp:requiredfieldvalidator id="Valida_Hora" style="Z-INDEX: 106; LEFT: 520px; POSITION: absolute; TOP: 608px"
				tabIndex="6" runat="server" Display="None" ControlToValidate="Txt_Hora" ErrorMessage="Entre com a hora da coleta."></asp:requiredfieldvalidator><asp:requiredfieldvalidator id="Valida_Coleta" style="Z-INDEX: 107; LEFT: 200px; POSITION: absolute; TOP: 608px"
				tabIndex="3" runat="server" Display="None" ControlToValidate="RBL_Tipo_Coleta" ErrorMessage="Selecione a coleta"></asp:requiredfieldvalidator>
			<asp:RequiredFieldValidator id="Valida_Info_Clinicas" style="Z-INDEX: 108; LEFT: 624px; POSITION: absolute; TOP: 608px"
				runat="server" Display="None" ControlToValidate="Txt_Info_Clinicas" ErrorMessage="Entre com as informaçõe clinicas"></asp:RequiredFieldValidator></form>
	</body>
</HTML>
