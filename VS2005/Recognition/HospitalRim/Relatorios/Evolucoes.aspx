<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="Evolucoes.aspx.cs" Inherits="Relatorios_Evolucoes" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script language="Javascript"> 

function mostrar(nomeCamada){ 

document.getElementById(nomeCamada).style.visibility="visible"; 

} 

function ocultar(nomeCamada){ 

document.getElementById(nomeCamada).style.visibility="hidden"; 

} 

//************************************************************
//FUNÇÃO QUE ABRE UMA POPUP DO LINK DA PAGINA QUE É PASSADO JUNTO COM A lARGURA E ALTURA DA POPUP
//PARA USAR COMO UM LINK BASTA USAR O SEGUINTE EXEMPLO ABAIXO:
//<a href="javascript:AbrePopUp('/SmartCare/Teste2.asp?Busca=seila','570','500',this,event)"><img src="\SmartCare\images\pesquisa.gif" border="0" WIDTH="15" HEIGHT="13"></a>
//************************************************************
function AbrePopUp(Link_Pagina,Largura,Altura) 
	{
	   window.open(Link_Pagina,'','width='+Largura+',height='+Altura+',scrollbars=yes,top=0,left=0,screenX=800,screenY=600,status=yes')
	}
</script> 

<fieldset>
	<legend align="center">Internações</legend>
	        <fieldset>
        <legend>Dados Paciente</legend>
  <table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr onclick="mostrar('camada1')">
            <td width="30%">Nome do Paciente </td>
            <td width="25%">Registro Geral </td>
            <td width="15%">Quarto/Leito</td>
            <td width="25%">Data</td>
          </tr>
          <tr>
            <td>
                NANANANANANANA</td>
            <td>
                NANANANA</td>
            <td>
                NANANA</td>
            <td>
                NANANA</td>
          </tr>
        </table>
        <table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="30%">N&ordm; Atendimento </td>
            <td width="25%">Cor</td>
            <td width="15%">Idade</td>
            <td width="25%">Sexo</td>
          </tr>
          <tr>
            <td>
                NANANANANANANA</td>
            <td>
                NANANANA</td>
            <td>
                NANANA</td>
            <td>
                NANANA</td>
          </tr>
        </table>
    </fieldset>   
	<fieldset>
		<legend>
            <asp:Image ID="Image01" runat="server" ImageUrl="~/Template/Img/Historico.jpg" Height="25px" />Interna&ccedil;&otilde;es </legend>
		<table class="texto"  width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr bgcolor="#F3F7FC">
				<td style="height: 21px; width: 261px;"><strong>Entrada</strong></td>
			    <td width="29%" style="height: 21px"><strong>Sa&iacute;da</strong></td>
			    <td style="height: 21px; width: 329px;"><strong>Dias</strong></td>
			    <td style="height: 21px; width: 25px;">&nbsp;</td>
			</tr>
			<tr>
			  <td style="width: 261px">nananananana</td>
			  <td>nananananana</td>
			  <td style="width: 329px">nanana</td>
			  <td style="width: 25px"><asp:HyperLink ID="HyperLink4" runat="server" ImageUrl="~/Template/Img/IcoMais.gif"
                      NavigateUrl="#" onclick="mostrar('camada1')">HyperLink</asp:HyperLink></td>
		  </tr>
			<tr>
			  <td style="width: 261px">nananananana</td>
			  <td>nananananana</td>
			  <td style="width: 329px">nanana</td>
			  <td style="width: 25px"><asp:HyperLink ID="HyperLink5" runat="server" ImageUrl="~/Template/Img/IcoMais.gif"
                      NavigateUrl="#" onclick="mostrar('camada1')">HyperLink</asp:HyperLink></td>
			</tr>
	</table>
	</fieldset>

    <div id="camada1" style="visibility:hidden">
    <fieldset>
		<legend>
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Template/Img/medico.jpg" Height="25px" />Evoluções Médicas</legend>
		<table class="texto"  width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr bgcolor="#F3F7FC">
				<td style="width: 696px"><strong>M&eacute;dico</strong></td>
			    <td style="width: 23%"><strong>Data</strong></td>
			    <td style="width: 175px"><strong>Hora</strong></td>
			    <td style="width: 27px">&nbsp;</td>
			</tr>
			<tr>
			  <td style="width: 696px">nanananananana na na na na na</td>
			  <td style="width: 60px">nanana</td>
			  <td style="width: 175px">nanana</td>
			  <td style="width: 27px">
                  <a href="javascript:AbrePopUp('/HospitalRim/Relatorios/RelatorioEvolucaoMedica.aspx','1024','768',this,event)"><img src="../Template/Img/alterar.gif" border="0" WIDTH="15" HEIGHT="13"></a></td>
		  </tr>
			<tr>
			  <td style="width: 696px;">nanananananana na na na na na</td>
			  <td style="width: 60px;">nanana</td>
			  <td style="width: 175px; height: 21px;">nanana</td>
			  <td style="width: 27px; height: 21px;">
			        <a href="javascript:AbrePopUp('/HospitalRim/Relatorios/RelatorioEvolucaoMedica.aspx','1024','768',this,event)"><img src="../Template/Img/alterar.gif" border="0" WIDTH="15" HEIGHT="13"></a></td>
		  </tr>
			<tr>
			  <td style="width: 696px">nanananananana na na na na na</td>
			  <td style="width: 60px">nanana</td>
			  <td style="width: 175px">nanana</td>
			  <td style="width: 27px">
			        <a href="javascript:AbrePopUp('/HospitalRim/Relatorios/RelatorioEvolucaoMedica.aspx','1024','768',this,event)"><img src="../Template/Img/alterar.gif" border="0" WIDTH="15" HEIGHT="13"></a></td>
		  </tr>
			<tr>
			  <td style="width: 696px">nanananananana na na na na na</td>
			  <td style="width: 60px">nanana</td>
			  <td style="width: 175px">nanana</td>
			  <td style="width: 27px">
			        <a href="javascript:AbrePopUp('/HospitalRim/Relatorios/RelatorioEvolucaoMedica.aspx','1024','768',this,event)"><img src="../Template/Img/alterar.gif" border="0" WIDTH="15" HEIGHT="13"></a></td>
		  </tr>
		</table>
	</fieldset>
	<fieldset>
		<legend>
            <asp:Image ID="Image2" runat="server" ImageUrl="~/Template/Img/multidisciplinar.jpg" Height="25px" />Evoluções Multidisciplinar</legend>
		<table class="texto"  width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr bgcolor="#F3F7FC">
				<td style="width: 546px"><strong>M&eacute;dico</strong></td>
			    <td style="width: 218px"><strong>Especialidade</strong></td>
			    <td style="width: 328px"><strong>Data</strong></td>
			    <td style="width: 213px"><strong>Hora</strong></td>
			    <td style="width: 29px">&nbsp;</td>
			</tr>
			<tr>
			  <td style="width: 546px">nanananana nanananana nanana</td>
			  <td style="width: 218px">nanananananananana</td>
		      <td style="width: 328px">nanana</td>
		      <td style="width: 213px">nanana</td>
		      <td style="width: 29px">
		            <a href="javascript:AbrePopUp('/HospitalRim/Relatorios/RelatorioEvolucaoMultidisciplinar.aspx','1024','768',this,event)"><img src="../Template/Img/alterar.gif" border="0" WIDTH="15" HEIGHT="13"></a></td>
			</tr>
			<tr>
			  <td style="width: 546px">nanananana nanananana nanana</td>
			  <td style="width: 218px">nanananananananana</td>
			  <td style="width: 328px">nanana</td>
		      <td style="width: 213px">nanana</td>
		      <td style="width: 29px">
		            <a href="javascript:AbrePopUp('/HospitalRim/Relatorios/RelatorioEvolucaoMultidisciplinar.aspx','1024','768',this,event)"><img src="../Template/Img/alterar.gif" border="0" WIDTH="15" HEIGHT="13"></a></td>
			</tr>
		</table>
	</fieldset>
	<fieldset>
	    <legend>
            <asp:Image ID="Image02" runat="server" ImageUrl="~/Template/Img/Alta.jpg" Height="25px" />Alta</legend>
	            <table class="texto"  width="100%" border="1" cellpadding="0" cellspacing="0">
                    <tr bgcolor="#F3F7FC">
                        <td style="width: 171px"><strong>Entrada</strong></td>
                        <td style="width: 184px"><strong>Alta</strong></td>
                        <td style="width: 574px"><strong>Médico</strong></td>
                        <td style="width: 22px">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width: 171px">nanana</td>
                        <td style="width: 184px">nanana</td>
                        <td style="width: 574px">nanananananana na na na na</td>
                        <td style="width: 22px">
                                <a href="javascript:AbrePopUp('/HospitalRim/Relatorios/RelatoriodeAlta.aspx','1124','768',this,event)"><img src="../Template/Img/alterar.gif" border="0" WIDTH="15" HEIGHT="13"></a></td>           
	                </tr>
	            </table>
	</fieldset>
  </div>
</fieldset>
</asp:Content>
