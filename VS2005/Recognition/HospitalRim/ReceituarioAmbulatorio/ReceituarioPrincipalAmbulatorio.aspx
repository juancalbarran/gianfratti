<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="ReceituarioPrincipalAmbulatorio.aspx.cs" Inherits="ReceituarioAmbulatorio_ReceituarioPrincipalAmbulatorio" Title="SmartCare - Hospital do Rim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <fieldset>
    <legend align="center">Receituário</legend>
    <fieldset>
      <legend align="left">&nbsp;Busca&nbsp;</legend>
      <table class="texto" width="535" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="154" style="font-weight: bold;">Nome</td>
          <td width="152" style="font-weight: bold;">Conv&ecirc;nio</td>
          <td width="153" style="font-weight: bold;">Data Entrada </td>
          <td width="13" style="font-weight: bold;"></td>
          <td width="63" style="font-weight: bold;"></td>
        </tr>
        <tr>
          <td><input id="ctl00_ContentPlaceHolder1_TxtCNPJ" name="ctl00$ContentPlaceHolder1$TxtCNPJ" /></td>
          <td><input id="ctl00_ContentPlaceHolder1_TxtRazaoSocial" name="ctl00$ContentPlaceHolder1$TxtRazaoSocial" /></td>
          <td><input id="ctl00_ContentPlaceHolder1_TxtContato" name="ctl00$ContentPlaceHolder1$TxtContato" /></td>
          <td></td>
          <td><input id="ctl00_ContentPlaceHolder1_Button1" type="submit" value="Buscar" name="ctl00$ContentPlaceHolder1$Button1" /></td>
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
            <td style="width: 16px">
                &nbsp;</td>
	    </tr>        
	    <tr>
          <td>
              NANANANANANANANANANANANA</td>
          <td>
              NANANANA</td>
          <td>
              NANANANANANA</td>
          <td>
              NANANANA</td>
          <td style="width: 16px"><a href="ReceituarioAmbulatorioPreenchido.aspx"><asp:Image  ID="Image1" runat="server" ImageUrl="~/Template/Img/alterar.gif" /></td>
        </tr>        
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td style="width: 16px">
              &nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td style="width: 16px">
              &nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td style="width: 16px">
              &nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td style="width: 16px">
              &nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td style="width: 16px">
              &nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td style="width: 16px">
              &nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td style="width: 16px">
              &nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td style="width: 16px">
              &nbsp;</td>
        </tr>
      </table>
    </fieldset>
	  <br />
	  <fieldset>
		<table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
		  <tr>
		    <td align="center" style="height: 24px"><asp:Button ID="Button1" runat="server" PostBackUrl="~/ReceituarioAmbulatorio/ReceituarioAmbulatorio.aspx" Text="Cadastrar" /></td>
          </tr>
       </table>
	  </fieldset>
    </fieldset>
</asp:Content>

