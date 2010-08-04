<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="PosOperatorio.aspx.cs" Inherits="FormPósOperatório_PosOperatorio" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
		<fieldset>
		    <legend align="center">Pós Operatório</legend>
			<fieldset>
			<table width="100%" border="1" cellpadding="0" cellspacing="0" class="texto">
			  <tr bgcolor="#F3F7FC">
				<td width="21%"><strong>Data:</strong></td>
			    <td width="10%"><strong>01/10/2007</strong></td>
			    <td width="10%"><strong>02/10/2007</strong></td>
			    <td width="10%"><strong>03/10/2007</strong></td>
			    <td width="10%"><strong>04/10/2007</strong></td>
			    <td width="10%"><strong>05/10/2007</strong></td>
			    <td width="10%"><strong>06/10/2007</strong></td>
			    <td width="19%"><strong>&quot;Data atual&quot; </strong>
                </td>
			  </tr>
			  <tr>
			    <td style="width: 194px"><strong>Dia de P.O.:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>
                    <input id="Text2" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
			    <td style="width: 194px"><strong>Problemas:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td><td>
                    <asp:RadioButton GroupName="Problemas" ID="Não" runat="server" Text="Não" />&nbsp;
                    <asp:RadioButton GroupName="Problemas" ID="Sim" runat="server" Text="Sim" /></td>
			  </tr>
			  <tr>
			    <td style="width: 194px"><strong>Press&atilde;o Arterial (PA):</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text3" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
			    <td style="width: 194px"><strong>Frequencia Card&iacute;aca (FC):</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text4" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr>
			    <td style="width: 194px"><strong>Peso:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text5" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
			    <td style="width: 194px"><strong>Temperatura:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text6" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr>
			    <td style="width: 194px"><strong>Diurese:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text7" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
			    <td style="width: 194px"><strong>Ultrasson:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text8" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr>
			    <td style="width: 194px"><strong>CSA:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text9" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
			    <td style="width: 194px"><strong>PRED:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text10" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr>
			    <td style="width: 194px"><strong>AZAT:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text11" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
			    <td style="width: 194px"><strong>Creatina:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text12" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr>
			    <td style="width: 194px"><strong>Ur&eacute;ia:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text13" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
			    <td style="width: 194px"><strong>N&iacute;vel Cya:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text14" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr>
			    <td style="width: 194px"><strong>S&oacute;dio:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text15" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
			    <td style="width: 194px"><strong>Pot&aacute;ssio:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text16" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr>
			    <td style="width: 194px"><strong>Hb:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text17" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
			    <td style="width: 194px"><strong>Htc:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text18" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr>
			    <td style="width: 194px"><strong>Gl&oacute;bulos Brancos:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text19" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
		    	<td style="width: 194px"><strong>Plaquetas:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text20" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr>
			    <td style="width: 194px"><strong>Diferencial:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text22" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
			    <td style="width: 194px"><strong>Protein&uacute;ria:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text21" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr>
			    <td style="width: 194px"><strong>Leu:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text23" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
			    <td style="width: 194px"><strong>Hem:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text24" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr>
			    <td style="width: 194px"><strong>Sorolog:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text25" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
				<td style="width: 194px"><strong>Fan:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text26" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr>
			    <td style="width: 194px"><strong>CH50:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text27" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
			    <td style="width: 194px"><strong>Glicemia:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text28" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr>
			    <td style="width: 194px"><strong>TGO:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text29" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
			    <td style="width: 194px"><strong>TGP:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text30" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr>
			    <td style="width: 194px;"><strong>Ca:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text31" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
			    <td style="width: 194px"><strong>P:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text32" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr>
				<td style="width: 194px"><strong>PTH-FA:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text33" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
			    <td style="width: 194px"><strong>Arteriografia:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text34" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr>
			    <td style="width: 194px"><strong>Tomografia:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text35" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
			    <td style="width: 194px"><strong>Biopsia:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text36" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr>
			    <td style="width: 194px"><strong>Relat&oacute;rio de Exames:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text37" style="width: 185px" type="text" /></td>
			  </tr>
			  <tr bgcolor="#F3F7FC">
			    <td style="width: 194px"><strong>Resumos:</strong></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			    <td><input id="Text38" style="width: 185px" type="text" /></td>
			  </tr>
			</table>
			</fieldset>
			<fieldset>
		   <table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center"><asp:Button ID="Button1" runat="server" Text="Salvar" OnClick="Button1_Click" /></td>
        </tr>
      </table>
		</fieldset>
		</fieldset>
</asp:Content>

