<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Calendario.aspx.vb" Inherits="SmartCare.Calendario" culture="pt-BR"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>AgendaVisualizar</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script language="javascript">
function AbrePopUp(Link_Pagina,Largura,Altura) 
	{
	   window.open(Link_Pagina,'','width='+Largura+',height='+Altura+',scrollbars=yes,top=0,left=0,screenX=800,screenY=600,status=yes')
	}

		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout" bottomMargin="0" leftMargin="0" topMargin="0" rightMargin="0">
		<form id="Form1" method="post" runat="server">
			<asp:calendar id="Calendar1" style="Z-INDEX: 103; LEFT: 0px; POSITION: absolute; TOP: 0px" runat="server"
				BackColor="Transparent" Font-Size="10pt" Width="100%" CellPadding="1" BorderWidth="1px" BorderColor="#3366CC"
				Height="600px" DayNameFormat="Full" Font-Names="Verdana" ForeColor="#003399" Font-Bold="True"
				NextPrevFormat="FullMonth" ShowGridLines="True">
				<TodayDayStyle ForeColor="White" BackColor="#99CCCC"></TodayDayStyle>
				<SelectorStyle ForeColor="#336666" BackColor="#99CCCC"></SelectorStyle>
				<DayStyle Height="80px" VerticalAlign="Top"></DayStyle>
				<NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" VerticalAlign="Top"></NextPrevStyle>
				<DayHeaderStyle Height="1px" ForeColor="#336666" VerticalAlign="Top" BackColor="#99CCCC"></DayHeaderStyle>
				<SelectedDayStyle Font-Bold="True" ForeColor="#CCFF99" BackColor="#009999"></SelectedDayStyle>
				<TitleStyle Font-Size="10pt" Font-Bold="True" Height="25px" BorderWidth="1px" ForeColor="#CCCCFF"
					BorderStyle="Solid" BorderColor="#3366CC" BackColor="#003399"></TitleStyle>
				<WeekendDayStyle BackColor="#CCCCFF"></WeekendDayStyle>
				<OtherMonthDayStyle ForeColor="#999999" VerticalAlign="Top"></OtherMonthDayStyle>
			</asp:calendar></form>
	</body>
</HTML>
