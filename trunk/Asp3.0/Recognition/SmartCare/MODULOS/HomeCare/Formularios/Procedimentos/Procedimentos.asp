<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<!-- #include virtual="/SmartCare/Modulos/HomeCare/Formularios/Procedimentos/Js/Validacoes.js" -->
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim id,Paciente,Idade,Sexo,Convenio,Content
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

If Request("id_Atendimento") <> "" Then Call Busca_Paciente(Cint(Request("id_Atendimento")))
Call Busca_Medico(Cint(Request("id_Atendimento")))
If Request("Action") = "Gravar" Then Call Gravar End if

Function Busca_Paciente(id_Atendimento)

	SQL	=	"SELECT  dbo.Pacientes.nome, dbo.Pacientes.data_nascimento, dbo.Pacientes.sexo, dbo.Convenios.Convenio " &_ 
			"FROM dbo.Pacientes INNER JOIN " &_ 
			"dbo.HomeCare_Solicitacao_Atendimento ON dbo.Pacientes.id = dbo.HomeCare_Solicitacao_Atendimento.id_Paciente INNER JOIN " &_ 
			"dbo.HomeCare_Atendimento ON dbo.HomeCare_Solicitacao_Atendimento.id = dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento INNER JOIN " &_ 
			"dbo.Convenios ON dbo.HomeCare_Solicitacao_Atendimento.id_Convenio = dbo.Convenios.id " &_ 
			"WHERE  (dbo.HomeCare_Atendimento.id = '"&id_Atendimento&"') "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					
					Paciente = Rs("Nome")
					Idade = Year(Date) - Year(Rs("data_nascimento")) 
					If Rs("Sexo") = "M" Then Sexo = "Masculino" Else Sexo = "Feminio"  end if
					Convenio = Rs("Convenio")
					Else
						Response.Write "<script>alert('Atendimento não encontrado')</script>"
						Response.Write "<script>location = 'JavaScript:history.back()' </script>"			
				End if
			Rs.Close
			Set Rs = Nothing

End Function

Function Busca_Medico(id_Atendimento)

	SQL	=	"SELECT dbo.Funcionarios.nome, dbo.HomeCare_Atendimento_Medicos.id_Funcionario AS id_medico " &_ 
			"FROM dbo.HomeCare_Atendimento_Medicos INNER JOIN " &_ 
			"dbo.Funcionarios ON dbo.HomeCare_Atendimento_Medicos.id_Funcionario = dbo.Funcionarios.id " &_ 
			"WHERE (dbo.HomeCare_Atendimento_Medicos.id_Atendimento = '"&id_Atendimento&"') " 
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					For x = 1 to Rs.RecordCount
						If rs.eof then Exit For
						Medico = "<input name='"&Rs("id_Medico")&"' type='checkbox' value='checkbox'>" & Rs("Nome") & "<br>"
					Rs.MoveNext
					Next			
				End if
			Rs.Close
			Set Rs = Nothing

End Function

Function Busca_Profissionais(id_Atendimento)

	SQL	=	"SELECT dbo.View_Atendimento_Funcionarios.Tipo_Profissional, dbo.Funcionarios.nome, dbo.View_Atendimento_Funcionarios.id_Funcionario    " &_ 
			"FROM dbo.View_Atendimento_Funcionarios INNER JOIN " &_ 
			"dbo.Funcionarios ON dbo.View_Atendimento_Funcionarios.id_Funcionario = dbo.Funcionarios.id " &_ 
			"WHERE dbo.View_Atendimento_Funcionarios.Tipo_Profissional = 1 And (dbo.View_Atendimento_Funcionarios.id_Atendimento = '"&id_Atendimento&"') "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
						Response.Write "<Table width='100%' border='0' cellpadding='0' cellspacing='1'>"
						Response.Write "<tr class='zebra_orange1'>"
						Response.Write "<td><b>Médico(a)</b></td>"
						Response.Write "</tr>"
					For x = 1 to Rs.RecordCount
						If rs.eof then Exit For
						Response.Write "<tr class='zebra_orange1'>"
						Response.Write "<td>" & "<input name='id_Func_Medico'  type='checkbox' value='"&Rs("id_Funcionario")&"'>" & Rs("Nome") & "</td>"
						Response.Write "</tr>"
					Rs.MoveNext
					Next
					Response.Write "</table>"			
				End if
			Rs.Close
			Set Rs = Nothing

End Function

