<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="UsuariosPrincipal.aspx.cs" Inherits="Usuarios_UsuariosPrincipal" Title="SmartCare - Hospital do Rim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <fieldset>
    <legend align="center">Gerenciador de Uuários</legend>
    <fieldset>
      <legend align="left">&nbsp;Busca&nbsp;</legend>
      <table class="texto" width="535" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="300" style="font-weight: bold;">Nome</td>
          <td width="155" style="font-weight: bold;">Perfil</td>
          <td width="80" style="font-weight: bold;"> </td>
        </tr>
        <tr>
          <td >
              <input id="Text1" style="width: 290px" type="text" /></td>
          <td >
              <input id="Text2" style="width: 147px" type="text" /></td>
          <td><asp:Button ID="Button2" runat="server" Text="Buscar" /></td>
        </tr>
      </table>
    </fieldset>
    <fieldset>
      <legend align="left">Usuários</legend>
      <table class="texto" width="100%" border="1" cellpadding="0" cellspacing="0" rules="all" id="ctl00_ContentPlaceHolder1_GridView1">
        <tr bgcolor="#F3F7FC">
          <td style="color: black; font-weight: bold; width: 314px;">Nome:</td>
          <td style="color: black; font-weight: bold; width: 294px;">Perfil:</td>
          <td style="color: black; font-weight: bold; width: 193px;">Status:</td>
	    </tr>
        <tr>
          <td style="width: 314px">
              NANANANANANANANANANANANANANANA</td>
          <td style="width: 294px">
              NANANANANANANANANANA</td>
          <td style="width: 193px">
              NANANANANANANA</td>
        </tr>        <tr>
          <td style="width: 314px; height: 21px">
              NANANANANANANANANANANANA</td>
          <td style="width: 294px; height: 21px">
              NANANANANANA</td>
          <td style="width: 193px; height: 21px">
              NANANANANANA</td>
        </tr>
        <tr>
          <td style="width: 314px">&nbsp;</td>
          <td style="width: 294px">&nbsp;</td>
          <td style="width: 193px">&nbsp;</td>
        </tr>
        <tr>
          <td style="width: 314px">&nbsp;</td>
          <td style="width: 294px">&nbsp;</td>
          <td style="width: 193px">&nbsp;</td>
        </tr>
        <tr>
          <td style="width: 314px">&nbsp;</td>
          <td style="width: 294px">&nbsp;</td>
          <td style="width: 193px">&nbsp;</td>
        </tr>
        <tr>
          <td style="width: 314px">&nbsp;</td>
          <td style="width: 294px">&nbsp;</td>
          <td style="width: 193px">&nbsp;</td>
        </tr>
        <tr>
          <td style="width: 314px">&nbsp;</td>
          <td style="width: 294px">&nbsp;</td>
          <td style="width: 193px">&nbsp;</td>
        </tr>
        <tr>
          <td style="width: 314px">&nbsp;</td>
          <td style="width: 294px">&nbsp;</td>
          <td style="width: 193px">&nbsp;</td>
        </tr>
        <tr>
          <td style="width: 314px">&nbsp;</td>
          <td style="width: 294px">&nbsp;</td>
          <td style="width: 193px">&nbsp;</td>
        </tr>

      </table>
    </fieldset>
	  <br />
	  <fieldset>
		<table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
		  <tr>
		    <td align="center" style="height: 24px">
                <asp:Button ID="Button1" runat="server" PostBackUrl="~/Usuarios/CadastroUsuarios.aspx" Text="Cadastrar" /></td>
          </tr>
       </table>
	  </fieldset>
    </fieldset>
</asp:Content>

