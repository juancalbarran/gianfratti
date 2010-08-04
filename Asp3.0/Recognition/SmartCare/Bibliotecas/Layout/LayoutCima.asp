<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<title>Sistema de Monitoramento de Home Care</title>
<head> 
<script>
            function redimen(nome)
            {
				var altura = eval("document.frames[nome].document.body.scrollHeight");
                eval("document.getElementById(nome).style.height = altura");
            }
</script>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
</head> 
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onunload="abrejanela()" >

<table width="100%" height="4%" border="0" cellpadding="0" cellspacing="0" bgcolor="#ECE9D8">
  <tr> 
    <td width="3%" valign="middle"><a href="/SmartCare"><img src="/SmartCare/images/home.gif" width="22" height="20" border="0"></a></td>
    <td class="texto" width="48%" valign="middle"><strong>Sistema de Monitoramento</strong></td>
    <td width="49%" align="right" valign="middle" class="texto"><a href="/SmartCare/Login/default.asp?action=Logoff"><img src="/SmartCare/images/logoff.jpg" border="0"></a></td>
  </tr>
</table>
<tr> 
    
  <td width="15%" valign="top" bgcolor="#ECE9D8"> <table width="100%" height="600" border="0" cellpadding="0" cellspacing="0">
      <tr> 
      <td valign="top" bgcolor="#ECE9D8"> 
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
                      <tr > 
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
				<iframe onLoad="redimen('iFrameItens');" id="iFrameItens" frameborder="0" name="iFrameItens"
					marginwidth="0" marginheight="0" scrolling="no" src="/SmartCare/default.asp" width="100%">
				</iframe>		
		 </td>
      </tr>
    </table></td>
    
<td width="94%" valign="top"></td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#ECE9D8">
  <tr>
    <td class="texto"><div align="center">&copy; Copyright Recognition</div></td>
  </tr>
</table>