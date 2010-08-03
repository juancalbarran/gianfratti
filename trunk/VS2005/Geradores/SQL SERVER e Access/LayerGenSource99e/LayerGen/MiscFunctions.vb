Public Class MiscFunctions
    Public Shared Sub DisplayError(ByVal strMessage As String)
        MessageBox.Show(strMessage, "Error", MessageBoxButtons.OK, MessageBoxIcon.Stop)
    End Sub

    Public Shared Function StripID(ByVal name As String)
        If name.Trim().ToUpper().EndsWith("_ID") Then
            Return name.Trim().Substring(0, name.Trim().Length - 3)
        End If

        If name.Trim().ToUpper().EndsWith("ID") Then
            Return name.Trim().Substring(0, name.Trim().Length - 2)
        End If
        Return name
    End Function

    Public Shared Function Proper(ByVal name As String)
        Dim s As String

        s = name.ToUpper()
        name = name.ToLower()
        name = Left(s, 1) + Right(name, name.Length - 1)
        Return name
    End Function
End Class
