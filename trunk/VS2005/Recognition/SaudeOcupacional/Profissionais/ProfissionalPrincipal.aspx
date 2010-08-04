<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true"
    CodeFile="ProfissionalPrincipal.aspx.cs" Inherits="Profissionais_ProfissionalPrincipal"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset style="height: 100%">
        <legend align="center">&nbsp;Gerenciador de Profissionais de Saúde&nbsp;</legend>
        <fieldset>
            <legend align="left">&nbsp;Busca&nbsp;</legend>
            <table class="texto" style="width: 100%; height: 100%" border="0" cellpadding="0"
                cellspacing="1">
                <tr>
                    <td style="width: 100px; height: 13px;">
                        Nome:</td>
                    <td style="width: 100px; height: 13px;">
                        CPF:</td>
                    <td style="width: 100px; height: 13px;">
                        RG:</td>
                    <td style="width: 100px; height: 13px;">
                    </td>
                    <td style="width: 100px; height: 13px;">
                    </td>
                    <td style="width: 100px; height: 13px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px; height: 21px;">
                        <asp:TextBox ID="TxtNome" runat="server" MaxLength="80"></asp:TextBox></td>
                    <td style="width: 100px; height: 21px;">
                        <asp:TextBox ID="TxtCPF" runat="server" MaxLength="14" onKeyPress="return MascaraCampo(this.form.name, this, '999.999.999-99', event);"></asp:TextBox></td>
                    <td style="width: 100px; height: 21px;">
                        <asp:TextBox ID="TxtRG" runat="server" MaxLength="20" onKeyPress="return MascaraCampo(this.form.name, this, '999999999999', event);"></asp:TextBox></td>
                    <td style="width: 100px; height: 21px;">
                        <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_Click" /></td>
                    <td style="width: 100px; height: 21px;">
                    </td>
                    <td style="width: 100px; height: 21px;">
                    </td>
                </tr>
            </table>
        </fieldset>
        <br />
        <fieldset>
            <table style="width: 100%" border="0" cellpadding="0" cellspacing="1" class="texto">
                <tr>
                    <td style="width: 646px; height: 19px;">
                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Template/Img/botao_cadastro.gif"
                            PostBackUrl="~/Profissionais/ProfissionalCadastro.aspx" /></td>
                    <td style="height: 19px; width: 21px;">
                        <img src="../Template/Img/Flg_verde.gif" /></td>
                    <td style="height: 19px; width: 130px;">
                        Médico Coordenador</td>
                    <td style="height: 19px; width: 18px;">
                        <img src="../Template/Img/Flg_amerelo_Escuro.gif" /></td>
                    <td style="height: 19px; width: 120px;">
                        Médico Examinador</td>
                </tr>
            </table>
        </fieldset>
        <fieldset>
            <legend>Lista</legend>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" CssClass="texto"
                Width="100%" DataKeyNames="ID" OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound"
                AllowPaging="True" PageSize="15" OnPageIndexChanging="GridView1_PageIndexChanging">
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Image ID="Image1" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Nome" HeaderText="Profissional" />
                    <asp:BoundField DataField="TipoProfissional" HeaderText="Tipo" />
                    <asp:HyperLinkField DataNavigateUrlFields="ID" DataNavigateUrlFormatString="ProfissionalCadastro.aspx?idProfissional={0}"
                        Text="&lt;img src=&quot;../Template/Img/alterar.gif&quot; border=&quot;0&quot; alt=&quot;Visualizar&quot;&gt;" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="ImgDelete" runat="server" CommandArgument='<%#Eval("ID")%>'
                                CommandName="Deletar" ImageUrl="~/Template/Img/excluir.gif" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F3F7FC" ForeColor="Gray" HorizontalAlign="Center" />
                <HeaderStyle BackColor="#F3F7FC" Font-Bold="True" ForeColor="Black" HorizontalAlign="Left" />
            </asp:GridView>
        </fieldset>
    </fieldset>
</asp:Content>
