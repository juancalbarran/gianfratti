<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 13/01/2005
' Descrição: Pagina de administração de Cargos
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
Dim Id_Formulario_Dinamico ,Nome_Formulario,Legenda_Formulario
Dim Nome_Paciente

'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

Call BuscaPaciente
Call Formulario

Function BuscaPaciente

	SQL	=	"SELECT dbo.Pacientes.nome " &_ 
			"FROM dbo.HomeCare_Atendimento INNER JOIN " &_ 
			"dbo.HomeCare_Solicitacao_Atendimento ON  " &_ 
			"dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento = dbo.HomeCare_Solicitacao_Atendimento.id INNER JOIN " &_ 
			"dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id " &_ 
			"WHERE (dbo.HomeCare_Atendimento.id = "&cint(Request("id_Atendimento"))&") "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Nome_Paciente = Rs("Nome")
				End if
			Rs.Close
			Set Rs = nothing	
	

End Function

Function Formulario

	SQL	=	"SELECT * From Formulario_Dinamico Where id = "&Request("id_Formulario_Dinamico")&" "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Id_Formulario_Dinamico = Rs("id")
					Nome_Formulario = Rs("Nome")
					Legenda_Formulario = Rs("Legenda")
				End if
			Rs.Close
			Set Rs = nothing	

End Function

Function Perguntas(Lado)

	SQL	=	"SELECT * From Formulario_Dinamico_Perguntas Where id_Formulario_Dinamico = '"&Cint(Request("id_Formulario_Dinamico"))&"' AND Lado = "&Lado&" Order by Posicao"
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					For x = 1 To Rs.Recordcount
						If Rs.Eof Then Exit For
						tamanho_td = 100/Rs.RecordCount
						Response.Write "<fieldset>"
						Response.Write "<legend>"&Rs("Pergunta")&"</legend>"
						Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' >" & Chr(10)
							Response.Write "<Tr>"  & Chr(10)
								Response.Write "<Td class=texto>"&Respostas(Rs("id"))&"</Td>" & Chr(10)
							Response.Write "</Tr>" & Chr(10)
						Response.Write "</Table>" & Chr(10)
						Response.Write "</fieldset>"
					Rs.MoveNext
					Next
				End If
			Rs.Close
			Set Rs = Nothing
			
End Function

Function Respostas(id_Perguntas)

	SQL	=	"SELECT * From Formulario_Dinamico_Respostas Where id_Formulario_Dinamico_Perguntas = "&Cint(id_Perguntas)&" Order by Posicao"
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
							Response.Write "<Tr >" & Chr(10)
					For x = 1 To Rs.Recordcount
						If Rs.Eof Then Exit For
								If Rs("Tipo") = "1" Then PosicaoLayout = Rs("Resposta")&Verifica_Tipo_Campo(Rs("Tipo"),Rs("id_Formulario_Dinamico_Perguntas"),Rs("id"),Rs("Tamanho_Campo")) Else PosicaoLayout = Verifica_Tipo_Campo(Rs("Tipo"),Rs("id_Formulario_Dinamico_Perguntas"),Rs("id"),Rs("Tamanho_Campo"))&Rs("Resposta") End if
								Response.Write "<Td width=30% class=texto>"&PosicaoLayout&"</Td>" & Chr(10)
								If x mod 4 = 0 Then 'Quebra por coluna, o numero que estiver dividinho sera o numero de colunas
									Response.Write "</tr><tr>"
								End if

					Rs.MoveNext
					Next
							Response.Write "</Tr>" & Chr(10)
				End If
			Rs.Close
			Set Rs = Nothing
			
End Function

Function Check(Tipo,id_Pergunta,id_Resposta,id_Atendimento)

	SQL	=	"SELECT dbo.Formulario_Dinamico_Prontuario_Perguntas.id_Pergunta, dbo.Formulario_Dinamico_Prontuiario_Respostas.id_Resposta, " &_ 
			"dbo.Formulario_Dinamico_Prontuiario_Respostas.texto, dbo.Formulario_Dinamico_Prontuario_Perguntas.id_Atendimento " &_ 
			"FROM dbo.Formulario_Dinamico_Prontuario_Perguntas INNER JOIN " &_ 
			"dbo.Formulario_Dinamico_Prontuiario_Respostas ON  " &_ 
			"dbo.Formulario_Dinamico_Prontuario_Perguntas.id = dbo.Formulario_Dinamico_Prontuiario_Respostas.id_Prontuario_Perguntas " &_ 
			"WHERE (dbo.Formulario_Dinamico_Prontuario_Perguntas.id_Pergunta = '"&Cint(id_Pergunta)&"') AND (dbo.Formulario_Dinamico_Prontuiario_Respostas.id_Resposta = '"&Cint(id_Resposta)&"') AND (id_Atendimento = '"&id_Atendimento&"') "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					if tipo = 1 Then Check = Rs("Texto") 'Tipo 1 é Text
					if tipo = 2 Then Check = "checked" 'Tipo 2 é CheckBox
					if tipo = 3 Then Check = "checked" 'Tipo 3 é Radio
					if tipo = 4 then Check = Rs("Texto") 'Tipo 4 é TextArea
					Else
					Check = ""
				End If
			Rs.Close
			Set Rs = Nothing

