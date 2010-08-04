<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="CadastroProfissionais.aspx.cs" Inherits="Profissionais_CadastroProfissionais" Title="SmartCare - Hospital do Rim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<fieldset>
    <legend align="center">&nbsp;Cadastro do Profissional de Saúde&nbsp;</legend>
                       
                        <fieldset>
                        <legend>Dados Pessoais</legend>
                        <table border="0" cellpadding="0" cellspacing="0" class="texto" style="width: 100%">
                            <tr>
                                <td style="width: 105px">CPF:</td>
                                <td style="width: 100px">RG:</td>
                                <td style="width: 101px">Data Expedição:</td>
                                <td style="width: 100px">UF:</td>
                                <td>Orgão Expeditor:</td>
                                <td style="width: 100px"></td>
                            </tr>
                            <tr>
                                <td style="width: 105px">
                                    <asp:TextBox ID="txtCPF" runat="server" MaxLength="14" onblur="javascript:Verifica_CPF(this);"
                                        onkeypress="return MascaraCampo(this.form.name, this, '999.999.999-99', event);"></asp:TextBox></td>
                                <td style="width: 100px">
                                    <asp:TextBox ID="txtRG" runat="server" MaxLength="20"></asp:TextBox></td>
                                <td style="width: 101px">
                                    <asp:TextBox ID="txtDtExpedicao" runat="server" MaxLength="10" onblur="javascript:valida_data(this);"
                                        onkeypress="return MascaraCampo(this.form.name, this, '99/99/9999', event);"
                                        Width="147px"></asp:TextBox></td>
                                <td style="width: 100px">
                                    <asp:TextBox ID="txtRgUFemissao" runat="server" MaxLength="2" Width="24px"></asp:TextBox></td>
                                <td colspan="2">
                                   <select name="ctl00$ContentPlaceHolder1$ddlOrgaoExpeditor" id="ctl00_ContentPlaceHolder1_ddlOrgaoExpeditor" class="texto" style="width:100%;">
	                                   <option value="">&lt;--Selecione--&gt;</option>
	                                   <option value="1">SSP - Secretaria de Seguran&#231;a P&#250;blica</option>
	                                   <option value="2">DIC - Diretoria de Identifica&#231;&#227;o Civil</option>
	                                   <option value="3">IFP - Instituto F&#233;lix Pacheco</option>
	                                   <option value="4">IPF - Instituto Pereira Faustino</option>
	                                   <option value="5">MAE - Minist&#233;rio da Aeron&#225;utica </option>
	                                   <option value="6">MEX - Minist&#233;rio do Ex&#233;rcito</option>
	                                   <option value="7">MMA - Minist&#233;rio da Marinha</option>
	                                   <option value="8">POF - Pol&#237;cia Federal</option>
	                                   <option value="9">POM - Pol&#237;cia Militar</option>
	                                   <option value="10">SES - Carteira de Estrangeiro</option>
	                                   <option value="11">CNT - Carteira Nacional de Habilita&#231;&#227;o</option>
	                                   <option value="12">ZZZ - Outros (inclusive exterior)</option>
                                   </select>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 105px">
                                    Nome:</td>
                                <td style="width: 100px">
                                </td>
                                <td style="width: 101px">
                                </td>
                                <td style="width: 100px">
                                </td>
                                <td style="width: 100px">
                                </td>
                                <td style="width: 100px">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <asp:TextBox ID="txtNome" runat="server" MaxLength="100" Width="100%"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNome"
                                        Display="Dynamic" ErrorMessage="Campo obrigatório"></asp:RequiredFieldValidator></td>
                            </tr>
                            <tr style="color: #000000">
                                <td style="width: 105px">
                                    Data Nasc.:</td>
                                <td style="width: 100px">
                                    Sexo:</td>
                                <td style="width: 101px">
                                    Estado Civil:</td>
                                <td style="width: 100px">
                                </td>
                                <td style="width: 100px">
                                </td>
                                <td style="width: 100px">
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 105px">
                                    <asp:TextBox ID="txtDtNascimento" runat="server" MaxLength="10" onblur="javascript:valida_data(this);"
                                        onkeypress="return MascaraCampo(this.form.name, this, '99/99/9999', event);"></asp:TextBox></td>
                                <td style="width: 100px">
                                    <asp:DropDownList ID="ddlSexo" runat="server">
                                        <asp:ListItem Value="">&lt;-Selecione-&gt;</asp:ListItem>
                                        <asp:ListItem Value="M">Masculino</asp:ListItem>
                                        <asp:ListItem Value="F">Feminino</asp:ListItem>
                                    </asp:DropDownList></td>
                                <td style="width: 101px">
                                    <asp:DropDownList ID="ddlEstadoCivil" runat="server">
                                        <asp:ListItem Value="">&lt;-Selecione-&gt;</asp:ListItem>
                                        <asp:ListItem>Solteiro</asp:ListItem>
                                        <asp:ListItem>Casado</asp:ListItem>
                                        <asp:ListItem>Separado</asp:ListItem>
                                        <asp:ListItem>Vi&#250;vo</asp:ListItem>
                                        <asp:ListItem>Outros</asp:ListItem>
                                    </asp:DropDownList></td>
                                <td style="width: 100px">
                                </td>
                                <td style="width: 100px">
                                </td>
                                <td style="width: 100px">
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 105px">
                                    End. Residencial:</td>
                                <td style="width: 100px">
                                    Número:</td>
                                <td style="width: 101px">
                                    Complemento:</td>
                                <td style="width: 100px">
                                    Cidade:</td>
                                <td style="width: 100px">
                                    Bairro:</td>
                                <td style="width: 100px">
                                    UF: &nbsp; CEP:</td>
                            </tr>
                            <tr>
                                <td style="width: 105px">
                                    <asp:TextBox ID="txtEndResidencia" runat="server" MaxLength="100"></asp:TextBox></td>
                                <td style="width: 100px">
                                    <asp:TextBox ID="txtNumero" runat="server" MaxLength="50" Width="146px"></asp:TextBox></td>
                                <td style="width: 101px">
                                    <asp:TextBox ID="txtComplemento" runat="server" MaxLength="50" Width="146px"></asp:TextBox></td>
                                <td style="width: 100px">
                                    <asp:TextBox ID="txtCidade" runat="server" MaxLength="50"></asp:TextBox></td>
                                <td style="width: 100px">
                                    <asp:TextBox ID="txtBairro" runat="server" MaxLength="50"></asp:TextBox></td>
                                <td style="width: 100px">
                                    <asp:TextBox ID="txtUF" runat="server" MaxLength="2" Width="24px"></asp:TextBox>&nbsp;
                                    <asp:TextBox ID="txtCEP" runat="server" MaxLength="9" onkeypress="return MascaraCampo(this.form.name, this, '99999-99', event);"
                                        Width="68%"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="width: 105px">
                                    Telefone:</td>
                                <td style="width: 100px">
                                    Celular:</td>
                                <td colspan="4">
                                    E-Mail:</td>
                            </tr>
                            <tr>
                                <td style="width: 105px">
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
                                    <asp:TextBox ID="txtEmail" runat="server" MaxLength="50" Width="100%"></asp:TextBox></td>
                            </tr>
                        </table>
                        </fieldset>
                        	  	  <fieldset>
	    <legend>Endereço Comercial</legend>
	    <table border="0" cellpadding="0" cellspacing="0" class="texto" style="width: 100%">
            <tr>
                <td style="width: 105px">
                    End. Residencial:</td>
                <td style="width: 100px">
                    Número:</td>
                <td style="width: 101px">
                    Complemento:</td>
                <td style="width: 100px">
                    Cidade:</td>
                <td style="width: 100px">
                    Bairro:</td>
                <td style="width: 100px">
                    UF: &nbsp; CEP:</td>
            </tr>
            <tr>
                <td style="width: 105px">
                    <asp:TextBox ID="txtEndComercial" runat="server" MaxLength="100"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtNumeroComercial" runat="server" MaxLength="50" Width="146px"></asp:TextBox></td>
                <td style="width: 101px">
                    <asp:TextBox ID="txtComplementocomercial" runat="server" MaxLength="50" Width="146px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtCidadeComercial" runat="server" MaxLength="50"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtBairroComercial" runat="server" MaxLength="50"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtUFComercial" runat="server" MaxLength="2" Width="24px"></asp:TextBox>&nbsp;
                    <asp:TextBox ID="txtCEPComercial" runat="server" MaxLength="9" onkeypress="return MascaraCampo(this.form.name, this, '99999-99', event);"
                        Width="68%"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 105px">
                    Telefone:</td>
                <td style="width: 100px">
                    Fax</td>
                <td colspan="4">
                    E-Mail:</td>
            </tr>
            <tr>
                <td style="width: 105px">
                    <asp:TextBox ID="txtDDDtelComercial" runat="server" MaxLength="2" onkeypress="return MascaraCampo(this.form.name, this, '99', event);"
                        Width="20px"></asp:TextBox>
                    <asp:TextBox ID="txtTelefoneComercial" runat="server" MaxLength="9" onkeypress="return MascaraCampo(this.form.name, this, '9999-9999', event);"
                        Width="73px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtDDDcelComercial" runat="server" MaxLength="2" onkeypress="return MascaraCampo(this.form.name, this, '99', event);"
                        Width="20px"></asp:TextBox>
                    <asp:TextBox ID="txtCelularComercial" runat="server" MaxLength="9" onkeypress="return MascaraCampo(this.form.name, this, '9999-9999', event);"
                        Width="73px"></asp:TextBox></td>
                <td colspan="4">
                    <asp:TextBox ID="txtEmailComercial" runat="server" MaxLength="50" Width="100%"></asp:TextBox></td>
            </tr>
        </table>

                    </fieldset>
                    <br />
                    <fieldset>
                        <legend>Ficha Profissional</legend>
                        <table border="0" cellpadding="0" cellspacing="1" class="texto" style="width: 100%">
                            <tr>
                                <td style="width: 258px">
                                    Conselho Profissional:</td>
                                <td style="width: 184px">
                                    Nº Conselho:</td>
                                <td colspan="3">
                                    Conselho - UF:</td>
                            </tr>
                            <tr>
                                <td style="width: 258px">
                                  <select name="ctl00$ContentPlaceHolder1$ddlConselhoProfissional$ddlConselhoProfissional" id="ctl00_ContentPlaceHolder1_ddlConselhoProfissional_ddlConselhoProfissional" class="texto">
	                                <option value="">&lt;--Selecione--&gt;</option>
	                                <option value="CRAS">Assist&#234;ncia Social (CRAS)</option>
                                	<option value="COREN">Enfermagem (COREN)</option>
	                                <option value="CRF">Farm&#225;cia (CRF)</option>
                                	<option value="CRFA">Fonoaudiologia (CRFA)</option>
                                	<option value="CREFITO">Fisioterapia e Terapia Ocupacional (CREFITO)</option>
	                                <option value="CRM">Medicina (CRM)</option>
	                                <option value="CRV">Medicina Veterin&#225;ria (CRV)</option>
	                                <option value="CRN">Nutri&#231;&#227;o (CRN)</option>
	                                <option value="CRO">Odontologia (CRO)</option>
	                                <option value="CRP">Psicologia (CRP)</option>
	                                <option value="OUT">Outros Conselhos (OUT)</option>
                                  </select>
                                </td>
                                <td style="width: 184px">
                                    <asp:TextBox ID="txtConselhoNumero" runat="server"></asp:TextBox></td>
                                <td colspan="3">
                                    <asp:TextBox ID="txtConselhoUF" runat="server" MaxLength="2" Width="16%"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td colspan="5">
                                    Especialidade(s):</td>
                            </tr>
                            <tr>
                                <td colspan="5">
                                    <table border="0" cellpadding="0" cellspacing="0" class="texto" width="100%">
                                        <tr>
                                            <td width="5%">1º)</td>
                                            <td width="45%">
                                            <select name="ctl00$ContentPlaceHolder1$ddlCBOS_1$ddlCBOS" id="ctl00_ContentPlaceHolder1_ddlCBOS_1_ddlCBOS" class="texto">
	                                            <option value="">&lt;--Selecione--&gt;</option>
	                                            <option value="01280">F&#237;sico nuclear</option>
		                                        <option value="04945">Pedagogo</option>
		                                        <option value="05110">Biologista em geral (bi&#243;logo biom&#233;dico)</option>
		                                        <option value="05230">Bioqu&#237;mico</option>
		                                        <option value="05250">Bacteriologista</option>
		                                        <option value="05270">Farmacologista</option>
		                                        <option value="05290">Outros bacteriologistas e trabalhadores assemelhados</option>
		                                        <option value="06105">M&#233;dico em geral (clinico geral)</option>
		                                        <option value="06110">M&#233;dico cirurgi&#227;o em geral</option>
		                                        <option value="06112">M&#233;dico cirurgi&#227;o pedi&#225;trico</option>
		                                        <option value="06113">M&#233;dico de per&#237;cias m&#233;dicas</option>
		                                        <option value="06114">M&#233;dico anatomopatologista</option>
		                                        <option value="06115">M&#233;dico anestesista</option>
		                                        <option value="06116">M&#233;dico broncoesofalogista</option>
		                                        <option value="06117">M&#233;dico cardiologista</option>
		                                        <option value="06118">M&#233;dico cirurgi&#227;o vascular</option>
		                                        <option value="06119">M&#233;dico dermatologista</option>
		                                        <option value="06120">M&#233;dico cirurgi&#227;o cardiovascular</option>
		                                        <option value="06121">M&#233;dico oncologista pedi&#225;trico</option>
		                                        <option value="06122">M&#233;dico do trabalho</option>
		                                        <option value="06123">M&#233;dico gastroenterologista</option>
		                                        <option value="06124">M&#233;dico hematologista</option>
		                                        <option value="06125">M&#233;dico endocrinologista</option>
		                                        <option value="06126">M&#233;dico nuclear</option>
		                                        <option value="06127">M&#233;dico endoscopista</option>
		                                        <option value="06128">M&#233;dico fisiatra</option>
		                                        <option value="06129">M&#233;dico oncologista clinico</option>
		                                        <option value="06130">M&#233;dico reumatologista</option>
		                                        <option value="06131">M&#233;dico neurocirurgi&#227;o</option>
		                                        <option value="06132">M&#233;dico ginecologista</option>
		                                        <option value="06133">M&#233;dico alergista/imunologista</option>
		                                        <option value="06134">M&#233;dico geriatra</option>
		                                        <option value="06135">M&#233;dico hemoterapeuta</option>
		                                        <option value="06136">M&#233;dico hansenologista</option>
		                                        <option value="06137">M&#233;dico legista</option>
		                                        <option value="06138">M&#233;dico nefrologista</option>
		                                        <option value="06139">M&#233;dico mastologista</option>
		                                        <option value="06140">M&#233;dico sanitarista</option>
		                                        <option value="06141">M&#233;dico de sa&#250;de da fam&#237;lia</option>
		                                        <option value="06142">M&#233;dico neurologista</option>
		                                        <option value="06143">M&#233;dico geneticista clinico</option>
		                                        <option value="06144">M&#233;dico infectologista</option>
		                                        <option value="06145">M&#233;dico obstetra</option>
		                                        <option value="06146">M&#233;dico cirurgi&#227;o de cabe&#231;a e pesco&#231;o</option>
		                                        <option value="06147">M&#233;dico oftalmologista</option>
		                                        <option value="06148">M&#233;dico homeopata</option>
		                                        <option value="06149">M&#233;dico ginecologista / obstetra</option>
		                                        <option value="06150">M&#233;dico ortopedista</option>
		                                        <option value="06151">M&#233;dico geral comunit&#225;rio</option>
		                                        <option value="06152">M&#233;dico otorrinolaringologista</option>
		                                        <option value="06153">M&#233;dico citopatologista</option>
		                                        <option value="06154">M&#233;dico cirurgi&#227;o tor&#225;cico</option>
		                                        <option value="06155">M&#233;dico pediatra</option>
		                                        <option value="06156">M&#233;dico ultrasonografista</option>
		                                        <option value="06157">M&#233;dico pneumotisiologista</option>
		                                        <option value="06158">M&#233;dico acupunturista</option>
		                                        <option value="06159">M&#233;dico cancerologista</option>
		                                        <option value="06160">M&#233;dico proctologista</option>
		                                        <option value="06161">M&#233;dico cirurgi&#227;o de m&#227;o</option>
		                                        <option value="06162">M&#233;dico psiquiatra</option>
		                                        <option value="06163">M&#233;dico cirurgi&#227;o do aparelho digestivo</option>
		                                        <option value="06164">M&#233;dico plantonista</option>
		                                        <option value="06165">M&#233;dico radiologista</option>
		                                        <option value="06166">M&#233;dico intensivista</option>
		                                        <option value="06167">M&#233;dico radioterapeuta</option>
		                                        <option value="06168">M&#233;dico oncologista cir&#250;rgico</option>
		                                        <option value="06170">M&#233;dico urologista</option>
		                                        <option value="06172">M&#233;dico patologista clinico</option>
		                                        <option value="06175">M&#233;dico angiologista</option>
		                                        <option value="06177">M&#233;dico de medicina esportiva</option>
		                                        <option value="06180">M&#233;dico cirurgi&#227;o pl&#225;stico</option>
		                                        <option value="06190">Outros m&#233;dicos</option>
		                                        <option value="06310">Cirurgi&#227;o dentista em geral</option>
		                                        <option value="06330">Cirurgi&#227;o dentista (sa&#250;de p&#250;blica)</option>
		                                        <option value="06335">Cirurgi&#227;o dentista (traumatologia buco maxilo facial)</option>
		                                        <option value="06340">Cirurgi&#227;o dentista (endodontia)</option>
		                                        <option value="06345">Cirurgi&#227;o dentista (ortodontia)</option>
		                                        <option value="06350">Cirurgi&#227;o dentista (patologia bucal)</option>
		                                        <option value="06355">Cirurgi&#227;o dentista (pediatria)</option>
		                                        <option value="06360">Cirurgi&#227;o dentista (pr&#243;tese)</option>
		                                        <option value="06365">Cirurgi&#227;o dentista (radiologia)</option>
		                                        <option value="06370">Cirurgi&#227;o dentista (periodontia)</option>
		                                        <option value="06510">M&#233;dico veterin&#225;rio em geral</option>
		                                        <option value="06540">Zootecnista</option>
		                                        <option value="06710">Farmac&#234;utico em geral</option>
		                                        <option value="06810">Nutricionista em geral</option>
		                                        <option value="07110">Enfermeiro, em geral</option>
		                                        <option value="07111">Enfermeiro do PACS</option>
		                                        <option value="07112">Enfermeiro do PSF</option>
		                                        <option value="07130">Enfermeiro sanitarista</option>
		                                        <option value="07140">Enfermeiro do trabalho</option>
		                                        <option value="07145">Enfermeiro obstetra</option>
		                                        <option value="07150">Enfermeiro de centro cir&#250;rgico</option>
		                                        <option value="07155">Enfermeiro de terapia intensiva</option>
		                                        <option value="07160">Enfermeiro peuricultor e pedi&#225;trico</option>
		                                        <option value="07165">Enfermeiro psiqui&#225;trico</option>
		                                        <option value="07310">Assistente social em geral</option>
		                                        <option value="07410">Psic&#243;logo em geral</option>
		                                        <option value="07525">Ortoptista</option>
		                                        <option value="07530">&#211;tico</option>
		                                        <option value="07550">T&#233;cnico em orienta&#231;&#227;o e mobilidade de cegos e deficientes visuais</option>
		                                        <option value="07620">Fisioterapeuta</option>
		                                        <option value="07630">Terapeuta ocupacional</option>
		                                        <option value="07690">Terapeutas em geral (outros terapeutas)</option>
	                                        	<option value="07914">Foniatra</option>
		                                        <option value="07915">Acupunturista</option>
		                                        <option value="07925">Fonoaudi&#243;logo</option>
		                                        <option value="19998">Outros profissionais de n&#237;vel superior</option>
		                                        <option value="31120">Agente Administrativo</option>
	                                        </select>
                                            </td>
                                            <td width="5%">4º)</td>
                                            <td width="45%">                                            
                                            <select name="ctl00$ContentPlaceHolder1$ddlCBOS_1$ddlCBOS" id="Select3" class="texto">
	                                            <option value="">&lt;--Selecione--&gt;</option>
	                                            <option value="01280">F&#237;sico nuclear</option>
		                                        <option value="04945">Pedagogo</option>
		                                        <option value="05110">Biologista em geral (bi&#243;logo biom&#233;dico)</option>
		                                        <option value="05230">Bioqu&#237;mico</option>
		                                        <option value="05250">Bacteriologista</option>
		                                        <option value="05270">Farmacologista</option>
		                                        <option value="05290">Outros bacteriologistas e trabalhadores assemelhados</option>
		                                        <option value="06105">M&#233;dico em geral (clinico geral)</option>
		                                        <option value="06110">M&#233;dico cirurgi&#227;o em geral</option>
		                                        <option value="06112">M&#233;dico cirurgi&#227;o pedi&#225;trico</option>
		                                        <option value="06113">M&#233;dico de per&#237;cias m&#233;dicas</option>
		                                        <option value="06114">M&#233;dico anatomopatologista</option>
		                                        <option value="06115">M&#233;dico anestesista</option>
		                                        <option value="06116">M&#233;dico broncoesofalogista</option>
		                                        <option value="06117">M&#233;dico cardiologista</option>
		                                        <option value="06118">M&#233;dico cirurgi&#227;o vascular</option>
		                                        <option value="06119">M&#233;dico dermatologista</option>
		                                        <option value="06120">M&#233;dico cirurgi&#227;o cardiovascular</option>
		                                        <option value="06121">M&#233;dico oncologista pedi&#225;trico</option>
		                                        <option value="06122">M&#233;dico do trabalho</option>
		                                        <option value="06123">M&#233;dico gastroenterologista</option>
		                                        <option value="06124">M&#233;dico hematologista</option>
		                                        <option value="06125">M&#233;dico endocrinologista</option>
		                                        <option value="06126">M&#233;dico nuclear</option>
		                                        <option value="06127">M&#233;dico endoscopista</option>
		                                        <option value="06128">M&#233;dico fisiatra</option>
		                                        <option value="06129">M&#233;dico oncologista clinico</option>
		                                        <option value="06130">M&#233;dico reumatologista</option>
		                                        <option value="06131">M&#233;dico neurocirurgi&#227;o</option>
		                                        <option value="06132">M&#233;dico ginecologista</option>
		                                        <option value="06133">M&#233;dico alergista/imunologista</option>
		                                        <option value="06134">M&#233;dico geriatra</option>
		                                        <option value="06135">M&#233;dico hemoterapeuta</option>
		                                        <option value="06136">M&#233;dico hansenologista</option>
		                                        <option value="06137">M&#233;dico legista</option>
		                                        <option value="06138">M&#233;dico nefrologista</option>
		                                        <option value="06139">M&#233;dico mastologista</option>
		                                        <option value="06140">M&#233;dico sanitarista</option>
		                                        <option value="06141">M&#233;dico de sa&#250;de da fam&#237;lia</option>
		                                        <option value="06142">M&#233;dico neurologista</option>
		                                        <option value="06143">M&#233;dico geneticista clinico</option>
		                                        <option value="06144">M&#233;dico infectologista</option>
		                                        <option value="06145">M&#233;dico obstetra</option>
		                                        <option value="06146">M&#233;dico cirurgi&#227;o de cabe&#231;a e pesco&#231;o</option>
		                                        <option value="06147">M&#233;dico oftalmologista</option>
		                                        <option value="06148">M&#233;dico homeopata</option>
		                                        <option value="06149">M&#233;dico ginecologista / obstetra</option>
		                                        <option value="06150">M&#233;dico ortopedista</option>
		                                        <option value="06151">M&#233;dico geral comunit&#225;rio</option>
		                                        <option value="06152">M&#233;dico otorrinolaringologista</option>
		                                        <option value="06153">M&#233;dico citopatologista</option>
		                                        <option value="06154">M&#233;dico cirurgi&#227;o tor&#225;cico</option>
		                                        <option value="06155">M&#233;dico pediatra</option>
		                                        <option value="06156">M&#233;dico ultrasonografista</option>
		                                        <option value="06157">M&#233;dico pneumotisiologista</option>
		                                        <option value="06158">M&#233;dico acupunturista</option>
		                                        <option value="06159">M&#233;dico cancerologista</option>
		                                        <option value="06160">M&#233;dico proctologista</option>
		                                        <option value="06161">M&#233;dico cirurgi&#227;o de m&#227;o</option>
		                                        <option value="06162">M&#233;dico psiquiatra</option>
		                                        <option value="06163">M&#233;dico cirurgi&#227;o do aparelho digestivo</option>
		                                        <option value="06164">M&#233;dico plantonista</option>
		                                        <option value="06165">M&#233;dico radiologista</option>
		                                        <option value="06166">M&#233;dico intensivista</option>
		                                        <option value="06167">M&#233;dico radioterapeuta</option>
		                                        <option value="06168">M&#233;dico oncologista cir&#250;rgico</option>
		                                        <option value="06170">M&#233;dico urologista</option>
		                                        <option value="06172">M&#233;dico patologista clinico</option>
		                                        <option value="06175">M&#233;dico angiologista</option>
		                                        <option value="06177">M&#233;dico de medicina esportiva</option>
		                                        <option value="06180">M&#233;dico cirurgi&#227;o pl&#225;stico</option>
		                                        <option value="06190">Outros m&#233;dicos</option>
		                                        <option value="06310">Cirurgi&#227;o dentista em geral</option>
		                                        <option value="06330">Cirurgi&#227;o dentista (sa&#250;de p&#250;blica)</option>
		                                        <option value="06335">Cirurgi&#227;o dentista (traumatologia buco maxilo facial)</option>
		                                        <option value="06340">Cirurgi&#227;o dentista (endodontia)</option>
		                                        <option value="06345">Cirurgi&#227;o dentista (ortodontia)</option>
		                                        <option value="06350">Cirurgi&#227;o dentista (patologia bucal)</option>
		                                        <option value="06355">Cirurgi&#227;o dentista (pediatria)</option>
		                                        <option value="06360">Cirurgi&#227;o dentista (pr&#243;tese)</option>
		                                        <option value="06365">Cirurgi&#227;o dentista (radiologia)</option>
		                                        <option value="06370">Cirurgi&#227;o dentista (periodontia)</option>
		                                        <option value="06510">M&#233;dico veterin&#225;rio em geral</option>
		                                        <option value="06540">Zootecnista</option>
		                                        <option value="06710">Farmac&#234;utico em geral</option>
		                                        <option value="06810">Nutricionista em geral</option>
		                                        <option value="07110">Enfermeiro, em geral</option>
		                                        <option value="07111">Enfermeiro do PACS</option>
		                                        <option value="07112">Enfermeiro do PSF</option>
		                                        <option value="07130">Enfermeiro sanitarista</option>
		                                        <option value="07140">Enfermeiro do trabalho</option>
		                                        <option value="07145">Enfermeiro obstetra</option>
		                                        <option value="07150">Enfermeiro de centro cir&#250;rgico</option>
		                                        <option value="07155">Enfermeiro de terapia intensiva</option>
		                                        <option value="07160">Enfermeiro peuricultor e pedi&#225;trico</option>
		                                        <option value="07165">Enfermeiro psiqui&#225;trico</option>
		                                        <option value="07310">Assistente social em geral</option>
		                                        <option value="07410">Psic&#243;logo em geral</option>
		                                        <option value="07525">Ortoptista</option>
		                                        <option value="07530">&#211;tico</option>
		                                        <option value="07550">T&#233;cnico em orienta&#231;&#227;o e mobilidade de cegos e deficientes visuais</option>
		                                        <option value="07620">Fisioterapeuta</option>
		                                        <option value="07630">Terapeuta ocupacional</option>
		                                        <option value="07690">Terapeutas em geral (outros terapeutas)</option>
	                                        	<option value="07914">Foniatra</option>
		                                        <option value="07915">Acupunturista</option>
		                                        <option value="07925">Fonoaudi&#243;logo</option>
		                                        <option value="19998">Outros profissionais de n&#237;vel superior</option>
		                                        <option value="31120">Agente Administrativo</option>
	                                        </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>2º)</td>
                                            <td>                                            
                                            <select name="ctl00$ContentPlaceHolder1$ddlCBOS_1$ddlCBOS" id="Select1" class="texto">
	                                            <option value="">&lt;--Selecione--&gt;</option>
	                                            <option value="01280">F&#237;sico nuclear</option>
		                                        <option value="04945">Pedagogo</option>
		                                        <option value="05110">Biologista em geral (bi&#243;logo biom&#233;dico)</option>
		                                        <option value="05230">Bioqu&#237;mico</option>
		                                        <option value="05250">Bacteriologista</option>
		                                        <option value="05270">Farmacologista</option>
		                                        <option value="05290">Outros bacteriologistas e trabalhadores assemelhados</option>
		                                        <option value="06105">M&#233;dico em geral (clinico geral)</option>
		                                        <option value="06110">M&#233;dico cirurgi&#227;o em geral</option>
		                                        <option value="06112">M&#233;dico cirurgi&#227;o pedi&#225;trico</option>
		                                        <option value="06113">M&#233;dico de per&#237;cias m&#233;dicas</option>
		                                        <option value="06114">M&#233;dico anatomopatologista</option>
		                                        <option value="06115">M&#233;dico anestesista</option>
		                                        <option value="06116">M&#233;dico broncoesofalogista</option>
		                                        <option value="06117">M&#233;dico cardiologista</option>
		                                        <option value="06118">M&#233;dico cirurgi&#227;o vascular</option>
		                                        <option value="06119">M&#233;dico dermatologista</option>
		                                        <option value="06120">M&#233;dico cirurgi&#227;o cardiovascular</option>
		                                        <option value="06121">M&#233;dico oncologista pedi&#225;trico</option>
		                                        <option value="06122">M&#233;dico do trabalho</option>
		                                        <option value="06123">M&#233;dico gastroenterologista</option>
		                                        <option value="06124">M&#233;dico hematologista</option>
		                                        <option value="06125">M&#233;dico endocrinologista</option>
		                                        <option value="06126">M&#233;dico nuclear</option>
		                                        <option value="06127">M&#233;dico endoscopista</option>
		                                        <option value="06128">M&#233;dico fisiatra</option>
		                                        <option value="06129">M&#233;dico oncologista clinico</option>
		                                        <option value="06130">M&#233;dico reumatologista</option>
		                                        <option value="06131">M&#233;dico neurocirurgi&#227;o</option>
		                                        <option value="06132">M&#233;dico ginecologista</option>
		                                        <option value="06133">M&#233;dico alergista/imunologista</option>
		                                        <option value="06134">M&#233;dico geriatra</option>
		                                        <option value="06135">M&#233;dico hemoterapeuta</option>
		                                        <option value="06136">M&#233;dico hansenologista</option>
		                                        <option value="06137">M&#233;dico legista</option>
		                                        <option value="06138">M&#233;dico nefrologista</option>
		                                        <option value="06139">M&#233;dico mastologista</option>
		                                        <option value="06140">M&#233;dico sanitarista</option>
		                                        <option value="06141">M&#233;dico de sa&#250;de da fam&#237;lia</option>
		                                        <option value="06142">M&#233;dico neurologista</option>
		                                        <option value="06143">M&#233;dico geneticista clinico</option>
		                                        <option value="06144">M&#233;dico infectologista</option>
		                                        <option value="06145">M&#233;dico obstetra</option>
		                                        <option value="06146">M&#233;dico cirurgi&#227;o de cabe&#231;a e pesco&#231;o</option>
		                                        <option value="06147">M&#233;dico oftalmologista</option>
		                                        <option value="06148">M&#233;dico homeopata</option>
		                                        <option value="06149">M&#233;dico ginecologista / obstetra</option>
		                                        <option value="06150">M&#233;dico ortopedista</option>
		                                        <option value="06151">M&#233;dico geral comunit&#225;rio</option>
		                                        <option value="06152">M&#233;dico otorrinolaringologista</option>
		                                        <option value="06153">M&#233;dico citopatologista</option>
		                                        <option value="06154">M&#233;dico cirurgi&#227;o tor&#225;cico</option>
		                                        <option value="06155">M&#233;dico pediatra</option>
		                                        <option value="06156">M&#233;dico ultrasonografista</option>
		                                        <option value="06157">M&#233;dico pneumotisiologista</option>
		                                        <option value="06158">M&#233;dico acupunturista</option>
		                                        <option value="06159">M&#233;dico cancerologista</option>
		                                        <option value="06160">M&#233;dico proctologista</option>
		                                        <option value="06161">M&#233;dico cirurgi&#227;o de m&#227;o</option>
		                                        <option value="06162">M&#233;dico psiquiatra</option>
		                                        <option value="06163">M&#233;dico cirurgi&#227;o do aparelho digestivo</option>
		                                        <option value="06164">M&#233;dico plantonista</option>
		                                        <option value="06165">M&#233;dico radiologista</option>
		                                        <option value="06166">M&#233;dico intensivista</option>
		                                        <option value="06167">M&#233;dico radioterapeuta</option>
		                                        <option value="06168">M&#233;dico oncologista cir&#250;rgico</option>
		                                        <option value="06170">M&#233;dico urologista</option>
		                                        <option value="06172">M&#233;dico patologista clinico</option>
		                                        <option value="06175">M&#233;dico angiologista</option>
		                                        <option value="06177">M&#233;dico de medicina esportiva</option>
		                                        <option value="06180">M&#233;dico cirurgi&#227;o pl&#225;stico</option>
		                                        <option value="06190">Outros m&#233;dicos</option>
		                                        <option value="06310">Cirurgi&#227;o dentista em geral</option>
		                                        <option value="06330">Cirurgi&#227;o dentista (sa&#250;de p&#250;blica)</option>
		                                        <option value="06335">Cirurgi&#227;o dentista (traumatologia buco maxilo facial)</option>
		                                        <option value="06340">Cirurgi&#227;o dentista (endodontia)</option>
		                                        <option value="06345">Cirurgi&#227;o dentista (ortodontia)</option>
		                                        <option value="06350">Cirurgi&#227;o dentista (patologia bucal)</option>
		                                        <option value="06355">Cirurgi&#227;o dentista (pediatria)</option>
		                                        <option value="06360">Cirurgi&#227;o dentista (pr&#243;tese)</option>
		                                        <option value="06365">Cirurgi&#227;o dentista (radiologia)</option>
		                                        <option value="06370">Cirurgi&#227;o dentista (periodontia)</option>
		                                        <option value="06510">M&#233;dico veterin&#225;rio em geral</option>
		                                        <option value="06540">Zootecnista</option>
		                                        <option value="06710">Farmac&#234;utico em geral</option>
		                                        <option value="06810">Nutricionista em geral</option>
		                                        <option value="07110">Enfermeiro, em geral</option>
		                                        <option value="07111">Enfermeiro do PACS</option>
		                                        <option value="07112">Enfermeiro do PSF</option>
		                                        <option value="07130">Enfermeiro sanitarista</option>
		                                        <option value="07140">Enfermeiro do trabalho</option>
		                                        <option value="07145">Enfermeiro obstetra</option>
		                                        <option value="07150">Enfermeiro de centro cir&#250;rgico</option>
		                                        <option value="07155">Enfermeiro de terapia intensiva</option>
		                                        <option value="07160">Enfermeiro peuricultor e pedi&#225;trico</option>
		                                        <option value="07165">Enfermeiro psiqui&#225;trico</option>
		                                        <option value="07310">Assistente social em geral</option>
		                                        <option value="07410">Psic&#243;logo em geral</option>
		                                        <option value="07525">Ortoptista</option>
		                                        <option value="07530">&#211;tico</option>
		                                        <option value="07550">T&#233;cnico em orienta&#231;&#227;o e mobilidade de cegos e deficientes visuais</option>
		                                        <option value="07620">Fisioterapeuta</option>
		                                        <option value="07630">Terapeuta ocupacional</option>
		                                        <option value="07690">Terapeutas em geral (outros terapeutas)</option>
	                                        	<option value="07914">Foniatra</option>
		                                        <option value="07915">Acupunturista</option>
		                                        <option value="07925">Fonoaudi&#243;logo</option>
		                                        <option value="19998">Outros profissionais de n&#237;vel superior</option>
		                                        <option value="31120">Agente Administrativo</option>
	                                        </select>
                                            </td>
                                            <td>
                                                5º)</td>
                                            <td>                                            
                                            <select name="ctl00$ContentPlaceHolder1$ddlCBOS_1$ddlCBOS" id="Select4" class="texto">
	                                            <option value="">&lt;--Selecione--&gt;</option>
	                                            <option value="01280">F&#237;sico nuclear</option>
		                                        <option value="04945">Pedagogo</option>
		                                        <option value="05110">Biologista em geral (bi&#243;logo biom&#233;dico)</option>
		                                        <option value="05230">Bioqu&#237;mico</option>
		                                        <option value="05250">Bacteriologista</option>
		                                        <option value="05270">Farmacologista</option>
		                                        <option value="05290">Outros bacteriologistas e trabalhadores assemelhados</option>
		                                        <option value="06105">M&#233;dico em geral (clinico geral)</option>
		                                        <option value="06110">M&#233;dico cirurgi&#227;o em geral</option>
		                                        <option value="06112">M&#233;dico cirurgi&#227;o pedi&#225;trico</option>
		                                        <option value="06113">M&#233;dico de per&#237;cias m&#233;dicas</option>
		                                        <option value="06114">M&#233;dico anatomopatologista</option>
		                                        <option value="06115">M&#233;dico anestesista</option>
		                                        <option value="06116">M&#233;dico broncoesofalogista</option>
		                                        <option value="06117">M&#233;dico cardiologista</option>
		                                        <option value="06118">M&#233;dico cirurgi&#227;o vascular</option>
		                                        <option value="06119">M&#233;dico dermatologista</option>
		                                        <option value="06120">M&#233;dico cirurgi&#227;o cardiovascular</option>
		                                        <option value="06121">M&#233;dico oncologista pedi&#225;trico</option>
		                                        <option value="06122">M&#233;dico do trabalho</option>
		                                        <option value="06123">M&#233;dico gastroenterologista</option>
		                                        <option value="06124">M&#233;dico hematologista</option>
		                                        <option value="06125">M&#233;dico endocrinologista</option>
		                                        <option value="06126">M&#233;dico nuclear</option>
		                                        <option value="06127">M&#233;dico endoscopista</option>
		                                        <option value="06128">M&#233;dico fisiatra</option>
		                                        <option value="06129">M&#233;dico oncologista clinico</option>
		                                        <option value="06130">M&#233;dico reumatologista</option>
		                                        <option value="06131">M&#233;dico neurocirurgi&#227;o</option>
		                                        <option value="06132">M&#233;dico ginecologista</option>
		                                        <option value="06133">M&#233;dico alergista/imunologista</option>
		                                        <option value="06134">M&#233;dico geriatra</option>
		                                        <option value="06135">M&#233;dico hemoterapeuta</option>
		                                        <option value="06136">M&#233;dico hansenologista</option>
		                                        <option value="06137">M&#233;dico legista</option>
		                                        <option value="06138">M&#233;dico nefrologista</option>
		                                        <option value="06139">M&#233;dico mastologista</option>
		                                        <option value="06140">M&#233;dico sanitarista</option>
		                                        <option value="06141">M&#233;dico de sa&#250;de da fam&#237;lia</option>
		                                        <option value="06142">M&#233;dico neurologista</option>
		                                        <option value="06143">M&#233;dico geneticista clinico</option>
		                                        <option value="06144">M&#233;dico infectologista</option>
		                                        <option value="06145">M&#233;dico obstetra</option>
		                                        <option value="06146">M&#233;dico cirurgi&#227;o de cabe&#231;a e pesco&#231;o</option>
		                                        <option value="06147">M&#233;dico oftalmologista</option>
		                                        <option value="06148">M&#233;dico homeopata</option>
		                                        <option value="06149">M&#233;dico ginecologista / obstetra</option>
		                                        <option value="06150">M&#233;dico ortopedista</option>
		                                        <option value="06151">M&#233;dico geral comunit&#225;rio</option>
		                                        <option value="06152">M&#233;dico otorrinolaringologista</option>
		                                        <option value="06153">M&#233;dico citopatologista</option>
		                                        <option value="06154">M&#233;dico cirurgi&#227;o tor&#225;cico</option>
		                                        <option value="06155">M&#233;dico pediatra</option>
		                                        <option value="06156">M&#233;dico ultrasonografista</option>
		                                        <option value="06157">M&#233;dico pneumotisiologista</option>
		                                        <option value="06158">M&#233;dico acupunturista</option>
		                                        <option value="06159">M&#233;dico cancerologista</option>
		                                        <option value="06160">M&#233;dico proctologista</option>
		                                        <option value="06161">M&#233;dico cirurgi&#227;o de m&#227;o</option>
		                                        <option value="06162">M&#233;dico psiquiatra</option>
		                                        <option value="06163">M&#233;dico cirurgi&#227;o do aparelho digestivo</option>
		                                        <option value="06164">M&#233;dico plantonista</option>
		                                        <option value="06165">M&#233;dico radiologista</option>
		                                        <option value="06166">M&#233;dico intensivista</option>
		                                        <option value="06167">M&#233;dico radioterapeuta</option>
		                                        <option value="06168">M&#233;dico oncologista cir&#250;rgico</option>
		                                        <option value="06170">M&#233;dico urologista</option>
		                                        <option value="06172">M&#233;dico patologista clinico</option>
		                                        <option value="06175">M&#233;dico angiologista</option>
		                                        <option value="06177">M&#233;dico de medicina esportiva</option>
		                                        <option value="06180">M&#233;dico cirurgi&#227;o pl&#225;stico</option>
		                                        <option value="06190">Outros m&#233;dicos</option>
		                                        <option value="06310">Cirurgi&#227;o dentista em geral</option>
		                                        <option value="06330">Cirurgi&#227;o dentista (sa&#250;de p&#250;blica)</option>
		                                        <option value="06335">Cirurgi&#227;o dentista (traumatologia buco maxilo facial)</option>
		                                        <option value="06340">Cirurgi&#227;o dentista (endodontia)</option>
		                                        <option value="06345">Cirurgi&#227;o dentista (ortodontia)</option>
		                                        <option value="06350">Cirurgi&#227;o dentista (patologia bucal)</option>
		                                        <option value="06355">Cirurgi&#227;o dentista (pediatria)</option>
		                                        <option value="06360">Cirurgi&#227;o dentista (pr&#243;tese)</option>
		                                        <option value="06365">Cirurgi&#227;o dentista (radiologia)</option>
		                                        <option value="06370">Cirurgi&#227;o dentista (periodontia)</option>
		                                        <option value="06510">M&#233;dico veterin&#225;rio em geral</option>
		                                        <option value="06540">Zootecnista</option>
		                                        <option value="06710">Farmac&#234;utico em geral</option>
		                                        <option value="06810">Nutricionista em geral</option>
		                                        <option value="07110">Enfermeiro, em geral</option>
		                                        <option value="07111">Enfermeiro do PACS</option>
		                                        <option value="07112">Enfermeiro do PSF</option>
		                                        <option value="07130">Enfermeiro sanitarista</option>
		                                        <option value="07140">Enfermeiro do trabalho</option>
		                                        <option value="07145">Enfermeiro obstetra</option>
		                                        <option value="07150">Enfermeiro de centro cir&#250;rgico</option>
		                                        <option value="07155">Enfermeiro de terapia intensiva</option>
		                                        <option value="07160">Enfermeiro peuricultor e pedi&#225;trico</option>
		                                        <option value="07165">Enfermeiro psiqui&#225;trico</option>
		                                        <option value="07310">Assistente social em geral</option>
		                                        <option value="07410">Psic&#243;logo em geral</option>
		                                        <option value="07525">Ortoptista</option>
		                                        <option value="07530">&#211;tico</option>
		                                        <option value="07550">T&#233;cnico em orienta&#231;&#227;o e mobilidade de cegos e deficientes visuais</option>
		                                        <option value="07620">Fisioterapeuta</option>
		                                        <option value="07630">Terapeuta ocupacional</option>
		                                        <option value="07690">Terapeutas em geral (outros terapeutas)</option>
	                                        	<option value="07914">Foniatra</option>
		                                        <option value="07915">Acupunturista</option>
		                                        <option value="07925">Fonoaudi&#243;logo</option>
		                                        <option value="19998">Outros profissionais de n&#237;vel superior</option>
		                                        <option value="31120">Agente Administrativo</option>
	                                        </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                3º)</td>
                                            <td>                                            
                                            <select name="ctl00$ContentPlaceHolder1$ddlCBOS_1$ddlCBOS" id="Select2" class="texto">
	                                            <option value="">&lt;--Selecione--&gt;</option>
	                                            <option value="01280">F&#237;sico nuclear</option>
		                                        <option value="04945">Pedagogo</option>
		                                        <option value="05110">Biologista em geral (bi&#243;logo biom&#233;dico)</option>
		                                        <option value="05230">Bioqu&#237;mico</option>
		                                        <option value="05250">Bacteriologista</option>
		                                        <option value="05270">Farmacologista</option>
		                                        <option value="05290">Outros bacteriologistas e trabalhadores assemelhados</option>
		                                        <option value="06105">M&#233;dico em geral (clinico geral)</option>
		                                        <option value="06110">M&#233;dico cirurgi&#227;o em geral</option>
		                                        <option value="06112">M&#233;dico cirurgi&#227;o pedi&#225;trico</option>
		                                        <option value="06113">M&#233;dico de per&#237;cias m&#233;dicas</option>
		                                        <option value="06114">M&#233;dico anatomopatologista</option>
		                                        <option value="06115">M&#233;dico anestesista</option>
		                                        <option value="06116">M&#233;dico broncoesofalogista</option>
		                                        <option value="06117">M&#233;dico cardiologista</option>
		                                        <option value="06118">M&#233;dico cirurgi&#227;o vascular</option>
		                                        <option value="06119">M&#233;dico dermatologista</option>
		                                        <option value="06120">M&#233;dico cirurgi&#227;o cardiovascular</option>
		                                        <option value="06121">M&#233;dico oncologista pedi&#225;trico</option>
		                                        <option value="06122">M&#233;dico do trabalho</option>
		                                        <option value="06123">M&#233;dico gastroenterologista</option>
		                                        <option value="06124">M&#233;dico hematologista</option>
		                                        <option value="06125">M&#233;dico endocrinologista</option>
		                                        <option value="06126">M&#233;dico nuclear</option>
		                                        <option value="06127">M&#233;dico endoscopista</option>
		                                        <option value="06128">M&#233;dico fisiatra</option>
		                                        <option value="06129">M&#233;dico oncologista clinico</option>
		                                        <option value="06130">M&#233;dico reumatologista</option>
		                                        <option value="06131">M&#233;dico neurocirurgi&#227;o</option>
		                                        <option value="06132">M&#233;dico ginecologista</option>
		                                        <option value="06133">M&#233;dico alergista/imunologista</option>
		                                        <option value="06134">M&#233;dico geriatra</option>
		                                        <option value="06135">M&#233;dico hemoterapeuta</option>
		                                        <option value="06136">M&#233;dico hansenologista</option>
		                                        <option value="06137">M&#233;dico legista</option>
		                                        <option value="06138">M&#233;dico nefrologista</option>
		                                        <option value="06139">M&#233;dico mastologista</option>
		                                        <option value="06140">M&#233;dico sanitarista</option>
		                                        <option value="06141">M&#233;dico de sa&#250;de da fam&#237;lia</option>
		                                        <option value="06142">M&#233;dico neurologista</option>
		                                        <option value="06143">M&#233;dico geneticista clinico</option>
		                                        <option value="06144">M&#233;dico infectologista</option>
		                                        <option value="06145">M&#233;dico obstetra</option>
		                                        <option value="06146">M&#233;dico cirurgi&#227;o de cabe&#231;a e pesco&#231;o</option>
		                                        <option value="06147">M&#233;dico oftalmologista</option>
		                                        <option value="06148">M&#233;dico homeopata</option>
		                                        <option value="06149">M&#233;dico ginecologista / obstetra</option>
		                                        <option value="06150">M&#233;dico ortopedista</option>
		                                        <option value="06151">M&#233;dico geral comunit&#225;rio</option>
		                                        <option value="06152">M&#233;dico otorrinolaringologista</option>
		                                        <option value="06153">M&#233;dico citopatologista</option>
		                                        <option value="06154">M&#233;dico cirurgi&#227;o tor&#225;cico</option>
		                                        <option value="06155">M&#233;dico pediatra</option>
		                                        <option value="06156">M&#233;dico ultrasonografista</option>
		                                        <option value="06157">M&#233;dico pneumotisiologista</option>
		                                        <option value="06158">M&#233;dico acupunturista</option>
		                                        <option value="06159">M&#233;dico cancerologista</option>
		                                        <option value="06160">M&#233;dico proctologista</option>
		                                        <option value="06161">M&#233;dico cirurgi&#227;o de m&#227;o</option>
		                                        <option value="06162">M&#233;dico psiquiatra</option>
		                                        <option value="06163">M&#233;dico cirurgi&#227;o do aparelho digestivo</option>
		                                        <option value="06164">M&#233;dico plantonista</option>
		                                        <option value="06165">M&#233;dico radiologista</option>
		                                        <option value="06166">M&#233;dico intensivista</option>
		                                        <option value="06167">M&#233;dico radioterapeuta</option>
		                                        <option value="06168">M&#233;dico oncologista cir&#250;rgico</option>
		                                        <option value="06170">M&#233;dico urologista</option>
		                                        <option value="06172">M&#233;dico patologista clinico</option>
		                                        <option value="06175">M&#233;dico angiologista</option>
		                                        <option value="06177">M&#233;dico de medicina esportiva</option>
		                                        <option value="06180">M&#233;dico cirurgi&#227;o pl&#225;stico</option>
		                                        <option value="06190">Outros m&#233;dicos</option>
		                                        <option value="06310">Cirurgi&#227;o dentista em geral</option>
		                                        <option value="06330">Cirurgi&#227;o dentista (sa&#250;de p&#250;blica)</option>
		                                        <option value="06335">Cirurgi&#227;o dentista (traumatologia buco maxilo facial)</option>
		                                        <option value="06340">Cirurgi&#227;o dentista (endodontia)</option>
		                                        <option value="06345">Cirurgi&#227;o dentista (ortodontia)</option>
		                                        <option value="06350">Cirurgi&#227;o dentista (patologia bucal)</option>
		                                        <option value="06355">Cirurgi&#227;o dentista (pediatria)</option>
		                                        <option value="06360">Cirurgi&#227;o dentista (pr&#243;tese)</option>
		                                        <option value="06365">Cirurgi&#227;o dentista (radiologia)</option>
		                                        <option value="06370">Cirurgi&#227;o dentista (periodontia)</option>
		                                        <option value="06510">M&#233;dico veterin&#225;rio em geral</option>
		                                        <option value="06540">Zootecnista</option>
		                                        <option value="06710">Farmac&#234;utico em geral</option>
		                                        <option value="06810">Nutricionista em geral</option>
		                                        <option value="07110">Enfermeiro, em geral</option>
		                                        <option value="07111">Enfermeiro do PACS</option>
		                                        <option value="07112">Enfermeiro do PSF</option>
		                                        <option value="07130">Enfermeiro sanitarista</option>
		                                        <option value="07140">Enfermeiro do trabalho</option>
		                                        <option value="07145">Enfermeiro obstetra</option>
		                                        <option value="07150">Enfermeiro de centro cir&#250;rgico</option>
		                                        <option value="07155">Enfermeiro de terapia intensiva</option>
		                                        <option value="07160">Enfermeiro peuricultor e pedi&#225;trico</option>
		                                        <option value="07165">Enfermeiro psiqui&#225;trico</option>
		                                        <option value="07310">Assistente social em geral</option>
		                                        <option value="07410">Psic&#243;logo em geral</option>
		                                        <option value="07525">Ortoptista</option>
		                                        <option value="07530">&#211;tico</option>
		                                        <option value="07550">T&#233;cnico em orienta&#231;&#227;o e mobilidade de cegos e deficientes visuais</option>
		                                        <option value="07620">Fisioterapeuta</option>
		                                        <option value="07630">Terapeuta ocupacional</option>
		                                        <option value="07690">Terapeutas em geral (outros terapeutas)</option>
	                                        	<option value="07914">Foniatra</option>
		                                        <option value="07915">Acupunturista</option>
		                                        <option value="07925">Fonoaudi&#243;logo</option>
		                                        <option value="19998">Outros profissionais de n&#237;vel superior</option>
		                                        <option value="31120">Agente Administrativo</option>
	                                        </select>
                                            </td>
                                            <td>
                                                6º)</td>
                                            <td>                                            
                                            <select name="ctl00$ContentPlaceHolder1$ddlCBOS_1$ddlCBOS" id="Select5" class="texto">
	                                            <option value="">&lt;--Selecione--&gt;</option>
	                                            <option value="01280">F&#237;sico nuclear</option>
		                                        <option value="04945">Pedagogo</option>
		                                        <option value="05110">Biologista em geral (bi&#243;logo biom&#233;dico)</option>
		                                        <option value="05230">Bioqu&#237;mico</option>
		                                        <option value="05250">Bacteriologista</option>
		                                        <option value="05270">Farmacologista</option>
		                                        <option value="05290">Outros bacteriologistas e trabalhadores assemelhados</option>
		                                        <option value="06105">M&#233;dico em geral (clinico geral)</option>
		                                        <option value="06110">M&#233;dico cirurgi&#227;o em geral</option>
		                                        <option value="06112">M&#233;dico cirurgi&#227;o pedi&#225;trico</option>
		                                        <option value="06113">M&#233;dico de per&#237;cias m&#233;dicas</option>
		                                        <option value="06114">M&#233;dico anatomopatologista</option>
		                                        <option value="06115">M&#233;dico anestesista</option>
		                                        <option value="06116">M&#233;dico broncoesofalogista</option>
		                                        <option value="06117">M&#233;dico cardiologista</option>
		                                        <option value="06118">M&#233;dico cirurgi&#227;o vascular</option>
		                                        <option value="06119">M&#233;dico dermatologista</option>
		                                        <option value="06120">M&#233;dico cirurgi&#227;o cardiovascular</option>
		                                        <option value="06121">M&#233;dico oncologista pedi&#225;trico</option>
		                                        <option value="06122">M&#233;dico do trabalho</option>
		                                        <option value="06123">M&#233;dico gastroenterologista</option>
		                                        <option value="06124">M&#233;dico hematologista</option>
		                                        <option value="06125">M&#233;dico endocrinologista</option>
		                                        <option value="06126">M&#233;dico nuclear</option>
		                                        <option value="06127">M&#233;dico endoscopista</option>
		                                        <option value="06128">M&#233;dico fisiatra</option>
		                                        <option value="06129">M&#233;dico oncologista clinico</option>
		                                        <option value="06130">M&#233;dico reumatologista</option>
		                                        <option value="06131">M&#233;dico neurocirurgi&#227;o</option>
		                                        <option value="06132">M&#233;dico ginecologista</option>
		                                        <option value="06133">M&#233;dico alergista/imunologista</option>
		                                        <option value="06134">M&#233;dico geriatra</option>
		                                        <option value="06135">M&#233;dico hemoterapeuta</option>
		                                        <option value="06136">M&#233;dico hansenologista</option>
		                                        <option value="06137">M&#233;dico legista</option>
		                                        <option value="06138">M&#233;dico nefrologista</option>
		                                        <option value="06139">M&#233;dico mastologista</option>
		                                        <option value="06140">M&#233;dico sanitarista</option>
		                                        <option value="06141">M&#233;dico de sa&#250;de da fam&#237;lia</option>
		                                        <option value="06142">M&#233;dico neurologista</option>
		                                        <option value="06143">M&#233;dico geneticista clinico</option>
		                                        <option value="06144">M&#233;dico infectologista</option>
		                                        <option value="06145">M&#233;dico obstetra</option>
		                                        <option value="06146">M&#233;dico cirurgi&#227;o de cabe&#231;a e pesco&#231;o</option>
		                                        <option value="06147">M&#233;dico oftalmologista</option>
		                                        <option value="06148">M&#233;dico homeopata</option>
		                                        <option value="06149">M&#233;dico ginecologista / obstetra</option>
		                                        <option value="06150">M&#233;dico ortopedista</option>
		                                        <option value="06151">M&#233;dico geral comunit&#225;rio</option>
		                                        <option value="06152">M&#233;dico otorrinolaringologista</option>
		                                        <option value="06153">M&#233;dico citopatologista</option>
		                                        <option value="06154">M&#233;dico cirurgi&#227;o tor&#225;cico</option>
		                                        <option value="06155">M&#233;dico pediatra</option>
		                                        <option value="06156">M&#233;dico ultrasonografista</option>
		                                        <option value="06157">M&#233;dico pneumotisiologista</option>
		                                        <option value="06158">M&#233;dico acupunturista</option>
		                                        <option value="06159">M&#233;dico cancerologista</option>
		                                        <option value="06160">M&#233;dico proctologista</option>
		                                        <option value="06161">M&#233;dico cirurgi&#227;o de m&#227;o</option>
		                                        <option value="06162">M&#233;dico psiquiatra</option>
		                                        <option value="06163">M&#233;dico cirurgi&#227;o do aparelho digestivo</option>
		                                        <option value="06164">M&#233;dico plantonista</option>
		                                        <option value="06165">M&#233;dico radiologista</option>
		                                        <option value="06166">M&#233;dico intensivista</option>
		                                        <option value="06167">M&#233;dico radioterapeuta</option>
		                                        <option value="06168">M&#233;dico oncologista cir&#250;rgico</option>
		                                        <option value="06170">M&#233;dico urologista</option>
		                                        <option value="06172">M&#233;dico patologista clinico</option>
		                                        <option value="06175">M&#233;dico angiologista</option>
		                                        <option value="06177">M&#233;dico de medicina esportiva</option>
		                                        <option value="06180">M&#233;dico cirurgi&#227;o pl&#225;stico</option>
		                                        <option value="06190">Outros m&#233;dicos</option>
		                                        <option value="06310">Cirurgi&#227;o dentista em geral</option>
		                                        <option value="06330">Cirurgi&#227;o dentista (sa&#250;de p&#250;blica)</option>
		                                        <option value="06335">Cirurgi&#227;o dentista (traumatologia buco maxilo facial)</option>
		                                        <option value="06340">Cirurgi&#227;o dentista (endodontia)</option>
		                                        <option value="06345">Cirurgi&#227;o dentista (ortodontia)</option>
		                                        <option value="06350">Cirurgi&#227;o dentista (patologia bucal)</option>
		                                        <option value="06355">Cirurgi&#227;o dentista (pediatria)</option>
		                                        <option value="06360">Cirurgi&#227;o dentista (pr&#243;tese)</option>
		                                        <option value="06365">Cirurgi&#227;o dentista (radiologia)</option>
		                                        <option value="06370">Cirurgi&#227;o dentista (periodontia)</option>
		                                        <option value="06510">M&#233;dico veterin&#225;rio em geral</option>
		                                        <option value="06540">Zootecnista</option>
		                                        <option value="06710">Farmac&#234;utico em geral</option>
		                                        <option value="06810">Nutricionista em geral</option>
		                                        <option value="07110">Enfermeiro, em geral</option>
		                                        <option value="07111">Enfermeiro do PACS</option>
		                                        <option value="07112">Enfermeiro do PSF</option>
		                                        <option value="07130">Enfermeiro sanitarista</option>
		                                        <option value="07140">Enfermeiro do trabalho</option>
		                                        <option value="07145">Enfermeiro obstetra</option>
		                                        <option value="07150">Enfermeiro de centro cir&#250;rgico</option>
		                                        <option value="07155">Enfermeiro de terapia intensiva</option>
		                                        <option value="07160">Enfermeiro peuricultor e pedi&#225;trico</option>
		                                        <option value="07165">Enfermeiro psiqui&#225;trico</option>
		                                        <option value="07310">Assistente social em geral</option>
		                                        <option value="07410">Psic&#243;logo em geral</option>
		                                        <option value="07525">Ortoptista</option>
		                                        <option value="07530">&#211;tico</option>
		                                        <option value="07550">T&#233;cnico em orienta&#231;&#227;o e mobilidade de cegos e deficientes visuais</option>
		                                        <option value="07620">Fisioterapeuta</option>
		                                        <option value="07630">Terapeuta ocupacional</option>
		                                        <option value="07690">Terapeutas em geral (outros terapeutas)</option>
	                                        	<option value="07914">Foniatra</option>
		                                        <option value="07915">Acupunturista</option>
		                                        <option value="07925">Fonoaudi&#243;logo</option>
		                                        <option value="19998">Outros profissionais de n&#237;vel superior</option>
		                                        <option value="31120">Agente Administrativo</option>
	                                        </select>
                                            </td>
                                        </tr>
                                        </table>
                                      </td>
                                    </tr>
                                    </table>
                                </fieldset>
                                <fieldset>
                                    <legend>Equipe Médica</legend>
                                        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="width: 370px">Selecione a equipe médica em que o profissional participa:</td>
                                                 <td><select name="ctl00$ContentPlaceHolder1$ddlConselhoProfissional$ddlConselhoProfissional" id="Select6" class="texto">
                                                    <option value="">&lt;--Selecione--&gt;</option>
                                                    <option value="Eqp1">Equipe Médica 1</option>
                                                    <option value="Eqp2">Equipe Médica 2</option>
                                                    <option value="Eqp3">Equipe Médica 3</option>
                                                    <option value="Eqp4">Equipe Médica 4</option>
                                                    <option value="Eqp5">Equipe Médica 5</option>
                                                    <option value="Eqp6">Equipe Médica 6</option>
                                                    <option value="Eqp7">Equipe Médica 7</option>
                                                    <option value="Eqp8">Equipe Médica 8</option>
                                                    <option value="Eqp9">Equipe Médica 9</option>
                                                    <option value="Eqp10">Equipe Médica 10</option>
                                                </select>
                                                </td>
                                            </tr>
                                        </table>
                                    <br />
                                </fieldset>
                                
                                <fieldset>
                                    <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
                                         <tr>
                                            <td align="center"><asp:Button ID="Button1" runat="server" Text="Salvar" /></td>
                                         </tr>
                                    </table>
                                </fieldset>
     
                        </fieldset>     
</asp:Content>

