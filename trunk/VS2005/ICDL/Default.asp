<%
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO QUE MOSTRA AS NOTIICAS EM DESTAQUE NA HOME
Function Noticias_Destaques

	'SELECT FAZ UM TOP 3 SOMENTE PARA APARECER AS 3 PRIMEIRAS NOTICIAS NA HOME
	SQL	=	"SELECT TOP 3 Id_Noticia,noticia_sinopse "&_ 
			"FROM NOTICIAS "  &_ 
			"Where noticia_Flag_Publicado = True " &_ 
			"Order By id_Noticia Desc"
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = ""
					For x = 1 To RS.Recordcount
						Content = Content &_ 
						"<table width='100%' border='0' cellspacing='0' cellpadding='0'>" & Chr(10) &_ 
							"<tr>"& Chr(10) &_
							  "<td width='30' height='63' valign='top' align='right'><img src='img/seta.gif' width='7' height='9'>&nbsp;&nbsp;</td>"& Chr(10) &_
							  "<td valign='top'><a href='Noticias.asp?id_Noticia="&Rs("Id_Noticia")&"'>"&Left(Rs("noticia_sinopse"),70)&"...</a></td>"& Chr(10) &_
							"</tr>"& Chr(10) &_
						"</table>"
					Rs.MoveNext
					Next
					Rs.Close
					Set Rs = Nothing
					
				End IF
				Noticias_Destaques = Content

End Function

'FUNÇÃO IRA TODOS OS DESTAQUES DAS PAGINAS QUE NÃO ESTA VAZIOS
Function Destaque_Home
	
	SQL	=	"SELECT PAGINAS.id_Pagina, PAGINAS.Pagina_Titulo, PAGINAS.Pagina_Destaque_Home " &_ 
			"FROM PAGINAS " &_ 
			"Where Pagina_Destaque_Home <> '' and Pagina_Flag_Publicado = True " &_ 
			"Order By data_atualizacao DESC "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = ""
					For X = 1 To Rs.RecordCount
						Content = Content &_ 
						"<table width='100%' border='0' cellspacing='0' cellpadding='0'> "& Chr(10) &_ 
                                "<tr> "& Chr(10) &_ 
                                  "<td colspan='2' background='img/certific.jpg'> "& Chr(10) &_  
                                    "<table width='100%' border='0' cellspacing='0' cellpadding='0'> "& Chr(10) &_ 
                                      "<tr>" & Chr(10) &_  
                                        "<td height='24' width='19'>&nbsp;</td>"& Chr(10) &_ 
                                        "<td width='326'><font color='#666666'>&nbsp;</font><b><font color='#004890'>"&Rs("Pagina_Titulo")&"</font></b></td> "& Chr(10) &_ 
                                      "</tr>"& Chr(10) &_ 
                                    "</table>"& Chr(10) &_ 
									"</td> "& Chr(10) &_ 
                                "</tr>"& Chr(10) &_ 
                                "<tr> "& Chr(10) &_  
                                  "<td width='2%' valign='top'><img src='img/certific_barra.jpg' width='16' height='114'></td> "& Chr(10) &_ 
                                  "<td width='98%' valign='top'>"& Chr(10) &_ 
								  "<table width='100%' border='0' cellspacing='0' cellpadding='0'> "& Chr(10) &_ 
                                      "<tr>" & Chr(10) &_  
                                        "<td valign='top'>"&Rs("Pagina_Destaque_Home")&"</td> "& Chr(10) &_ 
                                      "</tr> "& Chr(10) &_ 
                                      "<tr> "& Chr(10) &_  
                                        "<td height='20' valign='bottom' align='right'><b><a href='Paginas.asp?id_Pagina="&Rs("id_Pagina")&"'>Ler Mais ...</a></b> &nbsp;&nbsp;</td> "& Chr(10) &_ 
                                      "</tr>"& Chr(10) &_ 
                                    "</table>"& Chr(10) &_ 
									"</td>"& Chr(10) &_ 
                                "</tr>"& Chr(10) &_ 
                              "</table> "& Chr(10) 
					Rs.MoVeNext
					Next
                                                                Rs.Close
                                                                Set Rs = Nothing
				End If
				Destaque_Home = Content
