<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrescrissaoMedicaImpressao.aspx.cs" Inherits="PrescricaoMedica_PrescrissaoMedicaImpressao" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
	<fieldset>
		<legend align="center">Prescrição Médica</legend>
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
			<legend>Prescrição</legend>
	        <table width="100%" border="1" cellpadding="0" cellspacing="0" class="texto">
	          <tr>
		        <td width="532">
			        Prescri&ccedil;&atilde;o</td>
		        <td width="97">
			        Dose</td>
		        <td width="106">
			        &nbsp;Via &nbsp;Adm.</td>
		        <td width="86">
			        Intervalo</td>
		        <td width="98">
			        Hora</td>
		        <td width="298">
			        Observações</td>
	          </tr>
	          <tr>
		        <td>
			        D. Leve &nbsp; Hipossodica</td>
		        <td>&nbsp;
		        </td>
		        <td>&nbsp;
		        </td>
		        <td>&nbsp;
		        </td>
		        <td>&nbsp;
		        </td>
		        <td>&nbsp;
		        </td>
	          </tr>
	          <tr>
		        <td>
			        S. Glicossado 5%</td>
		        <td>
			        500ml</td>
		        <td>
			        EV</td>
		        <td>
			        8/8 hs</td>
		        <td>
			        12-20-06</td>
		        <td>&nbsp;
		        </td>
	          </tr>
	          <tr>
		        <td>
			        Cefalexina</td>
		        <td>
			        1,0g</td>
		        <td>
			        EV</td>
		        <td>
			        6/6 hs</td>
		        <td>
			        12-18-24-06</td>
		        <td style="width: 86px">&nbsp;
		        </td>
	          </tr>
	          <tr>
		        <td>
			        Vancomicina</td>
		        <td>
			        1,0g</td>
		        <td>
			        EV</td>
		        <td>
			        1x/ &nbsp;Dia</td>
		        <td>
			        16</td>
		        <td>&nbsp;
		        </td>
	          </tr>
	          <tr>
		        <td>
			        Meticorten</td>
		        <td>
			        60mg</td>
		        <td>
			        VO</td>
		        <td>
			        1x/ Dia</td>
		        <td>
			        manhã</td>
		        <td>&nbsp;
		        </td>
	          </tr>
	          <tr>
		        <td>
			        Azatriopina</td>
		        <td>&nbsp;
		        </td>
		        <td>
			        VO</td>
		        <td>&nbsp;
		        </td>
		        <td>&nbsp;
		        </td>
		        <td>&nbsp;
		        </td>
	          </tr>
	          <tr>
		        <td>
			        CSA</td>
		        <td>&nbsp;
		        </td>
		        <td>
			        VO</td>
		        <td>&nbsp;
		        </td>
		        <td>&nbsp;
		        </td>
		        <td>&nbsp;
		        </td>
	          </tr>
	          <tr>
		        <td>
			        Atenolol</td>
		        <td>&nbsp;
		        </td>
		        <td>
			        VO</td>
		        <td>&nbsp;
		        </td>
		        <td>&nbsp;
		        </td>
		        <td>&nbsp;
		        </td>
	          </tr>
	          <tr>
		        <td>
			        Captopril</td>
		        <td>&nbsp;
		        </td>
		        <td>
			        VO</td>
		        <td>&nbsp;
		        </td>
		        <td>&nbsp;
		        </td>
		        <td>&nbsp;
		        </td>
	          </tr>
	          <tr>
		        <td>
			        Lasix</td>
		        <td>&nbsp;
		        </td>
		        <td>
			        EV</td>
		        <td>&nbsp;
		        </td>
		        <td>&nbsp;
		        </td>
		        <td>&nbsp;
		        </td>
	          </tr>				  
	          <tr>
		        <td>
			        AAS</td>
		        <td>
			        100mg</td>
		        <td>
			        VO</td>
		        <td>
			        1x/ Dia</td>
		        <td>
			        após almoço</td>
		        <td>&nbsp;
		        </td>
	          </tr>				  
	          <tr>
		        <td>
			        Dextro</td>
		        <td>&nbsp;
		        </td>
		        <td>&nbsp;
		        </td>
		        <td>
			        4x/ Dia</td>
		        <td>&nbsp;
		        </td>
		        <td>&nbsp;
		        </td>
	          </tr>			  
	          <tr>
		        <td>
			        Insulina simples 3 ui</td>
		        <td>&nbsp;
		        </td>
		        <td>
			        SC</td>
		        <td>&nbsp;
		        </td>
		        <td>&nbsp;
		        </td>
		        <td>
			        Dextro:180-250
		        </td>
	          </tr>			  
	          <tr>
		        <td>
			        Insulina simples 5 ui</td>
		        <td>&nbsp;
		        </td>
		        <td>
			        SC</td>
		        <td>&nbsp;
		        </td>
		        <td>&nbsp;
		        </td>
		        <td>
			        Dextro: &nbsp; 250-350&nbsp;
		        </td>
	          </tr>		
	        </table>
		</fieldset>
		<fieldset>
			<legend>Observações</legend>
			<table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
                        </td>
				</tr>
		</table>
		</fieldset>

	</fieldset>
    </form>
</body>
</html>
