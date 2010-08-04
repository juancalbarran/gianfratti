<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 19/08/2006
' Descrição: Pagina para laudos de avaliações
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim Label,Nome,Data,Laudo

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

Function CarregaDados(Tipo_Laudo,id_Solicitacao)
	SQL	=	"SELECT  id, dbo.FuncaoFuncionarioNome(id_Funcionario_Medico_Avaliador) AS NomeMedico, Medico_Avaliador_Data, Medico_Laudo, " &_ 
            "dbo.FuncaoFuncionarioNome(id_Funcionario_Enfermeiro_Avaliador) AS NomeEnfermeiro, Enfermeiro_Avaliador_Data, Enfermeiro_Laudo,  " &_ 
            "dbo.FuncaoFuncionarioNome(id_Funcionario_Assistente_Social_Avaliador) AS NomeAssistenteSocial, Assistente_Social_Avaliador_Data,  " &_ 
            "Assistente_Social_Laudo, dbo.FuncaoFuncionarioNome(id_Funcionario_Fisioterapeuta_Avaliador) AS NomeFisioterapeuta,  " &_ 
            "Fisioterapeuta_Avaliador_Data, Fisioterapeuta_Laudo " &_ 
			"FROM  dbo.HomeCare_Solicitacao_Atendimento " &_ 
			"Where id = '"&Cint(id_Solicitacao)&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					If Cint(Request("Tipo_Laudo")) = "1" Then 'Laudo do Medico
						if Isnull(Rs("NomeMedico")) Then Response.Write "<Script>alert('Você deve selecionar uma Médico(a) antes de escrever a avaliação\nSelecione uma Médico(a) na solicitacao, salve a solicitacao e insira a avaliação')</Script>" : Response.Write "<script>window.opener=self;window.close();</script>" : Response.end
						Label = "Médico:"
						Nome = "Dr." & Rs("NomeMedico")
						Data = Rs("Medico_Avaliador_Data")
						Laudo = Rs("Medico_Laudo")
					Elseif Cint(Request("Tipo_Laudo")) = "2" Then 'Enfermeiro
					if Isnull(Rs("NomeEnfermeiro")) Then Response.Write "<Script>alert('Você deve selecionar uma Enfermeiro(a) antes de escrever a avaliação\nSelecione uma Enfermeiro(a) na solicitacao, salve a solicitacao e insira a avaliação')</Script>" : Response.Write "<script>window.opener=self;window.close();</script>" : Response.end
						Label = "Enfermeiro(a):"
						Nome = Rs("NomeEnfermeiro")
						Data = Rs("Enfermeiro_Avaliador_Data")
						Laudo = Rs("Enfermeiro_Laudo")
					Elseif Cint(Request("Tipo_Laudo")) = "3" Then 'Assistente social
						if Isnull(Rs("NomeAssistenteSocial")) Then Response.Write "<Script>alert('Você deve selecionar uma Assistente Social antes de escrever a avaliação\nSelecione uma assistente social na solicitacao, salve a solicitacao e insira a avaliação')</Script>" : Response.Write "<script>window.opener=self;window.close();</script>" : Response.end
						Label = "Assistente Social:"
						Nome = Rs("NomeAssistenteSocial")
						Data = Rs("Assistente_Social_Avaliador_Data")
						Laudo = Rs("Assistente_Social_Laudo")
					Elseif Cint(Request("Tipo_Laudo")) = "4" Then 'Fisioterapeuta
					if Isnull(Rs("NomeFisioterapeuta")) Then Response.Write "<Script>alert('Você deve selecionar uma Fisioterapeuta antes de escrever a avaliação\nSelecione uma Fisioterapeuta na solicitacao, salve a solicitacao e insira a avaliação')</Script>" : Response.Write "<script>window.opener=self;window.close();</script>" : Response.end
						Label = "Fisioterapeuta:"
						Nome = Rs("NomeFisioterapeuta")
						Data = Rs("Fisioterapeuta_Avaliador_Data")
						Laudo = Rs("Fisioterapeuta_Laudo")
					End If
				End if
			Rs.Close
			Set Rs = Nothing
	
