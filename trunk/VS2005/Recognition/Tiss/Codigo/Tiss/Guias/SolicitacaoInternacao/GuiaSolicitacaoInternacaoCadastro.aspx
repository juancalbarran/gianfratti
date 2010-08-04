<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="GuiaSolicitacaoInternacaoCadastro.aspx.cs" Inherits="Guias_SolicitacaoInternacao_GuiaSolicitacaoInternacaoCadastro" Title="Untitled Page" %>

<%@ Register Src="../../UserControls/Dominio/DropDownList/TipoAcomodacao.ascx" TagName="TipoAcomodacao"
    TagPrefix="uc10" %>

<%@ Register Src="../../UserControls/Dominio/DropDownList/Tabelas.ascx" TagName="Tabelas"
    TagPrefix="uc9" %>

<%@ Register Src="../../UserControls/Dominio/DropDownList/UnidadeTempoDoenca.ascx"
    TagName="UnidadeTempoDoenca" TagPrefix="uc7" %>
<%@ Register Src="../../UserControls/Dominio/DropDownList/IndicadorAcidente.ascx"
    TagName="IndicadorAcidente" TagPrefix="uc8" %>

<%@ Register Src="../../UserControls/Dominio/DropDownList/TipoInternacao.ascx" TagName="TipoInternacao"
    TagPrefix="uc4" %>
<%@ Register Src="../../UserControls/Dominio/DropDownList/RegimeInternacao.ascx"
    TagName="RegimeInternacao" TagPrefix="uc5" %>
<%@ Register Src="../../UserControls/Dominio/DropDownList/TipoDoenca.ascx" TagName="TipoDoenca"
    TagPrefix="uc6" %>

<%@ Register Src="../../UserControls/Dominio/DropDownList/CaraterInternacao.ascx"
    TagName="CaraterInternacao" TagPrefix="uc3" %>

<%@ Register Src="../../UserControls/Dominio/DropDownList/CBOS.ascx" TagName="CBOS"
    TagPrefix="uc2" %>

<%@ Register Src="../../UserControls/Dominio/DropDownList/ConselhoProfissional.ascx"
    TagName="ConselhoProfissional" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<fieldset>
