<%
' Autor: Fabrizio Gianfratti Manes
' Data: 03/01/2005
' Descrição: Funções Globais
' Atualizado por: -
' Data: -
' Atualização: -

'Usado para quando usar o XMLHTTP não retornat caracteres estranhos, principalmente quando tem acentos e outros caracteres estranhas
Response.CharSet="iso-8859-1"

'FUNÇÃO RESPONSAVEL POR NAO DEIXAR CACHE NA PAGINA
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
	Content = Content & "<option value=''><--Selecione--></option>" & Chr(10)
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

'VERSÃO 2.0 DA FUNÇÃO GeraListBoxOpcoesManual
'Foi feito uma nova versão pois quando era emcapsulado dentro do ASP retornava 2 ListBox pelo fato que eu dava um Response.Write no nome da função
'MONTA UM LIST BOX COM OS TITULOS E VALORES QUE DESEJAR. PARA USAR BASTA VER AS CONFIGURAÇÕES ABAIXO. FUNÇÃO MUITO UTIL
'ArrayValores = Array(1,0,3,125) 'Array dos valores
'ArrayTitulos = Array("Sim","Não","Talvez","Legal") 'Titulos para selecionar, tem que ser na mesma ordem do ArrayValores, para que cada titulo tenha o seu valor certo
'NomeCampo = "Teste" 'Nome que o campo vai ter. Ex: Teste
'ValorSelecionado = "0" 'Caso queira que algum Titulo Ja venha selecionado entao coloque algum valor que vc atribuiu no ArrayValores
'Evento = "onChange='document.form.submit()'" 'Caso queira algum evento entao coloque todo o codigo. Ex: onChange='document.form.submit()'
'NomeEstiloCss = "campos" 'Se quiser colocar algum Estilo Css entao coloque o nome do Estilo. Ex: campos
'Call GeraListBoxOpcoesManual(ArrayValores,ArrayTitulos,NomeCampo,ValorSelecionado,Evento,NomeEstiloCss)
Function GeraListBoxOpcoesManual_V2(ArrayValores,ArrayTitulos,NomeCampo,ValorSelecionado,Evento,NomeEstiloCss)
	
	'Faz a verificação para saber se a quantidade de Titulos passados a função é igual a quantidade de Valores passados
	If Ubound(ArrayTitulos) <> Ubound(ArrayValores) Then
		Response.write "O Numero de Titulos não é igual ao numero de Valores passados a função" & "<br>"
		Response.Write "Quantidade de Titulos passados: "&Ubound(ArrayTitulos) & "<br>"
		Response.Write "Quantidade de Valores passados: "&Ubound(ArrayValores) & "<br>"
		Response.end
	End if
	
	Content = ""
	Content = Content & "<select name='"&Trim(NomeCampo)&"' id='select' class='"&Trim(NomeEstiloCss)&"' "&Trim(Evento)&" > " & Chr(10) 
	Content = Content & "<option value=''><--Selecione--></option>" & Chr(10)
	For Y = Lbound(ArrayValores) To Ubound(ArrayTitulos)
		Selected = ""
		If Cstr(ValorSelecionado) = Cstr(ArrayValores(y)) Then
			Selected = "selected"
		End if
		Content = Content & "<option value='"&ArrayValores(y)&"' "&Selected&" >"&ArrayTitulos(y)&"</option>" & Chr(10)
	Next
	Content = Content & "</select>"
	GeraListBoxOpcoesManual_V2 = content
	
End Function


'MONTA UM LIST BOX COM OS TITULOS E VALORES DO TIPO SANGUINEO
'NomeCampo = "Teste" 'Nome que o campo vai ter. Ex: Teste
'ValorSelecionado = "0" 'Caso queira que algum Titulo Ja venha selecionado entao coloque algum valor que vc atribuiu no ArrayValores
'Evento = "onChange='document.form.submit()'" 'Caso queira algum evento entao coloque todo o codigo. Ex: onChange='document.form.submit()'
'NomeEstiloCss = "campos" 'Se quiser colocar algum Estilo Css entao coloque o nome do Estilo. Ex: campos
'Call GeraListBoxOpcoesTipoSangue(NomeCampo,ValorSelecionado,Evento,NomeEstiloCss)
Function GeraListBoxOpcoesTipoSangue(NomeCampo,ValorSelecionado,Evento,NomeEstiloCss)

	ArrayValores = Array("A+","A-","B+","B-","O+","O-","AB") 'Array dos valores
	ArrayTitulos = Array("Tipo(A+)","Tipo(A-)","Tipo(B+)","Tipo(B-)","Tipo(O+)","Tipo(O-)","Tipo(AB)") 'Titulos para selecionar, tem que ser na mesma ordem do ArrayValores, para que cada titulo tenha o seu valor certo
	Content = ""
	Content = Content & "<select name='"&Trim(NomeCampo)&"' id='select' class='"&Trim(NomeEstiloCss)&"' "&Trim(Evento)&" > " & Chr(10) 
	Content = Content & "<option value=''><--Selecione--></option>" & Chr(10)
	For Y = Lbound(ArrayValores) To Ubound(ArrayTitulos)
		Selected = ""
		If IsNull(ValorSelecionado)  Then ValorSelecionado = " " End IF 'Faz uma vericação para saber se o valor é nulo
		If Cstr(ValorSelecionado) = Cstr(ArrayValores(y)) Then
			Selected = "selected"
		End if
		Content = Content & "<option value='"&ArrayValores(y)&"' "&Selected&" >"&ArrayTitulos(y)&"</option>" & Chr(10)
	Next
	Content = Content & "</select>"
	GeraListBoxOpcoesTipoSangue = content
	response.write GeraListBoxOpcoesTipoSangue

End Function