End Function

Function Verifica_Tipo_Campo(Tipo,id_Pergunta,id_Resposta,Tamanho_Campo)
	
	If Tipo = "1" Then  'Tipo Text
		'Atenção - no NAME do campo é passado a seguinte nonenclatura outro.id_pergunta.id_resposta Isso foi feito pois este campo nao tinha como saber o id da resposta pois é campo livre
		Verifica_Tipo_Campo = "<input type='text' style='Height:15px' name=texto."&Cint(id_Pergunta)&"."&Cint(id_Resposta)&" size='"&Tamanho_Campo&"'' maxlength='300' value='"&Check(1,id_pergunta,id_Resposta,Request("id_Atendimento"))&"'>"
	End If

	If Tipo = "2" Then 'Tipo CheckBox
		Verifica_Tipo_Campo = "<input type='checkbox' name="&Cint(id_Pergunta)&" value="&Cint(id_Resposta)&" "&Check(2,id_pergunta,id_Resposta,Request("id_Atendimento"))&" >"
	End If

	If Tipo = "3" Then 'Tipo Radio Button
		Verifica_Tipo_Campo = "<input type='radio' name="&Cint(id_Pergunta)&" value="&Cint(id_Resposta)&" "&Check(3,id_pergunta,id_Resposta,Request("id_Atendimento"))&" >"
	End If

	If Tipo = "4" Then 'Tipo TextArea
		'Atenção - no NAME do campo é passado a seguinte nonenclatura texto.id_pergunta.id_resposta Isso foi feito pois este campo nao tinha como saber o id da resposta pois é campo livre
		Verifica_Tipo_Campo = "<textarea name=texto."&Cint(id_Pergunta)&"."&Cint(id_Resposta)&" cols='56' rows='"&Tamanho_Campo&"' >"&Check(4,id_pergunta,id_Resposta,Request("id_Atendimento"))&"</textarea>"
	End If
	
End Function
%>
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<title>Documento sem t&iacute;tulo</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<table width="100%">
  <tr> 
    <td width="50%" valign="top">
<table width="100%">
        <tr>
          <td><img src="/SmartCare/Images/logoteste.gif" width="300" height="32"></td>
        </tr>
      </table>
      <table width="100%">
        <tr>
          <td align="center" class="texto"><strong><%=Nome_Formulario%></strong></td>
        </tr>
      </table> </td>
    <td width="50%" valign="top" >
	<fieldset>
	  <table width="100%">
        <tr> 
          <td width="15%" class="texto">Paciente:</td>
          <td class="texto"><strong><%=Nome_Paciente%></strong></td>
          <td class="texto">Atendimento:</td>
          <td class="texto"><strong><%=Request("id_Atendimento")%></strong></td>
        </tr>
        <tr> 
          <td class="texto">Passagem:</td>
          <td width="40%" class="texto">&nbsp;</td>
          <td width="12%" class="texto">Leito:</td>
          <td width="33%" class="texto">&nbsp;</td>
        </tr>
        <tr> 
          <td class="texto">Prontu&aacute;rio:</td>
          <td colspan="3" class="texto">&nbsp;</td>
        </tr>
      </table>
	  </fieldset>
	  </td>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="3">
  <form name="form" method="post" action="gravar.asp?id_Atendimento=<%=Request("id_Atendimento")%>&id_Formulario_Dinamico=<%=Request("id_Formulario_Dinamico")%>">
    <tr> 
      <td colspan="2" valign="top" class="texto" ><%=Legenda_Formulario%></td>
    </tr>
    <tr> 
      <td width="50%" valign="top"><%=Perguntas(1)%> </td>
      <td width="50%" valign="top"><%=Perguntas(2)%></td>
    </tr>
    <tr align="center"> 
      <td colspan="2" valign="top"> <input type="submit" name="Submit" value="Enviar"> 
      </td>
    </tr>
  </form>
</table>
</body>
</html>
<% 
'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>