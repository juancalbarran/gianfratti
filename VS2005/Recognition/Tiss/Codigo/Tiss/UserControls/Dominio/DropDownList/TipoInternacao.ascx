<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TipoInternacao.ascx.cs" Inherits="UserControls_Dominio_DropDownList_TipoInternacao" %>
<asp:DropDownList ID="ddlTipoInternacao" runat="server" CssClass="texto">
</asp:DropDownList>&nbsp;<asp:RequiredFieldValidator ID="ValidaTipoInternacao"
    runat="server" ControlToValidate="ddlTipoInternacao" Display="None" ErrorMessage="Tipo de internação"
    SetFocusOnError="True"></asp:RequiredFieldValidator>
