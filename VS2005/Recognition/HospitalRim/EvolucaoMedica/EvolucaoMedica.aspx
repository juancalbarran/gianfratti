<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="EvolucaoMedica.aspx.cs" Inherits="EvolucaoMedica_EvolucaoMedica" Title="SmartCare - Hospital do Rim" %>
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
                <input id="Text9" style="width: 275px" type="text" /></td>
            <td>
                <input id="Text11" style="width: 220px" type="text" /></td>
            <td>
                <input id="Text13" style="width: 128px" type="text" /></td>
            <td>
                <input id="Text15" type="text" /></td>
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
                <input id="Text10" style="width: 275px" type="text" /></td>
            <td>
                <input id="Text12" style="width: 220px" type="text" /></td>
            <td>
                <input id="Text14" style="width: 128px" type="text" /></td>
            <td>
                <input id="Text16" type="text" /></td>
          </tr>
        </table>
</fieldset>      
		<fieldset>
			<legend>Evolução</legend>
    	    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="texto">
				<tr>
				  <td><textarea name="textarea" id="Textarea2" style="width: 100%; height: 380px"></textarea></td>
				</tr>
			</table>
		</fieldset>
		<fieldset>
		      <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center"><asp:Button ID="Button1" runat="server" Text="Salvar" OnClick="Button1_Click" /></td>
        </tr>
      </table>
		</fieldset>
	</fieldset>
</asp:Content>

