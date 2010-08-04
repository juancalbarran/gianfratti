<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 04/04/2005
' Descrição: Pagina de Login
' Atualizado por: -
' Data: -
' Atualização: -
%>
<script>
//Fncao que vai criar as Sessions no ASP.NET
function LoginAspNet(Login,Email,Funcionario_Nome,Funcionario_Email,Departamento_Nome,Cargo,id_Funcionario,id_Usuario,id_Cargo,id_Convenio,Convenio_Nome,Tipo_Login)
{

	xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
	xmlHTTP.Open('POST', 'CriaSessions.aspx?Login=' + Login + '&Funcionario_Nome='+Funcionario_Nome + '&Funcionario_Email=' + Funcionario_Email + '&Departamento_Nome=' + Departamento_Nome + '&Cargo=' + Cargo + '&id_Funcionario=' + id_Funcionario + '&id_Usuario=' + id_Usuario + '&id_Cargo=' + id_Cargo + '&id_Convenio=' + id_Convenio + '&Convenio_Nome=' + Convenio_Nome + '&Tipo_Login=' + Tipo_Login , false); // Seta a pagina onde ira buscar os dados.
	xmlHTTP.Send(); //Envia
	
}
</script>
<%
'[CONEXÃO COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUNÇÃO RESPONSAVEL POR FAZER O LOGIN DO USUARIO
'A VERIFICACAO DO SISTEMA PARA SABER SE O USUARIO ESTA LOGADO SE ENCONTRA NA PAGINA TOPO DO LAYOUT QUE É USADA EM TODAS AS PAGINAS
Function Login()

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL	=	"SELECT dbo.Usuarios.Login, dbo.Usuarios.Senha, dbo.Usuarios.Tipo, dbo.VIEW_Login.Tipo_Login, dbo.VIEW_Login.id_Usuario, dbo.VIEW_Login.id, "&_ 
            "dbo.VIEW_Login.nome, dbo.VIEW_Login.email, dbo.VIEW_Login.Departamento_Nome, dbo.VIEW_Login.id_Cargo, dbo.VIEW_Login.Cargo, "&_ 
            "dbo.VIEW_Login.id_Convenio, dbo.VIEW_Login.Convenio_Nome "&_ 
			"FROM dbo.Usuarios INNER JOIN "&_  
            "dbo.VIEW_Login ON dbo.Usuarios.id = dbo.VIEW_Login.id_Usuario "&_ 
			"Where Usuarios.Login = '"&Trim(Replace(Request("Login"),"'",""))&"' AND Usuarios.Senha = '"&Trim(Replace(Request("Senha"),"'",""))&"' AND Usuarios.Login <> '' AND  Usuarios.Senha <> ''   "
			Rs.open SQL, CONN, 3
				If Rs.Eof Then 'CASO O USUARIO NÃO EXISTA
					Session("Logado") = False 'SETA A SESSION PARA FALSE
					Response.Write "<script>alert('Acesso não autorizado.')</script>"
					Response.Write "<script>location = 'JavaScript:history.back()' </script>"
					Response.End
					Else 
						Session("Logado") = True 'SETA A SESSION PARA TRUE
						Session("Login") = Rs("Login") 'GUARDA O LOGIN DO FUNCIONARIO
						Session("Email") = Rs("Email") 'GUARDA O EMAIL DO FUNCIONARIO
						Session("Funcionario_Nome") = Rs("Nome") 'GUARDA O NOME DO FUNCIONARIO
						Session("Funcionario_Email") = Rs("email") 'GUARDA O ID DO CARGO PARA FUTURAS APLICAÇÕES USAR
						Session("Departamento_Nome") = Rs("Departamento_Nome") 'GUARDA O NOME DO DEPARTAMENTO 
						Session("Cargo") = Rs("Cargo") 'GUARDA O NOME DO CARGO
						Session("id_Funcionario") = Rs("id") 'GUARDA O ID DO FUNCIONARIO PARA FUTURAS APLICAÇÕES USAR
						Session("id_Usuario") = Rs("id_Usuario") 'GUARDA O ID DO USUARIO LOGADO NO SISTEMA PARA ABRIR O MENU CONFORME AS SUAS PERMISSÕES DE ACESSO
						Session("id_Cargo") = Rs("id_Cargo") 'GUARDA O ID DO CARGO PARA FUTURAS APLICAÇÕES USAR
						Session("id_Convenio") = Rs("id_Convenio") 'GUARDA O ID DO CONVENIO QUE SERA USADO
						Session("Convenio_Nome") = Rs("Convenio_Nome") 'GUARDA O NOME DO CONVENIO QUE SERA USADO
						Session("Tipo_Login") = Rs("Tipo_Login") 'VERIFICA SE O	USUARIO LOGADO É FUNCIONARIO OU CONTATO DE UM CONVENIO
						Call Guarda_Cookie_Login(Rs("Login")) 'CHAMA A FUNÇÃO QUE IRA GUARDAR O COOKIE COM O NOME DO LOGIN
						Call Grava_Log_Login("1") 'Chama a função que ira criar um log do historico do login
						'Chama a função abaixo que vai criar as Sessions no asp.net
						Response.Write "<Script>LoginAspNet('"&Session("Login")&"','"&Session("Email")&"','"&Session("Funcionario_Nome")&"','"&Session("Funcionario_Email")&"','"&Session("Departamento_Nome")&"','"&Session("Cargo")&"','"&Session("id_Funcionario")&"','"&Session("id_Usuario")&"','"&Session("id_Cargo")&"','"&Session("id_Convenio")&"','"&Session("Convenio_Nome")&"','"&Session("Tipo_Login")&"'  )</Script>"
						Response.write "<Script>location.href='"&Application("dominio")&"'</Script>" 'Antes estava Request("pagina_retorno") que é um campo hidden do form de login
				End If
			
			Rs.Close
			Set Rs = Nothing