'##############################################################
'#  Gera ListBoxes de acordo com os parâmetros passados       #
'#  @tabela: é a tabela de onde serão buscados os dados    #
'#  @tabelaid: é o nome do campo que é id da tabela     #
'#  @nome_listbox: é o nome do list box HTML     #
'#  @campo: é o nome do campo que contém o "nome"     #
'#  @valor_selecionado: é o valor que foi selecionado    #
'#  Ex: gerar_listbox("categorias","id_categoria","categoria_nome","4")
'##############################################################
Function gerar_listbox(tabela,tabelaid,nome_listbox,campo,valor_selecionado)

	SQL =	"select " & tabelaid & ", " & campo & " from " & tabela & " order by " & campo
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.open SQL, conn, 3
			content = "<select name=""" & nome_listbox & """ class=""campos"">"
			If Not rs.EOF Then
				content = content & "<option value=""""><<----Selecione---->></option>"
				For i = 1 to rs.RecordCount
					If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
					selected = ""
					If trim(rs(tabelaid)) = trim(valor_selecionado) Then
						selected = "selected"
					End If
					content = content & "<option class='"&zebrado&"' value=""" & rs(tabelaid) & """ " & selected & ">" & rs(campo) & "</option>"
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

'Este é uma nova versão da função Gerar_ListBox, pois aquele nao aceitava passar a condicao de clausula na query
'##############################################################
'#  Gera ListBoxes de acordo com os parâmetros passados       #
'#  @tabela: é a tabela de onde serão buscados os dados    #
'#  @clausula: é a condição Where caso queira fazer algum filtro. Ex: basta passar na função Whrere FlgPublicado = 1
'#  @tabelaid: é o nome do campo que é id da tabela     #
'#  @nome_listbox: é o nome do list box HTML     #
'#  @campo: é o nome do campo que contém o "nome"     #
'#  @titulo: e o nome que aparecera no liste box. Exemplo <<----Selecione---->>
'#  @valor_selecionado: é o valor que foi selecionado    #
'#  Ex: <%=gerar_listbox_Automatico("Funcionarios"," Where id_Departamento = 5 AND id_Cargo = 3 ","id","id_Funcionario","Nome","<<----Todos Médicos---->>","")
'##############################################################
Function gerar_listbox_Automatico(tabela,clausula,tabelaid,nome_listbox,campo,titulo,valor_selecionado)

	'[CONEXÃO COM O BANCO DE DADOS]
	set Conn = Server.CreateObject( "ADODB.Connection" )
	Conn.CursorLocation = 3 'adUserClient
	Conn.Open application("connstring")

	SQL =	"select " & tabelaid & ", " & campo & " from " & tabela & " "& clausula & " order by " & campo
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.open SQL, conn, 3
			content = "<select name=" & nome_listbox & " class=campos>"
			If Not rs.EOF Then
				if titulo <> "" Then content = content & "<option value=''>"&titulo&"</option>" End if
				For i = 1 to rs.RecordCount
					If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
					selected = ""
					If trim(rs(tabelaid)) = trim(valor_selecionado) Then
						selected = "selected"
					End If
					content = content & "<option class='"&zebrado&"' value=" & rs(tabelaid) & " " & selected & ">" & rs(campo) & "</option>"
				rs.MoveNext
				Next
			Else
				content = content & "<option value=''>Não foram encontrados registros</option>"
			End If
			content = content & "</select>"
			rs.close
			Set rs = Nothing
			gerar_listbox_Automatico = content

End function

'##############################################################
'#  Gera RadioButton de acordo com os parâmetros passados       #
'#  @tabela: é a tabela de onde serão buscados os dados    #
'#  @clausula: é a condição Where caso queira fazer algum filtro. Ex: basta passar na função Whrere FlgPublicado = 1
'#  @tabelaid: é o nome do campo que é id da tabela     #
'#  @nome_radio: é o nome do list box HTML     #
'#  @campo: é o nome do campo que contém o "nome"     #
'#  @valor_selecionado: é o valor que foi selecionado    #
'#  @evento_js : é se quiser passar algum evento javascropt ex: onclick='javascript:exibecodigo()'
'#  Ex: <%=RadioButtonAutomatico("id","Descricao","HomeCare_Solicitacao_Requisicao_Tipo","Where id = 5 ","id_Solicitacao_Requisicao_Tipo","2","onclick='javascript:exibecodigo()'")
'##############################################################
Function RadioButtonAutomatico(tabelaid,campo,tabela,clausula,nome_radio,valor_selecionado,evento_js)

	SQL	=	"Select "&Tabelaid&" , "&Campo&" From "&Tabela&" "&Clausula&" "
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.open SQL, conn, 3
			Content = ""
			If Not Rs.Eof Then
				For x = 1 To Rs.RecordCount
					If Rs.Eof Then Exit For
						checked = ""
						If trim(rs(tabelaid)) = trim(valor_selecionado) Then
							checked = "checked"
						End If
						Content = Content & "<input name='"&Nome_Radio&"' type='radio' value='"&Rs("id")&"' "&checked&"  "&evento_js&"  >" & Trim(Rs("Descricao"))
				Rs.MoveNext
				Next
			End If
			Rs.Close
			Set Rs = Nothing
			RadioButtonAutomatico = Content

End Function

'FUNÇÂO	RESPONSAVEL POR COLOCAR OS POSNTOS E TRAÇOS NO NUMERO DO CPF
'PARA USAR BASTA PASSAR O NUMERO DO CPF SEM PONTOS E TRAÇOS
Function MascaraCPF(CPF)

	If Len(CPF) = 11 then 'Verifica se o numero passado tem 11 numeros
		'Atribui o Numero passado a uma variavel
		StringCPF = CPF
		'Usamos o comando MID para fazer a mascara do CPF colocando os pontos e o traço
		CPF = Mid(StringCPF, 1, 3) & "." & Mid(StringCPF, 4, 3) & "." & Mid(StringCPF, 7, 3) & "-" & Mid(StringCPF, 10, 2) 
		'Retorna o numero já com a mascara pronta
		MascaraCPF = CPF 
	Else 'Caso o CPF não tenha 11 digitos
		MascaraCPF = "Invalido"
	End if

End Function

'FUNÇÂO	RESPONSAVEL POR COLOCAR OS POSNTOS E TRAÇOS NO NUMERO DO RG
'PARA USAR BASTA PASSAR O NUMERO DO RG SEM PONTOS E TRAÇOS
Function MascaraRG(RG)

	If Len(RG) = 9 then 'Verifica se o numero passado tem 9 numeros
		'Atribui o Numero passado a uma variavel
		StringRG = RG
		'Usamos o comando MID para fazer a mascara do RG colocando os pontos e o traço
		RG = Mid(StringRG, 1, 2) & "." & Mid(StringRG, 3, 3) & "." & Mid(StringRG, 6, 3) & "-" & Mid(StringRG, 9, 1) 
		'Retorna o numero já com a mascara pronta
		MascaraRG = RG
	End if
	
End Function


'=============================================================================
'Função que gera graficos em Barras - Esta função não foi feito por Fabrizio Gianfratti - retirada da URL http://lib.seven.com.br/ampliar.asp?codcat=5&codartigo=354
'Dentro da função tem alguns comentarios
'Para usar use: Ex:

'titulo = "Meu Gráfico" 'Titulo dos Graficos
'ImageNome = "img_grafico.gif" 'Image que forma as barras
'AlturaGrafico = 100 'Altura do grafico
'LarguraGrafico = 10 'Largura do grafico
'MostrarValorGrafico = "True" 'Se quiser mostrar os valores passados ao lado do grafico
'ArrayValores = Array(200,100,50,74,50.5) 'Array de valores que formaram o grafico
'ArrayTitulos = Array("Titulo1","Titulo2","Titulo3","Titulo4","Titulo5") 'titulo que as barras tera, tem que ser na mesma ordem do ArrayValores
'Response.Write GeraGraficoBarra(titulo, ArrayValores, ArrayTitulos, ImageNome, AlturaGrafico, LarguraGrafico, MostrarValorGrafico) 
'=============================================================================

Function GeraGraficoBarra(titulo, ArrayValores, ArrayTitulos, ImageNome, AlturaGrafico, LarguraGrafico, MostrarValorGrafico) 

	' titulo: Título do Grafico 
	' ArrayValores: Uma Array de valores para montar o Gráfico 
	' ArrayTitulos: Uma Array com os títulos dos valores passados pela Array ArrayValores 
	' ImageNome: Nome da imagem a ser utilizada para construir o gráfico. Utilize um Gif de 1 pixel da cor que você preferir... 
	' AlturaGrafico: Altura do Gráfico, sem contar os títulos dos valores 
	' LarguraGrafico: Largura de cada coluna 
	' MostrarValorGrafico: True ou False. Se vc quer que os valores apareçam ou não no gráfico 
	' para usar esta função: response.write GeraGraficoBarra(parameters) 


	dim tablestring 
	dim max 
	dim tempArrayValores  'Array temporario
	dim tempArrayTitulos  'Array temporario
	dim heightarray 
	dim tempnum 
	
	if AlturaGrafico > 0 and LarguraGrafico > 0 and ubound(ArrayTitulos) = ubound(ArrayValores) then 
	
		tempArrayTitulos = ArrayTitulos 
		tempArrayValores = ArrayValores 
		heightarray = array() 
		max = 0 
		maxlength = 0 
		tablestring = "<TABLE border='1' bordercolor='#000000'>" & vbCrLf 
	
		for each stuff in tempArrayValores 
			if stuff > max then max = stuff end if 
		next 
	
		If cint(max) = 0 Then 
			Response.Write("Sem dados para gerar grafico.")
			Response.End()
		End If
		
		tempnum = AlturaGrafico/max 

		for counter = 0 to ubound(tempArrayValores) 
			if tempArrayValores(counter) = max then 
				redim preserve heightarray(counter) 
				heightarray(counter) = AlturaGrafico 
			else 
				redim preserve heightarray(counter) 
				heightarray(counter) = tempArrayValores(counter) * tempnum 
			end if 
		next 

		tablestring = tablestring & "<TR bgcolor='#CCCCFF'><TH colspan='" & ubound(tempArrayValores)+1 & "'>" & titulo & "</TH></TR>" & _ 
		vbCrLf & "<TR bordercolor='#FFFFFF'>" & vbCrLf 
		for counter = 0 to ubound(tempArrayValores) 
			tablestring = tablestring & vbTab & "<TD valign='bottom' align='center'><img src='" & ImageNome & "' width='" & LarguraGrafico & "' height='" & _ 
			heightarray(counter) & "'>" 
			if MostrarValorGrafico then 
				tablestring = tablestring & "<BR>" & "<font size='1'>" & tempArrayValores(counter)  & "</font>"
			end if 
			tablestring = tablestring & "</TD>" & vbCrLf 
		next 

		tablestring = tablestring & "</TR>" & vbCrLf 

		for each stuff in ArrayTitulos 
			tablestring = tablestring & vbTab & "<TD align='center' bordercolor='#FFFFFF'><font size='1'><B> " & stuff & "</font> </TD>" & vbCrLf 
		next 

		tablestring = tablestring & "</TABLE>" & vbCrLf 
		GeraGraficoBarra = tablestring 
	else 
		Response.Write "Erro! A altura e a largura devem ser maiores que zero (0), ou o número de títulos não é igual ao número de valores passados..." 
	end if 

End Function

'Função presponsavel por mostrar as imagens capturadas
Function MostraImg(id_Documento,id_Paciente,id_Atendimento,NSessionID,Data)
	
	SQL	=	"SELECT Documento_Imagem.Img, Documento_Tipo.Tipo " &_ 
			"FROM Documento_Imagem INNER JOIN Documento_Tipo ON Documento_Imagem.id_Tipo = Documento_Tipo.id " &_ 
			"Where Documento_Imagem.id_Documento = '"&id_Documento&"'  " 
			if Trim(Request("id_Tipo")) <> "" Then
				clausula = "and "
				sql = sql & clausula & " Documento_Imagem.id_Tipo = '"&Trim(Replace(Request("id_Tipo"),"'","''"))&"'  "
				clausula = "and "
			end if
			
			sql = sql & "Order By Documento_Imagem.Data Desc "

			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
							MontaData = StrZero(Year(Data),4) & "_" & StrZero(Month(Data),2) & "_" & StrZero(Day(Data),2)
							Caminho = StrZero(id_Paciente,10) & "/" & StrZero(id_Atendimento,10)  & "/" & MontaData & "/" & NSessionID & "/"
							Response.Write "<td class='texto' width='10%' >"
							Response.Write "<a href=""javascript:AbrePopUp('/SmartCare/Captura/Thumbnail/GeraThumbnail.aspx?caminho="&Caminho&"&filename="&Rs("Img")&"','870','700',this,event)"" ><img src='/SmartCare/Captura/Thumbnail/GeraThumbnail.aspx?caminho="&Caminho&"&filename="&Rs("Img")&"&width=100' Alt='Clique para visualizar' border='0' ></a>" & "<br>" & Rs("Tipo")
							Response.Write "</td>"
							If x mod 6 = 0 Then 'quantidade de img por linha
							Response.Write "</tr><tr >"
							end if
					Rs.MoveNext
					Next
					Response.Write MostraImg 
				End if
			Rs.Close
			Set Rs = Nothing
End Function

'Função resposavel por gerar o grafico dos convenios que estão em atendimeno
Function MostraGraficoConveniosAtendimento

	'[CONEXÃO COM O BANCO DE DADOS]
	set Conn = Server.CreateObject( "ADODB.Connection" )
	Conn.CursorLocation = 3 'adUserClient
	Conn.Open application("connstring")

	SQL	=	"SELECT DISTINCT dbo.Convenios.Convenio, " &_ 
				"(SELECT COUNT(dbo.HomeCare_Atendimento.id) AS Total " &_ 
				"FROM dbo.HomeCare_Atendimento INNER JOIN " &_
				"dbo.HomeCare_Solicitacao_Atendimento ON  " &_ 
				"dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento = dbo.HomeCare_Solicitacao_Atendimento.id INNER JOIN " &_ 
				"dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id " &_ 
				"WHERE (dbo.HomeCare_Atendimento.id_Atendimento_Status_Condicoes_Alta = 1) AND (dbo.Pacientes.id_convenio = Convenios.id)) AS Total " &_ 
			"FROM dbo.HomeCare_Solicitacao_Atendimento INNER JOIN " &_ 
			"dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id INNER JOIN " &_ 
			"dbo.HomeCare_Atendimento ON  " &_ 
			"dbo.HomeCare_Solicitacao_Atendimento.id = dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento RIGHT OUTER JOIN " &_ 
			"dbo.Convenios ON dbo.Pacientes.id_convenio = dbo.Convenios.id " &_ 
			"ORDER BY dbo.Convenios.Convenio " 
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.open SQL, conn, 3
			If Not Rs.Eof Then
				Vetor = Array() 'Define uma variavel como array, vai ser usada para armazenar o total de cada convenio
				Vetor2 = Array() 'Define uma variavel como array, vai ser usada para armazenar o nome de cada convenio
				For x = 1 To Rs.RecordCount
					If rs.eof then exit for
					ReDim preserve Vetor(UBound(Vetor)+1) 'Este comando ira preservar o vetor e adciona + 1 valor
					Vetor(Ubound(Vetor )) = Rs("Total") 'Este é o valor que estamos adicionando no vetor
					Valores = Vetor 'Coloca o conteudo da variavel vetor dentro da Session

					ReDim preserve Vetor2(UBound(Vetor2)+1) 'Este comando ira preservar o vetor e adciona + 1 valor
					Vetor2(Ubound(Vetor2 )) = Rs("Convenio")  'Este é o valor que estamos adicionando no vetor
					Titulos = Vetor2 'Coloca o conteudo da variavel vetor dentro da Session

				Rs.MoveNext
				Next
					'Configurações abaixo é da função GeraGraficoBarra que vai ser chamada ára gerar o grafico
					titulo = "Convênios em atual atendimento" 'Titulo dos Graficos
					ImageNome = "/SmartCare/images/img_grafico.gif" 'Image que forma as barras
					AlturaGrafico = 100 'Altura do grafico
					LarguraGrafico = 10 'Largura do grafico
					MostrarValorGrafico = "True" 'Se quiser mostrar os valores passados ao lado do grafico
					ArrayValores = Valores 'Array de valores que formaram o grafico
					ArrayTitulos = Titulos 'titulo que as barras tera, tem que ser na mesma ordem do ArrayValores
					MostraGraficoConveniosAtendimento =  GeraGraficoBarra(titulo, ArrayValores, ArrayTitulos, ImageNome, AlturaGrafico, LarguraGrafico, MostrarValorGrafico) 
			End if

End Function

'Função que gera um PDF
Function GeraPDF(URL)

	Response.Buffer= True
	Response.Expires=Now()-1 
	Set theDoc = Server.CreateObject("ABCpdf5.Doc")
	theDoc.MediaBox = "A4" 'Tamanho do papel que sera impresso
	theDoc.Rect.SetRect 10,1,585,830 'Left(Esquerdo),Bottom(Rodapé),Width(Largura),Height(Altura)
	theDoc.Page = theDoc.AddPage()
	theURL = URL
	theID = theDoc.AddImageUrl(theURL, True, 0, True)			
	Do
	  'theDoc.FrameRect ' Caso queira uma borda
	  If Not theDoc.Chainable(theID) Then Exit Do
	  theDoc.Page = theDoc.AddPage()
	  theID = theDoc.AddImageToChain(theID)
	Loop
	For i = 1 To theDoc.PageCount
	  theDoc.PageNumber = i
	  theDoc.Flatten
	Next			
	segundos = Second(now)
	theDoc.Save "C:\Inetpub\wwwroot\SmartCare\TEMP\"&Session.SessionID&segundos&".pdf"
	theDoc.Clear
	
	Response.Redirect Application("dominio") & "/TEMP/"&Session.SessionID&segundos&".pdf"
	Set theDoc = Nothing

	Response.Flush()
	
End Function


'Função que gera um PDF
Function GeraPDFFF(Acao,Url)

	Select Case Acao
		Case "GeraPdf" 'Gera Pdf
			Response.Buffer = True
			Set Session("doc") = Server.CreateObject("ABCpdf5.Doc")
			Set theDoc = Session("doc")
			theDoc.MediaBox = "A4"
			theDoc.Rect.SetRect 10,1,585,830 'Left(Esquerdo),Bottom(Rodapé),Width(Largura),Height(Altura)
			theDoc.AddText Request.Form("text")
			theURL = URL
			If Left(theURL, 4) <> "http" Then theURL = "http://www.google.com/"
			theID = theDoc.AddImageUrl(theURL, True, 0, True)
			For i = 1 To theDoc.PageCount ' add up to 3 pages
			  If theDoc.GetInfo(theID, "Truncated") <> "1" Then Exit For
			  theDoc.PageNumber = i
			  theDoc.Page = theDoc.AddPage()
			  theID = theDoc.AddImageToChain(theID)
			  'theDoc.Save "C:\Inetpub\wwwroot\SmartCare\teste.pdf"
			 ' Response.Flush()

			Next
		Case "VisualizaPDF" 'Visualiza o Pdf
			Response.Buffer = True
			Response.Expires = Now()-1
			Set theDoc = Session("doc")
			theData = theDoc.GetData()
			Response.ContentType = "application/pdf"
			Response.AddHeader "content-length", UBound(theData) - LBound(theData) + 1
			If Request.QueryString("attachment") <> "" Then
				Response.AddHeader "content-disposition", "attachment; filename=MyPDF.PDF"
			Else
				Response.Addheader "content-disposition", "inline; filename=MyPDF.PDF"
			End If
			Response.BinaryWrite theData
			Response.Flush()
		Case "LimpaSessionPDF" 'Limpa a session do PDF que esta aberta no servidor
			Set Session("doc") = Nothing
			Response.Buffer = True
			Set Session("doc") = Server.CreateObject("ABCpdf5.Doc")
	End Select

End Function

'Função que gera um PDF
Function GeraPDFFFF(Acao,Url)

	Select Case Acao
		Case "GeraPdf" 'Gera Pdf
			Response.Buffer = True
			Set theDoc = Server.CreateObject("ABCpdf5.Doc")
			theDoc.MediaBox = "A4"
			theDoc.Rect.SetRect 10,1,585,830 'Left(Esquerdo),Bottom(Rodapé),Width(Largura),Height(Altura)
			'theDoc.Rect.Inset 0,0
			'theDoc.FontSize = 10
			
			theDoc.Page = theDoc.AddPage()
			theURL = URL
			theID = theDoc.AddImageUrl(theURL, True, 0, True)
			
			Do
			  'theDoc.FrameRect ' add a black border
			  If Not theDoc.Chainable(theID) Then Exit Do
			  theDoc.Page = theDoc.AddPage()
			  theID = theDoc.AddImageToChain(theID)
			Loop
			
			For i = 1 To theDoc.PageCount
			  theDoc.PageNumber = i
			  theDoc.Flatten
			Next
			
			theDoc.Save "C:\Inetpub\wwwroot\SmartCare\"&Session.SessionID&".pdf"
			Set theDoc = Nothing
			
		Case "VisualizaPDF" 'Visualiza o Pdf
			Response.Buffer = True
			Response.Expires = -1000
			Set theDoc = Session("doc")
			theData = theDoc.GetData()
			Response.ContentType = "application/pdf"
			Response.AddHeader "content-length", UBound(theData) - LBound(theData) + 1
			If Request.QueryString("attachment") <> "" Then
				Response.AddHeader "content-disposition", "attachment; filename=MyPDF.PDF"
			Else
				Response.Addheader "content-disposition", "inline; filename=MyPDF.PDF"
			End If
			Response.BinaryWrite theData
		Case "LimpaSessionPDF" 'Limpa a session do PDF que esta aberta no servidor
			Set Session("doc") = Nothing
			Response.Buffer = True
			Set Session("doc") = Server.CreateObject("ABCpdf5.Doc")
	End Select

End Function

'=============================================================================
'Função responsavel por gerar senhas aleatorias
'=============================================================================
Dim Chave
Function gera_senha(valores)

 Dim chr_array, chave
 chave = ""

 chr_array = Array("2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","j","k",_
         "m","n","p","q","r","s","t","u","v","w","x","y","z")
 Randomize
 Do While len(chave) < valores
 	num = chr_array(Int(UBound(chr_array) * Rnd ))
	chave = chave + num
 Loop
  gera_senha = chave

End Function 'Fim da função gera_senha()

'=============================================================================
' Remove todos os acentos da string
'=============================================================================
Function RemoveAcentos(vStr)

	dim i, s1, s2
	s1 = "ÁÂÃÉÊÍÓÕÔÚÇáâãéêíóõôúüç"
	s2 = "AAAEEIOOOUCaaaeeiooouuc"
	if len(vStr) <> 0 then 
	   For i = 1 to Len(s1)
		  vStr = replace(vStr,mid(s1,i,1),mid(s2,i,1))
	   next
	end if   
	RemoveAcentos = vStr
	
End Function

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
		On Error Resume Next 'Inicia o Tratamento de erro
			Mailer.Send 'envia o email
		If Err <> 0 Then 'Caso tenha acontecido um erro
			Response.Write "Erro ao enviar o email. " & Err.Description
			Response.end
		End If
	Set Mailer = Nothing 'Destroi o objeto criado

End Function

Function TiraAspas(Variavel)

	Variavel = Replace(Variavel,"'","")
	TiraAspas = Variavel

End FUnction

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
      
      'Usamos a função SrtZero para arrumar a quantidade de certa de numeros. Ex: 1/1/2005 a função formata para 01/01/2005
	  ArrumaData = StrZero(Day(Data),2) & "/" & StrZero(Month(Data),2) & "/" & Right(Year(Data),4) 

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


'FUNÇÃO QUE VERIFICA SE O VALOR É NULO, CASO SEJA ENTAO GRAVA O VALOR (NULL) NO BANCO DE DADOS
Function IfTxtBrancoNull(Variavel)
   
   Dim Aspinha
   Aspinha = CStr(chr(39))
   If Variavel = "0" or Variavel = "" or isnull(Variavel) then
      IfTxtBrancoNull = "Null"
   else
      IfTxtBrancoNull = Aspinha&Variavel&Aspinha
   end if
   
End Function

'FUNÇÃO QUE VERIFICA SE O VALOR É NULO, CASO SEJA ENTAO GRAVA O VALOR (NULL) NO BANCO DE DADOS
'Grava Numero Branco, serve tb para datas
Function IfNumBrancoNull(Variavel)
  
   if Variavel = "0" or Variavel = "" or isnull(Variavel) then
      IfNumBrancoNull = "Null"
   else
      IfNumBrancoNull = Variavel
   end if
   
End Function

'=========================
'Grava data
'-------------------------
Function GravaData(Variavel)
   if Variavel <> "" then
      w_ano = mid(Variavel,7,4)
      w_mes = mid(Variavel,4,2)
      w_dia = mid(Variavel,1,2)
      GravaData = "'"&w_ano & "-" &  strzero(w_mes,2) & "-" & strzero(w_dia,2) &" "&strzero(Hour(Variavel),2) & ":" & strzero(Minute(Variavel),2) & ":" & strzero(Second(Variavel),2) &"'" 
   else
      GravaData = "NULL"
   end if
   
End Function


'FUNÇÃO QUE MONTA O LIST BOX COM OS NOMES DOS ESTADOS
'PARA USAR:
'Call LisBox_estados("")
Function LisBox_estados(estado)
      redim estados(26,1)
      estados(0,0)="AC" : estados(0,1)="Acre" : estados(1,0)="AL" : estados(1,1)="Alagoas"
      estados(2,0)="AM" : estados(2,1)="Amazonas" : estados(3,0)="AP" : estados(3,1)="Amapá"
      estados(4,0)="BA" : estados(4,1)="Bahia" : estados(5,0)="CE" : estados(5,1)="Ceará"
      estados(6,0)="DF" : estados(6,1)="Distrito Federal" : estados(7,0)="ES" : estados(7,1)="Espírito Santo"
      estados(8,0)="GO" : estados(8,1)="Goiás" : estados(9,0)="MA" : estados(9,1)="Maranhão"
      estados(10,0)="MG" : estados(10,1)="Minas Gerais" : estados(11,0)="MS" : estados(11,1)="Mato Grosso do Sul"
      estados(12,0)="MT" : estados(12,1)="Mato Grosso" : estados(13,0)="PA" : estados(13,1)="Pará"
      estados(14,0)="PB" : estados(14,1)="Paraíba" : estados(15,0)="PE" : estados(15,1)="Pernambuco"
      estados(16,0)="PI" : estados(16,1)="Píaui" : estados(17,0)="PR" : estados(17,1)="Paraná"
      estados(18,0)="RJ" : estados(18,1)="Rio de Janeiro" : estados(19,0)="RN" : estados(19,1)="Rio Grande do Norte"
      estados(20,0)="RO" : estados(20,1)="Rondônia" : estados(21,0)="RR" : estados(21,1)="Roraima"
      estados(22,0)="RS" : estados(22,1)="Rio Grande do Sul" : estados(23,0)="AC" : estados(23,1)="Acre"
      estados(24,0)="SE" : estados(24,1)="Sergipe" : estados(25,0)="SP" : estados(25,1)="São Paulo"
      estados(26,0)="TO" : estados(26,1)="Tocantins"

      comboe_ = "<select name='UF' class='campos'>" & chr(10) & "<option value=""""  >-- UF --</option>" & chr(10)

      for x_=0 to ubound(estados)
          if ucase(estado)=ucase(estados(x_,1)) or ucase(estado)=estados(x_,0) then sel_="selected" else sel_="" end if
          comboe_=comboe_&"<option value="""&estados(x_,0)&""" " & sel_ & ">"&estados(x_,1)&"</option>" & chr(10)
      next
      comboe_=comboe_&"</select>" & chr(10)
      LisBox_estados = comboe_

End Function

'Função que passado a data de inicio ou data de termino devolve o tempo que esta em aberto.
'Se passado somente a data de inicio entao ele fica contando o tempo
'Se passado e data e inicio e da data de termino juntas entao ele calcula o tempo entre as 2 datas 
Function TempoDecorrido(data_inicio,data_termino)

	If data_termino = "" Then data_termino = Now Else data_termino = data_termino End if
		
	aux = DateDiff("d",data_inicio, data_termino)
	Tempo = empty
	
	If aux = 0 Then
		Tempo = Tempo & "0d " & DateDiff("H", data_inicio, data_termino) & "h "
	Else
		Tempo = Tempo & DateDiff("d", data_inicio, data_termino) & "d "
		Tempo  = Tempo & Abs((DatePart("H", data_inicio) - DatePart("H", data_termino))) & "h "
	End If
	
	Tempo  = Tempo & Abs((DatePart("n", data_inicio) - DatePart("n", data_termino))) & "m "
	
	TempoDecorrido = tempo

End Function


'Função responsavel por tirar a formatação do Telefone. Ex: (11)6215-93-87
'Está função faz um replace deixando o campo no formato 1162159387
Function ReplaceTelefone(Telefone)

	Telefone = Replace(Replace(Replace(Replace(Telefone,"'",""),"(",""),")",""),"-","")
	
	ReplaceTelefone = Telefone

End Function


'FUNÇÃO QUE CARREGA A STORE PROCEDURE QUE TRAZ OS DADOS DOS FUNCIONARIOS
Function Funcionarios_Dados(id_Funcionario)

	'[CONEXÃO COM O BANCO DE DADOS]
	set conn=server.createobject("adodb.connection")
	conn.open application("connstring")

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.Funcionarios_Dados '"&id_Funcionario&"' "
			Rs.open SQL, CONN, 3
			
			Nome = Trim(Rs("nome")) : Endereco = Trim(Rs("Endereco")) : CEP = Trim(Rs("CEP")) :  Departamento_Nome = Trim(Rs("Departamento_Nome")) : Cargo_Nome = Trim(Rs("Cargo_Nome"))
			TelefoneResidencial = Trim(Rs("TelefoneResidencial")) : TelefoneCelular = Trim(Rs("TelefoneCelular")) : Bairro = Trim(Rs("Bairro")) : Cidade = Trim(Rs("Cidade")) : UF = Trim(Rs("UF"))
			
			Rs.Close
			Set Rs = Nothing
			
End Function


'FUNÇÃO QUE GERA UM LIST BOX COM AS COTAÇÕES DAS MOEDAS
Function Gerar_ListBoxMoedasCotacoes(id)

	SQL =	"SELECT dbo.MoedasCotacoes.id, dbo.Moedas.descricao, dbo.MoedasCotacoes.data, dbo.MoedasCotacoes.cotacao " &_ 
			"FROM dbo.Moedas INNER JOIN "&_ 
			"dbo.MoedasCotacoes ON dbo.Moedas.id = dbo.MoedasCotacoes.id_moeda "&_ 
			"ORDER BY dbo.MoedasCotacoes.data DESC "
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.open SQL, conn, 3
			content = "<select name='id_MoedasCotacoes' class=""campos"">"
			If Not rs.EOF Then
				content = content & "<option value=''><<----Selecione---->></option>"
				For i = 1 to rs.RecordCount
					If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
					selected = ""
					If trim(rs("id")) = trim(id) Then
						selected = "selected"
					End If
					content = content & "<option class='"&zebrado&"' value='"&rs("id")&"' "&selected&">"&rs("Descricao")&" -- "&ArrumaDataHora(rs("Data"))&" -- "&FormatCurrency(rs("Cotacao"),4)& "</option>"
				rs.MoveNext
				Next
			Else
				content = content & "<option value="""">Não foram encontrados registros</option>"
			End If
			content = content & "</select>"
			rs.close
			Set rs = Nothing
			Gerar_ListBoxMoedasCotacoes = content

