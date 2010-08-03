<%
' Autor: Fabrizio Gianfratti Manes
' Email: fabrizio@gianfratti.con	
' Data: 20/01/2005
' Descrição: Pagina de Login de Usuarios do sistema
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR FAZER A VERIFICACAO SE O USUARIO É VALIDO OU NAO
Function Login

	SQL	=	"SELECT * From Usuarios Where usuario_login = '"&Replace(Request("usuario"),"'","")&"' and  usuario_senha = '"&Replace(Request("senha"),"'","")&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not rs.eof then 'Verifica se o usuario existe
					Session("Logado") = True 'CASO FOR VALIDO ENTAO LIBERA 
					Response.Write "<script>location = '../categorias/default.asp' </script>"
					Response.end	
					Else
						Session("Logado") = False 'CASO NAO FOR VALIDO NÃO LIBERA
						Response.Write "<script>alert('Usuario ou Senha Invalidos')</script>"
						Response.Write "<script>location = '"&Request("pagina_retorno")&"' </script>"
						Response.end
				End if
			Rs.Close
			Set Rs = Nothing

End Function

'Função responsavel por deslogar o usuario
Function Logof

	Session("Logado") = False
	Response.Write "<script>location = '../../' </script>" 'Envia para a pagina principal do site

End Function


'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Login"
		Call Login 'CHAMA A FUNÇÃO QUE IRA VEIRIFICAR SE O USUARIO É VALIDO
	
	Case "Logof"
		Call Logof
		
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>