<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="CadastrodePacientesPreenchido2.aspx.cs" Inherits="CadastrodePacientes_CadastrodePacientesPreenchido2" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <fieldset>
    <legend align="center">Cadastro de Paciente</legend>

	<fieldset>
	  <legend>Registro Geral</legend>
	  <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
	    <tr>
		  <td width="32%">Nº Registro Geral do Hospital</td>
	    </tr>
	    <tr>
	      <td style="height: 24px">
              111 222</td>
        </tr>
      </table>
	</fieldset>
	
	<fieldset>
	  <legend>Dados Pessoais</legend>
	  <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
	    <tr>
		  <td width="63%">Nome</td>
	    </tr>
	    <tr>
	      <td>
              Jose da Silva Filho</td>
        </tr>
	  </table>
	  <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
		  <td width="18%">Data de Nascimento </td>
		  <td width="12%">Idade</td>
		  <td width="15%">Naturalidade</td>
	      <td width="23%">RG</td>
	      <td width="25%">CPF</td>
		</tr>
	    <tr>
	      <td style="height: 18px; width: 125px;">
              1959</td>
	      <td style="height: 18px">
              48</td>
          <td style="height: 18px">
              Brasileira</td>
	      <td style="height: 18px">
              11.222.333-44</td>
	      <td style="height: 18px">
              123.456.789-00</td>
	    </tr>
      </table>
	  <fieldset>
	    <legend>Endereço Pessoal</legend>
	  <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
	    <tr>
		  <td width="27%">Endere&ccedil;o</td>
		  <td width="6%">N&uacute;mero</td>
		  <td width="15%">Bairro</td>
		  <td width="21%">Cidade</td>
		  <td width="4%">UF</td>
		  <td width="27%">CEP</td>
	    </tr>
	    <tr>
	      <td style="height: 19px">
              Av. Eng; Luiz Carlos Berrini</td>
          <td style="height: 19px">
              1500</td>
          <td style="height: 19px">
              Novo Brooklin</td>
          <td style="height: 19px">
              São Paulo</td>
          <td style="height: 19px">
              SP</td>
          <td style="height: 19px">
              <span style="font-size: 10pt">04571-000</span></td>
	    </tr>
    </table>
	  <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
	    <tr>
		  <td width="5%">DDD</td>
		  <td width="16%">Telefone Resid&ecirc;ncial </td>
		  <td width="6%">DDD</td>
		  <td width="15%">Telefone Comercial</td>
		  <td style="width: 61px">DDD</td>
		  <td style="width: 177px">Celular</td>
		  <td width="34%">Tefones Contato</td>
	    </tr>
	    <tr>
	      <td>
              011</td>
          <td>
              5508-4972</td>
          <td>
              011</td>
          <td>
              5508-4973</td>
          <td style="width: 61px">
              011</td>
          <td style="width: 177px">
              9117-3450</td>
          <td>
              </td>
	    </tr>
	  </table>
	  </fieldset>
	</fieldset>
    <fieldset>
	  <legend>Dados Atendimento</legend>
	  <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 32px">
	    <tr>
	      <td width="17%">Data do Atendimento</td>
	      <td colspan="1" style="width: 109px">Tipo de Atendimento </td>
	    </tr>
	    <tr>
	      <td width="14%" style="height: 25px">
              20/11/2007</td>
	      <td style="width: 109px; height: 25px;">
              SUS</td>
	    </tr>
	  </table>
	  <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
	    <tr>
		  <td width="32%" style="height: 19px">Dados Conv&ecirc;nio </td>
	      <td width="33%" style="height: 19px">&nbsp;</td>
	      <td width="35%" style="height: 19px">&nbsp;</td>
        </tr>
	    <tr>
	      <td>Nome</td>
	      <td>Tipo de Plano</td>
	      <td>N&uacute;mero</td>
        </tr>
	    <tr>
	      <td style="height: 24px">
              Sistema Unico de Saúde</td>
	      <td style="height: 24px">
              </td>
	      <td style="height: 24px">
              </td>
        </tr>
      </table>
	</fieldset>
	<fieldset>
	  <legend>Procedência</legend>
	  <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
	    <tr>
		  <td width="32%">Cidade</td>
		  <td width="8%">Estado</td>
		  <td width="60%">Pa&iacute;s</td>
	    </tr>
	    <tr>
	      <td style="height: 24px">
              </td>
	      <td style="height: 24px">
              </td>
	      <td style="height: 24px">
              </td>
        </tr>
      </table>
	</fieldset>
	<fieldset>
	  <legend>Encaminhado por</legend>
	  <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
	    <tr>
		  <td>
              Médico</td>
		</tr>
	    <tr>
	      <td>
              </td>
        </tr>
	    <tr>
	      <td>Hospital</td>
        </tr>
	    <tr>
	      <td>
              </td>
        </tr>
	    <tr>
	      <td>Institucional</td>
        </tr>
	    <tr>
	      <td>
              </td>
        </tr>
      </table>
        </fieldset>
	<fieldset>
	  <legend>Finalidade</legend>
	  <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
	    <tr>
	      <td>
              Transplante Renal</td>
        </tr>
      </table>
	</fieldset>
  </fieldset>
</asp:Content>

