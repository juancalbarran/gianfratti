Imports System.Data.SqlClient
Imports ADODB


Public Class Paciente

    Public StrNome As String
    Public id_Paciente As Integer
    Public nomee As String



    Function nome(ByVal id)
        StrNome = agoravai(1)
        Return StrNome
    End Function

    


    Function agoravai(ByVal id_Paciente)

        Dim strSql As String
        Dim conexao As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        strSql = " SELECT * From Pacientes "

        conexao = New SqlConnection("Server=fmanes;Database=Hospitalar;User ID=sa;Password=manes2000;Trusted_Connection=False")
        conexao.Open()
        Try
            cmd = New SqlCommand(strSql, conexao)
            dr = cmd.ExecuteReader()
            Try
                'Do While dr.Read()
                dr.Read()
                agoravai = dr("Nome")
                'Return nomee
                'Loop
            Finally
                dr.Close()
            End Try
        Finally
            conexao.Close()
        End Try

    End Function

End Class

