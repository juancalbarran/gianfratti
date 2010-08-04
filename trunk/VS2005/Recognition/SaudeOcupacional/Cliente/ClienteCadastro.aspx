<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="ClienteCadastro.aspx.cs" Inherits="Cliente_ClienteCadastro" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<fieldset style="height: 100%">
<legend  align="center">&nbsp;Cadastro de Cliente&nbsp;</legend>

<fieldset>
<legend  align=left >&nbsp;Ficha&nbsp;</legend>
    <table border="0" cellpadding="0" cellspacing="1" style="width: 100%; height: 100%" class="texto">
        <tr>
            <td style="width: 10%; height: 34px;" valign="middle">
                <asp:DropDownList ID="DdlTipoIdentificacao" runat="server" DataSourceID="SqlDataSource1"
                    DataTextField="Nome" DataValueField="id">
                </asp:DropDownList>:<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnString %>"
                    SelectCommand="SELECT [id], [Nome] FROM [TipoIdentificacao]"></asp:SqlDataSource>
            </td>
            <td style="width: 18%; height: 34px;" valign="middle">
                <asp:TextBox ID="TxtCNPJ_INCRA_CPF" onKeyPress="return MascaraCampo(this.form.name, this, '99.999.999/9999-99', event);" runat="server" Width="133px" MaxLength="18"></asp:TextBox><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtCNPJ_INCRA_CPF"
                    Display="Dynamic" ErrorMessage="Campo obrigatório"></asp:RequiredFieldValidator></td>
            <td style="width: 10%; height: 34px;" valign="middle">
                Insc. Estatual:</td>
            <td colspan="7" valign="middle" style="height: 34px">
                <asp:TextBox ID="TxtInscEstatual" onKeyPress="return MascaraCampo(this.form.name, this, '999999999999', event);" runat="server" MaxLength="12" Width="82px"></asp:TextBox></td>
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
                <asp:TextBox ID="TxtCep" onKeyPress="return MascaraCampo(this.form.name, this, '99999-999', event);" runat="server" MaxLength="9" Width="89px"></asp:TextBox></td>
            <td colspan="1" style="width: 10%; height: 13px" valign="middle">
                Cidade:</td>
            <td colspan="1" style="width: 18%; height: 13px" valign="middle">
                <asp:TextBox ID="TxtCidade" runat="server"  MaxLength="50" Width="133px"></asp:TextBox></td>
            <td colspan="1" style="width: 5%; height: 13px" valign="middle">
                UF:</td>
            <td colspan="1" style="width: 16%; height: 13px" valign="middle">
                <asp:TextBox ID="TxtUF" runat="server" MaxLength="2" Width="38px"></asp:TextBox></td>
        </tr>
         <tr>
            <td style="width: 10%; height: 13px;" valign="middle">
                Telefone:</td>
            <td style="width: 18%; height: 13px" valign="top">
                <asp:TextBox ID="TxtDDDtel"  runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99', event);" Width="20px" MaxLength="2"></asp:TextBox>
                <asp:TextBox ID="TxtTelefone" onKeyPress="return MascaraCampo(this.form.name, this, '9999-9999', event);" MaxLength="9" runat="server" Width="114px"></asp:TextBox></td>
            <td style="width: 10%; height: 13px;" valign="middle">
                Fax:</td>
            <td colspan="3" style="width: 13%; height: 13px" valign="top">
                <asp:TextBox ID="TxtDDDfax" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99', event);" Width="20px" MaxLength="2"></asp:TextBox>
                <asp:TextBox ID="TxtFax" onKeyPress="return MascaraCampo(this.form.name, this, '9999-9999', event);" runat="server" MaxLength="9" Width="66px"></asp:TextBox></td>
            <td colspan="1" style="width: 10%; height: 13px" valign="middle">
                Contato:</td>
            <td colspan="1" style="height: 13px" valign="middle">
                <asp:TextBox ID="TxtContato" runat="server"  MaxLength="50" Width="133px"></asp:TextBox></td>
                <td>
                E-Mail:</td>
                <td>
                <asp:TextBox ID="TxtEmail" runat="server"  MaxLength="50" Width="145px"></asp:TextBox><br />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtEmail"
                    Display="Dynamic" ErrorMessage="E-Mail inválido" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></td>
                        
        </tr>
        <tr>
            <td style="width: 10%; height: 13px" valign="middle">
                Médico Resp.:</td>
            <td colspan="9" style="height: 13px" valign="top">
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:cnnString %>"
                    SelectCommand="SELECT [id], [Nome] FROM [Profissional]"></asp:SqlDataSource>
                <asp:DropDownList ID="DdlProfissional" runat="server" DataSourceID="SqlDataSource2"
                    DataTextField="Nome" DataValueField="id" OnDataBound="DdlProfissional_DataBound"
                    Width="356px">
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td style="width: 10%; height: 13px" valign="middle">
                CNAE:</td>
            <td style="width: 18%; height: 13px" valign="top">
                <asp:TextBox ID="TxtCNAE" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '9999-9', event);" MaxLength="6" Width="118px"></asp:TextBox>
                <a href="javascript:AbrePopUp('/SaudeOcupacional/Tabelas/CNAE/PopUp/CNAEPopUp.aspx','750','500',this,event)"><img src="\SaudeOcupacional\Template\img\pesquisa.gif" border="0" WIDTH="15" HEIGHT="13"></a></td>
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

