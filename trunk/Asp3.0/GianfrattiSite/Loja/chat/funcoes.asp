<%
'Formata datas e valores para anotação americana, ATENÇÃO: Nunca altere este valor
Session.LCID = 1033

'********************************************************************************************************
' CARREGA VARIAVEIS DO SISTEMA
'********************************************************************************************************
'Verifica se o sistema esta ativo
If Application("SOS_sistema_ativo") <> True Then

  Application.Lock()

 'Lista dos atendentes
  Dim SOS_atendentes()
  Dim SOS_departamentos()
  Dim SOS_atendente_controle()

  Redim SOS_atendentes(0)
  Redim SOS_departamentos(0)
  Redim SOS_atendente_controle(0)

  Application("SOS_atendentes") = SOS_atendentes
  Application("SOS_departamentos") = SOS_departamentos
  Application("SOS_atendente_controle") = SOS_atendente_controle

 'Lista dos usuarios
  Dim SOS_usuario()
  Dim SOS_atendente()
  Dim SOS_ip()
  Dim SOS_entrada()
  Dim SOS_ativo()
  Dim SOS_email()
  Dim SOS_assunto()
  Dim SOS_id()
  Dim SOS_controle()

  Redim SOS_usuario(0)
  Redim SOS_atendente(0)
  Redim SOS_ip(0)
  Redim SOS_entrada(0)
  Redim SOS_ativo(0)
  Redim SOS_email(0)
  Redim SOS_assunto(0)
  Redim SOS_id(0)
  Redim SOS_controle(0)

  Application("SOS_usuario") = SOS_usuario
  Application("SOS_atendente") = SOS_atendente
  Application("SOS_ip") = SOS_ip
  Application("SOS_entrada") = SOS_entrada
  Application("SOS_ativo") = SOS_ativo
  Application("SOS_email") = SOS_email
  Application("SOS_assunto") = SOS_assunto
  Application("SOS_id") = SOS_id
  Application("SOS_controle") = SOS_controle

  'Define demais variaveis do sistema
  Application("SOS_conexao") = "Data Source=" & endereco_fisico & "databases\SOSdatabase.mdb;Provider=Microsoft.Jet.OLEDB.4.0;"
  Application("SOS_sistema_ativo") = True 

  Set objCon = Server.CreateObject("ADODB.Connection")
  objCon.Open Application("SOS_conexao")

  Set objRS = Server.CreateObject("ADODB.Recordset")
  objRS.CursorLocation = 2
  objRS.CursorType = 0
  objRS.LockType = 1
  strQ = "SELECT * FROM configuracoes"
  objRS.Open strQ, objCon, , , &H0001

  Application("SOS_tempo_expiracao") = Trim(objRS("tempo_espera_cliente"))
  Application("SOS_titulo") = Trim(objRS("titulo_atendimento"))
  Application("SOS_url") = Trim(objRS("url_atendimento"))
  Application("SOS_email_atendimento") = Trim(objRS("email_atendimento"))
  Application("SOS_componente") = Trim(objRS("email_componente"))
  Application("SOS_servidor") = Trim(objRS("email_servidor"))
  Application("SOS_titulo_email") = Trim(objRS("titulo_email"))
  Application("SOS_titulo_janela") = Trim(objRS("titulo_janela"))
  Application("SOS_tempo_espera") = Trim(objRS("tempo_espera_cliente"))
  Application("SOS_som") = objRS("som")
  Application("SOS_foto") = objRS("foto")

  objRS.Close
  Set objRS = Nothing
  objCon.Close
  Set objCon = Nothing

  Application.UnLock()

End If

'Executa rotina para remover atendentes e usuarios expirados
remove_usuarios_expirados
remove_atendentes_expirados


Function verifica_status()
  verifica_status = False

  Application.Lock()

  Dim SOS_atendentes

  'Carrega lista de usuarios
  SOS_atendentes = Application("SOS_atendentes")

  'Verifica se exixten atendentes online
  n = UBound(SOS_atendentes)
  If n > 0 Then
    verifica_status = True
  End IF

  Application.UnLock()  

  'Elimina variaveis da memoria
  Set n = Nothing

