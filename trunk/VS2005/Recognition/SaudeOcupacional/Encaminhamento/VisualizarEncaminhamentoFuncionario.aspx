<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VisualizarEncaminhamentoFuncionario.aspx.cs"
    Inherits="Encaminhamento_VisualizarEncaminhamentoFuncionario" %>
<link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />

<%@ Register Src="../UserControls/ClienteFuncionario/FuncionarioDadosBasicos.ascx"
    TagName="FuncionarioDadosBasicos" TagPrefix="uc1" %>
<%@ Register Src="../UserControls/Menu/Menu.ascx" TagName="Menu" TagPrefix="uc2" %>
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
                    <td style="width: 1081px; border: 1; border-style: solid; border-color: Black; background-color: #f5f5f5;
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
            <legend align="center">Encaminhameno Funcionário</legend>
            <uc1:FuncionarioDadosBasicos ID="FuncionarioDadosBasicos1" runat="server" />
            <br />
            <table border="1" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0" class="texto" width="100%">
                            <tr>
                                <td>
                                    <span style="font-size: 10pt; font-family: Arial;"><strong>Tipo de Atestado Clínico:</strong></span></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblTipoAtestadoClinico" runat="server" Font-Bold="True" Text="Label"
                                        Font-Names="Arial" Font-Size="9pt"></asp:Label></td>
                            </tr>
                            <tr style="font-size: 9pt">
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <table border="1" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0" class="texto" width="100%">
                            <tr>
                                <td>
                                    <span style="font-size: 9pt; font-family: Arial;"><strong>Exames <span style="font-size: 10pt">
                                        Complementares</span>:</strong></span></td>
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
            <table border="1" cellpadding="0" cellspacing="0" style="font-size: 9pt" width="100%">
                <tr>
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0" class="texto" width="100%">
                            <tr>
                                <td>
                                    <span style="font-size: 10pt; font-family: Arial"><strong>Médico Examinador:</strong></span></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblMedicoExaminador" runat="server" Font-Bold="True" Text="Label"
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
            <table border="1" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0" class="texto" width="100%">
                            <tr>
                                <td>
                                    <span style="font-size: 10pt; font-family: Arial;"><strong>Data da Realização:</strong></span></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblDataRealizacao" runat="server" Font-Bold="True" Text="Label" Font-Names="Arial"
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
