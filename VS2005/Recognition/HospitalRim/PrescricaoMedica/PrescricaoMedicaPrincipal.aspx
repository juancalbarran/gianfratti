<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="PrescricaoMedicaPrincipal.aspx.cs" Inherits="PrescricaoMedica_PrescricaoMedicaPrincipal" Title="SmartCare - Hospital do Rim" %>
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
    <legend align="center">Gerenciador de Prescrições Médicas</legend>
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
            <td style="width: 16px">&nbsp;</td>
            <td>
                &nbsp;</td>
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
          <td style="width: 16px"><a href="PrescricaoMedicaPreenchido.aspx"><asp:Image  ID="Image1" runat="server" ImageUrl="~/Template/Img/alterar.gif" /></td>
          <td style="width: 19px"><a href="javascript:AbrePopUp('/HospitalRim/PrescricaoMedica/PrescrissaoMedicaImpressao.aspx','1024','768',this,event)"><img src="../Template/Img/ico_impressora.gif"border="0" WIDTH="15" HEIGHT="13"></a></td>
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
          <td style="width: 16px"><a href="PrescricaoMedicaPreenchido2.aspx"><asp:Image  ID="Image2" runat="server" ImageUrl="~/Template/Img/alterar.gif" /></td>
          <td style="width: 19px"><a href="javascript:AbrePopUp('/HospitalRim/PrescricaoMedica/PrescrissaoMedicaImpressao2.aspx','1024','768',this,event)"><img src="../Template/Img/ico_impressora.gif"border="0" WIDTH="15" HEIGHT="13"></a></td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td style="width: 16px"></td>
          <td style="width: 19px">
              </td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td style="width: 16px">
              </td>
          <td style="width: 19px">
              </td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td style="width: 16px">
              </td>
          <td style="width: 19px">
              </td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td style="width: 16px">
              </td>
          <td style="width: 19px">
              </td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td style="width: 16px">
              </td>
          <td style="width: 19px">
              </td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td style="width: 16px">
              </td>
          <td style="width: 19px">
              </td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td style="width: 16px">
              </td>
          <td style="width: 19px">
              </td>
        </tr>
      </table>
    </fieldset>
	  <br />
	  <fieldset>
		<table class="texto" width="100%" border="0" cellpadding="0" cellspacing="0">
		  <tr>
		    <td align="center" style="height: 24px"><asp:Button ID="Button1" runat="server" PostBackUrl="~/PrescricaoMedica/PrescricaoMedica.aspx" Text="Cadastrar" /></td>
          </tr>
       </table>
	  </fieldset>
    </fieldset>
</asp:Content>

