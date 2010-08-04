<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--include file="../conexao.inc" -->

<html>
<head>
<title>Upload</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<link rel="stylesheet" href="../../css/text.css" type="text/css">

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<table align='' bgcolor='#003366' width='100%'><tr align=''>
    <td><font face='Arial, Helvetica, sans-serif' color='#FFFFFF' size='1'>Upload</font></td>
</tr></table>
<div align="center">
<%
if request("arquivo") <> "" then
	cod = request.QueryString("cd")
	Set Upl = Server.CreateObject("SoftArtisans.FileUp") 
	Upl.Path = "e:\home\dersa\web\daesp\editais"
	arqui = split(request("arquivo"),"\") 
	coluna = Trim(Request("arquivo_parte"))
		
	if upl.TotalBytes>=1 then
		Upl.Save
		SQL = "UPDATE tb_licitacao SET "&coluna&" = '" & arqui(ubound(arqui)) & "' WHERE cd_licitacao=" & cod
		conn.execute(SQL)
	end if 	
%>
Total de bytes enviados: <%=upl.TotalBytes%>
  <br>
  <br>
  <input name="enviar" type="button" class="botao" id="enviar" value=" Voltar" onclick="document.location='licitacoes_principal.asp'">
  </span> 
<%
Set Upl = Nothing
response.End()
end if
%>
  <span class="fonte75" > </span> </div>
<form name="form1" enctype="multipart/form-data" method="post" action="" onSubmit="javascript:this.action='licitacoes_upload.asp?cd=<%=request("cd")%>&arquivo=' + form1.arquivo.value +'&arquivo_parte=' + form1.arquivo_parte.value   ">
  <p align="center"><br>
    <span class="fonte75" ><strong><font size="2"> 
    <select name="arquivo_parte" id="arquivo_parte">
      <option value="Arquivo">Arquivo 1</option>
      <option value="Arquivo2">Arquivo 2</option>
      <option value="Arquivo3">Arquivo 3</option>
      <option value="Arquivo4">Arquivo 4</option>
      <option value="Arquivo5">Arquivo 5</option>
    </select>
    arquivo1: &nbsp; </font></strong></span> 
    <input name="arquivo" type="file" size="41">
    <input name="enviar" type="submit" class="botao" id="enviar7" value=" Enviar " onclick="this.value='  Enviando. Aguarde... '">
  </p>
  <p align="center"> 
    <input name="enviar" type="submit" class="botao" id="enviar" value=" Enviar " onclick="this.value='  Enviando. Aguarde... '">
  </p>
</form>
</body>
</html>