End function


'Função responsavel por trazer as especializações dos funcionarios
Function Funcionarios_Especializacao(id_Funcionario)

	'[CONEXÃO COM O BANCO DE DADOS]
	set conn=server.createobject("adodb.connection")
	conn.open application("connstring")

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.Funcionarios_Especializacao '"&id_Funcionario&"'  "
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof Then 'Verifica se existem registros			
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='98%' border='0' cellspacing='0' cellpadding='0' class='borda' >" 
					For x = 1 To Rs.RecordCount
					If Rs.Eof Then Exit For
					If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
					Content = Content &_
							"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Trim(Rs("descricao"))&"</Td>"  & Chr(10)&_
							"</Tr>"
					Rs.MoveNext
					Next
						Content = Content &_
					"</Table>"		
				End IF
				Rs.Close
				Set Rs = Nothing
				Funcionarios_Especializacao = Content

End Function

'Função responsavel por trazer as disponibilidades dos funcionarios
Function Funcionarios_Disponibilidade(id_Funcionario)

	'[CONEXÃO COM O BANCO DE DADOS]
	set conn=server.createobject("adodb.connection")
	conn.open application("connstring")

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC Funcionarios_Disponibilidades '"&id_Funcionario&"'  "
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof Then 'Verifica se existem registros			
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='98%' border='0' cellspacing='0' cellpadding='0' class='borda' >" 
					For x = 1 To Rs.RecordCount
					If Rs.Eof Then Exit For
					If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
					Content = Content &_
							"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Trim(Rs("descricao"))&"</Td>"  & Chr(10)&_
							"</Tr>"
					Rs.MoveNext
					Next
						Content = Content &_
						
					"</Table>"		
				End IF
				Rs.Close
				Set Rs = Nothing
				Funcionarios_Disponibilidade = Content