<legend>Guia de Solicitação de Internação</legend>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
  <tr>
    <td>1 - Registro ANS </td>
    <td>3 - Data da Autoriza&ccedil;&atilde;o </td>
    <td>4 - Senha </td>
    <td>5 - Data Validade Senha </td>
    <td>6 - Data de Emiss&atilde;o da Guia </td>
  </tr>
  <tr>
    <td>
        <asp:TextBox ID="txtRegANS" runat="server" MaxLength="6"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtDtAutorizacao" runat="server" MaxLength="10" onblur="javascript:valida_data(this);" onKeyPress="return MascaraCampo(document.form, this, '99/99/9999', event);"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtSenha" runat="server" MaxLength="20"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtDtValidadeSenha" runat="server" MaxLength="10" onblur="javascript:valida_data(this);" onKeyPress="return MascaraCampo(document.form, this, '99/99/9999', event);"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtDtEmissao" runat="server" MaxLength="10" onblur="javascript:valida_data(this);" onKeyPress="return MascaraCampo(document.form, this, '99/99/9999', event);"></asp:TextBox></td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
  <tr>
    <td style="background-color:#CCCCCC" colspan="3">Dados do Benefici&aacute;rio </td>
  </tr>
  <tr>
    <td>7 - N&uacute;mero da Carteira </td>
    <td>8 - Plano </td>
    <td>9 - Validade da Carteira </td>
  </tr>
  <tr>
    <td style="height: 24px">
        <asp:TextBox ID="txtNumCarteira" runat="server" MaxLength="20"></asp:TextBox></td>
    <td style="height: 24px">
        <asp:TextBox ID="txtPlano" runat="server" MaxLength="40"></asp:TextBox></td>
    <td style="height: 24px">
        <asp:TextBox ID="txtDtValidadeCarteira" runat="server" MaxLength="10" onblur="javascript:valida_data(this);" onKeyPress="return MascaraCampo(document.form, this, '99/99/9999', event);"></asp:TextBox></td>
  </tr>
  <tr>
    <td style="height: 19px">10 - Nome </td>
    <td colspan="2" style="height: 19px">
        11 - N&uacute;mero do Cart&atilde;o Nacional de Sa&uacute;de </td>
  </tr>
  <tr>
    <td>
        <asp:TextBox ID="txtNomeBeneficiario" runat="server" MaxLength="70"></asp:TextBox></td>
    <td colspan="2">
        <asp:TextBox ID="txtNumCartaoNacionalSaude" runat="server" MaxLength="15"></asp:TextBox></td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
  <tr>
    <td colspan="4" style="background-color:#CCCCCC; height: 19px;">Dados do Contratado Solicitante</td>
  </tr>
  <tr>
    <td>12 - C&oacute;digo da Operadora / CNPJ / CPF </td>
    <td>13 - Nome do Contratado </td>
    <td>14 - C&oacute;digo CNES </td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
        <asp:TextBox ID="txtCodOperadoraCnpjCpf" runat="server" MaxLength="14"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtNomeContratado" runat="server" MaxLength="70"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtCNES" runat="server" MaxLength="7"></asp:TextBox></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>15 - Nome do Profissional Solicitante</td>
    <td>16 - Conselho Profissional</td>
    <td>17 - N&uacute;mero do Conselho</td>
    <td>18 - UF</td>
  </tr>
  <tr>
    <td>
        <asp:TextBox ID="txtNomeProfissional" runat="server" MaxLength="70"></asp:TextBox></td>
    <td>
        <uc1:ConselhoProfissional ID="ddlConselhoProfissional" runat="server" CampoObrigatorio="true" />
    </td>
    <td>
        <asp:TextBox ID="txtNumeroConselho" runat="server" MaxLength="15"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtUFConselho" runat="server" Width="46px" MaxLength="2"></asp:TextBox></td>
  </tr>
    <tr>
        <td>
            19 - C&oacute;digo CBO S</td>
        <td>
        </td>
        <td>
        </td>
        <td>
        </td>
    </tr>
    <tr>
        <td colspan="4">
        <uc2:CBOS ID="ddlCBOS" runat="server" />
        </td>
    </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
  <tr>
    <td colspan="2" style="background-color:#CCCCCC; height: 19px;">Dados do Contratado Solicitante / Dados da Interna&ccedil;&atilde;o</td>
  </tr>
  <tr>
    <td style="height: 19px">20 - C&oacute;digo da Operadora / CNPJ</td>
    <td style="height: 19px">21 - Nome do Prestador</td>
  </tr>
  <tr>
    <td style="height: 24px">
        <asp:TextBox ID="txtCodOperadoraCnpj" runat="server" MaxLength="14"></asp:TextBox></td>
    <td style="height: 24px">
        <asp:TextBox ID="txtNomePrestador" runat="server" MaxLength="70"></asp:TextBox></td>
  </tr>
  <tr>
    <td>22 - Car&aacute;ter de Interna&ccedil;&atilde;o</td>
    <td>23 - Tipo de Interna&ccedil;&atilde;o</td>
  </tr>
  <tr>
    <td>
        <uc3:CaraterInternacao ID="ddlCaraterInternacao" runat="server" CampoObrigatorio="true" />
    </td>
    <td>
        <uc4:TipoInternacao ID="ddlTipoInternacao" runat="server" CampoObrigatorio="true" />
    </td>
  </tr>
  <tr>
    <td>24 - Regime de Interna&ccedil;&atilde;o</td>
    <td>25 - Qtde. Di&aacute;rias Solicitadas</td>
  </tr>
  <tr>
    <td style="height: 24px">
        <uc5:RegimeInternacao ID="ddlRegimeInternacao" runat="server" CampoObrigatorio="true" />
    </td>
    <td style="height: 24px">
        <asp:TextBox ID="txtQtdDiariasSolicitadas" runat="server" MaxLength="3"></asp:TextBox></td>
  </tr>
  <tr>
    <td>26 - Indica&ccedil;&atilde;o Cl&iacute;nica</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">
        <asp:TextBox ID="txtIndicacaoClinica" runat="server" TextMode="MultiLine" Width="100%"></asp:TextBox></td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
  <tr>
    <td colspan="4" style="background-color:#CCCCCC">Hip&oacute;tese Diagn&oacute;stica</td>
  </tr>
  <tr>
    <td>27 - Tipo Doen&ccedil;a </td>
    <td>28 - Tempo de Doen&ccedil;a Referida pelo Paciente </td>
    <td>29 - Indica&ccedil;&atilde;o de Acidente </td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="height: 24px">
        <uc6:TipoDoenca ID="ddlTipoDoenca" runat="server" />
    </td>
    <td style="height: 24px">
        <asp:TextBox ID="txtTempoDoenca" runat="server" Width="43px" MaxLength="2" onKeyPress="return MascaraCampo(document.form, this, '99', event);"></asp:TextBox>
        <uc7:UnidadeTempoDoenca ID="ddlUnidadeTempoDoenca" runat="server" />
    </td>
    <td style="height: 24px">
        <uc8:IndicadorAcidente ID="ddlIndicadorAcidente" runat="server" />
    </td>
    <td style="height: 24px">&nbsp;</td>
  </tr>
  <tr>
    <td>30 - CID 10 Principal </td>
    <td>31 - CID 10 (2) </td>
    <td>32 - CID 10 (3) </td>
    <td>33 - CID 10 (4) </td>
  </tr>
  <tr>
    <td>
        <asp:TextBox ID="txtCID10_1" runat="server" MaxLength="5"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtCID10_2" runat="server" MaxLength="5"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtCID10_3" runat="server" MaxLength="5"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtCID10_4" runat="server" MaxLength="5"></asp:TextBox></td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
  <tr>
    <td colspan="6" style="background-color:#CCCCCC;">Procedimentos Solicitados </td>
  </tr>
  <tr>
    <td style="height: 19px">34 - Tabela</td>
    <td style="height: 19px">35 - C&oacute;digo do Procedimento</td>
    <td style="height: 19px">36 - Descri&ccedil;&atilde;o</td>
    <td style="height: 19px">37 - Qtde. Solict.</td>
    <td style="height: 19px">38 - Qtde. Aut.</td>
    <td style="height: 19px">
        &nbsp;</td>
  </tr>
  <tr>
    <td>
        <uc9:Tabelas ID="ddlTabelas_Procedimentos" runat="server" />
    </td>
    <td>
        <asp:TextBox ID="txtCodProcedimento" runat="server" MaxLength="10"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtDescProcedimento" runat="server" MaxLength="60"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtQtdSolicitada" runat="server" Width="46px" MaxLength="2" onKeyPress="return MascaraCampo(document.form, this, '99', event);"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtQtdAutorizado" runat="server" Width="46px" MaxLength="2" onKeyPress="return MascaraCampo(document.form, this, '99', event);"></asp:TextBox></td>
    <td>
        <asp:Button ID="btnIncluirProcedimentos" runat="server" OnClick="btnIncluirProcedimentos_Click"
            Text="Incluir" CausesValidation="False" /></td>
  </tr>
