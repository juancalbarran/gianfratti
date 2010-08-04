Imports System.Data
Imports System.Data.SqlClient

Public Class Conexao
    Private StrConexao As String

    'Função que contém a String de conexao
    Function Conexao()

        'StrConexao = "Server=fmanes\SQL2000;Database=Hospitalar;User ID=HospitalarUsuario;Password=#$&13012005&$#;Trusted_Connection=False"
        StrConexao = "Server=(local);Database=Hospitalar;User ID=HospitalarUsuario;Password=#$&13012005&$#;Trusted_Connection=False"
        Return StrConexao

    End Function

End Class

