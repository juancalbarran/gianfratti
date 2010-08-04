<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="FormPosOperatorio.aspx.cs" Inherits="FormPósOperatório_FormPosOperatorio" Title="SmartCare - Hospital do Rim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<fieldset>
  <legend align="center">P&oacute;s Operat&oacute;rio</legend>
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
    <legend>Problemas</legend>
    <table class="texto"  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="7%"><label>
          <input name="Problemas" type="radio" value="radiobutton" />N&atilde;o</label>
     </td>
        <td width="93%">
       <input name="Problemas" type="radio" value="radiobutton" />Sim
        </td>
      </tr>
      <tr>
        <td colspan="2"><input name="textfield3" type="text" style="width: 507px" /></td>
      </tr>
    </table>
  </fieldset>
   <fieldset>
    <legend>Data de P.O. </legend>
    <table class="texto"  width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="95%"><input name="textfield32" type="text" style="width: 295px" /></td>
      </tr>
    </table>
  </fieldset>
  <fieldset>
    <legend>PA / FC</legend>
    <table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td style="width: 172px">Press&atilde;o Arterial (PA): </td>
        <td><input name="textfield33" type="text" style="width: 126px" /></td>
      </tr>
      <tr>
        <td style="height: 24px; width: 172px;">Frequencia Card&iacute;aca (FC):</td>
        <td style="height: 24px"><input name="textfield33" type="text" style="width: 126px" /></td>
      </tr>
    </table>
  </fieldset>
  <fieldset>
    <legend>Peso / Temp. </legend>
    <table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td style="width: 93px">Peso:</td>
        <td><input name="textfield332" type="text" style="width: 203px" /></td>
      </tr>
      <tr>
        <td style="width: 93px">Temperatura:</td>
        <td><input name="textfield332" type="text" style="width: 203px" /></td>
      </tr>
    </table>
  </fieldset>
  <fieldset>
    <legend>Diurese</legend>
    <table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><input name="textfield3224" type="text" style="width: 298px" /></td>
      </tr>
    </table>
  </fieldset>
  <fieldset>
    <legend>Ultrasson</legend>
    <table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><input name="textfield322" type="text" style="width: 296px" /></td>
      </tr>
    </table>
  </fieldset>
  <fieldset>
    <legend>CSA/PRED./AZAT</legend>
    <table class="texto"  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="6%">CSA:</td>
        <td width="94%"><input name="textfield323" type="text" style="width: 242px" /></td>
      </tr>
      <tr>
        <td>PRED:</td>
        <td><input name="textfield323" type="text" style="width: 242px" /></td>
      </tr>
      <tr>
        <td>AZAT:</td>
        <td><input name="textfield323" type="text" style="width: 242px" /></td>
      </tr>
    </table>
  </fieldset>
  <fieldset>
    <legend>Creatina/Ur&eacute;ia</legend>
    <table class="texto"  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="6%">Creatina:</td>
        <td width="94%"><input name="textfield3234" type="text" style="width: 239px" /></td>
      </tr>
      <tr>
        <td>Ur&eacute;ia:</td>
        <td><input name="textfield3234" type="text" style="width: 239px" /></td>
      </tr>
    </table>
  </fieldset>

  <fieldset>
    <legend>Nível Cya</legend>
    <table class="texto"  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><input name="textfield3225" type="text" style="width: 292px" /></td>
      </tr>
    </table>
  </fieldset>
  <fieldset>
    <legend>S&oacute;dio+Pot&aacute;ssio</legend>
    <table class="texto"  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>S&oacute;dio:</td>
        <td><input name="textfield3236" type="text" style="width: 235px" /></td>
      </tr>
      <tr>
        <td width="6%">Pot&aacute;ssio:</td>
        <td width="94%"><input name="textfield3236" type="text" style="width: 235px" /></td>
      </tr>
    </table>
  </fieldset>
  <fieldset>
    <legend>Hb/Htc </legend>
    <table class="texto"  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="3%">Hb:</td>
        <td width="97%"><input name="textfield3238" type="text" style="width: 263px" /></td>
      </tr>
      <tr>
        <td>Htc:</td>
        <td><input name="textfield3238" type="text" style="width: 263px" /></td>
      </tr>
    </table>
  </fieldset>
  <fieldset>
    <legend>Gl. Brancos/Plaq. </legend>
    <table class="texto"  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td style="width: 119px">Gl&oacute;bulos Brancos:</td>
        <td><input name="textfield32383" type="text" style="width: 169px" /></td>
      </tr>
      <tr>
        <td style="width: 119px">Plaquetas:</td>
        <td><input name="textfield32383" type="text" style="width: 169px" /></td>
      </tr>
    </table>
  </fieldset>
  <fieldset>
    <legend>Diferencial</legend>
    <table class="texto"  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><input name="textfield3225" type="text" style="width: 286px" /></td>
      </tr>
    </table>
  </fieldset>
  <fieldset>
    <legend>Protein&uacute;ria/Leu/Hem</legend>
    <table class="texto"  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td style="width: 71px">Protein&uacute;ria:</td>
        <td><input name="textfield322332" type="text" style="width: 214px" /></td>
      </tr>
      <tr>
        <td style="width: 71px">Leu:</td>
        <td><input name="textfield322332" type="text" style="width: 214px" /></td>
      </tr>
      <tr>
        <td style="width: 71px">Hem:</td>
        <td><input name="textfield322332" type="text" style="width: 214px" /></td>
      </tr>
    </table>
  </fieldset>
  <fieldset>
    <legend>Sorolog/Fan/CH50</legend>
    <table class="texto"  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td style="width: 68px">Sorolog:</td>
        <td><input name="textfield32234" type="text" style="width: 215px" /></td>
      </tr>
      <tr>
        <td style="width: 68px">Fan:</td>
        <td><input name="textfield32234" type="text" style="width: 215px" /></td>
      </tr>
      <tr>
        <td style="width: 68px">CH50:</td>
        <td><input name="textfield32234" type="text" style="width: 215px" /></td>
      </tr>
    </table>
  </fieldset>
  <fieldset>
    <legend>Glicemia/TGO/TGP</legend>
    <table class="texto"  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td style="width: 66px">Glicemia:</td>
        <td><input name="textfield322344" type="text" style="width: 216px" /></td>
      </tr>
      <tr>
        <td style="width: 66px">TGO:</td>
        <td><input name="textfield322344" type="text" style="width: 216px" /></td>
      </tr>
      <tr>
        <td style="width: 66px">TGP:</td>
        <td><input name="textfield322344" type="text" style="width: 216px" /></td>
      </tr>
    </table>
  </fieldset>
  <fieldset>
    <legend>Ca/P/PTH-FA</legend>
    <table class="texto"  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td style="width: 66px">Ca:</td>
        <td><input name="textfield3223444" type="text" style="width: 213px" /></td>
      </tr>
      <tr>
        <td style="width: 66px">P:</td>
        <td><input name="textfield3223444" type="text" style="width: 213px" /></td>
      </tr>
      <tr>
        <td style="width: 66px">PTH-FA:</td>
        <td><input name="textfield3223444" type="text" style="width: 213px" /></td>
      </tr>
    </table>
  </fieldset>
  <fieldset>
    <legend>Arteriografia</legend>
    <table class="texto"  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><input name="textfield3225" type="text" style="width: 277px" /></td>
      </tr>
    </table>
  </fieldset>
    <fieldset>
    <legend>Tomografia</legend>
    <table class="texto"  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><input name="textfield3225" type="text" style="width: 277px" /></td>
      </tr>
    </table>
  </fieldset>
  <fieldset>
    <legend>Biopsia</legend>
    <table class="texto"  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><input name="textfield3225" type="text" style="width: 277px" /></td>
      </tr>
    </table>
  </fieldset>
    <fieldset>
    <legend>Problemas/Relatório de Exames/Resumos</legend>
    <table class="texto"  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td style="width: 135px">Problemas:</td>
        <td><input name="textfield3223447" type="text" style="width: 443px" /></td>
      </tr>
      <tr>
        <td style="width: 135px">Relat&oacute;rio de Exames: </td>
        <td><input name="textfield3223447" type="text" style="width: 443px" /></td>
      </tr>
      <tr>
        <td style="width: 135px">Resumos:</td>
        <td><input name="textfield3223447" type="text" style="width: 443px" /></td>
      </tr>
    </table>
  </fieldset>
      <fieldset>
      <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center"><asp:Button ID="Button1" runat="server" Text="Salvar" /></td>
        </tr>
      </table>
    </fieldset>
</fieldset>
</asp:Content>

