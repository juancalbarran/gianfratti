<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true"
    CodeFile="PCMSOCadastro.aspx.cs" Inherits="PCMSO_PCMSOCadastro" Title="Untitled Page" %>

<%@ Register Src="../UserControls/DropDownList/PCMSOPeriodicidade.ascx" TagName="PCMSOPeriodicidade"
    TagPrefix="uc8" %>

<%@ Register Src="../UserControls/DropDownList/RiscosOcupacionais.ascx" TagName="RiscosOcupacionais" TagPrefix="uc6" %>
<%@ Register Src="../UserControls/DropDownList/RiscosOcupacionaisItens.ascx" TagName="RiscosOcupacionaisItens" TagPrefix="uc7" %>
<%@ Register Src="../UserControls/DropDownList/ClienteCargo.ascx" TagName="ClienteCargo" TagPrefix="uc5" %>
<%@ Register Src="../UserControls/DropDownList/ClienteSetor.ascx" TagName="ClienteSetor" TagPrefix="uc4" %>
<%@ Register Src="../UserControls/DropDownList/Cliente.ascx" TagName="Cliente" TagPrefix="uc2" %>
<%@ Register Src="../UserControls/DropDownList/ClienteDepartamento.ascx" TagName="ClienteDepartamento" TagPrefix="uc3" %>
<%@ Register Src="../UserControls/DropDownList/ExamesComplementares.ascx" TagName="ExamesComplementares" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset style="height: 100%">
        <legend align="center">PCMSO</legend>
        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
            <tr align="right">
                <td>
                    <div id="esconder">
                        <a href="#">
                            </a>
                    </div>
                </td>
            </tr>
        </table>
        <fieldset>
            <legend>Cliente</legend>
            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
                <tr>
                    <td style="height: 25px" colspan="2">
                        <uc2:Cliente ID="ddlCliente" runat="server" />
                    </td>
                    <td rowspan="2" align="right">
                                        <div id="Div1">
                        <a href="#">
                            <img alt="Imprimir" style="border: 0px; width: 32px; height: 29px;" src="../Template/Img/icoImprimir.jpg"
                            onclick="document.getElementById('esconder').style.display='none'; window.print(); document.getElementById('esconder').style.display='inline';" /></a>
                    </div>
                    </td>
                </tr>
                <tr>
                    <td style="height: 2px;" colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 250px">
                        Departamento:</td>
                    <td style="width: 250px">
                        Setor:</td>
                    <td>
                        Cargo:</td>
                </tr>
                <tr>
                    <td style="width: 250px; height: 25px">
                        <uc3:ClienteDepartamento ID="ClienteDepartamento1" runat="server" />
                    </td>
                    <td style="height: 25px; width: 250px;">
                        <uc4:ClienteSetor ID="ClienteSetor1" runat="server"></uc4:ClienteSetor>
                    </td>
                    <td style="height: 25px">
                        <uc5:ClienteCargo ID="ClienteCargo1" runat="server" />
                    </td>
                </tr>
            </table>
        </fieldset>
        <fieldset>
            <legend>Riscos</legend>
            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
                <tr>
                    <td style="width: 250px">
                        Agente:</td>
                    <td>
                        Tipo de Risco:</td>
                </tr>
                <tr>
                    <td style="width: 250px; height: 25px;">
                        <uc6:RiscosOcupacionais ID="RiscosOcupacionais1" runat="server" />
                    </td>
                    <td style="height: 25px">
                        <uc7:RiscosOcupacionaisItens ID="RiscosOcupacionaisItens1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 250px; height: 25px;">
                        <uc6:RiscosOcupacionais ID="RiscosOcupacionais2" runat="server" />
                    </td>
                    <td style="height: 25px">
                        <uc7:RiscosOcupacionaisItens ID="RiscosOcupacionaisItens2" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 250px; height: 25px;">
                        <uc6:RiscosOcupacionais ID="RiscosOcupacionais3" runat="server" />
                    </td>
                    <td style="height: 25px">
                        <uc7:RiscosOcupacionaisItens ID="RiscosOcupacionaisItens3" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 250px; height: 25px;">
                        <uc6:RiscosOcupacionais ID="RiscosOcupacionais4" runat="server" />
                    </td>
                    <td style="height: 25px">
                        <uc7:RiscosOcupacionaisItens ID="RiscosOcupacionaisItens4" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 250px; height: 25px;">
                        <uc6:RiscosOcupacionais ID="RiscosOcupacionais5" runat="server" />
                    </td>
                    <td style="height: 25px">
                        <uc7:RiscosOcupacionaisItens ID="RiscosOcupacionaisItens5" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 250px; height: 25px;">
                        <uc6:RiscosOcupacionais ID="RiscosOcupacionais6" runat="server" />
                    </td>
                    <td style="height: 25px">
                        <uc7:RiscosOcupacionaisItens ID="RiscosOcupacionaisItens6" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 250px; height: 25px">
                        <uc6:RiscosOcupacionais ID="RiscosOcupacionais7" runat="server" />
                    </td>
                    <td style="height: 25px">
                        <uc7:RiscosOcupacionaisItens ID="RiscosOcupacionaisItens7" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 250px; height: 25px">
                        <uc6:RiscosOcupacionais ID="RiscosOcupacionais8" runat="server" />
                    </td>
                    <td style="height: 25px">
                        <uc7:RiscosOcupacionaisItens ID="RiscosOcupacionaisItens8" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 250px; height: 25px;">
                        <uc6:RiscosOcupacionais ID="RiscosOcupacionais9" runat="server" />
                    </td>
                    <td style="height: 25px">
                        <uc7:RiscosOcupacionaisItens ID="RiscosOcupacionaisItens9" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 250px; height: 25px;">
                        <uc6:RiscosOcupacionais ID="RiscosOcupacionais10" runat="server" />
                    </td>
                    <td style="height: 25px">
                        <uc7:RiscosOcupacionaisItens ID="RiscosOcupacionaisItens10" runat="server" />
                    </td>
                </tr>
            </table>
        </fieldset>
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr>
                <td width="49%">
                    <fieldset>
                        <legend>Admissional</legend>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
                            <tr>
                                <td width="3%" style="height: 25px">
                                    1.</td>
                                <td width="97%" style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlAdm1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    2.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlAdm2" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    3.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlAdm3" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    4.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlAdm4" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    5.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlAdm5" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    6.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlAdm6" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    7.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlAdm7" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    8.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlAdm8" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    9.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlAdm9" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    10.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlAdm10" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
                <td width="2%">
                </td>
                <td width="49%">
                    <fieldset>
                        <legend>Periódico</legend>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
                            <tr>
                                <td width="3%" style="height: 25px">
                                    1.</td>
                                <td style="height: 25px; width: 240px;">
                                    <uc1:ExamesComplementares ID="ddlPer1" runat="server" />
                                </td>
                                <td style="height: 25px">
                                    <uc8:PCMSOPeriodicidade ID="ddlPeriodicidade1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    2.</td>
                                <td style="height: 25px; width: 240px;">
                                    <uc1:ExamesComplementares ID="ddlPer2" runat="server" />
                                </td>
                                <td style="height: 25px">
                                    <uc8:PCMSOPeriodicidade ID="ddlPeriodicidade2" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    3.</td>
                                <td style="height: 25px; width: 240px;">
                                    <uc1:ExamesComplementares ID="ddlPer3" runat="server" />
                                </td>
                                <td style="height: 25px">
                                    <uc8:PCMSOPeriodicidade ID="ddlPeriodicidade3" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    4.</td>
                                <td style="height: 25px; width: 240px;">
                                    <uc1:ExamesComplementares ID="ddlPer4" runat="server" />
                                </td>
                                <td style="height: 25px">
                                    <uc8:PCMSOPeriodicidade ID="ddlPeriodicidade4" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    5.</td>
                                <td style="height: 25px; width: 240px;">
                                    <uc1:ExamesComplementares ID="ddlPer5" runat="server" />
                                </td>
                                <td style="height: 25px">
                                    <uc8:PCMSOPeriodicidade ID="ddlPeriodicidade5" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    6.</td>
                                <td style="height: 25px; width: 240px;">
                                    <uc1:ExamesComplementares ID="ddlPer6" runat="server" />
                                </td>
                                <td style="height: 25px">
                                    <uc8:PCMSOPeriodicidade ID="ddlPeriodicidade6" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    7.</td>
                                <td style="height: 25px; width: 240px;">
                                    <uc1:ExamesComplementares ID="ddlPer7" runat="server" />
                                </td>
                                <td style="height: 25px">
                                    <uc8:PCMSOPeriodicidade ID="ddlPeriodicidade7" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    8.</td>
                                <td style="height: 25px; width: 240px;">
                                    <uc1:ExamesComplementares ID="ddlPer8" runat="server" />
                                </td>
                                <td style="height: 25px">
                                    <uc8:PCMSOPeriodicidade ID="ddlPeriodicidade8" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    9.</td>
                                <td style="height: 25px; width: 240px;">
                                    <uc1:ExamesComplementares ID="ddlPer9" runat="server" />
                                </td>
                                <td style="height: 25px">
                                    <uc8:PCMSOPeriodicidade ID="ddlPeriodicidade9" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    10.</td>
                                <td style="height: 25px; width: 240px;">
                                    <uc1:ExamesComplementares ID="ddlPer10" runat="server" />
                                </td>
                                <td style="height: 25px">
                                    <uc8:PCMSOPeriodicidade ID="ddlPeriodicidade10" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td>
                    <fieldset>
                        <legend>Demissional</legend>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
                            <tr>
                                <td width="3%" style="height: 25px">
                                    1.</td>
                                <td width="97%" style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlDem1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    2.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlDem2" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    3.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlDem3" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    4.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlDem4" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    5.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlDem5" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 24px">
                                    6.</td>
                                <td style="height: 24px">
                                    <uc1:ExamesComplementares ID="ddlDem6" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    7.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlDem7" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    8.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlDem8" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    9.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlDem9" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    10.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlDem10" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
                <td>
                </td>
                <td>
                    <fieldset>
                        <legend>Mudan&ccedil;a de Função</legend>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
                            <tr>
                                <td width="3%" style="height: 25px">
                                    1.</td>
                                <td width="97%" style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlMud1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    2.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlMud2" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    3.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlMud3" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    4.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlMud4" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    5.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlMud5" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    6.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlMud6" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    7.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlMud7" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    8.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlMud8" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    9.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlMud9" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px">
                                    10.</td>
                                <td style="height: 25px">
                                    <uc1:ExamesComplementares ID="ddlMud10" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
        </table>
        <br />
        <fieldset>
            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="texto">
                <tr align="center">
                    <td>
                        <asp:Button ID="btnSalvar" runat="server" Text="Salvar" OnClick="btnSalvar_Click" /></td>
                </tr>
            </table>
        </fieldset>
    </fieldset>
</asp:Content>
