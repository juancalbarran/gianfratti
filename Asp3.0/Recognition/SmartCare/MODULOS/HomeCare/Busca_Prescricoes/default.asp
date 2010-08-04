<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 20/08/2005
' Descrição: Pagina de busca de prescricoes
' Atualizado por: -
' Data: -
' Atualização: -
%>
<script language="javascript">
<!--
//FUNÇÃO QUE TRANSFERE O CONTEUDO DA PAGINA PARA OUTRA PAGINA
function Transfere(Numero,Tipo_Busca,Posicao_Vetor) 
	{
	try 
		{ 
			if (Tipo_Busca=="1") //Tipo 1 envia para o id da prescricao para o campo de medicamento
			{
				window.opener.document.formCadastro.id_Prescricao_Medicamento[Posicao_Vetor].value = Numero; //Envia para o campo da pagina 
				window.close();
				return
			}
			if (Tipo_Busca=="2") //Tipo 2 envia para o id da prescricao para o campo de exame
			{
				window.opener.document.formCadastro.id_Prescricao_Exame[Posicao_Vetor].value = Numero; //Envia para o campo da pagina 
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

'Função que apresenta todos as prescriçoes que nao foram atendidas, ou seja estao aguardando
Function Visualizar_Precricoes_Nao_Atendidas

	SQL	=	"SELECT DISTINCT " &_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica.Descricao, dbo.Funcionarios.nome,  " &_ 
			"dbo.HomeCare_Prescricao_Prioridade.Descricao AS prioridade, dbo.HomeCare_Atendimento_Prescricao_Medica.Qdt_Dias, " &_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica.Data_Cadastro, dbo.HomeCare_Atendimento_Prescricao_Medica.id, " &_ 
			"(SELECT  COUNT(id_Prescricao_Medica) " &_ 
			"FROM HomeCare_Atendimento_Medicamentos " &_ 
			"WHERE id_Atendimento = HomeCare_Atendimento_Prescricao_Medica.id_Atendimento AND  " &_ 
			"id_Prescricao_medica = HomeCare_Atendimento_Prescricao_Medica.id) AS Qtd_Prescricao_Atendida,  " &_ 
			"dbo.Periodicidade.Descricao AS Periodicidade, dbo.Intervalo.Descricao AS Intervalo " &_ 
			"FROM  dbo.HomeCare_Atendimento_Prescricao_Medica INNER JOIN " &_ 
			"dbo.Funcionarios ON dbo.HomeCare_Atendimento_Prescricao_Medica.Id_Funcionario = dbo.Funcionarios.id INNER JOIN " &_ 
			"dbo.HomeCare_Prescricao_Prioridade ON  " &_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica.id_Prioridade = dbo.HomeCare_Prescricao_Prioridade.id INNER JOIN " &_ 
			"dbo.Periodicidade ON dbo.HomeCare_Atendimento_Prescricao_Medica.id_Periodicidade = dbo.Periodicidade.id INNER JOIN " &_ 
			"dbo.Intervalo ON dbo.HomeCare_Atendimento_Prescricao_Medica.id_Intervalo = dbo.Intervalo.id CROSS JOIN " &_ 
			"dbo.HomeCare_Prescricao_Intervalo " &_ 
			"WHERE (dbo.HomeCare_Atendimento_Prescricao_Medica.id_Atendimento = '"&Request("id_Atendimento")&"') AND (HomeCare_Atendimento_Prescricao_Medica.id NOT IN  (SELECT id_Prescricao_Medica  FROM  HomeCare_Atendimento_Medicamentos)) " &_ 
			"Order By Prioridade Desc "
			set rs = createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>ID:</Td>" & Chr(10)
							Response.Write "<Td>Descrição:</Td>" & Chr(10)
							Response.Write "<Td>Periodicidade:</Td>" & Chr(10)
							Response.Write "<Td>Intervalo:</Td>" & Chr(10)
							Response.Write "<Td>Qtd Dias:</Td>" & Chr(10)
							Response.Write "<Td>Prioridade:</Td>" & Chr(10)
							Response.Write "<Td>Médico:</Td>" & Chr(10)
							Response.Write "<Td>Data Cadastro:</Td>" & Chr(10)
							Response.Write "<Td>Qtd vezes atendida:</Td>" & Chr(10)
							Response.Write "<Td>&nbsp;</Td>" & Chr(10)
						Response.Write "</Tr>"
					For x = 1 To Rs.Pagesize
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If Not Response.IsClientConnected  Then Rs.close : Set Rs = Nothing : Conn.Close : set Conn = nothing  : Response.end 'Verifica se o usuario ainda esta conectado na consulta
						If zebrado = "zebra4" Then zebrado = "zebra5" Else zebrado = "zebra4" End If
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("ID")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Descricao")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Periodicidade")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Intervalo")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Qdt_Dias")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Prioridade")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Nome")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("data_cadastro")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Qtd_Prescricao_Atendida")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&"<a href=""javascript:Transfere('"&Rs("id")&"' , '"&Request("Tipo_Busca")&"' , '"&Request("Posicao_Vetor")&"'  )"" ><img src='/SmartCare/images/ico_seta_baixo.gif' border='0' alt='Clique para selecionar esta prescrição'   ></a>"&"</Td>" & Chr(10)
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
					Response.Write "</Table>"
				Else 'Caso não seja encontrado nenhum registro
					Response.Write "<Table width='100%' border='0'><tr><td align ='center' class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
			Rs.Close
			Set Rs = Nothing

