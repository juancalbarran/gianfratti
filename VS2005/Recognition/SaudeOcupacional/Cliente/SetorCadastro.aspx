<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="SetorCadastro.aspx.cs" Inherits="Cliente_SetorCadastro" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<fieldset>
<legend  align=left >&nbsp;Cadastro de Setores&nbsp;</legend>
    <table cellpadding="0" cellspacing="1" class="texto" width="100%">
        <tr>
            <td style="width: 100px; height: 13px">
                Departamento:</td>
            <td colspan="2" style="height: 13px">
                <asp:DropDownList ID="DropDownList1" runat="server">
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td style="width: 100px; height: 20px">
                Setor:</td>
            <td colspan="2" style="height: 20px">
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>&nbsp;<asp:Button ID="Button1"
                    runat="server" Text="Cadastrar" /></td>
        </tr>
    </table>
</fieldset>
</asp:Content>

