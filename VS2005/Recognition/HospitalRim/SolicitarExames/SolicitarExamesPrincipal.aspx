<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="SolicitarExamesPrincipal.aspx.cs" Inherits="SolicitarExames_SolicitarExamesPrincipal" Title="SmartCare - Hospital do Rim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <fieldset>
    <legend align="center">Gerenciador de Solicitação de Exames</legend>
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
      <table class="texto" width="100%" border="1" cellpadding="0" cellspacing="0" rules="all" id="Table1">
        <tr bgcolor="#F3F7FC">
            <td style="font-weight: bold; color: black; width: 380px;">Nome:</td>
            <td style="font-weight: bold; color: black; width: 226px;">Registro Geral</td>
            <td style="font-weight: bold; color: black; width: 186px;">Tipo de Atendimento</td>
            <td style="font-weight: bold; color: black; width: 115px;">Data</td>
            <td style="width: 14px">
                &nbsp;</td>
	    </tr>        
	    <tr>
          <td style="width: 380px">
              Maria da Silva</td>
          <td style="width: 226px">
              111 111</td>
          <td style="width: 186px">
              Particular</td>
          <td style="width: 115px">
              20/11/2007</td>
          <td style="width: 14px"><a href="SolicitarExamesPreenchido.aspx"><asp:Image  ID="Image1" runat="server" ImageUrl="~/Template/Img/alterar.gif" /></a></td>
        </tr>        
        <tr>
          <td style="width: 380px">
              Jose da Silva Filho</td>
          <td style="width: 226px">
              111 222</td>
          <td style="width: 186px">
              SUS</td>
          <td style="width: 115px">
              22/11/2007</td>
          <td style="width: 14px"><a href="SolicitarExamesPreenchido2.aspx"><asp:Image  ID="Image2" runat="server" ImageUrl="~/Template/Img/alterar.gif" /></a></td>
        </tr>
        <tr>
          <td style="width: 380px"></td>
          <td style="width: 226px"></td>
          <td style="width: 186px"></td>
          <td style="width: 115px"></td>
          <td style="width: 14px">
              </td>
        </tr>
        <tr>
          <td style="width: 380px"></td>
          <td style="width: 226px"></td>
          <td style="width: 186px"></td>
          <td style="width: 115px"></td>
          <td style="width: 14px">
              </td>
        </tr>
        <tr>
          <td style="width: 380px"></td>
          <td style="width: 226px"></td>
          <td style="width: 186px"></td>
          <td style="width: 115px"></td>
          <td style="width: 14px">
              </td>
        </tr>
        <tr>
          <td style="width: 380px"></td>
          <td style="width: 226px"></td>
          <td style="width: 186px"></td>
          <td style="width: 115px"></td>
          <td style="width: 14px">
              </td>
        </tr>
        <tr>
          <td style="width: 380px"></td>
          <td style="width: 226px"></td>
          <td style="width: 186px"></td>
          <td style="width: 115px"></td>
          <td style="width: 14px">
              </td>
        </tr>
        <tr>
          <td style="width: 380px"></td>
          <td style="width: 226px"></td>
          <td style="width: 186px"></td>
          <td style="width: 115px"></td>
          <td style="width: 14px">
              </td>
        </tr>
        <tr>
          <td style="width: 380px"></td>
          <td style="width: 226px"></td>
          <td style="width: 186px"></td>
          <td style="width: 115px"></td>
          <td style="width: 14px">
              </td>
        </tr>
      </table>
    </fieldset>
	  <fieldset>
		<table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
		  <tr>
		    <td align="center" style="height: 24px"><asp:Button ID="Button1" runat="server" PostBackUrl="~/SolicitarExames/SolicitarExames.aspx" Text="Cadastrar" /></td>
          </tr>
       </table>
	  </fieldset>
    </fieldset>
</asp:Content>