</table>
    <asp:GridView ID="GridViewProcedimentos" runat="server" CellPadding="4" ForeColor="#333333" AutoGenerateColumns="False" CssClass="texto" OnSelectedIndexChanged="GridViewProcedimentos_SelectedIndexChanged" Width="100%" OnRowDataBound="GridViewProcedimentos_RowDataBound" ShowFooter="True"
        >
        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:BoundField DataField="idTabela" HeaderText="Tabela">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Codigo" HeaderText="C&#243;digo">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Descricao" HeaderText="Descri&#231;&#227;o">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="QtdSolicitada" HeaderText="Qtd. Solicitada">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="QtdAutorizada" HeaderText="Qtd. Autorizada">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:CommandField SelectText="Excluir" ShowSelectButton="True">
                <HeaderStyle HorizontalAlign="Right" />
            </asp:CommandField>
        </Columns>
        <RowStyle BackColor="#E3EAEB" />
        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
        <EditRowStyle BackColor="#7C6F57" />
    </asp:GridView>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
  <tr>
    <td colspan="7" style="background-color:#CCCCCC; height: 19px;">OPM Solicitados </td>
  </tr>
  <tr>
    <td>39 - Tabela</td>
    <td>40 - C&oacute;digo do OPM</td>
    <td>41 - Descri&ccedil;&atilde;o OPM</td>
    <td>42 - Qtde.</td>
    <td>43 - Fabricante</td>
    <td>44 - Valor Unit&aacute;rio</td>
    <td></td>
  </tr>
  <tr>
    <td><uc9:Tabelas ID="ddlTabelas_OPM" runat="server" /></td>
    <td>
        <asp:TextBox ID="txtCodOPM" runat="server" MaxLength="10"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtDescOPM" runat="server" MaxLength="60"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtQtdOPM" runat="server" Width="46px" MaxLength="2"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtFabricanteOPM" runat="server" MaxLength="40"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtValorOPM" runat="server" Width="46px"></asp:TextBox></td>
    <td>
        <asp:Button ID="btnIncluirOPM" runat="server" Text="Incluir" OnClick="btnIncluirOPM_Click" /></td>
  </tr>
