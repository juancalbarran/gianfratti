<%
' Autor: Fabrizio Gianfratti Manes
' Data: 31/08/2005
' Descrição: Esta página colocada como include faz a verificação se o usuario esta logado no sistema, caso nao estiver entao manda para a pagina de login
' Atualizado por: -
' Data: -
' Atualização: -
%>
<script> 
//Esta função é responsavel caso o usuario feche o navegador sem clicar no botao de sair, ou seja apertando F4 ou fechando o navegador bruscamente
function abrejanela()
	{
		var acao=self.screenTop; 
		if (acao > 9000)
		{ 
			//Passa uma parametro no link onde tera um comando para fechar a popup automaticamente
			window.open("/SmartCare/login/default.asp?action=Logoff&ForcaBruta=1","","width=1,height=1"); 
		}
		else { return; }
	}
</script> 
<%
'Função resposavel por verificar se o usuario esta logado no sistema
Function VerificaUsuario
	If Session("Logado") <> True Then
	%>
		<!-- #include virtual="/SmartCare/Login/modelos/Form_Login.htm" -->
	<%
	Response.End
	End IF
End Function

'Função que verifica se o usuario logado tem permissão de acessar a pagina
Function VerificaPermissao

	'Pega a pagina que ele esta tentando abrir
	PaginaAtual =  Replace(Request.ServerVariables("SCRIPT_NAME"),"/SmartCare","")
	'Verifica se é a pagina principal do sistema, se for entao não executa a consulta, pois a pagina principal do sistema nao esta cadatrada na base de paginas
	if Trim(PaginaAtual) <> "/Default.asp" And Trim(PaginaAtual) <> "/Default2.asp"  Then
		'[CONEXÃO COM O BANCO DE DADOS]
		set Conn = Server.CreateObject( "ADODB.Connection" )
		Conn.CursorLocation = 3 'adUserClient
		Conn.Open application("connstring")
	
		SQL	=	"SELECT DISTINCT dbo.Menu_Paginas_Admin.Link " &_ 
				"FROM dbo.Menu_Paginas_Admin INNER JOIN " &_ 
				"dbo.Menu_Categorias_Admin ON dbo.Menu_Paginas_Admin.id_Menu_Categorias_Admin = dbo.Menu_Categorias_Admin.id INNER JOIN " &_ 
				"dbo.UsuariosXMenu_Paginas_Admin ON dbo.Menu_Paginas_Admin.id = dbo.UsuariosXMenu_Paginas_Admin.id_Menu_Paginas_Admin " &_ 
				"Where Menu_Paginas_Admin.Link = '"&PaginaAtual&"' And UsuariosXMenu_Paginas_Admin.id_Usuario = '"&Session("id_Usuario")&"'  "
				Set rs = server.createobject("adodb.recordset")
				Rs.open SQL, CONN, 3
				IF RS.EOF THEN 'Caso ele nao tenha permissão exibimos a mensagem
					Response.Write "<script>alert('Prezado(a) "&Session("Funcionario_Nome")&"\n Você não possui permissão para acessar esta página')</script>"
					Response.Write "<script>location = '"&Application("Dominio")&"' </script>"
					response.end
				End if
		Rs.Close
		Set Rs = nothing
	End if

End Function

Call VerificaUsuario 'Executa a função para ver se o usuario esta logado no sistema
Call VerificaPermissao
%>
