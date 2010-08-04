<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="PosOperatorioPrincipal.aspx.cs" Inherits="FormPósOperatório_PosOperatorioPrincipal" Title="SmartCare - Hospital do Rim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <fieldset>
    <legend align="center">Gerenciador</legend>
    <fieldset>
      <legend align="left">&nbsp;Busca&nbsp;</legend>
      <table class="texto" width="535" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="154" style="font-weight: bold;">Nome</td>
          <td width="152" style="font-weight: bold;">
              Registro Geral</td>
          <td style="font-weight: bold; width: 150px;">Data</td>
          <td style="font-weight: bold; width: 8px;"></td>
          <td style="font-weight: bold; width: 63px;"></td>
        </tr>
        <tr>
          <td>
              <input id="Text1" style="width: 142px" type="text" /></td>
          <td>
              <input id="Text2" style="width: 141px" type="text" /></td>
          <td style="width: 150px">
              <input id="Text3" style="width: 140px" type="text" /></td>
          <td style="width: 8px"></td>
          <td style="width: 63px">
              <asp:Button ID="Button2" runat="server" Text="Buscar" /></td>
        </tr>
      </table>
    </fieldset>
    <fieldset>
      <legend align="left">Pacientes</legend>
      <table class="texto" width="100%" border="1" cellpadding="0" cellspacing="0" rules="all" id="ctl00_ContentPlaceHolder1_GridView1">
        <tr bgcolor="#F3F7FC">
            <td style="font-weight: bold; color: black; width: 443px;">Nome:</td>
            <td style="font-weight: bold; color: black; width: 141px;">Registro Geral</td>
            <td style="font-weight: bold; color: black; width: 192px;">Tipo de Atendimento</td>
            <td style="font-weight: bold; color: black">Data</td>
            <td style="width: 17px"></td>
	    </tr>        
	    <tr>
          <td>
              Jose da Silva Filho</td>
          <td>
              111 222</td>
          <td>
              SUS</td>
          <td>
              22/11/2007</td>
          <td style="width: 17px"><a href="../FormPosOperatorio/FormPosOperatorioPreenchido.aspx"><asp:Image  ID="Image1" runat="server" ImageUrl="~/Template/Img/alterar.gif" /></a></td>
        </tr>
        <tr>
          <td>
              Maria da Silva</td>
          <td>
              111 111</td>
          <td>
              Particular</td>
          <td>
              20/11/2007</td>
          <td style="width: 17px"><a href="../FormPosOperatorio/FormPosOperatorioPreenchido2.aspx"><asp:Image  ID="Image2" runat="server" ImageUrl="~/Template/Img/alterar.gif" /></a></td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td style="width: 17px"></td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td style="width: 17px"></td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td style="width: 17px"></td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td style="width: 17px"></td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td style="width: 17px"></td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td style="width: 17px"></td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td style="width: 17px"></td>
        </tr>
      </table>
    </fieldset>
	  <br />
	  <fieldset>
		<table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
		  <tr>
		    <td align="center" style="height: 24px">
                <asp:Button ID="Button1" runat="server" PostBackUrl="~/FormPosOperatorio/PosOperatorio.aspx" Text="Cadastrar" /></td>
          </tr>
       </table>
	  </fieldset>
    </fieldset>

</asp:Content>

