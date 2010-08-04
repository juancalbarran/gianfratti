<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Guias_PaginasAuxiliares_Prorrogacoes_Default" %>

<link href="../../../Template/Css/default.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" type="text/javascript" src="../../../JS/Funcoes.js"></script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script language=javascript type="text/javascript"> 
ID = PegaParamentro(self.location.href,'ID')
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
<fieldset>
<legend>Cadastro de Prorrogações</legend>
    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Template/Img/botao_cadastro.gif" OnClick="ImageButton1_Click" />
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete"
        SelectMethod="SelectAll" TypeName="TissObjetos.ProrrogacoesDAL">
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="idGuiaSolicitacaoInternacao" QueryStringField="idGuiaSolicitacaoInternacao"
                Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
        CellPadding="3" CssClass="texto" DataKeyNames="ID" DataSourceID="ObjectDataSource1"
        PageSize="20" Width="100%">
        <FooterStyle BackColor="White" ForeColor="#000066" />
        <Columns>
            <asp:BoundField DataField="Data" HeaderText="Data" />
            <asp:BoundField DataField="Responsavel" HeaderText="Respons&#225;vel" />
            <asp:BoundField DataField="TipoAcomodacao" HeaderText="Tipo Acomoda&#231;&#227;o" />
            <asp:BoundField DataField="QtdAutorizada" HeaderText="Qtd Autorizada" />
            <asp:HyperLinkField DataNavigateUrlFields="ID,idGuiaSolicitacaoInternacao" DataNavigateUrlFormatString="ProrrogacoesCadastro.aspx?ID={0}&amp;idGuiaSolicitacaoInternacao={1}"
                Text="&lt;img src=&quot;../../../Template/Img/alterar.gif&quot; border=&quot;0&quot; alt=&quot;Visualizar&quot;&gt;" />
            <asp:CommandField ButtonType="Image" DeleteImageUrl="../../../Template/Img/excluir.gif"
                ShowDeleteButton="True" />
        </Columns>
        <RowStyle ForeColor="#000066" />
        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
    </asp:GridView>
</fieldset>
    </form>
</body>
</html>
