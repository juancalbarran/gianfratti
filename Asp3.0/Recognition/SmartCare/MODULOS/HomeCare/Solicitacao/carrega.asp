<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" --> 
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 10/07/2005
' Descrição: Pagina de apoio ao JavaScript que usa o metodo XMLHTTP para buscar o paciente e o medico
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'Usado para quando usar o XMLHTTP não retornat caracteres estranhos, principalmente quando tem acentos e outros caracteres estranhas
Response.CharSet="iso-8859-1"

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")


'Função que retorna a cadastro do pacinte, porem tem que ser passado os parametros de busca para isso
Function Carrega_Dados_Cadastro_Pacientes

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "Select Top 1 * , dbo.FuncaoConvenioNome(id_Convenio) As Convenio_Nome  From Pacientes Where CPF = '"&Trim(Replace(Replace(Request("Busca"),".",""),"-",""))&"'  "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					IF Rs("Particular")	Then Tipo_Plano = "Pessoa Fisica" Else Tipo_Plano = "Pessoa Juridica" End if
					Response.Write "<input name='id_Paciente' type='hidden' value='"&Rs("id")&"'>"
					Response.Write "<input name='id_Convenio' type='hidden' value='"&Rs("id_Convenio")&"'>"
					Response.Write "<input name='Nome_Paciente' type='hidden' value='"&Rs("Nome")&"'>"
					Response.Write "<input name='Nome_Convenio' type='hidden' value='"&Rs("Convenio_Nome")&"'>"
					Response.Write "<fieldset>"
					Response.Write "<legend>&nbsp;Cadastro Paciente&nbsp;</legend>"

					Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>" & Chr(10)
					  Response.Write "<tr class='zebra_orange1'> "& Chr(10)
						Response.Write "<td width='8%'><b>Identificação:</b></td>" & Chr(10)
						Response.Write "<td width='25%'>"&Rs("Nome")&"</td>" & Chr(10)
						Response.Write "<td width='13%'><b>Data Nasc.:</b></td>" & Chr(10)
						Response.Write "<td width='22%'>"&ArrumaData(Rs("data_nascimento"))&"</td>" & Chr(10)
						Response.Write "<td width='8%'><b>Idade:</b></td>" & Chr(10)
						Response.Write "<td colspan='3'>"&Year(Date) - Year(Rs("Data_Nascimento"))&"</td>" & Chr(10)
					  Response.Write "</tr>" & Chr(10)
					  Response.Write "<tr class='zebra_orange1'> " & Chr(10)
						Response.Write "<td><b>RG:</b></td>" & Chr(10)
						Response.Write "<td>"&Rs("RG")&"</td>" & Chr(10)
						Response.Write "<td><b>CPF:</b></td>" & Chr(10)
						Response.Write "<td colspan='5'>"&Rs("CPF")&"</td>" & Chr(10)
					  Response.Write "</tr>" & Chr(10)
					  Response.Write "<tr class='zebra_orange1'> " & Chr(10)
						Response.Write "<td><b>Convênio:</b></td>" & Chr(10)
						Response.Write "<td>"&Rs("Convenio_Nome")&"</td>" & Chr(10)
						Response.Write "<td><b>Tipo Plano:</b></td>" & Chr(10)
						Response.Write "<td colspan='5'>"&Tipo_Plano&"</td>" & Chr(10)
					  Response.Write "</tr>" & Chr(10)
					  Response.Write "<tr class='zebra_orange1'>" & Chr(10) 
						Response.Write "<td><b>Endereço:</b></td>" & Chr(10)
						Response.Write "<td>"&Trim(Rs("Endereco"))&"</td>" & Chr(10)
						Response.Write "<td><b>Cidade:</b></td> " & Chr(10)
						Response.Write "<td>"&Trim(Rs("Cidade"))&"</td> " & Chr(10)
						Response.Write "<td><b>Bairro:</b></td>" & Chr(10)
						Response.Write "<td width='17%'>"&Trim(Rs("Bairro"))&"</td>" & Chr(10)
						Response.Write "<td width='3%'><b>UF:</b></td>" & Chr(10)
						Response.Write "<td width='4%'>"&Trim(Rs("UF"))&"</td> " & Chr(10)
					  Response.Write "</tr>" & Chr(10)
					  Response.Write "<tr class='zebra_orange1'> " & Chr(10)
						Response.Write "<td><b>Telefones:</b></td>" & Chr(10)
						Response.Write "<td>"&Trim(Rs("Telefones"))&"</td>" & Chr(10)
						Response.Write "<td><b>Responsavel:</b></td>" & Chr(10)
						Response.Write "<td>"&Trim(Rs("Responsavel"))&"</td>" & Chr(10)
						Response.Write "<td><b>Cuidador:</b></td>" & Chr(10)
						Response.Write "<td colspan='3'>"&Trim(Rs("Cuidador"))&"</td>" & Chr(10)
					  Response.Write "</tr>"& Chr(10)
					Response.Write "</table>" & Chr(10)
						Response.Write "</fieldset>"
		
				End IF
			Rs.Close
			Set Rs = Nothing

