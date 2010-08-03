<%@ Page Language="C#" MasterPageFile="~/Template/Template01.master" AutoEventWireup="true" CodeFile="Convenio.aspx.cs" Inherits="Forms_Convenio" Title="Smart Health Care - Cadastro de Convênios" %>

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
        <legend align="center">Convênios</legend>
        <fieldset>
            <legend>Filtro</legend>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
                <tr>
                    <td style="width: 454px">
                        Convênio:</td>
                    <td width="17%">
                        </td>
                    <td width="37%">
                        </td>
                </tr>
                <tr>
                    <td style="width: 454px; height: 24px;">
                        <asp:TextBox ID="txtConvenio" runat="server" MaxLength="100" Width="440px"></asp:TextBox></td>
                    <td style="height: 24px">
                        <asp:Button ID="btmBuscar" runat="server" Text="Buscar" OnClick="btmBuscar_Click" /></td>
                    <td style="height: 24px">
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
        </fieldset>
        <br />
        <fieldset>
            <table style="width: 100%" border="0" cellpadding="0" cellspacing="1" class="texto">
                <tr>
                    <td style="width: 100%;">
                        <asp:Button ID="Button1" runat="server" PostBackUrl="~/Forms/ConvenioCadastrar.aspx" Text="Novo Convênio" /></td>
                </tr>
            </table>
        </fieldset>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" Width="100%" ForeColor="Black" GridLines="None" AllowPaging="True" PageSize="15" OnPageIndexChanging="GridView1_PageIndexChanging" ShowFooter="True" OnRowCreated="GridView1_RowCreated" OnRowCommand="GridView1_RowCommand">
            <RowStyle BackColor="#E3EAEB" />
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="ImgBtnEditar" runat="server" CommandArgument='<%# Eval("ID")%>' ImageUrl="~/Template/Img/Editar.gif" CommandName="Editar" ToolTip="Editar Registro do Paciente" />
                    </ItemTemplate>
                    <HeaderStyle ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle HorizontalAlign="Left" Width="15px" />
                </asp:TemplateField>
                <asp:BoundField DataField="Nome" HeaderText="Nome">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="Valor" HeaderText="Valor Sess&#227;o" DataFormatString="{0:C2}">
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
