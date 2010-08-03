<%
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL FAZER UMA BUSCA NAS PAGINAS
Function Buscar_Paginas

	SQL	=	"SELECT id_Pagina,Pagina_Titulo "&_ 
			"FROM PAGINAS " &_ 
			"Where Pagina_Titulo Like '%"&Trim(Replace(Request("Buscar"),"'",""))&"%'  " &_ 
			"Order By Pagina_Titulo "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = ""
					Content = Content &_ 
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda'> "& Chr(10) &_
						"<Tr> "& Chr(10) &_ 
							"<TD align='center' bgcolor='#CEE5FA' ><B>PÁGINAS ENCONTRADAS</B></TD>"& Chr(10) &_ 
						"</Tr>"& Chr(10) 
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_ 
							"<Tr > "& Chr(10) &_ 
								"<TD class='"&zebrado&" textoAzul'>"&"<a href='Paginas.asp?Id_Pagina="&Rs("Id_Pagina")&"'>"&Rs("Pagina_Titulo")&"</a> "&"</TD>"& Chr(10) &_ 
							"</Tr>"& Chr(10)  &_ 
					Rs.MoVeNext
					Next
					Rs.Close
					Set Rs = Nothing
					Buscar_Paginas = Content & "</Table>"
					Response.Write Buscar_Paginas
				End If

End Function


'FUNÇÃO RESPONSAVEL FAZER UMA BUSCA NAS NOTICIAS
Function Buscar_Noticias

	SQL	=	"SELECT id_noticia,noticia_titulo,noticia_sinopse, data "&_ 
			"FROM NOTICIAS " &_ 
			"Where Noticia_Titulo Like '%"&Trim(Replace(Request("Buscar"),"'",""))&"%' " &_ 
			"Order By Data Desc "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = ""
					Content = Content &_ 
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda'> "& Chr(10) &_
						"<Tr> "& Chr(10) &_ 
							"<TD colspan='2' align='center' bgcolor='#CEE5FA'><B>NOTICIAS ENCONTRADAS</B></TD>"& Chr(10) &_ 
						"</Tr>"& Chr(10) 
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_ 
							"<Tr class='"&zebrado&" textoAzul' > "& Chr(10) &_ 
								"<TD >"&"<a href='Noticias.asp?Id_Noticia="&Rs("Id_Noticia")&"'>"&Rs("Noticia_Titulo")&"</a> "&"</TD>"& Chr(10) &_ 
								"<TD align='right' class='data'>"&ArrumaData(Rs("Data"))&"</TD>"& Chr(10) &_ 
							"</Tr>"& Chr(10)  &_ 
							"<Tr class='"&zebrado&"'> "& Chr(10) &_ 
								"<TD colspan='2'>"&Rs("Noticia_Sinopse")&"</TD>"& Chr(10) &_ 
							"</Tr>"& Chr(10)  &_ 
					Rs.MoVeNext
					Next
					Rs.Close
					Set Rs = Nothing
					Buscar_Noticias = Content & "</Table>"
					Response.Write Buscar_Noticias				
				End If

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
                            <td  > 
                              <%Call Buscar_Paginas%>
							  <Br>
							  <%Call Buscar_Noticias%>
							
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