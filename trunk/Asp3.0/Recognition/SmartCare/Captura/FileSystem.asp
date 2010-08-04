<%
'Cria uma pasta.
'O DirName pode ser um caminho absoluto ou relativo.
Public Function CreateFolder(ByVal DirName)
	
	On Error Resume Next
  If Mid(DirName, 2, 1) <> ":" Then
    DirName = Server.MapPath(DirName)
  End If
  If Err Then Err.Clear
  On Error GoTo 0
	
	Dim FSO
	Set FSO = Server.CreateObject("Scripting.FileSystemObject")
	
	On Error Resume Next
	If Not FSO.FolderExists(DirName) Then
		If Err Then
			On Error GoTo 0
			CreateFolder = False
			Set FSO = Nothing
			Exit Function
		End If

		FSO.CreateFolder DirName
		If Err Then
			On Error GoTo 0
			CreateFolder = False
			Set FSO = Nothing
			Exit Function
		End If	
	End If

	On Error GoTo 0
	Set FSO = Nothing
	CreateFolder = True

End Function

'FUNÇÃO QUE PREENCHE ZEROS A ESQUERDA DE UMA STRING PASSADA PARA A FUNÇÃO
'EX: SE VOCÊ PASSAR UMA STRING DE DATA 1/8/2005 NESSE FORMATO ENTAO ESTA FUNÇÃO FAZ A FORMATAÇÃO PARA 01/08/2005
'PARA USAR: StrZero(string,2) numero que foi passado é a quantidade de numeros que a string tera que ter
Function StrZero(Str,Size)
   Dim x, Content
   Content = ""
   For x = 1 to Size 'Faz o laço for até o numero que foi passado como parametro na função
      Content = Content & "0"
   Next
   StrZero = Right(Content & Str,Size)
End Function

Dim caminho 'Defino uma variavel caminho que sera usado no Upload.asp

'Função responsavel por criar a estrutura de pastas
Function CriaPastas(id_Paciente,id_Atendimento)
	Raiz = "C:\Inetpub\wwwroot\SmartCare\Captura\Imagens\" 'Posição do diretorio onde sera criado as pastas. Exe: C:\temp\
	Id_Paciente = StrZero(id_Paciente,10) 'Pega o id do paciente e acrescenta zeros a esquerda, preenchendo um total de 10 posições
	Id_Atendimento = StrZero(id_Atendimento,10) 'Pega o id do atendimento e acrescenta zeros a esquerda, preenchendo um total de 10 posições
	Data = Year(Date) & "_" & StrZero(Month(Date),2) & "_" & StrZero(Day(Date),2) 'Pega a data atual, modifica o formato para Ano/Mes/Dia. Isso foi feito pois fica mais facil depois fazer um filtro na pasta por ano
	CreateFolder(Raiz&Id_Paciente) 'Cria a pasta Raiz com o ID do paciente
	CreateFolder(Raiz&Id_Paciente&"\"&id_Atendimento) 'Cria a pasta Raiz com o ID do paciente
	CreateFolder(Raiz&Id_Paciente&"\"&id_Atendimento&"\"&Data) 'Cria nova pasta com a Data
	CreateFolder(Raiz&Id_Paciente&"\"&id_Atendimento&"\"&Data&"\"&Session.SessionID) 'Cria nova pasta com a SessionID
	Caminho = Raiz&Id_Paciente&"\"&id_Atendimento&"\"&Data&"\"&Session.SessionID&"\" 'Apos criar as pastas o caminho é este para agravação das imagens
End Function

'Função responsavel por batizar o nome da imagem
Function OrganizaNomeImagem(valor)
	
	if valor = "" then
		session("contador") = 1
	else 
		session("contador") = session("contador") + 1 
	end if
	
	'Lingas ocultadas pois controlavam a frente e o verso do documento, porem o usuario pode apenas selecionar a fremte do documento.
	'If session("contador2") = "" Then session("contador2") = 0
	
	'if session("contador") mod 2 Then
	'	session("contador2") = session("contador2") + 1
	'	session("lado") = "F" 
	'else
	'	session("contador2") = session("contador2")
	'	session("lado") = "V"	
	'End if
	'OrganizaNomeImagem = StrZero(session("contador2")&session("Lado"),7) 'Nome da imagem com 6 posições, esta com 7 pois uma posição é a letra F(Frente) ou V(Verso) no fim do arquivo
	OrganizaNomeImagem = StrZero(session("contador")&session("Lado"),7) 'Nome da imagem com 6 posições, esta com 7 pois uma posição é a letra F(Frente) ou V(Verso) no fim do arquivo

End Function

Function Grava_Documento(id_Paciente,id_Atendimento,NSession)

	Dim conn
	'[CONEXÃO COM O BANCO DE DADOS]
	set conn=server.createobject("adodb.connection")
	conn.open application("connstring")

	SQL =	"INSERT INTO Documento (id_Paciente,id_Atendimento,SessionID) VALUES ( '"&id_Paciente&"' , '"&id_Atendimento&"' , '"&NSession&"'  ) "
			conn.execute(SQL)

	Conn.Close
	Set Conn = Nothing
	
End Function

Function Grava_Imagem(img,id_Tipo)

	Dim conn
	'[CONEXÃO COM O BANCO DE DADOS]
	set conn=server.createobject("adodb.connection")
	conn.open application("connstring")

	SQL	=	"SELECT Top 1 id From Documento Where SessionID = '"&Session.SessionID&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					SQL =	"INSERT INTO Documento_Imagem (id_Documento,Id_Tipo,img) VALUES ( '"&Rs("ID")&"' , '"&Id_Tipo&"' , '"&img&"'  ) "
							conn.execute(SQL)
				End if

	Conn.Close
	Set Conn = Nothing
	
End Function
%>