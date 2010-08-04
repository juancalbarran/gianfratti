<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true"
    CodeFile="ProfissionalCadastro.aspx.cs" Inherits="Profissionais_ProfissionalCadastro"
    Title="Untitled Page" %>

<%@ Register Src="../UserControls/DropDownList/TipoProfissional.ascx" TagName="TipoProfissional"
    TagPrefix="uc4" %>
<%@ Register Src="../UserControls/DropDownList/Estados.ascx" TagName="Estados" TagPrefix="uc3" %>
<%@ Register Src="../UserControls/DropDownList/CBOS.ascx" TagName="CBOS" TagPrefix="uc2" %>
<%@ Register Src="../UserControls/DropDownList/ConselhoProfissional.ascx" TagName="ConselhoProfissional"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" language="JavaScript">
	//Declara um Array com a posicao e nome das Abas
	var arAbas = new Array();
	arAbas[0] = new stAba('td_FichaPessoal','div_FichaPessoal');
	arAbas[1] = new stAba('td_FichaProfissional','div_FichaProfissional');
	
	//Verifica se o CPF é valido
	function Verifica_CPF(CPF)
	{
	    if (!Valida_CPF(CPF.value)){document.aspnetForm.ctl00$ContentPlaceHolder1$TxtCPF.value = "";return false;}
	}
    </script>

    <fieldset style="height: 100%">
        <legend align="center">&nbsp;Cadastro do Profissional de Saúde&nbsp;</legend>
        <table cellspacing="0" cellpadding="0" border="0" style="border-left: 1px solid #000000;
            width: 100%; height: 100%">
            <tr>
                <td id="td_FichaPessoal" style="border-bottom: 0px solid #000000; width: 100; height: 20">
                    <a href="#" style="color: #000000;" onclick="AlternarAbas('td_FichaPessoal','div_FichaPessoal')">
                        Ficha Pessoal</a></td>
                <td id="td_FichaProfissional" style="border-bottom: 0px solid #000000; width: 100;
                    height: 20">
                    <a href="#" style="color: #000000;" onclick="AlternarAbas('td_FichaProfissional','div_FichaProfissional')">
                        Ficha Profissional</a>
                </td>
                <td style="border-bottom: 1px solid #000000; width: 460">
                </td>
            </tr>
            <tr>
                <td class="tb-conteudo" colspan="4" valign="Top" style="border-top: 1px solid #000000;
                    width: 100%; height: 100%">
                    <div id="div_FichaPessoal" class="conteudo" style="display: none">
                        <br />
                        <fieldset>
                            <table class="texto" style="width: 100%; height: 100%" border="0" cellpadding="0"
                                cellspacing="1">
                                <tr>
                                    <td style="width: 100px; height: 13px;">
                                        CPF:</td>
                                    <td style="width: 100px; height: 13px;">
                                    </td>
                                    <td style="width: 100px; height: 13px">
                                    </td>
                                    <td style="width: 100px; height: 13px;">
                                    </td>
                                    <td>
                                    </td>
                                    <td style="width: 100px; height: 13px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100px; height: 21px;">
                                        <asp:TextBox ID="txtCPF" runat="server" MaxLength="14" onblur="javascript:Verifica_CPF(this);"
                                            onkeypress="return MascaraCampo(this.form.name, this, '999.999.999-99', event);"></asp:TextBox></td>
                                    <td style="width: 100px; height: 21px;">
                                    </td>
                                    <td style="width: 100px; height: 21px">
                                    </td>
                                    <td style="width: 100px; height: 21px;">
                                    </td>
                                    <td colspan="2" style="height: 21px">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td style="width: 100px; height: 21px">
                                        RG:</td>
                                    <td style="width: 100px; height: 21px">
                                        Data Expedição:</td>
                                    <td style="width: 100px; height: 21px">
                                        UF:</td>
                                    <td style="width: 100px; height: 21px">
                                        Orgão Expeditor:</td>
                                    <td colspan="2" style="height: 21px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100px; height: 21px">
                                        <asp:TextBox ID="txtRG" runat="server" MaxLength="20"></asp:TextBox></td>
                                    <td style="width: 100px; height: 21px">
                                        <asp:TextBox ID="txtDtExpedicao" runat="server" MaxLength="10" onblur="javascript:valida_data(this);"
                                            onkeypress="return MascaraCampo(this.form.name, this, '99/99/9999', event);"
                                            Width="147px"></asp:TextBox></td>
                                    <td style="width: 100px; height: 21px">
                                        <uc3:Estados ID="ddlRgUFemissao" runat="server" />
                                    </td>
                                    <td colspan="3" style="height: 21px">
                                        <asp:DropDownList ID="ddlOrgaoExpeditor" runat="server" CssClass="texto" DataSourceID="SqlDataSource5"
                                            DataTextField="Sigla" DataValueField="id" Width="62%" OnPreRender="ddlOrgaoExpeditor_PreRender">
                                        </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:cnnString %>"
                                            SelectCommand="SELECT [id], ([Sigla] + ' - ' + [Descricao]) as Sigla FROM [TipoOrgaoExpeditor]">
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100px">
                                        Nome:</td>
                                    <td style="width: 100px">
                                    </td>
                                    <td style="width: 100px">
                                    </td>
                                    <td style="width: 100px">
                                    </td>
                                    <td style="width: 100px">
                                    </td>
                                    <td style="width: 100px">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="height: 23px">
                                        <asp:TextBox ID="txtNome" runat="server" Width="100%" MaxLength="100"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNome"
                                            Display="Dynamic" ErrorMessage="Campo obrigatório"></asp:RequiredFieldValidator></td>
                                </tr>
                                <tr>
                                    <td style="width: 100px; height: 13px;">
                                        Data Nasc.:</td>
                                    <td style="width: 100px; height: 13px;">
                                        Sexo:</td>
                                    <td style="width: 100px; height: 13px">
                                        Estado Civil:</td>
                                    <td style="width: 100px; height: 13px;">
                                    </td>
                                    <td style="width: 100px; height: 13px;">
                                    </td>
                                    <td style="width: 100px; height: 13px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100px; height: 24px;">
                                        <asp:TextBox ID="txtDtNascimento" runat="server" MaxLength="10" onblur="javascript:valida_data(this);"
                                            onkeypress="return MascaraCampo(this.form.name, this, '99/99/9999', event);"></asp:TextBox></td>
                                    <td style="width: 100px; height: 24px;">
                                        <asp:DropDownList ID="ddlSexo" runat="server">
                                            <asp:ListItem Value="">&lt;-Selecione-&gt;</asp:ListItem>
                                            <asp:ListItem Value="M">Masculino</asp:ListItem>
                                            <asp:ListItem Value="F">Feminino</asp:ListItem>
                                        </asp:DropDownList></td>
                                    <td style="width: 100px; height: 24px">
                                        <asp:DropDownList ID="ddlEstadoCivil" runat="server">
                                            <asp:ListItem Value="">&lt;-Selecione-&gt;</asp:ListItem>
                                            <asp:ListItem>Solteiro</asp:ListItem>
                                            <asp:ListItem>Casado</asp:ListItem>
                                            <asp:ListItem>Separado</asp:ListItem>
                                            <asp:ListItem>Vi&#250;vo</asp:ListItem>
                                            <asp:ListItem>Outros</asp:ListItem>
                                        </asp:DropDownList></td>
                                    <td style="width: 100px; height: 24px;">
                                    </td>
                                    <td style="width: 100px; height: 24px;">
                                    </td>
                                    <td style="width: 100px; height: 24px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100px">
                                        End. Residencial:</td>
                                    <td style="width: 100px">
                                        Número:</td>
                                    <td style="width: 100px">
                                        Complemento:</td>
                                    <td style="width: 100px">
                                    </td>
                                    <td style="width: 100px">
                                    </td>
                                    <td style="width: 100px">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100px; height: 21px;">
                                        <asp:TextBox ID="txtEndResidencia" runat="server" MaxLength="100"></asp:TextBox></td>
                                    <td style="width: 100px; height: 21px;">
                                        <asp:TextBox ID="txtNumero" runat="server" MaxLength="50" Width="146px"></asp:TextBox></td>
                                    <td style="width: 100px; height: 21px">
                                        <asp:TextBox ID="txtComplemento" runat="server" MaxLength="50" Width="146px"></asp:TextBox></td>
                                    <td style="width: 100px; height: 21px;">
                                    </td>
                                    <td style="width: 100px; height: 21px;">
                                    </td>
                                    <td style="width: 100px; height: 21px;">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100px; height: 21px">
                                        Cidade:</td>
                                    <td style="width: 100px; height: 21px">
                                        Bairro:</td>
                                    <td style="width: 100px; height: 21px">
                                        CEP:</td>
                                    <td style="width: 100px; height: 21px">
                                        UF:&nbsp;</td>
                                    <td style="width: 100px; height: 21px">
                                    </td>
                                    <td style="width: 100px; height: 21px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100px; height: 21px">
                                        <asp:TextBox ID="txtCidade" runat="server" MaxLength="50"></asp:TextBox></td>
                                    <td style="width: 100px; height: 21px">
                                        <asp:TextBox ID="txtBairro" runat="server" MaxLength="50"></asp:TextBox></td>
                                    <td style="width: 100px; height: 21px">
                                        <asp:TextBox ID="txtCEP" runat="server" MaxLength="9" onkeypress="return MascaraCampo(this.form.name, this, '99999-99', event);"
                                            Width="68%"></asp:TextBox></td>
                                    <td style="width: 100px; height: 21px">
                                        <uc3:Estados ID="ddlEstados" runat="server" />
                                    </td>
                                    <td style="width: 100px; height: 21px">
                                    </td>
                                    <td style="width: 100px; height: 21px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100px; height: 19px;">
                                        Telefone:</td>
                                    <td style="width: 100px; height: 19px;">
                                        Celular:</td>
                                    <td colspan="4" style="height: 19px">
                                        E-Mail:</td>
                                </tr>
                                <tr>
                                    <td style="width: 100px">
                                        <asp:TextBox ID="txtDDDtel" runat="server" MaxLength="2" onkeypress="return MascaraCampo(this.form.name, this, '99', event);"
                                            Width="20px"></asp:TextBox>
                                        <asp:TextBox ID="txtTelefone" runat="server" MaxLength="9" onkeypress="return MascaraCampo(this.form.name, this, '9999-9999', event);"
                                            Width="73px"></asp:TextBox></td>
                                    <td style="width: 100px">
                                        <asp:TextBox ID="txtDDDcel" runat="server" MaxLength="2" onkeypress="return MascaraCampo(this.form.name, this, '99', event);"
                                            Width="20px"></asp:TextBox>
                                        <asp:TextBox ID="txtCelular" runat="server" MaxLength="9" onkeypress="return MascaraCampo(this.form.name, this, '9999-9999', event);"
                                            Width="73px"></asp:TextBox></td>
                                    <td colspan="4">
                                        <asp:TextBox ID="txtEmail" runat="server" Width="52%" MaxLength="50"></asp:TextBox></td>
                                </tr>
                            </table>
                        </fieldset>
                        <br />
                        <fieldset>
                            <table class="texto" style="width: 100%;" border="0" cellpadding="0" cellspacing="1">
                                <tr>
                                    <td align="center" valign="top">
                                        <asp:Button ID="Button1" runat="server" OnClick="BtnSalvar_Click" Text="Salvar" /></td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div id="div_FichaProfissional" class="conteudo" style="display: none">
                        <br />
                        <fieldset>
                            <table class="texto" style="width: 100%;" border="0" cellpadding="0" cellspacing="1">
                                <tr>
                                    <td style="width: 258px">
                                        Tipo de Profissional:</td>
                                    <td style="width: 184px">
                                    </td>
                                    <td colspan="3" style="height: 20%">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 258px">
                                        <uc4:TipoProfissional ID="ddlTipoProfissional" runat="server" />
                                    </td>
                                    <td style="width: 184px">
                                    </td>
                                    <td colspan="3" style="height: 20%">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 258px;">
                                        Conselho Profissional:</td>
                                    <td style="width: 184px;">
                                        Nº Conselho:</td>
                                    <td style="height: 20%;" colspan="3">
                                        Conselho - UF:</td>
                                </tr>
                                <tr>
                                    <td style="width: 258px">
                                        <uc1:ConselhoProfissional ID="ddlConselhoProfissional" runat="server" />
                                    </td>
                                    <td style="width: 184px">
                                        <asp:TextBox ID="txtConselhoNumero" runat="server"></asp:TextBox></td>
                                    <td colspan="3">
                                        <uc3:Estados ID="ddlConselhoUF" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5">
                                        Especialidade(s):</td>
                                </tr>
                                <tr>
                                    <td colspan="5">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
                                            <tr>
                                                <td width="5%">
                                                    1&ordm;)</td>
                                                <td width="85%">
                                                    <uc2:CBOS ID="ddlCBOS_1" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 19px">
                                                    2&ordm;)</td>
                                                <td style="height: 19px">
                                                    <uc2:CBOS ID="ddlCBOS_2" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 19px">
                                                    3&ordm;)</td>
                                                <td style="height: 19px">
                                                    <uc2:CBOS ID="ddlCBOS_3" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 19px">
                                                    4º)</td>
                                                <td style="height: 19px">
                                                    <uc2:CBOS ID="ddlCBOS_4" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 19px">
                                                    5º)</td>
                                                <td style="height: 19px">
                                                    <uc2:CBOS ID="ddlCBOS_5" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 19px">
                                                    6º)</td>
                                                <td style="height: 19px">
                                                    <uc2:CBOS ID="ddlCBOS_6" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <br />
                        <fieldset>
                            <table class="texto" style="width: 100%;" border="0" cellpadding="0" cellspacing="1">
                                <tr>
                                    <td align="center" valign="top">
                                        <asp:Button ID="BtnSalvar" runat="server" OnClick="BtnSalvar_Click" Text="Salvar" /></td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
        </table>
    </fieldset>
</asp:Content>
