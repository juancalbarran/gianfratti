<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<%
Response.expires = -1000
Response.expiresabsolute = Now() - 1
Response.addHeader "pragma","no-cache"
Response.addHeader "cache-control","private"
Response.CacheControl = "no-cache"
Server.ScriptTimeout = 900
Response.buffer = false

Dim conn
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")
%>
<html>
<head>
<body onload="return window_onload()" onunload="return window_onunload()" LANGUAGE=javascript  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<SCRIPT LANGUAGE=javascript FOR=RasterTwain EVENT="AcquirePageEvent(pBitmap)" >
<!--
	RasterTwain_AquirePageEvent(pBitmap) //Quando abrir a página completa é registrado este evento JavaScript
//-->
</SCRIPT>

<script ID="clientEventHandlersJS" LANGUAGE="javascript">
<!--
var ImgCounter=0;
//Função que ao entrar na página é chamado no Body
//Bloco de código responsavel por listar todos os scanner da maquina e listar em um LisBox
function window_onload() 
{
   var i;   
   RasterTwain.InitSession(RasterView.Window);
   RasterTwain.EnableMethodErrors = false;
   TwainSource.length = RasterTwain.SourceCount;
   for (i = 0; i < RasterTwain.SourceCount; i++)
        TwainSource.options(i).text = RasterTwain.SourceName(i);
   		TwainSource.selectedIndex = 0;
}
//Função responsevel por pegar a imagem que esta no Activex e chamar outra função "HTTPSubmit" para enviar a imagem via Upload
function RasterTwain_AquirePageEvent(pBitmap)
{
    var strResponse;
    RasterView.Raster.RasterUNK.Bitmap = pBitmap; //PBitMap é o nome que a propria aplicação batiza a imagem
    strResponse = HTTPSubmit(); //chama a função que ira enviar a imagem via Upload
    //If abaixo serve para pegar qualquer tipo de erro que retorne da pagina de Upload.asp
	if (strResponse != "")
	{
	hWnd = window.open("", "", "width=336,height=336,menubar=0,dependent=0,scrollbars=0,resizable=1");    
    hWnd.document.write(strResponse);
	}
	IframeImagem.location.reload() // Atualiza o Iframe com as mimiaturas das imagens. Apos fechar a caixa de propriedades do scanner
	
}
//Função que é chamada quando a janela do navegador é fechada. A chamada desta função fica no Body da página
function window_onunload(){
  RasterTwain.EndSession(); //Ao fechar o navegador tira as imagens da memoria
}

//-->
</script>

<script language="vbscript">

//Função executada ao clicar no botão Scan
Function ScanImage()
	//Faz a validação antes de abrir as propriedades do scanner
	if id_Tipo.value = "" Then 
		alert("Selecione o tipo de documento que vai ser capturado")
		Exit Function
	end if
	L_LTWAIN_SHOW_USER_INTERFACE = 1 //Opcao Caso (1) então abre o menu de propriedades do Scanner, caso (0) entao não abre o menu, faz a captura direto. Lembrando que se (0) o aplicativo vai pegar a ultima configuração do scanner que a pessoa usou na maquina
	RasterTwain.AcquireSourceName = RasterTwain.SourceName(TwainSource.selectedIndex)
	RasterTwain.Acquire L_LTWAIN_SHOW_USER_INTERFACE
End Function

//Função que  é chamada logo apos o scanner fazer a captura, esta funçãp vai fazer o upload da imagem
//A logica é a seguinte, vai capturando e ja mandando uma por uma e não captura tudo e depois envia
Function HTTPSubmit() 
	Dim nRet, strResponse, nStatus, NV
	Dim HTTP_RQST_GET, HTTP_STATUS_OK
	Dim FILE_JFIF
 
	HTTP_RQST_GET  = 0
	HTTP_STATUS_OK = 200
	FILE_JFIF      = 10
	FILE_CMP       = 5 
	
	window.status="Uploading and processing Image " & cstr(imgCounter)
	
	RasterHTTP.EnableMethodErrors = false
	Set NV = CreateObject("NAMEVALUEItem.NAMEVALUEItem.140")

	nRet = RasterHTTP.InetHttpConnect(HTTPSite.value, 80, "", "")
	If nRet = 0 Then
	//Chama a página que vai fazer o Upload da imagem /DiretorioVirtual/Pasta/arquivo.asp
	nRet = RasterHTTP.InetHttpOpenRequest(HTTP_RQST_GET, "/SmartCare/Captura/Upload.asp?id_Paciente=" + id_Paciente.value + "&id_Atendimento=" + id_Atendimento.value + "&id_Tipo=" + id_Tipo.value , "", "HTTP/1.0")
	//MsgBox "/SmartCare/Captura/Upload.asp?id_Paciente=" + id_Paciente.value + "&id_Atendimento=" + id_Atendimento.value + "&id_Tipo=" + id_Tipo.value
	If nRet = 0 Then
	Dim raster
			
	NV.pszName = HTTPSite.value
	NV.pszValue = HTTPSite.value
	
	nStatus = RasterHTTP.InetHttpGetServerStatus() 
				
	Set raster = RasterView.Raster
	nRet = RasterHTTP.InetHttpSendBitmap(RasterView.Raster, FILE_JFIF, 24, 50, "image/jpg", NV)
	//nRet = RasterHTTP.InetHttpSendBitmap(RasterView.Raster, FILE_CMP, 24, -1, "image/cmp", NV)			
    	If nRet <> 0 Then
           MsgBox "Error Sending Image: " + CStr(nRet), , "Error"
              RasterHTTP.InetHttpCloseRequest
              RasterHTTP.InetHttpDisconnect
              Exit Function
        End If
         
        nStatus = RasterHTTP.InetHttpGetServerStatus()
        If nStatus = HTTP_STATUS_OK Then
            strResponse = RasterHTTP.InetHttpGetResponse()
            If strcomp(strResponse, "refresh", 1) = 0 Then 
               RefreshBrowser = -1
            else                
                HTTPSubmit = strResponse                
            End if               
        Else
           strResponse = RasterHTTP.InetHttpGetResponse()	   
           Document.Write strResponse	   
        End If

        RasterHTTP.InetHttpCloseRequest
      End If
      RasterHTTP.InetHttpDisconnect
   End If
   window.status =""
   Set NV = Nothing //Destroi o objeto criado
   Set raster = Nothing //Destroi o objeto criado

