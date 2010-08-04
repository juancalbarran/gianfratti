<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UsuariosCadastro.aspx.cs" Inherits="Usuarios_UsuariosCadastro" %>

<%@ Register Src="../UserControls/ListBox/Cliente.ascx" TagName="Cliente" TagPrefix="uc5" %>

<%@ Register Src="../UserControls/DropDownList/Profissional.ascx" TagName="Profissional"
    TagPrefix="uc4" %>

<%@ Register Src="../UserControls/DropDownList/Cliente.ascx" TagName="Cliente" TagPrefix="uc3" %>

<%@ Register Src="../UserControls/DropDownList/UsuarioStatus.ascx" TagName="UsuarioStatus"
    TagPrefix="uc1" %>
<%@ Register Src="../UserControls/DropDownList/UsuariosPerfil.ascx" TagName="UsuariosPerfil"
    TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />
    <title>Untitled Page</title>
</head>

<body>
    <form id="form1" runat="server">
    <div>
    <br />
    <fieldset>
      
		<table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td style="height: 19px; width: 157px;">Status: (*)</td>
            <td style="width: 161px">Perfil: (*)</td>
              <td style="width: 317px">
                  <asp:Label ID="lblProfissional" runat="server" Text="Profissional de Saúde:"></asp:Label></td>
              <td>
                  &nbsp;</td>
          </tr>
            <tr>
            <td style="height: 19px; width: 157px;">
                <uc1:UsuarioStatus ID="ddlUsuarioStatus" runat="server" />
            </td>
            <td style="width: 161px; height: 19px">
                &nbsp;<uc2:UsuariosPerfil ID="ddlUsuarioPerfil" runat="server" />
            </td>
                <td style="height: 19px;" colspan="2">
                    <uc4:Profissional ID="ddlProfissional" runat="server" />
                    &nbsp;</td>
          </tr>
        </table>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td style="height: 19px">
                    <asp:Label ID="lblCliente" runat="server" Text="Clientes:"></asp:Label></td>
            </tr>
            <tr>
                <td style="height: 19px">
                    &nbsp;<asp:CheckBoxList ID="ChkBoxList" runat="server" RepeatColumns="4">
                    </asp:CheckBoxList>
                </td>
            </tr>
          <tr>
            <td style="height: 19px">Nome: (*)</td>
          </tr>
          <tr>
            <td>
                <asp:TextBox ID="txtUsuarioNome" runat="server" Width="335px" MaxLength="40"></asp:TextBox>&nbsp;
                <asp:HiddenField ID="hddIUsuario" runat="server" />
                &nbsp; &nbsp;
            </td>
          </tr>
          <tr>
            <td>
                Usuário: (*)</td>
          </tr>
          <tr>
            <td style="height: 19px">
                <asp:TextBox ID="txtUsuario" runat="server" Width="200px" MaxLength="15"></asp:TextBox>
                (mínimo 06 caracteres)</td>
          </tr>
          <tr>
            <td>Senha: (*)</td>
          </tr>
          <tr>
            <td style="height: 19px">
                <asp:TextBox ID="txtUsuarioSenha" runat="server" Width="200px" MaxLength="10" TextMode="Password"></asp:TextBox>
                (mínimo 06 caracteres)</td>
          </tr>
          <tr>
            <td>Confirmar Senha: (*)</td>
          </tr>
          <tr>
            <td style="height: 24px">
                <asp:TextBox ID="txtUsuarioConfirmarSenha" runat="server" Width="200px" MaxLength="10" TextMode="Password"></asp:TextBox></td>
          </tr>
      </table>

    </fieldset>
    <br />
    <fieldset>
          <table style="width:100%;">
        <tr>
            <td align="center"> 
              <asp:Button ID="btnNovo" runat="server"
                  Text="Novo Usuário" OnClick="btnNovo_Click" CausesValidation="False" />
                &nbsp;&nbsp; &nbsp;
                <asp:Button ID="btnSalvarUsuario" runat="server"
                  Text="Salvar Usuario" OnClick="btnSalvarUsuario_Click" /></td>
        </tr>
      </table>
    </fieldset>
    
    <fieldset>
    <legend>Lista de Usuários</legend>
    <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
    <td>
        <asp:GridView ID="GridUsuario" runat="server" AutoGenerateColumns="False"
            BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
            CellPadding="3" CssClass="texto" DataKeyNames="Id"
            PageSize="5" Width="100%" OnRowCommand="GridUsuario_RowCommand">
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <Columns>
                <asp:BoundField DataField="Status" HeaderText="Status">
                    <HeaderStyle ForeColor="Black" HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Nome" HeaderText="Nome">
                    <HeaderStyle ForeColor="Black" HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Usuario" HeaderText="Usuario">
                    <HeaderStyle ForeColor="Black" HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Perfil" HeaderText="Perfil">
                    <HeaderStyle ForeColor="Black" HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Editar" ImageUrl="~/Template/Img/alterar.gif" CommandArgument='<%#Eval("ID")%>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="ImageButton1" runat="server" CommandArgument='<%#Eval("ID")%>'
                            CommandName="Deletar" ImageUrl="~/Template/Img/excluir.gif" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle ForeColor="#000066" />
            <SelectedRowStyle BackColor="WhiteSmoke" Font-Bold="True" ForeColor="Black" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <HeaderStyle BackColor="#F3F7FC" Font-Bold="True" ForeColor="White" />
        </asp:GridView>
        &nbsp;
    </td>
    </tr>
    </table>
    </fieldset>
    </div>
    
    </form>
</body>
</html>
