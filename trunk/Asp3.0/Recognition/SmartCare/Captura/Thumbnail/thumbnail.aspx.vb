Imports System.Data
Imports System.Data.SqlClient

Public Class thumbnail
    Inherits System.Web.UI.Page

    Dim MyConnection As SqlConnection 'Define a variavel MyConnection como global
    Protected WithEvents MyDataGrid As System.Web.UI.WebControls.DataGrid
    Dim DS = New DataSet 'Cria o Data Set
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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Faz conexao com a DLL onde contem a string de conexao
        Dim ObjConexao As New Funcoes.Conexao
        Dim Conexao As String
        Conexao = ObjConexao.Conexao

        'Define a String de conexão ao MyConnection.
        'Definimos no Page Load para ser usada em toda a página
        MyConnection = New SqlConnection(Conexao)

        If Not Page.IsPostBack Then 'Verifica se a paginajá foi postada, caso já tenha sido entao não fica carregando sempre o DataGrid
            DataGrid_Monta()
        End If

    End Sub

    'Sub que ira montar o Data Grid
    Sub DataGrid_Monta()

        Dim SQL As String
        'A SessionID que esta sendo passada este vendo do ASP convencional, é passada na chama da pagina dentro do IFRAME
        SQL = "SELECT dbo.Documento.id, dbo.Documento.id_Paciente, dbo.Documento.id_Atendimento, dbo.Documento.SessionID, YEAR(dbo.Documento.Data) AS Ano,  MONTH(dbo.Documento.Data) AS Mes, DAY(dbo.Documento.Data) AS Dia, dbo.Documento_Imagem.Img FROM dbo.Documento INNER JOIN dbo.Documento_Imagem ON dbo.Documento.id = dbo.Documento_Imagem.id_Documento Where SessionID = '" & Request.QueryString("SessionID") & "' Order By Documento_Imagem.id Desc "

        Dim MyCommand = New SqlDataAdapter(SQL, MyConnection) 'Define o SqlDataAdapter para o MyCommand e executa a Query que é uma constante

        MyCommand.Fill(DS, "TabelaTemp")  'Preenche o data set. É passado um nome de uma tabela temporaria que o proprio sistema ira usar

        MyDataGrid.DataSource = DS.Tables("TabelaTemp").DefaultView 'É passado um nome de uma tabela temporaria que o proprio sistema ira usar

        MyDataGrid.DataBind()

    End Sub

    Private Sub MyDataGrid_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles MyDataGrid.ItemDataBound

        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then

            Dim Lbl_Destaque As Label = CType(e.Item.FindControl("Lbl_Destaque"), Label)
            Dim Caminho As String

            'Monta o caminho onde a imagem esta armazenada seguindo as regras conforme tabela abaixo
            'ID_Paciente = 000000022 --> Tem que ser obrigatoriamente 10 digitos
            'ID_Atendimento = 0000000458 --> Tem que ser obrigatoriamente 10 digitos
            'Ano = 2006 --> Obrigatoriamente 4 digitos. Lembrando que a pasta criada esta no formato Ano/Mes/Dia pois dessa forma fica mais facil para fazer um filtro por ano
            'Mes = 07 --> Obrigatoriamente 2 digitos
            'Dia = 07 --> Obrigatoriamente 2 digitos
            'Imagem = 00000001 --> Tem que ser obrigatoriamente 10 digitos

            Caminho = StrZero(DataBinder.Eval(e.Item.DataItem, "ID_Paciente"), 10) & "/" & StrZero(DataBinder.Eval(e.Item.DataItem, "ID_Atendimento"), 10) & "/" & StrZero(DataBinder.Eval(e.Item.DataItem, "Ano"), 4) & "_" & StrZero(DataBinder.Eval(e.Item.DataItem, "Mes"), 2) & "_" & StrZero(DataBinder.Eval(e.Item.DataItem, "Dia"), 2) & "/" & DataBinder.Eval(e.Item.DataItem, "SessionID") & "/"

            'No Link da IMG chamaos a pagina onde ira gerar o Thumbnail. Ex: GeraThumbnail.aspx?caminho=Imagens&filename=00000025
            Lbl_Destaque.Text = "<a  href=""javascript:AbrePopUp('../Imagens/" & Caminho & DataBinder.Eval(e.Item.DataItem, "Img") & "  ','600','500',this,event)"" ><img src='GeraThumbnail.aspx?caminho=" & Caminho & "&filename=" & DataBinder.Eval(e.Item.DataItem, "Img") & "&width=80 ' Boder='0'></a>"

        End If

    End Sub

    'Evento da paginação
    Private Sub MyDataGrid_PageIndexChanged(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles MyDataGrid.PageIndexChanged
        MyDataGrid.CurrentPageIndex = e.NewPageIndex
        DataGrid_Monta()
    End Sub

    'Função responsavel por completar algo com zeros a esquerda
    'Ex: StrZero(id, 10) --> Suponhamos que o ID seja o numero 58 entao ficaria 0000000058
    Function StrZero(ByVal Str, ByVal Size)
        Dim x, Content
        Content = ""
        For x = 1 To Size 'Faz o laço for até o numero que foi passado como parametro na função
            Content = Content & "0"
        Next
        StrZero = Right(Content & Str, Size)
    End Function


End Class
