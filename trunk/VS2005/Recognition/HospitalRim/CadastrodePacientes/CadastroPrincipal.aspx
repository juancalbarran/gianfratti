<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="CadastroPrincipal.aspx.cs" Inherits="FormPrincipal" Title="SmartCare - Hospital do Rim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script language="javascript" type="text/javascript">
// <!CDATA[

function ctl00_ContentPlaceHolder1_GridView1_onclick() {

}

// ]]>
</script>

  <fieldset>
    <legend align="center">Gerenciador de Pacientes</legend>
    <fieldset>
      <legend align="left">&nbsp;Busca&nbsp;</legend>
      <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td style="font-weight: bold; width: 195px;">Nome</td>
          <td style="font-weight: bold; width: 142px;">Registro Geral</td>
          <td style="font-weight: bold; width: 141px;">CPF</td>
          <td style="font-weight: bold; width: 148px;">Tipo de Atendimento</td>
          <td style="font-weight: bold; width: 119px;">Data Entrada </td>
          <td style="font-weight: bold; width: 10px;"></td>
          <td width="75" style="font-weight: bold;"></td>
        </tr>
        <tr>
          <td style="width: 195px">
              <input id="Text1" style="width: 191px" type="text" /></td>
          <td style="width: 142px">
              <input id="Text2" style="width: 138px" type="text" /></td>
          <td style="width: 141px">
              <input id="Text3" style="width: 140px" type="text" /></td>
          <td style="width: 148px">
              <input id="Text4" style="width: 145px" type="text" /></td>
          <td style="width: 119px">
              <input id="Text5" style="width: 118px" type="text" /></td>
          <td style="width: 10px"></td>
          <td><input id="Buscar" type="submit" value="Buscar" name="ButtonBuscar" /></td>
        </tr>
    </table>
  </fieldset>
      <fieldset>
        <legend align="left">Pacientes</legend>
        <table class="texto" width="100%" border="1" cellpadding="0" cellspacing="0" rules="all" id="ctl00_ContentPlaceHolder1_GridView1" onclick="return ctl00_ContentPlaceHolder1_GridView1_onclick()">
          <tr bgcolor="#F3F7FC">
              <td style="font-weight: bold; color: black; width: 208px;">Nome:</td>
              <td style="font-weight: bold; color: black; width: 147px;">CPF:</td>
              <td style="font-weight: bold; color: black; width: 112px;">Conv&ecirc;nio:</td>
              <td style="font-weight: bold; color: black; width: 118px;">Data de Entrada:</td>
              <td style="width: 12px">
                  &nbsp;</td>
		  </tr>
          <tr>
            <td style="width: 208px">
                Maria da Silva</td>
            <td style="width: 147px">
                123.456.789-00</td>
            <td style="width: 112px">
                &nbsp;</td>
            <td style="width: 118px">
                20/11/2007</td>
            <td style="width: 12px"><a href="CadastrodePacientesPreenchido.aspx"><asp:Image  ID="Image1" runat="server" ImageUrl="~/Template/Img/alterar.gif" /></a></td>
          </tr>          
          <tr>
            <td style="width: 208px">
                Jose da Silva Filho</td>
            <td style="width: 147px">
                123.456.789-00</td>
            <td style="width: 112px">
                SUS</td>
            <td style="width: 118px">
                22/11/2007</td>
            <td style="width: 12px"><a href="CadastrodePacientesPreenchido2.aspx"><asp:Image  ID="Image2" runat="server" ImageUrl="~/Template/Img/alterar.gif" /></a></td>
          </tr>          
          <tr>
            <td style="width: 208px; height: 21px;"></td>
            <td style="width: 147px; height: 21px;"></td>
            <td style="width: 112px; height: 21px;"></td>
            <td style="height: 21px; width: 118px;"></td>
            <td style="width: 12px; height: 21px">
                </td>
          </tr>          
          <tr>
            <td style="width: 208px"></td>
            <td style="width: 147px"></td>
            <td style="width: 112px"></td>
            <td style="width: 118px"></td>
            <td style="width: 12px">
                </td>
          </tr>          
          <tr>
            <td style="width: 208px"></td>
            <td style="width: 147px"></td>
            <td style="width: 112px"></td>
            <td style="width: 118px"></td>
            <td style="width: 12px">
                </td>
          </tr>          
          <tr>
            <td style="width: 208px"></td>
            <td style="width: 147px"></td>
            <td style="width: 112px"></td>
            <td style="width: 118px"></td>
            <td style="width: 12px">
                </td>
          </tr>          
          <tr>
            <td style="width: 208px"></td>
            <td style="width: 147px"></td>
            <td style="width: 112px"></td>
            <td style="width: 118px"></td>
            <td style="width: 12px">
                </td>
          </tr>          
          <tr>
            <td style="width: 208px"></td>
            <td style="width: 147px"></td>
            <td style="width: 112px"></td>
            <td style="width: 118px"></td>
            <td style="width: 12px">
                </td>
          </tr>          
          <tr>
            <td style="width: 208px"></td>
            <td style="width: 147px"></td>
            <td style="width: 112px"></td>
            <td style="width: 118px"></td>
            <td style="width: 12px">
                </td>
          </tr>
      </table>
    </fieldset>
	  <br />
	  <fieldset>
		<table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
		  <tr>
		    <td align="center" style="height: 24px">
                <asp:Button ID="Button1" runat="server" PostBackUrl="~/CadastrodePacientes/FormCadastrodePacientes.aspx" Text="Cadastrar" /></td>
          </tr>
       </table>
	  </fieldset>
    </fieldset>
</asp:Content>

