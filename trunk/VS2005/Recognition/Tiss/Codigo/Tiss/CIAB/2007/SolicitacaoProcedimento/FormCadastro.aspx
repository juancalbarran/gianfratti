<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="FormCadastro.aspx.cs" Inherits="CIAB_2007_SolicitacaoProcedimento_FormCadastro" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
<fieldset style="height: 100%">
<legend>Solicitação de Procedimentos Médicos - Hospitalares</legend>
<table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr class="zebra_orange1">
        <td style="width: 251px">
            Guia:</td>
        <td style="width: 117px">
            Data:</td>
        <td colspan="4" style="width: 134217727px">
            Hora: &nbsp; &nbsp; </td>
        <td colspan="1" rowspan="4" style="width: 700x" valign="top">
            <asp:Image ID="Image1" runat="server" /> 

            <asp:HyperLink ID="PathImg" runat="server" Target="_blank">visualizar</asp:HyperLink>
            </td>
    </tr>
  <tr class="FundoAzul">
    <td style="width: 251px; height: 45px;" >
        <asp:RadioButtonList ID="rdoGuiaTipo" runat="server" CssClass="texto" RepeatDirection="Horizontal" Width="239px">
            <asp:ListItem Value="1">Interna&#231;&#227;o</asp:ListItem>
            <asp:ListItem Value="2">Prorroga&#231;&#227;o</asp:ListItem>
        </asp:RadioButtonList></td>
    <td style="width: 117px; height: 45px;"><label>
        <asp:TextBox ID="txtGuiaData" runat="server" Width="85px" onblur="javascript:valida_data(this);" onKeyPress="return MascaraCampo(document.form, this, '99/99/9999', event);"></asp:TextBox></label></td>
    <td colspan="4" style="width: 134217727px; height: 45px;">
        <asp:TextBox ID="txtGuiaHora" runat="server" Width="47px" MaxLength="5" onKeyPress="return MascaraCampo(document.form, this, '99:99', event);"></asp:TextBox></td>
  </tr>
    <tr class="zebra_orange1">
        <td colspan="6">
            Paciente:</td>
    </tr>
  <tr class="FundoAzul">
    <td colspan="6">
        <asp:TextBox ID="txtPaciente" runat="server" Width="70%"></asp:TextBox></td>
  </tr>
  
  
</table>
<table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr class="zebra_orange1">
        <td style="width: 259px">
            Sexo:</td>
        <td style="width: 50px">
            Idade:</td>
        <td style="width: 75px">
            Peso:</td>
        <td style="width: 618px">
            Altura:</td>
    </tr>
  <tr class="FundoAzul">
    <td style="width: 259px">
        <asp:RadioButtonList ID="rdoSexo" runat="server" CssClass="texto" RepeatDirection="Horizontal" Width="219px">
            <asp:ListItem Value="1">Masculino</asp:ListItem>
            <asp:ListItem Value="2">Feminino</asp:ListItem>
        </asp:RadioButtonList></td>
    <td style="width: 50px">
        <asp:TextBox ID="txtIdade" runat="server" Width="41px" MaxLength="3" onKeyPress="return MascaraCampo(document.form, this, '999', event);"></asp:TextBox></td>
    <td style="width: 75px">
        <asp:TextBox ID="txtPeso" runat="server" Width="41px" MaxLength="3" onKeyPress="return MascaraCampo(document.form, this, '999', event);"></asp:TextBox></td>
    <td style="width: 618px">
        <asp:TextBox ID="txtAltura" runat="server" Width="41px" MaxLength="3" onKeyPress="return MascaraCampo(document.form, this, '999', event);"></asp:TextBox></td>
  </tr>
    <tr class="zebra_orange1">
        <td colspan="4">
            Plano:</td>
    </tr>
    <tr class="FundoAzul">
        <td colspan="5">
        <asp:TextBox ID="txtPlano" runat="server" Width="70%"></asp:TextBox></td>
    </tr>
    <tr class="zebra_orange1">
        <td colspan="5">
            Titular:</td>
    </tr>
  <tr class="FundoAzul">
    <td colspan="5">
        <asp:TextBox ID="txtTitular" runat="server" Width="70%"></asp:TextBox></td>
  </tr>
    <tr class="zebra_orange1">
        <td colspan="5">
            Hospital:</td>
    </tr>
  <tr class="FundoAzul">
    <td colspan="4">
        <asp:TextBox ID="txtHospital" runat="server" Width="50%"></asp:TextBox>
        &nbsp; &nbsp; &nbsp; &nbsp; Código:
        <asp:TextBox ID="txtCodigo" runat="server" Width="126px" MaxLength="8"></asp:TextBox></td>
  </tr>
