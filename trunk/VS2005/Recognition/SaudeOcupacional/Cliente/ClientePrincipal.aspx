<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true"
    CodeFile="ClientePrincipal.aspx.cs" Inherits="Cliente_ClientePrincipal" Title="Saúde Ocupacional" %>

<%@ Register Src="../UserControls/DropDownList/TipoIdentificacao.ascx" TagName="TipoIdentificacao"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset style="height: 100%">
        <legend align="center">&nbsp;Gerenciador de Clientes&nbsp;</legend>
        <fieldset>
            <legend align="left">&nbsp;Busca&nbsp;</legend>
            <table class="texto" style="width: 100%; height: 100%" border="0" cellpadding="0"
                cellspacing="1">
                <tr>
                    <td style="width: 100px; height: 13px;">
                        <uc1:TipoIdentificacao ID="TipoIdentificacao1" runat="server" />
                    </td>
                    <td style="width: 100px; height: 13px;">
                        Razão Social:</td>
                    <td style="width: 100px; height: 13px;">
                        Contato:</td>
                    <td style="width: 100px; height: 13px;">
                    </td>
                    <td style="width: 100px; height: 13px;">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        <asp:TextBox ID="TxtCNPJ" runat="server"></asp:TextBox></td>
                    <td style="width: 100px">
                        <asp:TextBox ID="TxtRazaoSocial" runat="server"></asp:TextBox></td>
                    <td style="width: 100px">
                        <asp:TextBox ID="TxtContato" runat="server"></asp:TextBox></td>
                    <td style="width: 100px">
                        <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_Click" /></td>
                    <td style="width: 100px">
                    </td>
                </tr>
            </table>
        </fieldset>
        <table style="width: 100%" border="0" cellpadding="0" cellspacing="1" class="texto">
            <tr>
                <td style="width: 100px">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Template/Img/botao_cadastro.gif"
                        PostBackUrl="~/Cliente/DefaultAbas.aspx?idCliente=0" /></td>
            </tr>
        </table>
        <fieldset>
            <legend align="left">&nbsp;Clientes&nbsp;</legend>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%"
                BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                CellPadding="3" CssClass="texto" DataKeyNames="ID" OnRowCommand="GridView1_RowCommand"
                OnPreRender="GridView1_PreRender" AllowPaging="True" PageSize="15" OnPageIndexChanging="GridView1_PageIndexChanging"
                OnRowDataBound="GridView1_RowDataBound">
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F3F7FC" ForeColor="Gray" HorizontalAlign="Center" />
                <HeaderStyle BackColor="#F3F7FC" Font-Bold="True" ForeColor="Black" HorizontalAlign="Left" />
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="C&#243;digo" />
                    <asp:BoundField DataField="RazaoSocial" HeaderText="Raz&#227;o Social" />
                    <asp:BoundField DataField="Total_Funcionario" HeaderText="Funcion&#225;rios">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Cidade" HeaderText="Cidade" />
                    <asp:BoundField DataField="UF" HeaderText="UF" />
                    <asp:BoundField DataField="Telefone" HeaderText="Telefone" />
                    <asp:BoundField DataField="email" HeaderText="E-mail" />
                    <asp:HyperLinkField DataNavigateUrlFields="ID" DataNavigateUrlFormatString="DefaultAbas.aspx?idCliente={0}"
                        Text="&lt;img src=&quot;../Template/Img/alterar.gif&quot; border=&quot;0&quot; alt=&quot;Atualizar&quot;&gt;" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="ImgDelete" runat="server" CommandArgument='<%#Eval("ID")%>'
                                CommandName="Deletar" ImageUrl="~/Template/Img/excluir.gif" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            &nbsp;
        </fieldset>
    </fieldset>
</asp:Content>
