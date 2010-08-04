<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="FormAnamnesePreenchido.aspx.cs" Inherits="Anamnese_FormAnamnesePreenchido" Title="SmartCare - Hospital do Rim" %>
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
                <td>
                    </td>
                <td>
                    </td>
            </tr>
            <tr>
                <td>
                    </td>
                <td>
                    </td>
            </tr> 
            <tr>
                <td>
                    </td>
                <td>
                    </td>
            </tr>
            <tr>
                <td></td>
                <td></td>
            </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Queixa e Dura&ccedil;&atilde;o</legend>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="texto">
          <tr>
            <td>
                </td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Hist&oacute;ria Pregressa Mol&eacute;stia Atual</legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td style="height: 24px">
                Paciente com IRC internou para Tx renal</td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Interrogat&oacute;rio Complementar</legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
           <tr>
            <td style="height: 19px">
                </td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Antecedentes Pessoais</legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
	        <td>
                Politraumatismo ha 5 meses com nefrectomia
                <br />
                HAS<br />
                Infecção urinaria de repetição<br />
                Gota</td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Antecedentes Familiares</legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td>
                NDN</td>
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
            <td width="24%">
                14 X 8</td>
            <td width="6%">FC:</td>
            <td width="19%">
                82</td>
            <td width="6%">FR:</td>
            <td width="39%">
                16</td>
          </tr>
          <tr>
            <td>
                T:</td>
            <td>
                36,3</td>
            <td>Peso:</td>
            <td>
                72,4</td>
            <td>Altura:</td>
            <td>
                1,75</td>
          </tr>
        </table>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <br />
                    Complementação:</td>
            </tr>
            <tr>
            <td></td>
            </tr>
        </table>
      </fieldset>

<fieldset>
        <legend>Hip&oacute;teses Diagn&oacute;sticas</legend>
        <table class="texto" width="100%" border="1" cellpadding="0" cellspacing="0">
          <tr>
            <td colspan="4">Sindr&ocirc;micas </td>
            <td colspan="4">Etiol&oacute;gicas</td>
          </tr>
          <tr>
            <td width="3%" style="height: 16px">1.</td>
            <td style="width: 79px; height: 16px">CID10:</td>
            <td width="8%" style="height: 16px">
                N18</td>
            <td width="31%" style="height: 16px">
                Insuficiencia renal cronica</td>
            <td width="3%" style="height: 16px">1.</td>
            <td width="8%" style="height: 16px">CID10:</td>
            <td width="8%" style="height: 16px">
                &nbsp;</td>
            <td width="31%" style="height: 16px">
                &nbsp;</td>
          </tr>
          <tr>
            <td>2.</td>
            <td style="width: 79px">CID10:</td>
            <td>
                M10</td>
            <td>
                Gota</td>
            <td>
                2.</td>
            <td>
                CID10:</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
          </tr>
          <tr>
            <td>3.</td>
            <td style="width: 79px">CID10:</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;&nbsp;</td>
            <td>
                3.</td>
            <td>CID10:</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
          </tr>
          <tr>
            <td>4.</td>
            <td style="width: 79px">CID10:</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                4.</td>
            <td>
                CID10:</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
          </tr>
          <tr>
            <td>5.</td>
            <td style="width: 79px">CID10:</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>5.</td>
            <td>CID10:</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
          </tr>
          <tr>
            <td>6.</td>
            <td style="width: 79px">CID10:</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                6.</td>
            <td>
                CID10:</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
          </tr>
        </table>
</fieldset>
    <fieldset>
      <legend>Coment&aacute;rios, discuss&atilde;o com preceptor e exames pedidos</legend>
      <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td style="height: 19px">
              </td>
        </tr>
      </table>
    </fieldset>
  </fieldset>

</asp:Content>