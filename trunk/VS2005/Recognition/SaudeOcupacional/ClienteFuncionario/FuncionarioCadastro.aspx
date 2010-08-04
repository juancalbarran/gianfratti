<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="FuncionarioCadastro.aspx.cs" Inherits="Funcionario_FuncionarioCadastra" Title="Cadastro de Funcionários" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<fieldset style="height: 100%">
<legend  align=center >&nbsp;Cadastro de Funcionário&nbsp;</legend>
<fieldset>
<legend  align=left >&nbsp;Cliente&nbsp;</legend>
<table class=texto style="width: 100%; height: 100%" border="0" cellpadding="0" cellspacing="1">
    <tr>
        <td>
            <asp:DropDownList ID="DdlCliente" runat="server" AutoPostBack="True" DataSourceID="ObjectDataSource1" DataTextField="RazaoSocial" DataValueField="ID" OnDataBound="DdlCliente_DataBound">
            </asp:DropDownList>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DdlCliente"
                Display="Dynamic" ErrorMessage="Campo obrigatório" Width="144px"></asp:RequiredFieldValidator>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="ClienteDropDownList"
                TypeName="ClienteDAL"></asp:ObjectDataSource>
        </td>
    </tr>
</table>

</fieldset>

<fieldset>
<legend  align=left >&nbsp;Ficha Pessoal&nbsp;</legend>
    <table class=texto style="width: 100%; height: 100%" border="0" cellpadding="0" cellspacing="1">
        <tr>
            <td style="width: 100px; height: 13px;">
                CPF:</td>
            <td style="width: 100px; height: 13px;">
                RG:</td>
            <td style="width: 100px; height: 13px;">
                Data Expedição:</td>
            <td colspan="3" style="height: 13px">
                UF Emissão: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp;
                Orgão Expeditor:</td>
        </tr>
        <tr>
            <td style="width: 100px; height: 24px;">
                <asp:TextBox ID="TxtCPF" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '999999999-99', event);" MaxLength="12"></asp:TextBox>
                </td>
            <td style="width: 100px; height: 24px;">
                <asp:TextBox ID="TxtRG" runat="server" MaxLength="15"></asp:TextBox></td>
            <td style="width: 100px; height: 24px;">
                <asp:TextBox ID="TxtDtExpedicao" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99/99/9999', event);" MaxLength="10" Width="79px"></asp:TextBox></td>
            <td colspan="3" style="height: 24px">
                <asp:TextBox ID="TxtRgUFemissao" runat="server" MaxLength="2"  Width="24px"></asp:TextBox>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                <asp:DropDownList ID="DdlOrgaoExpeditor" runat="server" DataSourceID="ObjectDataSource3"
                    DataTextField="Descricao" DataValueField="id" CssClass="texto" Width="59%" OnDataBound="DdlOrgaoExpeditor_DataBound">
                </asp:DropDownList>&nbsp;
                <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="TipoOrgaoExpeditorDropDownList"
                    TypeName="ClienteFuncionarioDAL"></asp:ObjectDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="6">
                Nome:</td>
        </tr>
        <tr>
            <td colspan="6" style="height: 23px">
                <asp:TextBox ID="TxtNome" runat="server" Width="100%" MaxLength="100"></asp:TextBox><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TxtNome"
                    Display="Dynamic" ErrorMessage="Campo obrigatório" Width="144px"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td style="width: 100px">
                Data Nasc.:</td>
            <td style="width: 100px">
                Data Obito:</td>
            <td style="width: 100px">
                Sexo:</td>
            <td colspan="3">
                Estado Civil:</td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="TxtDtNascimento" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99/99/9999', event);" MaxLength="10"></asp:TextBox>
                </td>
            <td style="width: 100px">
                <asp:TextBox ID="TxtDtObito" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99/99/9999', event);" MaxLength="10"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:DropDownList ID="DdlSexo" runat="server">
                    <asp:ListItem>&lt;-Selecione-&gt;</asp:ListItem>
                    <asp:ListItem Value="M">Masculino</asp:ListItem>
                    <asp:ListItem Value="F">Feminino</asp:ListItem>
                </asp:DropDownList></td>
            <td colspan="3">
                <asp:DropDownList ID="DdlEstadoCivil" runat="server">
                    <asp:ListItem Value="">&lt;-Selecione-&gt;</asp:ListItem>
                    <asp:ListItem>Solteiro</asp:ListItem>
                    <asp:ListItem>Casado</asp:ListItem>
                    <asp:ListItem>Separado</asp:ListItem>
                    <asp:ListItem>Vi&#250;vo</asp:ListItem>
                    <asp:ListItem>Outros</asp:ListItem>
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td style="width: 100px">
                Nome da mãe:</td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td colspan="3">
            </td>
        </tr>
        <tr>
            <td colspan="6" style="height: 23px">
                <asp:TextBox ID="TxtMae" runat="server" Width="100%" MaxLength="100"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px; height: 13px;">
                End. Residencial:</td>
            <td style="width: 100px; height: 13px;">
                Número:</td>
            <td style="width: 100px; height: 13px;">
                Complemento:</td>
            <td style="width: 100px; height: 13px;">
                Cidade:</td>
            <td style="width: 130px; height: 13px;">
                Bairro:</td>
            <td style="width: 100px; height: 13px">
                UF: &nbsp; &nbsp;CEP:</td>
        </tr>
        <tr>
            <td style="width: 100px; height: 21px;">
                <asp:TextBox ID="TxtEndResidencia" runat="server" MaxLength="100"></asp:TextBox></td>
            <td style="width: 100px; height: 21px;">
                <asp:TextBox ID="TxtNumero" runat="server" Width="146px" MaxLength="50"></asp:TextBox></td>
            <td style="width: 100px; height: 21px;">
                <asp:TextBox ID="TxtConplemento" runat="server" MaxLength="50"></asp:TextBox></td>
            <td style="width: 100px; height: 21px;">
                <asp:TextBox ID="TxtCidade" runat="server" MaxLength="50"></asp:TextBox></td>
            <td style="width: 130px; height: 21px;">
                <asp:TextBox ID="TxtBairro" runat="server" Width="129px" MaxLength="50"></asp:TextBox></td>
            <td style="width: 100px; height: 21px;">
                <asp:TextBox ID="TxtUF" runat="server" MaxLength="2" Width="24px"></asp:TextBox>
                &nbsp;
                <asp:TextBox ID="TxtCEP" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99999-99', event);" MaxLength="9" Width="64%"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px">
                Telefone:</td>
            <td style="width: 100px">
                Celular:</td>
            <td style="width: 100px">
                Tel.: Contato:</td>
            <td colspan="3">
                Nome Contato:</td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="TxtDDDtel" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99', event);" MaxLength="2" Width="20px"></asp:TextBox>
                <asp:TextBox ID="TxtTelefone" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '9999-9999', event);" Width="73px" MaxLength="9"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TxtDDDcel" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99', event);" MaxLength="2" Width="20px"></asp:TextBox>
                <asp:TextBox ID="TxtCelular" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '9999-9999', event);" Width="73px" MaxLength="9"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TxtDDDContato" runat="server" MaxLength="2" onkeypress="return MascaraCampo(this.form.name, this, '99', event);"
                    Width="20px"></asp:TextBox>
                <asp:TextBox ID="TxtTelefoneContato" runat="server" onkeypress="return MascaraCampo(this.form.name, this, '9999-9999', event);"
                    Width="73px" MaxLength="9"></asp:TextBox></td>
            <td colspan="3">
                <asp:TextBox ID="TxtContatoNome" runat="server" MaxLength="100" Width="100%"></asp:TextBox></td>
        </tr>
    </table>
