Imports System.Drawing

Public Class imgseguranca
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    'Este evento aconte quando a página é carregada
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        Dim QuantCh As Integer = 5   'Número de caracteres no código
        Dim i As Integer     'Controle do Loop        
        Dim Codigo As String = ""    'Variável que irá conter o código
        Randomize(Timer)     'Randomiza a execução
        For i = 1 To QuantCh
            Codigo = Codigo & Chr(Int(23 * Rnd()) + 65)    'Gera um caracter entre A-Z e
        Next        'adiciona à variável
        'Grava o código em um cookie (com criptografia)
        Response.Cookies("codseg")("hash") = Codigo.GetHashCode()
        'O cookie expira em 5 minutos
        Response.Cookies("codseg").Expires = Now().AddMinutes(5)

        'Agora que o código aleatório está definida, 
        'chama a função que irá criar a imagem passando o codigo que foi gerado.
        GerarImg(Codigo)

    End Sub

    'Função para gerar à partir de um texto    
    Private Sub GerarImg(ByVal texto As String)

        'Sorteia uma fonte à ser usada
        'Se quiser usar outras fontes, altere a lista abaixo
        Dim FontesPossiveis As String() = {"Arial", "Tahoma", "Verdana", "Times New Roman"}
        Dim Fonte As String = FontesPossiveis(Int((FontesPossiveis.Length - 1) * Rnd()))

        'Sorteia um tamanho entre 25 e 35
        Dim Tamanho As Integer = Int(10 * Rnd()) + 25

        'Sorteia um estilo (Normal, Negrito, Italico)
        Dim Estilo = Int(2 * Rnd())


        'Sorteia um fundo para a imagem. Os fundos devem estar na pasta 'fundo'
        Dim ArquivosFundo() As String = System.IO.Directory.GetFiles(Server.MapPath("fundo/"))
        Dim Fundo As String = ArquivosFundo(Int((ArquivosFundo.Length - 1) * Rnd()))

        'Define um objeto de fonte, com os dados sorteados
        Dim oFonte As System.Drawing.Font = New System.Drawing.Font(Fonte, Tamanho, Estilo, GraphicsUnit.Point, 0)

        'Cria uma imagem com base no fundo sorteado
        Dim ImgInicial As Drawing.Image = Drawing.Image.FromFile(Fundo)

        'Cria um objeto gráfico que irá conter a imagem final
        Dim graf As Drawing.Graphics = Graphics.FromImage(ImgInicial)

        'Define a qualidade da imagem criada. Usei qualidade baixa para aumentar a velocidade
        graf.InterpolationMode = Drawing2D.InterpolationMode.Low
        graf.SmoothingMode = Drawing2D.SmoothingMode.HighSpeed

        'Rotaciona a imagem levemente, entre -10º e 10º
        graf.RotateTransform(Int(-10 + 20 * Rnd()))

        'Escreve o texto na imagem, em uma posição sorteada
        graf.DrawString(texto, oFonte, Brushes.Black, Int(40 * Rnd()), Int(40 * Rnd()))

        'Retorna a imagem diretamente ao cliente
        Response.ContentType = "image/jpeg"
        ImgInicial.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg)
    End Sub

End Class
