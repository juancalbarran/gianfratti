<%@ Page Language="vb" AutoEventWireup="false" Codebehind="thumbnail.aspx.vb" Inherits="SmartCare.thumbnail" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>thumbnail</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script>
	
function AbrePopUp(Link_Pagina,Largura,Altura) 
	{	
		   window.open(Link_Pagina,'','width='+Largura+',height='+Altura+',scrollbars=yes,top=0,left=0,screenX=800,screenY=600,status=yes')
	}
		
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:datagrid id="MyDataGrid" style="Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 8px" runat="server"
				BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" BackColor="White" CellPadding="4"
				AutoGenerateColumns="False" AllowPaging="True" Width="100px" ShowHeader="False">
				<FooterStyle ForeColor="#003399" BackColor="#99CCCC"></FooterStyle>
				<SelectedItemStyle Font-Bold="True" ForeColor="#CCFF99" BackColor="#009999"></SelectedItemStyle>
				<ItemStyle Font-Size="8pt" Font-Names="Verdana" HorizontalAlign="Center" ForeColor="#003399"
					BackColor="White"></ItemStyle>
				<HeaderStyle Font-Size="8pt" Font-Names="Verdana" Font-Bold="True" ForeColor="White" BackColor="#003399"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn HeaderText="imagem">
						<ItemTemplate>
							<asp:Label id="Lbl_Destaque" runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
				<PagerStyle Font-Size="12px" HorizontalAlign="Left" ForeColor="#003399" Position="Top" BackColor="#99CCCC"
					Wrap="False" Mode="NumericPages"></PagerStyle>
			</asp:datagrid></form>
	</body>
</HTML>
