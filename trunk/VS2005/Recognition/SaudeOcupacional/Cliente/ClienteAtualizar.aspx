<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClienteAtualizar.aspx.cs"
    Inherits="Cliente_ClienteAtualizar" Title="Untitled Page" %>

<%@ Register Src="../UserControls/DropDownList/Estados.ascx" TagName="Estados" TagPrefix="uc3" %>
<%@ Register Src="../UserControls/DropDownList/TipoIdentificacao.ascx" TagName="TipoIdentificacao"
    TagPrefix="uc1" %>
<%@ Register Src="../UserControls/DropDownList/Profissional.ascx" TagName="Profissional"
    TagPrefix="uc2" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />

    <script language="JavaScript" type="text/javascript" src="../JS/Funcoes.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <br />
        <fieldset>
            <table border="0" cellpadding="0" cellspacing="1" style="width: 100%; height: 100%"
                class="texto">
                <tr>
                    <td style="width: 10%; height: 34px;" valign="middle">
                        &nbsp;<uc1:TipoIdentificacao ID="DdlTipoIdentificacao" runat="server" />
                    </td>
                    <td style="width: 18%; height: 34px;" valign="middle">
                        <asp:TextBox ID="TxtCNPJ_INCRA_CPF" onKeyPress="return MascaraCampo(this.form.name, this, '99.999.999/9999-99', event);"
                            runat="server" Width="133px" MaxLength="18"></asp:TextBox><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtCNPJ_INCRA_CPF"
                            Display="Dynamic" ErrorMessage="Campo obrigatório"></asp:RequiredFieldValidator></td>
                    <td style="width: 10%; height: 34px;" valign="middle">
                        Insc. Estatual:</td>
                    <td colspan="7" valign="middle" style="height: 34px">
                        <asp:TextBox ID="TxtInscEstatual" onKeyPress="return MascaraCampo(this.form.name, this, '999999999999', event);"
                            runat="server" MaxLength="12" Width="82px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="height: 13px" valign="middle">
                        Razão Social:</td>
                    <td colspan="9" style="height: 13px" valign="top">
                        <asp:TextBox ID="TxtRazaoSocial" runat="server" MaxLength="100" Width="100%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtRazaoSocial"
                            Display="Dynamic" ErrorMessage="Campo obrigatório"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td style="height: 13px" valign="middle">
                        Endereço:</td>
                    <td colspan="9" style="height: 13px" valign="top">
                        <asp:TextBox ID="TxtEndereco" runat="server" MaxLength="100" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 10%; height: 13px;" valign="middle">
                        Bairro:</td>
                    <td style="width: 18%; height: 13px" valign="top">
                        <asp:TextBox ID="TxtBairro" runat="server" MaxLength="50" Width="139px"></asp:TextBox></td>
                    <td style="width: 10%; height: 13px;" valign="middle">
                        CEP:</td>
                    <td colspan="3" style="width: 13%; height: 13px" valign="top">
                        <asp:TextBox ID="TxtCep" onKeyPress="return MascaraCampo(this.form.name, this, '99999-999', event);"
                            runat="server" MaxLength="9" Width="89px"></asp:TextBox></td>
                    <td colspan="1" style="width: 10%; height: 13px" valign="middle">
                    </td>
                    <td colspan="1" style="width: 18%; height: 13px" valign="middle">
                    </td>
                    <td colspan="1" style="width: 5%; height: 13px" valign="middle">
                    </td>
                    <td colspan="1" style="width: 16%; height: 13px" valign="middle">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 10%; height: 13px" valign="middle">
                        Cidade:</td>
                    <td style="width: 18%; height: 13px" valign="top">
                        <asp:TextBox ID="TxtCidade" runat="server" MaxLength="50" Width="139px"></asp:TextBox></td>
                    <td style="width: 10%; height: 13px" valign="middle">
                        UF:</td>
                    <td colspan="4" style="height: 13px" valign="middle">
                        <uc3:Estados ID="ddlEstados" runat="server" />
                    </td>
                    <td colspan="1" style="width: 18%; height: 13px" valign="middle">
                    </td>
                    <td colspan="1" style="width: 5%; height: 13px" valign="middle">
                    </td>
                    <td colspan="1" style="width: 16%; height: 13px" valign="middle">
                    </td>
                </tr>
                <tr>
                    <td style="width: 10%; height: 13px;" valign="middle">
                        Telefone:</td>
                    <td style="width: 18%; height: 13px" valign="top">
                        <asp:TextBox ID="TxtDDDtel" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99', event);"
                            Width="20px" MaxLength="2"></asp:TextBox>
                        <asp:TextBox ID="TxtTelefone" onKeyPress="return MascaraCampo(this.form.name, this, '9999-9999', event);"
                            MaxLength="9" runat="server" Width="114px"></asp:TextBox></td>
                    <td style="width: 10%; height: 13px;" valign="middle">
                        Fax:</td>
                    <td colspan="3" style="width: 13%; height: 13px" valign="top">
                        <asp:TextBox ID="TxtDDDfax" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99', event);"
                            Width="20px" MaxLength="2"></asp:TextBox>
                        <asp:TextBox ID="TxtFax" onKeyPress="return MascaraCampo(this.form.name, this, '9999-9999', event);"
                            runat="server" MaxLength="9" Width="66px"></asp:TextBox></td>
                    <td colspan="1" style="width: 10%; height: 13px" valign="middle">
                    </td>
                    <td colspan="1" style="height: 13px" valign="middle">
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td style="width: 10%; height: 13px" valign="middle">
                        Contato:</td>
                    <td style="width: 18%; height: 13px" valign="top">
                        <asp:TextBox ID="TxtContato" runat="server" MaxLength="50" Width="139px"></asp:TextBox></td>
                    <td style="width: 10%; height: 13px" valign="middle">
                        E-Mail:</td>
                    <td colspan="4" style="height: 13px" valign="middle">
                        <asp:TextBox ID="TxtEmail" runat="server" MaxLength="50" Width="209px"></asp:TextBox><br />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtEmail"
                            Display="Dynamic" ErrorMessage="E-Mail inválido" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></td>
                    <td colspan="1" style="height: 13px" valign="middle">
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td style="width: 10%; height: 13px" valign="middle">
                        Méd. Coordenador:</td>
                    <td colspan="9" style="height: 13px" valign="top">
                        <uc2:Profissional ID="DdlProfissional" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 10%; height: 13px" valign="middle">
                        Méd. Examinador:</td>
                    <td colspan="9" style="height: 13px" valign="top">
                        <uc2:Profissional ID="DdlProfissional1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 10%; height: 13px" valign="middle">
                        Méd. Examinador:</td>
                    <td colspan="9" style="height: 13px" valign="top">
                        <uc2:Profissional ID="DdlProfissional2" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 10%; height: 13px" valign="middle">
                        Méd. Examinador:</td>
                    <td colspan="9" style="height: 13px" valign="top">
                        <uc2:Profissional ID="DdlProfissional3" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 10%; height: 13px" valign="middle">
                        CNAE:</td>
                    <td style="width: 18%; height: 13px" valign="top">
                        <asp:TextBox ID="TxtCNAE" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99.99-9/99', event);"
                            MaxLength="10" Width="118px"></asp:TextBox>
                        <a href="javascript:AbrePopUp('../Tabelas/CNAE20/PopUp/CNAE20PopUp.aspx','800','600',this,event)">
                            <img src="..\Template\img\pesquisa.gif" border="0" width="15" height="13"></a></td>
                    <td colspan="6" style="height: 13px" valign="middle">
                        <asp:TextBox ID="TxtDenominacao" runat="server" Width="100%" ReadOnly="True"></asp:TextBox></td>
                    <td>
                        Risco:</td>
                    <td>
                        <asp:TextBox ID="TxtRisco" runat="server" MaxLength="1" ReadOnly="True" Width="38px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="width: 10%; height: 13px;" valign="middle">
                        GFIP:</td>
                    <td style="height: 13px" valign="top" colspan="9">
                        <asp:TextBox ID="TxtGFIP" runat="server" MaxLength="10" Width="47px"></asp:TextBox>
                        &nbsp;&nbsp;
                    </td>
                </tr>
            </table>
        </fieldset>
        <br />
        <fieldset>
            <table border="0" cellpadding="0" cellspacing="1" style="width: 100%; height: 100%"
                class="texto">
                <tr>
                    <td align="center">
                        <asp:Button ID="BtnSalvar" runat="server" OnClick="BtnSalvar_Click" Text="Salvar" /></td>
                </tr>
            </table>
        </fieldset>
    </form>
</body>
</html>
