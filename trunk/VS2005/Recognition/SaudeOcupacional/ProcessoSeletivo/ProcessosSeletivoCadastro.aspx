<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true"
    CodeFile="ProcessosSeletivoCadastro.aspx.cs" Inherits="ProcessoSeletivo_ProcessosSeletivoCadastro"
    Title="Untitled Page" %>

<%@ Register Src="../UserControls/DropDownList/Cliente.ascx" TagName="Cliente" TagPrefix="uc1" %>
<%@ Register Src="../UserControls/DropDownList/ProcessoSeletivoStatus.ascx" TagName="ProcessoSeletivoStatus"
    TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset style="height: 100%">
        <legend align="center">Cadastro Processo Seletivo</legend>
        <fieldset>
            <legend>Razão Social</legend>
            <table class="texto" border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                <tr>
                    <td>
                        <uc1:Cliente ID="ddlCliente" runat="server" />
                    </td>
                </tr>
            </table>
        </fieldset>
        <fieldset>
            <legend>Cadastro do Candidato</legend>
            <table class="texto" border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                <tr>
                    <td>
                        Nome:</td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtNome" runat="server" Width="50%"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        CPF:</td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtCPF" runat="server" MaxLength="14" onkeypress="return MascaraCampo(this.form.name, this, '999.999.999-99', event);"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        Data Nascimento:</td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtDtNascimento" runat="server" onblur="javascript:valida_data(this);"
                            onKeyPress="return MascaraCampo(this.form.name, this, '99/99/9999', event);"
                            MaxLength="10"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        Sexo:</td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlSexo" runat="server">
                            <asp:ListItem Value="">&lt;-Selecione-&gt;</asp:ListItem>
                            <asp:ListItem Value="M">Masculino</asp:ListItem>
                            <asp:ListItem Value="F">Feminino</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td>
                        Departamanto:</td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlDepartamento" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDepartamento_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Setor:</td>
                </tr>
                <tr>
                    <td style="height: 22px">
                        <asp:DropDownList ID="ddlSetor" runat="server">
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td>
                        Função:</td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtFuncao" runat="server"></asp:TextBox></td>
                </tr>
            </table>
        </fieldset>
        <fieldset id="TblStatus" runat="server">
            <legend>Status</legend>
            <table class="texto" border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                <tr>
                    <td>
                        Status:</td>
                </tr>
                <tr>
                    <td>
                        <uc2:ProcessoSeletivoStatus ID="ddlProcessoSeletivoStatus" runat="server" />
                    </td>
                </tr>
            </table>
        </fieldset>
        <br />
        <fieldset>
            <table class="texto" border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                <tr>
                    <td align="center">
                        <asp:Button ID="btnSalvar" runat="server" Text="Salvar" OnClick="btnSalvar_Click" /></td>
                </tr>
            </table>
        </fieldset>
    </fieldset>
</asp:Content>
