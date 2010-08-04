<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<!-- #include virtual="/SmartCare/MODULOS/HomeCare/Busca_Funcionario/Js/Validacoes.js" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 09/08/2005
' Descrição: Pagina de busca de Funcionarios
' Atualizado por: -
' Data: -
' Atualização: -
%>
<script language="javascript">
<!--
//FUNÇÃO QUE TRANSFERE O CONTEUDO DA PAGINA PARA OUTRA PAGINA
function Transfere(Numero,Tipo_Funcionario,Posicao_Vetor) 
	{
	try //Estou usando tratamento de erro pois caso for da solicitacao de atendimento o campo tem um nome e se vier da abertura do atendimento o campo tem outro nome
		{ 
			if (Tipo_Funcionario=="1") //Tipo 1 -- Medico
			{
				window.opener.document.formCadastro.Medico_CRM.value = Numero; //Envia para o campo da pagina 
				window.opener.CarregaMedico();
				window.close();
				return
			}
			if (Tipo_Funcionario=="2") //Tipo 2 -- Enfermeiro
			{
				window.opener.document.formCadastro.Enfermeiro_COREN.value = Numero; //Envia para o campo da pagina 
				window.opener.CarregaEnfermeiro();
				window.close();
				return
			}
			if (Tipo_Funcionario=="3") //Tipo 3 -- Equipe enfermagem
			{
				window.opener.document.formCadastro.Enfermagem_COREN[Posicao_Vetor].value = Numero; //Envia para o campo da pagina 
				window.opener.CarregaEnfermagem(window.opener.document.formCadastro.Enfermagem_COREN,Posicao_Vetor);
				window.close();
				return
			}
			if (Tipo_Funcionario=="4") //Tipo 4 -- Fisioterapeuta
			{
				window.opener.document.formCadastro.Fisioterapeuta_CREFITO[Posicao_Vetor].value = Numero; //Envia para o campo da pagina 
				window.opener.CarregaFisiterapeuta(window.opener.document.formCadastro.Fisioterapeuta_CREFITO,Posicao_Vetor);
				window.close();
				return
			}
			if (Tipo_Funcionario=="5") //Tipo 5 -- Outros Serviços
			{
				window.opener.document.formCadastro.Outros_Servicos_Codigo[Posicao_Vetor].value = Numero; //Envia para o campo da pagina 
				window.opener.CarregaOutrosServicos(window.opener.document.formCadastro.Outros_Servicos_Codigo,Posicao_Vetor);
				window.close();
				return
			}
		}
	catch(e)//Caso houve erro então é mostrado a descrição do erro
			{ 
				alert(e.descripition); //Descricao do erro
			}

	}