</fieldset>

<fieldset>
<legend  align=left >&nbsp;Ficha Profissional&nbsp;</legend>
    <table class=texto style="width: 100%; height: 100%" border="0" cellpadding="0" cellspacing="1">
        <tr>
            <td style="width: 100px; height: 19px;">
                Status:</td>
            <td style="width: 100px; height: 19px;">
                Nº Matricula:</td>
            <td style="width: 100px; height: 19px;">
                Data Admissão:</td>
            <td colspan="2" style="height: 19px">
                Data Demissão:</td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:DropDownList ID="DdlStatus" runat="server" DataSourceID="ObjectDataSource2" DataTextField="Status"
                    DataValueField="id" OnDataBound="DdlStatus_DataBound">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DdlStatus"
                    Display="Dynamic" ErrorMessage="Campo obrigatório" Width="144px"></asp:RequiredFieldValidator>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="FuncionarioStatusDropDownList"
                    TypeName="ClienteFuncionarioDAL"></asp:ObjectDataSource>
            </td>
            <td style="width: 100px">
                <asp:TextBox ID="TxtNumMatricula" runat="server" MaxLength="50"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TxtDtAdmissao" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99/99/9999', event);" MaxLength="10"></asp:TextBox>
                </td>
            <td colspan="2">
                <asp:TextBox ID="TxtDtDemissao" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99/99/9999', event);" MaxLength="10"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px;">
                Departamento:</td>
            <td>Setor:</td>
            <td>Cargo:</td>
            <td>Função:</td>
                
        </tr>
        <tr>
            <td style="width: 100px;">
                <asp:DropDownList ID="DdlDepartamento" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2"
                    DataTextField="Nome" DataValueField="id">
                </asp:DropDownList>&nbsp;
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:cnnString %>"
                    SelectCommand="SELECT * FROM [ClienteDepartamento] WHERE ([idCliente] = @idCliente)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DdlCliente" Name="idCliente" PropertyName="SelectedValue"
                            Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td >
                <asp:DropDownList ID="DdlSetor" runat="server" DataSourceID="SqlDataSource3" DataTextField="Nome"
                    DataValueField="id">
                </asp:DropDownList>
                <asp:Button ID="btnCadastrarDeptoSetor" runat="server" OnClientClick="javascript:AbrePopUp('/SaudeOcupacional/ClienteDepartamentoSetor/ClienteDepartamentoPrincipal.aspx?idCliente='+document.aspnetForm.ctl00$ContentPlaceHolder1$DdlCliente.value,'350','250',this,event)"
                    Text="Cadastrar" Font-Size="XX-Small" />
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:cnnString %>"
                    SelectCommand="SELECT  ClienteSetor.id, ClienteSetor.idClienteDepartamento, ClienteSetor.Nome, ClienteDepartamento.idCliente FROM ClienteSetor INNER JOIN
                      ClienteDepartamento ON ClienteSetor.idClienteDepartamento = ClienteDepartamento.id WHERE ([idClienteDepartamento] = @idClienteDepartamento) and ([idCliente] = @idCliente) ">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DdlDepartamento" Name="idClienteDepartamento" PropertyName="SelectedValue"
                            Type="Int32" />
                                                    <asp:ControlParameter ControlID="DdlCliente" Name="idCliente" PropertyName="SelectedValue"
                            Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:TextBox ID="TxtCargo" runat="server" MaxLength="50"></asp:TextBox></td>
            <td>
                <asp:TextBox ID="TxtFuncao" runat="server" MaxLength="50"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px; height: 19px;">
                Remuneração:</td>
            <td style="width: 100px; height: 19px;">
                Aposentado:</td>
            <td colspan="3" style="height: 19px">
                </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="TxtSalario" MaxLength="15" runat="server" onKeyPress="return(FormataMoeda(this,'','.',event))"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:DropDownList ID="DdlAposentado" runat="server">
                <asp:ListItem Value="">&lt;-Selecione-&gt;</asp:ListItem>
                    <asp:ListItem Value="N">N&#227;o</asp:ListItem>
                    <asp:ListItem Value="S">Sim</asp:ListItem>
                </asp:DropDownList></td>
            <td colspan="3">
                </td>
        </tr>
        <tr>
            <td colspan="5">
                CBO (Cadastro Brasilieiro de Ocupações)</td>
        </tr>
        <tr>
            <td colspan="5">
                <asp:TextBox ID="TxtCBO" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '9999-99', event);" MaxLength="7" Width="64px"></asp:TextBox>
                <a href="javascript:AbrePopUp('/SaudeOcupacional/Tabelas/CBO/PopUp/CBOPopUp.aspx','750','500',this,event)">
                    <img border="0" height="13" src="\SaudeOcupacional\Template\img\pesquisa.gif" width="15" /></a>
                <asp:TextBox ID="TxtCBOFuncao" runat="server" Width="658px" ReadOnly></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px; height: 13px;">
                CTPS Nº:</td>
            <td style="width: 100px; height: 13px;">
                CTPS Serie:</td>
            <td style="height: 13px">
                UF:</td>
                        <td colspan="2" style="height: 13px">
                Filiação Previdenciaria:</td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="TxtNumCTPS" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '9999999', event);" MaxLength="7"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TxtSerieCTPS" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '99999', event);" MaxLength="5"></asp:TextBox></td>
            <td style="width: 100px">
                <asp:TextBox ID="TxtUFCTPS" runat="server" MaxLength="2" Width="24px"></asp:TextBox></td>
            <td colspan="2">
                <asp:TextBox ID="TxtFiliacaoPrevidencia" runat="server" MaxLength="50" ></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px; height: 38px;">
                NIT/PIS-PASEP:</td>
            <td style="width: 100px; height: 38px;">
            </td>
            <td style="width: 100px; height: 38px;">
            </td>
            <td colspan="2" style="height: 38px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="TxtPIS" runat="server" onKeyPress="return MascaraCampo(this.form.name, this, '999.99999.99-9', event);" MaxLength="14"></asp:TextBox></td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
            <td colspan="2">
            </td>
        </tr>
    </table>

</fieldset>
    <asp:Button ID="BtnSalvar" runat="server" OnClick="BtnSalvar_Click" Text="Salvar" /></fieldset>
</asp:Content>