Function Busca_Auxliares(id_Atendimento)

	SQL	=	"SELECT dbo.View_Atendimento_Funcionarios.Tipo_Profissional, dbo.Funcionarios.nome, dbo.View_Atendimento_Funcionarios.id_Funcionario    " &_ 
			"FROM dbo.View_Atendimento_Funcionarios INNER JOIN " &_ 
			"dbo.Funcionarios ON dbo.View_Atendimento_Funcionarios.id_Funcionario = dbo.Funcionarios.id " &_ 
			"WHERE dbo.View_Atendimento_Funcionarios.Tipo_Profissional In(2,3) And (dbo.View_Atendimento_Funcionarios.id_Atendimento = '"&id_Atendimento&"') "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
						Response.Write "<Table width='100%' border='0' cellpadding='0' cellspacing='1'>"
						Response.Write "<tr class='zebra_orange1'>"
						Response.Write "<td><b>Auxiliares:</b></td>"
						Response.Write "<td><b>Ordem de Atend.:</b></td>"
						Response.Write "</tr>"
					For x = 1 to Rs.RecordCount
						If rs.eof then Exit For
						Response.Write "<tr class='zebra_orange1'>"
						Response.Write "<td  width='25%'>" & "<input name='id_Func_Auxiliar'  type='checkbox' value='"&Rs("id_Funcionario")&"'>" & Rs("Nome") & "</td>"
						Response.Write "<Td  width='85%'>" & GeraListBoxOpcoesManual_V2(Array(1,2,3,4,5),Array("1º Auxiliar","2º Auxiliar","3º Auxiliar","4º Auxiliar","5º Auxiliar"),"Ordem_Auxiliar","","","") & "</td>"
						Response.Write "</tr>"
					Rs.MoveNext
					Next
					Response.Write "</table>"
				End if
			Rs.Close
			Set Rs = Nothing

End Function

Function Gravar_Medico

	SQL	=	"SELECT dbo.HomeCare_Atendimento.id AS id_Atendimento, dbo.Convenios.Convenio, dbo.Convenios.Tbl_Procedimentos, dbo.Convenios.CH " &_ 
			"FROM dbo.HomeCare_Atendimento INNER JOIN "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento ON  " &_ 
			"dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento = dbo.HomeCare_Solicitacao_Atendimento.id INNER JOIN " &_
			"dbo.Convenios ON dbo.HomeCare_Solicitacao_Atendimento.id_Convenio = dbo.Convenios.id " &_ 
			"WHERE   (dbo.HomeCare_Atendimento.id = "&Cint(Request("id_Atendimento"))&") "
			
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros

					For x = 1 To Request.Form("id_Func_Medico").Count
					
						'Regra para calcular o valor do médico da AMB 90 e 92
						'Calculo - QTD_CH * CH_Convenio
						Valor = (Request("QTD_CH") * Rs("CH")) 
						
						SQL = 	"INSERT INTO HomeCare_Atendimento_Procedimentos (id_Atendimento,Id_Funcionario,Tbl_Procedimento,Cod_AMB,QTD_CH,CH_CONVENIO,Data_Procedimento,Valor) VALUES ( '"&Cint(Request("id_Atendimento"))&"' , '"&Cint(Request("id_Func_Medico")(x))&"' , '"&Rs("Tbl_Procedimentos")&"' , '"&Trim(Replace(Request("Cod_AMB"),"'","''"))&"' , '"&Cint(Request("QTD_CH"))&"' , '"&Rs("CH")&"' , '"&Request("Data_Procedimento")&"' , '"&Valor&"' ) "
								conn.execute(SQL)
				
					Next								
					
				End if
			Rs.Close
			Set Rs = Nothing

End Function

Function Gravar_Auxiliares

	SQL	=	"SELECT dbo.HomeCare_Atendimento.id AS id_Atendimento, dbo.Convenios.Convenio, dbo.Convenios.Tbl_Procedimentos, dbo.Convenios.CH " &_ 
			"FROM dbo.HomeCare_Atendimento INNER JOIN "&_ 
			"dbo.HomeCare_Solicitacao_Atendimento ON  " &_ 
			"dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento = dbo.HomeCare_Solicitacao_Atendimento.id INNER JOIN " &_
			"dbo.Convenios ON dbo.HomeCare_Solicitacao_Atendimento.id_Convenio = dbo.Convenios.id " &_ 
			"WHERE   (dbo.HomeCare_Atendimento.id = "&Cint(Request("id_Atendimento"))&") "
			
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros

					For x = 1 To Request.Form("id_Func_Auxiliar").Count

							'Regra para calcular o valor dos auxiliares da AMB 90 e 92
							'1º Auxiliar - QTD CH da tabela AMB multiplicado pelo CH do Convênio menos 70% - Calculo (QTD_CH * CH_Convenio) - 70%
							'2,3,4 e 5º Auxiliar - QTD CH da tabela AMB multiplicado pelo CH do Convênio menos 80% - Calculo (QTD_CH * CH_Convenio) - 80%
							if Request("Ordem_Auxiliar")(x) = "1" Then Valor = (Request("QTD_CH") * Rs("CH")) - ((Request("QTD_CH") * Rs("CH")) * 0.7) End if
							if Request("Ordem_Auxiliar")(x) = "2" Or Request("Ordem_Auxiliar")(x) = "3" or Request("Ordem_Auxiliar")(x) = "4" or Request("Ordem_Auxiliar")(x) = "5" Then Valor = (Request("QTD_CH") * Rs("CH")) - ((Request("QTD_CH") * Rs("CH")) * 0.8) End if
						
						SQL = 	"INSERT INTO HomeCare_Atendimento_Procedimentos (id_Atendimento,Id_Funcionario,Tbl_Procedimento,Cod_AMB,QTD_CH,CH_CONVENIO,Ordem_Auxiliar,Data_Procedimento,Valor) VALUES ( '"&Cint(Request("id_Atendimento"))&"' , '"&Cint(Request("id_Func_Auxiliar")(x))&"' , '"&Rs("Tbl_Procedimentos")&"' , '"&Trim(Replace(Request("Cod_AMB"),"'","''"))&"' , '"&Cint(Request("QTD_CH"))&"' , '"&Rs("CH")&"' , '"&Request("Ordem_Auxiliar")(x)&"' , '"&Request("Data_Procedimento")&"' , '"&Valor&"' ) "
								conn.execute(SQL)
				
					Next								
					
				End if
			Rs.Close
			Set Rs = Nothing
		
