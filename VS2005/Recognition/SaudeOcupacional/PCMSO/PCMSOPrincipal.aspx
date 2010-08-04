<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true"
    CodeFile="PCMSOPrincipal.aspx.cs" Inherits="PCMSO_PCMSOPrincipal" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset style="height: 100%">
        <legend align="center">PCMSO</legend>
        <fieldset>
            <legend>Busca</legend>
            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
                <tr>
                    <td style="width: 440px">
                        Cliente:</td>
                    <td style="width: 27px">
                    </td>
                    <td style="width: 225px">
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td style="width: 440px">
                        <asp:TextBox ID="txtCliente" runat="server" Width="430px"></asp:TextBox></td>
                    <td style="width: 27px">
                    </td>
                    <td style="width: 225px">
                        <asp:Button ID="brnBuscar" runat="server" Text="Buscar" OnClick="BtnBuscar_Click" /></td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td style="height: 24px;" colspan="4">
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <a href="PCMSOCadastro.aspx">
                            <asp:Image ID="Image1" runat="server" ImageUrl="~/Template/Img/botao_cadastro.gif" /></a></td>
                </tr>
            </table>
        </fieldset>
        <fieldset>
            <legend>PCMSO</legend>
            <asp:GridView ID="GridView1" runat="server" CssClass="texto" AutoGenerateColumns="False"
                Width="100%" OnRowCommand="GridView1_RowCommand">
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F3F7FC" ForeColor="Gray" HorizontalAlign="Center" />
                <HeaderStyle BackColor="#F3F7FC" Font-Bold="True" ForeColor="Black" HorizontalAlign="Left" />
                <Columns>
                    <asp:BoundField DataField="RazaoSocial" HeaderText="Cliente" />
                    <asp:HyperLinkField DataNavigateUrlFields="ID,idCliente" DataNavigateUrlFormatString="PCMSOCadastro.aspx?id={0}&amp;idCliente={1}"
                        Text="&lt;img src=&quot;../Template/Img/alterar.gif&quot; border=&quot;0&quot; alt=&quot;Visualizar&quot;&gt;" />
                    <asp:HyperLinkField DataNavigateUrlFields="ID,idCliente" DataNavigateUrlFormatString="PCMSO.aspx?id={0}&amp;idCliente={1}"
                        Text="&lt;img src=&quot;../Template/Img/ico_impressora.gif&quot; border=&quot;0&quot; alt=&quot;Imprimir&quot;&gt;" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="ImgDelete" runat="server" CommandArgument='<%#Eval("ID")%>'
                                CommandName="Deletar" ImageUrl="~/Template/Img/excluir.gif" AlternateText="Deletar" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </fieldset>
    </fieldset>
</asp:Content>
