<%
' Autor: Fabrizio Gianfratti Manes
' Email: fabrizio@gianfratti.con	
' Data: 03/01/2005
' Descrição: Funções Globais
' Atualizado por: -
' Data: -
' Atualização: -

'CASO QUEIRA EXECUTAR ALGUMA FUNÇÃO INICIAL ENTAO USA ESTE ESPAÇO PARA  ISSO.
'*********************
Call SemCache 'Chama a função que nao deixa a pagina com cache
Call AguardeCarregamento 'Chama a função que executa escreve "Aguarde carregando.." 
'*********************

'FUNÇÃO RESPONSAVEL POR ESCREVER "AGUAEDE O CARREGAMENTO" ENQUANTO A PÁGINA ESTIVER SENDO EXECUTADO
Function AguardeCarregamento
  
 Response.Write "<center><div id='Carregando' style='display:block;'><br><br>"
 Response.Write "<font face='Arial, Tahoma' size='2' color='#330099'><b>Aguarde carregando...</b></font><br><br>"
 'Response.Write "<img src='progressbar.gif' alt='Carregando...' border='0'>"
 Response.Write "</div></center>"
 Response.Flush()
 Response.Write "<script language='javascript'>document.all.Carregando.style.display = 'none';</script>"

End Function

'FUNÇÃO RESPONSAVEL POR NAO DEIXAR CACHE NA PAGINA
'É CHAMADA NO INICIO DA BIBLIOTECA
Function SemCache

 Response.Buffer= True
 Response.AddHeader "cache-control", "private" 
 Response.AddHeader "pragma", "no-cache" 
 Response.ExpiresAbsolute = #January 1, 1990 00:00:01# 
 Response.Expires=Now()-1 
 Response.AddHeader "Cache-Control", "must-revalidate" 
 Response.AddHeader "Cache-Control", "no-cache"

End Function

'MONTA UM LIST BOX COM OS TITULOS E VALORES QUE DESEJAR. PARA USAR BASTA VER AS CONFIGURAÇÕES ABAIXO. FUNÇÃO MUITO UTIL
'ArrayValores = Array(1,0,3,125) 'Array dos valores
'ArrayTitulos = Array("Sim","Não","Talvez","Legal") 'Titulos para selecionar, tem que ser na mesma ordem do ArrayValores, para que cada titulo tenha o seu valor certo
'NomeCampo = "Teste" 'Nome que o campo vai ter. Ex: Teste
'ValorSelecionado = "0" 'Caso queira que algum Titulo Ja venha selecionado entao coloque algum valor que vc atribuiu no ArrayValores
'Evento = "onChange='document.form.submit()'" 'Caso queira algum evento entao coloque todo o codigo. Ex: onChange='document.form.submit()'
'NomeEstiloCss = "campos" 'Se quiser colocar algum Estilo Css entao coloque o nome do Estilo. Ex: campos
'Call GeraListBoxOpcoesManual(ArrayValores,ArrayTitulos,NomeCampo,ValorSelecionado,Evento,NomeEstiloCss)
Function GeraListBoxOpcoesManual(ArrayValores,ArrayTitulos,NomeCampo,ValorSelecionado,Evento,NomeEstiloCss)

	'Faz a verificação para saber se a quantidade de Titulos passados a função é igual a quantidade de Valores passados
	If Ubound(ArrayTitulos) <> Ubound(ArrayValores) Then
		Response.write "O Numero de Titulos não é igual ao numero de Valores passados a função" & "<br>"
		Response.Write "Quantidade de Titulos passados: "&Ubound(ArrayTitulos) & "<br>"
		Response.Write "Quantidade de Valores passados: "&Ubound(ArrayValores) & "<br>"
		Response.end
	End if
	
	Content = ""
	Content = Content & "<select name='"&Trim(NomeCampo)&"' id='select' class='"&Trim(NomeEstiloCss)&"' "&Trim(Evento)&" > " & Chr(10)
	For Y = Lbound(ArrayValores) To Ubound(ArrayTitulos)
		Selected = ""
		If Cstr(ValorSelecionado) = Cstr(ArrayValores(y)) Then
			Selected = "selected"
		End if
		Content = Content & "<option value='"&ArrayValores(y)&"' "&Selected&" >"&ArrayTitulos(y)&"</option>" & Chr(10)
	Next
	Content = Content & "</select>"
	GeraListBoxOpcoesManual = content
	response.write GeraListBoxOpcoesManual

End Function

