<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="SolicitarExames.aspx.cs" Inherits="SolicitarExames_SolicitarExames" Title="SmartCare - Hospital do Rim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<fieldset>
		<legend align="center">Solicitar Exames</legend>
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
                <input id="Text29" style="width: 275px" type="text" /></td>
            <td>
                <input id="Text30" style="width: 220px" type="text" /></td>
            <td>
                <input id="Text31" style="width: 128px" type="text" /></td>
            <td>
                <input id="Text32" type="text" /></td>
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
                <input id="Text33" style="width: 275px" type="text" /></td>
            <td>
                <input id="Text34" style="width: 220px" type="text" /></td>
            <td>
                <input id="Text35" style="width: 128px" type="text" /></td>
            <td>
                <input id="Text40" type="text" /></td>
          </tr>
        </table>
</fieldset>      
<fieldset>
			<legend>Exames</legend>
			<table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr>
			    <td width="40%">Exame</td>
			    <td width="15%">Data</td>
		    	<td width="15%">Hora</td>
			    <td width="30%">Observações</td>
			  </tr>
			  <tr>
			    <td><input id="Text1" type="text" style="width: 345px" /></td>
			    <td><input id="Text8" style="width: 127px" type="text" /></td>
		    	<td><input id="Text15" style="width: 125px" type="text" /></td>
			    <td><input id="Text22" style="width: 171px" type="text" /></td>
			  </tr>
			  <tr>
			    <td><input id="Text2" type="text" style="width: 345px" /></td>
			    <td><input id="Text9" style="width: 127px" type="text" /></td>
		    	<td><input id="Text16" style="width: 125px" type="text" /></td>
			    <td><input id="Text23" type="text" style="width: 171px" /></td>
			  </tr>
			  <tr>
			    <td><input id="Text3" type="text" style="width: 345px" /></td>
			    <td><input id="Text10" style="width: 127px" type="text" /></td>
		    	<td><input id="Text17" style="width: 125px" type="text" /></td>
			    <td><input id="Text24" type="text" style="width: 171px" /></td>
			  </tr>
		  	  <tr>
			    <td><input id="Text4" type="text" style="width: 345px" /></td>
			    <td><input id="Text11" style="width: 127px" type="text" /></td>
			    <td><input id="Text18" style="width: 125px" type="text" /></td>
		    	<td><input id="Text25" type="text" style="width: 171px" /></td>
			  </tr>
			  <tr>
			    <td><input id="Text5" type="text" style="width: 345px" /></td>
			    <td><input id="Text12" style="width: 127px" type="text" /></td>
			    <td><input id="Text19" style="width: 125px" type="text" /></td>
		    	<td><input id="Text26" type="text" style="width: 171px" /></td>
			  </tr>
			  <tr>
			    <td><input id="Text6" type="text" style="width: 345px" /></td>
			    <td><input id="Text13" style="width: 127px" type="text" /></td>
			    <td><input id="Text20" style="width: 125px" type="text" /></td>
		    	<td><input id="Text27" type="text" style="width: 171px" /></td>
			  </tr>
			  <tr>
			    <td><input id="Text7" type="text" style="width: 345px" /></td>
			    <td><input id="Text14" style="width: 127px" type="text" /></td>
			    <td><input id="Text21" style="width: 125px" type="text" /></td>
		    	<td><input id="Text28" type="text" style="width: 171px" /></td>
			  </tr>
			  <tr>
			    <td><input id="Text36" type="text" style="width: 345px" /></td>
			    <td><input id="Text37" style="width: 127px" type="text" /></td>
			    <td><input id="Text38" style="width: 125px" type="text" /></td>
		    	<td><input id="Text39" type="text" style="width: 171px" /></td>
			  </tr>
			  <tr>
			    <td><input id="Text41" type="text" style="width: 345px" /></td>
			    <td><input id="Text42" style="width: 127px" type="text" /></td>
			    <td><input id="Text43" style="width: 125px" type="text" /></td>
		    	<td><input id="Text44" type="text" style="width: 171px" /></td>
			  </tr>
			  <tr>
			    <td><input id="Text46" type="text" style="width: 345px" /></td>
			    <td><input id="Text47" style="width: 127px" type="text" /></td>
			    <td><input id="Text48" style="width: 125px" type="text" /></td>
		    	<td><input id="Text49" type="text" style="width: 171px" /></td>
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

