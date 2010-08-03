<%
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR EXIBIR O MENU DAS CATEGORIAS
Function Categorias

	SQL	=	"SELECT id_Categoria,Categoria_Nome From CATEGORIAS Where Categoria_Flag_Publicado = True Order By Ordem "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For
						Content = Content &_					
						"<table width='100%' border='0' cellspacing='0' cellpadding='0'> " & Chr(10) &_ 
											"<tr>" & Chr(10) &_ 
											  "<td height='29' width='25'></td>" & Chr(10) &_
											  "<td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> " & Chr(10) &_
												  "<tr>" & Chr(10) &_
													"<td height='29' width='12'><img src='img/esq.gif' width='12' height='32'></td> " & Chr(10) &_
													"<td width='131' class='bordaTop' align='center'><span class='textoCinza'>..:</span> "& Chr(10) &_ 
													"<span class='textoAzul'>"&Rs("Categoria_Nome")&"</span> <span class='textoCinza'>:..</span></td> "& Chr(10) &_
													"<td><img src='img/dir.gif' width='12' height='32'></td>"& Chr(10) &_
												  "</tr>" & Chr(10) &_
									"</table>" & Chr(10) &_
									"</td>" & Chr(10) &_
											  "<td width='29' valign='top'>&nbsp;</td> " & Chr(10) &_
											"</tr>"& Chr(10) 

						SQL	=	"SELECT id_Pagina,Pagina_Titulo From PAGINAS Where id_Categoria = "&Rs("id_Categoria")&" Order By Ordem "
								Set rs2 = server.createobject("adodb.recordset")
								Rs2.open SQL, CONN, 3
									IF not rs2.eof then 'Verifica se existem registros
										For y = 1 To Rs2.RecordCount
											Content = Content &_
												"<tr>"& Chr(10) &_ 
												  "<td width='25'>&nbsp;</td>"& Chr(10) &_
												  "<td>" & Chr(10) &_
												   "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='bordaLaterais'>" & Chr(10) &_
													  "<tr>" &_  
														"<td height='29' width='12'>&nbsp;</td>" & Chr(10) &_
														"<td width='131' ><b><a href='paginas.asp?id_pagina="&Rs2("id_pagina")&"' class='menu'>"&Rs2("Pagina_Titulo")&"</a></b></td> " & Chr(10) &_
														"<td>&nbsp;</td>" & Chr(10) &_
													  "</tr>" & Chr(10) &_
													"</table>"& Chr(10) &_
													"</td>" & Chr(10) &_
												  "<td width='29' valign='top'>&nbsp;</td>" & Chr(10) &_
												"</tr> "
									
										Rs2.MoveNext
										Next
                                                                                                                                Rs2.Close
                                                                                                                                Set Rs2 = Nothing
									End If
									Content = Content &_
									"<tr>"& Chr(10) &_
									  "<td height='29' width='25'>&nbsp;</td>" & Chr(10) &_
									  "<td>"& Chr(10) &_
									  "<table width='100%' border='0' cellspacing='0' cellpadding='0'>" & Chr(10) &_
										  "<tr>" & Chr(10) &_ 
											"<td height='32' width='12' valign='top'> <img src='img/esq2.gif' width='12' height='32'></td>"& Chr(10) &_
											"<td width='131' class='bordaBottom' align='center'>&nbsp;</td>" & Chr(10) &_
											"<td><img src='img/dir2.gif' width='12' height='32'></td>" & Chr(10) &_
										  "</tr>" & Chr(10) &_
										"</table>" & Chr(10) &_
										"</td>" & Chr(10) &_
									  "<td width='29' valign='top'>&nbsp;</td>"& Chr(10) &_
									"</tr>" & Chr(10) &_
								  "</table>" & Chr(10) &_ 
								  "<Br><Br>"
					Rs.MoveNext
					Next
                                                                Rs.Close
                                                                Set Rs = Nothing
				End If
				Categorias = Content

End Function
%>
<table width="209" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><img src="img/lateral.gif" width="209" height="23"></td>
  </tr>
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="29" width="25"></td>
          <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="right"><strong><a href="#"><img src="img/homeWeb.gif"  border="0"></a></strong></td>
                <td class='menu'><a href="/icdl">.: Home :.</a></td>
              </tr>
            </table></td>
          <td width="29" valign="top"><img src="img/lateral_lado.gif" width="29" height="32"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
  </tr>
  <tr> 
    <td height="20" valign="top"> <%=Categorias%></td>
  </tr>
  <tr> 
    <td height="20" align="center"><a href="http://www.ecdl.com" target="_blank"><strong>Site 
      da Funda&ccedil;&atilde;o ECDL</strong></a></td>
  </tr>
</table>
