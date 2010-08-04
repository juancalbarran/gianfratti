<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="FuncionarioPrincipal.aspx.cs" Inherits="ClienteFuncionario_FuncionarioPrincipal" Title="Untitled Page" %>

<%@ Register Src="../UserControls/DropDownList/ClienteFuncionarioStatus.ascx" TagName="ClienteFuncionarioStatus"
    TagPrefix="uc2" %>

<%@ Register Src="../UserControls/DropDownList/Cliente.ascx" TagName="Cliente" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<fieldset style="height: 100%">
<legend  align=center >&nbsp;Gerenciador de Funcionários&nbsp;</legend>

<fieldset>
<legend  align=left >&nbsp;Busca&nbsp;</legend>
    <table class=texto style="width: 100%; height: 100%" border="0" cellpadding="0" cellspacing="1">
        <tr>
            <td style="width: 100px; height: 13px">
                Status:</td>
            <td style="width: 100px; height: 13px">
                Cliente:</td>
            <td style="width: 100px; height: 13px">
            </td>
            <td style="width: 100px; height: 13px">
            </td>
            <td style="width: 100px; height: 13px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 13px">
                <uc2:ClienteFuncionarioStatus ID="ddlClienteFuncionarioStatus" runat="server" />
            </td>
            <td colspan="4" style="height: 13px">
                <uc1:Cliente ID="ddlCliente" runat="server" />
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 13px;">
                CPF:</td>
            <td style="width: 100px; height: 13px;">
                RG:</td>
            <td style="width: 100px; height: 13px;">
                Nome:</td>
            <td style="width: 100px; height: 13px;">
                Nome mãe:</td>
            <td style="width: 100px; height: 13px;">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="TxtCPF" runat="server" MaxLength="14" onKeyPress="return MascaraCampo(this.form.name, this, '999.999.999-99', event);"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TxtRG" runat="server" MaxLength="20"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TxtNome" runat="server" MaxLength="50"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TxtMae" runat="server" MaxLength="50"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_Click" /></td>
        </tr>
    </table>
</fieldset>
<br />
    <fieldset>
        <table style="width: 100%" border="0" cellpadding="0" cellspacing="1" class="texto">
        <tr>
            <td style="width: 347px; height: 19px;">
                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Template/Img/botao_cadastro.gif"
                    PostBackUrl="~/ClienteFuncionario/DefaultAbas.aspx?id=0&idCliente=0" /></td>
                                <td style="height: 19px; width: 21px;">
                <img src="../Template/Img/Flg_verde.gif" />&nbsp;</td>
            <td style="height: 19px; width: 43px;">
                Ativo</td>
            <td style="height: 19px; width: 15px;">
                <img src="../Template/Img/Flg_amerelo_Escuro.gif" /></td>
            <td style="height: 19px; width: 55px;">
                Licença</td>
            <td style="width: 16px; height: 19px">
                <img src="../Template/Img/Flg_vermelho.gif" /></td>
            <td style="width: 88px; height: 19px">
                Afastamento</td>
            <td style="width: 17px; height: 19px">
                <img src="../Template/Img/Flg_preto.gif" /></td>
            <td style="width: 70px; height: 19px">
                Desligado</td>
            <td style="width: 16px; height: 19px">
                <img src="../Template/Img/Flg_cinza.gif" /></td>
            <td style="width: 156px; height: 19px">
                Sem Registro Profissional</td>
        </tr>
    </table>
    </fieldset>

<fieldset>
<legend  align=left >&nbsp;Funcionários&nbsp;</legend>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
        BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" CssClass="texto"
        DataKeyNames="ID" Width="100%" OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound" AllowPaging="True" PageSize="15" OnPageIndexChanging="GridView1_PageIndexChanging">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Nome" HeaderText="Nome" />
            <asp:BoundField DataField="CPF" HeaderText="CPF" />
            <asp:BoundField DataField="RazaoSocial" HeaderText="Raz&#227;o Social" />
            <asp:BoundField DataField="Status" HeaderText="Status" />
            <asp:HyperLinkField DataNavigateUrlFields="ID,idCliente" DataNavigateUrlFormatString="DefaultAbas.aspx?id={0}&amp;idCliente={1}"
                Text="&lt;img src=&quot;../Template/Img/alterar.gif&quot; border=&quot;0&quot; alt=&quot;Atualizar&quot;&gt;" />
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
        <FooterStyle BackColor="White" ForeColor="#000066" />
        <HeaderStyle BackColor="#F3F7FC" Font-Bold="True" ForeColor="Black" HorizontalAlign="Left" />
    </asp:GridView>
    &nbsp;

</fieldset>

</fieldset>
</asp:Content>

