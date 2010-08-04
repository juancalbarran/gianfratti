<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RegimeInternacao.ascx.cs" Inherits="UserControls_Dominio_DropDownList_RegimeInternacao" %>
<asp:DropDownList ID="ddlRegimeInternacao" runat="server" CssClass="texto">
</asp:DropDownList><asp:RequiredFieldValidator ID="ValidaRegimeInternacao" runat="server"
    ControlToValidate="ddlRegimeInternacao" Display="None" ErrorMessage="Regime de internação"
    SetFocusOnError="True"></asp:RequiredFieldValidator>
