<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="GuiaConsultaCadastro.aspx.cs" Inherits="Guias_Consulta_GuiaConsultaCadastro" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<fieldset>
<legend>Guia de Consulta</legend>
<table width="100%" height="100%" border="0" cellspacing="0" class="texto">
  <tr>
    <td valign="top">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="texto">
        <tr>
          <td style="height: 19px">1 - Registro ANS</td>
          <td style="height: 19px">3 - Data de Emiss&atilde;o da Guia</td>
            <td rowspan="3" align="right">
                <asp:ImageButton ID="ImageButton1" runat="server" OnClick="ImageButton1_Click" ToolTip="Clique para ampliar" CausesValidation="False" />&nbsp;
            
            </td>
        </tr>
        <tr>
          <td style="height: 24px"><label>
              &nbsp;<asp:TextBox ID="txtRegANS" runat="server" MaxLength="6"></asp:TextBox></label></td>
          <td style="height: 24px">
              <asp:TextBox ID="txtDtEmissao" runat="server" MaxLength="10" onblur="javascript:valida_data(this);" onKeyPress="return MascaraCampo(document.form, this, '99/99/9999', event);"></asp:TextBox></td>
        </tr>
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
        <tr>
          <td colspan="3"  style="background-color:#CCCCCC">Dados do Benefici&aacute;rio </td>
        </tr>
        <tr>
          <td>4 - N&uacute;mero da Carteira</td>
          <td>5 - Plano </td>
          <td>6 - Validade da Carteira </td>
        </tr>
        <tr>
          <td>
              <asp:TextBox ID="txtNumCarteira" runat="server" MaxLength="20"></asp:TextBox></td>
          <td>
              <asp:TextBox ID="txtPlano" runat="server" MaxLength="40"></asp:TextBox></td>
          <td>
              <asp:TextBox ID="txtDtValidadeCarteira" runat="server" MaxLength="10" onblur="javascript:valida_data(this);" onKeyPress="return MascaraCampo(document.form, this, '99/99/9999', event);"></asp:TextBox></td>
        </tr>
        <tr>
          <td>7 - Nome </td>
          <td>8 - N&uacute;mero do Cart&atilde;o Nacional de Sa&uacute;de </td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>
              <asp:TextBox ID="txtNomeBeneficiario" runat="server" MaxLength="70"></asp:TextBox></td>
          <td>
              <asp:TextBox ID="txtNumCartaoNacionalSaude" runat="server" MaxLength="15"></asp:TextBox></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td colspan="3">&nbsp;</td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
        <tr>
          <td colspan="6" style="background-color:#CCCCCC">Dados do Contratado </td>
        </tr>
        <tr>
          <td>9 - C&oacute;digo na Operadora / CNPJ / CPF</td>
          <td>10 - Nome do Contratado </td>
          <td colspan="4">11 - C&oacute;digo CNES </td>
        </tr>
        <tr>
          <td style="height: 24px">
              <asp:TextBox ID="txtCodOperadoraCnpjCpf" runat="server" MaxLength="14"></asp:TextBox></td>
          <td style="height: 24px">
              <asp:TextBox ID="txtNomeContratado" runat="server" MaxLength="70"></asp:TextBox></td>
          <td colspan="4" style="height: 24px">
              <asp:TextBox ID="txtCNES" runat="server" MaxLength="7"></asp:TextBox></td>
        </tr>
        <tr>
          <td style="height: 19px">12 - Tipo Logradouro</td>
          <td style="height: 19px">13 - Logradouro</td>
          <td style="height: 19px"> 14 - Número</td>
          <td style="height: 19px"> 15 - Complemento</td>
          <td style="height: 19px">16 - Munic&iacute;pio </td>
          <td style="height: 19px">17 - UF &nbsp;</td>
        </tr>
        <tr>
          <td style="height: 24px">
              &nbsp;<asp:DropDownList ID="ddlTipoLogradouro" runat="server" DataSourceID="TipoLogradouro"
                  DataTextField="Descricao" DataValueField="Id" OnPreRender="txtTipoLogradouro_PreRender">
              </asp:DropDownList>
              <asp:ObjectDataSource ID="TipoLogradouro" runat="server" SelectMethod="SelectTipoLogradouro"
                  TypeName="TissObjetos.GuiaConsultaDAL"></asp:ObjectDataSource>
          </td>
          <td style="height: 24px">
              <asp:TextBox ID="txtLogradouro" runat="server" MaxLength="40"></asp:TextBox></td>
          <td style="height: 24px">
              <asp:TextBox ID="txtNumero" runat="server" MaxLength="5" Width="59px"></asp:TextBox></td>
          <td style="height: 24px">
              <asp:TextBox ID="txtComplemento" runat="server" MaxLength="15"></asp:TextBox></td>
          <td style="height: 24px">
              <asp:TextBox ID="txtMunicipio" runat="server" MaxLength="40" Width="104px"></asp:TextBox></td>
          <td style="height: 24px">
              <asp:TextBox ID="txtUF" runat="server" MaxLength="2" Width="34px"></asp:TextBox></td>
        </tr>
          <tr>
              <td style="height: 24px">
                  18 - C&oacute;digo IBGE</td>
              <td style="height: 24px">
                  19 - CEP</td>
              <td style="height: 24px">
              </td>
              <td style="height: 24px">
              </td>
              <td style="height: 24px">
              </td>
              <td style="height: 24px">
              </td>
          </tr>
          <tr>
              <td style="height: 24px">
              <asp:TextBox ID="txtCodIBGE" runat="server" MaxLength="7" Width="59px"></asp:TextBox></td>
              <td style="height: 24px">
              <asp:TextBox ID="txtCEP" runat="server" MaxLength="8" Width="59px"></asp:TextBox></td>
              <td style="height: 24px">
              </td>
              <td style="height: 24px">
              </td>
              <td style="height: 24px">
              </td>
              <td style="height: 24px">
              </td>
          </tr>
        <tr>
          <td style="height: 38px">20 - Nome do Profissional Executante </td>
          <td style="height: 38px">21 - Conselho Profissional
          </td>
          <td style="height: 38px">22 - N&ordm; do Conselho </td>
          <td style="height: 38px">23 - UF </td>
          <td style="height: 38px">24 - Código CBO-S
          </td>
          <td style="height: 38px">&nbsp;</td>
        </tr>
        <tr>
          <td>
              <asp:TextBox ID="txtNomeProfissional" runat="server" MaxLength="70"></asp:TextBox></td>
          <td>
              <asp:DropDownList ID="ddlConselhoProfissional" runat="server" DataSourceID="ConselhoProfissional"
                  DataTextField="Codigo" DataValueField="Id" OnPreRender="ddlConselhoProfissional_PreRender">
              </asp:DropDownList>
              <asp:ObjectDataSource ID="ConselhoProfissional" runat="server" SelectMethod="SelectConselhoProfissional"
                  TypeName="TissObjetos.GuiaConsultaDAL"></asp:ObjectDataSource>
          </td>
          <td>
              <asp:TextBox ID="txtNumeroConselho" runat="server" MaxLength="15" Width="59px"></asp:TextBox></td>
          <td>
              <asp:TextBox ID="txtUFConselho" runat="server" MaxLength="2" Width="59px"></asp:TextBox></td>
          <td colspan="2">
              <asp:DropDownList ID="ddlCBOS" runat="server" DataSourceID="CBOS" DataTextField="Descricao"
                  DataValueField="Id" OnPreRender="txtCBOS_PreRender" Width="185px">
              </asp:DropDownList>
              <asp:ObjectDataSource ID="CBOS" runat="server" SelectMethod="SelectCBOS" TypeName="TissObjetos.GuiaConsultaDAL">
              </asp:ObjectDataSource>
              &nbsp;</td>
        </tr>
        <tr>
          <td colspan="6">&nbsp;</td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
        <tr>
          <td colspan="4" style="background-color:#CCCCCC; height: 19px;">Hip&oacute;tese Diagn&oacute;stica </td>
        </tr>
        <tr>
          <td>25 - Tipo Doen&ccedil;a </td>
          <td>26 - Tempo de Doen&ccedil;a </td>
          <td colspan="2">27 - Indica&ccedil;&atilde;o de Acidente </td>
        </tr>
        <tr>
          <td>
              <asp:DropDownList ID="ddlTipoDoenca" runat="server" DataSourceID="TipoDoenca" DataTextField="Descricao" DataValueField="Id" OnPreRender="ddlTipoDoenca_PreRender">
              </asp:DropDownList>
              <asp:ObjectDataSource ID="TipoDoenca" runat="server" SelectMethod="SelectTipoDoenca"
                  TypeName="TissObjetos.GuiaConsultaDAL"></asp:ObjectDataSource>
          </td>
          <td>
              <asp:TextBox ID="txtTempoDoenca" runat="server" Width="28px" MaxLength="2"></asp:TextBox>
              <asp:DropDownList ID="ddlTempoDoencaUnidade" runat="server" DataSourceID="TempoDoenca" DataTextField="Descricao" DataValueField="Id" OnPreRender="ddlTempoDoencaUnidade_PreRender">
                  <asp:ListItem Value="A">Anos</asp:ListItem>
                  <asp:ListItem Value="M">Meses</asp:ListItem>
                  <asp:ListItem Value="D">Dias</asp:ListItem>
              </asp:DropDownList>
              <asp:ObjectDataSource ID="TempoDoenca" runat="server" SelectMethod="SelectDominioUnidadeTempoDoenca"
                  TypeName="TissObjetos.GuiaConsultaDAL"></asp:ObjectDataSource>
          </td>
          <td colspan="2">
              <asp:DropDownList ID="ddlIndicacaoAcidente" runat="server" DataSourceID="IndicadorAcidente" DataTextField="Descricao" DataValueField="id" OnPreRender="ddlIndicacaoAcidente_PreRender">
              </asp:DropDownList>
              <asp:ObjectDataSource ID="IndicadorAcidente" runat="server" SelectMethod="SelectIndicadorAcidente"
                  TypeName="TissObjetos.GuiaConsultaDAL"></asp:ObjectDataSource>
          </td>
        </tr>
        <tr>
          <td>28 - CID 10 Principal </td>
          <td>29 - CID (2) </td>
          <td>30 - CID (3) </td>
          <td>31 - CID (4) </td>
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
        <tr>
          <td colspan="4">&nbsp;</td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
        <tr>
          <td colspan="3" style="background-color:#CCCCCC; height: 19px;">Dados de Atendimento / Procedimento Realizado</td>
        </tr>
        <tr>
          <td>32 - Data do Atendimento </td>
          <td>33 - Código Tabela.
          </td>
          <td>34 - C&oacute;digo Procedimento </td>
        </tr>
        <tr>
          <td style="height: 24px">
              <asp:TextBox ID="txtDtAtendimento" runat="server" MaxLength="10" onblur="javascript:valida_data(this);" onKeyPress="return MascaraCampo(document.form, this, '99/99/9999', event);"></asp:TextBox></td>
          <td style="height: 24px">
              <asp:DropDownList ID="ddlCodTabela" runat="server" DataSourceID="Tabelas" DataTextField="Descricao"
                  DataValueField="Id" OnPreRender="txtCodTabela_PreRender" Width="300px">
              </asp:DropDownList>
              <asp:ObjectDataSource ID="Tabelas" runat="server" SelectMethod="SelectTabelas" TypeName="TissObjetos.GuiaConsultaDAL">
              </asp:ObjectDataSource>
          </td>
          <td style="height: 24px">
              <asp:TextBox ID="txtCodProcedimento" runat="server" MaxLength="10"></asp:TextBox></td>
        </tr>
        <tr>
          <td>35 - Tipo de Consulta </td>
          <td>36 - Tipo de Sa&iacute;da </td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>
              <asp:DropDownList ID="ddlTipoConsulta" runat="server" DataSourceID="TipoConsulta" DataTextField="Descricao" DataValueField="Id" OnPreRender="ddlTipoConsulta_PreRender">
                  <asp:ListItem Value="1">Primeira</asp:ListItem>
                  <asp:ListItem Value="2">Seguimento</asp:ListItem>
                  <asp:ListItem Value="3">Pr&#233; Natal</asp:ListItem>
              </asp:DropDownList>
              <asp:ObjectDataSource ID="TipoConsulta" runat="server" SelectMethod="SelectTipoConsulta"
                  TypeName="TissObjetos.GuiaConsultaDAL"></asp:ObjectDataSource>
          </td>
          <td>
              <asp:DropDownList ID="ddlTipoSaida" runat="server" DataSourceID="TipoSaida" DataTextField="Descricao" DataValueField="id" OnPreRender="ddlTipoSaida_PreRender">
              </asp:DropDownList>
              <asp:ObjectDataSource ID="TipoSaida" runat="server" SelectMethod="SelectTipoSaida"
                  TypeName="TissObjetos.GuiaConsultaDAL"></asp:ObjectDataSource>
          </td>
          <td>&nbsp;</td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
        <tr>
          <td>37 - Observa&ccedil;&atilde;o </td>
        </tr>
        <tr>
          <td>
              <asp:TextBox ID="txtObservacao" runat="server" Rows="3" TextMode="MultiLine" Width="100%" MaxLength="240"></asp:TextBox></td>
        </tr>
      </table>
      <table width="100%">
        <tr>
            <td></td>
        </tr>
        <tr>
            <td align=center style="height: 121px" valign="top"><asp:Button ID="BtnSalvar" runat="server" Text="Salvar" OnClick="BtnSalvar_Click" />
                <asp:RequiredFieldValidator ID="RegistroANS" runat="server" ControlToValidate="txtRegANS"
                    Display="None" ErrorMessage="Registro da operadora na ANS" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="DtEmissaoGuia" runat="server" ControlToValidate="txtDtEmissao"
                    Display="None" ErrorMessage="Data de emissão da guia" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="NumCartaoBeneficiario" runat="server" ControlToValidate="txtNumCarteira"
                    Display="None" ErrorMessage="Número do cartão do beneficiário" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="Plano" runat="server" ControlToValidate="txtPlano"
                    Display="None" ErrorMessage="Nome do plano do beneficiário" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="NomeBeneficiario" runat="server" ControlToValidate="txtNomeBeneficiario"
                    Display="None" ErrorMessage="Nome do beneficiário" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="CodOperadora" runat="server" ControlToValidate="txtCodOperadoraCnpjCpf"
                    Display="None" ErrorMessage="Código na operadora ou CNPJ ou CPF do contratado"
                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="NomeContratado" runat="server" ControlToValidate="txtNomeContratado"
                    Display="None" ErrorMessage="Nome do contratato" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="ConselhoProf" runat="server" ControlToValidate="ddlConselhoProfissional"
                    Display="None" ErrorMessage="Sigla do conselho profissional do executante" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="NumeroConselho" runat="server" ControlToValidate="txtNumeroConselho"
                    Display="None" ErrorMessage="Número no conselho profissional do executante" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="UFConselho" runat="server" ControlToValidate="txtUFConselho"
                    Display="None" ErrorMessage="Sigla da unidade federativa do conselho profissional do executante"
                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="DataAtendimento" runat="server" ControlToValidate="txtDtAtendimento"
                    Display="None" ErrorMessage="Data de realização do atendimento" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="CodigoTabela" runat="server" ControlToValidate="ddlCodTabela"
                    Display="None" ErrorMessage="Código da tabela utilizada para descrever os procedimentos"
                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="CodigoProcedimento" runat="server" ControlToValidate="txtCodProcedimento"
                    Display="None" ErrorMessage="Código do procedimento realizado" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="TipoDeConsulta" runat="server" ControlToValidate="ddlTipoConsulta"
                    Display="None" ErrorMessage="Tipo de consulta" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="TipoDeSaida" runat="server" ControlToValidate="ddlTipoSaida"
                    Display="None" ErrorMessage="Tipo de saída" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" HeaderText="Os seguintes campos são de preenchimento obritório"
                    ShowMessageBox="True" ShowSummary="False" />
            </td>
        </tr>
      </table>
      </td>
  </tr>
</table>
</fieldset>

</asp:Content>

