<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" --> 
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
'Chama a função para nao ficar Cache na pagina
Call SemCache
%>
<script language="javascript">
<!--
//FUNÇÃO QUE TRANSFERE O CONTEUDO DA PAGINA PARA OUTRA PAGINA
function Transfere(id_Status) 
	{
	try //Estou usando tratamento de erro pois caso for da solicitacao de atendimento o campo tem um nome e se vier da abertura do atendimento o campo tem outro nome
		{ 
				var sValue = id_Status //Cria uma variavel e armazena o id_status passado
				window.returnValue = sValue	//Passa o id_status para a pagina de baixo, como estamos usamdo uma janela modal entao tem que ser passado dessa forma
				window.close(); //fecha a janela
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

Function ListaStatusFuncionarios

	SQl	=	"Select id,Descricao From HomeCare_Atendimento_Funcionario_Status "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<fieldset>" & CHR(10)
						Response.Write "<legend>&nbsp;Status&nbsp;</legend>" & CHR(10)
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr>" & CHR(10)
							Response.Write "<td class='legenda' width='90%' valign='top'>Selcione um status para o funcionário na lista abaixo</td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='middle' align='center'>&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  Response.Write "<tr class='zebra_orange1'  onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"" >" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center' style='Cursor: Pointer;'>"&"<img src='/SmartCare/images/ico_seta_baixo.gif' border='0' Onclick=""Transfere("&Rs("id")&" )"" >"&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
						Response.Write "</fieldset>" & CHR(10)
				Else
					Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'><TR class='zebra_orange1'><TD align='center' class=legenda><b>Não foi encontrado diagnostico(s) no atendimento</b></TD></TR></Table>"
				End If
			Rs.Close
			Set Rs = Nothing

End Function
'Executa a function com a lsita de status dos funcionarios
Call ListaStatusFuncionarios
%>