End Function

'********************************************************************************************************
' ADICIONA USUARIO NA LISTA
'********************************************************************************************************
Sub adiciona_usuario(usuario, atendente, email, assunto)

  Application.Lock()

  Dim SOS_usuario
  Dim SOS_atendente
  Dim SOS_ip
  Dim SOS_entrada
  Dim SOS_ativo
  Dim SOS_email
  Dim SOS_assunto
  Dim SOS_id
  Dim SOS_controle

  'Carrega lista de usuarios
  SOS_usuario = Application("SOS_usuario")
  SOS_atendente = Application("SOS_atendente")
  SOS_ip = Application("SOS_ip")
  SOS_entrada = Application("SOS_entrada")
  SOS_ativo = Application("SOS_ativo")
  SOS_email = Application("SOS_email")
  SOS_assunto = Application("SOS_assunto")
  SOS_id = Application("SOS_id")
  SOS_controle = Application("SOS_controle")

  adiciona = True

  'Verifica se ha outro usuario com o mesmo nome na lista
  n = UBound(SOS_usuario)
  For i = 0 To n
    If Lcase(Trim(SOS_usuario(i))) = Lcase(Trim(usuario)) And Int(SOS_atendente(i)) = Int(atendente) Then
	  adiciona = False
    End If
  Next

  If adiciona = True Then
    'Adiciona usuario na lista
    ReDim Preserve SOS_usuario(n + 1)
    ReDim Preserve SOS_atendente(n + 1)
    ReDim Preserve SOS_ip(n + 1)
    ReDim Preserve SOS_entrada(n + 1)
    ReDim Preserve SOS_ativo(n + 1)
    ReDim Preserve SOS_email(n + 1)
    ReDim Preserve SOS_assunto(n + 1)
    ReDim Preserve SOS_id(n + 1)
    ReDim Preserve SOS_controle(n + 1)

    'Grava dados do usuario
    SOS_usuario(n + 1) = Trim(usuario)
    SOS_atendente(n + 1) = atendente
    SOS_ip(n + 1) = Request.ServerVariables("REMOTE_ADDR")
    SOS_entrada(n + 1) = Now()
    SOS_ativo(n + 1) = False
    SOS_email(n + 1) = email
    SOS_assunto(n + 1) = assunto
    SOS_id(n + 1) = 0
    SOS_controle(n + 1) = Now + ((1/24/60/60)*Application("SOS_tempo_expiracao"))

    Application("SOS_usuario") = SOS_usuario
    Application("SOS_atendente") = SOS_atendente
    Application("SOS_ip") = SOS_ip
    Application("SOS_entrada") = SOS_entrada
    Application("SOS_ativo") = SOS_ativo
    Application("SOS_email") = SOS_email
    Application("SOS_assunto") = SOS_assunto
    Application("SOS_id") = SOS_id
    Application("SOS_controle") = SOS_controle
	
  Else
    Response.Write "Outro usuario ja possui este nome, informe seu nome por completo."
    Response.Write "<br><a href='javascript: history.go(-1)'>Clique aqui</a> para voltar"
	Response.End()
  End If

  Application.UnLock()

  'Elimina variaveis da memoria
  Set adiciona = Nothing
  Set SOS_usuario = Nothing
  Set SOS_atendente = Nothing
  Set SOS_ip = Nothing
  Set SOS_entrada = Nothing
  Set SOS_ativo = Nothing
  Set SOS_email = Nothing
  Set SOS_assunto = Nothing
  Set SOS_id = Nothing
  Set SOS_controle = Nothing
  Set n = Nothing
  Set i = Nothing

End Sub