End Function

Function Gravar

	On Error Resume Next 'Inicia o Tratamento de erro
		Conn.BeginTrans  'Inicia a Transação
		Call Gravar_Medico
		Call Gravar_Auxiliares
	If Err <> 0 Then 'Verifica se ocorreu algum erro
		Conn.RollbackTrans 'Se foi detectado algum erro entao a Transação é desfeita e nao é inserido nenhum registro
		Response.Write "Foi detectado um erro e a ação foi cancelada: " & Err.Description
		Response.End
	Else
		Conn.CommitTrans 'Caso não tenha ocorrido nenhum erro entao a transação é efeutuado com sucesso
	End if

End Function

Function Visualiza_Procedimentos

	SQL	=	"SELECT HomeCare_Atendimento_Procedimentos.*, Funcionarios.nome " &_ 
			"FROM HomeCare_Atendimento_Procedimentos INNER JOIN " &_ 
			"Funcionarios ON HomeCare_Atendimento_Procedimentos.Id_Funcionario = Funcionarios.id " &_ 
			"WHERE (HomeCare_Atendimento_Procedimentos.id_Atendimento = "&Cint(Request("id_Atendimento"))&") " &_ 
			"ORDER BY HomeCare_Atendimento_Procedimentos.Data ,HomeCare_Atendimento_Procedimentos.Ordem_Auxiliar, HomeCare_Atendimento_Procedimentos.Cod_AMB "
			
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
						Response.Write "<Table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda'>"
						Response.Write "<tr class='Titulo_Tabela'>"
						Response.Write "<td><b>Data:</b></td>"
						Response.Write "<td><b>Nº Atend.:</b></td>"
						Response.Write "<td><b>Tabela:</b></td>"
						Response.Write "<td><b>Código:</b></td>"
						Response.Write "<td><b>Nome:</b></td>"
						Response.Write "<td><b>CH AMB:</b></td>"
						Response.Write "<td><b>CH Convênio:</b></td>"
						Response.Write "<td><b>Ordem:</b></td>"
						Response.Write "<td><b>Valor:</b></td>"
						Response.Write "</tr>"
						Total = 0
					For x = 1 to Rs.RecordCount
						If rs.eof then Exit For
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						If not IsNull(Rs("Ordem_Auxiliar")) Then Ordem = Rs("Ordem_Auxiliar") & "º Auxiliar" Else Ordem = "Médico(a)" End if
						Total = Total + Rs("Valor")
						Response.Write "<tr class='zebra_orange1'>"
						Response.Write "<td class='"&zebrado&"'>" & Rs("Data_Procedimento") & "</td>"
						Response.Write "<td class='"&zebrado&"'>" & Rs("Id_Atendimento") & "</td>"
						Response.Write "<td class='"&zebrado&"'>" & Rs("Tbl_Procedimento") & "</td>"
						Response.Write "<Td class='"&zebrado&"'>" & Rs("Cod_AMB") & "</td>"
						Response.Write "<td class='"&zebrado&"'>" & Rs("Nome") & "</td>"
						Response.Write "<td class='"&zebrado&"'>" & Rs("Qtd_CH") & "</td>"
						Response.Write "<td class='"&zebrado&"'>" & Rs("CH_Convenio") & "</td>"
						Response.Write "<td class='"&zebrado&"'>" & Ordem & "</td>"
						Response.Write "<td class='"&zebrado&"'>" & FormatCurrency(Rs("Valor")) & "</td>"
						Response.Write "</tr>"
					Rs.MoveNext
					Next
					Response.Write "<Tr align='right' class='zebra_orange1'>"
					Response.Write "<td colspan='9' class='"&zebrado&"' >Total:&nbsp;&nbsp;<b><font color='#FF0000'>"&FormatCurrency(Total)&"</Font></b></td>"
					Response.Write "</tr>"
					Response.Write "</table>"
				End if
			Rs.close
			Set Rs = Nothing