</table>
    <asp:GridView ID="GridViewOPMSolicitados" runat="server" CellPadding="4" ForeColor="#333333" AutoGenerateColumns="False" CssClass="texto" OnSelectedIndexChanged="GridViewOPMSolicitados_SelectedIndexChanged" Width="100%" OnRowDataBound="GridViewOPMSolicitados_RowDataBound" ShowFooter="True"
        >
        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:BoundField DataField="idTabela" HeaderText="Tabela">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Codigo" HeaderText="C&#243;digo">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Descricao" HeaderText="Descri&#231;&#227;o">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Qtd" HeaderText="Qtd">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Fabricante" HeaderText="Fabricante">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="ValorUni" HeaderText="ValorUnit&#225;rio" />
            <asp:CommandField SelectText="Excluir" ShowSelectButton="True">
                <HeaderStyle HorizontalAlign="Right" />
            </asp:CommandField>
        </Columns>
        <RowStyle BackColor="#E3EAEB" />
        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
        <EditRowStyle BackColor="#7C6F57" />
    </asp:GridView>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
  <tr>
    <td colspan="3" style="background-color:#CCCCCC;">Dados da Autoriza&ccedil;&atilde;o </td>
  </tr>
  <tr>
    <td>45 - Data Prov&aacute;vel de Admiss&atilde;o Hospitalar </td>
    <td>46 - Qtde. Di&aacute;rias Autorizadas </td>
    <td>47 - Tipo de Acomoda&ccedil;&atilde;o Autorizada </td>
  </tr>
  <tr>
    <td style="height: 24px">
        <asp:TextBox ID="txtdtProvavelAdmissao" runat="server" MaxLength="10" onblur="javascript:valida_data(this);" onKeyPress="return MascaraCampo(document.form, this, '99/99/9999', event);"></asp:TextBox></td>
    <td style="height: 24px">
        <asp:TextBox ID="txtQtdDiariasAutorizadas" runat="server" Width="46px" MaxLength="3" onKeyPress="return MascaraCampo(document.form, this, '9999', event);"></asp:TextBox></td>
    <td style="height: 24px">
        <uc10:TipoAcomodacao ID="ddlTipoAcomodacao" runat="server" />
    </td>
  </tr>
  <tr>
    <td>48 - C&oacute;digo da Operadora / CNPJ</td>
    <td>49 - Nome do Prestador autorizado</td>
    <td>50 - C&oacute;d. CNES</td>
  </tr>
  <tr>
    <td>
        <asp:TextBox ID="txtCodigoOperadoraCNPJ" runat="server" MaxLength="14" ></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtNomePrestadorAutorizado" runat="server" MaxLength="70"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="txtCodigoCNES" runat="server" MaxLength="7"></asp:TextBox></td>
  </tr>
  <tr>
    <td>51 - Observa&ccedil;&atilde;o</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td colspan="3">
        <asp:TextBox ID="txtObservacoes" runat="server" TextMode="MultiLine" Width="100%" MaxLength="240"></asp:TextBox></td>
  </tr>
  <tr>
    <td>52 - Data e Assinatura do M&eacute;dico Solicitante</td>
    <td>53 - Data e Assinatura do Benefici&aacute;rio ou Responsavel </td>
    <td>54 - Data e Assinatura do Resp. p/ Autoriza&ccedil;&atilde;o </td>
  </tr>
  <tr>
    <td>
        <asp:TextBox ID="TextBox95" runat="server"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="TextBox96" runat="server"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="TextBox97" runat="server"></asp:TextBox></td>
  </tr>
</table>

