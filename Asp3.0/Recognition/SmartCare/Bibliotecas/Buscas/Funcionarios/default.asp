<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 07/04/2005
' Descrição: Pagina de busca de Funcionarios
' Atualizado por: -
' Data: -
' Atualização: -
%>
<script language="javascript">
<!--
//FUNÇÃO QUE TRANSFERE O CONTEUDO DA PAGINA PARA OUTRA PAGINA
//FUNCÃO RECEBE UM CAMPO CHAMADO FLAG, ESTA FLAG SERVE PARA SABER DE QUAL CAMPO DO FORMULARIO OS DADOS TEM QUE IR
//NO CASO SE A FLAG FOR 1 ENTAO É PARA O MEDICO RESPONSAVEL E NO CASO DE 2 É PARA O ENFERMEIRO RESPONSAVEL
function Transfere(Id, Nome, Flag) 
	{
		if (Flag=="1") //CASO FOR MEDICO
		{
			window.opener.document.form.id_Funcionario_Medico.value = Id; //Envia para o campo da pagina 
			window.opener.document.form.Medico_Nome.value = Nome; //Envia para o campo da pagina
			//window.opener.location = '/SmartCare/Atendimentos/default.asp?action=Form_Incluir_Atendimentos&id_paciente=' + Id + '&Paciente_Nome=' + Nome ; //Envia para a pagina de baixo com os parametros que o formulario recupera
		}
		if (Flag=="2") //CASO FOR ENFERMEIRO
		{
			window.opener.document.form.id_Funcionario_Enfermeiro.value = Id; //Envia para o campo da pagina 
			window.opener.document.form.Enfermeiro_Nome.value = Nome; //Envia para o campo da pagina
			//window.opener.location = '/SmartCare/Atendimentos/default.asp?action=Form_Incluir_Atendimentos&id_paciente=' + Id + '&Paciente_Nome=' + Nome ; //Envia para a pagina de baixo com os parametros que o formulario recupera
		}

		window.close();
		return
	}
//-->
</script>

<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim id,Nome,id_Cargo,id_Departamento,Contato1,Contato2,Contato3,DataContratacao,DataDemissao,RG,CPF,Endereco,CEP,Banco1,Agencia1,CC1,Banco2,Agencia2,CC2,Email,Ramal,id_OperadoraPager,Pager
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE JÁ EXISTEM
Function VisualizarFuncionarios

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.Funcionarios_Visualizar '"&Request("Nome")&"' , '"&Request("id_Departamento")&"' , '"&Request("id_Cargo")&"' , '"&Request("id_Especializacao")&"' , '"&Request("id_Disponibilidade")&"' , '"&Request("id_Cobertura")&"' , '"&Request("Flg_Mostra_Funcionarios_Medicos")&"' , '"&Request("Flg_Mostra_Funcionarios_Enfermeiros")&"' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatenação
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' style='cursor: hand'  onClick="" javascript:Transfere(" & rs("id") & " , '" & rs("Nome") & "' , '" & Request("Flag") & "'  )  "" >" & Chr(10)&_
						"<Tr class='Tit_Box_Orange'>" & Chr(10)&_
							"<Td>Funcionario:</Td>" & Chr(10)&_
							"<Td>Departamento:</Td>" & Chr(10)&_
							"<Td>Cargo:</Td>" & Chr(10)&_
						"</Tr>"& Chr(10)&_

						"<Tr class='"&zebrado&"'>" & Chr(10)&_
							"<Td><B>"&UCASE(Rs("Nome"))&"</B></Td>" & Chr(10)&_
							"<Td><B>"&UCASE(Rs("Departamento"))&"</B></Td>" & Chr(10)&_
							"<Td><B>"&UCASE(Rs("Cargo"))&"</B></Td>" & Chr(10)&_
						"</Tr>" & Chr(10)&_
							"<Tr class='"&zebrado&"'>" & Chr(10)&_
								"<Td colspan='5'>" & Chr(10)&_
									"<table width='100%' border='0' cellspacing='0' cellpadding='0'>" & Chr(10)&_
										"<tr>" & Chr(10)&_
											"<td valign='top' width='15%'>"&Funcionario_Imagem(Rs("id"),"120","160")&"</td>" & Chr(10)&_
											"<td valign='top' width='25%'> <img src='/SmartCare/images/placa_Especializacoes.gif' >"&Funcionarios_Especializacao(Rs("id"))&"</td>" & Chr(10)&_
											"<td valign='top' width='25%'><img src='/SmartCare/images/placa_Disponibilidades.gif'  >"&Funcionarios_Disponibilidade(Rs("id"))&"</td>" & Chr(10)&_
											"<td valign='top' width='35%'><img src='/SmartCare/images/placa_Cobertura.gif'  >"&Funcionarios_Cobertura(Rs("id"))&"</td>" & Chr(10)&_
										"</tr>" & Chr(10)&_
								    "</table> " & Chr(10)&_
								"</Td>" & Chr(10)&_
							"</Tr>" & Chr(10)&_
							"</Table>"
					Rs.MoveNext
					Next
				Else 'Caso não seja encontrado nenhum registro
					Content = Content & "<Table><tr><td class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
			Rs.Close
			Set Rs = Nothing
			VisualizarFuncionarios = Content

End Function


'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction
		
	Case Else
%>
	<!-- #include virtual="/SmartCare/Bibliotecas/Buscas/Funcionarios/modelos/Form_Visualizar_Funcionarios.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>
