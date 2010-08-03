<%
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO QUE MOSTRA O CONTEUDO DAS PAGINAS
'DENTRO DESSA FUNÇÃO É CHAMADA A FUNÇÃO GLOBAL ConteudosBox A QUAL IRA MOSTRAR  O BOX COM OS CONTEUDOS DA PAGINA
Function Paginas_Conteudos

	SQL	=	"SELECT PAGINAS.id_Pagina, PAGINAS.Pagina_Titulo, PAGINAS.Pagina_Conteudo "&_ 
			"FROM PAGINAS " &_ 
			"Where PAGINAS.id_Pagina = "&Cint(Request("id_Pagina"))&" And Pagina_Flag_Publicado = True "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = ""
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For
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
                                  "<td width='16' valign='top'><img src='img/certific_barra.jpg' width='16' height='114'></td> "& Chr(10) &_ 
                                  "<td  width='987' valign='top'>"& Chr(10) &_ 
								  "<table width='100%' border='0' cellspacing='0' cellpadding='0'> "& Chr(10) &_ 
                                      "<tr>" & Chr(10) &_  
                                        "<td valign='top'>"& Chr(10) &_
										ConteudosBox(Rs("id_Pagina"))& Chr(10) &_
										
										Rs("Pagina_Conteudo")&"</td> "& Chr(10) &_ 
                                      "</tr> "& Chr(10) &_ 
                                    "</table>"& Chr(10) &_ 
									"</td>"& Chr(10) &_ 
                                "</tr>"& Chr(10) &_ 
                              "</table> "& Chr(10) 
					Rs.MoVeNext
					Next
					Rs.Close
					Set Rs = Nothing
				End If
				Paginas_Conteudos = Content

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
                      <td height="12" colspan="2"></td>
                    </tr>
                    <tr> 
                      <td width="3%" valign="top">&nbsp; </td>
                      <td width="97%" valign="top"> <%=Paginas_Conteudos%></td>
                    </tr>
                    <tr> 
                      <td colspan="2">&nbsp; </td>
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