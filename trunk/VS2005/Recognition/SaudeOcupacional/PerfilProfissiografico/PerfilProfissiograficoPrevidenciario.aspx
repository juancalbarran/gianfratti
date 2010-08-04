<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="PerfilProfissiograficoPrevidenciario.aspx.cs" Inherits="PerfilProfissiografico_Default" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<fieldset>
  <legend align="center">Perfil Profissiogr&aacute;fico Previdenci&aacute;rio</legend>
  <fieldset>
    <legend>Se&ccedil;&atilde;o de Dados Administrativos </legend>
	<table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
	    <td width="33%">CNPJ do Domic&iacute;lio Tribut&aacute;rio/CEE </td>
	    <td width="34%">Nome Empresarial </td>
	    <td width="33%">CNAE</td>
      </tr>
      <tr>
        <td>
            <asp:TextBox ID="TextBox1" runat="server" Width="261px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox2" runat="server" Width="261px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox3" runat="server" Width="261px"></asp:TextBox></td>
      </tr>
      <tr>
        <td>Nome do Trabalhador</td>
        <td>BR/PDH</td>
        <td>NIT</td>
      </tr>
      <tr>
        <td>
            <asp:TextBox ID="TextBox4" runat="server" Width="261px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox5" runat="server" Width="261px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox6" runat="server" Width="261px"></asp:TextBox></td>
      </tr>
    </table>
    <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
	    <td width="22%">Data do Nascimento </td>
	    <td width="11%">Sexo</td>
  	    <td colspan="3" align="center">CTPS (Numero, S&eacute;rie e UF)</td>
	    <td width="15%">Data de Admiss&atilde;o </td>
        <td width="19%">Regime Revezamento </td>
      </tr>
      <tr>
	    <td style="height: 19px">
            <asp:TextBox ID="TextBox7" runat="server" Width="165px"></asp:TextBox></td>
	    <td style="height: 19px">
            <asp:TextBox ID="TextBox77" runat="server" Width="65px"></asp:TextBox></td>
	    <td width="16%" style="height: 19px">&nbsp;<asp:TextBox ID="TextBox78" runat="server" Width="126px"></asp:TextBox></td>
	    <td width="11%" style="height: 19px">
            <asp:TextBox ID="TextBox79" runat="server" Width="90px"></asp:TextBox></td>
	    <td width="7%" style="height: 19px">
            <asp:TextBox ID="TextBox80" runat="server" Width="37px"></asp:TextBox></td>
	    <td style="height: 19px">
            <asp:TextBox ID="TextBox76" runat="server" Width="102px"></asp:TextBox></td>
	    <td style="height: 19px">
            <asp:TextBox ID="TextBox191" runat="server" Width="126px"></asp:TextBox></td>
	  </tr>
    </table>
    <fieldset>
    <legend>CAT Registrada</legend>
    <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
  	  <tr>
	    <td width="25%">Data do Registro </td>
        <td width="25%">N&uacute;mero de CAT </td>
        <td width="25%">Data do Registro </td>
        <td width="25%">N&uacute;mero de CAT </td>
      </tr>  	
      <tr>
	    <td>
            <asp:TextBox ID="TextBox8" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox9" runat="server" Width="165px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox10" runat="server" Width="165px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox11" runat="server" Width="188px"></asp:TextBox></td>
	  </tr>
    </table>
    </fieldset>
    <fieldset>
    <legend>Lotação e Atribuição</legend>
    <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
	    <td colspan="2" align="center">Per&iacute;odo</td>
	    <td width="13%">CNPJ/CEI</td>
	    <td width="12%">Setor</td>
	    <td width="12%">Cargo</td>
	    <td width="12%">Fun&ccedil;&atilde;o</td>
	    <td width="12%">CBO</td>
        <td width="13%">C&oacute;d. GFIP </td>
      </tr>
	  <tr>
	    <td width="13%">
            <asp:TextBox ID="TextBox12" runat="server" Width="102px"></asp:TextBox></td>
	    <td width="13%">
            <asp:TextBox ID="TextBox13" runat="server" Width="102px"></asp:TextBox></td>
	    <td>
            <asp:TextBox ID="TextBox81" runat="server" Width="102px"></asp:TextBox></td>
	    <td>
            <asp:TextBox ID="TextBox88" runat="server" Width="102px"></asp:TextBox></td>
	    <td>
            <asp:TextBox ID="TextBox89" runat="server" Width="102px"></asp:TextBox></td>
	    <td>
            <asp:TextBox ID="TextBox96" runat="server" Width="102px"></asp:TextBox></td>
	    <td>
            <asp:TextBox ID="TextBox97" runat="server" Width="102px"></asp:TextBox></td>
	    <td>
            <asp:TextBox ID="TextBox101" runat="server" Width="84px"></asp:TextBox></td>
	  </tr>
	  <tr>
	    <td style="height: 19px">
            <asp:TextBox ID="TextBox19" runat="server" Width="102px"></asp:TextBox></td>
        <td style="height: 19px">
            <asp:TextBox ID="TextBox14" runat="server" Width="102px"></asp:TextBox></td>
        <td style="height: 19px">
            <asp:TextBox ID="TextBox82" runat="server" Width="102px"></asp:TextBox></td>
        <td style="height: 19px">
            <asp:TextBox ID="TextBox87" runat="server" Width="102px"></asp:TextBox></td>
        <td style="height: 19px">
            <asp:TextBox ID="TextBox90" runat="server" Width="102px"></asp:TextBox></td>
        <td style="height: 19px">
            <asp:TextBox ID="TextBox95" runat="server" Width="102px"></asp:TextBox></td>
        <td style="height: 19px">
            <asp:TextBox ID="TextBox98" runat="server" Width="102px"></asp:TextBox></td>
        <td style="height: 19px">
            <asp:TextBox ID="TextBox102" runat="server" Width="84px"></asp:TextBox></td>
      </tr>
      <tr>
        <td>
            <asp:TextBox ID="TextBox18" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox15" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox83" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox86" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox91" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox94" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox99" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox103" runat="server" Width="84px"></asp:TextBox></td>
      </tr>
      <tr>
        <td>
            <asp:TextBox ID="TextBox17" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox16" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox84" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox85" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox92" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox93" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox100" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox104" runat="server" Width="84px"></asp:TextBox></td>
      </tr>
    </table>
    </fieldset>
    <fieldset>
    <legend>Profissiografía</legend>
    <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td colspan="2"align="center">Per&iacute;odo</td>
        <td width="74%">Descri&ccedil;&atilde;o das Atividades </td>
      </tr>
      <tr>
        <td width="13%">
            <asp:TextBox ID="TextBox20" runat="server" Width="102px"></asp:TextBox></td>
        <td width="13%">
            <asp:TextBox ID="TextBox21" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox105" runat="server" Width="620px"></asp:TextBox></td>
      </tr>
      <tr>
        <td>
            <asp:TextBox ID="TextBox28" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox22" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox106" runat="server" Width="620px"></asp:TextBox></td>
      </tr>
      <tr>
        <td>
            <asp:TextBox ID="TextBox29" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox23" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox107" runat="server" Width="620px"></asp:TextBox></td>
      </tr>
      <tr>
        <td>
            <asp:TextBox ID="TextBox30" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox24" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox108" runat="server" Width="620px"></asp:TextBox></td>
      </tr>
      <tr>
        <td>
            <asp:TextBox ID="TextBox31" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox25" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox109" runat="server" Width="620px"></asp:TextBox></td>
      </tr>
      <tr>
        <td>
            <asp:TextBox ID="TextBox32" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox26" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox110" runat="server" Width="620px"></asp:TextBox></td>
      </tr>
      <tr>
        <td>
            <asp:TextBox ID="TextBox33" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox27" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox111" runat="server" Width="620px"></asp:TextBox></td>
      </tr>
    </table>
    </fieldset>
  </fieldset>
  <fieldset>
    <legend>Se&ccedil;&atilde;o de Registros Ambientais</legend>
    <fieldset>
    <legend>Exposição a Fatores de Risco</legend>
    <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td colspan="2" align="center">Per&iacute;odo</td>
        <td width="7%">Tipo</td>
        <td width="13%">Fator de Risco </td>
        <td width="13%">Itens/ Conc </td>
        <td width="13%">T&eacute;cnica Utilizada </td>
        <td width="13%">EPC Eficaz (Sim/N&atilde;o)</td>
        <td width="15%">CA EPI </td>
      </tr>
      <tr>
        <td width="13%">
            <asp:TextBox ID="TextBox34" runat="server" Width="102px"></asp:TextBox></td>
        <td width="13%">
            <asp:TextBox ID="TextBox35" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox132" runat="server" Width="55px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox139" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox146" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox153" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox160" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox167" runat="server" Width="103px"></asp:TextBox></td>
      </tr>
      <tr>
        <td>
            <asp:TextBox ID="TextBox42" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox36" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox133" runat="server" Width="55px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox140" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox147" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox154" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox161" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox168" runat="server" Width="103px"></asp:TextBox></td>
      </tr>
      <tr>
        <td>
            <asp:TextBox ID="TextBox43" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox37" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox134" runat="server" Width="55px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox141" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox148" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox155" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox162" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox169" runat="server" Width="103px"></asp:TextBox></td>
      </tr>
      <tr>
        <td>
            <asp:TextBox ID="TextBox44" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox38" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox135" runat="server" Width="55px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox142" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox149" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox156" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox163" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox170" runat="server" Width="103px"></asp:TextBox></td>
      </tr>
      <tr>
        <td>
            <asp:TextBox ID="TextBox45" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox39" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox136" runat="server" Width="55px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox143" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox150" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox157" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox164" runat="server" Width="101px"></asp:TextBox></td>
      <td>
          <asp:TextBox ID="TextBox171" runat="server" Width="103px"></asp:TextBox></td>
      </tr>
      <tr>
        <td>
            <asp:TextBox ID="TextBox46" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox40" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox137" runat="server" Width="55px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox144" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox151" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox158" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox165" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox172" runat="server" Width="103px"></asp:TextBox></td>
      </tr>
      <tr>
        <td>
            <asp:TextBox ID="TextBox47" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox41" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox138" runat="server" Width="55px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox145" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox152" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox159" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox166" runat="server" Width="101px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox173" runat="server" Width="103px"></asp:TextBox></td>
      </tr>
    </table>
    </fieldset>
	<fieldset>
	<legend>Responsável Pelos Registros Ambientais</legend>
	<table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
	  <tr>
	    <td colspan="2" align="center">Per&iacute;odo</td>
	    <td width="25%">NIT</td>
	    <td width="25%">Registro Conselho de Classe </td>
	    <td width="25%">Nome do Profissional Legalmente Habilitado </td>
	  </tr>
	  <tr>
	    <td width="12%">
            <asp:TextBox ID="TextBox48" runat="server" Width="102px"></asp:TextBox></td>
        <td width="13%">
            <asp:TextBox ID="TextBox49" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox112" runat="server" Width="211px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox117" runat="server" Width="211px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox122" runat="server" Width="190px"></asp:TextBox></td>
	  </tr>
	  <tr>
	    <td>
            <asp:TextBox ID="TextBox51" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox50" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox113" runat="server" Width="211px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox118" runat="server" Width="211px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox123" runat="server" Width="190px"></asp:TextBox></td>
	  </tr>
	  <tr>
	    <td style="height: 24px">
            <asp:TextBox ID="TextBox52" runat="server" Width="102px"></asp:TextBox></td>
        <td style="height: 24px">
            <asp:TextBox ID="TextBox53" runat="server" Width="102px"></asp:TextBox></td>
        <td style="height: 24px">
            <asp:TextBox ID="TextBox114" runat="server" Width="211px"></asp:TextBox></td>
        <td style="height: 24px">
            <asp:TextBox ID="TextBox119" runat="server" Width="211px"></asp:TextBox></td>
        <td style="height: 24px">
            <asp:TextBox ID="TextBox124" runat="server" Width="190px"></asp:TextBox></td>
	  </tr>
	  <tr>
	    <td>
            <asp:TextBox ID="TextBox55" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox54" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox115" runat="server" Width="211px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox120" runat="server" Width="211px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox125" runat="server" Width="190px"></asp:TextBox></td>
	  </tr>
	  <tr>
	    <td>
            <asp:TextBox ID="TextBox56" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox57" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox116" runat="server" Width="211px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox121" runat="server" Width="211px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox126" runat="server" Width="190px"></asp:TextBox></td>
	  </tr>
  </table>
  </fieldset>
  </fieldset>
  <fieldset>
    <legend>Secao de Resultados de Monitoração Biológica</legend>
    <fieldset>
    <legend>Exames Médicos, Clínicos e Complementares</legend>
    <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
	  <tr>
	    <td width="20%">Data</td>
	    <td width="20%">Tipo</td>
	    <td width="20%">Natureza</td>
	    <td width="20%">Exame (R/S) </td>
	    <td width="20%">Indica&ccedil;&atilde;o de Resultados </td>
	  </tr>
	  <tr>
	    <td style="height: 19px">
            <asp:TextBox ID="TextBox58" runat="server" Width="102px"></asp:TextBox></td>
	    <td style="height: 19px">
            <asp:TextBox ID="TextBox59" runat="server" Width="155px"></asp:TextBox></td>
	    <td style="height: 19px">
            <asp:TextBox ID="TextBox174" runat="server" Width="159px"></asp:TextBox></td>
	    <td style="height: 19px">
            <asp:TextBox ID="TextBox183" runat="server" Width="154px"></asp:TextBox></td>
	    <td style="height: 19px">
            <asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem Value="Alterado"></asp:ListItem>
                <asp:ListItem Value="Est&#225;vel"></asp:ListItem>
                <asp:ListItem Value="Agravamento"></asp:ListItem>
                <asp:ListItem Value="Ocupacional"></asp:ListItem>
                <asp:ListItem Value="N&#227;o Ocupacional"></asp:ListItem>
            </asp:DropDownList></td>
      </tr>
	  <tr>
	    <td style="height: 19px">
            <asp:TextBox ID="TextBox61" runat="server" Width="102px"></asp:TextBox></td>
	    <td style="height: 19px">
            <asp:TextBox ID="TextBox60" runat="server" Width="155px"></asp:TextBox></td>
	    <td style="height: 19px">
            <asp:TextBox ID="TextBox175" runat="server" Width="159px"></asp:TextBox></td>
	    <td style="height: 19px">
            <asp:TextBox ID="TextBox184" runat="server" Width="154px"></asp:TextBox></td>
	    <td style="height: 19px"><asp:DropDownList ID="DropDownList2" runat="server">
            <asp:ListItem Value="Alterado"></asp:ListItem>
            <asp:ListItem Value="Est&#225;vel"></asp:ListItem>
            <asp:ListItem Value="Agravamento"></asp:ListItem>
            <asp:ListItem Value="Ocupacional"></asp:ListItem>
            <asp:ListItem Value="N&#227;o Ocupacional"></asp:ListItem>
        </asp:DropDownList></td>
      </tr>
	  <tr>
	    <td style="height: 24px">
            <asp:TextBox ID="TextBox62" runat="server" Width="102px"></asp:TextBox></td>
	    <td style="height: 24px">
            <asp:TextBox ID="TextBox63" runat="server" Width="155px"></asp:TextBox></td>
	    <td style="height: 24px">
            <asp:TextBox ID="TextBox176" runat="server" Width="159px"></asp:TextBox></td>
	    <td style="height: 24px">
            <asp:TextBox ID="TextBox185" runat="server" Width="154px"></asp:TextBox></td>
	    <td style="height: 24px"><asp:DropDownList ID="DropDownList3" runat="server" >
            <asp:ListItem Value="Alterado"></asp:ListItem>
            <asp:ListItem Value="Est&#225;vel"></asp:ListItem>
            <asp:ListItem Value="Agravamento"></asp:ListItem>
            <asp:ListItem Value="Ocupacional"></asp:ListItem>
            <asp:ListItem Value="N&#227;o Ocupacional"></asp:ListItem>
        </asp:DropDownList></td>
      </tr>
	  <tr>
	    <td>
            <asp:TextBox ID="TextBox65" runat="server" Width="102px"></asp:TextBox></td>
	    <td>
            <asp:TextBox ID="TextBox64" runat="server" Width="155px"></asp:TextBox></td>
	    <td>
            <asp:TextBox ID="TextBox177" runat="server" Width="159px"></asp:TextBox></td>
	    <td>
            <asp:TextBox ID="TextBox186" runat="server" Width="154px"></asp:TextBox></td>
	    <td><asp:DropDownList ID="DropDownList4" runat="server" >
            <asp:ListItem Value="Alterado"></asp:ListItem>
            <asp:ListItem Value="Est&#225;vel"></asp:ListItem>
            <asp:ListItem Value="Agravamento"></asp:ListItem>
            <asp:ListItem Value="Ocupacional"></asp:ListItem>
            <asp:ListItem Value="N&#227;o Ocupacional"></asp:ListItem>
        </asp:DropDownList></td>
      </tr>
    </table>
    </fieldset>
	<fieldset>
	<legend>Responsável Pela Monitoração Biológica</legend>
	<table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
	  <tr>
	    <td width="20%">Per&iacute;odo</td>
	    <td width="20%">NIT</td>
	    <td width="25%">Registro Conselho de Classe </td>
	    <td width="35%">Nome do Preofissional Legalmente Habilitado </td>
	  </tr>
	  <tr>
	    <td>
            <asp:TextBox ID="TextBox66" runat="server" Width="102px"></asp:TextBox></td>
	    <td>
            <asp:TextBox ID="TextBox67" runat="server" Width="155px"></asp:TextBox></td>
	    <td>
            <asp:TextBox ID="TextBox127" runat="server" Width="211px"></asp:TextBox></td>
	    <td>
            <asp:TextBox ID="TextBox178" runat="server" Width="274px"></asp:TextBox></td>
	  </tr>
	  <tr>
	    <td>
            <asp:TextBox ID="TextBox69" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox68" runat="server" Width="155px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox128" runat="server" Width="211px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox179" runat="server" Width="274px"></asp:TextBox></td>
	  </tr>
	  <tr>
	    <td>
            <asp:TextBox ID="TextBox70" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox71" runat="server" Width="155px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox129" runat="server" Width="211px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox180" runat="server" Width="274px"></asp:TextBox></td>
	  </tr>
	  <tr>
	    <td>
            <asp:TextBox ID="TextBox73" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox72" runat="server" Width="155px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox130" runat="server" Width="211px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox181" runat="server" Width="274px"></asp:TextBox></td>
	  </tr>
	  <tr>
	    <td>
            <asp:TextBox ID="TextBox74" runat="server" Width="102px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox75" runat="server" Width="155px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox131" runat="server" Width="211px"></asp:TextBox></td>
        <td>
            <asp:TextBox ID="TextBox182" runat="server" Width="274px"></asp:TextBox></td>
	  </tr>
  </table>
  </fieldset>
  </fieldset>
</fieldset>
</asp:Content>

