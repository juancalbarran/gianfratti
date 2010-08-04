<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">

<%
' Autor: Fabrizio Gianfratti Manes
' Data: 03/03/2005
' Descrição: Pagina de Busca de Departamentos
' Atualizado por: -
' Data: -
' Atualização: -
%>
<script language="javascript">
<!--
//FUNÇÃO QUE TRANSFERE O CONTEUDO DA PAGINA PARA OUTRA PAGINA
function Transfere(Id, Nome) 
	{
	window.opener.document.form.id_Departamento.value = Id; //Envia para o campo da pagina id_Departamento
	window.opener.document.form.DepartamentoNome.value = Nome; //Envia para o campo da pagina DepartamentoNome
	window.close();
	return
	}
//-->
</script>
<%
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE JÁ EXISTEM
Function VisualizarClientesDepartamentos

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.ClientesDepartamentos_Visualizar '"&Trim(Replace(Request("Busca"),"'",""))&"' , '"&Trim(Request("id_Cliente"))&"' , '"&Trim(Request("id_Local"))&"' , '"&Trim(Request("id_Cobertura"))&"' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Tit_Box_Orange'>" & Chr(10)&_
							"<Td>Departamento:</Td>" & Chr(10)&_
							"<Td>Cliente:</Td>" & Chr(10)&_
							"<Td>Local:</Td>" & Chr(10)&_
							"<Td>Cobertura:</Td>" & Chr(10)&_
							"<Td>Selecionar:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Descricao")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Nome")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Local_Descricao")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Cobertura_Nome")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&"<a href=""javascript:Transfere(" & rs("id") & " , '" & rs("Descricao") & "'  )"" >Selecionar</a>"&"</td>" & Chr(10) &_ 
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
			VisualizarClientesDepartamentos = Content

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case Else
%>
	<!-- #include virtual="/SmartCare/Bibliotecas/Buscas/ClientesDepartamentos/modelos/Form_Visualizar_ClientesDepartamentos.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>