'********************************************************************************************************
' REMOVE USUARIO DA LISTA
'********************************************************************************************************
Sub remove_usuario(usuario, atendente)

  Application.Lock()

  Dim SOS_usuario
  Dim SOS_atendente
  Dim SOS_ip
  Dim SOS_entrada
  Dim SOS_ativo
  Dim SOS_email
  Dim SOS_assunto
  Dim SOS_id
  Dim SOS_controle

  'Carrega lista de usuarios
  SOS_usuario = Application("SOS_usuario")
  SOS_atendente = Application("SOS_atendente")
  SOS_ip = Application("SOS_ip")
  SOS_entrada = Application("SOS_entrada")
  SOS_ativo = Application("SOS_ativo")
  SOS_email = Application("SOS_email")
  SOS_assunto = Application("SOS_assunto")
  SOS_id = Application("SOS_id")
  SOS_controle = Application("SOS_controle")

  n = UBound(SOS_usuario)

  Dim SOS_atualiza_usuario()
  Dim SOS_atualiza_atendente()
  Dim SOS_atualiza_ip()
  Dim SOS_atualiza_entrada()
  Dim SOS_atualiza_ativo()
  Dim SOS_atualiza_email()
  Dim SOS_atualiza_assunto()
  Dim SOS_atualiza_id()
  Dim SOS_atualiza_controle()

  'Verifica se a lista nao esta vazia
  If n > 0 Then

    ReDim Preserve SOS_atualiza_usuario(n-1)
    ReDim Preserve SOS_atualiza_atendente(n-1)
    ReDim Preserve SOS_atualiza_ip(n-1)
    ReDim Preserve SOS_atualiza_entrada(n-1)
    ReDim Preserve SOS_atualiza_ativo(n-1)
    ReDim Preserve SOS_atualiza_email(n-1)
    ReDim Preserve SOS_atualiza_assunto(n-1)
    ReDim Preserve SOS_atualiza_id(n-1)
    ReDim Preserve SOS_atualiza_controle(n-1)

    x = 0
    For i = 0 to n
	  If Lcase(Trim(SOS_usuario(i))) = Lcase(Trim(usuario)) And Int(SOS_atendente(i)) = Int(atendente) Then
        'Não armazena o usuarios a ser removido
	  Else
        'Armazena os demais usuarios em uma lista temporaria
        SOS_atualiza_usuario(x) = SOS_usuario(i)
        SOS_atualiza_atendente(x) = SOS_atendente(i)
        SOS_atualiza_ip(x) = SOS_ip(i)
        SOS_atualiza_entrada(x) = SOS_entrada(i)
        SOS_atualiza_ativo(x) = SOS_ativo(i)
        SOS_atualiza_email(x) = SOS_email(i)
        SOS_atualiza_assunto(x) = SOS_assunto(i)
        SOS_atualiza_id(x) = SOS_id(i)
        SOS_atualiza_controle(x) = SOS_controle(i)
        x = x + 1
	  End If
    Next
  Else
    Redim SOS_atualiza_usuario(0)
    Redim SOS_atualiza_atendente(0)
    Redim SOS_atualiza_ip(0)
    Redim SOS_atualiza_entrada(0)
    Redim SOS_atualiza_ativo(0)
    Redim SOS_atualiza_email(0)
    Redim SOS_atualiza_assunto(0)
    Redim SOS_atualiza_id(0)
    Redim SOS_atualiza_controle(0)
  End IF

  'Atualiza lista de usuarios
  Application("SOS_usuario") = SOS_atualiza_usuario
  Application("SOS_atendente") = SOS_atualiza_atendente
  Application("SOS_ip") = SOS_atualiza_ip
  Application("SOS_entrada") = SOS_atualiza_entrada
  Application("SOS_ativo") = SOS_atualiza_ativo
  Application("SOS_email") = SOS_atualiza_email
  Application("SOS_assunto") = SOS_atualiza_assunto
  Application("SOS_id") = SOS_atualiza_id
  Application("SOS_controle") = SOS_atualiza_controle

  Application.UnLock()  

  'Elimina variaveis da memoria
  Set n = Nothing
  Set x = Nothing
  Set i = Nothing

End Sub

