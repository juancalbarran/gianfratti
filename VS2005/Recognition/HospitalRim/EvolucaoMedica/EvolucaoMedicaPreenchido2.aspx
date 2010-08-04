<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="EvolucaoMedicaPreenchido2.aspx.cs" Inherits="EvolucaoMedica_EvolucaoMedicaPreenchido2" Title="Untitled Page" %>
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
                Maria da Silva</td>
            <td>
                111 111</td>
            <td>
                702</td>
            <td>
                20/11/2007</td>
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
                3450</td>
            <td>
                Parda</td>
            <td>
                61</td>
            <td>
                Fem</td>
          </tr>
        </table>
    </fieldset>      
		<fieldset>
			<legend>Evolução</legend>
    	    <table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
				  <td>
                      8° pos operatório de TX renal com rim de cadaver evoluindo 
                      <br />
                      Creatinina de 4,5 e Potássio de 5,6
                      <br />
                      Mantem em hemodialise
                      <br />
                      Iniciara protocolo</td>
				</tr>
			</table>
		</fieldset>
	</fieldset>
</asp:Content>