End Function

'Função responsavel por trazer as áreas de cobertura dos funcionarios
Function Funcionarios_Cobertura(id_Funcionario)

	'[CONEXÃO COM O BANCO DE DADOS]
	set conn=server.createobject("adodb.connection")
	conn.open application("connstring")

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC Funcionarios_Cobertura '"&id_Funcionario&"'  "
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof Then 'Verifica se existem registros			
					Content = "" 'Variavel usada para fazer a concatenação
					Content = Content &_
					"<table width='98%' border='0' cellspacing='0' cellpadding='0' class='borda' >" 
					For x = 1 To Rs.RecordCount
					If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
					Content = Content &_
							"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Trim(Rs("nome"))&"</Td>"  & Chr(10)&_
							"</Tr>"
					Rs.MoveNext
					Next
						Content = Content &_
					"</Table>"		
				End IF
				Rs.Close
				Set Rs = Nothing
				Funcionarios_Cobertura = Content

End Function

'FUNÇÃO RESPOSAVEL POR MOSTRAR A IMAGEM DO FUNCIONARIO
Function Funcionario_Imagem(id,Largura,Altura)

	'[CONEXÃO COM O BANCO DE DADOS]
	set conn=server.createobject("adodb.connection")
	conn.open application("connstring")

	SQL	=	"Select id,Img From FUNCIONARIOS Where id = '"&id&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				If Not Rs.Eof Then
					If Rs("img") <> "" or Rs("img") <> Null Then 
						img = Rs("img") 
						Else
						img = "0.jpg" 'Caso não tenha imagem entao é postada uma imagem padrao
					End if
				Else
					img = "0.jpg" 'Caso não tenha imagem entao é postada uma imagem padrao
				End if
				Content = Content &_ 
				"<img src='/SmartCare/Funcionarios/Img_Funcionarios/"&img&"' width='"&Largura&"' height='"&Altura&"' >"
				Funcionario_Imagem = Content
			Rs.Close
			Set Rs= Nothing
	
