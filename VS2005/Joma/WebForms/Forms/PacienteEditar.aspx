<%@ Page Language="C#" MasterPageFile="~/Template/Template01.master" AutoEventWireup="true" CodeFile="PacienteEditar.aspx.cs" Inherits="Forms_PacienteEditar" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="selector">
<center>
<table width="630" height="485">
<tr>
  <td width="80" valign=top><font size="2" FACE="Verdana" color="#000000">Nome:</font></td>
  <td width="242">
      <asp:TextBox ID="txtNome" runat="server"></asp:TextBox></td>
  <td width="66" valign="top"><p align="center"><font size="2" FACE="Verdana" color="#000000">Sexo:</font> </p></td>
  <td width="222" align="center" valign="middle">&nbsp;</td>
</tr>
<tr>
  <td valign=top><font color="#000000" size="2" face="Verdana">RG:</font></td>
  <td>
      <asp:TextBox ID="txtRG" runat="server"></asp:TextBox></td>
  <td valign="top"><div align="center"><span class="style6"><font color="#000000" face="Verdana">Nasc.:</font></span></div></td>
  <td align="left" valign="top"><label>
    
      <div align="center">
          &nbsp;</div>
  </label></td>
</tr>
<tr>
  <td valign=top><font color="#000000" size="2" face="Verdana">CPF:</font></td>
  <td colspan="2"></td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td valign=top><font size="2" FACE="Verdana" color="#000000">Endere&ccedil;o:</font></td>
  <td colspan="3">
      &nbsp;<span class="style1"></span></td>
  </tr>
<tr>
  <td valign=top><font size="2" FACE="Verdana" color="#000000">Bairro:</font></td>
  <td></td>
  <td><p align="center"><font color="#000000" size="2" face="Verdana">CEP:</font></p></td>
  <td></td>
</tr>
<tr>
  <td valign=top><font size="2" FACE="Verdana" color="#000000">Cidade:</font></td>
  <td></td>
  <td><p align="center"><font size="2" FACE="Verdana" color="#000000">UF:</font></p></td>
  <td></td>
</tr>
<tr>
  <td valign=top>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td valign=top><font size="2" FACE="Verdana" color="#000000">Telefone:</font></td>
  <td></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td></tr>
<tr>
  <td valign=top><font color="#000000" size="2" face="Verdana">Celular:</font></td>
  <td></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td valign=top><font color="#000000" size="2" face="Verdana">Email:</font></td>
  <td></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td valign=middle><p><font color="#000000" size="2" face="Verdana">Numero Convenio:</font></p></td>
  <td></td>
  <td><font color="#000000" size="2" face="Verdana">Particular?</font></td>
  <td><table width="200">
    <tr>
      <td><label>
          &nbsp;<font color="#000000" size="2" face="Verdana">Sim</font></label></td>
    </tr>
    <tr>
      <td><label>
          &nbsp;<font color="#000000" size="2" face="Verdana">N&atilde;o</font></label></td>
    </tr>
  </table>  </td></tr>
<tr><td align=left valign="middle"><p><font color="#000000" size="2" face="Verdana">Observa&ccedil;&atilde;o:</font></p></td>
  <td colspan="3"><label>
      &nbsp;</label></td>
  </tr>
<tr><td></td>
  <td valign="top"><div align="right"></div>
  <label></label></td>
  <td valign="top">&nbsp;</td>
  <td valign="top"><div align="right">
      &nbsp;
  </div></td></tr>
</table>
</center>
</div>

</asp:Content>

