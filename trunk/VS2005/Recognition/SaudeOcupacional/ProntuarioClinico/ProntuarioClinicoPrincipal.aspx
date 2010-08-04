<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="ProntuarioClinicoPrincipal.aspx.cs" Inherits="ProntuarioClinico_ProntuarioClinicoPrincipal" Title="Prontuário Clínico" %>

<%@ Register Src="../UserControls/DropDownList/Cliente.ascx" TagName="Cliente" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<fieldset style="height: 100%">
<legend  align=center >&nbsp;Gerenciador de Prontuarios Clinicos&nbsp;</legend>
<fieldset>
<legend  align=left >&nbsp;Busca&nbsp;</legend>
    <table class=texto style="width: 100%; height: 100%" border="0" cellpadding="0" cellspacing="1">
        <tr>
            <td style="width: 100px; height: 13px">
                Cliente:</td>
            <td style="width: 100px; height: 13px">
            </td>
            <td style="width: 100px; height: 13px">
            </td>
            <td style="width: 100px; height: 13px">
            </td>
            <td style="width: 100px; height: 13px">
            </td>
            <td style="width: 100px; height: 13px">
            </td>
        </tr>
        <tr>
            <td colspan="5" style="height: 13px">
                <uc1:Cliente ID="DdlCliente" runat="server" />
            </td>
            <td colspan="1" style="height: 13px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 13px;">
                Funcionário:</td>
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
                <asp:TextBox ID="TxtCPF" runat="server" MaxLength="14" onKeyPress="return MascaraCampo(this.form.name, this, '999.999.999-99', event);" ></asp:TextBox></td>
            <td style="width: 100px; height: 21px;">
                <asp:TextBox ID="TxtRG" runat="server" MaxLength="20" onKeyPress="return MascaraCampo(this.form.name, this, '999999999999', event);"></asp:TextBox></td>
            <td style="width: 100px; height: 21px;">
                <asp:Button ID="Button1" runat="server" Text="Buscar" /></td>
            <td style="width: 100px; height: 21px;">
                </td>
            <td style="width: 100px; height: 21px;">
                </td>
        </tr>
    </table>
</fieldset>
    &nbsp;
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" CssClass="texto" Width="100%" DataKeyNames="ID" OnPreRender="GridView1_PreRender" AllowPaging="True" PageSize="15" OnPageIndexChanging="GridView1_PageIndexChanging">
        <FooterStyle BackColor="White" ForeColor="#000066" />
        <Columns>
            <asp:BoundField DataField="Funcionario" HeaderText="Funcion&#225;rio" />
            <asp:BoundField DataField="RazaoSocial" HeaderText="Cliente" />
            <asp:HyperLinkField DataNavigateUrlFields="ID" DataNavigateUrlFormatString="ProntuarioClinicoCadastro.aspx?idFuncionario={0}"
                Text="&lt;img src=&quot;../Template/Img/alterar.gif&quot; border=&quot;0&quot; alt=&quot;Visualizar&quot;&gt;" />
        </Columns>
        <RowStyle ForeColor="#000066" />
        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#F3F7FC" ForeColor="Gray" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#F3F7FC" Font-Bold="True" ForeColor="Black" HorizontalAlign="Left" />
    </asp:GridView>
</fieldset>
</asp:Content>

