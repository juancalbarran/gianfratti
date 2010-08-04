Public Class Funcoes

    'FUNÇÃO QUE PREENCHE ZEROS A ESQUERDA DE UMA STRING PASSADA PARA A FUNÇÃO
    'EX: SE VOCÊ PASSAR UMA STRING DE DATA 1/8/2005 NESSE FORMATO ENTAO ESTA FUNÇÃO FAZ A FORMATAÇÃO PARA 01/08/2005
    'PARA USAR: FunStrZero(string,2) numero que foi passado é a quantidade de numeros que a string tera que ter
    Function StrZero(ByVal Str, ByVal Size)
        Dim x As Integer
        Dim Content As String
        Content = ""
        For x = 1 To Size 'Faz o laço for até o numero que foi passado como parametro na função
            Content = Content & "0"
        Next
        StrZero = Right(Content & Str, Size)
    End Function

    'FUNÇÃO QUE ARRUMA A DATA PARA O FORMATA DD/MM/AAAA
    'PARA EXECUTAR USE ArrumaData(variavel)
    Function ArrumaData(ByVal Data)

        If Len(Trim(Data)) > 8 Then   'Verifica se a variavel passada não esta vazia

            'Usamos a função SrtZero para arrumar a quantidade de certa de numeros. Ex: 1/1/2005 a função formata para 01/01/2005
            ArrumaData = StrZero(Day(Data), 2) & "/" & StrZero(Month(Data), 2) & "/" & Right(Year(Data), 4)

        End If

    End Function
End Class
