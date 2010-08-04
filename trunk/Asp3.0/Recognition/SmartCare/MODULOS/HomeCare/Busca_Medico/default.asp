<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 21/07/2005
' Descrição: Pagina de busca de medicos
' Atualizado por: -
' Data: -
' Atualização: -
%>
<script language="javascript">
<!--
//FUNÇÃO QUE TRANSFERE O CONTEUDO DA PAGINA PARA OUTRA PAGINA
function Transfere(Numero) 
	{
	try //Estou usando tratamento de erro pois caso for da solicitacao de atendimento o campo tem um nome e se vier da abertura do atendimento o campo tem outro nome
		{ 
			window.opener.document.formCadastro.Medico_Solicitante_CRM.value = Numero; //Envia para o campo da pagina 
			window.opener.CarregaMedico();
			window.close();
			return
		}
	catch(e)//Caso houve erro entao a requisicao é da abertura do atendimento
			{ 
				window.opener.document.formCadastro.Medico_CRM.value = Numero; //Envia para o campo da pagina 
				window.opener.CarregaMedico();
				window.close();
				return
			}

	}
//-->
</script>
<%
'[CONEXÃO COM O BANCO DE DADOS]
set Conn = Server.CreateObject( "ADODB.Connection" )
Conn.CursorLocation = 3 'adUserClient
Conn.Open application("connstring")

'Função que mostra todos os medicos
Function VisualizarMedicos

	dim pag
	regs = 25 'Aqui setamos quantos registros serão listados por página. 
	pag = request.querystring("pagina")
		if pag = "" Then
		   pag = 1
		end if
	set rs = createobject("adodb.recordset")
	rs.cursortype = 3 'Definimos o cursor a ser utilizado
	rs.pagesize = regs

	SQL	=	"Select Codigo,Nome,S,Dt_Inscr,Dt_Inat,Cidade,UF,Especialidades From Cremesp_medicos "
			clausula = " WHERE  "
				if Trim(Request("CRM")) <> "" Then
					sql = sql & clausula & " Codigo like '%"&Trim(Replace(Request("CRM"),"'","''"))&"%'  "
					clausula = "and "
				end if
				if Trim(Request("Nome")) <> "" Then
					sql = sql & clausula & " Nome like '%"&Trim(RemoveAcentos(Replace(Request("Nome"),"'","''")))&"%'  "
					clausula = "and "
				end if
				if Trim(Request("Especialidade")) <> "" Then
					sql = sql & clausula & " Especialidades like '%"&Trim(RemoveAcentos(Replace(Request("Especialidade"),"'","''")))&"%'  "
					clausula = "and "
				end if
				if Trim(Request("Cidade")) <> "" Then
					sql = sql & clausula & " Cidade like '%"&Trim(RemoveAcentos(Replace(Request("Cidade"),"'","''")))&"%'  "
					clausula = "and "
				end if
				if Trim(Request("Status")) <> "" Then
					sql = sql & clausula & " S = '"&Trim(Replace(Request("Status"),"'","''"))&"'  "
					clausula = "and "
				end if
				sql = sql & "Order By S , Nome "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					rs.absolutepage = pag
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>Status:</Td>" & Chr(10)
							Response.Write "<Td>CRMº:</Td>" & Chr(10)
							Response.Write "<Td>Nome:</Td>" & Chr(10)
							Response.Write "<Td>Especialidades:</Td>" & Chr(10)
							Response.Write "<Td>Cidade:</Td>" & Chr(10)
							Response.Write "<Td>UF:</Td>" & Chr(10)
							Response.Write "<Td>Inscrição:</Td>" & Chr(10)
							Response.Write "<Td>Inatividade:</Td>" & Chr(10)
							Response.Write "<Td>&nbsp;</Td>" & Chr(10)
						Response.Write "</Tr>"
					For x = 1 To Rs.Pagesize
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If Not Response.IsClientConnected  Then Rs.close : Set Rs = Nothing : Conn.Close : set Conn = nothing  : Response.end 'Verifica se o usuario ainda esta conectado na consulta
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						If Rs("S") = "A" Then 
							S = "Ativo" 
							Imagem = "<a href=""javascript:Transfere('"&Rs("Codigo")&"' )"" ><img src='/SmartCare/images/ico_seta_baixo.gif' border='0' alt='Clique para selecionar este médico'   ></a>"
							Else 
							S = "Inativo" 
							Imagem = "<img src='/SmartCare/images/ico_cadeado.gif' border='0' alt='Médico não esta exercendo a profissão'   >" 
						End If
						If Not Isdate(Rs("dt_Inat"))  Then dt_Inat = "" Else dt_Inat = ArrumaData(Rs("dt_Inat")) End if
						If Not Isdate(Rs("dt_Inscr"))  Then dt_Inscr = "" Else dt_Inscr = ArrumaData(Rs("dt_Inscr")) End if
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td style='Cursor: Pointer;' class='"&zebrado&"'>"&S&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Rs("Codigo")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Nome")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Especialidades")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Cidade")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Uf")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&dt_Inscr&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&dt_Inat&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Imagem&"&nbsp;</Td>" & Chr(10)
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
					Response.Write "</Table>"
				Else 'Caso não seja encontrado nenhum registro
					Response.Write "<Table width='100%' border='0'><tr><td align ='center' class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
					'Inicio da paginação
							'Caso tenha algum campo de busca na pagina coloque aqui o nome dele. Isso foi feito para nãi ter que ficar colocando em varios lugares
							VariaveisBusca = "Action="&Request("action")&"&Nome="&Request("Nome")&"&CRM="&Request("CRM")&"&Especialidade="&Request("Especialidade")&"&Cidade="&Request("Cidade")&"&Status="&Request("Status")&" "
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
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Busca_Medico/modelos/Form_Visualizar_Medicos.htm" -->
<%
End Select

'[Fecha Conexão Com Banco De Dados]
Conn.close
set Conn = nothing
%>
