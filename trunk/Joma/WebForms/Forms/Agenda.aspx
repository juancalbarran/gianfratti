<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Agenda.aspx.cs" Inherits="Forms_Agenda" Title="Smart Health Care - Agenda" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
            <fieldset style="height: 100%">
        <legend align="center">Agenda</legend>
                <fieldset>
            <legend>Filtro</legend>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
                <tr>
                    <td style="width: 454px">
                        Nome:</td>
                    <td width="17%">
                        </td>
                    <td width="37%">
                        </td>
                </tr>
                <tr>
                    <td style="width: 454px">
                        <asp:DropDownList ID="ddlProfissionais" runat="server">
                        </asp:DropDownList>&nbsp; &nbsp;<asp:Button ID="btmBuscar" runat="server" Text="Buscar" OnClick="btmBuscar_Click" /></td>
                    <td>
                        </td>
                    <td>
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                    </td>
                </tr>
            </table>
        </fieldset>
        <br />
            <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="White"
                Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" Width="100%"
                BorderWidth="1px" Font-Bold="True" NextPrevFormat="FullMonth" OnDayRender="Calendar1_DayRender" DayNameFormat="Full" SelectionMode="None" EnableTheming="True">
                <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                <WeekendDayStyle BackColor="InactiveCaptionText" Height="200px" />
                <TodayDayStyle BackColor="LightGoldenrodYellow" />
                <OtherMonthDayStyle ForeColor="Black" />
                <NextPrevStyle VerticalAlign="Bottom" Font-Bold="True" Font-Size="8pt" ForeColor="#333333" />
                <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                <TitleStyle BackColor="WhiteSmoke" BorderColor="Black" Font-Bold="True" BorderWidth="4px"
                    Font-Size="12pt" Font-Strikeout="False" Font-Underline="False" ForeColor="#333399"
                    Height="10px" HorizontalAlign="Center" VerticalAlign="Middle" />
                <DayStyle BorderColor="Black" BorderStyle="Dotted" BorderWidth="1px" ForeColor="Black"
                    Height="150px" VerticalAlign="Top" />
            </asp:Calendar>
            </fieldset>
    </form>

</body>
</html>
