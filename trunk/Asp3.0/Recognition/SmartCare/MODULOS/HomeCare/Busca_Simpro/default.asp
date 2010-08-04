<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 16/08/2005
' Descrição: Pagina de busca de produtos Simpro
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

	SQL	=	"Select * From Simpro "
			clausula = " WHERE  "
				if Trim(Request("CD_Simpro")) <> "" Then
					sql = sql & clausula & " CD_Simpro like '%"&Trim(Replace(Request("CD_Simpro"),"'","''"))&"%'  "
					clausula = "and "
				end if
				if Trim(Request("Descricao")) <> "" Then
					sql = sql & clausula & " Descricao like '%"&Trim(Replace(Request("Descricao"),"'","''"))&"%'  "
					clausula = "and "
				end if
				if Trim(Request("Fabrica")) <> "" Then
					sql = sql & clausula & " Fabrica like '%"&Trim(Replace(Request("Fabrica"),"'","''"))&"%'  "
					clausula = "and "
				end if
				if Trim(Request("Tipo_Produto_Simpro")) <> "" Then
					sql = sql & clausula & " Cd_Mercado like '%"&Trim(Replace(Request("Tipo_Produto_Simpro"),"'","''"))&"%'  "
					clausula = "and "
				end if
				sql = sql & "Order By Descricao "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					rs.absolutepage = pag
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>Cod. Simpro:</Td>" & Chr(10)
							Response.Write "<Td>Descrição:</Td>" & Chr(10)
							Response.Write "<Td>Vigencia:</Td>" & Chr(10)
							Response.Write "<Td>Tipo Embalagem:</Td>" & Chr(10)
							Response.Write "<Td>Tipo Fração:</Td>" & Chr(10)
							Response.Write "<Td>Qtd Embalagem:</Td>" & Chr(10)
							Response.Write "<Td>Qtd Fração:</Td>" & Chr(10)
							Response.Write "<Td>Fabricante:</Td>" & Chr(10)
							Response.Write "<Td>Tipo Produto:</Td>" & Chr(10)
							Response.Write "<Td>&nbsp;</Td>" & Chr(10)
						Response.Write "</Tr>"
					For x = 1 To Rs.Pagesize
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If Not Response.IsClientConnected  Then Rs.close : Set Rs = Nothing : Conn.Close : set Conn = nothing  : Response.end 'Verifica se o usuario ainda esta conectado na consulta
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						If Rs("Cd_Mercado") = "20" Then Cd_Mercado = "Material SmartCare ou Equipamentos" End if
						If Rs("Cd_Mercado") = "50" Then Cd_Mercado = "Medicamento" End if
						If Rs("Cd_Mercado") = "70" Then Cd_Mercado = "Perfumaria" End if
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td style='Cursor: Pointer;' class='"&zebrado&"'>"&Rs("Cd_Simpro")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Descricao")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Vigencia")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Rs("TP_Embal")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Rs("TP_Fracao")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Rs("QTDE_EMBAL")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Rs("QTDE_FRAC")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Fabrica")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Cd_Mercado&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&"<a href=""javascript:Transfere('"&Rs("Cd_Simpro")&"' , '"&Request("Tipo_Busca_Simpro")&"' , '"&Request("Posicao_Vetor")&"'  )"" ><img src='/SmartCare/images/ico_seta_baixo.gif' border='0' alt='Clique para selecionar este médico'   ></a>"&"</Td>" & Chr(10)
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
					Response.Write "</Table>"
				Else 'Caso não seja encontrado nenhum registro
					Response.Write "<Table width='100%' border='0'><tr><td align ='center' class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
					'Inicio da paginação
							'Caso tenha algum campo de busca na pagina coloque aqui o nome dele. Isso foi feito para nãi ter que ficar colocando em varios lugares
							VariaveisBusca = "Action="&Request("action")&"&Cod_Simpro="&Request("Cod_Simpro")&"&Descricao="&Request("Descricao")&"&Fabrica="&Request("Fabrica")&"&Tipo_Busca_Simpro="&Request("Tipo_Busca_Simpro")&"&Posicao_Vetor="&Request("Posicao_Vetor")
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

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction
	
	Case Else
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Busca_Simpro/modelos/Form_Visualizar_Simpro.htm" -->
<%
End Select

'[Fecha Conexão Com Banco De Dados]
Conn.close
set Conn = nothing
%>
