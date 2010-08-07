<% 
'######################################################################
'#  Função: Monta Vetor Automatico                                                        
'#  Autro: Fabrizio Gianfratti                                                            
'#  Site: www.gianfratti.com      Email: fabrizio@gianfratti.com                          
'#  PARAMETROS DA FUNÇÃO                                                                  
'#  Acao: Inserir ou Excluir                                                           
'#  Valor: é o valor que ira ser incluido ou excluido do vetor                            
'#  COMO CHAMAR A FUNÇÃO PARA INCLUIR UM VETOR                                           
'#  Ex: Call VetorMonta("Incluir",16) 'Para Incluir uma posicao no vetor "numerica"       
'#  Ex: Call VetorMonta("Incluir","Fabrizio") 'Para Incluir uma posicao no vetor "string" 
'#  COMO CHAMAR A FUNÇÃO PARA EXCLUIR UMA POSICAO DO VETOR                                
'#  Ex: Call VetorMonta("Excluir",15) 'Para Excluir uma posicocao do vetor                
'#  COMO VISUALIZAR A SESSION ONDE ESTAO OS VETORES                                       
'#  For x = 0 To Ubound(session("GuardaVetor"))                                           
'#   Response.Write session("GuardaVetor")(x) & "<br>"                                 
'#  Next                                                                                  
'#####################################################################
Function VetorMonta(Acao,Valor)
 'Usamos o case para manipular a ação da função
 Select Case Trim(Acao)
  'Inclui nova posicao ao vetor
  Case "Incluir"
   'Guarda na variavel Vetor o conteudo da Session
   Vetor = Session("GuardaVetor")
   'Verifica se a Variavel Vetor é um Array, caso nao for entao definimos ela um Array
   If Not IsArray(Vetor) Then Vetor = Array() End if
	'Verifica se o Valor que esta sendo inserido já esta no Vetor se estiver entao nao inseri para nao haver duplicidades do vetor
   If InStr(Join(Vetor), Valor) = 0 Then
    'Este comando ira preservar o vetor e adciona + 1 valor
	ReDim preserve Vetor(UBound(Vetor)+1)
    'Este é o valor que estamos adicionando no vetor
	Vetor(Ubound(Vetor )) = Valor
    'Coloca o conteudo da variavel vetor dentro da Session
	Session("GuardaVetor") = Vetor
   End if
  'Apaga uma determinada posicao do vetor
  Case "Excluir" 
   'Inicia a varivel vetor como vazia
   Vetor = Array() 
   'Criamos uma nova variavel Auxiliar e guardamos o valor da Session
   AuxVetor = Session("GuardaVetor") 
   'Definine a Session como um Array vazio
   Session("GuardaVetor") = Array() 
   'Faz um laço em todas as posições do vetor
   For i = 0 To Ubound(AuxVetor) 
    'Verifica se o valor passado para excluir do vetor é diferente do valor que esta dentro da variavel Auxiliar
	If AuxVetor(i) <> (Valor) Then
     'Este comando ira preservar o vetor e adciona + 1 valor
	 ReDim preserve Vetor (UBound(Vetor)+1) 
     'Este é o valor que estamos adicionando no vetor
	 Vetor (Ubound(Vetor)) = AuxVetor(i) 
     'Coloca o conteudo da variavel vetor dentro da Session
	 Session("GuardaVetor") = Vetor
    End If
   Next
 End Select 'Fim do Case
End Function

Function Incluir_Vetor

	'Executa a função que ira criar uma posição do vetor, basta passar a acao e o valor
	Call VetorMonta("Incluir",Replace(Request("Valor_Vetor"),"'","")) 

End Function

Function Excluir_Vetor(Valor_Vetor)

	'Executa a função que ira deletar uma posição do vetor, basra passar a acao e o valor
	Call VetorMonta("Excluir",Valor_Vetor) 

End Function

Function VisualizaValoresVetor
	
	'Veriofica se a Session é um array, caso nao for então atribuimos a Session como um Array
	IF Not IsArray(session("GuardaVetor")) Then session("GuardaVetor") = Array() End if
	'Faremos um laço entre todos os vetores criados
	For x = 0 To ubound(session("GuardaVetor")) 'ira fazer um laço mostrando todos os vetores criados
	 'Mostra os valores armazenados na Session e adiciona um link para apagar a posição do vetor caso queira
	 Response.Write session("GuardaVetor")(x) & "<a href='vetor.asp?action=Excluir_Vetor&Valor_Vetor="&session("GuardaVetor")(x)&"'>(Apagar)</a>" & "<br>" 'Imprime o Vetor na tela
	Next
	
	'Verifica se a Session tem alguma posição, se tiver mostra a opção de apagar todos os vetores
	If ubound(session("GuardaVetor")) >= 0 Then
	Response.Write "<br>" &"<a href='vetor.asp?action=LimpaVetor'>Apagar Tudo</a>" & "<br>" 'Imprime o Vetor na tela
	End if
	
End Function

Function LimpaVetor

	'Limpa todas as posiçoes do vetor, apagando a Session
	session("GuardaVetor") = Empty

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUNÇÕES
useraction=request("action")
select case useraction

	Case "Incluir_Vetor"
		'Chama a function que ira incluir um valor para o vetor
		Call Incluir_Vetor
		
	Case "Excluir_Vetor"
		'Chama a function que ira excluir um valor para o vetor
		Call Excluir_Vetor(Request("Valor_Vetor"))
	
	Case "LimpaVetor"
		'Chama a function que apagar todas as posições do vetor
		Call LimpaVetor

End Select
%>
<table width="100%">
	<form name="form" method="post" action="?action=Incluir_Vetor">
		<tr>
			<td><input name="Valor_Vetor" type="text" id="Valor_Vetor">	
        <input type="submit" name="Submit" value="Incluir no Vetor"></td>
	  	</tr>
	</form>
</table>
<%
'Chama a função que vizualiza todos os vetores criados
VisualizaValoresVetor
%>