End Function

'Função responsavel por mostrar um Box com as prescricoes que estao em espera
Function Box_Prescricoes_Espera

	'[CONEXÃO COM O BANCO DE DADOS]
	set conn=server.createobject("adodb.connection")
	conn.open application("connstring")

	SQL	=	"SELECT DISTINCT A.id_Atendimento, B.id_Solicitacao_Atendimento, " &_ 
				"(SELECT COUNT(X.id_Prioridade) FROM  HomeCare_Atendimento_Prescricao_Medica X	WHERE  X.id_Prioridade = 1 AND X.id_Atendimento = A.id_Atendimento AND 	X.id Not In (Select Y.id_Prescricao_Medica From HomeCare_Atendimento_Medicamentos Y	Where Y.id_Prescricao_Medica = X.ID	) ) AS Total_Rotina, " &_     
				"(SELECT COUNT(X.id_Prioridade) FROM  HomeCare_Atendimento_Prescricao_Medica X	WHERE  X.id_Prioridade = 2 AND  X.id_Atendimento = A.id_Atendimento AND X.id Not In (Select Y.id_Prescricao_Medica From HomeCare_Atendimento_Medicamentos Y	Where Y.id_Prescricao_Medica = X.ID	) ) AS Total_Urgencia " &_ 
			"FROM HomeCare_Atendimento_Prescricao_Medica A INNER JOIN	HomeCare_Atendimento B ON (A.id_Atendimento = B.id) " &_ 
			"Where A.id Not In (Select W.id_Prescricao_Medica From HomeCare_Atendimento_Medicamentos W Where W.id_Prescricao_Medica = A.id AND W.id_Atendimento = A.id_Atendimento) AND" &_ 
			"(A.id_Prescricao_Tipo = 1) " &_ 
			"GROUP BY A.id_Atendimento, B.id_Solicitacao_Atendimento, A.id "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				If Not Rs.Eof Then
					Response.Write	"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
					Response.Write		"<tr class='titulo_tabela'>" & Chr(10)
					Response.Write			"<td colspan='3'>Prescrições em espera</td>" & Chr(10)
					Response.Write		"</tr>" & Chr(10)
					Response.Write		"<tr class='zebra1'> " & Chr(10)
					Response.Write			"<td align='center' class='legenda'><strong>Atend.</strong></td>" & Chr(10)
					Response.Write			"<td align='center' class='legenda'><strong>Rotina</strong></td>" & Chr(10)
					Response.Write			"<td align='center' class='legenda'><strong>Urg&ecirc;ncia</strong></td>" & Chr(10)
					Response.Write 		"</tr>" & Chr(10)
					For x = 1 To Rs.RecordCount
						if rs.eof then exit For
						If zebrado = "zebra4" Then zebrado = "zebra5" Else zebrado = "zebra4" End If
							Response.Write	"<tr> " & Chr(10)
							Response.Write		"<td align='center' class='"&zebrado&"'>"&"<a target='iFrameItens' href='/SmartCare/Modulos/HomeCare/Atendimento/default.asp?action=Editar_Atendimento&id_Atendimento="&Rs("id_Atendimento")&"&id_Solicitacao_Atendimento="&Rs("id_Solicitacao_Atendimento")&"'>"&Rs("id_Atendimento")&"</a>"&"</td>" & Chr(10)
							Response.Write		"<td align='center' class='"&zebrado&"' >"&Rs("Total_Rotina")&"</td>" & Chr(10)
							Response.Write		"<td align='center' class='"&zebrado&"'>"&Rs("Total_Urgencia")&"</td>" & Chr(10)
							Response.Write	"</tr>" & Chr(10)
					Rs.MoveNext
					Next
					Response.Write	"<tr> " & Chr(10)
					Response.Write		"<td colspan='3' class='zebra2' >Total:&nbsp;<b>"&Rs.RecordCount&"</b></td>" & Chr(10)
					Response.Write	"</tr>" & Chr(10)
					Response.Write	"</table>" & Chr(10)
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função responsavel por mostrar as solicitaões aceitas que estao em espera para abrir o atendimento
Function Box_Solicitacao_Espera

	'[CONEXÃO COM O BANCO DE DADOS]
	set conn=server.createobject("adodb.connection")
	conn.open application("connstring")

	SQL	=	"SELECT dbo.HomeCare_Solicitacao_Atendimento.id, dbo.HomeCare_Solicitacao_Status.Descricao,dbo.HomeCare_Solicitacao_Atendimento.Data_Fechamento " &_ 
			"FROM dbo.HomeCare_Solicitacao_Atendimento INNER JOIN " &_ 
			"dbo.HomeCare_Solicitacao_Status ON dbo.HomeCare_Solicitacao_Atendimento.id_Solicitacao_Status = dbo.HomeCare_Solicitacao_Status.id " &_ 
			"WHERE (dbo.HomeCare_Solicitacao_Atendimento.id_Solicitacao_Status = 2) AND (dbo.HomeCare_Solicitacao_Atendimento.id NOT IN  (SELECT id_Solicitacao_Atendimento FROM  HomeCare_Atendimento WHERE Data_Fechamento IS NULL)) " 
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				If Not Rs.Eof Then
					Response.Write	"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
					Response.Write		"<tr class='titulo_tabela'>" & Chr(10)
					Response.Write			"<td colspan='3'>Solicitações Aprovadas</td>" & Chr(10)
					Response.Write		"</tr>" & Chr(10)
					Response.Write		"<tr class='zebra1'> " & Chr(10)
					Response.Write			"<td align='center' class='legenda'><strong>Solic.</strong></td>" & Chr(10)
					Response.Write			"<td align='center' class='legenda'><strong>Status</strong></td>" & Chr(10)
					Response.Write			"<td align='center' class='legenda'><strong>Tempo</strong></td>" & Chr(10)
					Response.Write 		"</tr>" & Chr(10)
					For x = 1 To Rs.RecordCount
						if rs.eof then exit For
						If zebrado = "zebra4" Then zebrado = "zebra5" Else zebrado = "zebra4" End If
							Response.Write	"<tr> " & Chr(10)
							Response.Write		"<td align='center' class='"&zebrado&"'>"&"<a target='iFrameItens' href='/SmartCare/Modulos/HomeCare/Atendimento/default.asp?action=Form_Incluir_Atendimento&Busca="&Rs("id")&"'>"&Rs("id")&" </a>"&"</td>" & Chr(10)
							Response.Write		"<td align='center' class='"&zebrado&"' >"&Rs("Descricao")&"</td>" & Chr(10)
							Response.Write		"<td align='center' class='"&zebrado&"'>"&TempoDecorrido(ArrumaDataHora(Rs("Data_Fechamento")),"")&"</td>" & Chr(10)
							Response.Write	"</tr>" & Chr(10)
					Rs.MoveNext
					Next
					Response.Write	"<tr> " & Chr(10)
					Response.Write		"<td colspan='3' class='zebra2' >Total:&nbsp;<b>"&Rs.RecordCount&"</b></td>" & Chr(10)
					Response.Write	"</tr>" & Chr(10)
					Response.Write	"</table>" & Chr(10)
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função responsavel por mostrar os exames
Function Box_Exames_Espera

	'[CONEXÃO COM O BANCO DE DADOS]
	set conn=server.createobject("adodb.connection")
	conn.open application("connstring")

	SQL	=	"SELECT dbo.HomeCare_Atendimento.id, dbo.Exames.cod_exame, dbo.Exames.tit_exame, " &_ 
			"dbo.FuncaoFuncionarioNome(dbo.HomeCare_Atendimento_Exames.id_Funcionario) AS Funcionario_Nome, " &_ 
			"dbo.HomeCare_Atendimento_Exames.Data_Realizacao_Exame, dbo.HomeCare_Atendimento_Exames.Data_Cadastro,  " &_ 
			"dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento, dbo.Pacientes.nome AS Paciente_Nome " &_ 
			"FROM dbo.HomeCare_Atendimento INNER JOIN " &_ 
			"dbo.HomeCare_Atendimento_Exames ON dbo.HomeCare_Atendimento.id = dbo.HomeCare_Atendimento_Exames.id_Atendimento INNER JOIN " &_ 
			"dbo.Exames ON dbo.HomeCare_Atendimento_Exames.id_Exames = dbo.Exames.id INNER JOIN " &_ 
			"dbo.HomeCare_Solicitacao_Atendimento ON  " &_ 
			"dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento = dbo.HomeCare_Solicitacao_Atendimento.id INNER JOIN " &_ 
			"dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id " 
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				If Not Rs.Eof Then
					Response.Write	"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
					Response.Write		"<tr class='titulo_tabela'>" & Chr(10)
					Response.Write			"<td colspan='6'>Exames em Espera</td>" & Chr(10)
					Response.Write		"</tr>" & Chr(10)
					Response.Write		"<tr class='zebra1'> " & Chr(10)
					Response.Write			"<td align='center' class='legenda'><strong>Atend.</strong></td>" & Chr(10)
					Response.Write			"<td class='legenda'><strong>Paciente.</strong></td>" & Chr(10)
					Response.Write			"<td class='legenda'><strong>Exame:</strong></td>" & Chr(10)
					Response.Write			"<td class='legenda'><strong>Médico:</strong></td>" & Chr(10)
					Response.Write			"<td class='legenda'><strong>Dt. Realização:</strong></td>" & Chr(10)
					Response.Write			"<td class='legenda'><strong>Dt. Cadastro:</strong></td>" & Chr(10)
					Response.Write 		"</tr>" & Chr(10)
					For x = 1 To Rs.RecordCount
						if rs.eof then exit For
						If zebrado = "zebra4" Then zebrado = "zebra5" Else zebrado = "zebra4" End If
							Response.Write	"<tr> " & Chr(10)
							Response.Write		"<td align='center' class='"&zebrado&"'>"&"<a href='/SmartCare/Modulos/HomeCare/Atendimento/default.asp?action=Editar_Atendimento&id_Atendimento="&Rs("id")&"&id_Solicitacao_Atendimento="&Rs("id_Solicitacao_Atendimento")&"'>"&Rs("id")&"</a>"&"</td>" & Chr(10)
							Response.Write		"<td  class='"&zebrado&"' >"&Rs("Paciente_Nome")&"</td>" & Chr(10)
							Response.Write		"<td  class='"&zebrado&"' >"&Rs("Tit_Exame")&"</td>" & Chr(10)
							Response.Write		"<td  class='"&zebrado&"'>"&Rs("Funcionario_Nome")&"</td>" & Chr(10)
							Response.Write		"<td  class='"&zebrado&"'>"&ArrumaData(Rs("Data_Realizacao_Exame"))&"&nbsp;</td>" & Chr(10)
							Response.Write		"<td  class='"&zebrado&"'>"&ArrumaDataHora(Rs("Data_Cadastro"))&"</td>" & Chr(10)
							Response.Write	"</tr>" & Chr(10)
					Rs.MoveNext
					Next
					Response.Write	"<tr> " & Chr(10)
					Response.Write		"<td colspan='6' class='zebra2' >Total:&nbsp;<b>"&Rs.RecordCount&"</b></td>" & Chr(10)
					Response.Write	"</tr>" & Chr(10)
					Response.Write	"</table>" & Chr(10)
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'Função que antes de enviar um email verifica se o contato esta cadastrado na tabela para receber o email que sera enviado
Function Verifica_Permissao_Email_Cliente_Contato(Convenio,Tipo)

	'[CONEXÃO COM O BANCO DE DADOS]
	set conn=server.createobject("adodb.connection")
	conn.open application("connstring")

	SQL	=	"SELECT dbo.ClientesContatos.Email " &_
			"FROM dbo.ClientesContatos INNER JOIN "&_ 
			"dbo.ClientesDepartamentos ON dbo.ClientesContatos.id_ClienteDepartamento = dbo.ClientesDepartamentos.id INNER JOIN "&_ 
			"dbo.Clientes ON dbo.ClientesDepartamentos.id_cliente = dbo.Clientes.id INNER JOIN "&_ 
			"dbo.ClientesContatos_PermissaoEmail ON dbo.ClientesContatos.id = dbo.ClientesContatos_PermissaoEmail.id_Contato "
 			clausula = "WHERE (dbo.Clientes.id_convenio = '"&Convenio&"') AND "
				if Tipo = "Solicitacao" Then
					sql = sql & clausula & " dbo.ClientesContatos_PermissaoEmail.Solicitacao = 1   "
					clausula = "and "
				end if
				if Tipo = "Atendimento" Then
					sql = sql & clausula & " dbo.ClientesContatos_PermissaoEmail.Atendimento = 1  "
					clausula = "and "
				end if
				if Tipo = "Evolucao" Then
					sql = sql & clausula & " dbo.ClientesContatos_PermissaoEmail.Evolucao = 1   "
					clausula = "and "
				end if
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				If Not Rs.Eof Then
					For x = 1 To Rs.RecordCount
					
						Email = Email & Rs("Email") & ";"
					
					Rs.MoveNext
					Next
				End if
				Verifica_Permissao_Email_Cliente_Contato = Email
				Rs.Close
				Set Rs = Nothing