'********************************************************************************************************
' REMOVE OS USUARIO COM TEMPO DE AGUARDO EXPIRADO
'********************************************************************************************************
Sub remove_usuarios_expirados()

  Application.Lock()
  'Carrega lista de usuarios
  Dim SOS_usuario
  Dim SOS_atendente
  Dim SOS_ip
  Dim SOS_entrada
  Dim SOS_ativo
  Dim SOS_email
  Dim SOS_assunto
  Dim SOS_id
  Dim SOS_controle

  SOS_usuario = Application("SOS_usuario")
  SOS_atendente = Application("SOS_atendente")
  SOS_ip = Application("SOS_ip")
  SOS_entrada = Application("SOS_entrada")
  SOS_ativo = Application("SOS_ativo")
  SOS_email = Application("SOS_email")
  SOS_assunto = Application("SOS_assunto")
  SOS_id = Application("SOS_id")
  SOS_controle = Application("SOS_controle")

  n = UBound(SOS_usuario)

  Dim SOS_atualiza_usuario()
  Dim SOS_atualiza_atendente()
  Dim SOS_atualiza_ip()
  Dim SOS_atualiza_entrada()
  Dim SOS_atualiza_ativo()
  Dim SOS_atualiza_email()
  Dim SOS_atualiza_assunto()
  Dim SOS_atualiza_id()
  Dim SOS_atualiza_controle()

  'Verifica se a lista nao esta vazia
  If n > 0 Then
    x = 0
    For i = 0 to n

      If SOS_controle(i) > Now() Or i = 0 Then

	    ReDim Preserve SOS_atualiza_usuario(x)
	    ReDim Preserve SOS_atualiza_atendente(x)
	    ReDim Preserve SOS_atualiza_ip(x)
	    ReDim Preserve SOS_atualiza_entrada(x)
	    ReDim Preserve SOS_atualiza_ativo(x)
	    ReDim Preserve SOS_atualiza_email(x)
	    ReDim Preserve SOS_atualiza_assunto(x)
	    ReDim Preserve SOS_atualiza_id(x)
	    ReDim Preserve SOS_atualiza_controle(x)
		
		On Error Resume Next

       'Armazena os demais usuarios em uma lista temporaria
        SOS_atualiza_usuario(x) = SOS_usuario(i)
        SOS_atualiza_atendente(x) = SOS_atendente(i)
        SOS_atualiza_ip(x) = SOS_ip(i)
        SOS_atualiza_entrada(x) = SOS_entrada(i)
        SOS_atualiza_ativo(x) = SOS_ativo(i)
        SOS_atualiza_email(x) = SOS_email(i)
        SOS_atualiza_assunto(x) = SOS_assunto(i)
        SOS_atualiza_id(x) = SOS_id(i)
        SOS_atualiza_controle(x) = SOS_controle(i)

        x = x + 1
      End If
    Next
  Else
    Redim SOS_atualiza_usuario(0)
    Redim SOS_atualiza_atendente(0)
    Redim SOS_atualiza_ip(0)
    Redim SOS_atualiza_entrada(0)
    Redim SOS_atualiza_ativo(0)
    Redim SOS_atualiza_email(0)
    Redim SOS_atualiza_assunto(0)
    Redim SOS_atualiza_id(0)
    Redim SOS_atualiza_controle(0)
  End IF

  'Atualiza lista de usuarios
  Application("SOS_usuario") = SOS_atualiza_usuario
  Application("SOS_atendente") = SOS_atualiza_atendente
  Application("SOS_ip") = SOS_atualiza_ip
  Application("SOS_entrada") = SOS_atualiza_entrada
  Application("SOS_ativo") = SOS_atualiza_ativo
  Application("SOS_email") = SOS_atualiza_email
  Application("SOS_assunto") = SOS_atualiza_assunto
  Application("SOS_id") = SOS_atualiza_id
  Application("SOS_controle") = SOS_atualiza_controle

  Application.UnLock()  

  'Elimina variaveis da memoria
  Set n = Nothing
  Set x = Nothing
  Set i = Nothing

