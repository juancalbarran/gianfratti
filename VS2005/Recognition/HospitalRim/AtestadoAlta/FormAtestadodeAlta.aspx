<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="FormAtestadodeAlta.aspx.cs" Inherits="AtestadoAlta_FormAtestadodeAlta" Title="SmartCare - Hospital do Rim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<fieldset style="height: 100%">
    <legend align="center">Resumo de Alta</legend>
    
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
            <td><input id="Text9" style="width: 275px" type="text" /></td>
            <td><input id="Text11" style="width: 220px" type="text" /></td>
            <td><input id="Text13" style="width: 128px" type="text" /></td>
            <td><input id="Text15" type="text" /></td>
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
            <td><input id="Text10" style="width: 275px" type="text" /></td>
            <td><input id="Text12" style="width: 220px" type="text" /></td>
            <td><input id="Text14" style="width: 128px" type="text" /></td>
            <td><input id="Text16" type="text" /></td>
          </tr>
        </table>
</fieldset>      
	  
	<fieldset>
      <legend>Data de Alta</legend>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="texto">
          <tr>
            <td style="width: 167px"> <input id="Text5" type="text" /></td>
            <td style="width: 101px">Dias Internado:</td>
            <td>
                <input id="Text6" type="text" /></td>
          </tr>
        </table>
  </fieldset>
  
	<fieldset>
      <legend>Quadro Clínico e Evolu&ccedil;&atilde;o </legend>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="texto">
          <tr>
            <td><textarea id="TextArea1" rows="2" style="width: 100%"></textarea></td>
          </tr>
        </table>
  </fieldset>

      <fieldset>
        <legend>Exames Subsidi&aacute;rios </legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td>
                <textarea id="Textarea2" rows="2" style="width: 100%"></textarea></td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Tratamento Realizado </legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
           <tr>
            <td>
                <textarea id="Textarea3" rows="2" style="width: 100%"></textarea></td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Outros Procedimentos </legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
	        <td>
                <textarea id="Textarea4" rows="2" style="width: 100%"></textarea></td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Diagn&oacute;stico Principal </legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
	        <td>CID10:</td>
	        <td width="50"><input id="Text1" style="width: 45px" type="text" /></td>
	        <td><input name="textfield14" type="text" style="width: 592px" /></td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Diagn&oacute;stico(s) Secund&aacute;rio(s) </legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="2%" style="height: 24px">1.</td>
            <td>CID10:</td>
	        <td width="50"><input id="Text2" style="width: 45px" type="text" /></td>
	        <td><input name="textfield14" type="text" style="width: 575px" /></td>
          </tr>
          <tr>
            <td style="height: 24px">2.</td>
            <td>CID10:</td>
	        <td width="50"><input id="Text3" style="width: 45px" type="text" /></td>
	        <td><input name="textfield14" type="text" style="width: 575px" /></td>
          </tr>
          <tr>
            <td>3.</td>
            <td>CID10:</td>
	        <td width="50"><input id="Text4" style="width: 45px" type="text" /></td>
	        <td><input name="textfield14" type="text" style="width: 575px" /></td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Encaminhamento </legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="98%">
                <textarea id="Textarea5" rows="2" style="width: 100%"></textarea></td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Condições de Alta</legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="13%"><label><input name="radiobutton" type="radio" value="radiobutton" />Curado</label></td>
            <td width="15%"><input name="radiobutton" type="radio" value="radiobutton" />Melhorado </td>
            <td width="14%"><input name="radiobutton" type="radio" value="radiobutton" />Piorado </td>
            <td width="15%"><input name="radiobutton" type="radio" value="radiobutton" />Alta a Pedido (*) </td>
            <td width="14%"><input name="radiobutton" type="radio" value="radiobutton" />&Oacute;bito</td>
            <td width="15%"><input name="radiobutton" type="radio" value="radiobutton" />Inalterado</td>
            <td width="14%"><input name="radiobutton" type="radio" value="radiobutton" />Doador</td>
          </tr>
        </table>
      </fieldset>
      <fieldset>
        <legend>Orienta&ccedil;&atilde;o e Terap&ecirc;utica </legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="98%">
                <textarea id="Textarea6" rows="2" style="width: 100%"></textarea></td>
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