End Function

'Função resposavel por disparar o email quando for aberto uma abertura de Atendimento
Function Dispara_Email_Abertura_Atendimento(Id_Atendimento)

	'[CONEXÃO COM O BANCO DE DADOS]
	set conn=server.createobject("adodb.connection")
	conn.open application("connstring")

	SQL =	"SELECT HomeCare_Atendimento.id, HomeCare_Atendimento.id_Solicitacao_Atendimento, HomeCare_Atendimento_Status.Descricao AS Atendimento_Status, "&_ 
			"HomeCare_Atendimento_Status_Condicoes_Alta.Descricao AS Status_Condicoes_Alta, HomeCare_Atendimento.Data_Cadastro, "&_ 
			"Pacientes.nome AS Paciente_Nome, Convenios.Convenio, Clientes.Nome AS Cliente_Nome, HomeCare_Solicitacao_Atendimento.id_Convenio "&_ 
			"FROM  HomeCare_Atendimento INNER JOIN "&_ 
			"HomeCare_Atendimento_Status ON HomeCare_Atendimento.id_Atendimento_Status = HomeCare_Atendimento_Status.id INNER JOIN "&_ 
			"HomeCare_Atendimento_Status_Condicoes_Alta ON  "&_
			"HomeCare_Atendimento.id_Atendimento_Status_Condicoes_Alta = HomeCare_Atendimento_Status_Condicoes_Alta.id INNER JOIN "&_ 
			"HomeCare_Solicitacao_Atendimento ON HomeCare_Atendimento.id_Solicitacao_Atendimento = HomeCare_Solicitacao_Atendimento.id INNER JOIN "&_ 
			"Pacientes ON HomeCare_Solicitacao_Atendimento.id_Paciente = Pacientes.id INNER JOIN "&_ 
			"Convenios ON HomeCare_Solicitacao_Atendimento.id_Convenio = Convenios.id INNER JOIN "&_ 
			"Clientes ON Convenios.id = Clientes.id_convenio "&_ 
			"WHERE HomeCare_Atendimento.id = '"&Cint(Id_Atendimento)&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				If Not Rs.Eof Then
					Assunto = "Abertura de Atendimento - Nº: "&Id_Atendimento&" - " & Rs("Atendimento_Status") 'Assunto do email
					
					Texto = ""
					Texto = Texto & "<b>Abertura de Atendimento</b>" & "<br><br>"  
					Texto = Texto & "<b>Data:</b> " & Rs("Data_Cadastro") & "<br>" 
					Texto = Texto & "<b>Nº Atendimento:</b> " & Id_Atendimento & "<br>" 
					Texto = Texto & "<b>Funcionario:</b> " & Session("Funcionario_Nome") & "<br>" 
					Texto = Texto & "<b>Cliente</b>: " & Rs("Cliente_Nome") & "<br>"
					Texto = Texto & "<b>Paciente:</b> " & Rs("Paciente_Nome") & "<br>"
					Texto = Texto & "<b>Tipo de Atendimento:</b> " & Rs("Atendimento_Status") & "<br>" 
					Texto = Texto & "<b>Status:</b> " & Rs("Status_Condicoes_Alta") & "<br><br>" 
					Texto = Texto & "Para visualizar mais detalhes clique "&"<a href='"&Application("Dominio")&"/Modulos/HomeCare/Atendimento/ImprimirAtendimento.asp?id_Atendimento="&Id_Atendimento&"' target='_blank'>aqui</a>"
	
					'Busca os emails dos clinentes que tem permissão de receber emails
					'É passado o id do convenio e o Tipo de email que sera enviado para dentro da function ser usado
					EmailsContatos = Verifica_Permissao_Email_Cliente_Contato(Rs("id_Convenio"),"Solicitacao")				
					
					'Dispara o email
					'Ordem dos parametro do envio de email (de,para,com_copia,copia_oculta,assunto,texto)
					Call enviar_email(application("email_suporte"),EmailsContatos,"",application("email_programador"),Assunto,Texto)
				End if
			Rs.Close
			Set Rs = Nothing

