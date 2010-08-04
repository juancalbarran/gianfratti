<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Cargo.aspx.cs" Inherits="Cliente_Cargo" %>

<%@ Register Src="../UserControls/DropDownList/ClienteDepartamento.ascx" TagName="ClienteDepartamento"
    TagPrefix="uc1" %>
<%@ Register Src="../UserControls/DropDownList/ClienteSetor.ascx" TagName="ClienteSetor"
    TagPrefix="uc2" %>
<link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
        <fieldset style="height: 100%">
            <legend align="center">Cargos</legend>
            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
                <tr>
                    <td style="height: 22px">
                        Departamento:</td>
                </tr>
                <tr>
                    <td style="height: 25px">
                        <uc1:ClienteDepartamento ID="ClienteDepartamento1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="height: 22px">
                        Setor:</td>
                </tr>
                <tr>
                    <td style="height: 25px">
                        <uc2:ClienteSetor ID="ClienteSetor1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="height: 22px">
                        Cargo:</td>
                </tr>
                <tr>
                    <td style="height: 25px">
                        <asp:TextBox ID="txtCargo" runat="server" Width="250px"></asp:TextBox></td>
                </tr>
            </table>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%"
                BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                CellPadding="3" CssClass="texto" OnRowCommand="GridView1_RowCommand">
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F3F7FC" ForeColor="Gray" HorizontalAlign="Center" />
                <HeaderStyle BackColor="#F3F7FC" Font-Bold="True" ForeColor="Black" HorizontalAlign="Left" />
                <Columns>
                    <asp:BoundField DataField="Departamento" HeaderText="Departamento" />
                    <asp:BoundField DataField="Setor" HeaderText="Setor" />
                    <asp:BoundField DataField="Cargo" HeaderText="Cargo" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="ImgDelete" runat="server" AlternateText="Deletar" CommandArgument='<%#Eval("ID")%>'
                                CommandName="Deletar" ImageUrl="~/Template/Img/excluir.gif" OnRowCommand="GridView1_RowCommand" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </fieldset>
        <br />
        <fieldset>
            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
                <tr>
                    <td align="center">
                        <asp:Button ID="btnSalvar" runat="server" Text="Salvar" OnClick="btnSalvar_Click" /></td>
                </tr>
            </table>
        </fieldset>
    </form>
</body>
</html>
