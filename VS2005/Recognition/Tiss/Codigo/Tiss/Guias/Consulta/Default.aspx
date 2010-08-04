<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Guias_Consulta_Default" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<fieldset>
<legend>Gerenciador de Guias de Consultas</legend>
<fieldset>
<legend>Busca</legend>
<table style="width:100%;" class="texto" >
    <tr>
        <td style="height: 21px">Nome beneficiário:</td>
        <td style="height: 21px">Nº Registro ANS:</td>
        <td style="height: 21px">Data Inicial de Emissão da Guia:</td>
        <td style="height: 21px">Data Final de Emissão da Guia:</td>
        <td style="height: 21px"></td>
    </tr>
        <tr>
        <td>
            <asp:TextBox ID="txtNomeBeneficiario" runat="server" MaxLength="70"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="txtRegANS" runat="server" MaxLength="6"></asp:TextBox></td>
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
                    PostBackUrl="~/Guias/Consulta/GuiaConsultaCadastro.aspx" />
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete"
        SelectMethod="SelectAll" TypeName="TissObjetos.GuiaConsultaDAL">
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="txtNomeBeneficiario" Name="NomeBeneficiario" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="txtRegANS" Name="RegAns" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtDtEmissaoInicial" Name="DtEmissaoInicial" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="txtDtEmissaoFinal" Name="DtEmissaoFinal" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
        CellPadding="3" CssClass="texto" DataKeyNames="ID" DataSourceID="ObjectDataSource1"
        Width="100%" PageSize="20">
        <FooterStyle BackColor="White" ForeColor="#000066" />
        <Columns>
            <asp:BoundField DataField="DtEmissao" HeaderText="Data Emiss&#227;o" />
            <asp:BoundField DataField="RegANS" HeaderText="Registro ANS" />
            <asp:BoundField DataField="Plano" HeaderText="Plano" />
            <asp:BoundField DataField="NomeBeneficiario" HeaderText="Benefici&#225;rio" />
            <asp:HyperLinkField DataNavigateUrlFields="ID" DataNavigateUrlFormatString="GuiaConsultaCadastro.aspx?ID={0}"
                Text="&lt;img src=&quot;../../Template/Img/alterar.gif&quot; border=&quot;0&quot; alt=&quot;Visualizar&quot;&gt;" />
            <asp:CommandField ButtonType="Image" DeleteImageUrl="../../Template/Img/excluir.gif"
                ShowDeleteButton="True" />
        </Columns>
        <RowStyle ForeColor="#000066" />
        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
    </asp:GridView>
</fieldset>
</asp:Content>