End Sub


'********************************************************************************************************
' ADICIONA ATENDENTE
'********************************************************************************************************
Sub adiciona_atendente(atendente, departamento)

  'Atualiza status do atendente para 1: Online
  Set objCon = Server.CreateObject("ADODB.Connection")
  objCon.Open Application("SOS_conexao")
  ComandoSQL = "UPDATE atendentes SET status=1 Where id = " & atendente
  Set objRS = objCon.Execute(ComandoSQL)
  objCon.Close

  'Elimina variaveis da memoria
  Set objCon = Nothing
  Set ComandoSQL = Nothing
  Set objRS = Nothing

  Application.Lock()

  Dim SOS_atendentes
  Dim SOS_departamentos
  Dim SOS_atendente_controle

  'Carrega lista de usuarios
  SOS_atendentes = Application("SOS_atendentes")
  SOS_departamentos = Application("SOS_departamentos")
  SOS_atendente_controle = Application("SOS_atendente_controle")

  adiciona = True

  'Verifica se ha outro usuario com o mesmo nome na lista
  n = UBound(SOS_atendentes)
  For i = 0 To n
    If Int(SOS_atendentes(i)) = Int(atendente) And Int(SOS_departamentos(i)) = Int(departamento) Then
	  adiciona = False
    End If
  Next

  If adiciona = True Then
    'Adiciona usuario na lista
    ReDim Preserve SOS_atendentes(n + 1)
    ReDim Preserve SOS_departamentos(n + 1)
    ReDim Preserve SOS_atendente_controle(n + 1)

    'Grava dados do usuario
    SOS_atendentes(n + 1) = Trim(atendente)
    SOS_departamentos(n + 1) = Trim(departamento)
    SOS_atendente_controle(n + 1) = Now + ((1/24/60/60)*Application("SOS_tempo_expiracao"))

    Application("SOS_atendentes") = SOS_atendentes
    Application("SOS_departamentos") = SOS_departamentos
    Application("SOS_atendente_controle") = SOS_atendente_controle

  Else
    Response.Write "Outro atendente ja possui este nome, informe seu nome por completo."
    Response.Write "<br><a href='javascript: history.go(-1)'>Clique aqui</a> para voltar"
	Response.End()
  End If

  Application.UnLock()

  'Elimina variaveis da memoria
  Set SOS_atendentes = Nothing
  Set SOS_atendentes = Nothing
  Set SOS_atendente_controle = Nothing
  Set n = Nothing
  Set i = Nothing

End Sub


'********************************************************************************************************
' ATUALIZA STATUS DO USUARIO
'********************************************************************************************************
Sub atualiza_status_usuario(usuario, atendente)

  Dim SOS_usuario
  Dim SOS_atendente
  Dim SOS_controle

  Application.Lock()

 'Atualiza o status do atendente, informando que o mesmo encontra-se online
  SOS_usuario = Application("SOS_usuario")
  SOS_atendente = Application("SOS_atendente")
  SOS_controle = Application("SOS_controle")

  n = UBound(SOS_usuario)
  For i = 0 To n
    If Trim(SOS_atendente(i)) <> "" Then
      If Lcase(SOS_usuario(i)) = Lcase(Trim(usuario)) And Int(SOS_atendente(i)) = Int(atendente) Then
        SOS_controle(i) = Now + ((1/24/60/60)*Application("SOS_tempo_expiracao"))
      End If
    End If
  Next

  Application("SOS_controle") = SOS_controle
  Application("SOS_atendente") = SOS_atendente
  
  Application.UnLock()

  Set n = Nothing
  Set i = Nothing

End Sub