End Function

%>
<html>
<body>
<fieldset>
<legend  align="center" >&nbsp;Procedimentos&nbsp;</legend>
<table width="100%" border="0" cellpadding="0" cellspacing="1">
  <form name="form1" method="post" action="">
    <tr class='zebra_orange1'> 
      <td width="14%"><strong>N&ordm; Atendimento:</strong></td>
      <td width="58%"><strong>Paciente:</strong></td>
      <td width="7%"><strong>Idade:</strong></td>
      <td width="10%"><strong>Sexo:</strong></td>
      <td width="11%"><strong>Conv&ecirc;nio:</strong></td>
    </tr>
    <tr class='zebra_orange1'> 
      <td><input name="id_Atendimento" type="text" id="id_Atendimento" onKeyPress="return MascaraCampo(document.form1, 'id_Atendimento', '99999999', event);" value="<%=Request("id_Atendimento")%>" size="5" maxlength="5"> 
        <input type="submit" name="Submit" value="Buscar"></td>
      <td><%=Paciente%></td>
      <td><%=Idade%></td>
      <td><%=Sexo%></td>
      <td><%=Convenio%></td>
    </tr>
  </form>
</table>
<table width="100%">
<form name="formCadastro" method="post" action="Procedimentos.asp?Action=Gravar" onSubmit= "return valida_campo()">
  <tr>
    <td>
	
<table width="100%" border="0" cellspacing="1" cellpadding="0">
          <tr class='zebra_orange1'> 
            <td colspan="4"><strong>Data do Procedimento:</strong></td>
          </tr>
          <tr class='zebra_orange1'>
            <td colspan="4"><input class="campos" name="Data_Procedimento" value="" size="12" onFocus="this.blur()" readonly> 
              <a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fStartPop(document.formCadastro.Data_Procedimento,'');return false;" HIDEFOCUS><img name="popcal" align="absmiddle" src="/SmartCare/bibliotecas/calendario/calbtn.gif" width="34" height="22" border="0" alt=""></a> 
              <iframe width=132 height=142 name="gToday:contrast:/SmartCare/bibliotecas/calendario/agenda.js" id="gToday:contrast:/SmartCare/bibliotecas/calendario/agenda.js" src="/SmartCare/bibliotecas/calendario/ipopeng.htm" scrolling="no" frameborder="0" style="visibility:visible; z-index:999; position:absolute; left:-500px; top:0px;"> 
              </iframe> </td>
          </tr>
          <tr class='zebra_orange1'> 
            <td width="10%"><strong>Cod. AMB: </strong></td>
            <td width="68%"><strong>Procedimento: 
              <input name="id_Atendimento" type="hidden" id="id_Atendimento" value="<%=Request("id_Atendimento")%>">
              </strong></td>
            <td width="11%"><strong>QTD CH:</strong></td>
            <td width="11%"><strong>N&ordm; Auxiliares:</strong></td>
          </tr>
          <tr class='zebra_orange1'> 
            <td><input name="Cod_AMB" type="text" class="campos" id="Cod_AMB" onchange="CarregaAMB(formCadastro.Cod_AMB)" size="8" maxlength="8"  > 
              <a href="javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Busca_AMB/default.asp?Tipo_Busca_Simpro=50&Tipo_Produto_Simpro=50&Posicao_Vetor=0','900','600',this,event)"><img src="/SmartCare/images/lupa.gif" alt="Consultar lista de m&eacute;dicos do cremesp"  border="0"></a></td>
            <td><input readonly name="Descricao_AMB" type="text" class="campos" id="Descricao_AMB" size="99"></td>
            <td><input readonly name="QTD_CH" type="text" class="campos" id="QTD_CH" size="10" maxlength="20"></td>
            <td><input readonly name="Numero_Auxiliares" type="text" class="campos" id="Numero_Auxiliares" size="3" maxlength="10"></td>
          </tr>
          <tr> 
            <td colspan="4"><span id='Carrega_Lista_Medicamentos'><%=Busca_Profissionais(Cint(request("id_Atendimento")))%> <%=Busca_Auxliares(Cint(request("id_Atendimento")))%> </span></td>
          </tr>
          <tr class='zebra_orange1' align="center"> 
            <td colspan="4"> <input type="submit" name="Submit" value="Gravar Procedimento"> 
            </td>
          </tr>
        </table>
        <%=Visualiza_Procedimentos%> </td>
  </tr>
  </Form>
</table>

</fieldset>