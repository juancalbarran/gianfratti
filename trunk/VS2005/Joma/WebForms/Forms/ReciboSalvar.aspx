<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReciboSalvar.aspx.cs" Inherits="Forms_ReciboSalvar" Title="Smart Health Care - Emissão de Recibos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
 <style type="text/css">
<!--
.style1 {font-size: 22px}
-->
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
</style>   
</head>
<body>
    <form id="form1" runat="server">

<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr>
    <td width="14%">&nbsp;</td>
    <td width="71%"><table width="99%"  border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td align="center" class="style1">
        <b>Dr.(a) <asp:Label ID="lblProfissionalNome" runat="server"></asp:Label> - Fisioterapêuta</b>
        <br /><b>
            Crefito: <asp:Label ID="lblProfissionalCrefito" runat="server"></asp:Label>&nbsp;
            CPF: <asp:Label ID="lblProfissionalCPF" runat="server"></asp:Label>&nbsp;</b>
            </td>
      </tr>    
      <tr>
        <td height="100" align="center" class="style1">Recibo n: 
            <asp:Label ID="lblReciboNumero" runat="server" Font-Bold="True" Font-Size="X-Large"></asp:Label></td>
      </tr>
      <tr>
        <td height="80" valign=top align="right">
            <asp:Label ID="lblValorTotalCabecalho" runat="server" Font-Bold="True" Font-Size="X-Large"></asp:Label></td>
      </tr>
      <tr>
        <td><div align="justify" class="style1">Recebemos de <strong>
            <asp:Label ID="lblPacienteNome" runat="server"></asp:Label></strong>, a quantia de <strong>
            <asp:Label ID="lblValorTotal" runat="server"></asp:Label></strong> Correspondente a 
            <asp:Label ID="lblSessoesQtd" runat="server" Font-Bold="True"></asp:Label>
            sess&otilde;es de fisioterapia nas seguintes datas:
            <asp:Label ID="lblDatas" runat="server" Font-Bold="True"></asp:Label>, no valor de 
            <asp:Label ID="lblValorSessao" runat="server" Font-Bold="True"></asp:Label>
            cada, e para clareza firmo (amos) o presente Recibo.</div></td>
      </tr>
      <tr>
        <td height="250">Santo Andre, 
            <asp:Label ID="lblDataExtenso" runat="server"></asp:Label></td>
      </tr>
      <tr>
        <td height="30" align="right" valign="bottom">_________________________________________</td>
      </tr>
      <tr>
        <td height="100" align="right" valign="bottom"><input type="button" value="Imprimir Recibo" onclick="window.print();" /> </td>
      </tr>
    </table></td>
    <td width="15%">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3">&nbsp;</td>
  </tr>
</table>

    </form>
</body>
</html>
