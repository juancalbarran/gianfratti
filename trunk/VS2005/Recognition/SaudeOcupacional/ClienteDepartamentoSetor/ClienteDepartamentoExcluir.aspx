<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClienteDepartamentoExcluir.aspx.cs" Inherits="ClienteDepartamentoSetor_ClienteDepartamentoExcluir" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" type="text/javascript" src="../JS/Funcoes.js"></script>
    <title>Excluir Departamento</title>
</head>
<body style="margin:5px">
    <form id="form1" runat="server">
    <div>
        <asp:Button ID="btnVoltar" runat="server" OnClick="btnVoltar_Click" Text="Voltar" />
        <div style="height:3px"></div>
        <div style=" border: 1px solid #2A7BA7; BackGround-Color:#F9F9FD; height:15px; text-align:center; padding: 2px;"
>Excluir Departamento</div><div style="height:3px"></div>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="ClienteDepartamentoDelete"
            SelectMethod="SelectDepartamentoAll" TypeName="ClienteDepartamentoSetorDAL">
            <DeleteParameters>
                <asp:Parameter Name="Id" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="idCliente" QueryStringField="idCliente" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Id"
            DataSourceID="ObjectDataSource1" Width="100%">
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <Columns>
                <asp:BoundField DataField="Nome" HeaderText="Departamento" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:HyperLinkField Text="Excluir Setor" DataNavigateUrlFields="Id,idCliente" DataNavigateUrlFormatString="ClienteSetorExcluir.aspx?idClienteDepartamento={0}&amp;idCliente={1}" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
            <RowStyle ForeColor="#000066" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
        </asp:GridView>
    </form>
</body>
</html>