</table>
<table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
<tr class="zebra_orange1">
<td colspan="1">Hist&oacute;rico da doen&ccedil;a atual que justifica a interna&ccedil;&atilde;o</td>
</tr>
    <tr class="FundoAzul">
        <td colspan="1">
        <asp:TextBox ID="txtHistorico" runat="server" Height="91px" TextMode="MultiLine"
            Width="100%"></asp:TextBox></td>
    </tr>
    <tr class="zebra_orange1">
        <td>
            Tipo de Doen&ccedil;a:</td>
    </tr>
    <tr class="FundoAzul">
        <td>
            <asp:RadioButtonList ID="rdoTipoDoenca" runat="server" CssClass="texto" RepeatDirection="Horizontal" Width="212px">
                <asp:ListItem Value="1">Cr&#244;nica</asp:ListItem>
                <asp:ListItem Value="2">Aguda</asp:ListItem>
            </asp:RadioButtonList></td>
    </tr>
    <tr class="zebra_orange1">
        <td>
            Tempo de Evolução:</td>
    </tr>
    <tr class="FundoAzul">
        <td>
            Anos: &nbsp;
              <asp:TextBox ID="txtTempoEvolucaoAnos" runat="server" Width="49px" MaxLength="2" onKeyPress="return MascaraCampo(document.form, this, '99', event);"></asp:TextBox>
            &nbsp; &nbsp;
            Meses: &nbsp; &nbsp;<asp:TextBox ID="txtTempoEvolucaoMeses" runat="server" Width="49px" MaxLength="2" onKeyPress="return MascaraCampo(document.form, this, '99', event);"></asp:TextBox>
            &nbsp; &nbsp;
            Dias: &nbsp;
              <asp:TextBox ID="txtTempoEvolucaoDias" runat="server" Width="49px" MaxLength="2" onKeyPress="return MascaraCampo(document.form, this, '99', event);"></asp:TextBox></td>
    </tr>
</table>
<table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="zebra_orange1">
    <td>Resultado dos exames complementares: </td>
  </tr>
  <tr class="FundoAzul">
    <td>
        <asp:TextBox ID="txtResultadoExames" runat="server" Width="70%"></asp:TextBox></td>
  </tr>
  <tr class="zebra_orange1">
    <td>Diagn&oacute;stico:</td>
  </tr>
  <tr class="FundoAzul">
    <td>
        <asp:TextBox ID="txtDiagnostico" runat="server" Width="70%"></asp:TextBox></td>
  </tr>
  <tr class="zebra_orange1">
    <td>Tratamento Proposto: </td>
  </tr>
  <tr class="FundoAzul">
    <td>
        <asp:TextBox ID="txtTratamento" runat="server" Width="70%"></asp:TextBox></td>
  </tr>
  <tr class="zebra_orange1">
    <td>C&oacute;digos dos Procedimentos Realizados </td>
  </tr>
  <tr class="FundoAzul">
    <td>
        1-<asp:TextBox ID="txtCodigoProcedimentos" runat="server" Width="20%" MaxLength="8" onKeyPress="return MascaraCampo(document.form, this, '99999999', event);"></asp:TextBox>
        2-<asp:TextBox ID="txtCodigoProcedimentos_1" runat="server" Width="20%" MaxLength="8" onKeyPress="return MascaraCampo(document.form, this, '99999999', event);"></asp:TextBox>
        3-<asp:TextBox ID="txtCodigoProcedimentos_2" runat="server" Width="20%" MaxLength="8" onKeyPress="return MascaraCampo(document.form, this, '99999999', event);"></asp:TextBox>
        4-<asp:TextBox ID="txtCodigoProcedimentos_3" runat="server" Width="20%" MaxLength="8" onKeyPress="return MascaraCampo(document.form, this, '99999999', event);"></asp:TextBox></td>
  </tr>
