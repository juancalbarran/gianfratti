<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClienteDepartamento.aspx.cs" Inherits="Cliente_ClienteDepartamento" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

<fieldset>
<legend  align=left >&nbsp;Departamento&nbsp;</legend>
    <table border="0" cellpadding="0" cellspacing="1" style="width: 100%; height: 100%" class="texto">
        <tr>
            <td style="width: 10%;" valign="middle">
                Departamento:</td>
            <td colspan="9" style="width: 40%;" valign="middle">
                <asp:TextBox ID="TxtDepartamento" runat="server" MaxLength="50" Width="338px"></asp:TextBox></td>
            <td colspan="1" style="width: 50%" valign="middle">
                <asp:Button ID="BtnIncluirDepartamento" runat="server" OnClick="BtnIncluirDepartamento_Click"
                    Text="Salvar" CausesValidation="False" />
                <asp:HiddenField ID="TxtidDepartamento" runat="server" />
            </td>
        </tr>
    </table>
</fieldset>

<fieldset>
<legend  align=left >&nbsp;Setor&nbsp;</legend>
    <table border="0" cellpadding="0" cellspacing="1" style="width: 100%; height: 100%" class="texto">
        <tr>
            <td style="width: 10%; height: 13px;" valign="middle">
                Departamento:</td>
            <td colspan="10" style="width: 40%; height: 13px;" valign="middle">
                <asp:PlaceHolder ID="phlDrop" runat="server"></asp:PlaceHolder>
                <asp:DropDownList ID="DdlDepartamentos" runat="server" DataSourceID="ObjectDataSource3"
                    DataTextField="Nome" DataValueField="id">
                </asp:DropDownList>
                <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="DropDownList"
                    TypeName="ClienteDepartamentoDAL">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="idCliente" QueryStringField="idCliente" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                </td>
        </tr>
        <tr>
            <td style="width: 10%; height: 13px;" valign="middle">
                Setor:</td>
            <td colspan="9" style="width: 40px" valign="middle">
                <asp:TextBox ID="TxtSetor" runat="server" MaxLength="50" Width="338px"></asp:TextBox></td>
            <td colspan="1" style="width: 50px" valign="middle">
                <asp:Button ID="BtnIncluirSetor" runat="server" OnClick="BtnIncluirSetor_Click"
                    Text="Salvar" CausesValidation="False" />
                <asp:HiddenField ID="txtidSetor" runat="server" />
            </td>
        </tr>
    </table>
</fieldset>

<fieldset>
    <legend  align=left >&nbsp;Lista de Departamentos&nbsp;</legend>
                    <asp:GridView ID="GridDepartamentos" runat="server" AutoGenerateColumns="False" BackColor="White"
                        BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" CssClass="texto"
                        DataKeyNames="Id"
                        PageSize="5" Width="50%" DataSourceID="ObjectDataSource1" OnSelectedIndexChanged="GridDepartamentos_SelectedIndexChanged" OnRowCommand="GridDepartamentos_RowCommand" OnRowDataBound="GridDepartamentos_RowDataBound">
                        <FooterStyle BackColor="White" ForeColor="Black" />
                        <Columns>
                            <asp:BoundField DataField="Nome" HeaderText="Departamento(s)" >
                                <HeaderStyle ForeColor="Black" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:CommandField ButtonType="Image" SelectImageUrl="~/Template/Img/alterar.gif"
                                ShowSelectButton="True">
                                <HeaderStyle ForeColor="Black" />
                            </asp:CommandField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:ImageButton ID="ImgDeleteDepartamento" runat="server" CommandArgument='<%#Eval("ID")%>' CommandName="DeletarDepartamento"
                                        ImageUrl="~/Template/Img/excluir.gif" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle ForeColor="#000066" />
                        <SelectedRowStyle BackColor="#8AA6D8" Font-Bold="True" ForeColor="Black" />
                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                        <HeaderStyle BackColor="#F3F7FC" Font-Bold="True" ForeColor="Black" />
                    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="SelectDepartamentosByIdCliente"
        TypeName="ClienteDepartamentoDAL" DeleteMethod="Delete">
        <SelectParameters>
            <asp:QueryStringParameter Name="idCliente" QueryStringField="idCliente" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </DeleteParameters>
    </asp:ObjectDataSource>
</fieldset>

<fieldset>
    <legend  align=left >&nbsp;Lista de Setores&nbsp;</legend>
<asp:GridView ID="GridSetores" runat="server" AutoGenerateColumns="False" BackColor="White"
                        BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" CssClass="texto"
                        DataKeyNames="Id"
                        PageSize="5" Width="50%" DataSourceID="ObjectDataSource2" OnSelectedIndexChanged="GridSetores_SelectedIndexChanged" OnRowCommand="GridSetores_RowCommand" OnRowDataBound="GridSetores_RowDataBound">
                    <FooterStyle BackColor="White" ForeColor="#000066" />
                    <Columns>
                        <asp:BoundField DataField="Nome" HeaderText="Setores(s)" >
                            <HeaderStyle ForeColor="Black" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/Template/Img/alterar.gif"
                                ShowSelectButton="True">
                            <HeaderStyle ForeColor="White" />
                        </asp:CommandField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="ImgDeleteSetor" runat="server" CommandArgument='<%#Eval("ID")%>'
                                    CommandName="DeletarSetores" ImageUrl="~/Template/Img/excluir.gif" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle ForeColor="#000066" />
                    <SelectedRowStyle BackColor="#8AA6D8" Font-Bold="True" ForeColor="Black" />
                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                    <HeaderStyle BackColor="#F3F7FC" Font-Bold="True" ForeColor="White" />
                </asp:GridView>
                    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="SelectSetoresByIdDepartamento"
                        TypeName="ClienteSetorDAL">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="GridDepartamentos" Name="IdDepartamento" PropertyName="SelectedValue"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
</fieldset>
    </form>
</body>
</html>
