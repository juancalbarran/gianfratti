<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmpresaCadastro.aspx.cs" Inherits="Empresa_EmpresaCadastro"%>

<%@ Register Src="../UserControls/DropDownList/Estados.ascx" TagName="Estados" TagPrefix="uc1" %>
<html>
<head>
<link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />
</head>
<body>

<form id="form" runat="server">
    <input type="hidden" id="hddidEmpresa" runat="server"/>
    <br/>
    <fieldset style="height: 100%">
    <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td colspan="4">CNPJ:</td>
        <td colspan="1" style="width: 1426px">Inscri&ccedil;&atilde;o Estadual:</td>
      </tr>
      <tr>
        <td colspan="4">
            <asp:TextBox ID="txtCNPJ" runat="server" Width="199px" MaxLength="18" onKeyPress="return MascaraCampo(this.form.name, this, '99.999.999/9999-99', event);" ></asp:TextBox></td>
        <td colspan="2">
            <asp:TextBox ID="txtInscEstadual" runat="server" Width="214px"></asp:TextBox></td>
      </tr>
      <tr>
        <td colspan="6" style="height: 19px">Raz&atilde;o Social:</td>
      </tr>
      <tr>
        <td colspan="6" style="height: 19px">
            <asp:TextBox ID="txtRazaoSocial" runat="server" Width="100%"></asp:TextBox></td>
       </tr>
      <tr>
        <td colspan="6" style="height: 19px">Endere&ccedil;o:</td>
      </tr>
      <tr>
        <td colspan="6" style="height: 19px">
            <asp:TextBox ID="txtEndereco" runat="server" Width="100%"></asp:TextBox></td>
      </tr>
      <tr>
        <td colspan="2">Bairro:</td>
        <td colspan="2">CEP:</td>
        <td style="width: 1426px"></td>
        <td width="25%"></td>
      </tr>
      <tr>
        <td colspan="2">
            <asp:TextBox ID="txtBairro" runat="server" Width="195px"></asp:TextBox></td>
        <td colspan="2">
            <asp:TextBox ID="txtCEP" runat="server" Width="195px" MaxLength="9" onKeyPress="return MascaraCampo(this.form.name, this, '99999-999', event);"></asp:TextBox></td>
        <td style="width: 1426px">
            </td>
        <td>
            &nbsp;</td>
      </tr>
        <tr>
            <td colspan="2" style="height: 13px">
                Cidade:</td>
            <td colspan="2" style="height: 13px">
                UF:</td>
            <td style="width: 1426px; height: 13px">
            </td>
            <td style="height: 13px">
            </td>
        </tr>
        <tr>
            <td colspan="2">
            <asp:TextBox ID="txtCidade" runat="server" Width="195px"></asp:TextBox></td>
            <td colspan="2">
            <uc1:Estados ID="ddlEstados" runat="server" />
            </td>
            <td style="width: 1426px">
            </td>
            <td>
            </td>
        </tr>
      <tr>
        <td style="height: 19px">DDD:</td>
        <td style="width: 64px; height: 19px;">Telefone</td>
        <td style="height: 19px">DDD</td>
        <td style="height: 19px; width: 249px;">Fax</td>
        <td style="width: 1426px; height: 19px;"></td>
        <td style="height: 19px"></td>
      </tr>
      <tr>
        <td width="4%" style="height: 19px">
            <asp:TextBox ID="txtDDDtel" runat="server" Width="35px" MaxLength="2" onKeyPress="return MascaraCampo(this.form.name, this, '99', event);"></asp:TextBox></td>
        <td style="width: 64px; height: 19px;"><asp:TextBox ID="txtTel" runat="server" Width="156px" MaxLength="9" onKeyPress="return MascaraCampo(this.form.name, this, '9999-9999', event);"></asp:TextBox></td>
        <td width="4%" style="height: 19px">
            <asp:TextBox ID="txtDDDFax" runat="server" Width="35px" MaxLength="2" onKeyPress="return MascaraCampo(this.form.name, this, '99', event);"></asp:TextBox></td>
        <td style="height: 19px; width: 249px;"><asp:TextBox ID="txtFax" runat="server" Width="154px" MaxLength="9" onKeyPress="return MascaraCampo(this.form.name, this, '9999-9999', event);"></asp:TextBox></td>
        <td style="height: 19px; width: 1426px;"></td>
        <td style="height: 19px"></td>
      </tr>
        <tr>
            <td colspan="2" style="height: 19px">
                Nome Contato:</td>
            <td colspan="2" style="height: 19px">
                E-mail:</td>
            <td style="width: 1426px; height: 19px">
            </td>
            <td style="height: 19px">
            </td>
        </tr>
        <tr>
            <td colspan="2" style="height: 19px">
                <asp:TextBox ID="txtContato" runat="server" Width="194px"></asp:TextBox></td>
            <td colspan="2" style="height: 19px">
                <asp:TextBox ID="txtEmail" runat="server" Width="195px"></asp:TextBox></td>
            <td style="width: 1426px; height: 19px">
            </td>
            <td style="height: 19px">
            </td>
        </tr>
    </table>
    
    </fieldset>

    <br />
    
    <fieldset>
    <table style="width:100%;">
    <tr>
    <td align="center">
        <asp:Button ID="BtnSalvar" runat="server" OnClick="BtnSalvar_Click" Text="Salvar" /></td>
    </tr>
    </table>
    </fieldset>
    
</form>

</body>
</html>