'##############################################################
'#  Gera ListBoxes de acordo com os parâmetros passados       #
'#  @tabela: é a tabela de onde serão buscados os dados    #
'#  @tabelaid: é o nome do campo que é id da tabela     #
'#  @campo: é o nome do campo que contém o "nome"     #
'#  @valor_selecionado: é o valor que foi selecionado    #
'#  Ex: gerar_listbox("categorias","id_categoria","categoria_nome","4")
'##############################################################
Function gerar_listbox(tabela, tabelaid, campo, valor_selecionado)

	SQL =	"select " & tabelaid & ", " & campo & " from " & tabela & " order by " & campo
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.open SQL, conn, 3
			content = "<select name=""" & tabelaid & """ class=""campos"">"
			If Not rs.EOF Then
				content = content & "<option value=""""><<----Selecione---->></option>"
				For i = 1 to rs.RecordCount
					selected = ""
					If trim(rs(tabelaid)) = trim(valor_selecionado) Then
						selected = "selected"
					End If
					content = content & "<option value=""" & rs(tabelaid) & """ " & selected & ">" & rs(campo) & "</option>"
				rs.MoveNext
				Next
			Else
				content = content & "<option value="""">Não foram encontrados registros</option>"
			End If
			content = content & "</select>"
			rs.close
			Set rs = Nothing
			gerar_listbox = content

End function

'=============================================================================
'Função para enviar email, basta passar os parametros requeridos pela função
'Função muito util, todo o sistema esta usando esta função, entao cuidado quando fizer alterações brusca
'=============================================================================
Function enviar_email(de,para,com_copia,copia_oculta,assunto,texto)

	Set Mailer = CreateObject("CDONTS.NewMail") 'Componente usado e o Cdonts
		Mailer.From = de ' e-mail de quem esta enviando a mensagem 
		Mailer.To = para' e-mail de quem vai receber a mensagem 
		Mailer.CC = com_copia ' Com Cópia 
		Mailer.BCC = copia_oculta ' Com Cópia Oculta
		Mailer.BodyFormat = 0 ' parametro de formatação para HTML
		Mailer.MailFormat = cdoMailFormatText ' parametro de formatação 
		Mailer.Subject = assunto 'Assunto do email
		Mailer.Body = texto 'texto que sera enviado por email
		Mailer.Send 'envia o email
	Set Mailer = Nothing 'Destroi o objeto criado

End Function

'FUNÇÃO QUE PREENCHE ZEROS A ESQUERDA DE UMA STRING PASSADA PARA A FUNÇÃO
'EX: SE VOCÊ PASSAR UMA STRING DE DATA 1/8/2005 NESSE FORMATO ENTAO ESTA FUNÇÃO FAZ A FORMATAÇÃO PARA 01/08/2005
'PARA USAR:
'StrZero(string,2) numero que foi passado é a quantidade de numeros que a string tera que ter
Function StrZero(Str,Size)
   Dim x, Content
   Content = ""
   For x = 1 to Size 'Faz o laço for até o numero que foi passado como parametro na função
      Content = Content & "0"
   Next
   StrZero = Right(Content & Str,Size)
End Function


'FUNÇÃO QUE ARRUMA A DATA PARA O FORMATA DD/MM/AAAA
'PARA EXECUTAR USE ArrumaData(variavel)
Function ArrumaData(Data)
  
   IF Not IsNull(Trim(Data)) Then 'Verifica se a variavel passada não esta vazia
      
      ArrumaData = Day(Data) & "/" & Month(Data) & "/" & Right(Year(Data),4) 

   End If                       
   
End Function

'FUNÇÃO QUE ARRUMA A DATA E A HORA PARA O FORMATA DD/MM/AAAA 00:00:00
'PARA EXECUTAR USE ArrumaData(variavel)
Function ArrumaDataHora(Data)
   
   IF Not IsNull(Trim(Data)) Then 'Verifica se a variavel passada não esta vazia
      
	  'Usamos a função SrtZero para arrumar a quantidade de certa de numeros. Ex: 1/1/2005 8:5:58 a função formata para 01/01/2005 08:05:2005
      ArrumaDataHora = StrZero(Day(Data),2) & "/" & StrZero(Month(Data),2) & "/" & Right(Year(Data),4) & " " & _
                       StrZero(Hour(Data),2) & ":" & StrZero(Minute(Data),2) & ":" & StrZero(Second(Data),2)
   End If                       
   
End Function

'FUNÇÃO QUE MOSTRA A LISTA DE CONTEUDOS REFERENTE A PAGINA
Function ConteudosBox(id_Pagina)

	SQL	=	"SELECT CONTEUDOS.id_Conteudo, CONTEUDOS.id_pagina, CONTEUDOS.id_pagina, CONTEUDOS.Conteudo_Titulo, CONTEUDOS.Conteudo, PAGINAS.Pagina_Titulo " &_ 
			"FROM PAGINAS INNER JOIN CONTEUDOS ON PAGINAS.id_Pagina = CONTEUDOS.id_pagina " &_ 
			"Where Conteudo_Flag_Publicado = True And CONTEUDOS.id_pagina = "&id_pagina&"  " &_ 
			"Order By CONTEUDOS.Ordem"
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = ""
					Content = Content &_ 
					"<table width='35%' border='0' align='right' cellpadding='0' cellspacing='0' class='borda'>" & Chr(10) &_ 
						"<tr >" & Chr(10) &_
							"<td colspan='2' align='center' >"&"<b><a href='paginas.asp?id_pagina="&Rs("id_pagina")&"'>"&Rs("Pagina_Titulo")&"</a></b>"&"</td> " & Chr(10) &_
						"</tr>"& Chr(10) 
					For y = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_ 
						"<tr >" & Chr(10) &_
							"<td class='"&zebrado&"' width='3%' valign='middle'><img src='Img/conteudo.gif' width='20' height='9'></td> " & Chr(10) &_
							"<td class='"&zebrado&"' width='97%' valign='top'>"&"<a href='conteudos.asp?id_conteudo="&Rs("id_conteudo")&"'>"&Rs("Conteudo_Titulo")&"</a>"&"</td>" & Chr(10) &_
						"</tr>"& Chr(10) 
					Rs.MoveNext
					Next
					Rs.Close
					Set Rs = Nothing
					Content = Content &_ 
					"</table>"
				End If
						ConteudosBox = Content