End Function

'Função resposavel por disparar o email quando for aberto uma abertura de Atendimento
Function Dispara_Email_Atendimento_Alteracao_Status(Id_Atendimento)

	'[CONEXÃO COM O BANCO DE DADOS]
	set conn=server.createobject("adodb.connection")
	conn.open application("connstring")

	SQL =	"SELECT HomeCare_Atendimento.id, HomeCare_Atendimento.id_Solicitacao_Atendimento, HomeCare_Atendimento_Status.Descricao AS Atendimento_Status, "&_ 
			"HomeCare_Atendimento_Status_Condicoes_Alta.Descricao AS Status_Condicoes_Alta, HomeCare_Atendimento.Data_Cadastro, "&_ 
			"Pacientes.nome AS Paciente_Nome, Convenios.Convenio, Clientes.Nome AS Cliente_Nome, HomeCare_Solicitacao_Atendimento.id_Convenio "&_ 
			"FROM  HomeCare_Atendimento INNER JOIN "&_ 
			"HomeCare_Atendimento_Status ON HomeCare_Atendimento.id_Atendimento_Status = HomeCare_Atendimento_Status.id INNER JOIN "&_ 
			"HomeCare_Atendimento_Status_Condicoes_Alta ON  "&_
			"HomeCare_Atendimento.id_Atendimento_Status_Condicoes_Alta = HomeCare_Atendimento_Status_Condicoes_Alta.id INNER JOIN "&_ 
			"HomeCare_Solicitacao_Atendimento ON HomeCare_Atendimento.id_Solicitacao_Atendimento = HomeCare_Solicitacao_Atendimento.id INNER JOIN "&_ 
			"Pacientes ON HomeCare_Solicitacao_Atendimento.id_Paciente = Pacientes.id INNER JOIN "&_ 
			"Convenios ON HomeCare_Solicitacao_Atendimento.id_Convenio = Convenios.id INNER JOIN "&_ 
			"Clientes ON Convenios.id = Clientes.id_convenio "&_ 
			"WHERE HomeCare_Atendimento.id = '"&Cint(Id_Atendimento)&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				If Not Rs.Eof Then
					Assunto = "Alteração de Status de Atendimento - Nº: "&Id_Atendimento&" - " & Rs("Atendimento_Status") 'Assunto do email
					
					Texto = ""
					Texto = Texto & "<b>Alteração de Status de Atendimento</b>" & "<br><br>"  
					Texto = Texto & "<b>Data:</b> " & Rs("Data_Cadastro") & "<br>" 
					Texto = Texto & "<b>Nº Atendimento:</b> " & Id_Atendimento & "<br>" 
					Texto = Texto & "<b>Funcionario:</b> " & Session("Funcionario_Nome") & "<br>" 
					Texto = Texto & "<b>Cliente</b>: " & Rs("Cliente_Nome") & "<br>"
					Texto = Texto & "<b>Paciente:</b> " & Rs("Paciente_Nome") & "<br>"
					Texto = Texto & "<b>Status de Atendimento:</b> " & Rs("Atendimento_Status") & "<br>" 
					Texto = Texto & "<b>Status do Paciente:</b> " & Rs("Status_Condicoes_Alta") & "<br><br>" 
					Texto = Texto & "Para visualizar mais detalhes clique "&"<a href='"&Application("Dominio")&"/Modulos/HomeCare/Atendimento/ImprimirAtendimento.asp?id_Atendimento="&Id_Atendimento&"' target='_blank'>aqui</a>"

					'Busca os emails dos clinentes que tem permissão de receber emails
					'É passado o id do convenio e o Tipo de email que sera enviado para dentro da function ser usado
					EmailsContatos = Verifica_Permissao_Email_Cliente_Contato(Rs("id_Convenio"),"Solicitacao")
									
					'Dispara o email
					'Ordem dos parametro do envio de email (de,para,com_copia,copia_oculta,assunto,texto)
					Call enviar_email(application("email_suporte"),EmailsContatos,"",application("email_programador"),Assunto,Texto)
				End if
			Rs.Close
			Set Rs = Nothing

End Function


