<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CNAE20PopUp.aspx.cs" Inherits="Tabelas_CNAE20_PopUp_CNAE20PopUp" %>

<link href="../../../Template/Css/default.css" rel="stylesheet" type="text/css" />

<script language="JavaScript" type="text/javascript" src="../../../JS/Funcoes.js"></script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
        <fieldset>
            <legend>Busca</legend>
            <table id="Table1" width="100%" class="texto">
                <tr>
                    <td>
                        Sub-Classe:</td>
                    <td>
                        Descrição:</td>
                    <td>
                        Grau de Risco:</td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td id="Td1" runat="server">
                        <asp:TextBox ID="txtSubClasse" runat="server" MaxLength="10" onkeypress="return MascaraCampo(this.form.name, this, '99.99-9/99', event);"
                            Width="118px"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtDescricao" runat="server" Width="404px"></asp:TextBox></td>
                    <td>
                        <asp:DropDownList ID="txtRisco" runat="server">
                            <asp:ListItem Value="">&lt;-Selecione-&gt;</asp:ListItem>
                            <asp:ListItem Value="1">1</asp:ListItem>
                            <asp:ListItem Value="2">2</asp:ListItem>
                            <asp:ListItem Value="3">3</asp:ListItem>
                        </asp:DropDownList></td>
                    <td>
                        <asp:Button ID="Button1" runat="server" Text="Buscar" /></td>
                </tr>
            </table>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                BorderStyle="Double" BorderWidth="3px" CellPadding="4" CssClass="texto" GridLines="Horizontal"
                Width="100%" AllowPaging="True" AllowSorting="True" PageSize="18" OnPageIndexChanging="GridView1_PageIndexChanging">
                <FooterStyle BackColor="#2E5CB8" ForeColor="White" BorderColor="#2E5CB8" BorderStyle="None" />
                <Columns>
                    <asp:BoundField DataField="Secao" HeaderText="Se&#231;&#227;o">
                        <HeaderStyle BackColor="#2E5CB8" ForeColor="White" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Divisao" HeaderText="Divis&#227;o">
                        <HeaderStyle BackColor="#2E5CB8" ForeColor="White" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Grupo_Classe" HeaderText="Classe">
                        <HeaderStyle BackColor="#2E5CB8" ForeColor="White" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="SubClasse" HeaderText="Sub-Classe">
                        <HeaderStyle BackColor="#2E5CB8" ForeColor="White" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Descricao" HeaderText="Descri&#231;&#227;o">
                        <HeaderStyle BackColor="#2E5CB8" ForeColor="White" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Grau_Risco" HeaderText="Risco">
                        <HeaderStyle BackColor="#2E5CB8" ForeColor="White" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:HyperLinkField DataNavigateUrlFields="SubClasse,Descricao,Grau_Risco" Text="&lt;img src=&quot;../../../Template/Img/alterar.gif&quot;  border=0 /&gt;"
                        DataNavigateUrlFormatString="CNAE20PopUp.aspx?Numero={0}&amp;Denominacao={1}&amp;Risco={2}">
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:HyperLinkField>
                </Columns>
                <RowStyle BackColor="White" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2E5CB8" ForeColor="White" HorizontalAlign="Center" />
                <HeaderStyle BackColor="#2E5CB8" Font-Bold="True" ForeColor="White" />
            </asp:GridView>
            &nbsp;
        </fieldset>
    </form>
</body>
</html>
