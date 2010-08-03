<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Catalogo._Default" %>

<%@ Register assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" namespace="System.Web.UI.WebControls" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" 
        BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="ID" 
        GridLines="Horizontal" onrowcommand="GridView1_RowCommand">
        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" 
                SortExpression="ID" />
            <asp:BoundField DataField="Titulo" HeaderText="Titulo" 
                SortExpression="Titulo" />
            <asp:BoundField DataField="Sinopse" HeaderText="Sinopse" 
                SortExpression="Sinopse" />
            <asp:BoundField DataField="ISBN" HeaderText="ISBN" SortExpression="ISBN" />
            <asp:BoundField DataField="Edicao" HeaderText="Edicao" 
                SortExpression="Edicao" />
            <asp:BoundField DataField="Autor" HeaderText="Autor" SortExpression="Autor" />
            <asp:BoundField DataField="Paginas" HeaderText="Paginas" 
                SortExpression="Paginas" />
            <asp:BoundField DataField="Img" HeaderText="Img" SortExpression="Img" />
            <asp:BoundField DataField="Tags" HeaderText="Tags" SortExpression="Tags" />
            <asp:BoundField DataField="Observacao" HeaderText="Observacao" 
                SortExpression="Observacao" />
            <asp:TemplateField HeaderText="Editar">
                <ItemTemplate>
                    <asp:Button ID="BtnEditar" runat="server" CommandArgument='<%# Eval("ID")%>' 
                        CommandName="Editar" Text="Editar" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
        <AlternatingRowStyle BackColor="#F7F7F7" />
    </asp:GridView>
    </form>
</body>
</html>
