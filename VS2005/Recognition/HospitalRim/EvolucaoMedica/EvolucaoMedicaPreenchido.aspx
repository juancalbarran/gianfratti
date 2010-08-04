<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="EvolucaoMedicaPreenchido.aspx.cs" Inherits="EvolucaoMedica_EvolucaoMedicaPreenchido" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<fieldset>
		<legend align="center">Evolução Médica</legend>
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
                Jose da Silva Filho</td>
            <td>
                111 222</td>
            <td>
                701</td>
            <td>
                22/11/2007</td>
          </tr>
        </table>
        <table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="30%">N&ordm; Atendimento </td>
            <td width="25%">Cor</td>
            <td width="15%">Idade</td>
            <td width="25%">Sexo</td>
          </tr>
          <tr>
            <td>
                3542</td>
            <td>
                Branca</td>
            <td>
                48</td>
            <td>
                Masc</td>
          </tr>
        </table>
    </fieldset>      
		<fieldset>
			<legend>Evolução</legend>
    	    <table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
				  <td>
                      Paciente no pos operatorio imediato de TX renal com rim de cadaver evoluindo sem
                      complicaçoes
                      <br />
                      Manter dados do protocolo
                      <br />
                      Suspender diureticos</td>
				</tr>
			</table>
		</fieldset>
	</fieldset>
</asp:Content>