End Function
%>
<SCRIPT LANGUAGE="JavaScript">
function openFlashFullscreen() {
window.open('Flash/Professor/exame.htm', '', 'fullscreen=yes', 'scrollbars=no');
}
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td valign="top" align="center">
      <table width="780" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><!-- #include virtual = "/icdl/include/topo.asp" --></td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="209" class="fundoMenu" valign="top"> 
                  <!-- #include virtual = "/icdl/include/lateral.asp" -->
                </td>
                <td width="571" colspan="2" valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="12"></td>
                    </tr>
                    <tr> 
                      <td align="center" valign="top"> 
                        <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="550" height="40" id="banner">
                          <param name=movie value="Flash/Professor/banner.swf">
                          <param name=quality value=high>
                          <param name=bgcolor value=#FFFFFF>
                          <embed src="Flash/Professor/banner.swf" quality=high bgcolor=#FFFFFF  width="550" height="40" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"> 
                          </embed> </object>
                      </td>
                    </tr>
                    <tr> 
                      <td valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="18">&nbsp;</td>
                            <td width="345" valign="top"> 
                              <p><%=Destaque_Home%></p></td>
                            <td width="208" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td width="37" valign="top">&nbsp;</td>
                                  <td width="171" valign="top"><a href="noticias.asp"><img src="img/news.jpg" width="149" height="24" border="0"></a></td>
                                </tr>
                                <tr> 
                                  <td colspan="2" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr> 
                                        <td width="168" valign="top" background="img/news_fundo.jpg"><br>
                                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr> 
                                              <td width="3%">&nbsp;</td>
                                              <td width="94%"><%=Noticias_Destaques%></td>
                                              <td width="3%">&nbsp;</td>
                                            </tr>
                                            <tr>
                                              <td>&nbsp;</td>
                                              <td align="right" valign="bottom" background="#"><font size="1"><em><a href="noticias.asp"><strong>Todas 
                                                &agrave;s Noticias</strong></a></em></font></td>
                                              <td>&nbsp;</td>
                                            </tr>
                                          </table></td>
                                        <td> <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr> 
                                              <td height="207" width="9">&nbsp;</td>
                                              <td valign="top" width="9"><img src="img/news_barra.jpg" width="9" height="145"></td>
                                              <td width="22">&nbsp;</td>
                                            </tr>
                                            <tr> 
                                              <td height="18" colspan="3">&nbsp;</td>
                                            </tr>
                                          </table></td>
                                      </tr>
                                    </table></td>
                                </tr>
                              </table>
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td width="37" valign="top">&nbsp;</td>
                                  <td width="171" valign="top">&nbsp;</td>
                                </tr>
                                <tr> 
                                  <td colspan="2" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr> 
                                        <td width="168" valign="top" background="img/news_fundo.jpg"><br> 
                                          <table width="98%" border="0" cellspacing="0" cellpadding="0">
                                            <form name="form_busca_Certificacao" method="post" action="BuscaCertificacao.asp">
                                              <tr> 
                                                <td width="3%">&nbsp;</td>
                                                <td width="94%" colspan="2" align="center" valign="top" class="textoAzul">Consulte 
                                                  os Certificados emitidos. </td>
                                                <td width="3%">&nbsp;</td>
                                              </tr>
                                              <tr> 
                                                <td>&nbsp;</td>
                                                <td colspan="2" align="center" valign="top">&nbsp;</td>
                                                <td>&nbsp;</td>
                                              </tr>
                                              <tr> 
                                                <td>&nbsp;</td>
                                                <td align="right"> <input name="Busca_Certificacao" type="text" class="box" id="Busca_Certificacao" size="18" maxlength="12"> 
                                                </td>
                                                <td align="center"><input type="image" border="0" name="imageField2" src="img/ok_busca.gif" width="27" height="19"></td>
                                                <td>&nbsp;</td>
                                              </tr>
                                              <tr>
                                                <td>&nbsp;</td>
                                                <td colspan="2" class="texto"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                                  <input type="radio" name="opcao_busca_certificado" value="2">
                                                  <font size="1" face="Verdana, Arial, Helvetica, sans-serif">Nome</font></font></td>
                                                <td>&nbsp;</td>
                                              </tr>
                                              <tr> 
                                                <td>&nbsp;</td>
                                                <td colspan="2" class="texto"> 
                                                  <input name="opcao_busca_certificado" type="radio" value="1" checked>
                                                  <font size="1" face="Verdana, Arial, Helvetica, sans-serif">N&uacute;mero</font></td>
                                                <td>&nbsp;</td>
                                              </tr>
                                              <tr> 
                                                <td>&nbsp;</td>
                                                <td colspan="2" class="texto"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ex: 
                                                  BR-000000</strong></font></td>
                                                <td>&nbsp;</td>
                                              </tr>
                                              <tr> 
                                                <td>&nbsp;</td>
                                                <td colspan="2" class="texto">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong>Ex 
                                                  Start: *BR-000000</strong></font></td>
                                                <td>&nbsp;</td>
                                              </tr>
                                              <tr> 
                                                <td>&nbsp;</td>
                                                <td colspan="2" class="texto">&nbsp; 
                                                </td>
                                                <td>&nbsp;</td>
                                              </tr>
                                            </form>
                                          </table>
										  
										  </td>
                                        <td> <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr> 
                                              <td height="207" width="9">&nbsp;</td>
                                              <td valign="top" width="9">&nbsp;</td>
                                              <td width="22">&nbsp;</td>
                                            </tr>
                                            <tr> 
                                              <td height="18" colspan="3">&nbsp;</td>
                                            </tr>
                                          </table></td>
                                      </tr>
                                    </table></td>
                                </tr>
                              </table></td>
                          </tr>
                        </table></td>
                    </tr>
                  </table></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td> 
            <!-- #include virtual = "/icdl/include/bottom.asp" -->
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>