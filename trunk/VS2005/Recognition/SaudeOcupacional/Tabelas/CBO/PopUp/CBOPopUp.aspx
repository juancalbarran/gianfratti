<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CBOPopUp.aspx.cs" Inherits="Tabelas_CBO_PopUp_CBOPopUp" %>

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
                        CBO:</td>
                    <td>
                        Função:</td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td id="Td1" runat="server">
                        <asp:TextBox ID="txtCBO" runat="server" MaxLength="10" Width="118px"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtFuncao" runat="server" Width="404px"></asp:TextBox></td>
                    <td>
                        <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_Click" /></td>
                </tr>
            </table>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                BorderStyle="Double" BorderWidth="3px" CellPadding="4" CssClass="texto" GridLines="Horizontal"
                Width="100%" AllowPaging="True" AllowSorting="True" PageSize="14" OnPageIndexChanging="GridView1_PageIndexChanging"
                DataKeyNames="COD_CBO" OnRowCommand="GridView1_RowCommand">
                <FooterStyle BackColor="#2E5CB8" ForeColor="White" BorderColor="#2E5CB8" BorderStyle="None" />
                <Columns>
                    <asp:BoundField DataField="COD_CBO" HeaderText="CBO" SortExpression="COD_CBO">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="FUNCAO" HeaderText="Fun&#231;&#227;o" SortExpression="FUNCAO">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageButton1" runat="server" CommandArgument='<%#Eval("COD_CBO")%>'
                                CommandName="Detalhes" ImageUrl='../../../Template/Img/alterar.gif' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:HyperLinkField DataNavigateUrlFields="COD_CBO,FUNCAO" DataNavigateUrlFormatString="CBOPopUp.aspx?Numero={0}&amp;Funcao={1}"
                        Text="&lt;img src=&quot;../../../Template/Img/pesquisa.gif&quot;  border=0 /&gt;">
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
