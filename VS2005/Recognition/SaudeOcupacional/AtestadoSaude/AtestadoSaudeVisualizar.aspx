<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AtestadoSaudeVisualizar.aspx.cs"
    Inherits="AtestadoSaude_AtestadoSaudeVisualizar" %>

<link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
        <fieldset>
            <table cellpadding="0" cellspacing="0" width="100%" class="texto">
                <tr>
                    <td style="width: 1081px; border: 1; border-style: solid; border-color: Black; background-color: #f5f5f5;
                        font-size: 30pt; font-family: Times New Roman;" align="center">
                        <strong><span style="font-size: 0.72em">
                        ATESTADO DE SAÚDE OCUPACIONAL (ASO)</span></strong></td>
                    <td style="width: 90px">
                        <img src="../Template/Img/LOGOMK.gif" alt="MK Assessoria em Saúde" /></td>
                </tr>
                <tr>
                    <td align="right" colspan="2">
                        <div id="esconder">
                            <a href="#">
                                <img alt="Imprimir" style="border: 0px; width: 32px; height: 29px;" src="../Template/Img/icoImprimir.jpg"
                                    onclick="document.getElementById('esconder').style.display='none'; window.print(); document.getElementById('esconder').style.display='inline';" /></a>&nbsp;</div>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
                <tr>
                    <td style="height: 19px; width: 1179px;">
                        <strong>Tipo de Atestado:</strong></td>
                </tr>
                <tr>
                    <td style="width: 1179px">
                        <asp:Label ID="lblTipoAtestado" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 1179px">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 1179px">
                        <table class="texto" style="width: 100%">
                            <tr>
                                <td align="center" style="width: 100%">
                                    <span style="font-size: 10pt"><strong>EM CUMPRIMENTO ÀS PORTARIAS Nºs. 3214/78, 3214/82,
                                        12/83, 24/94, E 8/96 DA NR7
                                        <br />
                                        DO MINISTÉRIO DO TRABALHO. PARA FINS DE EXAME</strong></span></td>
                            </tr>
                            <tr>
                                <td align="center" style="width: 100%">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td style="width: 100%">
                                    <b>Atesto para fins de trabalho que o(a) Sr.(a)</b>
                                    <asp:Label ID="lblNome" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td style="width: 100%; height: 21px">
                                    <b>RG: </b>
                                    <asp:Label ID="lblRG" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td style="width: 100%">
                                    <b>Exercendo a função de: </b>
                                    <asp:Label ID="lblFuncao" runat="server"></asp:Label>
                                    <strong>CBO</strong>:
                                    <asp:Label ID="lblCBO" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td style="width: 100%">
                                    <b>Empresa: </b>
                                    <asp:Label ID="lblCliente" runat="server"></asp:Label>&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100%">
                                    <b>Grau de Risco: </b>
                                    <asp:Label ID="lblRisco" runat="server"></asp:Label>&nbsp;
                                </td>
                            </tr>
                        </table>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 1179px">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 1179px">
                        &nbsp;</td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" border="1" width="100%" class="texto" style="font-size: 12pt">
                <tr>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
                            <tr>
                                <td>
                                    <strong>Riscos:</strong></td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td style="height: 13px">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>Observações:</strong></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblObservacoes" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                        &nbsp;</td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
                <tr>
                    <td colspan="4">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="4">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="4">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 17%">
                        <strong>Foi considerado(a)</strong></td>
                    <td style="width: 15%">
                        <asp:Label ID="lblStatusAtestado" runat="server"></asp:Label></td>
                    <td style="width: 14%">
                        <strong>c/ Pendência</strong></td>
                    <td style="width: 51%">
                        <asp:Label ID="lblPendencia" runat="server"></asp:Label>
                        &nbsp;&nbsp; <b>para exercer a função.</b></td>
                </tr>
                <tr>
                    <td colspan="4">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td style="width: 17%">
                        <strong>Médico Examinador:</strong></td>
                    <td colspan="3">
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 17%">
                        <strong>CRM: </strong>
                    </td>
                    <td style="width: 15%">
                    </td>
                    <td style="width: 14%">
                        <strong>Data da Consulta:</strong></td>
                    <td style="width: 51%">
                        <asp:Label ID="lblDataConsulta" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="4">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="4">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="4">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="4">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="4">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="4">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="4">
                        &nbsp;</td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" border="0" class="texto" width="100%">
                <tr>
                    <td align="center" colspan="2">
                        ___________________________________________________</td>
                    <td align="center" colspan="2">
                        ___________________________________________________</td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                        <strong>Assinatura / Carimbo - Médico Examinador</strong></td>
                    <td align="center" colspan="2">
                        <strong>Visto Funcionário</strong></td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                    </td>
                    <td align="center" colspan="2">
                        Declaro ter recebido</td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                    </td>
                    <td align="center" colspan="2">
                        cópia deste atestado</td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" border="0" class="texto" width="100%">
                <tr>
                    <td style="width: 1174px">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 1174px">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 1174px">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="center" style="width: 1174px">
                        <strong>Médico Coordenador PCMSO: Dr(a). </strong>
                        <asp:Label ID="lblMedicoResp" runat="server"></asp:Label><strong> CRM: </strong>
                        <asp:Label ID="lblConselhoNumero" runat="server"></asp:Label><strong> - </strong>
                        <asp:Label ID="lblConselhoUF" runat="server"></asp:Label><strong>&nbsp; </strong>
                    </td>
                </tr>
                <tr>
                    <td style="width: 1174px">
                    </td>
                </tr>
            </table>
        </fieldset>
    </form>
</body>
</html>