<a href="javascript:AbrePopUp('../PaginasAuxiliares/Prorrogacoes/Default.aspx?idGuiaSolicitacaoInternacao='+PegaParamentro(self.location.href,'ID'),'1200','500',this,event)"><img src="../../Template/Img/pesquisa.gif" border="0" WIDTH="15" HEIGHT="13"></a>
    <asp:Button ID="BtnSalvar" runat="server" Text="Salvar" OnClick="BtnSalvar_Click" />&nbsp;
    <asp:ValidationSummary ID="ValidationSummary2" runat="server" HeaderText="Os seguintes campos são de preenchimento obritório"
        ShowMessageBox="True" ShowSummary="False" />
    <asp:RequiredFieldValidator ID="RegistroANS" runat="server" ControlToValidate="txtRegANS"
        Display="None" ErrorMessage="Registro da operadora na ANS" SetFocusOnError="True"></asp:RequiredFieldValidator><asp:RequiredFieldValidator
            ID="DtEmissaoGuia" runat="server" ControlToValidate="txtDtEmissao" Display="None"
            ErrorMessage="Data de emissão da guia" SetFocusOnError="True"></asp:RequiredFieldValidator><asp:RequiredFieldValidator
                ID="NumCartaoBeneficiario" runat="server" ControlToValidate="txtNumCarteira"
                Display="None" ErrorMessage="Número do cartão do beneficiário" SetFocusOnError="True"></asp:RequiredFieldValidator><asp:RequiredFieldValidator
                    ID="Plano" runat="server" ControlToValidate="txtPlano" Display="None" ErrorMessage="Nome do plano do beneficiário"
                    SetFocusOnError="True"></asp:RequiredFieldValidator><asp:RequiredFieldValidator ID="NomeBeneficiario"
                        runat="server" ControlToValidate="txtNomeBeneficiario" Display="None" ErrorMessage="Nome do beneficiário"
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
    <asp:RequiredFieldValidator ID="CodOperadoraCnpjCpf" runat="server" ControlToValidate="txtCodOperadoraCnpjCpf"
        Display="None" ErrorMessage="Código na operadora ou CNPJ ou CPF do contratado solicitante"
        SetFocusOnError="True"></asp:RequiredFieldValidator><asp:RequiredFieldValidator ID="NomeContratado"
            runat="server" ControlToValidate="txtNomeContratado" Display="None" ErrorMessage="Nome do contratado solicitante"
            SetFocusOnError="True"></asp:RequiredFieldValidator><asp:RequiredFieldValidator ID="NumeroConselho"
                runat="server" ControlToValidate="txtNumeroConselho" Display="None" ErrorMessage="Número do conselho profissional"
                SetFocusOnError="True"></asp:RequiredFieldValidator><asp:RequiredFieldValidator ID="UFConselho"
                    runat="server" ControlToValidate="txtUFConselho" Display="None" ErrorMessage="Sigla da Unidade Federativa do Conselho Profissional"
                    SetFocusOnError="True"></asp:RequiredFieldValidator><asp:RequiredFieldValidator ID="QtdDiariasSolicitadas"
                        runat="server" ControlToValidate="txtQtdDiariasSolicitadas" Display="None" ErrorMessage="Quantidade de diárias solicitadas"
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
    <asp:RequiredFieldValidator ID="IndicacaoClinica" runat="server" ControlToValidate="txtIndicacaoClinica"
        Display="None" ErrorMessage="Texto livre preenchido pelo profissional médico solicitante da internação"
        SetFocusOnError="True"></asp:RequiredFieldValidator>
    <asp:RequiredFieldValidator ID="CID10_1" runat="server" ControlToValidate="txtCID10_1"
        Display="None" ErrorMessage="Código CID10 do diagnóstico principal" SetFocusOnError="True"></asp:RequiredFieldValidator>
    <asp:RequiredFieldValidator ID="DescProcedimento" runat="server" ControlToValidate="txtDescProcedimento"
        Display="None" ErrorMessage="Descrição do procedimento" SetFocusOnError="True"></asp:RequiredFieldValidator>
    <asp:RequiredFieldValidator ID="QtdSolicitada" runat="server" ControlToValidate="txtQtdSolicitada"
        Display="None" ErrorMessage="Quantidade de procedimentos solicitados" SetFocusOnError="True"></asp:RequiredFieldValidator><asp:RequiredFieldValidator
            ID="QtdAutorizado" runat="server" ControlToValidate="txtQtdAutorizado" Display="None"
            ErrorMessage="Quantidade de procedimentos autorizados pela operadora" SetFocusOnError="True"></asp:RequiredFieldValidator></fieldset>
</asp:Content>

