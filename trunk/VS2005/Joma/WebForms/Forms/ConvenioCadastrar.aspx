<%@ Page Language="C#" MasterPageFile="~/Template/Template01.master" AutoEventWireup="true" CodeFile="ConvenioCadastrar.aspx.cs" Inherits="Forms_ConvenioCadastrar" Title="Smart Health Care - Cadastro de Convênios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset style="height: 100%">
        <legend align="center">Convênio</legend>
        <fieldset>
            <legend>Registro</legend>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
                <tr>
                    <td width="33%">
                        Nome:</td>
                    <td width="14%">
                        Valor Sessão:</td>
                    <td width="53%">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtNome" runat="server" Width="318px" Obrigatorio="1" AliasCampo="Nome"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtValor" runat="server" Obrigatorio="1" AliasCampo="Valor" onKeyPress="return(FormataMoeda(this,'.',',',event))"></asp:TextBox></td>
                    <td>
                        &nbsp;&nbsp;
                        <asp:Button ID="BtnCadastrar" runat="server" Text="Salvar" OnClick="BtnCadastrar_Click" OnClientClick='return ValidaTexto(this.form)' /></td>
                </tr>
            </table>
        </fieldset>
    </fieldset>
</asp:Content>
