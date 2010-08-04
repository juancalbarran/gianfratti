<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Paciente_Gasto_Atendimento.aspx.vb" Inherits="SmartCare.Paciente_Gasto_Atendimento"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>RelatorioCid10</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../../../../Bibliotecas/Css/default.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="../../../../Bibliotecas/Funcoes/funcoesNet.js"></script>
	</HEAD>
	<body bottomMargin="0" leftMargin="0" topMargin="0" rightMargin="0">
		<form id="Form" method="post" runat="server">
			<FIELDSET><LEGEND id="LEGEND1" align="center" runat="server">&nbsp;Relatório de Gastos 
					por Paciente&nbsp;</LEGEND>
				<TABLE id="Table1" cellSpacing="1" cellPadding="0" width="100%" border="0" runat="server">
					<TR>
						<TD class="texto" style="FONT-WEIGHT: bold; HEIGHT: 3px" width="8%" bgColor="#ece9d8">Nº 
							Atend.:</TD>
						<TD style="HEIGHT: 3px" width="5%" bgColor="#ece9d8" height="3"><asp:textbox id="TxtBoxId_Atendimento" runat="server" Width="48px" CssClass="campos" MaxLength="10"></asp:textbox></TD>
						<TD class="texto" style="FONT-WEIGHT: bold; HEIGHT: 3px" width="8%" bgColor="#ece9d8"
							height="3">Data Inicio:</TD>
						<TD style="HEIGHT: 3px" width="10%" bgColor="#ece9d8" height="3"><asp:textbox id="TxtBoxData_Inicial" runat="server" Width="87px" CssClass="campos" MaxLength="10"></asp:textbox></TD>
						<TD class="texto" style="FONT-WEIGHT: bold; HEIGHT: 3px" width="8%" bgColor="#ece9d8"
							height="3">Data Final:</TD>
						<TD style="HEIGHT: 3px" width="10%" bgColor="#ece9d8" height="3"><asp:textbox id="TxtBoxData_Final" runat="server" Width="87px" CssClass="campos" MaxLength="10"></asp:textbox></TD>
						<TD class="texto" style="FONT-WEIGHT: bold; HEIGHT: 3px" width="11%" bgColor="#ece9d8"
							height="3">Cod. Simpro:</TD>
						<TD style="HEIGHT: 3px" align="left" width="5%" bgColor="#ece9d8" colSpan="5" height="3"><asp:textbox id="TextBoxSimpro" runat="server" Width="48px" CssClass="campos" MaxLength="10"></asp:textbox></TD>
						<TD class="texto" style="FONT-WEIGHT: bold; HEIGHT: 3px" align="left" width="5%" bgColor="#ece9d8"
							height="3">Tipo:</TD>
						<TD class="texto" id="TD1" style="FONT-WEIGHT: bold; HEIGHT: 3px" align="left" width="28%"
							bgColor="#ece9d8" height="3"><asp:dropdownlist id="DDL_Tipo" runat="server">
								<asp:ListItem Value=" ">Selecione</asp:ListItem>
								<asp:ListItem Value="50">Medicamento</asp:ListItem>
								<asp:ListItem Value="20">Mat. Hospitalar</asp:ListItem>
								<asp:ListItem Value="70">Perfumaria</asp:ListItem>
							</asp:dropdownlist>&nbsp;
							<asp:button id="Button1" runat="server" Text="Buscar"></asp:button></TD>
					</TR>
					<TR>
						<TD colSpan="14"><asp:datagrid id="MyDataGrid" runat="server" Width="100%" PageSize="100" AutoGenerateColumns="False"
								CellPadding="4" BackColor="White" BorderWidth="1px" BorderStyle="None" BorderColor="#3366CC">
								<FooterStyle ForeColor="#003399" BackColor="#99CCCC"></FooterStyle>
								<SelectedItemStyle Font-Bold="True" ForeColor="#CCFF99" BackColor="#009999"></SelectedItemStyle>
								<ItemStyle Font-Size="8pt" Font-Names="Verdana" ForeColor="#003399" BackColor="White"></ItemStyle>
								<HeaderStyle Font-Size="8pt" Font-Names="Verdana" Font-Bold="True" ForeColor="White" BackColor="#003399"></HeaderStyle>
								<Columns>
									<asp:BoundColumn DataField="CD_SIMPRO" SortExpression="CD_SIMPRO" HeaderText="Simpro"></asp:BoundColumn>
									<asp:BoundColumn DataField="data_cadastro" HeaderText="Data" DataFormatString="{0:dd/MM/yyyy HH:mm}"></asp:BoundColumn>
									<asp:BoundColumn DataField="Funcionario" SortExpression="Funcionario" HeaderText="Prescritor"></asp:BoundColumn>
									<asp:BoundColumn DataField="Descricao" SortExpression="Descricao" HeaderText="Descri&#231;&#227;o"></asp:BoundColumn>
									<asp:TemplateColumn SortExpression="CD_MERCADO" HeaderText="Tipo">
										<ItemTemplate>
											<asp:Label id="Lbl_Tipo" runat="server"></asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:BoundColumn DataField="PC_FR_VEN" SortExpression="PC_FR_VEN" HeaderText="Preco"></asp:BoundColumn>
									<asp:BoundColumn DataField="QTD" SortExpression="QTD" HeaderText="Qtd.">
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
									</asp:BoundColumn>
									<asp:BoundColumn DataField="Total" HeaderText="Total"></asp:BoundColumn>
								</Columns>
								<PagerStyle HorizontalAlign="Left" ForeColor="#003399" BackColor="#99CCCC" Mode="NumericPages"></PagerStyle>
							</asp:datagrid></TD>
					</TR>
					<TR>
						<TD style="WIDTH: 856px" colSpan="12"></TD>
						<TD style="WIDTH: 170px"></TD>
						<TD></TD>
					</TR>
				</TABLE>
				<FIELDSET>
		</form>
		</FIELDSET></FIELDSET>
	</body>
</HTML>
