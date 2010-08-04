<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="FormCadastrodePacientes.aspx.cs" Inherits="Cadastro_de_Pacientes_FormCadastrodePacientes" Title="Untitled Page" %>
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
	      <td style="height: 24px"><asp:TextBox ID="TextBox33" runat="server" Width="264px"></asp:TextBox></td>
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
              <asp:TextBox ID="TextBox1" runat="server" Width="417px"></asp:TextBox></td>
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
              <asp:TextBox ID="TextBox2" runat="server" Width="115px"></asp:TextBox></td>
	      <td style="height: 18px">
              <asp:TextBox ID="TextBox3" runat="server" Width="79px"></asp:TextBox></td>
          <td style="height: 18px">
              <asp:TextBox ID="TextBox4" runat="server" Width="133px"></asp:TextBox></td>
	      <td style="height: 18px">
              <asp:TextBox ID="TextBox5" runat="server" Width="215px"></asp:TextBox></td>
	      <td style="height: 18px">
              <asp:TextBox ID="TextBox6" runat="server" Width="197px"></asp:TextBox></td>
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
              <asp:TextBox ID="TextBox7" runat="server" Width="229px"></asp:TextBox></td>
          <td style="height: 19px">
              <asp:TextBox ID="TextBox8" runat="server" Width="45px"></asp:TextBox></td>
          <td style="height: 19px">
              <asp:TextBox ID="TextBox9" runat="server" Width="124px"></asp:TextBox></td>
          <td style="height: 19px">
              <asp:TextBox ID="TextBox10" runat="server" Width="175px"></asp:TextBox></td>
          <td style="height: 19px">
              <asp:TextBox ID="TextBox11" runat="server" Width="31px"></asp:TextBox></td>
          <td style="height: 19px">
              <asp:TextBox ID="TextBox12" runat="server" Width="198px"></asp:TextBox></td>
	    </tr>
    </table>
	  <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
	    <tr>
		  <td width="5%">DDD</td>
		  <td width="16%">Telefone Resid&ecirc;ncial </td>
		  <td width="6%">DDD</td>
		  <td width="15%">Telefone Comercial</td>
		  <td width="6%">DDD</td>
		  <td width="18%">Celular</td>
		  <td width="34%">Tefones Contato</td>
	    </tr>
	    <tr>
	      <td>
              <asp:TextBox ID="TextBox13" runat="server" Width="38px"></asp:TextBox></td>
          <td>
              <asp:TextBox ID="TextBox14" runat="server" Width="133px"></asp:TextBox></td>
          <td>
              <asp:TextBox ID="TextBox15" runat="server" Width="41px"></asp:TextBox></td>
          <td>
              <asp:TextBox ID="TextBox16" runat="server" Width="124px"></asp:TextBox></td>
          <td>
              <asp:TextBox ID="TextBox17" runat="server" Width="41px"></asp:TextBox></td>
          <td>
              <asp:TextBox ID="TextBox18" runat="server" Width="124px"></asp:TextBox></td>
          <td>
              <asp:TextBox ID="TextBox30" runat="server" Width="257px"></asp:TextBox></td>
	    </tr>
	  </table>
	  </fieldset>
	</fieldset>
    <fieldset>
	  <legend>Dados Atendimento</legend>
	  <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 32px">
	    <tr>
	      <td width="17%">Data do Atendimento</td>
	      <td style="width: 1%">&nbsp;</td>
	      <td colspan="2">Tipo de Atendimento </td>
	    </tr>
	    <tr>
	      <td width="14%" style="height: 25px"><asp:TextBox ID="TextBox19" runat="server" Width="129px"></asp:TextBox></td>
	      <td style="width: 1%; height: 25px;">&nbsp;</td>
	      <td style="height: 25px; width: 6%;">
              <input id="Radio1" name="SUS" type="radio" title="SUS" />SUS</td>
	      <td style="width: 11%; height: 25px;"><input id="Radio2" name="Particular" title="Particular" type="radio"/>Particular</td>
	      <td width="68%" style="height: 25px" title="Convênio"><input id="Radio3" name="Convênio" title="Convênio" type="radio" />Convênio</td>
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
	      <td style="height: 24px"><asp:TextBox ID="TextBox20" runat="server" Width="271px"></asp:TextBox></td>
	      <td style="height: 24px"><asp:TextBox ID="TextBox21" runat="server" Width="278px"></asp:TextBox></td>
	      <td style="height: 24px"><asp:TextBox ID="TextBox22" runat="server" Width="203px"></asp:TextBox></td>
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
	      <td style="height: 24px"><asp:TextBox ID="TextBox23" runat="server" Width="270px"></asp:TextBox></td>
	      <td style="height: 24px"><asp:TextBox ID="TextBox24" runat="server" Width="57px"></asp:TextBox></td>
	      <td style="height: 24px"><asp:TextBox ID="TextBox25" runat="server" Width="199px"></asp:TextBox></td>
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
	      <td><asp:TextBox ID="TextBox26" runat="server" Width="555px"></asp:TextBox></td>
        </tr>
	    <tr>
	      <td>Hospital</td>
        </tr>
	    <tr>
	      <td><asp:TextBox ID="TextBox27" runat="server" Width="554px"></asp:TextBox></td>
        </tr>
	    <tr>
	      <td>Institucional</td>
        </tr>
	    <tr>
	      <td><asp:TextBox ID="TextBox28" runat="server" Width="554px"></asp:TextBox></td>
        </tr>
      </table>
        </fieldset>
	<fieldset>
	  <legend>Finalidade</legend>
	  <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
	    <tr>
		  <td width="20%" style="height: 19px"><input id="Radio3" name="SUS" title="Transplante Renal" type="radio" />Transplante Renal</td>
		  <td width="19%" style="height: 19px"><input id="Radio4" name="SUS" title="Urologia" type="radio" />Urologia</td>
		  <td width="18%" style="height: 19px" title="Plástica"><input id="Radio6" name="SUS" title="Plástica" type="radio" />Plástica</td>
		  <td width="43%" style="height: 19px"><input id="Radio9" name="SUS" title="Hemodinâmica" type="radio" />Hemodinâmica</td>
	    </tr>
	    <tr>
	      <td><input id="Radio8" name="SUS" title="Vascular" type="radio" />Vascular</td>
	      <td title="Cardiologia"><input id="Radio5" name="SUS" title="Cardiologia" type="radio" />Cardiologia</td>
	      <td title="Outros"><input id="Radio7" name="SUS" title="Outros" type="radio" />Outros</td>
	      <td><asp:TextBox ID="TextBox29" runat="server" Width="270px"></asp:TextBox></td>
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