End Function
</script>
<fieldset>
<legend  align="center" >&nbsp;Captura de Documentos&nbsp;</legend>
<table width="100%">
  <tr class='zebra_orange1'> 
    <td class="texto"><strong>Documento:</strong></td>
    <td colspan="6" ><strong><%=gerar_listbox("Documento_Tipo","id","id_Tipo","Tipo","")%>
      <INPUT type="text" name=HTTPSite id=HTTPSite value="fmanes">
      </strong></td>
  </tr>
  <tr class='zebra_orange1'> 
    <td width="10%" class="texto"><strong>Paciente:</strong> </td>
    <td width="15%"><input name="id_Paciente" type="text" id="id_Paciente" value="180" size="10" onclick="teste()" ></td>
    <td width="11%" class="texto"><strong>Atendimento:</strong></td>
    <td width="11%"><input name="id_Atendimento" type="text" id="id_Atendimento" value="166" size="10" ></td>
    <td width="7%" class="texto"><strong>Scanner:</strong></td>
    <td width="23%"><SELECT id=TwainSource name=TwainSource LANGUAGE="javascript"" class="campos">
        <OPTION selected></OPTION>
        <OPTION></OPTION>
      </SELECT></td>
    <td width="23%"><input id="Scan" type="button" value="Scan" name="Scan" LANGUAGE="javascript" onclick="ScanImage()">
    </td>
  </tr>
</table>

<table width="100%">
  <tr class='zebra_orange1'> 
    <td> <OBJECT classid=CLSID:00140708-B1BA-11CE-ABC6-F5B2E79D9E3F codebase="teste.cab"  
		data=data:application/x-oleobject;base64,CAcTALqxzhGrxvWy552ePwICAAA+JgAAYx4AABMA4ODgAAMAAAAAAAMAAAAAAAMAAAAAAAkAAAAAAAAAAAAAAAAAAAAAAAsA//8EAAAAAAAEAAAAAAAEAAAAAAAEAAAAAAADAAMAAAALAP//CwAAAAsA//8LAAAACwD//wMAAAAAAAMAAAAAAAMAAAAAAAQAAADIQgsAAAADAAEAAAALAAAAAgAAAAIAZAACAAAACwAAAAMAAAAAAAsAAAAEAAAAAAATAAAAAAADAAAAAAAEAAAAAAATAP///wATAICAgAADAAAAAAAEAAAAAAATAP///wATAICAgAALAP//CwAAAAQAAAAAAAQAAAAAAAQAAAAWQwQAAAAWQxMAAAAAAAgAAgAAAAAACwD//wMAAAAAAAMAAAAAAAMAAAAAAAMAAAAAAAkAAAAAAAAAAAAAAAAAAAAAAAkAAAAAAAAAAAAAAAAAAAAAAAIAAAADAOgDAAADAAAAAAADAOgDAAADAAAAAAATAAAA/wATAAAAAAACABAAAwAAAAAAEwAAAAAAEwAAAAAAAgABAAIABQACAAAAAgAAABMAAAAAAAIAAAALAP//AgABAAsAAAADAAAAAAALAAAAAgAAAAIAAQACAAEACwAAAAsA//8CAAAAAgBkAAIAAAA=  name=RasterView width="800" height="500" id=RasterView VIEWASTEXT   >
        <param name="LPKPath" value="LTRVW14n.lpk">
      </OBJECT> <object classid="clsid:5220cb21-c88d-11cf-b347-00aa00a28331" align="baseline" border="0" width="1" height="1">
        <param name="LPKPath" value="LTRVW14n.lpk">
      </object> <OBJECT id=RasterTwain classid=CLSID:00140752-B1BA-11CE-ABC6-F5B2E79D9E3F name=RasterTwain>
      </OBJECT> <OBJECT id=RasterHTTP classid=CLSID:00140741-B1BA-11CE-ABC6-F5B2E79D9E3F name=RasterHTTP>
      </OBJECT> </td>
    <td align="center" valign="top" class="texto"  ><b>Imagens Capturadas</b>
<IFRAME name="IframeImagem" SRC="thumbnail\thumbnail.aspx?SessionID=<%=Session.SessionID%>" FRAMEBORDER=0 SCROLLING=auto WIDTH=145px HEIGHT=500px MARGINWIDTH=0px  MARGINHEIGHT=0px ALIGN=Top	></Iframe></td>
  </tr>
</table>
</fieldset>
</body>
</html>
<script LANGUAGE="javascript">
function pisca(){
   //window.focus();
     //setTimeout("pisca()",2000);
	// window.parent.teste.reload()
	 //alert('dfsdf')
	 //window.parente.reload()
	 //teste.location.reload(); 
 }
pisca();
</script>
<%
if isobject(NV) then NV.Close
if isobject(raster) then raster.Close
%>