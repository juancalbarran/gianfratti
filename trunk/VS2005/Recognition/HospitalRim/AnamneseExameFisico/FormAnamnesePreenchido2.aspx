<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="FormAnamnesePreenchido2.aspx.cs" Inherits="AnamneseExameFisico_FormAnamnesePreenchido2" Title="Untitled Page" %>
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
                parda</td>
            <td>
                61</td>
            <td>
                fem</td>
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
                    XXY</td>
                <td>
                    20/11/2007</td>
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
                DM<br />
                HAS<br />
                Dislipidemia</td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>Antecedentes Familiares</legend>
        <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td>
                Mae diabetica</td>
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
                18 X 10</td>
            <td width="6%">FC:</td>
            <td width="19%">
                88</td>
            <td width="6%">FR:</td>
            <td width="39%">
                22</td>
          </tr>
          <tr>
            <td>
                T:</td>
            <td>
                36,8</td>
            <td>Peso:</td>
            <td>
                56,3</td>
            <td>Altura:</td>
            <td>
                1,52</td>
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
            <td width="3%">1.</td>
            <td width="8%">CID10:</td>
            <td width="8%">
                N18</td>
            <td width="31%">
                Insuficiencia renal cronica</td>
            <td width="3%">1.</td>
            <td width="8%">CID10:</td>
            <td width="8%">
                &nbsp;</td>
            <td width="31%">
                &nbsp;</td>
          </tr>
          <tr>
            <td>2.</td>
            <td>CID10:</td>
            <td>
                E10</td>
            <td>
                Diabetes melitus</td>
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
            <td>CID10:</td>
            <td>
                E15</td>
            <td>
                Hipertensao arterial</td>
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
            <td>CID10:</td>
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
            <td>CID10:</td>
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
            <td>CID10:</td>
            <td>
                &nbsp;
                </td>
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

