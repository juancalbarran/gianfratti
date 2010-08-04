<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Detalhes.aspx.cs" Inherits="Tabelas_CBO_PopUp_Detalhes" %>
<link href="../../../Template/Css/default.css" rel="stylesheet" type="text/css" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <a href="javascript:history.go(-1)">VOLTAR</a> 
        <fieldset>
            <legend>Detalhes</legend>
        <table id="Table1" width="100%" class="texto" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td style="width: 66px">
                    <span style="font-size: 9pt"><strong>
                    CBO:</strong></span></td>
                <td>
                    <asp:Label ID="lblCBO" runat="server" Text="Label" Font-Size="9.3pt" Font-Bold="True"></asp:Label></td>
            </tr>    
            <tr>
                <td style="width: 66px">
                    </td>
                <td></td>
            </tr>
            <tr>
                <td style="width: 66px; height: 15px;">
                    <span style="font-size: 9pt"><strong>
                    Função:</strong></span></td>
                <td style="height: 15px">
                    <asp:Label ID="labelFuncao" runat="server" Text="Label" Font-Size="9.3pt" Font-Bold="True"></asp:Label></td>
            </tr>
            <tr align="right">
                <td style="width: 66px">
                    &nbsp;</td>
                <td>
                    <input id="btnVoltar" onclick="javascript:history.go(-1)" type="button" value="Voltar" />&nbsp;</td>
            </tr>    
        </table>
        <table id="Table2" width="100%" class="texto" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <span style="font-size: 9pt"><strong>Descrição Sumária:</strong></span></td>
            </tr>    
            <tr>
                <td style="height: 120px">
                    <asp:TextBox ID="txtResumida" runat="server" Height="120px" TextMode="MultiLine" Width="99%" ReadOnly="True" Font-Size="10pt" Font-Bold="True"></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    <span style="font-size: 9pt"><strong>Condições de Exercício:</strong></span></td>
            </tr>
            <tr>
                <td style="height: 120px">
                    <asp:TextBox ID="txtDetalhada" runat="server" Height="120px" TextMode="MultiLine" Width="99%" ReadOnly="True" Font-Size="10pt" Font-Bold="True"></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    <span style="font-size: 9pt"><strong>Formação e Experiência:</strong></span></td>
            </tr>
            <tr>
                <td style="height: 110px">
                    <asp:TextBox ID="txtFormacaoExperiencia" runat="server" Height="110px" TextMode="MultiLine" Width="99%" ReadOnly="True" Font-Size="10pt" Font-Bold="True"></asp:TextBox></td>
            </tr>                                                           
            <tr>
                <td>
                    <span style="font-size: 9pt"><strong>Exceção:</strong></span></td>
            </tr>
            <tr>
                <td style="height: 90px">
                    <asp:TextBox ID="txtExcecao" runat="server" Height="90px" TextMode="MultiLine" Width="99%" ReadOnly="True" Font-Size="10pt" Font-Bold="True"></asp:TextBox></td>
            </tr>            <tr>
                <td>
                    <span style="font-size: 9pt"><strong>Sinônimos:</strong></span></td>
            </tr>
            <tr>
                <td style="height: 90px">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" BorderStyle="Double" BorderWidth="3px" CellPadding="4" CssClass="texto" GridLines="Horizontal" Width="100%" AllowSorting="True">
                                <FooterStyle BackColor="#2E5CB8" ForeColor="White" BorderColor="#2E5CB8" BorderStyle="None" />
                                <RowStyle BackColor="White" ForeColor="#333333" />
                                <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2E5CB8" ForeColor="White" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#2E5CB8" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:BoundField DataField="Nom_Sin" HeaderText="Ocupa&#231;&#245;es" >
                                <HeaderStyle ForeColor="White" HorizontalAlign="Left" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
        </table>
        </fieldset>
    </form>
</body>
</html>
