<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VisualizarEncaminhamentoCandidato.aspx.cs"
    Inherits="Encaminhamento_VisualizarEncaminhamentoCandidato" %>

<link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
        <fieldset style="height: 100%">
            <table cellpadding="0" cellspacing="0" width="100%" class="texto">
                <tr>
                    <td style="width: 1081px; border: 1; border-style:solid; border-color: Black; background-color: #f5f5f5; 
                        font-size: 36pt; font-family: Times New Roman;" align="center">
                        <span style="font-size: 28pt">Encaminhamento</span></td>
                    <td style="width: 90px">
                        <img src="../Template/Img/LOGOMK.gif" alt="MK Assessoria em Saúde" /></td>
                </tr>
                <tr>
                    <td align="right" colspan="2">
                        <div id="esconder">
                            <a href="#">
                                <img alt="Imprimir" style="border: 0px; width: 32px; height: 29px;" src="../Template/Img/icoImprimir.jpg"
                                    onclick="document.getElementById('esconder').style.display='none'; window.print(); document.getElementById('esconder').style.display='inline';" /></a>&nbsp;
                        </div>
                    </td>
                </tr>
            </table>
            <legend align="center">Encaminhamento Processo Seletivo</legend>
            <table width="100%" border="1" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" class="texto">
                            <tr>
                                <td>
                                    <span style="font-size: 10pt; font-family: Arial;"><strong>Razão Social:</strong></span></td>
                            </tr>
                            <tr>
                                <td style="height: 13px">
                                    <asp:Label ID="lblRazaoSocial" runat="server" Text="Label" Font-Bold="True" Font-Names="Arial"
                                        Font-Size="9pt"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <table width="100%" border="1" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" class="texto">
                            <tr>
                                <td>
                                    <span style="font-size: 10pt"><strong><span style="font-family: Arial">Nome Candidato</span>:</strong></span></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblNomeCandidato" runat="server" Text="Label" Font-Bold="True" Font-Names="Arial"
                                        Font-Size="9pt"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <table width="100%" border="1" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" class="texto">
                            <tr>
                                <td>
                                    <span style="font-size: 10pt; font-family: Arial;"><strong>Tipo de Atestado Clínico:</strong></span></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblTipoAtestadoClinico" runat="server" Text="Label" Font-Bold="True"
                                        Font-Names="Arial" Font-Size="9pt"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <table width="100%" border="1" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" class="texto">
                            <tr>
                                <td>
                                    <span style="font-size: 10pt; font-family: Arial;"><strong>Exames Complementares:</strong></span></td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%"
                                        Font-Bold="True" Font-Size="9pt" Font-Names="Arial">
                                        <Columns>
                                            <asp:BoundField DataField="Descricao">
                                                <HeaderStyle BorderStyle="None" Font-Size="0pt" Height="0px" />
                                                <ItemStyle BorderStyle="None" Font-Bold="True" Font-Names="Arial" Font-Size="9pt" />
                                            </asp:BoundField>
                                        </Columns>
                                        <FooterStyle BorderStyle="None" />
                                        <PagerStyle BorderStyle="None" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <table width="100%" border="1" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" class="texto">
                            <tr>
                                <td>
                                    <span style="font-size: 10pt; font-family: Arial;"><strong>Médico Examinador:</strong></span></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblMedicoExaminador" runat="server" Text="Label" Font-Bold="True"
                                        Font-Names="Arial" Font-Size="9pt"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <table width="100%" border="1" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" class="texto">
                            <tr>
                                <td>
                                    <span style="font-size: 10pt; font-family: Arial;"><strong>Data da Realização:</strong></span></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblDataRealizacao" runat="server" Text="Label" Font-Bold="True" Font-Names="Arial"
                                        Font-Size="9pt"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </fieldset>
    </form>
</body>
</html>
