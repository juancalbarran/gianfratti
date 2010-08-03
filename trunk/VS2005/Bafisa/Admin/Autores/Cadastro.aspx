<%@ Page Language="C#" MasterPageFile="~/Admin/Template/TemplateAdmin.master" AutoEventWireup="true" CodeFile="Cadastro.aspx.cs" Inherits="Admin_Autores_Cadastro" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<fieldset>
<legend>Cadastro de Autores</legend>
    <table class="texto" style="width:100%" cellpadding="0" cellspacing="0" border="0" >
    <tr>
        <td>Nome:</td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtNome" runat="server" Width="50%"></asp:TextBox></td>
    </tr>
    <tr>
        <td>Descrição:</td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="txtDescricao" runat="server" TextMode="MultiLine" Width="50%" Height="110px"></asp:TextBox></td>
    </tr>
    <tr>
        <td>Foto:</td>
    </tr>
    <tr>
        <td><a href="javascript:AbrePopUp('../Tabelas/CNAE/PopUp/CNAEPopUp.aspx','750','500',this,event)"></a>
            <asp:FileUpload ID="arquivo" runat="server" /></td>
    </tr>
    </table>
    <br />
<fieldset>
    <table class="texto" style="width:100%" cellpadding="0" cellspacing="0" border="0" >
    <tr>
        <td style="text-align:center">
            <asp:Button ID="Button1" runat="server" PostBackUrl="~/Admin/Autores/Default.aspx"
                Text="Voltar" />&nbsp;
            <asp:Button ID="btnSalvar" runat="server" Text="Salvar" OnClick="btnSalvar_Click" /></td>
    </tr>
    </table>
</fieldset>
</fieldset>
</asp:Content>

