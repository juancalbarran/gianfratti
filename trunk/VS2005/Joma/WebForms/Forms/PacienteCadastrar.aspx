<%@ Page Language="C#" MasterPageFile="~/Template/Template01.master" AutoEventWireup="true"
    CodeFile="PacienteCadastrar.aspx.cs" Inherits="Forms_PacienteCadastrar" Title="Smart Health Care - Cadastro Paciente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset style="height: 100%">
        <legend align="center">Paciente</legend>
        <fieldset>
            <legend>Registro</legend>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
                <tr>
                    <td colspan="2" style="height: 19px">
                        Nome:</td>
                    <td width="15%" style="height: 19px">
                        Sexo:</td>
                    <td colspan="2" style="height: 19px">
                        Data Nascimento:</td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 24px">
                        <asp:TextBox ID="txtNome" runat="server" Width="450px" Obrigatorio="1" AliasCampo="Nome"></asp:TextBox></td>
                    <td style="height: 24px">
                        <asp:DropDownList ID="ddlSexo" runat="server" Obrigatorio="1" AliasCampo="Sexo">
                            <asp:ListItem Value="">&lt;--Selecione --&gt;</asp:ListItem>
                            <asp:ListItem Value="M">Masculino</asp:ListItem>
                            <asp:ListItem Value="F">Feminino</asp:ListItem>
                        </asp:DropDownList></td>
                    <td colspan="2" style="height: 24px">
                        <asp:TextBox ID="txtDtNascimento" runat="server" MaxLength="10" Obrigatorio="1" AliasCampo="Data de Nascimento"
                            onblur="javascript:valida_data(this);" onkeypress="return MascaraCampo(this.form.name, this, '99/99/9999', event);"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td width="27%">
                        RG:</td>
                    <td colspan="4">
                        CPF:</td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtRG" runat="server" MaxLength="20" Width="163px" Obrigatorio="1"
                            AliasCampo="RG"></asp:TextBox></td>
                    <td colspan="4">
                        <asp:TextBox ID="txtCPF" runat="server" Width="163px" MaxLength="14" Obrigatorio="1"
                            AliasCampo="CPF" onkeypress="return MascaraCampo(this.form.name, this, '999.999.999-99', event);"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        Endere&ccedil;o:</td>
                    <td width="18%">
                        Bairro:</td>
                    <td>
                        CEP:</td>
                    <td width="17%">
                        Cidade:</td>
                    <td width="23%">
                        UF:</td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtEndereco" runat="server" Width="250px" Obrigatorio="1" AliasCampo="Endereço"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtBairro" runat="server" Width="163px" Obrigatorio="1" AliasCampo="Bairro"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtCEP" runat="server" Width="69px" MaxLength="9" Obrigatorio="1"
                            AliasCampo="CEP" onkeypress="return MascaraCampo(this.form.name, this, '99999-999', event);"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtCidade" runat="server" Obrigatorio="1" AliasCampo="Cidade"></asp:TextBox></td>
                    <td>
                        <asp:DropDownList ID="ddlUF" runat="server" Obrigatorio="1" AliasCampo="Sexo">
                            <asp:ListItem Value=" ">&lt;--Selecione --&gt;</asp:ListItem>
                            <asp:ListItem Value="AL">AL</asp:ListItem>
                            <asp:ListItem Value="AP">AP</asp:ListItem>
                            <asp:ListItem Value="AM">AM</asp:ListItem>
                            <asp:ListItem Value="BA">BA</asp:ListItem>
                            <asp:ListItem Value="CE">CE</asp:ListItem>
                            <asp:ListItem Value="DF">DF</asp:ListItem>
                            <asp:ListItem Value="ES">ES</asp:ListItem>
                            <asp:ListItem Value="GO">GO</asp:ListItem>
                            <asp:ListItem Value="MA">MA</asp:ListItem>
                            <asp:ListItem Value="MT">MT</asp:ListItem>
                            <asp:ListItem Value="MS">MS</asp:ListItem>
                            <asp:ListItem Value="MG">MG</asp:ListItem>
                            <asp:ListItem Value="PA">PA</asp:ListItem>
                            <asp:ListItem Value="PB">PB</asp:ListItem>
                            <asp:ListItem Value="PR">PR</asp:ListItem>
                            <asp:ListItem Value="PE">PE</asp:ListItem>
                            <asp:ListItem Value="PI">PI</asp:ListItem>
                            <asp:ListItem Value="RJ">RJ</asp:ListItem>
                            <asp:ListItem Value="RN">RN</asp:ListItem>
                            <asp:ListItem Value="RS">RS</asp:ListItem>
                            <asp:ListItem Value="RO">RO</asp:ListItem>
                            <asp:ListItem Value="RR">RR</asp:ListItem>
                            <asp:ListItem Value="SC">SC</asp:ListItem>
                            <asp:ListItem Value="SP">SP</asp:ListItem>
                            <asp:ListItem Value="SE">SE</asp:ListItem>
                            <asp:ListItem Value="TO">TO</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td style="height: 19px">
                        Telefone:</td>
                    <td colspan="2" style="height: 19px">
                        Celular:</td>
                    <td colspan="2" style="height: 19px">
                        Email:</td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtTelefone" runat="server" Width="250px" MaxLength="13" onkeypress="return MascaraCampo(this.form.name, this, '(99)9999-9999', event);"></asp:TextBox></td>
                    <td colspan="2">
                        <asp:TextBox ID="txtCelular" runat="server" MaxLength="13" onkeypress="return MascaraCampo(this.form.name, this, '(99)9999-9999', event);"
                            Width="163px"></asp:TextBox></td>
                    <td colspan="2">
                        <asp:TextBox ID="txtEmail" runat="server" Width="260px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        Conv&ecirc;nio:</td>
                    <td colspan="2">
                        Número Convênio:</td>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlConvenio" runat="server" AliasCampo="Nome do Convênio" Obrigatorio="1">
                        </asp:DropDownList></td>
                    <td colspan="2">
                        <asp:TextBox ID="txtNumeroConvenio" runat="server" MaxLength="100" Width="163px"></asp:TextBox></td>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="5">
                        Observa&ccedil;&otilde;es:</td>
                </tr>
                <tr>
                    <td colspan="5" style="height: 38px">
                        <asp:TextBox ID="txtObs" runat="server" TextMode="MultiLine" Width="94%" Height="70px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="5" style="height: 19px">
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="5">
                        <asp:Button ID="BtnCadastrar" runat="server" Text="Cadastrar" OnClick="BtnCadastrar_Click"
                            OnClientClick='return ValidaTexto(this.form)' />
                        &nbsp; &nbsp;<input type="button" value="Voltar" onclick="history.go(-1)">
                        &nbsp;
                    </td>
                </tr>
            </table>
        </fieldset>
    </fieldset>
</asp:Content>
