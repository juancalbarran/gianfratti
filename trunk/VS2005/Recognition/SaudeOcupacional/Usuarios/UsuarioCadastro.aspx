<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true"
    CodeFile="UsuarioCadastro.aspx.cs" Inherits="Usuarios_UsuarioCadastro" Title="Untitled Page" %>

<%@ Register Src="../UserControls/DropDownList/Profissional.ascx" TagName="Profissional"
    TagPrefix="uc3" %>
<%@ Register Src="../UserControls/DropDownList/UsuarioStatus.ascx" TagName="UsuarioStatus"
    TagPrefix="uc1" %>
<%@ Register Src="../UserControls/DropDownList/UsuariosPerfil.ascx" TagName="UsuariosPerfil"
    TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset style="height: 100%">
        <legend align="center">&nbsp;Cadastro de Usuários&nbsp;</legend>
        <fieldset>
            <table border="0" cellpadding="0" cellspacing="1" style="width: 100%;" class="texto">
                <tr>
                    <td style="width: 119px; height: 19px">
                        Status(*):</td>
                    <td style="height: 19px; width: 143px;">
                        Perfil(*):</td>
                    <td style="width: 506px; height: 19px">
                        <asp:Label ID="lblMédico" runat="server" Text="Médico:"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 119px; height: 19px">
                        <uc1:UsuarioStatus ID="ddlUsuarioStatus" runat="server" />
                    </td>
                    <td style="height: 19px; width: 143px;">
                        <uc2:UsuariosPerfil ID="ddlUsuarioPerfil" runat="server" />
                    </td>
                    <td style="width: 506px; height: 19px">
                        <uc3:Profissional ID="ddlProfissional" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 119px; height: 19px">
                        Nome(*):</td>
                    <td style="height: 19px;" colspan="2">
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 19px">
                        <asp:TextBox ID="txtNome" runat="server" Width="50%" MaxLength="50"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 19px">
                        E-Mail (*): (a senha de acesso sera enviada para o e-mail cadastrado)</td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 19px">
                        <asp:TextBox ID="txtEmail" runat="server" Width="50%" MaxLength="100"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 19px">
                        Confirmação de E-Mail(*):</td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 19px">
                        <asp:TextBox ID="txtEmailConfirmacao" runat="server" Width="50%" MaxLength="100"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="width: 119px; height: 19px">
                        Usuario(*):</td>
                    <td colspan="2" style="height: 19px">
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 19px">
                        <asp:TextBox ID="txtUsuario" runat="server" MaxLength="20"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 19px">
                        Permissão de acesso:</td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 19px">
                        <asp:CheckBoxList ID="ChkBoxList" runat="server" CssClass="texto" RepeatColumns="4">
                        </asp:CheckBoxList></td>
                </tr>
            </table>
        </fieldset>
        <br />
        <fieldset>
            <table border="0" cellpadding="0" cellspacing="1" style="width: 100%;" class="texto">
                <tr>
                    <td align="center">
                        <asp:Button ID="btnSalvar" runat="server" OnClick="btnSalvar_Click" Text="Salvar" /></td>
                </tr>
            </table>
        </fieldset>
    </fieldset>
</asp:Content>
