<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="CadastroProtocolo.aspx.cs" Inherits="Protocolos_CadastroProtocolo" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<fieldset>
		<legend align="center">Protocolos</legend>
			<fieldset>
				<legend>Cadastro de Protocolo</legend>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="texto">
 					<tr>
		  				<td style="height: 19px">Nome do Protocolo:</td>
					</tr>
				 	<tr>
					    <td>&nbsp;<input id="Text1" style="width: 479px" type="text" /></td>
				    </tr>
					<tr>
					    <td>
                            Descrição:</td>
				    </tr>
					<tr>
					  <td>&nbsp;<textarea id="TextArea1" style="width: 99%; height: 550px"></textarea></td>
				  </tr>
				</table>
			</fieldset>
	</fieldset>
</asp:Content>

