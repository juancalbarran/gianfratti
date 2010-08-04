<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CID10PopUp.aspx.cs" Inherits="Tabelas_CID10_PopUp_CID10PopUp" %>

<link href="../../../Template/Css/default.css" rel="stylesheet" type="text/css" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
        <fieldset>
            <legend>Busca</legend>
            <table id="Table1" width="100%" class="texto">
                <tr>
                    <td>
                        CID10:</td>
                    <td>
                        Diagnóstico:</td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td id="Td1" runat="server">
                        <asp:TextBox ID="txtCID10" runat="server" MaxLength="10" Width="118px"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtDescricao" runat="server" Width="404px"></asp:TextBox></td>
                    <td>
                        <asp:Button ID="Button1" runat="server" Text="Buscar" /></td>
                </tr>
            </table>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                BorderStyle="Double" BorderWidth="3px" CellPadding="4" CssClass="texto" GridLines="Horizontal"
                Width="100%" AllowPaging="True" AllowSorting="True" PageSize="14" OnPageIndexChanging="GridView1_PageIndexChanging">
                <FooterStyle BackColor="#2E5CB8" ForeColor="White" BorderColor="#2E5CB8" BorderStyle="None" />
                <Columns>
                    <asp:BoundField DataField="CID10" HeaderText="CID10" SortExpression="CID10">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DESCRICAO" HeaderText="Diagnostico" SortExpression="DESCRICAO">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:HyperLinkField DataNavigateUrlFields="CID10" DataNavigateUrlFormatString="CID10PopUp.aspx?Numero={0}"
                        Text="&lt;img src=&quot;../../../Template/Img/alterar.gif&quot;  border=0 /&gt;">
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:HyperLinkField>
                </Columns>
                <RowStyle BackColor="White" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2E5CB8" ForeColor="White" HorizontalAlign="Center" />
                <HeaderStyle BackColor="#2E5CB8" Font-Bold="True" ForeColor="White" />
            </asp:GridView>
        </fieldset>
    </form>
</body>
</html>