'********************************************************************************************************
' ATUALIZA STATUS DO ATENDENTE
'********************************************************************************************************
Sub atualiza_status_atendente(atendente)

  Dim SOS_atendentes
  Dim SOS_atendente_controle
  
  Application.Lock()

 'Atualiza o status do atendente, informando que o mesmo encontra-se online
  SOS_atendentes = Application("SOS_atendentes")
  SOS_atendente_controle = Application("SOS_atendente_controle")

  n = UBound(SOS_atendentes)
  For i = 0 To n
    If Trim(SOS_atendentes(i)) <> "" Then
      If Int(SOS_atendentes(i)) = Int(atendente) Then
        SOS_atendente_controle(i) = Now + ((1/24/60/60)*Application("SOS_tempo_expiracao"))

      End If
    End If
  Next

  Application("SOS_atendente_controle") = SOS_atendente_controle
  
  Application.UnLock()

  Set n = Nothing
  Set i = Nothing

End Sub


'********************************************************************************************************
' REMOVE ATENDENTE
'********************************************************************************************************
Sub remove_atendente(atendente)

  'Atualiza status do atendente para 1: Online
  Set objCon = Server.CreateObject("ADODB.Connection")
  objCon.Open Application("SOS_conexao")
  ComandoSQL = "UPDATE atendentes SET status=0 Where id = " & atendente
  Set objRS = objCon.Execute(ComandoSQL)
  objCon.Close

  Dim SOS_atendente

  Application.Lock()

 'Se encontrar usuarios sendo atendidos, informa aos usuario que o atendente saiu
  SOS_atendente = Application("SOS_atendente")
  n = UBound(SOS_atendente)
  For i = 0 To n
    If Int(SOS_atendente(i)) = Int(Session("SOS_atendente")) Then
      SOS_atendente(i) = 0
    End If
  Next
  Application("SOS_atendente") = SOS_atendentes

  Dim SOS_atendentes
  Dim SOS_departamentos
  Dim SOS_atendente_controle

  'Carrega lista de atendentes
  SOS_atendentes = Application("SOS_atendentes")
  SOS_departamentos = Application("SOS_departamentos")
  SOS_atendente_controle = Application("SOS_atendente_controle")

  n = UBound(SOS_atendentes)

  Dim SOS_atualiza_atendentes()
  Dim SOS_atualiza_departamentos()
  Dim SOS_atualiza_atendente_controle()

  'Verifica se a lista nao esta vazia
  If n > 0 Then
    x = 0
	Set objCon = Server.CreateObject("ADODB.Connection")
	objCon.Open Application("SOS_conexao")
    For i = 0 to n
      If SOS_atendentes(i) <> atendente Or i = 0 Then

	    ReDim Preserve SOS_atualiza_atendentes(x)
	    ReDim Preserve SOS_atualiza_departamentos(x)
	    ReDim Preserve SOS_atualiza_atendente_controle(x)

       'Armazena os demais usuarios em uma lista temporaria
        SOS_atualiza_atendentes(x) = SOS_atendentes(i)
        SOS_atualiza_departamentos(x) = SOS_departamentos(i)
        SOS_atualiza_atendente_controle(x) = SOS_atendente_controle(i)

        x = x + 1
	  Else

	    'Atualiza status do atendente para 1: Online
		ComandoSQL = "UPDATE atendentes SET status=0 Where id = " & atendente
		Set objRS = objCon.Execute(ComandoSQL)

      End IF
    Next
	objCon.Close
	Set objCon = Nothing
  Else
    Redim SOS_atualiza_atendentes(0)
    Redim SOS_atualiza_departamentos(0)
    Redim SOS_atualiza_atendente_controle(0)
  End IF

  'Atualiza lista de usuarios
  Application("SOS_atendentes") = SOS_atualiza_atendentes
  Application("SOS_departamentos") = SOS_atualiza_departamentos
  Application("SOS_atendente_controle") = SOS_atualiza_atendente_controle

  Application.UnLock()  

  'Elimina variaveis da memoria
  Set n = Nothing
  Set x = Nothing
  Set i = Nothing

End Sub

