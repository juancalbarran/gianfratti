<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="ProcessosSeletivoPrincipal.aspx.cs" Inherits="ProcessoSeletivo_ProcessosSeletivoPrincipal" Title="Untitled Page" %>

<%@ Register Src="../UserControls/DropDownList/Cliente.ascx" TagName="Cliente" TagPrefix="uc1" %>
<%@ Register Src="../UserControls/DropDownList/ProcessoSeletivoStatus.ascx" TagName="ProcessoSeletivoStatus"
    TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<fieldset style="height: 100%">
<legend  align=center >&nbsp;Gerenciador de Processos Seletivos&nbsp;</legend>

    <fieldset>
    <legend  align=left >&nbsp;Busca&nbsp;</legend>
        <table class=texto style="width: 100%; height: 100%" border="0" cellpadding="0" cellspacing="1">
            <tr>
                <td style="width: 100px">
                    Razão Social:</td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    Status:</td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                    <uc1:Cliente ID="ddlCliente" runat="server" />
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    <uc2:ProcessoSeletivoStatus ID="ddlProcessoSeletivoStatus" runat="server" />
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                    Nome:</td>
                <td style="width: 100px">
                    </td>
                <td style="width: 100px">
                    CPF:</td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:TextBox ID="txtNome" runat="server" Width="90%"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtCPF" runat="server" MaxLength="14" onkeypress="return MascaraCampo(this.form.name, this, '999.999.999-99', event);"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar"  /></td>
                <td style="width: 100px">
                </td>
            </tr>
        </table>
    </fieldset>
    <br />
    <fieldset>
        <table style="width: 100%" border="0" cellpadding="0" cellspacing="1" class="texto">
        <tr>
            <td style="width: 646px; height: 19px;">
                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Template/Img/botao_cadastro.gif"
                    PostBackUrl="~/ProcessoSeletivo/ProcessosSeletivoCadastro.aspx" /></td>
                                <td style="height: 19px; width: 21px;">
                <img src="../Template/Img/Flg_amerelo_Escuro.gif" /></td>
            <td style="height: 19px; width: 130px;">Processo Seletivo</td>
            <td style="height: 19px; width: 18px;"><img src="../Template/Img/Flg_verde.gif" /></td>
            <td style="height: 19px; width: 78px;">Admitido</td>
            <td style="height: 19px; width: 1px;"><img src="../Template/Img/Flg_vermelho.gif" /></td>
            <td style="height: 19px; width: 88px;">Não Admitido</td>
        </tr>
    </table>
    </fieldset>
    
    <fieldset>
    <legend  align=left >&nbsp;Lista&nbsp;</legend>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" CssClass="texto" DataKeyNames="ID" OnRowCommand="GridView1_RowCommand" OnPreRender="GridView1_PreRender" OnDataBound="GridView1_DataBound" OnRowDataBound="GridView1_RowDataBound" AllowPaging="True" PageSize="15" OnPageIndexChanging="GridView1_PageIndexChanging">
                        <FooterStyle BackColor="White" ForeColor="#000066" />
                        <RowStyle ForeColor="#000066" />
                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#F3F7FC" ForeColor="Gray" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="#F3F7FC" Font-Bold="True" ForeColor="Black" HorizontalAlign="Left" />
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            &nbsp;<asp:Image ID="Image1" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Nome" HeaderText="Nome" />
                                    <asp:BoundField DataField="CPF" HeaderText="CPF" />
                                    <asp:BoundField DataField="Status" HeaderText="Status" />
                                    <asp:BoundField DataField="departamento" HeaderText="Departamento" />
                                    <asp:BoundField DataField="Setor" HeaderText="Setor" />
                            <asp:BoundField DataField="RazaoSocial" HeaderText="Raz&#227;o Social" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="ImageButton3" runat="server" CommandArgument='<%#Eval("ID")%>'
                                                CommandName="Editar" ImageUrl="~/Template/Img/alterar.gif" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="ImgDelete" runat="server" CommandArgument='<%#Eval("ID")%>' CommandName="Deletar"
                                                ImageUrl="~/Template/Img/excluir.gif" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="idProcessoSeletivoStatus" HeaderText="idProcessoSeletivoStatus"
                                        Visible="False" />
                        </Columns>
                    </asp:GridView>
        &nbsp;

    </fieldset>

</fieldset>
</asp:Content>

