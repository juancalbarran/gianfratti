<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="AtestadodeAltaPrincipal.aspx.cs" Inherits="AtestadoAlta_AtestadodeAltaPrincipal" Title="SmartCare - Hospital do Rim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <fieldset>
    <legend align="center">Gerenciador de Atestados de Alta</legend>
    <fieldset>
      <legend align="left">&nbsp;Busca&nbsp;</legend>
      <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td style="font-weight: bold; width: 250px;">Nome</td>
          <td style="font-weight: bold; width: 183px;">
              Registro Geral</td>
          <td style="font-weight: bold; width: 161px;">Data Entrada </td>
          <td style="font-weight: bold; width: 140px;">
              Data de Alta</td>
          <td width="63" style="font-weight: bold;"></td>
        </tr>
        <tr>
          <td style="width: 250px">
              <input id="Text1" style="width: 240px" type="text" /></td>
          <td style="width: 183px">
              <input id="Text2" style="width: 176px" type="text" /></td>
          <td style="width: 161px">
              <input id="Text3" style="width: 151px" type="text" /></td>
          <td style="width: 140px">
              <input id="Text4" style="width: 133px" type="text" /></td>
          <td><input id="ctl00_ContentPlaceHolder1_Button1" type="submit" value="Buscar" name="ctl00$ContentPlaceHolder1$Button1" /></td>
        </tr>
      </table>
    </fieldset>
    <fieldset>
      <legend align="left">Pacientes</legend>
      <table class="texto" width="100%" border="1" cellpadding="0" cellspacing="0" rules="all" id="ctl00_ContentPlaceHolder1_GridView1">
        <tr bgcolor="#F3F7FC">
            <td style="font-weight: bold; color: black; width: 221px;">Nome:</td>
            <td style="font-weight: bold; color: black; width: 112px;">
                Registro Geral:</td>
            <td style="font-weight: bold; color: black; width: 185px;">M&eacute;dico:</td>
            <td style="font-weight: bold; color: black; width: 146px;">
                Tipo de Atendimento:</td>
            <td style="font-weight: bold; color: black; width: 125px;">Data de Entrada:</td>
            <td style="font-weight: bold; color: black; width: 180px;">Data de Alta:</td>
            <td style="width: 10px">
                &nbsp;</td>
	    </tr>
        <tr>
          <td style="width: 221px">
              Jose da Silva Filho</td>
          <td style="width: 112px">
              111 222</td>
          <td style="width: 185px">
              &nbsp;</td>
          <td style="width: 146px">
              SUS</td>
          <td style="width: 125px">
              20/11/2007</td>
          <td style="width: 180px">
              29/11/2007</td>
          <td style="width: 10px"><a href="AtestadoAltaPreenchido.aspx"><asp:Image  ID="Image1" runat="server" ImageUrl="~/Template/Img/alterar.gif" /></a></td>
        </tr>        
        <tr>
          <td style="width: 221px">
              Maria da Silva</td>
          <td style="width: 112px">
              111 111</td>
          <td style="width: 185px">
              &nbsp;</td>
          <td style="width: 146px">
              Particular</td>
          <td style="width: 125px">
              22/11/2007</td>
          <td style="width: 180px">
              29/11/2007</td>
          <td style="width: 10px"><a href="AtestadoAltaPreenchido2.aspx"><asp:Image  ID="Image2" runat="server" ImageUrl="~/Template/Img/alterar.gif" /></a>
              </td>
        </tr>
        <tr>
          <td style="width: 221px"></td>
          <td style="width: 112px"></td>
          <td style="width: 185px"></td>
          <td style="width: 146px"></td>
          <td style="width: 125px"></td>
          <td style="width: 180px"></td>
          <td style="width: 10px">
              </td>
        </tr>
        <tr>
          <td style="width: 221px"></td>
          <td style="width: 112px"></td>
          <td style="width: 185px"></td>
          <td style="width: 146px"></td>
          <td style="width: 125px"></td>
          <td style="width: 180px"></td>
          <td style="width: 10px">
              </td>
        </tr>
        <tr>
          <td style="width: 221px"></td>
          <td style="width: 112px"></td>
          <td style="width: 185px"></td>
          <td style="width: 146px"></td>
          <td style="width: 125px"></td>
          <td style="width: 180px"></td>
          <td style="width: 10px">
              </td>
        </tr>
        <tr>
          <td style="width: 221px"></td>
          <td style="width: 112px"></td>
          <td style="width: 185px"></td>
          <td style="width: 146px"></td>
          <td style="width: 125px"></td>
          <td style="width: 180px"></td>
          <td style="width: 10px">
              </td>
        </tr>
        <tr>
          <td style="width: 221px"></td>
          <td style="width: 112px"></td>
          <td style="width: 185px"></td>
          <td style="width: 146px"></td>
          <td style="width: 125px"></td>
          <td style="width: 180px"></td>
          <td style="width: 10px">
              </td>
        </tr>
        <tr>
          <td style="width: 221px"></td>
          <td style="width: 112px"></td>
          <td style="width: 185px"></td>
          <td style="width: 146px"></td>
          <td style="width: 125px"></td>
          <td style="width: 180px"></td>
          <td style="width: 10px">
              </td>
        </tr>
        <tr>
          <td style="width: 221px"></td>
          <td style="width: 112px"></td>
          <td style="width: 185px"></td>
          <td style="width: 146px"></td>
          <td style="width: 125px"></td>
          <td style="width: 180px"></td>
          <td style="width: 10px">
              </td>
        </tr>

      </table>
    </fieldset>
	  <br />
	  <fieldset>
		<table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
		  <tr>
		    <td align="center" style="height: 24px"><asp:Button ID="Button1" runat="server" PostBackUrl="~/AtestadoAlta/FormAtestadodeAlta.aspx" Text="Cadastrar" /></td>
          </tr>
       </table>
	  </fieldset>
    </fieldset>
</asp:Content>

