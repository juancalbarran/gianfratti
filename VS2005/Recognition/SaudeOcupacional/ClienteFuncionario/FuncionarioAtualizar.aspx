<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="FuncionarioAtualizar.aspx.cs" Inherits="ClienteFuncionario_FuncionarioAtualizar" Title="Untitled Page" %>

<%@ Register Src="../UserControls/DropDownList/Estados.ascx" TagName="Estados" TagPrefix="uc3" %>

<%@ Register Src="../UserControls/DropDownList/ClienteDepartamento.ascx" TagName="ClienteDepartamento"
    TagPrefix="uc2" %>

<%@ Register Src="../UserControls/DropDownList/Cliente.ascx" TagName="Cliente" TagPrefix="uc1" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
        <link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />
    <script language="JavaScript" type="text/javascript" src="../JS/Funcoes.js"></script>
</head>
<body>

<form id="form1" runat="server">

<fieldset>
<legend  align=left >&nbsp;Cliente&nbsp;</legend>
<table class=texto style="width: 100%; height: 100%" border="0" cellpadding="0" cellspacing="1">
    <tr>
        <td style="height: 19px">
            <uc1:Cliente ID="DdlCliente" runat="server" />
        </td>
    </tr>
</table>
</fieldset>

<fieldset runat="server" id="TblFichaPessoal">
<legend  align=left >&nbsp;Ficha Pessoal&nbsp;</legend>
    <table class=texto style="width: 100%; height: 100%" border="0" cellpadding="0" cellspacing="1">
        <tr>
            <td style="width: 100px">
                CPF:</td>
            <td style="width: 100px">
                RG:</td>
            <td style="width: 100px">
                Data Expedição:</td>
            <td colspan="3">
                UF Emissão: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Orgão Expeditor:</td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="TxtCPF" onblur="javascript:Verifica_CPF(this);" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '999.999.999-99', event);" MaxLength="14"></asp:TextBox>
                </td>
            <td style="width: 100px">
                <asp:TextBox ID="TxtRG" runat="server" MaxLength="15"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TxtDtExpedicao" onblur="javascript:valida_data(this);" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99/99/9999', event);" MaxLength="10" Width="79px"></asp:TextBox></td>
            <td colspan="3">
                <asp:TextBox ID="TxtRgUFemissao" runat="server" MaxLength="2" Width="24px"></asp:TextBox>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp;<asp:DropDownList ID="DdlOrgaoExpeditor" runat="server" CssClass="texto" DataSourceID="ObjectDataSource1"
                    DataTextField="Descricao" DataValueField="ID" Width="59%" OnDataBound="DdlOrgaoExpeditor_DataBound">
                </asp:DropDownList>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="TipoOrgaoExpeditorDropDownList"
                    TypeName="ClienteFuncionarioDAL"></asp:ObjectDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="6">
                Nome:</td>
        </tr>
        <tr>
            <td colspan="6" style="height: 23px">
                <asp:TextBox ID="TxtNome" runat="server" Width="100%" MaxLength="100"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px">
                Data Nasc.:</td>
            <td style="width: 100px">
                Data Obito:</td>
            <td style="width: 100px">
                Sexo:</td>
            <td colspan="3">
                Estado Civil:</td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox onblur="javascript:valida_data(this);" ID="TxtDtNascimento" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99/99/9999', event);" MaxLength="10"></asp:TextBox>
                </td>
            <td style="width: 100px">
                <asp:TextBox onblur="javascript:valida_data(this);" ID="TxtDtObito" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99/99/9999', event);" MaxLength="10"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:DropDownList ID="DdlSexo" runat="server">
                    <asp:ListItem Value="" >&lt;-Selecione-&gt;</asp:ListItem>
                    <asp:ListItem Value="M">Masculino</asp:ListItem>
                    <asp:ListItem Value="F">Feminino</asp:ListItem>
                </asp:DropDownList></td>
            <td colspan="3">
                <asp:DropDownList ID="DdlEstadoCivil" runat="server">
                    <asp:ListItem Value="">&lt;-Selecione-&gt;</asp:ListItem>
                    <asp:ListItem>Solteiro</asp:ListItem>
                    <asp:ListItem>Casado</asp:ListItem>
                    <asp:ListItem>Separado</asp:ListItem>
                    <asp:ListItem>Vi&#250;vo</asp:ListItem>
                    <asp:ListItem>Outros</asp:ListItem>
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td style="width: 100px">
                Nome da mãe:</td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td colspan="3">
            </td>
        </tr>
        <tr>
            <td colspan="6" style="height: 23px">
                <asp:TextBox ID="TxtMae" runat="server" Width="100%" MaxLength="100"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px; height: 13px;">
                End. Residencial:</td>
            <td style="width: 100px; height: 13px;">
                Número:</td>
            <td style="width: 100px; height: 13px;">
                Complemento:</td>
            <td style="width: 100px; height: 13px;">
                </td>
            <td style="width: 130px; height: 13px;">
                </td>
            <td style="width: 100px; height: 13px">
                &nbsp; &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 100px; height: 21px;">
                <asp:TextBox ID="TxtEndResidencia" runat="server" MaxLength="100"></asp:TextBox></td>
            <td style="width: 100px; height: 21px;">
                <asp:TextBox ID="TxtNumero" runat="server" Width="146px" MaxLength="50"></asp:TextBox></td>
            <td style="width: 100px; height: 21px;">
                <asp:TextBox ID="TxtConplemento" runat="server" MaxLength="50"></asp:TextBox></td>
            <td style="width: 100px; height: 21px;">
                </td>
            <td style="width: 130px; height: 21px;">
                </td>
            <td style="width: 100px; height: 21px;">
                </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 21px">
                Cidade:</td>
            <td style="width: 100px; height: 21px">
                Bairro:</td>
            <td style="width: 100px; height: 21px">
                CEP:</td>
            <td style="width: 100px; height: 21px">
                UF:</td>
            <td style="width: 130px; height: 21px">
            </td>
            <td style="width: 100px; height: 21px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 21px">
                <asp:TextBox ID="TxtCidade" runat="server" MaxLength="50"></asp:TextBox></td>
            <td style="width: 100px; height: 21px">
                <asp:TextBox ID="TxtBairro" runat="server" Width="129px" MaxLength="50"></asp:TextBox></td>
            <td style="width: 100px; height: 21px">
                <asp:TextBox ID="TxtCEP" runat="server" MaxLength="9" onkeypress="return MascaraCampo(this.form.name, this, '99999-99', event);"
                    Width="65px"></asp:TextBox></td>
            <td style="width: 100px; height: 21px">
                <uc3:Estados ID="ddlEstados" runat="server" />
            </td>
            <td style="width: 130px; height: 21px">
            </td>
            <td style="width: 100px; height: 21px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                Telefone:</td>
            <td style="width: 100px">
                Celular:</td>
            <td style="width: 100px">
                Tel.: Contato:</td>
            <td colspan="3">
                Nome Contato:</td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="TxtDDDtel" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99', event);" MaxLength="2" Width="20px"></asp:TextBox>
                <asp:TextBox ID="TxtTelefone" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '9999-9999', event);" Width="73px" MaxLength="9"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TxtDDDcel" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99', event);" MaxLength="2" Width="20px"></asp:TextBox>
                <asp:TextBox ID="TxtCelular" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '9999-9999', event);" Width="73px" MaxLength="9"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TxtDDDContato" runat="server" MaxLength="2" onkeypress="return MascaraCampo(this.form.name, this, '99', event);"
                    Width="20px"></asp:TextBox>
                <asp:TextBox ID="TxtTelefoneContato" runat="server" onkeypress="return MascaraCampo(this.form.name, this, '9999-9999', event);"
                    Width="73px" MaxLength="9"></asp:TextBox></td>
            <td colspan="3">
                <asp:TextBox ID="TxtContatoNome" runat="server" MaxLength="100" Width="100%"></asp:TextBox></td>
        </tr>
    </table>

</fieldset>

    <br />
<fieldset>
    <table style="width: 100%">
        <tr>
            <td align="center" style="width: 100%"> <asp:Button ID="BtnSalvar" runat="server" Text="Salvar Ficha Pessoal" OnClick="BtnSalvar_Click" /></td>
        </tr>
    </table>
</fieldset>

</form>
</body>
</html>

