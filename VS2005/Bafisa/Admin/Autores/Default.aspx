<%@ Page Language="C#" MasterPageFile="~/Admin/Template/TemplateAdmin.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Autores_Default" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<fieldset style="height: 100%">
<legend>Gerenciador de Autores</legend>
    <table style="width:100%;" cellpadding="0" cellspacing="0" border="0">
    <tr>
    <td>
        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Admin/Template/Img/botao_cadastro.gif"
            PostBackUrl="~/Admin/Autores/Cadastro.aspx" /></td>
    </tr>
    <tr>
    <td>
        <asp:GridView ID="GridView" runat="server" AutoGenerateColumns="False" DataKeyNames="ID"
            OnRowCommand="GridView_RowCommand" Width="100%" CellPadding="4" ForeColor="#333333" GridLines="None" ShowFooter="True">
            <Columns>
                <asp:BoundField DataField="id" HeaderText="C&#243;digo" >
                    <HeaderStyle HorizontalAlign="Left" ForeColor="White" />
                </asp:BoundField>
                <asp:BoundField DataField="Nome" HeaderText="Nome" >
                    <HeaderStyle HorizontalAlign="Left" ForeColor="White" />
                </asp:BoundField>
                <asp:BoundField DataField="Descricao" HeaderText="Descri&#231;&#227;o" >
                    <HeaderStyle HorizontalAlign="Left" ForeColor="White" />
                </asp:BoundField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="ImageButton1" runat="server" CommandArgument='<%# Eval("ID") %>'
                            CommandName="Alterar" ImageUrl="~/Admin/Template/Img/alterar.gif" AlternateText="Editar registro" />
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Left" ForeColor="White" />
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Deletar" ImageUrl="~/Admin/Template/Img/excluir.gif" CommandArgument='<%# Eval("ID") %>' AlternateText="Apagar registro" />
                    </ItemTemplate>
                    <HeaderStyle ForeColor="White" />
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#E3EAEB" />
            <EditRowStyle BackColor="#7C6F57" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
    </td>
    </tr>
    </table>
</fieldset>    
</asp:Content>

