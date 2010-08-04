<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CaraterInternacao.ascx.cs" Inherits="UserControls_Dominio_DropDownList_CaraterInternacao" %>
<asp:DropDownList ID="ddlCaraterInternacao" runat="server" CssClass="texto">
</asp:DropDownList>&nbsp;<asp:RequiredFieldValidator ID="ValidaCaraterInternacao"
    runat="server" ControlToValidate="ddlCaraterInternacao" Display="None" ErrorMessage="Caráter de internação"
    SetFocusOnError="True"></asp:RequiredFieldValidator>
