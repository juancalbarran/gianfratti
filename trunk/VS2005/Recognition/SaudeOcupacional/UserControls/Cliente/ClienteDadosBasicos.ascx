<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ClienteDadosBasicos.ascx.cs"
    Inherits="UserControls_Cliente_ClienteDadosBasicos" %>
<fieldset>
    <legend>Dados Empresa</legend>
    <table cellpadding="0" cellspacing="0" border="1" width="100%" class="texto">
        <tr>
            <td>
                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
                    <tr>
                        <td style="width: 56px; height: 17px">
                            CNPJ:</td>
                        <td style="height: 17px; width: 150px;">
                            <asp:Label ID="lblCNPJ" runat="server" Text="Label" Font-Bold="True"></asp:Label></td>
                        <td style="width: 93px">
                            Razão Social:</td>
                        <td>
                            <asp:Label ID="lblRazaoSocial" runat="server" Text="Label" Font-Bold="True"></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 17px">
                            Médico Coordenador:</td>
                        <td colspan="2" style="height: 17px">
                            <asp:Label ID="lblMedicoCoordenador" runat="server" Text="Label" Font-Bold="True"></asp:Label></td>
                        <td style="height: 17px">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</fieldset>