End Function

Function Atualiza_Laudo

	If Cint(Request("Tipo_Laudo")) = "1" Then 'Laudo do Medico
		SQL	=	"Update HomeCare_Solicitacao_Atendimento SET Medico_Laudo= '"&Trim(Replace(Request("Laudo_Descricao"),"'",""))&"' Where id = "&Cint(Request("id_Solicitacao"))
	Elseif Cint(Request("Tipo_Laudo")) = "2" Then 'Enfermeiro
		SQL	=	"Update HomeCare_Solicitacao_Atendimento SET Enfermeiro_Laudo= '"&Trim(Replace(Request("Laudo_Descricao"),"'",""))&"' Where id = "&Cint(Request("id_Solicitacao"))
	Elseif Cint(Request("Tipo_Laudo")) = "3" Then 'Assistente social
		SQL	=	"Update HomeCare_Solicitacao_Atendimento SET Assistente_Social_Laudo= '"&Trim(Replace(Request("Laudo_Descricao"),"'",""))&"' Where id = "&Cint(Request("id_Solicitacao"))
	Elseif Cint(Request("Tipo_Laudo")) = "4" Then 'Fisioterapeuta
		SQL	=	"Update HomeCare_Solicitacao_Atendimento SET Fisioterapeuta_Laudo= '"&Trim(Replace(Request("Laudo_Descricao"),"'",""))&"' Where id = "&Cint(Request("id_Solicitacao"))
	End if
	
	conn.execute(SQL)
	Response.Write "<Script>alert('Salvo com sucesso')</Script>"
	response.write "<script>location = 'LaudoAvaliacao.asp?id_Solicitacao="&Request("id_Solicitacao")&"&Tipo_Laudo="&Request("Tipo_Laudo")&" ' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction
		
	Case "Atualiza_Laudo"
		Call Atualiza_Laudo
		
	Case Else
		Call CarregaDados(Cint(Request("Tipo_Laudo")),Cint(Request("id_Solicitacao")))

End Select

'[Fecha Conexão Com Banco De Dados]
Conn.close
set Conn = nothing
%>
<html>
<head>
<title>Laudo de Avaliação</title>
</head>
<body>
  	<fieldset>
	
<legend align="center">Avaliação&nbsp;</legend>
	<table width="100%" height="100%"  border="0">
  		<tr>
		    <td valign="top">
			<table width="100%"  border="0">
			<form name="form1" method="post" action="LaudoAvaliacao.asp?action=Atualiza_Laudo&id_Solicitacao=<%=Request("id_Solicitacao")%>&Tipo_Laudo=<%=Request("Tipo_Laudo")%>">
              <tr class='zebra_orange1'>
                <td width="82%"><strong><%=Label%></strong></td>
                <td width="18%"><strong>Data e Hora:</strong></td>
              </tr>
              <tr class='zebra_orange1'>
                <td><%=Nome%></td>
                <td><%=Data%></td>
              </tr>
              <tr class='zebra_orange1'>
                
            <td colspan="2" class='zebra_orange1'><strong>Avalia&ccedil;&atilde;o:</strong></td>
              </tr>
              <tr align="center" class='zebra_orange1'>
                <td colspan="2"><textarea name="Laudo_Descricao" cols="90%" rows="29" id="Laudo_Descricao"><%=Laudo%></textarea></td>
              </tr>
              <tr align="center" class='zebra_orange1'>
                <td colspan="2"><a href="javascript:AbrePopUp('/SmartCare/Modulos/HomeCare/Solicitacao/ImprimirSolicitacao.asp?id_Solicitacao_Atendimento=<%=Id%>','850','680',this,event)">
                  <input src="/SmartCare/images/disquete.gif" alt="Salvar Avalia&ccedil;&atilde;o" onClick="return VerificaStatus('<%=id_Solicitacao_Status%>')" type="image" name="submit">
                </a>
                  </td>
              </tr>
			  </Form>
            </table>			</td>
		</tr>
	</table>
	</fieldset>
</body>
</html>
