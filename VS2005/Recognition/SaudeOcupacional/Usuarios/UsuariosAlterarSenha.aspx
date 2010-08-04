<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UsuariosAlterarSenha.aspx.cs"
    Inherits="Usuarios_UsuariosAlterarSenha" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <fieldset>
            <legend align="center">Alteração de Senha</legend>
            <fieldset>
                <table width="30%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            Usu&aacute;rio:</td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="TextBox1" runat="server" Width="335px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>
                            Digite a Senha Atual :
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtSenha" runat="server" Width="200px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>
                            Digite a Nova Senha :
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtNovaSenha" runat="server" Width="200px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>
                            Cofirme a Nova Senha:
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtConfirmarNovaSenha" runat="server" Width="200px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Button ID="btnAlterarSenha" runat="server" Text="Alterar" /></td>
                    </tr>
                </table>
            </fieldset>
        </fieldset>
    </form>
</body>
</html>
