<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="ProfissionaisPrincipal.aspx.cs" Inherits="Profissionais_ProfissionaisPrincipal" Title="SmartCare - Hospital do Rim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <fieldset>
    <legend align="center">Gerenciador de Profissionais</legend>
    <fieldset>
      <legend align="left">&nbsp;Busca&nbsp;</legend>
      <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="20%" style="font-weight: bold;">Nome</td>
          <td width="20%" style="font-weight: bold;">Equipe</td>
          <td width="20%" style="font-weight: bold;">Número Conselho</td>
          <td width="20%" style="font-weight: bold;">Especialidade</td>
          <td width="20%" style="font-weight: bold;"></td>
        </tr>
        <tr>
          <td><input id="Nome" name="Nome" style="width: 146px" /></td>
          <td><input id="Equipe" name="Equipe" style="width: 145px" /></td>
          <td><input id="NumeroConselho" name="NumeroConselho" style="width: 147px" /></td>
          <td><input id="Especialidade" name="Especialidade" style="width: 147px" /></td>
          <td><input id="ctl00_ContentPlaceHolder1_Button1" type="submit" value="Buscar" name="ctl00$ContentPlaceHolder1$Button1" /></td>
        </tr>
      </table>
    </fieldset>
    <fieldset>
      <legend align="left">Profissionais</legend>
      <table class="texto" width="100%" border="1" cellpadding="0" cellspacing="0" rules="all" id="ctl00_ContentPlaceHolder1_GridView1">
        <tr bgcolor="#F3F7FC">
            <td width="35%" style="font-weight: bold; color: black;">Nome:</td>
            <td width="20%" style="font-weight: bold; color: black;">Equipe:</td>
            <td width="15%" style="font-weight: bold; color: black;">Número Conselho:</td>
            <td width="30%" style="font-weight: bold; color: black;">Especialidade:</td>
	    </tr>
        <tr>
          <td>
              NANANANANANANANANANA</td>
          <td>
              NANANANANANA</td>
          <td>
              NANANANA</td>
          <td>
              NANANANANANA</td>
        </tr>        
        <tr>
          <td>
              NANANANANANANANANANA</td>
          <td>
              NANANANANANA</td>
          <td>
              NANANANA</td>
          <td>
              NANANANANANA</td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td>&nbsp;</td>
        </tr>

      </table>
    </fieldset>
	  <br />
	  <fieldset>
		<table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
		  <tr>
		    <td align="center" style="height: 24px">
                <asp:Button ID="Button1" runat="server" PostBackUrl="~/Profissionais/CadastroProfissionais.aspx" Text="Cadastrar" /></td>
          </tr>
       </table>
	  </fieldset>
    </fieldset>
</asp:Content>

