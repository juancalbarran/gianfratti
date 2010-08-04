<%@ Page Language="C#" EnableEventValidation="false" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="EncaminhamentoPrincipal.aspx.cs" Inherits="Encaminhamento_EncaminhamentoPrincipal" Title="Untitled Page" %>

<%@ Register Src="../UserControls/DropDownList/TipoAtestado.ascx" TagName="TipoAtestado"
    TagPrefix="uc2" %>

<%@ Register Src="../UserControls/DropDownList/Cliente.ascx" TagName="Cliente" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<fieldset style="height: 100%">
    <legend align="center">Gerenciador de Encaminhamentos</legend>
    <fieldset>
        <legend>Busca</legend>
        <table width="100%" cellpadding="0" cellspacing="0" border="0" class="texto">
            <tr>
                <td style="width: 219px">
                    Cliente</td>
                <td style="width: 356px">
                    Tipo de Atestado</td>
                <td style="width: 170px">
                    Tipo de Encaminhamento</td>
                <td style="width: 145px">
                    </td>
            </tr>
            <tr>
                <td style="width: 219px; height: 17px">
                    <uc1:Cliente ID="ddlCliente" runat="server" />
                    </td>
                    <td style="width: 356px; height: 17px">
                        <uc2:TipoAtestado ID="ddlTipoAtestado" runat="server" />
                    </td>
                <td style="width: 170px; height: 17px;">
                    <asp:DropDownList ID="ddlTipoEncaminhamento" runat="server" CssClass="texto">
                        <asp:ListItem>&lt;--Selecione--&gt;</asp:ListItem>
                        <asp:ListItem>Funcion&#225;rio Efetivo</asp:ListItem>
                        <asp:ListItem>Candidato Processo Seletivo</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="width: 145px; height: 17px;">
                    </td>
            </tr>
            <tr>
                <td style="width: 219px; height: 19px;">
                    Nome</td>
                <td style="width: 356px; height: 19px;">
                    CPF</td>
                <td style="width: 170px; height: 19px;">
                    Data Realização do Exame</td>
                <td style="width: 145px; height: 19px;">
                    </td>
            </tr>
            <tr>
                <td style="width: 219px; height: 24px;">
                    <asp:TextBox ID="txtNome" runat="server" Width="249px"></asp:TextBox></td>
                <td style="width: 356px; height: 24px;">
                    <asp:TextBox ID="txtCPF" runat="server" Width="196px"  onKeyPress="return MascaraCampo(this.form.name, this, '999.999.999-99', event);" MaxLength="14" ></asp:TextBox></td>
                <td style="width: 170px; height: 24px;">
                    <asp:TextBox ID="TxtDtRealizacao" runat="server" MaxLength="10" onblur="javascript:valida_data(this);"
                        onkeypress="return MascaraCampo(this.form.name, this, '99/99/9999', event);"></asp:TextBox></td>
                <td style="width: 145px; height: 24px;">
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_Click" /></td>
            </tr>
        </table>
    </fieldset>
        <br />
    <fieldset>
        <table style="width: 100%" border="0" cellpadding="0" cellspacing="1" class="texto">
        <tr>
            <td style="width: 579px; height: 19px;">
                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Template/Img/botao_cadastro.gif"
                    PostBackUrl="~/Encaminhamento/DefaultAbas.aspx" /></td>
                                <td style="height: 19px; width: 21px;">
                <img src="../Template/Img/Flg_verde.gif" />&nbsp;</td>
            <td style="height: 19px; width: 152px;">
                Funcionário Efetivo</td>
            <td style="height: 19px; width: 18px;">
                <img src="../Template/Img/Flg_amerelo_Escuro.gif" /></td>
            <td style="height: 19px; width: 102px;">Processo Seletivo</td>
        </tr>
    </table>
    </fieldset>
    
    <fieldset>
    <legend  align=left >&nbsp;Lista&nbsp;</legend>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" CssClass="texto" ShowFooter="True" DataKeyNames="id" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand" AllowPaging="True" PageSize="15" OnPageIndexChanging="GridView1_PageIndexChanging">
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <RowStyle ForeColor="#000066" />
            <SelectedRowStyle Font-Bold="True" />
            <PagerStyle BackColor="#F3F7FC" ForeColor="Gray" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#F3F7FC" Font-Bold="True" ForeColor="Black" HorizontalAlign="Left" />
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Nome" HeaderText="Nome" />
                <asp:BoundField DataField="CPF" HeaderText="CPF" />
                <asp:BoundField DataField="TipoAtestado" HeaderText="Tipo de Atestado" />
                <asp:BoundField DataField="TipoEncaminhamento" HeaderText="Tipo Encaminhamento" />
                <asp:BoundField DataField="RazaoSocial" HeaderText="Cliente" />
                <asp:BoundField DataField="DtRealizacao" DataFormatString="{0:dd-dd-MM-yyyy}" HeaderText="Data Realiza&#231;&#227;o" />
                <asp:HyperLinkField DataNavigateUrlFields="ID,idClienteFuncionario,idProcessoSeletivo" DataNavigateUrlFormatString="EncaminhamentoPrincipal.aspx?idEncaminhamento={0}&amp;idClienteFuncionario={1}&amp;idProcessoSeletivo={2}" Text="&lt;img alt=&quot;Visualizar&quot;  border= &quot;0&quot; src=&quot;../Template/Img/alterar.gif&quot; /&gt;" />
            </Columns>
        </asp:GridView>
        </fieldset>
</fieldset>    

</asp:Content>

