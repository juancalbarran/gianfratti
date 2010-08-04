<%
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

	id_Formulario_Dinamico =  Request("id_Formulario_Dinamico") 'Recupera o id do formulario que esta vindo de um campo Hidden
	id_Atendimento = Request("id_Atendimento") 'Recupera o id do atendimento que esta vindo de um campo Hidden

	'Antes de qualquer ação é apagado as perguntas e respostas do formulario referente ao atendimento
	SQL	=	"DELETE FROM Formulario_Dinamico_Prontuario_Perguntas Where id_Formulario_Dinamico = '"&id_Formulario_Dinamico&"' And id_Atendimento = '"&id_Atendimento&"' "
			On Error Resume Next 'Inicia o Tratamento de erro por segurança
			Conn.BeginTrans  'Inicia a Transação
			conn.execute(SQL) 'Executa a Query

	For Each item In Request.Form 'Faz um laço nas perguntas
		If item <> "Submit" or Request.Form(item) <> "Enviar"  Then 'Ignora as propriedades do botao enviar
			For X = 1 To Request.Form(item).Count 'Faz um laço das respostas dentro das suas respectiva perguntas
				If Trim(item) <> "" and Trim(Request.Form(item)(x)) <> ""  Then 'Verifica se a pergunta fo respondida
					if InStr(item, ".") <> 0 Then 'Faz verificação para saber se o campo esta no formato Texto.id_Pergunta.id_Resposta e divide por vetor
						Vetor = Split(item, ".", -1, 1) 'Da um Splite no Ponto que separa a momeclatura que foi definido
						id_Pergunta = Vetor(1) 'Pega o ID da Pergunta na posicao 1
						id_Resposta = Vetor(2) 'Pega o ID da Resposta na posicao 2
						Else 'Caso não seja campo Texto(TextArea) ou Outros(Text) entao
							id_Pergunta = item 'Pega o ID da Pergunta
							id_Resposta = Request.Form(item)(x) 'Pega o ID da Resposta
					End if
					if left(item,6) = "texto." or left(item,6) = "outro." then Texto = Replace(Request.Form(item)(x),"'","") Else Texto = Null End if  'Verifica se a resposta é do tipo(Texto)
					'Antes de fazer o insert faz um select para saber se o id da pergunta já foi gravado, caso foi então não pode ser gravado de novo
					SQL	=	"SELECT Top 1 id From Formulario_Dinamico_Prontuario_Perguntas Where id_Atendimento = '"&id_Atendimento&"' and id_Formulario_Dinamico = '"&id_Formulario_Dinamico&"' and id_Pergunta = '"&Cint(id_Pergunta)&"' "
							Set rs = server.createobject("adodb.recordset")
							Rs.open SQL, CONN, 3
								IF rs.eof then 'Verifica se a pegunta já foi gravado, caso nao tenha sido então é gravada
									SQL_Pergunta = 	"INSERT INTO Formulario_Dinamico_Prontuario_Perguntas (id_Atendimento,id_Formulario_Dinamico,id_Pergunta) VALUES ( '"&id_Atendimento&"' , '"&id_Formulario_Dinamico&"' , '"&Cint(id_Pergunta)&"'  ) "
													Conn.execute(SQL_Pergunta) 'Executa a Query
													id_Transacao = Conn.execute("SELECT @@IDENTITY")(0).Value 'Pega o id para ser usado para gravar na tabela de respostas
									Else 'Caso a pergunta já foi inserida então buscamos o id para ser usado no insert das respostas
									 id_Transacao = Rs("id")
								End if
					'Faz o insert da resposta
					SQL_Resposta = 	"INSERT INTO Formulario_Dinamico_Prontuiario_Respostas (id_Prontuario_Perguntas,id_Resposta,Texto) VALUES ( '"&Cint(id_Transacao)&"' , '"&Cint(id_Resposta)&"' , '"&Texto&"'  ) "
									Conn.execute(SQL_Resposta) 'Executa a Query
									
				End if
			Next
		End if
	Next

	If Err <> 0 Then 'Verifica se ocorreu algum erro
		Conn.RollbackTrans 'Se foi detectado algum erro entao a Transação é desfeita e nao é inserido nenhum registro
		'Response.Write "Foi detectado um erro e a ação foi cancelada: " & Err.Description
		response.write "<script>alert('Um erro foi detectado e a operação foi cancelada');</script>" 
		response.write "<script>javascript:history.back();</script>" 'Volta a pagina do formulario sem apagar as opcoes selecionadas no formulario
		Response.End
		Else
		Conn.CommitTrans 'Caso não tenha ocorrido nenhum erro entao a transação é efeutuado com sucesso
		response.write "<script>location = 'default.asp?id_Atendimento="&id_Atendimento&"&id_Formulario_Dinamico="&id_Formulario_Dinamico&" ' </script>"
	End If
	
'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>