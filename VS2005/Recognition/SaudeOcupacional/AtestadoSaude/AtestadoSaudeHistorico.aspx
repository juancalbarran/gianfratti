<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AtestadoSaudeHistorico.aspx.cs" Inherits="AtestadoSaude_AtestadoSaudeHistorico" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <fieldset>
    <legend>Histórico de Atestados</legend>
    <asp:GridView ID="GridHistoricoAtestadoSaude" runat="server"
        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
        CellPadding="3" CssClass="texto" PageSize="5" Width="100%" DataSourceID="ObjectDataSource3" DataKeyNames="ID" OnSelectedIndexChanged="GridHistoricoAtestadoSaude_SelectedIndexChanged" AutoGenerateColumns="False">
        <FooterStyle BackColor="White" ForeColor="#000066" />
        <RowStyle ForeColor="#000066" />
        <SelectedRowStyle BackColor="whitesmoke" Font-Bold="True" ForeColor="Black" />
        <PagerStyle BackColor="#F3F7FC" ForeColor="Gray" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#F3F7FC" Font-Bold="True" ForeColor="Black" HorizontalAlign="Left" />
        <Columns>
            <asp:BoundField DataField="DataConsulta" HeaderText="Data Consulta" />
            <asp:BoundField DataField="Nome" HeaderText="Funcion&#225;rio" />
            <asp:BoundField DataField="TipoAtestado" HeaderText="Tipo Atestado" />
            <asp:BoundField DataField="StatusAtestado" HeaderText="Status" />
            <asp:CommandField ShowSelectButton="True" ButtonType="Image" SelectImageUrl="~/Template/Img/alterar.gif" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="SelectHistoricoAtestadoSaude"
        TypeName="AtestadoSaudeDAL">
        <SelectParameters>
            <asp:QueryStringParameter Name="idFuncionario" QueryStringField="idFuncionario" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    </fieldset>
    </form>
</body>
</html>
