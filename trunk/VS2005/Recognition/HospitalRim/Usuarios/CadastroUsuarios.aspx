<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="CadastroUsuarios.aspx.cs" Inherits="Usuarios_CadastroUsuarios" Title="SmartCare - Hospital do Rim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<fieldset>
      <legend align="center">Cadastro de Usuários</legend>  
		<fieldset>
		<table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td style="height: 19px">Status:</td>
          </tr>
            <tr>
            <td style="height: 19px">
                <asp:DropDownList ID="DropDownList1" runat="server">
                    <asp:ListItem Value="Ativado"></asp:ListItem>
                    <asp:ListItem Value="Desativado"></asp:ListItem>
                </asp:DropDownList></td>
          </tr>
          <tr>
            <td style="height: 19px">Nome:</td>
          </tr>
          <tr>
            <td>
                <asp:TextBox ID="txtNome" runat="server" Width="438px"></asp:TextBox>&nbsp;
            </td>
          </tr>
          <tr>
            <td>Perfil:</td>
          </tr>
          <tr>
            <td style="height: 19px">
                <asp:DropDownList ID="DropDownList2" runat="server">
                    <asp:ListItem Value="Administrativo"></asp:ListItem>
                    <asp:ListItem Value="Atendimento"></asp:ListItem>
                    <asp:ListItem Value="Ambulatório"></asp:ListItem>
                    <asp:ListItem Value="M&#233;dico"></asp:ListItem>
                </asp:DropDownList></td>
          </tr>
          <tr>
            <td>Usu&aacute;rio:</td>
          </tr>
          <tr>
            <td style="height: 19px">
                <asp:TextBox ID="txtUsuario" runat="server" Width="438px" MaxLength="15"></asp:TextBox></td>
          </tr>
          <tr>
            <td>Senha:</td>
          </tr>
          <tr>
            <td>
                <asp:TextBox ID="txtSenha" runat="server" Width="438px" MaxLength="15" TextMode="Password"></asp:TextBox></td>
          </tr>
          <tr>
            <td>Confirmar Senha: </td>
          </tr>
          <tr>
            <td style="height: 24px">
                <asp:TextBox ID="txtConfirmarSenha" runat="server" Width="438px" MaxLength="15" TextMode="Password"></asp:TextBox></td>
          </tr>
      </table>
    </fieldset>
        <fieldset>
      <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center"><asp:Button ID="Button1" runat="server" Text="Salvar" /></td>
        </tr>
      </table>
    </fieldset>
</fieldset>    
</asp:Content>