End Function

'Função que apresenta todos as prescriçoes que foram atendidas
Function Visualizar_Precricoes_Atendidas

	SQL	=	"SELECT DISTINCT " &_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica.Descricao, dbo.Funcionarios.nome, " &_ 
			"dbo.HomeCare_Prescricao_Prioridade.Descricao AS prioridade, dbo.HomeCare_Atendimento_Prescricao_Medica.Qdt_Dias, " &_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica.Data_Cadastro, dbo.HomeCare_Atendimento_Prescricao_Medica.id, " &_ 
			"(SELECT COUNT(id_Prescricao_Medica) " &_ 
			"FROM HomeCare_Atendimento_Medicamentos " &_ 
			"WHERE  id_Atendimento = HomeCare_Atendimento_Prescricao_Medica.id_Atendimento AND  " &_ 
			"id_Prescricao_medica = HomeCare_Atendimento_Prescricao_Medica.id) AS Qtd_Prescricao_Atendida,  " &_ 
			"dbo.Periodicidade.Descricao AS Periodicidade, dbo.Intervalo.Descricao AS Intervalo " &_ 
			"FROM dbo.HomeCare_Atendimento_Prescricao_Medica INNER JOIN " &_ 
			"dbo.Funcionarios ON dbo.HomeCare_Atendimento_Prescricao_Medica.Id_Funcionario = dbo.Funcionarios.id INNER JOIN " &_ 
			"dbo.HomeCare_Prescricao_Prioridade ON  " &_ 
			"dbo.HomeCare_Atendimento_Prescricao_Medica.id_Prioridade = dbo.HomeCare_Prescricao_Prioridade.id INNER JOIN " &_ 
			"dbo.Periodicidade ON dbo.HomeCare_Atendimento_Prescricao_Medica.id_Periodicidade = dbo.Periodicidade.id INNER JOIN " &_ 
			"dbo.Intervalo ON dbo.HomeCare_Atendimento_Prescricao_Medica.id_Intervalo = dbo.Intervalo.id " &_ 
			"WHERE (dbo.HomeCare_Atendimento_Prescricao_Medica.id_Atendimento = '"&Request("id_Atendimento")&"') AND (HomeCare_Atendimento_Prescricao_Medica.id IN  (SELECT id_Prescricao_Medica  FROM  HomeCare_Atendimento_Medicamentos)) " &_  
			"Order By Prioridade Desc "
			set rs = createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>ID:</Td>" & Chr(10)
							Response.Write "<Td>Descrição:</Td>" & Chr(10)
							Response.Write "<Td>Periodicidade:</Td>" & Chr(10)
							Response.Write "<Td>Intervalo:</Td>" & Chr(10)
							Response.Write "<Td>Qtd Dias:</Td>" & Chr(10)
							Response.Write "<Td>Prioridade:</Td>" & Chr(10)
							Response.Write "<Td>Médico:</Td>" & Chr(10)
							Response.Write "<Td>Data Cadastro:</Td>" & Chr(10)
							Response.Write "<Td>Qtd vezes atendida:</Td>" & Chr(10)
							Response.Write "<Td>&nbsp;</Td>" & Chr(10)
						Response.Write "</Tr>"
					For x = 1 To Rs.Pagesize
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If Not Response.IsClientConnected  Then Rs.close : Set Rs = Nothing : Conn.Close : set Conn = nothing  : Response.end 'Verifica se o usuario ainda esta conectado na consulta
						If zebrado2 = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("ID")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Descricao")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Periodicidade")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Intervalo")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Qdt_Dias")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Prioridade")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Nome")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("data_cadastro")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Qtd_Prescricao_Atendida")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&"<a href=""javascript:Transfere('"&Rs("id")&"' , '"&Request("Tipo_Busca")&"' , '"&Request("Posicao_Vetor")&"'  )"" ><img src='/SmartCare/images/ico_seta_baixo.gif' border='0' alt='Clique para selecionar esta prescrição'   ></a>"&"</Td>" & Chr(10)
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
					Response.Write "</Table>"
				Else 'Caso não seja encontrado nenhum registro
					Response.Write "<Table width='100%' border='0'><tr><td align ='center' class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
			Rs.Close
			Set Rs = Nothing

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction
	
	Case Else
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Busca_Prescricoes/modelos/Form_Visualizar_Prescricoes.htm" -->
<%
End Select

'[Fecha Conexão Com Banco De Dados]
Conn.close
set Conn = nothing
%>