<fieldset>
<legend  align=left >&nbsp;Departamento&nbsp;</legend>
    <table border="0" cellpadding="0" cellspacing="1" style="width: 100%; height: 100%" class="texto">
        <tr>
            <td style="width: 10%;" valign="middle">
                Departamento:</td>
            <td colspan="9" style="width: 40%;" valign="middle">
                <asp:TextBox ID="TxtDepartamento" runat="server" MaxLength="50" Width="338px"></asp:TextBox></td>
            <td colspan="1" style="width: 50%" valign="middle">
                <asp:Button ID="BtnIncluirDepartamento" runat="server" OnClick="BtnIncluirDepartamento_Click"
                    Text="Incluir" CausesValidation="False" /></td>
        </tr>
    </table>
</fieldset>

<fieldset>
<legend  align=left >&nbsp;Setor&nbsp;</legend>
    <table border="0" cellpadding="0" cellspacing="1" style="width: 100%; height: 100%" class="texto">
        <tr>
            <td style="width: 10%; height: 13px;" valign="middle">
                Departamento:</td>
            <td colspan="10" style="width: 40%; height: 13px;" valign="middle">
                <asp:PlaceHolder ID="phlDrop" runat="server"></asp:PlaceHolder>
                </td>
        </tr>
        <tr>
            <td style="width: 10%; height: 13px;" valign="middle">
                Setor:</td>
            <td colspan="9" style="width: 40px" valign="middle">
                <asp:TextBox ID="TxtSetor" runat="server" MaxLength="50" Width="338px"></asp:TextBox></td>
            <td colspan="1" style="width: 50px" valign="middle">
                <asp:Button ID="BtnIncluirSetor" runat="server" OnClick="BtnIncluirSetor_Click"
                    Text="Incluir" CausesValidation="False" /></td>
        </tr>
    </table>
</fieldset>

<fieldset>
    <legend  align=left >&nbsp;Lista de Departamentos e Setores&nbsp;</legend>
        <table border="0" cellpadding="0" cellspacing="1" style="width: 100%; height: 100%" class="texto">
            <tr>
                <td colspan="10" style="height: 13px" valign="middle"><asp:Label ID="LblDepartamentos" runat="server" Height="109px" Width="449px"><%this.ListaDepartamentosSetores();%></asp:Label></td>
            </tr>
        </table>
</fieldset>

<asp:Button ID="BtnSalvar" runat="server" OnClick="BtnSalvar_Click" Text="Salvar" /></fieldset>

</asp:Content>

