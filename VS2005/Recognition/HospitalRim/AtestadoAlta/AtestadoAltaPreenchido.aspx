<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="AtestadoAltaPreenchido.aspx.cs" Inherits="AtestadoAlta_AtestadoAltaPreenchido" Title="Untitled Page" %>
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
            <td>
                Jose da Silva Filho</td>
            <td>
                111 222</td>
            <td>
                701</td>
            <td>
                22/11/07</td>
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
                3452</td>
            <td>
                branca</td>
            <td>
                48</td>
            <td>
                masc</td>
          </tr>
        </table>
</fieldset>      
	  
	<fieldset>
      <legend>Data de Alta</legend>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="texto">
          <tr>
            <td style="width: 167px"> 29/11/2007</td>
            <td style="width: 101px">Dias Internado:</td>
            <td>
                8</td>
          </tr>
        </table>
  </fieldset>
  
	<fieldset>
      <legend>Quadro Clínico e Evolu&ccedil;&atilde;o </legend>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="texto">
          <tr>
            <td>
                Tx renal doador cadaver
            </td>
          </tr>
        </table>
  </fieldset>

      <fieldset>
        <legend>Exames Subsidi&aacute;rios </legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td>
                </td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Tratamento Realizado </legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
           <tr>
            <td>
                Tx renal</td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Outros Procedimentos </legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
	        <td>
                Angioplastia coronaria</td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Diagn&oacute;stico Principal </legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
	        <td style="width: 72px">CID10:</td>
	        <td width="50">N18</td>
	        <td>
                Insuficiencia Renal Cronica</td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Diagn&oacute;stico(s) Secund&aacute;rio(s) </legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="2%" style="height: 24px">1.</td>
            <td style="width: 51px">CID10:</td>
	        <td width="50">
                E10</td>
	        <td>
                Diabetes</td>
          </tr>
          <tr>
            <td style="height: 24px">2.</td>
            <td style="width: 51px">CID10:</td>
	        <td width="50">
                E15</td>
	        <td>
                Hipertensao</td>
          </tr>
          <tr>
            <td>3.</td>
            <td style="width: 51px">CID10:</td>
	        <td width="50">
                </td>
	        <td>
                </td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Encaminhamento </legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="98%">
                </td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Condições de Alta</legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="14%">
                Alta a Pedido</td>
          </tr>
        </table>
      </fieldset>
      <fieldset>
        <legend>Orienta&ccedil;&atilde;o e Terap&ecirc;utica </legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="98%">
                </td>
          </tr>
        </table>
      </fieldset>
  </fieldset>
</asp:Content>

