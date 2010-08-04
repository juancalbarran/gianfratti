<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="EncaminhamentoCadastro.aspx.cs" Inherits="Encaminhamento_EncaminhamentoCadastro" Title="Untitled Page" %>

<%@ Register Src="../UserControls/DropDownList/Profissional.ascx" TagName="Profissional"
    TagPrefix="uc3" %>

<%@ Register Src="../UserControls/DropDownList/Cliente.ascx" TagName="Cliente" TagPrefix="uc2" %>

<%@ Register Src="../UserControls/ClienteFuncionario/FuncionarioDadosBasicos.ascx"
    TagName="FuncionarioDadosBasicos" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<fieldset style="height: 100%">
<legend  align="center">Ficha de Encaminhamento</legend>

    <fieldset id="MostraTblCliente" runat="server">
    <legend>Razão Social</legend>
    <table class="texto" border="0" cellpadding=0 cellspacing=0 style="width:100%">
        <tr>
            <td>
                <uc2:Cliente ID="ddlCliente" runat="server" />
            </td>
        </tr>
    </table>
    </fieldset>

    <fieldset id="MostraTblProcessoSeletivo" runat="server">
    <legend>Candidato em Processo Seletivo</legend>
    <table class="texto" border="0" cellpadding="0" cellspacing="0" style="width:100%">
        <tr>
            <td>
                <asp:DropDownList ID="ddlProcessoSeletivo" runat="server">
                </asp:DropDownList></td>
        </tr>
    </table>
    </fieldset>

    <fieldset id="BuscaFuncEfetivo" runat="server">
    <legend>Funcionário Efetivo</legend>
    <table class="texto" border="0" cellpadding=0 cellspacing=0 style="width:100%">
        <tr>
            <td>Digite o número do CPF do funcionário:</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtBuscar" MaxLength="14" onkeypress="return MascaraCampo(this.form.name, this, '999.999.999-99', event);" runat="server"></asp:TextBox>
                <asp:Button ID="btnBuscaDadosFuncionario" runat="server" Text="Buscar Funcionário" OnClick="btnBuscaDadosFuncionario_Click" CausesValidation="False" />
                <asp:HiddenField ID="hddidCliente" runat="server" />
            </td>
        </tr>
    </table>
    </fieldset>
    
    <table runat="server" id="MostraTabDadosFunc" class="texto" border="0" cellpadding=0 cellspacing=0 style="width:100%">
        <tr>
            <td>
                <uc1:FuncionarioDadosBasicos ID="FuncionarioDadosBasicos1" runat="server" />
            </td>
        </tr>
    </table>
        
    <fieldset>
    <legend>Tipo de Atestado Clinico</legend>
    <table class="texto" border="0" cellpadding=0 cellspacing=0 style="width:100%">
        <tr>
            <td>
                <asp:RadioButtonList ID="rdoTipoAtestado" runat="server" class="texto" RepeatDirection="Horizontal" OnSelectedIndexChanged="rdoTipoAtestado_SelectedIndexChanged" AutoPostBack="True">
                </asp:RadioButtonList></td>
        </tr>
    </table>
    </fieldset>
    
    <fieldset>
    <legend>Exames Complementares</legend>
    <table class="texto" border="0" cellpadding=0 cellspacing=0 style="width:100%">
        <tr>
            <td>
                <asp:CheckBoxList ID="CheckBoxList1" runat="server" CssClass="texto" RepeatColumns="6"
                    RepeatDirection="Horizontal">
                </asp:CheckBoxList></td>
        </tr>
    </table>
    </fieldset>
 
     <fieldset>
    <legend>Médico Examinador</legend>
    <table class="texto" border="0" cellpadding=0 cellspacing=0 style="width:100%">
        <tr>
            <td>
                <uc3:Profissional ID="ddlProfissional" runat="server" />
            </td>
        </tr>
    </table>
    </fieldset>
       
    <fieldset>
    <legend>Data de Realização</legend>
    <table class="texto" border="0" cellpadding=0 cellspacing=0 style="width:100%">
        <tr>
            <td>
                <asp:TextBox ID="txtDtRealizacao" onblur="javascript:valida_data(this);" onKeyPress="return MascaraCampo(this.form.name, this, '99/99/9999', event);" MaxLength="10" Width="79px" runat="server"></asp:TextBox></td>
        </tr>
    </table>
    </fieldset>
    
    <br />
    <fieldset>
    <table class="texto" border="0" cellpadding=0 cellspacing=0 style="width:100%">
        <tr>
            <td style="height: 24px" align="center">
                <asp:Button ID="btnSalvar" runat="server" Text="Salvar" OnClick="btnSalvar_Click" /></td>
        </tr>
    </table>
    </fieldset>
    
</fieldset>
</asp:Content>

