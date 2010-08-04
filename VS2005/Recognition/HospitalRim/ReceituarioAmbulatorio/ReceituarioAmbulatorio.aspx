<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="ReceituarioAmbulatorio.aspx.cs" Inherits="ReceituarioAmbulatorio_ReceituarioAmbulatorio" Title="SmartCare - Hospital do Rim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<fieldset>
		<legend align="center">Receituário</legend>
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
                <input id="Text61" style="width: 275px" type="text" /></td>
            <td>
                <input id="Text62" style="width: 220px" type="text" /></td>
            <td>
                <input id="Text63" style="width: 128px" type="text" /></td>
            <td>
                <input id="Text64" type="text" /></td>
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
                <input id="Text65" style="width: 275px" type="text" /></td>
            <td>
                <input id="Text66" style="width: 220px" type="text" /></td>
            <td>
                <input id="Text67" style="width: 128px" type="text" /></td>
            <td>
                <input id="Text68" type="text" /></td>
          </tr>
        </table>
</fieldset>      

		<fieldset>
			<legend>Medicação</legend>
			<table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr>
			    <td style="width: 122px">Prescri&ccedil;&atilde;o</td>
			    <td width="15%">Dose</td>
		    	<td width="15%">Via Adm. </td>
			    <td width="15%">Intervalo</td>
			  </tr>
			  <tr>
			    <td style="width: 122px"><input id="Text1" type="text" style="width: 535px" /></td>
			    <td><input id="Text8" style="width: 127px" type="text" /></td>
		    	<td><input id="Text15" style="width: 125px" type="text" /></td>
			    <td><input id="Text22" style="width: 130px" type="text" /></td>
			  </tr>
			  <tr>
			    <td style="width: 122px"><input id="Text2" type="text" style="width: 535px" /></td>
			    <td><input id="Text9" style="width: 127px" type="text" /></td>
		    	<td><input id="Text16" style="width: 125px" type="text" /></td>
			    <td><input id="Text23" type="text" style="width: 130px" /></td>
			  </tr>
			  <tr>
			    <td style="width: 122px"><input id="Text3" type="text" style="width: 535px" /></td>
			    <td><input id="Text10" style="width: 127px" type="text" /></td>
		    	<td><input id="Text17" style="width: 125px" type="text" /></td>
			    <td><input id="Text24" type="text" style="width: 130px" /></td>
			  </tr>
		  	  <tr>
			    <td style="width: 122px"><input id="Text4" type="text" style="width: 535px" /></td>
			    <td><input id="Text11" style="width: 127px" type="text" /></td>
			    <td><input id="Text18" style="width: 125px" type="text" /></td>
		    	<td><input id="Text25" type="text" style="width: 130px" /></td>
			  </tr>
			  <tr>
			    <td style="width: 122px"><input id="Text5" type="text" style="width: 535px" /></td>
			    <td><input id="Text12" style="width: 127px" type="text" /></td>
			    <td><input id="Text19" style="width: 125px" type="text" /></td>
		    	<td><input id="Text26" type="text" style="width: 130px" /></td>
			  </tr>
			  <tr>
			    <td style="width: 122px"><input id="Text6" type="text" style="width: 535px" /></td>
			    <td><input id="Text13" style="width: 127px" type="text" /></td>
			    <td><input id="Text20" style="width: 125px" type="text" /></td>
		    	<td><input id="Text27" type="text" style="width: 130px" /></td>
			  </tr>
			  <tr>
			    <td style="width: 122px"><input id="Text7" type="text" style="width: 535px" /></td>
			    <td><input id="Text14" style="width: 127px" type="text" /></td>
			    <td><input id="Text21" style="width: 125px" type="text" /></td>
		    	<td><input id="Text28" type="text" style="width: 130px" /></td>
			  </tr>
			  <tr>
			    <td style="width: 122px"><input id="Text36" type="text" style="width: 535px" /></td>
			    <td><input id="Text37" style="width: 127px" type="text" /></td>
			    <td><input id="Text38" style="width: 125px" type="text" /></td>
		    	<td><input id="Text39" type="text" style="width: 130px" /></td>
			  </tr>
			  <tr>
			    <td style="width: 122px"><input id="Text41" type="text" style="width: 535px" /></td>
			    <td><input id="Text42" style="width: 127px" type="text" /></td>
			    <td><input id="Text43" style="width: 125px" type="text" /></td>
		    	<td><input id="Text44" type="text" style="width: 130px" /></td>
			  </tr>
			  <tr>
			    <td style="width: 122px"><input id="Text46" type="text" style="width: 535px" /></td>
			    <td><input id="Text47" style="width: 127px" type="text" /></td>
			    <td><input id="Text48" style="width: 125px" type="text" /></td>
		    	<td><input id="Text49" type="text" style="width: 130px" /></td>
			  </tr>		
		</table>
		</fieldset>
		<fieldset>
			<legend>Observações</legend>
			<table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><textarea id="Textarea2" style="width: 100%; height: 95px"></textarea></td>
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

