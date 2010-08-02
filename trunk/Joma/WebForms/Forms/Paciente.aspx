<%@ Page Language="C#" MasterPageFile="~/Template/Template01.master" AutoEventWireup="true" CodeFile="Paciente.aspx.cs" Inherits="Forms_Paciente" Title="Smart Health Care - Cadastro Paciente" %>

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
        <legend align="center">Pacientes</legend>
        <fieldset>
            <legend>Filtro</legend>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
                <tr>
                    <td style="width: 454px">
                        Nome:</td>
                    <td width="17%">
                        RG:</td>
                    <td width="37%">
                        CPF:</td>
                </tr>
                <tr>
                    <td style="width: 454px">
                        <asp:TextBox ID="txtNome" runat="server" MaxLength="100" Width="440px"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtRG" runat="server" MaxLength="20"></asp:TextBox>&nbsp;</td>
                    <td>
                        <asp:TextBox ID="txtCPF" runat="server" MaxLength="14" onkeypress="return MascaraCampo(this.form.name, this, '999.999.999-99', event);"></asp:TextBox>
                        &nbsp; &nbsp;&nbsp; &nbsp;<asp:Button ID="btmBuscar" runat="server" Text="Buscar" OnClick="btmBuscar_Click" />
                        &nbsp;&nbsp;
                        <asp:Button ID="btnLimpar" runat="server" Text="Limpar" OnClick="btnLimpar_Click" /></td>
                </tr>
            </table>
        </fieldset>
        <br />
        <fieldset>
            <table style="width: 100%" border="0" cellpadding="0" cellspacing="1" class="texto">
                <tr>
                    <td style="width: 100%;">
                        <asp:Button ID="Button1" runat="server" PostBackUrl="~/Forms/PacienteCadastrar.aspx" Text="Novo Paciente" /></td>
                </tr>
            </table>
        </fieldset>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" Width="100%" ForeColor="Black" GridLines="None" AllowPaging="True" PageSize="15" OnPageIndexChanging="GridView1_PageIndexChanging" ShowFooter="True" OnRowCreated="GridView1_RowCreated" OnRowCommand="GridView1_RowCommand"  >
            <RowStyle BackColor="#E3EAEB" />
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="ImgBtnAgendamento" runat="server" CommandArgument='<%# Eval("ID")%>' ImageUrl="~/Template/Img/agenda.png" CommandName="Agendamento" ToolTip="Agendar Sessões" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Left" Width="15px" />
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="ImgBtnEditar" runat="server" CommandArgument='<%# Eval("ID")%>' ImageUrl="~/Template/Img/Editar.gif" CommandName="Editar" ToolTip="Editar Registro do Paciente" />
                    </ItemTemplate>
                    <HeaderStyle ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle HorizontalAlign="Left" Width="15px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Nome">
                    <ItemTemplate>
                        <%# DataBinder.Eval(Container.DataItem, "Nome")%>
                    </ItemTemplate>
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Bold="True" Font-Size="10px" />
                    <FooterTemplate>
                        Total Registros: <%# TotalRegistros %>
                    </FooterTemplate>
                    <FooterStyle Font-Bold="True" Font-Size="9px"  ForeColor="White" HorizontalAlign="Left" />
                </asp:TemplateField>
                <asp:BoundField DataField="Sexo" HeaderText="Sexo">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="RG" HeaderText="RG">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="CPF" HeaderText="CPF">
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="dtNascimento" HeaderText="Dt. Nasc." DataFormatString="{0:dd/MM/yyyy}" >
                    <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Left" />
                    <ItemStyle Font-Size="10px" />
                </asp:BoundField>
                <asp:BoundField DataField="Idade" HeaderText="Idade" >
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
