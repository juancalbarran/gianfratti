<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="FormAnamneseExameFisico.aspx.cs" Inherits="AnamneseExameFisico_FormAnamneseExameFisico" Title="SmartCare - Hospital do Rim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

  <fieldset>
    <legend align="center">Anamnese e Exames F&iacute;sico</legend>

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
                <input id="Text9" style="width: 275px" type="text"/></td>
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
        <legend>Protocolo</legend>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
            <tr>
                <td>Caso o paciente participe de algum protocolo, favor especificar abaixo: </td>
            </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
            <tr>
                <td width="47%">
                    Protocolo:</td>
                <td width="53%">Data de in&iacute;cio da participação:</td>
            </tr>
            <tr>
                <td><input id="Text1" style="width: 395px" type="text" /></td>
                <td><input id="Text5" style="width: 175px" type="text" />
                    </td>
            </tr>
            <tr>
                <td><input id="Text2" style="width: 395px" type="text" /></td>
                <td><input id="Text6" style="width: 175px" type="text" />
                    </td>
            </tr> 
            <tr>
                <td><input id="Text3" style="width: 395px" type="text" /></td>
                <td><input id="Text7" style="width: 175px" type="text" /></td>
            </tr>
            <tr>
                <td><input id="Text4" style="width: 395px" type="text" /></td>
                <td><input id="Text8" style="width: 175px" type="text" /></td>
            </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Queixa e Dura&ccedil;&atilde;o</legend>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="texto">
          <tr>
            <td><textarea id="Textarea1" rows="2" style="width: 100%"></textarea></td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Hist&oacute;ria Pregressa Mol&eacute;stia Atual</legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td style="height: 24px"><textarea id="Textarea2" style="width: 100%; height: 95px"></textarea></td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Interrogat&oacute;rio Complementar</legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
           <tr>
            <td><textarea id="Textarea7" rows="2" style="width: 100%"></textarea></td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Antecedentes Pessoais</legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
	        <td><textarea id="Textarea4" rows="2" style="width: 100%"></textarea></td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Antecedentes Familiares</legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td><textarea id="Textarea5" rows="2" style="width: 100%"></textarea></td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Exame F&iacute;sico</legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          
          <tr>
            <td width="12%">Ex. F&iacute;sico </td>
            <td colspan="5"></td>
          </tr>
          <tr>
            <td width="6%">PA:</td>
            <td width="24%"><input type="text" name="textfield14" /></td>
            <td width="6%">FC:</td>
            <td width="19%"><input type="text" name="textfield15" /></td>
            <td width="6%">FR:</td>
            <td width="39%"><input type="text" name="textfield16" /></td>
          </tr>
          <tr>
            <td>
                T:</td>
            <td><input type="text" name="textfield17" /></td>
            <td>Peso:</td>
            <td><input type="text" name="textfield18" /></td>
            <td>Altura:</td>
            <td><input type="text" name="textfield19" /></td>
          </tr>
        </table>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <br />
                    Complementação:</td>
            </tr>
            <tr>
            <td><textarea id="Textarea3" style="width: 100%; height: 95px;"></textarea></td>
            </tr>
        </table>
      </fieldset>

<fieldset>
        <legend>Hip&oacute;teses Diagn&oacute;sticas</legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td colspan="4">Sindr&ocirc;micas </td>
            <td colspan="4">Etiol&oacute;gicas</td>
          </tr>
          <tr>
            <td width="3%">1.</td>
            <td width="8%">CID10:</td>
            <td width="8%"><input name="textfield2022" type="text" style="width: 50px" id="Text17" runat="server" /></td>
            <td width="31%"><input name="textfield202" type="text" style="width: 265px" /></td>
            <td width="3%">1.</td>
            <td width="8%">CID10:</td>
            <td width="8%"><input name="textfield20227" type="text" style="width: 50px" /></td>
            <td width="31%"><input name="textfield202" type="text" style="width: 265px" /></td>
          </tr>
          <tr>
            <td>2.</td>
            <td>CID10:</td>
            <td><input name="textfield20222" type="text" style="width: 50px" id="Text18" runat="server" /></td>
            <td><input name="textfield202" type="text" style="width: 265px" /></td>
            <td>
                2.</td>
            <td>
                CID10:</td>
            <td><input name="textfield20229" type="text" style="width: 50px" /></td>
            <td><input name="textfield202" type="text" style="width: 265px" /></td>
          </tr>
          <tr>
            <td>3.</td>
            <td>CID10:</td>
            <td><input name="textfield20223" type="text" style="width: 50px" id="Text19" runat="server" /></td>
            <td><input name="textfield202" type="text" style="width: 265px" /></td>
            <td>
                3.</td>
            <td>CID10:</td>
            <td><input name="textfield20228" type="text" style="width: 50px" /></td>
            <td><input name="textfield202" type="text" style="width: 265px" /></td>
          </tr>
          <tr>
            <td>4.</td>
            <td>CID10:</td>
            <td><input name="textfield20224" type="text" style="width: 50px" id="Text20" runat="server" /></td>
            <td><input name="textfield202" type="text" style="width: 265px" /></td>
            <td>
                4.</td>
            <td>
                CID10:</td>
            <td><input name="textfield20229" type="text" style="width: 50px" /></td>
            <td><input name="textfield202" type="text" style="width: 265px" /></td>
          </tr>
          <tr>
            <td>5.</td>
            <td>CID10:</td>
            <td><input name="textfield20225" type="text" style="width: 50px" /></td>
            <td><input name="textfield202" type="text" style="width: 265px" /></td>
            <td>
                5.</td>
            <td>CID10:</td>
            <td><input name="textfield20229" type="text" style="width: 50px" /></td>
            <td><input name="textfield202" type="text" style="width: 265px" /></td>
          </tr>
          <tr>
            <td>6.</td>
            <td>CID10:</td>
            <td><input name="textfield20226" type="text" style="width: 50px" /></td>
            <td><input name="textfield202" type="text" style="width: 265px" /></td>
            <td>
                6.</td>
            <td>
                CID10:</td>
            <td><input name="textfield20229" type="text" style="width: 50px" /></td>
            <td><input name="textfield202" type="text" style="width: 265px" /></td>
          </tr>
        </table>
    </fieldset>
    <fieldset>
      <legend>Coment&aacute;rios, discuss&atilde;o com preceptor e exames pedidos</legend>
      <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td>
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

