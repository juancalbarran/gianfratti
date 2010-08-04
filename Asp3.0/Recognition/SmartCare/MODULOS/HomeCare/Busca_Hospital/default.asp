<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Grid/Grid.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<script language="javascript">
<!--
//FUNÇÃO QUE TRANSFERE O CONTEUDO DA PAGINA PARA OUTRA PAGINA
function Transfere(Numero,Nome) 
	{
	window.opener.document.formCadastro.id_Hospital.value = Numero; //Envia para o campo da pagina 
	window.opener.document.formCadastro.Hospital_Nome.value = Nome; //Envia para o campo da pagina 
	window.close();
	return
	}
//-->
</script>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="Tit_Box_blue"> 
    <td align="center">Gerenciador de Hospitais</td>
  </tr>
</table>
<%
'[DELCARAÇÃO DAS VARIAVEIS GLOBAIS]
dim oConn, oPamellaGridClass, startTimer

'[Inicia de tempo que a pagina leva para abrir]
startTimer = timer

'[CONEXÃO COM O BANCO DE DADOS]
set Conn = Server.CreateObject( "ADODB.Connection" )
Conn.CursorLocation = 3 'adUserClient
Conn.Open application("connstring")

Set oPamellaGridClass = NEW PamellaGridClass

With oPamellaGridClass

    set .oConnection  = Conn
    .Keys             = ( "154855237068814" )	'Chave para acesso em "localhost"
    .cFormName        = "form"
    .nMaxRows         = "10"
    .cHeaderLabel     = "Gerenciador de Hospitais"
    .cHeaderAttribs   = "class=Cabecalho"
    .cFooterAttribs   = "align=center"
    .cEvenRowAttribs  = "class=LinhasImpares"
    .cOddRowAttribs   = "class=LinhasPares"
    .cNextLabel       = "Próxima página"
    .cNextAttribs     = "class=Proximo"
    .cPreviousLabel   = "Página anterior"
    .cPreviousAttribs = "class=Anterior"
    .cOrderAttribs    = "class=Ordem_Asc_Desc"
    .cTableAttribs    = "border=0 bgcolor=Gay  width=100% border='0' cellspacing='1' cellpadding='1' "

    .bCanSearch              = true
    .cSearchButtonAttribs    = "class=BotaoPesquisa"
    .cSearchButtonLabel      = "Pesquisar"
    .cSearchTextAttribs      = "class=TextoPesquisa"
    .cSearchOperatorsAttribs = "class=SelectsPesquisa"
    .cSearchFieldsAttribs    = "class=SelectsPesquisa"

    'Sintaxe: AddColumn Campo, Título, Attribs, pesquisável, tipo <C|D|B|N>, Expression
	.AddColumn "Nome"  , "Nome"       , "class=texto width=20%", true, "C", ""
	.AddColumn "Endereco"  , "Endereco"       , "class=texto width=20%", true, "C", ""
	.AddColumn "CEP"  , "CEP"       , "align=center class=texto width=10%", true, "C", ""
	.AddColumn "Bairro"  , "Bairro"       , "align=center class=texto width=10%", true, "C", ""
	.AddColumn "Cidade"  , "Cidade"       , "align=center class=texto width=10%", true, "C", ""
	.AddColumn "UF"  , "UF"       , "align=center class=texto width=2%", true, "C", ""
	.AddColumn "Telefone"  , "Telefone"       , "align=center class=texto width=12%", true, "C", ""
	.AddColumn "OBS"  , "OBS"       , "class=texto width=15%", true, "C", ""
	.AddColumn "ID"  , "Selecionar"       , "align=center class=texto width=10%", False, "C", "<a href=""javascript:Transfere('[[ID]]','{{Nome}}' )"" ><img src='/SmartCare/images/Selecionar.gif' border='0'   ></a>"
											
	.cSQL = "Select * From Hospital "

    .BuildGrid()

End With

'[Fecha Conexão Com Banco De Dados]
Conn.close
set Conn = nothing
'[Fecha o obejeto criado]
set oPamellaGridClass = nothing
'[Imprime o tempo que a pagina levou para ser carregada]
Response.write "<center><font size=-2 face=Arial>Página processada em " & round( Timer - StartTimer, 2 ) & " segundos</font></center>"
%>
