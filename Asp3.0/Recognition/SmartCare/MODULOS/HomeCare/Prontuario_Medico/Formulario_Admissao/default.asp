<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.Js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 28/09/2005
' Descrição: Pagina de Preenchimento de formulario de Admissão
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[CONEXÃO COM O BANCO DE DADOS]
set Conn = Server.CreateObject( "ADODB.Connection" )
Conn.CursorLocation = 3 'adUserClient
Conn.Open application("connstring")

Function Visualiza_Pacientes

	SQL =	"SELECT DISTINCT "&_ 
			"dbo.Pacientes.nome, dbo.Convenios.Convenio,  " &_ 
			"dbo.HomeCare_Atendimento_Status_Condicoes_Alta.Descricao AS Descricao_Status_Alta, "&_ 
			"dbo.HomeCare_Atendimento.id_Atendimento_Status_Condicoes_Alta, dbo.View_Atendimento_Funcionarios.id_Atendimento "&_ 
			"FROM  dbo.View_Atendimento_Funcionarios INNER JOIN "&_ 
			"dbo.HomeCare_Atendimento ON dbo.View_Atendimento_Funcionarios.id_Atendimento = dbo.HomeCare_Atendimento.id INNER JOIN "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento ON  "&_ 
			"dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento = dbo.HomeCare_Solicitacao_Atendimento.id INNER JOIN "&_ 
			"dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id INNER JOIN "&_ 
			"dbo.HomeCare_Atendimento_Status_Condicoes_Alta ON "&_ 
			"dbo.HomeCare_Atendimento.id_Atendimento_Status_Condicoes_Alta = dbo.HomeCare_Atendimento_Status_Condicoes_Alta.id INNER JOIN "&_ 
			"dbo.Convenios ON dbo.HomeCare_Solicitacao_Atendimento.id_Convenio = dbo.Convenios.id " 
			clausula = " WHERE  "
				if Trim(Session("Tipo_Login")) = "2" Then 'Caso o usuario logado seja um contato entao ele somente vera o pacientes dele, caso contrario se ele for um funcionario entao ele vero todos os pacientes
					sql = sql & clausula & " dbo.HomeCare_Solicitacao_Atendimento.id_Convenio = '"&Session("id_Convenio")&"' AND (dbo.View_Atendimento_Funcionarios.id_Funcionario_Status = 1)  "
					clausula = "and "
				end if
				if Trim(Request("Nome")) <> "" Then
					sql = sql & clausula & " Pacientes.Nome like '%"&Trim(Replace(Request("Nome"),"'","''"))&"%'  "
					clausula = "and "
				end if
			sql = sql & "Order by id_Atendimento_Status_Condicoes_Alta "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						  Response.Write "<tr class='Titulo_Tabela'>" & CHR(10)
							Response.Write "<td  valign='top' width='3%'>&nbsp;</td>" & CHR(10)
							Response.Write "<td  valign='top' width='9%'>Nº Atend.</td>" & CHR(10)
							Response.Write "<td  valign='top' width='26%'>Paciente</td>" & CHR(10)
							Response.Write "<td  valign='top' width='15%'>Convênio</td>" & CHR(10)
							Response.Write "<td  valign='top' width='15%'>Status</td>" & CHR(10)
							Response.Write "<td  valign='top' align='center' width='14%'>Form. Anamnese</td>" & CHR(10)
							Response.Write "<td  valign='top' align='center' width='21%'>Form. Exame Físico Adulto</td>" & CHR(10)

						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
							If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
							If Session("Tipo_Login") = "1" Then 'Verifica se o Usuario logado é um Funcionario, caso for entao apresenta o icono de editar
								if rs("id_Atendimento_Status_Condicoes_Alta") <> "1" Then  'Faz a verificação para saber se o status não esta em analise, caso nao esteja entao coloca uma figura do cadeado e nao habilita o link para edicao 
									Formulario_Anamnese = "<img src='\SmartCare\images\ico_cadeado.gif' border='0' alt='Paciente não se econtra mais em atendimento, para visualizar o formulário clique na imagem PDF ai lado' >"
									Formulario_ExameFisico = "<img src='\SmartCare\images\ico_cadeado.gif' border='0' alt='Paciente não se econtra mais em atendimento, para visualizar o formulário clique na imagem PDF ai lado' >"
									Else  'Caso ainda esteja em edicao entao é colocado a imagem de edicao e o link de acesso e o Link 
									Formulario_Anamnese = "<a href=""javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Prontuario/Default.asp?id_Atendimento="&Rs("id_Atendimento")&"&id_Formulario_Dinamico=1 ','1014','680',this,event)""><img src='\SmartCare\images\ico_editar.gif' border='0' alt='Preencher formulário' ></a>"
									Formulario_ExameFisico = "<a href=""javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Prontuario/Default.asp?id_Atendimento="&Rs("id_Atendimento")&"&id_Formulario_Dinamico=2 ','1014','680',this,event)""><img src='\SmartCare\images\ico_editar.gif' border='0' alt='Preencher formulário' ></a>"
								End if
							End if
						If rs("id_Atendimento_Status_Condicoes_Alta") = "1" Then 'Verifica o Status para colocar as images pintadas
							Flg_Imagem = "<img src='/SmartCare/images/Flg_verde.gif' border='0' alt='Em Atendimento'>"
							ElseIf rs("id_Atendimento_Status_Condicoes_Alta") = "2" Then
								Flg_Imagem = "<img src='/SmartCare/images/Flg_azul.gif' border='0' alt='Alta Clínica'>"
							ElseIf rs("id_Atendimento_Status_Condicoes_Alta") = "3" Then
								Flg_Imagem = "<img src='/SmartCare/images/Flg_amerelo_Escuro.gif' border='0' alt='Alta por reinternação SmartCare'>"
							ElseIf rs("id_Atendimento_Status_Condicoes_Alta") = "4" Then
								Flg_Imagem = "<img src='/SmartCare/images/Flg_vermelho.gif' border='0' alt='Exclusão Contratual'>"
							ElseIf rs("id_Atendimento_Status_Condicoes_Alta") = "5" Then
								Flg_Imagem = "<img src='/SmartCare/images/Flg_preto.gif' border='0' alt='Óbito'>"
						End if
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Flg_Imagem&"</Td>" & Chr(10)
							Response.Write "<td class='"&zebrado&"' valign='top' >"&Trim(Rs("id_Atendimento"))&"</td>" & CHR(10)
							Response.Write "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Nome"))&"</td>" & CHR(10)
							Response.Write "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Convenio"))&"</td>" & CHR(10)
							Response.Write "<td class='"&zebrado&"' valign='top'>"&Trim(Rs("Descricao_Status_Alta"))&"</td>" & CHR(10)
							
							'Response.Write "<td class='"&zebrado&"' valign='top' align='center'>"&Formulario_Anamnese&"&nbsp;</td>" & CHR(10)
							Response.Write "<td class='"&zebrado&"' valign='middle' align='center'>"&Formulario_Anamnese&"&nbsp;&nbsp;<a href='/SmartCare/Modulos/HomeCare/Prontuario_Medico/Formulario_Admissao/default.asp?action=MostraPDF&URL="&Application("dominio")&"/Modulos/HomeCare/Prontuario/Default.asp?id_Atendimento="&Rs("id_Atendimento")&"-id_Formulario_Dinamico=1' target='_blank'><img src='/SmartCare/images/ico_pdf.gif' border='0' target='_blank' ></a>"&"</td>" & CHR(10)
							
							'Response.Write "<td class='"&zebrado&"' valign='top' align='center'>"&Formulario_ExameFisico&"&nbsp;</td>" & CHR(10)
							Response.Write "<td class='"&zebrado&"' valign='middle' align='center'>"&Formulario_ExameFisico&"&nbsp;&nbsp;<a href='/SmartCare/Modulos/HomeCare/Prontuario_Medico/Formulario_Admissao/default.asp?action=MostraPDF&URL="&Application("dominio")&"/Modulos/HomeCare/Prontuario/Default.asp?id_Atendimento="&Rs("id_Atendimento")&"-id_Formulario_Dinamico=2' target='_blank'><img src='/SmartCare/images/ico_pdf.gif' border='0' target='_blank' ></a>"&"</td>" & CHR(10)

						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
						Response.Write "<Table width='100%' border='0' ><Tr><td align ='center' class='texto'>Total de registros encontrado: <b>"&Rs.RecordCount&"</b></td></tr></Table>"	
					Else
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Nenhum paciente em atendimento</b></TD></TR></Table>"
				End if

End Function

Function MostraPDF

	Call GeraPDF(Replace(Request("URL"),"-","&")) 'Chanma função global que ira gerar o PDF

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "MostraPDF"
		Call MostraPDF
	
	Case Else
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Prontuario_Medico/Formulario_Admissao/modelos/Form_Visualizar.htm" -->
<%

End Select

'[Fecha Conexão Com Banco De Dados]
Conn.close
set Conn = nothing
%>
