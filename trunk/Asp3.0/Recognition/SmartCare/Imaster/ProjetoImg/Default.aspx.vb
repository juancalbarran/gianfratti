Public Class _Default
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents txtCodigoSeg As System.Web.UI.WebControls.TextBox
    Protected WithEvents Btn_Verificar As System.Web.UI.WebControls.Button

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    'Variavel usada para enviar as msg de erros
    Public Erro As String = ""

    'Evento executado ao clicar no botao
    Private Sub Btn_Verificar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Btn_Verificar.Click
        'Verifica se o cookie existe
        If Not Request.Cookies("codseg") Is Nothing Then
            'Verifica se o código digitado é igual ao cookie,
            'novamente usando a criptografia básica
            If txtCodigoSeg.Text.ToUpper.GetHashCode = Request.Cookies("codseg")("hash") Then
                Response.Write("Parabéns. Você digitou corretamente o código.")
                Response.Write("<a href='Default.aspx'>Clique aqui para voltar à página inicial.</a>")
                Response.End()
            Else
                Erro = "O código não foi digitado corretamente.\nTente novamente!"
            End If
        Else
            Erro = "O cookie não foi gravado. \nVerifique se seu navegador suporta cookies."
        End If
    End Sub

End Class
