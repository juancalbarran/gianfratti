<%
' Autor: Fabrizio Gianfratti Manes	
' Data: 11/02/2004
' Descrição: Livraria - Criptografia de dados confidenciais
' Atualizado por: -
' Data: -
' Atualização: -
%>
<%
'INÍCIO DO CÓDIGO
'----------------------------------------------------------------------------------------------------------------
'Este código está otimizado e roda tanto em Windows 2000/NT/XP/ME/98 quanto em servidores UNIX-LINUX com chilli!ASP


Function Cripto(StrCripto, BolAcao) 'Início de da função de criptografia. Aonde o parâmetro String é o valor que será criptografado ou descriptografado. E o parâmetro BolAcao é um valor booleano (True ou False) para indicar se deve ser criptografado (True) ou descriptografado (False).

Dim X , i, n, TamChave, Valor 'Declaração das variáveis.
Dim aChaves(9) 'Declaração do Array que contem as chaves de criptografia

aChaves(0) = 77 'Atribuição dos valores dos caracteres que serão utilizados
aChaves(1) = 84 'como chave de criptografia
aChaves(2) = 79
aChaves(3) = 65
aChaves(4) = 73
aChaves(5) = 78
aChaves(6) = 67
aChaves(7) = 70
aChaves(8) = 82

X = Empty 'Atribui o valor vazio para a variável X

For i = 1 To Len(StrCripto) 'Inicia um Loop For que deve ser repetido a quantidade de vezes de acordo com o tamanho da String que deve ser criptografada.
    n = Asc(Mid(StrCripto, i, 1))
	
    If n > 31 Then 'mantém controles intactos
       n = n - 32 'desconsidera controles (Caracteres de 0 a 31)
       If BolAcao Then
          Valor = 1
       Else
          Valor = -1
       End If
       n = n + (aChaves((i - 1) Mod 9)) * Valor
       n = n Mod 224 ' Caracteres 256 - 32 desconsiderados
          If n < 0 Then
             n = 224 + n
          End If
       n = n + 32 ' Reajusta para caracteres normais
    End If
	
    X = X & Chr(n) 'Armazena na variável X os caracteres que foram modificados
Next

       If BolAcao Then
          Cripto = EHtmlEncode(X) 'Retorna o valor da variável X para a função
       Else
         Cripto = EHtmlDecode(X) 'Retorna o valor da variável X para a função
       End If


End Function

Function EHtmlEncode(StrString)
StrString = Replace(StrString, ",", "_a")
StrString = Replace(StrString, "'", "_b")
StrString = Replace(StrString, """", "_c")
StrString = Replace(StrString, "=", "_d")
StrString = Replace(StrString, ".", "_e")
StrString = Replace(StrString, "(", "_f")
StrString = Replace(StrString, "set", "_g")
StrString = Replace(StrString, "SET", "_h")
StrString = Replace(StrString, " where ", "_i")
StrString = Replace(StrString, " WHERE ", "_j")
StrString = Replace(StrString, ")", "_l")
StrString = Replace(StrString, Chr(32), "_m")
StrString = Replace(StrString, Chr(13), "_n")
StrString = Replace(StrString, Chr(0), "_o")
StrString = Replace(StrString, Chr(10) & Chr(10), "_p")
StrString = Replace(StrString, Chr(10), "_q")
StrString = Replace(StrString, Chr(9), "_r")
StrString = Replace(StrString, Chr(11), "_s")
StrString = Replace(StrString, Chr(12), "_t")
StrString = Replace(StrString, Chr(60), "_u")
StrString = Replace(StrString, "/", "_v")
StrString = Replace(StrString, "\", "_x")
EHtmlEncode = StrString
End Function

Function EHtmlDecode(StrString)
StrString = Replace(StrString, "_a", ",")
StrString = Replace(StrString, "_b", "'")
StrString = Replace(StrString, "_c", """")
StrString = Replace(StrString, "_d", "=")
StrString = Replace(StrString, "_e", ".")
StrString = Replace(StrString, "_f", "(")
StrString = Replace(StrString, "_g", "set")
StrString = Replace(StrString, "_h", "SET")
StrString = Replace(StrString, "_i", " where ")
StrString = Replace(StrString, "_j", " WHERE ")
StrString = Replace(StrString, "_l", ")")
StrString = Replace(StrString, "_m", Chr(32))
StrString = Replace(StrString, "_n", Chr(13))
StrString = Replace(StrString, "_o", Chr(0))
StrString = Replace(StrString, "_p", Chr(10) & Chr(10))
StrString = Replace(StrString, "_q", Chr(10))
StrString = Replace(StrString, "_r", Chr(9))
StrString = Replace(StrString, "_s", Chr(11))
StrString = Replace(StrString, "_t", Chr(12))
StrString = Replace(StrString, "_u", Chr(60))
StrString = Replace(StrString, "_v", "/")
StrString = Replace(StrString, "_x", "\")
EHtmlDecode = StrString
End Function

%>