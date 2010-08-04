<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="Usuarios_Default" Title="Untitled Page" %>

<%@ Register Src="../UserControls/DropDownList/UsuarioStatus.ascx" TagName="UsuarioStatus"
    TagPrefix="uc1" %>
<%@ Register Src="../UserControls/DropDownList/UsuariosPerfil.ascx" TagName="UsuariosPerfil"
    TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset style="height: 100%">
        <legend align="center">&nbsp;Gerenciador de Usuários&nbsp;</legend>
        <fieldset>
            <legend align="left">&nbsp;Filtro de Busca&nbsp;</legend>
            <table style="width: 100%" border="0" cellpadding="0" cellspacing="1" class="texto">
                <tr>
                    <td style="width: 38px">
                        Status:</td>
                    <td style="width: 543px">
                        Perfil:</td>
                </tr>
                <tr>
                    <td style="width: 38px; height: 22px">
                        <uc1:UsuarioStatus ID="ddlUsuarioStatus" runat="server" />
                    </td>
                    <td style="width: 543px; height: 22px">
                        <uc2:UsuariosPerfil ID="ddlUsuariosPerfil" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        Nome:</td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:TextBox ID="txtNome" runat="server" Width="30%"></asp:TextBox>&nbsp;<asp:Button
                            ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" /></td>
                </tr>
            </table>
        </fieldset>
        <br />
        <fieldset>
            <table style="width: 100%" border="0" cellpadding="0" cellspacing="1" class="texto">
                <tr>
                    <td style="width: 2395px; height: 19px;">
                        <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/Template/Img/botao_cadastro.gif"
                            PostBackUrl="~/Usuarios/UsuarioCadastro.aspx" /></td>
                    <td style="height: 19px;">
                        <img src="../Template/Img/Flg_verde.gif" />&nbsp;</td>
                    <td style="height: 19px; width: 261px;">
                        Usuário Ativo</td>
                    <td style="height: 19px; width: 18px;">
                        <img src="../Template/Img/Flg_preto.gif" /></td>
                    <td style="height: 19px; width: 261px;">
                        Usuário Inativo</td>
                </tr>
            </table>
        </fieldset>
        <fieldset>
            <legend align="left">&nbsp;Lista de Usuários&nbsp;</legend>
            <asp:GridView ID="GridUsuario" runat="server" AutoGenerateColumns="False" BackColor="White"
                BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" CssClass="texto"
                DataKeyNames="Id" OnRowCommand="GridUsuario_RowCommand" PageSize="5" Width="100%"
                OnRowDataBound="GridUsuario_RowDataBound">
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Image ID="Image1" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" HeaderText="Status">
                        <HeaderStyle ForeColor="Black" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Nome" HeaderText="Nome">
                        <HeaderStyle ForeColor="Black" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Email" HeaderText="Email">
                        <HeaderStyle ForeColor="Black" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Usuario" HeaderText="Usuario">
                        <HeaderStyle ForeColor="Black" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Perfil" HeaderText="Perfil">
                        <HeaderStyle ForeColor="Black" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageButton2" runat="server" CommandArgument='<%#Eval("ID")%>'
                                CommandName="Editar" ImageUrl="~/Template/Img/alterar.gif" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="ImgDelete" runat="server" CommandArgument='<%#Eval("ID")%>'
                                CommandName="Deletar" ImageUrl="~/Template/Img/excluir.gif" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="WhiteSmoke" Font-Bold="True" ForeColor="Black" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <HeaderStyle BackColor="#F3F7FC" Font-Bold="True" ForeColor="White" />
            </asp:GridView>
        </fieldset>
    </fieldset>
</asp:Content>
