<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="InterConsultas.aspx.cs" Inherits="Interconsultas_InterConsultas" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<fieldset>
	<legend align="center">Solicitar Inter-Consultas</legend>
	<fieldset>
        <legend>Dados Paciente</legend>
		<table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
        	<tr>
            	<td width="30%">Nome do Paciente </td>
	            <td width="25%">Registro Geral </td>
    	        <td width="15%">Quarto/Leito</td>
        	    <td width="25%">Data</td>
	        </tr>
        	<tr>
            	<td>
                	<input id="Text9" style="width: 275px" type="text" />
				</td>
            	<td>
	                <input id="Text11" style="width: 220px" type="text" />
	            </td>
    	        <td>
        	        <input id="Text13" style="width: 128px" type="text" />
        	    </td>
            	<td>
                	<input id="Text15" type="text" />
                </td>
	        </tr>
        </table>
        <table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
        	<tr>
            	<td width="30%">N&ordm; Atendimento
            	</td>
	            <td width="25%">
	                Cor
	            </td>
    	        <td width="15%">
    	            Idade
    	        </td>
        	    <td width="25%">
        	        Sexo
        	    </td>
        	</tr>
        	<tr>
            	<td>
                	<input id="Text10" style="width: 275px" type="text" />
				</td>
	            <td>
    	            <input id="Text12" style="width: 220px" type="text" />
				</td>
	            <td>
    	            <input id="Text14" style="width: 128px" type="text" />
    	        </td>
        	    <td>
            	    <input id="Text16" type="text" />
				</td>
        	</tr>
        </table>
	</fieldset>
	<fieldset>
		<legend>Dados Profissional Solicitante</legend>
		<table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="319">
				    M&eacute;dico
				</td>
				<td width="702">
				    Especialidade
				</td>
		    </tr>
			<tr>
				<td width="319">
				    <input name="text" type="text" id="text" style="width: 275px" />
			    </td>
				<td width="702">
				    <input name="text2" type="text" id="text2" style="width: 275px" />
				</td>
		    </tr>
		</table>
	</fieldset>
	<fieldset>
	    <legend>Profissional Solicitado</legend>
		<table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="319">Especialidade  </td>
			</tr>
			<tr>
				<td width="319">                                  
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
			</tr>
		</table>
	</fieldset>
	<br />
	<fieldset>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td align="center">
                    <asp:Button ID="Button1" runat="server" Text="Solicitar" OnClick="Button1_Click" />
                </td>
            </tr>
        </table>
    </fieldset>
</fieldset>
</asp:Content>