//-->
</script>
<%
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE JÁ EXISTEM
Function VisualizarFuncionarios

	dim pag
	regs = 20 'Aqui setamos quantos registros serão listados por página. 
	pag = request.querystring("pagina")
	if pag = "" Then pag = 1 end if
	set rs = createobject("adodb.recordset")
	rs.cursortype = 3 'Definimos o cursor a ser utilizado
	rs.pagesize = regs
	RS.CursorLocation = 3 

	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.Funcionarios_Visualizar '"&Request("Nome")&"' , '"&Request("id_Departamento")&"' , '"&Request("id_Cargo")&"' , '"&Request("id_Especializacao")&"' , '"&Request("id_Disponibilidade")&"' , '"&Request("id_Cobertura")&"', '' , '' , '"&Request("id_Cor_Pele")&"' , '"&Request("Sexo")&"' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					rs.absolutepage = pag
					For x = 1 To Rs.Pagesize
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' style='Cursor: Pointer;' Onclick=""javascript:Transfere('"&Rs("CODIGO_MEDICO")&"' , '"&Request("Tipo_Funcionario")&"' , '"&Request("Posicao_Vetor")&"' )"">" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela' >" & Chr(10)
							Response.Write "<Td width='40%'>Funcionario:</Td>" & Chr(10)
							Response.Write "<Td width='10%'>Código:</Td>" & Chr(10)
							Response.Write "<Td width='30%'>Departamento:</Td>" & Chr(10)
							Response.Write "<Td width='30%'>Cargo:</Td>" & Chr(10)
							Response.Write "<Td width='20%'>Atend. Max.:</Td>" & Chr(10)
							Response.Write "<Td width='10%'>Saldo:</Td>" & Chr(10)
						Response.Write "</Tr>"& Chr(10)

						Response.Write "<Tr class='zebra1'>" & Chr(10)
							Response.Write "<Td width='30%'>"&UCASE(Rs("Nome"))&"</Td>" & Chr(10)
							Response.Write "<Td width='10%'>"&Rs("Codigo_Medico")&"</Td>" & Chr(10)
							Response.Write "<Td width='15%'>"&UCASE(Rs("Departamento"))&"</Td>" & Chr(10)
							Response.Write "<Td width='15%'>"&UCASE(Rs("Cargo"))&"</Td>" & Chr(10)
							Response.Write "<Td width='20%'>"&Rs("Qtd_Maxima_Atendimento")&"</Td>" & Chr(10)
							Response.Write "<Td width='10%'>"&Rs("Funcionario_Atendimento_Saldo")&"</Td>" & Chr(10)
						Response.Write "</Tr>" & Chr(10)
							Response.Write "<Tr class='zebra1'>" & Chr(10)
								Response.Write "<Td colspan='6'>" & Chr(10)
									Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0'>" & Chr(10)
										Response.Write "<tr>" & Chr(10)
											Response.Write "<td valign='top' width='10%'>"&Funcionario_Imagem(Rs("id"),"60","80")&"</td>" & Chr(10)
											Response.Write "<td valign='top' width='25%'> <img src='/SmartCare/images/placa_Especializacoes.gif' >"&Funcionarios_Especializacao(Rs("id"))&"</td>" & Chr(10)
											Response.Write "<td valign='top' width='25%'><img src='/SmartCare/images/placa_Disponibilidades.gif'  >"&Funcionarios_Disponibilidade(Rs("id"))&"</td>" & Chr(10)
											Response.Write "<td valign='top' width='40%'><img src='/SmartCare/images/placa_Cobertura.gif'  >"&Funcionarios_Cobertura(Rs("id"))&"</td>" & Chr(10)
										Response.Write "</tr>" & Chr(10)
								    Response.Write "</table> " & Chr(10)
								Response.Write "</Td>" & Chr(10)
							Response.Write "</Tr>" & Chr(10)
							Response.Write "</Table>"
					Rs.MoveNext
					Next
				Else 'Caso não seja encontrado nenhum registro
					Response.Write "<Table><tr><td class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
					'Inicio da paginação
							'Caso tenha algum campo de busca na pagina coloque aqui o nome dele. Isso foi feito para nãi ter que ficar colocando em varios lugares
							VariaveisBusca = "Action="&Request("action")&"&Tipo_Funcionario="&Request("Tipo_Funcionario")&"&Posicao_Vetor="&Request("Posicao_Vetor")&"&Nome="&Request("Nome")&"&id_Cobertura="&Request("id_Cobertura")&"&id_Departamento="&Request("id_Departamento")&"&id_Cargo="&Request("id_Cargo")&"&id_Disponibilidade="&Request("id_Disponibilidade")&"&id_Especializacao="&Request("id_Especializacao")&"&id_Cor_Pele="&Request("id_Cor_Pele")&"&Sexo="&Request("Sexo")&"  "
							Response.Write "<div align='center' class='texto'>"&"Total de registros encontrados: " & rs.RecordCount & "</Div>"
							Response.Write "<div align='center' class='texto'>Página <b>" & pag & "</b> de " & rs.PageCount & "</Div>"
							If rs.PageCount <= 5 Then
								pinicial = 1
								pfinal = rs.PageCount
							Else
								pinicial = pag - pag mod 15 + 1
								pfinal = pag - pag mod 15 + 15
								If pinicial = pag + 1 Then
									pinicial = pinicial - 15
									pfinal = pfinal - 15
								End If
								If pfinal > rs.PageCount Then
									pfinal = rs.PageCount
								End If
							End If
							Response.Write "<div align='center' class='texto'>"
							If pag > 1 Then Response.Write "<a href=""" & SCRIPT_NAME & "?"&VariaveisBusca&"&pagina=" & pag - 1 & """>&lt;&lt; Anterior</a> |" 
							While pinicial <= pfinal
								If trim(pinicial) = trim(n) Then Response.Write "<b>" 
								Response.Write	"<a href=""" & SCRIPT_NAME & "?"&VariaveisBusca&"&pagina=" & pinicial & """>" & pinicial & "</a> " 
								If trim(pinicial) = trim(n) Then Response.Write "</b>"
								pinicial = pinicial + 1
							Wend
							If Abs(pag) < Abs(rs.PageCount) Then Response.Write "| <a href=""" & SCRIPT_NAME & "default.asp?"&VariaveisBusca&"&pagina=" & pag + 1 & """>Próxima &gt;&gt;</a>" 
							Response.Write "</div>"
					'Fim da paginação					
			Rs.Close
			Set Rs = Nothing

End Function


'FUNÇÃO QUE MONTA A LISTA DE COBERTURAS PARA SEREM SELECIONADAS DIVERSAS COBERTURAS
Function Cobertura
	
	SQL = 	"SELECT  * " &_
	  		"FROM FuncionariosXCobertura " &_
			"Where id_Funcionario = '"&request("id")&"' "
			set rs2 = createobject("adodb.recordset")
			Rs2.open SQL, CONN, 3

	SQL = 	"SELECT  * " &_
	  		"FROM COBERTURA " &_
			"Order By nome "
			set Rs = createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				If Rs.eof Then
   					response.write  "Nenhuma cobertura encontrada " & "<br>"
					else
						Content = ""
						Content = Content &_
						"<select name='id_cobertura' size='12' multiple>"
							For x = 1 to rs.recordcount
								IF Not Rs2.eof then
									selected = ""
										For y=1 to rs2.recordcount
											If trim(rs("id")) = Trim(rs2("id_cobertura")) Then
												selected = "selected"
											End If
										rs2.movenext
										next
										rs2.movefirst
								End if
										Content = Content &_
										"<option value=""" & rs("id") & """ " & selected & ">" & rs("nome") & "</option>"
							rs.movenext
							next
							Rs.Close
							Set Rs = Nothing
							Rs2.Close
							Set Rs2 = Nothing
				End if
				Cobertura = Content & "</select>"

End Function

'FUNÇÃO QUE MONTA A LISTA DE COBERTURAS PARA SEREM SELECIONADAS DIVERSAS COBERTURAS
Function Especializacao
	
	SQL = 	"SELECT  * " &_
	  		"FROM FuncionariosXEspecializacao " &_
			"Where id_Funcionario = '"&request("id")&"' "
			set rs2 = createobject("adodb.recordset")
			Rs2.open SQL, CONN, 3

	SQL = 	"SELECT  * " &_
	  		"FROM ESPECIALIZACOES " &_
			"Order By Descricao "
			set Rs = createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				If Rs.eof Then
   					response.write  "Nenhuma especialização encontrada " & "<br>"
					else
						Content = ""
						Content = Content &_
						"<select name='id_especializacao' size='12' multiple>"
							For x = 1 to rs.recordcount
								IF Not Rs2.eof then
									selected = ""
										For y=1 to rs2.recordcount
											If trim(rs("id")) = Trim(rs2("id_especializacao")) Then
												selected = "selected"
											End If
										rs2.movenext
										next
										rs2.movefirst
								End if
										Content = Content &_
										"<option value=""" & rs("id") & """ " & selected & ">" & rs("Descricao") & "</option>"
							rs.movenext
							next
							Rs.Close
							Set Rs = Nothing
							Rs2.Close
							Set Rs2 = Nothing
				End if
				Especializacao = Content & "</select>"

End Function

'FUNÇÃO QUE MONTA A LISTA DE DISPONIBILIDADES PARA SEREM SELECIONADAS
Function Disponibilidade
	
	SQL = 	"SELECT  * " &_
	  		"FROM FuncionariosXDisponibilidade " &_
			"Where id_Funcionario = '"&request("id")&"' "
			set rs2 = createobject("adodb.recordset")
			Rs2.open SQL, CONN, 3

	SQL = 	"SELECT  * " &_
	  		"FROM DISPONIBILIDADES " &_
			"Order By Descricao "
			set Rs = createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				If Rs.eof Then
   					response.write  "Nenhuma disponibilidade encontrada " & "<br>"
					else
						Content = ""
						Content = Content &_
						"<select name='id_disponibilidade' size='12' multiple>"
							For x = 1 to rs.recordcount
								IF Not Rs2.eof then
									selected = ""
										For y=1 to rs2.recordcount
											If trim(rs("id")) = Trim(rs2("id_disponibilidade")) Then
												selected = "selected"
											End If
										rs2.movenext
										next
										rs2.movefirst
								End if
										Content = Content &_
										"<option value=""" & rs("id") & """ " & selected & ">" & rs("Descricao") & "</option>"
							rs.movenext
							next
							Rs.Close
							Set Rs = Nothing
							Rs2.Close
							Set Rs2 = Nothing
				End if
				Disponibilidade = Content & "</select>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case Else
%>
	<!-- #include virtual="/SmartCare/MODULOS/HomeCare/Busca_Funcionario/modelos/Form_Visualizar_Funcionarios.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>
