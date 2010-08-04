<%@ Page Language="vb" AutoEventWireup="false" Codebehind="WebForm1.aspx.vb" Inherits="SmartCare.WebForm1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>WebForm1</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<LINK href="Styles.css" type="text/css" rel="stylesheet">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<P>&nbsp;</P>
			<P><asp:datagrid id="DataGrid2" runat="server" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px"
					BackColor="White" CellPadding="4" GridLines="Vertical" ForeColor="Black" AutoGenerateColumns="False">
					<FooterStyle BackColor="#CCCC99"></FooterStyle>
					<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#CE5D5A"></SelectedItemStyle>
					<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
					<ItemStyle BackColor="#F7F7DE"></ItemStyle>
					<HeaderStyle Font-Bold="True" ForeColor="White" BackColor="#6B696B"></HeaderStyle>
					<Columns>
						<asp:TemplateColumn>
							<ItemStyle Width="11px"></ItemStyle>
							<ItemTemplate>
								<asp:ImageButton id="imbExpand" ImageUrl="plus.gif" CommandName="Expand" Runat="server"></asp:ImageButton>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:BoundColumn DataField="Title" HeaderText="Title"></asp:BoundColumn>
						<asp:BoundColumn DataField="Author" HeaderText="Author"></asp:BoundColumn>
						<asp:BoundColumn DataField="Year" HeaderText="Year"></asp:BoundColumn>
						<asp:BoundColumn DataField="Price" HeaderText="Price"></asp:BoundColumn>
						<asp:TemplateColumn>
							<ItemTemplate>
								<asp:Panel id="pnlSummary" Runat="server" Visible="False"></TD></TR><TR bgcolor="#ffffcc">
										<TD></TD>
										<TD colspan="5"><FONT size="-1"><%# Databinder.Eval(container.dataitem, "Summary")%></FONT></TD>
									</TR></asp:Panel>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
					<PagerStyle HorizontalAlign="Right" ForeColor="Black" BackColor="#F7F7DE" Mode="NumericPages"></PagerStyle>
				</asp:datagrid></P>
		</form>
	</body>
</HTML>
