<%@ Page Language="C#" MasterPageFile="~/Template/Template01.master" AutoEventWireup="true" CodeFile="Recibos.aspx.cs" Inherits="Forms_Recibos" Title="Smart Health Care - Emissão de Recibos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="javascript" type="text/javascript">

var oldgridSelectedColor;

function setMouseOverColor(element)
{
    oldgridSelectedColor = element.style.backgroundColor;
    element.style.backgroundColor='#ABD0BC';
    element.style.cursor='hand';
    //element.style.textDecoration='underline';
}

function setMouseOutColor(element)
{
    element.style.backgroundColor=oldgridSelectedColor;
    //element.style.textDecoration='none';
}

function AbrirJanelaModal()
{
var ret;
//ret=window.showModalDialog("EditarProposta.aspx?idProposta="+idProposta+"","","");
ret=window.showModalDialog("ReciboSalvar.aspx",'','Resizable:no; DialogHeight:900px; DialogWidth800px; Edge:raised; Help:no; Scroll:no; Status:no; Center:yes;');
//document.form.aspnetForm.submit();

}
    </script>

    <fieldset style="height: 100%">
        <legend align="center">Recibos</legend>
        <fieldset>
            <legend>Filtro</legend>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
                <tr>
                    <td width="36%" style="height: 24px">
                        Paciente:</td>
                    <td width="36%" style="height: 24px">
                        Profissional:</td>
                    <td width="20%" style="height: 24px">
                        Convênio:</td>
                    <td width="8%" style="height: 24px">
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlPaciente" runat="server">
                        </asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlProfissional" runat="server">
                        </asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlConvenio" runat="server">
                        </asp:DropDownList></td>
                    <td>
                        <asp:Button ID="btnBusar" runat="server" Text="Buscar" OnClick="btnBusar_Click" /></td>
                </tr>
            </table>
            <br />
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
                <tr>
                    <td style="width: 6%">
                        Desconto:</td>
                    <td style="width: 6%">
                        <asp:TextBox ID="txtPorcentagem" runat="server" Width="35px" MaxLength="3" onkeypress="return MascaraCampo(this.form.name, this, '999', event);" Font-Bold="True">0</asp:TextBox>
                        <b>%</b></td>
                    <td width="71%">
                        <asp:Button ID="btnReCalcular" runat="server" Text="ReCalcular" OnClick="btnReCalcular_Click" /></td>
                </tr>
            </table>
        </fieldset>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" Width="100%" ForeColor="Black" GridLines="None" AllowPaging="True" PageSize="15" ShowFooter="True" OnRowCreated="GridView1_RowCreated" OnRowDataBound="GridView1_RowDataBound">
            <RowStyle BackColor="#E3EAEB" />
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox1_CheckedChanged" />
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("id") %>' Visible="False"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="DataInicio" HeaderText="Data" DataFormatString="{0:dd/MM/yyyy}">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="HoraInicio" HeaderText="Inicio">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="HoraFim" HeaderText="Fim">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="Convenio" HeaderText="Conv&#234;nio">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="Status" HeaderText="Status">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="Profissional" HeaderText="Profissional">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Valor">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Bold="True" Font-Size="10px" />
                    <FooterTemplate>
                        <asp:Label ID="lblValorTotal" runat="server"></asp:Label>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblValor" runat="server"></asp:Label>
                    </ItemTemplate>
                    <FooterStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#1C5E55" ForeColor="White" Font-Bold="True" Font-Size="12px" />
            <PagerStyle BackColor="#1C5E55" ForeColor="White" HorizontalAlign="Center" Font-Bold="False" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#7C6F57" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <br />
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="center">
                    <asp:Button ID="btnGerar" runat="server" OnClick="btnGerar_Click" Text="Gerar Recibo" Font-Bold="True" Font-Size="Small" /></td>
            </tr>
        </table>
    </fieldset>
</asp:Content>
