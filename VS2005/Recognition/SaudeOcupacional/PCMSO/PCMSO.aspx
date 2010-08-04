<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PCMSO.aspx.cs" Inherits="PCMSO_PCMSO"
    Title="Untitled Page" %>

<%@ Register Src="../UserControls/Cliente/ClienteDadosBasicos.ascx" TagName="ClienteDadosBasicos"
    TagPrefix="uc1" %>

<link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />
<html>
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server" class="texto">
        <fieldset style="height: 100%">
        <legend align="center">PCMSO</legend>
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr align="center" valign="top">
                    <td style="font-size: 12; height: 20px; width: 1133px;">
                        Parâmetros para Monitoramentos da Exposição Ocupacional a Alguns Riscos à Saúde
                        (NR-7)</td>
                    <td rowspan="2" style="width: 42px">
                        <div id="esconder">
                            <a href="#">
                                <img alt="Imprimir" style="border: 0px; width: 32px; height: 29px;" src="../Template/Img/icoImprimir.jpg"
                                    onclick="document.getElementById('esconder').style.display='none'; window.print(); document.getElementById('esconder').style.display='inline';" /></a>&nbsp;</div>
                    </td>
                </tr>
                <tr><td style="width: 1133px">
            </td>
                </tr>
            </table>
            <uc1:ClienteDadosBasicos ID="ClienteDadosBasicos1" runat="server" />
            <br />
            <asp:GridView ID="GridView1" runat="server" Width="100%" AutoGenerateColumns="False"
                OnRowDataBound="GridView1_RowDataBound" CssClass="texto">
                <FooterStyle BackColor="White" ForeColor="#000066"></FooterStyle>
                <RowStyle ForeColor="#000066" HorizontalAlign="Left" VerticalAlign="Top"></RowStyle>
                <SelectedRowStyle BackColor="#669999" ForeColor="White" Font-Bold="True"></SelectedRowStyle>
                <PagerStyle BackColor="#F3F7FC" ForeColor="Gray" HorizontalAlign="Center"></PagerStyle>
                <HeaderStyle BackColor="#F3F7FC" ForeColor="Black" HorizontalAlign="Left" Font-Bold="True">
                </HeaderStyle>
                <Columns>
                    <asp:BoundField DataField="Setor" HeaderText="Setor"></asp:BoundField>
                    <asp:BoundField DataField="Cargo" HeaderText="Cargo"></asp:BoundField>
                    <asp:BoundField DataField="Riscos" HeaderText="Riscos"></asp:BoundField>
                    <asp:BoundField DataField="Admissional" HeaderText="Admissional"></asp:BoundField>
                    <asp:BoundField DataField="Periodico" HeaderText="Peri&#243;dico"></asp:BoundField>
                    <asp:BoundField DataField="Demissional" HeaderText="Demissional"></asp:BoundField>
                    <asp:BoundField DataField="Mudanca_Funcao" HeaderText="Mudan&#231;a de Fun&#231;&#227;o">
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
            &nbsp;
        </fieldset>
    </form>
</body>
</html>
