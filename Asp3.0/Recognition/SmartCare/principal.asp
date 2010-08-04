<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
Dim nome,login,Endereco,CEP,Departamento_Nome,Cargo_Nome,TelefoneResidencial,TelefoneCelular,Bairro,Cidade,UF

IF Session("Tipo_Login") = "1" Then

'Chama a função que carrega os dados do funcionario para ser apresentado na tela principal
Call Funcionarios_Dados(Session("id_Funcionario"))
%>
<table width="100%" height="1024" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr > 
          <td width="84%" valign="top">
<table width="100%" border="0" cellspacing="1" cellpadding="0">
              <tr class="zebra_orange1"> 
                <td width="13%">Nome:</td>
                <td ><b><%=Nome%></b></td>
                <td>Login:</td>
                <td colspan="3"><b><%=Login%></b></td>
              </tr>
              <tr class="zebra_orange1"> 
                <td>Endere&ccedil;o:</td>
                <td width="39%"><b><%=Endereco%></b></td>
                <td width="14%">CEP:</td>
                <td colspan="3"><b><%=CEP%></b></td>
              </tr>
              <tr class="zebra_orange1"> 
                <td>Bairro:</td>
                <td><b><%=Bairro%></b></td>
                <td>Cidade:</td>
                <td width="21%"><b><%=Cidade%></b></td>
                <td width="6%">UF:</td>
                <td width="7%"><b><%=UF%></b></td>
              </tr>
              <tr class="zebra_orange1"> 
                <td>Departamento:</td>
                <td><b><%=Departamento_Nome%></b></td>
                <td>Cargo:</td>
                <td colspan="3"><b><%=Cargo_Nome%></b></td>
              </tr>
              <tr class="zebra_orange1"> 
                <td>Tel.Residencial:</td>
                <td><b><%=TelefoneResidencial%></b></td>
                <td>Celular:</td>
                <td colspan="3"><b><%=TelefoneCelular%></b></td>
              </tr>
            </table>
            <%
			'If para verificar se o funcionario tem algumas das propriedades abaixo, caso nao tenho entao não é mostrado a tabela
			IF Funcionarios_Especializacao(Session("id_Funcionario")) <> "" or Funcionarios_Disponibilidade(Session("id_Funcionario")) <> ""  or Funcionarios_Cobertura(Session("id_Funcionario")) <> "" Then
			%>
            <table width="100%" height="116" border="0" cellpadding="0" cellspacing="1">
              <tr class="zebra_orange1">
                <td height="25" valign="top"><img src="images/placa_Especializacoes.gif"></td>
                <td valign="top"><img src="images/placa_Disponibilidades.gif"></td>
                <td valign="top"><img src="images/placa_Cobertura.gif"></td>
              </tr>
              <tr class="zebra_orange1"> 
                <td width="33%" height="135" valign="top"><%=Funcionarios_Especializacao(Session("id_Funcionario"))%></td>
                <td width="33%" valign="top"><%=Funcionarios_Disponibilidade(Session("id_Funcionario"))%></td>
                <td width="33%" valign="top"><%=Funcionarios_Cobertura(Session("id_Funcionario"))%></td>
              </tr>
            </table>
		   <%End if%>
		</td>
          <td width="16%" valign="top"><table width="100" border="0" align="right" cellpadding="0" cellspacing="0">
              <tr> 
                <td colspan="3"><img src="images/BoxCima.bmp"></td>
              </tr>
              <tr> 
                <td width="4%" valign="top"><img src="images/BoxEsquerda.bmp"></td>
                <td width="92%" align="center" valign="top" bgcolor="#244256"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td class="titHome2"align="center"><%=Session("Funcionario_Nome")%></td>
                    </tr>
                  </table>
                  <br> <%=Funcionario_Imagem(Session("id_Funcionario"),"120","160")%><br> 
                  <br> <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td class="caixa2FundoTitulo"align="center"><%=Session("Departamento_Nome")%></td>
                    </tr>
                  </table></td>
                <td width="5%" valign="top"><img src="images/BoxDireita.bmp"></td>
              </tr>
              <tr> 
                <td colspan="3"><img src="images/BoxBaixo.bmp"></td>
              </tr>
            </table></td>
        </tr>
      </table>
      
      <table width="100%">
        <tr> 
          <td valign="top"><span id="mostrar_ocultar_menu" display: none;"><%=Box_Exames_Espera%></Span> </td>
        </tr>
      </table>
      <table width="100%">
        <tr> 
          <td valign="top"> <iframe width=100% height=140px name="" id="" src="/SmartCare/Modulos/HomeCare/Relatorios_Internos/Atendimento_Tipo_Mensal/default.asp" scrolling="no" frameborder="0" ></Iframe>	
          </td>
        </tr>
      </table>
      <table width="100%">
        <tr> 
          <td valign="top"> <iframe width=100% height=170px name="" id="" src="/SmartCare/Modulos/HomeCare/Relatorios_Internos/Atendimento_Status_Mensal/default.asp" scrolling="no" frameborder="0" ></Iframe>	
          </td>
        </tr>
      </table>
      <table width="100%">
        <tr> 
          <td valign="top">
      			<iframe width=100% height=230px name="" id="" src="/SmartCare/Modulos/HomeCare/Relatorios_Internos/Convenios_Atendimento_Tipo/default.asp" scrolling="no" frameborder="0" ></Iframe>		  
		  </td>
        </tr>
      </table>
      <table width="100%">
        <tr> 
          <td valign="top"> <iframe width=100% height=230px name="" id="" src="/SmartCare/Modulos/HomeCare/Relatorios_Internos/Convenios_Atendimento_Status/default.asp" scrolling="no" frameborder="0" ></Iframe>	
          </td>
        </tr>
      </table>
      
    </td>
  </tr>
</table>
<%End IF%>
<%
IF Session("Tipo_Login") = "2" Then
	'Caso seja do tipo Contato entao redireciona para a tela de solicitação
	Response.Redirect Application("Dominio") & "/Modulos/HomeCare/Solicitacao/Default.asp"
End if
%>