End Function



%>

<script language="JavaScript">
//FUNÇÃO RESPONSAVEL POR PERGUNTAR SE DESEJA MESMO EXECUTAR DETERMINADA ACAO ANTES DE EXECUTA-LA
//PARA USAR COMO UM LINK BASTA USAR O SEGUINTE EXEMPLO ABAIXO:
//"<a href=""javascript:Confirmar(" & rs("id_Categoria") & " , '" & rs("Categoria_Nome") & "' , 'ATENÇÂO !!\nDeseja mesmo excluir a categoria:' , 'default.asp?action=ExcluirCategorias&id_Categoria="&rs("id_categoria")&"' )"" >Excluir</a>"
function Confirmar(IdValor,NomeRegistro,Mensagem,url)
	{
	if (confirm("Registo(ID) Nº " + IdValor + "\n\n" +Mensagem + "\n" + NomeRegistro  ))
		{
		location = url;
		}
	}

//************************************************************
//Função para qualquer tipo de mascara para campos
//Observação: As máscaras podem ser representadas como os exemplos abaixo: 
//CEP -> 99.999-999 
//CPF -> 999.999.999-99 
//CNPJ -> 99.999.999/9999-99 
//Data -> 99/99/9999 
//Tel Resid -> (99) 999-9999 
//Tel Cel -> (99) 9999-9999 
//Processo -> 99.999999999/999-99 
//C/C -> 999999-! 
//E por aí vai...vc pode criar as mascaras que desejar
//Para usar coloco esse linha no campo:
//onKeyPress="return MascaraCampo(document.form, 'Fone', '(99) 9999-9999', event);"
//************************************************************
function MascaraCampo(objForm, strField, sMask, evtKeyPress) { 
      var i, nCount, sValue, fldLen, mskLen,bolMask, sCod, nTecla; 

      if(document.all) { // Internet Explorer 
        nTecla = evtKeyPress.keyCode; } 
      else if(document.layers) { // Nestcape 
        nTecla = evtKeyPress.which; 
      } 

      sValue = objForm[strField].value; 

      // Limpa todos os caracteres de formatação que 
      // já estiverem no campo. 
      sValue = sValue.toString().replace( "-", "" ); 
      sValue = sValue.toString().replace( "-", "" ); 
      sValue = sValue.toString().replace( ".", "" ); 
      sValue = sValue.toString().replace( ".", "" ); 
      sValue = sValue.toString().replace( "/", "" ); 
      sValue = sValue.toString().replace( "/", "" ); 
      sValue = sValue.toString().replace( "(", "" ); 
      sValue = sValue.toString().replace( "(", "" ); 
      sValue = sValue.toString().replace( ")", "" ); 
      sValue = sValue.toString().replace( ")", "" ); 
      sValue = sValue.toString().replace( ":", "" ); 
	  sValue = sValue.toString().replace( " ", "" ); 
      sValue = sValue.toString().replace( " ", "" ); 
      fldLen = sValue.length; 
      mskLen = sMask.length; 

      i = 0; 
      nCount = 0; 
      sCod = ""; 
      mskLen = fldLen; 

      while (i <= mskLen) { 
        bolMask = ((sMask.charAt(i) == "-") || (sMask.charAt(i) == ".") || (sMask.charAt(i) == "/")) 
        bolMask = bolMask || ((sMask.charAt(i) == "(") || (sMask.charAt(i) == ")") || (sMask.charAt(i) == ":") || (sMask.charAt(i) == " ")) 

        if (bolMask) { 
          sCod += sMask.charAt(i); 
          mskLen++; } 
        else { 
          sCod += sValue.charAt(nCount); 
          nCount++; 
        } 

        i++; 
      } 

      objForm[strField].value = sCod; 

      if (nTecla != 8) { // backspace 
        if (sMask.charAt(i-1) == "9") { // apenas números... 
          return ((nTecla > 47) && (nTecla < 58)); } // números de 0 a 9 
        else { // qualquer caracter... 
          return true; 
        } } 
      else { 
        return true; 
      } 
    } 
//Fim da função MascaraCampo


</script>

<script language="Javascript1.2">
<!--

<!-- // load htmlarea
_editor_url = "";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ '/icdl/admin/bibliotecas/htmlarea/editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// -->
//-->
</script>