'********************************************************************************************************
' REMOVE OS ATENDENTES COM TEMPO DE AGUARDO EXPIRADO
'********************************************************************************************************
Sub remove_atendentes_expirados()

  Application.Lock()

  Dim SOS_atendentes
  Dim SOS_departamentos
  Dim SOS_atendente_controle

  'Carrega lista de usuarios
  SOS_atendentes = Application("SOS_atendentes")
  SOS_departamentos = Application("SOS_departamentos")
  SOS_atendente_controle = Application("SOS_atendente_controle")

  n = UBound(SOS_atendentes)

  Dim SOS_atualiza_atendentes()
  Dim SOS_atualiza_departamentos()
  Dim SOS_atualiza_atendente_controle()

  'Verifica se a lista nao esta vazia
  If n > 0 Then
    x = 0
	Set objCon = Server.CreateObject("ADODB.Connection")
	objCon.Open Application("SOS_conexao")
    For i = 0 to n
      If SOS_atendente_controle(i) > Now() Or i = 0 Then

	    ReDim Preserve SOS_atualiza_atendentes(x)
	    ReDim Preserve SOS_atualiza_departamentos(x)
	    ReDim Preserve SOS_atualiza_atendente_controle(x)

       'Armazena os demais usuarios em uma lista temporaria
        SOS_atualiza_atendentes(x) = SOS_atendentes(i)
        SOS_atualiza_departamentos(x) = SOS_departamentos(i)
        SOS_atualiza_atendente_controle(x) = SOS_atendente_controle(i)

        x = x + 1
	  Else
	    If Trim(SOS_atendentes(i)) <> "" Then
	      'Atualiza status do atendente para 1: Online
		  ComandoSQL = "UPDATE atendentes SET status=0 Where id = " & SOS_atendentes(i)
		  Set objRS = objCon.Execute(ComandoSQL)
		End If
      End IF
    Next
	objCon.Close
	Set objCon = Nothing
  Else
    Redim SOS_atualiza_atendentes(0)
    Redim SOS_atualiza_departamentos(0)
    Redim SOS_atualiza_atendente_controle(0)
  End IF

  'Atualiza lista de usuarios
  Application("SOS_atendentes") = SOS_atualiza_atendentes
  Application("SOS_departamentos") = SOS_atualiza_departamentos
  Application("SOS_atendente_controle") = SOS_atualiza_atendente_controle

  Application.UnLock()  

  'Elimina variaveis da memoria
  Set n = Nothing
  Set x = Nothing
  Set i = Nothing

End Sub


'********************************************************************************************************
' CAPTURA O ENDERECO VIRTUAL DO SITE DENTRO DO SERVIDOR
'********************************************************************************************************
Function endereco_virtual()

  'Captura o endereco virtual a partir da pagina que chamou
  referencia = Request.ServerVariables("PATH_INFO")
  For i = 1 to len(StrReverse(referencia))
    If Mid(StrReverse(referencia),i,1) = "/" Then Exit For
  Next
  endereco = "/" & Left(referencia,Len(referencia)-i)
  endereco = Replace(endereco,"//","")
  endereco = "http://" & Request.ServerVariables("HTTP_HOST") & "/" & endereco

  endereco_virtual = endereco

  'Elimina variaveis da memoria
  Set referencia = Nothing
  Set caracter = Nothing
  Set nome = Nothing

End Function

'********************************************************************************************************
' CAPTURA O ENDERECO FISICO DO SITE DENTRO DO SERVIDOR
'********************************************************************************************************
Function endereco_fisico()

  'Captura o endereco fisico a partir da pagina que chamou
  referencia = Replace(Request.ServerVariables("SCRIPT_NAME"),"\","/")
  For i = 1 to Len(referencia)
    If i = 1 Then nome = ""
    caracter = Mid(StrReverse(referencia),i,1)
    If caracter = "/" Then Exit For
    nome = nome & caracter
  Next
  nome = StrReverse(nome)
  endereco_fisico = Replace(Replace(Replace(Request.ServerVariables("PATH_TRANSLATED"),nome,""),"/","\"),"admin\","")

  'Elimina variaveis da memoria
  Set referencia = Nothing
  Set caracter = Nothing
  Set nome = Nothing

End Function
%>