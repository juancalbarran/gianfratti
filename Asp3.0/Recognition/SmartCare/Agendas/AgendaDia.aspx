<%@ Page Language="vb" AutoEventWireup="false" Codebehind="AgendaDia.aspx.vb" Inherits="SmartCare.AgendaDia"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>AgendaDia</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../Bibliotecas/Css/default.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body topMargin="3">
		<form id="Form1" method="post" runat="server">
			<TABLE id="Table2" height="100%" cellSpacing="0" cellPadding="0" border="0">
				<TR>
					<TD style="WIDTH: 1092px" vAlign="top" colSpan="3">
						<fieldset><legend align="center">&nbsp;Compromissos do dia&nbsp;</legend><asp:datagrid id="MyDataGrid" runat="server" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px"
								BackColor="White" CellPadding="4" Width="100%" AutoGenerateColumns="False" PageSize="20" AllowSorting="True">
								<FooterStyle ForeColor="#003399" BackColor="#99CCCC"></FooterStyle>
								<SelectedItemStyle Font-Bold="True" ForeColor="#CCFF99" BackColor="#009999"></SelectedItemStyle>
								<ItemStyle Font-Size="8pt" Font-Names="Verdana" ForeColor="#003399" BackColor="White"></ItemStyle>
								<HeaderStyle Font-Size="8pt" Font-Names="Verdana" Font-Bold="True" ForeColor="White" BackColor="#003399"></HeaderStyle>
								<Columns>
									<asp:BoundColumn Visible="False" DataField="ID" HeaderText="ID"></asp:BoundColumn>
									<asp:BoundColumn DataField="Paciente" SortExpression="Paciente" HeaderText="Paciente"></asp:BoundColumn>
									<asp:BoundColumn DataField="Tipo" SortExpression="Tipo" HeaderText="Tipo"></asp:BoundColumn>
									<asp:BoundColumn DataField="Data_Inicio" SortExpression="Data_Inicio" HeaderText="Data"></asp:BoundColumn>
									<asp:BoundColumn DataField="Hora_Inicio" SortExpression="Hora_Inicio" HeaderText="Inicio"></asp:BoundColumn>
									<asp:BoundColumn DataField="Hora_Final" SortExpression="Hora_Final" HeaderText="Termino"></asp:BoundColumn>
									<asp:ButtonColumn Text="&lt;img border=0 src=&quot;/SmartCare/Images/ico_editar.gif&quot; &gt;" CommandName="Select"></asp:ButtonColumn>
								</Columns>
								<PagerStyle HorizontalAlign="Left" ForeColor="#003399" BackColor="#99CCCC" Mode="NumericPages"></PagerStyle>
							</asp:datagrid></fieldset>
						<asp:panel id="Panel1" runat="server" Height="124px">
							<FIELDSET><LEGEND>&nbsp;Paciente&nbsp;</LEGEND>
								<TABLE id="Table3" cellSpacing="1" cellPadding="0" width="100%" border="0" runat="server">
									<TR class="zebra_orange1">
										<TD class="texto" style="FONT-WEIGHT: bold; WIDTH: 53px; HEIGHT: 12px">Nome:</TD>
										<TD style="HEIGHT: 12px" colSpan="2">Fabrizio Gianfratti Manes</TD>
									</TR>
									<TR>
										<TD style="WIDTH: 53px"></TD>
										<TD></TD>
										<TD></TD>
									</TR>
									<TR>
										<TD colSpan="3"></TD>
									</TR>
								</TABLE>
							</FIELDSET>
						</asp:panel></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
