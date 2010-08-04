<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 03/03/2005
' Descrição: Pagina de busca de locais
' Atualizado por: -
' Data: -
' Atualização: -
%>
<script language="javascript">
<!--
//FUNÇÃO QUE TRANSFERE O CONTEUDO DA PAGINA PARA OUTRA PAGINA
//ESTA FUNÇÃO RECEBE UM PARAMETRO CHAMADO FLAG, ESTA FLAG TEM COMO OBJETIVO SABER SE É PARA SUBMETER O FORMULARIO NA PAGINA DE BAIXO OU NAO
//ISSO FOI FEITO POIS ESTA FUNÇÃO É USADA NA ABERTURA DO ATENDIMENTO COMO QUANDO EDITA O ATENDIMENTO, E COMO QUANDO ABRE O ATENDIMENTO NAO PODE SUBMTER O FORMULARIO
function Transfere(Id, Nome, Flag) 
	{
		if (Flag=="1") //CASO QUEIRA QUE O FORMULARIO DA PAGINA DE BAIXO SEHA SUBMETIDO
		{
			window.opener.document.form.id_Local.value = Id; //Envia para o campo da pagina id_Departamento
			window.opener.document.form.Local_Descricao.value = Nome; //Envia para o campo da pagina DepartamentoNome
			window.opener.focus(); //passa o foco para a pagina de baixo
			//Envia o formulario da pagina de baixo automaticamente. 
			//Ele faz um evento Click no botao automaticamente, para isso basta colocar o nome do botao que no caso o name do botao esta como submit
			//Atenção é importante lembrar que o nome do botao submit tem que ser em letras minusculas
			window.opener.document.forms[0]['submit'].click(); 
		}
		if (Flag=="2") //CASO NÃO QUEIRA QUE O FORMULARIO DA PAGINA DE BAIXO SEHA SUBMETIDO
		{
			window.opener.document.form.id_Local.value = Id; //Envia para o campo da pagina id_Departamento
			window.opener.document.form.Local_Descricao.value = Nome; //Envia para o campo da pagina DepartamentoNome
			window.opener.focus(); //passa o foco para a pagina de baixo
		}
			window.close(); //Fecha a janela que foi aberta
			return
	}
//-->
</script>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim id,id_cliente,id_cobertura,Descricao,Endereco,Bairro,CEP,Telefone,Contato,Cidade,UF
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE JÁ EXISTEM
Function VisualizarLocais

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.Locais_Visualizar '"&Replace(Request("Busca"),"'","")&"' , '"&Replace(Request("UF"),"'","")&"' , '"&Replace(Request("id_Cliente"),"'","")&"' , '"&Replace(Request("id_Cobertura"),"'","")&"' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Tit_Box_Orange'>" & Chr(10)&_
							"<Td>Cliente:</Td>" & Chr(10)&_
							"<Td>Cobertura:</Td>" & Chr(10)&_
							"<Td>Local:</Td>" & Chr(10)&_
							"<Td>UF:</Td>" & Chr(10)&_
							"<Td>Selecionar:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("ClienteNome")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("CoberturaNome")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Descricao")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("UF")&"&nbsp;</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&"<a href=""javascript:Transfere(" & rs("id") & " , '" & rs("Descricao") & "'  , '" & Request("Flag") & "'  )"" > <img src='/SmartCare/images/Selecionar.gif'  border='0'> </a>"&"</td>" & Chr(10) &_ 
						"</Tr>" 
					Rs.MoveNext
					Next
					Content = Content &_
					"</Table>"
				Else 'Caso não seja encontrado nenhum registro
					Content = Content & "<Table><tr><td class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
			Rs.Close
			Set Rs = Nothing
			VisualizarLocais = Content

End Function


'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case Else
%>
	<!-- #include virtual="/SmartCare/Bibliotecas/Buscas/Clientes_Locais/modelos/Form_Visualizar_Local.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>