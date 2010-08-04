<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="ExamesComplementaresCadastro.aspx.cs" Inherits="Tabelas_ExamesComplementares_ExamesComplementaresCadastro" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<fieldset>
    <legend align="center">Exames Complementares</legend>
    <fieldset style="height:100%">
    <legend>Cadastro de Exames</legend>
    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
        <tr>
            <td style="height: 19px;" colspan="3">
                Tipo de Exame:</td>
        </tr>
        <tr>
            <td style="width: 532px">
                <asp:TextBox ID="txtTipoExame" runat="server" Width="100%"></asp:TextBox></td>
            <td>
                &nbsp;<asp:Button ID="btnSalvar" runat="server" Text="Salvar" OnClick="btnSalvar_Click" /></td>
        </tr>
    </table>
    </fieldset>
    </fieldset>
</asp:Content>

