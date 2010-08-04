<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="CIAB_2007_SolicitacaoProcedimento_Default" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<fieldset style="height: 100%">
<legend>Gerenciador de Procedimentos Médicos</legend>
<fieldset>
<legend>Busca</legend>
<table style="width:100%;" class="texto" >
    <tr>
        <td>
            CRM do médico:</td>
        <td>Nome do paciente:</td>
        <td>Data Inicial de Emissão da Guia:</td>
        <td>Data Final de Emissão da Guia:</td>
        <td></td>
    </tr>
        <tr>
        <td>
            <asp:TextBox ID="txtCRM" runat="server" MaxLength="70"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="txtPaciente" runat="server" MaxLength="6"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="txtDtEmissaoInicial" runat="server" MaxLength="10" onKeyPress="return MascaraCampo(document.form, this, '99/99/9999', event);" onblur="javascript:valida_data(this);"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="txtDtEmissaoFinal" runat="server" MaxLength="10" onKeyPress="return MascaraCampo(document.form, this, '99/99/9999', event);" onblur="javascript:valida_data(this);"></asp:TextBox></td>
        <td>
            <asp:Button ID="btnBuscar" runat="server" Text="Buscar" /></td>
    </tr>
</table>
</fieldset>
<asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Template/Img/botao_cadastro.gif"
                    PostBackUrl="~/CIAB/2007/SolicitacaoProcedimento/FormCadastro.aspx" />
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"
        SelectMethod="SelectAll" TypeName="TissObjetos.CIAB2007SolicitacaoProcedimentoDAL" DeleteMethod="Delete">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtPaciente" Name="Paciente" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="txtCRM" Name="CRM" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtDtEmissaoInicial" Name="DtEmissaoInicial" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="txtDtEmissaoFinal" Name="DtEmissaoFinal" PropertyName="Text"
                Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </DeleteParameters>
    </asp:ObjectDataSource>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
        CellPadding="3" CssClass="texto" DataKeyNames="ID" DataSourceID="ObjectDataSource1"
        Width="100%" PageSize="25" OnRowDataBound="GridView1_RowDataBound" ShowFooter="True">
        <FooterStyle BackColor="#006699" ForeColor="#000066" />
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
            <asp:BoundField DataField="GuiaData" HeaderText="Data" />
            <asp:BoundField DataField="GuiaTipo" HeaderText="Guia Tipo" />
            <asp:BoundField DataField="CRM" HeaderText="CRM" />
            <asp:BoundField DataField="Paciente" HeaderText="Paciente" />
            <asp:BoundField DataField="Plano" HeaderText="Plano" />
            <asp:HyperLinkField DataNavigateUrlFields="ID" DataNavigateUrlFormatString="FormCadastro.aspx?ID={0}"
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

</asp:Content>

