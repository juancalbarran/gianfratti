<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="UsuarioCadastro.aspx.cs" Inherits="Cliente_UsuarioCadastro" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<fieldset>
<legend  align=left >&nbsp;Cadastro de Usuários&nbsp;</legend>
    <table cellpadding="0" cellspacing="1" class="texto" width="100%">
        <tr>
            <td style="width: 100px; height: 13px">
                Login:</td>
            <td colspan="2" style="height: 13px">
                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px; height: 20px">
                Senha:</td>
            <td colspan="2" style="height: 20px">
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px; height: 20px">
                Confirma Senha:</td>
            <td colspan="2" style="height: 20px">
                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>&nbsp;<asp:Button ID="Button1"
                    runat="server" Text="Cadastrar" /></td>
        </tr>
    </table>
</fieldset>
</asp:Content>

