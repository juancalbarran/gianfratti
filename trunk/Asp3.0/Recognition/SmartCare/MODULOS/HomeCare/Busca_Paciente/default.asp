<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 25/07/2005
' Descrição: Pagina de busca de pacientes
' Atualizado por: -
' Data: -
' Atualização: -
%>
<script language="javascript">
<!--
//FUNÇÃO QUE TRANSFERE O CONTEUDO DA PAGINA PARA OUTRA PAGINA
function Transfere(Numero) 
	{
	//Numero = Numero.substring(0,3) + "." + Numero.substring(4,7) + "." + Numero.substring(8,11) + "." +  Numero.substring(12,14) + '-' ; 
	window.opener.document.form.busca.value = Numero; //Envia para o campo da pagina 
	window.opener.CarregaPacientes();
	window.close();
	return
	}
//-->
</script>
<%
'[CONEXÃO COM O BANCO DE DADOS]
set Conn = Server.CreateObject( "ADODB.Connection" )
Conn.CursorLocation = 3 'adUserClient
Conn.Open application("connstring")

'Função que mostra todos os medicos
Function VisualizarPacientes

	dim pag
	regs = 15 'Aqui setamos quantos registros serão listados por página. 
	pag = request.querystring("pagina")
		if pag = "" Then
		   pag = 1
		end if
	set rs = createobject("adodb.recordset")
	rs.cursortype = 3 'Definimos o cursor a ser utilizado
	rs.pagesize = regs

	SQL	=	"Select Id,Nome,RG,CPF From Pacientes " 
 			clausula = "WHERE "
				if Trim(Request("Nome")) <> "" Then
					sql = sql & clausula & " Nome like '%"&Trim(Replace(Request("Nome"),"'","''"))&"%'  "
					clausula = "and "
				end if
				if Trim(Request("RG")) <> "" Then
					sql = sql & clausula & " RG like '%"&Trim(Replace(Request("RG"),"'","''"))&"%'  "
					clausula = "and "
				end if
				if Trim(Request("CPF")) <> "" Then
					sql = sql & clausula & " CPF like '%"&Trim(Replace(Request("CPF"),"'","''"))&"%'  "
					clausula = "and "
				end if
				If Session("Tipo_Login") = "2" Then
					sql = sql & clausula & " id_Convenio = '"&Session("id_Convenio")&"'  "
					clausula = "and "								
				End if
				sql = sql & "Order By Nome "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					rs.absolutepage = pag
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>Nome:</Td>" & Chr(10)
							Response.Write "<Td>RG:</Td>" & Chr(10)
							Response.Write "<Td>CPF:</Td>" & Chr(10)
							Response.Write "<Td>&nbsp;</Td>" & Chr(10)
						Response.Write "</Tr>"
					For x = 1 To Rs.Pagesize
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						If Verifica_Paciente_Atendimento(Rs("id"))  Then 
							imagem = "<a href=""javascript:Transfere('"&MascaraCPF(Rs("CPF"))&"' )"" ><img src='/SmartCare/images/ico_seta_baixo.gif' border='0' alt='Clique para selecionar este paciente'   ></a>"
							Else
							imagem = "<img src='/SmartCare/images/ico_cadeado.gif' border='0' alt='Já exsite uma solicitacao em analise para este paciente'   >" 
						End if
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td style='Cursor: Pointer;' class='"&zebrado&"'>"&Rs("Nome")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' >"&MascaraRG(Rs("RG"))&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' >"&MascaraCPF(Rs("CPF"))&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td width='3%' class='"&zebrado&"'>"&imagem&"&nbsp;</Td>" & Chr(10)
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
					Response.Write "</Table>"
				Else 'Caso não seja encontrado nenhum registro
					Response.Write "<Table width='100%' border='0'><tr><td align ='center' class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
					'Inicio da paginação
							'Caso tenha algum campo de busca na pagina coloque aqui o nome dele. Isso foi feito para nãi ter que ficar colocando em varios lugares
							VariaveisBusca = "Nome="&Request("Nome")&"&RG="&Request("RG")&"&CPF="&Request("CPF")
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

'Função resposavel por verifiar se o paciente já possui uma solicitacao de atendimento aberto
'Caso o paciente não tenha nenhuma solicitacao em analise entao retorna TRUE senao, se caso tenha a solicitacao em aberta entao retorna False
Function Verifica_Paciente_Atendimento(id_Paciente)

	SQL	=	"SELECT nome, id " &_ 
			"FROM dbo.Pacientes " &_ 
			"WHERE (id = '"&Id_Paciente&"') AND (NOT EXISTS " &_ 
                    "(SELECT TOP 1 1 " &_ 
                    "FROM HomeCare_Solicitacao_Atendimento a " &_ 
                    "WHERE a.id_Solicitacao_Status = 1 AND a.id_paciente = '"&Id_Paciente&"')) " 
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof Then 'Se não for vazio entao o paciente nao esta em atendimento
					Verifica_Paciente_Atendimento = True 'true quer dizer que o paciente nao esta em atendimento
					Else
						Verifica_Paciente_Atendimento = False 'false quer dizer que o paciente ja se encontra em atendimento
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction
	
	Case Else 
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Busca_Paciente/modelos/Form_Visualizar_Pacientes.htm" -->
<%
End Select

'[Fecha Conexão Com Banco De Dados]
Conn.close
set Conn = nothing
%>