'Função resposavel por disparar o email quando for aberto uma nova solicitacao
Function Dispara_Email_Abertura_Solicitacao(Id_Solicitacao)

	'[CONEXÃO COM O BANCO DE DADOS]
	set conn=server.createobject("adodb.connection")
	conn.open application("connstring")

	SQL =	"SELECT dbo.HomeCare_Solicitacao_Status.Descricao, dbo.Pacientes.nome, HomeCare_Solicitacao_Atendimento.id_Convenio " &_
			"FROM dbo.HomeCare_Solicitacao_Atendimento INNER JOIN " &_ 
			"dbo.HomeCare_Solicitacao_Status ON  " &_ 
			"dbo.HomeCare_Solicitacao_Atendimento.id_Solicitacao_Status = dbo.HomeCare_Solicitacao_Status.id INNER JOIN " &_ 
			"dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id " &_ 
			"WHERE dbo.HomeCare_Solicitacao_Atendimento.id = '"&Cint(id_Solicitacao)&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				If Not Rs.Eof Then
					Assunto = "Nova Solicitação de Atendimento - Paciente: " & Request("Nome_Paciente") 'Assunto do email
					
					Texto = ""
					Texto = Texto & "<b>Nova Solicitação de atendimento</b>" & "<br><br>"  
					Texto = Texto & "<b>Data:</b> " & ArrumaDataHora(Now) & "<br>" 
					Texto = Texto & "<b>Cliente</b>: " & Session("Convenio_Nome") & "<br>" 
					Texto = Texto & "<b>Funcionario:</b> " & Session("Funcionario_Nome") & "<br>" 
					Texto = Texto & "<b>Paciente:</b> " & Rs("Nome") & "<br>"
					Texto = Texto & "<b>Status:</b> " & Rs("Descricao") & "<br><br>" 
					Texto = Texto & "Para visualizar mais detalhes clique "&"<a href='"&Application("Dominio")&"/Modulos/HomeCare/Solicitacao/ImprimirSolicitacao.asp?id_Solicitacao_Atendimento="&Id_Solicitacao&"' target='_blank'>aqui</a>"
					
					'Busca os emails dos clinentes que tem permissão de receber emails
					'É passado o id do convenio e o Tipo de email que sera enviado para dentro da function ser usado
					EmailsContatos = Verifica_Permissao_Email_Cliente_Contato(Rs("id_Convenio"),"Solicitacao")
										
					'Dispara o email
					'Ordem dos parametro do envio de email (de,para,com_copia,copia_oculta,assunto,texto)
					Call enviar_email(application("email_suporte"),EmailsContatos,"",application("email_programador"),Assunto,Texto)
				End if
			Rs.Close
			Set Rs = Nothing

End Function

Function Dispara_Email_Cancelamento_Solicitacao(id_Solicitacao)

	Assunto = "Cancelamento de Solicitação de Atendimento - Nº: " & id_Solicitacao 'Assunto do email
	
	Texto = ""
	Texto = Texto & "<b>Cancelamento de Solicitação de atendimento</b>" & "<br><br>"  
	Texto = Texto & "Data: " & ArrumaDataHora(Now) & "<br>" 
	Texto = Texto & "Nº Solicitação: " & id_Solicitacao & "<br>" 
	Texto = Texto & "Cliente: " & Session("Convenio_Nome") & "<br>" 
	Texto = Texto & "Funcionario: " & Session("Funcionario_Nome") & "<br><br>" 
	Texto = Texto & "Para visualizar mais detalhes clique "&"<a href='"&Application("Dominio")&"/Modulos/HomeCare/Solicitacao/ImprimirSolicitacao.asp?id_Solicitacao_Atendimento="&Id_Solicitacao&"' target='_blank'>aqui</a>"
	
	'Busca os emails dos clinentes que tem permissão de receber emails
	'É passado o Cliente e o Tipi de email que sera enviado para dentro da function ser usado
	EmailsContatos = Verifica_Permissao_Email_Cliente_Contato(Session("id_Convenio"),"Solicitacao")

	'Dispara o email
	'Ordem dos parametro do envio de email (de,para,com_copia,copia_oculta,assunto,texto)
	Call enviar_email(application("email_suporte"),EmailsContatos,"",application("email_programador"),Assunto,Texto)

End Function

'Função que ira disparar um email avisando que a solicitação teve alteração de status
Function Dispara_Email_Solicitacao_Alteracao_Status(id_Solicitacao)

	If Cint(Request("id_Solicitacao_Status")) <> Cint(Request("id_Solicitacao_Status_Verifica")) Then
		'[CONEXÃO COM O BANCO DE DADOS]
		set conn=server.createobject("adodb.connection")
		conn.open application("connstring")
	
		SQL =	"SELECT dbo.HomeCare_Solicitacao_Status.Descricao, dbo.Pacientes.nome, HomeCare_Solicitacao_Atendimento.id_Convenio " &_
				"FROM dbo.HomeCare_Solicitacao_Atendimento INNER JOIN " &_ 
				"dbo.HomeCare_Solicitacao_Status ON  " &_ 
				"dbo.HomeCare_Solicitacao_Atendimento.id_Solicitacao_Status = dbo.HomeCare_Solicitacao_Status.id INNER JOIN " &_ 
				"dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id " &_ 
				"WHERE dbo.HomeCare_Solicitacao_Atendimento.id = '"&Cint(id_Solicitacao)&"' "
				Set rs = server.createobject("adodb.recordset")
				Rs.open SQL, CONN, 3
					If Not Rs.Eof Then
						Assunto = "Solicitação de Atendimento - Alteração Status: " & Rs("Descricao") 'Assunto do email
						Texto = ""
						Texto = Texto & "<b>Solicitação de Atendimento - Alteração de Status</b>" & "<br><br>"  
						Texto = Texto & "<b>Data:</b> " & ArrumaDataHora(Now) & "<br>" 
						Texto = Texto & "<b>Funcionario:</b> " & Session("Funcionario_Nome") & "<br>" 
						Texto = Texto & "<b>Nº Solicitação</b>: " & id_Solicitacao & "<br>" 
						Texto = Texto & "<b>Paciente:</b> " & Rs("Nome") & "<br>" 
						Texto = Texto & "<b>Status:</b> " & Rs("Descricao") & "<br><br>" 
						Texto = Texto & "Para visualizar mais detalhes clique "&"<a href='"&Application("Dominio")&"/Modulos/HomeCare/Solicitacao/ImprimirSolicitacao.asp?id_Solicitacao_Atendimento="&Id_Solicitacao&"' target='_blank'>aqui</a>"
						
						'Busca os emails dos clinentes que tem permissão de receber emails
						'É passado o id_Convenio e o Tipo de email que sera enviado para dentro da function ser usado
						EmailsContatos = Verifica_Permissao_Email_Cliente_Contato(Rs("id_Convenio"),"Solicitacao")

						'Dispara o email
						'Ordem dos parametro do envio de email (de,para,com_copia,copia_oculta,assunto,texto)
						Call enviar_email(application("email_suporte"),EmailsContatos,"",application("email_programador"),Assunto,Texto)
					End if
			Rs.Close
			Set Rs = Nothing
	End if

End Function

'Função que dispara o email avisando que aconteceu uma evolução no paciente
Function Dispara_Email_Evolucao_Paciente(id_Evolucao)

	Assunto = "Evolução Multidiciplinar - Paciente: " & Request("Paciente_Nome") 'Assunto do email
	Texto = ""
	Texto = Texto & "<b>Evolução Multidiciplinar - Paciente: " & Request("Paciente_Nome") &"</b>" & "<br><br>"  
	Texto = Texto & "<b>Data Cadastro:</b> " & ArrumaDataHora(Now) & "<br>" 
	Texto = Texto & "<b>Data Evolução:</b> " & Request("Data_Evolucao") & "<br>" 
	Texto = Texto & "<b>Médico:</b> " & Request("Medico_Nome") & "<br>" 
	Texto = Texto & "<b>Nº Atendimento</b>: " & Request("id_Atendimento") & "<br>" 
	Texto = Texto & "<b>Nº Evolução</b>: " & id_Evolucao & "<br>"
	Texto = Texto & "<b>Paciente:</b> " & Request("Paciente_Nome") & "<br><br>"
	Texto = Texto & "Para visualizar mais detalhes clique "&"<a href='"&Application("Dominio")&"/Modulos/HomeCare/Prontuario_Medico/Formulario_Evolucao/Historico.asp?id_Atendimento="&Request("id_Atendimento")&"' target='_blank'>aqui</a>"
	
	'Dispara o email
	'Ordem dos parametro do envio de email (de,para,com_copia,copia_oculta,assunto,texto)
	Call enviar_email(application("email_suporte"),application("email_suporte"),"",application("email_programador"),Assunto,Texto)

End Function

'Função responsavel por gravar um historico de login toda vez que o usuario acesso o sistema
'Se passar 1 como parametro entao grava a acao de entrar, caso for 2 acao de sair do sistema
Function Grava_Log_Login(Acao)

	'[CONEXÃO COM O BANCO DE DADOS]
	set conn=server.createobject("adodb.connection")
	conn.open application("connstring")

	If Acao = "1" Then Acao = "Entrou as "&Now&" " End if
	If Acao = "2" Then Acao = "Saiu as "&Now&" " End if
	
	SQL = 	"INSERT INTO Log_Login (Usuario,Acao) VALUES ( '"&Session("Funcionario_Nome")&"' , '"&Acao&"' ) "
			Conn.execute(SQL)
			
	'Fecha Conexão Com Banco De Dados
	'Conn.Close
	'Set Conn = Nothing

End Function

%>