End Function

'Função que retorna o nome do médico por CRM
Function BuscaMedico

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "Select Top 1 Codigo, Nome  From Cremesp_Medicos Where Codigo = '"&Request("CRM")&"' AND S= 'A' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Response.Write Trim(Rs("Nome"))
				End IF
			Rs.Close
			Set Rs = Nothing

End Function

'Função que retorna o CID10
Function BuscaCid10

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "Select Top 1 Cid10, Descricao  From Diagnostico Where Cid10 = '"&Request("Cid10")&"' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Response.Write Trim(Rs("Descricao"))
				End IF
			Rs.Close
			Set Rs = Nothing

End Function

'Função responsavel por deletar os itens da solicitcao
Function DeletarItensSolicitacao(id_Solicitacao_Medica_Itens)

	'Deleta o iten
	SQL	=	"DELETE FROM HomeCare_Solicitacao_Medica_Itens Where id ='"&Cint(request("id_Solicitacao_Medica_Itens"))&"' "
			conn.execute(SQL)

	'Apos deletar o item carrega os registros ja com os novos valores para o XMLHTTP carregar
	SQL = 	"Select id, id_Solicitacao_Atendimento, Descricao, Periodicidade, Qdt_Dias, ISNULL(Valor, 0) AS Valor, Data_Cadastro, " &_ 
			"ISNULL((SELECT SUM(Valor) FROM HomeCare_Solicitacao_Medica_Itens WHERE  (id_Solicitacao_Atendimento = '"&Request("id_Solicitacao_Atendimento")&"')), 0) AS Total " &_ 
			"From HomeCare_Solicitacao_Medica_Itens Where id_Solicitacao_Atendimento = '"&Request("id_Solicitacao_Atendimento")&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='27%' valign='top'><b>Prescrição:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='12%' valign='top'><b>Qtd Dias:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='12%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Valor:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center' >&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						Total = FormatCurrency(Rs("Total"))
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"">" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qdt_Dias"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)

							Response.Write "<td class='texto' valign='top' align='right'>"&FormatCurrency(Rs("Valor"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center' >"&"<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarItensSolicitacao( "&Rs("id")&" , '"&Rs("Descricao")&"' )"" >"&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td colspan='5' class='texto' align='right' valign='top'><b>"&Total&"</b></td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>&nbsp;</td>" & CHR(10)
						 Response.Write "</tr>" & CHR(10)
						Response.Write "</table>" & CHR(10)
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função responsavel por deletar os profissionais
Function DeletarProfissionais()

	'Deleta o iten
	SQL	=	"DELETE FROM HomeCare_Solicitacao_Profissionais Where id ='"&request("Id_Profissional")&"' and id_Solicitacao_Atendimento = '"&Request("id_Solicitacao_Atendimento")&"' "
			conn.execute(SQL)

	'Apos deletar o item carrega os registros ja com os novos valores para o XMLHTTP carregar
	SQL = 	"SELECT id, id_Solicitacao_Atendimento, Profissional, Periodicidade, ISNULL(Valor, 0) AS Valor, Data, " &_
			"IsNull((SELECT SUM(Valor) FROM dbo.HomeCare_Solicitacao_Profissionais WHERE id_Solicitacao_Atendimento = '"&Cint(Request("id_Solicitacao_Atendimento"))&"'),0) AS Total  " &_ 
			"FROM HomeCare_Solicitacao_Profissionais " &_ 
			"Where id_Solicitacao_Atendimento = '"&Cint(Request("id_Solicitacao_Atendimento"))&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='30%' valign='top'><b>Profissional:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='42%' valign='top'><b>Periodicidade:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Valor:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center'>&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						Total = Trim(FormatCurrency(Rs("Total")))
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"" >" & CHR(10)
							Response.Write "<td class='texto' valign='top' >"&Trim(Rs("Profissional"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Periodicidade"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top' align='right'>"&Trim(FormatCurrency(Rs("Valor")))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center'>"&"<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarProfissionais("&Rs("id")&" , '"&Rs("Profissional")&"' )"" >"&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td colspan='4' class='texto' align='right' valign='top'><b>"&Total&"</b></td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>&nbsp;</td>" & CHR(10)
						 Response.Write "</tr>" & CHR(10)
						Response.Write "</table>" & CHR(10)
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função responsavel por deletar o Cid10 da solicitcao
Function DeletarItensCid10()

	'Deleta o iten
	SQL	=	"DELETE FROM HomeCare_Diagnostico_Entrada Where id ='"&request("Id_Diagnostico_Entrada")&"' and id_Solicitacao_Atendimento = '"&Request("id_Solicitacao_Atendimento")&"' "
			conn.execute(SQL)

	'Apos deletar o item carrega os registros ja com os novos valores para o XMLHTTP carregar
	SQL = 	"SELECT dbo.HomeCare_Diagnostico_Entrada.id, dbo.Diagnostico.CID10, dbo.Diagnostico.DESCRICAO , Data_Cadastro " &_ 
			"FROM dbo.Diagnostico INNER JOIN " &_ 
            "dbo.HomeCare_Diagnostico_Entrada ON dbo.Diagnostico.CID10 = dbo.HomeCare_Diagnostico_Entrada.CID10 " &_ 
			"Where id_Solicitacao_Atendimento = '"&Request("id_Solicitacao_Atendimento")&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof then 'Verifica se existem registros
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='05%' valign='top'><b>CID10:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='59%' valign='top'><b>Diagnostico:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='13%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center'>&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"" >" & CHR(10)
							Response.Write "<td class='texto' valign='top' align='center'>"&Trim(Rs("CID10"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Descricao"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center'>"&"<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarItensCid10("&Rs("id")&" , '"&Rs("Descricao")&"' )"" >"&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "</table>" & CHR(10)
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função responsavel por deletar os Edquipamentos
Function DeletarEquipamentos()

	'Deleta o iten
	SQL	=	"DELETE FROM HomeCare_Solicitacao_Equipamentos Where id ='"&request("Id_Equipamento")&"' and id_Solicitacao_Atendimento = '"&Request("id_Solicitacao_Atendimento")&"' "
			conn.execute(SQL)

	'Apos deletar o item carrega os registros ja com os novos valores para o XMLHTTP carregar
	SQL =	"SELECT  id, id_Solicitacao_Atendimento, Equipamento, Qtd, Valor, Data_Cadastro, " &_ 
			"ISNULL((SELECT SUM(Valor)  FROM  HomeCare_Solicitacao_Equipamentos  WHERE id_Solicitacao_Atendimento = '"&Request("id_Solicitacao_Atendimento")&"'), 0) AS Total " &_ 
			"FROM HomeCare_Solicitacao_Equipamentos " &_
			"Where id_Solicitacao_Atendimento = '"&Request("id_Solicitacao_Atendimento")&"' "
			
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof And Rs(0).Name <> "sum" then 'Verifica se existem registros e se a coluna é diferente se SUM que é o total
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='52%' valign='top'><b>Equipamento:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='20%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Valor:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center'>&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						Total = Trim(FormatCurrency(Rs("Total")))
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"" >" & CHR(10)
							Response.Write "<td class='texto' valign='top' >"&Trim(Rs("Equipamento"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qtd"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top' align='right'>"&Trim(FormatCurrency(Rs("Valor")))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center'>"&"<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarEquipamentos("&Rs("id")&" , '"&Rs("Equipamento")&"' )"" >"&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td colspan='4' class='texto' align='right' valign='top'><b>"&FormatCurrency(Total)&"</b></td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>&nbsp;</td>" & CHR(10)
						 Response.Write "</tr>" & CHR(10)
						Response.Write "</table>" & CHR(10)
				End If
			Rs.Close
			Set Rs = Nothing
			
End Function

'Função responsavel por deletar os materiais
Function DeletarMateriais()

	'Deleta o iten
	SQL	=	"DELETE FROM HomeCare_Solicitacao_Materiais Where id ='"&request("Id_Material")&"' and id_Solicitacao_Atendimento = '"&Request("id_Solicitacao_Atendimento")&"' "
			conn.execute(SQL)

	'Apos deletar o item carrega os registros ja com os novos valores para o XMLHTTP carregar		
	SQL =	"SELECT id, id_Solicitacao_Atendimento, Material, Qtd, Valor, Data_Cadastro, " &_ 
			"ISNULL((SELECT Valor FROM HomeCare_Solicitacao_Materiais WHERE id_Solicitacao_Atendimento = '"&Request("id_Solicitacao_Atendimento")&"'), 0) AS Total " &_ 
			"FROM dbo.HomeCare_Solicitacao_Materiais " &_ 
			"WHERE (id_Solicitacao_Atendimento = '"&Request("id_Solicitacao_Atendimento")&"') "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof And Rs(0).Name <> "sum" then 'Verifica se existem registros e se a coluna é diferente se SUM que é o total
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='52%' valign='top'><b>Material:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='20%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Valor:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center'>&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						Total = Trim(FormatCurrency(Rs("Total")))
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"" >" & CHR(10)
							Response.Write "<td class='texto' valign='top' >"&Trim(Rs("Material"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qtd"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top' align='right'>"&Trim(FormatCurrency(Rs("Valor")))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center'>"&"<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarMaterial("&Rs("id")&" , '"&Rs("Material")&"' )"" >"&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td colspan='4' class='texto' align='right' valign='top'><b>"&FormatCurrency(Total)&"</b></td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>&nbsp;</td>" & CHR(10)
						 Response.Write "</tr>" & CHR(10)
						Response.Write "</table>" & CHR(10)
				End If
			Rs.Close
			Set Rs = Nothing
			
End Function

'Função responsavel por deletar as Dietas
Function DeletarDietas()

	'Deleta o iten
	SQL	=	"DELETE FROM HomeCare_Solicitacao_Dietas Where id ='"&request("Id_Dieta")&"' and id_Solicitacao_Atendimento = '"&Request("id_Solicitacao_Atendimento")&"' "
			conn.execute(SQL)

	'Apos deletar o item carrega os registros ja com os novos valores para o XMLHTTP carregar		
	SQL =	"SELECT id, id_Solicitacao_Atendimento, Dieta, Qtd, Valor, Data_Cadastro, " &_ 
			"ISNULL((SELECT SUM(Valor) FROM HomeCare_Solicitacao_Dietas WHERE id_Solicitacao_Atendimento = '"&Request("id_Solicitacao_Atendimento")&"'), 0) AS Total " &_ 
			"FROM HomeCare_Solicitacao_Dietas " &_ 
			"WHERE (id_Solicitacao_Atendimento = '"&Request("id_Solicitacao_Atendimento")&"') "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof And Rs(0).Name <> "sum" then 'Verifica se existem registros e se a coluna é diferente se SUM que é o total
						Response.Write "<table width='100%' border='0' cellspacing='1' cellpadding='0'>"
						  Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td class='texto' width='52%' valign='top'><b>Dieta:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='20%' valign='top'><b>Qtd:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='15%' valign='top'><b>Data:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='10%' valign='top'><b>Valor:</b></td>" & CHR(10)
							Response.Write "<td class='texto' width='03%' valign='middle' align='center'>&nbsp;</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					For x  = 1 To Rs.RecordCount
						IF Rs.eof Then Exit For
						Total = Trim(FormatCurrency(Rs("Total")))
						  Response.Write "<tr class='zebra_orange1' style='Cursor: Pointer;' onMouseOver=""this.style.backgroundColor='#ECE9D8';"" onMouseOut=""this.style.backgroundColor='#F1F1E7';"" >" & CHR(10)
							Response.Write "<td class='texto' valign='top' >"&Trim(Rs("Dieta"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&Trim(Rs("Qtd"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='top' align='right'>"&Trim(FormatCurrency(Rs("Valor")))&"</td>" & CHR(10)
							Response.Write "<td class='texto' valign='middle' align='center'>"&"<img src='/SmartCare/images/ico_excluir.gif' border='0' Onclick=""DeletarDieta("&Rs("id")&" , '"&Rs("Dieta")&"' )"" >"&"</td>" & CHR(10)
						  Response.Write "</tr>" & CHR(10)
					Rs.MoveNext
					Next
						Response.Write "<tr class='zebra_orange1'>" & CHR(10)
							Response.Write "<td colspan='4' class='texto' align='right' valign='top'><b>"&FormatCurrency(Total)&"</b></td>" & CHR(10)
							Response.Write "<td class='texto' valign='top'>&nbsp;</td>" & CHR(10)
						 Response.Write "</tr>" & CHR(10)
						Response.Write "</table>" & CHR(10)
				End If
			Rs.Close
			Set Rs = Nothing
			
End Function


'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Carrega_Dados_Cadastro_Pacientes"
		Call Carrega_Dados_Cadastro_Pacientes 'Carrega os dados do paciente chamando a função global
	
	Case "BuscaMedico"		
		Call BuscaMedico 'Carrega os dados do medico chamando a função global

	Case "BuscaCid10"		
		Call BuscaCid10
	
	Case "DeletarItensSolicitacao"	
		Call DeletarItensSolicitacao(Request("id_Solicitacao_Medica_Itens"))
	
	Case "DeletarItensCid10"
		Call DeletarItensCid10()
	
	Case "DeletarProfissionais"
		Call DeletarProfissionais()
	
	Case "DeletarEquipamentos"
		Call DeletarEquipamentos()
	
	Case "DeletarMateriais"
		Call DeletarMateriais()

	Case "DeletarDietas"
		Call DeletarDietas()
		
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>
