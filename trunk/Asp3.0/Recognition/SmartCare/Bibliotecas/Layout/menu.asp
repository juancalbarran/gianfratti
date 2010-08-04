<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<%
IF Trim(Session("NivelMenu")) = "" Then 'Caso tenho acabado de entrar no sistema o menu que ficara aberto sera o de nivel 1
	Session("NivelMenu") = "1" 
End If 

If Trim(Request("NivelMenu")) <> "" Then 'Caso tenha clicado em algum item no menu entao guarda na session
	Session("NivelMenu") = Trim(Request("NivelMenu"))
	End if

If Trim(Session("NivelMenu")) <> "" Then 
	Session("NivelMenu") = Session("NivelMenu")
End if


'FUNÇÃO QUE MONTA O MENU DO FUNCIONARIO COM AS PEMISSÕES QUE ELE TEM ECESSO
Function Menu_Permissoes

	'[CONEXÃO COM O BANCO DE DADOS]
	set conn=server.createobject("adodb.connection")
	conn.open application("connstring")

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	'SOMENTE TRAZ AS CATEGORIAS QUE O FUNCIONARIO TEM ACESSO
	SQL =	"EXEC Menu_Categorias_Permissoes_Funcionarios '"&Session("id_Usuario")&"' "
			RS.open SQL, CONN, 3
			If Not RS.Eof Then
				Conta = 0
				Menu = ""
				For y = 1 To RS.RecordCount 'Faz um laço for nas categorias que o funcionario tem permissão
					If Conta = 0 Then Conta = 0 Else Conta = Conta + 1 End if 'utiliza a variavel CONTA para montar o Array, ou seja o numero de Zero a infinito. Existe esse IF pois o Array tem que iniciar com o numero Zero e não 1(um)
					'Concatena a variavel que ira montar o menu
					'Abaixo ele monta o menu das categorias. Existe um exemplo original na mesma pasta onde se encontra esse arquivo para ver como é fora do ASP
					Menu = Menu &_
					"Link["&Conta&"] = ""0|"&RS("Categoria")&"""; "  &  Chr(10)
				
					Set RS2 = Server.CreateObject("ADODB.Recordset")
					RS2.CursorLocation = 3 
					'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
					'Sexecuta a Proc que vai retornar as paginas que o funcionario tem acesso referente a categoria aberta acima
					SQL =	"EXEC Menu_Paginas_Permissoes_Funcionarios '"&Session("id_Usuario")&"' , '"&Rs("id")&"' "
							RS2.open SQL, CONN, 3
							If Not RS2.Eof Then
								For x = 0 To RS2.RecordCount 'Faz um loço para pegar as paginas que o funcionario tem permisão dentro das categorias que iram ser selecionadas no for acima
									If RS2.Eof Then Exit For
									if Trim(Rs2("Parametros")) <> "" Then Caractere = "&" Else Caractere = "?" End if 'Este If serve para saber se o campo PARAMETROS foi preenchido para controlar o sinal de ? e & na URL, se o parametro estiver preenchido entao o sinal de ? vem junto com ele
									Conta = Conta + 1 'Vai encrementando a variavel conta
									'Continua concatenando a variavel MENU , mas agora vai montar as paginas que o funcionario tem acesso
									Menu = Menu &_
									"Link["&Conta&"] = ""|"&RS2("Nome")&"|"&Application("dominio")&RS2("Link")&RS2("Parametros")&Caractere&"NivelMenu="&y&"|iFrameItens"&"""; "  &  Chr(10)
									
									
								RS2.MoveNext
								Next
								Rs2.Close
								Set Rs2 = Nothing
							End If
				Rs.MoveNext
				Next
				Rs.Close
				Set Rs = Nothing
				Menu_Permissoes = Menu
				Else
					Response.Write "Você não possui nenhuma permissão de acesso para navegar no administrador"
					Response.end
				End If
End Function

%>

<style>
#main_panel{border:1px solid darkblue; position:relative; overflow:hidden;}
.head_item{ background-color:#6285CA; font-size:11px; font-family:verdana; font:bold; border-top:1px solid darkblue; border-bottom:1px solid darkblue; position:absolute; left:0px; cursor:hand; text-align:left;}
.item{ background-color:#F0F0F0; font-family:verdana; font-size:10px; left:0px; position:relative; text-align:left;}
.item_panel{ position:absolute; background-color:#F0F0F0; left:0px;}
.item_panel a { text-decoration:none; color:black; cursor:hand; }
</style>
<form name="form_menu" method="post" action="">
  <%'Este form foi criado apenas para o js do menu saber quem esta se logando, se é o Funcionario ou o Cliente, o campo hidden é usado na função .js do menu%>
  <%If Session("Tipo_Login") = "1" Then Tamanho_Comprimento = "405" Else Tamanho_Comprimento = "200" End If%>
  <input name="Menu_Comprimento" type="hidden" id="Menu_Comprimento" value="<%=Tamanho_Comprimento%>">
</form>

<script language="JavaScript" src="<%=Application("dominio")%>/Bibliotecas/Layout/outlook.js"></script>
<script language="JavaScript">  

var Link  = new Array()

	//Chama função que ira montar o menu de permissões do funcionario
	<%=Menu_Permissoes%>

for (i=0;i<Link.length;i++){ 

	Link[i] = Link[i];
} 

start(<%=Session("NivelMenu")%>); //Define qual o menu que ao entrar na página aparecera aberto
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

