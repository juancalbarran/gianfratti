<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 29/08/2006
' Descrição: Pagina de busca pela tabela BrasIndice
' Atualizado por: -
' Data: -
' Atualização: -
%>
<script language="javascript">
<!--
//FUNÇÃO QUE TRANSFERE O CONTEUDO DA PAGINA PARA OUTRA PAGINA
function Transfere(Numero,Tipo_Busca_Simpro,Posicao_Vetor) 
	{
	try //Estou usando tratamento de erro pois caso for da solicitacao de atendimento o campo tem um nome e se vier da abertura do atendimento o campo tem outro nome
		{ 
			if (Tipo_Busca_Simpro=="200") //Tipo 200 é a mesma consulta que o tipo 20 que é material SmartCare foi colocado o 200 apenas para diferenciar os campo no retorno para a pagina de baixo 
			{
				window.opener.document.formCadastro.Cod_Simpro_Equipamentos[Posicao_Vetor].value = Numero; //Envia para o campo da pagina 
				window.opener.CarregaSimproEquipamentos(window.opener.document.formCadastro.Cod_Simpro_Equipamentos,Posicao_Vetor);
				window.close();
				return
			}
			if (Tipo_Busca_Simpro=="20") //Tipo 200 -- Material SmartCare
			{
				window.opener.document.formCadastro.Cod_Simpro_Materiais[Posicao_Vetor].value = Numero; //Envia para o campo da pagina 
				window.opener.CarregaSimproMateriais(window.opener.document.formCadastro.Cod_Simpro_Materiais,Posicao_Vetor);
				window.close();
				return
			}
			if (Tipo_Busca_Simpro=="50") //Tipo 50 -- Medicamento
			{
				window.opener.document.formCadastro.Cod_Simpro_Medicamento[Posicao_Vetor].value = Numero; //Envia para o campo da pagina 
				window.opener.CarregaSimproMedicamento(window.opener.document.formCadastro.Cod_Simpro_Medicamento,Posicao_Vetor);
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
set Conn = Server.CreateObject( "ADODB.Connection" )
Conn.CursorLocation = 3 'adUserClient
Conn.Open application("connstring")

'Função que mostra todos os produtos simpro
Function VisualizarSimpro

	dim pag
	regs = 25 'Aqui setamos quantos registros serão listados por página. 
	pag = request.querystring("pagina")
		if pag = "" Then
		   pag = 1
		end if
	set rs = createobject("adodb.recordset")
	rs.cursortype = 3 'Definimos o cursor a ser utilizado
	rs.pagesize = regs

	SQL	=	"Select * From BrasIndice "
			clausula = " WHERE  "
				if Trim(Request("CodLaboratorio")) <> "" Then
					sql = sql & clausula & " CodLaboratorio like '%"&Trim(Replace(Request("CodLaboratorio"),"'","''"))&"%'  "
					clausula = "and "
				end if
				if Trim(Request("DescLaboratorio")) <> "" Then
					sql = sql & clausula & " DescLaboratorio = '"&Trim(Replace(Request("DescLaboratorio"),"'","''"))&"'  "
					clausula = "and "
				end if
				if Trim(Request("CodMedicamento")) <> "" Then
					sql = sql & clausula & " CodMedicamento like '%"&Trim(Replace(Request("CodMedicamento"),"'","''"))&"%'  "
					clausula = "and "
				end if
				if Trim(Request("DescMedicamento")) <> "" Then
					sql = sql & clausula & " DescMedicamento like '%"&Trim(Replace(Request("DescMedicamento"),"'","''"))&"%'  "
					clausula = "and "
				end if
				if Trim(Request("DescApresentacao")) <> "" Then
					sql = sql & clausula & " DescApresentacao like '%"&Trim(Replace(Request("DescApresentacao"),"'","''"))&"%'  "
					clausula = "and "
				end if
				if Trim(Request("EdicaoBrasIndice")) <> "" Then
					sql = sql & clausula & " EdicaoBrasIndice = '"&Trim(Replace(Request("EdicaoBrasIndice"),"'","''"))&"'  "
					clausula = "and "
				end if
				sql = sql & "Order By CodLaboratorio, CodMedicamento "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					rs.absolutepage = pag
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>Código:</Td>" & Chr(10)
							Response.Write "<Td>Edição:</Td>" & Chr(10)
							Response.Write "<Td>Laboratório:</Td>" & Chr(10)
							Response.Write "<Td>Cod. Med.:</Td>" & Chr(10)
							Response.Write "<Td>Desc. Med.:</Td>" & Chr(10)
							Response.Write "<Td>Cod. Apr.:</Td>" & Chr(10)
							Response.Write "<Td>Descrição:</Td>" & Chr(10)
							Response.Write "<Td>Tipo Preço:</Td>" & Chr(10)
							Response.Write "<Td>IPI:</Td>" & Chr(10)
							Response.Write "<Td>PIS/COFINS:</Td>" & Chr(10)
							Response.Write "<Td>Preço:</Td>" & Chr(10)
							Response.Write "<Td>Qtd:</Td>" & Chr(10)
							Response.Write "<Td>Preço Uni.:</Td>" & Chr(10)
							Response.Write "<Td>&nbsp;</Td>" & Chr(10)
						Response.Write "</Tr>"
					For x = 1 To Rs.Pagesize
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If Not Response.IsClientConnected  Then Rs.close : Set Rs = Nothing : Conn.Close : set Conn = nothing  : Response.end 'Verifica se o usuario ainda esta conectado na consulta
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("CodLaboratorio")&Rs("CodMedicamento")&Rs("CodApresentacao")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center'>"&Rs("EdicaoBrasIndice")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("DescLaboratorio")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("CodMedicamento")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("DescMedicamento")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Rs("CodApresentacao")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("DescApresentacao")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center'>"&Rs("TipoPreco")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center'>"&Rs("IPI")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center'>"&Rs("PIS_COFINS")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Rs("Preco")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Rs("Qtd")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center'>"&Rs("PrecoUnitario")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&"<a href=""javascript:Transfere('"&Rs("CodApresentacao")&"' , '"&Request("Tipo_Busca_Simpro")&"' , '"&Request("Posicao_Vetor")&"'  )"" ><img src='/SmartCare/images/ico_seta_baixo.gif' border='0' alt='Clique para selecionar este médico'   ></a>"&"</Td>" & Chr(10)
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
					Response.Write "</Table>"
				Else 'Caso não seja encontrado nenhum registro
					Response.Write "<Table width='100%' border='0'><tr><td align ='center' class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
					'Inicio da paginação
							'Caso tenha algum campo de busca na pagina coloque aqui o nome dele. Isso foi feito para nãi ter que ficar colocando em varios lugares
							VariaveisBusca = "Action="&Request("action")&"&CodLaboratorio="&Request("CodLaboratorio")&"&DescLaboratorio="&Request("DescLaboratorio")&"&CodMedicamento="&Request("CodMedicamento")&"&DescMedicamento="&Request("DescMedicamento")&"&DescApresentacao="&Request("DescApresentacao")&"&EdicaoBrasIndice="&Request("EdicaoBrasIndice")&"&Tipo_Busca_Simpro="&Request("Tipo_Busca_Simpro")&"&Posicao_Vetor="&Request("Posicao_Vetor")
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

Function GeraFornecedores

	'[CONEXÃO COM O BANCO DE DADOS]
	set Conn = Server.CreateObject( "ADODB.Connection" )
	Conn.CursorLocation = 3 'adUserClient
	Conn.Open application("connstring")

	SQL =	"SELECT DISTINCT CodLaboratorio, DescLaboratorio " &_ 
			"FROM BrasIndice " &_ 
			"ORDER BY DescLaboratorio "
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.open SQL, conn, 3
			content = "<select name='CodLaboratorio' class=campos>"
			If Not rs.EOF Then
				content = content & "<option value=''><<--Selecione-->></option>"
				For i = 1 to rs.RecordCount
					If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
					selected = ""
					If trim(rs("CodLaboratorio")) = trim(Request("CodLaboratorio")) Then
						selected = "selected"
					End If
					content = content & "<option class='"&zebrado&"' value=" & rs("CodLaboratorio") & " " & selected & ">" & rs("DescLaboratorio") & "</option>"
				rs.MoveNext
				Next
			Else
				content = content & "<option value=''>Não foram encontrados registros</option>"
			End If
			content = content & "</select>"
			rs.close
			Set rs = Nothing
			GeraFornecedores = content

End Function

Function Edicao

	'[CONEXÃO COM O BANCO DE DADOS]
	set Conn = Server.CreateObject( "ADODB.Connection" )
	Conn.CursorLocation = 3 'adUserClient
	Conn.Open application("connstring")

	SQL =	"SELECT DISTINCT EdicaoBrasIndice " &_ 
			"FROM BrasIndice " &_ 
			"ORDER BY EdicaoBrasIndice Desc"
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.open SQL, conn, 3
			content = "<select name='EdicaoBrasIndice' class=campos>"
			If Not rs.EOF Then
				content = content & "<option value=''><<--Selecione-->></option>"
				For i = 1 to rs.RecordCount
					If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
					selected = ""
					If trim(rs("EdicaoBrasIndice")) = trim(Request("EdicaoBrasIndice")) Then
						selected = "selected"
					End If
					content = content & "<option class='"&zebrado&"' value=" & rs("EdicaoBrasIndice") & " " & selected & ">" & rs("EdicaoBrasIndice") & "</option>"
				rs.MoveNext
				Next
			Else
				content = content & "<option value=''>Não foram encontrados registros</option>"
			End If
			content = content & "</select>"
			rs.close
			Set rs = Nothing
			Edicao = content

End Function


'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction
	
	Case Else
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Busca_BrasIndice/modelos/Form_Visualizar_Simpro.htm" -->
<%
End Select

'[Fecha Conexão Com Banco De Dados]
Conn.close
set Conn = nothing
%>
