<%
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR MOSTRAR TODAS AS NOTICIAS
Function Noticias

	SQL	=	"SELECT id_noticia,noticia_titulo,noticia_sinopse,data "&_ 
			"FROM NOTICIAS " &_ 
			"Where noticia_Flag_Publicado = True " &_ 
			"Order By Data Desc "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = ""
					Content = Content &_ 
					"<table width='100%' border='0' cellspacing='0' cellpadding='0'> "& Chr(10) 
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_ 
							"<Tr class='"&zebrado&"'> "& Chr(10) &_ 
								"<TD class='textoAzul'>"&"<a href='Noticias.asp?Id_Noticia="&Rs("Id_Noticia")&"'>"&Rs("Noticia_Titulo")&"</a> "&"</TD>"& Chr(10) &_ 
								"<TD>"&ArrumaData(Rs("Data"))&"</TD>"& Chr(10) &_ 
							"</Tr>"& Chr(10)  &_ 
							"<Tr class='"&zebrado&"'> "& Chr(10) &_ 
								"<TD colspan='2'>"&Rs("Noticia_Sinopse")&"</TD>"& Chr(10) &_ 
							"</Tr>"& Chr(10)  &_ 
					Rs.MoVeNext
					Next
					Rs.Close
					Set Rs = Nothing
				End If
				Noticias = Content & "</Table>"
				Response.Write Noticias

End Function

'FUNÇÃO RESPONSAVEL POR VISUALIZAR UMA DETERMINADA NOTICIA ESCOLHIDA
Function Noticias_Visualizar

	SQL	=	"SELECT id_noticia,noticia_titulo,noticia_sinopse,data,noticia_texto  "&_ 
			"FROM NOTICIAS " &_ 
			"Where id_Noticia = "&Cint(Request("id_Noticia"))&" and noticia_Flag_Publicado = True "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = ""
					Content = Content &_ 
					"<table width='100%' border='0' cellspacing='0' cellpadding='0'> "& Chr(10) &_ 
						"<Tr> "& Chr(10) &_ 
							"<TD class='textoAzul'>"&Rs("Noticia_Titulo")&"</TD>"& Chr(10) &_ 
							"<TD>"&ArrumaData(Rs("Data"))&"</TD>"& Chr(10) &_ 
						"</Tr>"& Chr(10) &_ 
						"<Tr> "& Chr(10) &_ 
							"<TD>&nbsp;</TD>"& Chr(10) &_ 
						"</Tr>"& Chr(10) &_ 
						"<Tr> "& Chr(10) &_ 
							"<TD>"&Replace(Rs("Noticia_Texto"),Chr(10),"<br>")&"</TD>"& Chr(10) &_ 
						"</Tr>"& Chr(10) &_ 
					"</table> "& Chr(10) 
					Rs.Close
					Set Rs = Nothing
				End If
				Noticias_Visualizar = Content
				Response.Write Noticias_Visualizar

End Function

%>
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
                <td width="571" valign="top"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="12"></td>
                    </tr>
                    <tr> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="18">&nbsp;</td>
                            <td>
							<%
							IF Not IsNull(Trim(Request("id_Noticia"))) Then 'FAZ A VERIFICAÇÃO PARA SABER SE FOI SELECIONADO ALGUMA NOTICIA
								Call Noticias_Visualizar 'CASO FOR SELECIONADO ALGUMA NOTICIA ENTAO A FUNÇÃO DE VISUALIZAÇÃO SERA ACIONADA
							End If
							
							IF Trim(Request("id_Noticia")) = "" Then
									Call Noticias 'CASO NENHUMA NOTICIA TENHA SIDO SELECIONADO ENTAO IRA MOSTRAR TODAS AS NOTICIAS CHAMANDO A FUNÇAO
							End if
							%>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td>&nbsp; </td>
                    </tr>
                  </table>
                </td>
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