End Function


'FUNÇÃO RESPONSAVEL POR GUARDAR UM COOKIE NA MAQUINA DA PESSOA COM O LOGIN DELA PARA QUE NA PROXIMA VEZ JA APAREÇA O LOGIN NO FORMULARIO
Function Guarda_Cookie_Login(Login)

	'CASO O CHECKBOX NÃO ESTEJA TICADO ENTAO E GUARDADO O COOKIE
	If Trim(Request("Guarda_Cookie_Login")) <> "1" Then
		Response.Cookies("Login") = Login
		Else 'SE O CHECKBOX FOI MARCADO ENTAO O COOKIE É APAGADO
			Response.Cookies("Login") = ""
	End If

End Function

'FUNÇÃO QUE É CHAMADA PARA RE-ENVIAR A SENHA POR EMAIL
Function EnviarSenha

	If Trim(Replace(Request("Email"),"'","")) = "" Then
		Response.Write "<script>alert('Digite seu e-mail')</script>"
		Response.Write "<script>location = '"&Request("pagina_retorno")&"' </script>"
		Response.End
	End if
	
	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.Login_Lembrar_Senha '"&Trim(Replace(Request("Email"),"'","&nbsp;"))&"'  "
			Rs.open SQL, CONN, 3
				If Not Rs.Eof Then
					'Faz a verificação para saber se o funcionario tem login
					'Caso nao tiver ele atribui o valor do email do funcionario antes do Arroba(@)
					If IsNull(rs("login")) or Trim(rs("login")) = "" then
						Dim Array_login, login
						Array_login =  Split(rs("email"), "@") 'Pega apenas o nome do email antes do (@) que sera o login dele caso ele nao tenha
						login = Array_login(0) 'Atribui o Array_login a variavel login
						Else 'Caso ele ja tiver login entao o login sera o mesmo
							login = rs("login")
					End If

					senha = gera_senha(6) 'CHAMA A FUNÇÃO GLOBAL QUE GERA A SENHA QUE SERA ENVIADA POR EMAIL
					
					content = "" 'VARIAVEL QUE CONTEM O TEXTO QUE SERA ENVIADO NO EMAIL
					content = Content &_ 
					"Caro(a) "&rs("nome")&","&"<br>"&"<br>"&_
				
					"Seu login e sua senha de acesso ao sistema de Monitoramento"&"<br>"&_
					"é a seguinte:"&"<br>"&"<br>"&_
					
					login &"<br>"&_ 
					senha &"<br>"&"<br>"&_
				
					"Para sua segurança não revele sua senha a ninguém."&"<br>"&_
					"Se você não solicitou sua senha, não se preocupe. Essa mensagem"&"<br>"&_
					"foi enviada apenas para o seu e-mail, e só você tem acesso a ela."&"<br>"&"<br>"&_
				
					"Atenciosamente,"&"<br>"&_
					"Nome da Empresa"&"<br>"&"<br>"

					'Função que vai enviar o email com a nova senha gerada eo login do cliente
					'Chama a função que envia o email. Basta passar os parametros naA?eu?l??Ÿl??Ÿl? ordem (de,para,com_copia,copia_oculta,assunto,texto)
					Call enviar_email(application("email_adm"),rs("email"),"",application("email_adm_copia_oculta"),"Recuperação de Senha",Content)
											
					'APOS MANDAR O EMAIL PARA O USUARIO FAZ O UPDATE NA TABELA COM A NOVA SENHA GERADA E O LOGIN
					SQL	=	"UPDATE USUARIOS SET senha = '"&senha&"' , login = '"&login&"' Where id = '"&Cint(rs("id"))&"' "
					conn.execute(SQL)
						
					Rs.close
					Set Rs = Nothing
						Response.Write "<script>alert('Um email foi enviado a sua caixa postal cotendo uma nova senha de acesso ao sistema')</script>"
						Response.Write "<script>location = '"&Request("pagina_retorno")&"' </script>"
						Response.End
					Else
						Response.Write "<script>alert('Email Invalido')</script>"
						Response.Write "<script>location = '"&Request("pagina_retorno")&"' </script>"
						Response.End
				End if				

			Rs.Close
			Set Rs = Nothing

End Function

'FUNÇÃO QUE DESLOGA O USUARIO DO SISTEMA
Function Logoff

	Call Grava_Log_Login("2") 'Chama a função que ira criar um log do historico do login
	Session.Abandon() 'DESTROI TODAS SESSION CRIADAS PELO SISTEMA
	
	If Trim(Request("ForcaBruta")) = "1" Then 'Este If rebebe o valor 1 que foi passado da Função JavaScript que deslogou a pessoa do sistema, pq provavemente o usuario ou Apertou as teclas F4 ou clicou no botao fechar ou praticou alguma acao que feche o navagador sem ser clicando no botao sair
		Response.Write "<script>window.opener=self;window.close();</script>" 'Fecha a falela que foi aberta para deslogar o usuario, epenas isso. A função JavaScript que envia a Flag esta no VerificaUsuarioLogado.asp
		Else
		Response.Redirect "/SmartCare/" 
	End if

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Login"
		Call Login() 'FUNÇÃO QUE IRA FAZER O LOGIN
		
	Case "EnviarSenha"
		Call EnviarSenha()
		
	Case "Logoff"
		Call Logoff() 'FUNÇÃO QUE IRA FAZER O LOGOFF
						
	Case Else
%>
	<!-- #include virtual="/SmartCare/Login/modelos/Form_Login.htm" -->
<%
End Select

'Fecha Conexão Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>