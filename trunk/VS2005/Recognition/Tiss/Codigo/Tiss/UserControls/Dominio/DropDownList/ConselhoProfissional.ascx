<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ConselhoProfissional.ascx.cs" Inherits="UserControls_Dominio_DropDownList_ConselhoProfissional" %>
<asp:DropDownList ID="ddlConselhoProfissional" runat="server" CssClass="texto">
</asp:DropDownList>&nbsp;
<asp:RequiredFieldValidator ID="ValidaConselhoProfissional" runat="server" ControlToValidate="ddlConselhoProfissional"
    Display="None" ErrorMessage="Sigla do conselho profissional" SetFocusOnError="True"></asp:RequiredFieldValidator>
