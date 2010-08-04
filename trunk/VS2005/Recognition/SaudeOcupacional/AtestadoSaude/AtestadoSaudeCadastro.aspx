<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AtestadoSaudeCadastro.aspx.cs" Inherits="AtestadoSaude_AtestadoSaudeCadastro" Title="Untitled Page" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../Template/Css/default.css" rel="stylesheet" type="text/css" />
    <script language="JavaScript" type="text/javascript" src="../JS/Funcoes.js"></script>
</head>
<body>
    <form id="form1" runat="server">
 
    <fieldset>
    <legend>Dados do Funcionário</legend>
    <table  class="texto" style="width: 100%">
        <tr>
            <td style="width: 100%"><b>Atesto para fins de trabalho que o(a) Sr.(a)</b>
    <asp:Label ID="lblNome" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td style="width: 100%; height: 21px;"><b>RG: </b><asp:Label ID="lblRG" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td style="width: 100%"><b>Exercendo a função de: </b><asp:Label ID="lblFuncao" runat="server"></asp:Label>&nbsp;<strong>CBO</strong>:
                <asp:Label ID="lblCBO" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td style="width: 100%"><b>Empresa: </b><asp:Label ID="lblCliente" runat="server"></asp:Label>&nbsp;
            </td>
        </tr>
        <tr>
            <td style="width: 100%"><b>Grau de Risco: </b><asp:Label ID="lblRisco" runat="server"></asp:Label>&nbsp;
            </td>
        </tr>
    </table>
    </fieldset>
                <fieldset>
    <legend>Médico Coordenador PCMSO</legend>
        <table style="width: 100%" class="texto">
            <tr>
                <td>
                    <strong>
                    Dr(a).</strong>
                    <asp:Label ID="lblMedicoResp" runat="server"></asp:Label>
                    <strong>CRM:</strong>
                    <asp:Label ID="lblConselhoNumero" runat="server"></asp:Label>
                    -
                    <asp:Label ID="lblConselhoUF" runat="server"></asp:Label>
                    <asp:HiddenField ID="hddIdProfissional" runat="server" />
                </td>
            </tr>
        </table>
    </fieldset>
    	<fieldset>
	<legend>Tipo de Atestado</legend>
    <asp:RadioButtonList ID="rdoTipoAtestado" class="texto" runat="server" DataSourceID="ObjectDataSource1"
        DataTextField="Nome" DataValueField="id" RepeatDirection="Horizontal">
    </asp:RadioButtonList>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="TipoAtestatoDropDownList"
        TypeName="AtestadoSaudeDAL"></asp:ObjectDataSource>
    	
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rdoTipoAtestado"
        CssClass="texto" Display="None" ErrorMessage="Selecione o tipo de atestado"></asp:RequiredFieldValidator>
    </fieldset>
    <fieldset>
    <legend>Observações</legend>
    <table width="100%" class="texto">
    <tr>
    <td>
    <asp:TextBox ID="txtObservacoes" runat="server" Rows="10" TextMode="MultiLine" Width="100%" MaxLength="500" Height="113px"></asp:TextBox>
    </td>
    </tr>
    </table>
    </fieldset>

    <fieldset>
    <legend>Parecer do Médico</legend>
    <table width="100%" class="texto">
        <tr>
            <td style="width: 15%"><strong>Foi considerado(a)</strong></td>
            <td style="width: 400px">
                <asp:RadioButtonList class="texto" ID="rdoStatusAtestado" runat="server" DataSourceID="ObjectDataSource2"
                    DataTextField="Nome" DataValueField="ID" RepeatDirection="Horizontal">
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rdoStatusAtestado"
                    CssClass="texto" Display="None" ErrorMessage="Selecione um parecer para o atestado"></asp:RequiredFieldValidator>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="StatusAtestatoDropDownList"
                    TypeName="AtestadoSaudeDAL"></asp:ObjectDataSource>
            </td>
            <td style="width: 196px">
                <strong>c/ Pendência</strong></td>
            <td style="width: 604px"><asp:TextBox ID="txtPendencia" runat="server" Width="225px" MaxLength="256"></asp:TextBox>
                <b>para exercer a função.</b></td>
        </tr>
        <tr>
            <td>
                <strong>Médico Examinador:</strong></td>
            <td style="width: 400px">
                <asp:TextBox ID="txtMedicoExaminador" runat="server" Width="268px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtMedicoExaminador"
                    CssClass="texto" Display="None" ErrorMessage="Entre com o nome do Médico examinador"
                    SetFocusOnError="True"></asp:RequiredFieldValidator></td>
            <td style="width: 196px">
                <strong>CRM: </strong>
            </td>
            <td style="width: 604px">
                <asp:TextBox ID="txtCRM" runat="server" Width="90px" MaxLength="10"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtCRM"
                    CssClass="texto" Display="None" ErrorMessage="Entre com o nome do Médico examinador"
                    SetFocusOnError="True"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td>
                <strong>Data da Consulta:</strong></td>
            <td style="width: 400px">
                <asp:TextBox ID="txtDataConsulta" runat="server" MaxLength="10" onblur="javascript:valida_data(this);" onkeypress="return MascaraCampo(this.form.name, this, '99/99/9999', event);"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtDataConsulta"
                    CssClass="texto" Display="None" ErrorMessage="Entre com o nome do Médico examinador"
                    SetFocusOnError="True"></asp:RequiredFieldValidator></td>
            <td style="width: 196px">
            </td>
            <td style="width: 604px">
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
            </td>
        </tr>
        <tr>
            <td align="center" colspan="4">
            </td>
        </tr>
    </table>
    </fieldset>
    <br />
    <fieldset>
        <table style="width: 100%">
            <tr>
                <td align="center">
                    <asp:Button ID="btnSalvar" runat="server" Text="Salvar" OnClick="btnSalvar_Click" /></td>
            </tr>
        </table> 
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
            ShowSummary="False" HeaderText="Campos de preenchimento obrigatório" />
    </fieldset>
        &nbsp;&nbsp;

    </form>
</body>
</html>