</table>
<table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr class="zebra_orange1">
        <td style="width: 507px">
            Tipo de Tratamento: 
        </td>
        <td>
            Internação:</td>
    </tr>
  <tr class="FundoAzul">
    <td style="width: 507px">
        <asp:RadioButtonList ID="rdoTipoTratamento" runat="server" CssClass="texto" RepeatDirection="Horizontal" Width="440px">
            <asp:ListItem Value="1">Cl&#237;nico</asp:ListItem>
            <asp:ListItem Value="2">Cir&#250;rgico</asp:ListItem>
            <asp:ListItem Value="3">Obster&#237;cio</asp:ListItem>
            <asp:ListItem Value="4">Outros</asp:ListItem>
        </asp:RadioButtonList></td>
    <td>
        <asp:RadioButtonList ID="rdoTipoInternacao" runat="server" CssClass="texto" RepeatDirection="Horizontal" Width="352px">
            <asp:ListItem Value="1">Eletivo</asp:ListItem>
            <asp:ListItem Value="2">Urg&#234;ncia/Emerg&#234;ncia</asp:ListItem>
        </asp:RadioButtonList></td>
  </tr>
</table>
<table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr class="zebra_orange1">
        <td style="width: 169px">
            Data Internação:
        </td>
        <td style="width: 158px">
            Data Cirurgia:</td>
        <td>
            Dias Interna&ccedil;&atilde;o: 
        </td>
    </tr>
  <tr class="FundoAzul">
    <td style="width: 169px">
        <asp:TextBox ID="txtDataInternacao" runat="server" Width="85px" onblur="javascript:valida_data(this);" onKeyPress="return MascaraCampo(document.form, this, '99/99/9999', event);" MaxLength="10"></asp:TextBox></td>
    <td style="width: 158px">
        <asp:TextBox ID="txtDataCirurgia" runat="server" Width="85px" onblur="javascript:valida_data(this);" onKeyPress="return MascaraCampo(document.form, this, '99/99/9999', event);" MaxLength="10"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtDiasInternacao" runat="server" Width="49px" MaxLength="3" onKeyPress="return MascaraCampo(document.form, this, '999', event);" ></asp:TextBox></td>
  </tr>
</table>
<table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="zebra_orange1">
    <td style="width: 848px">Procedimento Efetuado: </td>
    <td>Data do Procedimento: </td>
  </tr>
  <tr class="FundoAzul">
    <td style="width: 848px">
        <asp:TextBox ID="txtProcedimentoEfetuado" runat="server" Width="70%"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtDataProcedimento" runat="server" Width="85px" onblur="javascript:valida_data(this);" onKeyPress="return MascaraCampo(document.form, this, '99/99/9999', event);" MaxLength="10"></asp:TextBox></td>
  </tr>
</table>
<table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr class="zebra_orange1">
        <td>
            CRM do m&eacute;dico solicitante:</td>
    </tr>
  <tr class="FundoAzul">
    <td style="height: 24px">
        <asp:TextBox ID="txtCRM" runat="server" Width="81px" MaxLength="6" onKeyPress="return MascaraCampo(document.form, this, '999999', event);"></asp:TextBox>
        <asp:Label ID="lblNomeMedico" runat="server" Text="Label" Width="651px"></asp:Label></td>
  </tr>
</table>
<table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
<tr class="zebra_orange1">
<td align="center"> 
    <asp:Button ID="BtnSalvar" runat="server" OnClick="BtnSalvar_Click" Text="Salvar" /></td>
</tr>
</table>
    </fieldset>
    
</asp:Content>

