<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->

<title>Sistema de Monitoramento de Home Care</title>
<head> 
<script>
	//Função responsavel por redimensionar automaticamente o Iframe
	function redimen(nome)
	{
		var altura = eval("document.frames[nome].document.body.scrollHeight");
        eval("document.getElementById(nome).style.height = altura");
    }
</script>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
</head> 
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onunload="abrejanela()" >

<table border="0" cellpadding="0" cellspacing="0" style="border-style:None;width:100%;border-collapse:collapse;">
  <tr> 
    <td width="3%" rowspan="2" valign="top"><a href="<%=Application("dominio")%>"><img src="/SmartCare/images/LogoBanner.jpg" alt="P&aacute;gina principal" border="0" id="ctl00_ctl00_Image1" style="border-width:0px;" /></a></td>
    <td width="97%" valign="top"><img src="/SmartCare/images/banner_curve.gif" id="ctl00_ctl00_Image2" style="border-width:0px;" /></td>
  </tr>
  <tr> 
    <td valign="top" bgcolor="#2E5CB8"><img id="ctl00_ctl00_BannerFade" src="/SmartCare/images//banner_fade.gif" style="border-width:0px;" /></td>
  </tr>
  <tr> 
    <td colspan="2"  valign="middle"   >
	<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-style:None;width:100%;border-collapse:collapse;">
        <tr> 
          <td  class="toolbar" style="height:25px;white-space:nowrap;" >&nbsp;Bem 
            Vindo: <b><%=Session("Funcionario_Nome")%></b> </td>
          <td align="right" valign="middle"  class="toolbar" style="height:25px;white-space:nowrap;" ><a href="/SmartCare/Login/default.asp?action=Logoff"><img src="/SmartCare/images/sair.gif" alt="Sair do sistema" width="53" height="18" border="0"  /></a></td>
        </tr>
      </table></td>
  </tr>
</table>

<tr> 
    
  <td width="15%" valign="top" bgcolor="#ECE9D8"> 
  <table width="100%" height="600" border="0" cellpadding="0" cellspacing="0">
      <tr> 
      <td class="gradiente" valign="top"> 
	  <table width="100%">
          <tr>
            <td width="98%"><span id="mostrar_ocultar_menu" display: none;"> 
<%
	If Session("Tipo_Login") = "1" Then ' Caso o usuario logado seja do tipo funcionario
%>
			  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="99%" valign="top">
                    <!-- #include virtual="/SmartCare/Bibliotecas/Layout/menu.asp" -->
                    <BR style="font-size:5px;"> <%=Box_Solicitacao_Espera%> <BR style="font-size:5px;"> <%=Box_Prescricoes_Espera%> </td>
                </tr>
              </table>
<%
Else ' Caso o usuario logado seja do tipo Contato
%>
			  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="99%" valign="top">
                    <!-- #include virtual="/SmartCare/Bibliotecas/Layout/menu.asp" -->
                    <BR style="font-size:5px;">
                    <fieldset style="border :1px solid #000000;">
					<legend >Usuário</legend>
					<table width="100%">
                      <tr>
                        <td class="texto"><%=Session("Funcionario_Nome")%></td>
                      </tr>
                      <tr>
                        <td class="texto"><%=Session("Convenio_Nome")%></td>
                      </tr>
                    </table>
					</fieldset>
					</td>
                </tr>
              </table>
<%
	End if
%>
			  </Span> </td>
            <td width="2%"><a href="javascript:"><img src="/SmartCare/images/menu_minimiza.gif"  border="0" onClick="if(mostrar_ocultar_menu.style.display=='none'){mostrar_ocultar_menu.style.display=''}else{mostrar_ocultar_menu.style.display='none'};" ></a></td>
          </tr>
        </table>
        
      </td>
        <td width="100%" valign="top">
		<iframe onLoad="redimen('iFrameItens');" id="iFrameItens" frameborder="0" name="iFrameItens" marginwidth="0" marginheight="0" scrolling="no" src="/SmartCare/Modulos/HomeCare/Atendimento/default.asp" width="100%">
					 
          </iframe>
		 </td>
      </tr>
    </table></td>
    
<td width="94%" valign="top"></td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-style:None;width:100%;border-collapse:collapse;">
  <tr>
    <td class="toolbar" style="height:20px;white-space:nowrap;"><div align="center">&copy; Copyright Recognition</div></td>
  </tr>
</table>