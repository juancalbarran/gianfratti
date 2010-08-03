<!-- #include virtual = "/icdl/admin/Bibliotecas/funcoes/funcoes.asp" -->
<title>.: ICDL - Brasil :.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="default.css" type="text/css">
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="780" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <form name="form_Login" method="post" action="admin/login/default.asp?action=Login">
          <tr> 
            <td width="227"><img src="img/logo_topo.jpg" width="227" height="25"></td>
            <td width="82" bgcolor="#004890">&nbsp;</td>
            <td width="40" bgcolor="#004890" class="textoBco"> Login</td>
            <td width="94" bgcolor="#004890"> 
              <input name="usuario" type="text" class="box" id="usuario" size="11">
              <input type="hidden" name="pagina_retorno" value="<%="http://"&Request.ServerVariables("HTTP_HOST")&Request.ServerVariables("SCRIPT_NAME")&"?"&request.servervariables("QUERY_STRING")%>"> 
            </td>
            <td width="45" bgcolor="#004890" class="textoBco">Senha</td>
            <td width="88" bgcolor="#004890"> 
              <input type="password" name="senha" class="box" size="11">
            </td>
            <td width="70" bgcolor="#004890" valign="bottom"> 
              <input type="image" border="0" name="imageField" src="img/ok_topo.gif" width="27" height="19">
            </td>
            <td width="133"><img src="img/imagem_topo.jpg" width="133" height="25"></td>
          </tr>
        </form>
      </table>
    </td>
  </tr>
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><a href="/icdl"><img src="img/logo.jpg" width="299" height="103" border="0"></a></td>
          <td><img src="img/imagem.jpg" width="481" height="103"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <form name="form_Busca" method="post" action="busca.asp">
          <tr> 
            <td width="204"><img src="img/barra_lado1.jpg" width="204" height="42"></td>
            <td width="41" class="fundoBarra">&nbsp;</td>
            <td width="185" class="fundoBarra"><%=ArrumaData(Date)%> - <%=Hour(Now)%>h00</td>
            <td width="42" class="fundoBarra"><b>Busca</b></td>
            <td width="137" class="fundoBarra"> 
              <input name="buscar" type="text" class="box" id="buscar" size="19">
            </td>
            <td width="80" class="fundoBarra"> 
              <input type="image" border="0" name="imageField2" src="img/ok_busca.gif" width="27" height="19">
            </td>
            <td><img src="img/barra_lado2.jpg" width="91" height="42"></td>
          </tr>
        </form>
      </table>
    </td>
  </tr>
</table>