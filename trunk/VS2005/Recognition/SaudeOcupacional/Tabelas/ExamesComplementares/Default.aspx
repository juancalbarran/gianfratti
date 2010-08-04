<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="Tabelas_ExamesComplementares_Default" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset style="height:100%">
        <legend align="center">Exames Complementares</legend>
        <fieldset>
            <legend>&nbsp;Busca &nbsp;</legend>
            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
                <tr>
                    <td style="width: 513px">
                        &nbsp;Exame:</td>
                </tr>
                <tr>
                    <td style="height: 24px; width: 513px;">
                        <asp:TextBox ID="txtExame" runat="server" Width="100%"></asp:TextBox></td>
                    <td style="height: 24px">
                        &nbsp;<asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_Click" /></td>
                </tr>
                <tr>
                    <td style="width: 513px">
                        <a href="ExamesComplementaresCadastro.aspx">
                            <asp:Image ID="ImgCadastro" runat="server" ImageUrl="~/Template/Img/botao_cadastro.gif" /></a></td>
                </tr>
            </table>
        </fieldset>
        <fieldset>
            <legend>&nbsp;Exames&nbsp; </legend>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CssClass="texto" Width="100%"
                DataKeyNames="ID" OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound">
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F3F7FC" ForeColor="Gray" HorizontalAlign="Center" />
                <HeaderStyle BackColor="#F3F7FC" Font-Bold="True" ForeColor="Black" HorizontalAlign="Left" />
                <Columns>
                    <asp:BoundField DataField="Descricao" HeaderText="Descri&#231;&#227;o" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageButton1" runat="server" CommandArgument='<%#Eval("ID")%>'
                                CommandName="Editar" ImageUrl="~/Template/Img/alterar.gif" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="ImgDelete" runat="server" CommandArgument='<%#Eval("ID")%>'
                                CommandName="Deletar" ImageUrl="~/Template/Img/excluir.gif" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </fieldset>
    </fieldset>
</asp:Content>
