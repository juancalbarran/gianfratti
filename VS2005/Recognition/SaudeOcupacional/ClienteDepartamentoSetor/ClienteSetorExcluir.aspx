<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClienteSetorExcluir.aspx.cs" Inherits="ClienteDepartamentoSetor_ClienteSetorExcluir" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" type="text/javascript" src="../JS/Funcoes.js"></script>
    <title>Excluir Setor</title>
</head>
<body style="margin:5px;">
    <form id="form1" runat="server">
    <div>
        <asp:Button ID="btnVoltar" runat="server" OnClick="btnVoltar_Click" Text="Voltar" />
    <div style="height:3px"></div>
        <div style=" border: 1px solid #2A7BA7; BackGround-Color:#F9F9FD; height:15px; text-align:center; padding: 2px;"
>Excluir Setor</div><div style="height:3px"></div>
    </div>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="SelectSetorAll"
            TypeName="ClienteDepartamentoSetorDAL" DeleteMethod="ClienteSetorDelete">
            <SelectParameters>
                <asp:QueryStringParameter Name="idClienteDepartamento" QueryStringField="idClienteDepartamento"
                    Type="Int32" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="Id" Type="Int32" />
            </DeleteParameters>
        </asp:ObjectDataSource>
        <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#CCCCCC"
            BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="ObjectDataSource1" AutoGenerateColumns="False" DataKeyNames="Id" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="100%">
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <RowStyle ForeColor="#000066" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <Columns>
                <asp:BoundField DataField="Nome" HeaderText="Nome" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
