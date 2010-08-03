<%@ Page Language="C#" MasterPageFile="~/Template/Template01.master" AutoEventWireup="true" CodeFile="RecibosEmitidos.aspx.cs" Inherits="Forms_RecibosEmitidos" Title="Smart Health Care - Recibos Emitidos" %>

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
    </script>

    <fieldset style="height: 100%">
        <legend align="center">Recibos Emitidos</legend>
        
                <fieldset>
            <legend>Filtro</legend>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
                <tr>
                    <td style="width: 454px; height: 19px;">
                        Paciente:</td>
                    <td width="17%" style="height: 19px">
                        Data Inicio:</td>
                    <td width="37%" style="height: 19px">
                        Data Fim:</td>
                </tr>
                <tr>
                    <td style="width: 454px">
                        <asp:TextBox ID="txtPacienteNome" runat="server" MaxLength="100" Width="440px"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtdtInicio" runat="server" MaxLength="10" onblur="javascript:valida_data(this);" onkeypress="return MascaraCampo(this.form.name, this, '99/99/9999', event);" Width="82px"></asp:TextBox>&nbsp;</td>
                    <td>
                        <asp:TextBox ID="txtdtFim" runat="server" MaxLength="10" onblur="javascript:valida_data(this);" onkeypress="return MascaraCampo(this.form.name, this, '99/99/9999', event);" Width="82px"></asp:TextBox>
                        &nbsp; &nbsp;&nbsp; &nbsp;<asp:Button ID="btmBuscar" runat="server" Text="Buscar" OnClick="btmBuscar_Click" /></td>
                </tr>
            </table>
        </fieldset>

       <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" Width="100%" ForeColor="Black" GridLines="None" AllowPaging="True" PageSize="15" OnPageIndexChanging="GridView1_PageIndexChanging" ShowFooter="True" OnRowCreated="GridView1_RowCreated" OnRowCommand="GridView1_RowCommand"  >
            <RowStyle BackColor="#E3EAEB" />
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="ImgBtnEditar" runat="server" CommandArgument='<%# Eval("ID")%>' ImageUrl="~/Template/Img/Editar.gif" CommandName="Visualizar" ToolTip="Visualizar Recibo Emitido" />
                    </ItemTemplate>
                    <HeaderStyle ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle HorizontalAlign="Left" Width="15px" />
                </asp:TemplateField>
                <asp:BoundField DataField="id" HeaderText="Número Recibo">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="Data" HeaderText="Data Emiss&#227;o">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="Nome" HeaderText="Paciente">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="ValorTotal" HeaderText="Valor Total">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="ImgBtnApagar" runat="server" CommandArgument='<%# Eval("ID")%>' ImageUrl="~/Template/Img/excluir.gif" CommandName="Apagar" ToolTip="Apagar Registro" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" Width="20px" />
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#1C5E55" ForeColor="White" Font-Bold="True" Font-Size="12px" />
            <PagerStyle BackColor="#1C5E55" ForeColor="White" HorizontalAlign="Center" Font-Bold="False" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#7C6F57" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
 
    </fieldset>
</asp:Content>
