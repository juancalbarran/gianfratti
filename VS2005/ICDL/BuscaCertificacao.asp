<%
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL FAZER UMA BUSCA NAS CERTIFICAÇÕES
Function Buscar_Certificacao

	If Trim(Request("Busca_Certificacao")) = "" Then	
		Response.Write "<Script>alert('Preencha o campo com o número da certificação ou nome da pessoa certificada')</Script>"
		Response.Write "<script>location = 'default.asp' </script>"
		Response.end
	End If

	SQL	=	"SELECT * "&_ 
			"FROM CERTIFICADOS " 
			clausula = " WHERE  " 
			If Trim(Request("opcao_busca_certificado")) = "1" then 'Busca por N° de certificado
				sql = sql & clausula & " Numero_Certificado = '"&Trim(Replace(Request("Busca_Certificacao"),"'",""))&"'  "
				clausula = "and "
			End IF
			If Trim(Request("opcao_busca_certificado")) = "2" then 'Busca por Nome
				sql = sql & clausula & " Nome Like '"&Trim(Replace(Request("Busca_Certificacao"),"'",""))&"%'  "
				clausula = "and "
			End IF
			sql = sql & "Order By id "
			
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For
						Content = Content &_ 
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda'> "& Chr(10) &_
							"<Tr> "& Chr(10) &_ 
								"<TD align='center' bgcolor='#CEE5FA' ><B>Certificação Encontrada</B></TD>"& Chr(10) &_ 
							"</Tr>"& Chr(10) &_ 
							"<Tr > "& Chr(10) &_ 
								"<TD>Nome: <b>"&Rs("Nome")&"</b></TD>"& Chr(10) &_ 
							"</Tr>"& Chr(10)  &_ 
							"<Tr > "& Chr(10) &_ 
								"<TD>Número da Certificação: <b>"&Rs("Numero_Certificado")&"</b></TD>"& Chr(10) &_ 
							"</Tr>"& Chr(10)  &_ 
							"<Tr > "& Chr(10) &_ 
								"<TD>Centro Certificador: <b>"&Rs("Centro_Certificador")&"</b></TD>"& Chr(10) &_ 
							"</Tr>"& Chr(10)  &_ 
							"<Tr > "& Chr(10) &_ 
								"<TD>Data Emissao do Certificado: <b>"&ArrumaData(Rs("Data_Emissao"))&"</b></TD>"& Chr(10) &_ 
							"</Tr>"& Chr(10) &_ 
					"</Table>" &_ 
					"<br>"
					Rs.MoVeNext
					Next
					Else 'Caso nao tenha encontrado registros
						Content = Content &_ 
						"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda'> "& Chr(10) &_
							"<Tr> "& Chr(10) &_ 
								"<TD align='center' bgcolor='#CEE5FA' ><B>Certificação não encontrada</B></TD>"& Chr(10) &_ 
							"</Tr>"& Chr(10) &_ 
							"<Tr > "& Chr(10) &_ 
								"<TD>Caso queira entrar em contato conosco clique <a href='paginas.asp?id_pagina=12'>aqui</a></TD>"& Chr(10) &_ 
							"</Tr>"& Chr(10) &_ 
						"</Table>"
				End If
					Buscar_Certificacao = Content
					Response.Write Buscar_Certificacao
					Rs.Close
					Set Rs = Nothing

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
                              <%
								Call Buscar_Certificacao
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
<%
'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>